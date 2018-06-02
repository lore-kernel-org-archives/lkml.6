Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751554AbeFBA4i (ORCPT <rfc822;w@1wt.eu>);
        Fri, 1 Jun 2018 20:56:38 -0400
Received: from mail-qk0-f195.google.com ([209.85.220.195]:44982 "EHLO
        mail-qk0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751343AbeFBA40 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jun 2018 20:56:26 -0400
X-Google-Smtp-Source: ADUXVKKKYnJwECA3qxtV+VpIJl6oAOBb2O06hED6uwYo0D4XFiYDIDv9CUdpsQiy1Htku7efbGcRjA==
From: Ray Jui <ray.jui@broadcom.com>
To: Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Cc: linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        bcm-kernel-feedback-list@broadcom.com, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Pramod Kumar <pramod.kumar@broadcom.com>,
        Ray Jui <ray.jui@broadcom.com>
Subject: [PATCH v3 2/3] clk: bcm: Update and add Stingray clock entries
Date: Fri,  1 Jun 2018 17:56:07 -0700
Message-Id: <1527900968-12017-3-git-send-email-ray.jui@broadcom.com>
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1527900968-12017-1-git-send-email-ray.jui@broadcom.com>
References: <1527900968-12017-1-git-send-email-ray.jui@broadcom.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Pramod Kumar <pramod.kumar@broadcom.com>

Update and add Stingray clock definitions and tables so they match the
binding document and the latest ASIC datasheet

Signed-off-by: Pramod Kumar <pramod.kumar@broadcom.com>
Signed-off-by: Ray Jui <ray.jui@broadcom.com>
---
 drivers/clk/bcm/clk-sr.c | 135 +++++++++++++++++++++++++++++++++++++++++------
 1 file changed, 120 insertions(+), 15 deletions(-)

diff --git a/drivers/clk/bcm/clk-sr.c b/drivers/clk/bcm/clk-sr.c
index adc74f4..7b9efc0 100644
--- a/drivers/clk/bcm/clk-sr.c
+++ b/drivers/clk/bcm/clk-sr.c
@@ -56,8 +56,8 @@ static const struct iproc_pll_ctrl sr_genpll0 = {
 };
 
 static const struct iproc_clk_ctrl sr_genpll0_clk[] = {
-	[BCM_SR_GENPLL0_SATA_CLK] = {
-		.channel = BCM_SR_GENPLL0_SATA_CLK,
+	[BCM_SR_GENPLL0_125M_CLK] = {
+		.channel = BCM_SR_GENPLL0_125M_CLK,
 		.flags = IPROC_CLK_AON,
 		.enable = ENABLE_VAL(0x4, 6, 0, 12),
 		.mdiv = REG_VAL(0x18, 0, 9),
@@ -102,6 +102,65 @@ static int sr_genpll0_clk_init(struct platform_device *pdev)
 	return 0;
 }
 
+static const struct iproc_pll_ctrl sr_genpll2 = {
+	.flags = IPROC_CLK_AON | IPROC_CLK_PLL_HAS_NDIV_FRAC |
+		IPROC_CLK_PLL_NEEDS_SW_CFG,
+	.aon = AON_VAL(0x0, 1, 13, 12),
+	.reset = RESET_VAL(0x0, 12, 11),
+	.dig_filter = DF_VAL(0x0, 4, 3, 0, 4, 7, 3),
+	.sw_ctrl = SW_CTRL_VAL(0x10, 31),
+	.ndiv_int = REG_VAL(0x10, 20, 10),
+	.ndiv_frac = REG_VAL(0x10, 0, 20),
+	.pdiv = REG_VAL(0x14, 0, 4),
+	.status = REG_VAL(0x30, 12, 1),
+};
+
+static const struct iproc_clk_ctrl sr_genpll2_clk[] = {
+	[BCM_SR_GENPLL2_NIC_CLK] = {
+		.channel = BCM_SR_GENPLL2_NIC_CLK,
+		.flags = IPROC_CLK_AON,
+		.enable = ENABLE_VAL(0x4, 6, 0, 12),
+		.mdiv = REG_VAL(0x18, 0, 9),
+	},
+	[BCM_SR_GENPLL2_TS_500_CLK] = {
+		.channel = BCM_SR_GENPLL2_TS_500_CLK,
+		.flags = IPROC_CLK_AON,
+		.enable = ENABLE_VAL(0x4, 7, 1, 13),
+		.mdiv = REG_VAL(0x18, 10, 9),
+	},
+	[BCM_SR_GENPLL2_125_NITRO_CLK] = {
+		.channel = BCM_SR_GENPLL2_125_NITRO_CLK,
+		.flags = IPROC_CLK_AON,
+		.enable = ENABLE_VAL(0x4, 8, 2, 14),
+		.mdiv = REG_VAL(0x18, 20, 9),
+	},
+	[BCM_SR_GENPLL2_CHIMP_CLK] = {
+		.channel = BCM_SR_GENPLL2_CHIMP_CLK,
+		.flags = IPROC_CLK_AON,
+		.enable = ENABLE_VAL(0x4, 9, 3, 15),
+		.mdiv = REG_VAL(0x1c, 0, 9),
+	},
+	[BCM_SR_GENPLL2_NIC_FLASH_CLK] = {
+		.channel = BCM_SR_GENPLL2_NIC_FLASH_CLK,
+		.flags = IPROC_CLK_AON,
+		.enable = ENABLE_VAL(0x4, 10, 4, 16),
+		.mdiv = REG_VAL(0x1c, 10, 9),
+	},
+	[BCM_SR_GENPLL2_FS4_CLK] = {
+		.channel = BCM_SR_GENPLL2_FS4_CLK,
+		.enable = ENABLE_VAL(0x4, 11, 5, 17),
+		.mdiv = REG_VAL(0x1c, 20, 9),
+	},
+};
+
+static int sr_genpll2_clk_init(struct platform_device *pdev)
+{
+	iproc_pll_clk_setup(pdev->dev.of_node,
+			    &sr_genpll2, NULL, 0, sr_genpll2_clk,
+			    ARRAY_SIZE(sr_genpll2_clk));
+	return 0;
+}
+
 static const struct iproc_pll_ctrl sr_genpll3 = {
 	.flags = IPROC_CLK_AON | IPROC_CLK_PLL_HAS_NDIV_FRAC |
 		IPROC_CLK_PLL_NEEDS_SW_CFG,
@@ -157,6 +216,30 @@ static const struct iproc_clk_ctrl sr_genpll4_clk[] = {
 		.enable = ENABLE_VAL(0x4, 6, 0, 12),
 		.mdiv = REG_VAL(0x18, 0, 9),
 	},
+	[BCM_SR_GENPLL4_TPIU_PLL_CLK] = {
+		.channel = BCM_SR_GENPLL4_TPIU_PLL_CLK,
+		.flags = IPROC_CLK_AON,
+		.enable = ENABLE_VAL(0x4, 7, 1, 13),
+		.mdiv = REG_VAL(0x18, 10, 9),
+	},
+	[BCM_SR_GENPLL4_NOC_CLK] = {
+		.channel = BCM_SR_GENPLL4_NOC_CLK,
+		.flags = IPROC_CLK_AON,
+		.enable = ENABLE_VAL(0x4, 8, 2, 14),
+		.mdiv = REG_VAL(0x18, 20, 9),
+	},
+	[BCM_SR_GENPLL4_CHCLK_FS4_CLK] = {
+		.channel = BCM_SR_GENPLL4_CHCLK_FS4_CLK,
+		.flags = IPROC_CLK_AON,
+		.enable = ENABLE_VAL(0x4, 9, 3, 15),
+		.mdiv = REG_VAL(0x1c, 0, 9),
+	},
+	[BCM_SR_GENPLL4_BRIDGE_FSCPU_CLK] = {
+		.channel = BCM_SR_GENPLL4_BRIDGE_FSCPU_CLK,
+		.flags = IPROC_CLK_AON,
+		.enable = ENABLE_VAL(0x4, 10, 4, 16),
+		.mdiv = REG_VAL(0x1c, 10, 9),
+	},
 };
 
 static int sr_genpll4_clk_init(struct platform_device *pdev)
@@ -181,18 +264,21 @@ static const struct iproc_pll_ctrl sr_genpll5 = {
 };
 
 static const struct iproc_clk_ctrl sr_genpll5_clk[] = {
-	[BCM_SR_GENPLL5_FS_CLK] = {
-		.channel = BCM_SR_GENPLL5_FS_CLK,
-		.flags = IPROC_CLK_AON,
+	[BCM_SR_GENPLL5_FS4_HF_CLK] = {
+		.channel = BCM_SR_GENPLL5_FS4_HF_CLK,
 		.enable = ENABLE_VAL(0x4, 6, 0, 12),
 		.mdiv = REG_VAL(0x18, 0, 9),
 	},
-	[BCM_SR_GENPLL5_SPU_CLK] = {
-		.channel = BCM_SR_GENPLL5_SPU_CLK,
-		.flags = IPROC_CLK_AON,
-		.enable = ENABLE_VAL(0x4, 6, 0, 12),
+	[BCM_SR_GENPLL5_CRYPTO_AE_CLK] = {
+		.channel = BCM_SR_GENPLL5_CRYPTO_AE_CLK,
+		.enable = ENABLE_VAL(0x4, 7, 1, 12),
 		.mdiv = REG_VAL(0x18, 10, 9),
 	},
+	[BCM_SR_GENPLL5_RAID_AE_CLK] = {
+		.channel = BCM_SR_GENPLL5_RAID_AE_CLK,
+		.enable = ENABLE_VAL(0x4, 8, 2, 14),
+		.mdiv = REG_VAL(0x18, 20, 9),
+	},
 };
 
 static int sr_genpll5_clk_init(struct platform_device *pdev)
@@ -214,24 +300,30 @@ static const struct iproc_pll_ctrl sr_lcpll0 = {
 };
 
 static const struct iproc_clk_ctrl sr_lcpll0_clk[] = {
-	[BCM_SR_LCPLL0_SATA_REF_CLK] = {
-		.channel = BCM_SR_LCPLL0_SATA_REF_CLK,
+	[BCM_SR_LCPLL0_SATA_REFP_CLK] = {
+		.channel = BCM_SR_LCPLL0_SATA_REFP_CLK,
 		.flags = IPROC_CLK_AON,
 		.enable = ENABLE_VAL(0x0, 7, 1, 13),
 		.mdiv = REG_VAL(0x14, 0, 9),
 	},
-	[BCM_SR_LCPLL0_USB_REF_CLK] = {
-		.channel = BCM_SR_LCPLL0_USB_REF_CLK,
+	[BCM_SR_LCPLL0_SATA_REFN_CLK] = {
+		.channel = BCM_SR_LCPLL0_SATA_REFN_CLK,
 		.flags = IPROC_CLK_AON,
 		.enable = ENABLE_VAL(0x0, 8, 2, 14),
 		.mdiv = REG_VAL(0x14, 10, 9),
 	},
-	[BCM_SR_LCPLL0_SATA_REFPN_CLK] = {
-		.channel = BCM_SR_LCPLL0_SATA_REFPN_CLK,
+	[BCM_SR_LCPLL0_SATA_350_CLK] = {
+		.channel = BCM_SR_LCPLL0_SATA_350_CLK,
 		.flags = IPROC_CLK_AON,
 		.enable = ENABLE_VAL(0x0, 9, 3, 15),
 		.mdiv = REG_VAL(0x14, 20, 9),
 	},
+	[BCM_SR_LCPLL0_SATA_500_CLK] = {
+		.channel = BCM_SR_LCPLL0_SATA_500_CLK,
+		.flags = IPROC_CLK_AON,
+		.enable = ENABLE_VAL(0x0, 10, 4, 16),
+		.mdiv = REG_VAL(0x18, 0, 9),
+	},
 };
 
 static int sr_lcpll0_clk_init(struct platform_device *pdev)
@@ -259,6 +351,18 @@ static const struct iproc_clk_ctrl sr_lcpll1_clk[] = {
 		.enable = ENABLE_VAL(0x0, 7, 1, 13),
 		.mdiv = REG_VAL(0x14, 0, 9),
 	},
+	[BCM_SR_LCPLL1_USB_REF_CLK] = {
+		.channel = BCM_SR_LCPLL1_USB_REF_CLK,
+		.flags = IPROC_CLK_AON,
+		.enable = ENABLE_VAL(0x0, 8, 2, 14),
+		.mdiv = REG_VAL(0x14, 10, 9),
+	},
+	[BCM_SR_LCPLL1_CRMU_TS_CLK] = {
+		.channel = BCM_SR_LCPLL1_CRMU_TS_CLK,
+		.flags = IPROC_CLK_AON,
+		.enable = ENABLE_VAL(0x0, 9, 3, 15),
+		.mdiv = REG_VAL(0x14, 20, 9),
+	},
 };
 
 static int sr_lcpll1_clk_init(struct platform_device *pdev)
@@ -298,6 +402,7 @@ static int sr_lcpll_pcie_clk_init(struct platform_device *pdev)
 
 static const struct of_device_id sr_clk_dt_ids[] = {
 	{ .compatible = "brcm,sr-genpll0", .data = sr_genpll0_clk_init },
+	{ .compatible = "brcm,sr-genpll2", .data = sr_genpll2_clk_init },
 	{ .compatible = "brcm,sr-genpll4", .data = sr_genpll4_clk_init },
 	{ .compatible = "brcm,sr-genpll5", .data = sr_genpll5_clk_init },
 	{ .compatible = "brcm,sr-lcpll0", .data = sr_lcpll0_clk_init },
-- 
2.1.4
