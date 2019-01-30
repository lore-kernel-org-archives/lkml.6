Return-Path: <SRS0=IQwf=QG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,UPPERCASE_50_75,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F01BC282D7
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 23:07:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 081A120881
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 23:07:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aF0TUUMF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727216AbfA3XHL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Jan 2019 18:07:11 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:36307 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725535AbfA3XHK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Jan 2019 18:07:10 -0500
Received: by mail-wr1-f67.google.com with SMTP id u4so1291127wrp.3
        for <linux-kernel@vger.kernel.org>; Wed, 30 Jan 2019 15:07:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=GD9HCJMYtvxruYpl6gTMsd/xa6Ck5VTiM6tOlcs0gh8=;
        b=aF0TUUMFTi2F9KcZNGyepkWPt9A9fKby1f+yZ7DjEtnvk2G5kK2h/GH7kmY2N+zybl
         Nhp7O26guK5+tfPeIK7gaw3mHVJmbTIZd/jga3tBfkjSlsm/yM2N0ZGalMaUxoaZCpBF
         c1GyZdY+aaXkJp+jiNQ3Lm0op8MoXBDKThW2XQoWJWXKSeG88rWY2NTA2N7K+qtiM1Sr
         sxHeXB9mMzi22Hf8STTwn1p0x6ElB4Iel0XhLE8rjKm5djNvGlESdBh54mzYKO3GrE+h
         jzV6dC0NhXfCYdzi1I6pbeyMJVtof/2nz2gI4IuSxd8a5wVjAlvT268mfJzoRVlzfU2Z
         qFAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=GD9HCJMYtvxruYpl6gTMsd/xa6Ck5VTiM6tOlcs0gh8=;
        b=rYKZ/pKfRJTBUhSknYiusIiR2oRo72nQtYqRKiEyiRaBItYKQWiAhQ15lK+PqtKpog
         Mn658Ci8IlWNTc2U6dwpHU20Wnf7izOdDLpQK4jDV/2qGeL1eNBYDg7ToUvL62tM7y9T
         ShfUwZjvHLXZwp9wHDpeckjDPb9Q2VDUTXiSd5sd4Pt43/gyqf6xOj0+3pt/3i7/9n4r
         1SF4f8oxJwny0T0Ezo111AlUQC/Sweg1v7YXmBeO37JQiDX5WvY8H5AahiflENq59R2f
         l3rPT6F6F1iGLMaz+ShLC5B7O1ruHte23kf58eIOV+IIKljNGm+JWvNuRztRtZGJrqPV
         k0Cw==
X-Gm-Message-State: AJcUukfYqozajyw/QV/OCZRXcbaI3zEcA4wa8B5StEF/ndYvd7sEcD7t
        Yddru4zNCdTDDuHP1F33tDXzzamz
X-Google-Smtp-Source: ALg8bN7NpZDuNR2aHwiDutswNdUMkUSKdVl3UCxRpTp9o/utb63EJ81beFcbQM90ODXkxFU9mv0j9Q==
X-Received: by 2002:a5d:4c8a:: with SMTP id z10mr30863225wrs.75.1548885996595;
        Wed, 30 Jan 2019 14:06:36 -0800 (PST)
Received: from oded-ubuntu-des.habana-labs.com ([31.154.190.6])
        by smtp.gmail.com with ESMTPSA id b13sm2341349wrn.28.2019.01.30.14.06.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 30 Jan 2019 14:06:35 -0800 (PST)
