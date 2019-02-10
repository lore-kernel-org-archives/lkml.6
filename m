Return-Path: <SRS0=kemo=QR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10C5AC282C2
	for <linux-kernel@archiver.kernel.org>; Sun, 10 Feb 2019 09:01:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BB781214DA
	for <linux-kernel@archiver.kernel.org>; Sun, 10 Feb 2019 09:01:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549789277;
	bh=mIHVtCmCo4XxIhAgFz1H5zBf0lvQUElRcS7eRXbhk3s=;
	h=Date:From:To:Cc:Subject:List-ID:From;
	b=V1VmtS+X6KNdivnFGoy0Fz5+VDT8FtQSm4Z4MLQf1qubLOt8LUcl+jz5sfqZ4Ha2y
	 xqfWrmeUdbeC+3h9VSckE57g8SlM9u2iuBTBGn6ySSJxnjQyShkbHryyxGdzvk7Ab7
	 K9eygxOJucMGL1YfUCNo4wbnBJmjvMvtEzSxc7ug=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726125AbfBJJBQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 10 Feb 2019 04:01:16 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:36771 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725862AbfBJJBP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Feb 2019 04:01:15 -0500
Received: by mail-wm1-f65.google.com with SMTP id p6so11023275wmc.1
        for <linux-kernel@vger.kernel.org>; Sun, 10 Feb 2019 01:01:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=5WidITl/f2jMygBRbw4g9I+pBUfTJu1Y94bBbyGo308=;
        b=WcFc5juEU24EIkRpTYjk/blJon+zX1uIFLMqq5HbhTN2h8VTLc4CXkpnogcgT6aJ/K
         o6IuSIED4NinPCELz8dEd+voJINgBzryo6JcTIrfj+xq6M+BKg08jXgoLOEEgsHgREZb
         6wu5xcSvFpam87xuHqI+lysyt/yb5jvgB0PPiEpdiABG0i7DSEkA3rXxFG/QmnQTJj9E
         8BlJaYWchTHnoOj9jfkYg6lJIXDwfE0qnr7mqfGcnjnx5MLvUC1mJxG9AW31E/pOfO7e
         1eYCMUJl0k6v0BUVf/2IKoavrQGwbo8E8xCmgHyJmkVbaaaAUQiVlDSO7cBw+zZKs+4x
         wnTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mime-version:content-disposition:user-agent;
        bh=5WidITl/f2jMygBRbw4g9I+pBUfTJu1Y94bBbyGo308=;
        b=qzYz/54AS3s4gALM84RJ2u/CmaT+R221iqrMHcBn4HlEUPmJS4DLzeZbLvjSBzbWoO
         6R0LriHIkqSu3V1lnBll7nIVD3GChAg7A16qW4uoce00cISTeio0lJwODdZde4zm8rMF
         fMj0cGPI0gYmEU9WgAHu5w+AQf4DoFpDRpqW7UpklEBuCOjW5GgR/zE2u6b9uIXJMGBj
         kSvU8tK9JuU/tFlULFb2NQGUrfoq6YmnxitkBAYxdtY5lbzB12NYMj+GZ+POQYN2iTeP
         hIZFOB8Jvvs9RiY64aJ8QVD76R1+8RARSH/DKZUvKYQBjZp1njpOj0eICnGGmAxFKCgc
         EfPg==
X-Gm-Message-State: AHQUAuZluR+ZbuAwDRkXb2n46DOHJTUlCd7pzrrki2EgfXcKhyjD5kyx
        7OvGYtpl078Prr9zu5q6OC4=
X-Google-Smtp-Source: AHgI3IbS8ZNjOSmQcMOif0Las+sUNkM8pVQuK3VKJVntQJ7NgSYsDsXTAAP8oR9B2QgleX58Aqvn3w==
X-Received: by 2002:a05:6000:10cf:: with SMTP id b15mr23146801wrx.301.1549789272567;
        Sun, 10 Feb 2019 01:01:12 -0800 (PST)
