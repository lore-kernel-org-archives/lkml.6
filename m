Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752367AbeECKWz (ORCPT <rfc822;w@1wt.eu>);
        Thu, 3 May 2018 06:22:55 -0400
Received: from mga06.intel.com ([134.134.136.31]:65500 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752108AbeECKS4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 May 2018 06:18:56 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,358,1520924400";
   d="scan'208";a="36546420"
From: Luwei Kang <luwei.kang@intel.com>
To: kvm@vger.kernel.org
Cc: tglx@linutronix.de, mingo@redhat.com, hpa@zytor.com, x86@kernel.org,
        pbonzini@redhat.com, rkrcmar@redhat.com, linux-kernel@vger.kernel.org,
        joro@8bytes.org, peterz@infradead.org, chao.p.peng@linux.intel.com,
        Luwei Kang <luwei.kang@intel.com>
Subject: [PATCH v7 01/13] perf/x86/intel/pt: Move Intel-PT MSRs bit definitions to a public header
Date: Thu,  3 May 2018 20:13:16 +0800
Message-Id: <1525349608-10352-2-git-send-email-luwei.kang@intel.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1525349608-10352-1-git-send-email-luwei.kang@intel.com>
References: <1525349608-10352-1-git-send-email-luwei.kang@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Chao Peng <chao.p.peng@linux.intel.com>

Intel Processor Trace virtualization enabling in KVM guest
need to access these MSRs bit definitions, so move them to
public header file msr-index.h.

Signed-off-by: Chao Peng <chao.p.peng@linux.intel.com>
Signed-off-by: Luwei Kang <luwei.kang@intel.com>
---
 arch/x86/events/intel/pt.h       | 37 -------------------------------------
 arch/x86/include/asm/msr-index.h | 34 ++++++++++++++++++++++++++++++++++
 2 files changed, 34 insertions(+), 37 deletions(-)

diff --git a/arch/x86/events/intel/pt.h b/arch/x86/events/intel/pt.h
index 0eb41d0..0050ca1 100644
--- a/arch/x86/events/intel/pt.h
+++ b/arch/x86/events/intel/pt.h
@@ -20,43 +20,6 @@
 #define __INTEL_PT_H__
 
 /*
- * PT MSR bit definitions
- */
-#define RTIT_CTL_TRACEEN		BIT(0)
-#define RTIT_CTL_CYCLEACC		BIT(1)
-#define RTIT_CTL_OS			BIT(2)
-#define RTIT_CTL_USR			BIT(3)
-#define RTIT_CTL_PWR_EVT_EN		BIT(4)
-#define RTIT_CTL_FUP_ON_PTW		BIT(5)
-#define RTIT_CTL_CR3EN			BIT(7)
-#define RTIT_CTL_TOPA			BIT(8)
-#define RTIT_CTL_MTC_EN			BIT(9)
-#define RTIT_CTL_TSC_EN			BIT(10)
-#define RTIT_CTL_DISRETC		BIT(11)
-#define RTIT_CTL_PTW_EN			BIT(12)
-#define RTIT_CTL_BRANCH_EN		BIT(13)
-#define RTIT_CTL_MTC_RANGE_OFFSET	14
-#define RTIT_CTL_MTC_RANGE		(0x0full << RTIT_CTL_MTC_RANGE_OFFSET)
-#define RTIT_CTL_CYC_THRESH_OFFSET	19
-#define RTIT_CTL_CYC_THRESH		(0x0full << RTIT_CTL_CYC_THRESH_OFFSET)
-#define RTIT_CTL_PSB_FREQ_OFFSET	24
-#define RTIT_CTL_PSB_FREQ      		(0x0full << RTIT_CTL_PSB_FREQ_OFFSET)
-#define RTIT_CTL_ADDR0_OFFSET		32
-#define RTIT_CTL_ADDR0      		(0x0full << RTIT_CTL_ADDR0_OFFSET)
-#define RTIT_CTL_ADDR1_OFFSET		36
-#define RTIT_CTL_ADDR1      		(0x0full << RTIT_CTL_ADDR1_OFFSET)
-#define RTIT_CTL_ADDR2_OFFSET		40
-#define RTIT_CTL_ADDR2      		(0x0full << RTIT_CTL_ADDR2_OFFSET)
-#define RTIT_CTL_ADDR3_OFFSET		44
-#define RTIT_CTL_ADDR3      		(0x0full << RTIT_CTL_ADDR3_OFFSET)
-#define RTIT_STATUS_FILTEREN		BIT(0)
-#define RTIT_STATUS_CONTEXTEN		BIT(1)
-#define RTIT_STATUS_TRIGGEREN		BIT(2)
-#define RTIT_STATUS_BUFFOVF		BIT(3)
-#define RTIT_STATUS_ERROR		BIT(4)
-#define RTIT_STATUS_STOPPED		BIT(5)
-
-/*
  * Single-entry ToPA: when this close to region boundary, switch
  * buffers to avoid losing data.
  */
diff --git a/arch/x86/include/asm/msr-index.h b/arch/x86/include/asm/msr-index.h
index 53d5b1b..c168e26 100644
--- a/arch/x86/include/asm/msr-index.h
+++ b/arch/x86/include/asm/msr-index.h
@@ -106,7 +106,40 @@
 #define MSR_PEBS_LD_LAT_THRESHOLD	0x000003f6
 
 #define MSR_IA32_RTIT_CTL		0x00000570
+#define RTIT_CTL_TRACEEN		BIT(0)
+#define RTIT_CTL_CYCLEACC		BIT(1)
+#define RTIT_CTL_OS			BIT(2)
+#define RTIT_CTL_USR			BIT(3)
+#define RTIT_CTL_PWR_EVT_EN		BIT(4)
+#define RTIT_CTL_FUP_ON_PTW		BIT(5)
+#define RTIT_CTL_CR3EN			BIT(7)
+#define RTIT_CTL_TOPA			BIT(8)
+#define RTIT_CTL_MTC_EN			BIT(9)
+#define RTIT_CTL_TSC_EN			BIT(10)
+#define RTIT_CTL_DISRETC		BIT(11)
+#define RTIT_CTL_PTW_EN			BIT(12)
+#define RTIT_CTL_BRANCH_EN		BIT(13)
+#define RTIT_CTL_MTC_RANGE_OFFSET	14
+#define RTIT_CTL_MTC_RANGE		(0x0full << RTIT_CTL_MTC_RANGE_OFFSET)
+#define RTIT_CTL_CYC_THRESH_OFFSET	19
+#define RTIT_CTL_CYC_THRESH		(0x0full << RTIT_CTL_CYC_THRESH_OFFSET)
+#define RTIT_CTL_PSB_FREQ_OFFSET	24
+#define RTIT_CTL_PSB_FREQ      		(0x0full << RTIT_CTL_PSB_FREQ_OFFSET)
+#define RTIT_CTL_ADDR0_OFFSET		32
+#define RTIT_CTL_ADDR0      		(0x0full << RTIT_CTL_ADDR0_OFFSET)
+#define RTIT_CTL_ADDR1_OFFSET		36
+#define RTIT_CTL_ADDR1      		(0x0full << RTIT_CTL_ADDR1_OFFSET)
+#define RTIT_CTL_ADDR2_OFFSET		40
+#define RTIT_CTL_ADDR2      		(0x0full << RTIT_CTL_ADDR2_OFFSET)
+#define RTIT_CTL_ADDR3_OFFSET		44
+#define RTIT_CTL_ADDR3      		(0x0full << RTIT_CTL_ADDR3_OFFSET)
 #define MSR_IA32_RTIT_STATUS		0x00000571
+#define RTIT_STATUS_FILTEREN		BIT(0)
+#define RTIT_STATUS_CONTEXTEN		BIT(1)
+#define RTIT_STATUS_TRIGGEREN		BIT(2)
+#define RTIT_STATUS_BUFFOVF		BIT(3)
+#define RTIT_STATUS_ERROR		BIT(4)
+#define RTIT_STATUS_STOPPED		BIT(5)
 #define MSR_IA32_RTIT_ADDR0_A		0x00000580
 #define MSR_IA32_RTIT_ADDR0_B		0x00000581
 #define MSR_IA32_RTIT_ADDR1_A		0x00000582
@@ -115,6 +148,7 @@
 #define MSR_IA32_RTIT_ADDR2_B		0x00000585
 #define MSR_IA32_RTIT_ADDR3_A		0x00000586
 #define MSR_IA32_RTIT_ADDR3_B		0x00000587
+#define MSR_IA32_RTIT_ADDR_COUNT	8
 #define MSR_IA32_RTIT_CR3_MATCH		0x00000572
 #define MSR_IA32_RTIT_OUTPUT_BASE	0x00000560
 #define MSR_IA32_RTIT_OUTPUT_MASK	0x00000561
-- 
1.8.3.1
