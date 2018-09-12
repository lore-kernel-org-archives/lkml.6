Return-Path: <SRS0=BZo9=L2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0ED58C4646A
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 00:10:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C6EE120880
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 00:10:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C6EE120880
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728048AbeILFML (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Sep 2018 01:12:11 -0400
Received: from mga03.intel.com ([134.134.136.65]:25689 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725740AbeILFMK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Sep 2018 01:12:10 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 11 Sep 2018 17:10:27 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.53,362,1531810800"; 
   d="scan'208";a="72213119"
Received: from sohilbuildbox.sc.intel.com (HELO localhost.localdomain) ([172.25.110.4])
  by orsmga007.jf.intel.com with ESMTP; 11 Sep 2018 17:10:06 -0700
From:   Sohil Mehta <sohil.mehta@intel.com>
To:     Joerg Roedel <joro@8bytes.org>
Cc:     Ashok Raj <ashok.raj@intel.com>,
        David Woodhouse <dwmw2@infradead.org>,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        Jacob Pan <jacob.jun.pan@linux.intel.com>,
        Gayatri Kammela <gayatri.kammela@intel.com>,
        Sohil Mehta <sohil.mehta@intel.com>,
        Ravi V Shankar <ravi.v.shankar@intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Fenghua Yu <fenghua.yu@intel.com>
Subject: [PATCH v8 2/6] iommu/vt-d: Update register definitions to VT-d 3.0 specification
Date:   Tue, 11 Sep 2018 17:11:37 -0700
Message-Id: <20180912001141.64025-3-sohil.mehta@intel.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180912001141.64025-1-sohil.mehta@intel.com>
References: <20180912001141.64025-1-sohil.mehta@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add new register definitions added in the VT-d 3.0 specification. Also
include registers that were missing previously.

Cc: Lu Baolu <baolu.lu@linux.intel.com>
Cc: Fenghua Yu <fenghua.yu@intel.com>
Cc: Jacob Pan <jacob.jun.pan@linux.intel.com>
Cc: Ashok Raj <ashok.raj@intel.com>
Cc: Gayatri Kammela <gayatri.kammela@intel.com>
Signed-off-by: Sohil Mehta <sohil.mehta@intel.com>
---

v8: Simplify and split the patches differently

 include/linux/intel-iommu.h | 36 ++++++++++++++++++++++++++++++++++++
 1 file changed, 36 insertions(+)

diff --git a/include/linux/intel-iommu.h b/include/linux/intel-iommu.h
index b7cf32e8ae1f..3bdb9aa198af 100644
--- a/include/linux/intel-iommu.h
+++ b/include/linux/intel-iommu.h
@@ -72,6 +72,42 @@
 #define	DMAR_PEDATA_REG	0xe4	/* Page request event interrupt data register */
 #define	DMAR_PEADDR_REG	0xe8	/* Page request event interrupt addr register */
 #define	DMAR_PEUADDR_REG 0xec	/* Page request event Upper address register */
+#define DMAR_MTRRCAP_REG 0x100	/* MTRR capability register */
+#define DMAR_MTRRDEF_REG 0x108	/* MTRR default type register */
+#define DMAR_MTRR_FIX64K_00000_REG 0x120 /* MTRR Fixed range registers */
+#define DMAR_MTRR_FIX16K_80000_REG 0x128
+#define DMAR_MTRR_FIX16K_A0000_REG 0x130
+#define DMAR_MTRR_FIX4K_C0000_REG 0x138
+#define DMAR_MTRR_FIX4K_C8000_REG 0x140
+#define DMAR_MTRR_FIX4K_D0000_REG 0x148
+#define DMAR_MTRR_FIX4K_D8000_REG 0x150
+#define DMAR_MTRR_FIX4K_E0000_REG 0x158
+#define DMAR_MTRR_FIX4K_E8000_REG 0x160
+#define DMAR_MTRR_FIX4K_F0000_REG 0x168
+#define DMAR_MTRR_FIX4K_F8000_REG 0x170
+#define DMAR_MTRR_PHYSBASE0_REG 0x180 /* MTRR Variable range registers */
+#define DMAR_MTRR_PHYSMASK0_REG 0x188
+#define DMAR_MTRR_PHYSBASE1_REG 0x190
+#define DMAR_MTRR_PHYSMASK1_REG 0x198
+#define DMAR_MTRR_PHYSBASE2_REG 0x1a0
+#define DMAR_MTRR_PHYSMASK2_REG 0x1a8
+#define DMAR_MTRR_PHYSBASE3_REG 0x1b0
+#define DMAR_MTRR_PHYSMASK3_REG 0x1b8
+#define DMAR_MTRR_PHYSBASE4_REG 0x1c0
+#define DMAR_MTRR_PHYSMASK4_REG 0x1c8
+#define DMAR_MTRR_PHYSBASE5_REG 0x1d0
+#define DMAR_MTRR_PHYSMASK5_REG 0x1d8
+#define DMAR_MTRR_PHYSBASE6_REG 0x1e0
+#define DMAR_MTRR_PHYSMASK6_REG 0x1e8
+#define DMAR_MTRR_PHYSBASE7_REG 0x1f0
+#define DMAR_MTRR_PHYSMASK7_REG 0x1f8
+#define DMAR_MTRR_PHYSBASE8_REG 0x200
+#define DMAR_MTRR_PHYSMASK8_REG 0x208
+#define DMAR_MTRR_PHYSBASE9_REG 0x210
+#define DMAR_MTRR_PHYSMASK9_REG 0x218
+#define DMAR_VCCAP_REG		0xe00 /* Virtual command capability register */
+#define DMAR_VCMD_REG		0xe10 /* Virtual command register */
+#define DMAR_VCRSP_REG		0xe20 /* Virtual command response register */
 
 #define OFFSET_STRIDE		(9)
 
-- 
2.18.0

