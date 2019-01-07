Return-Path: <SRS0=PvM2=PP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44450C43444
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 18:58:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1063D206B7
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 18:58:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1546887532;
	bh=DzLkuoqA4eenTNgudWyY0yRyowiyW2Icco7Hbe1eR8k=;
	h=From:To:Cc:Subject:In-Reply-To:Date:List-ID:From;
	b=qLSP0+XIH+saEN7TDe6KPWt+LKWYeASZsOCiAnJHyaoe203WKwd4UyYiSUz9qOHIj
	 u8bdF5FkTq3sqSSbI7uN3Ci51MsEn++89U/2d+G2/c9Ogfw6rtVJmWiI3W2tgkcM6o
	 dXPSjaXJLKRtQyGtQwZ1hZdA/Gwe4FzzmJLRjO+w=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728857AbfAGS6v (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Jan 2019 13:58:51 -0500
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:41942 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727121AbfAGS6r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jan 2019 13:58:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=OsraQZruK+nLQRqmON7tNZMmn5CJYJe/V58Kd3lBLOQ=; b=TIWXow8NzC/s
        IqyRKhoYjJuROOnL1P8Fz/fXwAChcs+BpX1obfLQPQaO3VW8D/V5D1YUJzsHGJMVS8+/Fof0gJ4qq
        U+VR/sHN7S3TRE0YObQDBRTzI5bRxJRfX1WACTR/IJBMkCbe0ee8M2W2ZgG2xca/qfSXpCHSxdwlR
        CrIVU=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1gga6m-0007ph-Qb; Mon, 07 Jan 2019 18:58:44 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id 6D00D1127491; Mon,  7 Jan 2019 18:58:44 +0000 (GMT)
From:   Mark Brown <broonie@kernel.org>
To:     Axel Lin <axel.lin@ingics.com>
Cc:     Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org
Subject: Applied "regulator: act8945a: Use rdev_get_id() to access id of regulator" to the regulator tree
In-Reply-To: 
X-Patchwork-Hint: ignore
Message-Id: <20190107185844.6D00D1127491@debutante.sirena.org.uk>
Date:   Mon,  7 Jan 2019 18:58:44 +0000 (GMT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   regulator: act8945a: Use rdev_get_id() to access id of regulator

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

From 557ce9d755d5ffc735f03a9a2ce2f1b4a3b23bd6 Mon Sep 17 00:00:00 2001
From: Axel Lin <axel.lin@ingics.com>
Date: Fri, 4 Jan 2019 22:42:36 +0800
Subject: [PATCH] regulator: act8945a: Use rdev_get_id() to access id of
 regulator

Use rdev_get_id() instead of directly access rdev->desc->id.

Signed-off-by: Axel Lin <axel.lin@ingics.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/regulator/act8945a-regulator.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/drivers/regulator/act8945a-regulator.c b/drivers/regulator/act8945a-regulator.c
index 603db77723b6..caa61d306a69 100644
--- a/drivers/regulator/act8945a-regulator.c
+++ b/drivers/regulator/act8945a-regulator.c
@@ -87,7 +87,8 @@ static const struct regulator_linear_range act8945a_voltage_ranges[] = {
 static int act8945a_set_suspend_state(struct regulator_dev *rdev, bool enable)
 {
 	struct regmap *regmap = rdev->regmap;
-	int id = rdev->desc->id, reg, val;
+	int id = rdev_get_id(rdev);
+	int reg, val;
 
 	switch (id) {
 	case ACT8945A_ID_DCDC1:
@@ -159,7 +160,7 @@ static int act8945a_set_mode(struct regulator_dev *rdev, unsigned int mode)
 {
 	struct act8945a_pmic *act8945a = rdev_get_drvdata(rdev);
 	struct regmap *regmap = rdev->regmap;
-	int id = rdev->desc->id;
+	int id = rdev_get_id(rdev);
 	int reg, ret, val = 0;
 
 	switch (id) {
@@ -190,11 +191,11 @@ static int act8945a_set_mode(struct regulator_dev *rdev, unsigned int mode)
 
 	switch (mode) {
 	case REGULATOR_MODE_STANDBY:
-		if (rdev->desc->id > ACT8945A_ID_DCDC3)
+		if (id > ACT8945A_ID_DCDC3)
 			val = BIT(5);
 		break;
 	case REGULATOR_MODE_NORMAL:
-		if (rdev->desc->id <= ACT8945A_ID_DCDC3)
+		if (id <= ACT8945A_ID_DCDC3)
 			val = BIT(5);
 		break;
 	default:
@@ -213,7 +214,7 @@ static int act8945a_set_mode(struct regulator_dev *rdev, unsigned int mode)
 static unsigned int act8945a_get_mode(struct regulator_dev *rdev)
 {
 	struct act8945a_pmic *act8945a = rdev_get_drvdata(rdev);
-	int id = rdev->desc->id;
+	int id = rdev_get_id(rdev);
 
 	if (id < ACT8945A_ID_DCDC1 || id >= ACT8945A_ID_MAX)
 		return -EINVAL;
-- 
2.20.1

