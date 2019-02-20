Return-Path: <SRS0=sczE=Q3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFD15C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 17:53:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BA9DB21848
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 17:53:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550685189;
	bh=d2LME1JD/W5hUeTk/FskRyN8KIaQ+N7D3+vad9POBm8=;
	h=From:To:Cc:Subject:In-Reply-To:Date:List-ID:From;
	b=j1fPIvMDp87JihOIx79cEKxu/wdk0I+jVx075Vae+DHm/d/RcBHvoH48gwkbge7hP
	 /bEdSblpiWchM2VxYh6B4opJpJ6ZBThzdj1PlzIHyLCpsJ06vZ+pHDwhI4wtQtKwhC
	 /fzhO73skO+zCmDpebUjf54ReddV/XX9skihHjcs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726912AbfBTRxI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Feb 2019 12:53:08 -0500
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:55918 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725815AbfBTRxF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Feb 2019 12:53:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=rICkExlEtbFWdUnX2wtGRsO/rPh1TNh8aXgtJZaU/2M=; b=vwB93cLmLbTf
        kj36bwLVIuk+HtuPF1Y1C/R33uiq2OQ/D/tKiEtVPPFJBgCJPoKL8gJ0KpTEwkxR9Rb+IXqIHXsb2
        Vlnu9efejm9IDQrPxr478qqutUUkPCDctTa3cZIdmgeOE8MM5NytPyGwERCfgDXK/I7ibLSokieSC
        GTEv4=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1gwW3E-0005SR-Um; Wed, 20 Feb 2019 17:52:56 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id 6A50A112882D; Wed, 20 Feb 2019 17:52:56 +0000 (GMT)
From:   Mark Brown <broonie@kernel.org>
To:     Axel Lin <axel.lin@ingics.com>
Cc:     Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org
Subject: Applied "regulator: twl6030: Use regulator_list_voltage_linear_range for twl6030ldo_ops" to the regulator tree
In-Reply-To: 
X-Patchwork-Hint: ignore
Message-Id: <20190220175256.6A50A112882D@debutante.sirena.org.uk>
Date:   Wed, 20 Feb 2019 17:52:56 +0000 (GMT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   regulator: twl6030: Use regulator_list_voltage_linear_range for twl6030ldo_ops

has been applied to the regulator tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git 

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.  

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark

From 4a43870ae166a1a0bbc44a7b5ee63653303827bb Mon Sep 17 00:00:00 2001
From: Axel Lin <axel.lin@ingics.com>
Date: Sun, 17 Feb 2019 21:48:08 +0800
Subject: [PATCH] regulator: twl6030: Use regulator_list_voltage_linear_range
 for twl6030ldo_ops

Use linear range to replace the twl6030ldo_list_voltage implementation.
With this change, the min_mV is not used and can be removed from
struct twlreg_info.

Signed-off-by: Axel Lin <axel.lin@ingics.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/regulator/twl6030-regulator.c | 73 ++++++++++-----------------
 1 file changed, 27 insertions(+), 46 deletions(-)

diff --git a/drivers/regulator/twl6030-regulator.c b/drivers/regulator/twl6030-regulator.c
index 78b964539775..dcaa6512d760 100644
--- a/drivers/regulator/twl6030-regulator.c
+++ b/drivers/regulator/twl6030-regulator.c
@@ -31,9 +31,6 @@ struct twlreg_info {
 	/* twl resource ID, for resource control state machine */
 	u8			id;
 
-	/* chip constraints on regulator behavior */
-	u16			min_mV;
-
 	u8			flags;
 
 	/* used by regulator core */
@@ -252,27 +249,6 @@ static struct regulator_ops twl6030coresmps_ops = {
 	.get_voltage	= twl6030coresmps_get_voltage,
 };
 
-static int twl6030ldo_list_voltage(struct regulator_dev *rdev, unsigned sel)
-{
-	struct twlreg_info *info = rdev_get_drvdata(rdev);
-
-	switch (sel) {
-	case 0:
-		return 0;
-	case 1 ... 24:
-		/* Linear mapping from 00000001 to 00011000:
-		 * Absolute voltage value = 1.0 V + 0.1 V × (sel – 00000001)
-		 */
-		return (info->min_mV + 100 * (sel - 1)) * 1000;
-	case 25 ... 30:
-		return -EINVAL;
-	case 31:
-		return 2750000;
-	default:
-		return -EINVAL;
-	}
-}
-
 static int
 twl6030ldo_set_voltage_sel(struct regulator_dev *rdev, unsigned selector)
 {
@@ -291,7 +267,7 @@ static int twl6030ldo_get_voltage_sel(struct regulator_dev *rdev)
 }
 
 static struct regulator_ops twl6030ldo_ops = {
-	.list_voltage	= twl6030ldo_list_voltage,
+	.list_voltage	= regulator_list_voltage_linear_range,
 
 	.set_voltage_sel = twl6030ldo_set_voltage_sel,
 	.get_voltage_sel = twl6030ldo_get_voltage_sel,
@@ -513,6 +489,11 @@ static struct regulator_ops twlsmps_ops = {
 };
 
 /*----------------------------------------------------------------------*/
+static const struct regulator_linear_range twl6030ldo_linear_range[] = {
+	REGULATOR_LINEAR_RANGE(0, 0, 0, 0),
+	REGULATOR_LINEAR_RANGE(1000000, 1, 24, 100000),
+	REGULATOR_LINEAR_RANGE(2750000, 31, 31, 0),
+};
 
 #define TWL6030_ADJUSTABLE_SMPS(label) \
 static const struct twlreg_info TWL6030_INFO_##label = { \
@@ -525,28 +506,30 @@ static const struct twlreg_info TWL6030_INFO_##label = { \
 		}, \
 	}
 
-#define TWL6030_ADJUSTABLE_LDO(label, offset, min_mVolts) \
+#define TWL6030_ADJUSTABLE_LDO(label, offset) \
 static const struct twlreg_info TWL6030_INFO_##label = { \
 	.base = offset, \
-	.min_mV = min_mVolts, \
 	.desc = { \
 		.name = #label, \
 		.id = TWL6030_REG_##label, \
 		.n_voltages = 32, \
+		.linear_ranges = twl6030ldo_linear_range, \
+		.n_linear_ranges = ARRAY_SIZE(twl6030ldo_linear_range), \
 		.ops = &twl6030ldo_ops, \
 		.type = REGULATOR_VOLTAGE, \
 		.owner = THIS_MODULE, \
 		}, \
 	}
 
