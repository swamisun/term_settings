if [ -f $(brew --prefix)/etc/bash_completion ]; then
    . $(brew --prefix)/etc/bash_completion
fi

# for colordiff
# https://gist.github.com/dansimau/3104183

function diff {
    colordiff -u "$@" | less -RF
}

newtext=green
oldtext=red
diffstuff=cyan

## From https://gist.github.com/pmarreck/2046249

# sublime command to open stuff
subl() { open -a "Sublime Text 2.app" "${1:-.}"; }
 
# which hack, so it also shows defined aliases and functions that match
#which() {
#  which_out=`/usr/bin/which $@`;
#  if [ ! -z "$which_out" ]; then
#    echo "$which_out";
#  else
#    type "$@";
#  fi
#}

# Sexy man pages. Opens a postscript version in Preview.app
pman() { man -t "$@" | open -f -a Preview; }
 
# Who is holding open this damn port or file??
# usage: portopen 3000
function portopen {
	sudo lsof -P -i ":${1}"
}
function fileopen {
	sudo lsof "${1}"
}

# git functions
function rbr {
 git checkout $1;
 git pull origin $1;
 git checkout $2;
 git rebase $1;
}
 
function mbr {
 git checkout $1;
 git merge $2
 git push origin $1;
 git checkout $2;
}

# change the title of the OS X terminal window
# See http://hints.macworld.com/article.php?story=20031015173932306
export PROMPT_COMMAND='echo -ne "\033]0;$@\007"'

## https://gist.github.com/simonjodet/1550757

#Git branch indicator for bash prompt
parse_git_branch ()
{
    c_red=`tput setaf 1`
    c_green=`tput setaf 2`
    c_sgr0=`tput sgr0`
 
    if git rev-parse --git-dir >/dev/null 2>&1
        then
        gitver=$(git branch 2>/dev/null| sed -n '/^\*/s/^\* //p')
        color=""
        if git diff --quiet 2>/dev/null >&2 
            then
            color="${c_green}"
        else
            color=${c_red}
        fi
    else
        return 0
    fi
    echo "["$color$gitver$c_sgr0"]"
}


