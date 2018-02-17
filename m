Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751237AbeBQFt0 (ORCPT <rfc822;w@1wt.eu>);
        Sat, 17 Feb 2018 00:49:26 -0500
Received: from mga18.intel.com ([134.134.136.126]:1052 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751133AbeBQFtN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Feb 2018 00:49:13 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.46,523,1511856000";
   d="scan'208";a="20863358"
From: changbin.du@intel.com
To: corbet@lwn.net, rostedt@goodmis.org
Cc: mingo@kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, Changbin Du <changbin.du@intel.com>
Subject: [PATCH 08/17] trace doc: convert trace/tracepoints.txt to rst format
Date: Sat, 17 Feb 2018 13:39:41 +0800
Message-Id: <1518845990-20733-9-git-send-email-changbin.du@intel.com>
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
 .../trace/{tracepoints.txt => tracepoints.rst}     | 77 +++++++++++-----------
 2 files changed, 41 insertions(+), 37 deletions(-)
 rename Documentation/trace/{tracepoints.txt => tracepoints.rst} (74%)

diff --git a/Documentation/trace/index.rst b/Documentation/trace/index.rst
index 353fb8a..c8bbdfc 100644
--- a/Documentation/trace/index.rst
+++ b/Documentation/trace/index.rst
@@ -11,3 +11,4 @@ Linux Tracing Technologies
    ftrace-uses
    kprobetrace
    uprobetracer
+   tracepoints
diff --git a/Documentation/trace/tracepoints.txt b/Documentation/trace/tracepoints.rst
similarity index 74%
rename from Documentation/trace/tracepoints.txt
rename to Documentation/trace/tracepoints.rst
index a3efac6..6e3ce3b 100644
--- a/Documentation/trace/tracepoints.txt
+++ b/Documentation/trace/tracepoints.rst
@@ -1,6 +1,8 @@
-	             Using the Linux Kernel Tracepoints
+==================================
+Using the Linux Kernel Tracepoints
+==================================
 
-			    Mathieu Desnoyers
+:Author: Mathieu Desnoyers
 
 
 This document introduces Linux Kernel Tracepoints and their use. It
@@ -9,8 +11,8 @@ connect probe functions to them and provides some examples of probe
 functions.
 
 
-* Purpose of tracepoints
-
+Purpose of tracepoints
+----------------------
 A tracepoint placed in code provides a hook to call a function (probe)
 that you can provide at runtime. A tracepoint can be "on" (a probe is
 connected to it) or "off" (no probe is attached). When a tracepoint is
@@ -31,8 +33,8 @@ header file.
 They can be used for tracing and performance accounting.
 
 
-* Usage
-
+Usage
+-----
 Two elements are required for tracepoints :
 
 - A tracepoint definition, placed in a header file.
@@ -40,52 +42,53 @@ Two elements are required for tracepoints :
 
 In order to use tracepoints, you should include linux/tracepoint.h.
 
-In include/trace/events/subsys.h :
+In include/trace/events/subsys.h::
 
-#undef TRACE_SYSTEM
-#define TRACE_SYSTEM subsys
+	#undef TRACE_SYSTEM
+	#define TRACE_SYSTEM subsys
 
-#if !defined(_TRACE_SUBSYS_H) || defined(TRACE_HEADER_MULTI_READ)
-#define _TRACE_SUBSYS_H
+	#if !defined(_TRACE_SUBSYS_H) || defined(TRACE_HEADER_MULTI_READ)
+	#define _TRACE_SUBSYS_H
 
-#include <linux/tracepoint.h>
+	#include <linux/tracepoint.h>
 
-DECLARE_TRACE(subsys_eventname,
-	TP_PROTO(int firstarg, struct task_struct *p),
-	TP_ARGS(firstarg, p));
+	DECLARE_TRACE(subsys_eventname,
+		TP_PROTO(int firstarg, struct task_struct *p),
+		TP_ARGS(firstarg, p));
 
-#endif /* _TRACE_SUBSYS_H */
+	#endif /* _TRACE_SUBSYS_H */
 
-/* This part must be outside protection */
-#include <trace/define_trace.h>
+	/* This part must be outside protection */
+	#include <trace/define_trace.h>
 
-In subsys/file.c (where the tracing statement must be added) :
+In subsys/file.c (where the tracing statement must be added)::
 
-#include <trace/events/subsys.h>
+	#include <trace/events/subsys.h>
 
-#define CREATE_TRACE_POINTS
-DEFINE_TRACE(subsys_eventname);
+	#define CREATE_TRACE_POINTS
+	DEFINE_TRACE(subsys_eventname);
 
-void somefct(void)
-{
-	...
-	trace_subsys_eventname(arg, task);
-	...
-}
+	void somefct(void)
+	{
+		...
+		trace_subsys_eventname(arg, task);
+		...
+	}
 
 Where :
-- subsys_eventname is an identifier unique to your event
+  - subsys_eventname is an identifier unique to your event
+
     - subsys is the name of your subsystem.
     - eventname is the name of the event to trace.
 
-- TP_PROTO(int firstarg, struct task_struct *p) is the prototype of the
-  function called by this tracepoint.
+  - `TP_PROTO(int firstarg, struct task_struct *p)` is the prototype of the
+    function called by this tracepoint.
 
-- TP_ARGS(firstarg, p) are the parameters names, same as found in the
-  prototype.
+  - `TP_ARGS(firstarg, p)` are the parameters names, same as found in the
+    prototype.
 
-- if you use the header in multiple source files, #define CREATE_TRACE_POINTS
-  should appear only in one source file.
+  - if you use the header in multiple source files, `#define CREATE_TRACE_POINTS`
+    should appear only in one source file.
 
 Connecting a function (probe) to a tracepoint is done by providing a
 probe (function to call) for the specific tracepoint through
@@ -117,7 +120,7 @@ used to export the defined tracepoints.
 
 If you need to do a bit of work for a tracepoint parameter, and
 that work is only used for the tracepoint, that work can be encapsulated
-within an if statement with the following:
+within an if statement with the following::
 
 	if (trace_foo_bar_enabled()) {
 		int i;
@@ -139,7 +142,7 @@ The advantage of using the trace_<tracepoint>_enabled() is that it uses
 the static_key of the tracepoint to allow the if statement to be implemented
 with jump labels and avoid conditional branches.
 
-Note: The convenience macro TRACE_EVENT provides an alternative way to
+.. note:: The convenience macro TRACE_EVENT provides an alternative way to
       define tracepoints. Check http://lwn.net/Articles/379903,
       http://lwn.net/Articles/381064 and http://lwn.net/Articles/383362
       for a series of articles with more details.
-- 
2.7.4
