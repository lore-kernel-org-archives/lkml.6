Return-Path: <SRS0=Zbfl=J5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: *
X-Spam-Status: No, score=1.2 required=3.0 tests=DKIM_SIGNED,FSL_HELO_FAKE,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DC4EECDFB0
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 19:59:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 03DC320864
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 19:59:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bR/ajei3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 03DC320864
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731956AbeGMUPc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Jul 2018 16:15:32 -0400
Received: from mail-wr1-f51.google.com ([209.85.221.51]:32973 "EHLO
        mail-wr1-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731329AbeGMUPb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jul 2018 16:15:31 -0400
Received: by mail-wr1-f51.google.com with SMTP id g6-v6so17293115wrp.0
        for <linux-kernel@vger.kernel.org>; Fri, 13 Jul 2018 12:59:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=LhYGXgTfzXlBp0yf5z8DnR+xfLuIoGpf5U7CZgFMPXU=;
        b=bR/ajei3Vg7/nicH/M/QmeMYg2wLEK//DENkJkKTZviveJBJEK3Xx/yXAL/w5k32UO
         y1Px6hok9xcba2BpA83m3hNGCWM4Lq14ncKvu8woybq1bz4EhfJCWWEu0iMI1+RUBCkx
         Cx94wYk5GB9dWeJGkOf0ld8+xeItyGRIr0lA5Bn9K3mO7H2z5ob1/d0Ao6x4Kj7FwUvf
         iXJ8phex+No2Ghqz0b3sb9sc70pqePcyrcnN18nag4bPyaFk61Y/yTJfuuuxCbkJAFyC
         niCeN8wScJNVyoLJyhSjeJAfZ7Gdb02MQdGnEE3jwEwv5AjAm7nT5U8i5eWDoRnSH4Xg
         zJDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mime-version:content-disposition:user-agent;
        bh=LhYGXgTfzXlBp0yf5z8DnR+xfLuIoGpf5U7CZgFMPXU=;
        b=ZEib39x2GLHHKnm2xs3Pa2swC7TyGQ3NAkrgd6F50sYst9AYZpvnPlYXiIS65IZWIr
         S4Rlhz414Y2nMNaoLv0L9PB5k0eNRiXLXtHwFsKwiiEI6j2ihKB+tcdlMIupmIcSqVXi
         zYZMd7fUmzBiT9jMbnAiMtEhWPva7fLrG1SDOPuxCZpasxpqFczpuixYMITl5eWzAMjS
         g6mgvZaaK3U7tRna6cvDZiADztbu3Cr1r/3Qj6KqToIFq7Bij90RQ1kFuKv55fTFrqlX
         zumB3/tJhRUOkJFPVxp0IRk7n9koRuEP/W6II1j56BAnhL/3V1xrB79Mk2j4OJxLX5I2
         kUzQ==
X-Gm-Message-State: AOUpUlHx1noQUikC8rIT6jLwucL/yVDcII9CRRrsb6QmbRtme+zvy2hX
        60YBrqbQ1IQx6hMVqARD8Q0=
X-Google-Smtp-Source: AAOMgpfCm1Ydjzug/841iqU1ZMqzTcPdxSZIqImwTlXTJtc94xtBOjfiA3Z/tSqyv3wHRVk9HpubZw==
X-Received: by 2002:a5d:44c6:: with SMTP id z6-v6mr5761839wrr.236.1531511963796;
        Fri, 13 Jul 2018 12:59:23 -0700 (PDT)
Received: from gmail.com (2E8B0CD5.catv.pool.telekom.hu. [46.139.12.213])
        by smtp.gmail.com with ESMTPSA id n8-v6sm37117845wrt.56.2018.07.13.12.59.22
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 13 Jul 2018 12:59:23 -0700 (PDT)
Date:   Fri, 13 Jul 2018 21:59:20 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@infradead.org>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [GIT PULL] perf fixes
Message-ID: <20180713195920.GA2397@gmail.com>
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

   # HEAD: 6e1d33b24a2b4aebcb05782e937ebc9a7a4a3f50 Merge tag 'perf-urgent-for-mingo-4.18-20180711' of git://git.kernel.org/pub/scm/linux/kernel/git/acme/linux into perf/urgent

Misc tooling fixes: ptyhon3 related fixes, gcc8 fix, bashism fixes and some other 
smaller fixes.

 Thanks,

	Ingo

------------------>
Janne Huttunen (1):
      perf script python: Fix dict reference counting

Jeremy Cline (7):
      perf tools: Generate a Python script compatible with Python 2 and 3
      perf scripts python: Add Python 3 support to Core.py
      perf scripts python: Add Python 3 support to SchedGui.py
      perf scripts python: Add Python 3 support to Util.py
      perf scripts python: Add Python 3 support to sched-migration.py
      perf scripts python: Add Python 3 support to EventClass.py
      perf tools: Use python-config --includes rather than --cflags

Jiri Olsa (2):
      perf tools: Fix compilation errors on gcc8
      perf stat: Fix --interval_clear option

Kim Phillips (4):
      perf test shell: Replace '|&' with '2>&1 |' to work with more shells
      perf test shell: Make perf's inet_pton test more portable
      perf llvm-utils: Remove bashism from kernel include fetch script
      perf test shell: Prevent temporary editor files from being considered test scripts


 tools/perf/Makefile.config                         |  3 +-
 tools/perf/arch/x86/util/perf_regs.c               |  2 +-
 tools/perf/builtin-stat.c                          |  2 +-
 tools/perf/jvmti/jvmti_agent.c                     |  3 +-
 .../python/Perf-Trace-Util/lib/Perf/Trace/Core.py  | 40 +++++++++-------------
 .../Perf-Trace-Util/lib/Perf/Trace/EventClass.py   |  4 ++-
 .../Perf-Trace-Util/lib/Perf/Trace/SchedGui.py     |  2 +-
 .../python/Perf-Trace-Util/lib/Perf/Trace/Util.py  | 11 +++---
 tools/perf/scripts/python/sched-migration.py       | 14 +++++---
 tools/perf/tests/builtin-test.c                    |  2 +-
 .../tests/shell/record+probe_libc_inet_pton.sh     | 37 +++++++++++---------
 tools/perf/tests/shell/trace+probe_vfs_getname.sh  |  2 +-
 tools/perf/util/llvm-utils.c                       |  6 ++--
 .../util/scripting-engines/trace-event-python.c    | 37 +++++++++-----------
 14 files changed, 84 insertions(+), 81 deletions(-)

diff --git a/tools/perf/Makefile.config b/tools/perf/Makefile.config
index b5ac356ba323..f5a3b402589e 100644
--- a/tools/perf/Makefile.config
+++ b/tools/perf/Makefile.config
@@ -207,8 +207,7 @@ ifdef PYTHON_CONFIG
   PYTHON_EMBED_LDOPTS := $(shell $(PYTHON_CONFIG_SQ) --ldflags 2>/dev/null)
   PYTHON_EMBED_LDFLAGS := $(call strip-libs,$(PYTHON_EMBED_LDOPTS))
   PYTHON_EMBED_LIBADD := $(call grep-libs,$(PYTHON_EMBED_LDOPTS)) -lutil
-  PYTHON_EMBED_CCOPTS := $(shell $(PYTHON_CONFIG_SQ) --cflags 2>/dev/null)
-  PYTHON_EMBED_CCOPTS := $(filter-out -specs=%,$(PYTHON_EMBED_CCOPTS))
+  PYTHON_EMBED_CCOPTS := $(shell $(PYTHON_CONFIG_SQ) --includes 2>/dev/null)
   FLAGS_PYTHON_EMBED := $(PYTHON_EMBED_CCOPTS) $(PYTHON_EMBED_LDOPTS)
 endif
 
diff --git a/tools/perf/arch/x86/util/perf_regs.c b/tools/perf/arch/x86/util/perf_regs.c
index 4b2caf6d48e7..fead6b3b4206 100644
--- a/tools/perf/arch/x86/util/perf_regs.c
+++ b/tools/perf/arch/x86/util/perf_regs.c
@@ -226,7 +226,7 @@ int arch_sdt_arg_parse_op(char *old_op, char **new_op)
 		else if (rm[2].rm_so != rm[2].rm_eo)
 			prefix[0] = '+';
 		else
-			strncpy(prefix, "+0", 2);
+			scnprintf(prefix, sizeof(prefix), "+0");
 	}
 
 	/* Rename register */
diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
index 22547a490e1f..05be023c3f0e 100644
--- a/tools/perf/builtin-stat.c
+++ b/tools/perf/builtin-stat.c
@@ -1742,7 +1742,7 @@ static void print_interval(char *prefix, struct timespec *ts)
 		}
 	}
 
-	if ((num_print_interval == 0 && metric_only) || interval_clear)
+	if ((num_print_interval == 0 || interval_clear) && metric_only)
 		print_metric_headers(" ", true);
 	if (++num_print_interval == 25)
 		num_print_interval = 0;
diff --git a/tools/perf/jvmti/jvmti_agent.c b/tools/perf/jvmti/jvmti_agent.c
index 0c6d1002b524..ac1bcdc17dae 100644
--- a/tools/perf/jvmti/jvmti_agent.c
+++ b/tools/perf/jvmti/jvmti_agent.c
@@ -35,6 +35,7 @@
 #include <sys/mman.h>
 #include <syscall.h> /* for gettid() */
 #include <err.h>
+#include <linux/kernel.h>
 
 #include "jvmti_agent.h"
 #include "../util/jitdump.h"
@@ -249,7 +250,7 @@ void *jvmti_open(void)
 	/*
 	 * jitdump file name
 	 */
-	snprintf(dump_path, PATH_MAX, "%s/jit-%i.dump", jit_path, getpid());
+	scnprintf(dump_path, PATH_MAX, "%s/jit-%i.dump", jit_path, getpid());
 
 	fd = open(dump_path, O_CREAT|O_TRUNC|O_RDWR, 0666);
 	if (fd == -1)
