Return-Path: <SRS0=hTZH=KI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CEEB6ECDFB8
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 16:02:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5945220874
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 16:02:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sirena.org.uk header.i=@sirena.org.uk header.b="ZZIB/t4H"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5945220874
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388614AbeGXRJy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Jul 2018 13:09:54 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:33708 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388332AbeGXRJx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jul 2018 13:09:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=llA8ltiWVgBMQwZLuUX6yr/Om+3vB/+K7UUq7MyGYp8=; b=ZZIB/t4Hetu4
        yIu2zqYG0K2RaMN5o5RdrHhfO5BBn4Smy083CuOssY3GPMpraSp0GjU2MbcSBSzl43xsoYPj4gV9F
        UpIUrofdQZnFDZesWVUNoRF9s1Kygnd/UI1+QQmOgJtQs9JTAFqgyeCnzDCe8GcpPtBnywVlHhzd9
        W1t0c=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1fhzlr-0005aj-2x; Tue, 24 Jul 2018 16:02:43 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id D33161123A86; Tue, 24 Jul 2018 17:02:42 +0100 (BST)
From:   Mark Brown <broonie@kernel.org>
To:     Peter Geis <pgwipeout@gmail.com>
Cc:     Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org
Subject: Applied "regulator: Add support for CPCAP regulators on Motorola Xoom devices." to the regulator tree
In-Reply-To: 
Message-Id: <20180724160242.D33161123A86@debutante.sirena.org.uk>
Date:   Tue, 24 Jul 2018 17:02:42 +0100 (BST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   regulator: Add support for CPCAP regulators on Motorola Xoom devices.

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

From 6c0b319c0306accd92dc1601f8bf42adc147d4bf Mon Sep 17 00:00:00 2001
From: Peter Geis <pgwipeout@gmail.com>
Date: Tue, 24 Jul 2018 09:25:41 -0400
Subject: [PATCH] regulator: Add support for CPCAP regulators on Motorola Xoom
 devices.

Added support for the CPCAP power management regulator functions on
Tegra based Motorola Xoom devices.
Added sw2_sw4 value tables, which provide power to the Tegra core and
aux devices.
Added the Xoom init tables and device tree compatibility match.

Signed-off-by: Peter Geis <pgwipeout@gmail.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 .../bindings/regulator/cpcap-regulator.txt    |  1 +
 drivers/regulator/cpcap-regulator.c           | 80 +++++++++++++++++++
 2 files changed, 81 insertions(+)

diff --git a/Documentation/devicetree/bindings/regulator/cpcap-regulator.txt b/Documentation/devicetree/bindings/regulator/cpcap-regulator.txt
index 675f4437ce92..36f5e2f5cc0f 100644
--- a/Documentation/devicetree/bindings/regulator/cpcap-regulator.txt
+++ b/Documentation/devicetree/bindings/regulator/cpcap-regulator.txt
@@ -5,6 +5,7 @@ Requires node properties:
 - "compatible" value one of:
     "motorola,cpcap-regulator"
     "motorola,mapphone-cpcap-regulator"
+    "motorola,xoom-cpcap-regulator"
 
 Required regulator properties:
 - "regulator-name"
diff --git a/drivers/regulator/cpcap-regulator.c b/drivers/regulator/cpcap-regulator.c
index c0b1e04bd90f..2131457937b7 100644
--- a/drivers/regulator/cpcap-regulator.c
+++ b/drivers/regulator/cpcap-regulator.c
@@ -412,6 +412,82 @@ static struct cpcap_regulator omap4_regulators[] = {
 	{ /* sentinel */ },
 };
 
+static struct cpcap_regulator xoom_regulators[] = {
+	CPCAP_REG(SW1, CPCAP_REG_S1C1, CPCAP_REG_ASSIGN2,
+		  CPCAP_BIT_SW1_SEL, unknown_val_tbl,
+		  0, 0, 0, 0, 0, 0),
+	CPCAP_REG(SW2, CPCAP_REG_S2C1, CPCAP_REG_ASSIGN2,
+		  CPCAP_BIT_SW2_SEL, sw2_sw4_val_tbl,
+		  0xf00, 0x7f, 0, 0x800, 0, 120),
+	CPCAP_REG(SW3, CPCAP_REG_S3C, CPCAP_REG_ASSIGN2,
+		  CPCAP_BIT_SW3_SEL, unknown_val_tbl,
+		  0, 0, 0, 0, 0, 0),
+	CPCAP_REG(SW4, CPCAP_REG_S4C1, CPCAP_REG_ASSIGN2,
+		  CPCAP_BIT_SW4_SEL, sw2_sw4_val_tbl,
+		  0xf00, 0x7f, 0, 0x900, 0, 100),
+	CPCAP_REG(SW5, CPCAP_REG_S5C, CPCAP_REG_ASSIGN2,
+		  CPCAP_BIT_SW5_SEL, sw5_val_tbl,
+		  0x2a, 0, 0, 0x22, 0, 0),
+	CPCAP_REG(SW6, CPCAP_REG_S6C, CPCAP_REG_ASSIGN2,
+		  CPCAP_BIT_SW6_SEL, unknown_val_tbl,
+		  0, 0, 0, 0, 0, 0),
+	CPCAP_REG(VCAM, CPCAP_REG_VCAMC, CPCAP_REG_ASSIGN2,
+		  CPCAP_BIT_VCAM_SEL, vcam_val_tbl,
+		  0x87, 0x30, 4, 0x7, 0, 420),
+	CPCAP_REG(VCSI, CPCAP_REG_VCSIC, CPCAP_REG_ASSIGN3,
+		  CPCAP_BIT_VCSI_SEL, vcsi_val_tbl,
+		  0x47, 0x10, 4, 0x7, 0, 350),
+	CPCAP_REG(VDAC, CPCAP_REG_VDACC, CPCAP_REG_ASSIGN3,
+		  CPCAP_BIT_VDAC_SEL, vdac_val_tbl,
+		  0x87, 0x30, 4, 0x3, 0, 420),
+	CPCAP_REG(VDIG, CPCAP_REG_VDIGC, CPCAP_REG_ASSIGN2,
+		  CPCAP_BIT_VDIG_SEL, vdig_val_tbl,
+		  0x87, 0x30, 4, 0x5, 0, 420),
+	CPCAP_REG(VFUSE, CPCAP_REG_VFUSEC, CPCAP_REG_ASSIGN3,
+		  CPCAP_BIT_VFUSE_SEL, vfuse_val_tbl,
+		  0x80, 0xf, 0, 0x80, 0, 420),
+	CPCAP_REG(VHVIO, CPCAP_REG_VHVIOC, CPCAP_REG_ASSIGN3,
+		  CPCAP_BIT_VHVIO_SEL, vhvio_val_tbl,
+		  0x17, 0, 0, 0x2, 0, 0),
+	CPCAP_REG(VSDIO, CPCAP_REG_VSDIOC, CPCAP_REG_ASSIGN2,
+		  CPCAP_BIT_VSDIO_SEL, vsdio_val_tbl,
+		  0x87, 0x38, 3, 0x2, 0, 420),
+	CPCAP_REG(VPLL, CPCAP_REG_VPLLC, CPCAP_REG_ASSIGN3,
+		  CPCAP_BIT_VPLL_SEL, vpll_val_tbl,
+		  0x43, 0x18, 3, 0x1, 0, 420),
+	CPCAP_REG(VRF1, CPCAP_REG_VRF1C, CPCAP_REG_ASSIGN3,
+		  CPCAP_BIT_VRF1_SEL, vrf1_val_tbl,
+		  0xac, 0x2, 1, 0xc, 0, 10),
+	CPCAP_REG(VRF2, CPCAP_REG_VRF2C, CPCAP_REG_ASSIGN3,
+		  CPCAP_BIT_VRF2_SEL, vrf2_val_tbl,
+		  0x23, 0x8, 3, 0x3, 0, 10),
+	CPCAP_REG(VRFREF, CPCAP_REG_VRFREFC, CPCAP_REG_ASSIGN3,
+		  CPCAP_BIT_VRFREF_SEL, vrfref_val_tbl,
+		  0x23, 0x8, 3, 0x3, 0, 420),
+	CPCAP_REG(VWLAN1, CPCAP_REG_VWLAN1C, CPCAP_REG_ASSIGN3,
+		  CPCAP_BIT_VWLAN1_SEL, vwlan1_val_tbl,
+		  0x47, 0x10, 4, 0x5, 0, 420),
+	CPCAP_REG(VWLAN2, CPCAP_REG_VWLAN2C, CPCAP_REG_ASSIGN3,
+		  CPCAP_BIT_VWLAN2_SEL, vwlan2_val_tbl,
+		  0x20c, 0xc0, 6, 0x8, 0, 420),
+	CPCAP_REG(VSIM, CPCAP_REG_VSIMC, CPCAP_REG_ASSIGN3,
+		  0xffff, vsim_val_tbl,
+		  0x23, 0x8, 3, 0x3, 0, 420),
+	CPCAP_REG(VSIMCARD, CPCAP_REG_VSIMC, CPCAP_REG_ASSIGN3,
+		  0xffff, vsimcard_val_tbl,
+		  0x1e80, 0x8, 3, 0x1e00, 0, 420),
+	CPCAP_REG(VVIB, CPCAP_REG_VVIBC, CPCAP_REG_ASSIGN3,
+		  CPCAP_BIT_VVIB_SEL, vvib_val_tbl,
+		  0x1, 0xc, 2, 0, 0x1, 500),
+	CPCAP_REG(VUSB, CPCAP_REG_VUSBC, CPCAP_REG_ASSIGN3,
+		  CPCAP_BIT_VUSB_SEL, vusb_val_tbl,
+		  0x11c, 0x40, 6, 0xc, 0, 0),
+	CPCAP_REG(VAUDIO, CPCAP_REG_VAUDIOC, CPCAP_REG_ASSIGN4,
+		  CPCAP_BIT_VAUDIO_SEL, vaudio_val_tbl,
+		  0x16, 0x1, 0, 0x4, 0, 0),
+	{ /* sentinel */ },
+};
+
 static const struct of_device_id cpcap_regulator_id_table[] = {
 	{
 		.compatible = "motorola,cpcap-regulator",
@@ -420,6 +496,10 @@ static const struct of_device_id cpcap_regulator_id_table[] = {
 		.compatible = "motorola,mapphone-cpcap-regulator",
 		.data = omap4_regulators,
 	},
+	{
+		.compatible = "motorola,xoom-cpcap-regulator",
+		.data = xoom_regulators,
+	},
 	{},
 };
 MODULE_DEVICE_TABLE(of, cpcap_regulator_id_table);
-- 
2.18.0

