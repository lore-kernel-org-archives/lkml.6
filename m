Return-Path: <SRS0=q0iV=PB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39DC0C64E79
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Dec 2018 22:37:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D042F21738
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Dec 2018 22:37:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545691056;
	bh=q3sq6vCEryC0A3xTNQw02N9afUiPdtKM3rysUB/IYpQ=;
	h=Date:From:To:Cc:Subject:List-ID:From;
	b=MOsg93xUnuPXh7QgyNqeCyR8knCNrNNTvHVItnP93JJLT7deniTorYyfOEphJPqp+
	 +fHHpT2ZcU2CWDvRTSPOxDAfbjjgPmAElynWp5RVzkCzV8ty0JeT673jxH0ASD2XiS
	 oLOTOVP1ViHJiwungb1O4x5pMArFs/hdv+VHW+OE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725837AbeLXWhe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Dec 2018 17:37:34 -0500
Received: from mail-wr1-f47.google.com ([209.85.221.47]:40049 "EHLO
        mail-wr1-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725788AbeLXWhe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Dec 2018 17:37:34 -0500
Received: by mail-wr1-f47.google.com with SMTP id p4so12586770wrt.7
        for <linux-kernel@vger.kernel.org>; Mon, 24 Dec 2018 14:37:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=Mki6p3Sm6aDTsEL2g6p7n7MCX9IabPlw9F3tlGD3Fv4=;
        b=WsmIh5a1x1RokXV5MbJUtRSiHwxBQO4DWHpB7ro3AFV/IaUKJC+3reC0C3WHFD+A48
         f2VHFKjl1Jr7KRF9tELM43gJ4P9x8kCL7jNjcgVNIi4v7u82+B6Esk6asK2IEev4oWWV
         +TnWt6EWQCxBxnPLlsRRejvMHjV5gQCcQejTL746CQonjMcdyigyxyqOiBiAXFgKBteR
         XwT11Dz+4BIZBLc/M88Mr6Bu8Cf8aaMTbD3KzFO6YeyNwVsez/UTsAibvBaeyq6FoZh7
         +mFDgrrqeW3gvXy279iMFc5LLX0QlIPVa/z9Sit1vAZe1XVhsscybAODu5Z74zXPWrYL
         ZJQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mime-version:content-disposition:user-agent;
        bh=Mki6p3Sm6aDTsEL2g6p7n7MCX9IabPlw9F3tlGD3Fv4=;
        b=fz6tTfG5zWD/VRqrJBoxScw00TPUf2CbCMCQ1B7pzw1ulKmcuHDfQKW3ycrOUgxHCQ
         hzqD9fr48Ad/rEFpxhdklAV2m4kUcP+DlAj8Hlvcsny5yMX3ZcvLlUELeK5nhI/eGR1S
         JEMr7ueZYcN95NsuaxTNETiTfdyCy64q2vjYKEUFFosPKq28Csk52RtHybfBjDh2LRof
         kwE/xiVERot2IA/AJQ6G7ehnBM7QCnrSu1txMbVYnY2iR/8oiUxdsfCC713XiqtUwFH1
         l/HxOMvYJhysFEdGrFkBn1r9KUXfCHBGsPhSQxjamH36FTvaNxtn9Y071LUY85zp7LLI
         yHtw==
X-Gm-Message-State: AJcUukeAdJpp1+Fz3kkJMtqqlbE5MIfIXGnkVqWa6ApLC93l6+/xj7vX
        duCci1odY+BeapWZgSLeD4A=
X-Google-Smtp-Source: ALg8bN6t8Ws0DylnNxBnZcty15B9b/3ACVuFQn3pWyEC82ulZvbEQ+c/gJgfvwCXFW6TzH6XWa1wlw==
X-Received: by 2002:a5d:4a45:: with SMTP id v5mr12476502wrs.7.1545691050083;
        Mon, 24 Dec 2018 14:37:30 -0800 (PST)
Received: from gmail.com (2E8B0CD5.catv.pool.telekom.hu. [46.139.12.213])
        by smtp.gmail.com with ESMTPSA id e16sm23408455wrn.72.2018.12.24.14.37.28
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 24 Dec 2018 14:37:29 -0800 (PST)
Date:   Mon, 24 Dec 2018 23:37:27 +0100
From:   Ingo Molnar <mingo@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Arnaldo Carvalho de Melo <acme@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [GIT PULL] perf updates for v4.21
Message-ID: <20181224223727.GA34100@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

Please pull the latest perf-core-for-linus git tree from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git perf-core-for-linus

   # HEAD: 883f4def8b77e6870ce42be279564cca0256c611 Merge tag 'perf-core-for-mingo-4.21-20181218' of git://git.kernel.org/pub/scm/linux/kernel/git/acme/linux into perf/core

The main changes in this cycle on the kernel side:

 - rework kprobes blacklist handling (Masami Hiramatsu)
 - misc cleanups

on the tooling side these areas were the main focus:

 - 'perf trace'     enhancements (Arnaldo Carvalho de Melo)
 - 'perf bench'     enhancements (Davidlohr Bueso)
 - 'perf record'    enhancements (Alexey Budankov)
 - 'perf annotate'  enhancements (Jin Yao)
 - 'perf top'       enhancements (Jiri Olsa)
 - Intel hw tracing enhancements (Adrian Hunter)
 - ARM hw tracing   enhancements (Leo Yan, Mathieu Poirier)

 - ... plus lots of other enhancements, cleanups and fixes.

(See the Git log for more details.)

 Thanks,

	Ingo

------------------>
Adrian Hunter (10):
      perf machine: Record if a arch has a single user/kernel address space
      perf thread: Add fallback functions for cases where cpumode is insufficient
      perf tools: Use fallback for sample_addr_correlates_sym() cases
      perf script: Use fallbacks for branch stacks
      tools lib traceevent: Fix compile warnings in tools/lib/traceevent/event-parse.c
      perf tests record: Allow for 'sleep' being 'coreutils'
      perf test: Fix perf_event_attr test failure
      perf intel-pt: Fix error with config term "pt=0"
      perf dso: Export data_file_size() method there are no symbols
      perf auxtrace: Alter addr_filter__entire_dso() to work if there are no symbols

Alexey Budankov (5):
      tools build feature: Check if libaio is available
      perf mmap: Map data buffer for preserving collected data
      perf record: Enable asynchronous trace writing
      perf record: Extend trace writing to multi AIO
      perf record: Fix memory leak on AIO objects deallocation

Andi Kleen (2):
      perf tools: Support 'srccode' output
      perf vendor events intel: Fix Load_Miss_Real_Latency on SKL/SKX

Arnaldo Carvalho de Melo (77):
      perf bpf: Add unistd.h to the headers accessible to bpf proggies
      perf augmented_syscalls: Filter on a hard coded pid
      perf augmented_syscalls: Remove needless linux/socket.h include
      perf bpf: Add defines for map insertion/lookup
      perf bpf: Add simple pid_filter class accessible to BPF proggies
      perf augmented_syscalls: Drop 'write', 'poll' for testing without self pid filter
      perf augmented_syscalls: Use pid_filter
      perf evlist: Rename perf_evlist__set_filter* to perf_evlist__set_tp_filter*
      perf trace: Add "_from_option" suffix to trace__set_filter()
      perf trace: See if there is a map named "filtered_pids"
      perf trace: Fill in BPF "filtered_pids" map when present
      perf augmented_syscalls: Remove example hardcoded set of filtered pids
      Revert "perf augmented_syscalls: Drop 'write', 'poll' for testing without self pid filter"
      perf bpf: Reduce the hardcoded .max_entries for pid_maps
      tools build feature: Check if eventfd() is available
      perf build: Give better hint about devel package for libssl
      perf env: Also consider env->arch == NULL as local operation
      tools include: Adopt ERR_CAST() from the kernel err.h header
      perf top: Allow passing a kallsyms file
      perf beauty mmap_flags: Check if the arch has a mmap.h file
      perf trace: We need to consider "nr" if "__syscall_nr" is not there
      perf dso: Fix unchecked usage of strncpy()
      perf header: Fix unchecked usage of strncpy()
      perf header: Fix unchecked usage of strncpy()
      perf help: Remove needless use of strncpy()
      perf svghelper: Fix unchecked usage of strncpy()
      perf ui helpline: Use strlcpy() as a shorter form of strncpy() + explicit set nul
      perf probe: Fix unchecked usage of strncpy()
      perf parse-events: Fix unchecked usage of strncpy()
      perf trace: Rename delivery functions to ease making ordered_events selectable
      perf trace: Allow selecting use the use of the ordered_events code
      perf trace beauty: Beautify renameat2's fd arg wrt AT_FDCWD
      perf beauty: Add a string table generator for renameat2's flags constants
      perf beauty: Wire up the renameat flags table generator to the Makefile
      perf trace: Beautify renameat2's flags argument
      perf trace beauty: renameat's newdirfd may also be AT_FDCWD
      tools lib subcmd: Don't add the kernel sources to the include path
      perf tools: Add missing sigqueue() prototype for systems lacking it
      perf header: Fix up argument to ctime()
      perf tools: Add missing open_memstream() prototype for systems lacking it
      perf tools: Cast off_t to s64 to avoid warning on bionic libc
      perf trace: Rename set_ev_qualifier_filter to clarify its a tracepoint filter
      perf trace: Avoid using raw_syscalls in duplicity with eBPF augmentation
      perf trace: Implement syscall filtering in augmented_syscalls
      perf bpf: Move perf_event_output() from stdio.h to bpf.h
      perf augmented_syscalls: Switch to using a struct for the syscalls map values
      perf trace: Switch to using a struct for the aumented_raw_syscalls syscalls map values
      perf augmented_raw_syscalls: Do not include stdio.h
      perf trace: Allow specifying a set of events to add in perfconfig
      perf trace: Allow configuring if zeroed syscall args should be printed
      perf trace: Allow configuring if the syscall duration should be printed
      perf config: Show the configuration when no arguments are provided
      perf trace: Allow configuring default for perf_event_attr.inherit
      perf trace: Allow configuring if the syscall start timestamp should be printed
      perf trace: Allow suppressing the syscall argument names
      perf trace: Make the alignment of the syscall args be configurable
      perf trace: Enclose strings with double quotes
      perf trace: Add a prefix member to the strarray class
      perf trace: Allow asking for not suppressing common string prefixes
      perf trace beauty: Print O_RDONLY when (flags & O_ACCMODE) == 0
      perf trace: Add alignment spaces after the closing parens
      perf augmented_raw_syscalls: Copy 'access' arg as well
      perf trace: Enclose the errno strings with ()
      perf trace: Show NULL when syscall pointer args are 0
      tools include arch: Grab a copy of x86's prctl.h
      perf beauty: Add a string table generator for x86's 'arch_prctl' codes
      perf beauty: Wire up the x86_arch prctl code table generator
      perf trace: Move strarrays to beauty.h for further reuse
      perf trace: When showing string prefixes show prefix + ??? for unknown entries
      perf trace beauty: Beautify arch_prctl()'s arguments
      perf beauty mmap: Print PROT_READ before PROT_EXEC to match strace output
      perf beauty mmap: Print mmap's 'offset' arg in hexadecimal
      tools headers uapi: Grab a copy of fadvise.h
      perf beauty: Add generator for fadvise64's 'advice' arg constants
      perf trace: Wire up the fadvise 'advice' table generator
      perf symbols: Relax checks on perf-PID.map ownership
      tools uapi asm: Update asm-generic/unistd.h copy

Ben Hutchings (1):
      perf pmu: Suppress potential format-truncation warning

Davidlohr Bueso (3):
      perf bench: Move HAVE_PTHREAD_ATTR_SETAFFINITY_NP into bench.h
      perf bench: Add epoll parallel epoll_wait benchmark
      perf bench: Add epoll_ctl(2) benchmark

Eric Saint-Etienne (2):
      perf symbols: Fix slowness due to -ffunction-section
      perf map: Remove extra indirection from map__find()

Eugeniy Paltsev (1):
      perf annotate: Introduce basic support for ARC

Florian Fainelli (1):
      perf tests ARM: Disable breakpoint tests 32-bit

Ingo Molnar (7):
      perf: Fix typos in comments
      perf vendor events intel: Fix diverse typos
      tools lib traceevent: Fix diverse typos in comments
      perf tools Documentation: Fix diverse typos
      perf bpf-loader: Fix debugging message typo
      perf tools: Fix diverse comment typos
      tools lib subcmd: Fix a few source code comment typos

Jin Yao (4):
      perf annotate: Compute average IPC and IPC coverage per symbol
      perf annotate: Create a annotate2 flag in struct symbol
      perf report: Display average IPC and IPC coverage per symbol
      perf report: Documentation average IPC and IPC coverage

Jiri Olsa (18):
      perf jvmti: Separate jvmti cmlr check
      perf ordered_events: Rework show_progress for __ordered_events__flush
      perf ordered_events: Add private data member
      perf top: Save and display the lost count stats
      perf top: Move lost events warning to helpline
      perf top: Add processing thread
      perf top: Use cond variable instead of a lock
      perf top: Set the 'session_done' volatile variable when exiting
      perf top: Drop samples which are behind the refresh rate
      perf top: Save and display the drop count stats
      perf top: Display slow reader warning when droping samples
      perf top: Move perf_top__reset_sample_counters() to after counts display
      perf ordered_events: Add ordered_events__flush_time interface
      perf trace: Move event delivery to a new deliver_event() function
      perf ordered_events: Add first_time() method
      perf trace: Add ordered processing
      tools lib traceevent: Use LDFLAGS in the build commands
      perf tools: Link libperf-jvmti.so with LDFLAGS variable

Kan Liang (3):
      perf vendor events: Add stepping in CPUID string for x86
      perf vendor events: Add JSON metrics for Cascadelake server
      perf pmu: Move *_cpuid_str() weak functions to header.c

Leo Yan (8):
      perf cs-etm: Correct packets swapping in cs_etm__flush()
      perf cs-etm: Avoid stale branch samples when flush packet
      perf cs-etm: Remove unused 'trace_on' in cs_etm_decoder
      perf cs-etm: Refactor enumeration cs_etm_sample_type
      perf cs-etm: Rename CS_ETM_TRACE_ON to CS_ETM_DISCONTINUITY
      perf cs-etm: Treat NO_SYNC element as trace discontinuity
      perf cs-etm: Treat EO_TRACE element as trace discontinuity
      perf cs-etm: Generate branch sample for exception packet

Mark Drayton (1):
      perf tools: Allow specifying proc-map-timeout in config file

Masami Hiramatsu (3):
      kprobes: Blacklist symbols in arch-defined prohibited area
      kprobes/x86: Show x86-64 specific blacklisted symbols correctly
      kprobes/x86: Remove unneeded arch_within_kprobe_blacklist from x86

Mathieu Poirier (3):
      perf cs-etm: Add configuration for ETMv3 trace protocol
      perf cs-etm: Add support for ETMv3 trace decoding
      perf cs-etm: Add support for PTMv1.1 decoding

Michael Petlan (2):
      perf tests: Use shebangs in the shell scripts
      perf stat: Avoid segfaults caused by negated options

Milian Wolff (2):
      perf script: Add newline after uregs output
      perf script: Share code and output format for uregs and iregs output

Mukesh Ojha (1):
      perf/core: Declare the __percpu attribute on non-deref types

Pu Wen (1):
      perf tools: Add Hygon Dhyana support

Ravi Bangoria (2):
      perf stat: Use perf_evsel__is_clocki() for clock events
      perf stat: Fix shadow stats for clock events

Robert Walker (1):
      perf cs-etm: Support for ARM A32/T32 instruction sets in CoreSight trace

Sihyeon Jang (2):
      perf beauty mmap_flags: Fixed syntax error Fixed missing ']' error
      perf config: Modify size factor of snprintf

Stephane Eranian (1):
      perf stat: Fix CSV mode column output for non-cgroup events

Steven Rostedt (VMware) (1):
      tools lib traceevent: Fix processing of dereferenced args in bprintk events

Tzvetomir Stoyanov (8):
      tools lib traceevent: Add sanity check to is_timestamp_in_us()
      tools lib traceevent: Implement new API tep_get_ref()
      tools lib traceevent: Added support for pkg-config
      tools lib traceevent: Install trace-seq.h API header file
      tools lib traceevent, perf tools: Rename 'struct tep_event_format' to 'struct tep_event'
      tools lib traceevent: Rename tep_free_format() to tep_free_event()
      perf tools: traceevent API cleanup, remove __tep_data2host*()
      tools lib traceevent: traceevent API cleanup

Wen Yang (1):
      perf bpf: Use ERR_CAST instead of ERR_PTR(PTR_ERR())


 arch/x86/kernel/kprobes/core.c                     |     8 +-
 include/linux/kprobes.h                            |     3 +
 include/linux/perf_event.h                         |     4 +-
 kernel/events/core.c                               |     2 +-
 kernel/events/hw_breakpoint.c                      |     2 +-
 kernel/kprobes.c                                   |    67 +-
 tools/arch/x86/include/uapi/asm/prctl.h            |    17 +
 tools/build/Makefile.feature                       |     7 +-
 tools/build/feature/Makefile                       |    14 +-
 tools/build/feature/test-all.c                     |    10 +
 tools/build/feature/test-eventfd.c                 |     9 +
 tools/build/feature/test-jvmti-cmlr.c              |    11 +
 tools/build/feature/test-jvmti.c                   |     1 -
 tools/build/feature/test-libaio.c                  |    16 +
 tools/build/feature/test-libopencsd.c              |     8 +
 tools/include/linux/err.h                          |    13 +
 tools/include/uapi/asm-generic/unistd.h            |     4 +
 tools/include/uapi/linux/fadvise.h                 |    22 +
 tools/lib/subcmd/Makefile                          |     2 -
 tools/lib/subcmd/parse-options.h                   |     4 +-
 tools/lib/traceevent/Makefile                      |    31 +-
 tools/lib/traceevent/event-parse-api.c             |     8 +-
 tools/lib/traceevent/event-parse-local.h           |    13 +-
 tools/lib/traceevent/event-parse.c                 |   235 +-
 tools/lib/traceevent/event-parse.h                 |    77 +-
 tools/lib/traceevent/libtraceevent.pc.template     |    10 +
 tools/lib/traceevent/parse-filter.c                |    42 +-
 tools/lib/traceevent/plugin_function.c             |     2 +-
 tools/lib/traceevent/plugin_hrtimer.c              |     4 +-
 tools/lib/traceevent/plugin_kmem.c                 |     2 +-
 tools/lib/traceevent/plugin_kvm.c                  |    16 +-
 tools/lib/traceevent/plugin_mac80211.c             |     4 +-
 tools/lib/traceevent/plugin_sched_switch.c         |     4 +-
 tools/perf/Documentation/perf-bench.txt            |    10 +
 tools/perf/Documentation/perf-config.txt           |    38 +
 tools/perf/Documentation/perf-list.txt             |     2 +-
 tools/perf/Documentation/perf-record.txt           |     5 +
 tools/perf/Documentation/perf-report.txt           |    10 +-
 tools/perf/Documentation/perf-script.txt           |     2 +-
 tools/perf/Documentation/perf-stat.txt             |     4 +-
 tools/perf/Documentation/perf-top.txt              |     3 +
 tools/perf/Documentation/perf-trace.txt            |     6 +
 tools/perf/Makefile.config                         |    22 +-
 tools/perf/Makefile.perf                           |    39 +-
 tools/perf/arch/arc/annotate/instructions.c        |     9 +
 tools/perf/arch/common.c                           |    21 +-
 tools/perf/arch/common.h                           |     1 +
 tools/perf/arch/x86/tests/insn-x86.c               |     2 +-
 tools/perf/arch/x86/util/header.c                  |    66 +-
 tools/perf/arch/x86/util/intel-pt.c                |    11 +
 tools/perf/arch/x86/util/kvm-stat.c                |     2 +-
 tools/perf/bench/Build                             |     3 +
 tools/perf/bench/bench.h                           |    14 +
 tools/perf/bench/epoll-ctl.c                       |   413 +
 tools/perf/bench/epoll-wait.c                      |   540 +
 tools/perf/bench/futex.h                           |    12 -
 tools/perf/builtin-bench.c                         |    13 +
 tools/perf/builtin-config.c                        |     7 +-
 tools/perf/builtin-help.c                          |     2 +-
 tools/perf/builtin-kvm.c                           |     6 +-
 tools/perf/builtin-record.c                        |   263 +-
 tools/perf/builtin-report.c                        |    26 +-
 tools/perf/builtin-script.c                        |    97 +-
 tools/perf/builtin-stat.c                          |     8 +-
 tools/perf/builtin-timechart.c                     |     4 +
 tools/perf/builtin-top.c                           |   289 +-
 tools/perf/builtin-trace.c                         |   525 +-
 tools/perf/check-headers.sh                        |     2 +
 tools/perf/examples/bpf/augmented_raw_syscalls.c   |    41 +-
 tools/perf/include/bpf/bpf.h                       |    21 +
 tools/perf/include/bpf/pid_filter.h                |    21 +
 tools/perf/include/bpf/stdio.h                     |     3 -
 tools/perf/include/bpf/unistd.h                    |    10 +
 tools/perf/jvmti/libjvmti.c                        |    12 +
 tools/perf/perf.h                                  |     2 +-
 .../perf/pmu-events/arch/x86/broadwell/cache.json  |     4 +-
 .../pmu-events/arch/x86/broadwell/pipeline.json    |     2 +-
 .../pmu-events/arch/x86/broadwellde/cache.json     |     4 +-
 .../pmu-events/arch/x86/broadwellde/pipeline.json  |     2 +-
 .../perf/pmu-events/arch/x86/broadwellx/cache.json |     4 +-
 .../pmu-events/arch/x86/broadwellx/pipeline.json   |     2 +-
 .../pmu-events/arch/x86/cascadelakex/cache.json    | 10172 +++++++++++++++++++
 .../arch/x86/cascadelakex/clx-metrics.json         |   164 +
 .../arch/x86/cascadelakex/floating-point.json      |    85 +
 .../pmu-events/arch/x86/cascadelakex/frontend.json |   482 +
 .../pmu-events/arch/x86/cascadelakex/memory.json   |  9909 ++++++++++++++++++
 .../pmu-events/arch/x86/cascadelakex/other.json    |  8908 ++++++++++++++++
 .../pmu-events/arch/x86/cascadelakex/pipeline.json |   969 ++
 .../arch/x86/cascadelakex/uncore-memory.json       |   117 +
 .../arch/x86/cascadelakex/uncore-other.json        |   255 +
 .../arch/x86/cascadelakex/virtual-memory.json      |   285 +
 tools/perf/pmu-events/arch/x86/jaketown/cache.json |     4 +-
 .../pmu-events/arch/x86/jaketown/pipeline.json     |     2 +-
 .../pmu-events/arch/x86/knightslanding/cache.json  |    30 +-
 tools/perf/pmu-events/arch/x86/mapfile.csv         |     3 +-
 .../pmu-events/arch/x86/sandybridge/cache.json     |     4 +-
 .../pmu-events/arch/x86/sandybridge/pipeline.json  |     2 +-
 .../pmu-events/arch/x86/skylake/skl-metrics.json   |     2 +-
 .../pmu-events/arch/x86/skylakex/skx-metrics.json  |     2 +-
 .../pmu-events/arch/x86/skylakex/uncore-other.json |    12 +-
 tools/perf/tests/attr.c                            |     2 +-
 tools/perf/tests/attr.py                           |     2 +-
 tools/perf/tests/bp_signal.c                       |    20 +-
 tools/perf/tests/builtin-test.c                    |     3 +
 tools/perf/tests/code-reading.c                    |     2 +-
 tools/perf/tests/dwarf-unwind.c                    |     2 +-
 tools/perf/tests/mmap-thread-lookup.c              |     4 +-
 tools/perf/tests/perf-record.c                     |     7 +-
 tools/perf/tests/shell/probe_vfs_getname.sh        |     1 +
 .../tests/shell/record+probe_libc_inet_pton.sh     |     1 +
 .../tests/shell/record+script_probe_vfs_getname.sh |     1 +
 tools/perf/tests/shell/trace+probe_vfs_getname.sh  |     1 +
 tools/perf/trace/beauty/Build                      |     2 +
 tools/perf/trace/beauty/arch_prctl.c               |    33 +
 tools/perf/trace/beauty/beauty.h                   |    36 +-
 tools/perf/trace/beauty/clone.c                    |     7 +-
 tools/perf/trace/beauty/eventfd.c                  |     4 +-
 tools/perf/trace/beauty/fadvise.sh                 |    22 +
 tools/perf/trace/beauty/fcntl.c                    |    22 +-
 tools/perf/trace/beauty/flock.c                    |     4 +-
 tools/perf/trace/beauty/futex_op.c                 |     8 +-
 tools/perf/trace/beauty/futex_val3.c               |     3 +-
 tools/perf/trace/beauty/ioctl.c                    |    31 +-
 tools/perf/trace/beauty/kcmp.c                     |     8 +-
 tools/perf/trace/beauty/mmap.c                     |    22 +-
 tools/perf/trace/beauty/mmap_flags.sh              |     4 +-
 tools/perf/trace/beauty/mode_t.c                   |     4 +-
 tools/perf/trace/beauty/mount_flags.c              |     8 +-
 tools/perf/trace/beauty/msg_flags.c                |     4 +-
 tools/perf/trace/beauty/open_flags.c               |    13 +-
 tools/perf/trace/beauty/perf_event_open.c          |     4 +-
 tools/perf/trace/beauty/pkey_alloc.c               |    14 +-
 tools/perf/trace/beauty/prctl.c                    |    16 +-
 tools/perf/trace/beauty/rename_flags.sh            |    15 +
 tools/perf/trace/beauty/renameat.c                 |    19 +
 tools/perf/trace/beauty/sched_policy.c             |     6 +-
 tools/perf/trace/beauty/seccomp.c                  |     8 +-
 tools/perf/trace/beauty/signum.c                   |     4 +-
 tools/perf/trace/beauty/sockaddr.c                 |     4 +-
 tools/perf/trace/beauty/socket.c                   |     8 +-
 tools/perf/trace/beauty/socket_type.c              |     4 +-
 tools/perf/trace/beauty/statx.c                    |    10 +-
 tools/perf/trace/beauty/waitid_options.c           |     4 +-
 tools/perf/trace/beauty/x86_arch_prctl.sh          |    26 +
 tools/perf/ui/browsers/hists.c                     |    11 +
 tools/perf/ui/tui/helpline.c                       |     2 +-
 tools/perf/util/Build                              |     1 +
 tools/perf/util/annotate.c                         |    49 +-
 tools/perf/util/annotate.h                         |     5 +
 tools/perf/util/auxtrace.c                         |    11 +-
 tools/perf/util/bpf-loader.c                       |     4 +-
 tools/perf/util/config.c                           |     8 +-
 tools/perf/util/cs-etm-decoder/cs-etm-decoder.c    |   102 +-
 tools/perf/util/cs-etm-decoder/cs-etm-decoder.h    |    29 +-
 tools/perf/util/cs-etm.c                           |   216 +-
 tools/perf/util/dso.c                              |     8 +-
 tools/perf/util/dso.h                              |     1 +
 tools/perf/util/env.c                              |     2 +-
 tools/perf/util/event.c                            |    61 +-
 tools/perf/util/event.h                            |     8 +-
 tools/perf/util/evlist.c                           |    20 +-
 tools/perf/util/evlist.h                           |     8 +-
 tools/perf/util/evsel.h                            |     4 +-
 tools/perf/util/evsel_fprintf.c                    |     1 +
 tools/perf/util/header.c                           |    51 +-
 tools/perf/util/hist.c                             |     2 +-
 tools/perf/util/hist.h                             |     1 +
 tools/perf/util/jitdump.c                          |     2 +-
 tools/perf/util/machine.c                          |    33 +-
 tools/perf/util/machine.h                          |     6 +-
 tools/perf/util/map.c                              |    89 +-
 tools/perf/util/map.h                              |    18 +
 tools/perf/util/mmap.c                             |   152 +-
 tools/perf/util/mmap.h                             |    26 +-
 tools/perf/util/ordered-events.c                   |    44 +-
 tools/perf/util/ordered-events.h                   |     8 +-
 tools/perf/util/parse-events.c                     |     2 +-
 tools/perf/util/pmu.c                              |    47 +-
 tools/perf/util/probe-event.c                      |     4 +-
 tools/perf/util/probe-file.c                       |     2 +-
 tools/perf/util/python.c                           |     4 +-
 tools/perf/util/s390-cpumsf.c                      |     2 +-
 .../perf/util/scripting-engines/trace-event-perl.c |     6 +-
 .../util/scripting-engines/trace-event-python.c    |    24 +-
 tools/perf/util/session.c                          |     7 +-
 tools/perf/util/sort.c                             |    63 +-
 tools/perf/util/sort.h                             |     2 +
 tools/perf/util/srccode.c                          |   186 +
 tools/perf/util/srccode.h                          |     7 +
 tools/perf/util/srcline.c                          |    28 +
 tools/perf/util/srcline.h                          |     1 +
 tools/perf/util/stat-display.c                     |    16 +-
 tools/perf/util/stat-shadow.c                      |     6 +-
 tools/perf/util/svghelper.c                        |     2 +-
 tools/perf/util/symbol.c                           |    26 +-
 tools/perf/util/symbol.h                           |     1 +
 tools/perf/util/thread.c                           |     2 +
 tools/perf/util/thread.h                           |     6 +
 tools/perf/util/top.c                              |     8 +-
 tools/perf/util/top.h                              |    10 +-
 tools/perf/util/trace-event-parse.c                |    16 +-
 tools/perf/util/trace-event-read.c                 |     4 +-
 tools/perf/util/trace-event.c                      |     8 +-
 tools/perf/util/trace-event.h                      |    16 +-
 204 files changed, 35652 insertions(+), 944 deletions(-)
 create mode 100644 tools/arch/x86/include/uapi/asm/prctl.h
 create mode 100644 tools/build/feature/test-eventfd.c
 create mode 100644 tools/build/feature/test-jvmti-cmlr.c
 create mode 100644 tools/build/feature/test-libaio.c
 create mode 100644 tools/include/uapi/linux/fadvise.h
 create mode 100644 tools/lib/traceevent/libtraceevent.pc.template
 create mode 100644 tools/perf/arch/arc/annotate/instructions.c
 create mode 100644 tools/perf/bench/epoll-ctl.c
 create mode 100644 tools/perf/bench/epoll-wait.c
 create mode 100644 tools/perf/include/bpf/pid_filter.h
 create mode 100644 tools/perf/include/bpf/unistd.h
 create mode 100644 tools/perf/pmu-events/arch/x86/cascadelakex/cache.json
 create mode 100644 tools/perf/pmu-events/arch/x86/cascadelakex/clx-metrics.json
 create mode 100644 tools/perf/pmu-events/arch/x86/cascadelakex/floating-point.json
 create mode 100644 tools/perf/pmu-events/arch/x86/cascadelakex/frontend.json
 create mode 100644 tools/perf/pmu-events/arch/x86/cascadelakex/memory.json
 create mode 100644 tools/perf/pmu-events/arch/x86/cascadelakex/other.json
 create mode 100644 tools/perf/pmu-events/arch/x86/cascadelakex/pipeline.json
 create mode 100644 tools/perf/pmu-events/arch/x86/cascadelakex/uncore-memory.json
 create mode 100644 tools/perf/pmu-events/arch/x86/cascadelakex/uncore-other.json
 create mode 100644 tools/perf/pmu-events/arch/x86/cascadelakex/virtual-memory.json
 create mode 100644 tools/perf/trace/beauty/arch_prctl.c
 create mode 100755 tools/perf/trace/beauty/fadvise.sh
 create mode 100755 tools/perf/trace/beauty/rename_flags.sh
 create mode 100644 tools/perf/trace/beauty/renameat.c
 create mode 100755 tools/perf/trace/beauty/x86_arch_prctl.sh
 create mode 100644 tools/perf/util/srccode.c
 create mode 100644 tools/perf/util/srccode.h
