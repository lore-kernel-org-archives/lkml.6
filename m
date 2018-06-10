Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id GtZIE2O9HFt1VAAAmS7hNA
	; Sun, 10 Jun 2018 05:55:47 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 312B360795; Sun, 10 Jun 2018 05:55:47 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,MAILING_LIST_MULTI
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 392D7605A5;
	Sun, 10 Jun 2018 05:55:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 392D7605A5
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753744AbeFJFzi (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Sun, 10 Jun 2018 01:55:38 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:35737 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751542AbeFJFze (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Jun 2018 01:55:34 -0400
Received: from [217.76.163.81] (helo=nanos.fritz.box)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1fRtK7-0007Xw-1s; Sun, 10 Jun 2018 07:55:31 +0200
Date: Sun, 10 Jun 2018 07:55:30 +0200 (CEST)
From: Thomas Gleixner <tglx@linutronix.de>
To: Linus Torvalds <torvalds@linux-foundation.org>
cc: LKML <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@kernel.org>
Subject: [GIT pull] perf updates for 4.18
Message-ID: <alpine.DEB.2.21.1806100731320.1606@nanos.tec.linutronix.de>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

please pull the latest perf-urgent-for-linus git tree from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git perf-urgent-for-linus

perf updates and fixes:
    
    perf stat:
    
     - Display user and system time for workload targets (Jiri Olsa)
    
    perf record:
    
     - Enable arbitrary event names thru name= modifier (Alexey Budankov)
    
    PowerPC:
    
     - Add a python script for hypervisor call statistics (Ravi Bangoria)
    
    Intel PT: (Adrian Hunter)
    
     - Fix sync_switch INTEL_PT_SS_NOT_TRACING
    
     - Fix decoding to accept CBR between FUP and corresponding TIP
    
     - Fix MTC timing after overflow
    
     - Fix "Unexpected indirect branch" error
    
    perf test:
    
     - record+probe_libc_inet_pton:
    
      -  To get the symbol table for dynamic
         shared objects on ubuntu we need to pass the -D/--dynamic command line
         option, unlike with the fedora distros (Arnaldo Carvalho de Melo)
    
     - code-reading:
    
      - Fix perf_env setup for PTI entry trampolines (Adrian Hunter)
    
     - kmod-path:
    
      - Add tests for vdso32 and vdsox32 (Adrian Hunter)
    
     - Use header file util/debug.h (Thomas Richter)
    
    perf annotate:
    
     - Make the various UI backends (stdio, TUI, gtk) use more consistently
      structs with annotation options as specified by the user (Arnaldo Carvalho de Melo)
    
     - Move annotation specific knobs from the symbol_conf global kitchen
      sink to the annotation option structs (Arnaldo Carvalho de Melo)
    
    perf script:
    
     - Add more PMU fields to python scripts event handler dict (Jin Yao)
    
    Core:
    
     - Fix misleading error for some unparsable events mentioning PMUs when
      those are not involved in the problem (Jiri Olsa)
    
     - Consider BSS symbols when processing /proc/kallsyms ('B' and 'b')
      (Arnaldo Carvalho de Melo)
    
    - Be more robust when trying to use per-symbol histograms, checking for
      unlikely but possible cases where the space for the histograms wasn't
      allocated, print a debug message for such cases (Arnaldo Carvalho de Melo)
    
    - Fix symbol and object code resolution for vdso32 and vdsox32 (Adrian Hunter)
    
     - No need to check for null when passing pointers to foo__get() style
      refcount grabbing helpers, just like in the kernel and with free(),
      its safe to pass a NULL pointer to avoid having to check it before
      each and every foo__get() call (Arnaldo Carvalho de Melo)
    
     - Remove some dead code (quote.[ch]) (Arnaldo Carvalho de Melo)
    
     - Remove some needless globals, making them local (Arnaldo Carvalho de Melo)
    
     - Reduce usage of symbol_conf.use_callchain, using other means of
      finding out if callchains are in use or available for specific events,
      as we evolved this codebase to allow requesting callchains for just
      a subset of the monitored events. In time it will help polish
      recording and showing mixed sets accross the various tools:
    
        perf record -e cycles/call-graph=fp/,cache-misses/call-graph=dwarf/,instructions'
    
      (Arnaldo Carvalho de Melo)
    
     - Consider PTI entry trampolines in map__rip_2objdump() (Adrian Hunter)
    
Thanks,

	tglx

------------------>
Adrian Hunter (8):
      perf tests kmod-path: Add tests for vdso32 and vdsox32
      perf tools: Fix symbol and object code resolution for vdso32 and vdsox32
      perf test code-reading: Fix perf_env setup for PTI entry trampolines
      perf map: Consider PTI entry trampolines in rip_2objdump()
      perf intel-pt: Fix sync_switch INTEL_PT_SS_NOT_TRACING
      perf intel-pt: Fix decoding to accept CBR between FUP and corresponding TIP
      perf intel-pt: Fix MTC timing after overflow
      perf intel-pt: Fix "Unexpected indirect branch" error

Alexey Budankov (1):
      perf record: Enable arbitrary event names thru name= modifier

Arnaldo Carvalho de Melo (34):
      perf tools: Remove dead quote.[ch] code
      perf probe: Use return of map__get() to make code more compact
      perf cgroup: Make evlist__find_cgroup() more compact
      perf tools: No need to check if the argument to __get() function is NULL
      perf annotate: Pass perf_evsel instead of just evsel->idx
      perf annotate: __symbol__acount_cycles doesn't need notes
      perf annotate: Split allocation of annotated_source struct
      perf annotate: Introduce constructor/destructor for annotated_source
      perf annotate: Introduce annotated_source__alloc_histograms
      perf annotate: __symbol__inc_addr_samples() needs just annotated_source
      perf annotate: Introduce symbol__hists()
      perf annotate: Introduce symbol__cycle_hists()
      perf annotate: Stop using symbol_conf.nr_events global in symbol__hists()
      perf annotate: Replace symbol__alloc_hists() with symbol__hists()
      perf tools: Ditch the symbol_conf.nr_events global
      perf annotate: Add comment about annotated_src->nr_histograms
      perf annotate stdio: Use annotation_options consistently
      perf srcline: Introduce map__srcline() to make code more compact
      perf sort: Introduce addr_map_symbol__srcline() to make code more compact
      perf srcline: Make hist_entry srcline helper consistent with map's
      perf annotate: Pass annotation_options to symbol__annotate()
      perf annotate: Adopt anotation options from symbol_conf
      perf annotate: Move disassembler_style global to annotation_options
      perf hists browser: Pass annotation_options from tool to browser
      perf annotate: Move objdump_path to struct annotation_options
      perf report: No need to have report_callchain_help as a global
      perf evsel: Add has_callchain() helper to make code more compact/clear
      perf script: Check if evsel has callchains before trying to use it
      perf sched: Use sched->show_callchain where appropriate
      perf hists: Introduce hist_entry__has_callchain() method
      perf hists: Check if a hist_entry has callchains before using them
      perf test record+probe_libc_inet_pton: Ask 'nm' for dynamic symbols
      perf annnotate: Make __symbol__inc_addr_samples handle src->histograms == NULL
      perf symbols: Add BSS symbols when reading from /proc/kallsyms

Jin Yao (3):
      perf script python: Move dsoname code to a new function
      perf script python: Add more PMU fields to event handler dict
      perf script python: Add dict fields introduction to Documentation

Jiri Olsa (2):
      perf stat: Display user and system time
      perf tools: Fix pmu events parsing rule

Ravi Bangoria (1):
      perf script powerpc: Python script for hypervisor call statistics

Thomas Richter (1):
      perf test: Use header file util/debug.h


 tools/perf/Documentation/perf-list.txt             |   6 +-
 tools/perf/Documentation/perf-record.txt           |   3 +
 tools/perf/Documentation/perf-script-python.txt    |  26 +++
 tools/perf/Documentation/perf-stat.txt             |  40 +++-
 tools/perf/arch/common.c                           |   4 +-
 tools/perf/arch/common.h                           |   4 +-
 tools/perf/builtin-annotate.c                      |  36 +--
 tools/perf/builtin-c2c.c                           |   2 +-
 tools/perf/builtin-kvm.c                           |   2 -
 tools/perf/builtin-probe.c                         |   3 +-
 tools/perf/builtin-report.c                        |  39 ++--
 tools/perf/builtin-sched.c                         |  14 +-
 tools/perf/builtin-script.c                        |  12 +-
 tools/perf/builtin-stat.c                          |  28 ++-
 tools/perf/builtin-top.c                           |  48 ++--
 tools/perf/builtin-trace.c                         |   2 +-
 tools/perf/perf.c                                  |   1 -
 .../perf/scripts/python/bin/powerpc-hcalls-record  |   2 +
 .../perf/scripts/python/bin/powerpc-hcalls-report  |   2 +
 tools/perf/scripts/python/powerpc-hcalls.py        | 200 +++++++++++++++++
 tools/perf/tests/code-reading.c                    |   1 +
 tools/perf/tests/kmod-path.c                       |  16 ++
 tools/perf/tests/parse-events.c                    |   4 +-
 tools/perf/tests/python-use.c                      |   3 +-
 .../tests/shell/record+probe_libc_inet_pton.sh     |   2 +-
 tools/perf/ui/browsers/annotate.c                  |  21 +-
 tools/perf/ui/browsers/hists.c                     |  43 ++--
 tools/perf/ui/browsers/hists.h                     |   3 +
 tools/perf/ui/gtk/annotate.c                       |   2 +-
 tools/perf/ui/gtk/hists.c                          |   5 +-
 tools/perf/ui/hist.c                               |   2 +-
 tools/perf/ui/stdio/hist.c                         |   4 +-
 tools/perf/util/Build                              |   1 -
 tools/perf/util/annotate.c                         | 165 +++++++++-----
 tools/perf/util/annotate.h                         |  53 +++--
 tools/perf/util/cgroup.c                           |   9 +-
 tools/perf/util/dso.c                              |   2 +
 tools/perf/util/evsel.c                            |   4 +-
 tools/perf/util/evsel.h                            |   5 +
 tools/perf/util/header.c                           |  24 +-
 tools/perf/util/hist.c                             |  15 +-
 tools/perf/util/hist.h                             |  26 ++-
 .../perf/util/intel-pt-decoder/intel-pt-decoder.c  |  23 +-
 .../perf/util/intel-pt-decoder/intel-pt-decoder.h  |   9 +
 tools/perf/util/intel-pt.c                         |   5 +
 tools/perf/util/map.c                              |  26 ++-
 tools/perf/util/map.h                              |   1 +
 tools/perf/util/parse-events.l                     |  18 +-
 tools/perf/util/parse-events.y                     |  14 +-
 tools/perf/util/probe-event.c                      |   3 +-
 tools/perf/util/quote.c                            |  62 -----
 tools/perf/util/quote.h                            |  31 ---
 .../util/scripting-engines/trace-event-python.c    | 250 ++++++++++++++++++++-
 tools/perf/util/session.c                          |   2 +-
 tools/perf/util/sort.c                             |  81 ++-----
 tools/perf/util/sort.h                             |   7 +-
 tools/perf/util/symbol.c                           |   3 +-
 tools/perf/util/symbol.h                           |   3 -
 tools/perf/util/top.h                              |   3 +-
 59 files changed, 998 insertions(+), 427 deletions(-)
 create mode 100644 tools/perf/scripts/python/bin/powerpc-hcalls-record
 create mode 100644 tools/perf/scripts/python/bin/powerpc-hcalls-report
 create mode 100644 tools/perf/scripts/python/powerpc-hcalls.py
 delete mode 100644 tools/perf/util/quote.c
 delete mode 100644 tools/perf/util/quote.h

diff --git a/tools/perf/Documentation/perf-list.txt b/tools/perf/Documentation/perf-list.txt
index 2549c34a7895..11300dbe35c5 100644
--- a/tools/perf/Documentation/perf-list.txt
+++ b/tools/perf/Documentation/perf-list.txt
@@ -124,7 +124,11 @@ The available PMUs and their raw parameters can be listed with
 For example the raw event "LSD.UOPS" core pmu event above could
 be specified as
 
-  perf stat -e cpu/event=0xa8,umask=0x1,name=LSD.UOPS_CYCLES,cmask=1/ ...
+  perf stat -e cpu/event=0xa8,umask=0x1,name=LSD.UOPS_CYCLES,cmask=0x1/ ...
+
+  or using extended name syntax
+
+  perf stat -e cpu/event=0xa8,umask=0x1,cmask=0x1,name=\'LSD.UOPS_CYCLES:cmask=0x1\'/ ...
 
 PER SOCKET PMUS
 ---------------
diff --git a/tools/perf/Documentation/perf-record.txt b/tools/perf/Documentation/perf-record.txt
index cc37b3a4be76..04168da4268e 100644
--- a/tools/perf/Documentation/perf-record.txt
+++ b/tools/perf/Documentation/perf-record.txt
@@ -57,6 +57,9 @@ OPTIONS
 			 FP mode, "dwarf" for DWARF mode, "lbr" for LBR mode and
 			 "no" for disable callgraph.
 	  - 'stack-size': user stack size for dwarf mode
+	  - 'name' : User defined event name. Single quotes (') may be used to
+		    escape symbols in the name from parsing by shell and tool
+		    like this: name=\'CPU_CLK_UNHALTED.THREAD:cmask=0x1\'.
 
           See the linkperf:perf-list[1] man page for more parameters.
 
diff --git a/tools/perf/Documentation/perf-script-python.txt b/tools/perf/Documentation/perf-script-python.txt
index 51ec2d20068a..0fb9eda3cbca 100644
--- a/tools/perf/Documentation/perf-script-python.txt
+++ b/tools/perf/Documentation/perf-script-python.txt
@@ -610,6 +610,32 @@ Various utility functions for use with perf script:
   nsecs_str(nsecs) - returns printable string in the form secs.nsecs
   avg(total, n) - returns average given a sum and a total number of values
 
+SUPPORTED FIELDS
+----------------
+
+Currently supported fields:
+
+ev_name, comm, pid, tid, cpu, ip, time, period, phys_addr, addr,
+symbol, dso, time_enabled, time_running, values, callchain,
+brstack, brstacksym, datasrc, datasrc_decode, iregs, uregs,
+weight, transaction, raw_buf, attr.
+
+Some fields have sub items:
+
+brstack:
+    from, to, from_dsoname, to_dsoname, mispred,
+    predicted, in_tx, abort, cycles.
+
+brstacksym:
+    items: from, to, pred, in_tx, abort (converted string)
+
+For example,
+We can use this code to print brstack "from", "to", "cycles".
+
+if 'brstack' in dict:
+	for entry in dict['brstack']:
+		print "from %s, to %s, cycles %s" % (entry["from"], entry["to"], entry["cycles"])
+
 SEE ALSO
 --------
 linkperf:perf-script[1]
diff --git a/tools/perf/Documentation/perf-stat.txt b/tools/perf/Documentation/perf-stat.txt
index 3a822f308e6d..5dfe102fb5b5 100644
--- a/tools/perf/Documentation/perf-stat.txt
+++ b/tools/perf/Documentation/perf-stat.txt
@@ -310,20 +310,38 @@ Users who wants to get the actual value can apply --no-metric-only.
 EXAMPLES
 --------
 
-$ perf stat -- make -j
+$ perf stat -- make
 
- Performance counter stats for 'make -j':
+   Performance counter stats for 'make':
 
-    8117.370256  task clock ticks     #      11.281 CPU utilization factor
-            678  context switches     #       0.000 M/sec
-            133  CPU migrations       #       0.000 M/sec
-         235724  pagefaults           #       0.029 M/sec
-    24821162526  CPU cycles           #    3057.784 M/sec
-    18687303457  instructions         #    2302.138 M/sec
-      172158895  cache references     #      21.209 M/sec
-       27075259  cache misses         #       3.335 M/sec
+        83723.452481      task-clock:u (msec)       #    1.004 CPUs utilized
+                   0      context-switches:u        #    0.000 K/sec
+                   0      cpu-migrations:u          #    0.000 K/sec
+           3,228,188      page-faults:u             #    0.039 M/sec
+     229,570,665,834      cycles:u                  #    2.742 GHz
+     313,163,853,778      instructions:u            #    1.36  insn per cycle
+      69,704,684,856      branches:u                #  832.559 M/sec
+       2,078,861,393      branch-misses:u           #    2.98% of all branches
 
- Wall-clock time elapsed:   719.554352 msecs
+        83.409183620 seconds time elapsed
+
+        74.684747000 seconds user
+         8.739217000 seconds sys
+
+TIMINGS
+-------
+As displayed in the example above we can display 3 types of timings.
+We always display the time the counters were enabled/alive:
+
+        83.409183620 seconds time elapsed
+
+For workload sessions we also display time the workloads spent in
+user/system lands:
+
+        74.684747000 seconds user
+         8.739217000 seconds sys
+
+Those times are the very same as displayed by the 'time' tool.
 
 CSV FORMAT
 ----------
diff --git a/tools/perf/arch/common.c b/tools/perf/arch/common.c
index c6f373508a4f..82657c01a3b8 100644
--- a/tools/perf/arch/common.c
+++ b/tools/perf/arch/common.c
@@ -189,7 +189,7 @@ static int perf_env__lookup_binutils_path(struct perf_env *env,
 	return -1;
 }
 
-int perf_env__lookup_objdump(struct perf_env *env)
+int perf_env__lookup_objdump(struct perf_env *env, const char **path)
 {
 	/*
 	 * For live mode, env->arch will be NULL and we can use
@@ -198,5 +198,5 @@ int perf_env__lookup_objdump(struct perf_env *env)
 	if (env->arch == NULL)
 		return 0;
 
-	return perf_env__lookup_binutils_path(env, "objdump", &objdump_path);
+	return perf_env__lookup_binutils_path(env, "objdump", path);
 }
diff --git a/tools/perf/arch/common.h b/tools/perf/arch/common.h
index 2d875baa92e6..2167001b18c5 100644
--- a/tools/perf/arch/common.h
+++ b/tools/perf/arch/common.h
@@ -4,8 +4,6 @@
 
 #include "../util/env.h"
 
-extern const char *objdump_path;
-
-int perf_env__lookup_objdump(struct perf_env *env);
+int perf_env__lookup_objdump(struct perf_env *env, const char **path);
 
 #endif /* ARCH_PERF_COMMON_H */
diff --git a/tools/perf/builtin-annotate.c b/tools/perf/builtin-annotate.c
index da5704240239..5eb22cc56363 100644
--- a/tools/perf/builtin-annotate.c
+++ b/tools/perf/builtin-annotate.c
@@ -40,9 +40,8 @@
 struct perf_annotate {
 	struct perf_tool tool;
 	struct perf_session *session;
+	struct annotation_options opts;
 	bool	   use_tui, use_stdio, use_stdio2, use_gtk;
-	bool	   full_paths;
-	bool	   print_line;
 	bool	   skip_missing;
 	bool	   has_br_stack;
 	bool	   group_set;
@@ -162,12 +161,12 @@ static int hist_iter__branch_callback(struct hist_entry_iter *iter,
 	hist__account_cycles(sample->branch_stack, al, sample, false);
 
 	bi = he->branch_info;
-	err = addr_map_symbol__inc_samples(&bi->from, sample, evsel->idx);
+	err = addr_map_symbol__inc_samples(&bi->from, sample, evsel);
 
 	if (err)
 		goto out;
 
-	err = addr_map_symbol__inc_samples(&bi->to, sample, evsel->idx);
+	err = addr_map_symbol__inc_samples(&bi->to, sample, evsel);
 
 out:
 	return err;
@@ -249,7 +248,7 @@ static int perf_evsel__add_sample(struct perf_evsel *evsel,
 	if (he == NULL)
 		return -ENOMEM;
 
-	ret = hist_entry__inc_addr_samples(he, sample, evsel->idx, al->addr);
+	ret = hist_entry__inc_addr_samples(he, sample, evsel, al->addr);
 	hists__inc_nr_samples(hists, true);
 	return ret;
 }
@@ -289,10 +288,9 @@ static int hist_entry__tty_annotate(struct hist_entry *he,
 				    struct perf_annotate *ann)
 {
 	if (!ann->use_stdio2)
-		return symbol__tty_annotate(he->ms.sym, he->ms.map, evsel,
-					    ann->print_line, ann->full_paths, 0, 0);
-	return symbol__tty_annotate2(he->ms.sym, he->ms.map, evsel,
-				     ann->print_line, ann->full_paths);
+		return symbol__tty_annotate(he->ms.sym, he->ms.map, evsel, &ann->opts);
+
+	return symbol__tty_annotate2(he->ms.sym, he->ms.map, evsel, &ann->opts);
 }
 
 static void hists__find_annotations(struct hists *hists,
@@ -343,7 +341,7 @@ static void hists__find_annotations(struct hists *hists,
 			/* skip missing symbols */
 			nd = rb_next(nd);
 		} else if (use_browser == 1) {
-			key = hist_entry__tui_annotate(he, evsel, NULL);
+			key = hist_entry__tui_annotate(he, evsel, NULL, &ann->opts);
 
 			switch (key) {
 			case -1:
@@ -390,8 +388,9 @@ static int __cmd_annotate(struct perf_annotate *ann)
 			goto out;
 	}
 
-	if (!objdump_path) {
-		ret = perf_env__lookup_objdump(&session->header.env);
+	if (!ann->opts.objdump_path) {
+		ret = perf_env__lookup_objdump(&session->header.env,
+					       &ann->opts.objdump_path);
 		if (ret)
 			goto out;
 	}
@@ -476,6 +475,7 @@ int cmd_annotate(int argc, const char **argv)
 			.ordered_events = true,
 			.ordering_requires_timestamps = true,
 		},
+		.opts = annotation__default_options,
 	};
 	struct perf_data data = {
 		.mode  = PERF_DATA_MODE_READ,
@@ -503,9 +503,9 @@ int cmd_annotate(int argc, const char **argv)
 		   "file", "vmlinux pathname"),
 	OPT_BOOLEAN('m', "modules", &symbol_conf.use_modules,
 		    "load module symbols - WARNING: use only with -k and LIVE kernel"),
-	OPT_BOOLEAN('l', "print-line", &annotate.print_line,
+	OPT_BOOLEAN('l', "print-line", &annotate.opts.print_lines,
 		    "print matching source lines (may be slow)"),
-	OPT_BOOLEAN('P', "full-paths", &annotate.full_paths,
+	OPT_BOOLEAN('P', "full-paths", &annotate.opts.full_path,
 		    "Don't shorten the displayed pathnames"),
 	OPT_BOOLEAN(0, "skip-missing", &annotate.skip_missing,
 		    "Skip symbols that cannot be annotated"),
@@ -516,13 +516,13 @@ int cmd_annotate(int argc, const char **argv)
 	OPT_CALLBACK(0, "symfs", NULL, "directory",
 		     "Look for files with symbols relative to this directory",
 		     symbol__config_symfs),
-	OPT_BOOLEAN(0, "source", &symbol_conf.annotate_src,
+	OPT_BOOLEAN(0, "source", &annotate.opts.annotate_src,
 		    "Interleave source code with assembly code (default)"),
-	OPT_BOOLEAN(0, "asm-raw", &symbol_conf.annotate_asm_raw,
+	OPT_BOOLEAN(0, "asm-raw", &annotate.opts.show_asm_raw,
 		    "Display raw encoding of assembly instructions (default)"),
-	OPT_STRING('M', "disassembler-style", &disassembler_style, "disassembler style",
+	OPT_STRING('M', "disassembler-style", &annotate.opts.disassembler_style, "disassembler style",
 		   "Specify disassembler style (e.g. -M intel for intel syntax)"),
-	OPT_STRING(0, "objdump", &objdump_path, "path",
+	OPT_STRING(0, "objdump", &annotate.opts.objdump_path, "path",
 		   "objdump binary to use for disassembly and annotations"),
 	OPT_BOOLEAN(0, "group", &symbol_conf.event_group,
 		    "Show event group information together"),
diff --git a/tools/perf/builtin-c2c.c b/tools/perf/builtin-c2c.c
index 2126bfbcb385..307b3594525f 100644
--- a/tools/perf/builtin-c2c.c
+++ b/tools/perf/builtin-c2c.c
@@ -1976,7 +1976,7 @@ static int filter_cb(struct hist_entry *he)
 	c2c_he = container_of(he, struct c2c_hist_entry, he);
 
 	if (c2c.show_src && !he->srcline)
-		he->srcline = hist_entry__get_srcline(he);
+		he->srcline = hist_entry__srcline(he);
 
 	calc_width(c2c_he);
 
diff --git a/tools/perf/builtin-kvm.c b/tools/perf/builtin-kvm.c
index 72e2ca096bf5..2b1ef704169f 100644
--- a/tools/perf/builtin-kvm.c
+++ b/tools/perf/builtin-kvm.c
@@ -1438,8 +1438,6 @@ static int kvm_events_live(struct perf_kvm_stat *kvm,
 		goto out;
 	}
 
-	symbol_conf.nr_events = kvm->evlist->nr_entries;
-
 	if (perf_evlist__create_maps(kvm->evlist, &kvm->opts.target) < 0)
 		usage_with_options(live_usage, live_options);
 
diff --git a/tools/perf/builtin-probe.c b/tools/perf/builtin-probe.c
index c0065923a525..99de91698de1 100644
--- a/tools/perf/builtin-probe.c
+++ b/tools/perf/builtin-probe.c
@@ -81,8 +81,7 @@ static int parse_probe_event(const char *str)
 		params.target_used = true;
 	}
 
-	if (params.nsi)
-		pev->nsi = nsinfo__get(params.nsi);
+	pev->nsi = nsinfo__get(params.nsi);
 
 	/* Parse a perf-probe command into event */
 	ret = parse_perf_probe_command(str, pev);
diff --git a/tools/perf/builtin-report.c b/tools/perf/builtin-report.c
index ad978e3ee2b8..cdb5b6949832 100644
--- a/tools/perf/builtin-report.c
+++ b/tools/perf/builtin-report.c
@@ -71,6 +71,7 @@ struct report {
 	bool			group_set;
 	int			max_stack;
 	struct perf_read_values	show_threads_values;
+	struct annotation_options annotation_opts;
 	const char		*pretty_printing_style;
 	const char		*cpu_list;
 	const char		*symbol_filter_str;
@@ -136,26 +137,25 @@ static int hist_iter__report_callback(struct hist_entry_iter *iter,
 
 	if (sort__mode == SORT_MODE__BRANCH) {
 		bi = he->branch_info;
-		err = addr_map_symbol__inc_samples(&bi->from, sample, evsel->idx);
+		err = addr_map_symbol__inc_samples(&bi->from, sample, evsel);
 		if (err)
 			goto out;
 
-		err = addr_map_symbol__inc_samples(&bi->to, sample, evsel->idx);
+		err = addr_map_symbol__inc_samples(&bi->to, sample, evsel);
 
 	} else if (rep->mem_mode) {
 		mi = he->mem_info;
-		err = addr_map_symbol__inc_samples(&mi->daddr, sample, evsel->idx);
+		err = addr_map_symbol__inc_samples(&mi->daddr, sample, evsel);
 		if (err)
 			goto out;
 
-		err = hist_entry__inc_addr_samples(he, sample, evsel->idx, al->addr);
+		err = hist_entry__inc_addr_samples(he, sample, evsel, al->addr);
 
 	} else if (symbol_conf.cumulate_callchain) {
 		if (single)
-			err = hist_entry__inc_addr_samples(he, sample, evsel->idx,
-							   al->addr);
+			err = hist_entry__inc_addr_samples(he, sample, evsel, al->addr);
 	} else {
-		err = hist_entry__inc_addr_samples(he, sample, evsel->idx, al->addr);
+		err = hist_entry__inc_addr_samples(he, sample, evsel, al->addr);
 	}
 
 out:
@@ -181,11 +181,11 @@ static int hist_iter__branch_callback(struct hist_entry_iter *iter,
 			     rep->nonany_branch_mode);
 
 	bi = he->branch_info;
-	err = addr_map_symbol__inc_samples(&bi->from, sample, evsel->idx);
+	err = addr_map_symbol__inc_samples(&bi->from, sample, evsel);
 	if (err)
 		goto out;
 
-	err = addr_map_symbol__inc_samples(&bi->to, sample, evsel->idx);
+	err = addr_map_symbol__inc_samples(&bi->to, sample, evsel);
 
 	branch_type_count(&rep->brtype_stat, &bi->flags,
 			  bi->from.addr, bi->to.addr);
@@ -561,7 +561,7 @@ static int report__browse_hists(struct report *rep)
 		ret = perf_evlist__tui_browse_hists(evlist, help, NULL,
 						    rep->min_percent,
 						    &session->header.env,
-						    true);
+						    true, &rep->annotation_opts);
 		/*
 		 * Usually "ret" is the last pressed key, and we only
 		 * care if the key notifies us to switch data file.
@@ -946,12 +946,6 @@ parse_percent_limit(const struct option *opt, const char *str,
 	return 0;
 }
 
-#define CALLCHAIN_DEFAULT_OPT  "graph,0.5,caller,function,percent"
-
-const char report_callchain_help[] = "Display call graph (stack chain/backtrace):\n\n"
-				     CALLCHAIN_REPORT_HELP
-				     "\n\t\t\t\tDefault: " CALLCHAIN_DEFAULT_OPT;
-
 int cmd_report(int argc, const char **argv)
 {
 	struct perf_session *session;
@@ -960,6 +954,10 @@ int cmd_report(int argc, const char **argv)
 	bool has_br_stack = false;
 	int branch_mode = -1;
 	bool branch_call_mode = false;
+#define CALLCHAIN_DEFAULT_OPT  "graph,0.5,caller,function,percent"
+	const char report_callchain_help[] = "Display call graph (stack chain/backtrace):\n\n"
+					     CALLCHAIN_REPORT_HELP
+					     "\n\t\t\t\tDefault: " CALLCHAIN_DEFAULT_OPT;
 	char callchain_default_opt[] = CALLCHAIN_DEFAULT_OPT;
 	const char * const report_usage[] = {
 		"perf report [<options>]",
@@ -989,6 +987,7 @@ int cmd_report(int argc, const char **argv)
 		.max_stack		 = PERF_MAX_STACK_DEPTH,
 		.pretty_printing_style	 = "normal",
 		.socket_filter		 = -1,
+		.annotation_opts	 = annotation__default_options,
 	};
 	const struct option options[] = {
 	OPT_STRING('i', "input", &input_name, "file",
@@ -1078,11 +1077,11 @@ int cmd_report(int argc, const char **argv)
 		   "list of cpus to profile"),
 	OPT_BOOLEAN('I', "show-info", &report.show_full_info,
 		    "Display extended information about perf.data file"),
-	OPT_BOOLEAN(0, "source", &symbol_conf.annotate_src,
+	OPT_BOOLEAN(0, "source", &report.annotation_opts.annotate_src,
 		    "Interleave source code with assembly code (default)"),
-	OPT_BOOLEAN(0, "asm-raw", &symbol_conf.annotate_asm_raw,
+	OPT_BOOLEAN(0, "asm-raw", &report.annotation_opts.show_asm_raw,
 		    "Display raw encoding of assembly instructions (default)"),
-	OPT_STRING('M', "disassembler-style", &disassembler_style, "disassembler style",
+	OPT_STRING('M', "disassembler-style", &report.annotation_opts.disassembler_style, "disassembler style",
 		   "Specify disassembler style (e.g. -M intel for intel syntax)"),
 	OPT_BOOLEAN(0, "show-total-period", &symbol_conf.show_total_period,
 		    "Show a column with the sum of periods"),
@@ -1093,7 +1092,7 @@ int cmd_report(int argc, const char **argv)
 		    parse_branch_mode),
 	OPT_BOOLEAN(0, "branch-history", &branch_call_mode,
 		    "add last branch records to call history"),
-	OPT_STRING(0, "objdump", &objdump_path, "path",
+	OPT_STRING(0, "objdump", &report.annotation_opts.objdump_path, "path",
 		   "objdump binary to use for disassembly and annotations"),
 	OPT_BOOLEAN(0, "demangle", &symbol_conf.demangle,
 		    "Disable symbol demangling"),
diff --git a/tools/perf/builtin-sched.c b/tools/perf/builtin-sched.c
index 4dfdee668b0c..cbf39dab19c1 100644
--- a/tools/perf/builtin-sched.c
+++ b/tools/perf/builtin-sched.c
@@ -2143,7 +2143,7 @@ static void save_task_callchain(struct perf_sched *sched,
 		return;
 	}
 
-	if (!symbol_conf.use_callchain || sample->callchain == NULL)
+	if (!sched->show_callchain || sample->callchain == NULL)
 		return;
 
 	if (thread__resolve_callchain(thread, cursor, evsel, sample,
@@ -2271,10 +2271,11 @@ static struct thread *get_idle_thread(int cpu)
 	return idle_threads[cpu];
 }
 
-static void save_idle_callchain(struct idle_thread_runtime *itr,
+static void save_idle_callchain(struct perf_sched *sched,
+				struct idle_thread_runtime *itr,
 				struct perf_sample *sample)
 {
-	if (!symbol_conf.use_callchain || sample->callchain == NULL)
+	if (!sched->show_callchain || sample->callchain == NULL)
 		return;
 
 	callchain_cursor__copy(&itr->cursor, &callchain_cursor);
@@ -2320,7 +2321,7 @@ static struct thread *timehist_get_thread(struct perf_sched *sched,
 
 			/* copy task callchain when entering to idle */
 			if (perf_evsel__intval(evsel, sample, "next_pid") == 0)
-				save_idle_callchain(itr, sample);
+				save_idle_callchain(sched, itr, sample);
 		}
 	}
 
@@ -2849,7 +2850,7 @@ static void timehist_print_summary(struct perf_sched *sched,
 			printf("    CPU %2d idle entire time window\n", i);
 	}
 
-	if (sched->idle_hist && symbol_conf.use_callchain) {
+	if (sched->idle_hist && sched->show_callchain) {
 		callchain_param.mode  = CHAIN_FOLDED;
 		callchain_param.value = CCVAL_PERIOD;
 
@@ -2933,8 +2934,7 @@ static int timehist_check_attr(struct perf_sched *sched,
 			return -1;
 		}
 
-		if (sched->show_callchain &&
-		    !(evsel->attr.sample_type & PERF_SAMPLE_CALLCHAIN)) {
+		if (sched->show_callchain && !evsel__has_callchain(evsel)) {
 			pr_info("Samples do not have callchains.\n");
 			sched->show_callchain = 0;
 			symbol_conf.use_callchain = 0;
diff --git a/tools/perf/builtin-script.c b/tools/perf/builtin-script.c
index cefc8813e91e..b3bf35512d21 100644
--- a/tools/perf/builtin-script.c
+++ b/tools/perf/builtin-script.c
@@ -517,7 +517,7 @@ static int perf_session__check_output_opt(struct perf_session *session)
 
 		evlist__for_each_entry(session->evlist, evsel) {
 			not_pipe = true;
-			if (evsel->attr.sample_type & PERF_SAMPLE_CALLCHAIN) {
+			if (evsel__has_callchain(evsel)) {
 				use_callchain = true;
 				break;
 			}
@@ -532,22 +532,18 @@ static int perf_session__check_output_opt(struct perf_session *session)
 	 */
 	if (symbol_conf.use_callchain &&
 	    !output[PERF_TYPE_TRACEPOINT].user_set) {
-		struct perf_event_attr *attr;
-
 		j = PERF_TYPE_TRACEPOINT;
 
 		evlist__for_each_entry(session->evlist, evsel) {
 			if (evsel->attr.type != j)
 				continue;
 
-			attr = &evsel->attr;
-
-			if (attr->sample_type & PERF_SAMPLE_CALLCHAIN) {
+			if (evsel__has_callchain(evsel)) {
 				output[j].fields |= PERF_OUTPUT_IP;
 				output[j].fields |= PERF_OUTPUT_SYM;
 				output[j].fields |= PERF_OUTPUT_SYMOFFSET;
 				output[j].fields |= PERF_OUTPUT_DSO;
-				set_print_ip_opts(attr);
+				set_print_ip_opts(&evsel->attr);
 				goto out;
 			}
 		}
@@ -610,7 +606,7 @@ static int perf_sample__fprintf_start(struct perf_sample *sample,
 	if (PRINT_FIELD(COMM)) {
 		if (latency_format)
 			printed += fprintf(fp, "%8.8s ", thread__comm_str(thread));
-		else if (PRINT_FIELD(IP) && symbol_conf.use_callchain)
+		else if (PRINT_FIELD(IP) && evsel__has_callchain(evsel) && symbol_conf.use_callchain)
 			printed += fprintf(fp, "%s ", thread__comm_str(thread));
 		else
 			printed += fprintf(fp, "%16s ", thread__comm_str(thread));
diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
index a4f662a462c6..096ccb25c11f 100644
--- a/tools/perf/builtin-stat.c
+++ b/tools/perf/builtin-stat.c
@@ -80,6 +80,9 @@
 #include <sys/stat.h>
 #include <sys/wait.h>
 #include <unistd.h>
+#include <sys/time.h>
+#include <sys/resource.h>
+#include <sys/wait.h>
 
 #include "sane_ctype.h"
 
@@ -175,6 +178,8 @@ static int			output_fd;
 static int			print_free_counters_hint;
 static int			print_mixed_hw_group_error;
 static u64			*walltime_run;
+static bool			ru_display			= false;
+static struct rusage		ru_data;
 
 struct perf_stat {
 	bool			 record;
@@ -726,7 +731,7 @@ static int __run_perf_stat(int argc, const char **argv, int run_idx)
 					break;
 			}
 		}
-		waitpid(child_pid, &status, 0);
+		wait4(child_pid, &status, 0, &ru_data);
 
 		if (workload_exec_errno) {
 			const char *emsg = str_error_r(workload_exec_errno, msg, sizeof(msg));
@@ -1804,6 +1809,11 @@ static void print_table(FILE *output, int precision, double avg)
 	fprintf(output, "\n%*s# Final result:\n", indent, "");
 }
 
+static double timeval2double(struct timeval *t)
+{
+	return t->tv_sec + (double) t->tv_usec/USEC_PER_SEC;
+}
+
 static void print_footer(void)
 {
 	double avg = avg_stats(&walltime_nsecs_stats) / NSEC_PER_SEC;
@@ -1815,6 +1825,15 @@ static void print_footer(void)
 
 	if (run_count == 1) {
 		fprintf(output, " %17.9f seconds time elapsed", avg);
+
+		if (ru_display) {
+			double ru_utime = timeval2double(&ru_data.ru_utime);
+			double ru_stime = timeval2double(&ru_data.ru_stime);
+
+			fprintf(output, "\n\n");
+			fprintf(output, " %17.9f seconds user\n", ru_utime);
+			fprintf(output, " %17.9f seconds sys\n", ru_stime);
+		}
 	} else {
 		double sd = stddev_stats(&walltime_nsecs_stats) / NSEC_PER_SEC;
 		/*
@@ -2950,6 +2969,13 @@ int cmd_stat(int argc, const char **argv)
 
 	setup_system_wide(argc);
 
+	/*
+	 * Display user/system times only for single
+	 * run and when there's specified tracee.
+	 */
+	if ((run_count == 1) && target__none(&target))
+		ru_display = true;
+
 	if (run_count < 0) {
 		pr_err("Run count must be a positive number\n");
 		parse_options_usage(stat_usage, stat_options, "r", 1);
diff --git a/tools/perf/builtin-top.c b/tools/perf/builtin-top.c
index 7a349fcd3864..ffdc2769ff9f 100644
--- a/tools/perf/builtin-top.c
+++ b/tools/perf/builtin-top.c
@@ -123,14 +123,9 @@ static int perf_top__parse_source(struct perf_top *top, struct hist_entry *he)
 	}
 
 	notes = symbol__annotation(sym);
-	if (notes->src != NULL) {
-		pthread_mutex_lock(&notes->lock);
-		goto out_assign;
-	}
-
 	pthread_mutex_lock(&notes->lock);
 
-	if (symbol__alloc_hist(sym) < 0) {
+	if (!symbol__hists(sym, top->evlist->nr_entries)) {
 		pthread_mutex_unlock(&notes->lock);
 		pr_err("Not enough memory for annotating '%s' symbol!\n",
 		       sym->name);
@@ -138,9 +133,8 @@ static int perf_top__parse_source(struct perf_top *top, struct hist_entry *he)
 		return err;
 	}
 
-	err = symbol__annotate(sym, map, evsel, 0, NULL);
+	err = symbol__annotate(sym, map, evsel, 0, &top->annotation_opts, NULL);
 	if (err == 0) {
-out_assign:
 		top->sym_filter_entry = he;
 	} else {
 		char msg[BUFSIZ];
@@ -188,7 +182,7 @@ static void ui__warn_map_erange(struct map *map, struct symbol *sym, u64 ip)
 static void perf_top__record_precise_ip(struct perf_top *top,
 					struct hist_entry *he,
 					struct perf_sample *sample,
-					int counter, u64 ip)
+					struct perf_evsel *evsel, u64 ip)
 {
 	struct annotation *notes;
 	struct symbol *sym = he->ms.sym;
@@ -204,7 +198,7 @@ static void perf_top__record_precise_ip(struct perf_top *top,
 	if (pthread_mutex_trylock(&notes->lock))
 		return;
 
-	err = hist_entry__inc_addr_samples(he, sample, counter, ip);
+	err = hist_entry__inc_addr_samples(he, sample, evsel, ip);
 
 	pthread_mutex_unlock(&notes->lock);
 
@@ -249,10 +243,9 @@ static void perf_top__show_details(struct perf_top *top)
 		goto out_unlock;
 
 	printf("Showing %s for %s\n", perf_evsel__name(top->sym_evsel), symbol->name);
-	printf("  Events  Pcnt (>=%d%%)\n", top->sym_pcnt_filter);
+	printf("  Events  Pcnt (>=%d%%)\n", top->annotation_opts.min_pcnt);
 
-	more = symbol__annotate_printf(symbol, he->ms.map, top->sym_evsel,
-				       0, top->sym_pcnt_filter, top->print_entries, 4);
+	more = symbol__annotate_printf(symbol, he->ms.map, top->sym_evsel, &top->annotation_opts);
 
 	if (top->evlist->enabled) {
 		if (top->zero)
@@ -412,7 +405,7 @@ static void perf_top__print_mapped_keys(struct perf_top *top)
 
 	fprintf(stdout, "\t[f]     profile display filter (count).    \t(%d)\n", top->count_filter);
 
-	fprintf(stdout, "\t[F]     annotate display filter (percent). \t(%d%%)\n", top->sym_pcnt_filter);
+	fprintf(stdout, "\t[F]     annotate display filter (percent). \t(%d%%)\n", top->annotation_opts.min_pcnt);
 	fprintf(stdout, "\t[s]     annotate symbol.                   \t(%s)\n", name?: "NULL");
 	fprintf(stdout, "\t[S]     stop annotation.\n");
 
@@ -515,7 +508,7 @@ static bool perf_top__handle_keypress(struct perf_top *top, int c)
 			prompt_integer(&top->count_filter, "Enter display event count filter");
 			break;
 		case 'F':
-			prompt_percent(&top->sym_pcnt_filter,
+			prompt_percent(&top->annotation_opts.min_pcnt,
 				       "Enter details display event filter (percent)");
 			break;
 		case 'K':
@@ -613,7 +606,8 @@ static void *display_thread_tui(void *arg)
 	perf_evlist__tui_browse_hists(top->evlist, help, &hbt,
 				      top->min_percent,
 				      &top->session->header.env,
-				      !top->record_opts.overwrite);
+				      !top->record_opts.overwrite,
+				      &top->annotation_opts);
 
 	done = 1;
 	return NULL;
@@ -691,7 +685,7 @@ static int hist_iter__top_callback(struct hist_entry_iter *iter,
 	struct perf_evsel *evsel = iter->evsel;
 
 	if (perf_hpp_list.sym && single)
-		perf_top__record_precise_ip(top, he, iter->sample, evsel->idx, al->addr);
+		perf_top__record_precise_ip(top, he, iter->sample, evsel, al->addr);
 
 	hist__account_cycles(iter->sample->branch_stack, al, iter->sample,
 		     !(top->record_opts.branch_stack & PERF_SAMPLE_BRANCH_ANY));
@@ -1083,8 +1077,9 @@ static int __cmd_top(struct perf_top *top)
 	if (top->session == NULL)
 		return -1;
 
-	if (!objdump_path) {
-		ret = perf_env__lookup_objdump(&top->session->header.env);
+	if (!top->annotation_opts.objdump_path) {
+		ret = perf_env__lookup_objdump(&top->session->header.env,
+					       &top->annotation_opts.objdump_path);
 		if (ret)
 			goto out_delete;
 	}
@@ -1265,7 +1260,7 @@ int cmd_top(int argc, const char **argv)
 			.overwrite	= 1,
 		},
 		.max_stack	     = sysctl__max_stack(),
-		.sym_pcnt_filter     = 5,
+		.annotation_opts     = annotation__default_options,
 		.nr_threads_synthesize = UINT_MAX,
 	};
 	struct record_opts *opts = &top.record_opts;
@@ -1347,15 +1342,15 @@ int cmd_top(int argc, const char **argv)
 		   "only consider symbols in these comms"),
 	OPT_STRING(0, "symbols", &symbol_conf.sym_list_str, "symbol[,symbol...]",
 		   "only consider these symbols"),
-	OPT_BOOLEAN(0, "source", &symbol_conf.annotate_src,
+	OPT_BOOLEAN(0, "source", &top.annotation_opts.annotate_src,
 		    "Interleave source code with assembly code (default)"),
-	OPT_BOOLEAN(0, "asm-raw", &symbol_conf.annotate_asm_raw,
+	OPT_BOOLEAN(0, "asm-raw", &top.annotation_opts.show_asm_raw,
 		    "Display raw encoding of assembly instructions (default)"),
 	OPT_BOOLEAN(0, "demangle-kernel", &symbol_conf.demangle_kernel,
 		    "Enable kernel symbol demangling"),
-	OPT_STRING(0, "objdump", &objdump_path, "path",
+	OPT_STRING(0, "objdump", &top.annotation_opts.objdump_path, "path",
 		    "objdump binary to use for disassembly and annotations"),
-	OPT_STRING('M', "disassembler-style", &disassembler_style, "disassembler style",
+	OPT_STRING('M', "disassembler-style", &top.annotation_opts.disassembler_style, "disassembler style",
 		   "Specify disassembler style (e.g. -M intel for intel syntax)"),
 	OPT_STRING('u', "uid", &target->uid_str, "user", "user to profile"),
 	OPT_CALLBACK(0, "percent-limit", &top, "percent",
@@ -1391,6 +1386,9 @@ int cmd_top(int argc, const char **argv)
 	if (status < 0)
 		return status;
 
+	top.annotation_opts.min_pcnt = 5;
+	top.annotation_opts.context  = 4;
+
 	top.evlist = perf_evlist__new();
 	if (top.evlist == NULL)
 		return -ENOMEM;
@@ -1468,8 +1466,6 @@ int cmd_top(int argc, const char **argv)
 		goto out_delete_evlist;
 	}
 
-	symbol_conf.nr_events = top.evlist->nr_entries;
-
 	if (top.delay_secs < 1)
 		top.delay_secs = 1;
 
diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
index 560aed7da36a..6a748eca2edb 100644
--- a/tools/perf/builtin-trace.c
+++ b/tools/perf/builtin-trace.c
@@ -2491,7 +2491,7 @@ static int trace__run(struct trace *trace, int argc, const char **argv)
 	 * to override an explicitely set --max-stack global setting.
 	 */
 	evlist__for_each_entry(evlist, evsel) {
-		if ((evsel->attr.sample_type & PERF_SAMPLE_CALLCHAIN) &&
+		if (evsel__has_callchain(evsel) &&
 		    evsel->attr.sample_max_stack == 0)
 			evsel->attr.sample_max_stack = trace->max_stack;
 	}
diff --git a/tools/perf/perf.c b/tools/perf/perf.c
index 51c81509a315..a11cb006f968 100644
--- a/tools/perf/perf.c
+++ b/tools/perf/perf.c
@@ -12,7 +12,6 @@
 #include "util/env.h"
 #include <subcmd/exec-cmd.h>
 #include "util/config.h"
-#include "util/quote.h"
 #include <subcmd/run-command.h>
 #include "util/parse-events.h"
 #include <subcmd/parse-options.h>
diff --git a/tools/perf/scripts/python/bin/powerpc-hcalls-record b/tools/perf/scripts/python/bin/powerpc-hcalls-record
new file mode 100644
index 000000000000..b7402aa9147d
--- /dev/null
+++ b/tools/perf/scripts/python/bin/powerpc-hcalls-record
@@ -0,0 +1,2 @@
+#!/bin/bash
+perf record -e "{powerpc:hcall_entry,powerpc:hcall_exit}" $@
diff --git a/tools/perf/scripts/python/bin/powerpc-hcalls-report b/tools/perf/scripts/python/bin/powerpc-hcalls-report
new file mode 100644
index 000000000000..dd32ad7465f6
--- /dev/null
+++ b/tools/perf/scripts/python/bin/powerpc-hcalls-report
@@ -0,0 +1,2 @@
+#!/bin/bash
+perf script $@ -s "$PERF_EXEC_PATH"/scripts/python/powerpc-hcalls.py
diff --git a/tools/perf/scripts/python/powerpc-hcalls.py b/tools/perf/scripts/python/powerpc-hcalls.py
new file mode 100644
index 000000000000..00e0e7476e55
--- /dev/null
+++ b/tools/perf/scripts/python/powerpc-hcalls.py
@@ -0,0 +1,200 @@
+# SPDX-License-Identifier: GPL-2.0+
+#
+# Copyright (C) 2018 Ravi Bangoria, IBM Corporation
+#
+# Hypervisor call statisics
+
+import os
+import sys
+
+sys.path.append(os.environ['PERF_EXEC_PATH'] + \
+	'/scripts/python/Perf-Trace-Util/lib/Perf/Trace')
+
+from perf_trace_context import *
+from Core import *
+from Util import *
+
+# output: {
+#	opcode: {
+#		'min': minimum time nsec
+#		'max': maximum time nsec
+#		'time': average time nsec
+#		'cnt': counter
+#	} ...
+# }
+output = {}
+
+# d_enter: {
+#	cpu: {
+#		opcode: nsec
+#	} ...
+# }
+d_enter = {}
+
+hcall_table = {
+	4: 'H_REMOVE',
+	8: 'H_ENTER',
+	12: 'H_READ',
+	16: 'H_CLEAR_MOD',
+	20: 'H_CLEAR_REF',
+	24: 'H_PROTECT',
+	28: 'H_GET_TCE',
+	32: 'H_PUT_TCE',
+	36: 'H_SET_SPRG0',
+	40: 'H_SET_DABR',
+	44: 'H_PAGE_INIT',
+	48: 'H_SET_ASR',
+	52: 'H_ASR_ON',
+	56: 'H_ASR_OFF',
+	60: 'H_LOGICAL_CI_LOAD',
+	64: 'H_LOGICAL_CI_STORE',
+	68: 'H_LOGICAL_CACHE_LOAD',
+	72: 'H_LOGICAL_CACHE_STORE',
+	76: 'H_LOGICAL_ICBI',
+	80: 'H_LOGICAL_DCBF',
+	84: 'H_GET_TERM_CHAR',
+	88: 'H_PUT_TERM_CHAR',
+	92: 'H_REAL_TO_LOGICAL',
+	96: 'H_HYPERVISOR_DATA',
+	100: 'H_EOI',
+	104: 'H_CPPR',
+	108: 'H_IPI',
+	112: 'H_IPOLL',
+	116: 'H_XIRR',
+	120: 'H_MIGRATE_DMA',
+	124: 'H_PERFMON',
+	220: 'H_REGISTER_VPA',
+	224: 'H_CEDE',
+	228: 'H_CONFER',
+	232: 'H_PROD',
+	236: 'H_GET_PPP',
+	240: 'H_SET_PPP',
+	244: 'H_PURR',
+	248: 'H_PIC',
+	252: 'H_REG_CRQ',
+	256: 'H_FREE_CRQ',
+	260: 'H_VIO_SIGNAL',
+	264: 'H_SEND_CRQ',
+	272: 'H_COPY_RDMA',
+	276: 'H_REGISTER_LOGICAL_LAN',
+	280: 'H_FREE_LOGICAL_LAN',
+	284: 'H_ADD_LOGICAL_LAN_BUFFER',
+	288: 'H_SEND_LOGICAL_LAN',
+	292: 'H_BULK_REMOVE',
+	304: 'H_MULTICAST_CTRL',
+	308: 'H_SET_XDABR',
+	312: 'H_STUFF_TCE',
+	316: 'H_PUT_TCE_INDIRECT',
+	332: 'H_CHANGE_LOGICAL_LAN_MAC',
+	336: 'H_VTERM_PARTNER_INFO',
+	340: 'H_REGISTER_VTERM',
+	344: 'H_FREE_VTERM',
+	348: 'H_RESET_EVENTS',
+	352: 'H_ALLOC_RESOURCE',
+	356: 'H_FREE_RESOURCE',
+	360: 'H_MODIFY_QP',
+	364: 'H_QUERY_QP',
+	368: 'H_REREGISTER_PMR',
+	372: 'H_REGISTER_SMR',
+	376: 'H_QUERY_MR',
+	380: 'H_QUERY_MW',
+	384: 'H_QUERY_HCA',
+	388: 'H_QUERY_PORT',
+	392: 'H_MODIFY_PORT',
+	396: 'H_DEFINE_AQP1',
+	400: 'H_GET_TRACE_BUFFER',
+	404: 'H_DEFINE_AQP0',
+	408: 'H_RESIZE_MR',
+	412: 'H_ATTACH_MCQP',
+	416: 'H_DETACH_MCQP',
+	420: 'H_CREATE_RPT',
+	424: 'H_REMOVE_RPT',
+	428: 'H_REGISTER_RPAGES',
+	432: 'H_DISABLE_AND_GETC',
+	436: 'H_ERROR_DATA',
+	440: 'H_GET_HCA_INFO',
+	444: 'H_GET_PERF_COUNT',
+	448: 'H_MANAGE_TRACE',
+	468: 'H_FREE_LOGICAL_LAN_BUFFER',
+	472: 'H_POLL_PENDING',
+	484: 'H_QUERY_INT_STATE',
+	580: 'H_ILLAN_ATTRIBUTES',
+	592: 'H_MODIFY_HEA_QP',
+	596: 'H_QUERY_HEA_QP',
+	600: 'H_QUERY_HEA',
+	604: 'H_QUERY_HEA_PORT',
+	608: 'H_MODIFY_HEA_PORT',
+	612: 'H_REG_BCMC',
+	616: 'H_DEREG_BCMC',
+	620: 'H_REGISTER_HEA_RPAGES',
+	624: 'H_DISABLE_AND_GET_HEA',
+	628: 'H_GET_HEA_INFO',
+	632: 'H_ALLOC_HEA_RESOURCE',
+	644: 'H_ADD_CONN',
+	648: 'H_DEL_CONN',
+	664: 'H_JOIN',
+	676: 'H_VASI_STATE',
+	688: 'H_ENABLE_CRQ',
+	696: 'H_GET_EM_PARMS',
+	720: 'H_SET_MPP',
+	724: 'H_GET_MPP',
+	748: 'H_HOME_NODE_ASSOCIATIVITY',
+	756: 'H_BEST_ENERGY',
+	764: 'H_XIRR_X',
+	768: 'H_RANDOM',
+	772: 'H_COP',
+	788: 'H_GET_MPP_X',
+	796: 'H_SET_MODE',
+	61440: 'H_RTAS',
+}
+
+def hcall_table_lookup(opcode):
+	if (hcall_table.has_key(opcode)):
+		return hcall_table[opcode]
+	else:
+		return opcode
+
+print_ptrn = '%-28s%10s%10s%10s%10s'
+
+def trace_end():
+	print print_ptrn % ('hcall', 'count', 'min(ns)', 'max(ns)', 'avg(ns)')
+	print '-' * 68
+	for opcode in output:
+		h_name = hcall_table_lookup(opcode)
+		time = output[opcode]['time']
+		cnt = output[opcode]['cnt']
+		min_t = output[opcode]['min']
+		max_t = output[opcode]['max']
+
+		print print_ptrn % (h_name, cnt, min_t, max_t, time/cnt)
+
+def powerpc__hcall_exit(name, context, cpu, sec, nsec, pid, comm, callchain,
+			opcode, retval):
+	if (d_enter.has_key(cpu) and d_enter[cpu].has_key(opcode)):
+		diff = nsecs(sec, nsec) - d_enter[cpu][opcode]
+
+		if (output.has_key(opcode)):
+			output[opcode]['time'] += diff
+			output[opcode]['cnt'] += 1
+			if (output[opcode]['min'] > diff):
+				output[opcode]['min'] = diff
+			if (output[opcode]['max'] < diff):
+				output[opcode]['max'] = diff
+		else:
+			output[opcode] = {
+				'time': diff,
+				'cnt': 1,
+				'min': diff,
+				'max': diff,
+			}
+
+		del d_enter[cpu][opcode]
+#	else:
+#		print "Can't find matching hcall_enter event. Ignoring sample"
+
+def powerpc__hcall_entry(event_name, context, cpu, sec, nsec, pid, comm,
+			 callchain, opcode):
+		if (d_enter.has_key(cpu)):
+			d_enter[cpu][opcode] = nsecs(sec, nsec)
+		else:
+			d_enter[cpu] = {opcode: nsecs(sec, nsec)}
diff --git a/tools/perf/tests/code-reading.c b/tools/perf/tests/code-reading.c
index afa4ce21ba7c..4892bd2dc33e 100644
--- a/tools/perf/tests/code-reading.c
+++ b/tools/perf/tests/code-reading.c
@@ -560,6 +560,7 @@ static int do_test_code_reading(bool try_kcore)
 	pid = getpid();
 
 	machine = machine__new_host();
+	machine->env = &perf_env;
 
 	ret = machine__create_kernel_maps(machine);
 	if (ret < 0) {
diff --git a/tools/perf/tests/kmod-path.c b/tools/perf/tests/kmod-path.c
index 8e57d46109de..148dd31cc201 100644
--- a/tools/perf/tests/kmod-path.c
+++ b/tools/perf/tests/kmod-path.c
@@ -127,6 +127,22 @@ int test__kmod_path__parse(struct test *t __maybe_unused, int subtest __maybe_un
 	M("[vdso]", PERF_RECORD_MISC_KERNEL, false);
 	M("[vdso]", PERF_RECORD_MISC_USER, false);
 
+	T("[vdso32]", true      , true     , false, false, "[vdso32]", NULL);
+	T("[vdso32]", false     , true     , false, false, NULL    , NULL);
+	T("[vdso32]", true      , false    , false, false, "[vdso32]", NULL);
+	T("[vdso32]", false     , false    , false, false, NULL    , NULL);
+	M("[vdso32]", PERF_RECORD_MISC_CPUMODE_UNKNOWN, false);
+	M("[vdso32]", PERF_RECORD_MISC_KERNEL, false);
+	M("[vdso32]", PERF_RECORD_MISC_USER, false);
+
+	T("[vdsox32]", true      , true     , false, false, "[vdsox32]", NULL);
+	T("[vdsox32]", false     , true     , false, false, NULL    , NULL);
+	T("[vdsox32]", true      , false    , false, false, "[vdsox32]", NULL);
+	T("[vdsox32]", false     , false    , false, false, NULL    , NULL);
+	M("[vdsox32]", PERF_RECORD_MISC_CPUMODE_UNKNOWN, false);
+	M("[vdsox32]", PERF_RECORD_MISC_KERNEL, false);
+	M("[vdsox32]", PERF_RECORD_MISC_USER, false);
+
 	/* path         alloc_name  alloc_ext  kmod   comp   name          ext */
 	T("[vsyscall]", true      , true     , false, false, "[vsyscall]", NULL);
 	T("[vsyscall]", false     , true     , false, false, NULL        , NULL);
diff --git a/tools/perf/tests/parse-events.c b/tools/perf/tests/parse-events.c
index b9ebe15afb13..7d4077068454 100644
--- a/tools/perf/tests/parse-events.c
+++ b/tools/perf/tests/parse-events.c
@@ -499,7 +499,7 @@ static int test__checkevent_pmu_partial_time_callgraph(struct perf_evlist *evlis
 	 * while this test executes only parse events method.
 	 */
 	TEST_ASSERT_VAL("wrong period",     0 == evsel->attr.sample_period);
-	TEST_ASSERT_VAL("wrong callgraph",  !(PERF_SAMPLE_CALLCHAIN & evsel->attr.sample_type));
+	TEST_ASSERT_VAL("wrong callgraph",  !evsel__has_callchain(evsel));
 	TEST_ASSERT_VAL("wrong time",  !(PERF_SAMPLE_TIME & evsel->attr.sample_type));
 
 	/* cpu/config=2,call-graph=no,time=0,period=2000/ */
@@ -512,7 +512,7 @@ static int test__checkevent_pmu_partial_time_callgraph(struct perf_evlist *evlis
 	 * while this test executes only parse events method.
 	 */
 	TEST_ASSERT_VAL("wrong period",     0 == evsel->attr.sample_period);
-	TEST_ASSERT_VAL("wrong callgraph",  !(PERF_SAMPLE_CALLCHAIN & evsel->attr.sample_type));
+	TEST_ASSERT_VAL("wrong callgraph",  !evsel__has_callchain(evsel));
 	TEST_ASSERT_VAL("wrong time",  !(PERF_SAMPLE_TIME & evsel->attr.sample_type));
 
 	return 0;
diff --git a/tools/perf/tests/python-use.c b/tools/perf/tests/python-use.c
index 5d2df65ada6a..40ab72149ce1 100644
--- a/tools/perf/tests/python-use.c
+++ b/tools/perf/tests/python-use.c
@@ -7,8 +7,7 @@
 #include <stdlib.h>
 #include <linux/compiler.h>
 #include "tests.h"
-
-extern int verbose;
+#include "util/debug.h"
 
 int test__python_use(struct test *test __maybe_unused, int subtest __maybe_unused)
 {
diff --git a/tools/perf/tests/shell/record+probe_libc_inet_pton.sh b/tools/perf/tests/shell/record+probe_libc_inet_pton.sh
index 650b208f700f..263057039693 100755
--- a/tools/perf/tests/shell/record+probe_libc_inet_pton.sh
+++ b/tools/perf/tests/shell/record+probe_libc_inet_pton.sh
@@ -11,7 +11,7 @@
 . $(dirname $0)/lib/probe.sh
 
 libc=$(grep -w libc /proc/self/maps | head -1 | sed -r 's/.*[[:space:]](\/.*)/\1/g')
-nm -g $libc 2>/dev/null | fgrep -q inet_pton || exit 254
+nm -Dg $libc 2>/dev/null | fgrep -q inet_pton || exit 254
 
 trace_libc_inet_pton_backtrace() {
 	idx=0
diff --git a/tools/perf/ui/browsers/annotate.c b/tools/perf/ui/browsers/annotate.c
index 8be40fa903aa..3b4f1c10ff57 100644
--- a/tools/perf/ui/browsers/annotate.c
+++ b/tools/perf/ui/browsers/annotate.c
@@ -29,6 +29,7 @@ struct annotate_browser {
 	struct rb_node		   *curr_hot;
 	struct annotation_line	   *selection;
 	struct arch		   *arch;
+	struct annotation_options  *opts;
 	bool			    searching_backwards;
 	char			    search_bf[128];
 };
@@ -410,7 +411,7 @@ static bool annotate_browser__callq(struct annotate_browser *browser,
 	notes = symbol__annotation(dl->ops.target.sym);
 	pthread_mutex_lock(&notes->lock);
 
-	if (notes->src == NULL && symbol__alloc_hist(dl->ops.target.sym) < 0) {
+	if (!symbol__hists(dl->ops.target.sym, evsel->evlist->nr_entries)) {
 		pthread_mutex_unlock(&notes->lock);
 		ui__warning("Not enough memory for annotating '%s' symbol!\n",
 			    dl->ops.target.sym->name);
@@ -418,7 +419,7 @@ static bool annotate_browser__callq(struct annotate_browser *browser,
 	}
 
 	pthread_mutex_unlock(&notes->lock);
-	symbol__tui_annotate(dl->ops.target.sym, ms->map, evsel, hbt);
+	symbol__tui_annotate(dl->ops.target.sym, ms->map, evsel, hbt, browser->opts);
 	sym_title(ms->sym, ms->map, title, sizeof(title));
 	ui_browser__show_title(&browser->b, title);
 	return true;
@@ -817,24 +818,27 @@ static int annotate_browser__run(struct annotate_browser *browser,
 }
 
 int map_symbol__tui_annotate(struct map_symbol *ms, struct perf_evsel *evsel,
-			     struct hist_browser_timer *hbt)
+			     struct hist_browser_timer *hbt,
+			     struct annotation_options *opts)
 {
-	return symbol__tui_annotate(ms->sym, ms->map, evsel, hbt);
+	return symbol__tui_annotate(ms->sym, ms->map, evsel, hbt, opts);
 }
 
 int hist_entry__tui_annotate(struct hist_entry *he, struct perf_evsel *evsel,
-			     struct hist_browser_timer *hbt)
+			     struct hist_browser_timer *hbt,
+			     struct annotation_options *opts)
 {
 	/* reset abort key so that it can get Ctrl-C as a key */
 	SLang_reset_tty();
 	SLang_init_tty(0, 0, 0);
 
-	return map_symbol__tui_annotate(&he->ms, evsel, hbt);
+	return map_symbol__tui_annotate(&he->ms, evsel, hbt, opts);
 }
 
 int symbol__tui_annotate(struct symbol *sym, struct map *map,
 			 struct perf_evsel *evsel,
-			 struct hist_browser_timer *hbt)
+			 struct hist_browser_timer *hbt,
+			 struct annotation_options *opts)
 {
 	struct annotation *notes = symbol__annotation(sym);
 	struct map_symbol ms = {
@@ -851,6 +855,7 @@ int symbol__tui_annotate(struct symbol *sym, struct map *map,
 			.priv	 = &ms,
 			.use_navkeypressed = true,
 		},
+		.opts = opts,
 	};
 	int ret = -1, err;
 
@@ -860,7 +865,7 @@ int symbol__tui_annotate(struct symbol *sym, struct map *map,
 	if (map->dso->annotate_warned)
 		return -1;
 
-	err = symbol__annotate2(sym, map, evsel, &annotation__default_options, &browser.arch);
+	err = symbol__annotate2(sym, map, evsel, opts, &browser.arch);
 	if (err) {
 		char msg[BUFSIZ];
 		symbol__strerror_disassemble(sym, map, err, msg, sizeof(msg));
diff --git a/tools/perf/ui/browsers/hists.c b/tools/perf/ui/browsers/hists.c
index e5f247247daa..a96f62ca984a 100644
--- a/tools/perf/ui/browsers/hists.c
+++ b/tools/perf/ui/browsers/hists.c
@@ -1231,6 +1231,7 @@ static int hist_browser__show_entry(struct hist_browser *browser,
 	int width = browser->b.width;
 	char folded_sign = ' ';
 	bool current_entry = ui_browser__is_current_entry(&browser->b, row);
+	bool use_callchain = hist_entry__has_callchains(entry) && symbol_conf.use_callchain;
 	off_t row_offset = entry->row_offset;
 	bool first = true;
 	struct perf_hpp_fmt *fmt;
@@ -1240,7 +1241,7 @@ static int hist_browser__show_entry(struct hist_browser *browser,
 		browser->selection = &entry->ms;
 	}
 
-	if (symbol_conf.use_callchain) {
+	if (use_callchain) {
 		hist_entry__init_have_children(entry);
 		folded_sign = hist_entry__folded(entry);
 	}
@@ -1276,7 +1277,7 @@ static int hist_browser__show_entry(struct hist_browser *browser,
 			}
 
 			if (first) {
-				if (symbol_conf.use_callchain) {
+				if (use_callchain) {
 					ui_browser__printf(&browser->b, "%c ", folded_sign);
 					width -= 2;
 				}
@@ -1583,7 +1584,7 @@ hists_browser__scnprintf_headers(struct hist_browser *browser, char *buf,
 	int column = 0;
 	int span = 0;
 
-	if (symbol_conf.use_callchain) {
+	if (hists__has_callchains(hists) && symbol_conf.use_callchain) {
 		ret = scnprintf(buf, size, "  ");
 		if (advance_hpp_check(&dummy_hpp, ret))
 			return ret;
@@ -1987,7 +1988,7 @@ static int hist_browser__fprintf_entry(struct hist_browser *browser,
 	bool first = true;
 	int ret;
 
-	if (symbol_conf.use_callchain) {
+	if (hist_entry__has_callchains(he) && symbol_conf.use_callchain) {
 		folded_sign = hist_entry__folded(he);
 		printed += fprintf(fp, "%c ", folded_sign);
 	}
@@ -2175,7 +2176,8 @@ struct hist_browser *hist_browser__new(struct hists *hists)
 static struct hist_browser *
 perf_evsel_browser__new(struct perf_evsel *evsel,
 			struct hist_browser_timer *hbt,
-			struct perf_env *env)
+			struct perf_env *env,
+			struct annotation_options *annotation_opts)
 {
 	struct hist_browser *browser = hist_browser__new(evsel__hists(evsel));
 
@@ -2183,6 +2185,7 @@ perf_evsel_browser__new(struct perf_evsel *evsel,
 		browser->hbt   = hbt;
 		browser->env   = env;
 		browser->title = hists_browser__scnprintf_title;
+		browser->annotation_opts = annotation_opts;
 	}
 	return browser;
 }
@@ -2336,7 +2339,8 @@ do_annotate(struct hist_browser *browser, struct popup_action *act)
 	struct hist_entry *he;
 	int err;
 
-	if (!objdump_path && perf_env__lookup_objdump(browser->env))
+	if (!browser->annotation_opts->objdump_path &&
+	    perf_env__lookup_objdump(browser->env, &browser->annotation_opts->objdump_path))
 		return 0;
 
 	notes = symbol__annotation(act->ms.sym);
@@ -2344,7 +2348,8 @@ do_annotate(struct hist_browser *browser, struct popup_action *act)
 		return 0;
 
 	evsel = hists_to_evsel(browser->hists);
-	err = map_symbol__tui_annotate(&act->ms, evsel, browser->hbt);
+	err = map_symbol__tui_annotate(&act->ms, evsel, browser->hbt,
+				       browser->annotation_opts);
 	he = hist_browser__selected_entry(browser);
 	/*
 	 * offer option to annotate the other branch source or target
@@ -2667,7 +2672,7 @@ static void hist_browser__update_percent_limit(struct hist_browser *hb,
 			he->nr_rows = 0;
 		}
 
-		if (!he->leaf || !symbol_conf.use_callchain)
+		if (!he->leaf || !hist_entry__has_callchains(he) || !symbol_conf.use_callchain)
 			goto next;
 
 		if (callchain_param.mode == CHAIN_GRAPH_REL) {
@@ -2697,10 +2702,11 @@ static int perf_evsel__hists_browse(struct perf_evsel *evsel, int nr_events,
 				    struct hist_browser_timer *hbt,
 				    float min_pcnt,
 				    struct perf_env *env,
-				    bool warn_lost_event)
+				    bool warn_lost_event,
+				    struct annotation_options *annotation_opts)
 {
 	struct hists *hists = evsel__hists(evsel);
-	struct hist_browser *browser = perf_evsel_browser__new(evsel, hbt, env);
+	struct hist_browser *browser = perf_evsel_browser__new(evsel, hbt, env, annotation_opts);
 	struct branch_info *bi;
 #define MAX_OPTIONS  16
 	char *options[MAX_OPTIONS];
@@ -3062,6 +3068,7 @@ static int perf_evsel__hists_browse(struct perf_evsel *evsel, int nr_events,
 struct perf_evsel_menu {
 	struct ui_browser b;
 	struct perf_evsel *selection;
+	struct annotation_options *annotation_opts;
 	bool lost_events, lost_events_warned;
 	float min_pcnt;
 	struct perf_env *env;
@@ -3163,7 +3170,8 @@ static int perf_evsel_menu__run(struct perf_evsel_menu *menu,
 						       true, hbt,
 						       menu->min_pcnt,
 						       menu->env,
-						       warn_lost_event);
+						       warn_lost_event,
+						       menu->annotation_opts);
 			ui_browser__show_title(&menu->b, title);
 			switch (key) {
 			case K_TAB:
@@ -3222,7 +3230,8 @@ static int __perf_evlist__tui_browse_hists(struct perf_evlist *evlist,
 					   struct hist_browser_timer *hbt,
 					   float min_pcnt,
 					   struct perf_env *env,
-					   bool warn_lost_event)
+					   bool warn_lost_event,
+					   struct annotation_options *annotation_opts)
 {
 	struct perf_evsel *pos;
 	struct perf_evsel_menu menu = {
@@ -3237,6 +3246,7 @@ static int __perf_evlist__tui_browse_hists(struct perf_evlist *evlist,
 		},
 		.min_pcnt = min_pcnt,
 		.env = env,
+		.annotation_opts = annotation_opts,
 	};
 
 	ui_helpline__push("Press ESC to exit");
@@ -3257,7 +3267,8 @@ int perf_evlist__tui_browse_hists(struct perf_evlist *evlist, const char *help,
 				  struct hist_browser_timer *hbt,
 				  float min_pcnt,
 				  struct perf_env *env,
-				  bool warn_lost_event)
+				  bool warn_lost_event,
+				  struct annotation_options *annotation_opts)
 {
 	int nr_entries = evlist->nr_entries;
 
@@ -3267,7 +3278,8 @@ int perf_evlist__tui_browse_hists(struct perf_evlist *evlist, const char *help,
 
 		return perf_evsel__hists_browse(first, nr_entries, help,
 						false, hbt, min_pcnt,
-						env, warn_lost_event);
+						env, warn_lost_event,
+						annotation_opts);
 	}
 
 	if (symbol_conf.event_group) {
@@ -3285,5 +3297,6 @@ int perf_evlist__tui_browse_hists(struct perf_evlist *evlist, const char *help,
 
 	return __perf_evlist__tui_browse_hists(evlist, nr_entries, help,
 					       hbt, min_pcnt, env,
-					       warn_lost_event);
+					       warn_lost_event,
+					       annotation_opts);
 }
diff --git a/tools/perf/ui/browsers/hists.h b/tools/perf/ui/browsers/hists.h
index 9428bee076f2..91d3e18b50aa 100644
--- a/tools/perf/ui/browsers/hists.h
+++ b/tools/perf/ui/browsers/hists.h
@@ -4,6 +4,8 @@
 
 #include "ui/browser.h"
 
+struct annotation_options;
+
 struct hist_browser {
 	struct ui_browser   b;
 	struct hists	    *hists;
@@ -12,6 +14,7 @@ struct hist_browser {
 	struct hist_browser_timer *hbt;
 	struct pstack	    *pstack;
 	struct perf_env	    *env;
+	struct annotation_options *annotation_opts;
 	int		     print_seq;
 	bool		     show_dso;
 	bool		     show_headers;
diff --git a/tools/perf/ui/gtk/annotate.c b/tools/perf/ui/gtk/annotate.c
index aeeaf15029f0..48428c9acd89 100644
--- a/tools/perf/ui/gtk/annotate.c
+++ b/tools/perf/ui/gtk/annotate.c
@@ -169,7 +169,7 @@ static int symbol__gtk_annotate(struct symbol *sym, struct map *map,
 	if (map->dso->annotate_warned)
 		return -1;
 
-	err = symbol__annotate(sym, map, evsel, 0, NULL);
+	err = symbol__annotate(sym, map, evsel, 0, &annotation__default_options, NULL);
 	if (err) {
 		char msg[BUFSIZ];
 		symbol__strerror_disassemble(sym, map, err, msg, sizeof(msg));
diff --git a/tools/perf/ui/gtk/hists.c b/tools/perf/ui/gtk/hists.c
index 24e1ec201ffd..b085f1b3e34d 100644
--- a/tools/perf/ui/gtk/hists.c
+++ b/tools/perf/ui/gtk/hists.c
@@ -382,7 +382,8 @@ static void perf_gtk__show_hists(GtkWidget *window, struct hists *hists,
 			gtk_tree_store_set(store, &iter, col_idx++, s, -1);
 		}
 
-		if (symbol_conf.use_callchain && hists__has(hists, sym)) {
+		if (hists__has_callchains(hists) &&
+		    symbol_conf.use_callchain && hists__has(hists, sym)) {
 			if (callchain_param.mode == CHAIN_GRAPH_REL)
 				total = symbol_conf.cumulate_callchain ?
 					h->stat_acc->period : h->stat.period;
@@ -479,7 +480,7 @@ static void perf_gtk__add_hierarchy_entries(struct hists *hists,
 			}
 		}
 
-		if (symbol_conf.use_callchain && he->leaf) {
+		if (he->leaf && hist_entry__has_callchains(he) && symbol_conf.use_callchain) {
 			if (callchain_param.mode == CHAIN_GRAPH_REL)
 				total = symbol_conf.cumulate_callchain ?
 					he->stat_acc->period : he->stat.period;
diff --git a/tools/perf/ui/hist.c b/tools/perf/ui/hist.c
index 706f6f1e9c7d..fe3dfaa64a91 100644
--- a/tools/perf/ui/hist.c
+++ b/tools/perf/ui/hist.c
@@ -207,7 +207,7 @@ static int __hpp__sort_acc(struct hist_entry *a, struct hist_entry *b,
 		if (ret)
 			return ret;
 
-		if (a->thread != b->thread || !symbol_conf.use_callchain)
+		if (a->thread != b->thread || !hist_entry__has_callchains(a) || !symbol_conf.use_callchain)
 			return 0;
 
 		ret = b->callchain->max_depth - a->callchain->max_depth;
diff --git a/tools/perf/ui/stdio/hist.c b/tools/perf/ui/stdio/hist.c
index c1eb476da91b..69b7a28f7a1c 100644
--- a/tools/perf/ui/stdio/hist.c
+++ b/tools/perf/ui/stdio/hist.c
@@ -516,7 +516,7 @@ static int hist_entry__hierarchy_fprintf(struct hist_entry *he,
 	}
 	printed += putc('\n', fp);
 
-	if (symbol_conf.use_callchain && he->leaf) {
+	if (he->leaf && hist_entry__has_callchains(he) && symbol_conf.use_callchain) {
 		u64 total = hists__total_period(hists);
 
 		printed += hist_entry_callchain__fprintf(he, total, 0, fp);
@@ -550,7 +550,7 @@ static int hist_entry__fprintf(struct hist_entry *he, size_t size,
 
 	ret = fprintf(fp, "%s\n", bf);
 
-	if (use_callchain)
+	if (hist_entry__has_callchains(he) && use_callchain)
 		callchain_ret = hist_entry_callchain__fprintf(he, total_period,
 							      0, fp);
 
diff --git a/tools/perf/util/Build b/tools/perf/util/Build
index 5d4c45b76895..b604ef334dc9 100644
--- a/tools/perf/util/Build
+++ b/tools/perf/util/Build
@@ -24,7 +24,6 @@ libperf-y += libstring.o
 libperf-y += bitmap.o
 libperf-y += hweight.o
 libperf-y += smt.o
-libperf-y += quote.o
 libperf-y += strbuf.o
 libperf-y += string.o
 libperf-y += strlist.o
diff --git a/tools/perf/util/annotate.c b/tools/perf/util/annotate.c
index 71897689dacf..f91775b4bc3c 100644
--- a/tools/perf/util/annotate.c
+++ b/tools/perf/util/annotate.c
@@ -21,6 +21,7 @@
 #include "debug.h"
 #include "annotate.h"
 #include "evsel.h"
+#include "evlist.h"
 #include "block-range.h"
 #include "string2.h"
 #include "arch/common.h"
@@ -46,11 +47,10 @@
 struct annotation_options annotation__default_options = {
 	.use_offset     = true,
 	.jump_arrows    = true,
+	.annotate_src	= true,
 	.offset_level	= ANNOTATION__OFFSET_JUMP_TARGETS,
 };
 
-const char 	*disassembler_style;
-const char	*objdump_path;
 static regex_t	 file_lineno;
 
 static struct ins_ops *ins__find(struct arch *arch, const char *name);
@@ -678,10 +678,28 @@ static struct arch *arch__find(const char *name)
 	return bsearch(name, architectures, nmemb, sizeof(struct arch), arch__key_cmp);
 }
 
-int symbol__alloc_hist(struct symbol *sym)
+static struct annotated_source *annotated_source__new(void)
+{
+	struct annotated_source *src = zalloc(sizeof(*src));
+
+	if (src != NULL)
+		INIT_LIST_HEAD(&src->source);
+
+	return src;
+}
+
+static __maybe_unused void annotated_source__delete(struct annotated_source *src)
+{
+	if (src == NULL)
+		return;
+	zfree(&src->histograms);
+	zfree(&src->cycles_hist);
+	free(src);
+}
+
+static int annotated_source__alloc_histograms(struct annotated_source *src,
+					      size_t size, int nr_hists)
 {
-	struct annotation *notes = symbol__annotation(sym);
-	size_t size = symbol__size(sym);
 	size_t sizeof_sym_hist;
 
 	/*
@@ -701,17 +719,13 @@ int symbol__alloc_hist(struct symbol *sym)
 	sizeof_sym_hist = (sizeof(struct sym_hist) + size * sizeof(struct sym_hist_entry));
 
 	/* Check for overflow in zalloc argument */
-	if (sizeof_sym_hist > (SIZE_MAX - sizeof(*notes->src))
-				/ symbol_conf.nr_events)
+	if (sizeof_sym_hist > SIZE_MAX / nr_hists)
 		return -1;
 
-	notes->src = zalloc(sizeof(*notes->src) + symbol_conf.nr_events * sizeof_sym_hist);
-	if (notes->src == NULL)
-		return -1;
-	notes->src->sizeof_sym_hist = sizeof_sym_hist;
-	notes->src->nr_histograms   = symbol_conf.nr_events;
-	INIT_LIST_HEAD(&notes->src->source);
-	return 0;
+	src->sizeof_sym_hist = sizeof_sym_hist;
+	src->nr_histograms   = nr_hists;
+	src->histograms	     = calloc(nr_hists, sizeof_sym_hist) ;
+	return src->histograms ? 0 : -1;
 }
 
 /* The cycles histogram is lazily allocated. */
@@ -741,14 +755,11 @@ void symbol__annotate_zero_histograms(struct symbol *sym)
 	pthread_mutex_unlock(&notes->lock);
 }
 
-static int __symbol__account_cycles(struct annotation *notes,
+static int __symbol__account_cycles(struct cyc_hist *ch,
 				    u64 start,
 				    unsigned offset, unsigned cycles,
 				    unsigned have_start)
 {
-	struct cyc_hist *ch;
-
-	ch = notes->src->cycles_hist;
 	/*
 	 * For now we can only account one basic block per
 	 * final jump. But multiple could be overlapping.
@@ -791,7 +802,7 @@ static int __symbol__account_cycles(struct annotation *notes,
 }
 
 static int __symbol__inc_addr_samples(struct symbol *sym, struct map *map,
-				      struct annotation *notes, int evidx, u64 addr,
+				      struct annotated_source *src, int evidx, u64 addr,
 				      struct perf_sample *sample)
 {
 	unsigned offset;
@@ -807,7 +818,12 @@ static int __symbol__inc_addr_samples(struct symbol *sym, struct map *map,
 	}
 
 	offset = addr - sym->start;
-	h = annotation__histogram(notes, evidx);
+	h = annotated_source__histogram(src, evidx);
+	if (h == NULL) {
+		pr_debug("%s(%d): ENOMEM! sym->name=%s, start=%#" PRIx64 ", addr=%#" PRIx64 ", end=%#" PRIx64 ", func: %d\n",
+			 __func__, __LINE__, sym->name, sym->start, addr, sym->end, sym->type == STT_FUNC);
+		return -ENOMEM;
+	}
 	h->nr_samples++;
 	h->addr[offset].nr_samples++;
 	h->period += sample->period;
@@ -820,45 +836,69 @@ static int __symbol__inc_addr_samples(struct symbol *sym, struct map *map,
 	return 0;
 }
 
-static struct annotation *symbol__get_annotation(struct symbol *sym, bool cycles)
+static struct cyc_hist *symbol__cycles_hist(struct symbol *sym)
 {
 	struct annotation *notes = symbol__annotation(sym);
 
 	if (notes->src == NULL) {
-		if (symbol__alloc_hist(sym) < 0)
+		notes->src = annotated_source__new();
+		if (notes->src == NULL)
 			return NULL;
+		goto alloc_cycles_hist;
+	}
+
+	if (!notes->src->cycles_hist) {
+alloc_cycles_hist:
+		symbol__alloc_hist_cycles(sym);
 	}
-	if (!notes->src->cycles_hist && cycles) {
-		if (symbol__alloc_hist_cycles(sym) < 0)
+
+	return notes->src->cycles_hist;
+}
+
+struct annotated_source *symbol__hists(struct symbol *sym, int nr_hists)
+{
+	struct annotation *notes = symbol__annotation(sym);
+
+	if (notes->src == NULL) {
+		notes->src = annotated_source__new();
+		if (notes->src == NULL)
 			return NULL;
+		goto alloc_histograms;
 	}
-	return notes;
+
+	if (notes->src->histograms == NULL) {
+alloc_histograms:
+		annotated_source__alloc_histograms(notes->src, symbol__size(sym),
+						   nr_hists);
+	}
+
+	return notes->src;
 }
 
 static int symbol__inc_addr_samples(struct symbol *sym, struct map *map,
-				    int evidx, u64 addr,
+				    struct perf_evsel *evsel, u64 addr,
 				    struct perf_sample *sample)
 {
-	struct annotation *notes;
+	struct annotated_source *src;
 
 	if (sym == NULL)
 		return 0;
-	notes = symbol__get_annotation(sym, false);
-	if (notes == NULL)
+	src = symbol__hists(sym, evsel->evlist->nr_entries);
+	if (src == NULL)
 		return -ENOMEM;
-	return __symbol__inc_addr_samples(sym, map, notes, evidx, addr, sample);
+	return __symbol__inc_addr_samples(sym, map, src, evsel->idx, addr, sample);
 }
 
 static int symbol__account_cycles(u64 addr, u64 start,
 				  struct symbol *sym, unsigned cycles)
 {
-	struct annotation *notes;
+	struct cyc_hist *cycles_hist;
 	unsigned offset;
 
 	if (sym == NULL)
 		return 0;
-	notes = symbol__get_annotation(sym, true);
-	if (notes == NULL)
+	cycles_hist = symbol__cycles_hist(sym);
+	if (cycles_hist == NULL)
 		return -ENOMEM;
 	if (addr < sym->start || addr >= sym->end)
 		return -ERANGE;
@@ -870,7 +910,7 @@ static int symbol__account_cycles(u64 addr, u64 start,
 			start = 0;
 	}
 	offset = addr - sym->start;
-	return __symbol__account_cycles(notes,
+	return __symbol__account_cycles(cycles_hist,
 					start ? start - sym->start : 0,
 					offset, cycles,
 					!!start);
@@ -974,15 +1014,15 @@ void annotation__compute_ipc(struct annotation *notes, size_t size)
 }
 
 int addr_map_symbol__inc_samples(struct addr_map_symbol *ams, struct perf_sample *sample,
-				 int evidx)
+				 struct perf_evsel *evsel)
 {
-	return symbol__inc_addr_samples(ams->sym, ams->map, evidx, ams->al_addr, sample);
+	return symbol__inc_addr_samples(ams->sym, ams->map, evsel, ams->al_addr, sample);
 }
 
 int hist_entry__inc_addr_samples(struct hist_entry *he, struct perf_sample *sample,
-				 int evidx, u64 ip)
+				 struct perf_evsel *evsel, u64 ip)
 {
-	return symbol__inc_addr_samples(he->ms.sym, he->ms.map, evidx, ip, sample);
+	return symbol__inc_addr_samples(he->ms.sym, he->ms.map, evsel, ip, sample);
 }
 
 static void disasm_line__init_ins(struct disasm_line *dl, struct arch *arch, struct map_symbol *ms)
@@ -1031,6 +1071,7 @@ struct annotate_args {
 	struct arch		*arch;
 	struct map_symbol	 ms;
 	struct perf_evsel	*evsel;
+	struct annotation_options *options;
 	s64			 offset;
 	char			*line;
 	int			 line_nr;
@@ -1572,6 +1613,7 @@ static int dso__disassemble_filename(struct dso *dso, char *filename, size_t fil
 
 static int symbol__disassemble(struct symbol *sym, struct annotate_args *args)
 {
+	struct annotation_options *opts = args->options;
 	struct map *map = args->ms.map;
 	struct dso *dso = map->dso;
 	char *command;
@@ -1619,13 +1661,13 @@ static int symbol__disassemble(struct symbol *sym, struct annotate_args *args)
 		 "%s %s%s --start-address=0x%016" PRIx64
 		 " --stop-address=0x%016" PRIx64
 		 " -l -d %s %s -C \"%s\" 2>/dev/null|grep -v \"%s:\"|expand",
-		 objdump_path ? objdump_path : "objdump",
-		 disassembler_style ? "-M " : "",
-		 disassembler_style ? disassembler_style : "",
+		 opts->objdump_path ?: "objdump",
+		 opts->disassembler_style ? "-M " : "",
+		 opts->disassembler_style ?: "",
 		 map__rip_2objdump(map, sym->start),
 		 map__rip_2objdump(map, sym->end),
-		 symbol_conf.annotate_asm_raw ? "" : "--no-show-raw",
-		 symbol_conf.annotate_src ? "-S" : "",
+		 opts->show_asm_raw ? "" : "--no-show-raw",
+		 opts->annotate_src ? "-S" : "",
 		 symfs_filename, symfs_filename);
 
 	if (err < 0) {
@@ -1767,11 +1809,13 @@ void symbol__calc_percent(struct symbol *sym, struct perf_evsel *evsel)
 
 int symbol__annotate(struct symbol *sym, struct map *map,
 		     struct perf_evsel *evsel, size_t privsize,
+		     struct annotation_options *options,
 		     struct arch **parch)
 {
 	struct annotate_args args = {
 		.privsize	= privsize,
 		.evsel		= evsel,
+		.options	= options,
 	};
 	struct perf_env *env = perf_evsel__env(evsel);
 	const char *arch_name = perf_env__arch(env);
@@ -1949,8 +1993,8 @@ static int annotated_source__addr_fmt_width(struct list_head *lines, u64 start)
 }
 
 int symbol__annotate_printf(struct symbol *sym, struct map *map,
-			    struct perf_evsel *evsel, bool full_paths,
-			    int min_pcnt, int max_lines, int context)
+			    struct perf_evsel *evsel,
+			    struct annotation_options *opts)
 {
 	struct dso *dso = map->dso;
 	char *filename;
@@ -1962,6 +2006,7 @@ int symbol__annotate_printf(struct symbol *sym, struct map *map,
 	u64 start = map__rip_2objdump(map, sym->start);
 	int printed = 2, queue_len = 0, addr_fmt_width;
 	int more = 0;
+	bool context = opts->context;
 	u64 len;
 	int width = symbol_conf.show_total_period ? 12 : 8;
 	int graph_dotted_len;
@@ -1971,7 +2016,7 @@ int symbol__annotate_printf(struct symbol *sym, struct map *map,
 	if (!filename)
 		return -ENOMEM;
 
-	if (full_paths)
+	if (opts->full_path)
 		d_filename = filename;
 	else
 		d_filename = basename(filename);
@@ -2006,7 +2051,7 @@ int symbol__annotate_printf(struct symbol *sym, struct map *map,
 		}
 
 		err = annotation_line__print(pos, sym, start, evsel, len,
-					     min_pcnt, printed, max_lines,
+					     opts->min_pcnt, printed, opts->max_lines,
 					     queue, addr_fmt_width);
 
 		switch (err) {
@@ -2339,20 +2384,19 @@ static void symbol__calc_lines(struct symbol *sym, struct map *map,
 }
 
 int symbol__tty_annotate2(struct symbol *sym, struct map *map,
-			  struct perf_evsel *evsel, bool print_lines,
-			  bool full_paths)
+			  struct perf_evsel *evsel,
+			  struct annotation_options *opts)
 {
 	struct dso *dso = map->dso;
 	struct rb_root source_line = RB_ROOT;
-	struct annotation_options opts = annotation__default_options;
 	struct annotation *notes = symbol__annotation(sym);
 	char buf[1024];
 
-	if (symbol__annotate2(sym, map, evsel, &opts, NULL) < 0)
+	if (symbol__annotate2(sym, map, evsel, opts, NULL) < 0)
 		return -1;
 
-	if (print_lines) {
-		srcline_full_filename = full_paths;
+	if (opts->print_lines) {
+		srcline_full_filename = opts->full_path;
 		symbol__calc_lines(sym, map, &source_line);
 		print_summary(&source_line, dso->long_name);
 	}
@@ -2367,25 +2411,24 @@ int symbol__tty_annotate2(struct symbol *sym, struct map *map,
 }
 
 int symbol__tty_annotate(struct symbol *sym, struct map *map,
-			 struct perf_evsel *evsel, bool print_lines,
-			 bool full_paths, int min_pcnt, int max_lines)
+			 struct perf_evsel *evsel,
+			 struct annotation_options *opts)
 {
 	struct dso *dso = map->dso;
 	struct rb_root source_line = RB_ROOT;
 
-	if (symbol__annotate(sym, map, evsel, 0, NULL) < 0)
+	if (symbol__annotate(sym, map, evsel, 0, opts, NULL) < 0)
 		return -1;
 
 	symbol__calc_percent(sym, evsel);
 
-	if (print_lines) {
-		srcline_full_filename = full_paths;
+	if (opts->print_lines) {
+		srcline_full_filename = opts->full_path;
 		symbol__calc_lines(sym, map, &source_line);
 		print_summary(&source_line, dso->long_name);
 	}
 
-	symbol__annotate_printf(sym, map, evsel, full_paths,
-				min_pcnt, max_lines, 0);
+	symbol__annotate_printf(sym, map, evsel, opts);
 
 	annotated_source__purge(symbol__annotation(sym)->src);
 
@@ -2620,7 +2663,7 @@ int symbol__annotate2(struct symbol *sym, struct map *map, struct perf_evsel *ev
 	if (perf_evsel__is_group_event(evsel))
 		nr_pcnt = evsel->nr_members;
 
-	err = symbol__annotate(sym, map, evsel, 0, parch);
+	err = symbol__annotate(sym, map, evsel, 0, options, parch);
 	if (err)
 		goto out_free_offsets;
 
diff --git a/tools/perf/util/annotate.h b/tools/perf/util/annotate.h
index 5080b6dd98b8..a4c0d91907e6 100644
--- a/tools/perf/util/annotate.h
+++ b/tools/perf/util/annotate.h
@@ -67,12 +67,21 @@ struct annotation_options {
 	bool hide_src_code,
 	     use_offset,
 	     jump_arrows,
+	     print_lines,
+	     full_path,
 	     show_linenr,
 	     show_nr_jumps,
 	     show_nr_samples,
 	     show_total_period,
-	     show_minmax_cycle;
+	     show_minmax_cycle,
+	     show_asm_raw,
+	     annotate_src;
 	u8   offset_level;
+	int  min_pcnt;
+	int  max_lines;
+	int  context;
+	const char *objdump_path;
+	const char *disassembler_style;
 };
 
 enum {
@@ -201,7 +210,11 @@ struct cyc_hist {
 
 /** struct annotated_source - symbols with hits have this attached as in sannotation
  *
- * @histogram: Array of addr hit histograms per event being monitored
+ * @histograms: Array of addr hit histograms per event being monitored
+ * nr_histograms: This may not be the same as evsel->evlist->nr_entries if
+ * 		  we have more than a group in a evlist, where we will want
+ * 		  to see each group separately, that is why symbol__annotate2()
+ * 		  sets src->nr_histograms to evsel->nr_members.
  * @lines: If 'print_lines' is specified, per source code line percentages
  * @source: source parsed from a disassembler like objdump -dS
  * @cyc_hist: Average cycles per basic block
@@ -217,7 +230,7 @@ struct annotated_source {
 	int    		   nr_histograms;
 	size_t		   sizeof_sym_hist;
 	struct cyc_hist	   *cycles_hist;
-	struct sym_hist	   histograms[0];
+	struct sym_hist	   *histograms;
 };
 
 struct annotation {
@@ -267,10 +280,14 @@ void annotation__mark_jump_targets(struct annotation *notes, struct symbol *sym)
 void annotation__update_column_widths(struct annotation *notes);
 void annotation__init_column_widths(struct annotation *notes, struct symbol *sym);
 
+static inline struct sym_hist *annotated_source__histogram(struct annotated_source *src, int idx)
+{
+	return ((void *)src->histograms) + (src->sizeof_sym_hist * idx);
+}
+
 static inline struct sym_hist *annotation__histogram(struct annotation *notes, int idx)
 {
-	return (((void *)&notes->src->histograms) +
-	 	(notes->src->sizeof_sym_hist * idx));
+	return annotated_source__histogram(notes->src, idx);
 }
 
 static inline struct annotation *symbol__annotation(struct symbol *sym)
@@ -279,20 +296,21 @@ static inline struct annotation *symbol__annotation(struct symbol *sym)
 }
 
 int addr_map_symbol__inc_samples(struct addr_map_symbol *ams, struct perf_sample *sample,
-				 int evidx);
+				 struct perf_evsel *evsel);
 
 int addr_map_symbol__account_cycles(struct addr_map_symbol *ams,
 				    struct addr_map_symbol *start,
 				    unsigned cycles);
 
 int hist_entry__inc_addr_samples(struct hist_entry *he, struct perf_sample *sample,
-				 int evidx, u64 addr);
+				 struct perf_evsel *evsel, u64 addr);
 
-int symbol__alloc_hist(struct symbol *sym);
+struct annotated_source *symbol__hists(struct symbol *sym, int nr_hists);
 void symbol__annotate_zero_histograms(struct symbol *sym);
 
 int symbol__annotate(struct symbol *sym, struct map *map,
 		     struct perf_evsel *evsel, size_t privsize,
+		     struct annotation_options *options,
 		     struct arch **parch);
 int symbol__annotate2(struct symbol *sym, struct map *map,
 		      struct perf_evsel *evsel,
@@ -320,8 +338,8 @@ int symbol__strerror_disassemble(struct symbol *sym, struct map *map,
 				 int errnum, char *buf, size_t buflen);
 
 int symbol__annotate_printf(struct symbol *sym, struct map *map,
-			    struct perf_evsel *evsel, bool full_paths,
-			    int min_pcnt, int max_lines, int context);
+			    struct perf_evsel *evsel,
+			    struct annotation_options *options);
 int symbol__annotate_fprintf2(struct symbol *sym, FILE *fp);
 void symbol__annotate_zero_histogram(struct symbol *sym, int evidx);
 void symbol__annotate_decay_histogram(struct symbol *sym, int evidx);
@@ -332,30 +350,27 @@ int map_symbol__annotation_dump(struct map_symbol *ms, struct perf_evsel *evsel)
 bool ui__has_annotation(void);
 
 int symbol__tty_annotate(struct symbol *sym, struct map *map,
-			 struct perf_evsel *evsel, bool print_lines,
-			 bool full_paths, int min_pcnt, int max_lines);
+			 struct perf_evsel *evsel, struct annotation_options *opts);
 
 int symbol__tty_annotate2(struct symbol *sym, struct map *map,
-			  struct perf_evsel *evsel, bool print_lines,
-			  bool full_paths);
+			  struct perf_evsel *evsel, struct annotation_options *opts);
 
 #ifdef HAVE_SLANG_SUPPORT
 int symbol__tui_annotate(struct symbol *sym, struct map *map,
 			 struct perf_evsel *evsel,
-			 struct hist_browser_timer *hbt);
+			 struct hist_browser_timer *hbt,
+			 struct annotation_options *opts);
 #else
 static inline int symbol__tui_annotate(struct symbol *sym __maybe_unused,
 				struct map *map __maybe_unused,
 				struct perf_evsel *evsel  __maybe_unused,
-				struct hist_browser_timer *hbt
-				__maybe_unused)
+				struct hist_browser_timer *hbt __maybe_unused,
+				struct annotation_options *opts __maybe_unused)
 {
 	return 0;
 }
 #endif
 
-extern const char	*disassembler_style;
-
 void annotation_config__init(void);
 
 #endif	/* __PERF_ANNOTATE_H */
diff --git a/tools/perf/util/cgroup.c b/tools/perf/util/cgroup.c
index decb91f9da82..ccd02634a616 100644
--- a/tools/perf/util/cgroup.c
+++ b/tools/perf/util/cgroup.c
@@ -93,20 +93,17 @@ static int open_cgroup(const char *name)
 static struct cgroup *evlist__find_cgroup(struct perf_evlist *evlist, const char *str)
 {
 	struct perf_evsel *counter;
-	struct cgroup *cgrp = NULL;
 	/*
 	 * check if cgrp is already defined, if so we reuse it
 	 */
 	evlist__for_each_entry(evlist, counter) {
 		if (!counter->cgrp)
 			continue;
-		if (!strcmp(counter->cgrp->name, str)) {
-			cgrp = cgroup__get(counter->cgrp);
-			break;
-		}
+		if (!strcmp(counter->cgrp->name, str))
+			return cgroup__get(counter->cgrp);
 	}
 
-	return cgrp;
+	return NULL;
 }
 
 static struct cgroup *cgroup__new(const char *name)
diff --git a/tools/perf/util/dso.c b/tools/perf/util/dso.c
index cdfc2e5f55f5..51cf82cf1882 100644
--- a/tools/perf/util/dso.c
+++ b/tools/perf/util/dso.c
@@ -354,6 +354,8 @@ int __kmod_path__parse(struct kmod_path *m, const char *path,
 		if ((strncmp(name, "[kernel.kallsyms]", 17) == 0) ||
 		    (strncmp(name, "[guest.kernel.kallsyms", 22) == 0) ||
 		    (strncmp(name, "[vdso]", 6) == 0) ||
+		    (strncmp(name, "[vdso32]", 8) == 0) ||
+		    (strncmp(name, "[vdsox32]", 9) == 0) ||
 		    (strncmp(name, "[vsyscall]", 10) == 0)) {
 			m->kmod = false;
 
diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
index 150db5ed7400..94fce4f537e9 100644
--- a/tools/perf/util/evsel.c
+++ b/tools/perf/util/evsel.c
@@ -2197,7 +2197,7 @@ int perf_evsel__parse_sample(struct perf_evsel *evsel, union perf_event *event,
 		}
 	}
 
-	if (type & PERF_SAMPLE_CALLCHAIN) {
+	if (evsel__has_callchain(evsel)) {
 		const u64 max_callchain_nr = UINT64_MAX / sizeof(u64);
 
 		OVERFLOW_CHECK_u64(array);
@@ -2857,7 +2857,7 @@ int perf_evsel__open_strerror(struct perf_evsel *evsel, struct target *target,
 			 "Hint: Try again after reducing the number of events.\n"
 			 "Hint: Try increasing the limit with 'ulimit -n <limit>'");
 	case ENOMEM:
-		if ((evsel->attr.sample_type & PERF_SAMPLE_CALLCHAIN) != 0 &&
+		if (evsel__has_callchain(evsel) &&
 		    access("/proc/sys/kernel/perf_event_max_stack", F_OK) == 0)
 			return scnprintf(msg, size,
 					 "Not enough memory to setup event with callchain.\n"
diff --git a/tools/perf/util/evsel.h b/tools/perf/util/evsel.h
index b13f5f234c8f..d277930b19a1 100644
--- a/tools/perf/util/evsel.h
+++ b/tools/perf/util/evsel.h
@@ -459,6 +459,11 @@ static inline bool perf_evsel__has_branch_callstack(const struct perf_evsel *evs
 	return evsel->attr.branch_sample_type & PERF_SAMPLE_BRANCH_CALL_STACK;
 }
 
+static inline bool evsel__has_callchain(const struct perf_evsel *evsel)
+{
+	return (evsel->attr.sample_type & PERF_SAMPLE_CALLCHAIN) != 0;
+}
+
 typedef int (*attr__fprintf_f)(FILE *, const char *, const char *, void *);
 
 int perf_event_attr__fprintf(FILE *fp, struct perf_event_attr *attr,
diff --git a/tools/perf/util/header.c b/tools/perf/util/header.c
index a8bff2178fbc..540cd2dcd3e7 100644
--- a/tools/perf/util/header.c
+++ b/tools/perf/util/header.c
@@ -1459,8 +1459,24 @@ static void print_cmdline(struct feat_fd *ff, FILE *fp)
 
 	fprintf(fp, "# cmdline : ");
 
-	for (i = 0; i < nr; i++)
-		fprintf(fp, "%s ", ff->ph->env.cmdline_argv[i]);
+	for (i = 0; i < nr; i++) {
+		char *argv_i = strdup(ff->ph->env.cmdline_argv[i]);
+		if (!argv_i) {
+			fprintf(fp, "%s ", ff->ph->env.cmdline_argv[i]);
+		} else {
+			char *mem = argv_i;
+			do {
+				char *quote = strchr(argv_i, '\'');
+				if (!quote)
+					break;
+				*quote++ = '\0';
+				fprintf(fp, "%s\\\'", argv_i);
+				argv_i = quote;
+			} while (1);
+			fprintf(fp, "%s ", argv_i);
+			free(mem);
+		}
+	}
 	fputc('\n', fp);
 }
 
@@ -3312,8 +3328,6 @@ int perf_session__read_header(struct perf_session *session)
 		lseek(fd, tmp, SEEK_SET);
 	}
 
-	symbol_conf.nr_events = nr_attrs;
-
 	perf_header__process_sections(header, fd, &session->tevent,
 				      perf_file_section__process);
 
@@ -3739,8 +3753,6 @@ int perf_event__process_attr(struct perf_tool *tool __maybe_unused,
 		perf_evlist__id_add(evlist, evsel, 0, i, event->attr.id[i]);
 	}
 
-	symbol_conf.nr_events = evlist->nr_entries;
-
 	return 0;
 }
 
diff --git a/tools/perf/util/hist.c b/tools/perf/util/hist.c
index 4d602fba40b2..52e8fda93a47 100644
--- a/tools/perf/util/hist.c
+++ b/tools/perf/util/hist.c
@@ -410,7 +410,7 @@ static int hist_entry__init(struct hist_entry *he,
 		map__get(he->mem_info->daddr.map);
 	}
 
-	if (symbol_conf.use_callchain)
+	if (hist_entry__has_callchains(he) && symbol_conf.use_callchain)
 		callchain_init(he->callchain);
 
 	if (he->raw_data) {
@@ -492,7 +492,7 @@ static u8 symbol__parent_filter(const struct symbol *parent)
 
 static void hist_entry__add_callchain_period(struct hist_entry *he, u64 period)
 {
-	if (!symbol_conf.use_callchain)
+	if (!hist_entry__has_callchains(he) || !symbol_conf.use_callchain)
 		return;
 
 	he->hists->callchain_period += period;
@@ -986,7 +986,7 @@ iter_add_next_cumulative_entry(struct hist_entry_iter *iter,
 	iter->he = he;
 	he_cache[iter->curr++] = he;
 
-	if (symbol_conf.use_callchain)
+	if (hist_entry__has_callchains(he) && symbol_conf.use_callchain)
 		callchain_append(he->callchain, &cursor, sample->period);
 	return 0;
 }
@@ -1039,7 +1039,7 @@ int hist_entry_iter__add(struct hist_entry_iter *iter, struct addr_location *al,
 	int err, err2;
 	struct map *alm = NULL;
 
-	if (al && al->map)
+	if (al)
 		alm = map__get(al->map);
 
 	err = sample__resolve_callchain(iter->sample, &callchain_cursor, &iter->parent,
@@ -1373,7 +1373,8 @@ static int hists__hierarchy_insert_entry(struct hists *hists,
 	if (new_he) {
 		new_he->leaf = true;
 
-		if (symbol_conf.use_callchain) {
+		if (hist_entry__has_callchains(new_he) &&
+		    symbol_conf.use_callchain) {
 			callchain_cursor_reset(&callchain_cursor);
 			if (callchain_merge(&callchain_cursor,
 					    new_he->callchain,
@@ -1414,7 +1415,7 @@ static int hists__collapse_insert_entry(struct hists *hists,
 			if (symbol_conf.cumulate_callchain)
 				he_stat__add_stat(iter->stat_acc, he->stat_acc);
 
-			if (symbol_conf.use_callchain) {
+			if (hist_entry__has_callchains(he) && symbol_conf.use_callchain) {
 				callchain_cursor_reset(&callchain_cursor);
 				if (callchain_merge(&callchain_cursor,
 						    iter->callchain,
@@ -1757,7 +1758,7 @@ void perf_evsel__output_resort(struct perf_evsel *evsel, struct ui_progress *pro
 	bool use_callchain;
 
 	if (evsel && symbol_conf.use_callchain && !symbol_conf.show_ref_callgraph)
-		use_callchain = evsel->attr.sample_type & PERF_SAMPLE_CALLCHAIN;
+		use_callchain = evsel__has_callchain(evsel);
 	else
 		use_callchain = symbol_conf.use_callchain;
 
diff --git a/tools/perf/util/hist.h b/tools/perf/util/hist.h
index fbabfd8a215d..06607c434949 100644
--- a/tools/perf/util/hist.h
+++ b/tools/perf/util/hist.h
@@ -220,6 +220,12 @@ static inline struct hists *evsel__hists(struct perf_evsel *evsel)
 	return &hevsel->hists;
 }
 
+static __pure inline bool hists__has_callchains(struct hists *hists)
+{
+	const struct perf_evsel *evsel = hists_to_evsel(hists);
+	return evsel__has_callchain(evsel);
+}
+
 int hists__init(void);
 int __hists__init(struct hists *hists, struct perf_hpp_list *hpp_list);
 
@@ -419,19 +425,24 @@ struct hist_browser_timer {
 	int refresh;
 };
 
+struct annotation_options;
+
 #ifdef HAVE_SLANG_SUPPORT
 #include "../ui/keysyms.h"
 int map_symbol__tui_annotate(struct map_symbol *ms, struct perf_evsel *evsel,
-			     struct hist_browser_timer *hbt);
+			     struct hist_browser_timer *hbt,
+			     struct annotation_options *annotation_opts);
 
 int hist_entry__tui_annotate(struct hist_entry *he, struct perf_evsel *evsel,
-			     struct hist_browser_timer *hbt);
+			     struct hist_browser_timer *hbt,
+			     struct annotation_options *annotation_opts);
 
 int perf_evlist__tui_browse_hists(struct perf_evlist *evlist, const char *help,
 				  struct hist_browser_timer *hbt,
 				  float min_pcnt,
 				  struct perf_env *env,
-				  bool warn_lost_event);
+				  bool warn_lost_event,
+				  struct annotation_options *annotation_options);
 int script_browse(const char *script_opt);
 #else
 static inline
@@ -440,20 +451,23 @@ int perf_evlist__tui_browse_hists(struct perf_evlist *evlist __maybe_unused,
 				  struct hist_browser_timer *hbt __maybe_unused,
 				  float min_pcnt __maybe_unused,
 				  struct perf_env *env __maybe_unused,
-				  bool warn_lost_event __maybe_unused)
+				  bool warn_lost_event __maybe_unused,
+				  struct annotation_options *annotation_options __maybe_unused)
 {
 	return 0;
 }
 static inline int map_symbol__tui_annotate(struct map_symbol *ms __maybe_unused,
 					   struct perf_evsel *evsel __maybe_unused,
-					   struct hist_browser_timer *hbt __maybe_unused)
+					   struct hist_browser_timer *hbt __maybe_unused,
+					   struct annotation_options *annotation_options __maybe_unused)
 {
 	return 0;
 }
 
 static inline int hist_entry__tui_annotate(struct hist_entry *he __maybe_unused,
 					   struct perf_evsel *evsel __maybe_unused,
-					   struct hist_browser_timer *hbt __maybe_unused)
+					   struct hist_browser_timer *hbt __maybe_unused,
+					   struct annotation_options *annotation_opts __maybe_unused)
 {
 	return 0;
 }
diff --git a/tools/perf/util/intel-pt-decoder/intel-pt-decoder.c b/tools/perf/util/intel-pt-decoder/intel-pt-decoder.c
index f9157aed1289..d404bed7003a 100644
--- a/tools/perf/util/intel-pt-decoder/intel-pt-decoder.c
+++ b/tools/perf/util/intel-pt-decoder/intel-pt-decoder.c
@@ -113,6 +113,7 @@ struct intel_pt_decoder {
 	bool have_cyc;
 	bool fixup_last_mtc;
 	bool have_last_ip;
+	enum intel_pt_param_flags flags;
 	uint64_t pos;
 	uint64_t last_ip;
 	uint64_t ip;
@@ -226,6 +227,8 @@ struct intel_pt_decoder *intel_pt_decoder_new(struct intel_pt_params *params)
 	decoder->return_compression = params->return_compression;
 	decoder->branch_enable      = params->branch_enable;
 
+	decoder->flags              = params->flags;
+
 	decoder->period             = params->period;
 	decoder->period_type        = params->period_type;
 
@@ -1097,6 +1100,15 @@ static bool intel_pt_fup_event(struct intel_pt_decoder *decoder)
 	return ret;
 }
 
+static inline bool intel_pt_fup_with_nlip(struct intel_pt_decoder *decoder,
+					  struct intel_pt_insn *intel_pt_insn,
+					  uint64_t ip, int err)
+{
+	return decoder->flags & INTEL_PT_FUP_WITH_NLIP && !err &&
+	       intel_pt_insn->branch == INTEL_PT_BR_INDIRECT &&
+	       ip == decoder->ip + intel_pt_insn->length;
+}
+
 static int intel_pt_walk_fup(struct intel_pt_decoder *decoder)
 {
 	struct intel_pt_insn intel_pt_insn;
@@ -1109,10 +1121,11 @@ static int intel_pt_walk_fup(struct intel_pt_decoder *decoder)
 		err = intel_pt_walk_insn(decoder, &intel_pt_insn, ip);
 		if (err == INTEL_PT_RETURN)
 			return 0;
-		if (err == -EAGAIN) {
+		if (err == -EAGAIN ||
+		    intel_pt_fup_with_nlip(decoder, &intel_pt_insn, ip, err)) {
 			if (intel_pt_fup_event(decoder))
 				return 0;
-			return err;
+			return -EAGAIN;
 		}
 		decoder->set_fup_tx_flags = false;
 		if (err)
@@ -1376,7 +1389,6 @@ static int intel_pt_overflow(struct intel_pt_decoder *decoder)
 {
 	intel_pt_log("ERROR: Buffer overflow\n");
 	intel_pt_clear_tx_flags(decoder);
-	decoder->have_tma = false;
 	decoder->cbr = 0;
 	decoder->timestamp_insn_cnt = 0;
 	decoder->pkt_state = INTEL_PT_STATE_ERR_RESYNC;
@@ -1604,7 +1616,6 @@ static int intel_pt_walk_fup_tip(struct intel_pt_decoder *decoder)
 		case INTEL_PT_PSB:
 		case INTEL_PT_TSC:
 		case INTEL_PT_TMA:
-		case INTEL_PT_CBR:
 		case INTEL_PT_MODE_TSX:
 		case INTEL_PT_BAD:
 		case INTEL_PT_PSBEND:
@@ -1620,6 +1631,10 @@ static int intel_pt_walk_fup_tip(struct intel_pt_decoder *decoder)
 			decoder->pkt_step = 0;
 			return -ENOENT;
 
+		case INTEL_PT_CBR:
+			intel_pt_calc_cbr(decoder);
+			break;
+
 		case INTEL_PT_OVF:
 			return intel_pt_overflow(decoder);
 
diff --git a/tools/perf/util/intel-pt-decoder/intel-pt-decoder.h b/tools/perf/util/intel-pt-decoder/intel-pt-decoder.h
index fc1752d50019..51c18d67f4ca 100644
--- a/tools/perf/util/intel-pt-decoder/intel-pt-decoder.h
+++ b/tools/perf/util/intel-pt-decoder/intel-pt-decoder.h
@@ -60,6 +60,14 @@ enum {
 	INTEL_PT_ERR_MAX,
 };
 
+enum intel_pt_param_flags {
+	/*
+	 * FUP packet can contain next linear instruction pointer instead of
+	 * current linear instruction pointer.
+	 */
+	INTEL_PT_FUP_WITH_NLIP	= 1 << 0,
+};
+
 struct intel_pt_state {
 	enum intel_pt_sample_type type;
 	int err;
@@ -106,6 +114,7 @@ struct intel_pt_params {
 	unsigned int mtc_period;
 	uint32_t tsc_ctc_ratio_n;
 	uint32_t tsc_ctc_ratio_d;
+	enum intel_pt_param_flags flags;
 };
 
 struct intel_pt_decoder;
diff --git a/tools/perf/util/intel-pt.c b/tools/perf/util/intel-pt.c
index 492986a25ef6..aec68908d604 100644
--- a/tools/perf/util/intel-pt.c
+++ b/tools/perf/util/intel-pt.c
@@ -749,6 +749,7 @@ static struct intel_pt_queue *intel_pt_alloc_queue(struct intel_pt *pt,
 						   unsigned int queue_nr)
 {
 	struct intel_pt_params params = { .get_trace = 0, };
+	struct perf_env *env = pt->machine->env;
 	struct intel_pt_queue *ptq;
 
 	ptq = zalloc(sizeof(struct intel_pt_queue));
@@ -830,6 +831,9 @@ static struct intel_pt_queue *intel_pt_alloc_queue(struct intel_pt *pt,
 		}
 	}
 
+	if (env->cpuid && !strncmp(env->cpuid, "GenuineIntel,6,92,", 18))
+		params.flags |= INTEL_PT_FUP_WITH_NLIP;
+
 	ptq->decoder = intel_pt_decoder_new(&params);
 	if (!ptq->decoder)
 		goto out_free;
@@ -1521,6 +1525,7 @@ static int intel_pt_sample(struct intel_pt_queue *ptq)
 
 	if (intel_pt_is_switch_ip(ptq, state->to_ip)) {
 		switch (ptq->switch_state) {
+		case INTEL_PT_SS_NOT_TRACING:
 		case INTEL_PT_SS_UNKNOWN:
 		case INTEL_PT_SS_EXPECTING_SWITCH_IP:
 			err = intel_pt_next_tid(pt, ptq);
diff --git a/tools/perf/util/map.c b/tools/perf/util/map.c
index 6ae97eda370b..89ac5b5dc218 100644
--- a/tools/perf/util/map.c
+++ b/tools/perf/util/map.c
@@ -415,16 +415,20 @@ size_t map__fprintf_dsoname(struct map *map, FILE *fp)
 	return fprintf(fp, "%s", dsoname);
 }
 
+char *map__srcline(struct map *map, u64 addr, struct symbol *sym)
+{
+	if (map == NULL)
+		return SRCLINE_UNKNOWN;
+	return get_srcline(map->dso, map__rip_2objdump(map, addr), sym, true, true, addr);
+}
+
 int map__fprintf_srcline(struct map *map, u64 addr, const char *prefix,
 			 FILE *fp)
 {
-	char *srcline;
 	int ret = 0;
 
 	if (map && map->dso) {
-		srcline = get_srcline(map->dso,
-				      map__rip_2objdump(map, addr), NULL,
-				      true, true, addr);
+		char *srcline = map__srcline(map, addr, NULL);
 		if (srcline != SRCLINE_UNKNOWN)
 			ret = fprintf(fp, "%s%s", prefix, srcline);
 		free_srcline(srcline);
@@ -445,6 +449,20 @@ int map__fprintf_srcline(struct map *map, u64 addr, const char *prefix,
  */
 u64 map__rip_2objdump(struct map *map, u64 rip)
 {
+	struct kmap *kmap = __map__kmap(map);
+
+	/*
+	 * vmlinux does not have program headers for PTI entry trampolines and
+	 * kcore may not either. However the trampoline object code is on the
+	 * main kernel map, so just use that instead.
+	 */
+	if (kmap && is_entry_trampoline(kmap->name) && kmap->kmaps && kmap->kmaps->machine) {
+		struct map *kernel_map = machine__kernel_map(kmap->kmaps->machine);
+
+		if (kernel_map)
+			map = kernel_map;
+	}
+
 	if (!map->dso->adjust_symbols)
 		return rip;
 
diff --git a/tools/perf/util/map.h b/tools/perf/util/map.h
index 97e2a063bd65..4cb90f242bed 100644
--- a/tools/perf/util/map.h
+++ b/tools/perf/util/map.h
@@ -169,6 +169,7 @@ static inline void __map__zput(struct map **map)
 int map__overlap(struct map *l, struct map *r);
 size_t map__fprintf(struct map *map, FILE *fp);
 size_t map__fprintf_dsoname(struct map *map, FILE *fp);
+char *map__srcline(struct map *map, u64 addr, struct symbol *sym);
 int map__fprintf_srcline(struct map *map, u64 addr, const char *prefix,
 			 FILE *fp);
 
diff --git a/tools/perf/util/parse-events.l b/tools/perf/util/parse-events.l
index a1a01b1ac8b8..5f761f3ed0f3 100644
--- a/tools/perf/util/parse-events.l
+++ b/tools/perf/util/parse-events.l
@@ -53,7 +53,21 @@ static int str(yyscan_t scanner, int token)
 	YYSTYPE *yylval = parse_events_get_lval(scanner);
 	char *text = parse_events_get_text(scanner);
 
-	yylval->str = strdup(text);
+	if (text[0] != '\'') {
+		yylval->str = strdup(text);
+	} else {
+		/*
+		 * If a text tag specified on the command line
+		 * contains opening single quite ' then it is
+		 * expected that the tag ends with single quote
+		 * as well, like this:
+		 *     name=\'CPU_CLK_UNHALTED.THREAD:cmask=1\'
+		 * quotes need to be escaped to bypass shell
+		 * processing.
+		 */
+		yylval->str = strndup(&text[1], strlen(text) - 2);
+	}
+
 	return token;
 }
 
@@ -176,6 +190,7 @@ num_dec		[0-9]+
 num_hex		0x[a-fA-F0-9]+
 num_raw_hex	[a-fA-F0-9]+
 name		[a-zA-Z_*?\[\]][a-zA-Z0-9_*?.\[\]]*
+name_tag	[\'][a-zA-Z_*?\[\]][a-zA-Z0-9_*?\-,\.\[\]:=]*[\']
 name_minus	[a-zA-Z_*?][a-zA-Z0-9\-_*?.:]*
 drv_cfg_term	[a-zA-Z0-9_\.]+(=[a-zA-Z0-9_*?\.:]+)?
 /* If you add a modifier you need to update check_modifier() */
@@ -344,6 +359,7 @@ r{num_raw_hex}		{ return raw(yyscanner); }
 {bpf_object}		{ if (!isbpf(yyscanner)) { USER_REJECT }; return str(yyscanner, PE_BPF_OBJECT); }
 {bpf_source}		{ if (!isbpf(yyscanner)) { USER_REJECT }; return str(yyscanner, PE_BPF_SOURCE); }
 {name}			{ return pmu_str_check(yyscanner); }
+{name_tag}		{ return str(yyscanner, PE_NAME); }
 "/"			{ BEGIN(config); return '/'; }
 -			{ return '-'; }
 ,			{ BEGIN(event); return ','; }
diff --git a/tools/perf/util/parse-events.y b/tools/perf/util/parse-events.y
index e37608a87dba..155d2570274f 100644
--- a/tools/perf/util/parse-events.y
+++ b/tools/perf/util/parse-events.y
@@ -73,6 +73,7 @@ static void inc_group_count(struct list_head *list,
 %type <num> value_sym
 %type <head> event_config
 %type <head> opt_event_config
+%type <head> opt_pmu_config
 %type <term> event_term
 %type <head> event_pmu
 %type <head> event_legacy_symbol
@@ -224,7 +225,7 @@ event_def: event_pmu |
 	   event_bpf_file
 
 event_pmu:
-PE_NAME opt_event_config
+PE_NAME opt_pmu_config
 {
 	struct list_head *list, *orig_terms, *terms;
 
@@ -496,6 +497,17 @@ opt_event_config:
 	$$ = NULL;
 }
 
+opt_pmu_config:
+'/' event_config '/'
+{
+	$$ = $2;
+}
+|
+'/' '/'
+{
+	$$ = NULL;
+}
+
 start_terms: event_config
 {
 	struct parse_events_state *parse_state = _parse_state;
diff --git a/tools/perf/util/probe-event.c b/tools/perf/util/probe-event.c
index 3094f11e7d81..f119eb628dbb 100644
--- a/tools/perf/util/probe-event.c
+++ b/tools/perf/util/probe-event.c
@@ -165,8 +165,7 @@ static struct map *kernel_get_module_map(const char *module)
 		if (strncmp(pos->dso->short_name + 1, module,
 			    pos->dso->short_name_len - 2) == 0 &&
 		    module[pos->dso->short_name_len - 2] == '\0') {
-			map__get(pos);
-			return pos;
+			return map__get(pos);
 		}
 	}
 	return NULL;
diff --git a/tools/perf/util/quote.c b/tools/perf/util/quote.c
deleted file mode 100644
index 22eaa201aa27..000000000000
--- a/tools/perf/util/quote.c
+++ /dev/null
@@ -1,62 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-#include <errno.h>
-#include <stdlib.h>
-#include "strbuf.h"
-#include "quote.h"
-#include "util.h"
-
-/* Help to copy the thing properly quoted for the shell safety.
- * any single quote is replaced with '\'', any exclamation point
- * is replaced with '\!', and the whole thing is enclosed in a
- *
- * E.g.
- *  original     sq_quote     result
- *  name     ==> name      ==> 'name'
- *  a b      ==> a b       ==> 'a b'
- *  a'b      ==> a'\''b    ==> 'a'\''b'
- *  a!b      ==> a'\!'b    ==> 'a'\!'b'
- */
-static inline int need_bs_quote(char c)
-{
-	return (c == '\'' || c == '!');
-}
-
-static int sq_quote_buf(struct strbuf *dst, const char *src)
-{
-	char *to_free = NULL;
-	int ret;
-
-	if (dst->buf == src)
-		to_free = strbuf_detach(dst, NULL);
-
-	ret = strbuf_addch(dst, '\'');
-	while (!ret && *src) {
-		size_t len = strcspn(src, "'!");
-		ret = strbuf_add(dst, src, len);
-		src += len;
-		while (!ret && need_bs_quote(*src))
-			ret = strbuf_addf(dst, "'\\%c\'", *src++);
-	}
-	if (!ret)
-		ret = strbuf_addch(dst, '\'');
-	free(to_free);
-
-	return ret;
-}
-
-int sq_quote_argv(struct strbuf *dst, const char** argv, size_t maxlen)
-{
-	int i, ret;
-
-	/* Copy into destination buffer. */
-	ret = strbuf_grow(dst, 255);
-	for (i = 0; !ret && argv[i]; ++i) {
-		ret = strbuf_addch(dst, ' ');
-		if (ret)
-			break;
-		ret = sq_quote_buf(dst, argv[i]);
-		if (maxlen && dst->len > maxlen)
-			return -ENOSPC;
-	}
-	return ret;
-}
diff --git a/tools/perf/util/quote.h b/tools/perf/util/quote.h
deleted file mode 100644
index 274bf26d3511..000000000000
--- a/tools/perf/util/quote.h
+++ /dev/null
@@ -1,31 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-#ifndef __PERF_QUOTE_H
-#define __PERF_QUOTE_H
-
-#include <stddef.h>
-
-/* Help to copy the thing properly quoted for the shell safety.
- * any single quote is replaced with '\'', any exclamation point
- * is replaced with '\!', and the whole thing is enclosed in a
- * single quote pair.
- *
- * For example, if you are passing the result to system() as an
- * argument:
- *
- * sprintf(cmd, "foobar %s %s", sq_quote(arg0), sq_quote(arg1))
- *
- * would be appropriate.  If the system() is going to call ssh to
- * run the command on the other side:
- *
- * sprintf(cmd, "git-diff-tree %s %s", sq_quote(arg0), sq_quote(arg1));
- * sprintf(rcmd, "ssh %s %s", sq_util/quote.host), sq_quote(cmd));
- *
- * Note that the above examples leak memory!  Remember to free result from
- * sq_quote() in a real application.
- */
-
-struct strbuf;
-
-int sq_quote_argv(struct strbuf *, const char **argv, size_t maxlen);
-
-#endif /* __PERF_QUOTE_H */
diff --git a/tools/perf/util/scripting-engines/trace-event-python.c b/tools/perf/util/scripting-engines/trace-event-python.c
index 7f8afacd08ee..46e9e19ab1ac 100644
--- a/tools/perf/util/scripting-engines/trace-event-python.c
+++ b/tools/perf/util/scripting-engines/trace-event-python.c
@@ -48,6 +48,7 @@
 #include "cpumap.h"
 #include "print_binary.h"
 #include "stat.h"
+#include "mem-events.h"
 
 #if PY_MAJOR_VERSION < 3
 #define _PyUnicode_FromString(arg) \
@@ -372,6 +373,19 @@ static PyObject *get_field_numeric_entry(struct event_format *event,
 	return obj;
 }
 
+static const char *get_dsoname(struct map *map)
+{
+	const char *dsoname = "[unknown]";
+
+	if (map && map->dso) {
+		if (symbol_conf.show_kernel_path && map->dso->long_name)
+			dsoname = map->dso->long_name;
+		else
+			dsoname = map->dso->name;
+	}
+
+	return dsoname;
+}
 
 static PyObject *python_process_callchain(struct perf_sample *sample,
 					 struct perf_evsel *evsel,
@@ -427,14 +441,8 @@ static PyObject *python_process_callchain(struct perf_sample *sample,
 		}
 
 		if (node->map) {
-			struct map *map = node->map;
-			const char *dsoname = "[unknown]";
-			if (map && map->dso) {
-				if (symbol_conf.show_kernel_path && map->dso->long_name)
-					dsoname = map->dso->long_name;
-				else
-					dsoname = map->dso->name;
-			}
+			const char *dsoname = get_dsoname(node->map);
+
 			pydict_set_item_string_decref(pyelem, "dso",
 					_PyUnicode_FromString(dsoname));
 		}
@@ -448,6 +456,166 @@ static PyObject *python_process_callchain(struct perf_sample *sample,
 	return pylist;
 }
 
+static PyObject *python_process_brstack(struct perf_sample *sample,
+					struct thread *thread)
+{
+	struct branch_stack *br = sample->branch_stack;
+	PyObject *pylist;
+	u64 i;
+
+	pylist = PyList_New(0);
+	if (!pylist)
+		Py_FatalError("couldn't create Python list");
+
+	if (!(br && br->nr))
+		goto exit;
+
+	for (i = 0; i < br->nr; i++) {
+		PyObject *pyelem;
+		struct addr_location al;
+		const char *dsoname;
+
+		pyelem = PyDict_New();
+		if (!pyelem)
+			Py_FatalError("couldn't create Python dictionary");
+
+		pydict_set_item_string_decref(pyelem, "from",
+		    PyLong_FromUnsignedLongLong(br->entries[i].from));
+		pydict_set_item_string_decref(pyelem, "to",
+		    PyLong_FromUnsignedLongLong(br->entries[i].to));
+		pydict_set_item_string_decref(pyelem, "mispred",
+		    PyBool_FromLong(br->entries[i].flags.mispred));
+		pydict_set_item_string_decref(pyelem, "predicted",
+		    PyBool_FromLong(br->entries[i].flags.predicted));
+		pydict_set_item_string_decref(pyelem, "in_tx",
+		    PyBool_FromLong(br->entries[i].flags.in_tx));
+		pydict_set_item_string_decref(pyelem, "abort",
+		    PyBool_FromLong(br->entries[i].flags.abort));
+		pydict_set_item_string_decref(pyelem, "cycles",
+		    PyLong_FromUnsignedLongLong(br->entries[i].flags.cycles));
+
+		thread__find_map(thread, sample->cpumode,
+				 br->entries[i].from, &al);
+		dsoname = get_dsoname(al.map);
+		pydict_set_item_string_decref(pyelem, "from_dsoname",
+					      _PyUnicode_FromString(dsoname));
+
+		thread__find_map(thread, sample->cpumode,
+				 br->entries[i].to, &al);
+		dsoname = get_dsoname(al.map);
+		pydict_set_item_string_decref(pyelem, "to_dsoname",
+					      _PyUnicode_FromString(dsoname));
+
+		PyList_Append(pylist, pyelem);
+		Py_DECREF(pyelem);
+	}
+
+exit:
+	return pylist;
+}
+
+static unsigned long get_offset(struct symbol *sym, struct addr_location *al)
+{
+	unsigned long offset;
+
+	if (al->addr < sym->end)
+		offset = al->addr - sym->start;
+	else
+		offset = al->addr - al->map->start - sym->start;
+
+	return offset;
+}
+
+static int get_symoff(struct symbol *sym, struct addr_location *al,
+		      bool print_off, char *bf, int size)
+{
+	unsigned long offset;
+
+	if (!sym || !sym->name[0])
+		return scnprintf(bf, size, "%s", "[unknown]");
+
+	if (!print_off)
+		return scnprintf(bf, size, "%s", sym->name);
+
+	offset = get_offset(sym, al);
+
+	return scnprintf(bf, size, "%s+0x%x", sym->name, offset);
+}
+
+static int get_br_mspred(struct branch_flags *flags, char *bf, int size)
+{
+	if (!flags->mispred  && !flags->predicted)
+		return scnprintf(bf, size, "%s", "-");
+
+	if (flags->mispred)
+		return scnprintf(bf, size, "%s", "M");
+
+	return scnprintf(bf, size, "%s", "P");
+}
+
+static PyObject *python_process_brstacksym(struct perf_sample *sample,
+					   struct thread *thread)
+{
+	struct branch_stack *br = sample->branch_stack;
+	PyObject *pylist;
+	u64 i;
+	char bf[512];
+	struct addr_location al;
+
+	pylist = PyList_New(0);
+	if (!pylist)
+		Py_FatalError("couldn't create Python list");
+
+	if (!(br && br->nr))
+		goto exit;
+
+	for (i = 0; i < br->nr; i++) {
+		PyObject *pyelem;
+
+		pyelem = PyDict_New();
+		if (!pyelem)
+			Py_FatalError("couldn't create Python dictionary");
+
+		thread__find_symbol(thread, sample->cpumode,
+				    br->entries[i].from, &al);
+		get_symoff(al.sym, &al, true, bf, sizeof(bf));
+		pydict_set_item_string_decref(pyelem, "from",
+					      _PyUnicode_FromString(bf));
+
+		thread__find_symbol(thread, sample->cpumode,
+				    br->entries[i].to, &al);
+		get_symoff(al.sym, &al, true, bf, sizeof(bf));
+		pydict_set_item_string_decref(pyelem, "to",
+					      _PyUnicode_FromString(bf));
+
+		get_br_mspred(&br->entries[i].flags, bf, sizeof(bf));
+		pydict_set_item_string_decref(pyelem, "pred",
+					      _PyUnicode_FromString(bf));
+
+		if (br->entries[i].flags.in_tx) {
+			pydict_set_item_string_decref(pyelem, "in_tx",
+					      _PyUnicode_FromString("X"));
+		} else {
+			pydict_set_item_string_decref(pyelem, "in_tx",
+					      _PyUnicode_FromString("-"));
+		}
+
+		if (br->entries[i].flags.abort) {
+			pydict_set_item_string_decref(pyelem, "abort",
+					      _PyUnicode_FromString("A"));
+		} else {
+			pydict_set_item_string_decref(pyelem, "abort",
+					      _PyUnicode_FromString("-"));
+		}
+
+		PyList_Append(pylist, pyelem);
+		Py_DECREF(pyelem);
+	}
+
+exit:
+	return pylist;
+}
+
 static PyObject *get_sample_value_as_tuple(struct sample_read_value *value)
 {
 	PyObject *t;
@@ -498,12 +666,63 @@ static void set_sample_read_in_dict(PyObject *dict_sample,
 	pydict_set_item_string_decref(dict_sample, "values", values);
 }
 
+static void set_sample_datasrc_in_dict(PyObject *dict,
+				       struct perf_sample *sample)
+{
+	struct mem_info mi = { .data_src.val = sample->data_src };
+	char decode[100];
+
+	pydict_set_item_string_decref(dict, "datasrc",
+			PyLong_FromUnsignedLongLong(sample->data_src));
+
+	perf_script__meminfo_scnprintf(decode, 100, &mi);
+
+	pydict_set_item_string_decref(dict, "datasrc_decode",
+			_PyUnicode_FromString(decode));
+}
+
+static int regs_map(struct regs_dump *regs, uint64_t mask, char *bf, int size)
+{
+	unsigned int i = 0, r;
+	int printed = 0;
+
+	bf[0] = 0;
+
+	for_each_set_bit(r, (unsigned long *) &mask, sizeof(mask) * 8) {
+		u64 val = regs->regs[i++];
+
+		printed += scnprintf(bf + printed, size - printed,
+				     "%5s:0x%" PRIx64 " ",
+				     perf_reg_name(r), val);
+	}
+
+	return printed;
+}
+
+static void set_regs_in_dict(PyObject *dict,
+			     struct perf_sample *sample,
+			     struct perf_evsel *evsel)
+{
+	struct perf_event_attr *attr = &evsel->attr;
+	char bf[512];
+
+	regs_map(&sample->intr_regs, attr->sample_regs_intr, bf, sizeof(bf));
+
+	pydict_set_item_string_decref(dict, "iregs",
+			_PyUnicode_FromString(bf));
+
+	regs_map(&sample->user_regs, attr->sample_regs_user, bf, sizeof(bf));
+
+	pydict_set_item_string_decref(dict, "uregs",
+			_PyUnicode_FromString(bf));
+}
+
 static PyObject *get_perf_sample_dict(struct perf_sample *sample,
 					 struct perf_evsel *evsel,
 					 struct addr_location *al,
 					 PyObject *callchain)
 {
-	PyObject *dict, *dict_sample;
+	PyObject *dict, *dict_sample, *brstack, *brstacksym;
 
 	dict = PyDict_New();
 	if (!dict)
@@ -534,6 +753,11 @@ static PyObject *get_perf_sample_dict(struct perf_sample *sample,
 	pydict_set_item_string_decref(dict_sample, "addr",
 			PyLong_FromUnsignedLongLong(sample->addr));
 	set_sample_read_in_dict(dict_sample, sample, evsel);
+	pydict_set_item_string_decref(dict_sample, "weight",
+			PyLong_FromUnsignedLongLong(sample->weight));
+	pydict_set_item_string_decref(dict_sample, "transaction",
+			PyLong_FromUnsignedLongLong(sample->transaction));
+	set_sample_datasrc_in_dict(dict_sample, sample);
 	pydict_set_item_string_decref(dict, "sample", dict_sample);
 
 	pydict_set_item_string_decref(dict, "raw_buf", _PyBytes_FromStringAndSize(
@@ -551,6 +775,14 @@ static PyObject *get_perf_sample_dict(struct perf_sample *sample,
 
 	pydict_set_item_string_decref(dict, "callchain", callchain);
 
+	brstack = python_process_brstack(sample, al->thread);
+	pydict_set_item_string_decref(dict, "brstack", brstack);
+
+	brstacksym = python_process_brstacksym(sample, al->thread);
+	pydict_set_item_string_decref(dict, "brstacksym", brstacksym);
+
+	set_regs_in_dict(dict, sample, evsel);
+
 	return dict;
 }
 
diff --git a/tools/perf/util/session.c b/tools/perf/util/session.c
index b998bb475589..8b9369303561 100644
--- a/tools/perf/util/session.c
+++ b/tools/perf/util/session.c
@@ -1094,7 +1094,7 @@ static void dump_sample(struct perf_evsel *evsel, union perf_event *event,
 
 	sample_type = evsel->attr.sample_type;
 
-	if (sample_type & PERF_SAMPLE_CALLCHAIN)
+	if (evsel__has_callchain(evsel))
 		callchain__printf(evsel, sample);
 
 	if ((sample_type & PERF_SAMPLE_BRANCH_STACK) && !perf_evsel__has_branch_callstack(evsel))
diff --git a/tools/perf/util/sort.c b/tools/perf/util/sort.c
index 4058ade352a5..fed2952ab45a 100644
--- a/tools/perf/util/sort.c
+++ b/tools/perf/util/sort.c
@@ -331,24 +331,18 @@ struct sort_entry sort_sym = {
 
 /* --sort srcline */
 
-char *hist_entry__get_srcline(struct hist_entry *he)
+char *hist_entry__srcline(struct hist_entry *he)
 {
-	struct map *map = he->ms.map;
-
-	if (!map)
-		return SRCLINE_UNKNOWN;
-
-	return get_srcline(map->dso, map__rip_2objdump(map, he->ip),
-			   he->ms.sym, true, true, he->ip);
+	return map__srcline(he->ms.map, he->ip, he->ms.sym);
 }
 
 static int64_t
 sort__srcline_cmp(struct hist_entry *left, struct hist_entry *right)
 {
 	if (!left->srcline)
-		left->srcline = hist_entry__get_srcline(left);
+		left->srcline = hist_entry__srcline(left);
 	if (!right->srcline)
-		right->srcline = hist_entry__get_srcline(right);
+		right->srcline = hist_entry__srcline(right);
 
 	return strcmp(right->srcline, left->srcline);
 }
@@ -357,7 +351,7 @@ static int hist_entry__srcline_snprintf(struct hist_entry *he, char *bf,
 					size_t size, unsigned int width)
 {
 	if (!he->srcline)
-		he->srcline = hist_entry__get_srcline(he);
+		he->srcline = hist_entry__srcline(he);
 
 	return repsep_snprintf(bf, size, "%-.*s", width, he->srcline);
 }
@@ -371,33 +365,20 @@ struct sort_entry sort_srcline = {
 
 /* --sort srcline_from */
 
+static char *addr_map_symbol__srcline(struct addr_map_symbol *ams)
+{
+	return map__srcline(ams->map, ams->al_addr, ams->sym);
+}
+
 static int64_t
 sort__srcline_from_cmp(struct hist_entry *left, struct hist_entry *right)
 {
-	if (!left->branch_info->srcline_from) {
-		struct map *map = left->branch_info->from.map;
-		if (!map)
-			left->branch_info->srcline_from = SRCLINE_UNKNOWN;
-		else
-			left->branch_info->srcline_from = get_srcline(map->dso,
-					   map__rip_2objdump(map,
-							     left->branch_info->from.al_addr),
-							 left->branch_info->from.sym,
-							 true, true,
-							 left->branch_info->from.al_addr);
-	}
-	if (!right->branch_info->srcline_from) {
-		struct map *map = right->branch_info->from.map;
-		if (!map)
-			right->branch_info->srcline_from = SRCLINE_UNKNOWN;
-		else
-			right->branch_info->srcline_from = get_srcline(map->dso,
-					     map__rip_2objdump(map,
-							       right->branch_info->from.al_addr),
-						     right->branch_info->from.sym,
-						     true, true,
-						     right->branch_info->from.al_addr);
-	}
+	if (!left->branch_info->srcline_from)
+		left->branch_info->srcline_from = addr_map_symbol__srcline(&left->branch_info->from);
+
+	if (!right->branch_info->srcline_from)
+		right->branch_info->srcline_from = addr_map_symbol__srcline(&right->branch_info->from);
+
 	return strcmp(right->branch_info->srcline_from, left->branch_info->srcline_from);
 }
 
@@ -419,30 +400,12 @@ struct sort_entry sort_srcline_from = {
 static int64_t
 sort__srcline_to_cmp(struct hist_entry *left, struct hist_entry *right)
 {
-	if (!left->branch_info->srcline_to) {
-		struct map *map = left->branch_info->to.map;
-		if (!map)
-			left->branch_info->srcline_to = SRCLINE_UNKNOWN;
-		else
-			left->branch_info->srcline_to = get_srcline(map->dso,
-					   map__rip_2objdump(map,
-							     left->branch_info->to.al_addr),
-							 left->branch_info->from.sym,
-							 true, true,
-							 left->branch_info->to.al_addr);
-	}
-	if (!right->branch_info->srcline_to) {
-		struct map *map = right->branch_info->to.map;
-		if (!map)
-			right->branch_info->srcline_to = SRCLINE_UNKNOWN;
-		else
-			right->branch_info->srcline_to = get_srcline(map->dso,
-					     map__rip_2objdump(map,
-							       right->branch_info->to.al_addr),
-						     right->branch_info->to.sym,
-						     true, true,
-						     right->branch_info->to.al_addr);
-	}
+	if (!left->branch_info->srcline_to)
+		left->branch_info->srcline_to = addr_map_symbol__srcline(&left->branch_info->to);
+
+	if (!right->branch_info->srcline_to)
+		right->branch_info->srcline_to = addr_map_symbol__srcline(&right->branch_info->to);
+
 	return strcmp(right->branch_info->srcline_to, left->branch_info->srcline_to);
 }
 
diff --git a/tools/perf/util/sort.h b/tools/perf/util/sort.h
index 9e6896293bbd..7cf2d5cc038e 100644
--- a/tools/perf/util/sort.h
+++ b/tools/perf/util/sort.h
@@ -151,6 +151,11 @@ struct hist_entry {
 	struct callchain_root	callchain[0]; /* must be last member */
 };
 
+static __pure inline bool hist_entry__has_callchains(struct hist_entry *he)
+{
+	return hists__has_callchains(he->hists);
+}
+
 static inline bool hist_entry__has_pairs(struct hist_entry *he)
 {
 	return !list_empty(&he->pairs.node);
@@ -292,5 +297,5 @@ int64_t
 sort__daddr_cmp(struct hist_entry *left, struct hist_entry *right);
 int64_t
 sort__dcacheline_cmp(struct hist_entry *left, struct hist_entry *right);
-char *hist_entry__get_srcline(struct hist_entry *he);
+char *hist_entry__srcline(struct hist_entry *he);
 #endif	/* __PERF_SORT_H */
diff --git a/tools/perf/util/symbol.c b/tools/perf/util/symbol.c
index 8c84437f2a10..d188b7588152 100644
--- a/tools/perf/util/symbol.c
+++ b/tools/perf/util/symbol.c
@@ -40,7 +40,6 @@ char **vmlinux_path;
 struct symbol_conf symbol_conf = {
 	.use_modules		= true,
 	.try_vmlinux_path	= true,
-	.annotate_src		= true,
 	.demangle		= true,
 	.demangle_kernel	= false,
 	.cumulate_callchain	= true,
@@ -74,7 +73,7 @@ static enum dso_binary_type binary_type_symtab[] = {
 static bool symbol_type__filter(char symbol_type)
 {
 	symbol_type = toupper(symbol_type);
-	return symbol_type == 'T' || symbol_type == 'W' || symbol_type == 'D';
+	return symbol_type == 'T' || symbol_type == 'W' || symbol_type == 'D' || symbol_type == 'B';
 }
 
 static int prefix_underscores_count(const char *str)
diff --git a/tools/perf/util/symbol.h b/tools/perf/util/symbol.h
index 1a16438eb3ce..f25fae4b5743 100644
--- a/tools/perf/util/symbol.h
+++ b/tools/perf/util/symbol.h
@@ -90,7 +90,6 @@ struct intlist;
 
 struct symbol_conf {
 	unsigned short	priv_size;
-	unsigned short	nr_events;
 	bool		try_vmlinux_path,
 			init_annotation,
 			force,
@@ -109,8 +108,6 @@ struct symbol_conf {
 			show_cpu_utilization,
 			initialized,
 			kptr_restrict,
-			annotate_asm_raw,
-			annotate_src,
 			event_group,
 			demangle,
 			demangle_kernel,
diff --git a/tools/perf/util/top.h b/tools/perf/util/top.h
index 9892323cdd7c..9add1f72ce95 100644
--- a/tools/perf/util/top.h
+++ b/tools/perf/util/top.h
@@ -3,6 +3,7 @@
 #define __PERF_TOP_H 1
 
 #include "tool.h"
+#include "annotate.h"
 #include <linux/types.h>
 #include <stddef.h>
 #include <stdbool.h>
@@ -16,6 +17,7 @@ struct perf_top {
 	struct perf_tool   tool;
 	struct perf_evlist *evlist;
 	struct record_opts record_opts;
+	struct annotation_options annotation_opts;
 	/*
 	 * Symbols will be added here in perf_event__process_sample and will
 	 * get out after decayed.
@@ -35,7 +37,6 @@ struct perf_top {
 	struct perf_session *session;
 	struct winsize	   winsize;
 	int		   realtime_prio;
-	int		   sym_pcnt_filter;
 	const char	   *sym_filter;
 	float		   min_percent;
 	unsigned int	   nr_threads_synthesize;
