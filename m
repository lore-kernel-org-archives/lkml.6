Return-Path: <SRS0=jJS3=QA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DE4AC282C3
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 18:47:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0BC48218A2
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 18:47:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548355630;
	bh=fVYEjti9UQODXR1HfTbddvxoRkePP8HN4HzMOSomcws=;
	h=From:To:Cc:Subject:In-Reply-To:Date:List-ID:From;
	b=VaReuyTOnK1eqgxMGTqiz8Pw9nwHMdabNmSnmYbBR4+X8xkMkf4gUOvgjtSooGt7Z
	 CaiwS5Yp20+nOskSDW0hbSUyc1+KPZdqLmEeWFuDab6Los8jOGKdHIOZcEWodCZACX
	 57+XQLAWWSvFV04liBLIBz5IABY5wBPsb1vnPZC8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728690AbfAXSrI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Jan 2019 13:47:08 -0500
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:33224 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725913AbfAXSrI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Jan 2019 13:47:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=pPVJQXH0AgdMtLi7n3qW6m542cGqwjd/DzULRf5+RzY=; b=GdQLuMYQevOE
        ppIqWSv0cPscJhMHI8s8cD3cxWDKCtJhd+8e73fR0ZrNIegdDBJKrLTLy1kc5CBXEfX54Yrx788jC
        6US/SA3VO4zlqb6Cz/04LJDNz0c40k7wtvRGT2ffWOu+hkkLJHAdo4/s3NL6LlDcWs9NqSjR/rkjX
        890f8=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1gmk1p-0006bs-Px; Thu, 24 Jan 2019 18:47:05 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id 60DD71121C3A; Thu, 24 Jan 2019 18:47:05 +0000 (GMT)
From:   Mark Brown <broonie@kernel.org>
To:     Axel Lin <axel.lin@ingics.com>
Cc:     Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org
Subject: Applied "regulator: bd70528: Constify regulator_linear_range and regulator_ops" to the regulator tree
In-Reply-To: 
X-Patchwork-Hint: ignore
Message-Id: <20190124184705.60DD71121C3A@debutante.sirena.org.uk>
Date:   Thu, 24 Jan 2019 18:47:05 +0000 (GMT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   regulator: bd70528: Constify regulator_linear_range and regulator_ops

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

From 08f15f4a348a9e7d3be156126922da8d38731d53 Mon Sep 17 00:00:00 2001
From: Axel Lin <axel.lin@ingics.com>
Date: Thu, 24 Jan 2019 18:02:07 +0800
Subject: [PATCH] regulator: bd70528: Constify regulator_linear_range and
 regulator_ops

Signed-off-by: Axel Lin <axel.lin@ingics.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/regulator/bd70528-regulator.c | 17 ++++++++---------
 1 file changed, 8 insertions(+), 9 deletions(-)

diff --git a/drivers/regulator/bd70528-regulator.c b/drivers/regulator/bd70528-regulator.c
index 0cf261c469b9..72c7f9aa84f3 100644
--- a/drivers/regulator/bd70528-regulator.c
+++ b/drivers/regulator/bd70528-regulator.c
@@ -21,22 +21,22 @@
 #define BUCK_RAMPRATE_125MV 1
 #define BUCK_RAMP_MAX 250
 
-static struct regulator_linear_range bd70528_buck1_volts[] = {
+static const struct regulator_linear_range bd70528_buck1_volts[] = {
 	REGULATOR_LINEAR_RANGE(1200000, 0x00, 0x1, 600000),
 	REGULATOR_LINEAR_RANGE(2750000, 0x2, 0xf, 50000),
 };
-static struct regulator_linear_range bd70528_buck2_volts[] = {
+static const struct regulator_linear_range bd70528_buck2_volts[] = {
 	REGULATOR_LINEAR_RANGE(1200000, 0x00, 0x1, 300000),
 	REGULATOR_LINEAR_RANGE(1550000, 0x2, 0xd, 50000),
 	REGULATOR_LINEAR_RANGE(3000000, 0xe, 0xf, 300000),
 };
-static struct regulator_linear_range bd70528_buck3_volts[] = {
+static const struct regulator_linear_range bd70528_buck3_volts[] = {
 	REGULATOR_LINEAR_RANGE(800000, 0x00, 0xd, 50000),
 	REGULATOR_LINEAR_RANGE(1800000, 0xe, 0xf, 0),
 };
 
 /* All LDOs have same voltage ranges */
-static struct regulator_linear_range bd70528_ldo_volts[] = {
+static const struct regulator_linear_range bd70528_ldo_volts[] = {
 	REGULATOR_LINEAR_RANGE(1650000, 0x0, 0x07, 50000),
 	REGULATOR_LINEAR_RANGE(2100000, 0x8, 0x0f, 100000),
 	REGULATOR_LINEAR_RANGE(2850000, 0x10, 0x19, 50000),
@@ -83,7 +83,7 @@ static int bd70528_led_set_voltage_sel(struct regulator_dev *rdev,
 	return -EBUSY;
 }
 
-static struct regulator_ops bd70528_buck_ops = {
+static const struct regulator_ops bd70528_buck_ops = {
 	.enable = regulator_enable_regmap,
 	.disable = regulator_disable_regmap,
 	.is_enabled = regulator_is_enabled_regmap,
@@ -94,7 +94,7 @@ static struct regulator_ops bd70528_buck_ops = {
 	.set_ramp_delay = bd70528_set_ramp_delay,
 };
 
-static struct regulator_ops bd70528_ldo_ops = {
+static const struct regulator_ops bd70528_ldo_ops = {
 	.enable = regulator_enable_regmap,
 	.disable = regulator_disable_regmap,
 	.is_enabled = regulator_is_enabled_regmap,
@@ -105,7 +105,7 @@ static struct regulator_ops bd70528_ldo_ops = {
 	.set_ramp_delay = bd70528_set_ramp_delay,
 };
 
-static struct regulator_ops bd70528_led_ops = {
+static const struct regulator_ops bd70528_led_ops = {
 	.enable = regulator_enable_regmap,
 	.disable = regulator_disable_regmap,
 	.is_enabled = regulator_is_enabled_regmap,
@@ -114,8 +114,7 @@ static struct regulator_ops bd70528_led_ops = {
 	.get_voltage_sel = regulator_get_voltage_sel_regmap,
 };
 
-
-static struct regulator_desc bd70528_desc[] = {
+static const struct regulator_desc bd70528_desc[] = {
 	{
 		.name = "buck1",
 		.of_match = of_match_ptr("BUCK1"),
-- 
2.20.1

