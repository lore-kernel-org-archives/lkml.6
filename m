Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751455AbeEDHni (ORCPT <rfc822;w@1wt.eu>);
        Fri, 4 May 2018 03:43:38 -0400
Received: from mail-wr0-f175.google.com ([209.85.128.175]:34688 "EHLO
        mail-wr0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751277AbeEDHng (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 May 2018 03:43:36 -0400
X-Google-Smtp-Source: AB8JxZrHYMhBATrfUYsGAc1O8vqQ6Jc8wVSZcpG/2/Em0JylfWWlPjCXnbokegmp+hA/ytKM4vu01g==
Cc: mtk.manpages@gmail.com
From: "Michael Kerrisk (man-pages)" <mtk.manpages@gmail.com>
To: lkml <linux-kernel@vger.kernel.org>
Subject: man-pages-4.16 is released
Message-ID: <8cc21d2e-9f1c-01d1-f3bb-8f9d5f411aeb@gmail.com>
Date: Fri, 4 May 2018 09:43:34 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Gidday,

The Linux man-pages maintainer proudly announces:

    man-pages-4.16 - man pages for Linux

This release resulted from patches, bug reports, reviews, and comments
from 29 contributors. Around 160 commits changed 62 pages.

Tarball download:
    http://www.kernel.org/doc/man-pages/download.html
Git repository:
    https://git.kernel.org/cgit/docs/man-pages/man-pages.git/
Online changelog:
    http://man7.org/linux/man-pages/changelog.html#release_4.16

A short summary of the release is blogged at:
http://linux-man-pages.blogspot.com/2018/04/man-pages-416-is-released.html

The current version of the pages is browsable at:
http://man7.org/linux/man-pages/

A selection of changes in this release that may be of interest
to readers of LKML is shown below.

Cheers,

Michael

==================== Changes in man-pages-4.16 ====================


Newly documented interfaces in existing pages
---------------------------------------------

membarrier.2
    Mathieu Desnoyers  [Michael Kerrisk]
        Document new membarrier commands introduced in Linux 4.16
            Document the following membarrier commands introduced in
            Linux 4.16:

                MEMBARRIER_CMD_GLOBAL_EXPEDITED
                    (the old enum label MEMBARRIER_CMD_SHARED is now an
                    alias to preserve header backward compatibility)
                MEMBARRIER_CMD_REGISTER_GLOBAL_EXPEDITED
                MEMBARRIER_CMD_PRIVATE_EXPEDITED_SYNC_CORE
                MEMBARRIER_CMD_REGISTER_PRIVATE_EXPEDITED_SYNC_CORE

mmap.2
    Jan Kara  [Ross Zwisler, Michael Kerrisk]
        Add description of MAP_SHARED_VALIDATE and MAP_SYNC
    Michal Hocko  [John Hubbard, Michael Kerrisk, Jann Horn]
        Document new MAP_FIXED_NOREPLACE flag
            4.17+ kernels offer a new MAP_FIXED_NOREPLACE flag which allows
            the caller to atomically probe for a given address range.

readv.2
io_submit.2
    Jürg Billeter
        Document RWF_APPEND added in Linux 4.16

capabilities.7
    Michael Kerrisk
        Describe file capability versioning
    Michael Kerrisk  [Serge E. Hallyn]
        Document namespaced-file capabilities
        [There's still more work to be done on this new text]


Changes to individual pages
---------------------------

bpf.2
    Michael Kerrisk
        Update list of architectures that support JITed eBPF
            And note kernel version numbers where support is added.
    Michael Kerrisk
        Kernel 4.15 added CONFIG_BPF_JIT_ALWAYS_ON
            This causes the JIT compiler to be always on and
            forces bpf_jit_enable to 1.

fallocate.2
    Michael Kerrisk
        Since Linux 4.16, Btrfs supports FALLOC_FL_ZERO_RANGE

getrlimit.2
    Michael Kerrisk
        CAP_SYS_RESOURCE capability is required in *initial user namespace*

mmap.2
    Jann Horn
        MAP_FIXED is okay if the address range has been reserved
            Clarify that MAP_FIXED is appropriate if the specified address
            range has been reserved using an existing mapping, but shouldn't
            be used otherwise.
mount.2
    Michael Kerrisk
        ERRORS: add EBUSY for the case of trying to stack same mount twice
    Michael Kerrisk
        Remove a couple of obsolete EBUSY errors
            As far as I can tell, these EBUSY errors disappeared
            with the addition of stackable mounts in Linux 2.4.

perf_event_open.2
    Song Liu
        Add type kprobe and uprobe
            Two new types kprobe and uprobe are being added to
            perf_event_open(), which allow creating kprobe or
            uprobe with perf_event_open. This patch adds
            information about these types.

seccomp.2
    Michael Kerrisk
        Note that execve() may change syscall numbers during life of process
            On a multiarch/multi-ABI platform such as modern x86, each
            architecture/ABI (x86-64, x32, i386)has its own syscall numbers,
            which means a seccomp() filter may see different syscall numbers
            over the life of the process if that process uses execve() to
            execute programs that has a different architectures/ABIs.
    Michael Kerrisk
        Note which architectures support seccomp BPF
    Michael Kerrisk
        In EXAMPLE, clearly note that x32 syscalls are >= X32_SYSCALL_BIT

tmpfs.5
    Mike Frysinger
        Document current mount options
            Some of this content is moved from the mount(8) man page.
            Style was based on proc(5) sections.
cgroups.7
    Michael Kerrisk
        cgroup.events transitions generate POLLERR as well as POLLPRI

namespaces.7
    Michael Kerrisk  [Konstantin Khlebnikov]
        Mention that device ID should also be checked when comparing NS symlinks
            When comparing two namespaces symlinks to see if they refer to
            the same namespace, both the inode number and the device ID
            should be compared. This point was already made clear in
            ioctl_ns(2), but was missing from this page.
    Michael Kerrisk
        Note an idiosyncrasy of /proc/[pid]/ns/pid_for_children
            /proc/[pid]/ns/pid_for_children has a value only after first
            child is created in PID namespace. Verified by experiment.

network_namespaces.7
    Michael Kerrisk
        Network namespaces isolate the UNIX domain abstract socket namespace
vdso.7
    Michael Kerrisk
        VDSO symbols (system calls) are not visible to seccomp(2) filters

-- 
Michael Kerrisk
Linux man-pages maintainer; http://www.kernel.org/doc/man-pages/
Linux/UNIX System Programming Training: http://man7.org/training/
