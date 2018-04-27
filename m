Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932799AbeD0LIt (ORCPT <rfc822;w@1wt.eu>);
        Fri, 27 Apr 2018 07:08:49 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:48362 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932605AbeD0LIs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Apr 2018 07:08:48 -0400
From: Mark Brown <broonie@kernel.org>
To: Arvind Yadav <arvind.yadav.cs@gmail.com>
Cc: Mark Brown <broonie@kernel.org>, broonie@kernel.org,
        linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org,
        linux-spi@vger.kernel.org
Subject: Applied "spi: mpc52xx: Use gpio_is_valid()" to the spi tree
In-Reply-To: <aef1b612f61b530012459def8ac958f88674e1c8.1524826858.git.arvind.yadav.cs@gmail.com>
Message-Id: <E1fC1F8-0004WI-06@debutante>
Date: Fri, 27 Apr 2018 12:08:46 +0100
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   spi: mpc52xx: Use gpio_is_valid()

has been applied to the spi tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git 

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

>From 0a090d6537d3ac14391e7aeaf025b725e72a9675 Mon Sep 17 00:00:00 2001
From: Arvind Yadav <arvind.yadav.cs@gmail.com>
Date: Fri, 27 Apr 2018 16:32:17 +0530
Subject: [PATCH] spi: mpc52xx: Use gpio_is_valid()

Replace the manual validity checks for the GPIO with the
gpio_is_valid().

Signed-off-by: Arvind Yadav <arvind.yadav.cs@gmail.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/spi/spi-mpc52xx.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/spi/spi-mpc52xx.c b/drivers/spi/spi-mpc52xx.c
index e8b59ce4dc3a..0e55784a3ad9 100644
--- a/drivers/spi/spi-mpc52xx.c
+++ b/drivers/spi/spi-mpc52xx.c
@@ -447,7 +447,7 @@ static int mpc52xx_spi_probe(struct platform_device *op)
 
 		for (i = 0; i < ms->gpio_cs_count; i++) {
 			gpio_cs = of_get_gpio(op->dev.of_node, i);
-			if (gpio_cs < 0) {
+			if (!gpio_is_valid(gpio_cs)) {
 				dev_err(&op->dev,
 					"could not parse the gpio field in oftree\n");
 				rc = -ENODEV;
-- 
2.17.0
