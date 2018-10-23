Return-Path: <SRS0=vsD1=ND=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.4 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FSL_HELO_FAKE,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 547EAC46475
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Oct 2018 10:52:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EDCA120665
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Oct 2018 10:52:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qYgti+AP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EDCA120665
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727999AbeJWTPe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Oct 2018 15:15:34 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:51444 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726970AbeJWTPe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Oct 2018 15:15:34 -0400
Received: by mail-wm1-f66.google.com with SMTP id 143-v6so1263642wmf.1
        for <linux-kernel@vger.kernel.org>; Tue, 23 Oct 2018 03:52:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:content-transfer-encoding:user-agent;
        bh=eEGtAQMQwGNps/bdCoOOpveJURou8ezDEfaVqHffoCI=;
        b=qYgti+APPYBCBgct5JnNW5sveMe3saBzL4rtsqb41BJrS01WBFfO0JTKex3x64jQ+G
         kIQQSsElMx4qRwdUx+atl6cgB4wIPwzG8uG6toCT5BgiUr6/j11Mi3gBkvkrKVaVXZP+
         2addN7Q9E9uBEJvCcpoQOGvB4veNpbD/eTzTethEPbHyOrIJCw9FVYVzs5aenTA5Bhue
         XvC0/hQw5xRUIvuIXZDjdfhwzL5kGfJXk5uHzqQUi3nZhQEjwzGgU66aToHnAa1Httb+
         0yPZb6hLUi9AhKCp5co2isC+m/kXZk6Y6q3JJMY9BI8yIe/cjL2vDB28WOhLlD5W4Z7a
         bkxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mime-version:content-disposition:content-transfer-encoding
         :user-agent;
        bh=eEGtAQMQwGNps/bdCoOOpveJURou8ezDEfaVqHffoCI=;
        b=CiNQzLe7qJ2LnftS1dsXZEXZ1+92Zf957/X/lISz0cmp3YDwEJQwlIUHUWr8RaK33D
         5CICg14WKEFjB/y7s6u0bl4dIy02+rDz9vPakmoNyw7yLLnqrFK1uf0ds4TL00uq1wKz
         AjaXpzSctUb8oy1keIAWp2OfClNDj+r6WC5E/yyT9oUP7ITTr0U5Y9CSVgmNHauPA8IF
         y5cW1PwaXcXeJMbpTWP0kdyNolk4o8zjpukI5EAxdMLAX4AwsKlLseJECKcaIy43GzN0
         zTMtKCwTqOA0ZTr1pZcMHg10J2BZJcW5DB4cR+BKXEOj+YHfwMjDa0LpKpVeCG39Ki4B
         y0Tg==
X-Gm-Message-State: ABuFfojKU51Am8FVEbfFmjM3xjkNqu/0QDCm9bVT11pFqhe1H1hFm/hd
        2JUQ/QB+KSxI1T/2XpTVzno=
X-Google-Smtp-Source: ACcGV60rVndWEIeMpFU9HfWNChVvY7l/o4RFYNoYPMe+MM6aLWqQG72Pdz/z39oQTYinzXx0fDMYiw==
X-Received: by 2002:a1c:1694:: with SMTP id 142-v6mr20187674wmw.113.1540291956275;
        Tue, 23 Oct 2018 03:52:36 -0700 (PDT)
Received: from gmail.com (2E8B0CD5.catv.pool.telekom.hu. [46.139.12.213])
        by smtp.gmail.com with ESMTPSA id v1-v6sm1525416wrd.24.2018.10.23.03.52.35
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 23 Oct 2018 03:52:35 -0700 (PDT)
Date:   Tue, 23 Oct 2018 12:52:33 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@infradead.org>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jiri Olsa <jolsa@redhat.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [GIT PULL] perf updates for v4.20
Message-ID: <20181023105233.GA57147@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

Please pull the latest perf-core-for-linus git tree from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git perf-core-for-linus

   # HEAD: dda93b45389f025fd3422d22cc31cc1ea6040305 Merge branch 'x86/cache' into perf/core, to pick up fixes