-#define TWL6032_ADJUSTABLE_LDO(label, offset, min_mVolts) \
+#define TWL6032_ADJUSTABLE_LDO(label, offset) \
 static const struct twlreg_info TWL6032_INFO_##label = { \
 	.base = offset, \
-	.min_mV = min_mVolts, \
 	.desc = { \
 		.name = #label, \
 		.id = TWL6032_REG_##label, \
 		.n_voltages = 32, \
+		.linear_ranges = twl6030ldo_linear_range, \
+		.n_linear_ranges = ARRAY_SIZE(twl6030ldo_linear_range), \
 		.ops = &twl6030ldo_ops, \
 		.type = REGULATOR_VOLTAGE, \
 		.owner = THIS_MODULE, \
@@ -557,7 +540,6 @@ static const struct twlreg_info TWL6032_INFO_##label = { \
 static const struct twlreg_info TWLFIXED_INFO_##label = { \
 	.base = offset, \
 	.id = 0, \
-	.min_mV = mVolts, \
 	.desc = { \
 		.name = #label, \
 		.id = TWL6030##_REG_##label, \
@@ -574,7 +556,6 @@ static const struct twlreg_info TWLFIXED_INFO_##label = { \
 #define TWL6032_ADJUSTABLE_SMPS(label, offset) \
 static const struct twlreg_info TWLSMPS_INFO_##label = { \
 	.base = offset, \
-	.min_mV = 600, \
 	.desc = { \
 		.name = #label, \
 		.id = TWL6032_REG_##label, \
@@ -592,22 +573,22 @@ static const struct twlreg_info TWLSMPS_INFO_##label = { \
 TWL6030_ADJUSTABLE_SMPS(VDD1);
 TWL6030_ADJUSTABLE_SMPS(VDD2);
 TWL6030_ADJUSTABLE_SMPS(VDD3);
-TWL6030_ADJUSTABLE_LDO(VAUX1_6030, 0x54, 1000);
-TWL6030_ADJUSTABLE_LDO(VAUX2_6030, 0x58, 1000);
-TWL6030_ADJUSTABLE_LDO(VAUX3_6030, 0x5c, 1000);
-TWL6030_ADJUSTABLE_LDO(VMMC, 0x68, 1000);
-TWL6030_ADJUSTABLE_LDO(VPP, 0x6c, 1000);
-TWL6030_ADJUSTABLE_LDO(VUSIM, 0x74, 1000);
+TWL6030_ADJUSTABLE_LDO(VAUX1_6030, 0x54);
+TWL6030_ADJUSTABLE_LDO(VAUX2_6030, 0x58);
+TWL6030_ADJUSTABLE_LDO(VAUX3_6030, 0x5c);
+TWL6030_ADJUSTABLE_LDO(VMMC, 0x68);
+TWL6030_ADJUSTABLE_LDO(VPP, 0x6c);
+TWL6030_ADJUSTABLE_LDO(VUSIM, 0x74);
 /* 6025 are renamed compared to 6030 versions */
-TWL6032_ADJUSTABLE_LDO(LDO2, 0x54, 1000);
-TWL6032_ADJUSTABLE_LDO(LDO4, 0x58, 1000);
-TWL6032_ADJUSTABLE_LDO(LDO3, 0x5c, 1000);
-TWL6032_ADJUSTABLE_LDO(LDO5, 0x68, 1000);
-TWL6032_ADJUSTABLE_LDO(LDO1, 0x6c, 1000);
-TWL6032_ADJUSTABLE_LDO(LDO7, 0x74, 1000);
-TWL6032_ADJUSTABLE_LDO(LDO6, 0x60, 1000);
-TWL6032_ADJUSTABLE_LDO(LDOLN, 0x64, 1000);
-TWL6032_ADJUSTABLE_LDO(LDOUSB, 0x70, 1000);
+TWL6032_ADJUSTABLE_LDO(LDO2, 0x54);
+TWL6032_ADJUSTABLE_LDO(LDO4, 0x58);
+TWL6032_ADJUSTABLE_LDO(LDO3, 0x5c);
+TWL6032_ADJUSTABLE_LDO(LDO5, 0x68);
+TWL6032_ADJUSTABLE_LDO(LDO1, 0x6c);
+TWL6032_ADJUSTABLE_LDO(LDO7, 0x74);
+TWL6032_ADJUSTABLE_LDO(LDO6, 0x60);
+TWL6032_ADJUSTABLE_LDO(LDOLN, 0x64);
+TWL6032_ADJUSTABLE_LDO(LDOUSB, 0x70);
 TWL6030_FIXED_LDO(VANA, 0x50, 2100, 0);
 TWL6030_FIXED_LDO(VCXIO, 0x60, 1800, 0);
 TWL6030_FIXED_LDO(VDAC, 0x64, 1800, 0);
-- 
2.20.1

