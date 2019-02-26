Return-Path: <SRS0=tlbf=RB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2869DC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 12:07:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EC67021855
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 12:07:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551182834;
	bh=C0xysiuCQ1mVAucDYJVZ7loJOGTQJKq5w3DTv/UoSYk=;
	h=From:To:Cc:Subject:In-Reply-To:Date:List-ID:From;
	b=uOXETvTD9Z6o6n8VROwjAgqKmRdqCUkNk4VuW1bb8sjivhjNpNp7CwfpDkOVJRLOl
	 ys1dEUsci1/2chNF5U9r3DLEagx6MtwiA1ZwB2REvMWjrrqJAKRt0+iS3FBAdbShJs
	 GsVYV7of4P5ZgLbOXBXC9f6Au37U4JrcQRUU1qnE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727424AbfBZMHD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Feb 2019 07:07:03 -0500
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:58518 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726655AbfBZMG6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Feb 2019 07:06:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=D4ECjvQxnH17RiD5hiS/tVp5qmUMWDv6ExmogC9Aya8=; b=pyrpEML1XwPF
        sdVQCklwg6L1TCq+k8KrT6SxkjE4XIGTS5rzB5FKm/Zd348D1wo0qj3/ZIQ0wqOqgLKSgxKGrzDLk
        FtvvrKys0iEN7gg3ubpHYFY4Fqu+oqnJhEaSiPWSKVPbP7YT5fkVTBJojk5qyplcjEkeFzQrJzdwg
        VXetM=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1gybVg-0007jK-4H; Tue, 26 Feb 2019 12:06:56 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id ADEEB11284E3; Tue, 26 Feb 2019 12:06:55 +0000 (GMT)
From:   Mark Brown <broonie@kernel.org>
To:     Axel Lin <axel.lin@ingics.com>
Cc:     Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org
Subject: Applied "regulator: mt6311: Use linear instead of linear range for mt6311_buck_ops" to the regulator tree
In-Reply-To: 
X-Patchwork-Hint: ignore
Message-Id: <20190226120655.ADEEB11284E3@debutante.sirena.org.uk>
Date:   Tue, 26 Feb 2019 12:06:55 +0000 (GMT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   regulator: mt6311: Use linear instead of linear range for mt6311_buck_ops

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

From a661b1d9936e77a6c07f8ca10e3494932fa5e2c8 Mon Sep 17 00:00:00 2001
From: Axel Lin <axel.lin@ingics.com>
Date: Fri, 22 Feb 2019 00:28:31 +0800
Subject: [PATCH] regulator: mt6311: Use linear instead of linear range for
 mt6311_buck_ops

Current code already set .min_uV and .uV_step fields and it actually can
use regulator_list_voltage_linear.
So remove buck_volt_range and use regulator_list_voltage_linear instead.

Signed-off-by: Axel Lin <axel.lin@ingics.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/regulator/mt6311-regulator.c | 10 ++--------
 1 file changed, 2 insertions(+), 8 deletions(-)

diff --git a/drivers/regulator/mt6311-regulator.c b/drivers/regulator/mt6311-regulator.c
index 0495716fd35f..01d69f43d2b0 100644
--- a/drivers/regulator/mt6311-regulator.c
+++ b/drivers/regulator/mt6311-regulator.c
@@ -38,13 +38,9 @@ static const struct regmap_config mt6311_regmap_config = {
 #define MT6311_MAX_UV		1393750
 #define MT6311_STEP_UV		6250
 
-static const struct regulator_linear_range buck_volt_range[] = {
-	REGULATOR_LINEAR_RANGE(MT6311_MIN_UV, 0, 0x7f, MT6311_STEP_UV),
-};
-
 static const struct regulator_ops mt6311_buck_ops = {
-	.list_voltage = regulator_list_voltage_linear_range,
-	.map_voltage = regulator_map_voltage_linear_range,
+	.list_voltage = regulator_list_voltage_linear,
+	.map_voltage = regulator_map_voltage_linear,
 	.set_voltage_sel = regulator_set_voltage_sel_regmap,
 	.get_voltage_sel = regulator_get_voltage_sel_regmap,
 	.set_voltage_time_sel = regulator_set_voltage_time_sel,
@@ -71,8 +67,6 @@ static const struct regulator_ops mt6311_ldo_ops = {
 	.min_uV = MT6311_MIN_UV,\
 	.uV_step = MT6311_STEP_UV,\
 	.owner = THIS_MODULE,\
-	.linear_ranges = buck_volt_range, \
-	.n_linear_ranges = ARRAY_SIZE(buck_volt_range), \
 	.enable_reg = MT6311_VDVFS11_CON9,\
 	.enable_mask = MT6311_PMIC_VDVFS11_EN_MASK,\
 	.vsel_reg = MT6311_VDVFS11_CON12,\
-- 
2.20.1