From:   Oded Gabbay <oded.gabbay@gmail.com>
To:     gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        olof@lixom.net, rppt@linux.ibm.com
Cc:     ogabbay@habana.ai, arnd@arndb.de, joe@perches.com
Subject: [PATCH v2 06/15] habanalabs: add basic Goya h/w initialization
Date:   Thu, 31 Jan 2019 00:06:08 +0200
Message-Id: <20190130220617.4862-7-oded.gabbay@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190130220617.4862-1-oded.gabbay@gmail.com>
References: <20190130220617.4862-1-oded.gabbay@gmail.com>
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
Changes in v2:
  - Remove dead functions in upstream code (only used in palladium)
  - Remove unnecessary check of tpc_id in _goya_tpc_mbist_workaround()
  - Refactor goya_init_golden_registers() to make it more concise
  - Remove config_pll field from hl_device
  - Replace /** with /* in all functions
  - Use same function to push both types of F/W to device
  - Remove spl_fw field from hl_device as it was never used beyond scope
    of function
  - Remove goya_async_events.h file to add it in a later patch
  - Remove soft-reset code to add it in a later patch
  - Don't clear TPC ECC indication in TPC MBIST workaround
  - Remove Authors: from comment at start of file
  - Remove bitfields in interface to F/W and use __le16/32/64
  - Add new file goya_fw_if.h that contains defines that were in goya.h
 
 drivers/misc/habanalabs/device.c              |   12 +
 drivers/misc/habanalabs/goya/Makefile         |    3 +-
 drivers/misc/habanalabs/goya/goya.c           |  878 ++++-
 drivers/misc/habanalabs/goya/goyaP.h          |    4 +
 drivers/misc/habanalabs/goya/goya_security.c  | 2999 +++++++++++++++++
 drivers/misc/habanalabs/habanalabs.h          |   15 +
 drivers/misc/habanalabs/habanalabs_drv.c      |    7 +
 drivers/misc/habanalabs/include/armcp_if.h    |   19 +
 .../habanalabs/include/goya/goya_boot_if.h    |   30 +
 .../misc/habanalabs/include/goya/goya_fw_if.h |   28 +
 10 files changed, 3988 insertions(+), 7 deletions(-)
 create mode 100644 drivers/misc/habanalabs/goya/goya_security.c
 create mode 100644 drivers/misc/habanalabs/include/armcp_if.h
 create mode 100644 drivers/misc/habanalabs/include/goya/goya_boot_if.h
 create mode 100644 drivers/misc/habanalabs/include/goya/goya_fw_if.h

diff --git a/drivers/misc/habanalabs/device.c b/drivers/misc/habanalabs/device.c
index c5296b068aaf..9dcfe2cd3a0f 100644
--- a/drivers/misc/habanalabs/device.c
+++ b/drivers/misc/habanalabs/device.c
@@ -320,6 +320,15 @@ int hl_device_init(struct hl_device *hdev, struct class *hclass)
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
 
@@ -371,6 +380,9 @@ void hl_device_fini(struct hl_device *hdev)
 	if ((hdev->kernel_ctx) && (hl_ctx_put(hdev->kernel_ctx) != 1))
 		dev_err(hdev->dev, "kernel ctx is still alive\n");
 
+	/* Reset the H/W. It will be in idle state after this returns */
+	hdev->asic_funcs->hw_fini(hdev, true);
+
 	/* Call ASIC S/W finalize function */
 	hdev->asic_funcs->sw_fini(hdev);
 
diff --git a/drivers/misc/habanalabs/goya/Makefile b/drivers/misc/habanalabs/goya/Makefile
index 38d43006386d..b546e9f5ef76 100644
--- a/drivers/misc/habanalabs/goya/Makefile
+++ b/drivers/misc/habanalabs/goya/Makefile
@@ -1,3 +1,4 @@
 subdir-ccflags-y += -I$(src)
 
