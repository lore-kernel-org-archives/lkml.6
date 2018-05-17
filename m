Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752271AbeEQRNL (ORCPT <rfc822;w@1wt.eu>);
        Thu, 17 May 2018 13:13:11 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:44828 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752174AbeEQRNJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 May 2018 13:13:09 -0400
From: Mark Brown <broonie@kernel.org>
To: Anson Huang <Anson.Huang@nxp.com>
Cc: Mark Brown <broonie@kernel.org>, lgirdwood@gmail.com,
        broonie@kernel.org, Linux-imx@nxp.com, linux-kernel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Applied "regulator: pfuze100: add .is_enable() for pfuze100_swb_regulator_ops" to the regulator tree
In-Reply-To: <1526542042-28485-2-git-send-email-Anson.Huang@nxp.com>
Message-Id: <20180517171302.B3F1E44007C@finisterre.ee.mobilebroadband>
Date: Thu, 17 May 2018 18:13:02 +0100 (BST)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   regulator: pfuze100: add .is_enable() for pfuze100_swb_regulator_ops

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

>From 0b01fd3d40fe6402e5fa3b491ef23109feb1aaa5 Mon Sep 17 00:00:00 2001
From: Anson Huang <Anson.Huang@nxp.com>
Date: Thu, 17 May 2018 15:27:22 +0800
Subject: [PATCH] regulator: pfuze100: add .is_enable() for
 pfuze100_swb_regulator_ops

If is_enabled() is not defined, regulator core will assume
this regulator is already enabled, then it can NOT be really
enabled after disabled.

Based on Li Jun's patch from the NXP kernel tree.

Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/regulator/pfuze100-regulator.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/regulator/pfuze100-regulator.c b/drivers/regulator/pfuze100-regulator.c
index 053eb1ecf18d..677a070eeb1c 100644
--- a/drivers/regulator/pfuze100-regulator.c
+++ b/drivers/regulator/pfuze100-regulator.c
@@ -168,6 +168,7 @@ static const struct regulator_ops pfuze100_sw_regulator_ops = {
 static const struct regulator_ops pfuze100_swb_regulator_ops = {
 	.enable = regulator_enable_regmap,
 	.disable = regulator_disable_regmap,
+	.is_enabled = regulator_is_enabled_regmap,
 	.list_voltage = regulator_list_voltage_table,
 	.map_voltage = regulator_map_voltage_ascend,
 	.set_voltage_sel = regulator_set_voltage_sel_regmap,
-- 
2.17.0
