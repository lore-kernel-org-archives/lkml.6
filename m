Return-Path: <SRS0=I/I1=QE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FE35C282C8
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 12:35:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E0E8F21773
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 12:35:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548678942;
	bh=DeB50/hPKxsDcgw7h6VAflp1YUZhmhl5zIYAMfSCTTQ=;
	h=From:To:Cc:Subject:In-Reply-To:Date:List-ID:From;
	b=bslyx/aBjj1eYaL5UnVKlv02bMNyEJClkX59vVhZ70ClrUVfTnxRbEpCGw7bO8Jfi
	 2A4Qy0JTUDfTTIGIcbmOTHAnIts2ElSnQk5K4hGjbYTCZHtgG1YOAxHoxL/vsOpVr5
	 ejc/SucocfTs5EFk9USnF4OaTw3thjcEl3d8GpJ8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726832AbfA1Mfj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Jan 2019 07:35:39 -0500
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:42102 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726661AbfA1Mfi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jan 2019 07:35:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=ZAkRInmoIzrCBj5UT0SPPfdLv5fjRygzq7H3k1ReN44=; b=F/B/PAX42Kvv
        wuKfUwCK7VkbhRAQemGCHASQ6lbLrYYzOeHDBOytY2gRO8OkvlK4HhDlA94/XzF830Gra0K26IAFs
        zEZgWVPST+VfCHAut3K5hQ6cCQuZaajlf3RClfIA1rQao+HeXYVxGaf1EORYNkWXI/6ILo8r1Kdgf
        zJTY8=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1go68W-0002Sl-IN; Mon, 28 Jan 2019 12:35:36 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id 384E31127D29; Mon, 28 Jan 2019 12:35:36 +0000 (GMT)
From:   Mark Brown <broonie@kernel.org>
To:     Axel Lin <axel.lin@ingics.com>
Cc:     Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org
Subject: Applied "regulator: rk808: Constify regulator_ops" to the regulator tree
In-Reply-To: 
X-Patchwork-Hint: ignore
Message-Id: <20190128123536.384E31127D29@debutante.sirena.org.uk>
Date:   Mon, 28 Jan 2019 12:35:36 +0000 (GMT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   regulator: rk808: Constify regulator_ops

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

From dc6f23edd702c30c403eba74eb9c7743e5392f02 Mon Sep 17 00:00:00 2001
From: Axel Lin <axel.lin@ingics.com>
Date: Sun, 27 Jan 2019 22:23:43 +0800
Subject: [PATCH] regulator: rk808: Constify regulator_ops

While at it, also fix indent for rk805_reg_ops and rk805_switch_ops.

Signed-off-by: Axel Lin <axel.lin@ingics.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/regulator/rk808-regulator.c | 42 ++++++++++++++---------------
 1 file changed, 21 insertions(+), 21 deletions(-)

diff --git a/drivers/regulator/rk808-regulator.c b/drivers/regulator/rk808-regulator.c
index 213b68743cc8..c18ed632c95d 100644
--- a/drivers/regulator/rk808-regulator.c
+++ b/drivers/regulator/rk808-regulator.c
@@ -363,28 +363,28 @@ static int rk808_set_suspend_disable(struct regulator_dev *rdev)
 				  rdev->desc->enable_mask);
 }
 
-static struct regulator_ops rk805_reg_ops = {
-		.list_voltage           = regulator_list_voltage_linear,
-		.map_voltage            = regulator_map_voltage_linear,
-		.get_voltage_sel        = regulator_get_voltage_sel_regmap,
-		.set_voltage_sel        = regulator_set_voltage_sel_regmap,
-		.enable                 = regulator_enable_regmap,
-		.disable                = regulator_disable_regmap,
-		.is_enabled             = regulator_is_enabled_regmap,
-		.set_suspend_voltage    = rk808_set_suspend_voltage,
-		.set_suspend_enable     = rk805_set_suspend_enable,
-		.set_suspend_disable    = rk805_set_suspend_disable,
+static const struct regulator_ops rk805_reg_ops = {
+	.list_voltage           = regulator_list_voltage_linear,
+	.map_voltage            = regulator_map_voltage_linear,
+	.get_voltage_sel        = regulator_get_voltage_sel_regmap,
+	.set_voltage_sel        = regulator_set_voltage_sel_regmap,
+	.enable                 = regulator_enable_regmap,
+	.disable                = regulator_disable_regmap,
+	.is_enabled             = regulator_is_enabled_regmap,
+	.set_suspend_voltage    = rk808_set_suspend_voltage,
+	.set_suspend_enable     = rk805_set_suspend_enable,
+	.set_suspend_disable    = rk805_set_suspend_disable,
 };
 
-static struct regulator_ops rk805_switch_ops = {
-		.enable                 = regulator_enable_regmap,
-		.disable                = regulator_disable_regmap,
-		.is_enabled             = regulator_is_enabled_regmap,
-		.set_suspend_enable     = rk805_set_suspend_enable,
-		.set_suspend_disable    = rk805_set_suspend_disable,
+static const struct regulator_ops rk805_switch_ops = {
+	.enable                 = regulator_enable_regmap,
+	.disable                = regulator_disable_regmap,
+	.is_enabled             = regulator_is_enabled_regmap,
+	.set_suspend_enable     = rk805_set_suspend_enable,
+	.set_suspend_disable    = rk805_set_suspend_disable,
 };
 
-static struct regulator_ops rk808_buck1_2_ops = {
+static const struct regulator_ops rk808_buck1_2_ops = {
 	.list_voltage		= regulator_list_voltage_linear,
 	.map_voltage		= regulator_map_voltage_linear,
 	.get_voltage_sel	= rk808_buck1_2_get_voltage_sel_regmap,
@@ -399,7 +399,7 @@ static struct regulator_ops rk808_buck1_2_ops = {
 	.set_suspend_disable	= rk808_set_suspend_disable,
 };
 
-static struct regulator_ops rk808_reg_ops = {
+static const struct regulator_ops rk808_reg_ops = {
 	.list_voltage		= regulator_list_voltage_linear,
 	.map_voltage		= regulator_map_voltage_linear,
 	.get_voltage_sel	= regulator_get_voltage_sel_regmap,
@@ -412,7 +412,7 @@ static struct regulator_ops rk808_reg_ops = {
 	.set_suspend_disable	= rk808_set_suspend_disable,
 };
 
-static struct regulator_ops rk808_reg_ops_ranges = {
+static const struct regulator_ops rk808_reg_ops_ranges = {
 	.list_voltage		= regulator_list_voltage_linear_range,
 	.map_voltage		= regulator_map_voltage_linear_range,
 	.get_voltage_sel	= regulator_get_voltage_sel_regmap,
@@ -425,7 +425,7 @@ static struct regulator_ops rk808_reg_ops_ranges = {
 	.set_suspend_disable	= rk808_set_suspend_disable,
 };
 
-static struct regulator_ops rk808_switch_ops = {
+static const struct regulator_ops rk808_switch_ops = {
 	.enable			= regulator_enable_regmap,
 	.disable		= regulator_disable_regmap,
 	.is_enabled		= regulator_is_enabled_regmap,
-- 
2.20.1

