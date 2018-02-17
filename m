Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751127AbeBQFtH (ORCPT <rfc822;w@1wt.eu>);
        Sat, 17 Feb 2018 00:49:07 -0500
Received: from mga18.intel.com ([134.134.136.126]:1052 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751108AbeBQFtF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Feb 2018 00:49:05 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.46,523,1511856000";
   d="scan'208";a="20863341"
From: changbin.du@intel.com
To: corbet@lwn.net, rostedt@goodmis.org
Cc: mingo@kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, Changbin Du <changbin.du@intel.com>
Subject: [PATCH 04/17] trace doc: convert trace/tracepoint-analysis.txt to rst format
Date: Sat, 17 Feb 2018 13:39:37 +0800
Message-Id: <1518845990-20733-5-git-send-email-changbin.du@intel.com>
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
 ...epoint-analysis.txt => tracepoint-analysis.rst} | 41 ++++++++++++++--------
 2 files changed, 27 insertions(+), 15 deletions(-)
 rename Documentation/trace/{tracepoint-analysis.txt => tracepoint-analysis.rst} (93%)

diff --git a/Documentation/trace/index.rst b/Documentation/trace/index.rst
index aa2baad..61b5551 100644
--- a/Documentation/trace/index.rst
+++ b/Documentation/trace/index.rst
@@ -6,4 +6,5 @@ Linux Tracing Technologies
    :maxdepth: 2
 
    ftrace-design
+   tracepoint-analysis
    ftrace-uses
diff --git a/Documentation/trace/tracepoint-analysis.txt b/Documentation/trace/tracepoint-analysis.rst
similarity index 93%
rename from Documentation/trace/tracepoint-analysis.txt
rename to Documentation/trace/tracepoint-analysis.rst
index 058cc6c..a4d3ff2 100644
--- a/Documentation/trace/tracepoint-analysis.txt
+++ b/Documentation/trace/tracepoint-analysis.rst
@@ -1,7 +1,7 @@
-		Notes on Analysing Behaviour Using Events and Tracepoints
-
-			Documentation written by Mel Gorman
-		PCL information heavily based on email from Ingo Molnar
+=========================================================
+Notes on Analysing Behaviour Using Events and Tracepoints
+=========================================================
+:Author: Mel Gorman (PCL information heavily based on email from Ingo Molnar)
 
 1. Introduction
 ===============
@@ -27,18 +27,18 @@ assumed that the PCL tool tools/perf has been installed and is in your path.
 ----------------------
 
 All possible events are visible from /sys/kernel/debug/tracing/events. Simply
-calling
+calling::
 
   $ find /sys/kernel/debug/tracing/events -type d
 
 will give a fair indication of the number of events available.
 
 2.2 PCL (Performance Counters for Linux)
--------
+----------------------------------------
 
 Discovery and enumeration of all counters and events, including tracepoints,
 are available with the perf tool. Getting a list of available events is a
-simple case of:
+simple case of::
 
   $ perf list 2>&1 | grep Tracepoint
   ext4:ext4_free_inode                     [Tracepoint event]
@@ -57,7 +57,7 @@ simple case of:
 
 See Documentation/trace/events.txt for a proper description on how events
 can be enabled system-wide. A short example of enabling all events related
-to page allocation would look something like:
+to page allocation would look something like::
 
   $ for i in `find /sys/kernel/debug/tracing/events -name "enable" | grep mm_`; do echo 1 > $i; done
 
@@ -67,6 +67,7 @@ to page allocation would look something like:
 In SystemTap, tracepoints are accessible using the kernel.trace() function
 call. The following is an example that reports every 5 seconds what processes
 were allocating the pages.
+::
 
   global page_allocs
 
@@ -91,6 +92,7 @@ were allocating the pages.
 
 By specifying the -a switch and analysing sleep, the system-wide events
 for a duration of time can be examined.
+::
 
  $ perf stat -a \
 	-e kmem:mm_page_alloc -e kmem:mm_page_free \
@@ -118,6 +120,7 @@ basis using set_ftrace_pid.
 
 Events can be activated and tracked for the duration of a process on a local
 basis using PCL such as follows.
