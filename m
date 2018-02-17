Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751279AbeBQFte (ORCPT <rfc822;w@1wt.eu>);
        Sat, 17 Feb 2018 00:49:34 -0500
Received: from mga02.intel.com ([134.134.136.20]:59982 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751239AbeBQFt2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Feb 2018 00:49:28 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.46,523,1511856000";
   d="scan'208";a="20863419"
From: changbin.du@intel.com
To: corbet@lwn.net, rostedt@goodmis.org
Cc: mingo@kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, Changbin Du <changbin.du@intel.com>
Subject: [PATCH 16/17] trace doc: convert trace/intel_th.txt to rst format
Date: Sat, 17 Feb 2018 13:39:49 +0800
Message-Id: <1518845990-20733-17-git-send-email-changbin.du@intel.com>
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
 Documentation/trace/{intel_th.txt => intel_th.rst} | 43 +++++++++++-----------
 2 files changed, 23 insertions(+), 21 deletions(-)
 rename Documentation/trace/{intel_th.txt => intel_th.rst} (82%)

diff --git a/Documentation/trace/index.rst b/Documentation/trace/index.rst
index eabbbaf..02cc56c 100644
--- a/Documentation/trace/index.rst
+++ b/Documentation/trace/index.rst
@@ -19,3 +19,4 @@ Linux Tracing Technologies
    events-msr
    mmiotrace
    hwlat_detector
+   intel_th
diff --git a/Documentation/trace/intel_th.txt b/Documentation/trace/intel_th.rst
similarity index 82%
rename from Documentation/trace/intel_th.txt
rename to Documentation/trace/intel_th.rst
index 7a57165..990f132 100644
--- a/Documentation/trace/intel_th.txt
+++ b/Documentation/trace/intel_th.rst
@@ -1,3 +1,4 @@
+=======================
 Intel(R) Trace Hub (TH)
 =======================
 
@@ -18,13 +19,13 @@ via sysfs attributes.
 
 Currently, the following Intel TH subdevices (blocks) are supported:
   - Software Trace Hub (STH), trace source, which is a System Trace
-  Module (STM) device,
+    Module (STM) device,
   - Memory Storage Unit (MSU), trace output, which allows storing
-  trace hub output in system memory,
+    trace hub output in system memory,
   - Parallel Trace Interface output (PTI), trace output to an external
-  debug host via a PTI port,
+    debug host via a PTI port,
   - Global Trace Hub (GTH), which is a switch and a central component
-  of Intel(R) Trace Hub architecture.
+    of Intel(R) Trace Hub architecture.
 
 Common attributes for output devices are described in
 Documentation/ABI/testing/sysfs-bus-intel_th-output-devices, the most
@@ -65,41 +66,41 @@ allocated, are accessible via /dev/intel_th0/msc{0,1}.
 Quick example
 -------------
 
-# figure out which GTH port is the first memory controller:
+# figure out which GTH port is the first memory controller::
 
-$ cat /sys/bus/intel_th/devices/0-msc0/port
-0
+	$ cat /sys/bus/intel_th/devices/0-msc0/port
+	0
 
-# looks like it's port 0, configure master 33 to send data to port 0:
+# looks like it's port 0, configure master 33 to send data to port 0::
 
-$ echo 0 > /sys/bus/intel_th/devices/0-gth/masters/33
+	$ echo 0 > /sys/bus/intel_th/devices/0-gth/masters/33
 
 # allocate a 2-windowed multiblock buffer on the first memory
-# controller, each with 64 pages:
+# controller, each with 64 pages::
 
-$ echo multi > /sys/bus/intel_th/devices/0-msc0/mode
-$ echo 64,64 > /sys/bus/intel_th/devices/0-msc0/nr_pages
+	$ echo multi > /sys/bus/intel_th/devices/0-msc0/mode
+	$ echo 64,64 > /sys/bus/intel_th/devices/0-msc0/nr_pages
 
-# enable wrapping for this controller, too:
+# enable wrapping for this controller, too::
 
-$ echo 1 > /sys/bus/intel_th/devices/0-msc0/wrap
+	$ echo 1 > /sys/bus/intel_th/devices/0-msc0/wrap
 
-# and enable tracing into this port:
+# and enable tracing into this port::
 
-$ echo 1 > /sys/bus/intel_th/devices/0-msc0/active
+	$ echo 1 > /sys/bus/intel_th/devices/0-msc0/active
 
 # .. send data to master 33, see stm.txt for more details ..
 # .. wait for traces to pile up ..
-# .. and stop the trace:
+# .. and stop the trace::
 
-$ echo 0 > /sys/bus/intel_th/devices/0-msc0/active
+	$ echo 0 > /sys/bus/intel_th/devices/0-msc0/active
 
-# and now you can collect the trace from the device node:
+# and now you can collect the trace from the device node::
 
-$ cat /dev/intel_th0/msc0 > my_stp_trace
+	$ cat /dev/intel_th0/msc0 > my_stp_trace
 
 Host Debugger Mode
-==================
+------------------
 
 It is possible to configure the Trace Hub and control its trace
 capture from a remote debug host, which should be connected via one of
-- 
2.7.4
