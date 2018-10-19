Return-Path: <SRS0=xTli=M7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UPPERCASE_50_75,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F12DFECDE43
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Oct 2018 17:05:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B64D820843
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Oct 2018 17:05:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B64D820843
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727998AbeJTBM0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Oct 2018 21:12:26 -0400
Received: from mga07.intel.com ([134.134.136.100]:33478 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727549AbeJTBM0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Oct 2018 21:12:26 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 19 Oct 2018 10:05:29 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,400,1534834800"; 
   d="scan'208";a="79349702"
Received: from otc-cfl-s-03.jf.intel.com ([10.54.55.152])
  by fmsmga007.fm.intel.com with ESMTP; 19 Oct 2018 10:05:28 -0700
From:   kan.liang@linux.intel.com
To:     tglx@linutronix.de, peterz@infradead.org, acme@redhat.com,
        linux-kernel@vger.kernel.org
Cc:     ak@linux.intel.com, Kan Liang <kan.liang@linux.intel.com>
Subject: [PATCH 1/2] perf/x86/intel/uncore: Add more IMC PCI IDs for KabyLake and CoffeeLake
Date:   Fri, 19 Oct 2018 10:04:18 -0700
Message-Id: <20181019170419.378-1-kan.liang@linux.intel.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kan Liang <kan.liang@linux.intel.com>

KabyLake and CoffeeLake has the same client uncore events as SkyLake.

Add the PCI IDs for KabyLake Y, U, S processor line and CoffeeLake U,
H, S processor line.

Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
---
 arch/x86/events/intel/uncore_snb.c | 115 ++++++++++++++++++++++++++++-
 1 file changed, 114 insertions(+), 1 deletion(-)

diff --git a/arch/x86/events/intel/uncore_snb.c b/arch/x86/events/intel/uncore_snb.c
index 8527c3e1038b..bfa25814fe5f 100644
--- a/arch/x86/events/intel/uncore_snb.c
+++ b/arch/x86/events/intel/uncore_snb.c
@@ -15,6 +15,25 @@
 #define PCI_DEVICE_ID_INTEL_SKL_HQ_IMC	0x1910
 #define PCI_DEVICE_ID_INTEL_SKL_SD_IMC	0x190f
 #define PCI_DEVICE_ID_INTEL_SKL_SQ_IMC	0x191f
+#define PCI_DEVICE_ID_INTEL_KBL_Y_IMC	0x590c
+#define PCI_DEVICE_ID_INTEL_KBL_U_IMC	0x5904
+#define PCI_DEVICE_ID_INTEL_KBL_UQ_IMC	0x5914
+#define PCI_DEVICE_ID_INTEL_KBL_SD_IMC	0x590f
+#define PCI_DEVICE_ID_INTEL_KBL_SQ_IMC	0x591f
+#define PCI_DEVICE_ID_INTEL_CFL_2U_IMC	0x3ecc
+#define PCI_DEVICE_ID_INTEL_CFL_4U_IMC	0x3ed0
+#define PCI_DEVICE_ID_INTEL_CFL_4H_IMC	0x3e10
+#define PCI_DEVICE_ID_INTEL_CFL_6H_IMC	0x3ec4
+#define PCI_DEVICE_ID_INTEL_CFL_2S_D_IMC	0x3e0f
+#define PCI_DEVICE_ID_INTEL_CFL_4S_D_IMC	0x3e1f
+#define PCI_DEVICE_ID_INTEL_CFL_6S_D_IMC	0x3ec2
+#define PCI_DEVICE_ID_INTEL_CFL_8S_D_IMC	0x3e30
+#define PCI_DEVICE_ID_INTEL_CFL_4S_W_IMC	0x3e18
+#define PCI_DEVICE_ID_INTEL_CFL_6S_W_IMC	0x3ec6
+#define PCI_DEVICE_ID_INTEL_CFL_8S_W_IMC	0x3e31
+#define PCI_DEVICE_ID_INTEL_CFL_4S_S_IMC	0x3e33
+#define PCI_DEVICE_ID_INTEL_CFL_6S_S_IMC	0x3eca
+#define PCI_DEVICE_ID_INTEL_CFL_8S_S_IMC	0x3e32
 
 /* SNB event control */
 #define SNB_UNC_CTL_EV_SEL_MASK			0x000000ff
@@ -569,7 +588,82 @@ static const struct pci_device_id skl_uncore_pci_ids[] = {
 		PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_SKL_SQ_IMC),
 		.driver_data = UNCORE_PCI_DEV_DATA(SNB_PCI_UNCORE_IMC, 0),
 	},
