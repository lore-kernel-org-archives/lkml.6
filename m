Return-Path: <SRS0=uvhX=PT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A30C3C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 07:44:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1D6B020874
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 07:44:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547192672;
	bh=YzQfXu6Nfu7i2bzvhlR861QzsPEmOO8IYwOmK0OowWg=;
	h=Date:From:To:Cc:Subject:List-ID:From;
	b=dbvubTlwOukMRLoEjjJsI21AR2puS3PiLQj7RXAx889u3xV+rwxcALmxhDvGPPCTf
	 YK8XVefAcgdEYgGaFt0yZakn3f4YBmICpUwxL1g/IEHcC8QnQ/tWAzMhzW+iuH0GOy
	 inzATb0e0dM4oE8nRSN3A+43O8w1ltCqyEWTts+M=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730822AbfAKHoa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Jan 2019 02:44:30 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:37515 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727578AbfAKHoa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jan 2019 02:44:30 -0500
Received: by mail-wr1-f65.google.com with SMTP id s12so14087914wrt.4
        for <linux-kernel@vger.kernel.org>; Thu, 10 Jan 2019 23:44:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=G2I9iHdN/+QfQFTlkUNrmMr50MGR83R1dWQNcpmoTm0=;
        b=gwDa/0LuPuDiVJbniL2jfQYb1vHdimRXINEDpM4fZ+CDnmZh3TqYetQePNXdKAsben
         yZ2l4hOWHetlwNqS5EYGAXrnqsmC/PKZM0v4OZv7Oynu2A7JWF1cYhBkErCdEMSOLVSN
         qZoM7BKYhx2lUcISBqMN53Nbm1hNaYZUyc2mfpnSZY0C/J3HBNIHxJdg1JzwkZblaYlK
         bzgHeRnwk3JdJV7oK9xDFqbAHxwSk416ej2PyqYMtgpf6SCnnOGYDlIUnB6sdmHqaPe6
         UqyqWzssdB4wwPmxi5Aboihw3160jDH3SOYfcwtHMJOadGC/HqtWBb8D9xEVgJAwqLu+
         1vBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mime-version:content-disposition:user-agent;
        bh=G2I9iHdN/+QfQFTlkUNrmMr50MGR83R1dWQNcpmoTm0=;
        b=cKcyu0DxzCKnPAXxl/QPGRguxhAoBjs0zGyUPbpzrZCiC7oJWAH7vHzTCbIEcsyJNt
         fuRjSlCSR8Q/nDSZwSq2t2Kh02hwpcpl0AuROYV2/AaevY3dWbjRr4BLT1Y+kGUzE7A0
         /3SW08QJjeyQ/I6ALEOqQw1py0+oL4YU+dn2RDV1ELipEqvieDhWLIrBxeIDA8QMHfET
         SrhCTekIAW3Nq/hvfSIDlq4Q6MeWonqUaNjyeCNM2/pnbesZMbFPGezBufWu+42ACTdM
         +pWswCg18Q8ZiBoO9YUkj2tC26dhgMtssU8aSc8gxGJhxb2M2SDoZnVLpg4VsJ7NErwl
         cIhg==
X-Gm-Message-State: AJcUukcaVJVT/Hq4aaQD4Y1X2Xd28pekYbB2LBT/7bYyy4+btvjA2rMr
        hwzgLa14dk9DZJz5wVB0svw=
X-Google-Smtp-Source: ALg8bN46INr2CwXHkjqkq6Ve1JGHe5pmcEZH9gbvsvlRUrJjorD8xTukEDMkcYBQdo3xueEQQb+vgA==
X-Received: by 2002:adf:ed92:: with SMTP id c18mr12619177wro.194.1547192661273;
        Thu, 10 Jan 2019 23:44:21 -0800 (PST)
Received: from gmail.com (2E8B0CD5.catv.pool.telekom.hu. [46.139.12.213])
        by smtp.gmail.com with ESMTPSA id e18sm79272271wrv.88.2019.01.10.23.44.19
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 10 Jan 2019 23:44:20 -0800 (PST)
Date:   Fri, 11 Jan 2019 08:44:18 +0100
From:   Ingo Molnar <mingo@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@infradead.org>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [GIT PULL] perf fixes
Message-ID: <20190111074418.GA62414@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

Please pull the latest perf-urgent-for-linus git tree from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git perf-urgent-for-linus

   # HEAD: 4e72ee8872279a70ebe973172133b98e8acbf54e Merge tag 'perf-core-for-mingo-5.0-20190110' of git://git.kernel.org/pub/scm/linux/kernel/git/acme/linux into perf/urgent

Tooling changes only: fixes and a few stray improvements.

Most of the diffstat is dominated by a PowerPC related fix of system call 
trace output beautification that allows us to (again) use the UAPI header 
version and sync up with the kernel's version of PowerPC system call 
names in the arch/powerpc/kernel/syscalls/syscall.tbl header.

 Thanks,

	Ingo

------------------>
Arnaldo Carvalho de Melo (19):
      tools headers x86: Sync disabled-features.h
      tools headers uapi: Sync prctl.h with the kernel sources
      tools beauty: Make the prctl option table generator catch all PR_ options
      tools headers uapi: Update i915_drm.h
      tools headers uapi: Sync linux/in.h copy from the kernel sources
      tools headers uapi: Sync linux/kvm.h with the kernel sources
      tools headers uapi: Sync copy of asm-generic/unistd.h with the kernel sources
      tools headers x86: Sync asm/cpufeatures.h copy with the kernel sources
      perf python: Make sure the python binding output directory is in place
      perf test shell: Use a fallback to get the pathname in vfs_getname
      perf trace: Fix ')' placement in "interrupted" syscall lines
      perf trace: Fix alignment for [continued] lines
      perf top: Lift restriction on using callchains without "sym" in --sort
      tools include uapi: Grab a copy of linux/mount.h
      perf beauty: Switch from using uapi/linux/fs.h to uapi/linux/mount.h
      tools include uapi: Sync linux/fs.h copy with the kernel sources
      tools include uapi: Sync linux/vhost.h with the kernel sources
      tools include uapi: Sync linux/if_link.h copy with the kernel sources
      perf symbols: Add 'arch_cpu_idle' to the list of kernel idle symbols

Florian Fainelli (2):
      perf tools: Make find_vdso_map() more modular
      perf tests: Add a test for the ARM 32-bit [vectors] page

Ivan Krylov (1):
      perf annotate: Pass filename to objdump via execl

Jin Yao (2):
      perf stat: Fix endless wait for child process
      perf report: Fix wrong iteration count in --branch-history

Jiri Olsa (2):
      tools thermal tmon: Use -O3 instead of -O1 if available
      tools iio: Override CFLAGS assignments

Mattias Jacobsson (1):
      perf strbuf: Remove redundant va_end() in strbuf_addv()

Ravi Bangoria (2):
      perf powerpc: Rework syscall table generation
      tools headers powerpc: Remove unistd.h

Tzvetomir Stoyanov (7):
      tools lib traceevent: Introduce new libtracevent API: tep_override_comm()
      tools lib traceevent: Initialize host_bigendian at tep_handle allocation
      tools lib traceevent: Rename struct cmdline to struct tep_cmdline
      tools lib traceevent: Changed return logic of trace_seq_printf() and trace_seq_vprintf() APIs
      tools lib traceevent: Changed return logic of tep_register_event_handler() API
      tools lib traceevent: Rename tep_is_file_bigendian() to tep_file_bigendian()
      tools lib traceevent: Remove tep_data_event_from_type() API


 tools/arch/powerpc/include/uapi/asm/unistd.h       | 404 -------------------
 tools/arch/x86/include/asm/cpufeatures.h           |   2 +
 tools/arch/x86/include/asm/disabled-features.h     |   8 +-
 tools/include/uapi/asm-generic/unistd.h            |   4 +-
 tools/include/uapi/drm/i915_drm.h                  |   8 +
 tools/include/uapi/linux/fs.h                      |  60 +--
 tools/include/uapi/linux/if_link.h                 |  19 +
 tools/include/uapi/linux/in.h                      |  10 +-
 tools/include/uapi/linux/kvm.h                     |  19 +
 tools/include/uapi/linux/mount.h                   |  58 +++
 tools/include/uapi/linux/prctl.h                   |   8 +
 tools/include/uapi/linux/vhost.h                   | 113 +-----
 tools/lib/traceevent/event-parse-api.c             |   4 +-
 tools/lib/traceevent/event-parse-local.h           |   4 +-
 tools/lib/traceevent/event-parse.c                 | 129 ++++---
 tools/lib/traceevent/event-parse.h                 |  17 +-
 tools/lib/traceevent/plugin_kvm.c                  |   2 +-
 tools/lib/traceevent/trace-seq.c                   |  17 +-
 tools/perf/Makefile.perf                           |   8 +-
 tools/perf/arch/arm/tests/Build                    |   1 +
 tools/perf/arch/arm/tests/arch-tests.c             |   4 +
 tools/perf/arch/arm/tests/vectors-page.c           |  24 ++
 tools/perf/arch/powerpc/Makefile                   |  15 +-
 .../perf/arch/powerpc/entry/syscalls/mksyscalltbl  |  22 +-
 tools/perf/arch/powerpc/entry/syscalls/syscall.tbl | 427 +++++++++++++++++++++
 tools/perf/builtin-stat.c                          |   3 +-
 tools/perf/builtin-top.c                           |   7 +-
 tools/perf/builtin-trace.c                         |  15 +-
 tools/perf/check-headers.sh                        |   2 +-
 tools/perf/perf-read-vdso.c                        |   6 +-
 tools/perf/tests/shell/lib/probe_vfs_getname.sh    |   3 +-
 tools/perf/tests/tests.h                           |   5 +
 tools/perf/trace/beauty/mount_flags.sh             |   4 +-
 tools/perf/trace/beauty/prctl_option.sh            |   2 +-
 tools/perf/util/annotate.c                         |   8 +-
 tools/perf/util/callchain.c                        |  32 +-
 tools/perf/util/callchain.h                        |   1 +
 tools/perf/util/{find-vdso-map.c => find-map.c}    |   7 +-
 tools/perf/util/machine.c                          |   2 +-
 tools/perf/util/strbuf.c                           |   1 -
 tools/perf/util/symbol.c                           |   1 +
 tools/perf/util/vdso.c                             |   6 +-
 tools/thermal/tmon/Makefile                        |   2 +-
 43 files changed, 797 insertions(+), 697 deletions(-)
 delete mode 100644 tools/arch/powerpc/include/uapi/asm/unistd.h
 create mode 100644 tools/include/uapi/linux/mount.h
 create mode 100644 tools/perf/arch/arm/tests/vectors-page.c
 create mode 100644 tools/perf/arch/powerpc/entry/syscalls/syscall.tbl
 rename tools/perf/util/{find-vdso-map.c => find-map.c} (71%)

