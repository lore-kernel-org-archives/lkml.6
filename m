Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751301AbeBQFt4 (ORCPT <rfc822;w@1wt.eu>);
        Sat, 17 Feb 2018 00:49:56 -0500
Received: from mga02.intel.com ([134.134.136.20]:59982 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751240AbeBQFt3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Feb 2018 00:49:29 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.46,523,1511856000";
   d="scan'208";a="20863425"
From: changbin.du@intel.com
To: corbet@lwn.net, rostedt@goodmis.org
Cc: mingo@kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, Changbin Du <changbin.du@intel.com>
Subject: [PATCH 17/17] trace doc: convert trace/stm.txt to rst format
Date: Sat, 17 Feb 2018 13:39:50 +0800
Message-Id: <1518845990-20733-18-git-send-email-changbin.du@intel.com>
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
 Documentation/trace/index.rst            |  1 +
 Documentation/trace/{stm.txt => stm.rst} | 23 ++++++++++++-----------
 2 files changed, 13 insertions(+), 11 deletions(-)
 rename Documentation/trace/{stm.txt => stm.rst} (91%)

diff --git a/Documentation/trace/index.rst b/Documentation/trace/index.rst
index 02cc56c..b58c10b 100644
--- a/Documentation/trace/index.rst
+++ b/Documentation/trace/index.rst
@@ -20,3 +20,4 @@ Linux Tracing Technologies
    mmiotrace
    hwlat_detector
    intel_th
+   stm
diff --git a/Documentation/trace/stm.txt b/Documentation/trace/stm.rst
similarity index 91%
rename from Documentation/trace/stm.txt
rename to Documentation/trace/stm.rst
index 0376575..2c22ddb 100644
--- a/Documentation/trace/stm.txt
+++ b/Documentation/trace/stm.rst
@@ -1,3 +1,4 @@
+===================
 System Trace Module
 ===================
 
@@ -32,14 +33,14 @@ associated with it, located in "stp-policy" subsystem directory in
 configfs. The topmost directory's name (the policy) is formatted as
 the STM device name to which this policy applies and and arbitrary
 string identifier separated by a stop. From the examle above, a rule
-may look like this:
+may look like this::
 
-$ ls /config/stp-policy/dummy_stm.my-policy/user
-channels masters
-$ cat /config/stp-policy/dummy_stm.my-policy/user/masters
-48 63
-$ cat /config/stp-policy/dummy_stm.my-policy/user/channels
-0 127
+	$ ls /config/stp-policy/dummy_stm.my-policy/user
+	channels masters
+	$ cat /config/stp-policy/dummy_stm.my-policy/user/masters
+	48 63
+	$ cat /config/stp-policy/dummy_stm.my-policy/user/channels
+	0 127
 
 which means that the master allocation pool for this rule consists of
 masters 48 through 63 and channel allocation pool has channels 0
@@ -78,9 +79,9 @@ stm_source
 For kernel-based trace sources, there is "stm_source" device
 class. Devices of this class can be connected and disconnected to/from
 stm devices at runtime via a sysfs attribute called "stm_source_link"
-by writing the name of the desired stm device there, for example:
+by writing the name of the desired stm device there, for example::
 
-$ echo dummy_stm.0 > /sys/class/stm_source/console/stm_source_link
+	$ echo dummy_stm.0 > /sys/class/stm_source/console/stm_source_link
 
 For examples on how to use stm_source interface in the kernel, refer
 to stm_console, stm_heartbeat or stm_ftrace drivers.
@@ -118,5 +119,5 @@ the same time.
 
 Currently only Ftrace "function" tracer is supported.
 
-[1] https://software.intel.com/sites/default/files/managed/d3/3c/intel-th-developer-manual.pdf
-[2] http://infocenter.arm.com/help/index.jsp?topic=/com.arm.doc.ddi0444b/index.html
+* [1] https://software.intel.com/sites/default/files/managed/d3/3c/intel-th-developer-manual.pdf
+* [2] http://infocenter.arm.com/help/index.jsp?topic=/com.arm.doc.ddi0444b/index.html
-- 
2.7.4
