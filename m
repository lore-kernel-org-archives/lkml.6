Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753654AbeDSOHr (ORCPT <rfc822;w@1wt.eu>);
        Thu, 19 Apr 2018 10:07:47 -0400
Received: from sauhun.de ([88.99.104.3]:45342 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753577AbeDSOHR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Apr 2018 10:07:17 -0400
From: Wolfram Sang <wsa+renesas@sang-engineering.com>
To: linux-kernel@vger.kernel.org
Cc: linux-renesas-soc@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        alsa-devel@alsa-project.org, linux-arm-kernel@lists.infradead.org
Subject: [PATCH 61/61] ASoC: atmel: simplify getting .drvdata
Date: Thu, 19 Apr 2018 16:06:31 +0200
Message-Id: <20180419140641.27926-62-wsa+renesas@sang-engineering.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20180419140641.27926-1-wsa+renesas@sang-engineering.com>
References: <20180419140641.27926-1-wsa+renesas@sang-engineering.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We should get drvdata from struct device directly. Going via
platform_device is an unneeded step back and forth.

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---

Build tested only. buildbot is happy. Please apply individually.

 sound/soc/atmel/atmel_ssc_dai.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/sound/soc/atmel/atmel_ssc_dai.c b/sound/soc/atmel/atmel_ssc_dai.c
index a1e2c5682dcd..4a0275a6505d 100644
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
2.11.0