diff --git a/tools/arch/powerpc/include/uapi/asm/unistd.h b/tools/arch/powerpc/include/uapi/asm/unistd.h
deleted file mode 100644
index 985534d0b448..000000000000
--- a/tools/arch/powerpc/include/uapi/asm/unistd.h
+++ /dev/null
@@ -1,404 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0+ WITH Linux-syscall-note */
-/*
- * This file contains the system call numbers.
- *
- * This program is free software; you can redistribute it and/or
- * modify it under the terms of the GNU General Public License
- * as published by the Free Software Foundation; either version
- * 2 of the License, or (at your option) any later version.
- */
-#ifndef _UAPI_ASM_POWERPC_UNISTD_H_
-#define _UAPI_ASM_POWERPC_UNISTD_H_
-
-
-#define __NR_restart_syscall	  0
-#define __NR_exit		  1
-#define __NR_fork		  2
-#define __NR_read		  3
-#define __NR_write		  4
-#define __NR_open		  5
-#define __NR_close		  6
-#define __NR_waitpid		  7
-#define __NR_creat		  8
-#define __NR_link		  9
-#define __NR_unlink		 10
-#define __NR_execve		 11
-#define __NR_chdir		 12
-#define __NR_time		 13
-#define __NR_mknod		 14
-#define __NR_chmod		 15
-#define __NR_lchown		 16
-#define __NR_break		 17
-#define __NR_oldstat		 18
-#define __NR_lseek		 19
-#define __NR_getpid		 20
-#define __NR_mount		 21
-#define __NR_umount		 22
-#define __NR_setuid		 23
-#define __NR_getuid		 24
-#define __NR_stime		 25
-#define __NR_ptrace		 26
-#define __NR_alarm		 27
-#define __NR_oldfstat		 28
-#define __NR_pause		 29
-#define __NR_utime		 30
-#define __NR_stty		 31
-#define __NR_gtty		 32
-#define __NR_access		 33
-#define __NR_nice		 34
-#define __NR_ftime		 35
-#define __NR_sync		 36
-#define __NR_kill		 37
-#define __NR_rename		 38
-#define __NR_mkdir		 39
-#define __NR_rmdir		 40
-#define __NR_dup		 41
-#define __NR_pipe		 42
-#define __NR_times		 43
-#define __NR_prof		 44
-#define __NR_brk		 45
-#define __NR_setgid		 46
-#define __NR_getgid		 47
-#define __NR_signal		 48
-#define __NR_geteuid		 49
-#define __NR_getegid		 50
-#define __NR_acct		 51
-#define __NR_umount2		 52
-#define __NR_lock		 53
-#define __NR_ioctl		 54
-#define __NR_fcntl		 55
-#define __NR_mpx		 56
-#define __NR_setpgid		 57
-#define __NR_ulimit		 58
-#define __NR_oldolduname	 59
-#define __NR_umask		 60
-#define __NR_chroot		 61
-#define __NR_ustat		 62
-#define __NR_dup2		 63
-#define __NR_getppid		 64
-#define __NR_getpgrp		 65
-#define __NR_setsid		 66
-#define __NR_sigaction		 67
-#define __NR_sgetmask		 68
-#define __NR_ssetmask		 69
-#define __NR_setreuid		 70
-#define __NR_setregid		 71
-#define __NR_sigsuspend		 72
-#define __NR_sigpending		 73
-#define __NR_sethostname	 74
-#define __NR_setrlimit		 75
-#define __NR_getrlimit		 76
-#define __NR_getrusage		 77
-#define __NR_gettimeofday	 78
-#define __NR_settimeofday	 79
-#define __NR_getgroups		 80
-#define __NR_setgroups		 81
-#define __NR_select		 82
-#define __NR_symlink		 83
-#define __NR_oldlstat		 84
-#define __NR_readlink		 85
-#define __NR_uselib		 86
-#define __NR_swapon		 87
-#define __NR_reboot		 88
-#define __NR_readdir		 89
-#define __NR_mmap		 90
-#define __NR_munmap		 91
-#define __NR_truncate		 92
-#define __NR_ftruncate		 93
-#define __NR_fchmod		 94
-#define __NR_fchown		 95
-#define __NR_getpriority	 96
-#define __NR_setpriority	 97
-#define __NR_profil		 98
-#define __NR_statfs		 99
-#define __NR_fstatfs		100
-#define __NR_ioperm		101
-#define __NR_socketcall		102
-#define __NR_syslog		103
-#define __NR_setitimer		104
-#define __NR_getitimer		105
-#define __NR_stat		106
-#define __NR_lstat		107
-#define __NR_fstat		108
-#define __NR_olduname		109
-#define __NR_iopl		110
-#define __NR_vhangup		111
-#define __NR_idle		112
-#define __NR_vm86		113
-#define __NR_wait4		114
-#define __NR_swapoff		115
-#define __NR_sysinfo		116
-#define __NR_ipc		117
-#define __NR_fsync		118
-#define __NR_sigreturn		119
-#define __NR_clone		120
-#define __NR_setdomainname	121
-#define __NR_uname		122
-#define __NR_modify_ldt		123
-#define __NR_adjtimex		124
-#define __NR_mprotect		125
-#define __NR_sigprocmask	126
-#define __NR_create_module	127
-#define __NR_init_module	128
-#define __NR_delete_module	129
-#define __NR_get_kernel_syms	130
-#define __NR_quotactl		131
-#define __NR_getpgid		132
-#define __NR_fchdir		133
-#define __NR_bdflush		134
-#define __NR_sysfs		135
-#define __NR_personality	136
-#define __NR_afs_syscall	137 /* Syscall for Andrew File System */
-#define __NR_setfsuid		138
-#define __NR_setfsgid		139
-#define __NR__llseek		140
-#define __NR_getdents		141
-#define __NR__newselect		142
-#define __NR_flock		143
-#define __NR_msync		144
-#define __NR_readv		145
-#define __NR_writev		146
-#define __NR_getsid		147
-#define __NR_fdatasync		148
-#define __NR__sysctl		149
-#define __NR_mlock		150
-#define __NR_munlock		151
-#define __NR_mlockall		152
-#define __NR_munlockall		153
-#define __NR_sched_setparam		154
-#define __NR_sched_getparam		155
-#define __NR_sched_setscheduler		156
-#define __NR_sched_getscheduler		157
-#define __NR_sched_yield		158
-#define __NR_sched_get_priority_max	159
-#define __NR_sched_get_priority_min	160
-#define __NR_sched_rr_get_interval	161
-#define __NR_nanosleep		162
-#define __NR_mremap		163
-#define __NR_setresuid		164
-#define __NR_getresuid		165
-#define __NR_query_module	166
-#define __NR_poll		167
-#define __NR_nfsservctl		168
-#define __NR_setresgid		169
-#define __NR_getresgid		170
-#define __NR_prctl		171
-#define __NR_rt_sigreturn	172
-#define __NR_rt_sigaction	173
-#define __NR_rt_sigprocmask	174
-#define __NR_rt_sigpending	175
-#define __NR_rt_sigtimedwait	176
-#define __NR_rt_sigqueueinfo	177
-#define __NR_rt_sigsuspend	178
-#define __NR_pread64		179
-#define __NR_pwrite64		180
-#define __NR_chown		181
-#define __NR_getcwd		182
-#define __NR_capget		183
-#define __NR_capset		184
-#define __NR_sigaltstack	185
-#define __NR_sendfile		186
-#define __NR_getpmsg		187	/* some people actually want streams */
-#define __NR_putpmsg		188	/* some people actually want streams */
-#define __NR_vfork		189
-#define __NR_ugetrlimit		190	/* SuS compliant getrlimit */
-#define __NR_readahead		191
-#ifndef __powerpc64__			/* these are 32-bit only */
-#define __NR_mmap2		192
-#define __NR_truncate64		193
-#define __NR_ftruncate64	194
-#define __NR_stat64		195
-#define __NR_lstat64		196
-#define __NR_fstat64		197
-#endif
-#define __NR_pciconfig_read	198
-#define __NR_pciconfig_write	199
-#define __NR_pciconfig_iobase	200
-#define __NR_multiplexer	201
-#define __NR_getdents64		202
-#define __NR_pivot_root		203
-#ifndef __powerpc64__
-#define __NR_fcntl64		204
-#endif
-#define __NR_madvise		205
-#define __NR_mincore		206
-#define __NR_gettid		207
-#define __NR_tkill		208
-#define __NR_setxattr		209
-#define __NR_lsetxattr		210
-#define __NR_fsetxattr		211
-#define __NR_getxattr		212
-#define __NR_lgetxattr		213
-#define __NR_fgetxattr		214
-#define __NR_listxattr		215
-#define __NR_llistxattr		216
-#define __NR_flistxattr		217
-#define __NR_removexattr	218
-#define __NR_lremovexattr	219
-#define __NR_fremovexattr	220
-#define __NR_futex		221
-#define __NR_sched_setaffinity	222
-#define __NR_sched_getaffinity	223
-/* 224 currently unused */
-#define __NR_tuxcall		225
-#ifndef __powerpc64__
-#define __NR_sendfile64		226
-#endif
-#define __NR_io_setup		227
-#define __NR_io_destroy		228
-#define __NR_io_getevents	229
-#define __NR_io_submit		230
-#define __NR_io_cancel		231
-#define __NR_set_tid_address	232
-#define __NR_fadvise64		233
-#define __NR_exit_group		234
-#define __NR_lookup_dcookie	235
-#define __NR_epoll_create	236
-#define __NR_epoll_ctl		237
-#define __NR_epoll_wait		238
-#define __NR_remap_file_pages	239
-#define __NR_timer_create	240
-#define __NR_timer_settime	241
-#define __NR_timer_gettime	242
-#define __NR_timer_getoverrun	243
-#define __NR_timer_delete	244
-#define __NR_clock_settime	245
-#define __NR_clock_gettime	246
-#define __NR_clock_getres	247
-#define __NR_clock_nanosleep	248
-#define __NR_swapcontext	249
-#define __NR_tgkill		250
-#define __NR_utimes		251
-#define __NR_statfs64		252
-#define __NR_fstatfs64		253
-#ifndef __powerpc64__
-#define __NR_fadvise64_64	254
-#endif
-#define __NR_rtas		255
-#define __NR_sys_debug_setcontext 256
-/* Number 257 is reserved for vserver */
-#define __NR_migrate_pages	258
-#define __NR_mbind		259
-#define __NR_get_mempolicy	260
-#define __NR_set_mempolicy	261
-#define __NR_mq_open		262
-#define __NR_mq_unlink		263
-#define __NR_mq_timedsend	264
-#define __NR_mq_timedreceive	265
-#define __NR_mq_notify		266
-#define __NR_mq_getsetattr	267
-#define __NR_kexec_load		268
-#define __NR_add_key		269
-#define __NR_request_key	270
-#define __NR_keyctl		271
-#define __NR_waitid		272
-#define __NR_ioprio_set		273
-#define __NR_ioprio_get		274
-#define __NR_inotify_init	275
-#define __NR_inotify_add_watch	276
-#define __NR_inotify_rm_watch	277
-#define __NR_spu_run		278
-#define __NR_spu_create		279
-#define __NR_pselect6		280
-#define __NR_ppoll		281
-#define __NR_unshare		282
-#define __NR_splice		283
-#define __NR_tee		284
-#define __NR_vmsplice		285
-#define __NR_openat		286
-#define __NR_mkdirat		287
-#define __NR_mknodat		288
-#define __NR_fchownat		289
-#define __NR_futimesat		290
-#ifdef __powerpc64__
-#define __NR_newfstatat		291
-#else
-#define __NR_fstatat64		291
-#endif
-#define __NR_unlinkat		292
-#define __NR_renameat		293
-#define __NR_linkat		294
-#define __NR_symlinkat		295
-#define __NR_readlinkat		296
-#define __NR_fchmodat		297
-#define __NR_faccessat		298
-#define __NR_get_robust_list	299
-#define __NR_set_robust_list	300
-#define __NR_move_pages		301
-#define __NR_getcpu		302
-#define __NR_epoll_pwait	303
-#define __NR_utimensat		304
-#define __NR_signalfd		305
-#define __NR_timerfd_create	306
-#define __NR_eventfd		307
-#define __NR_sync_file_range2	308
-#define __NR_fallocate		309
-#define __NR_subpage_prot	310
-#define __NR_timerfd_settime	311
-#define __NR_timerfd_gettime	312
-#define __NR_signalfd4		313
-#define __NR_eventfd2		314
-#define __NR_epoll_create1	315
-#define __NR_dup3		316
-#define __NR_pipe2		317
-#define __NR_inotify_init1	318
-#define __NR_perf_event_open	319
-#define __NR_preadv		320
-#define __NR_pwritev		321
-#define __NR_rt_tgsigqueueinfo	322
-#define __NR_fanotify_init	323
-#define __NR_fanotify_mark	324
-#define __NR_prlimit64		325
-#define __NR_socket		326
-#define __NR_bind		327
-#define __NR_connect		328
-#define __NR_listen		329
-#define __NR_accept		330
-#define __NR_getsockname	331
-#define __NR_getpeername	332
-#define __NR_socketpair		333
-#define __NR_send		334
-#define __NR_sendto		335
-#define __NR_recv		336
-#define __NR_recvfrom		337
-#define __NR_shutdown		338
-#define __NR_setsockopt		339
-#define __NR_getsockopt		340
-#define __NR_sendmsg		341
-#define __NR_recvmsg		342
-#define __NR_recvmmsg		343
-#define __NR_accept4		344
-#define __NR_name_to_handle_at	345
-#define __NR_open_by_handle_at	346
-#define __NR_clock_adjtime	347
-#define __NR_syncfs		348
-#define __NR_sendmmsg		349
-#define __NR_setns		350
-#define __NR_process_vm_readv	351
-#define __NR_process_vm_writev	352
-#define __NR_finit_module	353
-#define __NR_kcmp		354
-#define __NR_sched_setattr	355
-#define __NR_sched_getattr	356
-#define __NR_renameat2		357
-#define __NR_seccomp		358
-#define __NR_getrandom		359
-#define __NR_memfd_create	360
-#define __NR_bpf		361
-#define __NR_execveat		362
-#define __NR_switch_endian	363
-#define __NR_userfaultfd	364
-#define __NR_membarrier		365
-#define __NR_mlock2		378
-#define __NR_copy_file_range	379
-#define __NR_preadv2		380
-#define __NR_pwritev2		381
-#define __NR_kexec_file_load	382
-#define __NR_statx		383
-#define __NR_pkey_alloc		384
-#define __NR_pkey_free		385
-#define __NR_pkey_mprotect	386
-#define __NR_rseq		387
-#define __NR_io_pgetevents	388
-
-#endif /* _UAPI_ASM_POWERPC_UNISTD_H_ */
diff --git a/tools/arch/x86/include/asm/cpufeatures.h b/tools/arch/x86/include/asm/cpufeatures.h
index 28c4a502b419..6d6122524711 100644
--- a/tools/arch/x86/include/asm/cpufeatures.h
+++ b/tools/arch/x86/include/asm/cpufeatures.h
@@ -281,9 +281,11 @@
 #define X86_FEATURE_CLZERO		(13*32+ 0) /* CLZERO instruction */
 #define X86_FEATURE_IRPERF		(13*32+ 1) /* Instructions Retired Count */
 #define X86_FEATURE_XSAVEERPTR		(13*32+ 2) /* Always save/restore FP error pointers */
+#define X86_FEATURE_WBNOINVD		(13*32+ 9) /* WBNOINVD instruction */
 #define X86_FEATURE_AMD_IBPB		(13*32+12) /* "" Indirect Branch Prediction Barrier */
 #define X86_FEATURE_AMD_IBRS		(13*32+14) /* "" Indirect Branch Restricted Speculation */
 #define X86_FEATURE_AMD_STIBP		(13*32+15) /* "" Single Thread Indirect Branch Predictors */
+#define X86_FEATURE_AMD_STIBP_ALWAYS_ON	(13*32+17) /* "" Single Thread Indirect Branch Predictors always-on preferred */
 #define X86_FEATURE_AMD_SSBD		(13*32+24) /* "" Speculative Store Bypass Disable */
 #define X86_FEATURE_VIRT_SSBD		(13*32+25) /* Virtualized Speculative Store Bypass Disable */
 #define X86_FEATURE_AMD_SSB_NO		(13*32+26) /* "" Speculative Store Bypass is fixed in hardware. */
diff --git a/tools/arch/x86/include/asm/disabled-features.h b/tools/arch/x86/include/asm/disabled-features.h
index 33833d1909af..a5ea841cc6d2 100644
--- a/tools/arch/x86/include/asm/disabled-features.h
+++ b/tools/arch/x86/include/asm/disabled-features.h
@@ -16,6 +16,12 @@
 # define DISABLE_MPX	(1<<(X86_FEATURE_MPX & 31))
 #endif
 
+#ifdef CONFIG_X86_SMAP
+# define DISABLE_SMAP	0
+#else
+# define DISABLE_SMAP	(1<<(X86_FEATURE_SMAP & 31))
+#endif
+
 #ifdef CONFIG_X86_INTEL_UMIP
 # define DISABLE_UMIP	0
 #else
@@ -68,7 +74,7 @@
 #define DISABLED_MASK6	0
 #define DISABLED_MASK7	(DISABLE_PTI)
 #define DISABLED_MASK8	0
-#define DISABLED_MASK9	(DISABLE_MPX)
+#define DISABLED_MASK9	(DISABLE_MPX|DISABLE_SMAP)
 #define DISABLED_MASK10	0
 #define DISABLED_MASK11	0
 #define DISABLED_MASK12	0
diff --git a/tools/include/uapi/asm-generic/unistd.h b/tools/include/uapi/asm-generic/unistd.h
index c7f3321fbe43..d90127298f12 100644
--- a/tools/include/uapi/asm-generic/unistd.h
+++ b/tools/include/uapi/asm-generic/unistd.h
@@ -738,9 +738,11 @@ __SYSCALL(__NR_statx,     sys_statx)
 __SC_COMP(__NR_io_pgetevents, sys_io_pgetevents, compat_sys_io_pgetevents)
 #define __NR_rseq 293
 __SYSCALL(__NR_rseq, sys_rseq)
+#define __NR_kexec_file_load 294
+__SYSCALL(__NR_kexec_file_load,     sys_kexec_file_load)
 
 #undef __NR_syscalls
-#define __NR_syscalls 294
+#define __NR_syscalls 295
 
 /*
  * 32 bit systems traditionally used different
diff --git a/tools/include/uapi/drm/i915_drm.h b/tools/include/uapi/drm/i915_drm.h
index a4446f452040..298b2e197744 100644
--- a/tools/include/uapi/drm/i915_drm.h
+++ b/tools/include/uapi/drm/i915_drm.h
@@ -412,6 +412,14 @@ typedef struct drm_i915_irq_wait {
 	int irq_seq;
 } drm_i915_irq_wait_t;
 
+/*
+ * Different modes of per-process Graphics Translation Table,
+ * see I915_PARAM_HAS_ALIASING_PPGTT
+ */
+#define I915_GEM_PPGTT_NONE	0
+#define I915_GEM_PPGTT_ALIASING	1
+#define I915_GEM_PPGTT_FULL	2
+
 /* Ioctl to query kernel params:
  */
 #define I915_PARAM_IRQ_ACTIVE            1
