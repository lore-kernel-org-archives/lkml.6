Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752099AbeBBPt2 (ORCPT <rfc822;w@1wt.eu>);
        Fri, 2 Feb 2018 10:49:28 -0500
Received: from mail-pf0-f176.google.com ([209.85.192.176]:39272 "EHLO
        mail-pf0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751470AbeBBPtV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Feb 2018 10:49:21 -0500
X-Google-Smtp-Source: AH8x227O8gG/5tPxkPu8ntLMpdYqCzUbdWW8iH5OQe6IuZUugzjEvUcNTtEWjI83IiUtp6Qs7Bna8w==
Cc: mtk.manpages@gmail.com
To: lkml <linux-kernel@vger.kernel.org>
From: "Michael Kerrisk (man-pages)" <mtk.manpages@gmail.com>
Subject: man-pages-4.15 is released
Message-ID: <b2fb5e7c-1086-b3e8-dfe9-36df1b6daaa8@gmail.com>
Date: Fri, 2 Feb 2018 16:49:18 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Gidday,

The Linux man-pages maintainer proudly announces:

    man-pages-4.15 - man pages for Linux

This release resulted from patches, bug reports, reviews, and comments 
from 26 contributors. Over 200 commits changed around 75 pages.
In addition, 3 new manual pages were added.

Tarball download:
    http://www.kernel.org/doc/man-pages/download.html
Git repository:
    https://git.kernel.org/cgit/docs/man-pages/man-pages.git/
Online changelog:
    http://man7.org/linux/man-pages/changelog.html#release_4.15

A short summary of the release is blogged at:
http://linux-man-pages.blogspot.com/2018/02/man-pages-415-is-released.html

A selection of changes in this release that may be of interest
to readers of LKML is shown below.

Cheers,

Michael


==================== Changes in man-pages-4.15 ====================

New and rewritten pages
-----------------------

s390_sthyi.2
    QingFeng Hao  [Michael Kerrisk]
        New page for s390-specific s390_sthyi(2)

network_namespaces.7
    Michael Kerrisk
        New page describing network namespaces
            Based on content moved from namespaces(7)

vsock.7
    Stefan Hajnoczi  [Jorgen Hansen, Michael Kerrisk]
        Document the VSOCK socket address family


Newly documented interfaces in existing pages
---------------------------------------------

cgroups.7
    Michael Kerrisk  [Tejun Heo]
        Document cgroups v2 "thread mode"
    Michael Kerrisk  [Tejun Heo]
        Document cgroup v2 delegation via the 'nsdelegate' mount option
    Michael Kerrisk
        Document the cgroup.max.depth and cgroup.max.descendants files
    Michael Kerrisk
        Document 'release_agent' mount option
    Michael Kerrisk  [Roman Gushchin]
        Document /sys/kernel/cgroup/delegate
    Michael Kerrisk  [Roman Gushchin]
        Document /sys/kernel/cgroup/features
    Michael Kerrisk  [Roman Gushchin]
        Document cgroups v2 cgroup.stat file


Changes to individual pages
---------------------------

fcntl.2
read.2
write.2
    NeilBrown
        Document "Lost locks" as cause for EIO.
            If an advisory lock is lost, then read/write requests on any
            affected file descriptor can return EIO - for NFSv4 at least.

mmap.2
    John Hubbard  [Michael Hocko]
        MAP_FIXED is no longer discouraged
            MAP_FIXED has been widely used for a very long time, yet the man
            page still claims that "the use of this option is discouraged".
    John Hubbard
        MAP_FIXED updated documentation
                -- Expand the documentation to discuss the hazards in
                   enough detail to allow avoiding them.

                -- Mention the upcoming MAP_FIXED_SAFE flag.

                -- Enhance the alignment requirement slightly.

recvmmsg.2
sendmmsg.2
    Nikola Forró
        Point out that error handling is unreliable

seccomp.2
    Michael Kerrisk
        Clarify that SECCOMP_RET_TRAP SIGSYS signal is thread-directed

capabilities.7
    Michael Kerrisk
        Note which capability sets are affected by SECBIT_NO_SETUID_FIXUP
            Note explicitly that SECBIT_NO_SETUID_FIXUP is relevant for
            the permitted, effective, and ambient capability sets.
    Michael Kerrisk
        Clarify effect of CAP_SETFCAP
            Make it clear that CAP_SETFCAP allows setting arbitrary
            capabilities on a file.
    Michael Kerrisk
        Clarify which capability sets are effected by SECBIT_KEEP_CAPS
            This flag has relevance only for the process permitted and
            effective sets.
    Michael Kerrisk
        Rephrase CAP_SETPCAP description
            * Mention kernel versions.
            * Place current kernel behavior first
    Michael Kerrisk
        SECBIT_KEEP_CAPS is ignored if SECBIT_NO_SETUID_FIXUP is set
    Michael Kerrisk
        Ambient set is also cleared when UIDs are set to nonzero value

cgroups.7
    Michael Kerrisk
        Add a more complete description of cgroup v1 named hierarchies
    Michael Kerrisk
        Add a section on unmounting cgroup v1 filesystems
    Michael Kerrisk
        Add subsection describing cgroups v2 subtree delegation
    Michael Kerrisk
        Mention ENOENT error that can occur when writing to subtree_control file
    Michael Kerrisk
        Add list of currently available version 2 controllers
    Nikolay Borisov
        Add information about RDMA controller
    Michael Kerrisk
        Rewrite the description of cgroup v2 subtree control
    Michael Kerrisk  [Tejun Heo]
        Note Linux 4.11 changes to cgroup v2 delegation containment rules
    Michael Kerrisk
        systemd(1) nowadays automatically mounts the cgroup2 filesystem
    Michael Kerrisk
        Clarify that cgroup.controllers is read-only
    Michael Kerrisk
        Elaborate a little on problems of splitting threads across cgroups in v1
    Michael Kerrisk  [Tejun Heo]
        Tweak the description of delegation of cgroup.subtree_control

sched.7
    Michael Kerrisk  [Andrea Parri]
        Correctly describe effect of priority changes for RT threads
            The placement of a thread in the run queue for its new
            priority depends on the direction of movement in priority.
            (This appears to contradict POSIX, except in the case of
            pthread_setschedprio().)

-- 
Michael Kerrisk
Linux man-pages maintainer; http://www.kernel.org/doc/man-pages/
Linux/UNIX System Programming Training: http://man7.org/training/