The main updates in this cycle were:

 - Lots of perf tooling changes too voluminous to list (big perf trace 
   and perf stat improvements, lots of libtraceevent reorganization, 
   etc.), so I'll list the authors and refer to the changelog for 
   details:

     Benjamin Peterson, Jérémie Galarneau, Kim Phillips, Peter Zijlstra,
     Ravi Bangoria, Sangwon Hong, Sean V Kelley, Steven Rostedt,
     Thomas Gleixner, Ding Xiang, Eduardo Habkost,
     Thomas Richter, Andi Kleen, Sanskriti Sharma, Adrian Hunter,
     Tzvetomir Stoyanov, Arnaldo Carvalho de Melo, Jiri Olsa.

   ... with the bulk of the changes written by Jiri Olsa, Tzvetomir 
   Stoyanov and Arnaldo Carvalho de Melo.

 - Continued intel_rdt work with a focus on playing well with perf 
   events. This also imported some non-perf RDT work due to dependencies.
   (Reinette Chatre)

 - Implement counter freezing for Arch Perfmon v4 (Skylake and
   newer). This allows to speed up the PMI handler by avoiding 
   unnecessary MSR writes and make it more accurate. (Andi Kleen)

 - kprobes cleanups and simplification (Masami Hiramatsu)

 - Intel Goldmont PMU updates (Kan Liang)

 - ... plus misc other fixes and updates.

 Thanks,

	Ingo

------------------>
Adrian Hunter (8):
      perf script: Enhance sample flags for trace begin / end
      perf db-export: Add trace begin / end branch type variants
      perf tools: Improve thread_stack__event() for trace begin / end
      perf tools: Improve thread_stack__process() for trace begin / end
      perf intel-pt: Add decoder flags for trace begin / end
      perf intel-pt: Implement decoder flags for trace begin / end
      perf script python: Fix export-to-postgresql.py occasional failure
      perf script python: Fix export-to-sqlite.py sample columns

Alexander Shishkin (1):
      perf: Suppress AUX/OVERWRITE records

Andi Kleen (5):
      perf tools: Report itrace options in help
      tools lib subcmd: Support overwriting the pager
      perf script: Allow sym and dso without ip, addr
      perf script: Print DSO for callindent
      perf/x86/intel: Add a separate Arch Perfmon v4 PMI handler

Andy Shevchenko (1):
      x86/intel_rdt: Switch to bitmap_zalloc()

Arnaldo Carvalho de Melo (34):
      perf trace: Pass augmented args to the arg formatters when available
      perf trace: Make the augmented_syscalls filter out the tracepoint event
      perf trace: Print the syscall name for augmented_syscalls
      perf trace: Extract the comm/tid printing for syscall enter
      perf trace: Show comm/tid for augmented_syscalls
      perf trace: Use the augmented filename, expanding syscall enter pointers
      perf trace: Augment the 'open' syscall 'filename' arg
      perf trace: Augment inotify_add_watch pathname syscall arg
      perf trace: Introduce augmented_filename_syscall_enter() declarator
      perf trace: Augment 'newstat' (aka 'stat') filename ptr
      perf trace: Add a etcsnoop.c augmented syscalls eBPF utility
      perf bpf: Give precedence to bpf header dir
      perf bpf: Add linux/socket.h to the headers accessible to bpf proggies
      perf trace augmented_syscalls: Augment connect's 'sockaddr' arg
      perf trace augmented_syscalls: Add augmented_sockaddr_syscall_enter()
      perf trace augmented_syscalls: Augment bind's 'myaddr' sockaddr arg
      perf trace augmented_syscalls: Augment sendto's 'addr' arg
      perf trace beauty: Reorganize 'struct sockaddr *' beautifier
      perf bpf: Add syscall_exit() helper
      perf augmented_syscalls: Update the header comments
      perf trace augmented_syscalls: Rename augmented_*_syscall__enter to just *_syscall
      perf trace augmented_syscalls: Hook into syscalls:sys_exit_SYSCALL too
      perf trace: Show comm and tid for tracepoint events
      perf augmented_syscalls: Check probe_read_str() return separately
      perf augmented_syscalls: Avoid optimization to pass older BPF validators
      perf trace: Introduce syscall__augmented_args() method
      perf trace: Setup augmented_args in the raw_syscalls:sys_enter handler
      perf trace: Use the raw_syscalls:sys_enter for the augmented syscalls
      perf map: Turn some pr_warning() to pr_debug()
      perf tests: Fix record+probe_libc_inet_pton.sh without ping's debuginfo
      perf python: Use -Wno-redundant-decls to build with PYTHON=python3
      perf python: Use -Wno-redundant-decls to build with PYTHON=python3
      tools include: Adopt linux/bits.h
      perf auxtrace: Include missing asm/bitsperlong.h to get BITS_PER_LONG