diff --git a/tools/include/uapi/linux/fs.h b/tools/include/uapi/linux/fs.h
index a441ea1bfe6d..121e82ce296b 100644
--- a/tools/include/uapi/linux/fs.h
+++ b/tools/include/uapi/linux/fs.h
@@ -14,6 +14,11 @@
 #include <linux/ioctl.h>
 #include <linux/types.h>
 
+/* Use of MS_* flags within the kernel is restricted to core mount(2) code. */
+#if !defined(__KERNEL__)
+#include <linux/mount.h>
+#endif
+
 /*
  * It's silly to have NR_OPEN bigger than NR_FILE, but you can change
  * the file limit at runtime and only root can increase the per-process
@@ -101,57 +106,6 @@ struct inodes_stat_t {
 
 #define NR_FILE  8192	/* this can well be larger on a larger system */
 
-
-/*
- * These are the fs-independent mount-flags: up to 32 flags are supported
- */
-#define MS_RDONLY	 1	/* Mount read-only */
-#define MS_NOSUID	 2	/* Ignore suid and sgid bits */
-#define MS_NODEV	 4	/* Disallow access to device special files */
-#define MS_NOEXEC	 8	/* Disallow program execution */
-#define MS_SYNCHRONOUS	16	/* Writes are synced at once */
-#define MS_REMOUNT	32	/* Alter flags of a mounted FS */
-#define MS_MANDLOCK	64	/* Allow mandatory locks on an FS */
-#define MS_DIRSYNC	128	/* Directory modifications are synchronous */
-#define MS_NOATIME	1024	/* Do not update access times. */
-#define MS_NODIRATIME	2048	/* Do not update directory access times */
-#define MS_BIND		4096
-#define MS_MOVE		8192
-#define MS_REC		16384
-#define MS_VERBOSE	32768	/* War is peace. Verbosity is silence.
-				   MS_VERBOSE is deprecated. */
-#define MS_SILENT	32768
-#define MS_POSIXACL	(1<<16)	/* VFS does not apply the umask */
-#define MS_UNBINDABLE	(1<<17)	/* change to unbindable */
-#define MS_PRIVATE	(1<<18)	/* change to private */
-#define MS_SLAVE	(1<<19)	/* change to slave */
-#define MS_SHARED	(1<<20)	/* change to shared */
-#define MS_RELATIME	(1<<21)	/* Update atime relative to mtime/ctime. */
-#define MS_KERNMOUNT	(1<<22) /* this is a kern_mount call */
-#define MS_I_VERSION	(1<<23) /* Update inode I_version field */
-#define MS_STRICTATIME	(1<<24) /* Always perform atime updates */
-#define MS_LAZYTIME	(1<<25) /* Update the on-disk [acm]times lazily */
-
-/* These sb flags are internal to the kernel */
-#define MS_SUBMOUNT     (1<<26)
-#define MS_NOREMOTELOCK	(1<<27)
-#define MS_NOSEC	(1<<28)
-#define MS_BORN		(1<<29)
-#define MS_ACTIVE	(1<<30)
-#define MS_NOUSER	(1<<31)
-
-/*
- * Superblock flags that can be altered by MS_REMOUNT
- */
-#define MS_RMT_MASK	(MS_RDONLY|MS_SYNCHRONOUS|MS_MANDLOCK|MS_I_VERSION|\
-			 MS_LAZYTIME)
-
-/*
- * Old magic mount flag and mask
- */
-#define MS_MGC_VAL 0xC0ED0000
-#define MS_MGC_MSK 0xffff0000
-
 /*
  * Structure for FS_IOC_FSGETXATTR[A] and FS_IOC_FSSETXATTR.
  */
