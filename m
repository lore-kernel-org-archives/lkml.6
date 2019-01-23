Return-Path: <SRS0=drEb=P7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,UPPERCASE_50_75,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C00AC282C3
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 00:02:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8C0A720856
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 00:02:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="uNvtdoB6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727345AbfAWACL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Jan 2019 19:02:11 -0500
Received: from mail-wm1-f45.google.com ([209.85.128.45]:51854 "EHLO
        mail-wm1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727064AbfAWABV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jan 2019 19:01:21 -0500
Received: by mail-wm1-f45.google.com with SMTP id b11so325678wmj.1
        for <linux-kernel@vger.kernel.org>; Tue, 22 Jan 2019 16:01:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=787AKtnMBgpMDBErasDMaz+kFU0VgZEl38psEnmCjJk=;
        b=uNvtdoB6nz0kSyECsMflFpkrPC1KeKy4S3ve9FgSK15gA37pZehDbv1FPV/xaCL+Qs
         hTKqQlFyKwbJGq1rfXvV+rmvmUxV9fhSEILo7EETo3rovrOecaeq+F9iNCAKnMTMSHw2
         mQZcoGqgaOYCFy0EwnI3yE6DvbeLuPqkJh29anU9VmO/eSAolvlXqwYC3vVn0aupVYyi
         YL+5BeyUD7iYg47jMFhapwI0jlQPUpOFRLgY50T+0trlfSZRDqv+7l92OdpdidS/Fj3C
         uM8gFShnVtDanOA2wNtziboPyJg23QDD781rYsf1xZolXr1PbVXnFbA5u1GH12bKmaoj
         eImQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=787AKtnMBgpMDBErasDMaz+kFU0VgZEl38psEnmCjJk=;
        b=KM0NO++mZmCJ+TmPsDpjwrwQQ/WlNzAPuTjYQGlfSxSzoxStfSYLing3Vk6gc+2htI
         GZjX1fU5MvPK2yirWVS7IV4d8JQ0xjR/Cg3JE2iA9WLjbehnQKHnnbLLhR3cg1FQouuP
         f75drBgNXJnv5nv+s1uTg4DnEJYf4rjpcdHRYZ3YrH9+ftpWfcT+sMaI7QBtOrpxniaH
         YW+4n9azv5gFy0U+e3bLcCC1CLGu6IUXUBba7YWo4oQEwM+r65tibi34r8+BJqqeYrrS
         wIvZhjt3yBJJ76OG2QQlggdC9cUZ4avNLX5Ke/pfLROv5X2BQcECMMrpazZUmU6zVooF
         b3Ew==
X-Gm-Message-State: AJcUukdiwfjZ2Ii39Xm/yiPNYVplPmf7G4aa2T8GyP7bjA/Sb/g+kNWe
        tX4oRw9gD4/gs/tLUnviVqQ=
X-Google-Smtp-Source: ALg8bN7te+gN79vRMbpCpfnHb60VcIpJawALeB5zeKV9rq+ME3N1LesjDT2wBDnECtJOHa8L3wUFCA==
X-Received: by 2002:a1c:c707:: with SMTP id x7mr456638wmf.120.1548201671209;
        Tue, 22 Jan 2019 16:01:11 -0800 (PST)
Received: from oded-ubuntu-desktop.habana-labs.com ([31.154.190.6])
        by smtp.gmail.com with ESMTPSA id 125sm97582630wmm.26.2019.01.22.16.01.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 22 Jan 2019 16:01:10 -0800 (PST)
From:   Oded Gabbay <oded.gabbay@gmail.com>
To:     gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org
Cc:     ogabbay@habana.ai
Subject: [PATCH 06/15] habanalabs: add basic Goya h/w initialization
Date:   Wed, 23 Jan 2019 02:00:48 +0200
Message-Id: <20190123000057.31477-7-oded.gabbay@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190123000057.31477-1-oded.gabbay@gmail.com>
References: <20190123000057.31477-1-oded.gabbay@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds the basic part of Goya's H/W initialization. It adds code
that initializes Goya's internal CPU, various registers that are related to
internal routing, scrambling, workarounds for H/W bugs, etc.

It also initializes Goya's security scheme that prevents the user from
abusing Goya to steal data from the host, crash the host, change
Goya's F/W, etc.

Signed-off-by: Oded Gabbay <oded.gabbay@gmail.com>
---
 drivers/misc/habanalabs/device.c              |   12 +
 drivers/misc/habanalabs/goya/Makefile         |    2 +-
 drivers/misc/habanalabs/goya/goya.c           | 1892 ++++++++++-
 drivers/misc/habanalabs/goya/goyaP.h          |    3 +
 drivers/misc/habanalabs/goya/goya_security.c  | 2999 +++++++++++++++++
 drivers/misc/habanalabs/habanalabs.h          |   16 +
 drivers/misc/habanalabs/habanalabs_drv.c      |    8 +
 drivers/misc/habanalabs/include/goya/goya.h   |    1 +
 .../include/goya/goya_async_events.h          |  186 +
 .../habanalabs/include/goya/goya_boot_if.h    |   32 +
 10 files changed, 5144 insertions(+), 7 deletions(-)
 create mode 100644 drivers/misc/habanalabs/goya/goya_security.c
 create mode 100644 drivers/misc/habanalabs/include/goya/goya_async_events.h
 create mode 100644 drivers/misc/habanalabs/include/goya/goya_boot_if.h

diff --git a/drivers/misc/habanalabs/device.c b/drivers/misc/habanalabs/device.c
index 0bd86a7d34db..9fc7218a973c 100644
--- a/drivers/misc/habanalabs/device.c
+++ b/drivers/misc/habanalabs/device.c
@@ -315,6 +315,15 @@ int hl_device_init(struct hl_device *hdev, struct class *hclass)
 		goto release_ctx;
 	}
 
+	rc = hdev->asic_funcs->hw_init(hdev);
+	if (rc) {
+		dev_err(hdev->dev, "failed to initialize the H/W\n");
+		rc = 0;
+		goto out_disabled;
+	}
+
+	hdev->disabled = false;
+
 	dev_notice(hdev->dev,
 		"Successfully added device to habanalabs driver\n");
 
@@ -366,6 +375,9 @@ void hl_device_fini(struct hl_device *hdev)
 	if ((hdev->kernel_ctx) && (hl_ctx_put(hdev->kernel_ctx) != 1))
 		dev_err(hdev->dev, "kernel ctx is still alive\n");
 
+	/* Reset the H/W. It will be in idle state after this returns */
+	hdev->asic_funcs->hw_fini(hdev, true);
+
 	/* Call ASIC S/W finalize function */
 	hdev->asic_funcs->sw_fini(hdev);
 
diff --git a/drivers/misc/habanalabs/goya/Makefile b/drivers/misc/habanalabs/goya/Makefile
index 5ebf3d0d5794..a57096fa41b6 100644
--- a/drivers/misc/habanalabs/goya/Makefile
+++ b/drivers/misc/habanalabs/goya/Makefile
@@ -1,3 +1,3 @@
 subdir-ccflags-y += -I$(src)
 
-HL_GOYA_FILES :=  goya/goya.o
\ No newline at end of file
+HL_GOYA_FILES :=  goya/goya.o goya/goya_security.o
\ No newline at end of file
diff --git a/drivers/misc/habanalabs/goya/goya.c b/drivers/misc/habanalabs/goya/goya.c
index 341ac085af82..f715e01838b3 100644
--- a/drivers/misc/habanalabs/goya/goya.c
+++ b/drivers/misc/habanalabs/goya/goya.c
@@ -119,11 +119,11 @@ static void goya_get_fixed_properties(struct hl_device *hdev)
 	prop->va_space_dram_end_address = VA_DDR_SPACE_END;
 	prop->cfg_size = CFG_SIZE;
 	prop->max_asid = MAX_ASID;
+	prop->cb_pool_cb_cnt = GOYA_CB_POOL_CB_CNT;
+	prop->cb_pool_cb_size = GOYA_CB_POOL_CB_SIZE;
 	prop->tpc_enabled_mask = TPC_ENABLED_MASK;
 
 	prop->high_pll = PLL_HIGH_DEFAULT;
-	prop->cb_pool_cb_cnt = GOYA_CB_POOL_CB_CNT;
-	prop->cb_pool_cb_size = GOYA_CB_POOL_CB_SIZE;
 }
 
 /**
@@ -459,10 +459,12 @@ static int goya_early_init(struct hl_device *hdev)
 		goto disable_device;
 	}
 
-	val = RREG32(mmPSOC_GLOBAL_CONF_BOOT_STRAP_PINS);
-	if (val & PSOC_GLOBAL_CONF_BOOT_STRAP_PINS_SRIOV_EN_MASK)
-		dev_warn(hdev->dev,
-			"PCI strap is not configured correctly, PCI bus errors may occur\n");
+	if (!hdev->pldm) {
+		val = RREG32(mmPSOC_GLOBAL_CONF_BOOT_STRAP_PINS);
+		if (val & PSOC_GLOBAL_CONF_BOOT_STRAP_PINS_SRIOV_EN_MASK)
+			dev_warn(hdev->dev,
+				"PCI strap is not configured correctly, PCI bus errors may occur\n");
+	}
 
 	return 0;
 
@@ -593,6 +595,1882 @@ int goya_sw_fini(struct hl_device *hdev)
 	return 0;
 }
 
+/**
+ * goya_init_pll - Initialize pll registers
+ *
+ * @hdev: pointer to hl_device structure
+ *
+ */
+static void goya_init_pll(struct hl_device *hdev)
+{
+	struct goya_device *goya = hdev->asic_specific;
+	u16 hbw_nr, hbw_nf, hbw_od, hbw_nb;
+	u16 cpu_nr, cpu_nf, cpu_od, cpu_nb;
+	u16 mc_nr, mc_nf, mc_od, mc_nb;
+	u16 pci_nr, pci_nf, pci_od, pci_nb;
+	u16 emmc_nr, emmc_nf, emmc_od, emmc_nb;
+
+	if (!hdev->config_pll)
+		return;
+
+	if (goya->hw_cap_initialized & HW_CAP_PLL)
+		return;
+
+	if (hdev->cpu_enable) {
+		dev_info(hdev->dev,
+			"Waiting 5s for u-boot before configuring PLLs\n");
+		ssleep(5);
+	}
+
+/*
+ * PLL possible configuration values:
+	{50000000,1,16,16,8},
+	{100000000,1,32,16,16},
+	{150000000,1,48,16,24},
+	{200000000,1,64,16,32},
+	{250000000,1,70,14,35},
+	{300000000,1,60,10,30},
+	{350000000,1,70,10,35},
+	{400000000,1,64,8,32},
+	{450000000,1,54,6,27},
+	{500000000,1,60,6,30},
+	{550000000,1,66,6,33},
+	{600000000,1,48,4,24},
+	{650000000,1,52,4,26},
+	{700000000,1,56,4,28},
+	{750000000,1,60,4,30},
+	{800000000,1,64,4,32},
+	{850000000,1,68,4,34},
+	{900000000,1,36,2,18},
+	{950000000,1,38,2,19},
+	{1000000000,1,40,2,20},
+	{1050000000,1,42,2,21},
+	{1100000000,1,44,2,22},
+	{1150000000,1,46,2,23},
+	{1200000000,1,48,2,24},
+	{1250000000,1,50,2,25},
+	{1300000000,1,52,2,26},
+	{1350000000,1,54,2,27},
+	{1400000000,1,56,2,28},
+	{1450000000,1,58,2,29},
+	{1500000000,1,60,2,30},
+	{1550000000,1,62,2,31},
+*/
+
+	if (hdev->pldm) {
+		hbw_nr  = 4, hbw_nf  = 302, hbw_od  = 1, hbw_nb  = 151;
+		cpu_nr  = 0, cpu_nf  = 47, cpu_od  = 1, cpu_nb  = 32;
+		mc_nr   = 1, mc_nf   = 159, mc_od   = 9, mc_nb   = 79;
+		pci_nr  = 4, pci_nf  = 343, pci_od  = 3, pci_nb  = 171;
+		emmc_nr = 24, emmc_nf = 415, emmc_od = 15, emmc_nb = 207;
+	} else {
+		/* 200MHz */
+		hbw_nr  = 0, hbw_nf  = 63, hbw_od  = 15, hbw_nb  = 31;
+		cpu_nr  = 0, cpu_nf  = 47, cpu_od  = 1, cpu_nb  = 23;
+		mc_nr   = 2, mc_nf   = 0x9f, mc_od   = 3, mc_nb   = 0x4f;
+		pci_nr  = 4, pci_nf  = 343, pci_od  = 3, pci_nb  = 171;
+		emmc_nr = 24, emmc_nf = 415, emmc_od = 15, emmc_nb = 207;
+	}
+
+	/* Adjust divider for SPI */
+	WREG32(mmPSOC_SPI_BAUDR, 8);
+
+	WREG32(mmCPU_PLL_RST, 1);
+	WREG32(mmCPU_PLL_NR, cpu_nr);
+	WREG32(mmCPU_PLL_NF, cpu_nf);
+	WREG32(mmCPU_PLL_OD, cpu_od);
+	WREG32(mmCPU_PLL_NB, cpu_nb);
+	WREG32(mmCPU_PLL_DATA_CHNG, 0x11);
+
+	/* delay before taking PLL out of reset */
+	udelay(100);
+
+	WREG32(mmCPU_PLL_RST, 0);
+	WREG32(mmCPU_PLL_DIV_EN_0, 0x1);
+	WREG32(mmCPU_PLL_DIV_SEL_0, 0x1);
+
+	WREG32(mmCPU_PLL_DIV_FACTOR_1, 0x5);
+	WREG32(mmCPU_PLL_DIV_FACTOR_CMD_1, 0x1);
+	WREG32(mmCPU_PLL_DIV_EN_1, 0x1);
+	WREG32(mmCPU_PLL_DIV_SEL_1, 0x3);
+
+	WREG32(mmCPU_PLL_DIV_FACTOR_2, 0x1);
+	WREG32(mmCPU_PLL_DIV_FACTOR_CMD_2, 0x1);
+	WREG32(mmCPU_PLL_DIV_EN_2, 0x1);
+	WREG32(mmCPU_PLL_DIV_SEL_2, 0x3);
+
+	WREG32(mmIC_PLL_RST, 1);
+	WREG32(mmIC_PLL_NR, hbw_nr);
+	WREG32(mmIC_PLL_NF, hbw_nf);
+	WREG32(mmIC_PLL_OD, hbw_od);
+	WREG32(mmIC_PLL_NB, hbw_nb);
+	WREG32(mmIC_PLL_DATA_CHNG, 0x11);
+
+	udelay(100);
+
+	WREG32(mmIC_PLL_RST, 0);
+	WREG32(mmIC_PLL_DIV_EN_0, 0x1);
+	WREG32(mmIC_PLL_DIV_SEL_0, 0x1);
+
+	WREG32(mmIC_PLL_DIV_FACTOR_1, 0x1);
+	WREG32(mmIC_PLL_DIV_FACTOR_CMD_1, 0x1);
+	WREG32(mmIC_PLL_DIV_EN_1, 0x1);
+	WREG32(mmIC_PLL_DIV_SEL_1, 0x3);
+
+	WREG32(mmIC_PLL_DIV_FACTOR_2, 0x1);
+	WREG32(mmIC_PLL_DIV_FACTOR_CMD_2, 0x1);
+	WREG32(mmIC_PLL_DIV_EN_2, 0x1);
+	WREG32(mmIC_PLL_DIV_SEL_2, 0x3);
+
+	WREG32(mmIC_PLL_DIV_FACTOR_3, 0x8);
+	WREG32(mmIC_PLL_DIV_FACTOR_CMD_3, 0x1);
+	WREG32(mmIC_PLL_DIV_EN_3, 0x1);
+	WREG32(mmIC_PLL_DIV_SEL_3, 0x3);
+
+	if ((hdev->pldm) || (!hdev->cpu_enable)) {
+		WREG32(mmMC_PLL_RST, 1);
+
+		WREG32(mmMC_PLL_NR, mc_nr);
+		WREG32(mmMC_PLL_NF, mc_nf);
+		WREG32(mmMC_PLL_OD, mc_od);
+		WREG32(mmMC_PLL_NB, mc_nb);
+		WREG32(mmMC_PLL_DATA_CHNG, 0x11);
+
+		udelay(100);
+
+		WREG32(mmMC_PLL_RST, 0);
+		WREG32(mmMC_PLL_DIV_EN_0, 0x1);
+		WREG32(mmMC_PLL_DIV_SEL_0, 0x1);
+	}
+
+	WREG32(mmPSOC_MME_PLL_RST, 1);
+	WREG32(mmPSOC_MME_PLL_NR, hbw_nr);
+	WREG32(mmPSOC_MME_PLL_NF, hbw_nf);
+	WREG32(mmPSOC_MME_PLL_OD, hbw_od);
+	WREG32(mmPSOC_MME_PLL_NB, hbw_nb);
+	WREG32(mmPSOC_MME_PLL_DATA_CHNG, 0x11);
+
+	udelay(100);
+
+	WREG32(mmPSOC_MME_PLL_RST, 0);
+	WREG32(mmPSOC_MME_PLL_DIV_EN_0, 0x1);
+	WREG32(mmPSOC_MME_PLL_DIV_SEL_0, 0x1);
+
+	WREG32(mmPSOC_MME_PLL_DIV_FACTOR_1, 0x1);
+	WREG32(mmPSOC_MME_PLL_DIV_FACTOR_CMD_1, 0x1);
+	WREG32(mmPSOC_MME_PLL_DIV_EN_1, 0x1);
+	WREG32(mmPSOC_MME_PLL_DIV_SEL_1, 0x3);
+
+	WREG32(mmPSOC_MME_PLL_DIV_FACTOR_2, 0x2);
+	WREG32(mmPSOC_MME_PLL_DIV_FACTOR_CMD_2, 0x1);
+	WREG32(mmPSOC_MME_PLL_DIV_EN_2, 0x1);
+	WREG32(mmPSOC_MME_PLL_DIV_SEL_2, 0x3);
+
+	WREG32(mmPSOC_MME_PLL_DIV_FACTOR_3, 0x8);
+	WREG32(mmPSOC_MME_PLL_DIV_FACTOR_CMD_3, 0x1);
+	WREG32(mmPSOC_MME_PLL_DIV_EN_3, 0x1);
+	WREG32(mmPSOC_MME_PLL_DIV_SEL_3, 0x3);
+
+	WREG32(mmPSOC_PCI_PLL_RST, 1);
+	WREG32(mmPSOC_PCI_PLL_NR, pci_nr);
+	WREG32(mmPSOC_PCI_PLL_NF, pci_nf);
+	WREG32(mmPSOC_PCI_PLL_OD, pci_od);
+	WREG32(mmPSOC_PCI_PLL_NB, pci_nb);
+	WREG32(mmPSOC_PCI_PLL_DATA_CHNG, 0x11);
+
+	udelay(100);
+
+	WREG32(mmPSOC_PCI_PLL_RST, 0);
+	WREG32(mmPSOC_PCI_PLL_DIV_EN_0, 0x1);
+	WREG32(mmPSOC_PCI_PLL_DIV_SEL_0, 0x1);
+
+	WREG32(mmPSOC_PCI_PLL_DIV_FACTOR_1, 0x4);
+	WREG32(mmPSOC_PCI_PLL_DIV_FACTOR_CMD_1, 0x1);
+	WREG32(mmPSOC_PCI_PLL_DIV_EN_1, 0x1);
+	WREG32(mmPSOC_PCI_PLL_DIV_SEL_1, 0x3);
+
+	WREG32(mmPSOC_PCI_PLL_DIV_FACTOR_2, 0x8);
+	WREG32(mmPSOC_PCI_PLL_DIV_FACTOR_CMD_2, 0x1);
+	WREG32(mmPSOC_PCI_PLL_DIV_EN_2, 0x1);
+	WREG32(mmPSOC_PCI_PLL_DIV_SEL_2, 0x3);
+
+	WREG32(mmPSOC_PCI_PLL_DIV_FACTOR_3, 0x55);
+	WREG32(mmPSOC_PCI_PLL_DIV_FACTOR_CMD_3, 0x1);
+	WREG32(mmPSOC_PCI_PLL_DIV_EN_3, 0x1);
+	WREG32(mmPSOC_PCI_PLL_DIV_SEL_3, 0x3);
+
+	WREG32(mmPSOC_EMMC_PLL_RST, 1);
+	WREG32(mmPSOC_EMMC_PLL_NR, emmc_nr);
+	WREG32(mmPSOC_EMMC_PLL_NF, emmc_nf);
+	WREG32(mmPSOC_EMMC_PLL_OD, emmc_od);
+	WREG32(mmPSOC_EMMC_PLL_NB, emmc_nb);
+	WREG32(mmPSOC_EMMC_PLL_DATA_CHNG, 0x11);
+
+	udelay(100);
+
+	WREG32(mmPSOC_EMMC_PLL_RST, 0);
+	WREG32(mmPSOC_EMMC_PLL_DIV_EN_0, 0x1);
+	WREG32(mmPSOC_EMMC_PLL_DIV_SEL_0, 0x1);
+
+	WREG32(mmPSOC_EMMC_PLL_DIV_FACTOR_1, 0x1);
+	WREG32(mmPSOC_EMMC_PLL_DIV_FACTOR_CMD_1, 0x1);
+	WREG32(mmPSOC_EMMC_PLL_DIV_EN_1, 0x1);
+	WREG32(mmPSOC_EMMC_PLL_DIV_SEL_1, 0x3);
+
+	/* 200MHz*/
+	WREG32(mmTPC_PLL_RST, 1);
+	WREG32(mmTPC_PLL_NR, hbw_nr);
+	WREG32(mmTPC_PLL_NF, hbw_nf);
+	WREG32(mmTPC_PLL_OD, hbw_od);
+	WREG32(mmTPC_PLL_NB, hbw_nb);
+	WREG32(mmTPC_PLL_DATA_CHNG, 0x11);
+
+	udelay(100);
+
+	WREG32(mmTPC_PLL_RST, 0);
+	WREG32(mmTPC_PLL_DIV_EN_0, 0x1);
+	WREG32(mmTPC_PLL_DIV_SEL_0, 0x1);
+
+	WREG32(mmTPC_PLL_DIV_FACTOR_1, 0x1);
+	WREG32(mmTPC_PLL_DIV_FACTOR_CMD_1, 0x1);
+	WREG32(mmTPC_PLL_DIV_EN_1, 0x1);
+	WREG32(mmTPC_PLL_DIV_SEL_1, 0x3);
+
+	WREG32(mmTPC_PLL_DIV_FACTOR_2, 0x1);
+	WREG32(mmTPC_PLL_DIV_FACTOR_CMD_2, 0x1);
+	WREG32(mmTPC_PLL_DIV_EN_2, 0x1);
+	WREG32(mmTPC_PLL_DIV_SEL_2, 0x3);
+
+	WREG32(mmTPC_PLL_DIV_FACTOR_3, 0x8);
+	WREG32(mmTPC_PLL_DIV_FACTOR_CMD_3, 0x1);
+	WREG32(mmTPC_PLL_DIV_EN_3, 0x1);
+	WREG32(mmTPC_PLL_DIV_SEL_3, 0x3);
+
+	goya->hw_cap_initialized |= HW_CAP_PLL;
+}
+
+static void goya_set_pll_refclk(struct hl_device *hdev)
+{
+	WREG32(mmCPU_PLL_DIV_SEL_0, 0x0);
+	WREG32(mmCPU_PLL_DIV_SEL_1, 0x0);
+	WREG32(mmCPU_PLL_DIV_SEL_2, 0x0);
+	WREG32(mmCPU_PLL_DIV_SEL_3, 0x0);
+
+	WREG32(mmIC_PLL_DIV_SEL_0, 0x0);
+	WREG32(mmIC_PLL_DIV_SEL_1, 0x0);
+	WREG32(mmIC_PLL_DIV_SEL_2, 0x0);
+	WREG32(mmIC_PLL_DIV_SEL_3, 0x0);
+
+	WREG32(mmMC_PLL_DIV_SEL_0, 0x0);
+	WREG32(mmMC_PLL_DIV_SEL_1, 0x0);
+	WREG32(mmMC_PLL_DIV_SEL_2, 0x0);
+	WREG32(mmMC_PLL_DIV_SEL_3, 0x0);
+
+	WREG32(mmPSOC_MME_PLL_DIV_SEL_0, 0x0);
+	WREG32(mmPSOC_MME_PLL_DIV_SEL_1, 0x0);
+	WREG32(mmPSOC_MME_PLL_DIV_SEL_2, 0x0);
+	WREG32(mmPSOC_MME_PLL_DIV_SEL_3, 0x0);
+
+	WREG32(mmPSOC_PCI_PLL_DIV_SEL_0, 0x0);
+	WREG32(mmPSOC_PCI_PLL_DIV_SEL_1, 0x0);
+	WREG32(mmPSOC_PCI_PLL_DIV_SEL_2, 0x0);
+	WREG32(mmPSOC_PCI_PLL_DIV_SEL_3, 0x0);
+
+	WREG32(mmPSOC_EMMC_PLL_DIV_SEL_0, 0x0);
+	WREG32(mmPSOC_EMMC_PLL_DIV_SEL_1, 0x0);
+	WREG32(mmPSOC_EMMC_PLL_DIV_SEL_2, 0x0);
+	WREG32(mmPSOC_EMMC_PLL_DIV_SEL_3, 0x0);
+
+	WREG32(mmTPC_PLL_DIV_SEL_0, 0x0);
+	WREG32(mmTPC_PLL_DIV_SEL_1, 0x0);
+	WREG32(mmTPC_PLL_DIV_SEL_2, 0x0);
+	WREG32(mmTPC_PLL_DIV_SEL_3, 0x0);
+}
+
+static void goya_disable_clk_rlx(struct hl_device *hdev)
+{
+	WREG32(mmPSOC_MME_PLL_CLK_RLX_0, 0x100010);
+	WREG32(mmIC_PLL_CLK_RLX_0, 0x100010);
+}
+
+/**
+ * goya_init_ddr_ch0 - Initialize DDR CH0 controller of the chip
+ *
+ * @hdev: pointer to hl_device structure
+ *
+ */
+static void goya_init_ddr_ch0(struct hl_device *hdev)
+{
+	struct goya_device *goya = hdev->asic_specific;
+	u32 val;
+
+	if (goya->hw_cap_initialized & HW_CAP_DDR_0)
+		return;
+
+	val = RREG32(mmDDR_MISC_CH0_CFG_DONE);
+	if (val & DDR_MISC_CH0_CFG_DONE_CFG_DONE_MASK) {
+		goya->hw_cap_initialized |= HW_CAP_DDR_0;
+		return;
+	}
+
+	WREG32(mmDDR_MC_CH0_DBG1, 0x00000001);
+	WREG32(mmDDR_MC_CH0_PWRCTL, 0x00000001);
+
+	val = RREG32(mmDDR_MC_CH0_STAT);
+
+	WREG32(mmDDR_MC_CH0_MSTR, 0x81040210);
+	WREG32(mmDDR_MC_CH0_MRCTRL0, 0x4000a0f0);
+	WREG32(mmDDR_MC_CH0_MRCTRL1, 0x00022ad0);
+	WREG32(mmDDR_MC_CH0_MRCTRL2, 0x091629e1);
+	WREG32(mmDDR_MC_CH0_PWRCTL, 0x00000008);
+	WREG32(mmDDR_MC_CH0_PWRTMG, 0x00040002);
+	WREG32(mmDDR_MC_CH0_HWLPCTL, 0x00be0002);
+	WREG32(mmDDR_MC_CH0_RFSHCTL0, 0x0091f020);
+	WREG32(mmDDR_MC_CH0_RFSHCTL1, 0x00120018);
+	WREG32((mmDDR_MC_CH0_MSTR + 0x00000058), 0x00160005);
+	WREG32(mmDDR_MC_CH0_RFSHCTL3, 0x00000020);
+	WREG32(mmDDR_MC_CH0_RFSHTMG, 0x003000d0);
+	WREG32(mmDDR_MC_CH0_ECCCFG0, 0x00000010);
+	WREG32(mmDDR_MC_CH0_ECCCFG1, 0x00000002);
+	WREG32(mmDDR_MC_CH0_ECCCTL, 0x00000300);
+	WREG32(mmDDR_MC_CH0_ECCPOISONADDR0, 0x00000078);
+	WREG32(mmDDR_MC_CH0_ECCPOISONADDR1, 0x100062f7);
+	WREG32(mmDDR_MC_CH0_CRCPARCTL0, 0x00008000);
+	WREG32(mmDDR_MC_CH0_CRCPARCTL1, 0x0e088301);
+	WREG32(mmDDR_MC_CH0_CRCPARCTL2, 0x00600527);
+	WREG32(mmDDR_MC_CH0_INIT0, 0x00070002);
+	WREG32(mmDDR_MC_CH0_INIT1, 0x0001000e);
+	WREG32(mmDDR_MC_CH0_INIT3, 0x0c510001);
+	WREG32(mmDDR_MC_CH0_INIT4, 0x00280400);
+	WREG32(mmDDR_MC_CH0_INIT5, 0x00110000);
+	WREG32(mmDDR_MC_CH0_INIT6, 0x02000643);
+	WREG32(mmDDR_MC_CH0_INIT7, 0x00001000);
+	WREG32(mmDDR_MC_CH0_DIMMCTL, 0x00000000);
+	WREG32(mmDDR_MC_CH0_RANKCTL, 0x000009a0);
+	WREG32(mmDDR_MC_CH0_DRAMTMG0, 0x1918361a);
+	WREG32(mmDDR_MC_CH0_DRAMTMG1, 0x00080724);
+	WREG32(mmDDR_MC_CH0_DRAMTMG2, 0x080d0713);
+	WREG32(mmDDR_MC_CH0_DRAMTMG3, 0x00012012);
+	WREG32(mmDDR_MC_CH0_DRAMTMG4, 0x0b04060b);
+	WREG32(mmDDR_MC_CH0_DRAMTMG5, 0x0a0c0804);
+	WREG32(mmDDR_MC_CH0_DRAMTMG8, 0x0606490c);
+	WREG32(mmDDR_MC_CH0_DRAMTMG9, 0x0002050f);
+	WREG32(mmDDR_MC_CH0_DRAMTMG10, 0x000e0d0f);
+	WREG32(mmDDR_MC_CH0_DRAMTMG11, 0x270b011f);
+	WREG32(mmDDR_MC_CH0_DRAMTMG12, 0x00000010);
+	WREG32(mmDDR_MC_CH0_DRAMTMG15, 0x00000000);
+	WREG32(mmDDR_MC_CH0_ZQCTL0, 0x31000040);
+	WREG32(mmDDR_MC_CH0_ZQCTL1, 0x00000070);
+	WREG32(mmDDR_MC_CH0_DFITMG0, 0x05978211);
+	WREG32(mmDDR_MC_CH0_DFITMG1, 0x00080101);
+	WREG32(mmDDR_MC_CH0_DFILPCFG0, 0x07006031);
+	WREG32(mmDDR_MC_CH0_DFILPCFG1, 0x00000010);
+	WREG32(mmDDR_MC_CH0_DFIUPD0, 0x40400018);
+	WREG32(mmDDR_MC_CH0_DFIUPD1, 0x000b0046);
+	WREG32(mmDDR_MC_CH0_DFIUPD2, 0x00000000);
+	WREG32(mmDDR_MC_CH0_DFIMISC, 0x00000041);
+	WREG32(mmDDR_MC_CH0_DFITMG2, 0x00001711);
+	WREG32(mmDDR_MC_CH0_DFITMG3, 0x0000001e);
+	WREG32(mmDDR_MC_CH0_DBICTL, 0x00000001);
+	WREG32(mmDDR_MC_CH0_DFIPHYMSTR, 0x00000000);
+	WREG32(mmDDR_MC_CH0_ADDRMAP0, 0x00001f1f);
+	WREG32(mmDDR_MC_CH0_ADDRMAP1, 0x003f1503);
+	WREG32(mmDDR_MC_CH0_ADDRMAP2, 0x01000400);
+	WREG32(mmDDR_MC_CH0_ADDRMAP3, 0x04000505);
+	WREG32(mmDDR_MC_CH0_ADDRMAP4, 0x00001f1f);
+	WREG32(mmDDR_MC_CH0_ADDRMAP5, 0x06060303);
+	WREG32(mmDDR_MC_CH0_ADDRMAP6, 0x0f050709);
+	WREG32(mmDDR_MC_CH0_ADDRMAP7, 0x00000f0f);
+	WREG32(mmDDR_MC_CH0_ADDRMAP8, 0x00003f01);
+	WREG32(mmDDR_MC_CH0_ADDRMAP9, 0x09000606);
+	WREG32(mmDDR_MC_CH0_ADDRMAP10, 0x02090105);
+	WREG32(mmDDR_MC_CH0_ADDRMAP11, 0x0000000a);
+	WREG32(mmDDR_MC_CH0_ODTCFG, 0x09090a08);
+	WREG32(mmDDR_MC_CH0_ODTMAP, 0x9ae1b5fe);
+	WREG32(mmDDR_MC_CH0_SCHED, 0x664d3700);
+	WREG32(mmDDR_MC_CH0_SCHED1, 0x00000000);
+	WREG32(mmDDR_MC_CH0_PERFHPR1, 0x1700e024);
+	WREG32(mmDDR_MC_CH0_PERFLPR1, 0x1e00836c);
+	WREG32(mmDDR_MC_CH0_PERFWR1, 0x260046c9);
+	WREG32(mmDDR_MC_CH0_DQMAP0, 0x0d2b3503);
+	WREG32(mmDDR_MC_CH0_DQMAP1, 0x042a0537);
+	WREG32(mmDDR_MC_CH0_DQMAP2, 0x330b2806);
+	WREG32(mmDDR_MC_CH0_DQMAP3, 0x27013803);
+	WREG32(mmDDR_MC_CH0_DQMAP4, 0x0000022c);
+	WREG32(mmDDR_MC_CH0_DQMAP5, 0x00000001);
+	WREG32(mmDDR_MC_CH0_DBG0, 0x00000001);
+	WREG32(mmDDR_MC_CH0_DBG1, 0x00000000);
+	WREG32(mmDDR_MC_CH0_DBGCMD, 0x00000000);
+	WREG32(mmDDR_MC_CH0_SWCTL, 0x00000001);
+	WREG32(mmDDR_MC_CH0_POISONCFG, 0x00000001);
+	WREG32(mmDDR_MC_CH0_ADVECCINDEX, 0x00000004);
+	WREG32(mmDDR_MC_CH0_ECCPOISONPAT0, 0x00000000);
+	WREG32(mmDDR_MC_CH0_ECCPOISONPAT1, 0x00000000);
+	WREG32(mmDDR_MC_CH0_ECCPOISONPAT2, 0x00000000);
+	WREG32(mmDDR_MC_CH0_CAPARPOISONCTL, 0x00000000);
+	WREG32(mmDDR_MC_CH0_PCCFG, 0x00000011);
+	WREG32(mmDDR_MC_CH0_PCFGR_0, 0x0000518c);
+	WREG32(mmDDR_MC_CH0_PCFGW_0, 0x00001263);
+	WREG32(mmDDR_MC_CH0_PCTRL_0, 0x00000001);
+	WREG32(mmDDR_MC_CH0_PCFGQOS0_0, 0x0011000e);
+	WREG32(mmDDR_MC_CH0_SBRCTL, 0x0016b540);
+	WREG32(mmDDR_MC_CH0_SBRWDATA0, 0x8c1d1786);
+	WREG32(mmDDR_MC_CH0_SBRWDATA1, 0x265f03dd);
+
+	val = RREG32(mmDDR_MC_CH0_RFSHCTL3);
+
+	WREG32(mmDDR_MISC_CH0_CFG_DONE, 0x00000001);
+
+	WREG32(mmDDR_MC_CH0_DBG1, 0x00000000);
+
+	val = RREG32(mmDDR_MC_CH0_PWRCTL);
+
+	WREG32(mmDDR_MC_CH0_PWRCTL, 0x00000002);
+
+	val = RREG32(mmDDR_MC_CH0_PWRCTL);
+
+	WREG32(mmDDR_MC_CH0_PWRCTL, 0x00000000);
+	WREG32(mmDDR_MC_CH0_SWCTL, 0x00000000);
+	WREG32(mmDDR_MC_CH0_DFIMISC, 0x00000041);
+	WREG32(mmDDR_MC_CH0_DFIMISC, 0x00000040);
+	WREG32(mmDDR_MC_CH0_DFIMISC, 0x00000040);
+	WREG32(mmDDR_MC_CH0_DFIMISC, 0x00000060);
+	WREG32(mmDDR_MC_CH0_DFIMISC, 0x00000040);
+	WREG32(mmDDR_MC_CH0_DFIMISC, 0x00000041);
+	WREG32(mmDDR_MC_CH0_DFIMISC, 0x00000041);
+	WREG32(mmDDR_MC_CH0_PCTRL_0, 0x00000001);
+
+	goya->hw_cap_initialized |= HW_CAP_DDR_0;
+}
+
+/**
+ * goya_init_ddr_ch1 - Initialize DDR CH1 controller of the chip
+ *
+ * @hdev: pointer to hl_device structure
+ *
+ */
+static void goya_init_ddr_ch1(struct hl_device *hdev)
+{
+	struct goya_device *goya = hdev->asic_specific;
+	u32 val;
+
+	if (goya->hw_cap_initialized & HW_CAP_DDR_1)
+		return;
+
+	val = RREG32(mmDDR_MISC_CH1_CFG_DONE);
+	if (val & DDR_MISC_CH1_CFG_DONE_CFG_DONE_MASK) {
+		goya->hw_cap_initialized |= HW_CAP_DDR_1;
+		return;
+	}
+
+	WREG32(mmDDR_MC_CH1_DBG1, 0x00000001);
+	WREG32(mmDDR_MC_CH1_PWRCTL, 0x00000001);
+
+	val = RREG32(mmDDR_MC_CH1_STAT);
+
+	WREG32(mmDDR_MC_CH1_MSTR, 0x81040210);
+	WREG32(mmDDR_MC_CH1_MRCTRL0, 0x4000a0f0);
+	WREG32(mmDDR_MC_CH1_MRCTRL1, 0x00022ad0);
+	WREG32(mmDDR_MC_CH1_MRCTRL2, 0x091629e1);
+	WREG32(mmDDR_MC_CH1_PWRCTL, 0x00000008);
+	WREG32(mmDDR_MC_CH1_PWRTMG, 0x00040002);
+	WREG32(mmDDR_MC_CH1_HWLPCTL, 0x00be0002);
+	WREG32(mmDDR_MC_CH1_RFSHCTL0, 0x0091f020);
+	WREG32(mmDDR_MC_CH1_RFSHCTL1, 0x00120018);
+	WREG32((mmDDR_MC_CH1_MSTR + 0x00000058), 0x00160005);
+	WREG32(mmDDR_MC_CH1_RFSHCTL3, 0x00000020);
+	WREG32(mmDDR_MC_CH1_RFSHTMG, 0x003000d0);
+	WREG32(mmDDR_MC_CH1_ECCCFG0, 0x00000010);
+	WREG32(mmDDR_MC_CH1_ECCCFG1, 0x00000002);
+	WREG32(mmDDR_MC_CH1_ECCCTL, 0x00000300);
+	WREG32(mmDDR_MC_CH1_ECCPOISONADDR0, 0x00000078);
+	WREG32(mmDDR_MC_CH1_ECCPOISONADDR1, 0x100062f7);
+	WREG32(mmDDR_MC_CH1_CRCPARCTL0, 0x00008000);
+	WREG32(mmDDR_MC_CH1_CRCPARCTL1, 0x0e088301);
+	WREG32(mmDDR_MC_CH1_CRCPARCTL2, 0x00600527);
+	WREG32(mmDDR_MC_CH1_INIT0, 0x00070002);
+	WREG32(mmDDR_MC_CH1_INIT1, 0x0001000e);
+	WREG32(mmDDR_MC_CH1_INIT3, 0x0c510001);
+	WREG32(mmDDR_MC_CH1_INIT4, 0x00280400);
+	WREG32(mmDDR_MC_CH1_INIT5, 0x00110000);
+	WREG32(mmDDR_MC_CH1_INIT6, 0x02000643);
+	WREG32(mmDDR_MC_CH1_INIT7, 0x00001000);
+	WREG32(mmDDR_MC_CH1_DIMMCTL, 0x00000000);
+	WREG32(mmDDR_MC_CH1_RANKCTL, 0x000009a0);
+	WREG32(mmDDR_MC_CH1_DRAMTMG0, 0x1918361a);
+	WREG32(mmDDR_MC_CH1_DRAMTMG1, 0x00080724);
+	WREG32(mmDDR_MC_CH1_DRAMTMG2, 0x080d0713);
+	WREG32(mmDDR_MC_CH1_DRAMTMG3, 0x00012012);
+	WREG32(mmDDR_MC_CH1_DRAMTMG4, 0x0b04060b);
+	WREG32(mmDDR_MC_CH1_DRAMTMG5, 0x0a0c0804);
+	WREG32(mmDDR_MC_CH1_DRAMTMG8, 0x0606490c);
+	WREG32(mmDDR_MC_CH1_DRAMTMG9, 0x0002050f);
+	WREG32(mmDDR_MC_CH1_DRAMTMG10, 0x000e0d0f);
+	WREG32(mmDDR_MC_CH1_DRAMTMG11, 0x270b011f);
+	WREG32(mmDDR_MC_CH1_DRAMTMG12, 0x00000010);
+	WREG32(mmDDR_MC_CH1_DRAMTMG15, 0x00000000);
+	WREG32(mmDDR_MC_CH1_ZQCTL0, 0x31000040);
+	WREG32(mmDDR_MC_CH1_ZQCTL1, 0x00000070);
+	WREG32(mmDDR_MC_CH1_DFITMG0, 0x05978211);
+	WREG32(mmDDR_MC_CH1_DFITMG1, 0x00080101);
+	WREG32(mmDDR_MC_CH1_DFILPCFG0, 0x07006031);
+	WREG32(mmDDR_MC_CH1_DFILPCFG1, 0x00000010);
+	WREG32(mmDDR_MC_CH1_DFIUPD0, 0x40400018);
+	WREG32(mmDDR_MC_CH1_DFIUPD1, 0x000b0046);
+	WREG32(mmDDR_MC_CH1_DFIUPD2, 0x00000000);
+	WREG32(mmDDR_MC_CH1_DFIMISC, 0x00000041);
+	WREG32(mmDDR_MC_CH1_DFITMG2, 0x00001711);
+	WREG32(mmDDR_MC_CH1_DFITMG3, 0x0000001e);
+	WREG32(mmDDR_MC_CH1_DBICTL, 0x00000001);
+	WREG32(mmDDR_MC_CH1_DFIPHYMSTR, 0x00000000);
+	WREG32(mmDDR_MC_CH1_ADDRMAP0, 0x00001f1f);
+	WREG32(mmDDR_MC_CH1_ADDRMAP1, 0x003f1503);
+	WREG32(mmDDR_MC_CH1_ADDRMAP2, 0x01000400);
+	WREG32(mmDDR_MC_CH1_ADDRMAP3, 0x04000505);
+	WREG32(mmDDR_MC_CH1_ADDRMAP4, 0x00001f1f);
+	WREG32(mmDDR_MC_CH1_ADDRMAP5, 0x06060303);
+	WREG32(mmDDR_MC_CH1_ADDRMAP6, 0x0f050709);
+	WREG32(mmDDR_MC_CH1_ADDRMAP7, 0x00000f0f);
+	WREG32(mmDDR_MC_CH1_ADDRMAP8, 0x00003f01);
+	WREG32(mmDDR_MC_CH1_ADDRMAP9, 0x09000606);
+	WREG32(mmDDR_MC_CH1_ADDRMAP10, 0x02090105);
+	WREG32(mmDDR_MC_CH1_ADDRMAP11, 0x0000000a);
+	WREG32(mmDDR_MC_CH1_ODTCFG, 0x09090a08);
+	WREG32(mmDDR_MC_CH1_ODTMAP, 0x9ae1b5fe);
+	WREG32(mmDDR_MC_CH1_SCHED, 0x664d3700);
+	WREG32(mmDDR_MC_CH1_SCHED1, 0x00000000);
+	WREG32(mmDDR_MC_CH1_PERFHPR1, 0x1700e024);
+	WREG32(mmDDR_MC_CH1_PERFLPR1, 0x1e00836c);
+	WREG32(mmDDR_MC_CH1_PERFWR1, 0x260046c9);
+	WREG32(mmDDR_MC_CH1_DQMAP0, 0x0d2b3503);
+	WREG32(mmDDR_MC_CH1_DQMAP1, 0x042a0537);
+	WREG32(mmDDR_MC_CH1_DQMAP2, 0x330b2806);
+	WREG32(mmDDR_MC_CH1_DQMAP3, 0x27013803);
+	WREG32(mmDDR_MC_CH1_DQMAP4, 0x0000022c);
+	WREG32(mmDDR_MC_CH1_DQMAP5, 0x00000001);
+	WREG32(mmDDR_MC_CH1_DBG0, 0x00000001);
+	WREG32(mmDDR_MC_CH1_DBG1, 0x00000000);
+	WREG32(mmDDR_MC_CH1_DBGCMD, 0x00000000);
+	WREG32(mmDDR_MC_CH1_SWCTL, 0x00000001);
+	WREG32(mmDDR_MC_CH1_POISONCFG, 0x00000001);
+	WREG32(mmDDR_MC_CH1_ADVECCINDEX, 0x00000004);
+	WREG32(mmDDR_MC_CH1_ECCPOISONPAT0, 0x00000000);
+	WREG32(mmDDR_MC_CH1_ECCPOISONPAT1, 0x00000000);
+	WREG32(mmDDR_MC_CH1_ECCPOISONPAT2, 0x00000000);
+	WREG32(mmDDR_MC_CH1_CAPARPOISONCTL, 0x00000000);
+	WREG32(mmDDR_MC_CH1_PCCFG, 0x00000011);
+	WREG32(mmDDR_MC_CH1_PCFGR_0, 0x0000518c);
+	WREG32(mmDDR_MC_CH1_PCFGW_0, 0x00001263);
+	WREG32(mmDDR_MC_CH1_PCTRL_0, 0x00000001);
+	WREG32(mmDDR_MC_CH1_PCFGQOS0_0, 0x0011000e);
+	WREG32(mmDDR_MC_CH1_SBRCTL, 0x0016b540);
+	WREG32(mmDDR_MC_CH1_SBRWDATA0, 0x8c1d1786);
+	WREG32(mmDDR_MC_CH1_SBRWDATA1, 0x265f03dd);
+
+	val = RREG32(mmDDR_MC_CH1_RFSHCTL3);
+
+	WREG32(mmDDR_MISC_CH1_CFG_DONE, 0x00000001);
+
+	WREG32(mmDDR_MC_CH1_DBG1, 0x00000000);
+
+	val = RREG32(mmDDR_MC_CH1_PWRCTL);
+
+	WREG32(mmDDR_MC_CH1_PWRCTL, 0x00000002);
+
+	val = RREG32(mmDDR_MC_CH1_PWRCTL);
+
+	WREG32(mmDDR_MC_CH1_PWRCTL, 0x00000000);
+	WREG32(mmDDR_MC_CH1_SWCTL, 0x00000000);
+	WREG32(mmDDR_MC_CH1_DFIMISC, 0x00000041);
+	WREG32(mmDDR_MC_CH1_DFIMISC, 0x00000040);
+	WREG32(mmDDR_MC_CH1_DFIMISC, 0x00000040);
+	WREG32(mmDDR_MC_CH1_DFIMISC, 0x00000060);
+	WREG32(mmDDR_MC_CH1_DFIMISC, 0x00000040);
+	WREG32(mmDDR_MC_CH1_DFIMISC, 0x00000041);
+	WREG32(mmDDR_MC_CH1_DFIMISC, 0x00000041);
+	WREG32(mmDDR_MC_CH1_PCTRL_0, 0x00000001);
+
+	goya->hw_cap_initialized |= HW_CAP_DDR_1;
+}
+
+static void _goya_tpc_mbist_workaround(struct hl_device *hdev, u8 tpc_id)
+{
+	u64 tpc_eml_address;
+	u32 val, tpc_offset, tpc_eml_offset, tpc_slm_offset;
+	int err, slm_index;
+
+	WARN_ON(tpc_id >= TPC_MAX_NUM);
+
+	tpc_offset = tpc_id * 0x40000;
+	tpc_eml_offset = tpc_id * 0x200000;
+	tpc_eml_address = (mmTPC0_EML_CFG_BASE + tpc_eml_offset - CFG_BASE);
+	tpc_slm_offset = tpc_eml_address + 0x100000;
+
+	/*
+	 * Workaround for Bug H2 #2443 :
+	 * "TPC SB is not initialized on chip reset"
+	 */
+
+	val = RREG32(mmTPC0_CFG_FUNC_MBIST_CNTRL + tpc_offset);
+	if (val & TPC0_CFG_FUNC_MBIST_CNTRL_MBIST_ACTIVE_MASK)
+		dev_warn(hdev->dev, "TPC%d MBIST ACTIVE is not cleared\n",
+			tpc_id);
+
+	WREG32(mmTPC0_CFG_FUNC_MBIST_PAT + tpc_offset, val & 0xFFFFF000);
+
+	WREG32(mmTPC0_CFG_FUNC_MBIST_MEM_0 + tpc_offset, 0x37FF);
+	WREG32(mmTPC0_CFG_FUNC_MBIST_MEM_1 + tpc_offset, 0x303F);
+	WREG32(mmTPC0_CFG_FUNC_MBIST_MEM_2 + tpc_offset, 0x71FF);
+	WREG32(mmTPC0_CFG_FUNC_MBIST_MEM_3 + tpc_offset, 0x71FF);
+	WREG32(mmTPC0_CFG_FUNC_MBIST_MEM_4 + tpc_offset, 0x70FF);
+	WREG32(mmTPC0_CFG_FUNC_MBIST_MEM_5 + tpc_offset, 0x70FF);
+	WREG32(mmTPC0_CFG_FUNC_MBIST_MEM_6 + tpc_offset, 0x70FF);
+	WREG32(mmTPC0_CFG_FUNC_MBIST_MEM_7 + tpc_offset, 0x70FF);
+	WREG32(mmTPC0_CFG_FUNC_MBIST_MEM_8 + tpc_offset, 0x70FF);
+	WREG32(mmTPC0_CFG_FUNC_MBIST_MEM_9 + tpc_offset, 0x70FF);
+
+	WREG32_OR(mmTPC0_CFG_FUNC_MBIST_CNTRL + tpc_offset,
+		1 << TPC0_CFG_FUNC_MBIST_CNTRL_MBIST_START_SHIFT);
+
+	err = hl_poll_timeout(
+		hdev,
+		mmTPC0_CFG_FUNC_MBIST_CNTRL + tpc_offset,
+		val,
+		(val & TPC0_CFG_FUNC_MBIST_CNTRL_MBIST_DONE_MASK),
+		1000,
+		HL_DEVICE_TIMEOUT_USEC);
+
+	if (err)
+		dev_err(hdev->dev,
+			"Timeout while waiting for TPC%d MBIST DONE\n", tpc_id);
+
+	WREG32_OR(mmTPC0_EML_CFG_DBG_CNT + tpc_eml_offset,
+		1 << TPC0_EML_CFG_DBG_CNT_CORE_RST_SHIFT);
+
+	msleep(GOYA_RESET_WAIT_MSEC);
+
+	WREG32_AND(mmTPC0_EML_CFG_DBG_CNT + tpc_eml_offset,
+		~(1 << TPC0_EML_CFG_DBG_CNT_CORE_RST_SHIFT));
+
+	msleep(GOYA_RESET_WAIT_MSEC);
+
+	for (slm_index = 0 ; slm_index < 256 ; slm_index++)
+		WREG32(tpc_slm_offset + (slm_index << 2), 0);
+
+	val = RREG32(tpc_slm_offset);
+
+	WREG32(mmTPC0_CFG_BASE + tpc_offset + 0xF40 - CFG_BASE, 0x100);
+}
+
+static void goya_tpc_mbist_workaround(struct hl_device *hdev)
+{
+	struct goya_device *goya = hdev->asic_specific;
+	int i;
+
+	if (hdev->pldm)
+		return;
+
+	if (goya->hw_cap_initialized & HW_CAP_TPC_MBIST)
+		return;
+
+	/* Workaround for H2 #2443 */
+
+	for (i = 0 ; i < TPC_MAX_NUM ; i++)
+		_goya_tpc_mbist_workaround(hdev, i);
+
+	goya->hw_cap_initialized |= HW_CAP_TPC_MBIST;
+}
+
+/**
+ * goya_init_golden_registers - Initialize golden registers
+ *
+ * @hdev: pointer to hl_device structure
+ *
+ * Initialize the H/W registers of the device
+ *
+ */
+static void goya_init_golden_registers(struct hl_device *hdev)
+{
+	struct goya_device *goya = hdev->asic_specific;
+	u32 polynom[10], tpc_intr_mask;
+
+	if (goya->hw_cap_initialized & HW_CAP_GOLDEN)
+		return;
+
+	polynom[0] = 0x00020080;
+	polynom[1] = 0x00401000;
+	polynom[2] = 0x00200800;
+	polynom[3] = 0x00002000;
+	polynom[4] = 0x00080200;
+	polynom[5] = 0x00040100;
+	polynom[6] = 0x00100400;
+	polynom[7] = 0x00004000;
+	polynom[8] = 0x00010000;
+	polynom[9] = 0x00008000;
+
+	/* Mask all arithmetic interrupts from TPC */
+	tpc_intr_mask = 0x7FFF;
+
+	WREG32(mmDMA_NRTR_SPLIT_COEF_0, polynom[0] >> 7);
+	WREG32(mmDMA_NRTR_SPLIT_COEF_1, polynom[1] >> 7);
+	WREG32(mmDMA_NRTR_SPLIT_COEF_2, polynom[2] >> 7);
+	WREG32(mmDMA_NRTR_SPLIT_COEF_3, polynom[3] >> 7);
+	WREG32(mmDMA_NRTR_SPLIT_COEF_4, polynom[4] >> 7);
+	WREG32(mmDMA_NRTR_SPLIT_COEF_5, polynom[5] >> 7);
+	WREG32(mmDMA_NRTR_SPLIT_COEF_6, polynom[6] >> 7);
+	WREG32(mmDMA_NRTR_SPLIT_COEF_7, polynom[7] >> 7);
+	WREG32(mmDMA_NRTR_SPLIT_COEF_8, polynom[8] >> 7);
+	WREG32(mmDMA_NRTR_SPLIT_COEF_9, polynom[9] >> 7);
+
+	WREG32(mmDMA_NRTR_SCRAMB_EN, 1 << DMA_NRTR_SCRAMB_EN_VAL_SHIFT);
+	WREG32(mmDMA_NRTR_NON_LIN_SCRAMB,
+			1 << DMA_NRTR_NON_LIN_SCRAMB_EN_SHIFT);
+
+	WREG32(mmSRAM_Y5_X0_RTR_HBW_RD_RQ_L_ARB, 0x302);
+	WREG32(mmSRAM_Y4_X0_RTR_HBW_RD_RQ_L_ARB, 0x302);
+	WREG32(mmSRAM_Y3_X0_RTR_HBW_RD_RQ_L_ARB, 0x302);
+	WREG32(mmSRAM_Y2_X0_RTR_HBW_RD_RQ_L_ARB, 0x302);
+	WREG32(mmSRAM_Y1_X0_RTR_HBW_RD_RQ_L_ARB, 0x302);
+	WREG32(mmSRAM_Y0_X0_RTR_HBW_RD_RQ_L_ARB, 0x302);
+	WREG32(mmSRAM_Y5_X1_RTR_HBW_RD_RQ_L_ARB, 0x302);
+	WREG32(mmSRAM_Y4_X1_RTR_HBW_RD_RQ_L_ARB, 0x302);
+	WREG32(mmSRAM_Y3_X1_RTR_HBW_RD_RQ_L_ARB, 0x302);
+	WREG32(mmSRAM_Y2_X1_RTR_HBW_RD_RQ_L_ARB, 0x302);
+	WREG32(mmSRAM_Y1_X1_RTR_HBW_RD_RQ_L_ARB, 0x302);
+	WREG32(mmSRAM_Y0_X1_RTR_HBW_RD_RQ_L_ARB, 0x302);
+	WREG32(mmSRAM_Y5_X2_RTR_HBW_RD_RQ_L_ARB, 0x302);
+	WREG32(mmSRAM_Y4_X2_RTR_HBW_RD_RQ_L_ARB, 0x302);
+	WREG32(mmSRAM_Y3_X2_RTR_HBW_RD_RQ_L_ARB, 0x302);
+	WREG32(mmSRAM_Y2_X2_RTR_HBW_RD_RQ_L_ARB, 0x302);
+	WREG32(mmSRAM_Y1_X2_RTR_HBW_RD_RQ_L_ARB, 0x302);
+	WREG32(mmSRAM_Y0_X2_RTR_HBW_RD_RQ_L_ARB, 0x302);
+	WREG32(mmSRAM_Y5_X3_RTR_HBW_RD_RQ_L_ARB, 0x302);
+	WREG32(mmSRAM_Y4_X3_RTR_HBW_RD_RQ_L_ARB, 0x302);
+	WREG32(mmSRAM_Y3_X3_RTR_HBW_RD_RQ_L_ARB, 0x302);
+	WREG32(mmSRAM_Y2_X3_RTR_HBW_RD_RQ_L_ARB, 0x302);
+	WREG32(mmSRAM_Y1_X3_RTR_HBW_RD_RQ_L_ARB, 0x302);
+	WREG32(mmSRAM_Y0_X3_RTR_HBW_RD_RQ_L_ARB, 0x302);
+	WREG32(mmSRAM_Y5_X4_RTR_HBW_RD_RQ_L_ARB, 0x302);
+	WREG32(mmSRAM_Y4_X4_RTR_HBW_RD_RQ_L_ARB, 0x302);
+	WREG32(mmSRAM_Y3_X4_RTR_HBW_RD_RQ_L_ARB, 0x302);
+	WREG32(mmSRAM_Y2_X4_RTR_HBW_RD_RQ_L_ARB, 0x302);
+	WREG32(mmSRAM_Y1_X4_RTR_HBW_RD_RQ_L_ARB, 0x302);
+	WREG32(mmSRAM_Y0_X4_RTR_HBW_RD_RQ_L_ARB, 0x302);
+	WREG32(mmSRAM_Y5_X0_RTR_HBW_DATA_L_ARB, 0x204);
+	WREG32(mmSRAM_Y4_X0_RTR_HBW_DATA_L_ARB, 0x204);
+	WREG32(mmSRAM_Y3_X0_RTR_HBW_DATA_L_ARB, 0x204);
+	WREG32(mmSRAM_Y2_X0_RTR_HBW_DATA_L_ARB, 0x204);
+	WREG32(mmSRAM_Y1_X0_RTR_HBW_DATA_L_ARB, 0x204);
+	WREG32(mmSRAM_Y0_X0_RTR_HBW_DATA_L_ARB, 0x204);
+	WREG32(mmSRAM_Y5_X1_RTR_HBW_DATA_L_ARB, 0x204);
+	WREG32(mmSRAM_Y4_X1_RTR_HBW_DATA_L_ARB, 0x204);
+	WREG32(mmSRAM_Y3_X1_RTR_HBW_DATA_L_ARB, 0x204);
+	WREG32(mmSRAM_Y2_X1_RTR_HBW_DATA_L_ARB, 0x204);
+	WREG32(mmSRAM_Y1_X1_RTR_HBW_DATA_L_ARB, 0x204);
+	WREG32(mmSRAM_Y0_X1_RTR_HBW_DATA_L_ARB, 0x204);
+	WREG32(mmSRAM_Y5_X2_RTR_HBW_DATA_L_ARB, 0x204);
+	WREG32(mmSRAM_Y4_X2_RTR_HBW_DATA_L_ARB, 0x204);
+	WREG32(mmSRAM_Y3_X2_RTR_HBW_DATA_L_ARB, 0x204);
+	WREG32(mmSRAM_Y2_X2_RTR_HBW_DATA_L_ARB, 0x204);
+	WREG32(mmSRAM_Y1_X2_RTR_HBW_DATA_L_ARB, 0x204);
+	WREG32(mmSRAM_Y0_X2_RTR_HBW_DATA_L_ARB, 0x204);
+	WREG32(mmSRAM_Y5_X3_RTR_HBW_DATA_L_ARB, 0x204);
+	WREG32(mmSRAM_Y4_X3_RTR_HBW_DATA_L_ARB, 0x204);
+	WREG32(mmSRAM_Y3_X3_RTR_HBW_DATA_L_ARB, 0x204);
+	WREG32(mmSRAM_Y2_X3_RTR_HBW_DATA_L_ARB, 0x204);
+	WREG32(mmSRAM_Y1_X3_RTR_HBW_DATA_L_ARB, 0x204);
+	WREG32(mmSRAM_Y0_X3_RTR_HBW_DATA_L_ARB, 0x204);
+	WREG32(mmSRAM_Y5_X4_RTR_HBW_DATA_L_ARB, 0x204);
+	WREG32(mmSRAM_Y4_X4_RTR_HBW_DATA_L_ARB, 0x204);
+	WREG32(mmSRAM_Y3_X4_RTR_HBW_DATA_L_ARB, 0x204);
+	WREG32(mmSRAM_Y2_X4_RTR_HBW_DATA_L_ARB, 0x204);
+	WREG32(mmSRAM_Y1_X4_RTR_HBW_DATA_L_ARB, 0x204);
+	WREG32(mmSRAM_Y0_X4_RTR_HBW_DATA_L_ARB, 0x204);
+	WREG32(mmSRAM_Y5_X0_RTR_HBW_DATA_E_ARB, 0x206);
+	WREG32(mmSRAM_Y4_X0_RTR_HBW_DATA_E_ARB, 0x206);
+	WREG32(mmSRAM_Y3_X0_RTR_HBW_DATA_E_ARB, 0x206);
+	WREG32(mmSRAM_Y2_X0_RTR_HBW_DATA_E_ARB, 0x206);
+	WREG32(mmSRAM_Y1_X0_RTR_HBW_DATA_E_ARB, 0x206);
+	WREG32(mmSRAM_Y0_X0_RTR_HBW_DATA_E_ARB, 0x206);
+	WREG32(mmSRAM_Y5_X1_RTR_HBW_DATA_E_ARB, 0x206);
+	WREG32(mmSRAM_Y4_X1_RTR_HBW_DATA_E_ARB, 0x206);
+	WREG32(mmSRAM_Y3_X1_RTR_HBW_DATA_E_ARB, 0x206);
+	WREG32(mmSRAM_Y2_X1_RTR_HBW_DATA_E_ARB, 0x206);
+	WREG32(mmSRAM_Y1_X1_RTR_HBW_DATA_E_ARB, 0x206);
+	WREG32(mmSRAM_Y0_X1_RTR_HBW_DATA_E_ARB, 0x206);
+	WREG32(mmSRAM_Y5_X2_RTR_HBW_DATA_E_ARB, 0x206);
+	WREG32(mmSRAM_Y4_X2_RTR_HBW_DATA_E_ARB, 0x206);
+	WREG32(mmSRAM_Y3_X2_RTR_HBW_DATA_E_ARB, 0x206);
+	WREG32(mmSRAM_Y2_X2_RTR_HBW_DATA_E_ARB, 0x206);
+	WREG32(mmSRAM_Y1_X2_RTR_HBW_DATA_E_ARB, 0x206);
+	WREG32(mmSRAM_Y0_X2_RTR_HBW_DATA_E_ARB, 0x206);
+	WREG32(mmSRAM_Y5_X3_RTR_HBW_DATA_E_ARB, 0x207);
+	WREG32(mmSRAM_Y4_X3_RTR_HBW_DATA_E_ARB, 0x207);
+	WREG32(mmSRAM_Y3_X3_RTR_HBW_DATA_E_ARB, 0x207);
+	WREG32(mmSRAM_Y2_X3_RTR_HBW_DATA_E_ARB, 0x207);
+	WREG32(mmSRAM_Y1_X3_RTR_HBW_DATA_E_ARB, 0x207);
+	WREG32(mmSRAM_Y0_X3_RTR_HBW_DATA_E_ARB, 0x207);
+	WREG32(mmSRAM_Y5_X4_RTR_HBW_DATA_E_ARB, 0x207);
+	WREG32(mmSRAM_Y4_X4_RTR_HBW_DATA_E_ARB, 0x207);
+	WREG32(mmSRAM_Y3_X4_RTR_HBW_DATA_E_ARB, 0x207);
+	WREG32(mmSRAM_Y2_X4_RTR_HBW_DATA_E_ARB, 0x207);
+	WREG32(mmSRAM_Y1_X4_RTR_HBW_DATA_E_ARB, 0x207);
+	WREG32(mmSRAM_Y0_X4_RTR_HBW_DATA_E_ARB, 0x207);
+	WREG32(mmSRAM_Y5_X0_RTR_HBW_DATA_W_ARB, 0x207);
+	WREG32(mmSRAM_Y4_X0_RTR_HBW_DATA_W_ARB, 0x207);
+	WREG32(mmSRAM_Y3_X0_RTR_HBW_DATA_W_ARB, 0x207);
+	WREG32(mmSRAM_Y2_X0_RTR_HBW_DATA_W_ARB, 0x207);
+	WREG32(mmSRAM_Y1_X0_RTR_HBW_DATA_W_ARB, 0x207);
+	WREG32(mmSRAM_Y0_X0_RTR_HBW_DATA_W_ARB, 0x207);
+	WREG32(mmSRAM_Y5_X1_RTR_HBW_DATA_W_ARB, 0x207);
+	WREG32(mmSRAM_Y4_X1_RTR_HBW_DATA_W_ARB, 0x207);
+	WREG32(mmSRAM_Y3_X1_RTR_HBW_DATA_W_ARB, 0x207);
+	WREG32(mmSRAM_Y2_X1_RTR_HBW_DATA_W_ARB, 0x207);
+	WREG32(mmSRAM_Y1_X1_RTR_HBW_DATA_W_ARB, 0x207);
+	WREG32(mmSRAM_Y0_X1_RTR_HBW_DATA_W_ARB, 0x207);
+	WREG32(mmSRAM_Y5_X2_RTR_HBW_DATA_W_ARB, 0x206);
+	WREG32(mmSRAM_Y4_X2_RTR_HBW_DATA_W_ARB, 0x206);
+	WREG32(mmSRAM_Y3_X2_RTR_HBW_DATA_W_ARB, 0x206);
+	WREG32(mmSRAM_Y2_X2_RTR_HBW_DATA_W_ARB, 0x206);
+	WREG32(mmSRAM_Y1_X2_RTR_HBW_DATA_W_ARB, 0x206);
+	WREG32(mmSRAM_Y0_X2_RTR_HBW_DATA_W_ARB, 0x206);
+	WREG32(mmSRAM_Y5_X3_RTR_HBW_DATA_W_ARB, 0x206);
+	WREG32(mmSRAM_Y4_X3_RTR_HBW_DATA_W_ARB, 0x206);
+	WREG32(mmSRAM_Y3_X3_RTR_HBW_DATA_W_ARB, 0x206);
+	WREG32(mmSRAM_Y2_X3_RTR_HBW_DATA_W_ARB, 0x206);
+	WREG32(mmSRAM_Y1_X3_RTR_HBW_DATA_W_ARB, 0x206);
+	WREG32(mmSRAM_Y0_X3_RTR_HBW_DATA_W_ARB, 0x206);
+	WREG32(mmSRAM_Y5_X4_RTR_HBW_DATA_W_ARB, 0x206);
+	WREG32(mmSRAM_Y4_X4_RTR_HBW_DATA_W_ARB, 0x206);
+	WREG32(mmSRAM_Y3_X4_RTR_HBW_DATA_W_ARB, 0x206);
+	WREG32(mmSRAM_Y2_X4_RTR_HBW_DATA_W_ARB, 0x206);
+	WREG32(mmSRAM_Y1_X4_RTR_HBW_DATA_W_ARB, 0x206);
+	WREG32(mmSRAM_Y0_X4_RTR_HBW_DATA_W_ARB, 0x206);
+	WREG32(mmSRAM_Y5_X0_RTR_HBW_WR_RS_E_ARB, 0x101);
+	WREG32(mmSRAM_Y4_X0_RTR_HBW_WR_RS_E_ARB, 0x101);
+	WREG32(mmSRAM_Y3_X0_RTR_HBW_WR_RS_E_ARB, 0x101);
+	WREG32(mmSRAM_Y2_X0_RTR_HBW_WR_RS_E_ARB, 0x101);
+	WREG32(mmSRAM_Y1_X0_RTR_HBW_WR_RS_E_ARB, 0x101);
+	WREG32(mmSRAM_Y0_X0_RTR_HBW_WR_RS_E_ARB, 0x101);
+	WREG32(mmSRAM_Y5_X1_RTR_HBW_WR_RS_E_ARB, 0x102);
+	WREG32(mmSRAM_Y4_X1_RTR_HBW_WR_RS_E_ARB, 0x102);
+	WREG32(mmSRAM_Y3_X1_RTR_HBW_WR_RS_E_ARB, 0x102);
+	WREG32(mmSRAM_Y2_X1_RTR_HBW_WR_RS_E_ARB, 0x102);
+	WREG32(mmSRAM_Y1_X1_RTR_HBW_WR_RS_E_ARB, 0x102);
+	WREG32(mmSRAM_Y0_X1_RTR_HBW_WR_RS_E_ARB, 0x102);
+	WREG32(mmSRAM_Y5_X2_RTR_HBW_WR_RS_E_ARB, 0x103);
+	WREG32(mmSRAM_Y4_X2_RTR_HBW_WR_RS_E_ARB, 0x103);
+	WREG32(mmSRAM_Y3_X2_RTR_HBW_WR_RS_E_ARB, 0x103);
+	WREG32(mmSRAM_Y2_X2_RTR_HBW_WR_RS_E_ARB, 0x103);
+	WREG32(mmSRAM_Y1_X2_RTR_HBW_WR_RS_E_ARB, 0x103);
+	WREG32(mmSRAM_Y0_X2_RTR_HBW_WR_RS_E_ARB, 0x103);
+	WREG32(mmSRAM_Y5_X3_RTR_HBW_WR_RS_E_ARB, 0x104);
+	WREG32(mmSRAM_Y4_X3_RTR_HBW_WR_RS_E_ARB, 0x104);
+	WREG32(mmSRAM_Y3_X3_RTR_HBW_WR_RS_E_ARB, 0x104);
+	WREG32(mmSRAM_Y2_X3_RTR_HBW_WR_RS_E_ARB, 0x104);
+	WREG32(mmSRAM_Y1_X3_RTR_HBW_WR_RS_E_ARB, 0x104);
+	WREG32(mmSRAM_Y0_X3_RTR_HBW_WR_RS_E_ARB, 0x104);
+	WREG32(mmSRAM_Y5_X4_RTR_HBW_WR_RS_E_ARB, 0x105);
+	WREG32(mmSRAM_Y4_X4_RTR_HBW_WR_RS_E_ARB, 0x105);
+	WREG32(mmSRAM_Y3_X4_RTR_HBW_WR_RS_E_ARB, 0x105);
+	WREG32(mmSRAM_Y2_X4_RTR_HBW_WR_RS_E_ARB, 0x105);
+	WREG32(mmSRAM_Y1_X4_RTR_HBW_WR_RS_E_ARB, 0x105);
+	WREG32(mmSRAM_Y0_X4_RTR_HBW_WR_RS_E_ARB, 0x105);
+	WREG32(mmSRAM_Y5_X0_RTR_HBW_WR_RS_W_ARB, 0x105);
+	WREG32(mmSRAM_Y4_X0_RTR_HBW_WR_RS_W_ARB, 0x105);
+	WREG32(mmSRAM_Y3_X0_RTR_HBW_WR_RS_W_ARB, 0x105);
+	WREG32(mmSRAM_Y2_X0_RTR_HBW_WR_RS_W_ARB, 0x105);
+	WREG32(mmSRAM_Y1_X0_RTR_HBW_WR_RS_W_ARB, 0x105);
+	WREG32(mmSRAM_Y0_X0_RTR_HBW_WR_RS_W_ARB, 0x105);
+	WREG32(mmSRAM_Y5_X1_RTR_HBW_WR_RS_W_ARB, 0x104);
+	WREG32(mmSRAM_Y4_X1_RTR_HBW_WR_RS_W_ARB, 0x104);
+	WREG32(mmSRAM_Y3_X1_RTR_HBW_WR_RS_W_ARB, 0x104);
+	WREG32(mmSRAM_Y2_X1_RTR_HBW_WR_RS_W_ARB, 0x104);
+	WREG32(mmSRAM_Y1_X1_RTR_HBW_WR_RS_W_ARB, 0x104);
+	WREG32(mmSRAM_Y0_X1_RTR_HBW_WR_RS_W_ARB, 0x104);
+	WREG32(mmSRAM_Y5_X2_RTR_HBW_WR_RS_W_ARB, 0x103);
+	WREG32(mmSRAM_Y4_X2_RTR_HBW_WR_RS_W_ARB, 0x103);
+	WREG32(mmSRAM_Y3_X2_RTR_HBW_WR_RS_W_ARB, 0x103);
+	WREG32(mmSRAM_Y2_X2_RTR_HBW_WR_RS_W_ARB, 0x103);
+	WREG32(mmSRAM_Y1_X2_RTR_HBW_WR_RS_W_ARB, 0x103);
+	WREG32(mmSRAM_Y0_X2_RTR_HBW_WR_RS_W_ARB, 0x103);
+	WREG32(mmSRAM_Y5_X3_RTR_HBW_WR_RS_W_ARB, 0x102);
+	WREG32(mmSRAM_Y4_X3_RTR_HBW_WR_RS_W_ARB, 0x102);
+	WREG32(mmSRAM_Y3_X3_RTR_HBW_WR_RS_W_ARB, 0x102);
+	WREG32(mmSRAM_Y2_X3_RTR_HBW_WR_RS_W_ARB, 0x102);
+	WREG32(mmSRAM_Y1_X3_RTR_HBW_WR_RS_W_ARB, 0x102);
+	WREG32(mmSRAM_Y0_X3_RTR_HBW_WR_RS_W_ARB, 0x102);
+	WREG32(mmSRAM_Y5_X4_RTR_HBW_WR_RS_W_ARB, 0x101);
+	WREG32(mmSRAM_Y4_X4_RTR_HBW_WR_RS_W_ARB, 0x101);
+	WREG32(mmSRAM_Y3_X4_RTR_HBW_WR_RS_W_ARB, 0x101);
+	WREG32(mmSRAM_Y2_X4_RTR_HBW_WR_RS_W_ARB, 0x101);
+	WREG32(mmSRAM_Y1_X4_RTR_HBW_WR_RS_W_ARB, 0x101);
+	WREG32(mmSRAM_Y0_X4_RTR_HBW_WR_RS_W_ARB, 0x101);
+
+	WREG32(mmMME_STORE_MAX_CREDIT, 0x21);
+	WREG32(mmMME_AGU, 0x0f0f0f10);
+	WREG32(mmMME_SEI_MASK, ~0x0);
+
+	WREG32(mmMME6_RTR_HBW_RD_RQ_N_ARB, 0x01010101);
+	WREG32(mmMME5_RTR_HBW_RD_RQ_N_ARB, 0x01040101);
+	WREG32(mmMME4_RTR_HBW_RD_RQ_N_ARB, 0x01030101);
+	WREG32(mmMME3_RTR_HBW_RD_RQ_N_ARB, 0x01020101);
+	WREG32(mmMME2_RTR_HBW_RD_RQ_N_ARB, 0x01010101);
+	WREG32(mmMME1_RTR_HBW_RD_RQ_N_ARB, 0x07010701);
+	WREG32(mmMME6_RTR_HBW_RD_RQ_S_ARB, 0x04010401);
+	WREG32(mmMME5_RTR_HBW_RD_RQ_S_ARB, 0x04050401);
+	WREG32(mmMME4_RTR_HBW_RD_RQ_S_ARB, 0x03070301);
+	WREG32(mmMME3_RTR_HBW_RD_RQ_S_ARB, 0x01030101);
+	WREG32(mmMME2_RTR_HBW_RD_RQ_S_ARB, 0x01040101);
+	WREG32(mmMME1_RTR_HBW_RD_RQ_S_ARB, 0x01050105);
+	WREG32(mmMME6_RTR_HBW_RD_RQ_W_ARB, 0x01010501);
+	WREG32(mmMME5_RTR_HBW_RD_RQ_W_ARB, 0x01010501);
+	WREG32(mmMME4_RTR_HBW_RD_RQ_W_ARB, 0x01040301);
+	WREG32(mmMME3_RTR_HBW_RD_RQ_W_ARB, 0x01030401);
+	WREG32(mmMME2_RTR_HBW_RD_RQ_W_ARB, 0x01040101);
+	WREG32(mmMME1_RTR_HBW_RD_RQ_W_ARB, 0x01050101);
+	WREG32(mmMME6_RTR_HBW_WR_RQ_N_ARB, 0x02020202);
+	WREG32(mmMME5_RTR_HBW_WR_RQ_N_ARB, 0x01070101);
+	WREG32(mmMME4_RTR_HBW_WR_RQ_N_ARB, 0x02020201);
+	WREG32(mmMME3_RTR_HBW_WR_RQ_N_ARB, 0x07020701);
+	WREG32(mmMME2_RTR_HBW_WR_RQ_N_ARB, 0x01020101);
+	WREG32(mmMME1_RTR_HBW_WR_RQ_S_ARB, 0x01010101);
+	WREG32(mmMME6_RTR_HBW_WR_RQ_S_ARB, 0x01070101);
+	WREG32(mmMME5_RTR_HBW_WR_RQ_S_ARB, 0x01070101);
+	WREG32(mmMME4_RTR_HBW_WR_RQ_S_ARB, 0x07020701);
+	WREG32(mmMME3_RTR_HBW_WR_RQ_S_ARB, 0x02020201);
+	WREG32(mmMME2_RTR_HBW_WR_RQ_S_ARB, 0x01070101);
+	WREG32(mmMME1_RTR_HBW_WR_RQ_S_ARB, 0x01020102);
+	WREG32(mmMME6_RTR_HBW_WR_RQ_W_ARB, 0x01020701);
+	WREG32(mmMME5_RTR_HBW_WR_RQ_W_ARB, 0x01020701);
+	WREG32(mmMME4_RTR_HBW_WR_RQ_W_ARB, 0x07020707);
+	WREG32(mmMME3_RTR_HBW_WR_RQ_W_ARB, 0x01020201);
+	WREG32(mmMME2_RTR_HBW_WR_RQ_W_ARB, 0x01070201);
+	WREG32(mmMME1_RTR_HBW_WR_RQ_W_ARB, 0x01070201);
+	WREG32(mmMME6_RTR_HBW_RD_RS_N_ARB, 0x01070102);
+	WREG32(mmMME5_RTR_HBW_RD_RS_N_ARB, 0x01070102);
+	WREG32(mmMME4_RTR_HBW_RD_RS_N_ARB, 0x01060102);
+	WREG32(mmMME3_RTR_HBW_RD_RS_N_ARB, 0x01040102);
+	WREG32(mmMME2_RTR_HBW_RD_RS_N_ARB, 0x01020102);
+	WREG32(mmMME1_RTR_HBW_RD_RS_N_ARB, 0x01020107);
+	WREG32(mmMME6_RTR_HBW_RD_RS_S_ARB, 0x01020106);
+	WREG32(mmMME5_RTR_HBW_RD_RS_S_ARB, 0x01020102);
+	WREG32(mmMME4_RTR_HBW_RD_RS_S_ARB, 0x01040102);
+	WREG32(mmMME3_RTR_HBW_RD_RS_S_ARB, 0x01060102);
+	WREG32(mmMME2_RTR_HBW_RD_RS_S_ARB, 0x01070102);
+	WREG32(mmMME1_RTR_HBW_RD_RS_S_ARB, 0x01070102);
+	WREG32(mmMME6_RTR_HBW_RD_RS_E_ARB, 0x01020702);
+	WREG32(mmMME5_RTR_HBW_RD_RS_E_ARB, 0x01020702);
+	WREG32(mmMME4_RTR_HBW_RD_RS_E_ARB, 0x01040602);
+	WREG32(mmMME3_RTR_HBW_RD_RS_E_ARB, 0x01060402);
+	WREG32(mmMME2_RTR_HBW_RD_RS_E_ARB, 0x01070202);
+	WREG32(mmMME1_RTR_HBW_RD_RS_E_ARB, 0x01070102);
+	WREG32(mmMME6_RTR_HBW_RD_RS_W_ARB, 0x01060401);
+	WREG32(mmMME5_RTR_HBW_RD_RS_W_ARB, 0x01060401);
+	WREG32(mmMME4_RTR_HBW_RD_RS_W_ARB, 0x01060401);
+	WREG32(mmMME3_RTR_HBW_RD_RS_W_ARB, 0x01060401);
+	WREG32(mmMME2_RTR_HBW_RD_RS_W_ARB, 0x01060401);
+	WREG32(mmMME1_RTR_HBW_RD_RS_W_ARB, 0x01060401);
+	WREG32(mmMME6_RTR_HBW_WR_RS_N_ARB, 0x01050101);
+	WREG32(mmMME5_RTR_HBW_WR_RS_N_ARB, 0x01040101);
+	WREG32(mmMME4_RTR_HBW_WR_RS_N_ARB, 0x01030101);
+	WREG32(mmMME3_RTR_HBW_WR_RS_N_ARB, 0x01020101);
+	WREG32(mmMME2_RTR_HBW_WR_RS_N_ARB, 0x01010101);
+	WREG32(mmMME1_RTR_HBW_WR_RS_N_ARB, 0x01010107);
+	WREG32(mmMME6_RTR_HBW_WR_RS_S_ARB, 0x01010107);
+	WREG32(mmMME5_RTR_HBW_WR_RS_S_ARB, 0x01010101);
+	WREG32(mmMME4_RTR_HBW_WR_RS_S_ARB, 0x01020101);
+	WREG32(mmMME3_RTR_HBW_WR_RS_S_ARB, 0x01030101);
+	WREG32(mmMME2_RTR_HBW_WR_RS_S_ARB, 0x01040101);
+	WREG32(mmMME1_RTR_HBW_WR_RS_S_ARB, 0x01050101);
+	WREG32(mmMME6_RTR_HBW_WR_RS_E_ARB, 0x01010501);
+	WREG32(mmMME5_RTR_HBW_WR_RS_E_ARB, 0x01010501);
+	WREG32(mmMME4_RTR_HBW_WR_RS_E_ARB, 0x01040301);
+	WREG32(mmMME3_RTR_HBW_WR_RS_E_ARB, 0x01030401);
+	WREG32(mmMME2_RTR_HBW_WR_RS_E_ARB, 0x01040101);
+	WREG32(mmMME1_RTR_HBW_WR_RS_E_ARB, 0x01050101);
+	WREG32(mmMME6_RTR_HBW_WR_RS_W_ARB, 0x01010101);
+	WREG32(mmMME5_RTR_HBW_WR_RS_W_ARB, 0x01010101);
+	WREG32(mmMME4_RTR_HBW_WR_RS_W_ARB, 0x01010101);
+	WREG32(mmMME3_RTR_HBW_WR_RS_W_ARB, 0x01010101);
+	WREG32(mmMME2_RTR_HBW_WR_RS_W_ARB, 0x01010101);
+	WREG32(mmMME1_RTR_HBW_WR_RS_W_ARB, 0x01010101);
+
+	WREG32(mmMME1_RTR_SPLIT_COEF_0, polynom[0] >> 7);
+	WREG32(mmMME1_RTR_SPLIT_COEF_1, polynom[1] >> 7);
+	WREG32(mmMME1_RTR_SPLIT_COEF_2, polynom[2] >> 7);
+	WREG32(mmMME1_RTR_SPLIT_COEF_3, polynom[3] >> 7);
+	WREG32(mmMME1_RTR_SPLIT_COEF_4, polynom[4] >> 7);
+	WREG32(mmMME1_RTR_SPLIT_COEF_5, polynom[5] >> 7);
+	WREG32(mmMME1_RTR_SPLIT_COEF_6, polynom[6] >> 7);
+	WREG32(mmMME1_RTR_SPLIT_COEF_7, polynom[7] >> 7);
+	WREG32(mmMME1_RTR_SPLIT_COEF_8, polynom[8] >> 7);
+	WREG32(mmMME1_RTR_SPLIT_COEF_9, polynom[9] >> 7);
+
+	WREG32(mmMME2_RTR_SPLIT_COEF_0, polynom[0] >> 7);
+	WREG32(mmMME2_RTR_SPLIT_COEF_1, polynom[1] >> 7);
+	WREG32(mmMME2_RTR_SPLIT_COEF_2, polynom[2] >> 7);
+	WREG32(mmMME2_RTR_SPLIT_COEF_3, polynom[3] >> 7);
+	WREG32(mmMME2_RTR_SPLIT_COEF_4, polynom[4] >> 7);
+	WREG32(mmMME2_RTR_SPLIT_COEF_5, polynom[5] >> 7);
+	WREG32(mmMME2_RTR_SPLIT_COEF_6, polynom[6] >> 7);
+	WREG32(mmMME2_RTR_SPLIT_COEF_7, polynom[7] >> 7);
+	WREG32(mmMME2_RTR_SPLIT_COEF_8, polynom[8] >> 7);
+	WREG32(mmMME2_RTR_SPLIT_COEF_9, polynom[9] >> 7);
+
+	WREG32(mmMME3_RTR_SPLIT_COEF_0, polynom[0] >> 7);
+	WREG32(mmMME3_RTR_SPLIT_COEF_1, polynom[1] >> 7);
+	WREG32(mmMME3_RTR_SPLIT_COEF_2, polynom[2] >> 7);
+	WREG32(mmMME3_RTR_SPLIT_COEF_3, polynom[3] >> 7);
+	WREG32(mmMME3_RTR_SPLIT_COEF_4, polynom[4] >> 7);
+	WREG32(mmMME3_RTR_SPLIT_COEF_5, polynom[5] >> 7);
+	WREG32(mmMME3_RTR_SPLIT_COEF_6, polynom[6] >> 7);
+	WREG32(mmMME3_RTR_SPLIT_COEF_7, polynom[7] >> 7);
+	WREG32(mmMME3_RTR_SPLIT_COEF_8, polynom[8] >> 7);
+	WREG32(mmMME3_RTR_SPLIT_COEF_9, polynom[9] >> 7);
+
+	WREG32(mmMME4_RTR_SPLIT_COEF_0, polynom[0] >> 7);
+	WREG32(mmMME4_RTR_SPLIT_COEF_1, polynom[1] >> 7);
+	WREG32(mmMME4_RTR_SPLIT_COEF_2, polynom[2] >> 7);
+	WREG32(mmMME4_RTR_SPLIT_COEF_3, polynom[3] >> 7);
+	WREG32(mmMME4_RTR_SPLIT_COEF_4, polynom[4] >> 7);
+	WREG32(mmMME4_RTR_SPLIT_COEF_5, polynom[5] >> 7);
+	WREG32(mmMME4_RTR_SPLIT_COEF_6, polynom[6] >> 7);
+	WREG32(mmMME4_RTR_SPLIT_COEF_7, polynom[7] >> 7);
+	WREG32(mmMME4_RTR_SPLIT_COEF_8, polynom[8] >> 7);
+	WREG32(mmMME4_RTR_SPLIT_COEF_9, polynom[9] >> 7);
+
+	WREG32(mmMME5_RTR_SPLIT_COEF_0, polynom[0] >> 7);
+	WREG32(mmMME5_RTR_SPLIT_COEF_1, polynom[1] >> 7);
+	WREG32(mmMME5_RTR_SPLIT_COEF_2, polynom[2] >> 7);
+	WREG32(mmMME5_RTR_SPLIT_COEF_3, polynom[3] >> 7);
+	WREG32(mmMME5_RTR_SPLIT_COEF_4, polynom[4] >> 7);
+	WREG32(mmMME5_RTR_SPLIT_COEF_5, polynom[5] >> 7);
+	WREG32(mmMME5_RTR_SPLIT_COEF_6, polynom[6] >> 7);
+	WREG32(mmMME5_RTR_SPLIT_COEF_7, polynom[7] >> 7);
+	WREG32(mmMME5_RTR_SPLIT_COEF_8, polynom[8] >> 7);
+	WREG32(mmMME5_RTR_SPLIT_COEF_9, polynom[9] >> 7);
+
+	WREG32(mmMME6_RTR_SPLIT_COEF_0, polynom[0] >> 7);
+	WREG32(mmMME6_RTR_SPLIT_COEF_1, polynom[1] >> 7);
+	WREG32(mmMME6_RTR_SPLIT_COEF_2, polynom[2] >> 7);
+	WREG32(mmMME6_RTR_SPLIT_COEF_3, polynom[3] >> 7);
+	WREG32(mmMME6_RTR_SPLIT_COEF_4, polynom[4] >> 7);
+	WREG32(mmMME6_RTR_SPLIT_COEF_5, polynom[5] >> 7);
+	WREG32(mmMME6_RTR_SPLIT_COEF_6, polynom[6] >> 7);
+	WREG32(mmMME6_RTR_SPLIT_COEF_7, polynom[7] >> 7);
+	WREG32(mmMME6_RTR_SPLIT_COEF_8, polynom[8] >> 7);
+	WREG32(mmMME6_RTR_SPLIT_COEF_9, polynom[9] >> 7);
+
+	WREG32(mmMME1_RTR_SCRAMB_EN, 1 << MME1_RTR_SCRAMB_EN_VAL_SHIFT);
+	WREG32(mmMME1_RTR_NON_LIN_SCRAMB,
+			1 << MME1_RTR_NON_LIN_SCRAMB_EN_SHIFT);
+
+	WREG32(mmMME2_RTR_SCRAMB_EN, 1 << MME2_RTR_SCRAMB_EN_VAL_SHIFT);
+	WREG32(mmMME2_RTR_NON_LIN_SCRAMB,
+			1 << MME2_RTR_NON_LIN_SCRAMB_EN_SHIFT);
+
+	WREG32(mmMME3_RTR_SCRAMB_EN, 1 << MME3_RTR_SCRAMB_EN_VAL_SHIFT);
+	WREG32(mmMME3_RTR_NON_LIN_SCRAMB,
+			1 << MME3_RTR_NON_LIN_SCRAMB_EN_SHIFT);
+
+	WREG32(mmMME4_RTR_SCRAMB_EN, 1 << MME4_RTR_SCRAMB_EN_VAL_SHIFT);
+	WREG32(mmMME4_RTR_NON_LIN_SCRAMB,
+			1 << MME4_RTR_NON_LIN_SCRAMB_EN_SHIFT);
+
+	WREG32(mmMME5_RTR_SCRAMB_EN, 1 << MME5_RTR_SCRAMB_EN_VAL_SHIFT);
+	WREG32(mmMME5_RTR_NON_LIN_SCRAMB,
+			1 << MME5_RTR_NON_LIN_SCRAMB_EN_SHIFT);
+
+	WREG32(mmMME6_RTR_SCRAMB_EN, 1 << MME6_RTR_SCRAMB_EN_VAL_SHIFT);
+	WREG32(mmMME6_RTR_NON_LIN_SCRAMB,
+			1 << MME6_RTR_NON_LIN_SCRAMB_EN_SHIFT);
+
+	WREG32(mmTPC0_NRTR_SPLIT_COEF_0, polynom[0] >> 7);
+	WREG32(mmTPC0_NRTR_SPLIT_COEF_1, polynom[1] >> 7);
+	WREG32(mmTPC0_NRTR_SPLIT_COEF_2, polynom[2] >> 7);
+	WREG32(mmTPC0_NRTR_SPLIT_COEF_3, polynom[3] >> 7);
+	WREG32(mmTPC0_NRTR_SPLIT_COEF_4, polynom[4] >> 7);
+	WREG32(mmTPC0_NRTR_SPLIT_COEF_5, polynom[5] >> 7);
+	WREG32(mmTPC0_NRTR_SPLIT_COEF_6, polynom[6] >> 7);
+	WREG32(mmTPC0_NRTR_SPLIT_COEF_7, polynom[7] >> 7);
+	WREG32(mmTPC0_NRTR_SPLIT_COEF_8, polynom[8] >> 7);
+	WREG32(mmTPC0_NRTR_SPLIT_COEF_9, polynom[9] >> 7);
+
+	WREG32(mmTPC0_NRTR_SCRAMB_EN, 1 << TPC0_NRTR_SCRAMB_EN_VAL_SHIFT);
+	WREG32(mmTPC0_NRTR_NON_LIN_SCRAMB,
+			1 << TPC0_NRTR_NON_LIN_SCRAMB_EN_SHIFT);
+
+	/*
+	 * Workaround for Bug H2 #2441 :
+	 * "ST.NOP set trace event illegal opcode"
+	 */
+	WREG32(mmTPC0_CFG_TPC_INTR_MASK, tpc_intr_mask);
+
+	WREG32(mmTPC1_RTR_HBW_RD_RQ_N_ARB, 0x01010101);
+	WREG32(mmTPC1_RTR_HBW_RD_RQ_S_ARB, 0x01010101);
+	WREG32(mmTPC1_RTR_HBW_RD_RQ_E_ARB, 0x01060101);
+	WREG32(mmTPC1_RTR_HBW_WR_RQ_N_ARB, 0x02020102);
+	WREG32(mmTPC1_RTR_HBW_WR_RQ_S_ARB, 0x01010101);
+	WREG32(mmTPC1_RTR_HBW_WR_RQ_E_ARB, 0x02070202);
+	WREG32(mmTPC1_RTR_HBW_RD_RS_N_ARB, 0x01020201);
+	WREG32(mmTPC1_RTR_HBW_RD_RS_S_ARB, 0x01070201);
+	WREG32(mmTPC1_RTR_HBW_RD_RS_W_ARB, 0x01070202);
+	WREG32(mmTPC1_RTR_HBW_WR_RS_N_ARB, 0x01010101);
+	WREG32(mmTPC1_RTR_HBW_WR_RS_S_ARB, 0x01050101);
+	WREG32(mmTPC1_RTR_HBW_WR_RS_W_ARB, 0x01050101);
+
+	WREG32(mmTPC1_RTR_SPLIT_COEF_0, polynom[0] >> 7);
+	WREG32(mmTPC1_RTR_SPLIT_COEF_1, polynom[1] >> 7);
+	WREG32(mmTPC1_RTR_SPLIT_COEF_2, polynom[2] >> 7);
+	WREG32(mmTPC1_RTR_SPLIT_COEF_3, polynom[3] >> 7);
+	WREG32(mmTPC1_RTR_SPLIT_COEF_4, polynom[4] >> 7);
+	WREG32(mmTPC1_RTR_SPLIT_COEF_5, polynom[5] >> 7);
+	WREG32(mmTPC1_RTR_SPLIT_COEF_6, polynom[6] >> 7);
+	WREG32(mmTPC1_RTR_SPLIT_COEF_7, polynom[7] >> 7);
+	WREG32(mmTPC1_RTR_SPLIT_COEF_8, polynom[8] >> 7);
+	WREG32(mmTPC1_RTR_SPLIT_COEF_9, polynom[9] >> 7);
+
+	WREG32(mmTPC1_RTR_SCRAMB_EN, 1 << TPC1_RTR_SCRAMB_EN_VAL_SHIFT);
+	WREG32(mmTPC1_RTR_NON_LIN_SCRAMB,
+			1 << TPC1_RTR_NON_LIN_SCRAMB_EN_SHIFT);
+
+	/*
+	 * Workaround for Bug H2 #2441 :
+	 * "ST.NOP set trace event illegal opcode"
+	 */
+	WREG32(mmTPC1_CFG_TPC_INTR_MASK, tpc_intr_mask);
+
+	WREG32(mmTPC2_RTR_HBW_RD_RQ_N_ARB, 0x01020101);
+	WREG32(mmTPC2_RTR_HBW_RD_RQ_S_ARB, 0x01050101);
+	WREG32(mmTPC2_RTR_HBW_RD_RQ_E_ARB, 0x01010201);
+	WREG32(mmTPC2_RTR_HBW_WR_RQ_N_ARB, 0x02040102);
+	WREG32(mmTPC2_RTR_HBW_WR_RQ_S_ARB, 0x01050101);
+	WREG32(mmTPC2_RTR_HBW_WR_RQ_E_ARB, 0x02060202);
+	WREG32(mmTPC2_RTR_HBW_RD_RS_N_ARB, 0x01020201);
+	WREG32(mmTPC2_RTR_HBW_RD_RS_S_ARB, 0x01070201);
+	WREG32(mmTPC2_RTR_HBW_RD_RS_W_ARB, 0x01070202);
+	WREG32(mmTPC2_RTR_HBW_WR_RS_N_ARB, 0x01010101);
+	WREG32(mmTPC2_RTR_HBW_WR_RS_S_ARB, 0x01040101);
+	WREG32(mmTPC2_RTR_HBW_WR_RS_W_ARB, 0x01040101);
+
+	WREG32(mmTPC2_RTR_SPLIT_COEF_0, polynom[0] >> 7);
+	WREG32(mmTPC2_RTR_SPLIT_COEF_1, polynom[1] >> 7);
+	WREG32(mmTPC2_RTR_SPLIT_COEF_2, polynom[2] >> 7);
+	WREG32(mmTPC2_RTR_SPLIT_COEF_3, polynom[3] >> 7);
+	WREG32(mmTPC2_RTR_SPLIT_COEF_4, polynom[4] >> 7);
+	WREG32(mmTPC2_RTR_SPLIT_COEF_5, polynom[5] >> 7);
+	WREG32(mmTPC2_RTR_SPLIT_COEF_6, polynom[6] >> 7);
+	WREG32(mmTPC2_RTR_SPLIT_COEF_7, polynom[7] >> 7);
+	WREG32(mmTPC2_RTR_SPLIT_COEF_8, polynom[8] >> 7);
+	WREG32(mmTPC2_RTR_SPLIT_COEF_9, polynom[9] >> 7);
+
+	WREG32(mmTPC2_RTR_SCRAMB_EN, 1 << TPC2_RTR_SCRAMB_EN_VAL_SHIFT);
+	WREG32(mmTPC2_RTR_NON_LIN_SCRAMB,
+			1 << TPC2_RTR_NON_LIN_SCRAMB_EN_SHIFT);
+
+	/*
+	 * Workaround for Bug H2 #2441 :
+	 * "ST.NOP set trace event illegal opcode"
+	 */
+	WREG32(mmTPC2_CFG_TPC_INTR_MASK, tpc_intr_mask);
+
+	WREG32(mmTPC3_RTR_HBW_RD_RQ_N_ARB, 0x01030101);
+	WREG32(mmTPC3_RTR_HBW_RD_RQ_S_ARB, 0x01040101);
+	WREG32(mmTPC3_RTR_HBW_RD_RQ_E_ARB, 0x01040301);
+	WREG32(mmTPC3_RTR_HBW_WR_RQ_N_ARB, 0x02060102);
+	WREG32(mmTPC3_RTR_HBW_WR_RQ_S_ARB, 0x01040101);
+	WREG32(mmTPC3_RTR_HBW_WR_RQ_E_ARB, 0x01040301);
+	WREG32(mmTPC3_RTR_HBW_RD_RS_N_ARB, 0x01040201);
+	WREG32(mmTPC3_RTR_HBW_RD_RS_S_ARB, 0x01060201);
+	WREG32(mmTPC3_RTR_HBW_RD_RS_W_ARB, 0x01060402);
+	WREG32(mmTPC3_RTR_HBW_WR_RS_N_ARB, 0x01020101);
+	WREG32(mmTPC3_RTR_HBW_WR_RS_S_ARB, 0x01030101);
+	WREG32(mmTPC3_RTR_HBW_WR_RS_W_ARB, 0x01030401);
+
+	WREG32(mmTPC3_RTR_SPLIT_COEF_0, polynom[0] >> 7);
+	WREG32(mmTPC3_RTR_SPLIT_COEF_1, polynom[1] >> 7);
+	WREG32(mmTPC3_RTR_SPLIT_COEF_2, polynom[2] >> 7);
+	WREG32(mmTPC3_RTR_SPLIT_COEF_3, polynom[3] >> 7);
+	WREG32(mmTPC3_RTR_SPLIT_COEF_4, polynom[4] >> 7);
+	WREG32(mmTPC3_RTR_SPLIT_COEF_5, polynom[5] >> 7);
+	WREG32(mmTPC3_RTR_SPLIT_COEF_6, polynom[6] >> 7);
+	WREG32(mmTPC3_RTR_SPLIT_COEF_7, polynom[7] >> 7);
+	WREG32(mmTPC3_RTR_SPLIT_COEF_8, polynom[8] >> 7);
+	WREG32(mmTPC3_RTR_SPLIT_COEF_9, polynom[9] >> 7);
+
+	WREG32(mmTPC3_RTR_SCRAMB_EN, 1 << TPC3_RTR_SCRAMB_EN_VAL_SHIFT);
+	WREG32(mmTPC3_RTR_NON_LIN_SCRAMB,
+			1 << TPC3_RTR_NON_LIN_SCRAMB_EN_SHIFT);
+
+	/*
+	 * Workaround for Bug H2 #2441 :
+	 * "ST.NOP set trace event illegal opcode"
+	 */
+	WREG32(mmTPC3_CFG_TPC_INTR_MASK, tpc_intr_mask);
+
+	WREG32(mmTPC4_RTR_HBW_RD_RQ_N_ARB, 0x01040101);
+	WREG32(mmTPC4_RTR_HBW_RD_RQ_S_ARB, 0x01030101);
+	WREG32(mmTPC4_RTR_HBW_RD_RQ_E_ARB, 0x01030401);
+	WREG32(mmTPC4_RTR_HBW_WR_RQ_N_ARB, 0x02070102);
+	WREG32(mmTPC4_RTR_HBW_WR_RQ_S_ARB, 0x01030101);
+	WREG32(mmTPC4_RTR_HBW_WR_RQ_E_ARB, 0x02060702);
+	WREG32(mmTPC4_RTR_HBW_RD_RS_N_ARB, 0x01060201);
+	WREG32(mmTPC4_RTR_HBW_RD_RS_S_ARB, 0x01040201);
+	WREG32(mmTPC4_RTR_HBW_RD_RS_W_ARB, 0x01040602);
+	WREG32(mmTPC4_RTR_HBW_WR_RS_N_ARB, 0x01030101);
+	WREG32(mmTPC4_RTR_HBW_WR_RS_S_ARB, 0x01020101);
+	WREG32(mmTPC4_RTR_HBW_WR_RS_W_ARB, 0x01040301);
+
+	WREG32(mmTPC4_RTR_SPLIT_COEF_0, polynom[0] >> 7);
+	WREG32(mmTPC4_RTR_SPLIT_COEF_1, polynom[1] >> 7);
+	WREG32(mmTPC4_RTR_SPLIT_COEF_2, polynom[2] >> 7);
+	WREG32(mmTPC4_RTR_SPLIT_COEF_3, polynom[3] >> 7);
+	WREG32(mmTPC4_RTR_SPLIT_COEF_4, polynom[4] >> 7);
+	WREG32(mmTPC4_RTR_SPLIT_COEF_5, polynom[5] >> 7);
+	WREG32(mmTPC4_RTR_SPLIT_COEF_6, polynom[6] >> 7);
+	WREG32(mmTPC4_RTR_SPLIT_COEF_7, polynom[7] >> 7);
+	WREG32(mmTPC4_RTR_SPLIT_COEF_8, polynom[8] >> 7);
+	WREG32(mmTPC4_RTR_SPLIT_COEF_9, polynom[9] >> 7);
+
+	WREG32(mmTPC4_RTR_SCRAMB_EN, 1 << TPC4_RTR_SCRAMB_EN_VAL_SHIFT);
+	WREG32(mmTPC4_RTR_NON_LIN_SCRAMB,
+			1 << TPC4_RTR_NON_LIN_SCRAMB_EN_SHIFT);
+
+	/*
+	 * Workaround for Bug H2 #2441 :
+	 * "ST.NOP set trace event illegal opcode"
+	 */
+	WREG32(mmTPC4_CFG_TPC_INTR_MASK, tpc_intr_mask);
+
+	WREG32(mmTPC5_RTR_HBW_RD_RQ_N_ARB, 0x01050101);
+	WREG32(mmTPC5_RTR_HBW_RD_RQ_S_ARB, 0x01020101);
+	WREG32(mmTPC5_RTR_HBW_RD_RQ_E_ARB, 0x01200501);
+	WREG32(mmTPC5_RTR_HBW_WR_RQ_N_ARB, 0x02070102);
+	WREG32(mmTPC5_RTR_HBW_WR_RQ_S_ARB, 0x01020101);
+	WREG32(mmTPC5_RTR_HBW_WR_RQ_E_ARB, 0x02020602);
+	WREG32(mmTPC5_RTR_HBW_RD_RS_N_ARB, 0x01070201);
+	WREG32(mmTPC5_RTR_HBW_RD_RS_S_ARB, 0x01020201);
+	WREG32(mmTPC5_RTR_HBW_RD_RS_W_ARB, 0x01020702);
+	WREG32(mmTPC5_RTR_HBW_WR_RS_N_ARB, 0x01040101);
+	WREG32(mmTPC5_RTR_HBW_WR_RS_S_ARB, 0x01010101);
+	WREG32(mmTPC5_RTR_HBW_WR_RS_W_ARB, 0x01010501);
+
+	WREG32(mmTPC5_RTR_SPLIT_COEF_0, polynom[0] >> 7);
+	WREG32(mmTPC5_RTR_SPLIT_COEF_1, polynom[1] >> 7);
+	WREG32(mmTPC5_RTR_SPLIT_COEF_2, polynom[2] >> 7);
+	WREG32(mmTPC5_RTR_SPLIT_COEF_3, polynom[3] >> 7);
+	WREG32(mmTPC5_RTR_SPLIT_COEF_4, polynom[4] >> 7);
+	WREG32(mmTPC5_RTR_SPLIT_COEF_5, polynom[5] >> 7);
+	WREG32(mmTPC5_RTR_SPLIT_COEF_6, polynom[6] >> 7);
+	WREG32(mmTPC5_RTR_SPLIT_COEF_7, polynom[7] >> 7);
+	WREG32(mmTPC5_RTR_SPLIT_COEF_8, polynom[8] >> 7);
+	WREG32(mmTPC5_RTR_SPLIT_COEF_9, polynom[9] >> 7);
+
+	WREG32(mmTPC5_RTR_SCRAMB_EN, 1 << TPC5_RTR_SCRAMB_EN_VAL_SHIFT);
+	WREG32(mmTPC5_RTR_NON_LIN_SCRAMB,
+			1 << TPC5_RTR_NON_LIN_SCRAMB_EN_SHIFT);
+
+	/*
+	 * Workaround for Bug H2 #2441 :
+	 * "ST.NOP set trace event illegal opcode"
+	 */
+	WREG32(mmTPC5_CFG_TPC_INTR_MASK, tpc_intr_mask);
+
+	WREG32(mmTPC6_RTR_HBW_RD_RQ_N_ARB, 0x01010101);
+	WREG32(mmTPC6_RTR_HBW_RD_RQ_S_ARB, 0x01010101);
+	WREG32(mmTPC6_RTR_HBW_RD_RQ_E_ARB, 0x01010601);
+	WREG32(mmTPC6_RTR_HBW_WR_RQ_N_ARB, 0x01010101);
+	WREG32(mmTPC6_RTR_HBW_WR_RQ_S_ARB, 0x01010101);
+	WREG32(mmTPC6_RTR_HBW_WR_RQ_E_ARB, 0x02020702);
+	WREG32(mmTPC6_RTR_HBW_RD_RS_N_ARB, 0x01010101);
+	WREG32(mmTPC6_RTR_HBW_RD_RS_S_ARB, 0x01010101);
+	WREG32(mmTPC6_RTR_HBW_RD_RS_W_ARB, 0x01020702);
+	WREG32(mmTPC6_RTR_HBW_WR_RS_N_ARB, 0x01050101);
+	WREG32(mmTPC6_RTR_HBW_WR_RS_S_ARB, 0x01010101);
+	WREG32(mmTPC6_RTR_HBW_WR_RS_W_ARB, 0x01010501);
+
+	WREG32(mmTPC6_RTR_SPLIT_COEF_0, polynom[0] >> 7);
+	WREG32(mmTPC6_RTR_SPLIT_COEF_1, polynom[1] >> 7);
+	WREG32(mmTPC6_RTR_SPLIT_COEF_2, polynom[2] >> 7);
+	WREG32(mmTPC6_RTR_SPLIT_COEF_3, polynom[3] >> 7);
+	WREG32(mmTPC6_RTR_SPLIT_COEF_4, polynom[4] >> 7);
+	WREG32(mmTPC6_RTR_SPLIT_COEF_5, polynom[5] >> 7);
+	WREG32(mmTPC6_RTR_SPLIT_COEF_6, polynom[6] >> 7);
+	WREG32(mmTPC6_RTR_SPLIT_COEF_7, polynom[7] >> 7);
+	WREG32(mmTPC6_RTR_SPLIT_COEF_8, polynom[8] >> 7);
+	WREG32(mmTPC6_RTR_SPLIT_COEF_9, polynom[9] >> 7);
+
+	WREG32(mmTPC6_RTR_SCRAMB_EN, 1 << TPC6_RTR_SCRAMB_EN_VAL_SHIFT);
+	WREG32(mmTPC6_RTR_NON_LIN_SCRAMB,
+			1 << TPC6_RTR_NON_LIN_SCRAMB_EN_SHIFT);
+
+	/*
+	 * Workaround for Bug H2 #2441 :
+	 * "ST.NOP set trace event illegal opcode"
+	 */
+	WREG32(mmTPC6_CFG_TPC_INTR_MASK, tpc_intr_mask);
+
+	WREG32(mmTPC7_NRTR_SPLIT_COEF_0, polynom[0] >> 7);
+	WREG32(mmTPC7_NRTR_SPLIT_COEF_1, polynom[1] >> 7);
+	WREG32(mmTPC7_NRTR_SPLIT_COEF_2, polynom[2] >> 7);
+	WREG32(mmTPC7_NRTR_SPLIT_COEF_3, polynom[3] >> 7);
+	WREG32(mmTPC7_NRTR_SPLIT_COEF_4, polynom[4] >> 7);
+	WREG32(mmTPC7_NRTR_SPLIT_COEF_5, polynom[5] >> 7);
+	WREG32(mmTPC7_NRTR_SPLIT_COEF_6, polynom[6] >> 7);
+	WREG32(mmTPC7_NRTR_SPLIT_COEF_7, polynom[7] >> 7);
+	WREG32(mmTPC7_NRTR_SPLIT_COEF_8, polynom[8] >> 7);
+	WREG32(mmTPC7_NRTR_SPLIT_COEF_9, polynom[9] >> 7);
+
+	WREG32(mmTPC7_NRTR_SCRAMB_EN, 1 << TPC7_NRTR_SCRAMB_EN_VAL_SHIFT);
+	WREG32(mmTPC7_NRTR_NON_LIN_SCRAMB,
+			1 << TPC7_NRTR_NON_LIN_SCRAMB_EN_SHIFT);
+
+	/*
+	 * Workaround for Bug H2 #2441 :
+	 * "ST.NOP set trace event illegal opcode"
+	 */
+	WREG32(mmTPC7_CFG_TPC_INTR_MASK, tpc_intr_mask);
+
+	WREG32(mmPCI_NRTR_SPLIT_COEF_0, polynom[0] >> 7);
+	WREG32(mmPCI_NRTR_SPLIT_COEF_1, polynom[1] >> 7);
+	WREG32(mmPCI_NRTR_SPLIT_COEF_2, polynom[2] >> 7);
+	WREG32(mmPCI_NRTR_SPLIT_COEF_3, polynom[3] >> 7);
+	WREG32(mmPCI_NRTR_SPLIT_COEF_4, polynom[4] >> 7);
+	WREG32(mmPCI_NRTR_SPLIT_COEF_5, polynom[5] >> 7);
+	WREG32(mmPCI_NRTR_SPLIT_COEF_6, polynom[6] >> 7);
+	WREG32(mmPCI_NRTR_SPLIT_COEF_7, polynom[7] >> 7);
+	WREG32(mmPCI_NRTR_SPLIT_COEF_8, polynom[8] >> 7);
+	WREG32(mmPCI_NRTR_SPLIT_COEF_9, polynom[9] >> 7);
+
+	WREG32(mmPCI_NRTR_SCRAMB_EN, 1 << PCI_NRTR_SCRAMB_EN_VAL_SHIFT);
+	WREG32(mmPCI_NRTR_NON_LIN_SCRAMB,
+			1 << PCI_NRTR_NON_LIN_SCRAMB_EN_SHIFT);
+
+	/*
+	 * Workaround for H2 #HW-23 bug
+	 * Set DMA max outstanding read requests to 240 on DMA CH 1. Set it
+	 * to 16 on KMD DMA
+	 * We need to limit only these DMAs because the user can only read
+	 * from Host using DMA CH 1
+	 */
+	WREG32(mmDMA_CH_0_CFG0, 0x0fff0010);
+	WREG32(mmDMA_CH_1_CFG0, 0x0fff00F0);
+
+	goya->hw_cap_initialized |= HW_CAP_GOLDEN;
+}
+
+
+/**
+ * goya_push_uboot_to_device - Push u-boot FW code to device
+ *
+ * @hdev: pointer to hl_device structure
+ *
+ * Copy u-boot fw code from firmware file to SRAM BAR.
+ * Returns 0 on success
+ *
+ */
+static int goya_push_uboot_to_device(struct hl_device *hdev)
+{
+	char fw_name[200];
+	const u64 *fw_data;
+	void __iomem *dst;
+	size_t fw_size, i;
+	int rc;
+
+	snprintf(fw_name, sizeof(fw_name), "habanalabs/goya/goya-u-boot.bin");
+
+	rc = request_firmware(&hdev->spl_fw, fw_name, hdev->dev);
+
+	if (rc) {
+		dev_err(hdev->dev, "Failed to request u-boot fw image\n");
+		goto out;
+	}
+
+	fw_size = hdev->spl_fw->size;
+	if ((fw_size % 4) != 0) {
+		dev_err(hdev->dev, "illegal u-boot firmware size %lu\n",
+			fw_size);
+		rc = -EINVAL;
+		goto out;
+	}
+
+	dev_dbg(hdev->dev, "u-boot firmware size == %lu\n", fw_size);
+
+	fw_data = (const u64 *) hdev->spl_fw->data;
+	dst = hdev->pcie_bar[SRAM_CFG_BAR_ID] + UBOOT_FW_OFFSET;
+
+	if ((hdev->spl_fw->size % 8) != 0)
+		fw_size -= 8;
+
+	for (i = 0 ; i < fw_size ; i += 8, fw_data++, dst += 8) {
+		if (!(i & (0x80000 - 1)))
+			dev_dbg(hdev->dev,
+				"u-boot copied so far %lu out of %lu",
+				i, fw_size);
+
+		writeq(*fw_data, dst);
+	}
+
+	if ((hdev->spl_fw->size % 8) != 0)
+		writel(*(const u32 *) fw_data, dst);
+
+out:
+	release_firmware(hdev->spl_fw);
+	return rc;
+}
+
+/**
+ * goya_push_linux_to_device - Push LINUX FW code to device
+ *
+ * @hdev: pointer to hl_device structure
+ *
+ * Copy LINXU fw code from firmware file to DDR BAR.
+ * Returns 0 on success
+ *
+ */
+static int goya_push_linux_to_device(struct hl_device *hdev)
+{
+	char fw_name[200];
+	const u64 *fw_data;
+	void __iomem *dst;
+	size_t fw_size, i;
+	int rc;
+
+	snprintf(fw_name, sizeof(fw_name), "habanalabs/goya/goya-fit.itb");
+
+	rc = request_firmware(&hdev->spl_fw, fw_name, hdev->dev);
+
+	if (rc) {
+		dev_err(hdev->dev, "Failed to request Linux fw image\n");
+		goto out;
+	}
+
+	fw_size = hdev->spl_fw->size;
+	if ((fw_size % 4) != 0) {
+		dev_err(hdev->dev, "illegal Linux firmware size %lu\n",
+			fw_size);
+		rc = -EINVAL;
+		goto out;
+	}
+
+	dev_dbg(hdev->dev, "Linux firmware size == %lu\n", fw_size);
+
+	fw_data = (const u64 *) hdev->spl_fw->data;
+	dst = hdev->pcie_bar[DDR_BAR_ID] + LINUX_FW_OFFSET;
+
+	if ((hdev->spl_fw->size % 8) != 0)
+		fw_size -= 8;
+
+	for (i = 0 ; i < fw_size ; i += 8, fw_data++, dst += 8) {
+		if (!(i & (0x80000 - 1))) {
+			dev_dbg(hdev->dev,
+				"Linux copied so far %lu out of %lu",
+				i, fw_size);
+			usleep_range(20, 100);
+		}
+		writeq(*fw_data, dst);
+	}
+
+	if ((hdev->spl_fw->size % 8) != 0)
+		writel(*(const u32 *) fw_data, dst);
+
+out:
+	release_firmware(hdev->spl_fw);
+	return rc;
+}
+
+static int goya_pldm_init_cpu(struct hl_device *hdev)
+{
+	u32 val, unit_rst_val;
+	int rc;
+
+	/* Must initialize SRAM scrambler before pushing u-boot to SRAM */
+	goya_init_golden_registers(hdev);
+
+	/* Put ARM cores into reset */
+	WREG32(mmCPU_CA53_CFG_ARM_RST_CONTROL, CPU_RESET_ASSERT);
+	val = RREG32(mmCPU_CA53_CFG_ARM_RST_CONTROL);
+
+	/* Reset the CA53 MACRO */
+	unit_rst_val = RREG32(mmPSOC_GLOBAL_CONF_UNIT_RST_N);
+	WREG32(mmPSOC_GLOBAL_CONF_UNIT_RST_N, CA53_RESET);
+	val = RREG32(mmPSOC_GLOBAL_CONF_UNIT_RST_N);
+	WREG32(mmPSOC_GLOBAL_CONF_UNIT_RST_N, unit_rst_val);
+	val = RREG32(mmPSOC_GLOBAL_CONF_UNIT_RST_N);
+
+	rc = goya_push_uboot_to_device(hdev);
+	if (rc)
+		return rc;
+
+	rc = goya_push_linux_to_device(hdev);
+	if (rc)
+		return rc;
+
+	WREG32(mmPSOC_GLOBAL_CONF_UBOOT_MAGIC, KMD_MSG_FIT_RDY);
+	WREG32(mmPSOC_GLOBAL_CONF_WARM_REBOOT, CPU_BOOT_STATUS_NA);
+
+	WREG32(mmCPU_CA53_CFG_RST_ADDR_LSB_0,
+		lower_32_bits(SRAM_BASE_ADDR + UBOOT_FW_OFFSET));
+	WREG32(mmCPU_CA53_CFG_RST_ADDR_MSB_0,
+		upper_32_bits(SRAM_BASE_ADDR + UBOOT_FW_OFFSET));
+
+	/* Release ARM core 0 from reset */
+	WREG32(mmCPU_CA53_CFG_ARM_RST_CONTROL,
+					CPU_RESET_CORE0_DEASSERT);
+	val = RREG32(mmCPU_CA53_CFG_ARM_RST_CONTROL);
+
+	return 0;
+}
+
+/*
+ * FW component passes an offset from SRAM_BASE_ADDR in SCRATCHPAD_xx.
+ * The version string should be located by that offset.
+ */
+static void goya_read_device_fw_version(struct hl_device *hdev,
+					enum goya_fw_component fwc)
+{
+	const char *name;
+	u32 ver_off;
+	char *dest;
+
+	switch (fwc) {
+	case FW_COMP_UBOOT:
+		ver_off = RREG32(mmPSOC_GLOBAL_CONF_SCRATCHPAD_29);
+		dest = hdev->asic_prop.uboot_ver;
+		name = "U-Boot";
+		break;
+	case FW_COMP_PREBOOT:
+		ver_off = RREG32(mmPSOC_GLOBAL_CONF_SCRATCHPAD_28);
+		dest = hdev->asic_prop.preboot_ver;
+		name = "Preboot";
+		break;
+	default:
+		dev_warn(hdev->dev, "Undefined FW component: %d\n", fwc);
+		return;
+	}
+
+	ver_off &= ~((u32)SRAM_BASE_ADDR);
+
+	if (ver_off < SRAM_SIZE - VERSION_MAX_LEN) {
+		memcpy_fromio(dest, hdev->pcie_bar[SRAM_CFG_BAR_ID] + ver_off,
+							VERSION_MAX_LEN);
+	} else {
+		dev_err(hdev->dev, "%s version offset (0x%x) is above SRAM\n",
+								name, ver_off);
+		strcpy(dest, "unavailable");
+	}
+}
+
+static int goya_init_cpu(struct hl_device *hdev, u32 cpu_timeout)
+{
+	struct goya_device *goya = hdev->asic_specific;
+	u32 status;
+	int rc;
+
+	if (!hdev->cpu_enable)
+		return 0;
+
+	if (goya->hw_cap_initialized & HW_CAP_CPU)
+		return 0;
+
+	/*
+	 * Before pushing u-boot/linux to device, need to set the ddr bar to
+	 * base address of dram
+	 */
+	rc = goya_set_ddr_bar_base(hdev, DRAM_PHYS_BASE);
+	if (rc) {
+		dev_err(hdev->dev,
+			"failed to map DDR bar to DRAM base address\n");
+		return rc;
+	}
+
+	if (hdev->pldm) {
+		rc = goya_pldm_init_cpu(hdev);
+		if (rc)
+			return rc;
+
+		goto out;
+	}
+
+	/* Make sure CPU boot-loader is running */
+	rc = hl_poll_timeout(
+		hdev,
+		mmPSOC_GLOBAL_CONF_WARM_REBOOT,
+		status,
+		(status == CPU_BOOT_STATUS_DRAM_RDY) ||
+		(status == CPU_BOOT_STATUS_SRAM_AVAIL),
+		10000,
+		cpu_timeout);
+
+	if (rc) {
+		dev_err(hdev->dev, "Error in ARM u-boot !!!");
+		switch (status) {
+		case CPU_BOOT_STATUS_NA:
+			dev_err(hdev->dev,
+				"ARM status %d - BTL did NOT run\n", status);
+			break;
+		case CPU_BOOT_STATUS_IN_WFE:
+			dev_err(hdev->dev,
+				"ARM status %d - Inside WFE loop\n", status);
+			break;
+		case CPU_BOOT_STATUS_IN_BTL:
+			dev_err(hdev->dev,
+				"ARM status %d - Stuck in BTL\n", status);
+			break;
+		case CPU_BOOT_STATUS_IN_PREBOOT:
+			dev_err(hdev->dev,
+				"ARM status %d - Stuck in Preboot\n", status);
+			break;
+		case CPU_BOOT_STATUS_IN_SPL:
+			dev_err(hdev->dev,
+				"ARM status %d - Stuck in SPL\n", status);
+			break;
+		case CPU_BOOT_STATUS_IN_UBOOT:
+			dev_err(hdev->dev,
+				"ARM status %d - Stuck in u-boot\n", status);
+			break;
+		case CPU_BOOT_STATUS_DRAM_INIT_FAIL:
+			dev_err(hdev->dev,
+				"ARM status %d - DDR initialization failed\n",
+				status);
+			break;
+		default:
+			dev_err(hdev->dev,
+				"ARM status %d - Invalid status code\n",
+				status);
+			break;
+		}
+		return -EIO;
+	}
+
+	/* Read U-Boot version now in case we will later fail */
+	goya_read_device_fw_version(hdev, FW_COMP_UBOOT);
+	goya_read_device_fw_version(hdev, FW_COMP_PREBOOT);
+
+	if (status == CPU_BOOT_STATUS_SRAM_AVAIL)
+		goto out;
+
+	if (!hdev->fw_loading) {
+		dev_info(hdev->dev, "Skip loading FW\n");
+		goto out;
+	}
+
+	rc = goya_push_linux_to_device(hdev);
+	if (rc)
+		return rc;
+
+	WREG32(mmPSOC_GLOBAL_CONF_UBOOT_MAGIC, KMD_MSG_FIT_RDY);
+
+	rc = hl_poll_timeout(
+		hdev,
+		mmPSOC_GLOBAL_CONF_WARM_REBOOT,
+		status,
+		(status == CPU_BOOT_STATUS_SRAM_AVAIL),
+		10000,
+		cpu_timeout);
+
+	if (rc) {
+		if (status == CPU_BOOT_STATUS_FIT_CORRUPTED)
+			dev_err(hdev->dev,
+				"ARM u-boot reports FIT image is corrupted\n");
+		else
+			dev_err(hdev->dev,
+				"ARM Linux failed to load, %d\n", status);
+		WREG32(mmPSOC_GLOBAL_CONF_UBOOT_MAGIC, KMD_MSG_NA);
+		return -EIO;
+	}
+
+	dev_info(hdev->dev, "Successfully loaded firmware to device\n");
+
+out:
+	goya->hw_cap_initialized |= HW_CAP_CPU;
+
+	return 0;
+}
+
+/**
+ * goya_hw_init - Goya hardware initialization code
+ *
+ * @hdev: pointer to hl_device structure
+ *
+ * Returns 0 on success
+ *
+ */
+static int goya_hw_init(struct hl_device *hdev)
+{
+	struct asic_fixed_properties *prop = &hdev->asic_prop;
+	u32 val;
+	int rc;
+
+	dev_info(hdev->dev, "Starting initialization of H/W\n");
+
+	/* Perform read from the device to make sure device is up */
+	val = RREG32(mmPCIE_DBI_DEVICE_ID_VENDOR_ID_REG);
+
+	goya_init_pll(hdev);
+
+	if (hdev->pldm) {
+		goya_init_ddr_ch0(hdev);
+		goya_init_ddr_ch1(hdev);
+	}
+
+	rc = goya_init_cpu(hdev, GOYA_CPU_TIMEOUT_USEC);
+	if (rc) {
+		dev_err(hdev->dev, "failed to initialize CPU\n");
+		return rc;
+	}
+
+	goya_tpc_mbist_workaround(hdev);
+
+	goya_init_golden_registers(hdev);
+
+	/*
+	 * After CPU initialization is finished, change DDR bar mapping inside
+	 * iATU to point to the start address of the MMU page tables
+	 */
+	rc = goya_set_ddr_bar_base(hdev, DRAM_PHYS_BASE +
+		(MMU_PAGE_TABLES_ADDR & ~(prop->dram_pci_bar_size - 0x1ull)));
+	if (rc) {
+		dev_err(hdev->dev,
+			"failed to map DDR bar to MMU page tables\n");
+		return rc;
+	}
+
+	goya_init_security(hdev);
+
+	/* CPU initialization is finished, we can now move to 48 bit DMA mask */
+	rc = pci_set_dma_mask(hdev->pdev, DMA_BIT_MASK(48));
+	if (rc) {
+		dev_warn(hdev->dev, "Unable to set pci dma mask to 48 bits\n");
+		rc = pci_set_dma_mask(hdev->pdev, DMA_BIT_MASK(32));
+		if (rc) {
+			dev_err(hdev->dev,
+				"Unable to set pci dma mask to 32 bits\n");
+			return rc;
+		}
+	}
+
+	rc = pci_set_consistent_dma_mask(hdev->pdev, DMA_BIT_MASK(48));
+	if (rc) {
+		dev_warn(hdev->dev,
+			"Unable to set pci consistent dma mask to 48 bits\n");
+		rc = pci_set_consistent_dma_mask(hdev->pdev, DMA_BIT_MASK(32));
+		if (rc) {
+			dev_err(hdev->dev,
+				"Unable to set pci consistent dma mask to 32 bits\n");
+			return rc;
+		}
+	}
+
+	/* Perform read from the device to flush all MSI-X configuration */
+	val = RREG32(mmPCIE_DBI_DEVICE_ID_VENDOR_ID_REG);
+
+	return 0;
+}
+
+/**
+ * goya_hw_fini - Goya hardware tear-down code
+ *
+ * @hdev: pointer to hl_device structure
+ * @hard_reset: should we do hard reset to all engines or just reset the
+ *              compute/dma engines
+ *
+ * The function does the following:
+ * - Send interrupt to CPU to go into "quiet" mode
+ * - Stall MME, TPC
+ * - Stop External, Internal QMANs
+ * - Disable MSI-X
+ * - Issue reset command
+ * - Wait until reset is done
+ * - Start device BTL
+ *
+ */
+static void goya_hw_fini(struct hl_device *hdev, bool hard_reset)
+{
+	struct goya_device *goya = hdev->asic_specific;
+	u32 reset_timeout_ms, status;
+
+	if (hdev->pldm)
+		reset_timeout_ms = GOYA_PLDM_RESET_TIMEOUT_MSEC;
+	else
+		reset_timeout_ms = GOYA_RESET_TIMEOUT_MSEC;
+
+	if (hard_reset) {
+		goya_set_ddr_bar_base(hdev, DRAM_PHYS_BASE);
+		goya_disable_clk_rlx(hdev);
+		goya_set_pll_refclk(hdev);
+
+		WREG32(mmPSOC_GLOBAL_CONF_SW_ALL_RST_CFG, RESET_ALL);
+		dev_info(hdev->dev,
+			"Issued HARD reset command, going to wait %dms\n",
+			reset_timeout_ms);
+	} else {
+		WREG32(mmPSOC_GLOBAL_CONF_SW_ALL_RST_CFG, DMA_MME_TPC_RESET);
+		dev_info(hdev->dev,
+			"Issued SOFT reset command, going to wait %dms\n",
+			reset_timeout_ms);
+	}
+
+	/*
+	 * After hard reset, we can't poll the BTM_FSM register because the PSOC
+	 * itself is in reset. In either reset we need to wait until the reset
+	 * is deasserted
+	 */
+	msleep(reset_timeout_ms);
+
+	status = RREG32(mmPSOC_GLOBAL_CONF_BTM_FSM);
+	if (status & PSOC_GLOBAL_CONF_BTM_FSM_STATE_MASK)
+		dev_err(hdev->dev,
+			"Timeout while waiting for device to reset 0x%x\n",
+			status);
+
+	if (!hard_reset) {
+		goya->hw_cap_initialized &= ~(HW_CAP_DMA | HW_CAP_MME |
+						HW_CAP_GOLDEN | HW_CAP_TPC);
+		WREG32(mmGIC_DISTRIBUTOR__5_GICD_SETSPI_NSR,
+				GOYA_ASYNC_EVENT_ID_SOFT_RESET);
+		return;
+	}
+
+	/* Chicken bit to re-initiate boot sequencer flow */
+	WREG32(mmPSOC_GLOBAL_CONF_BOOT_SEQ_RE_START,
+		1 << PSOC_GLOBAL_CONF_BOOT_SEQ_RE_START_IND_SHIFT);
+	/* Move boot manager FSM to pre boot sequencer init state */
+	WREG32(mmPSOC_GLOBAL_CONF_SW_BTM_FSM,
+			0xA << PSOC_GLOBAL_CONF_SW_BTM_FSM_CTRL_SHIFT);
+
+	goya->hw_cap_initialized &= ~(HW_CAP_CPU | HW_CAP_CPU_Q |
+					HW_CAP_DDR_0 | HW_CAP_DDR_1 |
+					HW_CAP_DMA | HW_CAP_MME |
+					HW_CAP_MMU | HW_CAP_TPC_MBIST |
+					HW_CAP_GOLDEN | HW_CAP_TPC);
+
+	if (!hdev->pldm) {
+		int rc;
+		/* In case we are running inside VM and the VM is
+		 * shutting down, we need to make sure CPU boot-loader
+		 * is running before we can continue the VM shutdown.
+		 * That is because the VM will send an FLR signal that
+		 * we must answer
+		 */
+		dev_info(hdev->dev,
+			"Going to wait up to %ds for CPU boot loader\n",
+			GOYA_CPU_TIMEOUT_USEC / 1000 / 1000);
+
+		rc = hl_poll_timeout(
+			hdev,
+			mmPSOC_GLOBAL_CONF_WARM_REBOOT,
+			status,
+			(status == CPU_BOOT_STATUS_DRAM_RDY),
+			10000,
+			GOYA_CPU_TIMEOUT_USEC);
+		if (rc)
+			dev_err(hdev->dev,
+				"failed to wait for CPU boot loader\n");
+	}
+}
+
 int goya_suspend(struct hl_device *hdev)
 {
 	return 0;
@@ -641,6 +2519,8 @@ static const struct hl_asic_funcs goya_funcs = {
 	.early_fini = goya_early_fini,
 	.sw_init = goya_sw_init,
 	.sw_fini = goya_sw_fini,
+	.hw_init = goya_hw_init,
+	.hw_fini = goya_hw_fini,
 	.suspend = goya_suspend,
 	.resume = goya_resume,
 	.mmap = goya_mmap,
diff --git a/drivers/misc/habanalabs/goya/goyaP.h b/drivers/misc/habanalabs/goya/goyaP.h
index 0e12c56472bd..45a6d2ca2752 100644
--- a/drivers/misc/habanalabs/goya/goyaP.h
+++ b/drivers/misc/habanalabs/goya/goyaP.h
@@ -9,6 +9,7 @@
 #define GOYAP_H_
 
 #include "habanalabs.h"
+#include "include/goya/goya_boot_if.h"
 #include "include/goya/goya.h"
 
 #define NUMBER_OF_CMPLT_QUEUES		5
@@ -122,4 +123,6 @@ struct goya_device {
 	u32		hw_cap_initialized;
 };
 
+void goya_init_security(struct hl_device *hdev);
+
 #endif /* GOYAP_H_ */
diff --git a/drivers/misc/habanalabs/goya/goya_security.c b/drivers/misc/habanalabs/goya/goya_security.c
new file mode 100644
index 000000000000..99ad9aacf49e
--- /dev/null
+++ b/drivers/misc/habanalabs/goya/goya_security.c
@@ -0,0 +1,2999 @@
+// SPDX-License-Identifier: GPL-2.0
+
+/*
+ * Copyright 2016-2018 HabanaLabs, Ltd.
+ * All Rights Reserved.
+ */
+
+#include "goyaP.h"
+
+/**
+ * goya_set_block_as_protected - set the given block as protected
+ *
+ * @hdev: pointer to hl_device structure
+ * @block: block base address
+ *
+ */
+static void goya_pb_set_block(struct hl_device *hdev, u64 base)
+{
+	u32 pb_addr = base - CFG_BASE + PROT_BITS_OFFS;
+
+	while (pb_addr & 0xFFF) {
+		WREG32(pb_addr, 0);
+		pb_addr += 4;
+	}
+}
+
+static void goya_init_mme_protection_bits(struct hl_device *hdev)
+{
+	u32 pb_addr, mask;
+	u8 word_offset;
+
+	/* TODO: change to real reg name when Soc Online is updated */
+	u64 mmMME_SBB_POWER_ECO1 = 0xDFF60,
+		mmMME_SBB_POWER_ECO2 = 0xDFF64;
+
+	goya_pb_set_block(hdev, mmACC_MS_ECC_MEM_0_BASE);
+	goya_pb_set_block(hdev, mmACC_MS_ECC_MEM_1_BASE);
+	goya_pb_set_block(hdev, mmACC_MS_ECC_MEM_2_BASE);
+	goya_pb_set_block(hdev, mmACC_MS_ECC_MEM_3_BASE);
+
+	goya_pb_set_block(hdev, mmSBA_ECC_MEM_BASE);
+	goya_pb_set_block(hdev, mmSBB_ECC_MEM_BASE);
+
+	goya_pb_set_block(hdev, mmMME1_RTR_BASE);
+	goya_pb_set_block(hdev, mmMME1_RD_REGULATOR_BASE);
+	goya_pb_set_block(hdev, mmMME1_WR_REGULATOR_BASE);
+	goya_pb_set_block(hdev, mmMME2_RTR_BASE);
+	goya_pb_set_block(hdev, mmMME2_RD_REGULATOR_BASE);
+	goya_pb_set_block(hdev, mmMME2_WR_REGULATOR_BASE);
+	goya_pb_set_block(hdev, mmMME3_RTR_BASE);
+	goya_pb_set_block(hdev, mmMME3_RD_REGULATOR_BASE);
+	goya_pb_set_block(hdev, mmMME3_WR_REGULATOR_BASE);
+
+	goya_pb_set_block(hdev, mmMME4_RTR_BASE);
+	goya_pb_set_block(hdev, mmMME4_RD_REGULATOR_BASE);
+	goya_pb_set_block(hdev, mmMME4_WR_REGULATOR_BASE);
+
+	goya_pb_set_block(hdev, mmMME5_RTR_BASE);
+	goya_pb_set_block(hdev, mmMME5_RD_REGULATOR_BASE);
+	goya_pb_set_block(hdev, mmMME5_WR_REGULATOR_BASE);
+
+	goya_pb_set_block(hdev, mmMME6_RTR_BASE);
+	goya_pb_set_block(hdev, mmMME6_RD_REGULATOR_BASE);
+	goya_pb_set_block(hdev, mmMME6_WR_REGULATOR_BASE);
+
+	pb_addr = (mmMME_DUMMY & ~0xFFF) + PROT_BITS_OFFS;
+	word_offset = ((mmMME_DUMMY & PROT_BITS_OFFS) >> 7) << 2;
+	mask = 1 << ((mmMME_DUMMY & 0x7F) >> 2);
+	mask |= 1 << ((mmMME_RESET & 0x7F) >> 2);
+	mask |= 1 << ((mmMME_STALL & 0x7F) >> 2);
+	mask |= 1 << ((mmMME_SM_BASE_ADDRESS_LOW & 0x7F) >> 2);
+	mask |= 1 << ((mmMME_SM_BASE_ADDRESS_HIGH & 0x7F) >> 2);
+	mask |= 1 << ((mmMME_DBGMEM_ADD & 0x7F) >> 2);
+	mask |= 1 << ((mmMME_DBGMEM_DATA_WR & 0x7F) >> 2);
+	mask |= 1 << ((mmMME_DBGMEM_DATA_RD & 0x7F) >> 2);
+	mask |= 1 << ((mmMME_DBGMEM_CTRL & 0x7F) >> 2);
+	mask |= 1 << ((mmMME_DBGMEM_RC & 0x7F) >> 2);
+	mask |= 1 << ((mmMME_LOG_SHADOW & 0x7F) >> 2);
+
+	WREG32(pb_addr + word_offset, ~mask);
+
+	pb_addr = (mmMME_STORE_MAX_CREDIT & ~0xFFF) + PROT_BITS_OFFS;
+	word_offset = ((mmMME_STORE_MAX_CREDIT & PROT_BITS_OFFS) >> 7) << 2;
+	mask = 1 << ((mmMME_STORE_MAX_CREDIT & 0x7F) >> 2);
+	mask |= 1 << ((mmMME_AGU & 0x7F) >> 2);
+	mask |= 1 << ((mmMME_SBA & 0x7F) >> 2);
+	mask |= 1 << ((mmMME_SBB & 0x7F) >> 2);
+	mask |= 1 << ((mmMME_SBC & 0x7F) >> 2);
+	mask |= 1 << ((mmMME_WBC & 0x7F) >> 2);
+	mask |= 1 << ((mmMME_SBA_CONTROL_DATA & 0x7F) >> 2);
+	mask |= 1 << ((mmMME_SBB_CONTROL_DATA & 0x7F) >> 2);
+	mask |= 1 << ((mmMME_SBC_CONTROL_DATA & 0x7F) >> 2);
+	mask |= 1 << ((mmMME_WBC_CONTROL_DATA & 0x7F) >> 2);
+	mask |= 1 << ((mmMME_TE & 0x7F) >> 2);
+	mask |= 1 << ((mmMME_TE2DEC & 0x7F) >> 2);
+	mask |= 1 << ((mmMME_REI_STATUS & 0x7F) >> 2);
+	mask |= 1 << ((mmMME_REI_MASK & 0x7F) >> 2);
+	mask |= 1 << ((mmMME_SEI_STATUS & 0x7F) >> 2);
+	mask |= 1 << ((mmMME_SEI_MASK & 0x7F) >> 2);
+	mask |= 1 << ((mmMME_SPI_STATUS & 0x7F) >> 2);
+	mask |= 1 << ((mmMME_SPI_MASK & 0x7F) >> 2);
+
+	WREG32(pb_addr + word_offset, ~mask);
+
+	pb_addr = (mmMME_QM_GLBL_CFG0 & ~0xFFF) + PROT_BITS_OFFS;
+	word_offset = ((mmMME_QM_GLBL_CFG0 & PROT_BITS_OFFS) >> 7) << 2;
+	mask = 1 << ((mmMME_QM_GLBL_CFG0 & 0x7F) >> 2);
+	mask |= 1 << ((mmMME_QM_GLBL_CFG1 & 0x7F) >> 2);
+	mask |= 1 << ((mmMME_QM_GLBL_PROT & 0x7F) >> 2);
+	mask |= 1 << ((mmMME_QM_GLBL_ERR_CFG & 0x7F) >> 2);
+	mask |= 1 << ((mmMME_QM_GLBL_ERR_ADDR_LO & 0x7F) >> 2);
+	mask |= 1 << ((mmMME_QM_GLBL_ERR_ADDR_HI & 0x7F) >> 2);
+	mask |= 1 << ((mmMME_QM_GLBL_ERR_WDATA & 0x7F) >> 2);
+	mask |= 1 << ((mmMME_QM_GLBL_SECURE_PROPS & 0x7F) >> 2);
+	mask |= 1 << ((mmMME_QM_GLBL_NON_SECURE_PROPS & 0x7F) >> 2);
+	mask |= 1 << ((mmMME_QM_GLBL_STS0 & 0x7F) >> 2);
+	mask |= 1 << ((mmMME_QM_GLBL_STS1 & 0x7F) >> 2);
+	mask |= 1 << ((mmMME_QM_PQ_BASE_LO & 0x7F) >> 2);
+	mask |= 1 << ((mmMME_QM_PQ_BASE_HI & 0x7F) >> 2);
+	mask |= 1 << ((mmMME_QM_PQ_SIZE & 0x7F) >> 2);
+	mask |= 1 << ((mmMME_QM_PQ_PI & 0x7F) >> 2);
+	mask |= 1 << ((mmMME_QM_PQ_CI & 0x7F) >> 2);
+	mask |= 1 << ((mmMME_QM_PQ_CFG0 & 0x7F) >> 2);
+	mask |= 1 << ((mmMME_QM_PQ_CFG1 & 0x7F) >> 2);
+	mask |= 1 << ((mmMME_QM_PQ_ARUSER & 0x7F) >> 2);
+
+	WREG32(pb_addr + word_offset, ~mask);
+
+	pb_addr = (mmMME_QM_PQ_PUSH0 & ~0xFFF) + PROT_BITS_OFFS;
+	word_offset = ((mmMME_QM_PQ_PUSH0 & PROT_BITS_OFFS) >> 7) << 2;
+	mask = 1 << ((mmMME_QM_PQ_PUSH0 & 0x7F) >> 2);
+	mask |= 1 << ((mmMME_QM_PQ_PUSH1 & 0x7F) >> 2);
+	mask |= 1 << ((mmMME_QM_PQ_PUSH2 & 0x7F) >> 2);
+	mask |= 1 << ((mmMME_QM_PQ_PUSH3 & 0x7F) >> 2);
+	mask |= 1 << ((mmMME_QM_PQ_STS0 & 0x7F) >> 2);
+	mask |= 1 << ((mmMME_QM_PQ_STS1 & 0x7F) >> 2);
+	mask |= 1 << ((mmMME_QM_PQ_RD_RATE_LIM_EN & 0x7F) >> 2);
+	mask |= 1 << ((mmMME_QM_PQ_RD_RATE_LIM_RST_TOKEN & 0x7F) >> 2);
+	mask |= 1 << ((mmMME_QM_PQ_RD_RATE_LIM_SAT & 0x7F) >> 2);
+	mask |= 1 << ((mmMME_QM_PQ_RD_RATE_LIM_TOUT & 0x7F) >> 2);
+	mask |= 1 << ((mmMME_QM_CQ_CFG0 & 0x7F) >> 2);
+	mask |= 1 << ((mmMME_QM_CQ_CFG1 & 0x7F) >> 2);
+	mask |= 1 << ((mmMME_QM_CQ_ARUSER & 0x7F) >> 2);
+	mask |= 1 << ((mmMME_QM_CQ_PTR_LO & 0x7F) >> 2);
+	mask |= 1 << ((mmMME_QM_CQ_PTR_HI & 0x7F) >> 2);
+	mask |= 1 << ((mmMME_QM_CQ_TSIZE & 0x7F) >> 2);
+	mask |= 1 << ((mmMME_QM_CQ_CTL & 0x7F) >> 2);
+	mask |= 1 << ((mmMME_QM_CQ_PTR_LO_STS & 0x7F) >> 2);
+	mask |= 1 << ((mmMME_QM_CQ_PTR_HI_STS & 0x7F) >> 2);
+	mask |= 1 << ((mmMME_QM_CQ_TSIZE_STS & 0x7F) >> 2);
+	mask |= 1 << ((mmMME_QM_CQ_CTL_STS & 0x7F) >> 2);
+	mask |= 1 << ((mmMME_QM_CQ_STS0 & 0x7F) >> 2);
+	mask |= 1 << ((mmMME_QM_CQ_STS1 & 0x7F) >> 2);
+	mask |= 1 << ((mmMME_QM_CQ_RD_RATE_LIM_EN & 0x7F) >> 2);
+	mask |= 1 << ((mmMME_QM_CQ_RD_RATE_LIM_RST_TOKEN & 0x7F) >> 2);
+	mask |= 1 << ((mmMME_QM_CQ_RD_RATE_LIM_SAT & 0x7F) >> 2);
+	mask |= 1 << ((mmMME_QM_CQ_RD_RATE_LIM_TOUT & 0x7F) >> 2);
+
+	WREG32(pb_addr + word_offset, ~mask);
+
+	pb_addr = (mmMME_QM_CQ_IFIFO_CNT & ~0xFFF) + PROT_BITS_OFFS;
+	word_offset = ((mmMME_QM_CQ_IFIFO_CNT & PROT_BITS_OFFS) >> 7) << 2;
+	mask = 1 << ((mmMME_QM_CQ_IFIFO_CNT & 0x7F) >> 2);
+	mask |= 1 << ((mmMME_QM_CP_MSG_BASE0_ADDR_LO & 0x7F) >> 2);
+	mask |= 1 << ((mmMME_QM_CP_MSG_BASE0_ADDR_HI & 0x7F) >> 2);
+	mask |= 1 << ((mmMME_QM_CP_MSG_BASE1_ADDR_LO & 0x7F) >> 2);
+	mask |= 1 << ((mmMME_QM_CP_MSG_BASE1_ADDR_HI & 0x7F) >> 2);
+	mask |= 1 << ((mmMME_QM_CP_MSG_BASE2_ADDR_LO & 0x7F) >> 2);
+	mask |= 1 << ((mmMME_QM_CP_MSG_BASE2_ADDR_HI & 0x7F) >> 2);
+	mask |= 1 << ((mmMME_QM_CP_MSG_BASE3_ADDR_LO & 0x7F) >> 2);
+	mask |= 1 << ((mmMME_QM_CP_MSG_BASE3_ADDR_HI & 0x7F) >> 2);
+	mask |= 1 << ((mmMME_QM_CP_LDMA_TSIZE_OFFSET & 0x7F) >> 2);
+	mask |= 1 << ((mmMME_QM_CP_LDMA_SRC_BASE_LO_OFFSET & 0x7F) >> 2);
+	mask |= 1 << ((mmMME_QM_CP_LDMA_SRC_BASE_HI_OFFSET & 0x7F) >> 2);
+	mask |= 1 << ((mmMME_QM_CP_LDMA_DST_BASE_LO_OFFSET & 0x7F) >> 2);
+	mask |= 1 << ((mmMME_QM_CP_LDMA_DST_BASE_HI_OFFSET & 0x7F) >> 2);
+	mask |= 1 << ((mmMME_QM_CP_LDMA_COMMIT_OFFSET & 0x7F) >> 2);
+
+	WREG32(pb_addr + word_offset, ~mask);
+
+	pb_addr = (mmMME_QM_CP_STS & ~0xFFF) + PROT_BITS_OFFS;
+	word_offset = ((mmMME_QM_CP_STS & PROT_BITS_OFFS) >> 7) << 2;
+	mask = 1 << ((mmMME_QM_CP_STS & 0x7F) >> 2);
+	mask |= 1 << ((mmMME_QM_CP_CURRENT_INST_LO & 0x7F) >> 2);
+	mask |= 1 << ((mmMME_QM_CP_CURRENT_INST_HI & 0x7F) >> 2);
+	mask |= 1 << ((mmMME_QM_CP_BARRIER_CFG & 0x7F) >> 2);
+	mask |= 1 << ((mmMME_QM_CP_DBG_0 & 0x7F) >> 2);
+	mask |= 1 << ((mmMME_QM_PQ_BUF_ADDR & 0x7F) >> 2);
+	mask |= 1 << ((mmMME_QM_PQ_BUF_RDATA & 0x7F) >> 2);
+	mask |= 1 << ((mmMME_QM_CQ_BUF_ADDR & 0x7F) >> 2);
+	mask |= 1 << ((mmMME_QM_CQ_BUF_RDATA & 0x7F) >> 2);
+
+	WREG32(pb_addr + word_offset, ~mask);
+
+	pb_addr = (mmMME_CMDQ_GLBL_CFG0 & ~0xFFF) + PROT_BITS_OFFS;
+	word_offset = ((mmMME_CMDQ_GLBL_CFG0 & PROT_BITS_OFFS) >> 7) << 2;
+	mask = 1 << ((mmMME_CMDQ_GLBL_CFG0 & 0x7F) >> 2);
+	mask |= 1 << ((mmMME_CMDQ_GLBL_CFG1 & 0x7F) >> 2);
+	mask |= 1 << ((mmMME_CMDQ_GLBL_PROT & 0x7F) >> 2);
+	mask |= 1 << ((mmMME_CMDQ_GLBL_ERR_CFG & 0x7F) >> 2);
+	mask |= 1 << ((mmMME_CMDQ_GLBL_ERR_ADDR_LO & 0x7F) >> 2);
+	mask |= 1 << ((mmMME_CMDQ_GLBL_ERR_ADDR_HI & 0x7F) >> 2);
+	mask |= 1 << ((mmMME_CMDQ_GLBL_ERR_WDATA & 0x7F) >> 2);
+	mask |= 1 << ((mmMME_CMDQ_GLBL_SECURE_PROPS & 0x7F) >> 2);
+	mask |= 1 << ((mmMME_CMDQ_GLBL_NON_SECURE_PROPS & 0x7F) >> 2);
+	mask |= 1 << ((mmMME_CMDQ_GLBL_STS0 & 0x7F) >> 2);
+	mask |= 1 << ((mmMME_CMDQ_GLBL_STS1 & 0x7F) >> 2);
+
+	WREG32(pb_addr + word_offset, ~mask);
+
+	pb_addr = (mmMME_CMDQ_CQ_CFG0 & ~0xFFF) + PROT_BITS_OFFS;
+	word_offset = ((mmMME_CMDQ_CQ_CFG0 & PROT_BITS_OFFS) >> 7) << 2;
+	mask = 1 << ((mmMME_CMDQ_CQ_CFG0 & 0x7F) >> 2);
+	mask |= 1 << ((mmMME_CMDQ_CQ_CFG1 & 0x7F) >> 2);
+	mask |= 1 << ((mmMME_CMDQ_CQ_ARUSER & 0x7F) >> 2);
+	mask |= 1 << ((mmMME_CMDQ_CQ_PTR_LO_STS & 0x7F) >> 2);
+	mask |= 1 << ((mmMME_CMDQ_CQ_PTR_HI_STS & 0x7F) >> 2);
+	mask |= 1 << ((mmMME_CMDQ_CQ_TSIZE_STS & 0x7F) >> 2);
+	mask |= 1 << ((mmMME_CMDQ_CQ_CTL_STS & 0x7F) >> 2);
+	mask |= 1 << ((mmMME_CMDQ_CQ_STS0 & 0x7F) >> 2);
+	mask |= 1 << ((mmMME_CMDQ_CQ_STS1 & 0x7F) >> 2);
+	mask |= 1 << ((mmMME_CMDQ_CQ_RD_RATE_LIM_EN & 0x7F) >> 2);
+	mask |= 1 << ((mmMME_CMDQ_CQ_RD_RATE_LIM_RST_TOKEN & 0x7F) >> 2);
+	mask |= 1 << ((mmMME_CMDQ_CQ_RD_RATE_LIM_SAT & 0x7F) >> 2);
+	mask |= 1 << ((mmMME_CMDQ_CQ_RD_RATE_LIM_TOUT & 0x7F) >> 2);
+
+	WREG32(pb_addr + word_offset, ~mask);
+
+	pb_addr = (mmMME_CMDQ_CQ_IFIFO_CNT & ~0xFFF) + PROT_BITS_OFFS;
+	word_offset = ((mmMME_CMDQ_CQ_IFIFO_CNT &
+			PROT_BITS_OFFS) >> 7) << 2;
+	mask = 1 << ((mmMME_CMDQ_CQ_IFIFO_CNT & 0x7F) >> 2);
+	mask |= 1 << ((mmMME_CMDQ_CP_MSG_BASE0_ADDR_LO & 0x7F) >> 2);
+	mask |= 1 << ((mmMME_CMDQ_CP_MSG_BASE0_ADDR_HI & 0x7F) >> 2);
+	mask |= 1 << ((mmMME_CMDQ_CP_MSG_BASE1_ADDR_LO & 0x7F) >> 2);
+	mask |= 1 << ((mmMME_CMDQ_CP_MSG_BASE1_ADDR_HI & 0x7F) >> 2);
+	mask |= 1 << ((mmMME_CMDQ_CP_MSG_BASE2_ADDR_LO & 0x7F) >> 2);
+	mask |= 1 << ((mmMME_CMDQ_CP_MSG_BASE2_ADDR_HI & 0x7F) >> 2);
+	mask |= 1 << ((mmMME_CMDQ_CP_MSG_BASE3_ADDR_LO & 0x7F) >> 2);
+	mask |= 1 << ((mmMME_CMDQ_CP_MSG_BASE3_ADDR_HI & 0x7F) >> 2);
+	mask |= 1 << ((mmMME_CMDQ_CP_LDMA_TSIZE_OFFSET & 0x7F) >> 2);
+	mask |= 1 << ((mmMME_CMDQ_CP_LDMA_SRC_BASE_LO_OFFSET & 0x7F) >> 2);
+	mask |= 1 << ((mmMME_CMDQ_CP_LDMA_SRC_BASE_HI_OFFSET & 0x7F) >> 2);
+	mask |= 1 << ((mmMME_CMDQ_CP_LDMA_DST_BASE_LO_OFFSET & 0x7F) >> 2);
+	mask |= 1 << ((mmMME_CMDQ_CP_LDMA_DST_BASE_HI_OFFSET & 0x7F) >> 2);
+	mask |= 1 << ((mmMME_CMDQ_CP_LDMA_COMMIT_OFFSET & 0x7F) >> 2);
+	mask |= 1 << ((mmMME_CMDQ_CP_STS & 0x7F) >> 2);
+	mask |= 1 << ((mmMME_CMDQ_CP_CURRENT_INST_LO & 0x7F) >> 2);
+
+	WREG32(pb_addr + word_offset, ~mask);
+
+	pb_addr = (mmMME_CMDQ_CP_CURRENT_INST_HI & ~0xFFF) + PROT_BITS_OFFS;
+	word_offset = ((mmMME_CMDQ_CP_CURRENT_INST_HI & PROT_BITS_OFFS) >> 7)
+			<< 2;
+	mask = 1 << ((mmMME_CMDQ_CP_CURRENT_INST_HI & 0x7F) >> 2);
+	mask |= 1 << ((mmMME_CMDQ_CP_BARRIER_CFG & 0x7F) >> 2);
+	mask |= 1 << ((mmMME_CMDQ_CP_DBG_0 & 0x7F) >> 2);
+	mask |= 1 << ((mmMME_CMDQ_CQ_BUF_ADDR & 0x7F) >> 2);
+	mask |= 1 << ((mmMME_CMDQ_CQ_BUF_RDATA & 0x7F) >> 2);
+
+	WREG32(pb_addr + word_offset, ~mask);
+
+	pb_addr = (mmMME_SBB_POWER_ECO1 & ~0xFFF) + PROT_BITS_OFFS;
+	word_offset = ((mmMME_SBB_POWER_ECO1 & PROT_BITS_OFFS) >> 7) << 2;
+	mask = 1 << ((mmMME_SBB_POWER_ECO1 & 0x7F) >> 2);
+	mask |= 1 << ((mmMME_SBB_POWER_ECO2 & 0x7F) >> 2);
+
+	WREG32(pb_addr + word_offset, ~mask);
+}
+
+static void goya_init_dma_protection_bits(struct hl_device *hdev)
+{
+	u32 pb_addr, mask;
+	u8 word_offset;
+
+	goya_pb_set_block(hdev, mmDMA_NRTR_BASE);
+	goya_pb_set_block(hdev, mmDMA_RD_REGULATOR_BASE);
+	goya_pb_set_block(hdev, mmDMA_WR_REGULATOR_BASE);
+
+	pb_addr = (mmDMA_QM_0_GLBL_CFG0 & ~0xFFF) + PROT_BITS_OFFS;
+	word_offset = ((mmDMA_QM_0_GLBL_CFG0 & PROT_BITS_OFFS) >> 7) << 2;
+	mask = 1 << ((mmDMA_QM_0_GLBL_CFG0 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA_QM_0_GLBL_CFG1 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA_QM_0_GLBL_PROT & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA_QM_0_GLBL_ERR_CFG & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA_QM_0_GLBL_ERR_ADDR_LO & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA_QM_0_GLBL_ERR_ADDR_HI & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA_QM_0_GLBL_ERR_WDATA & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA_QM_0_GLBL_SECURE_PROPS & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA_QM_0_GLBL_NON_SECURE_PROPS & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA_QM_0_GLBL_STS0 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA_QM_0_GLBL_STS1 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA_QM_0_PQ_BASE_LO & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA_QM_0_PQ_BASE_HI & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA_QM_0_PQ_SIZE & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA_QM_0_PQ_PI & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA_QM_0_PQ_CI & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA_QM_0_PQ_CFG0 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA_QM_0_PQ_CFG1 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA_QM_0_PQ_ARUSER & 0x7F) >> 2);
+
+	WREG32(pb_addr + word_offset, ~mask);
+
+	pb_addr = (mmDMA_QM_0_PQ_PUSH0 & ~0xFFF) + PROT_BITS_OFFS;
+	word_offset = ((mmDMA_QM_0_PQ_PUSH0 & PROT_BITS_OFFS) >> 7) << 2;
+	mask = 1 << ((mmDMA_QM_0_PQ_PUSH0 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA_QM_0_PQ_PUSH1 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA_QM_0_PQ_PUSH2 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA_QM_0_PQ_PUSH3 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA_QM_0_PQ_STS0 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA_QM_0_PQ_STS1 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA_QM_0_PQ_RD_RATE_LIM_EN & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA_QM_0_PQ_RD_RATE_LIM_RST_TOKEN & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA_QM_0_PQ_RD_RATE_LIM_SAT & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA_QM_0_PQ_RD_RATE_LIM_TOUT & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA_QM_0_CQ_CFG0 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA_QM_0_CQ_CFG1 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA_QM_0_CQ_ARUSER & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA_QM_0_CQ_PTR_LO & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA_QM_0_CQ_PTR_HI & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA_QM_0_CQ_TSIZE & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA_QM_0_CQ_CTL & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA_QM_0_CQ_PTR_LO_STS & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA_QM_0_CQ_PTR_HI_STS & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA_QM_0_CQ_TSIZE_STS & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA_QM_0_CQ_CTL_STS & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA_QM_0_CQ_STS0 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA_QM_0_CQ_STS1 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA_QM_0_CQ_RD_RATE_LIM_EN & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA_QM_0_CQ_RD_RATE_LIM_RST_TOKEN & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA_QM_0_CQ_RD_RATE_LIM_SAT & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA_QM_0_CQ_RD_RATE_LIM_TOUT & 0x7F) >> 2);
+
+	WREG32(pb_addr + word_offset, ~mask);
+
+	pb_addr = (mmDMA_QM_0_CQ_IFIFO_CNT & ~0xFFF) + PROT_BITS_OFFS;
+	word_offset = ((mmDMA_QM_0_CQ_IFIFO_CNT & PROT_BITS_OFFS) >> 7) << 2;
+	mask = 1 << ((mmDMA_QM_0_CQ_IFIFO_CNT & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA_QM_0_CP_MSG_BASE0_ADDR_LO & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA_QM_0_CP_MSG_BASE0_ADDR_HI & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA_QM_0_CP_MSG_BASE1_ADDR_LO & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA_QM_0_CP_MSG_BASE1_ADDR_HI & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA_QM_0_CP_MSG_BASE2_ADDR_LO & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA_QM_0_CP_MSG_BASE2_ADDR_HI & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA_QM_0_CP_MSG_BASE3_ADDR_LO & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA_QM_0_CP_MSG_BASE3_ADDR_HI & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA_QM_0_CP_LDMA_TSIZE_OFFSET & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA_QM_0_CP_LDMA_SRC_BASE_LO_OFFSET & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA_QM_0_CP_LDMA_SRC_BASE_HI_OFFSET & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA_QM_0_CP_LDMA_DST_BASE_LO_OFFSET & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA_QM_0_CP_LDMA_DST_BASE_HI_OFFSET & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA_QM_0_CP_LDMA_COMMIT_OFFSET & 0x7F) >> 2);
+
+	WREG32(pb_addr + word_offset, ~mask);
+
+	goya_pb_set_block(hdev, mmDMA_CH_0_BASE);
+
+	pb_addr = (mmDMA_QM_1_GLBL_CFG0 & ~0xFFF) + PROT_BITS_OFFS;
+	word_offset = ((mmDMA_QM_1_GLBL_CFG0 & PROT_BITS_OFFS) >> 7) << 2;
+	mask = 1 << ((mmDMA_QM_1_GLBL_CFG0 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA_QM_1_GLBL_CFG1 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA_QM_1_GLBL_PROT & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA_QM_1_GLBL_ERR_CFG & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA_QM_1_GLBL_ERR_ADDR_LO & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA_QM_1_GLBL_ERR_ADDR_HI & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA_QM_1_GLBL_ERR_WDATA & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA_QM_1_GLBL_SECURE_PROPS & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA_QM_1_GLBL_NON_SECURE_PROPS & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA_QM_1_GLBL_STS0 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA_QM_1_GLBL_STS1 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA_QM_1_PQ_BASE_LO & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA_QM_1_PQ_BASE_HI & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA_QM_1_PQ_SIZE & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA_QM_1_PQ_PI & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA_QM_1_PQ_CI & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA_QM_1_PQ_CFG0 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA_QM_1_PQ_CFG1 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA_QM_1_PQ_ARUSER & 0x7F) >> 2);
+
+	WREG32(pb_addr + word_offset, ~mask);
+
+	pb_addr = (mmDMA_QM_1_PQ_PUSH0 & ~0xFFF) + PROT_BITS_OFFS;
+	word_offset = ((mmDMA_QM_1_PQ_PUSH0 & PROT_BITS_OFFS) >> 7) << 2;
+	mask = 1 << ((mmDMA_QM_1_PQ_PUSH0 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA_QM_1_PQ_PUSH1 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA_QM_1_PQ_PUSH2 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA_QM_1_PQ_PUSH3 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA_QM_1_PQ_STS0 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA_QM_1_PQ_STS1 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA_QM_1_PQ_RD_RATE_LIM_EN & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA_QM_1_PQ_RD_RATE_LIM_RST_TOKEN & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA_QM_1_PQ_RD_RATE_LIM_SAT & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA_QM_1_PQ_RD_RATE_LIM_TOUT & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA_QM_1_CQ_CFG0 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA_QM_1_CQ_CFG1 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA_QM_1_CQ_ARUSER & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA_QM_1_CQ_PTR_LO & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA_QM_1_CQ_PTR_HI & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA_QM_1_CQ_TSIZE & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA_QM_1_CQ_CTL & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA_QM_1_CQ_PTR_LO_STS & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA_QM_1_CQ_PTR_HI_STS & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA_QM_1_CQ_TSIZE_STS & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA_QM_1_CQ_CTL_STS & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA_QM_1_CQ_STS0 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA_QM_1_CQ_STS1 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA_QM_1_CQ_RD_RATE_LIM_EN & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA_QM_1_CQ_RD_RATE_LIM_RST_TOKEN & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA_QM_1_CQ_RD_RATE_LIM_SAT & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA_QM_1_CQ_RD_RATE_LIM_TOUT & 0x7F) >> 2);
+
+	WREG32(pb_addr + word_offset, ~mask);
+
+	pb_addr = (mmDMA_QM_1_CQ_IFIFO_CNT & ~0xFFF) + PROT_BITS_OFFS;
+	word_offset = ((mmDMA_QM_1_CQ_IFIFO_CNT & PROT_BITS_OFFS) >> 7) << 2;
+	mask = 1 << ((mmDMA_QM_1_CQ_IFIFO_CNT & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA_QM_1_CP_MSG_BASE0_ADDR_LO & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA_QM_1_CP_MSG_BASE0_ADDR_HI & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA_QM_1_CP_MSG_BASE1_ADDR_LO & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA_QM_1_CP_MSG_BASE1_ADDR_HI & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA_QM_1_CP_MSG_BASE2_ADDR_LO & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA_QM_1_CP_MSG_BASE2_ADDR_HI & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA_QM_1_CP_MSG_BASE3_ADDR_LO & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA_QM_1_CP_MSG_BASE3_ADDR_HI & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA_QM_1_CP_LDMA_TSIZE_OFFSET & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA_QM_1_CP_LDMA_SRC_BASE_LO_OFFSET & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA_QM_1_CP_LDMA_SRC_BASE_HI_OFFSET & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA_QM_1_CP_LDMA_DST_BASE_LO_OFFSET & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA_QM_1_CP_LDMA_DST_BASE_HI_OFFSET & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA_QM_1_CP_LDMA_COMMIT_OFFSET & 0x7F) >> 2);
+
+	WREG32(pb_addr + word_offset, ~mask);
+
+	goya_pb_set_block(hdev, mmDMA_CH_1_BASE);
+
+	pb_addr = (mmDMA_QM_2_GLBL_CFG0 & ~0xFFF) + PROT_BITS_OFFS;
+	word_offset = ((mmDMA_QM_2_GLBL_CFG0 & PROT_BITS_OFFS) >> 7) << 2;
+	mask = 1 << ((mmDMA_QM_2_GLBL_CFG0 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA_QM_2_GLBL_CFG1 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA_QM_2_GLBL_PROT & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA_QM_2_GLBL_ERR_CFG & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA_QM_2_GLBL_ERR_ADDR_LO & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA_QM_2_GLBL_ERR_ADDR_HI & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA_QM_2_GLBL_ERR_WDATA & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA_QM_2_GLBL_SECURE_PROPS & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA_QM_2_GLBL_NON_SECURE_PROPS & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA_QM_2_GLBL_STS0 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA_QM_2_GLBL_STS1 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA_QM_2_PQ_BASE_LO & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA_QM_2_PQ_BASE_HI & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA_QM_2_PQ_SIZE & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA_QM_2_PQ_PI & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA_QM_2_PQ_CI & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA_QM_2_PQ_CFG0 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA_QM_2_PQ_CFG1 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA_QM_2_PQ_ARUSER & 0x7F) >> 2);
+
+	WREG32(pb_addr + word_offset, ~mask);
+
+	pb_addr = (mmDMA_QM_2_PQ_PUSH0 & ~0xFFF) + PROT_BITS_OFFS;
+	word_offset = ((mmDMA_QM_2_PQ_PUSH0 & PROT_BITS_OFFS) >> 7) << 2;
+	mask = 1 << ((mmDMA_QM_2_PQ_PUSH0 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA_QM_2_PQ_PUSH1 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA_QM_2_PQ_PUSH2 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA_QM_2_PQ_PUSH3 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA_QM_2_PQ_STS0 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA_QM_2_PQ_STS1 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA_QM_2_PQ_RD_RATE_LIM_EN & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA_QM_2_PQ_RD_RATE_LIM_RST_TOKEN & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA_QM_2_PQ_RD_RATE_LIM_SAT & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA_QM_2_PQ_RD_RATE_LIM_TOUT & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA_QM_2_CQ_CFG0 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA_QM_2_CQ_CFG1 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA_QM_2_CQ_ARUSER & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA_QM_2_CQ_PTR_LO & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA_QM_2_CQ_PTR_HI & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA_QM_2_CQ_TSIZE & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA_QM_2_CQ_CTL & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA_QM_2_CQ_PTR_LO_STS & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA_QM_2_CQ_PTR_HI_STS & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA_QM_2_CQ_TSIZE_STS & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA_QM_2_CQ_CTL_STS & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA_QM_2_CQ_STS0 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA_QM_2_CQ_STS1 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA_QM_2_CQ_RD_RATE_LIM_EN & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA_QM_2_CQ_RD_RATE_LIM_RST_TOKEN & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA_QM_2_CQ_RD_RATE_LIM_SAT & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA_QM_2_CQ_RD_RATE_LIM_TOUT & 0x7F) >> 2);
+
+	WREG32(pb_addr + word_offset, ~mask);
+
+	pb_addr = (mmDMA_QM_2_CQ_IFIFO_CNT & ~0xFFF) + PROT_BITS_OFFS;
+	word_offset = ((mmDMA_QM_2_CQ_IFIFO_CNT & PROT_BITS_OFFS) >> 7) << 2;
+	mask = 1 << ((mmDMA_QM_2_CQ_IFIFO_CNT & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA_QM_2_CP_MSG_BASE0_ADDR_LO & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA_QM_2_CP_MSG_BASE0_ADDR_HI & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA_QM_2_CP_MSG_BASE1_ADDR_LO & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA_QM_2_CP_MSG_BASE1_ADDR_HI & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA_QM_2_CP_MSG_BASE2_ADDR_LO & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA_QM_2_CP_MSG_BASE2_ADDR_HI & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA_QM_2_CP_MSG_BASE3_ADDR_LO & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA_QM_2_CP_MSG_BASE3_ADDR_HI & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA_QM_2_CP_LDMA_TSIZE_OFFSET & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA_QM_2_CP_LDMA_SRC_BASE_LO_OFFSET & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA_QM_2_CP_LDMA_SRC_BASE_HI_OFFSET & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA_QM_2_CP_LDMA_DST_BASE_LO_OFFSET & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA_QM_2_CP_LDMA_DST_BASE_HI_OFFSET & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA_QM_2_CP_LDMA_COMMIT_OFFSET & 0x7F) >> 2);
+
+	WREG32(pb_addr + word_offset, ~mask);
+
+	goya_pb_set_block(hdev, mmDMA_CH_2_BASE);
+
+	pb_addr = (mmDMA_QM_3_GLBL_CFG0 & ~0xFFF) + PROT_BITS_OFFS;
+	word_offset = ((mmDMA_QM_3_GLBL_CFG0 & PROT_BITS_OFFS) >> 7) << 2;
+	mask = 1 << ((mmDMA_QM_3_GLBL_CFG0 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA_QM_3_GLBL_CFG1 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA_QM_3_GLBL_PROT & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA_QM_3_GLBL_ERR_CFG & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA_QM_3_GLBL_ERR_ADDR_LO & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA_QM_3_GLBL_ERR_ADDR_HI & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA_QM_3_GLBL_ERR_WDATA & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA_QM_3_GLBL_SECURE_PROPS & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA_QM_3_GLBL_NON_SECURE_PROPS & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA_QM_3_GLBL_STS0 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA_QM_3_GLBL_STS1 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA_QM_3_PQ_BASE_LO & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA_QM_3_PQ_BASE_HI & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA_QM_3_PQ_SIZE & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA_QM_3_PQ_PI & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA_QM_3_PQ_CI & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA_QM_3_PQ_CFG0 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA_QM_3_PQ_CFG1 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA_QM_3_PQ_ARUSER & 0x7F) >> 2);
+
+	WREG32(pb_addr + word_offset, ~mask);
+
+	pb_addr = (mmDMA_QM_3_PQ_PUSH0 & ~0xFFF) + PROT_BITS_OFFS;
+	word_offset = ((mmDMA_QM_3_PQ_PUSH0 & PROT_BITS_OFFS) >> 7) << 2;
+	mask = 1 << ((mmDMA_QM_3_PQ_PUSH0 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA_QM_3_PQ_PUSH1 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA_QM_3_PQ_PUSH2 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA_QM_3_PQ_PUSH3 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA_QM_3_PQ_STS0 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA_QM_3_PQ_STS1 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA_QM_3_PQ_RD_RATE_LIM_EN & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA_QM_3_PQ_RD_RATE_LIM_RST_TOKEN & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA_QM_3_PQ_RD_RATE_LIM_SAT & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA_QM_3_PQ_RD_RATE_LIM_TOUT & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA_QM_3_CQ_CFG0 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA_QM_3_CQ_CFG1 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA_QM_3_CQ_ARUSER & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA_QM_3_CQ_PTR_LO & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA_QM_3_CQ_PTR_HI & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA_QM_3_CQ_TSIZE & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA_QM_3_CQ_CTL & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA_QM_3_CQ_PTR_LO_STS & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA_QM_3_CQ_PTR_HI_STS & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA_QM_3_CQ_TSIZE_STS & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA_QM_3_CQ_CTL_STS & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA_QM_3_CQ_STS0 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA_QM_3_CQ_STS1 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA_QM_3_CQ_RD_RATE_LIM_EN & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA_QM_3_CQ_RD_RATE_LIM_RST_TOKEN & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA_QM_3_CQ_RD_RATE_LIM_SAT & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA_QM_3_CQ_RD_RATE_LIM_TOUT & 0x7F) >> 2);
+
+	WREG32(pb_addr + word_offset, ~mask);
+
+	pb_addr = (mmDMA_QM_3_CQ_IFIFO_CNT & ~0xFFF) + PROT_BITS_OFFS;
+	word_offset = ((mmDMA_QM_3_CQ_IFIFO_CNT & PROT_BITS_OFFS) >> 7) << 2;
+	mask = 1 << ((mmDMA_QM_3_CQ_IFIFO_CNT & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA_QM_3_CP_MSG_BASE0_ADDR_LO & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA_QM_3_CP_MSG_BASE0_ADDR_HI & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA_QM_3_CP_MSG_BASE1_ADDR_LO & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA_QM_3_CP_MSG_BASE1_ADDR_HI & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA_QM_3_CP_MSG_BASE2_ADDR_LO & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA_QM_3_CP_MSG_BASE2_ADDR_HI & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA_QM_3_CP_MSG_BASE3_ADDR_LO & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA_QM_3_CP_MSG_BASE3_ADDR_HI & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA_QM_3_CP_LDMA_TSIZE_OFFSET & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA_QM_3_CP_LDMA_SRC_BASE_LO_OFFSET & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA_QM_3_CP_LDMA_SRC_BASE_HI_OFFSET & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA_QM_3_CP_LDMA_DST_BASE_LO_OFFSET & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA_QM_3_CP_LDMA_DST_BASE_HI_OFFSET & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA_QM_3_CP_LDMA_COMMIT_OFFSET & 0x7F) >> 2);
+
+	WREG32(pb_addr + word_offset, ~mask);
+
+	goya_pb_set_block(hdev, mmDMA_CH_3_BASE);
+
+	pb_addr = (mmDMA_QM_4_GLBL_CFG0 & ~0xFFF) + PROT_BITS_OFFS;
+	word_offset = ((mmDMA_QM_4_GLBL_CFG0 & PROT_BITS_OFFS) >> 7) << 2;
+	mask = 1 << ((mmDMA_QM_4_GLBL_CFG0 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA_QM_4_GLBL_CFG1 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA_QM_4_GLBL_PROT & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA_QM_4_GLBL_ERR_CFG & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA_QM_4_GLBL_ERR_ADDR_LO & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA_QM_4_GLBL_ERR_ADDR_HI & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA_QM_4_GLBL_ERR_WDATA & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA_QM_4_GLBL_SECURE_PROPS & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA_QM_4_GLBL_NON_SECURE_PROPS & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA_QM_4_GLBL_STS0 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA_QM_4_GLBL_STS1 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA_QM_4_PQ_BASE_LO & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA_QM_4_PQ_BASE_HI & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA_QM_4_PQ_SIZE & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA_QM_4_PQ_PI & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA_QM_4_PQ_CI & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA_QM_4_PQ_CFG0 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA_QM_4_PQ_CFG1 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA_QM_4_PQ_ARUSER & 0x7F) >> 2);
+
+	WREG32(pb_addr + word_offset, ~mask);
+
+	pb_addr = (mmDMA_QM_4_PQ_PUSH0 & ~0xFFF) + PROT_BITS_OFFS;
+	word_offset = ((mmDMA_QM_4_PQ_PUSH0 & PROT_BITS_OFFS) >> 7) << 2;
+	mask = 1 << ((mmDMA_QM_4_PQ_PUSH0 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA_QM_4_PQ_PUSH1 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA_QM_4_PQ_PUSH2 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA_QM_4_PQ_PUSH3 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA_QM_4_PQ_STS0 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA_QM_4_PQ_STS1 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA_QM_4_PQ_RD_RATE_LIM_EN & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA_QM_4_PQ_RD_RATE_LIM_RST_TOKEN & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA_QM_4_PQ_RD_RATE_LIM_SAT & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA_QM_4_PQ_RD_RATE_LIM_TOUT & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA_QM_4_CQ_CFG0 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA_QM_4_CQ_CFG1 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA_QM_4_CQ_ARUSER & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA_QM_4_CQ_PTR_LO & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA_QM_4_CQ_PTR_HI & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA_QM_4_CQ_TSIZE & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA_QM_4_CQ_CTL & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA_QM_4_CQ_PTR_LO_STS & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA_QM_4_CQ_PTR_HI_STS & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA_QM_4_CQ_TSIZE_STS & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA_QM_4_CQ_CTL_STS & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA_QM_4_CQ_STS0 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA_QM_4_CQ_STS1 & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA_QM_4_CQ_RD_RATE_LIM_EN & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA_QM_4_CQ_RD_RATE_LIM_RST_TOKEN & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA_QM_4_CQ_RD_RATE_LIM_SAT & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA_QM_4_CQ_RD_RATE_LIM_TOUT & 0x7F) >> 2);
+
+	WREG32(pb_addr + word_offset, ~mask);
+
+	pb_addr = (mmDMA_QM_4_CQ_IFIFO_CNT & ~0xFFF) + PROT_BITS_OFFS;
+	word_offset = ((mmDMA_QM_4_CQ_IFIFO_CNT & PROT_BITS_OFFS) >> 7) << 2;
+	mask = 1 << ((mmDMA_QM_4_CQ_IFIFO_CNT & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA_QM_4_CP_MSG_BASE0_ADDR_LO & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA_QM_4_CP_MSG_BASE0_ADDR_HI & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA_QM_4_CP_MSG_BASE1_ADDR_LO & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA_QM_4_CP_MSG_BASE1_ADDR_HI & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA_QM_4_CP_MSG_BASE2_ADDR_LO & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA_QM_4_CP_MSG_BASE2_ADDR_HI & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA_QM_4_CP_MSG_BASE3_ADDR_LO & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA_QM_4_CP_MSG_BASE3_ADDR_HI & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA_QM_4_CP_LDMA_TSIZE_OFFSET & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA_QM_4_CP_LDMA_SRC_BASE_LO_OFFSET & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA_QM_4_CP_LDMA_SRC_BASE_HI_OFFSET & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA_QM_4_CP_LDMA_DST_BASE_LO_OFFSET & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA_QM_4_CP_LDMA_DST_BASE_HI_OFFSET & 0x7F) >> 2);
+	mask |= 1 << ((mmDMA_QM_4_CP_LDMA_COMMIT_OFFSET & 0x7F) >> 2);
+
+	WREG32(pb_addr + word_offset, ~mask);
+
+	goya_pb_set_block(hdev, mmDMA_CH_4_BASE);
+}
+
+static void goya_init_tpc_protection_bits(struct hl_device *hdev)
+{
+	u32 pb_addr, mask;
+	u8 word_offset;
+
+	goya_pb_set_block(hdev, mmTPC0_RD_REGULATOR_BASE);
+	goya_pb_set_block(hdev, mmTPC0_WR_REGULATOR_BASE);
+
+	pb_addr = (mmTPC0_CFG_CFG_BASE_ADDRESS_HIGH & ~0xFFF) + PROT_BITS_OFFS;
+	word_offset = ((mmTPC0_CFG_CFG_BASE_ADDRESS_HIGH &
+			PROT_BITS_OFFS) >> 7) << 2;
+	mask = 1 << ((mmTPC0_CFG_CFG_BASE_ADDRESS_HIGH & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC0_CFG_CFG_SUBTRACT_VALUE & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC0_CFG_SM_BASE_ADDRESS_LOW & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC0_CFG_SM_BASE_ADDRESS_HIGH & 0x7F) >> 2);
+
+	WREG32(pb_addr + word_offset, ~mask);
+
+	pb_addr = (mmTPC0_CFG_ARUSER & ~0xFFF) + PROT_BITS_OFFS;
+	word_offset = ((mmTPC0_CFG_ARUSER & PROT_BITS_OFFS) >> 7) << 2;
+	mask = 1 << ((mmTPC0_CFG_ARUSER & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC0_CFG_AWUSER & 0x7F) >> 2);
+
+	WREG32(pb_addr + word_offset, ~mask);
+
+	pb_addr = (mmTPC0_CFG_FUNC_MBIST_CNTRL & ~0xFFF) + PROT_BITS_OFFS;
+	word_offset = ((mmTPC0_CFG_FUNC_MBIST_CNTRL &
+			PROT_BITS_OFFS) >> 7) << 2;
+	mask = 1 << ((mmTPC0_CFG_FUNC_MBIST_CNTRL & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC0_CFG_FUNC_MBIST_PAT & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC0_CFG_FUNC_MBIST_MEM_0 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC0_CFG_FUNC_MBIST_MEM_1 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC0_CFG_FUNC_MBIST_MEM_2 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC0_CFG_FUNC_MBIST_MEM_3 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC0_CFG_FUNC_MBIST_MEM_4 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC0_CFG_FUNC_MBIST_MEM_5 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC0_CFG_FUNC_MBIST_MEM_6 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC0_CFG_FUNC_MBIST_MEM_7 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC0_CFG_FUNC_MBIST_MEM_8 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC0_CFG_FUNC_MBIST_MEM_9 & 0x7F) >> 2);
+
+	WREG32(pb_addr + word_offset, ~mask);
+
+	pb_addr = (mmTPC0_QM_GLBL_CFG0 & ~0xFFF) + PROT_BITS_OFFS;
+	word_offset = ((mmTPC0_QM_GLBL_CFG0 & PROT_BITS_OFFS) >> 7) << 2;
+	mask = 1 << ((mmTPC0_QM_GLBL_CFG0 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC0_QM_GLBL_CFG1 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC0_QM_GLBL_PROT & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC0_QM_GLBL_ERR_CFG & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC0_QM_GLBL_ERR_ADDR_LO & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC0_QM_GLBL_ERR_ADDR_HI & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC0_QM_GLBL_ERR_WDATA & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC0_QM_GLBL_SECURE_PROPS & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC0_QM_GLBL_NON_SECURE_PROPS & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC0_QM_GLBL_STS0 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC0_QM_GLBL_STS1 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC0_QM_PQ_BASE_LO & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC0_QM_PQ_BASE_HI & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC0_QM_PQ_SIZE & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC0_QM_PQ_PI & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC0_QM_PQ_CI & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC0_QM_PQ_CFG0 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC0_QM_PQ_CFG1 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC0_QM_PQ_ARUSER & 0x7F) >> 2);
+
+	WREG32(pb_addr + word_offset, ~mask);
+
+	pb_addr = (mmTPC0_QM_PQ_PUSH0 & ~0xFFF) + PROT_BITS_OFFS;
+	word_offset = ((mmTPC0_QM_PQ_PUSH0 & PROT_BITS_OFFS) >> 7) << 2;
+	mask = 1 << ((mmTPC0_QM_PQ_PUSH0 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC0_QM_PQ_PUSH1 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC0_QM_PQ_PUSH2 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC0_QM_PQ_PUSH3 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC0_QM_PQ_STS0 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC0_QM_PQ_STS1 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC0_QM_PQ_RD_RATE_LIM_EN & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC0_QM_PQ_RD_RATE_LIM_RST_TOKEN & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC0_QM_PQ_RD_RATE_LIM_SAT & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC0_QM_PQ_RD_RATE_LIM_TOUT & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC0_QM_CQ_CFG0 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC0_QM_CQ_CFG1 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC0_QM_CQ_ARUSER & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC0_QM_CQ_PTR_LO & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC0_QM_CQ_PTR_HI & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC0_QM_CQ_TSIZE & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC0_QM_CQ_CTL & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC0_QM_CQ_PTR_LO_STS & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC0_QM_CQ_PTR_HI_STS & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC0_QM_CQ_TSIZE_STS & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC0_QM_CQ_CTL_STS & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC0_QM_CQ_STS0 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC0_QM_CQ_STS1 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC0_QM_CQ_RD_RATE_LIM_EN & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC0_QM_CQ_RD_RATE_LIM_RST_TOKEN & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC0_QM_CQ_RD_RATE_LIM_SAT & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC0_QM_CQ_RD_RATE_LIM_TOUT & 0x7F) >> 2);
+
+	WREG32(pb_addr + word_offset, ~mask);
+
+	pb_addr = (mmTPC0_QM_CQ_IFIFO_CNT & ~0xFFF) + PROT_BITS_OFFS;
+	word_offset = ((mmTPC0_QM_CQ_IFIFO_CNT & PROT_BITS_OFFS) >> 7) << 2;
+	mask = 1 << ((mmTPC0_QM_CQ_IFIFO_CNT & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC0_QM_CP_MSG_BASE0_ADDR_LO & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC0_QM_CP_MSG_BASE0_ADDR_HI & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC0_QM_CP_MSG_BASE1_ADDR_LO & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC0_QM_CP_MSG_BASE1_ADDR_HI & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC0_QM_CP_MSG_BASE2_ADDR_LO & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC0_QM_CP_MSG_BASE2_ADDR_HI & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC0_QM_CP_MSG_BASE3_ADDR_LO & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC0_QM_CP_MSG_BASE3_ADDR_HI & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC0_QM_CP_LDMA_TSIZE_OFFSET & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC0_QM_CP_LDMA_SRC_BASE_LO_OFFSET & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC0_QM_CP_LDMA_SRC_BASE_HI_OFFSET & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC0_QM_CP_LDMA_DST_BASE_LO_OFFSET & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC0_QM_CP_LDMA_DST_BASE_HI_OFFSET & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC0_QM_CP_LDMA_COMMIT_OFFSET & 0x7F) >> 2);
+
+	WREG32(pb_addr + word_offset, ~mask);
+
+	pb_addr = (mmTPC0_CMDQ_GLBL_CFG0 & ~0xFFF) + PROT_BITS_OFFS;
+	word_offset = ((mmTPC0_CMDQ_GLBL_CFG0 & PROT_BITS_OFFS) >> 7) << 2;
+	mask = 1 << ((mmTPC0_CMDQ_GLBL_CFG0 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC0_CMDQ_GLBL_CFG1 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC0_CMDQ_GLBL_PROT & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC0_CMDQ_GLBL_ERR_CFG & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC0_CMDQ_GLBL_ERR_ADDR_LO & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC0_CMDQ_GLBL_ERR_ADDR_HI & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC0_CMDQ_GLBL_ERR_WDATA & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC0_CMDQ_GLBL_SECURE_PROPS & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC0_CMDQ_GLBL_NON_SECURE_PROPS & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC0_CMDQ_GLBL_STS0 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC0_CMDQ_GLBL_STS1 & 0x7F) >> 2);
+
+	WREG32(pb_addr + word_offset, ~mask);
+
+	pb_addr = (mmTPC0_CMDQ_CQ_CFG0 & ~0xFFF) + PROT_BITS_OFFS;
+	word_offset = ((mmTPC0_CMDQ_CQ_CFG0 & PROT_BITS_OFFS) >> 7) << 2;
+	mask = 1 << ((mmTPC0_CMDQ_CQ_CFG0 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC0_CMDQ_CQ_CFG1 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC0_CMDQ_CQ_ARUSER & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC0_CMDQ_CQ_PTR_LO_STS & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC0_CMDQ_CQ_PTR_HI_STS & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC0_CMDQ_CQ_TSIZE_STS & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC0_CMDQ_CQ_CTL_STS & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC0_CMDQ_CQ_STS0 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC0_CMDQ_CQ_STS1 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC0_CMDQ_CQ_RD_RATE_LIM_EN & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC0_CMDQ_CQ_RD_RATE_LIM_RST_TOKEN & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC0_CMDQ_CQ_RD_RATE_LIM_SAT & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC0_CMDQ_CQ_RD_RATE_LIM_TOUT & 0x7F) >> 2);
+
+	WREG32(pb_addr + word_offset, ~mask);
+
+	pb_addr = (mmTPC0_CMDQ_CQ_IFIFO_CNT & ~0xFFF) + PROT_BITS_OFFS;
+	word_offset = ((mmTPC0_CMDQ_CQ_IFIFO_CNT & PROT_BITS_OFFS) >> 7) << 2;
+	mask = 1 << ((mmTPC0_CMDQ_CQ_IFIFO_CNT & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC0_CMDQ_CP_MSG_BASE0_ADDR_LO & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC0_CMDQ_CP_MSG_BASE0_ADDR_HI & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC0_CMDQ_CP_MSG_BASE1_ADDR_LO & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC0_CMDQ_CP_MSG_BASE1_ADDR_HI & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC0_CMDQ_CP_MSG_BASE2_ADDR_LO & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC0_CMDQ_CP_MSG_BASE2_ADDR_HI & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC0_CMDQ_CP_MSG_BASE3_ADDR_LO & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC0_CMDQ_CP_MSG_BASE3_ADDR_HI & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC0_CMDQ_CP_LDMA_TSIZE_OFFSET & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC0_CMDQ_CP_LDMA_SRC_BASE_LO_OFFSET & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC0_CMDQ_CP_LDMA_SRC_BASE_HI_OFFSET & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC0_CMDQ_CP_LDMA_DST_BASE_LO_OFFSET & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC0_CMDQ_CP_LDMA_DST_BASE_HI_OFFSET & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC0_CMDQ_CP_LDMA_COMMIT_OFFSET & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC0_CMDQ_CP_STS & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC0_CMDQ_CP_CURRENT_INST_LO & 0x7F) >> 2);
+
+	WREG32(pb_addr + word_offset, ~mask);
+
+	pb_addr = (mmTPC0_CMDQ_CP_CURRENT_INST_HI & ~0xFFF) + PROT_BITS_OFFS;
+	word_offset = ((mmTPC0_CMDQ_CP_CURRENT_INST_HI & PROT_BITS_OFFS) >> 7)
+			<< 2;
+	mask = 1 << ((mmTPC0_CMDQ_CP_CURRENT_INST_HI & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC0_CMDQ_CP_BARRIER_CFG & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC0_CMDQ_CP_DBG_0 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC0_CMDQ_CQ_BUF_ADDR & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC0_CMDQ_CQ_BUF_RDATA & 0x7F) >> 2);
+
+	WREG32(pb_addr + word_offset, ~mask);
+
+	goya_pb_set_block(hdev, mmTPC1_RTR_BASE);
+	goya_pb_set_block(hdev, mmTPC1_RD_REGULATOR_BASE);
+	goya_pb_set_block(hdev, mmTPC1_WR_REGULATOR_BASE);
+
+	pb_addr = (mmTPC1_CFG_CFG_BASE_ADDRESS_HIGH & ~0xFFF) + PROT_BITS_OFFS;
+	word_offset = ((mmTPC1_CFG_CFG_BASE_ADDRESS_HIGH &
+			PROT_BITS_OFFS) >> 7) << 2;
+	mask = 1 << ((mmTPC1_CFG_CFG_BASE_ADDRESS_HIGH & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC1_CFG_CFG_SUBTRACT_VALUE & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC1_CFG_SM_BASE_ADDRESS_LOW & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC1_CFG_SM_BASE_ADDRESS_HIGH & 0x7F) >> 2);
+
+	WREG32(pb_addr + word_offset, ~mask);
+
+	pb_addr = (mmTPC1_CFG_ARUSER & ~0xFFF) + PROT_BITS_OFFS;
+	word_offset = ((mmTPC1_CFG_ARUSER & PROT_BITS_OFFS) >> 7) << 2;
+	mask = 1 << ((mmTPC1_CFG_ARUSER & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC1_CFG_AWUSER & 0x7F) >> 2);
+
+	WREG32(pb_addr + word_offset, ~mask);
+
+	pb_addr = (mmTPC1_CFG_FUNC_MBIST_CNTRL & ~0xFFF) + PROT_BITS_OFFS;
+	word_offset = ((mmTPC1_CFG_FUNC_MBIST_CNTRL & PROT_BITS_OFFS) >> 7)
+			<< 2;
+	mask = 1 << ((mmTPC1_CFG_FUNC_MBIST_CNTRL & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC1_CFG_FUNC_MBIST_PAT & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC1_CFG_FUNC_MBIST_MEM_0 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC1_CFG_FUNC_MBIST_MEM_1 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC1_CFG_FUNC_MBIST_MEM_2 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC1_CFG_FUNC_MBIST_MEM_3 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC1_CFG_FUNC_MBIST_MEM_4 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC1_CFG_FUNC_MBIST_MEM_5 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC1_CFG_FUNC_MBIST_MEM_6 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC1_CFG_FUNC_MBIST_MEM_7 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC1_CFG_FUNC_MBIST_MEM_8 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC1_CFG_FUNC_MBIST_MEM_9 & 0x7F) >> 2);
+
+	WREG32(pb_addr + word_offset, ~mask);
+
+	pb_addr = (mmTPC1_QM_GLBL_CFG0 & ~0xFFF) + PROT_BITS_OFFS;
+	word_offset = ((mmTPC1_QM_GLBL_CFG0 & PROT_BITS_OFFS) >> 7) << 2;
+	mask = 1 << ((mmTPC1_QM_GLBL_CFG0 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC1_QM_GLBL_CFG1 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC1_QM_GLBL_PROT & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC1_QM_GLBL_ERR_CFG & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC1_QM_GLBL_ERR_ADDR_LO & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC1_QM_GLBL_ERR_ADDR_HI & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC1_QM_GLBL_ERR_WDATA & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC1_QM_GLBL_SECURE_PROPS & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC1_QM_GLBL_NON_SECURE_PROPS & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC1_QM_GLBL_STS0 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC1_QM_GLBL_STS1 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC1_QM_PQ_BASE_LO & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC1_QM_PQ_BASE_HI & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC1_QM_PQ_SIZE & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC1_QM_PQ_PI & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC1_QM_PQ_CI & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC1_QM_PQ_CFG0 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC1_QM_PQ_CFG1 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC1_QM_PQ_ARUSER & 0x7F) >> 2);
+
+	WREG32(pb_addr + word_offset, ~mask);
+
+	pb_addr = (mmTPC1_QM_PQ_PUSH0 & ~0xFFF) + PROT_BITS_OFFS;
+	word_offset = ((mmTPC1_QM_PQ_PUSH0 & PROT_BITS_OFFS) >> 7) << 2;
+	mask = 1 << ((mmTPC1_QM_PQ_PUSH0 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC1_QM_PQ_PUSH1 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC1_QM_PQ_PUSH2 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC1_QM_PQ_PUSH3 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC1_QM_PQ_STS0 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC1_QM_PQ_STS1 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC1_QM_PQ_RD_RATE_LIM_EN & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC1_QM_PQ_RD_RATE_LIM_RST_TOKEN & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC1_QM_PQ_RD_RATE_LIM_SAT & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC1_QM_PQ_RD_RATE_LIM_TOUT & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC1_QM_CQ_CFG0 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC1_QM_CQ_CFG1 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC1_QM_CQ_ARUSER & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC1_QM_CQ_PTR_LO & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC1_QM_CQ_PTR_HI & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC1_QM_CQ_TSIZE & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC1_QM_CQ_CTL & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC1_QM_CQ_PTR_LO_STS & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC1_QM_CQ_PTR_HI_STS & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC1_QM_CQ_TSIZE_STS & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC1_QM_CQ_CTL_STS & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC1_QM_CQ_STS0 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC1_QM_CQ_STS1 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC1_QM_CQ_RD_RATE_LIM_EN & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC1_QM_CQ_RD_RATE_LIM_RST_TOKEN & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC1_QM_CQ_RD_RATE_LIM_SAT & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC1_QM_CQ_RD_RATE_LIM_TOUT & 0x7F) >> 2);
+
+	WREG32(pb_addr + word_offset, ~mask);
+
+	pb_addr = (mmTPC1_QM_CQ_IFIFO_CNT & ~0xFFF) + PROT_BITS_OFFS;
+	word_offset = ((mmTPC1_QM_CQ_IFIFO_CNT & PROT_BITS_OFFS) >> 7) << 2;
+	mask = 1 << ((mmTPC1_QM_CQ_IFIFO_CNT & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC1_QM_CP_MSG_BASE0_ADDR_LO & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC1_QM_CP_MSG_BASE0_ADDR_HI & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC1_QM_CP_MSG_BASE1_ADDR_LO & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC1_QM_CP_MSG_BASE1_ADDR_HI & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC1_QM_CP_MSG_BASE2_ADDR_LO & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC1_QM_CP_MSG_BASE2_ADDR_HI & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC1_QM_CP_MSG_BASE3_ADDR_LO & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC1_QM_CP_MSG_BASE3_ADDR_HI & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC1_QM_CP_LDMA_TSIZE_OFFSET & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC1_QM_CP_LDMA_SRC_BASE_LO_OFFSET & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC1_QM_CP_LDMA_SRC_BASE_HI_OFFSET & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC1_QM_CP_LDMA_DST_BASE_LO_OFFSET & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC1_QM_CP_LDMA_DST_BASE_HI_OFFSET & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC1_QM_CP_LDMA_COMMIT_OFFSET & 0x7F) >> 2);
+
+	WREG32(pb_addr + word_offset, ~mask);
+
+	pb_addr = (mmTPC1_CMDQ_GLBL_CFG0 & ~0xFFF) + PROT_BITS_OFFS;
+	word_offset = ((mmTPC1_CMDQ_GLBL_CFG0 & PROT_BITS_OFFS) >> 7) << 2;
+	mask = 1 << ((mmTPC1_CMDQ_GLBL_CFG0 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC1_CMDQ_GLBL_CFG1 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC1_CMDQ_GLBL_PROT & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC1_CMDQ_GLBL_ERR_CFG & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC1_CMDQ_GLBL_ERR_ADDR_LO & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC1_CMDQ_GLBL_ERR_ADDR_HI & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC1_CMDQ_GLBL_ERR_WDATA & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC1_CMDQ_GLBL_SECURE_PROPS & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC1_CMDQ_GLBL_NON_SECURE_PROPS & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC1_CMDQ_GLBL_STS0 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC1_CMDQ_GLBL_STS1 & 0x7F) >> 2);
+
+	WREG32(pb_addr + word_offset, ~mask);
+
+	pb_addr = (mmTPC1_CMDQ_CQ_CFG0 & ~0xFFF) + PROT_BITS_OFFS;
+	word_offset = ((mmTPC1_CMDQ_CQ_CFG0 & PROT_BITS_OFFS) >> 7) << 2;
+	mask = 1 << ((mmTPC1_CMDQ_CQ_CFG0 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC1_CMDQ_CQ_CFG1 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC1_CMDQ_CQ_ARUSER & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC1_CMDQ_CQ_PTR_LO_STS & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC1_CMDQ_CQ_PTR_HI_STS & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC1_CMDQ_CQ_TSIZE_STS & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC1_CMDQ_CQ_CTL_STS & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC1_CMDQ_CQ_STS0 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC1_CMDQ_CQ_STS1 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC1_CMDQ_CQ_RD_RATE_LIM_EN & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC1_CMDQ_CQ_RD_RATE_LIM_RST_TOKEN & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC1_CMDQ_CQ_RD_RATE_LIM_SAT & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC1_CMDQ_CQ_RD_RATE_LIM_TOUT & 0x7F) >> 2);
+
+	WREG32(pb_addr + word_offset, ~mask);
+
+	pb_addr = (mmTPC1_CMDQ_CQ_IFIFO_CNT & ~0xFFF) + PROT_BITS_OFFS;
+	word_offset = ((mmTPC1_CMDQ_CQ_IFIFO_CNT & PROT_BITS_OFFS) >> 7) << 2;
+	mask = 1 << ((mmTPC1_CMDQ_CQ_IFIFO_CNT & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC1_CMDQ_CP_MSG_BASE0_ADDR_LO & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC1_CMDQ_CP_MSG_BASE0_ADDR_HI & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC1_CMDQ_CP_MSG_BASE1_ADDR_LO & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC1_CMDQ_CP_MSG_BASE1_ADDR_HI & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC1_CMDQ_CP_MSG_BASE2_ADDR_LO & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC1_CMDQ_CP_MSG_BASE2_ADDR_HI & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC1_CMDQ_CP_MSG_BASE3_ADDR_LO & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC1_CMDQ_CP_MSG_BASE3_ADDR_HI & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC1_CMDQ_CP_LDMA_TSIZE_OFFSET & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC1_CMDQ_CP_LDMA_SRC_BASE_LO_OFFSET & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC1_CMDQ_CP_LDMA_SRC_BASE_HI_OFFSET & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC1_CMDQ_CP_LDMA_DST_BASE_LO_OFFSET & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC1_CMDQ_CP_LDMA_DST_BASE_HI_OFFSET & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC1_CMDQ_CP_LDMA_COMMIT_OFFSET & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC1_CMDQ_CP_STS & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC1_CMDQ_CP_CURRENT_INST_LO & 0x7F) >> 2);
+
+	WREG32(pb_addr + word_offset, ~mask);
+
+	pb_addr = (mmTPC1_CMDQ_CP_CURRENT_INST_HI & ~0xFFF) + PROT_BITS_OFFS;
+	word_offset = ((mmTPC1_CMDQ_CP_CURRENT_INST_HI & PROT_BITS_OFFS) >> 7)
+			<< 2;
+	mask = 1 << ((mmTPC1_CMDQ_CP_CURRENT_INST_HI & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC1_CMDQ_CP_BARRIER_CFG & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC1_CMDQ_CP_DBG_0 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC1_CMDQ_CQ_BUF_ADDR & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC1_CMDQ_CQ_BUF_RDATA & 0x7F) >> 2);
+
+	WREG32(pb_addr + word_offset, ~mask);
+
+	goya_pb_set_block(hdev, mmTPC2_RTR_BASE);
+	goya_pb_set_block(hdev, mmTPC2_RD_REGULATOR_BASE);
+	goya_pb_set_block(hdev, mmTPC2_WR_REGULATOR_BASE);
+
+	pb_addr = (mmTPC2_CFG_CFG_BASE_ADDRESS_HIGH & ~0xFFF) + PROT_BITS_OFFS;
+	word_offset = ((mmTPC2_CFG_CFG_BASE_ADDRESS_HIGH &
+			PROT_BITS_OFFS) >> 7) << 2;
+	mask = 1 << ((mmTPC2_CFG_CFG_BASE_ADDRESS_HIGH & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC2_CFG_CFG_SUBTRACT_VALUE & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC2_CFG_SM_BASE_ADDRESS_LOW & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC2_CFG_SM_BASE_ADDRESS_HIGH & 0x7F) >> 2);
+
+	WREG32(pb_addr + word_offset, ~mask);
+
+	pb_addr = (mmTPC2_CFG_ARUSER & ~0xFFF) + PROT_BITS_OFFS;
+	word_offset = ((mmTPC2_CFG_ARUSER & PROT_BITS_OFFS) >> 7) << 2;
+	mask = 1 << ((mmTPC2_CFG_ARUSER & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC2_CFG_AWUSER & 0x7F) >> 2);
+
+	WREG32(pb_addr + word_offset, ~mask);
+
+	pb_addr = (mmTPC2_CFG_FUNC_MBIST_CNTRL & ~0xFFF) + PROT_BITS_OFFS;
+	word_offset = ((mmTPC2_CFG_FUNC_MBIST_CNTRL & PROT_BITS_OFFS) >> 7)
+			<< 2;
+	mask = 1 << ((mmTPC2_CFG_FUNC_MBIST_CNTRL & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC2_CFG_FUNC_MBIST_PAT & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC2_CFG_FUNC_MBIST_MEM_0 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC2_CFG_FUNC_MBIST_MEM_1 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC2_CFG_FUNC_MBIST_MEM_2 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC2_CFG_FUNC_MBIST_MEM_3 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC2_CFG_FUNC_MBIST_MEM_4 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC2_CFG_FUNC_MBIST_MEM_5 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC2_CFG_FUNC_MBIST_MEM_6 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC2_CFG_FUNC_MBIST_MEM_7 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC2_CFG_FUNC_MBIST_MEM_8 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC2_CFG_FUNC_MBIST_MEM_9 & 0x7F) >> 2);
+
+	WREG32(pb_addr + word_offset, ~mask);
+
+	pb_addr = (mmTPC2_QM_GLBL_CFG0 & ~0xFFF) + PROT_BITS_OFFS;
+	word_offset = ((mmTPC2_QM_GLBL_CFG0 & PROT_BITS_OFFS) >> 7) << 2;
+	mask = 1 << ((mmTPC2_QM_GLBL_CFG0 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC2_QM_GLBL_CFG1 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC2_QM_GLBL_PROT & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC2_QM_GLBL_ERR_CFG & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC2_QM_GLBL_ERR_ADDR_LO & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC2_QM_GLBL_ERR_ADDR_HI & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC2_QM_GLBL_ERR_WDATA & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC2_QM_GLBL_SECURE_PROPS & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC2_QM_GLBL_NON_SECURE_PROPS & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC2_QM_GLBL_STS0 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC2_QM_GLBL_STS1 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC2_QM_PQ_BASE_LO & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC2_QM_PQ_BASE_HI & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC2_QM_PQ_SIZE & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC2_QM_PQ_PI & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC2_QM_PQ_CI & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC2_QM_PQ_CFG0 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC2_QM_PQ_CFG1 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC2_QM_PQ_ARUSER & 0x7F) >> 2);
+
+	WREG32(pb_addr + word_offset, ~mask);
+
+	pb_addr = (mmTPC2_QM_PQ_PUSH0 & ~0xFFF) + PROT_BITS_OFFS;
+	word_offset = ((mmTPC2_QM_PQ_PUSH0 & PROT_BITS_OFFS) >> 7) << 2;
+	mask = 1 << ((mmTPC2_QM_PQ_PUSH0 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC2_QM_PQ_PUSH1 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC2_QM_PQ_PUSH2 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC2_QM_PQ_PUSH3 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC2_QM_PQ_STS0 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC2_QM_PQ_STS1 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC2_QM_PQ_RD_RATE_LIM_EN & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC2_QM_PQ_RD_RATE_LIM_RST_TOKEN & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC2_QM_PQ_RD_RATE_LIM_SAT & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC2_QM_PQ_RD_RATE_LIM_TOUT & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC2_QM_CQ_CFG0 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC2_QM_CQ_CFG1 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC2_QM_CQ_ARUSER & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC2_QM_CQ_PTR_LO & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC2_QM_CQ_PTR_HI & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC2_QM_CQ_TSIZE & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC2_QM_CQ_CTL & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC2_QM_CQ_PTR_LO_STS & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC2_QM_CQ_PTR_HI_STS & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC2_QM_CQ_TSIZE_STS & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC2_QM_CQ_CTL_STS & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC2_QM_CQ_STS0 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC2_QM_CQ_STS1 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC2_QM_CQ_RD_RATE_LIM_EN & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC2_QM_CQ_RD_RATE_LIM_RST_TOKEN & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC2_QM_CQ_RD_RATE_LIM_SAT & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC2_QM_CQ_RD_RATE_LIM_TOUT & 0x7F) >> 2);
+
+	WREG32(pb_addr + word_offset, ~mask);
+
+	pb_addr = (mmTPC2_QM_CQ_IFIFO_CNT & ~0xFFF) + PROT_BITS_OFFS;
+	word_offset = ((mmTPC2_QM_CQ_IFIFO_CNT & PROT_BITS_OFFS) >> 7) << 2;
+	mask = 1 << ((mmTPC2_QM_CQ_IFIFO_CNT & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC2_QM_CP_MSG_BASE0_ADDR_LO & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC2_QM_CP_MSG_BASE0_ADDR_HI & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC2_QM_CP_MSG_BASE1_ADDR_LO & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC2_QM_CP_MSG_BASE1_ADDR_HI & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC2_QM_CP_MSG_BASE2_ADDR_LO & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC2_QM_CP_MSG_BASE2_ADDR_HI & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC2_QM_CP_MSG_BASE3_ADDR_LO & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC2_QM_CP_MSG_BASE3_ADDR_HI & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC2_QM_CP_LDMA_TSIZE_OFFSET & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC2_QM_CP_LDMA_SRC_BASE_LO_OFFSET & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC2_QM_CP_LDMA_SRC_BASE_HI_OFFSET & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC2_QM_CP_LDMA_DST_BASE_LO_OFFSET & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC2_QM_CP_LDMA_DST_BASE_HI_OFFSET & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC2_QM_CP_LDMA_COMMIT_OFFSET & 0x7F) >> 2);
+
+	WREG32(pb_addr + word_offset, ~mask);
+
+	pb_addr = (mmTPC2_CMDQ_GLBL_CFG0 & ~0xFFF) + PROT_BITS_OFFS;
+	word_offset = ((mmTPC2_CMDQ_GLBL_CFG0 & PROT_BITS_OFFS) >> 7) << 2;
+	mask = 1 << ((mmTPC2_CMDQ_GLBL_CFG0 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC2_CMDQ_GLBL_CFG1 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC2_CMDQ_GLBL_PROT & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC2_CMDQ_GLBL_ERR_CFG & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC2_CMDQ_GLBL_ERR_ADDR_LO & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC2_CMDQ_GLBL_ERR_ADDR_HI & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC2_CMDQ_GLBL_ERR_WDATA & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC2_CMDQ_GLBL_SECURE_PROPS & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC2_CMDQ_GLBL_NON_SECURE_PROPS & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC2_CMDQ_GLBL_STS0 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC2_CMDQ_GLBL_STS1 & 0x7F) >> 2);
+
+	WREG32(pb_addr + word_offset, ~mask);
+
+	pb_addr = (mmTPC2_CMDQ_CQ_CFG0 & ~0xFFF) + PROT_BITS_OFFS;
+	word_offset = ((mmTPC2_CMDQ_CQ_CFG0 & PROT_BITS_OFFS) >> 7) << 2;
+	mask = 1 << ((mmTPC2_CMDQ_CQ_CFG0 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC2_CMDQ_CQ_CFG1 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC2_CMDQ_CQ_ARUSER & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC2_CMDQ_CQ_PTR_LO_STS & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC2_CMDQ_CQ_PTR_HI_STS & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC2_CMDQ_CQ_TSIZE_STS & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC2_CMDQ_CQ_CTL_STS & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC2_CMDQ_CQ_STS0 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC2_CMDQ_CQ_STS1 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC2_CMDQ_CQ_RD_RATE_LIM_EN & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC2_CMDQ_CQ_RD_RATE_LIM_RST_TOKEN & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC2_CMDQ_CQ_RD_RATE_LIM_SAT & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC2_CMDQ_CQ_RD_RATE_LIM_TOUT & 0x7F) >> 2);
+
+	WREG32(pb_addr + word_offset, ~mask);
+
+	pb_addr = (mmTPC2_CMDQ_CQ_IFIFO_CNT & ~0xFFF) + PROT_BITS_OFFS;
+	word_offset = ((mmTPC2_CMDQ_CQ_IFIFO_CNT & PROT_BITS_OFFS) >> 7) << 2;
+	mask = 1 << ((mmTPC2_CMDQ_CQ_IFIFO_CNT & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC2_CMDQ_CP_MSG_BASE0_ADDR_LO & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC2_CMDQ_CP_MSG_BASE0_ADDR_HI & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC2_CMDQ_CP_MSG_BASE1_ADDR_LO & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC2_CMDQ_CP_MSG_BASE1_ADDR_HI & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC2_CMDQ_CP_MSG_BASE2_ADDR_LO & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC2_CMDQ_CP_MSG_BASE2_ADDR_HI & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC2_CMDQ_CP_MSG_BASE3_ADDR_LO & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC2_CMDQ_CP_MSG_BASE3_ADDR_HI & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC2_CMDQ_CP_LDMA_TSIZE_OFFSET & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC2_CMDQ_CP_LDMA_SRC_BASE_LO_OFFSET & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC2_CMDQ_CP_LDMA_SRC_BASE_HI_OFFSET & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC2_CMDQ_CP_LDMA_DST_BASE_LO_OFFSET & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC2_CMDQ_CP_LDMA_DST_BASE_HI_OFFSET & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC2_CMDQ_CP_LDMA_COMMIT_OFFSET & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC2_CMDQ_CP_STS & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC2_CMDQ_CP_CURRENT_INST_LO & 0x7F) >> 2);
+
+	WREG32(pb_addr + word_offset, ~mask);
+
+	pb_addr = (mmTPC2_CMDQ_CP_CURRENT_INST_HI & ~0xFFF) + PROT_BITS_OFFS;
+	word_offset = ((mmTPC2_CMDQ_CP_CURRENT_INST_HI & PROT_BITS_OFFS) >> 7)
+			<< 2;
+	mask = 1 << ((mmTPC2_CMDQ_CP_CURRENT_INST_HI & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC2_CMDQ_CP_BARRIER_CFG & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC2_CMDQ_CP_DBG_0 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC2_CMDQ_CQ_BUF_ADDR & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC2_CMDQ_CQ_BUF_RDATA & 0x7F) >> 2);
+
+	WREG32(pb_addr + word_offset, ~mask);
+
+	goya_pb_set_block(hdev, mmTPC3_RTR_BASE);
+	goya_pb_set_block(hdev, mmTPC3_RD_REGULATOR_BASE);
+	goya_pb_set_block(hdev, mmTPC3_WR_REGULATOR_BASE);
+
+	pb_addr = (mmTPC3_CFG_CFG_BASE_ADDRESS_HIGH & ~0xFFF) + PROT_BITS_OFFS;
+	word_offset = ((mmTPC3_CFG_CFG_BASE_ADDRESS_HIGH
+			& PROT_BITS_OFFS) >> 7) << 2;
+	mask = 1 << ((mmTPC3_CFG_CFG_BASE_ADDRESS_HIGH & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC3_CFG_CFG_SUBTRACT_VALUE & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC3_CFG_SM_BASE_ADDRESS_LOW & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC3_CFG_SM_BASE_ADDRESS_HIGH & 0x7F) >> 2);
+
+	WREG32(pb_addr + word_offset, ~mask);
+
+	pb_addr = (mmTPC3_CFG_ARUSER & ~0xFFF) + PROT_BITS_OFFS;
+	word_offset = ((mmTPC3_CFG_ARUSER & PROT_BITS_OFFS) >> 7) << 2;
+	mask = 1 << ((mmTPC3_CFG_ARUSER & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC3_CFG_AWUSER & 0x7F) >> 2);
+
+	WREG32(pb_addr + word_offset, ~mask);
+
+	pb_addr = (mmTPC3_CFG_FUNC_MBIST_CNTRL & ~0xFFF) + PROT_BITS_OFFS;
+	word_offset = ((mmTPC3_CFG_FUNC_MBIST_CNTRL
+			& PROT_BITS_OFFS) >> 7) << 2;
+	mask = 1 << ((mmTPC3_CFG_FUNC_MBIST_CNTRL & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC3_CFG_FUNC_MBIST_PAT & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC3_CFG_FUNC_MBIST_MEM_0 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC3_CFG_FUNC_MBIST_MEM_1 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC3_CFG_FUNC_MBIST_MEM_2 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC3_CFG_FUNC_MBIST_MEM_3 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC3_CFG_FUNC_MBIST_MEM_4 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC3_CFG_FUNC_MBIST_MEM_5 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC3_CFG_FUNC_MBIST_MEM_6 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC3_CFG_FUNC_MBIST_MEM_7 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC3_CFG_FUNC_MBIST_MEM_8 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC3_CFG_FUNC_MBIST_MEM_9 & 0x7F) >> 2);
+
+	WREG32(pb_addr + word_offset, ~mask);
+
+	pb_addr = (mmTPC3_QM_GLBL_CFG0 & ~0xFFF) + PROT_BITS_OFFS;
+	word_offset = ((mmTPC3_QM_GLBL_CFG0 & PROT_BITS_OFFS) >> 7) << 2;
+	mask = 1 << ((mmTPC3_QM_GLBL_CFG0 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC3_QM_GLBL_CFG1 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC3_QM_GLBL_PROT & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC3_QM_GLBL_ERR_CFG & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC3_QM_GLBL_ERR_ADDR_LO & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC3_QM_GLBL_ERR_ADDR_HI & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC3_QM_GLBL_ERR_WDATA & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC3_QM_GLBL_SECURE_PROPS & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC3_QM_GLBL_NON_SECURE_PROPS & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC3_QM_GLBL_STS0 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC3_QM_GLBL_STS1 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC3_QM_PQ_BASE_LO & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC3_QM_PQ_BASE_HI & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC3_QM_PQ_SIZE & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC3_QM_PQ_PI & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC3_QM_PQ_CI & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC3_QM_PQ_CFG0 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC3_QM_PQ_CFG1 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC3_QM_PQ_ARUSER & 0x7F) >> 2);
+
+	WREG32(pb_addr + word_offset, ~mask);
+
+	pb_addr = (mmTPC3_QM_PQ_PUSH0 & ~0xFFF) + PROT_BITS_OFFS;
+	word_offset = ((mmTPC3_QM_PQ_PUSH0 & PROT_BITS_OFFS) >> 7) << 2;
+	mask = 1 << ((mmTPC3_QM_PQ_PUSH0 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC3_QM_PQ_PUSH1 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC3_QM_PQ_PUSH2 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC3_QM_PQ_PUSH3 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC3_QM_PQ_STS0 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC3_QM_PQ_STS1 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC3_QM_PQ_RD_RATE_LIM_EN & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC3_QM_PQ_RD_RATE_LIM_RST_TOKEN & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC3_QM_PQ_RD_RATE_LIM_SAT & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC3_QM_PQ_RD_RATE_LIM_TOUT & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC3_QM_CQ_CFG0 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC3_QM_CQ_CFG1 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC3_QM_CQ_ARUSER & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC3_QM_CQ_PTR_LO & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC3_QM_CQ_PTR_HI & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC3_QM_CQ_TSIZE & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC3_QM_CQ_CTL & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC3_QM_CQ_PTR_LO_STS & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC3_QM_CQ_PTR_HI_STS & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC3_QM_CQ_TSIZE_STS & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC3_QM_CQ_CTL_STS & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC3_QM_CQ_STS0 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC3_QM_CQ_STS1 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC3_QM_CQ_RD_RATE_LIM_EN & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC3_QM_CQ_RD_RATE_LIM_RST_TOKEN & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC3_QM_CQ_RD_RATE_LIM_SAT & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC3_QM_CQ_RD_RATE_LIM_TOUT & 0x7F) >> 2);
+
+	WREG32(pb_addr + word_offset, ~mask);
+
+	pb_addr = (mmTPC3_QM_CQ_IFIFO_CNT & ~0xFFF) + PROT_BITS_OFFS;
+	word_offset = ((mmTPC3_QM_CQ_IFIFO_CNT & PROT_BITS_OFFS) >> 7) << 2;
+	mask = 1 << ((mmTPC3_QM_CQ_IFIFO_CNT & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC3_QM_CP_MSG_BASE0_ADDR_LO & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC3_QM_CP_MSG_BASE0_ADDR_HI & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC3_QM_CP_MSG_BASE1_ADDR_LO & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC3_QM_CP_MSG_BASE1_ADDR_HI & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC3_QM_CP_MSG_BASE2_ADDR_LO & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC3_QM_CP_MSG_BASE2_ADDR_HI & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC3_QM_CP_MSG_BASE3_ADDR_LO & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC3_QM_CP_MSG_BASE3_ADDR_HI & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC3_QM_CP_LDMA_TSIZE_OFFSET & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC3_QM_CP_LDMA_SRC_BASE_LO_OFFSET & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC3_QM_CP_LDMA_SRC_BASE_HI_OFFSET & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC3_QM_CP_LDMA_DST_BASE_LO_OFFSET & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC3_QM_CP_LDMA_DST_BASE_HI_OFFSET & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC3_QM_CP_LDMA_COMMIT_OFFSET & 0x7F) >> 2);
+
+	WREG32(pb_addr + word_offset, ~mask);
+
+	pb_addr = (mmTPC3_CMDQ_GLBL_CFG0 & ~0xFFF) + PROT_BITS_OFFS;
+	word_offset = ((mmTPC3_CMDQ_GLBL_CFG0 & PROT_BITS_OFFS) >> 7) << 2;
+	mask = 1 << ((mmTPC3_CMDQ_GLBL_CFG0 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC3_CMDQ_GLBL_CFG1 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC3_CMDQ_GLBL_PROT & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC3_CMDQ_GLBL_ERR_CFG & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC3_CMDQ_GLBL_ERR_ADDR_LO & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC3_CMDQ_GLBL_ERR_ADDR_HI & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC3_CMDQ_GLBL_ERR_WDATA & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC3_CMDQ_GLBL_SECURE_PROPS & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC3_CMDQ_GLBL_NON_SECURE_PROPS & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC3_CMDQ_GLBL_STS0 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC3_CMDQ_GLBL_STS1 & 0x7F) >> 2);
+
+	WREG32(pb_addr + word_offset, ~mask);
+
+	pb_addr = (mmTPC3_CMDQ_CQ_CFG0 & ~0xFFF) + PROT_BITS_OFFS;
+	word_offset = ((mmTPC3_CMDQ_CQ_CFG0 & PROT_BITS_OFFS) >> 7) << 2;
+	mask = 1 << ((mmTPC3_CMDQ_CQ_CFG0 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC3_CMDQ_CQ_CFG1 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC3_CMDQ_CQ_ARUSER & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC3_CMDQ_CQ_PTR_LO_STS & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC3_CMDQ_CQ_PTR_HI_STS & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC3_CMDQ_CQ_TSIZE_STS & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC3_CMDQ_CQ_CTL_STS & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC3_CMDQ_CQ_STS0 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC3_CMDQ_CQ_STS1 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC3_CMDQ_CQ_RD_RATE_LIM_EN & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC3_CMDQ_CQ_RD_RATE_LIM_RST_TOKEN & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC3_CMDQ_CQ_RD_RATE_LIM_SAT & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC3_CMDQ_CQ_RD_RATE_LIM_TOUT & 0x7F) >> 2);
+
+	WREG32(pb_addr + word_offset, ~mask);
+
+	pb_addr = (mmTPC3_CMDQ_CQ_IFIFO_CNT & ~0xFFF) + PROT_BITS_OFFS;
+	word_offset = ((mmTPC3_CMDQ_CQ_IFIFO_CNT & PROT_BITS_OFFS) >> 7) << 2;
+	mask = 1 << ((mmTPC3_CMDQ_CQ_IFIFO_CNT & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC3_CMDQ_CP_MSG_BASE0_ADDR_LO & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC3_CMDQ_CP_MSG_BASE0_ADDR_HI & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC3_CMDQ_CP_MSG_BASE1_ADDR_LO & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC3_CMDQ_CP_MSG_BASE1_ADDR_HI & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC3_CMDQ_CP_MSG_BASE2_ADDR_LO & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC3_CMDQ_CP_MSG_BASE2_ADDR_HI & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC3_CMDQ_CP_MSG_BASE3_ADDR_LO & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC3_CMDQ_CP_MSG_BASE3_ADDR_HI & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC3_CMDQ_CP_LDMA_TSIZE_OFFSET & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC3_CMDQ_CP_LDMA_SRC_BASE_LO_OFFSET & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC3_CMDQ_CP_LDMA_SRC_BASE_HI_OFFSET & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC3_CMDQ_CP_LDMA_DST_BASE_LO_OFFSET & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC3_CMDQ_CP_LDMA_DST_BASE_HI_OFFSET & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC3_CMDQ_CP_LDMA_COMMIT_OFFSET & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC3_CMDQ_CP_STS & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC3_CMDQ_CP_CURRENT_INST_LO & 0x7F) >> 2);
+
+	WREG32(pb_addr + word_offset, ~mask);
+
+	pb_addr = (mmTPC3_CMDQ_CP_CURRENT_INST_HI & ~0xFFF) + PROT_BITS_OFFS;
+	word_offset = ((mmTPC3_CMDQ_CP_CURRENT_INST_HI & PROT_BITS_OFFS) >> 7)
+			<< 2;
+	mask = 1 << ((mmTPC3_CMDQ_CP_CURRENT_INST_HI & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC3_CMDQ_CP_BARRIER_CFG & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC3_CMDQ_CP_DBG_0 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC3_CMDQ_CQ_BUF_ADDR & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC3_CMDQ_CQ_BUF_RDATA & 0x7F) >> 2);
+
+	WREG32(pb_addr + word_offset, ~mask);
+
+	goya_pb_set_block(hdev, mmTPC4_RTR_BASE);
+	goya_pb_set_block(hdev, mmTPC4_RD_REGULATOR_BASE);
+	goya_pb_set_block(hdev, mmTPC4_WR_REGULATOR_BASE);
+
+	pb_addr = (mmTPC4_CFG_CFG_BASE_ADDRESS_HIGH & ~0xFFF) + PROT_BITS_OFFS;
+	word_offset = ((mmTPC4_CFG_CFG_BASE_ADDRESS_HIGH &
+			PROT_BITS_OFFS) >> 7) << 2;
+	mask = 1 << ((mmTPC4_CFG_CFG_BASE_ADDRESS_HIGH & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC4_CFG_CFG_SUBTRACT_VALUE & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC4_CFG_SM_BASE_ADDRESS_LOW & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC4_CFG_SM_BASE_ADDRESS_HIGH & 0x7F) >> 2);
+
+	WREG32(pb_addr + word_offset, ~mask);
+
+	pb_addr = (mmTPC4_CFG_ARUSER & ~0xFFF) + PROT_BITS_OFFS;
+	word_offset = ((mmTPC4_CFG_ARUSER & PROT_BITS_OFFS) >> 7) << 2;
+	mask = 1 << ((mmTPC4_CFG_ARUSER & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC4_CFG_AWUSER & 0x7F) >> 2);
+
+	WREG32(pb_addr + word_offset, ~mask);
+
+	pb_addr = (mmTPC4_CFG_FUNC_MBIST_CNTRL & ~0xFFF) + PROT_BITS_OFFS;
+	word_offset = ((mmTPC4_CFG_FUNC_MBIST_CNTRL &
+			PROT_BITS_OFFS) >> 7) << 2;
+	mask = 1 << ((mmTPC4_CFG_FUNC_MBIST_CNTRL & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC4_CFG_FUNC_MBIST_PAT & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC4_CFG_FUNC_MBIST_MEM_0 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC4_CFG_FUNC_MBIST_MEM_1 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC4_CFG_FUNC_MBIST_MEM_2 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC4_CFG_FUNC_MBIST_MEM_3 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC4_CFG_FUNC_MBIST_MEM_4 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC4_CFG_FUNC_MBIST_MEM_5 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC4_CFG_FUNC_MBIST_MEM_6 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC4_CFG_FUNC_MBIST_MEM_7 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC4_CFG_FUNC_MBIST_MEM_8 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC4_CFG_FUNC_MBIST_MEM_9 & 0x7F) >> 2);
+
+	WREG32(pb_addr + word_offset, ~mask);
+
+	pb_addr = (mmTPC4_QM_GLBL_CFG0 & ~0xFFF) + PROT_BITS_OFFS;
+	word_offset = ((mmTPC4_QM_GLBL_CFG0 & PROT_BITS_OFFS) >> 7) << 2;
+	mask = 1 << ((mmTPC4_QM_GLBL_CFG0 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC4_QM_GLBL_CFG1 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC4_QM_GLBL_PROT & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC4_QM_GLBL_ERR_CFG & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC4_QM_GLBL_ERR_ADDR_LO & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC4_QM_GLBL_ERR_ADDR_HI & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC4_QM_GLBL_ERR_WDATA & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC4_QM_GLBL_SECURE_PROPS & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC4_QM_GLBL_NON_SECURE_PROPS & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC4_QM_GLBL_STS0 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC4_QM_GLBL_STS1 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC4_QM_PQ_BASE_LO & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC4_QM_PQ_BASE_HI & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC4_QM_PQ_SIZE & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC4_QM_PQ_PI & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC4_QM_PQ_CI & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC4_QM_PQ_CFG0 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC4_QM_PQ_CFG1 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC4_QM_PQ_ARUSER & 0x7F) >> 2);
+
+	WREG32(pb_addr + word_offset, ~mask);
+
+	pb_addr = (mmTPC4_QM_PQ_PUSH0 & ~0xFFF) + PROT_BITS_OFFS;
+	word_offset = ((mmTPC4_QM_PQ_PUSH0 & PROT_BITS_OFFS) >> 7) << 2;
+	mask = 1 << ((mmTPC4_QM_PQ_PUSH0 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC4_QM_PQ_PUSH1 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC4_QM_PQ_PUSH2 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC4_QM_PQ_PUSH3 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC4_QM_PQ_STS0 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC4_QM_PQ_STS1 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC4_QM_PQ_RD_RATE_LIM_EN & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC4_QM_PQ_RD_RATE_LIM_RST_TOKEN & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC4_QM_PQ_RD_RATE_LIM_SAT & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC4_QM_PQ_RD_RATE_LIM_TOUT & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC4_QM_CQ_CFG0 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC4_QM_CQ_CFG1 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC4_QM_CQ_ARUSER & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC4_QM_CQ_PTR_LO & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC4_QM_CQ_PTR_HI & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC4_QM_CQ_TSIZE & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC4_QM_CQ_CTL & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC4_QM_CQ_PTR_LO_STS & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC4_QM_CQ_PTR_HI_STS & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC4_QM_CQ_TSIZE_STS & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC4_QM_CQ_CTL_STS & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC4_QM_CQ_STS0 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC4_QM_CQ_STS1 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC4_QM_CQ_RD_RATE_LIM_EN & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC4_QM_CQ_RD_RATE_LIM_RST_TOKEN & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC4_QM_CQ_RD_RATE_LIM_SAT & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC4_QM_CQ_RD_RATE_LIM_TOUT & 0x7F) >> 2);
+
+	WREG32(pb_addr + word_offset, ~mask);
+
+	pb_addr = (mmTPC4_QM_CQ_IFIFO_CNT & ~0xFFF) + PROT_BITS_OFFS;
+	word_offset = ((mmTPC4_QM_CQ_IFIFO_CNT & PROT_BITS_OFFS) >> 7) << 2;
+	mask = 1 << ((mmTPC4_QM_CQ_IFIFO_CNT & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC4_QM_CP_MSG_BASE0_ADDR_LO & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC4_QM_CP_MSG_BASE0_ADDR_HI & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC4_QM_CP_MSG_BASE1_ADDR_LO & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC4_QM_CP_MSG_BASE1_ADDR_HI & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC4_QM_CP_MSG_BASE2_ADDR_LO & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC4_QM_CP_MSG_BASE2_ADDR_HI & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC4_QM_CP_MSG_BASE3_ADDR_LO & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC4_QM_CP_MSG_BASE3_ADDR_HI & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC4_QM_CP_LDMA_TSIZE_OFFSET & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC4_QM_CP_LDMA_SRC_BASE_LO_OFFSET & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC4_QM_CP_LDMA_SRC_BASE_HI_OFFSET & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC4_QM_CP_LDMA_DST_BASE_LO_OFFSET & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC4_QM_CP_LDMA_DST_BASE_HI_OFFSET & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC4_QM_CP_LDMA_COMMIT_OFFSET & 0x7F) >> 2);
+
+	WREG32(pb_addr + word_offset, ~mask);
+
+	pb_addr = (mmTPC4_CMDQ_GLBL_CFG0 & ~0xFFF) + PROT_BITS_OFFS;
+	word_offset = ((mmTPC4_CMDQ_GLBL_CFG0 & PROT_BITS_OFFS) >> 7) << 2;
+	mask = 1 << ((mmTPC4_CMDQ_GLBL_CFG0 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC4_CMDQ_GLBL_CFG1 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC4_CMDQ_GLBL_PROT & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC4_CMDQ_GLBL_ERR_CFG & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC4_CMDQ_GLBL_ERR_ADDR_LO & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC4_CMDQ_GLBL_ERR_ADDR_HI & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC4_CMDQ_GLBL_ERR_WDATA & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC4_CMDQ_GLBL_SECURE_PROPS & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC4_CMDQ_GLBL_NON_SECURE_PROPS & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC4_CMDQ_GLBL_STS0 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC4_CMDQ_GLBL_STS1 & 0x7F) >> 2);
+
+	WREG32(pb_addr + word_offset, ~mask);
+
+	pb_addr = (mmTPC4_CMDQ_CQ_CFG0 & ~0xFFF) + PROT_BITS_OFFS;
+	word_offset = ((mmTPC4_CMDQ_CQ_CFG0 & PROT_BITS_OFFS) >> 7) << 2;
+	mask = 1 << ((mmTPC4_CMDQ_CQ_CFG0 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC4_CMDQ_CQ_CFG1 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC4_CMDQ_CQ_ARUSER & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC4_CMDQ_CQ_PTR_LO_STS & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC4_CMDQ_CQ_PTR_HI_STS & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC4_CMDQ_CQ_TSIZE_STS & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC4_CMDQ_CQ_CTL_STS & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC4_CMDQ_CQ_STS0 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC4_CMDQ_CQ_STS1 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC4_CMDQ_CQ_RD_RATE_LIM_EN & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC4_CMDQ_CQ_RD_RATE_LIM_RST_TOKEN & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC4_CMDQ_CQ_RD_RATE_LIM_SAT & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC4_CMDQ_CQ_RD_RATE_LIM_TOUT & 0x7F) >> 2);
+
+	WREG32(pb_addr + word_offset, ~mask);
+
+	pb_addr = (mmTPC4_CMDQ_CQ_IFIFO_CNT & ~0xFFF) + PROT_BITS_OFFS;
+	word_offset = ((mmTPC4_CMDQ_CQ_IFIFO_CNT & PROT_BITS_OFFS) >> 7) << 2;
+	mask = 1 << ((mmTPC4_CMDQ_CQ_IFIFO_CNT & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC4_CMDQ_CP_MSG_BASE0_ADDR_LO & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC4_CMDQ_CP_MSG_BASE0_ADDR_HI & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC4_CMDQ_CP_MSG_BASE1_ADDR_LO & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC4_CMDQ_CP_MSG_BASE1_ADDR_HI & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC4_CMDQ_CP_MSG_BASE2_ADDR_LO & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC4_CMDQ_CP_MSG_BASE2_ADDR_HI & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC4_CMDQ_CP_MSG_BASE3_ADDR_LO & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC4_CMDQ_CP_MSG_BASE3_ADDR_HI & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC4_CMDQ_CP_LDMA_TSIZE_OFFSET & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC4_CMDQ_CP_LDMA_SRC_BASE_LO_OFFSET & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC4_CMDQ_CP_LDMA_SRC_BASE_HI_OFFSET & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC4_CMDQ_CP_LDMA_DST_BASE_LO_OFFSET & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC4_CMDQ_CP_LDMA_DST_BASE_HI_OFFSET & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC4_CMDQ_CP_LDMA_COMMIT_OFFSET & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC4_CMDQ_CP_STS & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC4_CMDQ_CP_CURRENT_INST_LO & 0x7F) >> 2);
+
+	WREG32(pb_addr + word_offset, ~mask);
+
+	pb_addr = (mmTPC4_CMDQ_CP_CURRENT_INST_HI & ~0xFFF) + PROT_BITS_OFFS;
+	word_offset = ((mmTPC4_CMDQ_CP_CURRENT_INST_HI & PROT_BITS_OFFS) >> 7)
+			<< 2;
+	mask = 1 << ((mmTPC4_CMDQ_CP_CURRENT_INST_HI & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC4_CMDQ_CP_BARRIER_CFG & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC4_CMDQ_CP_DBG_0 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC4_CMDQ_CQ_BUF_ADDR & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC4_CMDQ_CQ_BUF_RDATA & 0x7F) >> 2);
+
+	WREG32(pb_addr + word_offset, ~mask);
+
+	goya_pb_set_block(hdev, mmTPC5_RTR_BASE);
+	goya_pb_set_block(hdev, mmTPC5_RD_REGULATOR_BASE);
+	goya_pb_set_block(hdev, mmTPC5_WR_REGULATOR_BASE);
+
+	pb_addr = (mmTPC5_CFG_CFG_BASE_ADDRESS_HIGH & ~0xFFF) + PROT_BITS_OFFS;
+	word_offset = ((mmTPC5_CFG_CFG_BASE_ADDRESS_HIGH &
+			PROT_BITS_OFFS) >> 7) << 2;
+	mask = 1 << ((mmTPC5_CFG_CFG_BASE_ADDRESS_HIGH & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC5_CFG_CFG_SUBTRACT_VALUE & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC5_CFG_SM_BASE_ADDRESS_LOW & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC5_CFG_SM_BASE_ADDRESS_HIGH & 0x7F) >> 2);
+
+	WREG32(pb_addr + word_offset, ~mask);
+
+	pb_addr = (mmTPC5_CFG_ARUSER & ~0xFFF) + PROT_BITS_OFFS;
+	word_offset = ((mmTPC5_CFG_ARUSER & PROT_BITS_OFFS) >> 7) << 2;
+	mask = 1 << ((mmTPC5_CFG_ARUSER & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC5_CFG_AWUSER & 0x7F) >> 2);
+
+	WREG32(pb_addr + word_offset, ~mask);
+
+	pb_addr = (mmTPC5_CFG_FUNC_MBIST_CNTRL & ~0xFFF) + PROT_BITS_OFFS;
+	word_offset = ((mmTPC5_CFG_FUNC_MBIST_CNTRL &
+			PROT_BITS_OFFS) >> 7) << 2;
+	mask = 1 << ((mmTPC5_CFG_FUNC_MBIST_CNTRL & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC5_CFG_FUNC_MBIST_PAT & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC5_CFG_FUNC_MBIST_MEM_0 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC5_CFG_FUNC_MBIST_MEM_1 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC5_CFG_FUNC_MBIST_MEM_2 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC5_CFG_FUNC_MBIST_MEM_3 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC5_CFG_FUNC_MBIST_MEM_4 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC5_CFG_FUNC_MBIST_MEM_5 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC5_CFG_FUNC_MBIST_MEM_6 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC5_CFG_FUNC_MBIST_MEM_7 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC5_CFG_FUNC_MBIST_MEM_8 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC5_CFG_FUNC_MBIST_MEM_9 & 0x7F) >> 2);
+
+	WREG32(pb_addr + word_offset, ~mask);
+
+	pb_addr = (mmTPC5_QM_GLBL_CFG0 & ~0xFFF) + PROT_BITS_OFFS;
+	word_offset = ((mmTPC5_QM_GLBL_CFG0 & PROT_BITS_OFFS) >> 7) << 2;
+	mask = 1 << ((mmTPC5_QM_GLBL_CFG0 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC5_QM_GLBL_CFG1 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC5_QM_GLBL_PROT & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC5_QM_GLBL_ERR_CFG & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC5_QM_GLBL_ERR_ADDR_LO & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC5_QM_GLBL_ERR_ADDR_HI & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC5_QM_GLBL_ERR_WDATA & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC5_QM_GLBL_SECURE_PROPS & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC5_QM_GLBL_NON_SECURE_PROPS & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC5_QM_GLBL_STS0 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC5_QM_GLBL_STS1 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC5_QM_PQ_BASE_LO & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC5_QM_PQ_BASE_HI & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC5_QM_PQ_SIZE & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC5_QM_PQ_PI & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC5_QM_PQ_CI & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC5_QM_PQ_CFG0 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC5_QM_PQ_CFG1 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC5_QM_PQ_ARUSER & 0x7F) >> 2);
+
+	WREG32(pb_addr + word_offset, ~mask);
+
+	pb_addr = (mmTPC5_QM_PQ_PUSH0 & ~0xFFF) + PROT_BITS_OFFS;
+	word_offset = ((mmTPC5_QM_PQ_PUSH0 & PROT_BITS_OFFS) >> 7) << 2;
+	mask = 1 << ((mmTPC5_QM_PQ_PUSH0 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC5_QM_PQ_PUSH1 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC5_QM_PQ_PUSH2 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC5_QM_PQ_PUSH3 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC5_QM_PQ_STS0 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC5_QM_PQ_STS1 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC5_QM_PQ_RD_RATE_LIM_EN & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC5_QM_PQ_RD_RATE_LIM_RST_TOKEN & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC5_QM_PQ_RD_RATE_LIM_SAT & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC5_QM_PQ_RD_RATE_LIM_TOUT & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC5_QM_CQ_CFG0 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC5_QM_CQ_CFG1 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC5_QM_CQ_ARUSER & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC5_QM_CQ_PTR_LO & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC5_QM_CQ_PTR_HI & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC5_QM_CQ_TSIZE & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC5_QM_CQ_CTL & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC5_QM_CQ_PTR_LO_STS & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC5_QM_CQ_PTR_HI_STS & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC5_QM_CQ_TSIZE_STS & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC5_QM_CQ_CTL_STS & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC5_QM_CQ_STS0 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC5_QM_CQ_STS1 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC5_QM_CQ_RD_RATE_LIM_EN & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC5_QM_CQ_RD_RATE_LIM_RST_TOKEN & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC5_QM_CQ_RD_RATE_LIM_SAT & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC5_QM_CQ_RD_RATE_LIM_TOUT & 0x7F) >> 2);
+
+	WREG32(pb_addr + word_offset, ~mask);
+
+	pb_addr = (mmTPC5_QM_CQ_IFIFO_CNT & ~0xFFF) + PROT_BITS_OFFS;
+	word_offset = ((mmTPC5_QM_CQ_IFIFO_CNT & PROT_BITS_OFFS) >> 7) << 2;
+	mask = 1 << ((mmTPC5_QM_CQ_IFIFO_CNT & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC5_QM_CP_MSG_BASE0_ADDR_LO & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC5_QM_CP_MSG_BASE0_ADDR_HI & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC5_QM_CP_MSG_BASE1_ADDR_LO & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC5_QM_CP_MSG_BASE1_ADDR_HI & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC5_QM_CP_MSG_BASE2_ADDR_LO & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC5_QM_CP_MSG_BASE2_ADDR_HI & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC5_QM_CP_MSG_BASE3_ADDR_LO & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC5_QM_CP_MSG_BASE3_ADDR_HI & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC5_QM_CP_LDMA_TSIZE_OFFSET & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC5_QM_CP_LDMA_SRC_BASE_LO_OFFSET & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC5_QM_CP_LDMA_SRC_BASE_HI_OFFSET & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC5_QM_CP_LDMA_DST_BASE_LO_OFFSET & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC5_QM_CP_LDMA_DST_BASE_HI_OFFSET & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC5_QM_CP_LDMA_COMMIT_OFFSET & 0x7F) >> 2);
+
+	WREG32(pb_addr + word_offset, ~mask);
+
+	pb_addr = (mmTPC5_CMDQ_GLBL_CFG0 & ~0xFFF) + PROT_BITS_OFFS;
+	word_offset = ((mmTPC5_CMDQ_GLBL_CFG0 & PROT_BITS_OFFS) >> 7) << 2;
+	mask = 1 << ((mmTPC5_CMDQ_GLBL_CFG0 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC5_CMDQ_GLBL_CFG1 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC5_CMDQ_GLBL_PROT & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC5_CMDQ_GLBL_ERR_CFG & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC5_CMDQ_GLBL_ERR_ADDR_LO & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC5_CMDQ_GLBL_ERR_ADDR_HI & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC5_CMDQ_GLBL_ERR_WDATA & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC5_CMDQ_GLBL_SECURE_PROPS & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC5_CMDQ_GLBL_NON_SECURE_PROPS & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC5_CMDQ_GLBL_STS0 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC5_CMDQ_GLBL_STS1 & 0x7F) >> 2);
+
+	WREG32(pb_addr + word_offset, ~mask);
+
+	pb_addr = (mmTPC5_CMDQ_CQ_CFG0 & ~0xFFF) + PROT_BITS_OFFS;
+	word_offset = ((mmTPC5_CMDQ_CQ_CFG0 & PROT_BITS_OFFS) >> 7) << 2;
+	mask = 1 << ((mmTPC5_CMDQ_CQ_CFG0 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC5_CMDQ_CQ_CFG1 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC5_CMDQ_CQ_ARUSER & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC5_CMDQ_CQ_PTR_LO_STS & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC5_CMDQ_CQ_PTR_HI_STS & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC5_CMDQ_CQ_TSIZE_STS & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC5_CMDQ_CQ_CTL_STS & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC5_CMDQ_CQ_STS0 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC5_CMDQ_CQ_STS1 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC5_CMDQ_CQ_RD_RATE_LIM_EN & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC5_CMDQ_CQ_RD_RATE_LIM_RST_TOKEN & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC5_CMDQ_CQ_RD_RATE_LIM_SAT & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC5_CMDQ_CQ_RD_RATE_LIM_TOUT & 0x7F) >> 2);
+
+	WREG32(pb_addr + word_offset, ~mask);
+
+	pb_addr = (mmTPC5_CMDQ_CQ_IFIFO_CNT & ~0xFFF) + PROT_BITS_OFFS;
+	word_offset = ((mmTPC5_CMDQ_CQ_IFIFO_CNT & PROT_BITS_OFFS) >> 7) << 2;
+	mask = 1 << ((mmTPC5_CMDQ_CQ_IFIFO_CNT & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC5_CMDQ_CP_MSG_BASE0_ADDR_LO & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC5_CMDQ_CP_MSG_BASE0_ADDR_HI & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC5_CMDQ_CP_MSG_BASE1_ADDR_LO & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC5_CMDQ_CP_MSG_BASE1_ADDR_HI & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC5_CMDQ_CP_MSG_BASE2_ADDR_LO & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC5_CMDQ_CP_MSG_BASE2_ADDR_HI & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC5_CMDQ_CP_MSG_BASE3_ADDR_LO & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC5_CMDQ_CP_MSG_BASE3_ADDR_HI & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC5_CMDQ_CP_LDMA_TSIZE_OFFSET & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC5_CMDQ_CP_LDMA_SRC_BASE_LO_OFFSET & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC5_CMDQ_CP_LDMA_SRC_BASE_HI_OFFSET & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC5_CMDQ_CP_LDMA_DST_BASE_LO_OFFSET & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC5_CMDQ_CP_LDMA_DST_BASE_HI_OFFSET & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC5_CMDQ_CP_LDMA_COMMIT_OFFSET & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC5_CMDQ_CP_STS & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC5_CMDQ_CP_CURRENT_INST_LO & 0x7F) >> 2);
+
+	WREG32(pb_addr + word_offset, ~mask);
+
+	pb_addr = (mmTPC5_CMDQ_CP_CURRENT_INST_HI & ~0xFFF) + PROT_BITS_OFFS;
+	word_offset = ((mmTPC5_CMDQ_CP_CURRENT_INST_HI & PROT_BITS_OFFS) >> 7)
+			<< 2;
+	mask = 1 << ((mmTPC5_CMDQ_CP_CURRENT_INST_HI & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC5_CMDQ_CP_BARRIER_CFG & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC5_CMDQ_CP_DBG_0 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC5_CMDQ_CQ_BUF_ADDR & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC5_CMDQ_CQ_BUF_RDATA & 0x7F) >> 2);
+
+	WREG32(pb_addr + word_offset, ~mask);
+
+	goya_pb_set_block(hdev, mmTPC6_RTR_BASE);
+	goya_pb_set_block(hdev, mmTPC6_RD_REGULATOR_BASE);
+	goya_pb_set_block(hdev, mmTPC6_WR_REGULATOR_BASE);
+
+	pb_addr = (mmTPC6_CFG_CFG_BASE_ADDRESS_HIGH & ~0xFFF) + PROT_BITS_OFFS;
+	word_offset = ((mmTPC6_CFG_CFG_BASE_ADDRESS_HIGH &
+			PROT_BITS_OFFS) >> 7) << 2;
+	mask = 1 << ((mmTPC6_CFG_CFG_BASE_ADDRESS_HIGH & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC6_CFG_CFG_SUBTRACT_VALUE & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC6_CFG_SM_BASE_ADDRESS_LOW & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC6_CFG_SM_BASE_ADDRESS_HIGH & 0x7F) >> 2);
+
+	WREG32(pb_addr + word_offset, ~mask);
+
+	pb_addr = (mmTPC6_CFG_ARUSER & ~0xFFF) + PROT_BITS_OFFS;
+	word_offset = ((mmTPC6_CFG_ARUSER & PROT_BITS_OFFS) >> 7) << 2;
+	mask = 1 << ((mmTPC6_CFG_ARUSER & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC6_CFG_AWUSER & 0x7F) >> 2);
+
+	WREG32(pb_addr + word_offset, ~mask);
+
+	pb_addr = (mmTPC6_CFG_FUNC_MBIST_CNTRL & ~0xFFF) + PROT_BITS_OFFS;
+	word_offset = ((mmTPC6_CFG_FUNC_MBIST_CNTRL &
+			PROT_BITS_OFFS) >> 7) << 2;
+	mask = 1 << ((mmTPC6_CFG_FUNC_MBIST_CNTRL & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC6_CFG_FUNC_MBIST_PAT & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC6_CFG_FUNC_MBIST_MEM_0 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC6_CFG_FUNC_MBIST_MEM_1 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC6_CFG_FUNC_MBIST_MEM_2 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC6_CFG_FUNC_MBIST_MEM_3 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC6_CFG_FUNC_MBIST_MEM_4 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC6_CFG_FUNC_MBIST_MEM_5 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC6_CFG_FUNC_MBIST_MEM_6 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC6_CFG_FUNC_MBIST_MEM_7 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC6_CFG_FUNC_MBIST_MEM_8 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC6_CFG_FUNC_MBIST_MEM_9 & 0x7F) >> 2);
+
+	WREG32(pb_addr + word_offset, ~mask);
+
+	pb_addr = (mmTPC6_QM_GLBL_CFG0 & ~0xFFF) + PROT_BITS_OFFS;
+	word_offset = ((mmTPC6_QM_GLBL_CFG0 & PROT_BITS_OFFS) >> 7) << 2;
+	mask = 1 << ((mmTPC6_QM_GLBL_CFG0 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC6_QM_GLBL_CFG1 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC6_QM_GLBL_PROT & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC6_QM_GLBL_ERR_CFG & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC6_QM_GLBL_ERR_ADDR_LO & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC6_QM_GLBL_ERR_ADDR_HI & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC6_QM_GLBL_ERR_WDATA & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC6_QM_GLBL_SECURE_PROPS & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC6_QM_GLBL_NON_SECURE_PROPS & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC6_QM_GLBL_STS0 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC6_QM_GLBL_STS1 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC6_QM_PQ_BASE_LO & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC6_QM_PQ_BASE_HI & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC6_QM_PQ_SIZE & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC6_QM_PQ_PI & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC6_QM_PQ_CI & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC6_QM_PQ_CFG0 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC6_QM_PQ_CFG1 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC6_QM_PQ_ARUSER & 0x7F) >> 2);
+
+	WREG32(pb_addr + word_offset, ~mask);
+
+	pb_addr = (mmTPC6_QM_PQ_PUSH0 & ~0xFFF) + PROT_BITS_OFFS;
+	word_offset = ((mmTPC6_QM_PQ_PUSH0 & PROT_BITS_OFFS) >> 7) << 2;
+	mask = 1 << ((mmTPC6_QM_PQ_PUSH0 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC6_QM_PQ_PUSH1 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC6_QM_PQ_PUSH2 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC6_QM_PQ_PUSH3 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC6_QM_PQ_STS0 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC6_QM_PQ_STS1 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC6_QM_PQ_RD_RATE_LIM_EN & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC6_QM_PQ_RD_RATE_LIM_RST_TOKEN & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC6_QM_PQ_RD_RATE_LIM_SAT & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC6_QM_PQ_RD_RATE_LIM_TOUT & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC6_QM_CQ_CFG0 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC6_QM_CQ_CFG1 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC6_QM_CQ_ARUSER & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC6_QM_CQ_PTR_LO & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC6_QM_CQ_PTR_HI & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC6_QM_CQ_TSIZE & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC6_QM_CQ_CTL & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC6_QM_CQ_PTR_LO_STS & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC6_QM_CQ_PTR_HI_STS & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC6_QM_CQ_TSIZE_STS & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC6_QM_CQ_CTL_STS & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC6_QM_CQ_STS0 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC6_QM_CQ_STS1 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC6_QM_CQ_RD_RATE_LIM_EN & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC6_QM_CQ_RD_RATE_LIM_RST_TOKEN & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC6_QM_CQ_RD_RATE_LIM_SAT & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC6_QM_CQ_RD_RATE_LIM_TOUT & 0x7F) >> 2);
+
+	WREG32(pb_addr + word_offset, ~mask);
+
+	pb_addr = (mmTPC6_QM_CQ_IFIFO_CNT & ~0xFFF) + PROT_BITS_OFFS;
+	word_offset = ((mmTPC6_QM_CQ_IFIFO_CNT & PROT_BITS_OFFS) >> 7) << 2;
+	mask = 1 << ((mmTPC6_QM_CQ_IFIFO_CNT & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC6_QM_CP_MSG_BASE0_ADDR_LO & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC6_QM_CP_MSG_BASE0_ADDR_HI & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC6_QM_CP_MSG_BASE1_ADDR_LO & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC6_QM_CP_MSG_BASE1_ADDR_HI & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC6_QM_CP_MSG_BASE2_ADDR_LO & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC6_QM_CP_MSG_BASE2_ADDR_HI & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC6_QM_CP_MSG_BASE3_ADDR_LO & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC6_QM_CP_MSG_BASE3_ADDR_HI & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC6_QM_CP_LDMA_TSIZE_OFFSET & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC6_QM_CP_LDMA_SRC_BASE_LO_OFFSET & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC6_QM_CP_LDMA_SRC_BASE_HI_OFFSET & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC6_QM_CP_LDMA_DST_BASE_LO_OFFSET & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC6_QM_CP_LDMA_DST_BASE_HI_OFFSET & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC6_QM_CP_LDMA_COMMIT_OFFSET & 0x7F) >> 2);
+
+	WREG32(pb_addr + word_offset, ~mask);
+
+	pb_addr = (mmTPC6_CMDQ_GLBL_CFG0 & ~0xFFF) + PROT_BITS_OFFS;
+	word_offset = ((mmTPC6_CMDQ_GLBL_CFG0 & PROT_BITS_OFFS) >> 7) << 2;
+	mask = 1 << ((mmTPC6_CMDQ_GLBL_CFG0 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC6_CMDQ_GLBL_CFG1 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC6_CMDQ_GLBL_PROT & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC6_CMDQ_GLBL_ERR_CFG & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC6_CMDQ_GLBL_ERR_ADDR_LO & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC6_CMDQ_GLBL_ERR_ADDR_HI & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC6_CMDQ_GLBL_ERR_WDATA & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC6_CMDQ_GLBL_SECURE_PROPS & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC6_CMDQ_GLBL_NON_SECURE_PROPS & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC6_CMDQ_GLBL_STS0 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC6_CMDQ_GLBL_STS1 & 0x7F) >> 2);
+
+	WREG32(pb_addr + word_offset, ~mask);
+
+	pb_addr = (mmTPC6_CMDQ_CQ_CFG0 & ~0xFFF) + PROT_BITS_OFFS;
+	word_offset = ((mmTPC6_CMDQ_CQ_CFG0 & PROT_BITS_OFFS) >> 7) << 2;
+	mask = 1 << ((mmTPC6_CMDQ_CQ_CFG0 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC6_CMDQ_CQ_CFG1 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC6_CMDQ_CQ_ARUSER & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC6_CMDQ_CQ_PTR_LO_STS & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC6_CMDQ_CQ_PTR_HI_STS & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC6_CMDQ_CQ_TSIZE_STS & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC6_CMDQ_CQ_CTL_STS & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC6_CMDQ_CQ_STS0 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC6_CMDQ_CQ_STS1 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC6_CMDQ_CQ_RD_RATE_LIM_EN & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC6_CMDQ_CQ_RD_RATE_LIM_RST_TOKEN & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC6_CMDQ_CQ_RD_RATE_LIM_SAT & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC6_CMDQ_CQ_RD_RATE_LIM_TOUT & 0x7F) >> 2);
+
+	WREG32(pb_addr + word_offset, ~mask);
+
+	pb_addr = (mmTPC6_CMDQ_CQ_IFIFO_CNT & ~0xFFF) + PROT_BITS_OFFS;
+	word_offset = ((mmTPC6_CMDQ_CQ_IFIFO_CNT & PROT_BITS_OFFS) >> 7) << 2;
+	mask = 1 << ((mmTPC6_CMDQ_CQ_IFIFO_CNT & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC6_CMDQ_CP_MSG_BASE0_ADDR_LO & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC6_CMDQ_CP_MSG_BASE0_ADDR_HI & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC6_CMDQ_CP_MSG_BASE1_ADDR_LO & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC6_CMDQ_CP_MSG_BASE1_ADDR_HI & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC6_CMDQ_CP_MSG_BASE2_ADDR_LO & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC6_CMDQ_CP_MSG_BASE2_ADDR_HI & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC6_CMDQ_CP_MSG_BASE3_ADDR_LO & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC6_CMDQ_CP_MSG_BASE3_ADDR_HI & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC6_CMDQ_CP_LDMA_TSIZE_OFFSET & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC6_CMDQ_CP_LDMA_SRC_BASE_LO_OFFSET & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC6_CMDQ_CP_LDMA_SRC_BASE_HI_OFFSET & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC6_CMDQ_CP_LDMA_DST_BASE_LO_OFFSET & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC6_CMDQ_CP_LDMA_DST_BASE_HI_OFFSET & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC6_CMDQ_CP_LDMA_COMMIT_OFFSET & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC6_CMDQ_CP_STS & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC6_CMDQ_CP_CURRENT_INST_LO & 0x7F) >> 2);
+
+	WREG32(pb_addr + word_offset, ~mask);
+
+	pb_addr = (mmTPC6_CMDQ_CP_CURRENT_INST_HI & ~0xFFF) + PROT_BITS_OFFS;
+	word_offset = ((mmTPC6_CMDQ_CP_CURRENT_INST_HI & PROT_BITS_OFFS) >> 7)
+			<< 2;
+	mask = 1 << ((mmTPC6_CMDQ_CP_CURRENT_INST_HI & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC6_CMDQ_CP_BARRIER_CFG & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC6_CMDQ_CP_DBG_0 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC6_CMDQ_CQ_BUF_ADDR & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC6_CMDQ_CQ_BUF_RDATA & 0x7F) >> 2);
+
+	WREG32(pb_addr + word_offset, ~mask);
+
+	goya_pb_set_block(hdev, mmTPC7_NRTR_BASE);
+	goya_pb_set_block(hdev, mmTPC7_RD_REGULATOR_BASE);
+	goya_pb_set_block(hdev, mmTPC7_WR_REGULATOR_BASE);
+
+	pb_addr = (mmTPC7_CFG_CFG_BASE_ADDRESS_HIGH & ~0xFFF) +	PROT_BITS_OFFS;
+	word_offset = ((mmTPC7_CFG_CFG_BASE_ADDRESS_HIGH &
+			PROT_BITS_OFFS) >> 7) << 2;
+	mask = 1 << ((mmTPC7_CFG_CFG_BASE_ADDRESS_HIGH & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC7_CFG_CFG_SUBTRACT_VALUE & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC7_CFG_SM_BASE_ADDRESS_LOW & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC7_CFG_SM_BASE_ADDRESS_HIGH & 0x7F) >> 2);
+
+	WREG32(pb_addr + word_offset, ~mask);
+
+	pb_addr = (mmTPC7_CFG_ARUSER & ~0xFFF) + PROT_BITS_OFFS;
+	word_offset = ((mmTPC7_CFG_ARUSER & PROT_BITS_OFFS) >> 7) << 2;
+	mask = 1 << ((mmTPC7_CFG_ARUSER & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC7_CFG_AWUSER & 0x7F) >> 2);
+
+	WREG32(pb_addr + word_offset, ~mask);
+
+	pb_addr = (mmTPC7_CFG_FUNC_MBIST_CNTRL & ~0xFFF) + PROT_BITS_OFFS;
+	word_offset = ((mmTPC7_CFG_FUNC_MBIST_CNTRL &
+			PROT_BITS_OFFS) >> 7) << 2;
+	mask = 1 << ((mmTPC7_CFG_FUNC_MBIST_CNTRL & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC7_CFG_FUNC_MBIST_PAT & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC7_CFG_FUNC_MBIST_MEM_0 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC7_CFG_FUNC_MBIST_MEM_1 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC7_CFG_FUNC_MBIST_MEM_2 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC7_CFG_FUNC_MBIST_MEM_3 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC7_CFG_FUNC_MBIST_MEM_4 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC7_CFG_FUNC_MBIST_MEM_5 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC7_CFG_FUNC_MBIST_MEM_6 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC7_CFG_FUNC_MBIST_MEM_7 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC7_CFG_FUNC_MBIST_MEM_8 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC7_CFG_FUNC_MBIST_MEM_9 & 0x7F) >> 2);
+
+	WREG32(pb_addr + word_offset, ~mask);
+
+	pb_addr = (mmTPC7_QM_GLBL_CFG0 & ~0xFFF) + PROT_BITS_OFFS;
+	word_offset = ((mmTPC7_QM_GLBL_CFG0 & PROT_BITS_OFFS) >> 7) << 2;
+	mask = 1 << ((mmTPC7_QM_GLBL_CFG0 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC7_QM_GLBL_CFG1 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC7_QM_GLBL_PROT & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC7_QM_GLBL_ERR_CFG & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC7_QM_GLBL_ERR_ADDR_LO & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC7_QM_GLBL_ERR_ADDR_HI & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC7_QM_GLBL_ERR_WDATA & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC7_QM_GLBL_SECURE_PROPS & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC7_QM_GLBL_NON_SECURE_PROPS & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC7_QM_GLBL_STS0 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC7_QM_GLBL_STS1 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC7_QM_PQ_BASE_LO & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC7_QM_PQ_BASE_HI & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC7_QM_PQ_SIZE & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC7_QM_PQ_PI & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC7_QM_PQ_CI & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC7_QM_PQ_CFG0 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC7_QM_PQ_CFG1 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC7_QM_PQ_ARUSER & 0x7F) >> 2);
+
+	WREG32(pb_addr + word_offset, ~mask);
+
+	pb_addr = (mmTPC7_QM_PQ_PUSH0 & ~0xFFF) + PROT_BITS_OFFS;
+	word_offset = ((mmTPC7_QM_PQ_PUSH0 & PROT_BITS_OFFS) >> 7) << 2;
+	mask = 1 << ((mmTPC7_QM_PQ_PUSH0 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC7_QM_PQ_PUSH1 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC7_QM_PQ_PUSH2 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC7_QM_PQ_PUSH3 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC7_QM_PQ_STS0 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC7_QM_PQ_STS1 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC7_QM_PQ_RD_RATE_LIM_EN & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC7_QM_PQ_RD_RATE_LIM_RST_TOKEN & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC7_QM_PQ_RD_RATE_LIM_SAT & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC7_QM_PQ_RD_RATE_LIM_TOUT & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC7_QM_CQ_CFG0 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC7_QM_CQ_CFG1 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC7_QM_CQ_ARUSER & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC7_QM_CQ_PTR_LO & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC7_QM_CQ_PTR_HI & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC7_QM_CQ_TSIZE & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC7_QM_CQ_CTL & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC7_QM_CQ_PTR_LO_STS & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC7_QM_CQ_PTR_HI_STS & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC7_QM_CQ_TSIZE_STS & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC7_QM_CQ_CTL_STS & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC7_QM_CQ_STS0 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC7_QM_CQ_STS1 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC7_QM_CQ_RD_RATE_LIM_EN & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC7_QM_CQ_RD_RATE_LIM_RST_TOKEN & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC7_QM_CQ_RD_RATE_LIM_SAT & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC7_QM_CQ_RD_RATE_LIM_TOUT & 0x7F) >> 2);
+
+	WREG32(pb_addr + word_offset, ~mask);
+
+	pb_addr = (mmTPC7_QM_CQ_IFIFO_CNT & ~0xFFF) + PROT_BITS_OFFS;
+	word_offset = ((mmTPC7_QM_CQ_IFIFO_CNT & PROT_BITS_OFFS) >> 7) << 2;
+	mask = 1 << ((mmTPC7_QM_CQ_IFIFO_CNT & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC7_QM_CP_MSG_BASE0_ADDR_LO & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC7_QM_CP_MSG_BASE0_ADDR_HI & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC7_QM_CP_MSG_BASE1_ADDR_LO & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC7_QM_CP_MSG_BASE1_ADDR_HI & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC7_QM_CP_MSG_BASE2_ADDR_LO & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC7_QM_CP_MSG_BASE2_ADDR_HI & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC7_QM_CP_MSG_BASE3_ADDR_LO & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC7_QM_CP_MSG_BASE3_ADDR_HI & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC7_QM_CP_LDMA_TSIZE_OFFSET & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC7_QM_CP_LDMA_SRC_BASE_LO_OFFSET & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC7_QM_CP_LDMA_SRC_BASE_HI_OFFSET & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC7_QM_CP_LDMA_DST_BASE_LO_OFFSET & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC7_QM_CP_LDMA_DST_BASE_HI_OFFSET & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC7_QM_CP_LDMA_COMMIT_OFFSET & 0x7F) >> 2);
+
+	WREG32(pb_addr + word_offset, ~mask);
+
+	pb_addr = (mmTPC7_CMDQ_GLBL_CFG0 & ~0xFFF) + PROT_BITS_OFFS;
+	word_offset = ((mmTPC7_CMDQ_GLBL_CFG0 & PROT_BITS_OFFS) >> 7) << 2;
+	mask = 1 << ((mmTPC7_CMDQ_GLBL_CFG0 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC7_CMDQ_GLBL_CFG1 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC7_CMDQ_GLBL_PROT & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC7_CMDQ_GLBL_ERR_CFG & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC7_CMDQ_GLBL_ERR_ADDR_LO & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC7_CMDQ_GLBL_ERR_ADDR_HI & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC7_CMDQ_GLBL_ERR_WDATA & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC7_CMDQ_GLBL_SECURE_PROPS & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC7_CMDQ_GLBL_NON_SECURE_PROPS & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC7_CMDQ_GLBL_STS0 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC7_CMDQ_GLBL_STS1 & 0x7F) >> 2);
+
+	WREG32(pb_addr + word_offset, ~mask);
+
+	pb_addr = (mmTPC7_CMDQ_CQ_CFG0 & ~0xFFF) + PROT_BITS_OFFS;
+	word_offset = ((mmTPC7_CMDQ_CQ_CFG0 & PROT_BITS_OFFS) >> 7) << 2;
+	mask = 1 << ((mmTPC7_CMDQ_CQ_CFG0 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC7_CMDQ_CQ_CFG1 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC7_CMDQ_CQ_ARUSER & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC7_CMDQ_CQ_PTR_LO_STS & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC7_CMDQ_CQ_PTR_HI_STS & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC7_CMDQ_CQ_TSIZE_STS & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC7_CMDQ_CQ_CTL_STS & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC7_CMDQ_CQ_STS0 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC7_CMDQ_CQ_STS1 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC7_CMDQ_CQ_RD_RATE_LIM_EN & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC7_CMDQ_CQ_RD_RATE_LIM_RST_TOKEN & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC7_CMDQ_CQ_RD_RATE_LIM_SAT & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC7_CMDQ_CQ_RD_RATE_LIM_TOUT & 0x7F) >> 2);
+
+	WREG32(pb_addr + word_offset, ~mask);
+
+	pb_addr = (mmTPC7_CMDQ_CQ_IFIFO_CNT & ~0xFFF) + PROT_BITS_OFFS;
+	word_offset = ((mmTPC7_CMDQ_CQ_IFIFO_CNT & PROT_BITS_OFFS) >> 7) << 2;
+	mask = 1 << ((mmTPC7_CMDQ_CQ_IFIFO_CNT & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC7_CMDQ_CP_MSG_BASE0_ADDR_LO & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC7_CMDQ_CP_MSG_BASE0_ADDR_HI & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC7_CMDQ_CP_MSG_BASE1_ADDR_LO & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC7_CMDQ_CP_MSG_BASE1_ADDR_HI & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC7_CMDQ_CP_MSG_BASE2_ADDR_LO & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC7_CMDQ_CP_MSG_BASE2_ADDR_HI & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC7_CMDQ_CP_MSG_BASE3_ADDR_LO & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC7_CMDQ_CP_MSG_BASE3_ADDR_HI & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC7_CMDQ_CP_LDMA_TSIZE_OFFSET & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC7_CMDQ_CP_LDMA_SRC_BASE_LO_OFFSET & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC7_CMDQ_CP_LDMA_SRC_BASE_HI_OFFSET & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC7_CMDQ_CP_LDMA_DST_BASE_LO_OFFSET & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC7_CMDQ_CP_LDMA_DST_BASE_HI_OFFSET & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC7_CMDQ_CP_LDMA_COMMIT_OFFSET & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC7_CMDQ_CP_STS & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC7_CMDQ_CP_CURRENT_INST_LO & 0x7F) >> 2);
+
+	WREG32(pb_addr + word_offset, ~mask);
+
+	pb_addr = (mmTPC7_CMDQ_CP_CURRENT_INST_HI & ~0xFFF) + PROT_BITS_OFFS;
+	word_offset = ((mmTPC7_CMDQ_CP_CURRENT_INST_HI & PROT_BITS_OFFS) >> 7)
+			<< 2;
+	mask = 1 << ((mmTPC7_CMDQ_CP_CURRENT_INST_HI & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC7_CMDQ_CP_BARRIER_CFG & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC7_CMDQ_CP_DBG_0 & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC7_CMDQ_CQ_BUF_ADDR & 0x7F) >> 2);
+	mask |= 1 << ((mmTPC7_CMDQ_CQ_BUF_RDATA & 0x7F) >> 2);
+
+	WREG32(pb_addr + word_offset, ~mask);
+}
+
+/**
+ * goya_init_protection_bits - Initialize protection bits for specific registers
+ *
+ * @hdev: pointer to hl_device structure
+ *
+ * All protection bits are 1 by default, means not protected. Need to set to 0
+ * each bit that belongs to a protected register.
+ *
+ */
+static void goya_init_protection_bits(struct hl_device *hdev)
+{
+	/*
+	 * In each 4K block of registers, the last 128 bytes are protection
+	 * bits - total of 1024 bits, one for each register. Each bit is related
+	 * to a specific register, by the order of the registers.
+	 * So in order to calculate the bit that is related to a given register,
+	 * we need to calculate its word offset and then the exact bit inside
+	 * the word (which is 4 bytes).
+	 *
+	 * Register address:
+	 *
+	 * 31                 12 11           7   6             2  1      0
+	 * -----------------------------------------------------------------
+	 * |      Don't         |    word       |  bit location  |    0    |
+	 * |      care          |   offset      |  inside word   |         |
+	 * -----------------------------------------------------------------
+	 *
+	 * Bits 7-11 represents the word offset inside the 128 bytes.
+	 * Bits 2-6 represents the bit location inside the word.
+	 */
+
+	goya_pb_set_block(hdev, mmPCI_NRTR_BASE);
+	goya_pb_set_block(hdev, mmPCI_RD_REGULATOR_BASE);
+	goya_pb_set_block(hdev, mmPCI_WR_REGULATOR_BASE);
+
+	goya_pb_set_block(hdev, mmSRAM_Y0_X0_BANK_BASE);
+	goya_pb_set_block(hdev, mmSRAM_Y0_X0_RTR_BASE);
+	goya_pb_set_block(hdev, mmSRAM_Y0_X1_BANK_BASE);
+	goya_pb_set_block(hdev, mmSRAM_Y0_X1_RTR_BASE);
+	goya_pb_set_block(hdev, mmSRAM_Y0_X2_BANK_BASE);
+	goya_pb_set_block(hdev, mmSRAM_Y0_X2_RTR_BASE);
+	goya_pb_set_block(hdev, mmSRAM_Y0_X3_BANK_BASE);
+	goya_pb_set_block(hdev, mmSRAM_Y0_X3_RTR_BASE);
+	goya_pb_set_block(hdev, mmSRAM_Y0_X4_BANK_BASE);
+	goya_pb_set_block(hdev, mmSRAM_Y0_X4_RTR_BASE);
+
+	goya_pb_set_block(hdev, mmSRAM_Y1_X0_BANK_BASE);
+	goya_pb_set_block(hdev, mmSRAM_Y1_X0_RTR_BASE);
+	goya_pb_set_block(hdev, mmSRAM_Y1_X1_BANK_BASE);
+	goya_pb_set_block(hdev, mmSRAM_Y1_X1_RTR_BASE);
+	goya_pb_set_block(hdev, mmSRAM_Y1_X2_BANK_BASE);
+	goya_pb_set_block(hdev, mmSRAM_Y1_X2_RTR_BASE);
+	goya_pb_set_block(hdev, mmSRAM_Y1_X3_BANK_BASE);
+	goya_pb_set_block(hdev, mmSRAM_Y1_X3_RTR_BASE);
+	goya_pb_set_block(hdev, mmSRAM_Y1_X4_BANK_BASE);
+	goya_pb_set_block(hdev, mmSRAM_Y1_X4_RTR_BASE);
+
+	goya_pb_set_block(hdev, mmSRAM_Y2_X0_BANK_BASE);
+	goya_pb_set_block(hdev, mmSRAM_Y2_X0_RTR_BASE);
+	goya_pb_set_block(hdev, mmSRAM_Y2_X1_BANK_BASE);
+	goya_pb_set_block(hdev, mmSRAM_Y2_X1_RTR_BASE);
+	goya_pb_set_block(hdev, mmSRAM_Y2_X2_BANK_BASE);
+	goya_pb_set_block(hdev, mmSRAM_Y2_X2_RTR_BASE);
+	goya_pb_set_block(hdev, mmSRAM_Y2_X3_BANK_BASE);
+	goya_pb_set_block(hdev, mmSRAM_Y2_X3_RTR_BASE);
+	goya_pb_set_block(hdev, mmSRAM_Y2_X4_BANK_BASE);
+	goya_pb_set_block(hdev, mmSRAM_Y2_X4_RTR_BASE);
+
+	goya_pb_set_block(hdev, mmSRAM_Y3_X0_BANK_BASE);
+	goya_pb_set_block(hdev, mmSRAM_Y3_X0_RTR_BASE);
+	goya_pb_set_block(hdev, mmSRAM_Y3_X1_BANK_BASE);
+	goya_pb_set_block(hdev, mmSRAM_Y3_X1_RTR_BASE);
+	goya_pb_set_block(hdev, mmSRAM_Y3_X2_BANK_BASE);
+	goya_pb_set_block(hdev, mmSRAM_Y3_X2_RTR_BASE);
+	goya_pb_set_block(hdev, mmSRAM_Y3_X3_BANK_BASE);
+	goya_pb_set_block(hdev, mmSRAM_Y3_X3_RTR_BASE);
+	goya_pb_set_block(hdev, mmSRAM_Y3_X4_BANK_BASE);
+	goya_pb_set_block(hdev, mmSRAM_Y3_X4_RTR_BASE);
+
+	goya_pb_set_block(hdev, mmSRAM_Y4_X0_BANK_BASE);
+	goya_pb_set_block(hdev, mmSRAM_Y4_X0_RTR_BASE);
+	goya_pb_set_block(hdev, mmSRAM_Y4_X1_BANK_BASE);
+	goya_pb_set_block(hdev, mmSRAM_Y4_X1_RTR_BASE);
+	goya_pb_set_block(hdev, mmSRAM_Y4_X2_BANK_BASE);
+	goya_pb_set_block(hdev, mmSRAM_Y4_X2_RTR_BASE);
+	goya_pb_set_block(hdev, mmSRAM_Y4_X3_BANK_BASE);
+	goya_pb_set_block(hdev, mmSRAM_Y4_X3_RTR_BASE);
+	goya_pb_set_block(hdev, mmSRAM_Y4_X4_BANK_BASE);
+	goya_pb_set_block(hdev, mmSRAM_Y4_X4_RTR_BASE);
+
+	goya_pb_set_block(hdev, mmSRAM_Y5_X0_BANK_BASE);
+	goya_pb_set_block(hdev, mmSRAM_Y5_X0_RTR_BASE);
+	goya_pb_set_block(hdev, mmSRAM_Y5_X1_BANK_BASE);
+	goya_pb_set_block(hdev, mmSRAM_Y5_X1_RTR_BASE);
+	goya_pb_set_block(hdev, mmSRAM_Y5_X2_BANK_BASE);
+	goya_pb_set_block(hdev, mmSRAM_Y5_X2_RTR_BASE);
+	goya_pb_set_block(hdev, mmSRAM_Y5_X3_BANK_BASE);
+	goya_pb_set_block(hdev, mmSRAM_Y5_X3_RTR_BASE);
+	goya_pb_set_block(hdev, mmSRAM_Y5_X4_BANK_BASE);
+	goya_pb_set_block(hdev, mmSRAM_Y5_X4_RTR_BASE);
+
+	goya_pb_set_block(hdev, mmPCIE_WRAP_BASE);
+	goya_pb_set_block(hdev, mmPCIE_CORE_BASE);
+	goya_pb_set_block(hdev, mmPCIE_DB_CFG_BASE);
+	goya_pb_set_block(hdev, mmPCIE_DB_CMD_BASE);
+	goya_pb_set_block(hdev, mmPCIE_AUX_BASE);
+	goya_pb_set_block(hdev, mmPCIE_DB_RSV_BASE);
+	goya_pb_set_block(hdev, mmPCIE_PHY_BASE);
+
+	goya_init_mme_protection_bits(hdev);
+
+	goya_init_dma_protection_bits(hdev);
+
+	goya_init_tpc_protection_bits(hdev);
+}
+
+/**
+ * goya_init_security - Initialize security model
+ *
+ * @hdev: pointer to hl_device structure
+ *
+ * Initialize the security model of the device
+ * That includes range registers and protection bit per register
+ *
+ */
+void goya_init_security(struct hl_device *hdev)
+{
+	struct goya_device *goya = hdev->asic_specific;
+
+	u32 dram_addr_lo = lower_32_bits(DRAM_PHYS_BASE);
+	u32 dram_addr_hi = upper_32_bits(DRAM_PHYS_BASE);
+
+	u32 lbw_rng0_base = 0xFC440000 & DMA_MACRO_LBW_RANGE_BASE_R_MASK;
+	u32 lbw_rng0_mask = 0xFFFF0000 & DMA_MACRO_LBW_RANGE_BASE_R_MASK;
+
+	u32 lbw_rng1_base = 0xFC480000 & DMA_MACRO_LBW_RANGE_BASE_R_MASK;
+	u32 lbw_rng1_mask = 0xFFF80000 & DMA_MACRO_LBW_RANGE_BASE_R_MASK;
+
+	u32 lbw_rng2_base = 0xFC600000 & DMA_MACRO_LBW_RANGE_BASE_R_MASK;
+	u32 lbw_rng2_mask = 0xFFE00000 & DMA_MACRO_LBW_RANGE_BASE_R_MASK;
+
+	u32 lbw_rng3_base = 0xFC800000 & DMA_MACRO_LBW_RANGE_BASE_R_MASK;
+	u32 lbw_rng3_mask = 0xFFF00000 & DMA_MACRO_LBW_RANGE_BASE_R_MASK;
+
+	u32 lbw_rng4_base = 0xFCC02000 & DMA_MACRO_LBW_RANGE_BASE_R_MASK;
+	u32 lbw_rng4_mask = 0xFFFFF000 & DMA_MACRO_LBW_RANGE_BASE_R_MASK;
+
+	u32 lbw_rng5_base = 0xFCC40000 & DMA_MACRO_LBW_RANGE_BASE_R_MASK;
+	u32 lbw_rng5_mask = 0xFFFF8000 & DMA_MACRO_LBW_RANGE_BASE_R_MASK;
+
+	u32 lbw_rng6_base = 0xFCC48000 & DMA_MACRO_LBW_RANGE_BASE_R_MASK;
+	u32 lbw_rng6_mask = 0xFFFFF000 & DMA_MACRO_LBW_RANGE_BASE_R_MASK;
+
+	u32 lbw_rng7_base = 0xFCC4A000 & DMA_MACRO_LBW_RANGE_BASE_R_MASK;
+	u32 lbw_rng7_mask = 0xFFFFE000 & DMA_MACRO_LBW_RANGE_BASE_R_MASK;
+
+	u32 lbw_rng8_base = 0xFCC4C000 & DMA_MACRO_LBW_RANGE_BASE_R_MASK;
+	u32 lbw_rng8_mask = 0xFFFFC000 & DMA_MACRO_LBW_RANGE_BASE_R_MASK;
+
+	u32 lbw_rng9_base = 0xFCC50000 & DMA_MACRO_LBW_RANGE_BASE_R_MASK;
+	u32 lbw_rng9_mask = 0xFFFF0000 & DMA_MACRO_LBW_RANGE_BASE_R_MASK;
+
+	u32 lbw_rng10_base = 0xFCC60000 & DMA_MACRO_LBW_RANGE_BASE_R_MASK;
+	u32 lbw_rng10_mask = 0xFFFE0000 & DMA_MACRO_LBW_RANGE_BASE_R_MASK;
+
+	u32 lbw_rng11_base = 0xFCE00000 & DMA_MACRO_LBW_RANGE_BASE_R_MASK;
+	u32 lbw_rng11_mask = 0xFFFFC000 & DMA_MACRO_LBW_RANGE_BASE_R_MASK;
+
+	u32 lbw_rng12_base = 0xFE484000 & DMA_MACRO_LBW_RANGE_BASE_R_MASK;
+	u32 lbw_rng12_mask = 0xFFFFF000 & DMA_MACRO_LBW_RANGE_BASE_R_MASK;
+
+	u32 lbw_rng13_base = 0xFEC43000 & DMA_MACRO_LBW_RANGE_BASE_R_MASK;
+	u32 lbw_rng13_mask = 0xFFFFF000 & DMA_MACRO_LBW_RANGE_BASE_R_MASK;
+
+	WREG32(mmDMA_MACRO_LBW_RANGE_HIT_BLOCK, 0xFFFF);
+	WREG32(mmDMA_MACRO_HBW_RANGE_HIT_BLOCK, 0xFF);
+
+	if (!(goya->hw_cap_initialized & HW_CAP_MMU)) {
+		WREG32(mmDMA_MACRO_HBW_RANGE_HIT_BLOCK, 0xFE);
+
+		/* Protect HOST */
+		WREG32(mmDMA_MACRO_HBW_RANGE_BASE_31_0_0, 0);
+		WREG32(mmDMA_MACRO_HBW_RANGE_BASE_49_32_0, 0);
+		WREG32(mmDMA_MACRO_HBW_RANGE_MASK_31_0_0, 0);
+		WREG32(mmDMA_MACRO_HBW_RANGE_MASK_49_32_0, 0xFFF80);
+	}
+
+	/*
+	 * Protect DDR @
+	 * DRAM_VIRT_BASE : DRAM_VIRT_BASE + DRAM_VIRT_END
+	 * The mask protects the first 512MB
+	 */
+	WREG32(mmDMA_MACRO_HBW_RANGE_BASE_31_0_1, dram_addr_lo);
+	WREG32(mmDMA_MACRO_HBW_RANGE_BASE_49_32_1, dram_addr_hi);
+	WREG32(mmDMA_MACRO_HBW_RANGE_MASK_31_0_1, 0xE0000000);
+	WREG32(mmDMA_MACRO_HBW_RANGE_MASK_49_32_1, 0x3FFFF);
+
+	/* Protect registers */
+
+	WREG32(mmDMA_MACRO_LBW_RANGE_BASE_0, lbw_rng0_base);
+	WREG32(mmDMA_MACRO_LBW_RANGE_MASK_0, lbw_rng0_mask);
+	WREG32(mmDMA_MACRO_LBW_RANGE_BASE_1, lbw_rng1_base);
+	WREG32(mmDMA_MACRO_LBW_RANGE_MASK_1, lbw_rng1_mask);
+	WREG32(mmDMA_MACRO_LBW_RANGE_BASE_2, lbw_rng2_base);
+	WREG32(mmDMA_MACRO_LBW_RANGE_MASK_2, lbw_rng2_mask);
+	WREG32(mmDMA_MACRO_LBW_RANGE_BASE_3, lbw_rng3_base);
+	WREG32(mmDMA_MACRO_LBW_RANGE_MASK_3, lbw_rng3_mask);
+	WREG32(mmDMA_MACRO_LBW_RANGE_BASE_4, lbw_rng4_base);
+	WREG32(mmDMA_MACRO_LBW_RANGE_MASK_4, lbw_rng4_mask);
+	WREG32(mmDMA_MACRO_LBW_RANGE_BASE_5, lbw_rng5_base);
+	WREG32(mmDMA_MACRO_LBW_RANGE_MASK_5, lbw_rng5_mask);
+	WREG32(mmDMA_MACRO_LBW_RANGE_BASE_6, lbw_rng6_base);
+	WREG32(mmDMA_MACRO_LBW_RANGE_MASK_6, lbw_rng6_mask);
+	WREG32(mmDMA_MACRO_LBW_RANGE_BASE_7, lbw_rng7_base);
+	WREG32(mmDMA_MACRO_LBW_RANGE_MASK_7, lbw_rng7_mask);
+	WREG32(mmDMA_MACRO_LBW_RANGE_BASE_8, lbw_rng8_base);
+	WREG32(mmDMA_MACRO_LBW_RANGE_MASK_8, lbw_rng8_mask);
+	WREG32(mmDMA_MACRO_LBW_RANGE_BASE_9, lbw_rng9_base);
+	WREG32(mmDMA_MACRO_LBW_RANGE_MASK_9, lbw_rng9_mask);
+	WREG32(mmDMA_MACRO_LBW_RANGE_BASE_10, lbw_rng10_base);
+	WREG32(mmDMA_MACRO_LBW_RANGE_MASK_10, lbw_rng10_mask);
+	WREG32(mmDMA_MACRO_LBW_RANGE_BASE_11, lbw_rng11_base);
+	WREG32(mmDMA_MACRO_LBW_RANGE_MASK_11, lbw_rng11_mask);
+	WREG32(mmDMA_MACRO_LBW_RANGE_BASE_12, lbw_rng12_base);
+	WREG32(mmDMA_MACRO_LBW_RANGE_MASK_12, lbw_rng12_mask);
+	WREG32(mmDMA_MACRO_LBW_RANGE_BASE_13, lbw_rng13_base);
+	WREG32(mmDMA_MACRO_LBW_RANGE_MASK_13, lbw_rng13_mask);
+
+	WREG32(mmMME1_RTR_LBW_RANGE_HIT, 0xFFFF);
+	WREG32(mmMME2_RTR_LBW_RANGE_HIT, 0xFFFF);
+	WREG32(mmMME3_RTR_LBW_RANGE_HIT, 0xFFFF);
+	WREG32(mmMME4_RTR_LBW_RANGE_HIT, 0xFFFF);
+	WREG32(mmMME5_RTR_LBW_RANGE_HIT, 0xFFFF);
+	WREG32(mmMME6_RTR_LBW_RANGE_HIT, 0xFFFF);
+
+	WREG32(mmMME1_RTR_HBW_RANGE_HIT, 0xFE);
+	WREG32(mmMME2_RTR_HBW_RANGE_HIT, 0xFE);
+	WREG32(mmMME3_RTR_HBW_RANGE_HIT, 0xFE);
+	WREG32(mmMME4_RTR_HBW_RANGE_HIT, 0xFE);
+	WREG32(mmMME5_RTR_HBW_RANGE_HIT, 0xFE);
+	WREG32(mmMME6_RTR_HBW_RANGE_HIT, 0xFE);
+
+	/* Protect HOST */
+	WREG32(mmMME1_RTR_HBW_RANGE_BASE_L_0, 0);
+	WREG32(mmMME1_RTR_HBW_RANGE_BASE_H_0, 0);
+	WREG32(mmMME1_RTR_HBW_RANGE_MASK_L_0, 0);
+	WREG32(mmMME1_RTR_HBW_RANGE_MASK_H_0, 0xFFF80);
+
+	WREG32(mmMME2_RTR_HBW_RANGE_BASE_L_0, 0);
+	WREG32(mmMME2_RTR_HBW_RANGE_BASE_H_0, 0);
+	WREG32(mmMME2_RTR_HBW_RANGE_MASK_L_0, 0);
+	WREG32(mmMME2_RTR_HBW_RANGE_MASK_H_0, 0xFFF80);
+
+	WREG32(mmMME3_RTR_HBW_RANGE_BASE_L_0, 0);
+	WREG32(mmMME3_RTR_HBW_RANGE_BASE_H_0, 0);
+	WREG32(mmMME3_RTR_HBW_RANGE_MASK_L_0, 0);
+	WREG32(mmMME3_RTR_HBW_RANGE_MASK_H_0, 0xFFF80);
+
+	WREG32(mmMME4_RTR_HBW_RANGE_BASE_L_0, 0);
+	WREG32(mmMME4_RTR_HBW_RANGE_BASE_H_0, 0);
+	WREG32(mmMME4_RTR_HBW_RANGE_MASK_L_0, 0);
+	WREG32(mmMME4_RTR_HBW_RANGE_MASK_H_0, 0xFFF80);
+
+	WREG32(mmMME5_RTR_HBW_RANGE_BASE_L_0, 0);
+	WREG32(mmMME5_RTR_HBW_RANGE_BASE_H_0, 0);
+	WREG32(mmMME5_RTR_HBW_RANGE_MASK_L_0, 0);
+	WREG32(mmMME5_RTR_HBW_RANGE_MASK_H_0, 0xFFF80);
+
+	WREG32(mmMME6_RTR_HBW_RANGE_BASE_L_0, 0);
+	WREG32(mmMME6_RTR_HBW_RANGE_BASE_H_0, 0);
+	WREG32(mmMME6_RTR_HBW_RANGE_MASK_L_0, 0);
+	WREG32(mmMME6_RTR_HBW_RANGE_MASK_H_0, 0xFFF80);
+
+	/*
+	 * Protect DDR @
+	 * DRAM_VIRT_BASE : DRAM_VIRT_BASE + DRAM_VIRT_END
+	 * The mask protects the first 512MB
+	 */
+	WREG32(mmMME1_RTR_HBW_RANGE_BASE_L_1, dram_addr_lo);
+	WREG32(mmMME1_RTR_HBW_RANGE_BASE_H_1, dram_addr_hi);
+	WREG32(mmMME1_RTR_HBW_RANGE_MASK_L_1, 0xE0000000);
+	WREG32(mmMME1_RTR_HBW_RANGE_MASK_H_1, 0x3FFFF);
+
+	WREG32(mmMME2_RTR_HBW_RANGE_BASE_L_1, dram_addr_lo);
+	WREG32(mmMME2_RTR_HBW_RANGE_BASE_H_1, dram_addr_hi);
+	WREG32(mmMME2_RTR_HBW_RANGE_MASK_L_1, 0xE0000000);
+	WREG32(mmMME2_RTR_HBW_RANGE_MASK_H_1, 0x3FFFF);
+
+	WREG32(mmMME3_RTR_HBW_RANGE_BASE_L_1, dram_addr_lo);
+	WREG32(mmMME3_RTR_HBW_RANGE_BASE_H_1, dram_addr_hi);
+	WREG32(mmMME3_RTR_HBW_RANGE_MASK_L_1, 0xE0000000);
+	WREG32(mmMME3_RTR_HBW_RANGE_MASK_H_1, 0x3FFFF);
+
+	WREG32(mmMME4_RTR_HBW_RANGE_BASE_L_1, dram_addr_lo);
+	WREG32(mmMME4_RTR_HBW_RANGE_BASE_H_1, dram_addr_hi);
+	WREG32(mmMME4_RTR_HBW_RANGE_MASK_L_1, 0xE0000000);
+	WREG32(mmMME4_RTR_HBW_RANGE_MASK_H_1, 0x3FFFF);
+
+	WREG32(mmMME5_RTR_HBW_RANGE_BASE_L_1, dram_addr_lo);
+	WREG32(mmMME5_RTR_HBW_RANGE_BASE_H_1, dram_addr_hi);
+	WREG32(mmMME5_RTR_HBW_RANGE_MASK_L_1, 0xE0000000);
+	WREG32(mmMME5_RTR_HBW_RANGE_MASK_H_1, 0x3FFFF);
+
+	WREG32(mmMME6_RTR_HBW_RANGE_BASE_L_1, dram_addr_lo);
+	WREG32(mmMME6_RTR_HBW_RANGE_BASE_H_1, dram_addr_hi);
+	WREG32(mmMME6_RTR_HBW_RANGE_MASK_L_1, 0xE0000000);
+	WREG32(mmMME6_RTR_HBW_RANGE_MASK_H_1, 0x3FFFF);
+
+	WREG32(mmMME1_RTR_LBW_RANGE_BASE_0, lbw_rng0_base);
+	WREG32(mmMME1_RTR_LBW_RANGE_MASK_0, lbw_rng0_mask);
+	WREG32(mmMME1_RTR_LBW_RANGE_BASE_1, lbw_rng1_base);
+	WREG32(mmMME1_RTR_LBW_RANGE_MASK_1, lbw_rng1_mask);
+	WREG32(mmMME1_RTR_LBW_RANGE_BASE_2, lbw_rng2_base);
+	WREG32(mmMME1_RTR_LBW_RANGE_MASK_2, lbw_rng2_mask);
+	WREG32(mmMME1_RTR_LBW_RANGE_BASE_3, lbw_rng3_base);
+	WREG32(mmMME1_RTR_LBW_RANGE_MASK_3, lbw_rng3_mask);
+	WREG32(mmMME1_RTR_LBW_RANGE_BASE_4, lbw_rng4_base);
+	WREG32(mmMME1_RTR_LBW_RANGE_MASK_4, lbw_rng4_mask);
+	WREG32(mmMME1_RTR_LBW_RANGE_BASE_5, lbw_rng5_base);
+	WREG32(mmMME1_RTR_LBW_RANGE_MASK_5, lbw_rng5_mask);
+	WREG32(mmMME1_RTR_LBW_RANGE_BASE_6, lbw_rng6_base);
+	WREG32(mmMME1_RTR_LBW_RANGE_MASK_6, lbw_rng6_mask);
+	WREG32(mmMME1_RTR_LBW_RANGE_BASE_7, lbw_rng7_base);
+	WREG32(mmMME1_RTR_LBW_RANGE_MASK_7, lbw_rng7_mask);
+	WREG32(mmMME1_RTR_LBW_RANGE_BASE_8, lbw_rng8_base);
+	WREG32(mmMME1_RTR_LBW_RANGE_MASK_8, lbw_rng8_mask);
+	WREG32(mmMME1_RTR_LBW_RANGE_BASE_9, lbw_rng9_base);
+	WREG32(mmMME1_RTR_LBW_RANGE_MASK_9, lbw_rng9_mask);
+	WREG32(mmMME1_RTR_LBW_RANGE_BASE_10, lbw_rng10_base);
+	WREG32(mmMME1_RTR_LBW_RANGE_MASK_10, lbw_rng10_mask);
+	WREG32(mmMME1_RTR_LBW_RANGE_BASE_11, lbw_rng11_base);
+	WREG32(mmMME1_RTR_LBW_RANGE_MASK_11, lbw_rng11_mask);
+	WREG32(mmMME1_RTR_LBW_RANGE_BASE_12, lbw_rng12_base);
+	WREG32(mmMME1_RTR_LBW_RANGE_MASK_12, lbw_rng12_mask);
+	WREG32(mmMME1_RTR_LBW_RANGE_BASE_13, lbw_rng13_base);
+	WREG32(mmMME1_RTR_LBW_RANGE_MASK_13, lbw_rng13_mask);
+
+	WREG32(mmMME2_RTR_LBW_RANGE_BASE_0, lbw_rng0_base);
+	WREG32(mmMME2_RTR_LBW_RANGE_MASK_0, lbw_rng0_mask);
+	WREG32(mmMME2_RTR_LBW_RANGE_BASE_1, lbw_rng1_base);
+	WREG32(mmMME2_RTR_LBW_RANGE_MASK_1, lbw_rng1_mask);
+	WREG32(mmMME2_RTR_LBW_RANGE_BASE_2, lbw_rng2_base);
+	WREG32(mmMME2_RTR_LBW_RANGE_MASK_2, lbw_rng2_mask);
+	WREG32(mmMME2_RTR_LBW_RANGE_BASE_3, lbw_rng3_base);
+	WREG32(mmMME2_RTR_LBW_RANGE_MASK_3, lbw_rng3_mask);
+	WREG32(mmMME2_RTR_LBW_RANGE_BASE_4, lbw_rng4_base);
+	WREG32(mmMME2_RTR_LBW_RANGE_MASK_4, lbw_rng4_mask);
+	WREG32(mmMME2_RTR_LBW_RANGE_BASE_5, lbw_rng5_base);
+	WREG32(mmMME2_RTR_LBW_RANGE_MASK_5, lbw_rng5_mask);
+	WREG32(mmMME2_RTR_LBW_RANGE_BASE_6, lbw_rng6_base);
+	WREG32(mmMME2_RTR_LBW_RANGE_MASK_6, lbw_rng6_mask);
+	WREG32(mmMME2_RTR_LBW_RANGE_BASE_7, lbw_rng7_base);
+	WREG32(mmMME2_RTR_LBW_RANGE_MASK_7, lbw_rng7_mask);
+	WREG32(mmMME2_RTR_LBW_RANGE_BASE_8, lbw_rng8_base);
+	WREG32(mmMME2_RTR_LBW_RANGE_MASK_8, lbw_rng8_mask);
+	WREG32(mmMME2_RTR_LBW_RANGE_BASE_9, lbw_rng9_base);
+	WREG32(mmMME2_RTR_LBW_RANGE_MASK_9, lbw_rng9_mask);
+	WREG32(mmMME2_RTR_LBW_RANGE_BASE_10, lbw_rng10_base);
+	WREG32(mmMME2_RTR_LBW_RANGE_MASK_10, lbw_rng10_mask);
+	WREG32(mmMME2_RTR_LBW_RANGE_BASE_11, lbw_rng11_base);
+	WREG32(mmMME2_RTR_LBW_RANGE_MASK_11, lbw_rng11_mask);
+	WREG32(mmMME2_RTR_LBW_RANGE_BASE_12, lbw_rng12_base);
+	WREG32(mmMME2_RTR_LBW_RANGE_MASK_12, lbw_rng12_mask);
+	WREG32(mmMME2_RTR_LBW_RANGE_BASE_13, lbw_rng13_base);
+	WREG32(mmMME2_RTR_LBW_RANGE_MASK_13, lbw_rng13_mask);
+
+	WREG32(mmMME3_RTR_LBW_RANGE_BASE_0, lbw_rng0_base);
+	WREG32(mmMME3_RTR_LBW_RANGE_MASK_0, lbw_rng0_mask);
+	WREG32(mmMME3_RTR_LBW_RANGE_BASE_1, lbw_rng1_base);
+	WREG32(mmMME3_RTR_LBW_RANGE_MASK_1, lbw_rng1_mask);
+	WREG32(mmMME3_RTR_LBW_RANGE_BASE_2, lbw_rng2_base);
+	WREG32(mmMME3_RTR_LBW_RANGE_MASK_2, lbw_rng2_mask);
+	WREG32(mmMME3_RTR_LBW_RANGE_BASE_3, lbw_rng3_base);
+	WREG32(mmMME3_RTR_LBW_RANGE_MASK_3, lbw_rng3_mask);
+	WREG32(mmMME3_RTR_LBW_RANGE_BASE_4, lbw_rng4_base);
+	WREG32(mmMME3_RTR_LBW_RANGE_MASK_4, lbw_rng4_mask);
+	WREG32(mmMME3_RTR_LBW_RANGE_BASE_5, lbw_rng5_base);
+	WREG32(mmMME3_RTR_LBW_RANGE_MASK_5, lbw_rng5_mask);
+	WREG32(mmMME3_RTR_LBW_RANGE_BASE_6, lbw_rng6_base);
+	WREG32(mmMME3_RTR_LBW_RANGE_MASK_6, lbw_rng6_mask);
+	WREG32(mmMME3_RTR_LBW_RANGE_BASE_7, lbw_rng7_base);
+	WREG32(mmMME3_RTR_LBW_RANGE_MASK_7, lbw_rng7_mask);
+	WREG32(mmMME3_RTR_LBW_RANGE_BASE_8, lbw_rng8_base);
+	WREG32(mmMME3_RTR_LBW_RANGE_MASK_8, lbw_rng8_mask);
+	WREG32(mmMME3_RTR_LBW_RANGE_BASE_9, lbw_rng9_base);
+	WREG32(mmMME3_RTR_LBW_RANGE_MASK_9, lbw_rng9_mask);
+	WREG32(mmMME3_RTR_LBW_RANGE_BASE_10, lbw_rng10_base);
+	WREG32(mmMME3_RTR_LBW_RANGE_MASK_10, lbw_rng10_mask);
+	WREG32(mmMME3_RTR_LBW_RANGE_BASE_11, lbw_rng11_base);
+	WREG32(mmMME3_RTR_LBW_RANGE_MASK_11, lbw_rng11_mask);
+	WREG32(mmMME3_RTR_LBW_RANGE_BASE_12, lbw_rng12_base);
+	WREG32(mmMME3_RTR_LBW_RANGE_MASK_12, lbw_rng12_mask);
+	WREG32(mmMME3_RTR_LBW_RANGE_BASE_13, lbw_rng13_base);
+	WREG32(mmMME3_RTR_LBW_RANGE_MASK_13, lbw_rng13_mask);
+
+	WREG32(mmMME4_RTR_LBW_RANGE_BASE_0, lbw_rng0_base);
+	WREG32(mmMME4_RTR_LBW_RANGE_MASK_0, lbw_rng0_mask);
+	WREG32(mmMME4_RTR_LBW_RANGE_BASE_1, lbw_rng1_base);
+	WREG32(mmMME4_RTR_LBW_RANGE_MASK_1, lbw_rng1_mask);
+	WREG32(mmMME4_RTR_LBW_RANGE_BASE_2, lbw_rng2_base);
+	WREG32(mmMME4_RTR_LBW_RANGE_MASK_2, lbw_rng2_mask);
+	WREG32(mmMME4_RTR_LBW_RANGE_BASE_3, lbw_rng3_base);
+	WREG32(mmMME4_RTR_LBW_RANGE_MASK_3, lbw_rng3_mask);
+	WREG32(mmMME4_RTR_LBW_RANGE_BASE_4, lbw_rng4_base);
+	WREG32(mmMME4_RTR_LBW_RANGE_MASK_4, lbw_rng4_mask);
+	WREG32(mmMME4_RTR_LBW_RANGE_BASE_5, lbw_rng5_base);
+	WREG32(mmMME4_RTR_LBW_RANGE_MASK_5, lbw_rng5_mask);
+	WREG32(mmMME4_RTR_LBW_RANGE_BASE_6, lbw_rng6_base);
+	WREG32(mmMME4_RTR_LBW_RANGE_MASK_6, lbw_rng6_mask);
+	WREG32(mmMME4_RTR_LBW_RANGE_BASE_7, lbw_rng7_base);
+	WREG32(mmMME4_RTR_LBW_RANGE_MASK_7, lbw_rng7_mask);
+	WREG32(mmMME4_RTR_LBW_RANGE_BASE_8, lbw_rng8_base);
+	WREG32(mmMME4_RTR_LBW_RANGE_MASK_8, lbw_rng8_mask);
+	WREG32(mmMME4_RTR_LBW_RANGE_BASE_9, lbw_rng9_base);
+	WREG32(mmMME4_RTR_LBW_RANGE_MASK_9, lbw_rng9_mask);
+	WREG32(mmMME4_RTR_LBW_RANGE_BASE_10, lbw_rng10_base);
+	WREG32(mmMME4_RTR_LBW_RANGE_MASK_10, lbw_rng10_mask);
+	WREG32(mmMME4_RTR_LBW_RANGE_BASE_11, lbw_rng11_base);
+	WREG32(mmMME4_RTR_LBW_RANGE_MASK_11, lbw_rng11_mask);
+	WREG32(mmMME4_RTR_LBW_RANGE_BASE_12, lbw_rng12_base);
+	WREG32(mmMME4_RTR_LBW_RANGE_MASK_12, lbw_rng12_mask);
+	WREG32(mmMME4_RTR_LBW_RANGE_BASE_13, lbw_rng13_base);
+	WREG32(mmMME4_RTR_LBW_RANGE_MASK_13, lbw_rng13_mask);
+
+	WREG32(mmMME5_RTR_LBW_RANGE_BASE_0, lbw_rng0_base);
+	WREG32(mmMME5_RTR_LBW_RANGE_MASK_0, lbw_rng0_mask);
+	WREG32(mmMME5_RTR_LBW_RANGE_BASE_1, lbw_rng1_base);
+	WREG32(mmMME5_RTR_LBW_RANGE_MASK_1, lbw_rng1_mask);
+	WREG32(mmMME5_RTR_LBW_RANGE_BASE_2, lbw_rng2_base);
+	WREG32(mmMME5_RTR_LBW_RANGE_MASK_2, lbw_rng2_mask);
+	WREG32(mmMME5_RTR_LBW_RANGE_BASE_3, lbw_rng3_base);
+	WREG32(mmMME5_RTR_LBW_RANGE_MASK_3, lbw_rng3_mask);
+	WREG32(mmMME5_RTR_LBW_RANGE_BASE_4, lbw_rng4_base);
+	WREG32(mmMME5_RTR_LBW_RANGE_MASK_4, lbw_rng4_mask);
+	WREG32(mmMME5_RTR_LBW_RANGE_BASE_5, lbw_rng5_base);
+	WREG32(mmMME5_RTR_LBW_RANGE_MASK_5, lbw_rng5_mask);
+	WREG32(mmMME5_RTR_LBW_RANGE_BASE_6, lbw_rng6_base);
+	WREG32(mmMME5_RTR_LBW_RANGE_MASK_6, lbw_rng6_mask);
+	WREG32(mmMME5_RTR_LBW_RANGE_BASE_7, lbw_rng7_base);
+	WREG32(mmMME5_RTR_LBW_RANGE_MASK_7, lbw_rng7_mask);
+	WREG32(mmMME5_RTR_LBW_RANGE_BASE_8, lbw_rng8_base);
+	WREG32(mmMME5_RTR_LBW_RANGE_MASK_8, lbw_rng8_mask);
+	WREG32(mmMME5_RTR_LBW_RANGE_BASE_9, lbw_rng9_base);
+	WREG32(mmMME5_RTR_LBW_RANGE_MASK_9, lbw_rng9_mask);
+	WREG32(mmMME5_RTR_LBW_RANGE_BASE_10, lbw_rng10_base);
+	WREG32(mmMME5_RTR_LBW_RANGE_MASK_10, lbw_rng10_mask);
+	WREG32(mmMME5_RTR_LBW_RANGE_BASE_11, lbw_rng11_base);
+	WREG32(mmMME5_RTR_LBW_RANGE_MASK_11, lbw_rng11_mask);
+	WREG32(mmMME5_RTR_LBW_RANGE_BASE_12, lbw_rng12_base);
+	WREG32(mmMME5_RTR_LBW_RANGE_MASK_12, lbw_rng12_mask);
+	WREG32(mmMME5_RTR_LBW_RANGE_BASE_13, lbw_rng13_base);
+	WREG32(mmMME5_RTR_LBW_RANGE_MASK_13, lbw_rng13_mask);
+
+	WREG32(mmMME6_RTR_LBW_RANGE_BASE_0, lbw_rng0_base);
+	WREG32(mmMME6_RTR_LBW_RANGE_MASK_0, lbw_rng0_mask);
+	WREG32(mmMME6_RTR_LBW_RANGE_BASE_1, lbw_rng1_base);
+	WREG32(mmMME6_RTR_LBW_RANGE_MASK_1, lbw_rng1_mask);
+	WREG32(mmMME6_RTR_LBW_RANGE_BASE_2, lbw_rng2_base);
+	WREG32(mmMME6_RTR_LBW_RANGE_MASK_2, lbw_rng2_mask);
+	WREG32(mmMME6_RTR_LBW_RANGE_BASE_3, lbw_rng3_base);
+	WREG32(mmMME6_RTR_LBW_RANGE_MASK_3, lbw_rng3_mask);
+	WREG32(mmMME6_RTR_LBW_RANGE_BASE_4, lbw_rng4_base);
+	WREG32(mmMME6_RTR_LBW_RANGE_MASK_4, lbw_rng4_mask);
+	WREG32(mmMME6_RTR_LBW_RANGE_BASE_5, lbw_rng5_base);
+	WREG32(mmMME6_RTR_LBW_RANGE_MASK_5, lbw_rng5_mask);
+	WREG32(mmMME6_RTR_LBW_RANGE_BASE_6, lbw_rng6_base);
+	WREG32(mmMME6_RTR_LBW_RANGE_MASK_6, lbw_rng6_mask);
+	WREG32(mmMME6_RTR_LBW_RANGE_BASE_7, lbw_rng7_base);
+	WREG32(mmMME6_RTR_LBW_RANGE_MASK_7, lbw_rng7_mask);
+	WREG32(mmMME6_RTR_LBW_RANGE_BASE_8, lbw_rng8_base);
+	WREG32(mmMME6_RTR_LBW_RANGE_MASK_8, lbw_rng8_mask);
+	WREG32(mmMME6_RTR_LBW_RANGE_BASE_9, lbw_rng9_base);
+	WREG32(mmMME6_RTR_LBW_RANGE_MASK_9, lbw_rng9_mask);
+	WREG32(mmMME6_RTR_LBW_RANGE_BASE_10, lbw_rng10_base);
+	WREG32(mmMME6_RTR_LBW_RANGE_MASK_10, lbw_rng10_mask);
+	WREG32(mmMME6_RTR_LBW_RANGE_BASE_11, lbw_rng11_base);
+	WREG32(mmMME6_RTR_LBW_RANGE_MASK_11, lbw_rng11_mask);
+	WREG32(mmMME6_RTR_LBW_RANGE_BASE_12, lbw_rng12_base);
+	WREG32(mmMME6_RTR_LBW_RANGE_MASK_12, lbw_rng12_mask);
+	WREG32(mmMME6_RTR_LBW_RANGE_BASE_13, lbw_rng13_base);
+	WREG32(mmMME6_RTR_LBW_RANGE_MASK_13, lbw_rng13_mask);
+
+	WREG32(mmTPC0_NRTR_LBW_RANGE_HIT, 0xFFFF);
+	WREG32(mmTPC0_NRTR_HBW_RANGE_HIT, 0xFE);
+
+	/* Protect HOST */
+	WREG32(mmTPC0_NRTR_HBW_RANGE_BASE_L_0, 0);
+	WREG32(mmTPC0_NRTR_HBW_RANGE_BASE_H_0, 0);
+	WREG32(mmTPC0_NRTR_HBW_RANGE_MASK_L_0, 0);
+	WREG32(mmTPC0_NRTR_HBW_RANGE_MASK_H_0, 0xFFF80);
+
+	/*
+	 * Protect DDR @
+	 * DRAM_VIRT_BASE : DRAM_VIRT_BASE + DRAM_VIRT_END
+	 * The mask protects the first 512MB
+	 */
+	WREG32(mmTPC0_NRTR_HBW_RANGE_BASE_L_1, dram_addr_lo);
+	WREG32(mmTPC0_NRTR_HBW_RANGE_BASE_H_1, dram_addr_hi);
+	WREG32(mmTPC0_NRTR_HBW_RANGE_MASK_L_1, 0xE0000000);
+	WREG32(mmTPC0_NRTR_HBW_RANGE_MASK_H_1, 0x3FFFF);
+
+	WREG32(mmTPC0_NRTR_LBW_RANGE_BASE_0, lbw_rng0_base);
+	WREG32(mmTPC0_NRTR_LBW_RANGE_MASK_0, lbw_rng0_mask);
+	WREG32(mmTPC0_NRTR_LBW_RANGE_BASE_1, lbw_rng1_base);
+	WREG32(mmTPC0_NRTR_LBW_RANGE_MASK_1, lbw_rng1_mask);
+	WREG32(mmTPC0_NRTR_LBW_RANGE_BASE_2, lbw_rng2_base);
+	WREG32(mmTPC0_NRTR_LBW_RANGE_MASK_2, lbw_rng2_mask);
+	WREG32(mmTPC0_NRTR_LBW_RANGE_BASE_3, lbw_rng3_base);
+	WREG32(mmTPC0_NRTR_LBW_RANGE_MASK_3, lbw_rng3_mask);
+	WREG32(mmTPC0_NRTR_LBW_RANGE_BASE_4, lbw_rng4_base);
+	WREG32(mmTPC0_NRTR_LBW_RANGE_MASK_4, lbw_rng4_mask);
+	WREG32(mmTPC0_NRTR_LBW_RANGE_BASE_5, lbw_rng5_base);
+	WREG32(mmTPC0_NRTR_LBW_RANGE_MASK_5, lbw_rng5_mask);
+	WREG32(mmTPC0_NRTR_LBW_RANGE_BASE_6, lbw_rng6_base);
+	WREG32(mmTPC0_NRTR_LBW_RANGE_MASK_6, lbw_rng6_mask);
+	WREG32(mmTPC0_NRTR_LBW_RANGE_BASE_7, lbw_rng7_base);
+	WREG32(mmTPC0_NRTR_LBW_RANGE_MASK_7, lbw_rng7_mask);
+	WREG32(mmTPC0_NRTR_LBW_RANGE_BASE_8, lbw_rng8_base);
+	WREG32(mmTPC0_NRTR_LBW_RANGE_MASK_8, lbw_rng8_mask);
+	WREG32(mmTPC0_NRTR_LBW_RANGE_BASE_9, lbw_rng9_base);
+	WREG32(mmTPC0_NRTR_LBW_RANGE_MASK_9, lbw_rng9_mask);
+	WREG32(mmTPC0_NRTR_LBW_RANGE_BASE_10, lbw_rng10_base);
+	WREG32(mmTPC0_NRTR_LBW_RANGE_MASK_10, lbw_rng10_mask);
+	WREG32(mmTPC0_NRTR_LBW_RANGE_BASE_11, lbw_rng11_base);
+	WREG32(mmTPC0_NRTR_LBW_RANGE_MASK_11, lbw_rng11_mask);
+	WREG32(mmTPC0_NRTR_LBW_RANGE_BASE_12, lbw_rng12_base);
+	WREG32(mmTPC0_NRTR_LBW_RANGE_MASK_12, lbw_rng12_mask);
+	WREG32(mmTPC0_NRTR_LBW_RANGE_BASE_13, lbw_rng13_base);
+	WREG32(mmTPC0_NRTR_LBW_RANGE_MASK_13, lbw_rng13_mask);
+
+	WREG32(mmTPC1_RTR_LBW_RANGE_HIT, 0xFFFF);
+	WREG32(mmTPC1_RTR_HBW_RANGE_HIT, 0xFE);
+
+	/* Protect HOST */
+	WREG32(mmTPC1_RTR_HBW_RANGE_BASE_L_0, 0);
+	WREG32(mmTPC1_RTR_HBW_RANGE_BASE_H_0, 0);
+	WREG32(mmTPC1_RTR_HBW_RANGE_MASK_L_0, 0);
+	WREG32(mmTPC1_RTR_HBW_RANGE_MASK_H_0, 0xFFF80);
+
+	/*
+	 * Protect DDR @
+	 * DRAM_VIRT_BASE : DRAM_VIRT_BASE + DRAM_VIRT_END
+	 * The mask protects the first 512MB
+	 */
+	WREG32(mmTPC1_RTR_HBW_RANGE_BASE_L_1, dram_addr_lo);
+	WREG32(mmTPC1_RTR_HBW_RANGE_BASE_H_1, dram_addr_hi);
+	WREG32(mmTPC1_RTR_HBW_RANGE_MASK_L_1, 0xE0000000);
+	WREG32(mmTPC1_RTR_HBW_RANGE_MASK_H_1, 0x3FFFF);
+
+	WREG32(mmTPC1_RTR_LBW_RANGE_BASE_0, lbw_rng0_base);
+	WREG32(mmTPC1_RTR_LBW_RANGE_MASK_0, lbw_rng0_mask);
+	WREG32(mmTPC1_RTR_LBW_RANGE_BASE_1, lbw_rng1_base);
+	WREG32(mmTPC1_RTR_LBW_RANGE_MASK_1, lbw_rng1_mask);
+	WREG32(mmTPC1_RTR_LBW_RANGE_BASE_2, lbw_rng2_base);
+	WREG32(mmTPC1_RTR_LBW_RANGE_MASK_2, lbw_rng2_mask);
+	WREG32(mmTPC1_RTR_LBW_RANGE_BASE_3, lbw_rng3_base);
+	WREG32(mmTPC1_RTR_LBW_RANGE_MASK_3, lbw_rng3_mask);
+	WREG32(mmTPC1_RTR_LBW_RANGE_BASE_4, lbw_rng4_base);
+	WREG32(mmTPC1_RTR_LBW_RANGE_MASK_4, lbw_rng4_mask);
+	WREG32(mmTPC1_RTR_LBW_RANGE_BASE_5, lbw_rng5_base);
+	WREG32(mmTPC1_RTR_LBW_RANGE_MASK_5, lbw_rng5_mask);
+	WREG32(mmTPC1_RTR_LBW_RANGE_BASE_6, lbw_rng6_base);
+	WREG32(mmTPC1_RTR_LBW_RANGE_MASK_6, lbw_rng6_mask);
+	WREG32(mmTPC1_RTR_LBW_RANGE_BASE_7, lbw_rng7_base);
+	WREG32(mmTPC1_RTR_LBW_RANGE_MASK_7, lbw_rng7_mask);
+	WREG32(mmTPC1_RTR_LBW_RANGE_BASE_8, lbw_rng8_base);
+	WREG32(mmTPC1_RTR_LBW_RANGE_MASK_8, lbw_rng8_mask);
+	WREG32(mmTPC1_RTR_LBW_RANGE_BASE_9, lbw_rng9_base);
+	WREG32(mmTPC1_RTR_LBW_RANGE_MASK_9, lbw_rng9_mask);
+	WREG32(mmTPC1_RTR_LBW_RANGE_BASE_10, lbw_rng10_base);
+	WREG32(mmTPC1_RTR_LBW_RANGE_MASK_10, lbw_rng10_mask);
+	WREG32(mmTPC1_RTR_LBW_RANGE_BASE_11, lbw_rng11_base);
+	WREG32(mmTPC1_RTR_LBW_RANGE_MASK_11, lbw_rng11_mask);
+	WREG32(mmTPC1_RTR_LBW_RANGE_BASE_12, lbw_rng12_base);
+	WREG32(mmTPC1_RTR_LBW_RANGE_MASK_12, lbw_rng12_mask);
+	WREG32(mmTPC1_RTR_LBW_RANGE_BASE_13, lbw_rng13_base);
+	WREG32(mmTPC1_RTR_LBW_RANGE_MASK_13, lbw_rng13_mask);
+
+	WREG32(mmTPC2_RTR_LBW_RANGE_HIT, 0xFFFF);
+	WREG32(mmTPC2_RTR_HBW_RANGE_HIT, 0xFE);
+
+	/* Protect HOST */
+	WREG32(mmTPC2_RTR_HBW_RANGE_BASE_L_0, 0);
+	WREG32(mmTPC2_RTR_HBW_RANGE_BASE_H_0, 0);
+	WREG32(mmTPC2_RTR_HBW_RANGE_MASK_L_0, 0);
+	WREG32(mmTPC2_RTR_HBW_RANGE_MASK_H_0, 0xFFF80);
+
+	/*
+	 * Protect DDR @
+	 * DRAM_VIRT_BASE : DRAM_VIRT_BASE + DRAM_VIRT_END
+	 * The mask protects the first 512MB
+	 */
+	WREG32(mmTPC2_RTR_HBW_RANGE_BASE_L_1, dram_addr_lo);
+	WREG32(mmTPC2_RTR_HBW_RANGE_BASE_H_1, dram_addr_hi);
+	WREG32(mmTPC2_RTR_HBW_RANGE_MASK_L_1, 0xE0000000);
+	WREG32(mmTPC2_RTR_HBW_RANGE_MASK_H_1, 0x3FFFF);
+
+	WREG32(mmTPC2_RTR_LBW_RANGE_BASE_0, lbw_rng0_base);
+	WREG32(mmTPC2_RTR_LBW_RANGE_MASK_0, lbw_rng0_mask);
+	WREG32(mmTPC2_RTR_LBW_RANGE_BASE_1, lbw_rng1_base);
+	WREG32(mmTPC2_RTR_LBW_RANGE_MASK_1, lbw_rng1_mask);
+	WREG32(mmTPC2_RTR_LBW_RANGE_BASE_2, lbw_rng2_base);
+	WREG32(mmTPC2_RTR_LBW_RANGE_MASK_2, lbw_rng2_mask);
+	WREG32(mmTPC2_RTR_LBW_RANGE_BASE_3, lbw_rng3_base);
+	WREG32(mmTPC2_RTR_LBW_RANGE_MASK_3, lbw_rng3_mask);
+	WREG32(mmTPC2_RTR_LBW_RANGE_BASE_4, lbw_rng4_base);
+	WREG32(mmTPC2_RTR_LBW_RANGE_MASK_4, lbw_rng4_mask);
+	WREG32(mmTPC2_RTR_LBW_RANGE_BASE_5, lbw_rng5_base);
+	WREG32(mmTPC2_RTR_LBW_RANGE_MASK_5, lbw_rng5_mask);
+	WREG32(mmTPC2_RTR_LBW_RANGE_BASE_6, lbw_rng6_base);
+	WREG32(mmTPC2_RTR_LBW_RANGE_MASK_6, lbw_rng6_mask);
+	WREG32(mmTPC2_RTR_LBW_RANGE_BASE_7, lbw_rng7_base);
+	WREG32(mmTPC2_RTR_LBW_RANGE_MASK_7, lbw_rng7_mask);
+	WREG32(mmTPC2_RTR_LBW_RANGE_BASE_8, lbw_rng8_base);
+	WREG32(mmTPC2_RTR_LBW_RANGE_MASK_8, lbw_rng8_mask);
+	WREG32(mmTPC2_RTR_LBW_RANGE_BASE_9, lbw_rng9_base);
+	WREG32(mmTPC2_RTR_LBW_RANGE_MASK_9, lbw_rng9_mask);
+	WREG32(mmTPC2_RTR_LBW_RANGE_BASE_10, lbw_rng10_base);
+	WREG32(mmTPC2_RTR_LBW_RANGE_MASK_10, lbw_rng10_mask);
+	WREG32(mmTPC2_RTR_LBW_RANGE_BASE_11, lbw_rng11_base);
+	WREG32(mmTPC2_RTR_LBW_RANGE_MASK_11, lbw_rng11_mask);
+	WREG32(mmTPC2_RTR_LBW_RANGE_BASE_12, lbw_rng12_base);
+	WREG32(mmTPC2_RTR_LBW_RANGE_MASK_12, lbw_rng12_mask);
+	WREG32(mmTPC2_RTR_LBW_RANGE_BASE_13, lbw_rng13_base);
+	WREG32(mmTPC2_RTR_LBW_RANGE_MASK_13, lbw_rng13_mask);
+
+	WREG32(mmTPC3_RTR_LBW_RANGE_HIT, 0xFFFF);
+	WREG32(mmTPC3_RTR_HBW_RANGE_HIT, 0xFE);
+
+	/* Protect HOST */
+	WREG32(mmTPC3_RTR_HBW_RANGE_BASE_L_0, 0);
+	WREG32(mmTPC3_RTR_HBW_RANGE_BASE_H_0, 0);
+	WREG32(mmTPC3_RTR_HBW_RANGE_MASK_L_0, 0);
+	WREG32(mmTPC3_RTR_HBW_RANGE_MASK_H_0, 0xFFF80);
+
+	/*
+	 * Protect DDR @
+	 * DRAM_VIRT_BASE : DRAM_VIRT_BASE + DRAM_VIRT_END
+	 * The mask protects the first 512MB
+	 */
+	WREG32(mmTPC3_RTR_HBW_RANGE_BASE_L_1, dram_addr_lo);
+	WREG32(mmTPC3_RTR_HBW_RANGE_BASE_H_1, dram_addr_hi);
+	WREG32(mmTPC3_RTR_HBW_RANGE_MASK_L_1, 0xE0000000);
+	WREG32(mmTPC3_RTR_HBW_RANGE_MASK_H_1, 0x3FFFF);
+
+	WREG32(mmTPC3_RTR_LBW_RANGE_BASE_0, lbw_rng0_base);
+	WREG32(mmTPC3_RTR_LBW_RANGE_MASK_0, lbw_rng0_mask);
+	WREG32(mmTPC3_RTR_LBW_RANGE_BASE_1, lbw_rng1_base);
+	WREG32(mmTPC3_RTR_LBW_RANGE_MASK_1, lbw_rng1_mask);
+	WREG32(mmTPC3_RTR_LBW_RANGE_BASE_2, lbw_rng2_base);
+	WREG32(mmTPC3_RTR_LBW_RANGE_MASK_2, lbw_rng2_mask);
+	WREG32(mmTPC3_RTR_LBW_RANGE_BASE_3, lbw_rng3_base);
+	WREG32(mmTPC3_RTR_LBW_RANGE_MASK_3, lbw_rng3_mask);
+	WREG32(mmTPC3_RTR_LBW_RANGE_BASE_4, lbw_rng4_base);
+	WREG32(mmTPC3_RTR_LBW_RANGE_MASK_4, lbw_rng4_mask);
+	WREG32(mmTPC3_RTR_LBW_RANGE_BASE_5, lbw_rng5_base);
+	WREG32(mmTPC3_RTR_LBW_RANGE_MASK_5, lbw_rng5_mask);
+	WREG32(mmTPC3_RTR_LBW_RANGE_BASE_6, lbw_rng6_base);
+	WREG32(mmTPC3_RTR_LBW_RANGE_MASK_6, lbw_rng6_mask);
+	WREG32(mmTPC3_RTR_LBW_RANGE_BASE_7, lbw_rng7_base);
+	WREG32(mmTPC3_RTR_LBW_RANGE_MASK_7, lbw_rng7_mask);
+	WREG32(mmTPC3_RTR_LBW_RANGE_BASE_8, lbw_rng8_base);
+	WREG32(mmTPC3_RTR_LBW_RANGE_MASK_8, lbw_rng8_mask);
+	WREG32(mmTPC3_RTR_LBW_RANGE_BASE_9, lbw_rng9_base);
+	WREG32(mmTPC3_RTR_LBW_RANGE_MASK_9, lbw_rng9_mask);
+	WREG32(mmTPC3_RTR_LBW_RANGE_BASE_10, lbw_rng10_base);
+	WREG32(mmTPC3_RTR_LBW_RANGE_MASK_10, lbw_rng10_mask);
+	WREG32(mmTPC3_RTR_LBW_RANGE_BASE_11, lbw_rng11_base);
+	WREG32(mmTPC3_RTR_LBW_RANGE_MASK_11, lbw_rng11_mask);
+	WREG32(mmTPC3_RTR_LBW_RANGE_BASE_12, lbw_rng12_base);
+	WREG32(mmTPC3_RTR_LBW_RANGE_MASK_12, lbw_rng12_mask);
+	WREG32(mmTPC3_RTR_LBW_RANGE_BASE_13, lbw_rng13_base);
+	WREG32(mmTPC3_RTR_LBW_RANGE_MASK_13, lbw_rng13_mask);
+
+	WREG32(mmTPC4_RTR_LBW_RANGE_HIT, 0xFFFF);
+	WREG32(mmTPC4_RTR_HBW_RANGE_HIT, 0xFE);
+
+	/* Protect HOST */
+	WREG32(mmTPC4_RTR_HBW_RANGE_BASE_L_0, 0);
+	WREG32(mmTPC4_RTR_HBW_RANGE_BASE_H_0, 0);
+	WREG32(mmTPC4_RTR_HBW_RANGE_MASK_L_0, 0);
+	WREG32(mmTPC4_RTR_HBW_RANGE_MASK_H_0, 0xFFF80);
+
+	/*
+	 * Protect DDR @
+	 * DRAM_VIRT_BASE : DRAM_VIRT_BASE + DRAM_VIRT_END
+	 * The mask protects the first 512MB
+	 */
+	WREG32(mmTPC4_RTR_HBW_RANGE_BASE_L_1, dram_addr_lo);
+	WREG32(mmTPC4_RTR_HBW_RANGE_BASE_H_1, dram_addr_hi);
+	WREG32(mmTPC4_RTR_HBW_RANGE_MASK_L_1, 0xE0000000);
+	WREG32(mmTPC4_RTR_HBW_RANGE_MASK_H_1, 0x3FFFF);
+
+	WREG32(mmTPC4_RTR_LBW_RANGE_BASE_0, lbw_rng0_base);
+	WREG32(mmTPC4_RTR_LBW_RANGE_MASK_0, lbw_rng0_mask);
+	WREG32(mmTPC4_RTR_LBW_RANGE_BASE_1, lbw_rng1_base);
+	WREG32(mmTPC4_RTR_LBW_RANGE_MASK_1, lbw_rng1_mask);
+	WREG32(mmTPC4_RTR_LBW_RANGE_BASE_2, lbw_rng2_base);
+	WREG32(mmTPC4_RTR_LBW_RANGE_MASK_2, lbw_rng2_mask);
+	WREG32(mmTPC4_RTR_LBW_RANGE_BASE_3, lbw_rng3_base);
+	WREG32(mmTPC4_RTR_LBW_RANGE_MASK_3, lbw_rng3_mask);
+	WREG32(mmTPC4_RTR_LBW_RANGE_BASE_4, lbw_rng4_base);
+	WREG32(mmTPC4_RTR_LBW_RANGE_MASK_4, lbw_rng4_mask);
+	WREG32(mmTPC4_RTR_LBW_RANGE_BASE_5, lbw_rng5_base);
+	WREG32(mmTPC4_RTR_LBW_RANGE_MASK_5, lbw_rng5_mask);
+	WREG32(mmTPC4_RTR_LBW_RANGE_BASE_6, lbw_rng6_base);
+	WREG32(mmTPC4_RTR_LBW_RANGE_MASK_6, lbw_rng6_mask);
+	WREG32(mmTPC4_RTR_LBW_RANGE_BASE_7, lbw_rng7_base);
+	WREG32(mmTPC4_RTR_LBW_RANGE_MASK_7, lbw_rng7_mask);
+	WREG32(mmTPC4_RTR_LBW_RANGE_BASE_8, lbw_rng8_base);
+	WREG32(mmTPC4_RTR_LBW_RANGE_MASK_8, lbw_rng8_mask);
+	WREG32(mmTPC4_RTR_LBW_RANGE_BASE_9, lbw_rng9_base);
+	WREG32(mmTPC4_RTR_LBW_RANGE_MASK_9, lbw_rng9_mask);
+	WREG32(mmTPC4_RTR_LBW_RANGE_BASE_10, lbw_rng10_base);
+	WREG32(mmTPC4_RTR_LBW_RANGE_MASK_10, lbw_rng10_mask);
+	WREG32(mmTPC4_RTR_LBW_RANGE_BASE_11, lbw_rng11_base);
+	WREG32(mmTPC4_RTR_LBW_RANGE_MASK_11, lbw_rng11_mask);
+	WREG32(mmTPC4_RTR_LBW_RANGE_BASE_12, lbw_rng12_base);
+	WREG32(mmTPC4_RTR_LBW_RANGE_MASK_12, lbw_rng12_mask);
+	WREG32(mmTPC4_RTR_LBW_RANGE_BASE_13, lbw_rng13_base);
+	WREG32(mmTPC4_RTR_LBW_RANGE_MASK_13, lbw_rng13_mask);
+
+	WREG32(mmTPC5_RTR_LBW_RANGE_HIT, 0xFFFF);
+	WREG32(mmTPC5_RTR_HBW_RANGE_HIT, 0xFE);
+
+	/* Protect HOST */
+	WREG32(mmTPC5_RTR_HBW_RANGE_BASE_L_0, 0);
+	WREG32(mmTPC5_RTR_HBW_RANGE_BASE_H_0, 0);
+	WREG32(mmTPC5_RTR_HBW_RANGE_MASK_L_0, 0);
+	WREG32(mmTPC5_RTR_HBW_RANGE_MASK_H_0, 0xFFF80);
+
+	/*
+	 * Protect DDR @
+	 * DRAM_VIRT_BASE : DRAM_VIRT_BASE + DRAM_VIRT_END
+	 * The mask protects the first 512MB
+	 */
+	WREG32(mmTPC5_RTR_HBW_RANGE_BASE_L_1, dram_addr_lo);
+	WREG32(mmTPC5_RTR_HBW_RANGE_BASE_H_1, dram_addr_hi);
+	WREG32(mmTPC5_RTR_HBW_RANGE_MASK_L_1, 0xE0000000);
+	WREG32(mmTPC5_RTR_HBW_RANGE_MASK_H_1, 0x3FFFF);
+
+	WREG32(mmTPC5_RTR_LBW_RANGE_BASE_0, lbw_rng0_base);
+	WREG32(mmTPC5_RTR_LBW_RANGE_MASK_0, lbw_rng0_mask);
+	WREG32(mmTPC5_RTR_LBW_RANGE_BASE_1, lbw_rng1_base);
+	WREG32(mmTPC5_RTR_LBW_RANGE_MASK_1, lbw_rng1_mask);
+	WREG32(mmTPC5_RTR_LBW_RANGE_BASE_2, lbw_rng2_base);
+	WREG32(mmTPC5_RTR_LBW_RANGE_MASK_2, lbw_rng2_mask);
+	WREG32(mmTPC5_RTR_LBW_RANGE_BASE_3, lbw_rng3_base);
+	WREG32(mmTPC5_RTR_LBW_RANGE_MASK_3, lbw_rng3_mask);
+	WREG32(mmTPC5_RTR_LBW_RANGE_BASE_4, lbw_rng4_base);
+	WREG32(mmTPC5_RTR_LBW_RANGE_MASK_4, lbw_rng4_mask);
+	WREG32(mmTPC5_RTR_LBW_RANGE_BASE_5, lbw_rng5_base);
+	WREG32(mmTPC5_RTR_LBW_RANGE_MASK_5, lbw_rng5_mask);
+	WREG32(mmTPC5_RTR_LBW_RANGE_BASE_6, lbw_rng6_base);
+	WREG32(mmTPC5_RTR_LBW_RANGE_MASK_6, lbw_rng6_mask);
+	WREG32(mmTPC5_RTR_LBW_RANGE_BASE_7, lbw_rng7_base);
+	WREG32(mmTPC5_RTR_LBW_RANGE_MASK_7, lbw_rng7_mask);
+	WREG32(mmTPC5_RTR_LBW_RANGE_BASE_8, lbw_rng8_base);
+	WREG32(mmTPC5_RTR_LBW_RANGE_MASK_8, lbw_rng8_mask);
+	WREG32(mmTPC5_RTR_LBW_RANGE_BASE_9, lbw_rng9_base);
+	WREG32(mmTPC5_RTR_LBW_RANGE_MASK_9, lbw_rng9_mask);
+	WREG32(mmTPC5_RTR_LBW_RANGE_BASE_10, lbw_rng10_base);
+	WREG32(mmTPC5_RTR_LBW_RANGE_MASK_10, lbw_rng10_mask);
+	WREG32(mmTPC5_RTR_LBW_RANGE_BASE_11, lbw_rng11_base);
+	WREG32(mmTPC5_RTR_LBW_RANGE_MASK_11, lbw_rng11_mask);
+	WREG32(mmTPC5_RTR_LBW_RANGE_BASE_12, lbw_rng12_base);
+	WREG32(mmTPC5_RTR_LBW_RANGE_MASK_12, lbw_rng12_mask);
+	WREG32(mmTPC5_RTR_LBW_RANGE_BASE_13, lbw_rng13_base);
+	WREG32(mmTPC5_RTR_LBW_RANGE_MASK_13, lbw_rng13_mask);
+
+	WREG32(mmTPC6_RTR_LBW_RANGE_HIT, 0xFFFF);
+	WREG32(mmTPC6_RTR_HBW_RANGE_HIT, 0xFE);
+
+	/* Protect HOST */
+	WREG32(mmTPC6_RTR_HBW_RANGE_BASE_L_0, 0);
+	WREG32(mmTPC6_RTR_HBW_RANGE_BASE_H_0, 0);
+	WREG32(mmTPC6_RTR_HBW_RANGE_MASK_L_0, 0);
+	WREG32(mmTPC6_RTR_HBW_RANGE_MASK_H_0, 0xFFF80);
+
+	/*
+	 * Protect DDR @
+	 * DRAM_VIRT_BASE : DRAM_VIRT_BASE + DRAM_VIRT_END
+	 * The mask protects the first 512MB
+	 */
+	WREG32(mmTPC6_RTR_HBW_RANGE_BASE_L_1, dram_addr_lo);
+	WREG32(mmTPC6_RTR_HBW_RANGE_BASE_H_1, dram_addr_hi);
+	WREG32(mmTPC6_RTR_HBW_RANGE_MASK_L_1, 0xE0000000);
+	WREG32(mmTPC6_RTR_HBW_RANGE_MASK_H_1, 0x3FFFF);
+
+	WREG32(mmTPC6_RTR_LBW_RANGE_BASE_0, lbw_rng0_base);
+	WREG32(mmTPC6_RTR_LBW_RANGE_MASK_0, lbw_rng0_mask);
+	WREG32(mmTPC6_RTR_LBW_RANGE_BASE_1, lbw_rng1_base);
+	WREG32(mmTPC6_RTR_LBW_RANGE_MASK_1, lbw_rng1_mask);
+	WREG32(mmTPC6_RTR_LBW_RANGE_BASE_2, lbw_rng2_base);
+	WREG32(mmTPC6_RTR_LBW_RANGE_MASK_2, lbw_rng2_mask);
+	WREG32(mmTPC6_RTR_LBW_RANGE_BASE_3, lbw_rng3_base);
+	WREG32(mmTPC6_RTR_LBW_RANGE_MASK_3, lbw_rng3_mask);
+	WREG32(mmTPC6_RTR_LBW_RANGE_BASE_4, lbw_rng4_base);
+	WREG32(mmTPC6_RTR_LBW_RANGE_MASK_4, lbw_rng4_mask);
+	WREG32(mmTPC6_RTR_LBW_RANGE_BASE_5, lbw_rng5_base);
+	WREG32(mmTPC6_RTR_LBW_RANGE_MASK_5, lbw_rng5_mask);
+	WREG32(mmTPC6_RTR_LBW_RANGE_BASE_6, lbw_rng6_base);
+	WREG32(mmTPC6_RTR_LBW_RANGE_MASK_6, lbw_rng6_mask);
+	WREG32(mmTPC6_RTR_LBW_RANGE_BASE_7, lbw_rng7_base);
+	WREG32(mmTPC6_RTR_LBW_RANGE_MASK_7, lbw_rng7_mask);
+	WREG32(mmTPC6_RTR_LBW_RANGE_BASE_8, lbw_rng8_base);
+	WREG32(mmTPC6_RTR_LBW_RANGE_MASK_8, lbw_rng8_mask);
+	WREG32(mmTPC6_RTR_LBW_RANGE_BASE_9, lbw_rng9_base);
+	WREG32(mmTPC6_RTR_LBW_RANGE_MASK_9, lbw_rng9_mask);
+	WREG32(mmTPC6_RTR_LBW_RANGE_BASE_10, lbw_rng10_base);
+	WREG32(mmTPC6_RTR_LBW_RANGE_MASK_10, lbw_rng10_mask);
+	WREG32(mmTPC6_RTR_LBW_RANGE_BASE_11, lbw_rng11_base);
+	WREG32(mmTPC6_RTR_LBW_RANGE_MASK_11, lbw_rng11_mask);
+	WREG32(mmTPC6_RTR_LBW_RANGE_BASE_12, lbw_rng12_base);
+	WREG32(mmTPC6_RTR_LBW_RANGE_MASK_12, lbw_rng12_mask);
+	WREG32(mmTPC6_RTR_LBW_RANGE_BASE_13, lbw_rng13_base);
+	WREG32(mmTPC6_RTR_LBW_RANGE_MASK_13, lbw_rng13_mask);
+
+	WREG32(mmTPC7_NRTR_LBW_RANGE_HIT, 0xFFFF);
+	WREG32(mmTPC7_NRTR_HBW_RANGE_HIT, 0xFE);
+
+	/* Protect HOST */
+	WREG32(mmTPC7_NRTR_HBW_RANGE_BASE_L_0, 0);
+	WREG32(mmTPC7_NRTR_HBW_RANGE_BASE_H_0, 0);
+	WREG32(mmTPC7_NRTR_HBW_RANGE_MASK_L_0, 0);
+	WREG32(mmTPC7_NRTR_HBW_RANGE_MASK_H_0, 0xFFF80);
+
+	/*
+	 * Protect DDR @
+	 * DRAM_VIRT_BASE : DRAM_VIRT_BASE + DRAM_VIRT_END
+	 * The mask protects the first 512MB
+	 */
+	WREG32(mmTPC7_NRTR_HBW_RANGE_BASE_L_1, dram_addr_lo);
+	WREG32(mmTPC7_NRTR_HBW_RANGE_BASE_H_1, dram_addr_hi);
+	WREG32(mmTPC7_NRTR_HBW_RANGE_MASK_L_1, 0xE0000000);
+	WREG32(mmTPC7_NRTR_HBW_RANGE_MASK_H_1, 0x3FFFF);
+
+	WREG32(mmTPC7_NRTR_LBW_RANGE_BASE_0, lbw_rng0_base);
+	WREG32(mmTPC7_NRTR_LBW_RANGE_MASK_0, lbw_rng0_mask);
+	WREG32(mmTPC7_NRTR_LBW_RANGE_BASE_1, lbw_rng1_base);
+	WREG32(mmTPC7_NRTR_LBW_RANGE_MASK_1, lbw_rng1_mask);
+	WREG32(mmTPC7_NRTR_LBW_RANGE_BASE_2, lbw_rng2_base);
+	WREG32(mmTPC7_NRTR_LBW_RANGE_MASK_2, lbw_rng2_mask);
+	WREG32(mmTPC7_NRTR_LBW_RANGE_BASE_3, lbw_rng3_base);
+	WREG32(mmTPC7_NRTR_LBW_RANGE_MASK_3, lbw_rng3_mask);
+	WREG32(mmTPC7_NRTR_LBW_RANGE_BASE_4, lbw_rng4_base);
+	WREG32(mmTPC7_NRTR_LBW_RANGE_MASK_4, lbw_rng4_mask);
+	WREG32(mmTPC7_NRTR_LBW_RANGE_BASE_5, lbw_rng5_base);
+	WREG32(mmTPC7_NRTR_LBW_RANGE_MASK_5, lbw_rng5_mask);
+	WREG32(mmTPC7_NRTR_LBW_RANGE_BASE_6, lbw_rng6_base);
+	WREG32(mmTPC7_NRTR_LBW_RANGE_MASK_6, lbw_rng6_mask);
+	WREG32(mmTPC7_NRTR_LBW_RANGE_BASE_7, lbw_rng7_base);
+	WREG32(mmTPC7_NRTR_LBW_RANGE_MASK_7, lbw_rng7_mask);
+	WREG32(mmTPC7_NRTR_LBW_RANGE_BASE_8, lbw_rng8_base);
+	WREG32(mmTPC7_NRTR_LBW_RANGE_MASK_8, lbw_rng8_mask);
+	WREG32(mmTPC7_NRTR_LBW_RANGE_BASE_9, lbw_rng9_base);
+	WREG32(mmTPC7_NRTR_LBW_RANGE_MASK_9, lbw_rng9_mask);
+	WREG32(mmTPC7_NRTR_LBW_RANGE_BASE_10, lbw_rng10_base);
+	WREG32(mmTPC7_NRTR_LBW_RANGE_MASK_10, lbw_rng10_mask);
+	WREG32(mmTPC7_NRTR_LBW_RANGE_BASE_11, lbw_rng11_base);
+	WREG32(mmTPC7_NRTR_LBW_RANGE_MASK_11, lbw_rng11_mask);
+	WREG32(mmTPC7_NRTR_LBW_RANGE_BASE_12, lbw_rng12_base);
+	WREG32(mmTPC7_NRTR_LBW_RANGE_MASK_12, lbw_rng12_mask);
+	WREG32(mmTPC7_NRTR_LBW_RANGE_BASE_13, lbw_rng13_base);
+	WREG32(mmTPC7_NRTR_LBW_RANGE_MASK_13, lbw_rng13_mask);
+
+	goya_init_protection_bits(hdev);
+}
diff --git a/drivers/misc/habanalabs/habanalabs.h b/drivers/misc/habanalabs/habanalabs.h
index 6ad476df65b0..adda281ec2af 100644
--- a/drivers/misc/habanalabs/habanalabs.h
+++ b/drivers/misc/habanalabs/habanalabs.h
@@ -23,6 +23,8 @@
 
 #define HL_MMAP_CB_MASK			(0x8000000000000000ull >> PAGE_SHIFT)
 
+#define HL_DEVICE_TIMEOUT_USEC		1000000 /* 1 s */
+
 #define HL_MAX_QUEUES			128
 
 struct hl_device;
@@ -32,6 +34,8 @@ struct hl_fpriv;
 
 /**
  * struct asic_fixed_properties - ASIC specific immutable properties.
+ * @uboot_ver: F/W U-boot version.
+ * @preboot_ver: F/W Preboot version.
  * @sram_base_address: SRAM physical start address.
  * @sram_end_address: SRAM physical end address.
  * @sram_user_base_address - SRAM physical start address for user access.
@@ -60,6 +64,8 @@ struct hl_fpriv;
  * @tpc_enabled_mask: which TPCs are enabled.
  */
 struct asic_fixed_properties {
+	char			uboot_ver[VERSION_MAX_LEN];
+	char			preboot_ver[VERSION_MAX_LEN];
 	u64			sram_base_address;
 	u64			sram_end_address;
 	u64			sram_user_base_address;
@@ -168,6 +174,8 @@ enum hl_asic_type {
  * @early_fini: tears down what was done in early_init.
  * @sw_init: sets up driver state, does not configure H/W.
  * @sw_fini: tears down driver state, does not configure H/W.
+ * @hw_init: sets up the H/W state.
+ * @hw_fini: tears down the H/W state.
  * @suspend: handles IP specific H/W or SW changes for suspend.
  * @resume: handles IP specific H/W or SW changes for resume.
  * @mmap: mmap function, does nothing.
@@ -180,6 +188,8 @@ struct hl_asic_funcs {
 	int (*early_fini)(struct hl_device *hdev);
 	int (*sw_init)(struct hl_device *hdev);
 	int (*sw_fini)(struct hl_device *hdev);
+	int (*hw_init)(struct hl_device *hdev);
+	void (*hw_fini)(struct hl_device *hdev, bool hard_reset);
 	int (*suspend)(struct hl_device *hdev);
 	int (*resume)(struct hl_device *hdev);
 	int (*mmap)(struct hl_fpriv *hpriv, struct vm_area_struct *vma);
@@ -312,6 +322,7 @@ void hl_wreg(struct hl_device *hdev, u32 reg, u32 val);
  * @cpu_accessible_dma_mem: KMD <-> ArmCP shared memory CPU address.
  * @cpu_accessible_dma_address: KMD <-> ArmCP shared memory DMA address.
  * @cpu_accessible_dma_pool: KMD <-> ArmCP shared memory pool.
+ * @spl_fw: image to load to ArmCP.
  * @asid_bitmap: holds used/available ASIDs.
  * @asid_mutex: protects asid_bitmap.
  * @device_open: lock for sanity checks upon FD open.
@@ -340,6 +351,7 @@ struct hl_device {
 	void				*cpu_accessible_dma_mem;
 	dma_addr_t			cpu_accessible_dma_address;
 	struct gen_pool			*cpu_accessible_dma_pool;
+	const struct firmware		*spl_fw;
 	unsigned long			*asid_bitmap;
 	struct mutex			asid_mutex;
 	/* TODO: change to rw_sem for multiple contexts (same as other IOCTL) */
@@ -359,7 +371,11 @@ struct hl_device {
 	u8				disabled;
 
 	/* Parameters for bring-up */
+	u8				cpu_enable;
 	u8				reset_pcilink;
+	u8				config_pll;
+	u8				fw_loading;
+	u8				pldm;
 };
 
 /*
diff --git a/drivers/misc/habanalabs/habanalabs_drv.c b/drivers/misc/habanalabs/habanalabs_drv.c
index 5c312dd3aa50..bd80683118d3 100644
--- a/drivers/misc/habanalabs/habanalabs_drv.c
+++ b/drivers/misc/habanalabs/habanalabs_drv.c
@@ -181,7 +181,15 @@ int create_hdev(struct hl_device **dev, struct pci_dev *pdev,
 	hdev->major = hl_major;
 
 	/* Parameters for bring-up - set them to defaults */
+	hdev->cpu_enable = 1;
 	hdev->reset_pcilink = 0;
+	hdev->config_pll = 0;
+	hdev->fw_loading = 1;
+	hdev->pldm = 0;
+
+	/* If CPU is disabled, no point in loading FW */
+	if (!hdev->cpu_enable)
+		hdev->fw_loading = 0;
 
 	hdev->disabled = true;
 	hdev->pdev = pdev; /* can be NULL in case of simulator device */
diff --git a/drivers/misc/habanalabs/include/goya/goya.h b/drivers/misc/habanalabs/include/goya/goya.h
index 192a1450cbb1..2d0efb7b44bb 100644
--- a/drivers/misc/habanalabs/include/goya/goya.h
+++ b/drivers/misc/habanalabs/include/goya/goya.h
@@ -11,6 +11,7 @@
 #define GOYA_H
 
 #include "asic_reg/goya_regs.h"
+#include "goya_async_events.h"
 
 #include <linux/types.h>
 
diff --git a/drivers/misc/habanalabs/include/goya/goya_async_events.h b/drivers/misc/habanalabs/include/goya/goya_async_events.h
new file mode 100644
index 000000000000..497937a17ee9
--- /dev/null
+++ b/drivers/misc/habanalabs/include/goya/goya_async_events.h
@@ -0,0 +1,186 @@
+/* SPDX-License-Identifier: GPL-2.0
+ *
+ * Copyright 2018 HabanaLabs, Ltd.
+ * All Rights Reserved.
+ *
+ */
+
+#ifndef __GOYA_ASYNC_EVENTS_H_
+#define __GOYA_ASYNC_EVENTS_H_
+
+enum goya_async_event_id {
+	GOYA_ASYNC_EVENT_ID_PCIE_IF = 33,
+	GOYA_ASYNC_EVENT_ID_TPC0_ECC = 36,
+	GOYA_ASYNC_EVENT_ID_TPC1_ECC = 39,
+	GOYA_ASYNC_EVENT_ID_TPC2_ECC = 42,
+	GOYA_ASYNC_EVENT_ID_TPC3_ECC = 45,
+	GOYA_ASYNC_EVENT_ID_TPC4_ECC = 48,
+	GOYA_ASYNC_EVENT_ID_TPC5_ECC = 51,
+	GOYA_ASYNC_EVENT_ID_TPC6_ECC = 54,
+	GOYA_ASYNC_EVENT_ID_TPC7_ECC = 57,
+	GOYA_ASYNC_EVENT_ID_MME_ECC = 60,
+	GOYA_ASYNC_EVENT_ID_MME_ECC_EXT = 61,
+	GOYA_ASYNC_EVENT_ID_MMU_ECC = 63,
+	GOYA_ASYNC_EVENT_ID_DMA_MACRO = 64,
+	GOYA_ASYNC_EVENT_ID_DMA_ECC = 66,
+	GOYA_ASYNC_EVENT_ID_CPU_IF_ECC = 75,
+	GOYA_ASYNC_EVENT_ID_PSOC_MEM = 78,
+	GOYA_ASYNC_EVENT_ID_PSOC_CORESIGHT = 79,
+	GOYA_ASYNC_EVENT_ID_SRAM0 = 81,
+	GOYA_ASYNC_EVENT_ID_SRAM1 = 82,
+	GOYA_ASYNC_EVENT_ID_SRAM2 = 83,
+	GOYA_ASYNC_EVENT_ID_SRAM3 = 84,
+	GOYA_ASYNC_EVENT_ID_SRAM4 = 85,
+	GOYA_ASYNC_EVENT_ID_SRAM5 = 86,
+	GOYA_ASYNC_EVENT_ID_SRAM6 = 87,
+	GOYA_ASYNC_EVENT_ID_SRAM7 = 88,
+	GOYA_ASYNC_EVENT_ID_SRAM8 = 89,
+	GOYA_ASYNC_EVENT_ID_SRAM9 = 90,
+	GOYA_ASYNC_EVENT_ID_SRAM10 = 91,
+	GOYA_ASYNC_EVENT_ID_SRAM11 = 92,
+	GOYA_ASYNC_EVENT_ID_SRAM12 = 93,
+	GOYA_ASYNC_EVENT_ID_SRAM13 = 94,
+	GOYA_ASYNC_EVENT_ID_SRAM14 = 95,
+	GOYA_ASYNC_EVENT_ID_SRAM15 = 96,
+	GOYA_ASYNC_EVENT_ID_SRAM16 = 97,
+	GOYA_ASYNC_EVENT_ID_SRAM17 = 98,
+	GOYA_ASYNC_EVENT_ID_SRAM18 = 99,
+	GOYA_ASYNC_EVENT_ID_SRAM19 = 100,
+	GOYA_ASYNC_EVENT_ID_SRAM20 = 101,
+	GOYA_ASYNC_EVENT_ID_SRAM21 = 102,
+	GOYA_ASYNC_EVENT_ID_SRAM22 = 103,
+	GOYA_ASYNC_EVENT_ID_SRAM23 = 104,
+	GOYA_ASYNC_EVENT_ID_SRAM24 = 105,
+	GOYA_ASYNC_EVENT_ID_SRAM25 = 106,
+	GOYA_ASYNC_EVENT_ID_SRAM26 = 107,
+	GOYA_ASYNC_EVENT_ID_SRAM27 = 108,
+	GOYA_ASYNC_EVENT_ID_SRAM28 = 109,
+	GOYA_ASYNC_EVENT_ID_SRAM29 = 110,
+	GOYA_ASYNC_EVENT_ID_GIC500 = 112,
+	GOYA_ASYNC_EVENT_ID_PCIE_DEC = 115,
+	GOYA_ASYNC_EVENT_ID_TPC0_DEC = 117,
+	GOYA_ASYNC_EVENT_ID_TPC1_DEC = 120,
+	GOYA_ASYNC_EVENT_ID_TPC2_DEC = 123,
+	GOYA_ASYNC_EVENT_ID_TPC3_DEC = 126,
+	GOYA_ASYNC_EVENT_ID_TPC4_DEC = 129,
+	GOYA_ASYNC_EVENT_ID_TPC5_DEC = 132,
+	GOYA_ASYNC_EVENT_ID_TPC6_DEC = 135,
+	GOYA_ASYNC_EVENT_ID_TPC7_DEC = 138,
+	GOYA_ASYNC_EVENT_ID_AXI_ECC = 139,
+	GOYA_ASYNC_EVENT_ID_L2_RAM_ECC = 140,
+	GOYA_ASYNC_EVENT_ID_MME_WACS = 141,
+	GOYA_ASYNC_EVENT_ID_MME_WACSD = 142,
+	GOYA_ASYNC_EVENT_ID_PLL0 = 143,
+	GOYA_ASYNC_EVENT_ID_PLL1 = 144,
+	GOYA_ASYNC_EVENT_ID_PLL3 = 146,
+	GOYA_ASYNC_EVENT_ID_PLL4 = 147,
+	GOYA_ASYNC_EVENT_ID_PLL5 = 148,
+	GOYA_ASYNC_EVENT_ID_PLL6 = 149,
+	GOYA_ASYNC_EVENT_ID_CPU_AXI_SPLITTER = 155,
+	GOYA_ASYNC_EVENT_ID_PSOC_AXI_DEC = 159,
+	GOYA_ASYNC_EVENT_ID_PSOC = 160,
+	GOYA_ASYNC_EVENT_ID_PCIE_FLR = 171,
+	GOYA_ASYNC_EVENT_ID_PCIE_HOT_RESET = 172,
+	GOYA_ASYNC_EVENT_ID_PCIE_QID0_ENG0 = 174,
+	GOYA_ASYNC_EVENT_ID_PCIE_QID0_ENG1 = 175,
+	GOYA_ASYNC_EVENT_ID_PCIE_QID0_ENG2 = 176,
+	GOYA_ASYNC_EVENT_ID_PCIE_QID0_ENG3 = 177,
+	GOYA_ASYNC_EVENT_ID_PCIE_QID1_ENG0 = 178,
+	GOYA_ASYNC_EVENT_ID_PCIE_QID1_ENG1 = 179,
+	GOYA_ASYNC_EVENT_ID_PCIE_QID1_ENG2 = 180,
+	GOYA_ASYNC_EVENT_ID_PCIE_QID1_ENG3 = 181,
+	GOYA_ASYNC_EVENT_ID_PCIE_APB = 182,
+	GOYA_ASYNC_EVENT_ID_PCIE_QDB = 183,
+	GOYA_ASYNC_EVENT_ID_PCIE_BM_D_P_WR = 184,
+	GOYA_ASYNC_EVENT_ID_PCIE_BM_D_RD = 185,
+	GOYA_ASYNC_EVENT_ID_PCIE_BM_U_P_WR = 186,
+	GOYA_ASYNC_EVENT_ID_PCIE_BM_U_RD = 187,
+	GOYA_ASYNC_EVENT_ID_TPC0_BMON_SPMU = 190,
+	GOYA_ASYNC_EVENT_ID_TPC0_KRN_ERR = 191,
+	GOYA_ASYNC_EVENT_ID_TPC1_BMON_SPMU = 200,
+	GOYA_ASYNC_EVENT_ID_TPC1_KRN_ERR = 201,
+	GOYA_ASYNC_EVENT_ID_TPC2_BMON_SPMU = 210,
+	GOYA_ASYNC_EVENT_ID_TPC2_KRN_ERR = 211,
+	GOYA_ASYNC_EVENT_ID_TPC3_BMON_SPMU = 220,
+	GOYA_ASYNC_EVENT_ID_TPC3_KRN_ERR = 221,
+	GOYA_ASYNC_EVENT_ID_TPC4_BMON_SPMU = 230,
+	GOYA_ASYNC_EVENT_ID_TPC4_KRN_ERR = 231,
+	GOYA_ASYNC_EVENT_ID_TPC5_BMON_SPMU = 240,
+	GOYA_ASYNC_EVENT_ID_TPC5_KRN_ERR = 241,
+	GOYA_ASYNC_EVENT_ID_TPC6_BMON_SPMU = 250,
+	GOYA_ASYNC_EVENT_ID_TPC6_KRN_ERR = 251,
+	GOYA_ASYNC_EVENT_ID_TPC7_BMON_SPMU = 260,
+	GOYA_ASYNC_EVENT_ID_TPC7_KRN_ERR = 261,
+	GOYA_ASYNC_EVENT_ID_MMU_SBA_SPMU0 = 270,
+	GOYA_ASYNC_EVENT_ID_MMU_SBA_SPMU1 = 271,
+	GOYA_ASYNC_EVENT_ID_MME_WACS_UP = 272,
+	GOYA_ASYNC_EVENT_ID_MME_WACS_DOWN = 273,
+	GOYA_ASYNC_EVENT_ID_MMU_PAGE_FAULT = 280,
+	GOYA_ASYNC_EVENT_ID_MMU_WR_PERM = 281,
+	GOYA_ASYNC_EVENT_ID_MMU_DBG_BM = 282,
+	GOYA_ASYNC_EVENT_ID_DMA_BM_CH0 = 290,
+	GOYA_ASYNC_EVENT_ID_DMA_BM_CH1 = 291,
+	GOYA_ASYNC_EVENT_ID_DMA_BM_CH2 = 292,
+	GOYA_ASYNC_EVENT_ID_DMA_BM_CH3 = 293,
+	GOYA_ASYNC_EVENT_ID_DMA_BM_CH4 = 294,
+	GOYA_ASYNC_EVENT_ID_DDR0_PHY_DFI = 300,
+	GOYA_ASYNC_EVENT_ID_DDR0_ECC_SCRUB = 301,
+	GOYA_ASYNC_EVENT_ID_DDR0_DB_ECC = 302,
+	GOYA_ASYNC_EVENT_ID_DDR0_SB_ECC = 303,
+	GOYA_ASYNC_EVENT_ID_DDR0_SB_ECC_MC = 304,
+	GOYA_ASYNC_EVENT_ID_DDR0_AXI_RD = 305,
+	GOYA_ASYNC_EVENT_ID_DDR0_AXI_WR = 306,
+	GOYA_ASYNC_EVENT_ID_DDR1_PHY_DFI = 310,
+	GOYA_ASYNC_EVENT_ID_DDR1_ECC_SCRUB = 311,
+	GOYA_ASYNC_EVENT_ID_DDR1_DB_ECC = 312,
+	GOYA_ASYNC_EVENT_ID_DDR1_SB_ECC = 313,
+	GOYA_ASYNC_EVENT_ID_DDR1_SB_ECC_MC = 314,
+	GOYA_ASYNC_EVENT_ID_DDR1_AXI_RD = 315,
+	GOYA_ASYNC_EVENT_ID_DDR1_AXI_WR = 316,
+	GOYA_ASYNC_EVENT_ID_CPU_BMON = 320,
+	GOYA_ASYNC_EVENT_ID_TS_EAST = 322,
+	GOYA_ASYNC_EVENT_ID_TS_WEST = 323,
+	GOYA_ASYNC_EVENT_ID_TS_NORTH = 324,
+	GOYA_ASYNC_EVENT_ID_PSOC_GPIO_U16_0 = 330,
+	GOYA_ASYNC_EVENT_ID_PSOC_GPIO_U16_1 = 331,
+	GOYA_ASYNC_EVENT_ID_PSOC_GPIO_U16_2 = 332,
+	GOYA_ASYNC_EVENT_ID_PSOC_GPIO_05_SW_RESET = 356,
+	GOYA_ASYNC_EVENT_ID_PSOC_GPIO_10_VRHOT_ICRIT = 361,
+	GOYA_ASYNC_EVENT_ID_TPC0_CMDQ = 430,
+	GOYA_ASYNC_EVENT_ID_TPC1_CMDQ = 431,
+	GOYA_ASYNC_EVENT_ID_TPC2_CMDQ = 432,
+	GOYA_ASYNC_EVENT_ID_TPC3_CMDQ = 433,
+	GOYA_ASYNC_EVENT_ID_TPC4_CMDQ = 434,
+	GOYA_ASYNC_EVENT_ID_TPC5_CMDQ = 435,
+	GOYA_ASYNC_EVENT_ID_TPC6_CMDQ = 436,
+	GOYA_ASYNC_EVENT_ID_TPC7_CMDQ = 437,
+	GOYA_ASYNC_EVENT_ID_TPC0_QM = 438,
+	GOYA_ASYNC_EVENT_ID_TPC1_QM = 439,
+	GOYA_ASYNC_EVENT_ID_TPC2_QM = 440,
+	GOYA_ASYNC_EVENT_ID_TPC3_QM = 441,
+	GOYA_ASYNC_EVENT_ID_TPC4_QM = 442,
+	GOYA_ASYNC_EVENT_ID_TPC5_QM = 443,
+	GOYA_ASYNC_EVENT_ID_TPC6_QM = 444,
+	GOYA_ASYNC_EVENT_ID_TPC7_QM = 445,
+	GOYA_ASYNC_EVENT_ID_MME_QM = 447,
+	GOYA_ASYNC_EVENT_ID_MME_CMDQ = 448,
+	GOYA_ASYNC_EVENT_ID_DMA0_QM = 449,
+	GOYA_ASYNC_EVENT_ID_DMA1_QM = 450,
+	GOYA_ASYNC_EVENT_ID_DMA2_QM = 451,
+	GOYA_ASYNC_EVENT_ID_DMA3_QM = 452,
+	GOYA_ASYNC_EVENT_ID_DMA4_QM = 453,
+	GOYA_ASYNC_EVENT_ID_DMA_ON_HBW = 454,
+	GOYA_ASYNC_EVENT_ID_DMA0_CH = 455,
+	GOYA_ASYNC_EVENT_ID_DMA1_CH = 456,
+	GOYA_ASYNC_EVENT_ID_DMA2_CH = 457,
+	GOYA_ASYNC_EVENT_ID_DMA3_CH = 458,
+	GOYA_ASYNC_EVENT_ID_DMA4_CH = 459,
+	GOYA_ASYNC_EVENT_ID_PI_UPDATE = 484,
+	GOYA_ASYNC_EVENT_ID_HALT_MACHINE = 485,
+	GOYA_ASYNC_EVENT_ID_INTS_REGISTER = 486,
+	GOYA_ASYNC_EVENT_ID_SOFT_RESET = 487,
+	GOYA_ASYNC_EVENT_ID_LAST_VALID_ID = 1023,
+	GOYA_ASYNC_EVENT_ID_SIZE
+};
+
+#endif /* __GOYA_ASYNC_EVENTS_H_ */
diff --git a/drivers/misc/habanalabs/include/goya/goya_boot_if.h b/drivers/misc/habanalabs/include/goya/goya_boot_if.h
new file mode 100644
index 000000000000..2e39578ec795
--- /dev/null
+++ b/drivers/misc/habanalabs/include/goya/goya_boot_if.h
@@ -0,0 +1,32 @@
+/* SPDX-License-Identifier: GPL-2.0
+ *
+ * Copyright 2018 HabanaLabs, Ltd.
+ * All Rights Reserved.
+ *
+ * Author: Oded Gabbay <oded.gabbay@gmail.com>
+ *
+ */
+
+#ifndef GOYA_BOOT_IF_H
+#define GOYA_BOOT_IF_H
+
+enum cpu_boot_status {
+	CPU_BOOT_STATUS_NA = 0,		/* Default value after reset of chip */
+	CPU_BOOT_STATUS_IN_WFE,
+	CPU_BOOT_STATUS_DRAM_RDY,
+	CPU_BOOT_STATUS_SRAM_AVAIL,
+	CPU_BOOT_STATUS_IN_BTL,		/* BTL is H/W FSM */
+	CPU_BOOT_STATUS_IN_PREBOOT,
+	CPU_BOOT_STATUS_IN_SPL,
+	CPU_BOOT_STATUS_IN_UBOOT,
+	CPU_BOOT_STATUS_DRAM_INIT_FAIL,
+	CPU_BOOT_STATUS_FIT_CORRUPTED
+};
+
+enum kmd_msg {
+	KMD_MSG_NA = 0,
+	KMD_MSG_GOTO_WFE,
+	KMD_MSG_FIT_RDY
+};
+
+#endif /* GOYA_BOOT_IF_H */
-- 
2.17.1