Benjamin Peterson (1):
      perf trace beauty: Alias 'umount' to 'umount2'

Ding Xiang (2):
      tools include: Adopt PTR_ERR_OR_ZERO from the kernel err.h header
      perf bpf-loader: use PTR_ERR_OR_ZERO inetead of return code

Eduardo Habkost (2):
      perf python: Make clang_has_option() work on Python 3
      perf python: More portable way to make CFLAGS work with clang

Jiri Olsa (51):
      perf stat: Use evsel->threads in create_perf_stat_counter()
      perf stat: Move 'initial_delay' to 'struct perf_stat_config'
      perf stat: Move 'no_inherit' to 'struct perf_stat_config'
      perf stat: Use local config arg for scale in create_perf_stat_counter()
      perf stat: Add 'identifier' flag to 'struct perf_stat_config'
      perf tools: Switch 'session' argument to 'evlist' in perf_event__synthesize_attrs()
      perf evsel: Introduce perf_evsel__store_ids()
      perf stat: Move create_perf_stat_counter() to stat.c
      perf stat: Rename 'is_pipe' argument to 'attrs' in perf_stat_synthesize_config()
      perf stat: Add 'struct perf_stat_config' argument to perf_stat_synthesize_config()
      perf stat: Add 'struct perf_tool' argument to perf_stat_synthesize_config()
      perf stat: Add 'struct perf_evlist' argument to perf_stat_synthesize_config()
      perf stat: Add 'perf_event__handler_t' argument to perf_stat_synthesize_config()
      perf stat: Move perf_stat_synthesize_config() to stat.c
      perf stat: Introduce perf_evlist__print_counters()
      perf stat: Move STAT_RECORD out of perf_evlist__print_counters()
      perf stat: Add 'struct perf_stat_config' argument to perf_evlist__print_counters()
      perf stat: Pass 'struct perf_stat_config' argument to local print functions
      perf stat: Pass a 'struct perf_stat_config' argument to global print functions
      perf stat: Move csv_* to 'struct perf_stat_config'
      perf stat: Move 'interval_clear' to 'struct perf_stat_config'
      perf stat: Move 'metric_only' to 'struct perf_stat_config'
      perf stat: Move 'unit_width' to 'struct perf_stat_config'
      perf stat: Add 'target' argument to perf_evlist__print_counters()
      perf stat: Pass 'evlist' argument to print functions
      perf stat: Use 'evsel->evlist' instead of 'evsel_list' in collect_all_aliases()
      perf stat: Move 'run_count' to 'struct perf_stat_config'
      perf stat: Move 'metric_only_len' to 'struct perf_stat_config'
      perf stat: Pass 'struct perf_stat_config' to first_shadow_cpu()
      perf stat: Pass 'evlist' to aggr_update_shadow()
      perf stat: Add 'walltime_nsecs_stats' pointer to 'struct perf_stat_config'
      perf stat: Move 'null_run' to 'struct perf_stat_config'
      perf stat: Move 'print_free_counters_hint' to 'struct perf_stat_config'
      perf stat: Move 'print_mixed_hw_group_error' to 'struct perf_stat_config'
      perf stat: Move ru_* data to 'struct perf_stat_config'
      perf stat: Move *_aggr_* data to 'struct perf_stat_config'
      perf stat: Do not use the global 'evsel_list' in print functions
      perf stat: Move 'big_num' data to 'struct perf_stat_config'
      perf stat: Move 'no_merge' data to 'struct perf_stat_config'
      perf stat: Propagate 'struct target' arg to sort_aggr_thread()
      perf stat: Move 'walltime_*' data to 'struct perf_stat_config'
      perf stat: Move 'metric_events' to 'struct perf_stat_config'
      perf stat: Move the display functions to stat-display.c
      perf ordered_events: Add 'struct ordered_events_buffer' layer
      perf ordered_events: Prevent crossing max_alloc_size
      perf tools: Remove perf_tool from event_op2
      perf tools: Remove perf_tool from event_op3
      perf auxtrace: Pass struct perf_mmap into mmap__read* functions
      perf tools: Add 'struct perf_mmap' arg to record__write()
      perf util: Make copyfile_offset() global
      perf/x86/intel: Export mem events only if there's PEBS support