@@ -269,7 +223,8 @@ struct fsxattr {
 #define FS_POLICY_FLAGS_PAD_16		0x02
 #define FS_POLICY_FLAGS_PAD_32		0x03
 #define FS_POLICY_FLAGS_PAD_MASK	0x03
-#define FS_POLICY_FLAGS_VALID		0x03
+#define FS_POLICY_FLAG_DIRECT_KEY	0x04	/* use master key directly */
+#define FS_POLICY_FLAGS_VALID		0x07
 
 /* Encryption algorithms */
 #define FS_ENCRYPTION_MODE_INVALID		0
@@ -281,6 +236,7 @@ struct fsxattr {
 #define FS_ENCRYPTION_MODE_AES_128_CTS		6
 #define FS_ENCRYPTION_MODE_SPECK128_256_XTS	7 /* Removed, do not use. */
 #define FS_ENCRYPTION_MODE_SPECK128_256_CTS	8 /* Removed, do not use. */
+#define FS_ENCRYPTION_MODE_ADIANTUM		9
 
 struct fscrypt_policy {
 	__u8 version;
diff --git a/tools/include/uapi/linux/if_link.h b/tools/include/uapi/linux/if_link.h
index 1debfa42cba1..d6533828123a 100644
--- a/tools/include/uapi/linux/if_link.h
+++ b/tools/include/uapi/linux/if_link.h
@@ -288,6 +288,7 @@ enum {
 	IFLA_BR_MCAST_IGMP_VERSION,
 	IFLA_BR_MCAST_MLD_VERSION,
 	IFLA_BR_VLAN_STATS_PER_PORT,
+	IFLA_BR_MULTI_BOOLOPT,
 	__IFLA_BR_MAX,
 };
 
@@ -533,6 +534,7 @@ enum {
 	IFLA_VXLAN_LABEL,
 	IFLA_VXLAN_GPE,
 	IFLA_VXLAN_TTL_INHERIT,
+	IFLA_VXLAN_DF,
 	__IFLA_VXLAN_MAX
 };
 #define IFLA_VXLAN_MAX	(__IFLA_VXLAN_MAX - 1)
@@ -542,6 +544,14 @@ struct ifla_vxlan_port_range {
 	__be16	high;
 };
 
+enum ifla_vxlan_df {
+	VXLAN_DF_UNSET = 0,
+	VXLAN_DF_SET,
+	VXLAN_DF_INHERIT,
+	__VXLAN_DF_END,
+	VXLAN_DF_MAX = __VXLAN_DF_END - 1,
+};
+
 /* GENEVE section */
 enum {
 	IFLA_GENEVE_UNSPEC,
@@ -557,10 +567,19 @@ enum {
 	IFLA_GENEVE_UDP_ZERO_CSUM6_RX,
 	IFLA_GENEVE_LABEL,
 	IFLA_GENEVE_TTL_INHERIT,
+	IFLA_GENEVE_DF,
 	__IFLA_GENEVE_MAX
 };
 #define IFLA_GENEVE_MAX	(__IFLA_GENEVE_MAX - 1)
 
+enum ifla_geneve_df {
+	GENEVE_DF_UNSET = 0,
+	GENEVE_DF_SET,
+	GENEVE_DF_INHERIT,
+	__GENEVE_DF_END,
+	GENEVE_DF_MAX = __GENEVE_DF_END - 1,
+};
+
 /* PPP section */
 enum {
 	IFLA_PPP_UNSPEC,
diff --git a/tools/include/uapi/linux/in.h b/tools/include/uapi/linux/in.h
index 48e8a225b985..f6052e70bf40 100644
--- a/tools/include/uapi/linux/in.h
+++ b/tools/include/uapi/linux/in.h
@@ -266,10 +266,14 @@ struct sockaddr_in {
 
 #define	IN_CLASSD(a)		((((long int) (a)) & 0xf0000000) == 0xe0000000)
 #define	IN_MULTICAST(a)		IN_CLASSD(a)
-#define IN_MULTICAST_NET	0xF0000000
+#define	IN_MULTICAST_NET	0xe0000000
 
-#define	IN_EXPERIMENTAL(a)	((((long int) (a)) & 0xf0000000) == 0xf0000000)
-#define	IN_BADCLASS(a)		IN_EXPERIMENTAL((a))
+#define	IN_BADCLASS(a)		((((long int) (a) ) == 0xffffffff)
+#define	IN_EXPERIMENTAL(a)	IN_BADCLASS((a))
+
+#define	IN_CLASSE(a)		((((long int) (a)) & 0xf0000000) == 0xf0000000)
+#define	IN_CLASSE_NET		0xffffffff
+#define	IN_CLASSE_NSHIFT	0
 
 /* Address to accept any incoming messages. */
 #define	INADDR_ANY		((unsigned long int) 0x00000000)
diff --git a/tools/include/uapi/linux/kvm.h b/tools/include/uapi/linux/kvm.h
index 2b7a652c9fa4..6d4ea4b6c922 100644
--- a/tools/include/uapi/linux/kvm.h
+++ b/tools/include/uapi/linux/kvm.h
@@ -492,6 +492,17 @@ struct kvm_dirty_log {
 	};
 };
 
+/* for KVM_CLEAR_DIRTY_LOG */
+struct kvm_clear_dirty_log {
+	__u32 slot;
+	__u32 num_pages;
+	__u64 first_page;
+	union {
+		void __user *dirty_bitmap; /* one bit per page */
+		__u64 padding2;
+	};
+};
+
 /* for KVM_SET_SIGNAL_MASK */
 struct kvm_signal_mask {
 	__u32 len;
@@ -975,6 +986,8 @@ struct kvm_ppc_resize_hpt {
 #define KVM_CAP_HYPERV_ENLIGHTENED_VMCS 163
 #define KVM_CAP_EXCEPTION_PAYLOAD 164
 #define KVM_CAP_ARM_VM_IPA_SIZE 165
+#define KVM_CAP_MANUAL_DIRTY_LOG_PROTECT 166
+#define KVM_CAP_HYPERV_CPUID 167
 
 #ifdef KVM_CAP_IRQ_ROUTING
 
@@ -1421,6 +1434,12 @@ struct kvm_enc_region {
 #define KVM_GET_NESTED_STATE         _IOWR(KVMIO, 0xbe, struct kvm_nested_state)
 #define KVM_SET_NESTED_STATE         _IOW(KVMIO,  0xbf, struct kvm_nested_state)
 
+/* Available with KVM_CAP_MANUAL_DIRTY_LOG_PROTECT */
+#define KVM_CLEAR_DIRTY_LOG          _IOWR(KVMIO, 0xc0, struct kvm_clear_dirty_log)
+
+/* Available with KVM_CAP_HYPERV_CPUID */
+#define KVM_GET_SUPPORTED_HV_CPUID _IOWR(KVMIO, 0xc1, struct kvm_cpuid2)
+
 /* Secure Encrypted Virtualization command */
 enum sev_cmd_id {
 	/* Guest initialization commands */
diff --git a/tools/include/uapi/linux/mount.h b/tools/include/uapi/linux/mount.h
new file mode 100644
index 000000000000..3f9ec42510b0
--- /dev/null
+++ b/tools/include/uapi/linux/mount.h
@@ -0,0 +1,58 @@
+#ifndef _UAPI_LINUX_MOUNT_H
+#define _UAPI_LINUX_MOUNT_H
+
+/*
+ * These are the fs-independent mount-flags: up to 32 flags are supported
+ *
+ * Usage of these is restricted within the kernel to core mount(2) code and
+ * callers of sys_mount() only.  Filesystems should be using the SB_*
+ * equivalent instead.
+ */
+#define MS_RDONLY	 1	/* Mount read-only */
+#define MS_NOSUID	 2	/* Ignore suid and sgid bits */
+#define MS_NODEV	 4	/* Disallow access to device special files */
+#define MS_NOEXEC	 8	/* Disallow program execution */
+#define MS_SYNCHRONOUS	16	/* Writes are synced at once */
+#define MS_REMOUNT	32	/* Alter flags of a mounted FS */
+#define MS_MANDLOCK	64	/* Allow mandatory locks on an FS */
+#define MS_DIRSYNC	128	/* Directory modifications are synchronous */
+#define MS_NOATIME	1024	/* Do not update access times. */
+#define MS_NODIRATIME	2048	/* Do not update directory access times */
+#define MS_BIND		4096
+#define MS_MOVE		8192
+#define MS_REC		16384
+#define MS_VERBOSE	32768	/* War is peace. Verbosity is silence.
+				   MS_VERBOSE is deprecated. */
+#define MS_SILENT	32768
+#define MS_POSIXACL	(1<<16)	/* VFS does not apply the umask */
+#define MS_UNBINDABLE	(1<<17)	/* change to unbindable */
+#define MS_PRIVATE	(1<<18)	/* change to private */
+#define MS_SLAVE	(1<<19)	/* change to slave */
+#define MS_SHARED	(1<<20)	/* change to shared */
+#define MS_RELATIME	(1<<21)	/* Update atime relative to mtime/ctime. */
+#define MS_KERNMOUNT	(1<<22) /* this is a kern_mount call */
+#define MS_I_VERSION	(1<<23) /* Update inode I_version field */
+#define MS_STRICTATIME	(1<<24) /* Always perform atime updates */
+#define MS_LAZYTIME	(1<<25) /* Update the on-disk [acm]times lazily */
+
+/* These sb flags are internal to the kernel */
+#define MS_SUBMOUNT     (1<<26)
+#define MS_NOREMOTELOCK	(1<<27)
+#define MS_NOSEC	(1<<28)
+#define MS_BORN		(1<<29)
+#define MS_ACTIVE	(1<<30)
+#define MS_NOUSER	(1<<31)
+
+/*
+ * Superblock flags that can be altered by MS_REMOUNT
+ */
+#define MS_RMT_MASK	(MS_RDONLY|MS_SYNCHRONOUS|MS_MANDLOCK|MS_I_VERSION|\
+			 MS_LAZYTIME)
+
+/*
+ * Old magic mount flag and mask
+ */
+#define MS_MGC_VAL 0xC0ED0000
+#define MS_MGC_MSK 0xffff0000
+
+#endif /* _UAPI_LINUX_MOUNT_H */
diff --git a/tools/include/uapi/linux/prctl.h b/tools/include/uapi/linux/prctl.h
index b17201edfa09..b4875a93363a 100644
--- a/tools/include/uapi/linux/prctl.h
+++ b/tools/include/uapi/linux/prctl.h
@@ -220,4 +220,12 @@ struct prctl_mm_map {
 # define PR_SPEC_DISABLE		(1UL << 2)
 # define PR_SPEC_FORCE_DISABLE		(1UL << 3)
 
+/* Reset arm64 pointer authentication keys */
+#define PR_PAC_RESET_KEYS		54
+# define PR_PAC_APIAKEY			(1UL << 0)
+# define PR_PAC_APIBKEY			(1UL << 1)
+# define PR_PAC_APDAKEY			(1UL << 2)
+# define PR_PAC_APDBKEY			(1UL << 3)
+# define PR_PAC_APGAKEY			(1UL << 4)
+
 #endif /* _LINUX_PRCTL_H */
diff --git a/tools/include/uapi/linux/vhost.h b/tools/include/uapi/linux/vhost.h
index 84c3de89696a..40d028eed645 100644
--- a/tools/include/uapi/linux/vhost.h
+++ b/tools/include/uapi/linux/vhost.h
@@ -11,94 +11,9 @@
  * device configuration.
  */
 
+#include <linux/vhost_types.h>
 #include <linux/types.h>
-#include <linux/compiler.h>
 #include <linux/ioctl.h>
-#include <linux/virtio_config.h>
-#include <linux/virtio_ring.h>
-
-struct vhost_vring_state {
-	unsigned int index;
-	unsigned int num;
-};
-
-struct vhost_vring_file {
-	unsigned int index;
-	int fd; /* Pass -1 to unbind from file. */
-
-};
-
-struct vhost_vring_addr {
-	unsigned int index;
-	/* Option flags. */
-	unsigned int flags;
-	/* Flag values: */
-	/* Whether log address is valid. If set enables logging. */
-#define VHOST_VRING_F_LOG 0
-
-	/* Start of array of descriptors (virtually contiguous) */
-	__u64 desc_user_addr;
-	/* Used structure address. Must be 32 bit aligned */
-	__u64 used_user_addr;
-	/* Available structure address. Must be 16 bit aligned */
-	__u64 avail_user_addr;
-	/* Logging support. */
-	/* Log writes to used structure, at offset calculated from specified
-	 * address. Address must be 32 bit aligned. */
-	__u64 log_guest_addr;
-};
-
-/* no alignment requirement */
-struct vhost_iotlb_msg {
-	__u64 iova;
-	__u64 size;
-	__u64 uaddr;
-#define VHOST_ACCESS_RO      0x1
-#define VHOST_ACCESS_WO      0x2
-#define VHOST_ACCESS_RW      0x3
-	__u8 perm;
-#define VHOST_IOTLB_MISS           1
-#define VHOST_IOTLB_UPDATE         2
-#define VHOST_IOTLB_INVALIDATE     3
-#define VHOST_IOTLB_ACCESS_FAIL    4
-	__u8 type;
-};
-
-#define VHOST_IOTLB_MSG 0x1
-#define VHOST_IOTLB_MSG_V2 0x2
-
-struct vhost_msg {
-	int type;
-	union {
-		struct vhost_iotlb_msg iotlb;
-		__u8 padding[64];
-	};
-};
-
-struct vhost_msg_v2 {
-	__u32 type;
-	__u32 reserved;
-	union {
-		struct vhost_iotlb_msg iotlb;
-		__u8 padding[64];
-	};
-};
-
-struct vhost_memory_region {
-	__u64 guest_phys_addr;
-	__u64 memory_size; /* bytes */
-	__u64 userspace_addr;
-	__u64 flags_padding; /* No flags are currently specified. */
-};
-
-/* All region addresses and sizes must be 4K aligned. */
-#define VHOST_PAGE_SIZE 0x1000
-
-struct vhost_memory {
-	__u32 nregions;
-	__u32 padding;
-	struct vhost_memory_region regions[0];
-};
 
 /* ioctls */
 
@@ -186,31 +101,7 @@ struct vhost_memory {
  * device.  This can be used to stop the ring (e.g. for migration). */
 #define VHOST_NET_SET_BACKEND _IOW(VHOST_VIRTIO, 0x30, struct vhost_vring_file)
 
-/* Feature bits */
-/* Log all write descriptors. Can be changed while device is active. */
-#define VHOST_F_LOG_ALL 26
-/* vhost-net should add virtio_net_hdr for RX, and strip for TX packets. */
-#define VHOST_NET_F_VIRTIO_NET_HDR 27
-
-/* VHOST_SCSI specific definitions */
-
-/*
- * Used by QEMU userspace to ensure a consistent vhost-scsi ABI.
- *
- * ABI Rev 0: July 2012 version starting point for v3.6-rc merge candidate +
- *            RFC-v2 vhost-scsi userspace.  Add GET_ABI_VERSION ioctl usage
- * ABI Rev 1: January 2013. Ignore vhost_tpgt filed in struct vhost_scsi_target.
- *            All the targets under vhost_wwpn can be seen and used by guset.
- */
-
-#define VHOST_SCSI_ABI_VERSION	1
-
-struct vhost_scsi_target {
-	int abi_version;
-	char vhost_wwpn[224]; /* TRANSPORT_IQN_LEN */
-	unsigned short vhost_tpgt;
-	unsigned short reserved;
-};
+/* VHOST_SCSI specific defines */
 
 #define VHOST_SCSI_SET_ENDPOINT _IOW(VHOST_VIRTIO, 0x40, struct vhost_scsi_target)
 #define VHOST_SCSI_CLEAR_ENDPOINT _IOW(VHOST_VIRTIO, 0x41, struct vhost_scsi_target)
diff --git a/tools/lib/traceevent/event-parse-api.c b/tools/lib/traceevent/event-parse-api.c
index 8b31c0e00ba3..d463761a58f4 100644
--- a/tools/lib/traceevent/event-parse-api.c
+++ b/tools/lib/traceevent/event-parse-api.c
@@ -194,13 +194,13 @@ void tep_set_page_size(struct tep_handle *pevent, int _page_size)
 }
 
 /**
- * tep_is_file_bigendian - get if the file is in big endian order
+ * tep_file_bigendian - get if the file is in big endian order
  * @pevent: a handle to the tep_handle
  *
  * This returns if the file is in big endian order
  * If @pevent is NULL, 0 is returned.
  */
-int tep_is_file_bigendian(struct tep_handle *pevent)
+int tep_file_bigendian(struct tep_handle *pevent)
 {
 	if(pevent)
 		return pevent->file_bigendian;
diff --git a/tools/lib/traceevent/event-parse-local.h b/tools/lib/traceevent/event-parse-local.h
index 9a092dd4a86d..35833ee32d6c 100644
--- a/tools/lib/traceevent/event-parse-local.h
+++ b/tools/lib/traceevent/event-parse-local.h
@@ -7,7 +7,7 @@
 #ifndef _PARSE_EVENTS_INT_H
 #define _PARSE_EVENTS_INT_H
 
-struct cmdline;
+struct tep_cmdline;
 struct cmdline_list;
 struct func_map;
 struct func_list;
@@ -36,7 +36,7 @@ struct tep_handle {
 	int long_size;
 	int page_size;
 
-	struct cmdline *cmdlines;
+	struct tep_cmdline *cmdlines;
 	struct cmdline_list *cmdlist;
 	int cmdline_count;
 
diff --git a/tools/lib/traceevent/event-parse.c b/tools/lib/traceevent/event-parse.c
index 69a96e39f0ab..abd4fa5d3088 100644
--- a/tools/lib/traceevent/event-parse.c
+++ b/tools/lib/traceevent/event-parse.c
@@ -124,15 +124,15 @@ struct tep_print_arg *alloc_arg(void)
 	return calloc(1, sizeof(struct tep_print_arg));
 }
 
-struct cmdline {
+struct tep_cmdline {
 	char *comm;
 	int pid;
 };
 
 static int cmdline_cmp(const void *a, const void *b)
 {
-	const struct cmdline *ca = a;
-	const struct cmdline *cb = b;
+	const struct tep_cmdline *ca = a;
+	const struct tep_cmdline *cb = b;
 
 	if (ca->pid < cb->pid)
 		return -1;
@@ -152,7 +152,7 @@ static int cmdline_init(struct tep_handle *pevent)
 {
 	struct cmdline_list *cmdlist = pevent->cmdlist;
 	struct cmdline_list *item;
-	struct cmdline *cmdlines;
+	struct tep_cmdline *cmdlines;
 	int i;
 
 	cmdlines = malloc(sizeof(*cmdlines) * pevent->cmdline_count);
@@ -179,8 +179,8 @@ static int cmdline_init(struct tep_handle *pevent)
 
 static const char *find_cmdline(struct tep_handle *pevent, int pid)
 {
-	const struct cmdline *comm;
-	struct cmdline key;
+	const struct tep_cmdline *comm;
+	struct tep_cmdline key;
 
 	if (!pid)
 		return "<idle>";
@@ -208,8 +208,8 @@ static const char *find_cmdline(struct tep_handle *pevent, int pid)
  */
 int tep_pid_is_registered(struct tep_handle *pevent, int pid)
 {
-	const struct cmdline *comm;
-	struct cmdline key;
+	const struct tep_cmdline *comm;
+	struct tep_cmdline key;
 
 	if (!pid)
 		return 1;
@@ -232,11 +232,13 @@ int tep_pid_is_registered(struct tep_handle *pevent, int pid)
  * we must add this pid. This is much slower than when cmdlines
  * are added before the array is initialized.
  */
-static int add_new_comm(struct tep_handle *pevent, const char *comm, int pid)
+static int add_new_comm(struct tep_handle *pevent,
+			const char *comm, int pid, bool override)
 {
-	struct cmdline *cmdlines = pevent->cmdlines;
-	const struct cmdline *cmdline;
-	struct cmdline key;
+	struct tep_cmdline *cmdlines = pevent->cmdlines;
+	struct tep_cmdline *cmdline;
+	struct tep_cmdline key;
+	char *new_comm;
 
 	if (!pid)
 		return 0;
@@ -247,8 +249,19 @@ static int add_new_comm(struct tep_handle *pevent, const char *comm, int pid)
 	cmdline = bsearch(&key, pevent->cmdlines, pevent->cmdline_count,
 		       sizeof(*pevent->cmdlines), cmdline_cmp);
 	if (cmdline) {
-		errno = EEXIST;
-		return -1;
+		if (!override) {
+			errno = EEXIST;
+			return -1;
+		}
+		new_comm = strdup(comm);
+		if (!new_comm) {
+			errno = ENOMEM;
+			return -1;
+		}
+		free(cmdline->comm);
+		cmdline->comm = new_comm;
+
+		return 0;
 	}
 
 	cmdlines = realloc(cmdlines, sizeof(*cmdlines) * (pevent->cmdline_count + 1));
@@ -275,21 +288,13 @@ static int add_new_comm(struct tep_handle *pevent, const char *comm, int pid)
 	return 0;
 }
 
-/**
- * tep_register_comm - register a pid / comm mapping
- * @pevent: handle for the pevent
- * @comm: the command line to register
- * @pid: the pid to map the command line to
- *
- * This adds a mapping to search for command line names with
- * a given pid. The comm is duplicated.
- */
-int tep_register_comm(struct tep_handle *pevent, const char *comm, int pid)
+static int _tep_register_comm(struct tep_handle *pevent,
+			      const char *comm, int pid, bool override)
 {
 	struct cmdline_list *item;
 
 	if (pevent->cmdlines)
-		return add_new_comm(pevent, comm, pid);
+		return add_new_comm(pevent, comm, pid, override);
 
 	item = malloc(sizeof(*item));
 	if (!item)
@@ -312,6 +317,40 @@ int tep_register_comm(struct tep_handle *pevent, const char *comm, int pid)
 	return 0;
 }
 
+/**
+ * tep_register_comm - register a pid / comm mapping
+ * @pevent: handle for the pevent
+ * @comm: the command line to register
+ * @pid: the pid to map the command line to
+ *
+ * This adds a mapping to search for command line names with
+ * a given pid. The comm is duplicated. If a command with the same pid
+ * already exist, -1 is returned and errno is set to EEXIST
+ */
+int tep_register_comm(struct tep_handle *pevent, const char *comm, int pid)
+{
+	return _tep_register_comm(pevent, comm, pid, false);
+}
+
+/**
+ * tep_override_comm - register a pid / comm mapping
+ * @pevent: handle for the pevent
+ * @comm: the command line to register
+ * @pid: the pid to map the command line to
+ *
+ * This adds a mapping to search for command line names with
+ * a given pid. The comm is duplicated. If a command with the same pid
+ * already exist, the command string is udapted with the new one
+ */
+int tep_override_comm(struct tep_handle *pevent, const char *comm, int pid)
+{
+	if (!pevent->cmdlines && cmdline_init(pevent)) {
+		errno = ENOMEM;
+		return -1;
+	}
+	return _tep_register_comm(pevent, comm, pid, true);
+}
+
 int tep_register_trace_clock(struct tep_handle *pevent, const char *trace_clock)
 {
 	pevent->trace_clock = strdup(trace_clock);
@@ -5226,18 +5265,6 @@ int tep_data_type(struct tep_handle *pevent, struct tep_record *rec)
 	return trace_parse_common_type(pevent, rec->data);
 }
 
-/**
- * tep_data_event_from_type - find the event by a given type
- * @pevent: a handle to the pevent
- * @type: the type of the event.
- *
- * This returns the event form a given @type;
- */
-struct tep_event *tep_data_event_from_type(struct tep_handle *pevent, int type)
-{
-	return tep_find_event(pevent, type);
-}
-
 /**
  * tep_data_pid - parse the PID from record
  * @pevent: a handle to the pevent
@@ -5292,8 +5319,8 @@ const char *tep_data_comm_from_pid(struct tep_handle *pevent, int pid)
 	return comm;
 }
 
-static struct cmdline *
-pid_from_cmdlist(struct tep_handle *pevent, const char *comm, struct cmdline *next)
+static struct tep_cmdline *
+pid_from_cmdlist(struct tep_handle *pevent, const char *comm, struct tep_cmdline *next)
 {
 	struct cmdline_list *cmdlist = (struct cmdline_list *)next;
 
@@ -5305,7 +5332,7 @@ pid_from_cmdlist(struct tep_handle *pevent, const char *comm, struct cmdline *ne
 	while (cmdlist && strcmp(cmdlist->comm, comm) != 0)
 		cmdlist = cmdlist->next;
 
-	return (struct cmdline *)cmdlist;
+	return (struct tep_cmdline *)cmdlist;
 }
 
 /**
@@ -5321,10 +5348,10 @@ pid_from_cmdlist(struct tep_handle *pevent, const char *comm, struct cmdline *ne
  * next pid.
  * Also, it does a linear search, so it may be slow.
  */
-struct cmdline *tep_data_pid_from_comm(struct tep_handle *pevent, const char *comm,
-				       struct cmdline *next)
+struct tep_cmdline *tep_data_pid_from_comm(struct tep_handle *pevent, const char *comm,
+					   struct tep_cmdline *next)
 {
-	struct cmdline *cmdline;
+	struct tep_cmdline *cmdline;
 
 	/*
 	 * If the cmdlines have not been converted yet, then use
@@ -5363,7 +5390,7 @@ struct cmdline *tep_data_pid_from_comm(struct tep_handle *pevent, const char *co
  * Returns the pid for a give cmdline. If @cmdline is NULL, then
  * -1 is returned.
  */
-int tep_cmdline_pid(struct tep_handle *pevent, struct cmdline *cmdline)
+int tep_cmdline_pid(struct tep_handle *pevent, struct tep_cmdline *cmdline)
 {
 	struct cmdline_list *cmdlist = (struct cmdline_list *)cmdline;
 
@@ -6593,6 +6620,12 @@ static struct tep_event *search_event(struct tep_handle *pevent, int id,
  *
  * If @id is >= 0, then it is used to find the event.
  * else @sys_name and @event_name are used.
+ *
+ * Returns:
+ *  TEP_REGISTER_SUCCESS_OVERWRITE if an existing handler is overwritten
+ *  TEP_REGISTER_SUCCESS if a new handler is registered successfully
+ *  negative TEP_ERRNO_... in case of an error
+ *
  */
 int tep_register_event_handler(struct tep_handle *pevent, int id,
 			       const char *sys_name, const char *event_name,
@@ -6610,7 +6643,7 @@ int tep_register_event_handler(struct tep_handle *pevent, int id,
 
 	event->handler = func;
 	event->context = context;
-	return 0;
+	return TEP_REGISTER_SUCCESS_OVERWRITE;
 
  not_found:
 	/* Save for later use. */
@@ -6640,7 +6673,7 @@ int tep_register_event_handler(struct tep_handle *pevent, int id,
 	pevent->handlers = handle;
 	handle->context = context;
 
-	return -1;
+	return TEP_REGISTER_SUCCESS;
 }
 
 static int handle_matches(struct event_handler *handler, int id,
@@ -6723,8 +6756,10 @@ struct tep_handle *tep_alloc(void)
 {
 	struct tep_handle *pevent = calloc(1, sizeof(*pevent));
 
-	if (pevent)
+	if (pevent) {
 		pevent->ref_count = 1;
+		pevent->host_bigendian = tep_host_bigendian();
+	}
 
 	return pevent;
 }
diff --git a/tools/lib/traceevent/event-parse.h b/tools/lib/traceevent/event-parse.h
index 35d37087d3c5..aec48f2aea8a 100644
--- a/tools/lib/traceevent/event-parse.h
+++ b/tools/lib/traceevent/event-parse.h
@@ -432,6 +432,7 @@ int tep_set_function_resolver(struct tep_handle *pevent,
 			      tep_func_resolver_t *func, void *priv);
 void tep_reset_function_resolver(struct tep_handle *pevent);
 int tep_register_comm(struct tep_handle *pevent, const char *comm, int pid);
+int tep_override_comm(struct tep_handle *pevent, const char *comm, int pid);
 int tep_register_trace_clock(struct tep_handle *pevent, const char *trace_clock);
 int tep_register_function(struct tep_handle *pevent, char *name,
 			  unsigned long long addr, char *mod);
@@ -484,6 +485,11 @@ int tep_print_func_field(struct trace_seq *s, const char *fmt,
 			 struct tep_event *event, const char *name,
 			 struct tep_record *record, int err);
 
+enum tep_reg_handler {
+	TEP_REGISTER_SUCCESS = 0,
+	TEP_REGISTER_SUCCESS_OVERWRITE,
+};
+
 int tep_register_event_handler(struct tep_handle *pevent, int id,
 			       const char *sys_name, const char *event_name,
 			       tep_event_handler_func func, void *context);
@@ -520,15 +526,14 @@ tep_find_event_by_record(struct tep_handle *pevent, struct tep_record *record);
 void tep_data_lat_fmt(struct tep_handle *pevent,
 		      struct trace_seq *s, struct tep_record *record);
 int tep_data_type(struct tep_handle *pevent, struct tep_record *rec);
-struct tep_event *tep_data_event_from_type(struct tep_handle *pevent, int type);
 int tep_data_pid(struct tep_handle *pevent, struct tep_record *rec);
 int tep_data_preempt_count(struct tep_handle *pevent, struct tep_record *rec);
 int tep_data_flags(struct tep_handle *pevent, struct tep_record *rec);
 const char *tep_data_comm_from_pid(struct tep_handle *pevent, int pid);
-struct cmdline;
-struct cmdline *tep_data_pid_from_comm(struct tep_handle *pevent, const char *comm,
-				       struct cmdline *next);
-int tep_cmdline_pid(struct tep_handle *pevent, struct cmdline *cmdline);
+struct tep_cmdline;
+struct tep_cmdline *tep_data_pid_from_comm(struct tep_handle *pevent, const char *comm,
+					   struct tep_cmdline *next);
+int tep_cmdline_pid(struct tep_handle *pevent, struct tep_cmdline *cmdline);
 
 void tep_print_field(struct trace_seq *s, void *data,
 		     struct tep_format_field *field);
@@ -553,7 +558,7 @@ int tep_get_long_size(struct tep_handle *pevent);
 void tep_set_long_size(struct tep_handle *pevent, int long_size);
 int tep_get_page_size(struct tep_handle *pevent);
 void tep_set_page_size(struct tep_handle *pevent, int _page_size);
-int tep_is_file_bigendian(struct tep_handle *pevent);
+int tep_file_bigendian(struct tep_handle *pevent);
 void tep_set_file_bigendian(struct tep_handle *pevent, enum tep_endian endian);
 int tep_is_host_bigendian(struct tep_handle *pevent);
 void tep_set_host_bigendian(struct tep_handle *pevent, enum tep_endian endian);
diff --git a/tools/lib/traceevent/plugin_kvm.c b/tools/lib/traceevent/plugin_kvm.c
index 754050eea467..64b9c25a1fd3 100644
--- a/tools/lib/traceevent/plugin_kvm.c
+++ b/tools/lib/traceevent/plugin_kvm.c
@@ -389,7 +389,7 @@ static int kvm_mmu_print_role(struct trace_seq *s, struct tep_record *record,
 	 * We can only use the structure if file is of the same
 	 * endianness.
 	 */
-	if (tep_is_file_bigendian(event->pevent) ==
+	if (tep_file_bigendian(event->pevent) ==
 	    tep_is_host_bigendian(event->pevent)) {
 
 		trace_seq_printf(s, "%u q%u%s %s%s %spae %snxe %swp%s%s%s",
diff --git a/tools/lib/traceevent/trace-seq.c b/tools/lib/traceevent/trace-seq.c
index 8ff1d55954d1..8d5ecd2bf877 100644
--- a/tools/lib/traceevent/trace-seq.c
+++ b/tools/lib/traceevent/trace-seq.c
@@ -100,7 +100,8 @@ static void expand_buffer(struct trace_seq *s)
  * @fmt: printf format string
  *
  * It returns 0 if the trace oversizes the buffer's free
- * space, 1 otherwise.
+ * space, the number of characters printed, or a negative
+ * value in case of an error.
  *
  * The tracer may use either sequence operations or its own
  * copy to user routines. To simplify formating of a trace
@@ -129,9 +130,10 @@ trace_seq_printf(struct trace_seq *s, const char *fmt, ...)
 		goto try_again;
 	}
 
-	s->len += ret;
+	if (ret > 0)
+		s->len += ret;
 
-	return 1;
+	return ret;
 }
 
 /**
@@ -139,6 +141,10 @@ trace_seq_printf(struct trace_seq *s, const char *fmt, ...)
  * @s: trace sequence descriptor
  * @fmt: printf format string
  *
+ * It returns 0 if the trace oversizes the buffer's free
+ * space, the number of characters printed, or a negative
+ * value in case of an error.
+ * *
  * The tracer may use either sequence operations or its own
  * copy to user routines. To simplify formating of a trace
  * trace_seq_printf is used to store strings into a special
@@ -163,9 +169,10 @@ trace_seq_vprintf(struct trace_seq *s, const char *fmt, va_list args)
 		goto try_again;
 	}
 
-	s->len += ret;
+	if (ret > 0)
+		s->len += ret;
 
-	return len;
+	return ret;
 }
 
 /**
diff --git a/tools/perf/Makefile.perf b/tools/perf/Makefile.perf
index ff29c3372ec3..0ee6795d82cc 100644
--- a/tools/perf/Makefile.perf
+++ b/tools/perf/Makefile.perf
@@ -524,12 +524,14 @@ $(arch_errno_name_array): $(arch_errno_tbl)
 
 all: shell_compatibility_test $(ALL_PROGRAMS) $(LANG_BINDINGS) $(OTHER_PROGRAMS)
 
+# Create python binding output directory if not already present
+_dummy := $(shell [ -d '$(OUTPUT)python' ] || mkdir -p '$(OUTPUT)python')
+
 $(OUTPUT)python/perf.so: $(PYTHON_EXT_SRCS) $(PYTHON_EXT_DEPS) $(LIBTRACEEVENT_DYNAMIC_LIST)
 	$(QUIET_GEN)LDSHARED="$(CC) -pthread -shared" \
         CFLAGS='$(CFLAGS)' LDFLAGS='$(LDFLAGS) $(LIBTRACEEVENT_DYNAMIC_LIST_LDFLAGS)' \
 	  $(PYTHON_WORD) util/setup.py \
 	  --quiet build_ext; \
-	mkdir -p $(OUTPUT)python && \
 	cp $(PYTHON_EXTBUILD_LIB)perf*.so $(OUTPUT)python/
 
 please_set_SHELL_PATH_to_a_more_modern_shell:
@@ -660,12 +662,12 @@ $(OUTPUT)perf-%: %.o $(PERFLIBS)
 	$(QUIET_LINK)$(CC) $(CFLAGS) -o $@ $(LDFLAGS) $(filter %.o,$^) $(LIBS)
 
 ifndef NO_PERF_READ_VDSO32
-$(OUTPUT)perf-read-vdso32: perf-read-vdso.c util/find-vdso-map.c
+$(OUTPUT)perf-read-vdso32: perf-read-vdso.c util/find-map.c
 	$(QUIET_CC)$(CC) -m32 $(filter -static,$(LDFLAGS)) -Wall -Werror -o $@ perf-read-vdso.c
 endif
 
 ifndef NO_PERF_READ_VDSOX32
-$(OUTPUT)perf-read-vdsox32: perf-read-vdso.c util/find-vdso-map.c
+$(OUTPUT)perf-read-vdsox32: perf-read-vdso.c util/find-map.c
 	$(QUIET_CC)$(CC) -mx32 $(filter -static,$(LDFLAGS)) -Wall -Werror -o $@ perf-read-vdso.c
 endif
 
diff --git a/tools/perf/arch/arm/tests/Build b/tools/perf/arch/arm/tests/Build
index 883c57ff0c08..d9ae2733f9cc 100644
--- a/tools/perf/arch/arm/tests/Build
+++ b/tools/perf/arch/arm/tests/Build
@@ -1,4 +1,5 @@
 libperf-y += regs_load.o
 libperf-y += dwarf-unwind.o
+libperf-y += vectors-page.o
 
 libperf-y += arch-tests.o
diff --git a/tools/perf/arch/arm/tests/arch-tests.c b/tools/perf/arch/arm/tests/arch-tests.c
index 5b1543c98022..6848101a855f 100644
--- a/tools/perf/arch/arm/tests/arch-tests.c
+++ b/tools/perf/arch/arm/tests/arch-tests.c
@@ -10,6 +10,10 @@ struct test arch_tests[] = {
 		.func = test__dwarf_unwind,
 	},
 #endif
+	{
+		.desc = "Vectors page",
+		.func = test__vectors_page,
+	},
 	{
 		.func = NULL,
 	},
diff --git a/tools/perf/arch/arm/tests/vectors-page.c b/tools/perf/arch/arm/tests/vectors-page.c
new file mode 100644
index 000000000000..7ffdd79971c8
--- /dev/null
+++ b/tools/perf/arch/arm/tests/vectors-page.c
@@ -0,0 +1,24 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <stdio.h>
+#include <string.h>
+#include <linux/compiler.h>
+
+#include "debug.h"
+#include "tests/tests.h"
+#include "util/find-map.c"
+
+#define VECTORS__MAP_NAME "[vectors]"
+
+int test__vectors_page(struct test *test __maybe_unused,
+		       int subtest __maybe_unused)
+{
+	void *start, *end;
+
+	if (find_map(&start, &end, VECTORS__MAP_NAME)) {
+		pr_err("%s not found, is CONFIG_KUSER_HELPERS enabled?\n",
+		       VECTORS__MAP_NAME);
+		return TEST_FAIL;
+	}
+
+	return TEST_OK;
+}
diff --git a/tools/perf/arch/powerpc/Makefile b/tools/perf/arch/powerpc/Makefile
index a111239df182..e58d00d62f02 100644
--- a/tools/perf/arch/powerpc/Makefile
+++ b/tools/perf/arch/powerpc/Makefile
@@ -14,18 +14,25 @@ PERF_HAVE_JITDUMP := 1
 out    := $(OUTPUT)arch/powerpc/include/generated/asm
 header32 := $(out)/syscalls_32.c
 header64 := $(out)/syscalls_64.c
-sysdef := $(srctree)/tools/arch/powerpc/include/uapi/asm/unistd.h
-sysprf := $(srctree)/tools/perf/arch/powerpc/entry/syscalls/
+syskrn := $(srctree)/arch/powerpc/kernel/syscalls/syscall.tbl
+sysprf := $(srctree)/tools/perf/arch/powerpc/entry/syscalls
+sysdef := $(sysprf)/syscall.tbl
 systbl := $(sysprf)/mksyscalltbl
 
 # Create output directory if not already present
 _dummy := $(shell [ -d '$(out)' ] || mkdir -p '$(out)')
 
 $(header64): $(sysdef) $(systbl)
-	$(Q)$(SHELL) '$(systbl)' '64' '$(CC)' $(sysdef) > $@
+	@(test -d ../../kernel -a -d ../../tools -a -d ../perf && ( \
+	(diff -B $(sysdef) $(syskrn) >/dev/null) \
+	|| echo "Warning: Kernel ABI header at '$(sysdef)' differs from latest version at '$(syskrn)'" >&2 )) || true
+	$(Q)$(SHELL) '$(systbl)' '64' $(sysdef) > $@
 
 $(header32): $(sysdef) $(systbl)
-	$(Q)$(SHELL) '$(systbl)' '32' '$(CC)' $(sysdef) > $@
+	@(test -d ../../kernel -a -d ../../tools -a -d ../perf && ( \
+	(diff -B $(sysdef) $(syskrn) >/dev/null) \
+	|| echo "Warning: Kernel ABI header at '$(sysdef)' differs from latest version at '$(syskrn)'" >&2 )) || true
+	$(Q)$(SHELL) '$(systbl)' '32' $(sysdef) > $@
 
 clean::
 	$(call QUIET_CLEAN, powerpc) $(RM) $(header32) $(header64)
diff --git a/tools/perf/arch/powerpc/entry/syscalls/mksyscalltbl b/tools/perf/arch/powerpc/entry/syscalls/mksyscalltbl
index ef52e1dd694b..6c58060aa03b 100755
--- a/tools/perf/arch/powerpc/entry/syscalls/mksyscalltbl
+++ b/tools/perf/arch/powerpc/entry/syscalls/mksyscalltbl
@@ -9,10 +9,9 @@
 # Changed by: Ravi Bangoria <ravi.bangoria@linux.vnet.ibm.com>
 
 wordsize=$1
-gcc=$2
-input=$3
+SYSCALL_TBL=$2
 
-if ! test -r $input; then
+if ! test -r $SYSCALL_TBL; then
 	echo "Could not read input file" >&2
 	exit 1
 fi
@@ -20,18 +19,21 @@ fi
 create_table()
 {
 	local wordsize=$1
-	local max_nr
+	local max_nr nr abi sc discard
+	max_nr=-1
+	nr=0
 
 	echo "static const char *syscalltbl_powerpc_${wordsize}[] = {"
-	while read sc nr; do
-		printf '\t[%d] = "%s",\n' $nr $sc
-		max_nr=$nr
+	while read nr abi sc discard; do
+		if [ "$max_nr" -lt "$nr" ]; then
+			printf '\t[%d] = "%s",\n' $nr $sc
+			max_nr=$nr
+		fi
 	done
 	echo '};'
 	echo "#define SYSCALLTBL_POWERPC_${wordsize}_MAX_ID $max_nr"
 }
 
-$gcc -m${wordsize} -E -dM -x c  $input	       \
-	|sed -ne 's/^#define __NR_//p' \
-	|sort -t' ' -k2 -nu	       \
+grep -E "^[[:digit:]]+[[:space:]]+(common|spu|nospu|${wordsize})" $SYSCALL_TBL \
+	|sort -k1 -n                                                           \
 	|create_table ${wordsize}
diff --git a/tools/perf/arch/powerpc/entry/syscalls/syscall.tbl b/tools/perf/arch/powerpc/entry/syscalls/syscall.tbl
new file mode 100644
index 000000000000..db3bbb8744af
--- /dev/null
+++ b/tools/perf/arch/powerpc/entry/syscalls/syscall.tbl
@@ -0,0 +1,427 @@
+# SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note
+#
+# system call numbers and entry vectors for powerpc
+#
+# The format is:
+# <number> <abi> <name> <entry point> <compat entry point>
+#
+# The <abi> can be common, spu, nospu, 64, or 32 for this file.
+#
+0	nospu	restart_syscall			sys_restart_syscall
+1	nospu	exit				sys_exit
+2	nospu	fork				ppc_fork
+3	common	read				sys_read
+4	common	write				sys_write
+5	common	open				sys_open			compat_sys_open
+6	common	close				sys_close
+7	common	waitpid				sys_waitpid
+8	common	creat				sys_creat
+9	common	link				sys_link
+10	common	unlink				sys_unlink
+11	nospu	execve				sys_execve			compat_sys_execve
+12	common	chdir				sys_chdir
+13	common	time				sys_time			compat_sys_time
+14	common	mknod				sys_mknod
+15	common	chmod				sys_chmod
+16	common	lchown				sys_lchown
+17	common	break				sys_ni_syscall
+18	32	oldstat				sys_stat			sys_ni_syscall
+18	64	oldstat				sys_ni_syscall
+18	spu	oldstat				sys_ni_syscall
+19	common	lseek				sys_lseek			compat_sys_lseek
+20	common	getpid				sys_getpid
+21	nospu	mount				sys_mount			compat_sys_mount
+22	32	umount				sys_oldumount
+22	64	umount				sys_ni_syscall
+22	spu	umount				sys_ni_syscall
+23	common	setuid				sys_setuid
+24	common	getuid				sys_getuid
+25	common	stime				sys_stime			compat_sys_stime
+26	nospu	ptrace				sys_ptrace			compat_sys_ptrace
+27	common	alarm				sys_alarm
+28	32	oldfstat			sys_fstat			sys_ni_syscall
+28	64	oldfstat			sys_ni_syscall
+28	spu	oldfstat			sys_ni_syscall
+29	nospu	pause				sys_pause
+30	nospu	utime				sys_utime			compat_sys_utime
+31	common	stty				sys_ni_syscall
+32	common	gtty				sys_ni_syscall
+33	common	access				sys_access
+34	common	nice				sys_nice
+35	common	ftime				sys_ni_syscall
+36	common	sync				sys_sync
+37	common	kill				sys_kill
+38	common	rename				sys_rename
+39	common	mkdir				sys_mkdir
+40	common	rmdir				sys_rmdir
+41	common	dup				sys_dup
+42	common	pipe				sys_pipe
+43	common	times				sys_times			compat_sys_times
+44	common	prof				sys_ni_syscall
+45	common	brk				sys_brk
+46	common	setgid				sys_setgid
+47	common	getgid				sys_getgid
+48	nospu	signal				sys_signal
+49	common	geteuid				sys_geteuid
+50	common	getegid				sys_getegid
+51	nospu	acct				sys_acct
+52	nospu	umount2				sys_umount
+53	common	lock				sys_ni_syscall
+54	common	ioctl				sys_ioctl			compat_sys_ioctl
+55	common	fcntl				sys_fcntl			compat_sys_fcntl
+56	common	mpx				sys_ni_syscall
+57	common	setpgid				sys_setpgid
+58	common	ulimit				sys_ni_syscall
+59	32	oldolduname			sys_olduname
+59	64	oldolduname			sys_ni_syscall
+59	spu	oldolduname			sys_ni_syscall
+60	common	umask				sys_umask
+61	common	chroot				sys_chroot
+62	nospu	ustat				sys_ustat			compat_sys_ustat
+63	common	dup2				sys_dup2
+64	common	getppid				sys_getppid
+65	common	getpgrp				sys_getpgrp
+66	common	setsid				sys_setsid
+67	32	sigaction			sys_sigaction			compat_sys_sigaction
+67	64	sigaction			sys_ni_syscall
+67	spu	sigaction			sys_ni_syscall
+68	common	sgetmask			sys_sgetmask
+69	common	ssetmask			sys_ssetmask
+70	common	setreuid			sys_setreuid
+71	common	setregid			sys_setregid
+72	32	sigsuspend			sys_sigsuspend
+72	64	sigsuspend			sys_ni_syscall
+72	spu	sigsuspend			sys_ni_syscall
+73	32	sigpending			sys_sigpending			compat_sys_sigpending
+73	64	sigpending			sys_ni_syscall
+73	spu	sigpending			sys_ni_syscall
+74	common	sethostname			sys_sethostname
+75	common	setrlimit			sys_setrlimit			compat_sys_setrlimit
+76	32	getrlimit			sys_old_getrlimit		compat_sys_old_getrlimit
+76	64	getrlimit			sys_ni_syscall
+76	spu	getrlimit			sys_ni_syscall
+77	common	getrusage			sys_getrusage			compat_sys_getrusage
+78	common	gettimeofday			sys_gettimeofday		compat_sys_gettimeofday
+79	common	settimeofday			sys_settimeofday		compat_sys_settimeofday
+80	common	getgroups			sys_getgroups
+81	common	setgroups			sys_setgroups
+82	32	select				ppc_select			sys_ni_syscall
+82	64	select				sys_ni_syscall
+82	spu	select				sys_ni_syscall
+83	common	symlink				sys_symlink
+84	32	oldlstat			sys_lstat			sys_ni_syscall
+84	64	oldlstat			sys_ni_syscall
+84	spu	oldlstat			sys_ni_syscall
+85	common	readlink			sys_readlink
+86	nospu	uselib				sys_uselib
+87	nospu	swapon				sys_swapon
+88	nospu	reboot				sys_reboot
+89	32	readdir				sys_old_readdir			compat_sys_old_readdir
+89	64	readdir				sys_ni_syscall
+89	spu	readdir				sys_ni_syscall
+90	common	mmap				sys_mmap
+91	common	munmap				sys_munmap
+92	common	truncate			sys_truncate			compat_sys_truncate
+93	common	ftruncate			sys_ftruncate			compat_sys_ftruncate
+94	common	fchmod				sys_fchmod
+95	common	fchown				sys_fchown
+96	common	getpriority			sys_getpriority
+97	common	setpriority			sys_setpriority
+98	common	profil				sys_ni_syscall
+99	nospu	statfs				sys_statfs			compat_sys_statfs
+100	nospu	fstatfs				sys_fstatfs			compat_sys_fstatfs
+101	common	ioperm				sys_ni_syscall
+102	common	socketcall			sys_socketcall			compat_sys_socketcall
+103	common	syslog				sys_syslog
+104	common	setitimer			sys_setitimer			compat_sys_setitimer
+105	common	getitimer			sys_getitimer			compat_sys_getitimer
+106	common	stat				sys_newstat			compat_sys_newstat
+107	common	lstat				sys_newlstat			compat_sys_newlstat
+108	common	fstat				sys_newfstat			compat_sys_newfstat
+109	32	olduname			sys_uname
+109	64	olduname			sys_ni_syscall
+109	spu	olduname			sys_ni_syscall
+110	common	iopl				sys_ni_syscall
+111	common	vhangup				sys_vhangup
+112	common	idle				sys_ni_syscall
+113	common	vm86				sys_ni_syscall
+114	common	wait4				sys_wait4			compat_sys_wait4
+115	nospu	swapoff				sys_swapoff
+116	common	sysinfo				sys_sysinfo			compat_sys_sysinfo
+117	nospu	ipc				sys_ipc				compat_sys_ipc
+118	common	fsync				sys_fsync
+119	32	sigreturn			sys_sigreturn			compat_sys_sigreturn
+119	64	sigreturn			sys_ni_syscall
+119	spu	sigreturn			sys_ni_syscall
+120	nospu	clone				ppc_clone
+121	common	setdomainname			sys_setdomainname
+122	common	uname				sys_newuname
+123	common	modify_ldt			sys_ni_syscall
+124	common	adjtimex			sys_adjtimex			compat_sys_adjtimex
+125	common	mprotect			sys_mprotect
+126	32	sigprocmask			sys_sigprocmask			compat_sys_sigprocmask
+126	64	sigprocmask			sys_ni_syscall
+126	spu	sigprocmask			sys_ni_syscall
+127	common	create_module			sys_ni_syscall
+128	nospu	init_module			sys_init_module
+129	nospu	delete_module			sys_delete_module
+130	common	get_kernel_syms			sys_ni_syscall
+131	nospu	quotactl			sys_quotactl
+132	common	getpgid				sys_getpgid
+133	common	fchdir				sys_fchdir
+134	common	bdflush				sys_bdflush
+135	common	sysfs				sys_sysfs
+136	32	personality			sys_personality			ppc64_personality
+136	64	personality			ppc64_personality
+136	spu	personality			ppc64_personality
+137	common	afs_syscall			sys_ni_syscall
+138	common	setfsuid			sys_setfsuid
+139	common	setfsgid			sys_setfsgid
+140	common	_llseek				sys_llseek
+141	common	getdents			sys_getdents			compat_sys_getdents
+142	common	_newselect			sys_select			compat_sys_select
+143	common	flock				sys_flock
+144	common	msync				sys_msync
+145	common	readv				sys_readv			compat_sys_readv
+146	common	writev				sys_writev			compat_sys_writev
+147	common	getsid				sys_getsid
+148	common	fdatasync			sys_fdatasync
+149	nospu	_sysctl				sys_sysctl			compat_sys_sysctl
+150	common	mlock				sys_mlock
+151	common	munlock				sys_munlock
+152	common	mlockall			sys_mlockall
+153	common	munlockall			sys_munlockall
+154	common	sched_setparam			sys_sched_setparam
+155	common	sched_getparam			sys_sched_getparam
+156	common	sched_setscheduler		sys_sched_setscheduler
+157	common	sched_getscheduler		sys_sched_getscheduler
+158	common	sched_yield			sys_sched_yield
+159	common	sched_get_priority_max		sys_sched_get_priority_max
+160	common	sched_get_priority_min		sys_sched_get_priority_min
+161	common	sched_rr_get_interval		sys_sched_rr_get_interval	compat_sys_sched_rr_get_interval
+162	common	nanosleep			sys_nanosleep			compat_sys_nanosleep
+163	common	mremap				sys_mremap
+164	common	setresuid			sys_setresuid
+165	common	getresuid			sys_getresuid
+166	common	query_module			sys_ni_syscall
+167	common	poll				sys_poll
+168	common	nfsservctl			sys_ni_syscall
+169	common	setresgid			sys_setresgid
+170	common	getresgid			sys_getresgid
+171	common	prctl				sys_prctl
+172	nospu	rt_sigreturn			sys_rt_sigreturn		compat_sys_rt_sigreturn
+173	nospu	rt_sigaction			sys_rt_sigaction		compat_sys_rt_sigaction
+174	nospu	rt_sigprocmask			sys_rt_sigprocmask		compat_sys_rt_sigprocmask
+175	nospu	rt_sigpending			sys_rt_sigpending		compat_sys_rt_sigpending
+176	nospu	rt_sigtimedwait			sys_rt_sigtimedwait		compat_sys_rt_sigtimedwait
+177	nospu 	rt_sigqueueinfo			sys_rt_sigqueueinfo		compat_sys_rt_sigqueueinfo
+178	nospu 	rt_sigsuspend			sys_rt_sigsuspend		compat_sys_rt_sigsuspend
+179	common	pread64				sys_pread64			compat_sys_pread64
+180	common	pwrite64			sys_pwrite64			compat_sys_pwrite64
+181	common	chown				sys_chown
+182	common	getcwd				sys_getcwd
+183	common	capget				sys_capget
+184	common	capset				sys_capset
+185	nospu	sigaltstack			sys_sigaltstack			compat_sys_sigaltstack
+186	32	sendfile			sys_sendfile			compat_sys_sendfile
+186	64	sendfile			sys_sendfile64
+186	spu	sendfile			sys_sendfile64
+187	common	getpmsg				sys_ni_syscall
+188	common 	putpmsg				sys_ni_syscall
+189	nospu	vfork				ppc_vfork
+190	common	ugetrlimit			sys_getrlimit			compat_sys_getrlimit
+191	common	readahead			sys_readahead			compat_sys_readahead
+192	32	mmap2				sys_mmap2			compat_sys_mmap2
+193	32	truncate64			sys_truncate64			compat_sys_truncate64
+194	32	ftruncate64			sys_ftruncate64			compat_sys_ftruncate64
+195	32	stat64				sys_stat64
+196	32	lstat64				sys_lstat64
+197	32	fstat64				sys_fstat64
+198	nospu 	pciconfig_read			sys_pciconfig_read
+199	nospu 	pciconfig_write			sys_pciconfig_write
+200	nospu 	pciconfig_iobase		sys_pciconfig_iobase
+201	common 	multiplexer			sys_ni_syscall
+202	common	getdents64			sys_getdents64
+203	common	pivot_root			sys_pivot_root
+204	32	fcntl64				sys_fcntl64			compat_sys_fcntl64
+205	common	madvise				sys_madvise
+206	common	mincore				sys_mincore
+207	common	gettid				sys_gettid
+208	common	tkill				sys_tkill
+209	common	setxattr			sys_setxattr
+210	common	lsetxattr			sys_lsetxattr
+211	common	fsetxattr			sys_fsetxattr
+212	common	getxattr			sys_getxattr
+213	common	lgetxattr			sys_lgetxattr
+214	common	fgetxattr			sys_fgetxattr
+215	common	listxattr			sys_listxattr
+216	common	llistxattr			sys_llistxattr
+217	common	flistxattr			sys_flistxattr
+218	common	removexattr			sys_removexattr
+219	common	lremovexattr			sys_lremovexattr
+220	common	fremovexattr			sys_fremovexattr
+221	common	futex				sys_futex			compat_sys_futex
+222	common	sched_setaffinity		sys_sched_setaffinity		compat_sys_sched_setaffinity
+223	common	sched_getaffinity		sys_sched_getaffinity		compat_sys_sched_getaffinity
+# 224 unused
+225	common	tuxcall				sys_ni_syscall
+226	32	sendfile64			sys_sendfile64			compat_sys_sendfile64
+227	common	io_setup			sys_io_setup			compat_sys_io_setup
+228	common	io_destroy			sys_io_destroy
+229	common	io_getevents			sys_io_getevents		compat_sys_io_getevents
+230	common	io_submit			sys_io_submit			compat_sys_io_submit
+231	common	io_cancel			sys_io_cancel
+232	nospu	set_tid_address			sys_set_tid_address
+233	common	fadvise64			sys_fadvise64			ppc32_fadvise64
+234	nospu	exit_group			sys_exit_group
+235	nospu	lookup_dcookie			sys_lookup_dcookie		compat_sys_lookup_dcookie
+236	common	epoll_create			sys_epoll_create
+237	common	epoll_ctl			sys_epoll_ctl
+238	common	epoll_wait			sys_epoll_wait
+239	common	remap_file_pages		sys_remap_file_pages
+240	common	timer_create			sys_timer_create		compat_sys_timer_create
+241	common	timer_settime			sys_timer_settime		compat_sys_timer_settime
+242	common	timer_gettime			sys_timer_gettime		compat_sys_timer_gettime
+243	common	timer_getoverrun		sys_timer_getoverrun
+244	common	timer_delete			sys_timer_delete
+245	common	clock_settime			sys_clock_settime		compat_sys_clock_settime
+246	common	clock_gettime			sys_clock_gettime		compat_sys_clock_gettime
+247	common	clock_getres			sys_clock_getres		compat_sys_clock_getres
+248	common	clock_nanosleep			sys_clock_nanosleep		compat_sys_clock_nanosleep
+249	32	swapcontext			ppc_swapcontext			ppc32_swapcontext
+249	64	swapcontext			ppc64_swapcontext
+249	spu	swapcontext			sys_ni_syscall
+250	common	tgkill				sys_tgkill
+251	common	utimes				sys_utimes			compat_sys_utimes
+252	common	statfs64			sys_statfs64			compat_sys_statfs64
+253	common	fstatfs64			sys_fstatfs64			compat_sys_fstatfs64
+254	32	fadvise64_64			ppc_fadvise64_64
+254	spu	fadvise64_64			sys_ni_syscall
+255	common	rtas				sys_rtas
+256	32	sys_debug_setcontext		sys_debug_setcontext		sys_ni_syscall
+256	64	sys_debug_setcontext		sys_ni_syscall
+256	spu	sys_debug_setcontext		sys_ni_syscall
+# 257 reserved for vserver
+258	nospu	migrate_pages			sys_migrate_pages		compat_sys_migrate_pages
+259	nospu	mbind				sys_mbind			compat_sys_mbind
+260	nospu	get_mempolicy			sys_get_mempolicy		compat_sys_get_mempolicy
+261	nospu	set_mempolicy			sys_set_mempolicy		compat_sys_set_mempolicy
+262	nospu	mq_open				sys_mq_open			compat_sys_mq_open
+263	nospu	mq_unlink			sys_mq_unlink
+264	nospu	mq_timedsend			sys_mq_timedsend		compat_sys_mq_timedsend
+265	nospu	mq_timedreceive			sys_mq_timedreceive		compat_sys_mq_timedreceive
+266	nospu	mq_notify			sys_mq_notify			compat_sys_mq_notify
+267	nospu	mq_getsetattr			sys_mq_getsetattr		compat_sys_mq_getsetattr
+268	nospu	kexec_load			sys_kexec_load			compat_sys_kexec_load
+269	nospu	add_key				sys_add_key
+270	nospu	request_key			sys_request_key
+271	nospu	keyctl				sys_keyctl			compat_sys_keyctl
+272	nospu	waitid				sys_waitid			compat_sys_waitid
+273	nospu	ioprio_set			sys_ioprio_set
+274	nospu	ioprio_get			sys_ioprio_get
+275	nospu	inotify_init			sys_inotify_init
+276	nospu	inotify_add_watch		sys_inotify_add_watch
+277	nospu	inotify_rm_watch		sys_inotify_rm_watch
+278	nospu	spu_run				sys_spu_run
+279	nospu	spu_create			sys_spu_create
+280	nospu	pselect6			sys_pselect6			compat_sys_pselect6
+281	nospu	ppoll				sys_ppoll			compat_sys_ppoll
+282	common	unshare				sys_unshare
+283	common	splice				sys_splice
+284	common	tee				sys_tee
+285	common	vmsplice			sys_vmsplice			compat_sys_vmsplice
+286	common	openat				sys_openat			compat_sys_openat
+287	common	mkdirat				sys_mkdirat
+288	common	mknodat				sys_mknodat
+289	common	fchownat			sys_fchownat
+290	common	futimesat			sys_futimesat			compat_sys_futimesat
+291	32	fstatat64			sys_fstatat64
+291	64	newfstatat			sys_newfstatat
+291	spu	newfstatat			sys_newfstatat
+292	common	unlinkat			sys_unlinkat
+293	common	renameat			sys_renameat
+294	common	linkat				sys_linkat
+295	common	symlinkat			sys_symlinkat
+296	common	readlinkat			sys_readlinkat
+297	common	fchmodat			sys_fchmodat
+298	common	faccessat			sys_faccessat
+299	common	get_robust_list			sys_get_robust_list		compat_sys_get_robust_list
+300	common	set_robust_list			sys_set_robust_list		compat_sys_set_robust_list
+301	common	move_pages			sys_move_pages			compat_sys_move_pages
+302	common	getcpu				sys_getcpu
+303	nospu	epoll_pwait			sys_epoll_pwait			compat_sys_epoll_pwait
+304	common	utimensat			sys_utimensat			compat_sys_utimensat
+305	common	signalfd			sys_signalfd			compat_sys_signalfd
+306	common	timerfd_create			sys_timerfd_create
+307	common	eventfd				sys_eventfd
+308	common	sync_file_range2		sys_sync_file_range2		compat_sys_sync_file_range2
+309	nospu	fallocate			sys_fallocate			compat_sys_fallocate
+310	nospu	subpage_prot			sys_subpage_prot
+311	common	timerfd_settime			sys_timerfd_settime		compat_sys_timerfd_settime
+312	common	timerfd_gettime			sys_timerfd_gettime		compat_sys_timerfd_gettime
+313	common	signalfd4			sys_signalfd4			compat_sys_signalfd4
+314	common	eventfd2			sys_eventfd2
+315	common	epoll_create1			sys_epoll_create1
+316	common	dup3				sys_dup3
+317	common	pipe2				sys_pipe2
+318	nospu	inotify_init1			sys_inotify_init1
+319	common	perf_event_open			sys_perf_event_open
+320	common	preadv				sys_preadv			compat_sys_preadv
+321	common	pwritev				sys_pwritev			compat_sys_pwritev
+322	nospu	rt_tgsigqueueinfo		sys_rt_tgsigqueueinfo		compat_sys_rt_tgsigqueueinfo
+323	nospu	fanotify_init			sys_fanotify_init
+324	nospu	fanotify_mark			sys_fanotify_mark		compat_sys_fanotify_mark
+325	common	prlimit64			sys_prlimit64
+326	common	socket				sys_socket
+327	common	bind				sys_bind
+328	common	connect				sys_connect
+329	common	listen				sys_listen
+330	common	accept				sys_accept
+331	common	getsockname			sys_getsockname
+332	common	getpeername			sys_getpeername
+333	common	socketpair			sys_socketpair
+334	common	send				sys_send
+335	common	sendto				sys_sendto
+336	common	recv				sys_recv			compat_sys_recv
+337	common	recvfrom			sys_recvfrom			compat_sys_recvfrom
+338	common	shutdown			sys_shutdown
+339	common	setsockopt			sys_setsockopt			compat_sys_setsockopt
+340	common	getsockopt			sys_getsockopt			compat_sys_getsockopt
+341	common	sendmsg				sys_sendmsg			compat_sys_sendmsg
+342	common	recvmsg				sys_recvmsg			compat_sys_recvmsg
+343	common	recvmmsg			sys_recvmmsg			compat_sys_recvmmsg
+344	common	accept4				sys_accept4
+345	common	name_to_handle_at		sys_name_to_handle_at
+346	common	open_by_handle_at		sys_open_by_handle_at		compat_sys_open_by_handle_at
+347	common	clock_adjtime			sys_clock_adjtime		compat_sys_clock_adjtime
+348	common	syncfs				sys_syncfs
+349	common	sendmmsg			sys_sendmmsg			compat_sys_sendmmsg
+350	common	setns				sys_setns
+351	nospu	process_vm_readv		sys_process_vm_readv		compat_sys_process_vm_readv
+352	nospu	process_vm_writev		sys_process_vm_writev		compat_sys_process_vm_writev
+353	nospu	finit_module			sys_finit_module
+354	nospu	kcmp				sys_kcmp
+355	common	sched_setattr			sys_sched_setattr
+356	common	sched_getattr			sys_sched_getattr
+357	common	renameat2			sys_renameat2
+358	common	seccomp				sys_seccomp
+359	common	getrandom			sys_getrandom
+360	common	memfd_create			sys_memfd_create
+361	common	bpf				sys_bpf
+362	nospu	execveat			sys_execveat			compat_sys_execveat
+363	32	switch_endian			sys_ni_syscall
+363	64	switch_endian			ppc_switch_endian
+363	spu	switch_endian			sys_ni_syscall
+364	common	userfaultfd			sys_userfaultfd
+365	common	membarrier			sys_membarrier
+378	nospu	mlock2				sys_mlock2
+379	nospu	copy_file_range			sys_copy_file_range
+380	common	preadv2				sys_preadv2			compat_sys_preadv2
+381	common	pwritev2			sys_pwritev2			compat_sys_pwritev2
+382	nospu	kexec_file_load			sys_kexec_file_load
+383	nospu	statx				sys_statx
+384	nospu	pkey_alloc			sys_pkey_alloc
+385	nospu	pkey_free			sys_pkey_free
+386	nospu	pkey_mprotect			sys_pkey_mprotect
+387	nospu	rseq				sys_rseq
+388	nospu	io_pgetevents			sys_io_pgetevents		compat_sys_io_pgetevents
diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
index 1410d66192f7..63a3afc7f32b 100644
--- a/tools/perf/builtin-stat.c
+++ b/tools/perf/builtin-stat.c
@@ -561,7 +561,8 @@ static int __run_perf_stat(int argc, const char **argv, int run_idx)
 					break;
 			}
 		}
-		wait4(child_pid, &status, 0, &stat_config.ru_data);
+		if (child_pid != -1)
+			wait4(child_pid, &status, 0, &stat_config.ru_data);
 
 		if (workload_exec_errno) {
 			const char *emsg = str_error_r(workload_exec_errno, msg, sizeof(msg));
diff --git a/tools/perf/builtin-top.c b/tools/perf/builtin-top.c
index fe3ecfb2e64b..f64e312db787 100644
--- a/tools/perf/builtin-top.c
+++ b/tools/perf/builtin-top.c
@@ -1028,12 +1028,7 @@ static int perf_top__start_counters(struct perf_top *top)
 
 static int callchain_param__setup_sample_type(struct callchain_param *callchain)
 {
-	if (!perf_hpp_list.sym) {
-		if (callchain->enabled) {
-			ui__error("Selected -g but \"sym\" not present in --sort/-s.");
-			return -EINVAL;
-		}
-	} else if (callchain->mode != CHAIN_NONE) {
+	if (callchain->mode != CHAIN_NONE) {
 		if (callchain_register_param(callchain) < 0) {
 			ui__error("Can't register callchain params.\n");
 			return -EINVAL;
diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
index adbf28183560..ed4583128b9c 100644
--- a/tools/perf/builtin-trace.c
+++ b/tools/perf/builtin-trace.c
@@ -1758,6 +1758,7 @@ static int trace__printf_interrupted_entry(struct trace *trace)
 {
 	struct thread_trace *ttrace;
 	size_t printed;
+	int len;
 
 	if (trace->failure_only || trace->current == NULL)
 		return 0;
@@ -1768,9 +1769,14 @@ static int trace__printf_interrupted_entry(struct trace *trace)
 		return 0;
 
 	printed  = trace__fprintf_entry_head(trace, trace->current, 0, false, ttrace->entry_time, trace->output);
-	printed += fprintf(trace->output, ")%-*s ...\n", trace->args_alignment, ttrace->entry_str);
-	ttrace->entry_pending = false;
+	printed += len = fprintf(trace->output, "%s)", ttrace->entry_str);
+
+	if (len < trace->args_alignment - 4)
+		printed += fprintf(trace->output, "%-*s", trace->args_alignment - 4 - len, " ");
 
+	printed += fprintf(trace->output, " ...\n");
+
+	ttrace->entry_pending = false;
 	++trace->nr_events_printed;
 
 	return printed;
@@ -2026,9 +2032,10 @@ static int trace__sys_exit(struct trace *trace, struct perf_evsel *evsel,
 	if (ttrace->entry_pending) {
 		printed = fprintf(trace->output, "%s", ttrace->entry_str);
 	} else {
-		fprintf(trace->output, " ... [");
+		printed += fprintf(trace->output, " ... [");
 		color_fprintf(trace->output, PERF_COLOR_YELLOW, "continued");
-		fprintf(trace->output, "]: %s()", sc->name);
+		printed += 9;
+		printed += fprintf(trace->output, "]: %s()", sc->name);
 	}
 
 	printed++; /* the closing ')' */
diff --git a/tools/perf/check-headers.sh b/tools/perf/check-headers.sh
index 6cb98f8570a2..7b55613924de 100755
--- a/tools/perf/check-headers.sh
+++ b/tools/perf/check-headers.sh
@@ -10,6 +10,7 @@ include/uapi/linux/fs.h
 include/uapi/linux/kcmp.h
 include/uapi/linux/kvm.h
 include/uapi/linux/in.h
+include/uapi/linux/mount.h
 include/uapi/linux/perf_event.h
 include/uapi/linux/prctl.h
 include/uapi/linux/sched.h
@@ -49,7 +50,6 @@ arch/parisc/include/uapi/asm/errno.h
 arch/powerpc/include/uapi/asm/errno.h
 arch/sparc/include/uapi/asm/errno.h
 arch/x86/include/uapi/asm/errno.h
-arch/powerpc/include/uapi/asm/unistd.h
 include/asm-generic/bitops/arch_hweight.h
 include/asm-generic/bitops/const_hweight.h
 include/asm-generic/bitops/__fls.h
diff --git a/tools/perf/perf-read-vdso.c b/tools/perf/perf-read-vdso.c
index 8c0ca0cc428f..aaa5210ea84a 100644
--- a/tools/perf/perf-read-vdso.c
+++ b/tools/perf/perf-read-vdso.c
@@ -5,17 +5,17 @@
 #define VDSO__MAP_NAME "[vdso]"
 
 /*
- * Include definition of find_vdso_map() also used in util/vdso.c for
+ * Include definition of find_map() also used in util/vdso.c for
  * building perf.
  */
-#include "util/find-vdso-map.c"
+#include "util/find-map.c"
 
 int main(void)
 {
 	void *start, *end;
 	size_t size, written;
 
-	if (find_vdso_map(&start, &end))
+	if (find_map(&start, &end, VDSO__MAP_NAME))
 		return 1;
 
 	size = end - start;
diff --git a/tools/perf/tests/shell/lib/probe_vfs_getname.sh b/tools/perf/tests/shell/lib/probe_vfs_getname.sh
index 1c16e56cd93e..7cb99b433888 100644
--- a/tools/perf/tests/shell/lib/probe_vfs_getname.sh
+++ b/tools/perf/tests/shell/lib/probe_vfs_getname.sh
@@ -13,7 +13,8 @@ add_probe_vfs_getname() {
 	local verbose=$1
 	if [ $had_vfs_getname -eq 1 ] ; then
 		line=$(perf probe -L getname_flags 2>&1 | egrep 'result.*=.*filename;' | sed -r 's/[[:space:]]+([[:digit:]]+)[[:space:]]+result->uptr.*/\1/')
-		perf probe $verbose "vfs_getname=getname_flags:${line} pathname=result->name:string"
+		perf probe -q       "vfs_getname=getname_flags:${line} pathname=result->name:string" || \
+		perf probe $verbose "vfs_getname=getname_flags:${line} pathname=filename:string"
 	fi
 }
 
diff --git a/tools/perf/tests/tests.h b/tools/perf/tests/tests.h
index b82f55fcc294..399f18ca71a3 100644
--- a/tools/perf/tests/tests.h
+++ b/tools/perf/tests/tests.h
@@ -119,4 +119,9 @@ int test__arch_unwind_sample(struct perf_sample *sample,
 			     struct thread *thread);
 #endif
 #endif
+
+#if defined(__arm__)
+int test__vectors_page(struct test *test, int subtest);
+#endif
+
 #endif /* TESTS_H */
diff --git a/tools/perf/trace/beauty/mount_flags.sh b/tools/perf/trace/beauty/mount_flags.sh
index 45547573a1db..847850b2ef6c 100755
--- a/tools/perf/trace/beauty/mount_flags.sh
+++ b/tools/perf/trace/beauty/mount_flags.sh
@@ -5,11 +5,11 @@
 
 printf "static const char *mount_flags[] = {\n"
 regex='^[[:space:]]*#[[:space:]]*define[[:space:]]+MS_([[:alnum:]_]+)[[:space:]]+([[:digit:]]+)[[:space:]]*.*'
-egrep $regex ${header_dir}/fs.h | egrep -v '(MSK|VERBOSE|MGC_VAL)\>' | \
+egrep $regex ${header_dir}/mount.h | egrep -v '(MSK|VERBOSE|MGC_VAL)\>' | \
 	sed -r "s/$regex/\2 \2 \1/g" | sort -n | \
 	xargs printf "\t[%s ? (ilog2(%s) + 1) : 0] = \"%s\",\n"
 regex='^[[:space:]]*#[[:space:]]*define[[:space:]]+MS_([[:alnum:]_]+)[[:space:]]+\(1<<([[:digit:]]+)\)[[:space:]]*.*'
-egrep $regex ${header_dir}/fs.h | \
+egrep $regex ${header_dir}/mount.h | \
 	sed -r "s/$regex/\2 \1/g" | \
 	xargs printf "\t[%s + 1] = \"%s\",\n"
 printf "};\n"
diff --git a/tools/perf/trace/beauty/prctl_option.sh b/tools/perf/trace/beauty/prctl_option.sh
index d32f8f1124af..3109d7b05e11 100755
--- a/tools/perf/trace/beauty/prctl_option.sh
+++ b/tools/perf/trace/beauty/prctl_option.sh
@@ -4,7 +4,7 @@
 [ $# -eq 1 ] && header_dir=$1 || header_dir=tools/include/uapi/linux/
 
 printf "static const char *prctl_options[] = {\n"
-regex='^#define[[:space:]]+PR_([GS]ET\w+)[[:space:]]*([[:xdigit:]]+).*'
+regex='^#define[[:space:]]+PR_(\w+)[[:space:]]*([[:xdigit:]]+).*'
 egrep $regex ${header_dir}/prctl.h | grep -v PR_SET_PTRACER | \
 	sed -r "s/$regex/\2 \1/g"	| \
 	sort -n | xargs printf "\t[%s] = \"%s\",\n"
diff --git a/tools/perf/util/annotate.c b/tools/perf/util/annotate.c
index ac9805e0bc76..70de8f6b3aee 100644
--- a/tools/perf/util/annotate.c
+++ b/tools/perf/util/annotate.c
@@ -1723,15 +1723,14 @@ static int symbol__disassemble(struct symbol *sym, struct annotate_args *args)
 	err = asprintf(&command,
 		 "%s %s%s --start-address=0x%016" PRIx64
 		 " --stop-address=0x%016" PRIx64
-		 " -l -d %s %s -C \"%s\" 2>/dev/null|grep -v \"%s:\"|expand",
+		 " -l -d %s %s -C \"$1\" 2>/dev/null|grep -v \"$1:\"|expand",
 		 opts->objdump_path ?: "objdump",
 		 opts->disassembler_style ? "-M " : "",
 		 opts->disassembler_style ?: "",
 		 map__rip_2objdump(map, sym->start),
 		 map__rip_2objdump(map, sym->end),
 		 opts->show_asm_raw ? "" : "--no-show-raw",
-		 opts->annotate_src ? "-S" : "",
-		 symfs_filename, symfs_filename);
+		 opts->annotate_src ? "-S" : "");
 
 	if (err < 0) {
 		pr_err("Failure allocating memory for the command to run\n");
@@ -1756,7 +1755,8 @@ static int symbol__disassemble(struct symbol *sym, struct annotate_args *args)
 		close(stdout_fd[0]);
 		dup2(stdout_fd[1], 1);
 		close(stdout_fd[1]);
-		execl("/bin/sh", "sh", "-c", command, NULL);
+		execl("/bin/sh", "sh", "-c", command, "--", symfs_filename,
+		      NULL);
 		perror(command);
 		exit(-1);
 	}
diff --git a/tools/perf/util/callchain.c b/tools/perf/util/callchain.c
index 32ef7bdca1cf..dc2212e12184 100644
--- a/tools/perf/util/callchain.c
+++ b/tools/perf/util/callchain.c
@@ -766,6 +766,7 @@ static enum match_result match_chain(struct callchain_cursor_node *node,
 			cnode->cycles_count += node->branch_flags.cycles;
 			cnode->iter_count += node->nr_loop_iter;
 			cnode->iter_cycles += node->iter_cycles;
+			cnode->from_count++;
 		}
 	}
 
@@ -1345,10 +1346,10 @@ static int branch_to_str(char *bf, int bfsize,
 static int branch_from_str(char *bf, int bfsize,
 			   u64 branch_count,
 			   u64 cycles_count, u64 iter_count,
-			   u64 iter_cycles)
+			   u64 iter_cycles, u64 from_count)
 {
 	int printed = 0, i = 0;
-	u64 cycles;
+	u64 cycles, v = 0;
 
 	cycles = cycles_count / branch_count;
 	if (cycles) {
@@ -1357,14 +1358,16 @@ static int branch_from_str(char *bf, int bfsize,
 				bf + printed, bfsize - printed);
 	}
 
-	if (iter_count) {
-		printed += count_pri64_printf(i++, "iter",
-				iter_count,
-				bf + printed, bfsize - printed);
+	if (iter_count && from_count) {
+		v = iter_count / from_count;
+		if (v) {
+			printed += count_pri64_printf(i++, "iter",
+					v, bf + printed, bfsize - printed);
 
-		printed += count_pri64_printf(i++, "avg_cycles",
-				iter_cycles / iter_count,
-				bf + printed, bfsize - printed);
+			printed += count_pri64_printf(i++, "avg_cycles",
+					iter_cycles / iter_count,
+					bf + printed, bfsize - printed);
+		}
 	}
 
 	if (i)
@@ -1377,6 +1380,7 @@ static int counts_str_build(char *bf, int bfsize,
 			     u64 branch_count, u64 predicted_count,
 			     u64 abort_count, u64 cycles_count,
 			     u64 iter_count, u64 iter_cycles,
+			     u64 from_count,
 			     struct branch_type_stat *brtype_stat)
 {
 	int printed;
@@ -1389,7 +1393,8 @@ static int counts_str_build(char *bf, int bfsize,
 				predicted_count, abort_count, brtype_stat);
 	} else {
 		printed = branch_from_str(bf, bfsize, branch_count,
-				cycles_count, iter_count, iter_cycles);
+				cycles_count, iter_count, iter_cycles,
+				from_count);
 	}
 
 	if (!printed)
@@ -1402,13 +1407,14 @@ static int callchain_counts_printf(FILE *fp, char *bf, int bfsize,
 				   u64 branch_count, u64 predicted_count,
 				   u64 abort_count, u64 cycles_count,
 				   u64 iter_count, u64 iter_cycles,
+				   u64 from_count,
 				   struct branch_type_stat *brtype_stat)
 {
 	char str[256];
 
 	counts_str_build(str, sizeof(str), branch_count,
 			 predicted_count, abort_count, cycles_count,
-			 iter_count, iter_cycles, brtype_stat);
+			 iter_count, iter_cycles, from_count, brtype_stat);
 
 	if (fp)
 		return fprintf(fp, "%s", str);
@@ -1422,6 +1428,7 @@ int callchain_list_counts__printf_value(struct callchain_list *clist,
 	u64 branch_count, predicted_count;
 	u64 abort_count, cycles_count;
 	u64 iter_count, iter_cycles;
+	u64 from_count;
 
 	branch_count = clist->branch_count;
 	predicted_count = clist->predicted_count;
@@ -1429,11 +1436,12 @@ int callchain_list_counts__printf_value(struct callchain_list *clist,
 	cycles_count = clist->cycles_count;
 	iter_count = clist->iter_count;
 	iter_cycles = clist->iter_cycles;
+	from_count = clist->from_count;
 
 	return callchain_counts_printf(fp, bf, bfsize, branch_count,
 				       predicted_count, abort_count,
 				       cycles_count, iter_count, iter_cycles,
-				       &clist->brtype_stat);
+				       from_count, &clist->brtype_stat);
 }
 
 static void free_callchain_node(struct callchain_node *node)
diff --git a/tools/perf/util/callchain.h b/tools/perf/util/callchain.h
index 154560b1eb65..99d38ac019b8 100644
--- a/tools/perf/util/callchain.h
+++ b/tools/perf/util/callchain.h
@@ -118,6 +118,7 @@ struct callchain_list {
 		bool		has_children;
 	};
 	u64			branch_count;
+	u64			from_count;
 	u64			predicted_count;
 	u64			abort_count;
 	u64			cycles_count;
diff --git a/tools/perf/util/find-vdso-map.c b/tools/perf/util/find-map.c
similarity index 71%
rename from tools/perf/util/find-vdso-map.c
rename to tools/perf/util/find-map.c
index d7823e3508fc..7b2300588ece 100644
--- a/tools/perf/util/find-vdso-map.c
+++ b/tools/perf/util/find-map.c
@@ -1,5 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0
-static int find_vdso_map(void **start, void **end)
+static int find_map(void **start, void **end, const char *name)
 {
 	FILE *maps;
 	char line[128];
@@ -7,7 +7,7 @@ static int find_vdso_map(void **start, void **end)
 
 	maps = fopen("/proc/self/maps", "r");
 	if (!maps) {
-		fprintf(stderr, "vdso: cannot open maps\n");
+		fprintf(stderr, "cannot open maps\n");
 		return -1;
 	}
 
@@ -21,8 +21,7 @@ static int find_vdso_map(void **start, void **end)
 		if (m < 0)
 			continue;
 
-		if (!strncmp(&line[m], VDSO__MAP_NAME,
-			     sizeof(VDSO__MAP_NAME) - 1))
+		if (!strncmp(&line[m], name, strlen(name)))
 			found = 1;
 	}
 
diff --git a/tools/perf/util/machine.c b/tools/perf/util/machine.c
index 6fcb3bce0442..143f7057d581 100644
--- a/tools/perf/util/machine.c
+++ b/tools/perf/util/machine.c
@@ -2005,7 +2005,7 @@ static void save_iterations(struct iterations *iter,
 {
 	int i;
 
-	iter->nr_loop_iter = nr;
+	iter->nr_loop_iter++;
 	iter->cycles = 0;
 
 	for (i = 0; i < nr; i++)
diff --git a/tools/perf/util/strbuf.c b/tools/perf/util/strbuf.c
index 9005fbe0780e..23092fd6451d 100644
--- a/tools/perf/util/strbuf.c
+++ b/tools/perf/util/strbuf.c
@@ -109,7 +109,6 @@ static int strbuf_addv(struct strbuf *sb, const char *fmt, va_list ap)
 			return ret;
 		}
 		len = vsnprintf(sb->buf + sb->len, sb->alloc - sb->len, fmt, ap_saved);
-		va_end(ap_saved);
 		if (len > strbuf_avail(sb)) {
 			pr_debug("this should not happen, your vsnprintf is broken");
 			va_end(ap_saved);
diff --git a/tools/perf/util/symbol.c b/tools/perf/util/symbol.c
index 01f2c7385e38..48efad6d0f90 100644
--- a/tools/perf/util/symbol.c
+++ b/tools/perf/util/symbol.c
@@ -614,6 +614,7 @@ int modules__parse(const char *filename, void *arg,
 static bool symbol__is_idle(const char *name)
 {
 	const char * const idle_symbols[] = {
+		"arch_cpu_idle",
 		"cpu_idle",
 		"cpu_startup_entry",
 		"intel_idle",
diff --git a/tools/perf/util/vdso.c b/tools/perf/util/vdso.c
index 741af209b19d..3702cba11d7d 100644
--- a/tools/perf/util/vdso.c
+++ b/tools/perf/util/vdso.c
@@ -18,10 +18,10 @@
 #include "debug.h"
 
 /*
- * Include definition of find_vdso_map() also used in perf-read-vdso.c for
+ * Include definition of find_map() also used in perf-read-vdso.c for
  * building perf-read-vdso32 and perf-read-vdsox32.
  */
-#include "find-vdso-map.c"
+#include "find-map.c"
 
 #define VDSO__TEMP_FILE_NAME "/tmp/perf-vdso.so-XXXXXX"
 
@@ -76,7 +76,7 @@ static char *get_file(struct vdso_file *vdso_file)
 	if (vdso_file->found)
 		return vdso_file->temp_file_name;
 
-	if (vdso_file->error || find_vdso_map(&start, &end))
+	if (vdso_file->error || find_map(&start, &end, VDSO__MAP_NAME))
 		return NULL;
 
 	size = end - start;
diff --git a/tools/thermal/tmon/Makefile b/tools/thermal/tmon/Makefile
index 89a2444c1df2..59e417ec3e13 100644
--- a/tools/thermal/tmon/Makefile
+++ b/tools/thermal/tmon/Makefile
@@ -6,7 +6,7 @@ VERSION = 1.0
 
 BINDIR=usr/bin
 WARNFLAGS=-Wall -Wshadow -W -Wformat -Wimplicit-function-declaration -Wimplicit-int
-override CFLAGS+= -O1 ${WARNFLAGS}
+override CFLAGS+= $(call cc-option,-O3,-O1) ${WARNFLAGS}
 # Add "-fstack-protector" only if toolchain supports it.
 override CFLAGS+= $(call cc-option,-fstack-protector-strong)
 CC?= $(CROSS_COMPILE)gcc
