Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751412AbeBQFvy (ORCPT <rfc822;w@1wt.eu>);
        Sat, 17 Feb 2018 00:51:54 -0500
Received: from mga18.intel.com ([134.134.136.126]:1058 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751116AbeBQFtJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Feb 2018 00:49:09 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.46,523,1511856000";
   d="scan'208";a="20863350"
From: changbin.du@intel.com
To: corbet@lwn.net, rostedt@goodmis.org
Cc: mingo@kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, Changbin Du <changbin.du@intel.com>
Subject: [PATCH 06/17] trace doc: convert trace/kprobetrace.txt to rst format
Date: Sat, 17 Feb 2018 13:39:39 +0800
Message-Id: <1518845990-20733-7-git-send-email-changbin.du@intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1518845990-20733-1-git-send-email-changbin.du@intel.com>
References: <1518845990-20733-1-git-send-email-changbin.du@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Changbin Du <changbin.du@intel.com>

This converts the plain text documentation to reStructuredText format and
add it into Sphinx TOC tree. No essential content change.

Cc: Steven Rostedt <rostedt@goodmis.org>
Signed-off-by: Changbin Du <changbin.du@intel.com>
---
 Documentation/trace/index.rst                      |   1 +
 .../trace/{kprobetrace.txt => kprobetrace.rst}     | 100 +++++++++++----------
 2 files changed, 55 insertions(+), 46 deletions(-)
 rename Documentation/trace/{kprobetrace.txt => kprobetrace.rst} (63%)

diff --git a/Documentation/trace/index.rst b/Documentation/trace/index.rst
index 947c6db..c8e2130 100644
--- a/Documentation/trace/index.rst
+++ b/Documentation/trace/index.rst
@@ -9,3 +9,4 @@ Linux Tracing Technologies
    tracepoint-analysis
    ftrace
    ftrace-uses
+   kprobetrace
diff --git a/Documentation/trace/kprobetrace.txt b/Documentation/trace/kprobetrace.rst
similarity index 63%
rename from Documentation/trace/kprobetrace.txt
rename to Documentation/trace/kprobetrace.rst
index 1a3a3d6..3e0f971 100644
--- a/Documentation/trace/kprobetrace.txt
+++ b/Documentation/trace/kprobetrace.rst
@@ -1,8 +1,8 @@
-                        Kprobe-based Event Tracing
-                        ==========================
-
-                 Documentation is written by Masami Hiramatsu
+==========================
+Kprobe-based Event Tracing
+==========================
 
+:Author: Masami Hiramatsu
 
 Overview
 --------
@@ -23,6 +23,8 @@ current_tracer. Instead of that, add probe points via
 
 Synopsis of kprobe_events
 -------------------------
+::
+
   p[:[GRP/]EVENT] [MOD:]SYM[+offs]|MEMADDR [FETCHARGS]	: Set a probe
   r[MAXACTIVE][:[GRP/]EVENT] [MOD:]SYM[+0] [FETCHARGS]	: Set a return probe
   -:[GRP/]EVENT						: Clear a probe
@@ -66,7 +68,7 @@ String type is a special type, which fetches a "null-terminated" string from
 kernel space. This means it will fail and store NULL if the string container
 has been paged out.
 Bitfield is another special type, which takes 3 parameters, bit-width, bit-
-offset, and container-size (usually 32). The syntax is;
+offset, and container-size (usually 32). The syntax is::
 
  b<bit-width>@<bit-offset>/<container-size>
 
@@ -75,7 +77,7 @@ For $comm, the default type is "string"; any other type is invalid.
 
 Per-Probe Event Filtering
 -------------------------
- Per-probe event filtering feature allows you to set different filter on each
+Per-probe event filtering feature allows you to set different filter on each
 probe and gives you what arguments will be shown in trace buffer. If an event
 name is specified right after 'p:' or 'r:' in kprobe_events, it adds an event
 under tracing/events/kprobes/<EVENT>, at the directory you can see 'id',
@@ -96,87 +98,93 @@ id:
 
 Event Profiling
 ---------------
- You can check the total number of probe hits and probe miss-hits via
+You can check the total number of probe hits and probe miss-hits via
 /sys/kernel/debug/tracing/kprobe_profile.
- The first column is event name, the second is the number of probe hits,
+The first column is event name, the second is the number of probe hits,
 the third is the number of probe miss-hits.
 
 
 Usage examples
 --------------
 To add a probe as a new event, write a new definition to kprobe_events
-as below.
+as below::
 
   echo 'p:myprobe do_sys_open dfd=%ax filename=%dx flags=%cx mode=+4($stack)' > /sys/kernel/debug/tracing/kprobe_events
 
- This sets a kprobe on the top of do_sys_open() function with recording
+This sets a kprobe on the top of do_sys_open() function with recording
 1st to 4th arguments as "myprobe" event. Note, which register/stack entry is
 assigned to each function argument depends on arch-specific ABI. If you unsure
 the ABI, please try to use probe subcommand of perf-tools (you can find it
 under tools/perf/).
 As this example shows, users can choose more familiar names for each arguments.
+::
 
   echo 'r:myretprobe do_sys_open $retval' >> /sys/kernel/debug/tracing/kprobe_events
 
- This sets a kretprobe on the return point of do_sys_open() function with
+This sets a kretprobe on the return point of do_sys_open() function with
 recording return value as "myretprobe" event.
- You can see the format of these events via
+You can see the format of these events via
 /sys/kernel/debug/tracing/events/kprobes/<EVENT>/format.
+::
 
   cat /sys/kernel/debug/tracing/events/kprobes/myprobe/format
-name: myprobe
-ID: 780
-format:
-        field:unsigned short common_type;       offset:0;       size:2; signed:0;
-        field:unsigned char common_flags;       offset:2;       size:1; signed:0;
-        field:unsigned char common_preempt_count;       offset:3; size:1;signed:0;
-        field:int common_pid;   offset:4;       size:4; signed:1;
+  name: myprobe
+  ID: 780
+  format:
+          field:unsigned short common_type;       offset:0;       size:2; signed:0;
+          field:unsigned char common_flags;       offset:2;       size:1; signed:0;
+          field:unsigned char common_preempt_count;       offset:3; size:1;signed:0;
+          field:int common_pid;   offset:4;       size:4; signed:1;
 
-        field:unsigned long __probe_ip; offset:12;      size:4; signed:0;
-        field:int __probe_nargs;        offset:16;      size:4; signed:1;
-        field:unsigned long dfd;        offset:20;      size:4; signed:0;
-        field:unsigned long filename;   offset:24;      size:4; signed:0;
-        field:unsigned long flags;      offset:28;      size:4; signed:0;
-        field:unsigned long mode;       offset:32;      size:4; signed:0;
+          field:unsigned long __probe_ip; offset:12;      size:4; signed:0;
+          field:int __probe_nargs;        offset:16;      size:4; signed:1;
+          field:unsigned long dfd;        offset:20;      size:4; signed:0;
+          field:unsigned long filename;   offset:24;      size:4; signed:0;
+          field:unsigned long flags;      offset:28;      size:4; signed:0;
+          field:unsigned long mode;       offset:32;      size:4; signed:0;
 
 
-print fmt: "(%lx) dfd=%lx filename=%lx flags=%lx mode=%lx", REC->__probe_ip,
-REC->dfd, REC->filename, REC->flags, REC->mode
+  print fmt: "(%lx) dfd=%lx filename=%lx flags=%lx mode=%lx", REC->__probe_ip,
+  REC->dfd, REC->filename, REC->flags, REC->mode
 
- You can see that the event has 4 arguments as in the expressions you specified.
+You can see that the event has 4 arguments as in the expressions you specified.
+::
 
   echo > /sys/kernel/debug/tracing/kprobe_events
 
- This clears all probe points.
+This clears all probe points.
 
- Or,
+Or,
+::
 
   echo -:myprobe >> kprobe_events
 
- This clears probe points selectively.
+This clears probe points selectively.
 
- Right after definition, each event is disabled by default. For tracing these
+Right after definition, each event is disabled by default. For tracing these
 events, you need to enable it.
+::
 
   echo 1 > /sys/kernel/debug/tracing/events/kprobes/myprobe/enable
   echo 1 > /sys/kernel/debug/tracing/events/kprobes/myretprobe/enable
 
- And you can see the traced information via /sys/kernel/debug/tracing/trace.
+And you can see the traced information via /sys/kernel/debug/tracing/trace.
+::
 
   cat /sys/kernel/debug/tracing/trace
-# tracer: nop
-#
-#           TASK-PID    CPU#    TIMESTAMP  FUNCTION
-#              | |       |          |         |
-           <...>-1447  [001] 1038282.286875: myprobe: (do_sys_open+0x0/0xd6) dfd=3 filename=7fffd1ec4440 flags=8000 mode=0
-           <...>-1447  [001] 1038282.286878: myretprobe: (sys_openat+0xc/0xe <- do_sys_open) $retval=fffffffffffffffe
-           <...>-1447  [001] 1038282.286885: myprobe: (do_sys_open+0x0/0xd6) dfd=ffffff9c filename=40413c flags=8000 mode=1b6
-           <...>-1447  [001] 1038282.286915: myretprobe: (sys_open+0x1b/0x1d <- do_sys_open) $retval=3
-           <...>-1447  [001] 1038282.286969: myprobe: (do_sys_open+0x0/0xd6) dfd=ffffff9c filename=4041c6 flags=98800 mode=10
-           <...>-1447  [001] 1038282.286976: myretprobe: (sys_open+0x1b/0x1d <- do_sys_open) $retval=3
-
-
- Each line shows when the kernel hits an event, and <- SYMBOL means kernel
+  # tracer: nop
+  #
+  #           TASK-PID    CPU#    TIMESTAMP  FUNCTION
+  #              | |       |          |         |
+             <...>-1447  [001] 1038282.286875: myprobe: (do_sys_open+0x0/0xd6) dfd=3 filename=7fffd1ec4440 flags=8000 mode=0
+             <...>-1447  [001] 1038282.286878: myretprobe: (sys_openat+0xc/0xe <- do_sys_open) $retval=fffffffffffffffe
+             <...>-1447  [001] 1038282.286885: myprobe: (do_sys_open+0x0/0xd6) dfd=ffffff9c filename=40413c flags=8000 mode=1b6
+             <...>-1447  [001] 1038282.286915: myretprobe: (sys_open+0x1b/0x1d <- do_sys_open) $retval=3
+             <...>-1447  [001] 1038282.286969: myprobe: (do_sys_open+0x0/0xd6) dfd=ffffff9c filename=4041c6 flags=98800 mode=10
+             <...>-1447  [001] 1038282.286976: myretprobe: (sys_open+0x1b/0x1d <- do_sys_open) $retval=3
+
+
+Each line shows when the kernel hits an event, and <- SYMBOL means kernel
 returns from SYMBOL(e.g. "sys_open+0x1b/0x1d <- do_sys_open" means kernel
 returns from do_sys_open to sys_open+0x1b).
 
-- 
2.7.4
