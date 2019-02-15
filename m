Return-Path: <SRS0=lv5c=QW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FAC7C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 18:42:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 41CED206C0
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 18:42:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550256120;
	bh=ADK8oDpi1eyu+dExJVlhEuh3kUwL4xo0KzVFOnuFExk=;
	h=From:To:Cc:Subject:In-Reply-To:Date:List-ID:From;
	b=qqziwx3Zt1EExpm9hok233Pm2YVaGmlN2drMiEN9Dllr5tyA3E+K0pIll9BZkBCa0
	 V3dV+3BQFfR+FS+rzWEqYwMNi9QSjbA47zEnwVKXJECFbmG6Cxo1Rxd8lVTcqDrhdb
	 LpqDzvxkoT7FkXpXpwiJ0edrIhSzkBmdbd3d6FLM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732452AbfBOSl6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Feb 2019 13:41:58 -0500
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:34960 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732396AbfBOSl5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Feb 2019 13:41:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=RREqh9P5qxOwAPFC2+zkJaxkBbRgkvOIEt00VPYHt5M=; b=O+5UdUxxSNLn
        M2QakzqQxI14PXrxEQeMjrbD4tBmEg5GztK35mLXyXlCa30aj1ovT17WUn+3ph22Ox0IDX+6dLRuO
        2NB9ajgBFUCCMjqB2dAiuR20lrPb6pb4+rDMm6e+p+ZwYV0ayW027WU9sMd7Hs5hGNC5rHXzaSwkr
        8tjk4=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1guiQs-0000hm-Hk; Fri, 15 Feb 2019 18:41:54 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id 0CABE11286B7; Fri, 15 Feb 2019 18:41:54 +0000 (GMT)
From:   Mark Brown <broonie@kernel.org>
To:     Axel Lin <axel.lin@ingics.com>
Cc:     Tim Harvey <tharvey@gateworks.com>,
        Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org
Subject: Applied "regulator: ltc3676: Simplify .readable_reg and .writable_reg callbacks" to the regulator tree
In-Reply-To: 
X-Patchwork-Hint: ignore
Message-Id: <20190215184154.0CABE11286B7@debutante.sirena.org.uk>
Date:   Fri, 15 Feb 2019 18:41:54 +0000 (GMT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   regulator: ltc3676: Simplify .readable_reg and .writable_reg callbacks

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

From 502aba81aa61393d798cdaabfaa9cba334b9f3d0 Mon Sep 17 00:00:00 2001
From: Axel Lin <axel.lin@ingics.com>
Date: Fri, 15 Feb 2019 19:54:20 +0800
Subject: [PATCH] regulator: ltc3676: Simplify .readable_reg and .writable_reg
 callbacks

Use case range for continuous range to make the code shorter.
The .readable_reg and .writable_reg implementation are exactly the same,
so use a common ltc3676_readable_writeable_reg function instead.

Signed-off-by: Axel Lin <axel.lin@ingics.com>
Acked-by: Tim Harvey <tharvey@gateworks.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/regulator/ltc3676.c | 63 +++----------------------------------
 1 file changed, 5 insertions(+), 58 deletions(-)

diff --git a/drivers/regulator/ltc3676.c b/drivers/regulator/ltc3676.c
index 71fd0f2a4b76..549a1a243870 100644
--- a/drivers/regulator/ltc3676.c
+++ b/drivers/regulator/ltc3676.c
@@ -241,61 +241,10 @@ static struct regulator_desc ltc3676_regulators[LTC3676_NUM_REGULATORS] = {
 	LTC3676_FIXED_REG(LDO4, ldo4, LDOB, 2),
 };
 
-static bool ltc3676_writeable_reg(struct device *dev, unsigned int reg)
+static bool ltc3676_readable_writeable_reg(struct device *dev, unsigned int reg)
 {
 	switch (reg) {
-	case LTC3676_IRQSTAT:
-	case LTC3676_BUCK1:
-	case LTC3676_BUCK2:
-	case LTC3676_BUCK3:
-	case LTC3676_BUCK4:
-	case LTC3676_LDOA:
-	case LTC3676_LDOB:
-	case LTC3676_SQD1:
-	case LTC3676_SQD2:
-	case LTC3676_CNTRL:
-	case LTC3676_DVB1A:
-	case LTC3676_DVB1B:
-	case LTC3676_DVB2A:
-	case LTC3676_DVB2B:
-	case LTC3676_DVB3A:
-	case LTC3676_DVB3B:
-	case LTC3676_DVB4A:
-	case LTC3676_DVB4B:
-	case LTC3676_MSKIRQ:
-	case LTC3676_MSKPG:
-	case LTC3676_USER:
-	case LTC3676_HRST:
-	case LTC3676_CLIRQ:
-		return true;
-	}
-	return false;
-}
-
-static bool ltc3676_readable_reg(struct device *dev, unsigned int reg)
-{
-	switch (reg) {
-	case LTC3676_IRQSTAT:
-	case LTC3676_BUCK1:
-	case LTC3676_BUCK2:
-	case LTC3676_BUCK3:
-	case LTC3676_BUCK4:
-	case LTC3676_LDOA:
-	case LTC3676_LDOB:
-	case LTC3676_SQD1:
-	case LTC3676_SQD2:
-	case LTC3676_CNTRL:
-	case LTC3676_DVB1A:
-	case LTC3676_DVB1B:
-	case LTC3676_DVB2A:
-	case LTC3676_DVB2B:
-	case LTC3676_DVB3A:
-	case LTC3676_DVB3B:
-	case LTC3676_DVB4A:
-	case LTC3676_DVB4B:
-	case LTC3676_MSKIRQ:
-	case LTC3676_MSKPG:
-	case LTC3676_USER:
+	case LTC3676_BUCK1 ... LTC3676_IRQSTAT:
 	case LTC3676_HRST:
 	case LTC3676_CLIRQ:
 		return true;
@@ -306,9 +255,7 @@ static bool ltc3676_readable_reg(struct device *dev, unsigned int reg)
 static bool ltc3676_volatile_reg(struct device *dev, unsigned int reg)
 {
 	switch (reg) {
-	case LTC3676_IRQSTAT:
-	case LTC3676_PGSTATL:
-	case LTC3676_PGSTATRT:
+	case LTC3676_IRQSTAT ... LTC3676_PGSTATRT:
 		return true;
 	}
 	return false;
@@ -317,8 +264,8 @@ static bool ltc3676_volatile_reg(struct device *dev, unsigned int reg)
 static const struct regmap_config ltc3676_regmap_config = {
 	.reg_bits = 8,
 	.val_bits = 8,
-	.writeable_reg = ltc3676_writeable_reg,
-	.readable_reg = ltc3676_readable_reg,
+	.writeable_reg = ltc3676_readable_writeable_reg,
+	.readable_reg = ltc3676_readable_writeable_reg,
 	.volatile_reg = ltc3676_volatile_reg,
 	.max_register = LTC3676_CLIRQ,
 	.use_single_read = true,
-- 
2.20.1

