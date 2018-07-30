Return-Path: <SRS0=qqIy=KO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C10E016256E1
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 16:03:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 55684205C9
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 16:03:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sirena.org.uk header.i=@sirena.org.uk header.b="kmD/KUXy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 55684205C9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726916AbeG3Riu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Jul 2018 13:38:50 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:45524 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726681AbeG3Riu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jul 2018 13:38:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=nD1ADE8OmyxmMGDDv+zK01i5aIAD1spQNLVroH7KX5c=; b=kmD/KUXy3ajt
        cj2NpVNXteKjSMTZr/MhQhgUECfb/FT1nIeHiXXM5nj/jvH92A0WqPzANGz1KSR8Wstcg4JlBaAD4
        jIsruobqkghWVR1zVUkUF5IfzseSNykLGXa4iqelEF/D3KoyH53upxpdWnCCSzd4y5krYIJXfZLkI
        Ohsa0=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1fkAdZ-0005YD-Qk; Mon, 30 Jul 2018 16:03:09 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id 770721124216; Mon, 30 Jul 2018 17:03:09 +0100 (BST)
From:   Mark Brown <broonie@kernel.org>
To:     Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
Cc:     Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org
Subject: Applied "regulator: bd71837: adobt MFD changes to regulator driver" to the regulator tree
In-Reply-To: 
Message-Id: <20180730160309.770721124216@debutante.sirena.org.uk>
Date:   Mon, 30 Jul 2018 17:03:09 +0100 (BST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   regulator: bd71837: adobt MFD changes to regulator driver

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

From 410e8b4f5ca34e026ffc460a86e2354febe06fac Mon Sep 17 00:00:00 2001
From: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
Date: Mon, 30 Jul 2018 14:50:08 +0300
Subject: [PATCH] regulator: bd71837: adobt MFD changes to regulator driver

MFD part for bd71837 was changed during the review. Clean regulator part to
match changed MFD:
- renamed header file => fix include
- remove unused platdata as also type definition was removed
- Kconfig option for MFD part was changed => fix depends on clause
- Rename Kconfig option for regulators
  As Kconfig option for regulators gets now used (when dependency to MFD is
  satisfied) change it so that it won't require new change when support for
  bd71847 is added.

Signed-off-by: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/regulator/Kconfig             | 4 ++--
 drivers/regulator/Makefile            | 2 +-
 drivers/regulator/bd71837-regulator.c | 7 +------
 3 files changed, 4 insertions(+), 9 deletions(-)

diff --git a/drivers/regulator/Kconfig b/drivers/regulator/Kconfig
index 8233dc7f0a68..347351e79b1e 100644
--- a/drivers/regulator/Kconfig
+++ b/drivers/regulator/Kconfig
@@ -180,9 +180,9 @@ config REGULATOR_BCM590XX
 	  BCM590xx PMUs. This will enable support for the software
 	  controllable LDO/Switching regulators.
 
-config REGULATOR_BD71837
+config REGULATOR_BD718XX
 	tristate "ROHM BD71837 Power Regulator"
-	depends on MFD_BD71837
+	depends on MFD_ROHM_BD718XX
 	help
 	  This driver supports voltage regulators on ROHM BD71837 PMIC.
 	  This will enable support for the software controllable buck
diff --git a/drivers/regulator/Makefile b/drivers/regulator/Makefile
index b7839f41591e..18bfed61e7fe 100644
--- a/drivers/regulator/Makefile
+++ b/drivers/regulator/Makefile
@@ -27,7 +27,7 @@ obj-$(CONFIG_REGULATOR_AS3711) += as3711-regulator.o
 obj-$(CONFIG_REGULATOR_AS3722) += as3722-regulator.o
 obj-$(CONFIG_REGULATOR_AXP20X) += axp20x-regulator.o
 obj-$(CONFIG_REGULATOR_BCM590XX) += bcm590xx-regulator.o
-obj-$(CONFIG_REGULATOR_BD71837) += bd71837-regulator.o
+obj-$(CONFIG_REGULATOR_BD718XX) += bd71837-regulator.o
 obj-$(CONFIG_REGULATOR_BD9571MWV) += bd9571mwv-regulator.o
 obj-$(CONFIG_REGULATOR_DA903X)	+= da903x.o
 obj-$(CONFIG_REGULATOR_DA9052)	+= da9052-regulator.o
diff --git a/drivers/regulator/bd71837-regulator.c b/drivers/regulator/bd71837-regulator.c
index 3a487255482c..0f8ac8dec3e1 100644
--- a/drivers/regulator/bd71837-regulator.c
+++ b/drivers/regulator/bd71837-regulator.c
@@ -7,7 +7,7 @@
 #include <linux/gpio.h>
 #include <linux/interrupt.h>
 #include <linux/kernel.h>
-#include <linux/mfd/bd71837.h>
+#include <linux/mfd/rohm-bd718x7.h>
 #include <linux/module.h>
 #include <linux/platform_device.h>
 #include <linux/regulator/driver.h>
@@ -490,7 +490,6 @@ struct reg_init {
 static int bd71837_probe(struct platform_device *pdev)
 {
 	struct bd71837_pmic *pmic;
-	struct bd71837_board *pdata;
 	struct regulator_config config = { 0 };
 	struct reg_init pmic_regulator_inits[] = {
 		{
@@ -558,7 +557,6 @@ static int bd71837_probe(struct platform_device *pdev)
 		goto err;
 	}
 	platform_set_drvdata(pdev, pmic);
-	pdata = dev_get_platdata(pmic->mfd->dev);
 
 	/* Register LOCK release */
 	err = regmap_update_bits(pmic->mfd->regmap, BD71837_REG_REGLOCK,
@@ -578,9 +576,6 @@ static int bd71837_probe(struct platform_device *pdev)
 
 		desc = &pmic->descs[i];
 
-		if (pdata)
-			config.init_data = pdata->init_data[i];
-
 		config.dev = pdev->dev.parent;
 		config.driver_data = pmic;
 		config.regmap = pmic->mfd->regmap;
-- 
2.18.0