diff --git a/tools/perf/scripts/python/Perf-Trace-Util/lib/Perf/Trace/Core.py b/tools/perf/scripts/python/Perf-Trace-Util/lib/Perf/Trace/Core.py
index 38dfb720fb6f..54ace2f6bc36 100644
--- a/tools/perf/scripts/python/Perf-Trace-Util/lib/Perf/Trace/Core.py
+++ b/tools/perf/scripts/python/Perf-Trace-Util/lib/Perf/Trace/Core.py
@@ -31,10 +31,8 @@ symbolic_fields = autodict()
     string = ""
 
     if flag_fields[event_name][field_name]:
-	print_delim = 0
-        keys = flag_fields[event_name][field_name]['values'].keys()
-        keys.sort()
-        for idx in keys:
+        print_delim = 0
+        for idx in sorted(flag_fields[event_name][field_name]['values']):
             if not value and not idx:
                 string += flag_fields[event_name][field_name]['values'][idx]
                 break
@@ -51,14 +49,12 @@ symbolic_fields = autodict()
     string = ""
 
     if symbolic_fields[event_name][field_name]:
-        keys = symbolic_fields[event_name][field_name]['values'].keys()
-        keys.sort()
-        for idx in keys:
+        for idx in sorted(symbolic_fields[event_name][field_name]['values']):
             if not value and not idx:
-		string = symbolic_fields[event_name][field_name]['values'][idx]
+                string = symbolic_fields[event_name][field_name]['values'][idx]
                 break
-	    if (value == idx):
-		string = symbolic_fields[event_name][field_name]['values'][idx]
+            if (value == idx):
+                string = symbolic_fields[event_name][field_name]['values'][idx]
                 break
 
     return string