Received: from gmail.com (2E8B0CD5.catv.pool.telekom.hu. [46.139.12.213])
        by smtp.gmail.com with ESMTPSA id e9sm14208162wrc.56.2019.02.10.01.01.11
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 10 Feb 2019 01:01:11 -0800 (PST)
Date:   Sun, 10 Feb 2019 10:01:09 +0100
From:   Ingo Molnar <mingo@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Arnaldo Carvalho de Melo <acme@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: [GIT PULL] perf fixes
Message-ID: <20190210090109.GA114636@gmail.com>
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

   # HEAD: 3bb2600657dac78580e5b8fecc202eaaff5d4ced Merge tag 'perf-urgent-for-mingo-5.0-20190205' of git://git.kernel.org/pub/scm/linux/kernel/git/acme/linux into perf/urgent

A couple of kernel side fixes:

 - Fix the Intel uncore driver on certain hardware configurations
 - Fix a CPU hotplug related memory allocation bug
 - Remove a spurious WARN()

Plus also a handful of perf tooling fixes.

 Thanks,

	Ingo

------------------>
Arnaldo Carvalho de Melo (4):
      perf clang: Do not use 'return std::move(something)'
      tools headers uapi: Sync linux/in.h copy from the kernel sources
      perf symbols: Add fallback definitions for GELF_ST_VISIBILITY()
      perf trace: Support multiple "vfs_getname" probes

Gustavo A. R. Silva (1):
      perf tests evsel-tp-sched: Fix bitwise operator

Jiri Olsa (1):
      perf symbols: Filter out hidden symbols from labels

Kan Liang (1):
      perf/x86/intel/uncore: Add Node ID mask

Mark Rutland (1):
      perf/core: Don't WARN() for impossible ring-buffer sizes

Peter Zijlstra (1):
      perf/x86/intel: Delay memory deallocation until x86_pmu_dead_cpu()

Ravi Bangoria (1):
      perf mem/c2c: Fix perf_mem_events to support powerpc

Tony Jones (1):
      perf script python: Add Python3 support to tests/attr.py


 arch/x86/events/intel/core.c              | 16 +++++++++++-----
 arch/x86/events/intel/uncore_snbep.c      |  4 +++-
 kernel/events/ring_buffer.c               |  3 +++
 tools/include/uapi/linux/in.h             |  2 +-
 tools/perf/Documentation/perf-c2c.txt     | 16 ++++++++++++----
 tools/perf/Documentation/perf-mem.txt     |  2 +-
 tools/perf/arch/powerpc/util/Build        |  1 +
 tools/perf/arch/powerpc/util/mem-events.c | 11 +++++++++++
 tools/perf/builtin-trace.c                | 25 +++++++++++++++++-------
 tools/perf/tests/attr.py                  | 32 ++++++++++++++++++-------------
 tools/perf/tests/evsel-tp-sched.c         |  2 +-
 tools/perf/util/c++/clang.cpp             |  2 +-
 tools/perf/util/mem-events.c              |  2 +-
 tools/perf/util/symbol-elf.c              | 23 +++++++++++++++++++++-
 14 files changed, 105 insertions(+), 36 deletions(-)
 create mode 100644 tools/perf/arch/powerpc/util/mem-events.c

diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
index 40e12cfc87f6..daafb893449b 100644
--- a/arch/x86/events/intel/core.c
+++ b/arch/x86/events/intel/core.c
@@ -3558,6 +3558,14 @@ static void free_excl_cntrs(int cpu)
 }
 
 static void intel_pmu_cpu_dying(int cpu)
+{
+	fini_debug_store_on_cpu(cpu);
+
+	if (x86_pmu.counter_freezing)
+		disable_counter_freeze();
+}
+
+static void intel_pmu_cpu_dead(int cpu)
 {
 	struct cpu_hw_events *cpuc = &per_cpu(cpu_hw_events, cpu);
 	struct intel_shared_regs *pc;
@@ -3570,11 +3578,6 @@ static void intel_pmu_cpu_dying(int cpu)
 	}
 
 	free_excl_cntrs(cpu);
