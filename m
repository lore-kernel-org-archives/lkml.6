Return-Path: <SRS0=tlbf=RB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1009FC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 12:07:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CABA921855
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 12:07:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551182825;
	bh=0fGgGADy7jSSs6E/FUf7EiPrGCVGhPalWNpkNBjGvxk=;
	h=From:To:Cc:Subject:In-Reply-To:Date:List-ID:From;
	b=r9yYHs/Rzs7IVUew/N24KgLngRbuYBMhvujjpgs0fhgQN9TZ4/Zyhse2dgU4T7kPE
	 dvMW5Qr7EY07K8gVQg/PcyfeHppRHNGjtd+48MJhfERYSjel6o3eLCUug7SFzNU/Xc
	 y91dhimGGIDuaNHZWROAbl5ekUX0srC4P559mDFU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727517AbfBZMHE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Feb 2019 07:07:04 -0500
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:58614 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727378AbfBZMHB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Feb 2019 07:07:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=zGlu9JfKuXSyM5cwCIkF+XxUMh36GQrs4Dhmit0Uwso=; b=dhyUT81cQ/fU
        iWBscDlcTfkog0MqibZh3ARkxMEoePapPnaI6Kl9XMVSqXqFl+WhUy3qOtq16Lk+Hrg81dXfurgAB
        Rs9OHpE40VQCoheoMLZFOyiK6qYYAgD6a3XdNpQKbFziDTydCC/Njt8q+wLjw3q+GqQprxQ1877Zi
        jDrms=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1gybVj-0007jX-LP; Tue, 26 Feb 2019 12:06:59 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id 23BEE11284E3; Tue, 26 Feb 2019 12:06:59 +0000 (GMT)
From:   Mark Brown <broonie@kernel.org>
To:     Christian Hohnstaedt <Christian.Hohnstaedt@wago.com>
Cc:     Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org
Subject: Applied "regulator: tps65218: Add support for LS2" to the regulator tree
In-Reply-To: 
X-Patchwork-Hint: ignore
Message-Id: <20190226120659.23BEE11284E3@debutante.sirena.org.uk>
Date:   Tue, 26 Feb 2019 12:06:59 +0000 (GMT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   regulator: tps65218: Add support for LS2

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

From e5c8ba0635a81f90f51efd3d9a4c0c404e463d0f Mon Sep 17 00:00:00 2001
From: Christian Hohnstaedt <Christian.Hohnstaedt@wago.com>
Date: Fri, 22 Feb 2019 09:38:54 +0100
Subject: [PATCH] regulator: tps65218: Add support for LS2

Re-use the "tps65218_pmic_*_current_limit()" functions of LS3
and calculate the different required bit-shift by counting the
trailing 0s in "struct regulator_desc.csel_mask"

Signed-off-by: Christian Hohnstaedt <Christian.Hohnstaedt@wago.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/regulator/tps65218-regulator.c | 18 +++++++++++++-----
 include/linux/mfd/tps65218.h           |  3 ++-
 2 files changed, 15 insertions(+), 6 deletions(-)

diff --git a/drivers/regulator/tps65218-regulator.c b/drivers/regulator/tps65218-regulator.c
index 6209beee1018..df333b7702cb 100644
--- a/drivers/regulator/tps65218-regulator.c
+++ b/drivers/regulator/tps65218-regulator.c
@@ -204,7 +204,8 @@ static int tps65218_pmic_set_input_current_lim(struct regulator_dev *dev,
 		return -EINVAL;
 
 	return tps65218_set_bits(tps, dev->desc->csel_reg, dev->desc->csel_mask,
-				 index << 2, TPS65218_PROTECT_L1);
+				 index << __builtin_ctz(dev->desc->csel_mask),
+				 TPS65218_PROTECT_L1);
 }
 
 static int tps65218_pmic_set_current_limit(struct regulator_dev *dev,
@@ -223,7 +224,8 @@ static int tps65218_pmic_set_current_limit(struct regulator_dev *dev,
 		return -EINVAL;
 
 	return tps65218_set_bits(tps, dev->desc->csel_reg, dev->desc->csel_mask,
-				 index << 2, TPS65218_PROTECT_L1);
+				 index << __builtin_ctz(dev->desc->csel_mask),
+				 TPS65218_PROTECT_L1);
 }
 
 static int tps65218_pmic_get_current_limit(struct regulator_dev *dev)
@@ -236,12 +238,13 @@ static int tps65218_pmic_get_current_limit(struct regulator_dev *dev)
 	if (retval < 0)
 		return retval;
 
-	index = (index & dev->desc->csel_mask) >> 2;
+	index = (index & dev->desc->csel_mask) >>
+					 __builtin_ctz(dev->desc->csel_mask);
 
 	return ls3_currents[index];
 }
 
-static struct regulator_ops tps65218_ls3_ops = {
+static struct regulator_ops tps65218_ls23_ops = {
 	.is_enabled		= regulator_is_enabled_regmap,
 	.enable			= tps65218_pmic_enable,
 	.disable		= tps65218_pmic_disable,
@@ -303,8 +306,13 @@ static const struct regulator_desc regulators[] = {
 			   TPS65218_ENABLE2_LDO1_EN, 0, 0, ldo1_dcdc3_ranges,
 			   2, 0, 0, TPS65218_REG_SEQ6,
 			   TPS65218_SEQ6_LDO1_SEQ_MASK),
+	TPS65218_REGULATOR("LS2", "regulator-ls2", TPS65218_LS_2,
+			   REGULATOR_CURRENT, tps65218_ls23_ops, 0, 0, 0,
+			   TPS65218_REG_ENABLE2, TPS65218_ENABLE2_LS2_EN,
+			   TPS65218_REG_CONFIG2, TPS65218_CONFIG2_LS2ILIM_MASK,
+			   NULL, 0, 0, 0, 0, 0),
 	TPS65218_REGULATOR("LS3", "regulator-ls3", TPS65218_LS_3,
-			   REGULATOR_CURRENT, tps65218_ls3_ops, 0, 0, 0,
+			   REGULATOR_CURRENT, tps65218_ls23_ops, 0, 0, 0,
 			   TPS65218_REG_ENABLE2, TPS65218_ENABLE2_LS3_EN,
 			   TPS65218_REG_CONFIG2, TPS65218_CONFIG2_LS3ILIM_MASK,
 			   NULL, 0, 0, 0, 0, 0),
diff --git a/include/linux/mfd/tps65218.h b/include/linux/mfd/tps65218.h
index c204d9a79436..45cdcd0fee53 100644
--- a/include/linux/mfd/tps65218.h
+++ b/include/linux/mfd/tps65218.h
@@ -208,6 +208,7 @@ enum tps65218_regulator_id {
 	/* LDOs */
 	TPS65218_LDO_1,
 	/* LS's */
+	TPS65218_LS_2,
 	TPS65218_LS_3,
 };
 
@@ -218,7 +219,7 @@ enum tps65218_regulator_id {
 /* Number of LDO voltage regulators available */
 #define TPS65218_NUM_LDO		1
 /* Number of total LS current regulators available */
-#define TPS65218_NUM_LS			1
+#define TPS65218_NUM_LS			2
 /* Number of total regulators available */
 #define TPS65218_NUM_REGULATOR		(TPS65218_NUM_DCDC + TPS65218_NUM_LDO \
 					 + TPS65218_NUM_LS)
-- 
2.20.1