@@ -74,19 +70,17 @@ trace_flags = { 0x00: "NONE", \
     string = ""
     print_delim = 0
 
-    keys = trace_flags.keys()
-
-    for idx in keys:
-	if not value and not idx:
-	    string += "NONE"
-	    break
-
-	if idx and (value & idx) == idx:
-	    if print_delim:
-		string += " | ";
-	    string += trace_flags[idx]
-	    print_delim = 1
-	    value &= ~idx
+    for idx in trace_flags:
+        if not value and not idx:
+            string += "NONE"
+            break
+
+        if idx and (value & idx) == idx:
+            if print_delim:
+                string += " | ";
+            string += trace_flags[idx]
+            print_delim = 1
+            value &= ~idx
 
     return string
 
diff --git a/tools/perf/scripts/python/Perf-Trace-Util/lib/Perf/Trace/EventClass.py b/tools/perf/scripts/python/Perf-Trace-Util/lib/Perf/Trace/EventClass.py
index 81a56cd2b3c1..21a7a1298094 100755
--- a/tools/perf/scripts/python/Perf-Trace-Util/lib/Perf/Trace/EventClass.py
+++ b/tools/perf/scripts/python/Perf-Trace-Util/lib/Perf/Trace/EventClass.py
@@ -8,6 +8,7 @@
 # PerfEvent is the base class for all perf event sample, PebsEvent
 # is a HW base Intel x86 PEBS event, and user could add more SW/HW
 # event classes based on requirements.
+from __future__ import print_function
 
 import struct
 
@@ -44,7 +45,8 @@ EVTYPE_IBS      = 3
                 PerfEvent.event_num += 1
 
         def show(self):
-                print "PMU event: name=%12s, symbol=%24s, comm=%8s, dso=%12s" % (self.name, self.symbol, self.comm, self.dso)
+                print("PMU event: name=%12s, symbol=%24s, comm=%8s, dso=%12s" %
+                      (self.name, self.symbol, self.comm, self.dso))
 
 #
 # Basic Intel PEBS (Precise Event-based Sampling) event, whose raw buffer
diff --git a/tools/perf/scripts/python/Perf-Trace-Util/lib/Perf/Trace/SchedGui.py b/tools/perf/scripts/python/Perf-Trace-Util/lib/Perf/Trace/SchedGui.py
index fdd92f699055..cac7b2542ee8 100644
--- a/tools/perf/scripts/python/Perf-Trace-Util/lib/Perf/Trace/SchedGui.py
+++ b/tools/perf/scripts/python/Perf-Trace-Util/lib/Perf/Trace/SchedGui.py
@@ -11,7 +11,7 @@
 try:
 	import wx
 except ImportError:
-	raise ImportError, "You need to install the wxpython lib for this script"
+	raise ImportError("You need to install the wxpython lib for this script")
 
 
 class RootFrame(wx.Frame):
diff --git a/tools/perf/scripts/python/Perf-Trace-Util/lib/Perf/Trace/Util.py b/tools/perf/scripts/python/Perf-Trace-Util/lib/Perf/Trace/Util.py
index f6c84966e4f8..7384dcb628c4 100644
--- a/tools/perf/scripts/python/Perf-Trace-Util/lib/Perf/Trace/Util.py
+++ b/tools/perf/scripts/python/Perf-Trace-Util/lib/Perf/Trace/Util.py
@@ -5,6 +5,7 @@
 # This software may be distributed under the terms of the GNU General
 # Public License ("GPL") version 2 as published by the Free Software
 # Foundation.
+from __future__ import print_function
 
 import errno, os
 
@@ -33,7 +34,7 @@ NSECS_PER_SEC    = 1000000000
     return str
 
 def add_stats(dict, key, value):
-	if not dict.has_key(key):
+	if key not in dict:
 		dict[key] = (value, value, value, 1)
 	else:
 		min, max, avg, count = dict[key]
@@ -72,10 +73,10 @@ audit_package_warned = False
 except:
 	if not audit_package_warned:
 		audit_package_warned = True
-		print "Install the audit-libs-python package to get syscall names.\n" \
-                    "For example:\n  # apt-get install python-audit (Ubuntu)" \
-                    "\n  # yum install audit-libs-python (Fedora)" \
-                    "\n  etc.\n"
+		print("Install the audit-libs-python package to get syscall names.\n"
+                    "For example:\n  # apt-get install python-audit (Ubuntu)"
+                    "\n  # yum install audit-libs-python (Fedora)"
+                    "\n  etc.\n")
 
 def syscall_name(id):
 	try:
diff --git a/tools/perf/scripts/python/sched-migration.py b/tools/perf/scripts/python/sched-migration.py
index de66cb3b72c9..3473e7f66081 100644
--- a/tools/perf/scripts/python/sched-migration.py
+++ b/tools/perf/scripts/python/sched-migration.py
@@ -9,13 +9,17 @@
 # This software is distributed under the terms of the GNU General
 # Public License ("GPL") version 2 as published by the Free Software
 # Foundation.
-
+from __future__ import print_function
 
 import os
 import sys
 
 from collections import defaultdict
-from UserList import UserList
+try:
+    from UserList import UserList
+except ImportError:
+    # Python 3: UserList moved to the collections package
+    from collections import UserList
 
 sys.path.append(os.environ['PERF_EXEC_PATH'] + \
 	'/scripts/python/Perf-Trace-Util/lib/Perf/Trace')
@@ -300,7 +304,7 @@ threads = { 0 : "idle"}
 		if i == -1:
 			return
 
-		for i in xrange(i, len(self.data)):
+		for i in range(i, len(self.data)):
 			timeslice = self.data[i]
 			if timeslice.start > end:
 				return
@@ -336,8 +340,8 @@ threads = { 0 : "idle"}
 		on_cpu_task = self.current_tsk[headers.cpu]
 
 		if on_cpu_task != -1 and on_cpu_task != prev_pid:
-			print "Sched switch event rejected ts: %s cpu: %d prev: %s(%d) next: %s(%d)" % \
-				(headers.ts_format(), headers.cpu, prev_comm, prev_pid, next_comm, next_pid)
+			print("Sched switch event rejected ts: %s cpu: %d prev: %s(%d) next: %s(%d)" % \
+				headers.ts_format(), headers.cpu, prev_comm, prev_pid, next_comm, next_pid)
 
 		threads[prev_pid] = prev_comm
 		threads[next_pid] = next_comm
diff --git a/tools/perf/tests/builtin-test.c b/tools/perf/tests/builtin-test.c
index 2bde505e2e7e..dd850a26d579 100644
--- a/tools/perf/tests/builtin-test.c
+++ b/tools/perf/tests/builtin-test.c
@@ -422,7 +422,7 @@ static const char *shell_test__description(char *description, size_t size,
 
 #define for_each_shell_test(dir, base, ent)	\
 	while ((ent = readdir(dir)) != NULL)	\
-		if (!is_directory(base, ent))
+		if (!is_directory(base, ent) && ent->d_name[0] != '.')
 
 static const char *shell_tests__dir(char *path, size_t size)
 {
diff --git a/tools/perf/tests/shell/record+probe_libc_inet_pton.sh b/tools/perf/tests/shell/record+probe_libc_inet_pton.sh
index 263057039693..94e513e62b34 100755
--- a/tools/perf/tests/shell/record+probe_libc_inet_pton.sh
+++ b/tools/perf/tests/shell/record+probe_libc_inet_pton.sh
@@ -14,35 +14,40 @@ libc=$(grep -w libc /proc/self/maps | head -1 | sed -r 's/.*[[:space:]](\/.*)/\1
 nm -Dg $libc 2>/dev/null | fgrep -q inet_pton || exit 254
 
 trace_libc_inet_pton_backtrace() {
-	idx=0
-	expected[0]="ping[][0-9 \.:]+probe_libc:inet_pton: \([[:xdigit:]]+\)"
-	expected[1]=".*inet_pton\+0x[[:xdigit:]]+[[:space:]]\($libc|inlined\)$"
+
+	expected=`mktemp -u /tmp/expected.XXX`
+
+	echo "ping[][0-9 \.:]+probe_libc:inet_pton: \([[:xdigit:]]+\)" > $expected
+	echo ".*inet_pton\+0x[[:xdigit:]]+[[:space:]]\($libc|inlined\)$" >> $expected
 	case "$(uname -m)" in
 	s390x)
 		eventattr='call-graph=dwarf,max-stack=4'
-		expected[2]="gaih_inet.*\+0x[[:xdigit:]]+[[:space:]]\($libc|inlined\)$"
-		expected[3]="(__GI_)?getaddrinfo\+0x[[:xdigit:]]+[[:space:]]\($libc|inlined\)$"
-		expected[4]="main\+0x[[:xdigit:]]+[[:space:]]\(.*/bin/ping.*\)$"
+		echo "gaih_inet.*\+0x[[:xdigit:]]+[[:space:]]\($libc|inlined\)$" >> $expected
+		echo "(__GI_)?getaddrinfo\+0x[[:xdigit:]]+[[:space:]]\($libc|inlined\)$" >> $expected
+		echo "main\+0x[[:xdigit:]]+[[:space:]]\(.*/bin/ping.*\)$" >> $expected
 		;;
 	*)
 		eventattr='max-stack=3'
-		expected[2]="getaddrinfo\+0x[[:xdigit:]]+[[:space:]]\($libc\)$"
-		expected[3]=".*\+0x[[:xdigit:]]+[[:space:]]\(.*/bin/ping.*\)$"
+		echo "getaddrinfo\+0x[[:xdigit:]]+[[:space:]]\($libc\)$" >> $expected
+		echo ".*\+0x[[:xdigit:]]+[[:space:]]\(.*/bin/ping.*\)$" >> $expected
 		;;
 	esac
 
-	file=`mktemp -u /tmp/perf.data.XXX`
+	perf_data=`mktemp -u /tmp/perf.data.XXX`
+	perf_script=`mktemp -u /tmp/perf.script.XXX`
+	perf record -e probe_libc:inet_pton/$eventattr/ -o $perf_data ping -6 -c 1 ::1 > /dev/null 2>&1
+	perf script -i $perf_data > $perf_script
 
-	perf record -e probe_libc:inet_pton/$eventattr/ -o $file ping -6 -c 1 ::1 > /dev/null 2>&1
-	perf script -i $file | while read line ; do
+	exec 3<$perf_script
+	exec 4<$expected
+	while read line <&3 && read -r pattern <&4; do
+		[ -z "$pattern" ] && break
 		echo $line
-		echo "$line" | egrep -q "${expected[$idx]}"
+		echo "$line" | egrep -q "$pattern"
 		if [ $? -ne 0 ] ; then
-			printf "FAIL: expected backtrace entry %d \"%s\" got \"%s\"\n" $idx "${expected[$idx]}" "$line"
+			printf "FAIL: expected backtrace entry \"%s\" got \"%s\"\n" "$pattern" "$line"
 			exit 1
 		fi
-		let idx+=1
-		[ -z "${expected[$idx]}" ] && break
 	done
 
 	# If any statements are executed from this point onwards,
@@ -58,6 +63,6 @@ skip_if_no_perf_probe && \
 perf probe -q $libc inet_pton && \
 trace_libc_inet_pton_backtrace
 err=$?
-rm -f ${file}
+rm -f ${perf_data} ${perf_script} ${expected}
 perf probe -q -d probe_libc:inet_pton
 exit $err
diff --git a/tools/perf/tests/shell/trace+probe_vfs_getname.sh b/tools/perf/tests/shell/trace+probe_vfs_getname.sh
index 55ad9793d544..4ce276efe6b4 100755
--- a/tools/perf/tests/shell/trace+probe_vfs_getname.sh
+++ b/tools/perf/tests/shell/trace+probe_vfs_getname.sh
@@ -17,7 +17,7 @@ skip_if_no_perf_probe || exit 2
 file=$(mktemp /tmp/temporary_file.XXXXX)
 
 trace_open_vfs_getname() {
-	evts=$(echo $(perf list syscalls:sys_enter_open* |& egrep 'open(at)? ' | sed -r 's/.*sys_enter_([a-z]+) +\[.*$/\1/') | sed 's/ /,/')
+	evts=$(echo $(perf list syscalls:sys_enter_open* 2>&1 | egrep 'open(at)? ' | sed -r 's/.*sys_enter_([a-z]+) +\[.*$/\1/') | sed 's/ /,/')
 	perf trace -e $evts touch $file 2>&1 | \
 	egrep " +[0-9]+\.[0-9]+ +\( +[0-9]+\.[0-9]+ ms\): +touch\/[0-9]+ open(at)?\((dfd: +CWD, +)?filename: +${file}, +flags: CREAT\|NOCTTY\|NONBLOCK\|WRONLY, +mode: +IRUGO\|IWUGO\) += +[0-9]+$"
 }
diff --git a/tools/perf/util/llvm-utils.c b/tools/perf/util/llvm-utils.c
index 976e658e38dc..5e94857dfca2 100644
--- a/tools/perf/util/llvm-utils.c
+++ b/tools/perf/util/llvm-utils.c
@@ -266,16 +266,16 @@ static const char *kinc_fetch_script =
 "#!/usr/bin/env sh\n"
 "if ! test -d \"$KBUILD_DIR\"\n"
 "then\n"
-"	exit -1\n"
+"	exit 1\n"
 "fi\n"
 "if ! test -f \"$KBUILD_DIR/include/generated/autoconf.h\"\n"
 "then\n"
-"	exit -1\n"
+"	exit 1\n"
 "fi\n"
 "TMPDIR=`mktemp -d`\n"
 "if test -z \"$TMPDIR\"\n"
 "then\n"
-"    exit -1\n"
+"    exit 1\n"
 "fi\n"
 "cat << EOF > $TMPDIR/Makefile\n"
 "obj-y := dummy.o\n"
diff --git a/tools/perf/util/scripting-engines/trace-event-python.c b/tools/perf/util/scripting-engines/trace-event-python.c
index 46e9e19ab1ac..bc32e57d17be 100644
--- a/tools/perf/util/scripting-engines/trace-event-python.c
+++ b/tools/perf/util/scripting-engines/trace-event-python.c
@@ -908,14 +908,11 @@ static void python_process_tracepoint(struct perf_sample *sample,
 	if (_PyTuple_Resize(&t, n) == -1)
 		Py_FatalError("error resizing Python tuple");
 
-	if (!dict) {
+	if (!dict)
 		call_object(handler, t, handler_name);
-	} else {
+	else
 		call_object(handler, t, default_handler_name);
-		Py_DECREF(dict);
-	}
 
-	Py_XDECREF(all_entries_dict);
 	Py_DECREF(t);
 }
 
@@ -1235,7 +1232,6 @@ static void python_process_general_event(struct perf_sample *sample,
 
 	call_object(handler, t, handler_name);
 
-	Py_DECREF(dict);
 	Py_DECREF(t);
 }
 
@@ -1627,6 +1623,7 @@ static int python_generate_script(struct pevent *pevent, const char *outfile)
 	fprintf(ofp, "# See the perf-script-python Documentation for the list "
 		"of available functions.\n\n");
 
+	fprintf(ofp, "from __future__ import print_function\n\n");
 	fprintf(ofp, "import os\n");
 	fprintf(ofp, "import sys\n\n");
 
@@ -1636,10 +1633,10 @@ static int python_generate_script(struct pevent *pevent, const char *outfile)
 	fprintf(ofp, "from Core import *\n\n\n");
 
 	fprintf(ofp, "def trace_begin():\n");
-	fprintf(ofp, "\tprint \"in trace_begin\"\n\n");
+	fprintf(ofp, "\tprint(\"in trace_begin\")\n\n");
 
 	fprintf(ofp, "def trace_end():\n");
-	fprintf(ofp, "\tprint \"in trace_end\"\n\n");
+	fprintf(ofp, "\tprint(\"in trace_end\")\n\n");
 
 	while ((event = trace_find_next_event(pevent, event))) {
 		fprintf(ofp, "def %s__%s(", event->system, event->name);
@@ -1675,7 +1672,7 @@ static int python_generate_script(struct pevent *pevent, const char *outfile)
 			"common_secs, common_nsecs,\n\t\t\t"
 			"common_pid, common_comm)\n\n");
 
-		fprintf(ofp, "\t\tprint \"");
+		fprintf(ofp, "\t\tprint(\"");
 
 		not_first = 0;
 		count = 0;
@@ -1736,31 +1733,31 @@ static int python_generate_script(struct pevent *pevent, const char *outfile)
 				fprintf(ofp, "%s", f->name);
 		}
 
-		fprintf(ofp, ")\n\n");
+		fprintf(ofp, "))\n\n");
 
-		fprintf(ofp, "\t\tprint 'Sample: {'+"
-			"get_dict_as_string(perf_sample_dict['sample'], ', ')+'}'\n\n");
+		fprintf(ofp, "\t\tprint('Sample: {'+"
+			"get_dict_as_string(perf_sample_dict['sample'], ', ')+'}')\n\n");
 
 		fprintf(ofp, "\t\tfor node in common_callchain:");
 		fprintf(ofp, "\n\t\t\tif 'sym' in node:");
-		fprintf(ofp, "\n\t\t\t\tprint \"\\t[%%x] %%s\" %% (node['ip'], node['sym']['name'])");
+		fprintf(ofp, "\n\t\t\t\tprint(\"\\t[%%x] %%s\" %% (node['ip'], node['sym']['name']))");
 		fprintf(ofp, "\n\t\t\telse:");
-		fprintf(ofp, "\n\t\t\t\tprint \"\t[%%x]\" %% (node['ip'])\n\n");
-		fprintf(ofp, "\t\tprint \"\\n\"\n\n");
+		fprintf(ofp, "\n\t\t\t\tprint(\"\t[%%x]\" %% (node['ip']))\n\n");
+		fprintf(ofp, "\t\tprint()\n\n");
 
 	}
 
 	fprintf(ofp, "def trace_unhandled(event_name, context, "
 		"event_fields_dict, perf_sample_dict):\n");
 
-	fprintf(ofp, "\t\tprint get_dict_as_string(event_fields_dict)\n");
-	fprintf(ofp, "\t\tprint 'Sample: {'+"
-		"get_dict_as_string(perf_sample_dict['sample'], ', ')+'}'\n\n");
+	fprintf(ofp, "\t\tprint(get_dict_as_string(event_fields_dict))\n");
+	fprintf(ofp, "\t\tprint('Sample: {'+"
+		"get_dict_as_string(perf_sample_dict['sample'], ', ')+'}')\n\n");
 
 	fprintf(ofp, "def print_header("
 		"event_name, cpu, secs, nsecs, pid, comm):\n"
-		"\tprint \"%%-20s %%5u %%05u.%%09u %%8u %%-20s \" %% \\\n\t"
-		"(event_name, cpu, secs, nsecs, pid, comm),\n\n");
+		"\tprint(\"%%-20s %%5u %%05u.%%09u %%8u %%-20s \" %% \\\n\t"
+		"(event_name, cpu, secs, nsecs, pid, comm), end=\"\")\n\n");
 
 	fprintf(ofp, "def get_dict_as_string(a_dict, delimiter=' '):\n"
 		"\treturn delimiter.join"
