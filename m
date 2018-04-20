Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753511AbeDTREM (ORCPT <rfc822;w@1wt.eu>);
        Fri, 20 Apr 2018 13:04:12 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:47454 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752337AbeDTREK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Apr 2018 13:04:10 -0400
From: Mark Brown <broonie@kernel.org>
To: Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc: Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        alsa-devel@alsa-project.org, Takashi Iwai <tiwai@suse.com>,
        kernel-janitors@vger.kernel.org,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Liam Girdwood <lgirdwood@gmail.com>, linux-renesas-soc@vger.kernel.org,
        Mark Brown <broonie@kernel.org>, linux-arm-kernel@lists.infradead.org,
        alsa-devel@alsa-project.org
Subject: Applied "ASoC: atmel: simplify getting .drvdata" to the asoc tree
In-Reply-To: <20180419140641.27926-62-wsa+renesas@sang-engineering.com>
Message-Id: <E1f9ZS7-0004VB-By@debutante>
Date: Fri, 20 Apr 2018 18:04:03 +0100
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   ASoC: atmel: simplify getting .drvdata

has been applied to the asoc tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git 

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

>From c0380478139fce887b948b35dc0dcee0b40bdf09 Mon Sep 17 00:00:00 2001
From: Wolfram Sang <wsa+renesas@sang-engineering.com>
Date: Thu, 19 Apr 2018 16:06:31 +0200
Subject: [PATCH] ASoC: atmel: simplify getting .drvdata

We should get drvdata from struct device directly. Going via
platform_device is an unneeded step back and forth.

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/atmel/atmel_ssc_dai.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/sound/soc/atmel/atmel_ssc_dai.c b/sound/soc/atmel/atmel_ssc_dai.c
index 1c7af0ca98ec..d3b69682d9c2 100644
--- a/sound/soc/atmel/atmel_ssc_dai.c
+++ b/sound/soc/atmel/atmel_ssc_dai.c
@@ -1002,8 +1002,7 @@ static const struct snd_soc_component_driver atmel_ssc_component = {
 
 static int asoc_ssc_init(struct device *dev)
 {
-	struct platform_device *pdev = to_platform_device(dev);
-	struct ssc_device *ssc = platform_get_drvdata(pdev);
+	struct ssc_device *ssc = dev_get_drvdata(dev);
 	int ret;
 
 	ret = snd_soc_register_component(dev, &atmel_ssc_component,
@@ -1033,8 +1032,7 @@ static int asoc_ssc_init(struct device *dev)
 
 static void asoc_ssc_exit(struct device *dev)
 {
-	struct platform_device *pdev = to_platform_device(dev);
-	struct ssc_device *ssc = platform_get_drvdata(pdev);
+	struct ssc_device *ssc = dev_get_drvdata(dev);
 
 	if (ssc->pdata->use_dma)
 		atmel_pcm_dma_platform_unregister(dev);
-- 
2.17.0