-
+	{ /* IMC */
+		PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_KBL_Y_IMC),
+		.driver_data = UNCORE_PCI_DEV_DATA(SNB_PCI_UNCORE_IMC, 0),
+	},
+	{ /* IMC */
+		PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_KBL_U_IMC),
+		.driver_data = UNCORE_PCI_DEV_DATA(SNB_PCI_UNCORE_IMC, 0),
+	},
+	{ /* IMC */
+		PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_KBL_UQ_IMC),
+		.driver_data = UNCORE_PCI_DEV_DATA(SNB_PCI_UNCORE_IMC, 0),
+	},
+	{ /* IMC */
+		PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_KBL_SD_IMC),
+		.driver_data = UNCORE_PCI_DEV_DATA(SNB_PCI_UNCORE_IMC, 0),
+	},
+	{ /* IMC */
+		PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_KBL_SQ_IMC),
+		.driver_data = UNCORE_PCI_DEV_DATA(SNB_PCI_UNCORE_IMC, 0),
+	},
+	{ /* IMC */
+		PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_CFL_2U_IMC),
+		.driver_data = UNCORE_PCI_DEV_DATA(SNB_PCI_UNCORE_IMC, 0),
+	},
+	{ /* IMC */
+		PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_CFL_4U_IMC),
+		.driver_data = UNCORE_PCI_DEV_DATA(SNB_PCI_UNCORE_IMC, 0),
+	},
+	{ /* IMC */
+		PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_CFL_4H_IMC),
+		.driver_data = UNCORE_PCI_DEV_DATA(SNB_PCI_UNCORE_IMC, 0),
+	},
+	{ /* IMC */
+		PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_CFL_6H_IMC),
+		.driver_data = UNCORE_PCI_DEV_DATA(SNB_PCI_UNCORE_IMC, 0),
+	},
+	{ /* IMC */
+		PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_CFL_2S_D_IMC),
+		.driver_data = UNCORE_PCI_DEV_DATA(SNB_PCI_UNCORE_IMC, 0),
+	},
+	{ /* IMC */
+		PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_CFL_4S_D_IMC),
+		.driver_data = UNCORE_PCI_DEV_DATA(SNB_PCI_UNCORE_IMC, 0),
+	},
+	{ /* IMC */
+		PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_CFL_6S_D_IMC),
+		.driver_data = UNCORE_PCI_DEV_DATA(SNB_PCI_UNCORE_IMC, 0),
+	},
+	{ /* IMC */
+		PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_CFL_8S_D_IMC),
+		.driver_data = UNCORE_PCI_DEV_DATA(SNB_PCI_UNCORE_IMC, 0),
+	},
+	{ /* IMC */
+		PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_CFL_4S_W_IMC),
+		.driver_data = UNCORE_PCI_DEV_DATA(SNB_PCI_UNCORE_IMC, 0),
+	},
+	{ /* IMC */
+		PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_CFL_6S_W_IMC),
+		.driver_data = UNCORE_PCI_DEV_DATA(SNB_PCI_UNCORE_IMC, 0),
+	},
+	{ /* IMC */
+		PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_CFL_8S_W_IMC),
+		.driver_data = UNCORE_PCI_DEV_DATA(SNB_PCI_UNCORE_IMC, 0),
+	},
+	{ /* IMC */
+		PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_CFL_4S_S_IMC),
+		.driver_data = UNCORE_PCI_DEV_DATA(SNB_PCI_UNCORE_IMC, 0),
+	},
+	{ /* IMC */
+		PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_CFL_6S_S_IMC),
+		.driver_data = UNCORE_PCI_DEV_DATA(SNB_PCI_UNCORE_IMC, 0),
+	},
+	{ /* IMC */
+		PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_CFL_8S_S_IMC),
+		.driver_data = UNCORE_PCI_DEV_DATA(SNB_PCI_UNCORE_IMC, 0),
+	},
 	{ /* end: all zeroes */ },
 };
 
