Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1033705AbeEXQaD (ORCPT <rfc822;w@1wt.eu>);
        Thu, 24 May 2018 12:30:03 -0400
Received: from mga06.intel.com ([134.134.136.31]:7324 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1033672AbeEXQ3Y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 May 2018 12:29:24 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,436,1520924400";
   d="scan'208";a="51893095"
From: richard.gong@linux.intel.com
To: catalin.marinas@arm.com, will.deacon@arm.com, dinguyen@kernel.org,
        robh+dt@kernel.org, mark.rutland@arm.com, atull@kernel.org,
        mdf@kernel.org, arnd@arndb.de, gregkh@linuxfoundation.org,
        corbet@lwn.net
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-fpga@vger.kernel.org,
        linux-doc@vger.kernel.org, yves.vandervennet@linux.intel.com,
        richard.gong@linux.intel.com, richard.gong@intel.com
Subject: [PATCHv5 8/8] Documentation: driver-api: add stratix10 service layer
Date: Thu, 24 May 2018 11:33:20 -0500
Message-Id: <1527179600-26441-9-git-send-email-richard.gong@linux.intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1527179600-26441-1-git-send-email-richard.gong@linux.intel.com>
References: <1527179600-26441-1-git-send-email-richard.gong@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Richard Gong <richard.gong@intel.com>

Add new file stratix10-svc.rst
Add stratix10-svc.rst to driver-api/index.rst

Signed-off-by: Richard Gong <richard.gong@intel.com>
Signed-off-by: Alan Tull <atull@kernel.org>
---
v5: this patch is added in patch set version 5
---
 Documentation/driver-api/index.rst         |  1 +
 Documentation/driver-api/stratix10-svc.rst | 32 ++++++++++++++++++++++++++++++
 2 files changed, 33 insertions(+)
 create mode 100644 Documentation/driver-api/stratix10-svc.rst

diff --git a/Documentation/driver-api/index.rst b/Documentation/driver-api/index.rst
index 6d8352c..4b31109 100644
--- a/Documentation/driver-api/index.rst
+++ b/Documentation/driver-api/index.rst
@@ -49,6 +49,7 @@ available subsections can be seen below.
    dmaengine/index
    slimbus
    soundwire/index
+   stratix10-svc
 
 .. only::  subproject and html
 
diff --git a/Documentation/driver-api/stratix10-svc.rst b/Documentation/driver-api/stratix10-svc.rst
new file mode 100644
index 0000000..ed361d8
--- /dev/null
+++ b/Documentation/driver-api/stratix10-svc.rst
@@ -0,0 +1,32 @@
+
+Intel Stratix10 SoC Service Layer
+=================================
+
+Some features of the Intel Stratix10 SoC require a level of privilege
+higher than the kernel is granted. Such secure features include
+FPGA programming. In terms of the ARMv8 architecture, the kernel runs
+at Exception Level 1 (EL1), access to the features requires
+Exception Level 3 (EL3).
+
+The Intel Stratix10 SoC service layer provides an in kernel API for
+drivers to request access to the secure features. The requests are queued
+and processed one by one. ARM’s SMCCC is used to pass the execution
+of the requests on to a secure monitor (EL3).
+
+.. kernel-doc:: include/linux/stratix10-svc-client.h
+   :functions: stratix10_svc_command_code
+
+.. kernel-doc:: include/linux/stratix10-svc-client.h
+   :functions: stratix10_svc_client_msg
+
+.. kernel-doc:: include/linux/stratix10-svc-client.h
+   :functions: stratix10_svc_command_reconfig_payload
+
+.. kernel-doc:: include/linux/stratix10-svc-client.h
+   :functions: stratix10_svc_cb_data
+
+.. kernel-doc:: include/linux/stratix10-svc-client.h
+   :functions: stratix10_svc_client
+
+.. kernel-doc:: drivers/misc/stratix10-svc.c
+   :export:
-- 
2.7.4