-
-	fini_debug_store_on_cpu(cpu);
-
-	if (x86_pmu.counter_freezing)
-		disable_counter_freeze();
 }
 
 static void intel_pmu_sched_task(struct perf_event_context *ctx,
@@ -3663,6 +3666,7 @@ static __initconst const struct x86_pmu core_pmu = {
 	.cpu_prepare		= intel_pmu_cpu_prepare,
 	.cpu_starting		= intel_pmu_cpu_starting,
 	.cpu_dying		= intel_pmu_cpu_dying,
+	.cpu_dead		= intel_pmu_cpu_dead,
 };
 
 static struct attribute *intel_pmu_attrs[];
@@ -3703,6 +3707,8 @@ static __initconst const struct x86_pmu intel_pmu = {
 	.cpu_prepare		= intel_pmu_cpu_prepare,
 	.cpu_starting		= intel_pmu_cpu_starting,
 	.cpu_dying		= intel_pmu_cpu_dying,
+	.cpu_dead		= intel_pmu_cpu_dead,
+
 	.guest_get_msrs		= intel_guest_get_msrs,
 	.sched_task		= intel_pmu_sched_task,
 };
diff --git a/arch/x86/events/intel/uncore_snbep.c b/arch/x86/events/intel/uncore_snbep.c
index c07bee31abe8..b10e04387f38 100644
--- a/arch/x86/events/intel/uncore_snbep.c
+++ b/arch/x86/events/intel/uncore_snbep.c
@@ -1222,6 +1222,8 @@ static struct pci_driver snbep_uncore_pci_driver = {
 	.id_table	= snbep_uncore_pci_ids,
 };
 
+#define NODE_ID_MASK	0x7
+
 /*
  * build pci bus to socket mapping
  */
@@ -1243,7 +1245,7 @@ static int snbep_pci2phy_map_init(int devid, int nodeid_loc, int idmap_loc, bool
 		err = pci_read_config_dword(ubox_dev, nodeid_loc, &config);
 		if (err)
 			break;
-		nodeid = config;
+		nodeid = config & NODE_ID_MASK;
 		/* get the Node ID mapping */
 		err = pci_read_config_dword(ubox_dev, idmap_loc, &config);
 		if (err)
diff --git a/kernel/events/ring_buffer.c b/kernel/events/ring_buffer.c
index 4a9937076331..309ef5a64af5 100644
--- a/kernel/events/ring_buffer.c
+++ b/kernel/events/ring_buffer.c
@@ -734,6 +734,9 @@ struct ring_buffer *rb_alloc(int nr_pages, long watermark, int cpu, int flags)
 	size = sizeof(struct ring_buffer);
 	size += nr_pages * sizeof(void *);
 
+	if (order_base_2(size) >= MAX_ORDER)
+		goto fail;
+
 	rb = kzalloc(size, GFP_KERNEL);
 	if (!rb)
 		goto fail;
diff --git a/tools/include/uapi/linux/in.h b/tools/include/uapi/linux/in.h
index f6052e70bf40..a55cb8b10165 100644
--- a/tools/include/uapi/linux/in.h
+++ b/tools/include/uapi/linux/in.h
@@ -268,7 +268,7 @@ struct sockaddr_in {
 #define	IN_MULTICAST(a)		IN_CLASSD(a)
 #define	IN_MULTICAST_NET	0xe0000000
 
-#define	IN_BADCLASS(a)		((((long int) (a) ) == 0xffffffff)
+#define	IN_BADCLASS(a)		(((long int) (a) ) == (long int)0xffffffff)
 #define	IN_EXPERIMENTAL(a)	IN_BADCLASS((a))
 
 #define	IN_CLASSE(a)		((((long int) (a)) & 0xf0000000) == 0xf0000000)
diff --git a/tools/perf/Documentation/perf-c2c.txt b/tools/perf/Documentation/perf-c2c.txt
index 095aebdc5bb7..e6150f21267d 100644
--- a/tools/perf/Documentation/perf-c2c.txt
+++ b/tools/perf/Documentation/perf-c2c.txt
@@ -19,8 +19,11 @@ C2C stands for Cache To Cache.
 The perf c2c tool provides means for Shared Data C2C/HITM analysis. It allows
 you to track down the cacheline contentions.
 
-The tool is based on x86's load latency and precise store facility events
-provided by Intel CPUs. These events provide:
+On x86, the tool is based on load latency and precise store facility events
+provided by Intel CPUs. On PowerPC, the tool uses random instruction sampling
+with thresholding feature.
+
+These events provide:
   - memory address of the access
   - type of the access (load and store details)
   - latency (in cycles) of the load access
@@ -46,7 +49,7 @@ RECORD OPTIONS
 
 -l::
 --ldlat::
-	Configure mem-loads latency.
+	Configure mem-loads latency. (x86 only)
 
 -k::
 --all-kernel::
@@ -119,11 +122,16 @@ Following perf record options are configured by default:
   -W,-d,--phys-data,--sample-cpu
 
 Unless specified otherwise with '-e' option, following events are monitored by
-default:
+default on x86:
 
   cpu/mem-loads,ldlat=30/P
   cpu/mem-stores/P
 
+and following on PowerPC:
+
+  cpu/mem-loads/
+  cpu/mem-stores/
+
 User can pass any 'perf record' option behind '--' mark, like (to enable
 callchains and system wide monitoring):
 
diff --git a/tools/perf/Documentation/perf-mem.txt b/tools/perf/Documentation/perf-mem.txt
index f8d2167cf3e7..199ea0f0a6c0 100644
--- a/tools/perf/Documentation/perf-mem.txt
+++ b/tools/perf/Documentation/perf-mem.txt
@@ -82,7 +82,7 @@ RECORD OPTIONS
 	Be more verbose (show counter open errors, etc)
 
 --ldlat <n>::
-	Specify desired latency for loads event.
+	Specify desired latency for loads event. (x86 only)
 
 In addition, for report all perf report options are valid, and for record
 all perf record options.
diff --git a/tools/perf/arch/powerpc/util/Build b/tools/perf/arch/powerpc/util/Build
index 2e6595310420..ba98bd006488 100644
--- a/tools/perf/arch/powerpc/util/Build
+++ b/tools/perf/arch/powerpc/util/Build
@@ -2,6 +2,7 @@ libperf-y += header.o
 libperf-y += sym-handling.o
 libperf-y += kvm-stat.o
 libperf-y += perf_regs.o
+libperf-y += mem-events.o
 
 libperf-$(CONFIG_DWARF) += dwarf-regs.o
 libperf-$(CONFIG_DWARF) += skip-callchain-idx.o
diff --git a/tools/perf/arch/powerpc/util/mem-events.c b/tools/perf/arch/powerpc/util/mem-events.c
new file mode 100644
index 000000000000..d08311f04e95
--- /dev/null
+++ b/tools/perf/arch/powerpc/util/mem-events.c
@@ -0,0 +1,11 @@
+// SPDX-License-Identifier: GPL-2.0
+#include "mem-events.h"
+
+/* PowerPC does not support 'ldlat' parameter. */
+char *perf_mem_events__name(int i)
+{
+	if (i == PERF_MEM_EVENTS__LOAD)
+		return (char *) "cpu/mem-loads/";
+
+	return (char *) "cpu/mem-stores/";
+}
diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
index ed4583128b9c..b36061cd1ab8 100644
--- a/tools/perf/builtin-trace.c
+++ b/tools/perf/builtin-trace.c
@@ -2514,19 +2514,30 @@ static size_t trace__fprintf_thread_summary(struct trace *trace, FILE *fp);
 
 static bool perf_evlist__add_vfs_getname(struct perf_evlist *evlist)
 {
-	struct perf_evsel *evsel = perf_evsel__newtp("probe", "vfs_getname");
+	bool found = false;
+	struct perf_evsel *evsel, *tmp;
+	struct parse_events_error err = { .idx = 0, };
+	int ret = parse_events(evlist, "probe:vfs_getname*", &err);
 
-	if (IS_ERR(evsel))
+	if (ret)
 		return false;
 
-	if (perf_evsel__field(evsel, "pathname") == NULL) {
+	evlist__for_each_entry_safe(evlist, evsel, tmp) {
+		if (!strstarts(perf_evsel__name(evsel), "probe:vfs_getname"))
+			continue;
+
+		if (perf_evsel__field(evsel, "pathname")) {
+			evsel->handler = trace__vfs_getname;
+			found = true;
+			continue;
+		}
+
+		list_del_init(&evsel->node);
+		evsel->evlist = NULL;
 		perf_evsel__delete(evsel);
-		return false;
 	}
 
-	evsel->handler = trace__vfs_getname;
-	perf_evlist__add(evlist, evsel);
-	return true;
+	return found;
 }
 
 static struct perf_evsel *perf_evsel__new_pgfault(u64 config)
diff --git a/tools/perf/tests/attr.py b/tools/perf/tests/attr.py
index 44090a9a19f3..e952127e4fb0 100644
--- a/tools/perf/tests/attr.py
+++ b/tools/perf/tests/attr.py
@@ -1,6 +1,8 @@
 #! /usr/bin/python
 # SPDX-License-Identifier: GPL-2.0
 
+from __future__ import print_function
+
 import os
 import sys
 import glob
@@ -8,7 +10,11 @@ import optparse
 import tempfile
 import logging
 import shutil
-import ConfigParser
+
+try:
+    import configparser
+except ImportError:
+    import ConfigParser as configparser
 
 def data_equal(a, b):
     # Allow multiple values in assignment separated by '|'
@@ -100,20 +106,20 @@ class Event(dict):
     def equal(self, other):
         for t in Event.terms:
             log.debug("      [%s] %s %s" % (t, self[t], other[t]));
-            if not self.has_key(t) or not other.has_key(t):
+            if t not in self or t not in other:
                 return False
             if not data_equal(self[t], other[t]):
                 return False
         return True
 
     def optional(self):
-        if self.has_key('optional') and self['optional'] == '1':
+        if 'optional' in self and self['optional'] == '1':
             return True
         return False
 
     def diff(self, other):
         for t in Event.terms:
-            if not self.has_key(t) or not other.has_key(t):
+            if t not in self or t not in other:
                 continue
             if not data_equal(self[t], other[t]):
                 log.warning("expected %s=%s, got %s" % (t, self[t], other[t]))
@@ -134,7 +140,7 @@ class Event(dict):
 #   - expected values assignments
 class Test(object):
     def __init__(self, path, options):
-        parser = ConfigParser.SafeConfigParser()
+        parser = configparser.SafeConfigParser()
         parser.read(path)
 
         log.warning("running '%s'" % path)
@@ -193,7 +199,7 @@ class Test(object):
         return True
 
     def load_events(self, path, events):
-        parser_event = ConfigParser.SafeConfigParser()
+        parser_event = configparser.SafeConfigParser()
         parser_event.read(path)
 
         # The event record section header contains 'event' word,
@@ -207,7 +213,7 @@ class Test(object):
             # Read parent event if there's any
             if (':' in section):
                 base = section[section.index(':') + 1:]
-                parser_base = ConfigParser.SafeConfigParser()
+                parser_base = configparser.SafeConfigParser()
                 parser_base.read(self.test_dir + '/' + base)
                 base_items = parser_base.items('event')
 
@@ -322,9 +328,9 @@ def run_tests(options):
     for f in glob.glob(options.test_dir + '/' + options.test):
         try:
             Test(f, options).run()
-        except Unsup, obj:
+        except Unsup as obj:
             log.warning("unsupp  %s" % obj.getMsg())
-        except Notest, obj:
+        except Notest as obj:
             log.warning("skipped %s" % obj.getMsg())
 
 def setup_log(verbose):
@@ -363,7 +369,7 @@ def main():
     parser.add_option("-p", "--perf",
                       action="store", type="string", dest="perf")
     parser.add_option("-v", "--verbose",
-                      action="count", dest="verbose")
+                      default=0, action="count", dest="verbose")
 
     options, args = parser.parse_args()
     if args:
@@ -373,7 +379,7 @@ def main():
     setup_log(options.verbose)
 
     if not options.test_dir:
-        print 'FAILED no -d option specified'
+        print('FAILED no -d option specified')
         sys.exit(-1)
 
     if not options.test:
@@ -382,8 +388,8 @@ def main():
     try:
         run_tests(options)
 
-    except Fail, obj:
-        print "FAILED %s" % obj.getMsg();
+    except Fail as obj:
+        print("FAILED %s" % obj.getMsg())
         sys.exit(-1)
 
     sys.exit(0)
diff --git a/tools/perf/tests/evsel-tp-sched.c b/tools/perf/tests/evsel-tp-sched.c
index 5f8501c68da4..5cbba70bcdd0 100644
--- a/tools/perf/tests/evsel-tp-sched.c
+++ b/tools/perf/tests/evsel-tp-sched.c
@@ -17,7 +17,7 @@ static int perf_evsel__test_field(struct perf_evsel *evsel, const char *name,
 		return -1;
 	}
 
-	is_signed = !!(field->flags | TEP_FIELD_IS_SIGNED);
+	is_signed = !!(field->flags & TEP_FIELD_IS_SIGNED);
 	if (should_be_signed && !is_signed) {
 		pr_debug("%s: \"%s\" signedness(%d) is wrong, should be %d\n",
 			 evsel->name, name, is_signed, should_be_signed);
diff --git a/tools/perf/util/c++/clang.cpp b/tools/perf/util/c++/clang.cpp
index 89512504551b..39c0004f2886 100644
--- a/tools/perf/util/c++/clang.cpp
+++ b/tools/perf/util/c++/clang.cpp
@@ -160,7 +160,7 @@ getBPFObjectFromModule(llvm::Module *Module)
 	}
 	PM.run(*Module);
 
-	return std::move(Buffer);
+	return Buffer;
 }
 
 }
diff --git a/tools/perf/util/mem-events.c b/tools/perf/util/mem-events.c
index 93f74d8d3cdd..42c3e5a229d2 100644
--- a/tools/perf/util/mem-events.c
+++ b/tools/perf/util/mem-events.c
@@ -28,7 +28,7 @@ struct perf_mem_event perf_mem_events[PERF_MEM_EVENTS__MAX] = {
 static char mem_loads_name[100];
 static bool mem_loads_name__init;
 
-char *perf_mem_events__name(int i)
+char * __weak perf_mem_events__name(int i)
 {
 	if (i == PERF_MEM_EVENTS__LOAD) {
 		if (!mem_loads_name__init) {
diff --git a/tools/perf/util/symbol-elf.c b/tools/perf/util/symbol-elf.c
index 66a84d5846c8..dca7dfae69ad 100644
--- a/tools/perf/util/symbol-elf.c
+++ b/tools/perf/util/symbol-elf.c
@@ -19,6 +19,20 @@
 #define EM_AARCH64	183  /* ARM 64 bit */
 #endif
 
+#ifndef ELF32_ST_VISIBILITY
+#define ELF32_ST_VISIBILITY(o)	((o) & 0x03)
+#endif
+
+/* For ELF64 the definitions are the same.  */
+#ifndef ELF64_ST_VISIBILITY
+#define ELF64_ST_VISIBILITY(o)	ELF32_ST_VISIBILITY (o)
+#endif
+
+/* How to extract information held in the st_other field.  */
+#ifndef GELF_ST_VISIBILITY
+#define GELF_ST_VISIBILITY(val)	ELF64_ST_VISIBILITY (val)
+#endif
+
 typedef Elf64_Nhdr GElf_Nhdr;
 
 #ifdef HAVE_CPLUS_DEMANGLE_SUPPORT
@@ -87,6 +101,11 @@ static inline uint8_t elf_sym__type(const GElf_Sym *sym)
 	return GELF_ST_TYPE(sym->st_info);
 }
 
+static inline uint8_t elf_sym__visibility(const GElf_Sym *sym)
+{
+	return GELF_ST_VISIBILITY(sym->st_other);
+}
+
 #ifndef STT_GNU_IFUNC
 #define STT_GNU_IFUNC 10
 #endif
@@ -111,7 +130,9 @@ static inline int elf_sym__is_label(const GElf_Sym *sym)
 	return elf_sym__type(sym) == STT_NOTYPE &&
 		sym->st_name != 0 &&
 		sym->st_shndx != SHN_UNDEF &&
-		sym->st_shndx != SHN_ABS;
+		sym->st_shndx != SHN_ABS &&
+		elf_sym__visibility(sym) != STV_HIDDEN &&
+		elf_sym__visibility(sym) != STV_INTERNAL;
 }
 
 static bool elf_sym__filter(GElf_Sym *sym)
