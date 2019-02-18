Return-Path: <SRS0=sLOc=QZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 454EFC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 18:49:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 158BA217F9
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 18:49:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550515798;
	bh=mLJzmFmJ/aVgW2RQhTVQsGuqaZl9P5ut9SnH72GagTY=;
	h=From:To:Cc:Subject:In-Reply-To:Date:List-ID:From;
	b=Tl2dOW+TJ7DxQ4B0lAgf6UwjkTW3OPcGq2zg3ODyF68HEd+CEGvyv9eV70SmU2+vq
	 r4OC5gCguLRDUsMV7UX9M4gbNwfA71mNUzuVIMGRst34E2/2rPlQwboGN/B/h3yF9/
	 rhKi07rGlM7aEvKE/Oh7v/2KYyP9ZwUO5X8xYIDY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727039AbfBRSt4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Feb 2019 13:49:56 -0500
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:42502 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726940AbfBRSty (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Feb 2019 13:49:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=rkwHCN0C+itYbacENpj9r9+r0CKDNRL4OLkQ9ej7ROU=; b=Hr3PoUk2eqmf
        dx6yHT34bLNUTP1xN/swwheWESPAel56sa8z1LZbX7EA1PywsHP78KSi+LBay0axthphV+KZQl79W
        k6vkYirl7tbJTbNd7jGPtvXsZNQJBXliW4uIu3MrlfRd3FHa0dNE6b6wN6ExBCsVJ2ntMdFmpdjqm
        Av9s4=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1gvnzE-0001fs-0r; Mon, 18 Feb 2019 18:49:52 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id 90E6D1128008; Mon, 18 Feb 2019 18:49:51 +0000 (GMT)
From:   Mark Brown <broonie@kernel.org>
To:     Axel Lin <axel.lin@ingics.com>
Cc:     Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org
Subject: Applied "regulator: pv88060: Fix .ops for PV88060_SW" to the regulator tree
In-Reply-To: 
X-Patchwork-Hint: ignore
Message-Id: <20190218184951.90E6D1128008@debutante.sirena.org.uk>
Date:   Mon, 18 Feb 2019 18:49:51 +0000 (GMT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   regulator: pv88060: Fix .ops for PV88060_SW

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

From 55e72728cd2dd9f9cd1cec92c4171aa63d000c30 Mon Sep 17 00:00:00 2001
From: Axel Lin <axel.lin@ingics.com>
Date: Fri, 15 Feb 2019 09:42:49 +0800
Subject: [PATCH] regulator: pv88060: Fix .ops for PV88060_SW

There is no vsel_reg/vsel_mask settings for PV88060_ID_SWx, so don't use
pv88060_ldo_ops for PV88060_SW. The PV88060_ID_SWx is fixed voltage,
set .fixed_uV instead of .min_uV then regulator core will automatically
support get_voltage and list_voltage.

Signed-off-by: Axel Lin <axel.lin@ingics.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/regulator/pv88060-regulator.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/drivers/regulator/pv88060-regulator.c b/drivers/regulator/pv88060-regulator.c
index a9446056435f..d5dab9bef378 100644
--- a/drivers/regulator/pv88060-regulator.c
+++ b/drivers/regulator/pv88060-regulator.c
@@ -184,6 +184,12 @@ static const struct regulator_ops pv88060_ldo_ops = {
 	.list_voltage = regulator_list_voltage_linear,
 };
 
+static const struct regulator_ops pv88060_sw_ops = {
+	.enable = regulator_enable_regmap,
+	.disable = regulator_disable_regmap,
+	.is_enabled = regulator_is_enabled_regmap,
+};
+
 #define PV88060_BUCK(chip, regl_name, min, step, max, limits_array) \
 {\
 	.desc	=	{\
@@ -237,9 +243,8 @@ static const struct regulator_ops pv88060_ldo_ops = {
 		.regulators_node = of_match_ptr("regulators"),\
 		.type = REGULATOR_VOLTAGE,\
 		.owner = THIS_MODULE,\
-		.ops = &pv88060_ldo_ops,\
-		.min_uV = max,\
-		.uV_step = 0,\
+		.ops = &pv88060_sw_ops,\
+		.fixed_uV = max,\
 		.n_voltages = 1,\
 		.enable_reg = PV88060_REG_##regl_name##_CONF,\
 		.enable_mask = PV88060_SW_EN,\
-- 
2.20.1

