Return-Path: <SRS0=sLOc=QZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F60EC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 18:49:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 036532177E
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 18:49:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550515795;
	bh=nREbvS+I1//rWUfniaR+F7OPeGp44/lj9cwAJmKVWJw=;
	h=From:To:Cc:Subject:In-Reply-To:Date:List-ID:From;
	b=soLVt/1hxTZQKEAs6KQKOCgITq0GSug/QKnQIxqBfSMZefJskZmK5BF71uA+hmN4D
	 +Te0XJBNN8Cv+vEPOeuc5f/y37H9s5ShYbok6TjE2ajln3kpVZpXmNcGEs+WgD4voq
	 b98TU+fSS/NpjuV2ysBunFFls5JsbRU151dZ1jic=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726989AbfBRStx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Feb 2019 13:49:53 -0500
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:42436 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726685AbfBRStw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Feb 2019 13:49:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=1353i1blkWlPboNW7W34bHqFXcZ7Xb4PWkOI03EVOcs=; b=TSt96JOWaIKa
        oiLTn+4cKuLZJkBVfDLMZ+fKgFoo7Flm9xYZSBMiUlm2901QUxO8WJaqesjh9TDpgZUV4CaET7mpv
        hD2fO6t8rUMYiDGL4XMBuYhV/HMOkajD85ceNJ/kvxYkslEJ26cXpcGeBZA0yg9Vjwjxc5bzf0Saa
        fU/PY=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1gvnzC-0001fl-9n; Mon, 18 Feb 2019 18:49:50 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id D8BAD1128008; Mon, 18 Feb 2019 18:49:49 +0000 (GMT)
From:   Mark Brown <broonie@kernel.org>
To:     Axel Lin <axel.lin@ingics.com>
Cc:     Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org
Subject: Applied "regulator: stpmic1: Remove regul_id and *regmap from struct stpmic1_regulator" to the regulator tree
In-Reply-To: 
X-Patchwork-Hint: ignore
Message-Id: <20190218184949.D8BAD1128008@debutante.sirena.org.uk>
Date:   Mon, 18 Feb 2019 18:49:49 +0000 (GMT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   regulator: stpmic1: Remove regul_id and *regmap from struct stpmic1_regulator

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

From ef541f73d1a87723a9f5bcc76669c98d20292cfa Mon Sep 17 00:00:00 2001
From: Axel Lin <axel.lin@ingics.com>
Date: Thu, 14 Feb 2019 09:59:56 +0800
Subject: [PATCH] regulator: stpmic1: Remove regul_id and *regmap from struct
 stpmic1_regulator

At the context with *rdev available, regulator core provides
rdev_get_id()/rdev_get_regmap() APIs to get regulator id and *regmap.
So no need to store them in struct stpmic1_regulator.

Signed-off-by: Axel Lin <axel.lin@ingics.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/regulator/stpmic1_regulator.c | 12 ++++--------
 1 file changed, 4 insertions(+), 8 deletions(-)

diff --git a/drivers/regulator/stpmic1_regulator.c b/drivers/regulator/stpmic1_regulator.c
index 963e67fa9ca6..d456fb5d4044 100644
--- a/drivers/regulator/stpmic1_regulator.c
+++ b/drivers/regulator/stpmic1_regulator.c
@@ -30,20 +30,16 @@ struct stpmic1_regulator_cfg {
 
 /**
  * stpmic1 regulator data: this structure is used as driver data
- * @regul_id: regulator id
  * @reg_node: DT node of regulator (unused on non-DT platforms)
  * @cfg: stpmic specific regulator description
  * @mask_reset: mask_reset bit value
  * @irq_curlim: current limit interrupt number
- * @regmap: point to parent regmap structure
  */
 struct stpmic1_regulator {
-	unsigned int regul_id;
 	struct device_node *reg_node;
 	const struct stpmic1_regulator_cfg *cfg;
 	u8 mask_reset;
 	int irq_curlim;
-	struct regmap *regmap;
 };
 
 static int stpmic1_set_mode(struct regulator_dev *rdev, unsigned int mode);
@@ -475,9 +471,10 @@ static int stpmic1_set_mode(struct regulator_dev *rdev, unsigned int mode)
 static int stpmic1_set_icc(struct regulator_dev *rdev)
 {
 	struct stpmic1_regulator *regul = rdev_get_drvdata(rdev);
+	struct regmap *regmap = rdev_get_regmap(rdev);
 
 	/* enable switch off in case of over current */
-	return regmap_update_bits(regul->regmap, regul->cfg->icc_reg,
+	return regmap_update_bits(regmap, regul->cfg->icc_reg,
 				  regul->cfg->icc_mask, regul->cfg->icc_mask);
 }
 
@@ -501,11 +498,12 @@ static int stpmic1_regulator_init(struct platform_device *pdev,
 				  struct regulator_dev *rdev)
 {
 	struct stpmic1_regulator *regul = rdev_get_drvdata(rdev);
+	struct regmap *regmap = rdev_get_regmap(rdev);
 	int ret = 0;
 
 	/* set mask reset */
 	if (regul->mask_reset && regul->cfg->mask_reset_reg != 0) {
-		ret = regmap_update_bits(regul->regmap,
+		ret = regmap_update_bits(regmap,
 					 regul->cfg->mask_reset_reg,
 					 regul->cfg->mask_reset_mask,
 					 regul->cfg->mask_reset_mask);
@@ -584,10 +582,8 @@ regulator_dev *stpmic1_regulator_register(struct platform_device *pdev, int id,
 	config.regmap = pmic_dev->regmap;
 	config.driver_data = regul;
 
-	regul->regul_id = id;
 	regul->reg_node = config.of_node;
 	regul->cfg = &stpmic1_regulator_cfgs[id];
-	regul->regmap = pmic_dev->regmap;
 
 	rdev = devm_regulator_register(&pdev->dev, &regul->cfg->desc, &config);
 	if (IS_ERR(rdev)) {
-- 
2.20.1

