#!/bin/bash
set -eux

###----------------------------------------------------------------------------
### VARIABLES
###----------------------------------------------------------------------------
export DEBIAN_FRONTEND=noninteractive
vagrantHome='/home/vagrant'
backupDir="$vagrantHome/backup"
rootHome='/root'

## Setup ~/.bashrc
printf '\n\n%s\n' "Setting the ~/.bashrc file..."
cp -pv "$rootHome/.bashrc" "$backupDir/bashrc-root.orig"
cat <<EOF > "$rootHome/.bashrc"
# rootBashrcFile
# ~/.bashrc: executed by bash(1) for non-login shells.

# Note: PS1 and umask are already set in /etc/profile. You should not
# need this unless you want different defaults for root.
# PS1='\${debian_chroot:+(\$debian_chroot)}\h:\w\\$ '
# umask 022

# You may uncomment the following lines if you want 'ls' to be colorized:
export LS_OPTIONS='--color=auto'
eval "\$(dircolors)"
alias ll='ls \$LS_OPTIONS -l'
alias la='ls \$LS_OPTIONS -la'
alias lh='ls \$LS_OPTIONS -lh'
alias ld='ls \$LS_OPTIONS -ld'

# Some more alias to avoid making mistakes:
alias rm='rm -iv'
alias cp='cp -pv'
alias mv='mv -v'

###----------------------------------------------------------------------------
### Find Stuff on the filesystem (fs). These are starter functions. To tailor
### them to more-fit your workstyle type 'man find' (in the shell) and modify
### them until you are happy.
###----------------------------------------------------------------------------
# Find files somewhere on the system; to use:
#   1) call the alias, 'findsys'
#   2) pass a directory where the search should begin, and
#   3) pass a file name, either exact or fuzzy: e.g.:
# \$ findsys /var/ '*.log'
function findSystemStuff()   {
    findDir="\$1"
    findFSO="\$2"
    find "\$findDir" -name 'proc' -prune , -name 'dev' -prune , -name 'sys' -prune , -name 'run' -prune , -name "\$findFSO"
}

alias findsys=findSystemStuff
###----------------------------------------------------------------------------
# Find fs objects (directories, files) in your home directory; To use:
#   1) call the alias, 'findmy'
#   2) pass a 'type' of fs object, either 'f' (file) or 'd' (directory)
#   3) pass the object name, either exact or fuzzy: e.g.:
# \$ findmy f '.vimr*'
function findMyStuff()   {
    findType="\$1"
    findFSO="\$2"
    find "\$HOME" -type "\$findType" -name "\$findFSO"
}

alias findmy=findMyStuff
###----------------------------------------------------------------------------

EOF
