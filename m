Return-Path: <SRS0=AzW9=NE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UPPERCASE_50_75,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD381C004D3
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Oct 2018 08:07:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9B9F22082F
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Oct 2018 08:07:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9B9F22082F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727637AbeJXQeJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Oct 2018 12:34:09 -0400
Received: from mga18.intel.com ([134.134.136.126]:4492 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727595AbeJXQeI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Oct 2018 12:34:08 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 24 Oct 2018 01:07:05 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,419,1534834800"; 
   d="scan'208";a="273987209"
Received: from skx-d.bj.intel.com ([10.238.135.53])
  by fmsmga005.fm.intel.com with ESMTP; 24 Oct 2018 01:07:00 -0700
From:   Luwei Kang <luwei.kang@intel.com>
To:     kvm@vger.kernel.org, x86@kernel.org
Cc:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, hpa@zytor.com,
        pbonzini@redhat.com, rkrcmar@redhat.com, joro@8bytes.org,
        songliubraving@fb.com, peterz@infradead.org,
        alexander.shishkin@linux.intel.com, kstewart@linuxfoundation.org,
        gregkh@linuxfoundation.org, thomas.lendacky@amd.com,
        konrad.wilk@oracle.com, mattst88@gmail.com,
        Janakarajan.Natarajan@amd.com, dwmw@amazon.co.uk,
        jpoimboe@redhat.com, marcorr@google.com, ubizjak@gmail.com,
        sean.j.christopherson@intel.com, jmattson@google.com,
        linux-kernel@vger.kernel.org,
        Chao Peng <chao.p.peng@linux.intel.com>,
        Luwei Kang <luwei.kang@intel.com>
Subject: [PATCH v13 01/12] perf/x86/intel/pt: Move Intel PT MSRs bit defines to global header
Date:   Wed, 24 Oct 2018 16:05:05 +0800
Message-Id: <1540368316-12998-2-git-send-email-luwei.kang@intel.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1540368316-12998-1-git-send-email-luwei.kang@intel.com>
References: <1540368316-12998-1-git-send-email-luwei.kang@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Chao Peng <chao.p.peng@linux.intel.com>

The Intel Processor Trace (PT) MSR bit defines are in a private
header. The upcoming support for PT virtualization requires these defines
to be accessible from KVM code.

Move them to the global MSR header file.

Reviewed-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Chao Peng <chao.p.peng@linux.intel.com>
Signed-off-by: Luwei Kang <luwei.kang@intel.com>
---
 arch/x86/events/intel/pt.h       | 37 -------------------------------------
 arch/x86/include/asm/msr-index.h | 33 +++++++++++++++++++++++++++++++++
 2 files changed, 33 insertions(+), 37 deletions(-)

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
index 4731f0c..d3a9eb9 100644
--- a/arch/x86/include/asm/msr-index.h
+++ b/arch/x86/include/asm/msr-index.h
@@ -120,7 +120,40 @@
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
+#define RTIT_CTL_PSB_FREQ		(0x0full << RTIT_CTL_PSB_FREQ_OFFSET)
+#define RTIT_CTL_ADDR0_OFFSET		32
+#define RTIT_CTL_ADDR0			(0x0full << RTIT_CTL_ADDR0_OFFSET)
+#define RTIT_CTL_ADDR1_OFFSET		36
+#define RTIT_CTL_ADDR1			(0x0full << RTIT_CTL_ADDR1_OFFSET)
+#define RTIT_CTL_ADDR2_OFFSET		40
+#define RTIT_CTL_ADDR2			(0x0full << RTIT_CTL_ADDR2_OFFSET)
+#define RTIT_CTL_ADDR3_OFFSET		44
+#define RTIT_CTL_ADDR3			(0x0full << RTIT_CTL_ADDR3_OFFSET)
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
-- 
1.8.3.1

