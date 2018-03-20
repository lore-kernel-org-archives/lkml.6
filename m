Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751094AbeCTBWX (ORCPT <rfc822;w@1wt.eu>);
        Mon, 19 Mar 2018 21:22:23 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:41872 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750731AbeCTBWQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Mar 2018 21:22:16 -0400
From: Mark Brown <broonie@kernel.org>
To: Nicholas Lowell <nlowell@lexmark.com>
Cc: Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Applied "regulator: giving regulator controlling gpios a non-empty label when used through the devicetree." to the regulator tree
In-Reply-To: <1521465799-5589-1-git-send-email-nlowell@lexmark.com>
Message-Id: <20180320012212.0740244007A@finisterre.ee.mobilebroadband>
Date: Tue, 20 Mar 2018 01:22:12 +0000 (GMT)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   regulator: giving regulator controlling gpios a non-empty label when used through the devicetree.

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

>From 37ad490bab09b7c218e37b570069cf188f2616e7 Mon Sep 17 00:00:00 2001
From: Nicholas Lowell <nlowell@lexmark.com>
Date: Mon, 19 Mar 2018 09:23:14 -0400
Subject: [PATCH] regulator: giving regulator controlling gpios a non-empty
 label when used through the devicetree.

When the label is empty, it causes missing information and limits diagnostics
for instances such as 'cat /sys/kernel/debug/gpio'

Setting the label to the regulator supply_name will point to the device
using the gpio(s).

Signed-off-by: Nicholas Lowell <nlowell@lexmark.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/regulator/gpio-regulator.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/regulator/gpio-regulator.c b/drivers/regulator/gpio-regulator.c
index a2eb50719c7b..a86b8997bb54 100644
--- a/drivers/regulator/gpio-regulator.c
+++ b/drivers/regulator/gpio-regulator.c
@@ -196,6 +196,7 @@ of_get_gpio_regulator_config(struct device *dev, struct device_node *np,
 				break;
 			}
 			config->gpios[i].gpio = gpio;
+			config->gpios[i].label = config->supply_name;
 			if (proplen > 0) {
 				of_property_read_u32_index(np, "gpios-states",
 							   i, &ret);
-- 
2.16.2
