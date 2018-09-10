Return-Path: <SRS0=FvrY=LY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E018C4321E
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 17:53:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4338C20881
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 17:53:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sirena.org.uk header.i=@sirena.org.uk header.b="JgWWS8BP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4338C20881
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728439AbeIJWtK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Sep 2018 18:49:10 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:53390 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726603AbeIJWtJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Sep 2018 18:49:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=bVRkBi97z0GVvsD8H7d58qFvNH0e886Xst7XreuZZBY=; b=JgWWS8BPmOsv
        PUlsIDKGVdXZd8mMaxVJoRapFHzsQtl4E1Ciy4Ms5tWy459UJqCBw7FTSGdQs2b4bHSkVaFidveeB
        QrA65J7YUE+6ofaj0e8+UMF+I+3g39vLLwGXA08Nvhfqmojvfj24ll1TTG4qOwlXTgt4GzevQYiYS
        /FRKk=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1fzQNP-00028B-39; Mon, 10 Sep 2018 17:53:31 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id BC2A511227B6; Mon, 10 Sep 2018 18:53:30 +0100 (BST)
From:   Mark Brown <broonie@kernel.org>
To:     Robert Jarzmik <robert.jarzmik@free.fr>
Cc:     Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, Daniel Mack <daniel@zonque.org>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        alsa-devel@alsa-project.org
Subject: Applied "ASoC: pxa: switch to new ac97 bus support" to the asoc tree
In-Reply-To:  <20180825084618.13641-1-robert.jarzmik@free.fr>
Message-Id: <20180910175330.BC2A511227B6@debutante.sirena.org.uk>
Date:   Mon, 10 Sep 2018 18:53:30 +0100 (BST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   ASoC: pxa: switch to new ac97 bus support

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

From 1c8bc7b3de5e76cb89aacdc7be1475a028af505f Mon Sep 17 00:00:00 2001
From: Robert Jarzmik <robert.jarzmik@free.fr>
Date: Sat, 25 Aug 2018 10:46:18 +0200
Subject: [PATCH] ASoC: pxa: switch to new ac97 bus support

Switch to the new ac97 bus support in sound/ac97 instead of the legacy
snd_ac97 one.

Signed-off-by: Robert Jarzmik <robert.jarzmik@free.fr>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/arm/Kconfig           |  1 -
 sound/soc/pxa/Kconfig       |  5 ++--
 sound/soc/pxa/pxa2xx-ac97.c | 48 +++++++++++++++++++------------------
 3 files changed, 27 insertions(+), 27 deletions(-)

diff --git a/sound/arm/Kconfig b/sound/arm/Kconfig
index 5fbd47a9177e..28867732a318 100644
--- a/sound/arm/Kconfig
+++ b/sound/arm/Kconfig
@@ -31,7 +31,6 @@ endif	# SND_ARM
 
 config SND_PXA2XX_LIB
 	tristate
-	select SND_AC97_CODEC if SND_PXA2XX_LIB_AC97
 	select SND_DMAENGINE_PCM
 
 config SND_PXA2XX_LIB_AC97
diff --git a/sound/soc/pxa/Kconfig b/sound/soc/pxa/Kconfig
index 776e148b0aa2..29f577e6dfc0 100644
--- a/sound/soc/pxa/Kconfig
+++ b/sound/soc/pxa/Kconfig
@@ -19,14 +19,13 @@ config SND_MMP_SOC
 
 config SND_PXA2XX_AC97
 	tristate
-	select SND_AC97_CODEC
 
 config SND_PXA2XX_SOC_AC97
 	tristate
-	select AC97_BUS
+	select AC97_BUS_NEW
 	select SND_PXA2XX_LIB
 	select SND_PXA2XX_LIB_AC97
-	select SND_SOC_AC97_BUS
+	select SND_SOC_AC97_BUS_NEW
 
 config SND_PXA2XX_SOC_I2S
 	select SND_PXA2XX_LIB
diff --git a/sound/soc/pxa/pxa2xx-ac97.c b/sound/soc/pxa/pxa2xx-ac97.c
index 9f779657bc86..f8a3aa6c6d4e 100644
--- a/sound/soc/pxa/pxa2xx-ac97.c
+++ b/sound/soc/pxa/pxa2xx-ac97.c
@@ -17,6 +17,7 @@
 #include <linux/dmaengine.h>
 #include <linux/dma/pxa-dma.h>
 
+#include <sound/ac97/controller.h>
 #include <sound/core.h>
 #include <sound/ac97_codec.h>
 #include <sound/soc.h>
@@ -27,43 +28,35 @@
 #include <mach/regs-ac97.h>
 #include <mach/audio.h>
 
-static void pxa2xx_ac97_warm_reset(struct snd_ac97 *ac97)
+static void pxa2xx_ac97_warm_reset(struct ac97_controller *adrv)
 {
 	pxa2xx_ac97_try_warm_reset();
 
 	pxa2xx_ac97_finish_reset();
 }
 
-static void pxa2xx_ac97_cold_reset(struct snd_ac97 *ac97)
+static void pxa2xx_ac97_cold_reset(struct ac97_controller *adrv)
 {
 	pxa2xx_ac97_try_cold_reset();
 
 	pxa2xx_ac97_finish_reset();
 }
 
-static unsigned short pxa2xx_ac97_legacy_read(struct snd_ac97 *ac97,
-					      unsigned short reg)
+static int pxa2xx_ac97_read_actrl(struct ac97_controller *adrv, int slot,
+				  unsigned short reg)
 {
-	int ret;
-
-	ret = pxa2xx_ac97_read(ac97->num, reg);
-	if (ret < 0)
-		return 0;
-	else
-		return (unsigned short)(ret & 0xffff);
+	return pxa2xx_ac97_read(slot, reg);
 }
 
-static void pxa2xx_ac97_legacy_write(struct snd_ac97 *ac97,
-				     unsigned short reg, unsigned short val)
+static int pxa2xx_ac97_write_actrl(struct ac97_controller *adrv, int slot,
+				   unsigned short reg, unsigned short val)
 {
-	int ret;
-
-	ret = pxa2xx_ac97_write(ac97->num, reg, val);
+	return pxa2xx_ac97_write(slot, reg, val);
 }
 
-static struct snd_ac97_bus_ops pxa2xx_ac97_ops = {
-	.read	= pxa2xx_ac97_legacy_read,
-	.write	= pxa2xx_ac97_legacy_write,
+static struct ac97_controller_ops pxa2xx_ac97_ops = {
+	.read	= pxa2xx_ac97_read_actrl,
+	.write	= pxa2xx_ac97_write_actrl,
 	.warm_reset	= pxa2xx_ac97_warm_reset,
 	.reset	= pxa2xx_ac97_cold_reset,
 };
@@ -233,6 +226,9 @@ MODULE_DEVICE_TABLE(of, pxa2xx_ac97_dt_ids);
 static int pxa2xx_ac97_dev_probe(struct platform_device *pdev)
 {
 	int ret;
+	struct ac97_controller *ctrl;
+	pxa2xx_audio_ops_t *pdata = pdev->dev.platform_data;
+	void **codecs_pdata;
 
 	if (pdev->id != -1) {
 		dev_err(&pdev->dev, "PXA2xx has only one AC97 port.\n");
@@ -245,10 +241,14 @@ static int pxa2xx_ac97_dev_probe(struct platform_device *pdev)
 		return ret;
 	}
 
-	ret = snd_soc_set_ac97_ops(&pxa2xx_ac97_ops);
-	if (ret != 0)
-		return ret;
+	codecs_pdata = pdata ? pdata->codec_pdata : NULL;
+	ctrl = snd_ac97_controller_register(&pxa2xx_ac97_ops, &pdev->dev,
+					    AC97_SLOTS_AVAILABLE_ALL,
+					    codecs_pdata);
+	if (IS_ERR(ctrl))
+		return PTR_ERR(ctrl);
 
+	platform_set_drvdata(pdev, ctrl);
 	/* Punt most of the init to the SoC probe; we may need the machine
 	 * driver to do interesting things with the clocking to get us up
 	 * and running.
@@ -259,8 +259,10 @@ static int pxa2xx_ac97_dev_probe(struct platform_device *pdev)
 
 static int pxa2xx_ac97_dev_remove(struct platform_device *pdev)
 {
+	struct ac97_controller *ctrl = platform_get_drvdata(pdev);
+
 	snd_soc_unregister_component(&pdev->dev);
-	snd_soc_set_ac97_ops(NULL);
+	snd_ac97_controller_unregister(ctrl);
 	pxa2xx_ac97_hw_remove(pdev);
 	return 0;
 }
-- 
2.19.0.rc1

