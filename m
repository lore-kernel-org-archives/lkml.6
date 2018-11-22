Return-Path: <SRS0=Yw3T=OB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,UPPERCASE_50_75,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0ADBC43441
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 19:53:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8071820866
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 19:53:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="LLNZbAe1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8071820866
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2438526AbeKWGea (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 23 Nov 2018 01:34:30 -0500
Received: from mail.kernel.org ([198.145.29.99]:33480 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2404680AbeKWGea (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Nov 2018 01:34:30 -0500
Received: from sasha-vm.mshome.net (unknown [37.142.5.207])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 23E8820864;
        Thu, 22 Nov 2018 19:53:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1542916417;
        bh=0ccDhM3Z3YV2b2jVWvRj+lYKsUyuZjWi2EoIajI/tKg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=LLNZbAe1Jja6j+jpc1DjWZ4pufDu4AXynQlHDovxOjpEic73jML+U2ISiqx2SO0OL
         HRE56+dWZWej1+qyU+LqziICJAuHHrY+wn+re1EQby3BzR2zUvnHZEzh7qrNqiF0cX
         R2usvfxr9QYHkFmzPTnfe8/HEVJ8pcXVwK2syflY=
From:   Sasha Levin <sashal@kernel.org>
To:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Kan Liang <kan.liang@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Stephane Eranian <eranian@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vince Weaver <vincent.weaver@maine.edu>,
        Ingo Molnar <mingo@kernel.org>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.19 18/36] perf/x86/intel/uncore: Add more IMC PCI IDs for KabyLake and CoffeeLake CPUs
Date:   Thu, 22 Nov 2018 14:52:22 -0500
Message-Id: <20181122195240.13123-18-sashal@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181122195240.13123-1-sashal@kernel.org>
References: <20181122195240.13123-1-sashal@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kan Liang <kan.liang@linux.intel.com>

[ Upstream commit c10a8de0d32e95b0b8c7c17b6dc09baea5a5a899 ]

KabyLake and CoffeeLake CPUs have the same client uncore events as SkyLake.

Add the PCI IDs for the KabyLake Y, U, S processor lines and CoffeeLake U,
H, S processor lines.

Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Arnaldo Carvalho de Melo <acme@redhat.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Stephane Eranian <eranian@google.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Vince Weaver <vincent.weaver@maine.edu>
Link: http://lkml.kernel.org/r/20181019170419.378-1-kan.liang@linux.intel.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
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