-HL_GOYA_FILES :=  goya/goya.o
+HL_GOYA_FILES :=  goya/goya.o goya/goya_security.o
+
diff --git a/drivers/misc/habanalabs/goya/goya.c b/drivers/misc/habanalabs/goya/goya.c
index 6626dead7231..8d13305ef6a5 100644
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
 
 /*
@@ -465,10 +465,12 @@ static int goya_early_init(struct hl_device *hdev)
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
 
@@ -599,6 +601,868 @@ int goya_sw_fini(struct hl_device *hdev)
 	return 0;
 }
 
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
+static void _goya_tpc_mbist_workaround(struct hl_device *hdev, u8 tpc_id)
+{
+	u64 tpc_eml_address;
+	u32 val, tpc_offset, tpc_eml_offset, tpc_slm_offset;
+	int err, slm_index;
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
+/*
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
+	u32 polynom[10], tpc_intr_mask, offset;
+	int i;
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
+	for (i = 0, offset = 0 ; i < 6 ; i++, offset += 0x20000) {
+		WREG32(mmSRAM_Y0_X0_RTR_HBW_RD_RQ_L_ARB + offset, 0x302);
+		WREG32(mmSRAM_Y0_X1_RTR_HBW_RD_RQ_L_ARB + offset, 0x302);
+		WREG32(mmSRAM_Y0_X2_RTR_HBW_RD_RQ_L_ARB + offset, 0x302);
+		WREG32(mmSRAM_Y0_X3_RTR_HBW_RD_RQ_L_ARB + offset, 0x302);
+		WREG32(mmSRAM_Y0_X4_RTR_HBW_RD_RQ_L_ARB + offset, 0x302);
+
+		WREG32(mmSRAM_Y0_X0_RTR_HBW_DATA_L_ARB + offset, 0x204);
+		WREG32(mmSRAM_Y0_X1_RTR_HBW_DATA_L_ARB + offset, 0x204);
+		WREG32(mmSRAM_Y0_X2_RTR_HBW_DATA_L_ARB + offset, 0x204);
+		WREG32(mmSRAM_Y0_X3_RTR_HBW_DATA_L_ARB + offset, 0x204);
+		WREG32(mmSRAM_Y0_X4_RTR_HBW_DATA_L_ARB + offset, 0x204);
+
+
+		WREG32(mmSRAM_Y0_X0_RTR_HBW_DATA_E_ARB + offset, 0x206);
+		WREG32(mmSRAM_Y0_X1_RTR_HBW_DATA_E_ARB + offset, 0x206);
+		WREG32(mmSRAM_Y0_X2_RTR_HBW_DATA_E_ARB + offset, 0x206);
+		WREG32(mmSRAM_Y0_X3_RTR_HBW_DATA_E_ARB + offset, 0x207);
+		WREG32(mmSRAM_Y0_X4_RTR_HBW_DATA_E_ARB + offset, 0x207);
+
+		WREG32(mmSRAM_Y0_X0_RTR_HBW_DATA_W_ARB + offset, 0x207);
+		WREG32(mmSRAM_Y0_X1_RTR_HBW_DATA_W_ARB + offset, 0x207);
+		WREG32(mmSRAM_Y0_X2_RTR_HBW_DATA_W_ARB + offset, 0x206);
+		WREG32(mmSRAM_Y0_X3_RTR_HBW_DATA_W_ARB + offset, 0x206);
+		WREG32(mmSRAM_Y0_X4_RTR_HBW_DATA_W_ARB + offset, 0x206);
+
+		WREG32(mmSRAM_Y0_X0_RTR_HBW_WR_RS_E_ARB + offset, 0x101);
+		WREG32(mmSRAM_Y0_X1_RTR_HBW_WR_RS_E_ARB + offset, 0x102);
+		WREG32(mmSRAM_Y0_X2_RTR_HBW_WR_RS_E_ARB + offset, 0x103);
+		WREG32(mmSRAM_Y0_X3_RTR_HBW_WR_RS_E_ARB + offset, 0x104);
+		WREG32(mmSRAM_Y0_X4_RTR_HBW_WR_RS_E_ARB + offset, 0x105);
+
+		WREG32(mmSRAM_Y0_X0_RTR_HBW_WR_RS_W_ARB + offset, 0x105);
+		WREG32(mmSRAM_Y0_X1_RTR_HBW_WR_RS_W_ARB + offset, 0x104);
+		WREG32(mmSRAM_Y0_X2_RTR_HBW_WR_RS_W_ARB + offset, 0x103);
+		WREG32(mmSRAM_Y0_X3_RTR_HBW_WR_RS_W_ARB + offset, 0x102);
+		WREG32(mmSRAM_Y0_X4_RTR_HBW_WR_RS_W_ARB + offset, 0x101);
+	}
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
+	for (i = 0, offset = 0 ; i < 10 ; i++, offset += 4) {
+		WREG32(mmMME1_RTR_SPLIT_COEF_0 + offset, polynom[i] >> 7);
+		WREG32(mmMME2_RTR_SPLIT_COEF_0 + offset, polynom[i] >> 7);
+		WREG32(mmMME3_RTR_SPLIT_COEF_0 + offset, polynom[i] >> 7);
+		WREG32(mmMME4_RTR_SPLIT_COEF_0 + offset, polynom[i] >> 7);
+		WREG32(mmMME5_RTR_SPLIT_COEF_0 + offset, polynom[i] >> 7);
+		WREG32(mmMME6_RTR_SPLIT_COEF_0 + offset, polynom[i] >> 7);
+
+		WREG32(mmTPC0_NRTR_SPLIT_COEF_0 + offset, polynom[i] >> 7);
+		WREG32(mmTPC1_RTR_SPLIT_COEF_0 + offset, polynom[i] >> 7);
+		WREG32(mmTPC2_RTR_SPLIT_COEF_0 + offset, polynom[i] >> 7);
+		WREG32(mmTPC3_RTR_SPLIT_COEF_0 + offset, polynom[i] >> 7);
+		WREG32(mmTPC4_RTR_SPLIT_COEF_0 + offset, polynom[i] >> 7);
+		WREG32(mmTPC5_RTR_SPLIT_COEF_0 + offset, polynom[i] >> 7);
+		WREG32(mmTPC6_RTR_SPLIT_COEF_0 + offset, polynom[i] >> 7);
+		WREG32(mmTPC7_NRTR_SPLIT_COEF_0 + offset, polynom[i] >> 7);
+
+		WREG32(mmPCI_NRTR_SPLIT_COEF_0 + offset, polynom[i] >> 7);
+		WREG32(mmDMA_NRTR_SPLIT_COEF_0 + offset, polynom[i] >> 7);
+	}
+
+	for (i = 0, offset = 0 ; i < 6 ; i++, offset += 0x40000) {
+		WREG32(mmMME1_RTR_SCRAMB_EN + offset,
+				1 << MME1_RTR_SCRAMB_EN_VAL_SHIFT);
+		WREG32(mmMME1_RTR_NON_LIN_SCRAMB + offset,
+				1 << MME1_RTR_NON_LIN_SCRAMB_EN_SHIFT);
+	}
+
+	for (i = 0, offset = 0 ; i < 8 ; i++, offset += 0x40000) {
+		/*
+		 * Workaround for Bug H2 #2441 :
+		 * "ST.NOP set trace event illegal opcode"
+		 */
+		WREG32(mmTPC0_CFG_TPC_INTR_MASK + offset, tpc_intr_mask);
+
+		WREG32(mmTPC0_NRTR_SCRAMB_EN + offset,
+				1 << TPC0_NRTR_SCRAMB_EN_VAL_SHIFT);
+		WREG32(mmTPC0_NRTR_NON_LIN_SCRAMB + offset,
+				1 << TPC0_NRTR_NON_LIN_SCRAMB_EN_SHIFT);
+	}
+
+	WREG32(mmDMA_NRTR_SCRAMB_EN, 1 << DMA_NRTR_SCRAMB_EN_VAL_SHIFT);
+	WREG32(mmDMA_NRTR_NON_LIN_SCRAMB,
+			1 << DMA_NRTR_NON_LIN_SCRAMB_EN_SHIFT);
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
+/*
+ * goya_push_fw_to_device - Push FW code to device
+ *
+ * @hdev: pointer to hl_device structure
+ *
+ * Copy fw code from firmware file to device memory.
+ * Returns 0 on success
+ *
+ */
+static int goya_push_fw_to_device(struct hl_device *hdev, const char *fw_name,
+					void __iomem *dst)
+{
+	const struct firmware *fw;
+	const u64 *fw_data;
+	size_t fw_size, i;
+	int rc;
+
+	rc = request_firmware(&fw, fw_name, hdev->dev);
+
+	if (rc) {
+		dev_err(hdev->dev, "Failed to request %s\n", fw_name);
+		goto out;
+	}
+
+	fw_size = fw->size;
+	if ((fw_size % 4) != 0) {
+		dev_err(hdev->dev, "illegal %s firmware size %lu\n",
+			fw_name, fw_size);
+		rc = -EINVAL;
+		goto out;
+	}
+
+	dev_dbg(hdev->dev, "%s firmware size == %lu\n", fw_name, fw_size);
+
+	fw_data = (const u64 *) fw->data;
+
+	if ((fw->size % 8) != 0)
+		fw_size -= 8;
+
+	for (i = 0 ; i < fw_size ; i += 8, fw_data++, dst += 8) {
+		if (!(i & (0x80000 - 1))) {
+			dev_dbg(hdev->dev,
+				"copied so far %lu out of %lu for %s firmware",
+				i, fw_size, fw_name);
+			usleep_range(20, 100);
+		}
+
+		writeq(*fw_data, dst);
+	}
+
+	if ((fw->size % 8) != 0)
+		writel(*(const u32 *) fw_data, dst);
+
+out:
+	release_firmware(fw);
+	return rc;
+}
+
+static int goya_pldm_init_cpu(struct hl_device *hdev)
+{
+	char fw_name[200];
+	void __iomem *dst;
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
+	snprintf(fw_name, sizeof(fw_name), "habanalabs/goya/goya-u-boot.bin");
+	dst = hdev->pcie_bar[SRAM_CFG_BAR_ID] + UBOOT_FW_OFFSET;
+	rc = goya_push_fw_to_device(hdev, fw_name, dst);
+	if (rc)
+		return rc;
+
+	snprintf(fw_name, sizeof(fw_name), "habanalabs/goya/goya-fit.itb");
+	dst = hdev->pcie_bar[DDR_BAR_ID] + LINUX_FW_OFFSET;
+	rc = goya_push_fw_to_device(hdev, fw_name, dst);
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
+	char fw_name[200];
+	void __iomem *dst;
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
+	snprintf(fw_name, sizeof(fw_name), "habanalabs/goya/goya-fit.itb");
+	dst = hdev->pcie_bar[DDR_BAR_ID] + LINUX_FW_OFFSET;
+	rc = goya_push_fw_to_device(hdev, fw_name, dst);
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
+/*
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
+/*
+ * goya_hw_fini - Goya hardware tear-down code
+ *
+ * @hdev: pointer to hl_device structure
+ * @hard_reset: should we do hard reset to all engines or just reset the
+ *              compute/dma engines
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
@@ -647,6 +1511,8 @@ static const struct hl_asic_funcs goya_funcs = {
 	.early_fini = goya_early_fini,
 	.sw_init = goya_sw_init,
 	.sw_fini = goya_sw_fini,
+	.hw_init = goya_hw_init,
+	.hw_fini = goya_hw_fini,
 	.suspend = goya_suspend,
 	.resume = goya_resume,
 	.mmap = goya_mmap,
diff --git a/drivers/misc/habanalabs/goya/goyaP.h b/drivers/misc/habanalabs/goya/goyaP.h
index d65ac54ba89b..5fb0fb942800 100644
--- a/drivers/misc/habanalabs/goya/goyaP.h
+++ b/drivers/misc/habanalabs/goya/goyaP.h
@@ -10,7 +10,9 @@
 
 #include <uapi/misc/habanalabs.h>
 #include "habanalabs.h"
+#include "include/goya/goya_boot_if.h"
 #include "include/goya/goya.h"
+#include "include/goya/goya_fw_if.h"
 
 #define NUMBER_OF_CMPLT_QUEUES		5
 #define NUMBER_OF_EXT_HW_QUEUES		5
@@ -152,4 +154,6 @@ struct goya_device {
 	u32		hw_cap_initialized;
 };
 
+void goya_init_security(struct hl_device *hdev);
+
 #endif /* GOYAP_H_ */
diff --git a/drivers/misc/habanalabs/goya/goya_security.c b/drivers/misc/habanalabs/goya/goya_security.c
new file mode 100644
index 000000000000..7315bbc02569
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
+/*
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
+/*
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
+/*
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
index 0ca174a8dad9..6f1e976a7d08 100644
--- a/drivers/misc/habanalabs/habanalabs.h
+++ b/drivers/misc/habanalabs/habanalabs.h
@@ -8,6 +8,8 @@
 #ifndef HABANALABSP_H_
 #define HABANALABSP_H_
 
+#include "include/armcp_if.h"
+
 #define pr_fmt(fmt)			"habanalabs: " fmt
 
 #include <linux/pci.h>
@@ -23,6 +25,8 @@
 
 #define HL_MMAP_CB_MASK			(0x8000000000000000ull >> PAGE_SHIFT)
 
+#define HL_DEVICE_TIMEOUT_USEC		1000000 /* 1 s */
+
 #define HL_MAX_QUEUES			128
 
 struct hl_device;
@@ -31,6 +35,8 @@ struct hl_fpriv;
 
 /**
  * struct asic_fixed_properties - ASIC specific immutable properties.
+ * @uboot_ver: F/W U-boot version.
+ * @preboot_ver: F/W Preboot version.
  * @sram_base_address: SRAM physical start address.
  * @sram_end_address: SRAM physical end address.
  * @sram_user_base_address - SRAM physical start address for user access.
@@ -59,6 +65,8 @@ struct hl_fpriv;
  * @tpc_enabled_mask: which TPCs are enabled.
  */
 struct asic_fixed_properties {
+	char			uboot_ver[VERSION_MAX_LEN];
+	char			preboot_ver[VERSION_MAX_LEN];
 	u64			sram_base_address;
 	u64			sram_end_address;
 	u64			sram_user_base_address;
@@ -156,6 +164,8 @@ enum hl_asic_type {
  * @early_fini: tears down what was done in early_init.
  * @sw_init: sets up driver state, does not configure H/W.
  * @sw_fini: tears down driver state, does not configure H/W.
+ * @hw_init: sets up the H/W state.
+ * @hw_fini: tears down the H/W state.
  * @suspend: handles IP specific H/W or SW changes for suspend.
  * @resume: handles IP specific H/W or SW changes for resume.
  * @mmap: mmap function, does nothing.
@@ -174,6 +184,8 @@ struct hl_asic_funcs {
 	int (*early_fini)(struct hl_device *hdev);
 	int (*sw_init)(struct hl_device *hdev);
 	int (*sw_fini)(struct hl_device *hdev);
+	int (*hw_init)(struct hl_device *hdev);
+	void (*hw_fini)(struct hl_device *hdev, bool hard_reset);
 	int (*suspend)(struct hl_device *hdev);
 	int (*resume)(struct hl_device *hdev);
 	int (*mmap)(struct hl_fpriv *hpriv, struct vm_area_struct *vma);
@@ -350,7 +362,10 @@ struct hl_device {
 	u8				disabled;
 
 	/* Parameters for bring-up */
+	u8				cpu_enable;
 	u8				reset_pcilink;
+	u8				fw_loading;
+	u8				pldm;
 };
 
 
diff --git a/drivers/misc/habanalabs/habanalabs_drv.c b/drivers/misc/habanalabs/habanalabs_drv.c
index b07979c599e2..2611883eab11 100644
--- a/drivers/misc/habanalabs/habanalabs_drv.c
+++ b/drivers/misc/habanalabs/habanalabs_drv.c
@@ -171,7 +171,14 @@ int create_hdev(struct hl_device **dev, struct pci_dev *pdev,
 	hdev->major = hl_major;
 
 	/* Parameters for bring-up - set them to defaults */
+	hdev->cpu_enable = 1;
 	hdev->reset_pcilink = 0;
+	hdev->fw_loading = 1;
+	hdev->pldm = 0;
+
+	/* If CPU is disabled, no point in loading FW */
+	if (!hdev->cpu_enable)
+		hdev->fw_loading = 0;
 
 	hdev->disabled = true;
 	hdev->pdev = pdev; /* can be NULL in case of simulator device */
diff --git a/drivers/misc/habanalabs/include/armcp_if.h b/drivers/misc/habanalabs/include/armcp_if.h
new file mode 100644
index 000000000000..85fc2efe144b
--- /dev/null
+++ b/drivers/misc/habanalabs/include/armcp_if.h
@@ -0,0 +1,19 @@
+/* SPDX-License-Identifier: GPL-2.0
+ *
+ * Copyright 2016-2018 HabanaLabs, Ltd.
+ * All Rights Reserved.
+ *
+ */
+
+#ifndef ARMCP_IF_H
+#define ARMCP_IF_H
+
+#include <linux/types.h>
+
+/*
+ * ArmCP info
+ */
+
+#define VERSION_MAX_LEN			128
+
+#endif /* ARMCP_IF_H */
diff --git a/drivers/misc/habanalabs/include/goya/goya_boot_if.h b/drivers/misc/habanalabs/include/goya/goya_boot_if.h
new file mode 100644
index 000000000000..1803465cc49a
--- /dev/null
+++ b/drivers/misc/habanalabs/include/goya/goya_boot_if.h
@@ -0,0 +1,30 @@
+/* SPDX-License-Identifier: GPL-2.0
+ *
+ * Copyright 2018 HabanaLabs, Ltd.
+ * All Rights Reserved.
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
diff --git a/drivers/misc/habanalabs/include/goya/goya_fw_if.h b/drivers/misc/habanalabs/include/goya/goya_fw_if.h
new file mode 100644
index 000000000000..a9920cb4a07b
--- /dev/null
+++ b/drivers/misc/habanalabs/include/goya/goya_fw_if.h
@@ -0,0 +1,28 @@
+/* SPDX-License-Identifier: GPL-2.0
+ *
+ * Copyright 2016-2018 HabanaLabs, Ltd.
+ * All Rights Reserved.
+ *
+ */
+
+#ifndef GOYA_FW_IF_H
+#define GOYA_FW_IF_H
+
+#define CPU_BOOT_ADDR		0x7FF8040000ull
+
+#define UBOOT_FW_OFFSET		0x100000		/* 1MB in SRAM */
+#define LINUX_FW_OFFSET		0x800000		/* 8MB in DDR */
+
+enum goya_pll_index {
+	CPU_PLL = 0,
+	IC_PLL,
+	MC_PLL,
+	MME_PLL,
+	PCI_PLL,
+	EMMC_PLL,
+	TPC_PLL
+};
+
+#define GOYA_PLL_FREQ_LOW		50000000 /* 50 MHz */
+
+#endif /* GOYA_FW_IF_H */
-- 
2.17.1

