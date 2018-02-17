Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751350AbeBQFws (ORCPT <rfc822;w@1wt.eu>);
        Sat, 17 Feb 2018 00:52:48 -0500
Received: from mga18.intel.com ([134.134.136.126]:1052 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751077AbeBQFtD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Feb 2018 00:49:03 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.46,523,1511856000";
   d="scan'208";a="20863333"
From: changbin.du@intel.com
To: corbet@lwn.net, rostedt@goodmis.org
Cc: mingo@kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, Changbin Du <changbin.du@intel.com>
Subject: [PATCH 03/17] trace doc: add ftrace-uses.rst to doc tree
Date: Sat, 17 Feb 2018 13:39:36 +0800
Message-Id: <1518845990-20733-4-git-send-email-changbin.du@intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1518845990-20733-1-git-send-email-changbin.du@intel.com>
References: <1518845990-20733-1-git-send-email-changbin.du@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Changbin Du <changbin.du@intel.com>

Add ftrace-uses.rst into Sphinx TOC tree. Few format issues are fixed.

Cc: Steven Rostedt <rostedt@goodmis.org>
Signed-off-by: Changbin Du <changbin.du@intel.com>
---
 Documentation/trace/ftrace-uses.rst | 23 ++++++++++++-----------
 Documentation/trace/index.rst       |  1 +
 2 files changed, 13 insertions(+), 11 deletions(-)

diff --git a/Documentation/trace/ftrace-uses.rst b/Documentation/trace/ftrace-uses.rst
index 3aed560..998a60a 100644
--- a/Documentation/trace/ftrace-uses.rst
+++ b/Documentation/trace/ftrace-uses.rst
@@ -21,13 +21,14 @@ how to use ftrace to implement your own function callbacks.
 
 The ftrace context
 ==================
+.. warning::
 
-WARNING: The ability to add a callback to almost any function within the
-kernel comes with risks. A callback can be called from any context
-(normal, softirq, irq, and NMI). Callbacks can also be called just before
-going to idle, during CPU bring up and takedown, or going to user space.
-This requires extra care to what can be done inside a callback. A callback
-can be called outside the protective scope of RCU.
+  The ability to add a callback to almost any function within the
+  kernel comes with risks. A callback can be called from any context
+  (normal, softirq, irq, and NMI). Callbacks can also be called just before
+  going to idle, during CPU bring up and takedown, or going to user space.
+  This requires extra care to what can be done inside a callback. A callback
+  can be called outside the protective scope of RCU.
 
 The ftrace infrastructure has some protections agains recursions and RCU
 but one must still be very careful how they use the callbacks.
@@ -54,15 +55,15 @@ an ftrace_ops with ftrace:
 
 Both .flags and .private are optional. Only .func is required.
 
-To enable tracing call::
+To enable tracing call:
 
 .. c:function::  register_ftrace_function(&ops);
 
-To disable tracing call::
+To disable tracing call:
 
 .. c:function::  unregister_ftrace_function(&ops);
 
-The above is defined by including the header::
+The above is defined by including the header:
 
 .. c:function:: #include <linux/ftrace.h>
 
@@ -200,7 +201,7 @@ match a specific pattern.
 
 See Filter Commands in :file:`Documentation/trace/ftrace.txt`.
 
-To just trace the schedule function::
+To just trace the schedule function:
 
 .. code-block:: c
 
@@ -210,7 +211,7 @@ To add more functions, call the ftrace_set_filter() more than once with the
 @reset parameter set to zero. To remove the current filter set and replace it
 with new functions defined by @buf, have @reset be non-zero.
 
-To remove all the filtered functions and trace all functions::
+To remove all the filtered functions and trace all functions:
 
 .. code-block:: c
 
diff --git a/Documentation/trace/index.rst b/Documentation/trace/index.rst
index c8000ba..aa2baad 100644
--- a/Documentation/trace/index.rst
+++ b/Documentation/trace/index.rst
@@ -6,3 +6,4 @@ Linux Tracing Technologies
    :maxdepth: 2
 
    ftrace-design
+   ftrace-uses
-- 
2.7.4
