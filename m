Return-Path: <SRS0=jJS3=QA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C89C1C282C3
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 18:47:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 959CE218AF
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 18:47:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548355633;
	bh=JxBQDOhJWmpVF5Pnb3XxA1nWqcEXQknjtwzufY4KTpM=;
	h=From:To:Cc:Subject:In-Reply-To:Date:List-ID:From;
	b=B1KZtcPSRroVqYbOOEDQdgkcx5yD5LzbJwktosb1Hx19I1L7iIULB6dvpU+CXmH3f
	 8Tx+aokB/vsr8ya/6qtiYyMcgry7Vw4QX2OBWAoTJhAdTYDc2VPUm+U2O4RZ1svytP
	 ZXApWczphOD0CCwcGXIxhzS95CfNjpNPJhiBwUpA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728895AbfAXSrM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Jan 2019 13:47:12 -0500
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:33314 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725913AbfAXSrL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Jan 2019 13:47:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=Tl1OceKS/YyUV9e7nd6heilEzev1SchcR3LQXIzbBMM=; b=fJoD+hX9T9z5
        W48IwZhmbK9kuZz69f4OujUx3uftJK742ZkkjJTnrtq6I6LUVbcEx/1yjvcxmwkXL4EdA6pXh9tJT
        43NgQ2l7y6Qg1rBDuDa4r9fDaW8mbvjmKTVCxrzw25lufjCiPowwg6A8C3HRWtTMyzAkkwWr5BCBI
        3gbv8=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1gmk1t-0006br-5H; Thu, 24 Jan 2019 18:47:09 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id AFDA81121B6F; Thu, 24 Jan 2019 18:47:03 +0000 (GMT)
From:   Mark Brown <broonie@kernel.org>
To:     Axel Lin <axel.lin@ingics.com>
Cc:     Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org
Subject: Applied "regulator: bd718x7: Constify regulator_ops" to the regulator tree
In-Reply-To: 
X-Patchwork-Hint: ignore
Message-Id: <20190124184703.AFDA81121B6F@debutante.sirena.org.uk>
Date:   Thu, 24 Jan 2019 18:47:03 +0000 (GMT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   regulator: bd718x7: Constify regulator_ops

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

From 704c5c01ce6e0d322e2c9555490b39c41e729383 Mon Sep 17 00:00:00 2001
From: Axel Lin <axel.lin@ingics.com>
Date: Thu, 24 Jan 2019 18:02:08 +0800
Subject: [PATCH] regulator: bd718x7: Constify regulator_ops

Signed-off-by: Axel Lin <axel.lin@ingics.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/regulator/bd718x7-regulator.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/regulator/bd718x7-regulator.c b/drivers/regulator/bd718x7-regulator.c
index b8dcdc21dc22..ccea133778c8 100644
--- a/drivers/regulator/bd718x7-regulator.c
+++ b/drivers/regulator/bd718x7-regulator.c
@@ -79,7 +79,7 @@ static int bd718xx_set_voltage_sel_pickable_restricted(
 	return regulator_set_voltage_sel_pickable_regmap(rdev, sel);
 }
 
-static struct regulator_ops bd718xx_pickable_range_ldo_ops = {
+static const struct regulator_ops bd718xx_pickable_range_ldo_ops = {
 	.enable = regulator_enable_regmap,
 	.disable = regulator_disable_regmap,
 	.is_enabled = regulator_is_enabled_regmap,
@@ -88,7 +88,7 @@ static struct regulator_ops bd718xx_pickable_range_ldo_ops = {
 	.get_voltage_sel = regulator_get_voltage_sel_pickable_regmap,
 };
 
-static struct regulator_ops bd718xx_pickable_range_buck_ops = {
+static const struct regulator_ops bd718xx_pickable_range_buck_ops = {
 	.enable = regulator_enable_regmap,
 	.disable = regulator_disable_regmap,
 	.is_enabled = regulator_is_enabled_regmap,
@@ -98,7 +98,7 @@ static struct regulator_ops bd718xx_pickable_range_buck_ops = {
 	.set_voltage_time_sel = regulator_set_voltage_time_sel,
 };
 
-static struct regulator_ops bd718xx_ldo_regulator_ops = {
+static const struct regulator_ops bd718xx_ldo_regulator_ops = {
 	.enable = regulator_enable_regmap,
 	.disable = regulator_disable_regmap,
 	.is_enabled = regulator_is_enabled_regmap,
@@ -107,7 +107,7 @@ static struct regulator_ops bd718xx_ldo_regulator_ops = {
 	.get_voltage_sel = regulator_get_voltage_sel_regmap,
 };
 
-static struct regulator_ops bd718xx_ldo_regulator_nolinear_ops = {
+static const struct regulator_ops bd718xx_ldo_regulator_nolinear_ops = {
 	.enable = regulator_enable_regmap,
 	.disable = regulator_disable_regmap,
 	.is_enabled = regulator_is_enabled_regmap,
@@ -116,7 +116,7 @@ static struct regulator_ops bd718xx_ldo_regulator_nolinear_ops = {
 	.get_voltage_sel = regulator_get_voltage_sel_regmap,
 };
 
-static struct regulator_ops bd718xx_buck_regulator_ops = {
+static const struct regulator_ops bd718xx_buck_regulator_ops = {
 	.enable = regulator_enable_regmap,
 	.disable = regulator_disable_regmap,
 	.is_enabled = regulator_is_enabled_regmap,
@@ -126,7 +126,7 @@ static struct regulator_ops bd718xx_buck_regulator_ops = {
 	.set_voltage_time_sel = regulator_set_voltage_time_sel,
 };
 
-static struct regulator_ops bd718xx_buck_regulator_nolinear_ops = {
+static const struct regulator_ops bd718xx_buck_regulator_nolinear_ops = {
 	.enable = regulator_enable_regmap,
 	.disable = regulator_disable_regmap,
 	.is_enabled = regulator_is_enabled_regmap,
@@ -137,7 +137,7 @@ static struct regulator_ops bd718xx_buck_regulator_nolinear_ops = {
 	.set_voltage_time_sel = regulator_set_voltage_time_sel,
 };
 
-static struct regulator_ops bd718xx_dvs_buck_regulator_ops = {
+static const struct regulator_ops bd718xx_dvs_buck_regulator_ops = {
 	.enable = regulator_enable_regmap,
 	.disable = regulator_disable_regmap,
 	.is_enabled = regulator_is_enabled_regmap,
-- 
2.20.1