+::
 
   $ perf stat -e kmem:mm_page_alloc -e kmem:mm_page_free \
 		 -e kmem:mm_page_free_batched ./hackbench 10
@@ -145,6 +148,7 @@ Any workload can exhibit variances between runs and it can be important
 to know what the standard deviation is. By and large, this is left to the
 performance analyst to do it by hand. In the event that the discrete event
 occurrences are useful to the performance analyst, then perf can be used.
+::
 
   $ perf stat --repeat 5 -e kmem:mm_page_alloc -e kmem:mm_page_free
 			-e kmem:mm_page_free_batched ./hackbench 10
@@ -167,6 +171,7 @@ aggregation of discrete events, then a script would need to be developed.
 
 Using --repeat, it is also possible to view how events are fluctuating over
 time on a system-wide basis using -a and sleep.
+::
 
   $ perf stat -e kmem:mm_page_alloc -e kmem:mm_page_free \
 		-e kmem:mm_page_free_batched \
@@ -188,9 +193,9 @@ When events are enabled the events that are triggering can be read from
 options exist as well. By post-processing the output, further information can
 be gathered on-line as appropriate. Examples of post-processing might include
 
-  o Reading information from /proc for the PID that triggered the event
-  o Deriving a higher-level event from a series of lower-level events.
-  o Calculating latencies between two events
+  - Reading information from /proc for the PID that triggered the event
+  - Deriving a higher-level event from a series of lower-level events.
+  - Calculating latencies between two events
 
 Documentation/trace/postprocess/trace-pagealloc-postprocess.pl is an example
 script that can read trace_pipe from STDIN or a copy of a trace. When used
@@ -200,14 +205,14 @@ and twice to exit.
 Simplistically, the script just reads STDIN and counts up events but it
 also can do more such as
 
-  o Derive high-level events from many low-level events. If a number of pages
+  - Derive high-level events from many low-level events. If a number of pages
     are freed to the main allocator from the per-CPU lists, it recognises
     that as one per-CPU drain even though there is no specific tracepoint
     for that event
-  o It can aggregate based on PID or individual process number
-  o In the event memory is getting externally fragmented, it reports
+  - It can aggregate based on PID or individual process number
+  - In the event memory is getting externally fragmented, it reports
     on whether the fragmentation event was severe or moderate.
-  o When receiving an event about a PID, it can record who the parent was so
+  - When receiving an event about a PID, it can record who the parent was so
     that if large numbers of events are coming from very short-lived
     processes, the parent process responsible for creating all the helpers
     can be identified
@@ -218,6 +223,7 @@ also can do more such as
 There may also be a requirement to identify what functions within a program
 were generating events within the kernel. To begin this sort of analysis, the
 data must be recorded. At the time of writing, this required root:
+::
 
   $ perf record -c 1 \
 	-e kmem:mm_page_alloc -e kmem:mm_page_free \
@@ -232,6 +238,7 @@ very coarse as a result.
 
 This record outputted a file called perf.data which can be analysed using
 perf report.
+::
 
   $ perf report
   # Samples: 30922
@@ -258,6 +265,7 @@ within the VDSO. With simple binaries, this will often be the case so let's
 take a slightly different example. In the course of writing this, it was
 noticed that X was generating an insane amount of page allocations so let's look
 at it:
+::
 
   $ perf record -c 1 -f \
 		-e kmem:mm_page_alloc -e kmem:mm_page_free \
@@ -265,6 +273,7 @@ at it:
 		-p `pidof X`
 
 This was interrupted after a few seconds and
+::
 
   $ perf report
   # Samples: 27666
@@ -282,6 +291,7 @@ This was interrupted after a few seconds and
 
 So, almost half of the events are occurring in a library. To get an idea which
 symbol:
+::
 
   $ perf report --sort comm,dso,symbol
   # Samples: 27666
@@ -298,6 +308,7 @@ symbol:
        0.00%     Xorg  [kernel]                                 [k] ftrace_trace_userstack
 
 To see where within the function pixmanFillsse2 things are going wrong:
+::
 
   $ perf annotate pixmanFillsse2
   [ ... ]
-- 
2.7.4