@@ -618,6 +712,25 @@ static const struct imc_uncore_pci_dev desktop_imc_pci_ids[] = {
 	IMC_DEV(SKL_HQ_IMC, &skl_uncore_pci_driver),  /* 6th Gen Core H Quad Core */
 	IMC_DEV(SKL_SD_IMC, &skl_uncore_pci_driver),  /* 6th Gen Core S Dual Core */
 	IMC_DEV(SKL_SQ_IMC, &skl_uncore_pci_driver),  /* 6th Gen Core S Quad Core */
+	IMC_DEV(KBL_Y_IMC, &skl_uncore_pci_driver),  /* 7th Gen Core Y */
+	IMC_DEV(KBL_U_IMC, &skl_uncore_pci_driver),  /* 7th Gen Core U */
+	IMC_DEV(KBL_UQ_IMC, &skl_uncore_pci_driver),  /* 7th Gen Core U Quad Core */
+	IMC_DEV(KBL_SD_IMC, &skl_uncore_pci_driver),  /* 7th Gen Core S Dual Core */
+	IMC_DEV(KBL_SQ_IMC, &skl_uncore_pci_driver),  /* 7th Gen Core S Quad Core */
+	IMC_DEV(CFL_2U_IMC, &skl_uncore_pci_driver),  /* 8th Gen Core U 2 Cores */
+	IMC_DEV(CFL_4U_IMC, &skl_uncore_pci_driver),  /* 8th Gen Core U 4 Cores */
+	IMC_DEV(CFL_4H_IMC, &skl_uncore_pci_driver),  /* 8th Gen Core H 4 Cores */
+	IMC_DEV(CFL_6H_IMC, &skl_uncore_pci_driver),  /* 8th Gen Core H 6 Cores */
+	IMC_DEV(CFL_2S_D_IMC, &skl_uncore_pci_driver),  /* 8th Gen Core S 2 Cores Desktop */
+	IMC_DEV(CFL_4S_D_IMC, &skl_uncore_pci_driver),  /* 8th Gen Core S 4 Cores Desktop */
+	IMC_DEV(CFL_6S_D_IMC, &skl_uncore_pci_driver),  /* 8th Gen Core S 6 Cores Desktop */
+	IMC_DEV(CFL_8S_D_IMC, &skl_uncore_pci_driver),  /* 8th Gen Core S 8 Cores Desktop */
+	IMC_DEV(CFL_4S_W_IMC, &skl_uncore_pci_driver),  /* 8th Gen Core S 4 Cores Work Station */
+	IMC_DEV(CFL_6S_W_IMC, &skl_uncore_pci_driver),  /* 8th Gen Core S 6 Cores Work Station */
+	IMC_DEV(CFL_8S_W_IMC, &skl_uncore_pci_driver),  /* 8th Gen Core S 8 Cores Work Station */
+	IMC_DEV(CFL_4S_S_IMC, &skl_uncore_pci_driver),  /* 8th Gen Core S 4 Cores Server */
+	IMC_DEV(CFL_6S_S_IMC, &skl_uncore_pci_driver),  /* 8th Gen Core S 6 Cores Server */
+	IMC_DEV(CFL_8S_S_IMC, &skl_uncore_pci_driver),  /* 8th Gen Core S 8 Cores Server */
 	{  /* end marker */ }
 };
 
-- 
2.17.1

