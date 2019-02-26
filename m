Return-Path: <SRS0=tlbf=RB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F2C0C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 16:49:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1006C2147C
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 16:49:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551199765;
	bh=QNcmxzSxkio8PvgrOh6UTmxc4sRtB0tnC7Q5TBIIdD0=;
	h=From:To:Cc:Subject:In-Reply-To:Date:List-ID:From;
	b=JhB/bKpdjXuFRLGQIpcrydRi+eMqG4qYprLyQbky142nctiEAunNupfAE8++8NnLk
	 qidfxVJb0cpoPetsnBnjSr6nl1feBiCmB4uoDiazYY/0svL5ro4pJgmDwlhZpzHLne
	 GoWAWUH/JUOvtmiGiA52c/4UdPUxdaaMOeBkLQTo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728340AbfBZQtX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Feb 2019 11:49:23 -0500
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:52676 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727108AbfBZQtW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Feb 2019 11:49:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=nPJPHR7FTinWJG0c5a8tV8JEv1gzxTYH5LCjpoOXeQE=; b=THOSjpqFqROE
        3wzwmsfvpUECy/2kC7fbK4Z9w7tiZdU0QgvmoriiqWW5x5IxWFFNnfJW9ZDxQsZ/NfOshM6U79S8H
        IdaekKvGqrRv5H3P1a+PBfYynPrfcbRNGwJHW2lzGhq2vUcc/7RcRxO61IGU4wBqOyGupPzrxys/L
        kXKHY=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1gyfux-0000I9-VJ; Tue, 26 Feb 2019 16:49:20 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id 773431121A0A; Tue, 26 Feb 2019 16:49:19 +0000 (GMT)
From:   Mark Brown <broonie@kernel.org>
To:     Axel Lin <axel.lin@ingics.com>
Cc:     Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org
Subject: Applied "regulator: 88pm8607: Simplify pm8607_list_voltage implementation" to the regulator tree
In-Reply-To: 
X-Patchwork-Hint: ignore
Message-Id: <20190226164919.773431121A0A@debutante.sirena.org.uk>
Date:   Tue, 26 Feb 2019 16:49:19 +0000 (GMT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   regulator: 88pm8607: Simplify pm8607_list_voltage implementation

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

From 2654d368ea3dc7e04a78ff2531ffd886736ae374 Mon Sep 17 00:00:00 2001
From: Axel Lin <axel.lin@ingics.com>
Date: Tue, 26 Feb 2019 20:40:58 +0800
Subject: [PATCH] regulator: 88pm8607: Simplify pm8607_list_voltage
 implementation

Set volt_table filed then we can use regulator_list_voltage_table.
Since we have volt_table setting, now we can remove vol_table from
struct pm8607_regulator_info.

Signed-off-by: Axel Lin <axel.lin@ingics.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/regulator/88pm8607.c | 19 ++++++++++---------
 1 file changed, 10 insertions(+), 9 deletions(-)

diff --git a/drivers/regulator/88pm8607.c b/drivers/regulator/88pm8607.c
index 28f55248eb90..597385d25201 100644
--- a/drivers/regulator/88pm8607.c
+++ b/drivers/regulator/88pm8607.c
@@ -27,7 +27,6 @@ struct pm8607_regulator_info {
 	struct i2c_client	*i2c;
 	struct i2c_client	*i2c_8606;
 
-	unsigned int	*vol_table;
 	unsigned int	*vol_suspend;
 
 	int	slope_double;
@@ -210,13 +209,15 @@ static const unsigned int LDO14_suspend_table[] = {
 static int pm8607_list_voltage(struct regulator_dev *rdev, unsigned index)
 {
 	struct pm8607_regulator_info *info = rdev_get_drvdata(rdev);
-	int ret = -EINVAL;
+	int ret;
+
+	ret = regulator_list_voltage_table(rdev, index);
+	if (ret < 0)
+		return ret;
+
+	if (info->slope_double)
+		ret <<= 1;
 
-	if (info->vol_table && (index < rdev->desc->n_voltages)) {
-		ret = info->vol_table[index];
-		if (info->slope_double)
-			ret <<= 1;
-	}
 	return ret;
 }
 
@@ -257,6 +258,7 @@ static const struct regulator_ops pm8606_preg_ops = {
 		.type	= REGULATOR_VOLTAGE,				\
 		.id	= PM8607_ID_##vreg,				\
 		.owner	= THIS_MODULE,					\
+		.volt_table = vreg##_table,				\
 		.n_voltages = ARRAY_SIZE(vreg##_table),			\
 		.vsel_reg = PM8607_##vreg,				\
 		.vsel_mask = ARRAY_SIZE(vreg##_table) - 1,		\
@@ -266,7 +268,6 @@ static const struct regulator_ops pm8606_preg_ops = {
 		.enable_mask = 1 << (ebit),				\
 	},								\
 	.slope_double	= (0),						\
-	.vol_table	= (unsigned int *)&vreg##_table,		\
 	.vol_suspend	= (unsigned int *)&vreg##_suspend_table,	\
 }
 
@@ -278,6 +279,7 @@ static const struct regulator_ops pm8606_preg_ops = {
 		.type	= REGULATOR_VOLTAGE,				\
 		.id	= PM8607_ID_LDO##_id,				\
 		.owner	= THIS_MODULE,					\
+		.volt_table = LDO##_id##_table,				\
 		.n_voltages = ARRAY_SIZE(LDO##_id##_table),		\
 		.vsel_reg = PM8607_##vreg,				\
 		.vsel_mask = (ARRAY_SIZE(LDO##_id##_table) - 1) << (shift), \
@@ -285,7 +287,6 @@ static const struct regulator_ops pm8606_preg_ops = {
 		.enable_mask = 1 << (ebit),				\
 	},								\
 	.slope_double	= (0),						\
-	.vol_table	= (unsigned int *)&LDO##_id##_table,		\
 	.vol_suspend	= (unsigned int *)&LDO##_id##_suspend_table,	\
 }
 
-- 
2.20.1

