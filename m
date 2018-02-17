Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751379AbeBQFvx (ORCPT <rfc822;w@1wt.eu>);
        Sat, 17 Feb 2018 00:51:53 -0500
Received: from mga18.intel.com ([134.134.136.126]:1064 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751141AbeBQFtR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Feb 2018 00:49:17 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.46,523,1511856000";
   d="scan'208";a="20863380"
From: changbin.du@intel.com
To: corbet@lwn.net, rostedt@goodmis.org
Cc: mingo@kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, Changbin Du <changbin.du@intel.com>
Subject: [PATCH 11/17] trace doc: convert trace/events-power.txt to rst format
Date: Sat, 17 Feb 2018 13:39:44 +0800
Message-Id: <1518845990-20733-12-git-send-email-changbin.du@intel.com>
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
 .../trace/{events-power.txt => events-power.rst}   | 52 +++++++++++++---------
 Documentation/trace/index.rst                      |  1 +
 2 files changed, 31 insertions(+), 22 deletions(-)
 rename Documentation/trace/{events-power.txt => events-power.rst} (65%)

diff --git a/Documentation/trace/events-power.txt b/Documentation/trace/events-power.rst
similarity index 65%
rename from Documentation/trace/events-power.txt
rename to Documentation/trace/events-power.rst
index 21d514c..a77daca 100644
--- a/Documentation/trace/events-power.txt
+++ b/Documentation/trace/events-power.rst
@@ -1,13 +1,14 @@
-
-			Subsystem Trace Points: power
+=============================
+Subsystem Trace Points: power
+=============================
 
 The power tracing system captures events related to power transitions
 within the kernel. Broadly speaking there are three major subheadings:
 
-  o Power state switch which reports events related to suspend (S-states),
-     cpuidle (C-states) and cpufreq (P-states)
-  o System clock related changes
-  o Power domains related changes and transitions
+  - Power state switch which reports events related to suspend (S-states),
+    cpuidle (C-states) and cpufreq (P-states)
+  - System clock related changes
+  - Power domains related changes and transitions
 
 This document describes what each of the tracepoints is and why they
 might be useful.
@@ -22,14 +23,16 @@ Cf. include/trace/events/power.h for the events definitions.
 
 A 'cpu' event class gathers the CPU-related events: cpuidle and
 cpufreq.
+::
 
-cpu_idle		"state=%lu cpu_id=%lu"
-cpu_frequency		"state=%lu cpu_id=%lu"
+  cpu_idle		"state=%lu cpu_id=%lu"
+  cpu_frequency		"state=%lu cpu_id=%lu"
 
 A suspend event is used to indicate the system going in and out of the
 suspend mode:
+::
 
-machine_suspend		"state=%lu"
+  machine_suspend		"state=%lu"
 
 
 Note: the value of '-1' or '4294967295' for state means an exit from the current state,
@@ -45,10 +48,11 @@ correctly draw the states diagrams and to calculate accurate statistics etc.
 ================
 The clock events are used for clock enable/disable and for
 clock rate change.
+::
 
-clock_enable		"%s state=%lu cpu_id=%lu"
-clock_disable		"%s state=%lu cpu_id=%lu"
-clock_set_rate		"%s state=%lu cpu_id=%lu"
+  clock_enable		"%s state=%lu cpu_id=%lu"
+  clock_disable		"%s state=%lu cpu_id=%lu"
+  clock_set_rate		"%s state=%lu cpu_id=%lu"
 
 The first parameter gives the clock name (e.g. "gpio1_iclk").
 The second parameter is '1' for enable, '0' for disable, the target
@@ -57,8 +61,9 @@ clock rate for set_rate.
 3. Power domains events
 =======================
 The power domain events are used for power domains transitions
+::
 
-power_domain_target	"%s state=%lu cpu_id=%lu"
+  power_domain_target	"%s state=%lu cpu_id=%lu"
 
 The first parameter gives the power domain name (e.g. "mpu_pwrdm").
 The second parameter is the power domain target state.
@@ -67,28 +72,31 @@ The second parameter is the power domain target state.
 ================
 The PM QoS events are used for QoS add/update/remove request and for
 target/flags update.
+::
 
-pm_qos_add_request                 "pm_qos_class=%s value=%d"
-pm_qos_update_request              "pm_qos_class=%s value=%d"
-pm_qos_remove_request              "pm_qos_class=%s value=%d"
-pm_qos_update_request_timeout      "pm_qos_class=%s value=%d, timeout_us=%ld"
+  pm_qos_add_request                 "pm_qos_class=%s value=%d"
+  pm_qos_update_request              "pm_qos_class=%s value=%d"
+  pm_qos_remove_request              "pm_qos_class=%s value=%d"
+  pm_qos_update_request_timeout      "pm_qos_class=%s value=%d, timeout_us=%ld"
 
 The first parameter gives the QoS class name (e.g. "CPU_DMA_LATENCY").
 The second parameter is value to be added/updated/removed.
 The third parameter is timeout value in usec.
+::
 
-pm_qos_update_target               "action=%s prev_value=%d curr_value=%d"
-pm_qos_update_flags                "action=%s prev_value=0x%x curr_value=0x%x"
+  pm_qos_update_target               "action=%s prev_value=%d curr_value=%d"
+  pm_qos_update_flags                "action=%s prev_value=0x%x curr_value=0x%x"
 
 The first parameter gives the QoS action name (e.g. "ADD_REQ").
 The second parameter is the previous QoS value.
 The third parameter is the current QoS value to update.
 
 And, there are also events used for device PM QoS add/update/remove request.
+::
 
-dev_pm_qos_add_request             "device=%s type=%s new_value=%d"
-dev_pm_qos_update_request          "device=%s type=%s new_value=%d"
-dev_pm_qos_remove_request          "device=%s type=%s new_value=%d"
+  dev_pm_qos_add_request             "device=%s type=%s new_value=%d"
+  dev_pm_qos_update_request          "device=%s type=%s new_value=%d"
+  dev_pm_qos_remove_request          "device=%s type=%s new_value=%d"
 
 The first parameter gives the device name which tries to add/update/remove
 QoS requests.
diff --git a/Documentation/trace/index.rst b/Documentation/trace/index.rst
index 95586aa..309c9c5 100644
--- a/Documentation/trace/index.rst
+++ b/Documentation/trace/index.rst
@@ -14,3 +14,4 @@ Linux Tracing Technologies
    tracepoints
    events
    events-kmem
+   events-power
-- 
2.7.4
