Return-Path: <SRS0=Tk4m=PR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,INCLUDES_PATCH,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5636DC43387
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 07:05:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E090320821
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 07:05:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547017538;
	bh=swyTSZNGT0uy7mEtjOLydNxdcpUfiypf8cvvmjSb1LE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=nlI9Ep1pTnIckBQnFlKaXu32N6VmzG/B7L5TtZTXsy9Vy3oJEulZMxCm1rGtSv3/s
	 7DQb/ardfL6A1iTRw6GvrL+O9tePyycC8ANqzMTxQkxvr/f4bLCcSuXXJZT8qZIcEK
	 tlA3dHdh4Aia4fqo2sBaymjTtBd1ZlzVuN/R5KFw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729731AbfAIHFf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Jan 2019 02:05:35 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:55619 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729528AbfAIHFf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jan 2019 02:05:35 -0500
Received: by mail-wm1-f65.google.com with SMTP id y139so6410833wmc.5;
        Tue, 08 Jan 2019 23:05:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=lmkziVX2BQaaWYur0JXOmAGKOPq4bSiNFIfn41UHG2Y=;
        b=fQUfErGtEasKzR344j89RnV6rm6EIspeAYJFi+lM06vDEqB0l3kn7Xqj0SwPiAOn1S
         rBSamDoMfdetCSgoV+bM9kmrEUKgUBH9J3lUa2AObbtO1/5/Jo2VcO9Kr2TaAGzlo+47
         J9MKzyQlYTZYci6G9v1yRRMwLNoOtybhfsgGaovETZaVHxYASh6pfBp42gHOx0ACBuNX
         njyUeRYfxUu+zGevQbOfkkL1nLGOOBljQwhsMI0t8SPhAoKO8WrirtsWrTnB3m8clJt+
         Q4alRsvLY3IXafMn8Ut7YmTjK3eTbs0qImYyaAgNbP7GiGJAz/F11pV3P6ZjnJJHstK6
         pHOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=lmkziVX2BQaaWYur0JXOmAGKOPq4bSiNFIfn41UHG2Y=;
        b=ZOCXcNcsPWcnyaUpEeq6NdO4qSsWhLhIoQNnLUfkF9dYOWobAUj4Q+3BVhS1BQGAJe
         7GrBOueFb36VdufGp4VlN00zaFj90vXb74K4AIHPqCxlRoVu5k9Z/ChYx2SuZKAxbpQq
         FV1qw5DOJ3oDgmSMjfOc9WvdkODeyZg0cYpdt6fTp29bi1zDmCumAu6QsqdONWBXo2B4
         aeaTusYN6qrIHtSWtb3+EgHzXCeOFfYSeCSHFVeTOjJU61d9DI/n9k+1knPPtlSz9hCt
         bS5wD7FBHfnubiqs96zstU+k2lkNZjmbmzmflMrG3u0A9PHxAXeLJBfAjMLt7RRee6YU
         kh7w==
X-Gm-Message-State: AJcUukd0+zE23MO9fqkYJp3/XMZ7qxbOEW/IRhod8PuSsyni0xCXLMtg
        YAORHvfsNiWFpkqgyWxStec=
X-Google-Smtp-Source: ALg8bN5ELWPivGBOlu5DMmg4uhhItYEFLvcJwz86WtKL8Ayu3wLN7kQ0qpOlB9MLFotKGdbNBuTtfA==
X-Received: by 2002:a1c:81ca:: with SMTP id c193mr4556169wmd.66.1547017531593;
        Tue, 08 Jan 2019 23:05:31 -0800 (PST)
Received: from gmail.com (2E8B0CD5.catv.pool.telekom.hu. [46.139.12.213])
        by smtp.gmail.com with ESMTPSA id e18sm72739581wrv.88.2019.01.08.23.05.30
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 08 Jan 2019 23:05:30 -0800 (PST)
Date:   Wed, 9 Jan 2019 08:05:28 +0100
From:   Ingo Molnar <mingo@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org,
        Florian Fainelli <f.fainelli@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Tzvetomir Stoyanov <tstoyanov@vmware.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: Re: [GIT PULL 00/16] perf/core fixes and improvements
Message-ID: <20190109070528.GB29753@gmail.com>
References: <20190108195910.17726-1-acme@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190108195910.17726-1-acme@kernel.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Arnaldo Carvalho de Melo <acme@kernel.org> wrote:

