Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752281AbeCNQkO (ORCPT <rfc822;w@1wt.eu>);
        Wed, 14 Mar 2018 12:40:14 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:41254 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751362AbeCNQkK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Mar 2018 12:40:10 -0400
From: Mark Brown <broonie@kernel.org>
To: Christophe Jaillet <christophe.jaillet@wanadoo.fr>
Cc: Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Mark Brown <broonie@kernel.org>, broonie@kernel.org,
        f.fainelli@gmail.com, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        linux-spi@vger.kernel.org
Subject: Applied "spi: bcm-qspi: fIX some error handling paths" to the spi tree
In-Reply-To: <20180313183658.10641-1-christophe.jaillet@wanadoo.fr>
Message-Id: <20180314164006.89AF3440079@finisterre.ee.mobilebroadband>
Date: Wed, 14 Mar 2018 16:40:06 +0000 (GMT)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   spi: bcm-qspi: fIX some error handling paths

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

>From bc3cc75281b3c2b1c5355d88d147b66a753bb9a5 Mon Sep 17 00:00:00 2001
From: Christophe Jaillet <christophe.jaillet@wanadoo.fr>
Date: Tue, 13 Mar 2018 19:36:58 +0100
Subject: [PATCH] spi: bcm-qspi: fIX some error handling paths

For some reason, commit c0368e4db4a3 ("spi: bcm-qspi: Fix use after free
in bcm_qspi_probe() in error path") has updated some gotos, but not all of
them.

This looks spurious, so fix it.

Fixes: fa236a7ef240 ("spi: bcm-qspi: Add Broadcom MSPI driver")
Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/spi/spi-bcm-qspi.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/spi/spi-bcm-qspi.c b/drivers/spi/spi-bcm-qspi.c
index a172ab299e80..1596d35498c5 100644
--- a/drivers/spi/spi-bcm-qspi.c
+++ b/drivers/spi/spi-bcm-qspi.c
@@ -1247,7 +1247,7 @@ int bcm_qspi_probe(struct platform_device *pdev,
 		qspi->base[MSPI]  = devm_ioremap_resource(dev, res);
 		if (IS_ERR(qspi->base[MSPI])) {
 			ret = PTR_ERR(qspi->base[MSPI]);
-			goto qspi_probe_err;
+			goto qspi_resource_err;
 		}
 	} else {
 		goto qspi_resource_err;
@@ -1258,7 +1258,7 @@ int bcm_qspi_probe(struct platform_device *pdev,
 		qspi->base[BSPI]  = devm_ioremap_resource(dev, res);
 		if (IS_ERR(qspi->base[BSPI])) {
 			ret = PTR_ERR(qspi->base[BSPI]);
-			goto qspi_probe_err;
+			goto qspi_resource_err;
 		}
 		qspi->bspi_mode = true;
 	} else {
-- 
2.16.2