Jithu Joseph (1):
      x86/intel_rdt: Prevent pseudo-locking from using stale pointers

Jérémie Galarneau (1):
      perf tools: Initialize perf_data_file fd field

Kan Liang (2):
      perf/x86/intel: Factor out common code of PMI handler
      perf/x86/intel: Add quirk for Goldmont Plus

Kim Phillips (1):
      perf annotate: Handle arm64 move instructions

Masami Hiramatsu (6):
      kprobes: Remove pointless BUG_ON() from disarming process
      kprobes: Remove pointless BUG_ON() from add_new_kprobe()
      kprobes: Remove pointless BUG_ON() from reuse_unused_kprobe()
      kprobes: Return error if we fail to reuse kprobe instead of BUG_ON()
      kprobes: Don't call BUG_ON() if there is a kprobe in use on free list
      kprobes/x86: Use preempt_enable() in optimized_callback()

Milian Wolff (2):
      perf report: Don't try to map ip to invalid map
      perf record: Use unmapped IP for inline callchain cursors

Peter Zijlstra (1):
      x86/cpu: Sanitize FAM6_ATOM naming

Ravi Bangoria (1):
      perf test: Add watchpoint test

Reinette Chatre (8):
      perf/x86: Add helper to obtain performance counter index
      x86/intel_rdt: Remove local register variables
      x86/intel_rdt: Create required perf event attributes
      x86/intel_rdt: Use perf infrastructure for measurements
      x86/intel_rdt: Re-enable pseudo-lock measurements
      x86/intel_rdt: Introduce utility to obtain CDP peer
      x86/intel_rdt: CBM overlap should also check for overlap with CDP peer
      x86/intel_rdt: Fix initial allocation to consider CDP

Sangwon Hong (1):
      perf help: Add missing subcommand `version`

Sanskriti Sharma (5):
      perf strbuf: Match va_{add,copy} with va_end
      perf tools: Cleanup trace-event-info 'tdata' leak
      perf tools: Free 'printk' string in parse_ftrace_printk()
      perf tools: Avoid double free in read_event_file()
      perf tools: Free temporary 'sys' string in read_event_files()

Sean V Kelley (1):
      perf vendor events arm64: Revise core JSON events for eMAG

Steven Rostedt (VMware) (2):
      tools lib traceevent: Separate out tep_strerror() for strerror_r() issues
      kprobes, x86/ptrace.h: Make regs_get_kernel_stack_nth() not fault on bad stack

Thomas Richter (2):
      perf report: Create auxiliary trace data files for s390
      perf test: S390 does not support watchpoints in test 22

Tzvetomir Stoyanov (1):
      tools lib traceevent, perf tools: Move struct tep_handler definition in a local header file

Tzvetomir Stoyanov (VMware) (16):
      tools lib traceevent, perf tools: Split trace-seq related APIs in a separate header file
      tools lib traceevent, perf tools: Rename struct event_format to struct tep_event_format
      tools lib traceevent, perf tools: Rename struct format{_field} to struct tep_format{_field}
      tools lib traceevent, perf tools: Rename enum format_flags to enum tep_format_flags
      tools lib traceevent: Rename enum event_{sort_}type to enum tep_event_{sort_}type
      tools lib traceevent: Add prefix TEP_ to all EVENT_FL_* flags
      tools lib traceevent, perf tools: Add prefix tep_ to all print_* structures
      tools lib traceevent, perf tools: Rename enum print_arg_type to enum tep_print_arg_type
      tools lib traceevent: Add prefix tep_ to enums filter_{boolean,op,cmp}_type
      tools lib traceevent: Add prefix tep_ to enums filter_{exp,arg}_type
      tools lib traceevent: Add prefix tep_ to struct filter_{arg,value_type}
      tools lib traceevent: Add prefix tep_ to various structs filter_arg_*.
      tools lib traceevent: Add prefix tep_ to structs filter_type and event_filter
      tools lib traceevent: Rename struct plugin_list to struct tep_plugin_list
      tools lib traceevent: Rename data2host*() APIs
      tools lib traceevent: Add prefix tep_ to enum filter_trivial_type

