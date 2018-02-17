Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751349AbeBQFug (ORCPT <rfc822;w@1wt.eu>);
        Sat, 17 Feb 2018 00:50:36 -0500
Received: from mga02.intel.com ([134.134.136.20]:59982 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751204AbeBQFtY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Feb 2018 00:49:24 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.46,523,1511856000";
   d="scan'208";a="20863402"
From: changbin.du@intel.com
To: corbet@lwn.net, rostedt@goodmis.org
Cc: mingo@kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, Changbin Du <changbin.du@intel.com>
Subject: [PATCH 13/17] trace doc: convert trace/events-msr.txt to rst format
Date: Sat, 17 Feb 2018 13:39:46 +0800
Message-Id: <1518845990-20733-14-git-send-email-changbin.du@intel.com>
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
 Documentation/trace/events-msr.rst | 40 ++++++++++++++++++++++++++++++++++++++
 Documentation/trace/events-msr.txt | 37 -----------------------------------
 Documentation/trace/index.rst      |  1 +
 3 files changed, 41 insertions(+), 37 deletions(-)
 create mode 100644 Documentation/trace/events-msr.rst
 delete mode 100644 Documentation/trace/events-msr.txt

diff --git a/Documentation/trace/events-msr.rst b/Documentation/trace/events-msr.rst
new file mode 100644
index 0000000..e938aa0
--- /dev/null
+++ b/Documentation/trace/events-msr.rst
@@ -0,0 +1,40 @@
+================
+MSR Trace Events
+================
+
+The x86 kernel supports tracing most MSR (Model Specific Register) accesses.
+To see the definition of the MSRs on Intel systems please see the SDM
+at http://www.intel.com/sdm (Volume 3)
+
+Available trace points:
+
+/sys/kernel/debug/tracing/events/msr/
+
+Trace MSR reads:
+
+read_msr
+
+  - msr: MSR number
+  - val: Value written
+  - failed: 1 if the access failed, otherwise 0
+
+
+Trace MSR writes:
+
+write_msr
+
+  - msr: MSR number
+  - val: Value written
+  - failed: 1 if the access failed, otherwise 0
+
+
+Trace RDPMC in kernel:
+
+rdpmc
+
+The trace data can be post processed with the postprocess/decode_msr.py script::
+
+  cat /sys/kernel/debug/tracing/trace | decode_msr.py /usr/src/linux/include/asm/msr-index.h
+
+to add symbolic MSR names.
+
diff --git a/Documentation/trace/events-msr.txt b/Documentation/trace/events-msr.txt
deleted file mode 100644
index 78c383b..0000000
--- a/Documentation/trace/events-msr.txt
+++ /dev/null
@@ -1,37 +0,0 @@
-
-The x86 kernel supports tracing most MSR (Model Specific Register) accesses.
-To see the definition of the MSRs on Intel systems please see the SDM
-at http://www.intel.com/sdm (Volume 3)
-
-Available trace points:
-
-/sys/kernel/debug/tracing/events/msr/
-
-Trace MSR reads
-
-read_msr
-
-msr: MSR number
-val: Value written
-failed: 1 if the access failed, otherwise 0
-
-
-Trace MSR writes
-
-write_msr
-
-msr: MSR number
-val: Value written
-failed: 1 if the access failed, otherwise 0
-
-
-Trace RDPMC in kernel
-
-rdpmc
-
-The trace data can be post processed with the postprocess/decode_msr.py script
-
-cat /sys/kernel/debug/tracing/trace | decode_msr.py /usr/src/linux/include/asm/msr-index.h
-
-to add symbolic MSR names.
-
diff --git a/Documentation/trace/index.rst b/Documentation/trace/index.rst
index f4a8fbc..307468d 100644
--- a/Documentation/trace/index.rst
+++ b/Documentation/trace/index.rst
@@ -16,3 +16,4 @@ Linux Tracing Technologies
    events-kmem
    events-power
    events-nmi
+   events-msr
-- 
2.7.4