> Hi Ingo,
> 
> 	Please consider pulling,
> 
> - Arnaldo
> 
> Test results at the end of this message, as usual.
> 
> The following changes since commit 64598e8b6fdaf28e37c3530f8b95a9f8ef6af131:
> 
>   Merge tag 'perf-core-for-mingo-4.21-20190104' of git://git.kernel.org/pub/scm/linux/kernel/git/acme/linux into perf/urgent (2019-01-08 16:31:19 +0100)
> 
> are available in the Git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git tags/perf-core-for-mingo-5.0-20190108
> 
> for you to fetch changes up to ee412f14693a3fe2645b3528603dfd37dd05118a:
> 
>   tools include uapi: Sync linux/vhost.h with the kernel sources (2019-01-08 14:09:33 -0300)
> 
> ----------------------------------------------------------------
> perf/core fixes and improvements:
> 
> perf top:
> 
>   Arnaldo Carvalho de Melo:
> 
>   . Lift restriction on using callchains without "sym" in --sort, allowing
> 
> perf trace:
> 
>   Arnaldo Carvalho de Melo:
> 
>   . Fix ')' placement in "interrupted" syscall lines.
> 
>   . Fix alignment for [continued] lines.
> 
> perf tests:
> 
>   Florian Fainelli:
> 
>   . Add a test for the ARM 32-bit [vectors] page.
> 
> tools lib traceevent:
> 
>   Tzvetomir Stoyanov:
> 
>   . Introduce new libtracevent API: tep_override_comm().
> 
>   . Initialize host_bigendian at tep_handle allocation.
> 
>   . More namespacing changes.
> 
>   . Remove superfluous APIs.
> 
> tools headers uapi:
> 
>   Arnaldo Carvalho de Melo:
> 
>   . Update linux/{fs,vhost}.h, grab a copy o linux/mount.h, where the
>     MS_ mount flags were moved.
> 
> Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
> 
> ----------------------------------------------------------------
> Arnaldo Carvalho de Melo (7):
>       perf trace: Fix ')' placement in "interrupted" syscall lines
>       perf trace: Fix alignment for [continued] lines
>       perf top: Lift restriction on using callchains without "sym" in --sort
>       tools include uapi: Grab a copy of linux/mount.h
>       perf beauty: Switch from using uapi/linux/fs.h to uapi/linux/mount.h
>       tools include uapi: Sync linux/fs.h copy with the kernel sources
>       tools include uapi: Sync linux/vhost.h with the kernel sources
> 
> Florian Fainelli (2):
>       perf tools: Make find_vdso_map() more modular
>       perf tests: Add a test for the ARM 32-bit [vectors] page
> 
> Tzvetomir Stoyanov (7):
>       tools lib traceevent: Introduce new libtracevent API: tep_override_comm()
>       tools lib traceevent: Initialize host_bigendian at tep_handle allocation
>       tools lib traceevent: Rename struct cmdline to struct tep_cmdline
>       tools lib traceevent: Changed return logic of trace_seq_printf() and trace_seq_vprintf() APIs
>       tools lib traceevent: Changed return logic of tep_register_event_handler() API
>       tools lib traceevent: Rename tep_is_file_bigendian() to tep_file_bigendian()
>       tools lib traceevent: Remove tep_data_event_from_type() API
> 
>  tools/include/uapi/linux/fs.h                   |  60 ++---------
>  tools/include/uapi/linux/mount.h                |  58 +++++++++++
>  tools/include/uapi/linux/vhost.h                | 113 +--------------------
>  tools/lib/traceevent/event-parse-api.c          |   4 +-
>  tools/lib/traceevent/event-parse-local.h        |   4 +-
>  tools/lib/traceevent/event-parse.c              | 129 +++++++++++++++---------
>  tools/lib/traceevent/event-parse.h              |  17 ++--
>  tools/lib/traceevent/plugin_kvm.c               |   2 +-
>  tools/lib/traceevent/trace-seq.c                |  17 +++-
>  tools/perf/Makefile.perf                        |   4 +-
>  tools/perf/arch/arm/tests/Build                 |   1 +
>  tools/perf/arch/arm/tests/arch-tests.c          |   4 +
>  tools/perf/arch/arm/tests/vectors-page.c        |  24 +++++
>  tools/perf/builtin-top.c                        |   7 +-
>  tools/perf/builtin-trace.c                      |  15 ++-
>  tools/perf/check-headers.sh                     |   1 +
>  tools/perf/perf-read-vdso.c                     |   6 +-
>  tools/perf/tests/tests.h                        |   5 +
>  tools/perf/trace/beauty/mount_flags.sh          |   4 +-
>  tools/perf/util/{find-vdso-map.c => find-map.c} |   7 +-
>  tools/perf/util/vdso.c                          |   6 +-
>  21 files changed, 238 insertions(+), 250 deletions(-)
>  create mode 100644 tools/include/uapi/linux/mount.h
>  create mode 100644 tools/perf/arch/arm/tests/vectors-page.c
>  rename tools/perf/util/{find-vdso-map.c => find-map.c} (71%)

Pulled, thanks a lot Arnaldo!

> tools headers uapi:
> 
>   Arnaldo Carvalho de Melo:
> 
>   . Update linux/{fs,vhost}.h, grab a copy o linux/mount.h, where the
>     MS_ mount flags were moved.

We still have two UAPI warnings in the latest tip:perf/urgent - the patch 
below fixes them, at least on x86.

The if_link.h looks trivial enough - but I'm unsure about the powerpc one 
and didn't test it on PowerPC.

Thanks,

	Ingo

==============>
 tools/arch/powerpc/include/uapi/asm/unistd.h | 389 +--------------------------
 tools/include/uapi/linux/if_link.h           |  19 ++
 2 files changed, 21 insertions(+), 387 deletions(-)

diff --git a/tools/arch/powerpc/include/uapi/asm/unistd.h b/tools/arch/powerpc/include/uapi/asm/unistd.h
index 985534d0b448..5f84e3dc98d0 100644
--- a/tools/arch/powerpc/include/uapi/asm/unistd.h
+++ b/tools/arch/powerpc/include/uapi/asm/unistd.h
@@ -10,395 +10,10 @@
 #ifndef _UAPI_ASM_POWERPC_UNISTD_H_
 #define _UAPI_ASM_POWERPC_UNISTD_H_
 
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
 #ifndef __powerpc64__
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
+#include <asm/unistd_32.h>
 #else
-#define __NR_fstatat64		291
+#include <asm/unistd_64.h>
 #endif
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
 
 #endif /* _UAPI_ASM_POWERPC_UNISTD_H_ */
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



