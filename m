Return-Path: <SRS0=tlbf=RB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 327D7C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 16:49:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E95462147C
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 16:49:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551199763;
	bh=IHFIdPT5VDC4J2bi0js7/+ZQrAAMw717nt2fOJJzpY0=;
	h=From:To:Cc:Subject:In-Reply-To:Date:List-ID:From;
	b=1/k0OThZTRCNXcfEScAydagAjBMdLtHlFYbV9QaMyUkkvs5fWdFFjfo8zG2IBGbBh
	 pTMRpi8f1Y15whpZV8uO0183cID8O6uwmjfQj3Zqx9QZzFnDkcofYPc/csMWd2h0dv
	 qfF/7dgK4NlHBPSC7gdQSeifscqePGhfXZugIxMc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727883AbfBZQtV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Feb 2019 11:49:21 -0500
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:52642 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727054AbfBZQtV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Feb 2019 11:49:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=yq+M1WkNR0h/NFMmag/tNW870la5n43j+y9a/Jk3mxc=; b=fcKKy3r4Eq+c
        sl+o1f3AeW6F9h2qRMrGKQ8v0AOqQIUk+aXZQQmTHWIUTSiu0IMnk85ysyG5snX8CqEw3ndlAWck/
        Fl8jJAK8EeIgox1ij9WFl798S2c38Z7H7uWUtABbpBcId6dHNrmOCjKaEk4nNk3kU8E6KMiuY49wO
        7VWk8=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1gyfuw-0000I4-Hg; Tue, 26 Feb 2019 16:49:18 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id C4E2E1121A0A; Tue, 26 Feb 2019 16:49:17 +0000 (GMT)
From:   Mark Brown <broonie@kernel.org>
To:     Axel Lin <axel.lin@ingics.com>
Cc:     Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org
Subject: Applied "regulator: 88pm8607: Remove unused fields from struct pm8607_regulator_info" to the regulator tree
In-Reply-To: 
X-Patchwork-Hint: ignore
Message-Id: <20190226164917.C4E2E1121A0A@debutante.sirena.org.uk>
Date:   Tue, 26 Feb 2019 16:49:17 +0000 (GMT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   regulator: 88pm8607: Remove unused fields from struct pm8607_regulator_info

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

From 0e819b51fb9b2558d7cb85400a47370a631325dc Mon Sep 17 00:00:00 2001
From: Axel Lin <axel.lin@ingics.com>
Date: Tue, 26 Feb 2019 20:40:59 +0800
Subject: [PATCH] regulator: 88pm8607: Remove unused fields from struct
 pm8607_regulator_info

The *i2c and *i2c_8606 are no longer used since this driver was converted
to use regmap helpers. The *chip and *regulator are not really required.
So remove these unused fields.

Signed-off-by: Axel Lin <axel.lin@ingics.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/regulator/88pm8607.c | 19 +++++--------------
 1 file changed, 5 insertions(+), 14 deletions(-)

diff --git a/drivers/regulator/88pm8607.c b/drivers/regulator/88pm8607.c
index 597385d25201..753a6a1b30c3 100644
--- a/drivers/regulator/88pm8607.c
+++ b/drivers/regulator/88pm8607.c
@@ -11,7 +11,6 @@
 #include <linux/kernel.h>
 #include <linux/init.h>
 #include <linux/err.h>
-#include <linux/i2c.h>
 #include <linux/of.h>
 #include <linux/regulator/of_regulator.h>
 #include <linux/platform_device.h>
@@ -22,10 +21,6 @@
 
 struct pm8607_regulator_info {
 	struct regulator_desc	desc;
-	struct pm860x_chip	*chip;
-	struct regulator_dev	*regulator;
-	struct i2c_client	*i2c;
-	struct i2c_client	*i2c_8606;
 
 	unsigned int	*vol_suspend;
 
@@ -350,6 +345,7 @@ static int pm8607_regulator_probe(struct platform_device *pdev)
 	struct pm8607_regulator_info *info = NULL;
 	struct regulator_init_data *pdata = dev_get_platdata(&pdev->dev);
 	struct regulator_config config = { };
+	struct regulator_dev *rdev;
 	struct resource *res;
 	int i;
 
@@ -372,13 +368,9 @@ static int pm8607_regulator_probe(struct platform_device *pdev)
 		/* i is used to check regulator ID */
 		i = -1;
 	}
-	info->i2c = (chip->id == CHIP_PM8607) ? chip->client : chip->companion;
-	info->i2c_8606 = (chip->id == CHIP_PM8607) ? chip->companion :
-			chip->client;
-	info->chip = chip;
 
 	/* check DVC ramp slope double */
-	if ((i == PM8607_ID_BUCK3) && info->chip->buck3_double)
+	if ((i == PM8607_ID_BUCK3) && chip->buck3_double)
 		info->slope_double = 1;
 
 	config.dev = &pdev->dev;
@@ -393,12 +385,11 @@ static int pm8607_regulator_probe(struct platform_device *pdev)
 	else
 		config.regmap = chip->regmap_companion;
 
-	info->regulator = devm_regulator_register(&pdev->dev, &info->desc,
-						  &config);
-	if (IS_ERR(info->regulator)) {
+	rdev = devm_regulator_register(&pdev->dev, &info->desc, &config);
+	if (IS_ERR(rdev)) {
 		dev_err(&pdev->dev, "failed to register regulator %s\n",
 			info->desc.name);
-		return PTR_ERR(info->regulator);
+		return PTR_ERR(rdev);
 	}
 
 	platform_set_drvdata(pdev, info);
-- 
2.20.1

