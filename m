Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751259AbeBQFtb (ORCPT <rfc822;w@1wt.eu>);
        Sat, 17 Feb 2018 00:49:31 -0500
Received: from mga02.intel.com ([134.134.136.20]:59982 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751133AbeBQFt0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Feb 2018 00:49:26 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.46,523,1511856000";
   d="scan'208";a="20863414"
From: changbin.du@intel.com
To: corbet@lwn.net, rostedt@goodmis.org
Cc: mingo@kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, Changbin Du <changbin.du@intel.com>
Subject: [PATCH 15/17] trace doc: convert trace/hwlat_detector.txt to rst fromat
Date: Sat, 17 Feb 2018 13:39:48 +0800
Message-Id: <1518845990-20733-16-git-send-email-changbin.du@intel.com>
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
 .../{hwlat_detector.txt => hwlat_detector.rst}     | 26 +++++++++++++---------
 Documentation/trace/index.rst                      |  1 +
 2 files changed, 16 insertions(+), 11 deletions(-)
 rename Documentation/trace/{hwlat_detector.txt => hwlat_detector.rst} (83%)

diff --git a/Documentation/trace/hwlat_detector.txt b/Documentation/trace/hwlat_detector.rst
similarity index 83%
rename from Documentation/trace/hwlat_detector.txt
rename to Documentation/trace/hwlat_detector.rst
index 3207717..5739349 100644
--- a/Documentation/trace/hwlat_detector.txt
+++ b/Documentation/trace/hwlat_detector.rst
@@ -1,4 +1,8 @@
-Introduction:
+=========================
+Hardware Latency Detector
+=========================
+
+Introduction
 -------------
 
 The tracer hwlat_detector is a special purpose tracer that is used to
@@ -28,7 +32,7 @@ Note that the hwlat detector should *NEVER* be used in a production environment.
 It is intended to be run manually to determine if the hardware platform has a
 problem with long system firmware service routines.
 
-Usage:
+Usage
 ------
 
 Write the ASCII text "hwlat" into the current_tracer file of the tracing system
@@ -36,16 +40,16 @@ Write the ASCII text "hwlat" into the current_tracer file of the tracing system
 redefine the threshold in microseconds (us) above which latency spikes will
 be taken into account.
 
-Example:
+Example::
 
 	# echo hwlat > /sys/kernel/tracing/current_tracer
 	# echo 100 > /sys/kernel/tracing/tracing_thresh
 
 The /sys/kernel/tracing/hwlat_detector interface contains the following files:
 
-width			- time period to sample with CPUs held (usecs)
-			  must be less than the total window size (enforced)
-window			- total period of sampling, width being inside (usecs)
+  - width - time period to sample with CPUs held (usecs)
+            must be less than the total window size (enforced)
+  - window - total period of sampling, width being inside (usecs)
 
 By default the width is set to 500,000 and window to 1,000,000, meaning that
 for every 1,000,000 usecs (1s) the hwlat detector will spin for 500,000 usecs
@@ -67,11 +71,11 @@ The following tracing directory files are used by the hwlat_detector:
 
 in /sys/kernel/tracing:
 
- tracing_threshold	- minimum latency value to be considered (usecs)
- tracing_max_latency	- maximum hardware latency actually observed (usecs)
- tracing_cpumask	- the CPUs to move the hwlat thread across
- hwlat_detector/width	- specified amount of time to spin within window (usecs)
- hwlat_detector/window	- amount of time between (width) runs (usecs)
+ - tracing_threshold	- minimum latency value to be considered (usecs)
+ - tracing_max_latency	- maximum hardware latency actually observed (usecs)
+ - tracing_cpumask	- the CPUs to move the hwlat thread across
+ - hwlat_detector/width	- specified amount of time to spin within window (usecs)
+ - hwlat_detector/window	- amount of time between (width) runs (usecs)
 
 The hwlat detector's kernel thread will migrate across each CPU specified in
 tracing_cpumask between each window. To limit the migration, either modify
diff --git a/Documentation/trace/index.rst b/Documentation/trace/index.rst
index 4b3d690..eabbbaf 100644
--- a/Documentation/trace/index.rst
+++ b/Documentation/trace/index.rst
@@ -18,3 +18,4 @@ Linux Tracing Technologies
    events-nmi
    events-msr
    mmiotrace
+   hwlat_detector
-- 
2.7.4
