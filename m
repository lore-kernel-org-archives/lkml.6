Return-Path: <SRS0=I82Q=LM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 822E2C433F5
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 15:09:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1B5B52054F
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 15:09:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sirena.org.uk header.i=@sirena.org.uk header.b="DasO5J01"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1B5B52054F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728958AbeH2TGd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Aug 2018 15:06:33 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:54560 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727668AbeH2TGd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Aug 2018 15:06:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=W1kFCM+UVn2VYnFzZuCFenW/onMu0fuDSplYhOLzSjI=; b=DasO5J01sGos
        //zmuVNT5JZPAsjY6JbTn7U2FllDqQZAUjCiPpj769YnwkV6lfIorf1Hge4TdOOgO1ErkIgFB81W2
        5DGTh9EXY9QjtnRMyfSayRGx30knFzXUnLSZymC5VfPXn2TLncZr7U0xxts0EfIUgF6eD5ZNLyf6G
        UkyUA=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1fv25i-0000Q3-AS; Wed, 29 Aug 2018 15:09:06 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id 13352112486B; Wed, 29 Aug 2018 16:09:06 +0100 (BST)
From:   Mark Brown <broonie@kernel.org>
To:     Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
Cc:     Mark Brown <broonie@kernel.org>, stable@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Applied "regulator: bd71837: Disable voltage monitoring for LDO3/4" to the regulator tree
In-Reply-To: 
Message-Id: <20180829150906.13352112486B@debutante.sirena.org.uk>
Date:   Wed, 29 Aug 2018 16:09:06 +0100 (BST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   regulator: bd71837: Disable voltage monitoring for LDO3/4

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

From 823f18f8b860526fc099c222619a126d57d2ad8c Mon Sep 17 00:00:00 2001
From: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
Date: Wed, 29 Aug 2018 15:36:10 +0300
Subject: [PATCH] regulator: bd71837: Disable voltage monitoring for LDO3/4

There is a HW quirk in BD71837. The shutdown sequence timings for
bucks/LDOs which are enabled via register interface are changed.
At PMIC poweroff the voltage for BUCK6/7 is cut immediately at the
beginning of shut-down sequence. This causes LDO5/6 voltage
monitoring to detect under voltage and force PMIC to emergency
state instead of poweroff. Disable voltage monitoring for LDO5 and
LDO6 at probe to avoid this.

Signed-off-by: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
Cc: stable@vger.kernel.org
---
 drivers/regulator/bd71837-regulator.c | 19 +++++++++++++++
 include/linux/mfd/rohm-bd718x7.h      | 33 ++++++++++++++++++++++++---
 2 files changed, 49 insertions(+), 3 deletions(-)

diff --git a/drivers/regulator/bd71837-regulator.c b/drivers/regulator/bd71837-regulator.c
index 0f8ac8dec3e1..a1bd8aaf4d98 100644
--- a/drivers/regulator/bd71837-regulator.c
+++ b/drivers/regulator/bd71837-regulator.c
@@ -569,6 +569,25 @@ static int bd71837_probe(struct platform_device *pdev)
 			BD71837_REG_REGLOCK);
 	}
 
+	/*
+	 * There is a HW quirk in BD71837. The shutdown sequence timings for
+	 * bucks/LDOs which are controlled via register interface are changed.
+	 * At PMIC poweroff the voltage for BUCK6/7 is cut immediately at the
+	 * beginning of shut-down sequence. As bucks 6 and 7 are parent
+	 * supplies for LDO5 and LDO6 - this causes LDO5/6 voltage
+	 * monitoring to errorneously detect under voltage and force PMIC to
+	 * emergency state instead of poweroff. In order to avoid this we
+	 * disable voltage monitoring for LDO5 and LDO6
+	 */
+	err = regmap_update_bits(pmic->mfd->regmap, BD718XX_REG_MVRFLTMASK2,
+				 BD718XX_LDO5_VRMON80 | BD718XX_LDO6_VRMON80,
+				 BD718XX_LDO5_VRMON80 | BD718XX_LDO6_VRMON80);
+	if (err) {
+		dev_err(&pmic->pdev->dev,
+			"Failed to disable voltage monitoring\n");
+		goto err;
+	}
+
 	for (i = 0; i < ARRAY_SIZE(pmic_regulator_inits); i++) {
 
 		struct regulator_desc *desc;
diff --git a/include/linux/mfd/rohm-bd718x7.h b/include/linux/mfd/rohm-bd718x7.h
index a528747f8aed..e8338e5dc10b 100644
--- a/include/linux/mfd/rohm-bd718x7.h
+++ b/include/linux/mfd/rohm-bd718x7.h
@@ -78,9 +78,9 @@ enum {
 	BD71837_REG_TRANS_COND0        = 0x1F,
 	BD71837_REG_TRANS_COND1        = 0x20,
 	BD71837_REG_VRFAULTEN          = 0x21,
-	BD71837_REG_MVRFLTMASK0        = 0x22,
-	BD71837_REG_MVRFLTMASK1        = 0x23,
-	BD71837_REG_MVRFLTMASK2        = 0x24,
+	BD718XX_REG_MVRFLTMASK0        = 0x22,
+	BD718XX_REG_MVRFLTMASK1        = 0x23,
+	BD718XX_REG_MVRFLTMASK2        = 0x24,
 	BD71837_REG_RCVCFG             = 0x25,
 	BD71837_REG_RCVNUM             = 0x26,
 	BD71837_REG_PWRONCONFIG0       = 0x27,
@@ -159,6 +159,33 @@ enum {
 #define BUCK8_MASK		0x3F
 #define BUCK8_DEFAULT		0x1E
 
+/* BD718XX Voltage monitoring masks */
+#define BD718XX_BUCK1_VRMON80           0x1
+#define BD718XX_BUCK1_VRMON130          0x2
+#define BD718XX_BUCK2_VRMON80           0x4
+#define BD718XX_BUCK2_VRMON130          0x8
+#define BD718XX_1ST_NODVS_BUCK_VRMON80  0x1
+#define BD718XX_1ST_NODVS_BUCK_VRMON130 0x2
+#define BD718XX_2ND_NODVS_BUCK_VRMON80  0x4
+#define BD718XX_2ND_NODVS_BUCK_VRMON130 0x8
+#define BD718XX_3RD_NODVS_BUCK_VRMON80  0x10
+#define BD718XX_3RD_NODVS_BUCK_VRMON130 0x20
+#define BD718XX_4TH_NODVS_BUCK_VRMON80  0x40
+#define BD718XX_4TH_NODVS_BUCK_VRMON130 0x80
+#define BD718XX_LDO1_VRMON80            0x1
+#define BD718XX_LDO2_VRMON80            0x2
+#define BD718XX_LDO3_VRMON80            0x4
+#define BD718XX_LDO4_VRMON80            0x8
+#define BD718XX_LDO5_VRMON80            0x10
+#define BD718XX_LDO6_VRMON80            0x20
+
+/* BD71837 specific voltage monitoring masks */
+#define BD71837_BUCK3_VRMON80           0x10
+#define BD71837_BUCK3_VRMON130          0x20
+#define BD71837_BUCK4_VRMON80           0x40
+#define BD71837_BUCK4_VRMON130          0x80
+#define BD71837_LDO7_VRMON80            0x40
+
 /* BD71837_REG_IRQ bits */
 #define IRQ_SWRST		0x40
 #define IRQ_PWRON_S		0x20
-- 
2.18.0

