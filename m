Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751218AbeBQFtZ (ORCPT <rfc822;w@1wt.eu>);
        Sat, 17 Feb 2018 00:49:25 -0500
Received: from mga18.intel.com ([134.134.136.126]:1059 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751132AbeBQFtL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Feb 2018 00:49:11 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.46,523,1511856000";
   d="scan'208";a="20863353"
From: changbin.du@intel.com
To: corbet@lwn.net, rostedt@goodmis.org
Cc: mingo@kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, Changbin Du <changbin.du@intel.com>
Subject: [PATCH 07/17] trace doc: convert trace/uprobetracer.txt to rst format
Date: Sat, 17 Feb 2018 13:39:40 +0800
Message-Id: <1518845990-20733-8-git-send-email-changbin.du@intel.com>
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
 Documentation/trace/index.rst                      |  1 +
 .../trace/{uprobetracer.txt => uprobetracer.rst}   | 44 +++++++++++++---------
 2 files changed, 27 insertions(+), 18 deletions(-)
 rename Documentation/trace/{uprobetracer.txt => uprobetracer.rst} (86%)

diff --git a/Documentation/trace/index.rst b/Documentation/trace/index.rst
index c8e2130..353fb8a 100644
--- a/Documentation/trace/index.rst
+++ b/Documentation/trace/index.rst
@@ -10,3 +10,4 @@ Linux Tracing Technologies
    ftrace
    ftrace-uses
    kprobetrace
+   uprobetracer
diff --git a/Documentation/trace/uprobetracer.txt b/Documentation/trace/uprobetracer.rst
similarity index 86%
rename from Documentation/trace/uprobetracer.txt
rename to Documentation/trace/uprobetracer.rst
index bf526a7c..98d3f69 100644
--- a/Documentation/trace/uprobetracer.txt
+++ b/Documentation/trace/uprobetracer.rst
@@ -1,7 +1,8 @@
-            Uprobe-tracer: Uprobe-based Event Tracing
-            =========================================
+=========================================
+Uprobe-tracer: Uprobe-based Event Tracing
+=========================================
 
-           Documentation written by Srikar Dronamraju
+:Author: Srikar Dronamraju
 
 
 Overview
@@ -19,6 +20,8 @@ user to calculate the offset of the probepoint in the object.
 
 Synopsis of uprobe_tracer
 -------------------------
+::
+
   p[:[GRP/]EVENT] PATH:OFFSET [FETCHARGS] : Set a uprobe
   r[:[GRP/]EVENT] PATH:OFFSET [FETCHARGS] : Set a return uprobe (uretprobe)
   -:[GRP/]EVENT                           : Clear uprobe or uretprobe event
@@ -57,7 +60,7 @@ x86-64 uses x64).
 String type is a special type, which fetches a "null-terminated" string from
 user space.
 Bitfield is another special type, which takes 3 parameters, bit-width, bit-
-offset, and container-size (usually 32). The syntax is;
+offset, and container-size (usually 32). The syntax is::
 
  b<bit-width>@<bit-offset>/<container-size>
 
@@ -74,28 +77,28 @@ the third is the number of probe miss-hits.
 Usage examples
 --------------
  * Add a probe as a new uprobe event, write a new definition to uprobe_events
-as below: (sets a uprobe at an offset of 0x4245c0 in the executable /bin/bash)
+   as below (sets a uprobe at an offset of 0x4245c0 in the executable /bin/bash)::
 
     echo 'p /bin/bash:0x4245c0' > /sys/kernel/debug/tracing/uprobe_events
 
- * Add a probe as a new uretprobe event:
+ * Add a probe as a new uretprobe event::
 
     echo 'r /bin/bash:0x4245c0' > /sys/kernel/debug/tracing/uprobe_events
 
- * Unset registered event:
+ * Unset registered event::
 
     echo '-:p_bash_0x4245c0' >> /sys/kernel/debug/tracing/uprobe_events
 
- * Print out the events that are registered:
+ * Print out the events that are registered::
 
     cat /sys/kernel/debug/tracing/uprobe_events
 
- * Clear all events:
+ * Clear all events::
 
     echo > /sys/kernel/debug/tracing/uprobe_events
 
 Following example shows how to dump the instruction pointer and %ax register
-at the probed text address. Probe zfree function in /bin/zsh:
+at the probed text address. Probe zfree function in /bin/zsh::
 
     # cd /sys/kernel/debug/tracing/
     # cat /proc/`pgrep zsh`/maps | grep /bin/zsh | grep r-xp
@@ -103,24 +106,27 @@ at the probed text address. Probe zfree function in /bin/zsh:
     # objdump -T /bin/zsh | grep -w zfree
     0000000000446420 g    DF .text  0000000000000012  Base        zfree
 
-  0x46420 is the offset of zfree in object /bin/zsh that is loaded at
-  0x00400000. Hence the command to uprobe would be:
+0x46420 is the offset of zfree in object /bin/zsh that is loaded at
+0x00400000. Hence the command to uprobe would be::
 
     # echo 'p:zfree_entry /bin/zsh:0x46420 %ip %ax' > uprobe_events
 
-  And the same for the uretprobe would be:
+And the same for the uretprobe would be::
 
     # echo 'r:zfree_exit /bin/zsh:0x46420 %ip %ax' >> uprobe_events
 
-Please note: User has to explicitly calculate the offset of the probe-point
-in the object. We can see the events that are registered by looking at the
-uprobe_events file.
+.. note:: User has to explicitly calculate the offset of the probe-point
+	in the object.
+
+We can see the events that are registered by looking at the uprobe_events file.
+::
 
     # cat uprobe_events
     p:uprobes/zfree_entry /bin/zsh:0x00046420 arg1=%ip arg2=%ax
     r:uprobes/zfree_exit /bin/zsh:0x00046420 arg1=%ip arg2=%ax
 
-Format of events can be seen by viewing the file events/uprobes/zfree_entry/format
+Format of events can be seen by viewing the file events/uprobes/zfree_entry/format.
+::
 
     # cat events/uprobes/zfree_entry/format
     name: zfree_entry
@@ -139,16 +145,18 @@ Format of events can be seen by viewing the file events/uprobes/zfree_entry/form
     print fmt: "(%lx) arg1=%lx arg2=%lx", REC->__probe_ip, REC->arg1, REC->arg2
 
 Right after definition, each event is disabled by default. For tracing these
-events, you need to enable it by:
+events, you need to enable it by::
 
     # echo 1 > events/uprobes/enable
 
 Lets disable the event after sleeping for some time.
+::
 
     # sleep 20
     # echo 0 > events/uprobes/enable
 
 And you can see the traced information via /sys/kernel/debug/tracing/trace.
+::
 
     # cat trace
     # tracer: nop
-- 
2.7.4