Xiaochen Shen (1):
      x86/intel_rdt: Show missing resctrl mount options

YueHaibing (1):
      x86/cpu: Drop pointless static qualifier in punit_dev_state_show()

Zubin Mithra (2):
      perf/x86: Add __ro_after_init annotations
      perf/x86/intel/pt: Annotate 'pt_cap_group' with __ro_after_init


 Documentation/admin-guide/kernel-parameters.txt    |    5 +
 Documentation/x86/intel_rdt_ui.txt                 |   22 +-
 arch/x86/events/core.c                             |   37 +-
 arch/x86/events/intel/core.c                       |  346 ++++-
 arch/x86/events/intel/cstate.c                     |    8 +-
 arch/x86/events/intel/pt.c                         |    2 +-
 arch/x86/events/intel/rapl.c                       |    4 +-
 arch/x86/events/msr.c                              |    8 +-
 arch/x86/events/perf_event.h                       |    4 +-
 arch/x86/include/asm/intel-family.h                |   33 +-
 arch/x86/include/asm/msr-index.h                   |    1 +
 arch/x86/include/asm/perf_event.h                  |    1 +
 arch/x86/include/asm/ptrace.h                      |   42 +-
 arch/x86/kernel/cpu/common.c                       |   28 +-
 arch/x86/kernel/cpu/intel_rdt.c                    |   17 +-
 arch/x86/kernel/cpu/intel_rdt_ctrlmondata.c        |   12 +-
 arch/x86/kernel/cpu/intel_rdt_pseudo_lock.c        |  385 +++---
 arch/x86/kernel/cpu/intel_rdt_rdtgroup.c           |  176 ++-
 arch/x86/kernel/kprobes/opt.c                      |    2 +-
 arch/x86/kernel/tsc.c                              |    2 +-
 arch/x86/kernel/tsc_msr.c                          |   10 +-
 arch/x86/platform/atom/punit_atom_debug.c          |    6 +-
 .../platform/intel-mid/device_libs/platform_bt.c   |    2 +-
 drivers/acpi/acpi_lpss.c                           |    2 +-
 drivers/acpi/x86/utils.c                           |    2 +-
 drivers/cpufreq/intel_pstate.c                     |    4 +-
 drivers/edac/pnd2_edac.c                           |    2 +-
 drivers/idle/intel_idle.c                          |   18 +-
 drivers/mmc/host/sdhci-acpi.c                      |    2 +-
 drivers/pci/pci-mid.c                              |    4 +-
 drivers/platform/x86/intel_int0002_vgpio.c         |    2 +-
 drivers/platform/x86/intel_mid_powerbtn.c          |    4 +-
 drivers/platform/x86/intel_telemetry_debugfs.c     |    2 +-
 drivers/platform/x86/intel_telemetry_pltdrv.c      |    2 +-
 drivers/powercap/intel_rapl.c                      |   10 +-
 drivers/thermal/intel_soc_dts_thermal.c            |    2 +-
 kernel/events/ring_buffer.c                        |   14 +-
 kernel/kprobes.c                                   |   39 +-
 sound/soc/intel/boards/bytcr_rt5651.c              |    2 +-
 tools/include/linux/bitops.h                       |    7 +-
 tools/include/linux/bits.h                         |   26 +
 tools/include/linux/err.h                          |    7 +
 tools/lib/subcmd/pager.c                           |   11 +-
 tools/lib/subcmd/pager.h                           |    1 +
 tools/lib/traceevent/Build                         |    2 +
 tools/lib/traceevent/event-parse-api.c             |  275 ++++
 tools/lib/traceevent/event-parse-local.h           |   92 ++
 tools/lib/traceevent/event-parse.c                 | 1217 ++++++++--------
 tools/lib/traceevent/event-parse.h                 |  782 ++++-------
 tools/lib/traceevent/event-plugin.c                |   20 +-
 tools/lib/traceevent/parse-filter.c                |  647 ++++-----
 tools/lib/traceevent/plugin_function.c             |    3 +-
 tools/lib/traceevent/plugin_hrtimer.c              |    5 +-
 tools/lib/traceevent/plugin_jbd2.c                 |    1 +
 tools/lib/traceevent/plugin_kmem.c                 |    5 +-
 tools/lib/traceevent/plugin_kvm.c                  |   15 +-
 tools/lib/traceevent/plugin_mac80211.c             |    7 +-
 tools/lib/traceevent/plugin_sched_switch.c         |   11 +-
 tools/lib/traceevent/plugin_scsi.c                 |    1 +
 tools/lib/traceevent/plugin_xen.c                  |    1 +
 tools/lib/traceevent/tep_strerror.c                |   53 +
 tools/lib/traceevent/trace-seq.c                   |    2 +
 tools/lib/traceevent/trace-seq.h                   |   55 +
 tools/perf/Makefile.perf                           |    4 +-
 tools/perf/arch/arm64/annotate/instructions.c      |   59 +-
 tools/perf/arch/s390/annotate/instructions.c       |    2 -
 tools/perf/builtin-annotate.c                      |    7 +-
 tools/perf/builtin-inject.c                        |   40 +-
 tools/perf/builtin-record.c                        |   53 +-
 tools/perf/builtin-report.c                        |   11 +-
 tools/perf/builtin-script.c                        |  110 +-
 tools/perf/builtin-stat.c                          | 1463 ++------------------
 tools/perf/builtin-trace.c                         |  179 ++-
 tools/perf/check-headers.sh                        |    1 +
 tools/perf/command-list.txt                        |    1 +
 tools/perf/examples/bpf/augmented_syscalls.c       |  154 ++-
 tools/perf/examples/bpf/etcsnoop.c                 |   80 ++
 tools/perf/include/bpf/bpf.h                       |    3 +
 tools/perf/include/bpf/linux/socket.h              |   24 +
 .../pmu-events/arch/arm64/ampere/emag/branch.json  |   23 +
 .../pmu-events/arch/arm64/ampere/emag/bus.json     |   26 +
 .../pmu-events/arch/arm64/ampere/emag/cache.json   |  191 +++
 .../pmu-events/arch/arm64/ampere/emag/clock.json   |   20 +
 .../arch/arm64/ampere/emag/core-imp-def.json       |   32 -
 .../arch/arm64/ampere/emag/exception.json          |   50 +
 .../arch/arm64/ampere/emag/instruction.json        |   89 ++
 .../arch/arm64/ampere/emag/intrinsic.json          |   14 +
 .../pmu-events/arch/arm64/ampere/emag/memory.json  |   29 +
 .../arch/arm64/ampere/emag/pipeline.json           |   50 +
 tools/perf/scripts/python/export-to-postgresql.py  |    9 +
 tools/perf/scripts/python/export-to-sqlite.py      |    6 +-
 tools/perf/tests/Build                             |    1 +
 tools/perf/tests/builtin-test.c                    |   10 +
 tools/perf/tests/evsel-tp-sched.c                  |    4 +-
 .../tests/shell/record+probe_libc_inet_pton.sh     |    2 +-
 tools/perf/tests/tests.h                           |    4 +
 tools/perf/tests/wp.c                              |  241 ++++
 tools/perf/trace/beauty/Build                      |    1 +
 tools/perf/trace/beauty/beauty.h                   |   34 +
 tools/perf/trace/beauty/sockaddr.c                 |   76 +
 tools/perf/util/Build                              |    1 +
 tools/perf/util/auxtrace.c                         |   30 +-
 tools/perf/util/auxtrace.h                         |   41 +-
 tools/perf/util/bpf-loader.c                       |    2 +-
 tools/perf/util/data-convert-bt.c                  |   58 +-
 tools/perf/util/db-export.c                        |   22 +
 tools/perf/util/evsel.c                            |   39 +-
 tools/perf/util/evsel.h                            |   11 +-
 tools/perf/util/evsel_fprintf.c                    |    2 +-
 tools/perf/util/header.c                           |   24 +-
 tools/perf/util/header.h                           |   17 +-
 .../perf/util/intel-pt-decoder/intel-pt-decoder.c  |   34 +-
 .../perf/util/intel-pt-decoder/intel-pt-decoder.h  |    2 +
 tools/perf/util/intel-pt.c                         |    5 +
 tools/perf/util/llvm-utils.c                       |    2 +-
 tools/perf/util/machine.c                          |    8 +-
 tools/perf/util/map.c                              |   15 +-
 tools/perf/util/mmap.c                             |    6 +-
 tools/perf/util/mmap.h                             |    2 +-
 tools/perf/util/ordered-events.c                   |   87 +-
 tools/perf/util/ordered-events.h                   |   37 +-
 tools/perf/util/python.c                           |   20 +-
 tools/perf/util/s390-cpumsf.c                      |   94 +-
 .../perf/util/scripting-engines/trace-event-perl.c |   66 +-
 .../util/scripting-engines/trace-event-python.c    |  100 +-
 tools/perf/util/session.c                          |   75 +-
 tools/perf/util/session.h                          |    5 +-
 tools/perf/util/setup.py                           |   18 +-
 tools/perf/util/sort.c                             |   22 +-
 tools/perf/util/stat-display.c                     | 1166 ++++++++++++++++
 tools/perf/util/stat-shadow.c                      |  147 +-
 tools/perf/util/stat.c                             |  100 +-
 tools/perf/util/stat.h                             |   77 +-
 tools/perf/util/strbuf.c                           |   10 +-
 tools/perf/util/thread-stack.c                     |   51 +-
 tools/perf/util/tool.h                             |    7 +-
 tools/perf/util/trace-event-info.c                 |    2 +
 tools/perf/util/trace-event-parse.c                |   44 +-
 tools/perf/util/trace-event-read.c                 |   15 +-
 tools/perf/util/trace-event.c                      |    8 +-
 tools/perf/util/trace-event.h                      |   21 +-
 tools/perf/util/util.c                             |    2 +-
 tools/perf/util/util.h                             |    2 +
 tools/power/x86/turbostat/turbostat.c              |   46 +-
 144 files changed, 6281 insertions(+), 3875 deletions(-)
 create mode 100644 tools/include/linux/bits.h
 create mode 100644 tools/lib/traceevent/event-parse-api.c
 create mode 100644 tools/lib/traceevent/event-parse-local.h
 create mode 100644 tools/lib/traceevent/tep_strerror.c
 create mode 100644 tools/lib/traceevent/trace-seq.h
 create mode 100644 tools/perf/examples/bpf/etcsnoop.c
 create mode 100644 tools/perf/include/bpf/linux/socket.h
 create mode 100644 tools/perf/pmu-events/arch/arm64/ampere/emag/branch.json
 create mode 100644 tools/perf/pmu-events/arch/arm64/ampere/emag/bus.json
 create mode 100644 tools/perf/pmu-events/arch/arm64/ampere/emag/cache.json
 create mode 100644 tools/perf/pmu-events/arch/arm64/ampere/emag/clock.json
 delete mode 100644 tools/perf/pmu-events/arch/arm64/ampere/emag/core-imp-def.json
 create mode 100644 tools/perf/pmu-events/arch/arm64/ampere/emag/exception.json
 create mode 100644 tools/perf/pmu-events/arch/arm64/ampere/emag/instruction.json
 create mode 100644 tools/perf/pmu-events/arch/arm64/ampere/emag/intrinsic.json
 create mode 100644 tools/perf/pmu-events/arch/arm64/ampere/emag/memory.json
 create mode 100644 tools/perf/pmu-events/arch/arm64/ampere/emag/pipeline.json
 create mode 100644 tools/perf/tests/wp.c
 create mode 100644 tools/perf/trace/beauty/sockaddr.c
 create mode 100644 tools/perf/util/stat-display.c
