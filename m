Return-Path: <SRS0=i6x1=N7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75B8EC32789
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 16:28:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 40093208E3
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 16:28:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sirena.org.uk header.i=@sirena.org.uk header.b="AhPxJc02"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 40093208E3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729311AbeKUC6P (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Nov 2018 21:58:15 -0500
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:59452 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728601AbeKUC6P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Nov 2018 21:58:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=6DT6EzIDlksYJtpA99O6RrxbUGtlNuweFfuD/LEILwo=; b=AhPxJc02t23N
        l3o4NPYVPj36vA8H7H3jbbg/cdiA7ojhI2Z0ku25WUlCSBE4+WM4Xlm8dJd3C8xQFJfbx7NpA/Edg
        /QXwIcuaEu0QmF9jPrqN8GcR9oYnSZkdErXcWiwJX+iWAEGlY3BA5JE7A4J2WiEphp+1a+vXz7gmt
        vI6iA=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1gP8sn-0001mU-Rn; Tue, 20 Nov 2018 16:28:13 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id 892EF1124DC2; Tue, 20 Nov 2018 16:28:13 +0000 (GMT)
From:   Mark Brown <broonie@kernel.org>
To:     Charles Keepax <ckeepax@opensource.cirrus.com>
Cc:     Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org
Subject: Applied "regulator: lochnagar: Move driver to binding from DT" to the regulator tree
In-Reply-To: 
Message-Id: <20181120162813.892EF1124DC2@debutante.sirena.org.uk>
Date:   Tue, 20 Nov 2018 16:28:13 +0000 (GMT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   regulator: lochnagar: Move driver to binding from DT

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

From d90acbc4e3ddd72ccccebcaf9cdc7ed8da669132 Mon Sep 17 00:00:00 2001
From: Charles Keepax <ckeepax@opensource.cirrus.com>
Date: Tue, 20 Nov 2018 14:16:24 +0000
Subject: [PATCH] regulator: lochnagar: Move driver to binding from DT

Based on review comments on the MFD driver, move the child drivers for
the Lochnagar MFD over to binding through device tree.

Signed-off-by: Charles Keepax <ckeepax@opensource.cirrus.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/regulator/lochnagar-regulator.c | 48 +++++++++++++++++++------
 1 file changed, 37 insertions(+), 11 deletions(-)

diff --git a/drivers/regulator/lochnagar-regulator.c b/drivers/regulator/lochnagar-regulator.c
index 182198246479..5a89e6d4b9a6 100644
--- a/drivers/regulator/lochnagar-regulator.c
+++ b/drivers/regulator/lochnagar-regulator.c
@@ -13,6 +13,7 @@
 #include <linux/module.h>
 #include <linux/mutex.h>
 #include <linux/of.h>
+#include <linux/of_device.h>
 #include <linux/platform_device.h>
 #include <linux/regmap.h>
 #include <linux/regulator/driver.h>
@@ -214,28 +215,52 @@ static const struct regulator_desc lochnagar_regulators[] = {
 	},
 };
 
+static const struct of_device_id lochnagar_of_match[] = {
+	{
+		.compatible = "cirrus,lochnagar2-micvdd",
+		.data = &lochnagar_regulators[LOCHNAGAR_MICVDD],
+	},
+	{
+		.compatible = "cirrus,lochnagar2-mic1vdd",
+		.data = &lochnagar_regulators[LOCHNAGAR_MIC1VDD],
+	},
+	{
+		.compatible = "cirrus,lochnagar2-mic2vdd",
+		.data = &lochnagar_regulators[LOCHNAGAR_MIC1VDD],
+	},
+	{
+		.compatible = "cirrus,lochnagar2-vddcore",
+		.data = &lochnagar_regulators[LOCHNAGAR_VDDCORE],
+	},
+	{},
+};
+
 static int lochnagar_regulator_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
 	struct lochnagar *lochnagar = dev_get_drvdata(dev->parent);
 	struct regulator_config config = { };
+	const struct of_device_id *of_id;
+	const struct regulator_desc *desc;
 	struct regulator_dev *rdev;
-	int ret, i;
+	int ret;
 
-	config.dev = lochnagar->dev;
+	config.dev = dev;
 	config.regmap = lochnagar->regmap;
 	config.driver_data = lochnagar;
 
-	for (i = 0; i < ARRAY_SIZE(lochnagar_regulators); i++) {
-		const struct regulator_desc *desc = &lochnagar_regulators[i];
+	of_id = of_match_device(lochnagar_of_match, dev);
+	if (!of_id)
+		return -EINVAL;
 
-		rdev = devm_regulator_register(dev, desc, &config);
-		if (IS_ERR(rdev)) {
-			ret = PTR_ERR(rdev);
-			dev_err(dev, "Failed to register %s regulator: %d\n",
-				desc->name, ret);
-			return ret;
-		}
+	desc = of_id->data;
+
+	rdev = devm_regulator_register(dev, desc, &config);
+	if (IS_ERR(rdev)) {
+		ret = PTR_ERR(rdev);
+		dev_err(dev, "Failed to register %s regulator: %d\n",
+			desc->name, ret);
+		return ret;
 	}
 
 	return 0;
@@ -244,6 +269,7 @@ static int lochnagar_regulator_probe(struct platform_device *pdev)
 static struct platform_driver lochnagar_regulator_driver = {
 	.driver = {
 		.name = "lochnagar-regulator",
+		.of_match_table = of_match_ptr(lochnagar_of_match),
 	},
 
 	.probe = lochnagar_regulator_probe,
-- 
2.19.0.rc2

