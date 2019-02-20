Return-Path: <SRS0=sczE=Q3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85538C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 17:53:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 52DA2218D8
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 17:53:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550685183;
	bh=GZc3mOZLjcCd6PUk6KTh2S2yOsJGfWCZVPFLrcoqoIo=;
	h=From:To:Cc:Subject:In-Reply-To:Date:List-ID:From;
	b=OY+ehhvAkQAUbK1BVs2WeaBet5ejKnoB7TM0AFZnDd9yTEs9RqOA//n0ByAVzJIuj
	 wk4BdROxJrF7NIhaohrFiUDybilu5DYDJ8hL2ik9wrWo1lcigfgZtUYkibj9X59HNW
	 jcd5IMLkcgDk+csgZNavABdNUcIFa5kKJuAAYCXk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726660AbfBTRxB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Feb 2019 12:53:01 -0500
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:55822 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725815AbfBTRxB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Feb 2019 12:53:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=2RMos94vHJUpc8zZU8uIDLc0keeL8JtmnWdoYv19C30=; b=QWqmbShRuGJp
        cX0gN6WoUsVJsX/ENkDvJE0yt38tlU0PxYdOL48D06R3Q8QJBhT8JpoLANf8XD9Eiz/PmNRkI6ePx
        ufMYezijdXo4HNtvLybNIWhi72vEl/W7T2oc9F7Hk1HulzQLQYgVHXa4dVzvQkfH32yTNi+vWVe3g
        wQBCo=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1gwW3G-0005SU-JE; Wed, 20 Feb 2019 17:52:58 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id 248B1112882D; Wed, 20 Feb 2019 17:52:58 +0000 (GMT)
From:   Mark Brown <broonie@kernel.org>
To:     Axel Lin <axel.lin@ingics.com>
Cc:     Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org
Subject: Applied "regulator: max77650: Add missing .owner field in regulator_desc" to the regulator tree
In-Reply-To: 
X-Patchwork-Hint: ignore
Message-Id: <20190220175258.248B1112882D@debutante.sirena.org.uk>
Date:   Wed, 20 Feb 2019 17:52:58 +0000 (GMT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   regulator: max77650: Add missing .owner field in regulator_desc

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

From 721efb504d28ce0bc704643ea2d952b9e87ed9f7 Mon Sep 17 00:00:00 2001
From: Axel Lin <axel.lin@ingics.com>
Date: Wed, 20 Feb 2019 09:53:28 +0800
Subject: [PATCH] regulator: max77650: Add missing .owner field in
 regulator_desc

Add missing .owner field in regulator_desc, which is used for refcounting.

Signed-off-by: Axel Lin <axel.lin@ingics.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/regulator/max77650-regulator.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/regulator/max77650-regulator.c b/drivers/regulator/max77650-regulator.c
index 5afb91400832..411912d5278b 100644
--- a/drivers/regulator/max77650-regulator.c
+++ b/drivers/regulator/max77650-regulator.c
@@ -319,6 +319,7 @@ static struct max77650_regulator_desc max77650_LDO_desc = {
 		.active_discharge_reg	= MAX77650_REG_CNFG_LDO_B,
 		.enable_time		= 100,
 		.type			= REGULATOR_VOLTAGE,
+		.owner			= THIS_MODULE,
 	},
 	.regA		= MAX77650_REG_CNFG_LDO_A,
 	.regB		= MAX77650_REG_CNFG_LDO_B,
@@ -343,6 +344,7 @@ static struct max77650_regulator_desc max77650_SBB0_desc = {
 		.active_discharge_reg	= MAX77650_REG_CNFG_SBB0_B,
 		.enable_time		= 100,
 		.type			= REGULATOR_VOLTAGE,
+		.owner			= THIS_MODULE,
 	},
 	.regA		= MAX77650_REG_CNFG_SBB0_A,
 	.regB		= MAX77650_REG_CNFG_SBB0_B,
@@ -367,6 +369,7 @@ static struct max77650_regulator_desc max77650_SBB1_desc = {
 		.active_discharge_reg	= MAX77650_REG_CNFG_SBB1_B,
 		.enable_time		= 100,
 		.type			= REGULATOR_VOLTAGE,
+		.owner			= THIS_MODULE,
 	},
 	.regA		= MAX77650_REG_CNFG_SBB1_A,
 	.regB		= MAX77650_REG_CNFG_SBB1_B,
@@ -390,6 +393,7 @@ static struct max77650_regulator_desc max77651_SBB1_desc = {
 		.active_discharge_reg	= MAX77650_REG_CNFG_SBB1_B,
 		.enable_time		= 100,
 		.type			= REGULATOR_VOLTAGE,
+		.owner			= THIS_MODULE,
 	},
 	.regA		= MAX77650_REG_CNFG_SBB1_A,
 	.regB		= MAX77650_REG_CNFG_SBB1_B,
@@ -414,6 +418,7 @@ static struct max77650_regulator_desc max77650_SBB2_desc = {
 		.active_discharge_reg	= MAX77650_REG_CNFG_SBB2_B,
 		.enable_time		= 100,
 		.type			= REGULATOR_VOLTAGE,
+		.owner			= THIS_MODULE,
 	},
 	.regA		= MAX77650_REG_CNFG_SBB2_A,
 	.regB		= MAX77650_REG_CNFG_SBB2_B,
@@ -438,6 +443,7 @@ static struct max77650_regulator_desc max77651_SBB2_desc = {
 		.active_discharge_reg	= MAX77650_REG_CNFG_SBB2_B,
 		.enable_time		= 100,
 		.type			= REGULATOR_VOLTAGE,
+		.owner			= THIS_MODULE,
 	},
 	.regA		= MAX77650_REG_CNFG_SBB2_A,
 	.regB		= MAX77650_REG_CNFG_SBB2_B,
-- 
2.20.1

