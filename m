Return-Path: <SRS0=tlbf=RB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09EEEC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 16:49:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B9B9F21850
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 16:49:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551199780;
	bh=2qkco89c5apPbWmds59QcemD85htvUNy2htA3R5wIlo=;
	h=From:To:Cc:Subject:In-Reply-To:Date:List-ID:From;
	b=zoJyu9F78PMAwA5r+ubZlvBMWJt6c5E4PGCCm6w5VPls3fyjOuJKTLyd53ZEN9F7w
	 58Gr64CYPCYgYElC6CWpQ8LJHv7mHFZSrvHjXgyjcTZ2poyxeWzOL7qdAby7TZsQY/
	 pR+4TI7s1ISdg7UsL93bxmq8avhlpqi9imod7sIU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728640AbfBZQti (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Feb 2019 11:49:38 -0500
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:53084 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726801AbfBZQti (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Feb 2019 11:49:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=0bDuot5eciAYmpU2yp6KZw8ZBQnKKpzV0Lf2obziFVE=; b=E7Ia72SDuYD3
        2a/izR8+rcEhXLmfYCGn2+OOGE2F2oFS1/ZGT9Az46mUzB/zW+2hH6beL7WZGxd2rTBYeO8oy6wDQ
        U7FGEGdLScbwCuybUDxouYzs2B/lzPg+U8b2VHCTk8dT3j9LPi7Mm02O5vUuQ2j9VK4e0eN/yb5+c
        4qL8k=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1gyfv6-0000IJ-84; Tue, 26 Feb 2019 16:49:28 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id CFD251121A0A; Tue, 26 Feb 2019 16:49:22 +0000 (GMT)
From:   Mark Brown <broonie@kernel.org>
To:     Axel Lin <axel.lin@ingics.com>
Cc:     Tony Lindgren <tony@atomide.com>, Mark Brown <broonie@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: Applied "regulator: cpcap: Remove unused vsel_shift from struct cpcap_regulator" to the regulator tree
In-Reply-To: 
X-Patchwork-Hint: ignore
Message-Id: <20190226164922.CFD251121A0A@debutante.sirena.org.uk>
Date:   Tue, 26 Feb 2019 16:49:22 +0000 (GMT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   regulator: cpcap: Remove unused vsel_shift from struct cpcap_regulator

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

From de33873e9f95ee750ca0c17e0b960bff7d233a4e Mon Sep 17 00:00:00 2001
From: Axel Lin <axel.lin@ingics.com>
Date: Tue, 26 Feb 2019 13:52:29 +0800
Subject: [PATCH] regulator: cpcap: Remove unused vsel_shift from struct
 cpcap_regulator

This driver uses regulator_get/set_voltage_sel_regmap so it does not use
vsel_shift. Actually, vsel_shift can be calculated by vsel_mask setting.

Signed-off-by: Axel Lin <axel.lin@ingics.com>
Tested-by: Tony Lindgren <tony@atomide.com>
Reviewed-by: Sebastian Reichel <sebastian.reichel@collabora.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/regulator/cpcap-regulator.c | 102 ++++++++++++++--------------
 1 file changed, 50 insertions(+), 52 deletions(-)

diff --git a/drivers/regulator/cpcap-regulator.c b/drivers/regulator/cpcap-regulator.c
index 2131457937b7..c15ced1b5968 100644
--- a/drivers/regulator/cpcap-regulator.c
+++ b/drivers/regulator/cpcap-regulator.c
@@ -100,12 +100,11 @@ struct cpcap_regulator {
 	struct regulator_desc rdesc;
 	const u16 assign_reg;
 	const u16 assign_mask;
-	const u16 vsel_shift;
 };
 
 #define CPCAP_REG(_ID, reg, assignment_reg, assignment_mask, val_tbl,	\
-		mode_mask, volt_mask, volt_shft,			\
-		mode_val, off_val, volt_trans_time) {			\
+		mode_mask, volt_mask, mode_val, off_val,		\
+		volt_trans_time) {					\
 	.rdesc = {							\
 		.name = #_ID,						\
 		.of_match = of_match_ptr(#_ID),				\
@@ -127,7 +126,6 @@ struct cpcap_regulator {
 	},								\
 	.assign_reg = (assignment_reg),					\
 	.assign_mask = (assignment_mask),				\
-	.vsel_shift = (volt_shft),					\
 }
 
 struct cpcap_ddata {
@@ -339,152 +337,152 @@ static const unsigned int vaudio_val_tbl[] = { 0, 2775000, };
 static struct cpcap_regulator omap4_regulators[] = {
 	CPCAP_REG(SW1, CPCAP_REG_S1C1, CPCAP_REG_ASSIGN2,
 		  CPCAP_BIT_SW1_SEL, unknown_val_tbl,
-		  0, 0, 0, 0, 0, 0),
+		  0, 0, 0, 0, 0),
 	CPCAP_REG(SW2, CPCAP_REG_S2C1, CPCAP_REG_ASSIGN2,
 		  CPCAP_BIT_SW2_SEL, unknown_val_tbl,
-		  0, 0, 0, 0, 0, 0),
+		  0, 0, 0, 0, 0),
 	CPCAP_REG(SW3, CPCAP_REG_S3C, CPCAP_REG_ASSIGN2,
 		  CPCAP_BIT_SW3_SEL, unknown_val_tbl,
-		  0, 0, 0, 0, 0, 0),
+		  0, 0, 0, 0, 0),
 	CPCAP_REG(SW4, CPCAP_REG_S4C1, CPCAP_REG_ASSIGN2,
 		  CPCAP_BIT_SW4_SEL, unknown_val_tbl,
-		  0, 0, 0, 0, 0, 0),
+		  0, 0, 0, 0, 0),
 	CPCAP_REG(SW5, CPCAP_REG_S5C, CPCAP_REG_ASSIGN2,
 		  CPCAP_BIT_SW5_SEL, sw5_val_tbl,
-		  0x28, 0, 0, 0x20 | CPCAP_REG_OFF_MODE_SEC, 0, 0),
+		  0x28, 0, 0x20 | CPCAP_REG_OFF_MODE_SEC, 0, 0),
 	CPCAP_REG(SW6, CPCAP_REG_S6C, CPCAP_REG_ASSIGN2,
 		  CPCAP_BIT_SW6_SEL, unknown_val_tbl,
-		  0, 0, 0, 0, 0, 0),
+		  0, 0, 0, 0, 0),
 	CPCAP_REG(VCAM, CPCAP_REG_VCAMC, CPCAP_REG_ASSIGN2,
 		  CPCAP_BIT_VCAM_SEL, vcam_val_tbl,
-		  0x87, 0x30, 4, 0x3, 0, 420),
+		  0x87, 0x30, 0x3, 0, 420),
 	CPCAP_REG(VCSI, CPCAP_REG_VCSIC, CPCAP_REG_ASSIGN3,
 		  CPCAP_BIT_VCSI_SEL, vcsi_val_tbl,
-		  0x47, 0x10, 4, 0x43, 0x41, 350),
+		  0x47, 0x10, 0x43, 0x41, 350),
 	CPCAP_REG(VDAC, CPCAP_REG_VDACC, CPCAP_REG_ASSIGN3,
 		  CPCAP_BIT_VDAC_SEL, vdac_val_tbl,
-		  0x87, 0x30, 4, 0x3, 0, 420),
+		  0x87, 0x30, 0x3, 0, 420),
 	CPCAP_REG(VDIG, CPCAP_REG_VDIGC, CPCAP_REG_ASSIGN2,
 		  CPCAP_BIT_VDIG_SEL, vdig_val_tbl,
-		  0x87, 0x30, 4, 0x82, 0, 420),
+		  0x87, 0x30, 0x82, 0, 420),
 	CPCAP_REG(VFUSE, CPCAP_REG_VFUSEC, CPCAP_REG_ASSIGN3,
 		  CPCAP_BIT_VFUSE_SEL, vfuse_val_tbl,
-		  0x80, 0xf, 0, 0x80, 0, 420),
+		  0x80, 0xf, 0x80, 0, 420),
 	CPCAP_REG(VHVIO, CPCAP_REG_VHVIOC, CPCAP_REG_ASSIGN3,
 		  CPCAP_BIT_VHVIO_SEL, vhvio_val_tbl,
-		  0x17, 0, 0, 0, 0x12, 0),
+		  0x17, 0, 0, 0x12, 0),
 	CPCAP_REG(VSDIO, CPCAP_REG_VSDIOC, CPCAP_REG_ASSIGN2,
 		  CPCAP_BIT_VSDIO_SEL, vsdio_val_tbl,
-		  0x87, 0x38, 3, 0x82, 0, 420),
+		  0x87, 0x38, 0x82, 0, 420),
 	CPCAP_REG(VPLL, CPCAP_REG_VPLLC, CPCAP_REG_ASSIGN3,
 		  CPCAP_BIT_VPLL_SEL, vpll_val_tbl,
-		  0x43, 0x18, 3, 0x2, 0, 420),
+		  0x43, 0x18, 0x2, 0, 420),
 	CPCAP_REG(VRF1, CPCAP_REG_VRF1C, CPCAP_REG_ASSIGN3,
 		  CPCAP_BIT_VRF1_SEL, vrf1_val_tbl,
-		  0xac, 0x2, 1, 0x4, 0, 10),
+		  0xac, 0x2, 0x4, 0, 10),
 	CPCAP_REG(VRF2, CPCAP_REG_VRF2C, CPCAP_REG_ASSIGN3,
 		  CPCAP_BIT_VRF2_SEL, vrf2_val_tbl,
-		  0x23, 0x8, 3, 0, 0, 10),
+		  0x23, 0x8, 0, 0, 10),
 	CPCAP_REG(VRFREF, CPCAP_REG_VRFREFC, CPCAP_REG_ASSIGN3,
 		  CPCAP_BIT_VRFREF_SEL, vrfref_val_tbl,
-		  0x23, 0x8, 3, 0, 0, 420),
+		  0x23, 0x8, 0, 0, 420),
 	CPCAP_REG(VWLAN1, CPCAP_REG_VWLAN1C, CPCAP_REG_ASSIGN3,
 		  CPCAP_BIT_VWLAN1_SEL, vwlan1_val_tbl,
-		  0x47, 0x10, 4, 0, 0, 420),
+		  0x47, 0x10, 0, 0, 420),
 	CPCAP_REG(VWLAN2, CPCAP_REG_VWLAN2C, CPCAP_REG_ASSIGN3,
 		  CPCAP_BIT_VWLAN2_SEL, vwlan2_val_tbl,
-		  0x20c, 0xc0, 6, 0x20c, 0, 420),
+		  0x20c, 0xc0, 0x20c, 0, 420),
 	CPCAP_REG(VSIM, CPCAP_REG_VSIMC, CPCAP_REG_ASSIGN3,
 		  0xffff, vsim_val_tbl,
-		  0x23, 0x8, 3, 0x3, 0, 420),
+		  0x23, 0x8, 0x3, 0, 420),
 	CPCAP_REG(VSIMCARD, CPCAP_REG_VSIMC, CPCAP_REG_ASSIGN3,
 		  0xffff, vsimcard_val_tbl,
-		  0x1e80, 0x8, 3, 0x1e00, 0, 420),
+		  0x1e80, 0x8, 0x1e00, 0, 420),
 	CPCAP_REG(VVIB, CPCAP_REG_VVIBC, CPCAP_REG_ASSIGN3,
 		  CPCAP_BIT_VVIB_SEL, vvib_val_tbl,
-		  0x1, 0xc, 2, 0x1, 0, 500),
+		  0x1, 0xc, 0x1, 0, 500),
 	CPCAP_REG(VUSB, CPCAP_REG_VUSBC, CPCAP_REG_ASSIGN3,
 		  CPCAP_BIT_VUSB_SEL, vusb_val_tbl,
-		  0x11c, 0x40, 6, 0xc, 0, 0),
+		  0x11c, 0x40, 0xc, 0, 0),
 	CPCAP_REG(VAUDIO, CPCAP_REG_VAUDIOC, CPCAP_REG_ASSIGN4,
 		  CPCAP_BIT_VAUDIO_SEL, vaudio_val_tbl,
-		  0x16, 0x1, 0, 0x4, 0, 0),
+		  0x16, 0x1, 0x4, 0, 0),
 	{ /* sentinel */ },
 };
 
 static struct cpcap_regulator xoom_regulators[] = {
 	CPCAP_REG(SW1, CPCAP_REG_S1C1, CPCAP_REG_ASSIGN2,
 		  CPCAP_BIT_SW1_SEL, unknown_val_tbl,
-		  0, 0, 0, 0, 0, 0),
+		  0, 0, 0, 0, 0),
 	CPCAP_REG(SW2, CPCAP_REG_S2C1, CPCAP_REG_ASSIGN2,
 		  CPCAP_BIT_SW2_SEL, sw2_sw4_val_tbl,
-		  0xf00, 0x7f, 0, 0x800, 0, 120),
+		  0xf00, 0x7f, 0x800, 0, 120),
 	CPCAP_REG(SW3, CPCAP_REG_S3C, CPCAP_REG_ASSIGN2,
 		  CPCAP_BIT_SW3_SEL, unknown_val_tbl,
-		  0, 0, 0, 0, 0, 0),
+		  0, 0, 0, 0, 0),
 	CPCAP_REG(SW4, CPCAP_REG_S4C1, CPCAP_REG_ASSIGN2,
 		  CPCAP_BIT_SW4_SEL, sw2_sw4_val_tbl,
-		  0xf00, 0x7f, 0, 0x900, 0, 100),
+		  0xf00, 0x7f, 0x900, 0, 100),
 	CPCAP_REG(SW5, CPCAP_REG_S5C, CPCAP_REG_ASSIGN2,
 		  CPCAP_BIT_SW5_SEL, sw5_val_tbl,
-		  0x2a, 0, 0, 0x22, 0, 0),
+		  0x2a, 0, 0x22, 0, 0),
 	CPCAP_REG(SW6, CPCAP_REG_S6C, CPCAP_REG_ASSIGN2,
 		  CPCAP_BIT_SW6_SEL, unknown_val_tbl,
-		  0, 0, 0, 0, 0, 0),
+		  0, 0, 0, 0, 0),
 	CPCAP_REG(VCAM, CPCAP_REG_VCAMC, CPCAP_REG_ASSIGN2,
 		  CPCAP_BIT_VCAM_SEL, vcam_val_tbl,
-		  0x87, 0x30, 4, 0x7, 0, 420),
+		  0x87, 0x30, 0x7, 0, 420),
 	CPCAP_REG(VCSI, CPCAP_REG_VCSIC, CPCAP_REG_ASSIGN3,
 		  CPCAP_BIT_VCSI_SEL, vcsi_val_tbl,
-		  0x47, 0x10, 4, 0x7, 0, 350),
+		  0x47, 0x10, 0x7, 0, 350),
 	CPCAP_REG(VDAC, CPCAP_REG_VDACC, CPCAP_REG_ASSIGN3,
 		  CPCAP_BIT_VDAC_SEL, vdac_val_tbl,
-		  0x87, 0x30, 4, 0x3, 0, 420),
+		  0x87, 0x30, 0x3, 0, 420),
 	CPCAP_REG(VDIG, CPCAP_REG_VDIGC, CPCAP_REG_ASSIGN2,
 		  CPCAP_BIT_VDIG_SEL, vdig_val_tbl,
-		  0x87, 0x30, 4, 0x5, 0, 420),
+		  0x87, 0x30, 0x5, 0, 420),
 	CPCAP_REG(VFUSE, CPCAP_REG_VFUSEC, CPCAP_REG_ASSIGN3,
 		  CPCAP_BIT_VFUSE_SEL, vfuse_val_tbl,
-		  0x80, 0xf, 0, 0x80, 0, 420),
+		  0x80, 0xf, 0x80, 0, 420),
 	CPCAP_REG(VHVIO, CPCAP_REG_VHVIOC, CPCAP_REG_ASSIGN3,
 		  CPCAP_BIT_VHVIO_SEL, vhvio_val_tbl,
-		  0x17, 0, 0, 0x2, 0, 0),
+		  0x17, 0, 0x2, 0, 0),
 	CPCAP_REG(VSDIO, CPCAP_REG_VSDIOC, CPCAP_REG_ASSIGN2,
 		  CPCAP_BIT_VSDIO_SEL, vsdio_val_tbl,
-		  0x87, 0x38, 3, 0x2, 0, 420),
+		  0x87, 0x38, 0x2, 0, 420),
 	CPCAP_REG(VPLL, CPCAP_REG_VPLLC, CPCAP_REG_ASSIGN3,
 		  CPCAP_BIT_VPLL_SEL, vpll_val_tbl,
-		  0x43, 0x18, 3, 0x1, 0, 420),
+		  0x43, 0x18, 0x1, 0, 420),
 	CPCAP_REG(VRF1, CPCAP_REG_VRF1C, CPCAP_REG_ASSIGN3,
 		  CPCAP_BIT_VRF1_SEL, vrf1_val_tbl,
-		  0xac, 0x2, 1, 0xc, 0, 10),
+		  0xac, 0x2, 0xc, 0, 10),
 	CPCAP_REG(VRF2, CPCAP_REG_VRF2C, CPCAP_REG_ASSIGN3,
 		  CPCAP_BIT_VRF2_SEL, vrf2_val_tbl,
-		  0x23, 0x8, 3, 0x3, 0, 10),
+		  0x23, 0x8, 0x3, 0, 10),
 	CPCAP_REG(VRFREF, CPCAP_REG_VRFREFC, CPCAP_REG_ASSIGN3,
 		  CPCAP_BIT_VRFREF_SEL, vrfref_val_tbl,
-		  0x23, 0x8, 3, 0x3, 0, 420),
+		  0x23, 0x8, 0x3, 0, 420),
 	CPCAP_REG(VWLAN1, CPCAP_REG_VWLAN1C, CPCAP_REG_ASSIGN3,
 		  CPCAP_BIT_VWLAN1_SEL, vwlan1_val_tbl,
-		  0x47, 0x10, 4, 0x5, 0, 420),
+		  0x47, 0x10, 0x5, 0, 420),
 	CPCAP_REG(VWLAN2, CPCAP_REG_VWLAN2C, CPCAP_REG_ASSIGN3,
 		  CPCAP_BIT_VWLAN2_SEL, vwlan2_val_tbl,
-		  0x20c, 0xc0, 6, 0x8, 0, 420),
+		  0x20c, 0xc0, 0x8, 0, 420),
 	CPCAP_REG(VSIM, CPCAP_REG_VSIMC, CPCAP_REG_ASSIGN3,
 		  0xffff, vsim_val_tbl,
-		  0x23, 0x8, 3, 0x3, 0, 420),
+		  0x23, 0x8, 0x3, 0, 420),
 	CPCAP_REG(VSIMCARD, CPCAP_REG_VSIMC, CPCAP_REG_ASSIGN3,
 		  0xffff, vsimcard_val_tbl,
-		  0x1e80, 0x8, 3, 0x1e00, 0, 420),
+		  0x1e80, 0x8, 0x1e00, 0, 420),
 	CPCAP_REG(VVIB, CPCAP_REG_VVIBC, CPCAP_REG_ASSIGN3,
 		  CPCAP_BIT_VVIB_SEL, vvib_val_tbl,
-		  0x1, 0xc, 2, 0, 0x1, 500),
+		  0x1, 0xc, 0, 0x1, 500),
 	CPCAP_REG(VUSB, CPCAP_REG_VUSBC, CPCAP_REG_ASSIGN3,
 		  CPCAP_BIT_VUSB_SEL, vusb_val_tbl,
-		  0x11c, 0x40, 6, 0xc, 0, 0),
+		  0x11c, 0x40, 0xc, 0, 0),
 	CPCAP_REG(VAUDIO, CPCAP_REG_VAUDIOC, CPCAP_REG_ASSIGN4,
 		  CPCAP_BIT_VAUDIO_SEL, vaudio_val_tbl,
-		  0x16, 0x1, 0, 0x4, 0, 0),
+		  0x16, 0x1, 0x4, 0, 0),
 	{ /* sentinel */ },
 };
 
-- 
2.20.1

