Return-Path: <SRS0=bKrn=NQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28B6AC46475
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 11:59:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D375E20825
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 11:59:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sirena.org.uk header.i=@sirena.org.uk header.b="SDtXEgE5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D375E20825
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729421AbeKEVSr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 5 Nov 2018 16:18:47 -0500
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:40752 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726494AbeKEVSq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Nov 2018 16:18:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=Xp1cvOYUMWsq6Y3iqTzyhO4J0pL7i2/Z32XOIDy+44E=; b=SDtXEgE5FVl+
        9RN9xSDKFlfIfckxw+n1jVgdqUNX82KLM1cd6N4D+SWIWuroezFZY7cxCgDIWiIxWelxBpQ13SCzq
        yZSe9Lxfz46IZT1CPAr1KzWQ3//Blxtg0KSeq3s/wa0ClvnIhnVF0Tu7sqNUvfareRyLqI7DmETB0
        9arqE=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1gJdXC-0008Ix-Pc; Mon, 05 Nov 2018 11:59:10 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id 773A81124D98; Mon,  5 Nov 2018 11:59:10 +0000 (GMT)
From:   Mark Brown <broonie@kernel.org>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org,
        Charles Keepax <ckeepax@opensource.cirrus.com>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        patches@opensource.cirrus.com, linux-kernel@vger.kernel.org,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Robert Jarzmik <robert.jarzmik@free.fr>,
        alsa-devel@alsa-project.org
Subject: Applied "ASoC: wm97xx: fix uninitialized regmap pointer problem" to the asoc tree
In-Reply-To:  <20181102151922.889131-1-arnd@arndb.de>
Message-Id: <20181105115910.773A81124D98@debutante.sirena.org.uk>
Date:   Mon,  5 Nov 2018 11:59:10 +0000 (GMT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   ASoC: wm97xx: fix uninitialized regmap pointer problem

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

From 576ce4075bfa0f03e0e91a89eecc539b3b828b08 Mon Sep 17 00:00:00 2001
From: Arnd Bergmann <arnd@arndb.de>
Date: Fri, 2 Nov 2018 16:18:21 +0100
Subject: [PATCH] ASoC: wm97xx: fix uninitialized regmap pointer problem

gcc notices that without either the ac97 bus or the pdata, we never
initialize the regmap pointer, which leads to an uninitialized variable
access:

sound/soc/codecs/wm9712.c: In function 'wm9712_soc_probe':
sound/soc/codecs/wm9712.c:666:2: error: 'regmap' may be used uninitialized in this function [-Werror=maybe-uninitialized]

Since that configuration is invalid, it's better to return an error
here. I tried to avoid adding complexity to the conditions, and turned
the #ifdef into a regular if(IS_ENABLED()) check for readability.
This in turn requires moving some header file declarations out of
an #ifdef.

The same code is used in three drivers, all of which I'm changing
the same way.

Fixes: 2ed1a8e0ce8d ("ASoC: wm9712: add ac97 new bus support")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 include/sound/soc.h       |  2 +-
 sound/soc/codecs/wm9705.c | 10 ++++------
 sound/soc/codecs/wm9712.c | 10 ++++------
 sound/soc/codecs/wm9713.c | 10 ++++------
 4 files changed, 13 insertions(+), 19 deletions(-)

diff --git a/include/sound/soc.h b/include/sound/soc.h
index f1dab1f4b194..5a8b84140f01 100644
--- a/include/sound/soc.h
+++ b/include/sound/soc.h
@@ -553,12 +553,12 @@ static inline void snd_soc_jack_free_gpios(struct snd_soc_jack *jack, int count,
 }
 #endif
 
-#ifdef CONFIG_SND_SOC_AC97_BUS
 struct snd_ac97 *snd_soc_alloc_ac97_component(struct snd_soc_component *component);
 struct snd_ac97 *snd_soc_new_ac97_component(struct snd_soc_component *component,
 	unsigned int id, unsigned int id_mask);
 void snd_soc_free_ac97_component(struct snd_ac97 *ac97);
 
+#ifdef CONFIG_SND_SOC_AC97_BUS
 int snd_soc_set_ac97_ops(struct snd_ac97_bus_ops *ops);
 int snd_soc_set_ac97_ops_of_reset(struct snd_ac97_bus_ops *ops,
 		struct platform_device *pdev);
diff --git a/sound/soc/codecs/wm9705.c b/sound/soc/codecs/wm9705.c
index ccdf088461b7..54c306707c02 100644
--- a/sound/soc/codecs/wm9705.c
+++ b/sound/soc/codecs/wm9705.c
@@ -325,8 +325,7 @@ static int wm9705_soc_probe(struct snd_soc_component *component)
 	if (wm9705->mfd_pdata) {
 		wm9705->ac97 = wm9705->mfd_pdata->ac97;
 		regmap = wm9705->mfd_pdata->regmap;
-	} else {
-#ifdef CONFIG_SND_SOC_AC97_BUS
+	} else if (IS_ENABLED(CONFIG_SND_SOC_AC97_BUS)) {
 		wm9705->ac97 = snd_soc_new_ac97_component(component, WM9705_VENDOR_ID,
 						      WM9705_VENDOR_ID_MASK);
 		if (IS_ERR(wm9705->ac97)) {
@@ -339,7 +338,8 @@ static int wm9705_soc_probe(struct snd_soc_component *component)
 			snd_soc_free_ac97_component(wm9705->ac97);
 			return PTR_ERR(regmap);
 		}
-#endif
+	} else {
+		return -ENXIO;
 	}
 
 	snd_soc_component_set_drvdata(component, wm9705->ac97);
@@ -350,14 +350,12 @@ static int wm9705_soc_probe(struct snd_soc_component *component)
 
 static void wm9705_soc_remove(struct snd_soc_component *component)
 {
-#ifdef CONFIG_SND_SOC_AC97_BUS
 	struct wm9705_priv *wm9705 = snd_soc_component_get_drvdata(component);
 
-	if (!wm9705->mfd_pdata) {
+	if (IS_ENABLED(CONFIG_SND_SOC_AC97_BUS) && !wm9705->mfd_pdata) {
 		snd_soc_component_exit_regmap(component);
 		snd_soc_free_ac97_component(wm9705->ac97);
 	}
-#endif
 }
 
 static const struct snd_soc_component_driver soc_component_dev_wm9705 = {
diff --git a/sound/soc/codecs/wm9712.c b/sound/soc/codecs/wm9712.c
index e873baa9e778..01949eaba4fd 100644
--- a/sound/soc/codecs/wm9712.c
+++ b/sound/soc/codecs/wm9712.c
@@ -642,8 +642,7 @@ static int wm9712_soc_probe(struct snd_soc_component *component)
 	if (wm9712->mfd_pdata) {
 		wm9712->ac97 = wm9712->mfd_pdata->ac97;
 		regmap = wm9712->mfd_pdata->regmap;
-	} else {
-#ifdef CONFIG_SND_SOC_AC97_BUS
+	} else if (IS_ENABLED(CONFIG_SND_SOC_AC97_BUS)) {
 		int ret;
 
 		wm9712->ac97 = snd_soc_new_ac97_component(component, WM9712_VENDOR_ID,
@@ -660,7 +659,8 @@ static int wm9712_soc_probe(struct snd_soc_component *component)
 			snd_soc_free_ac97_component(wm9712->ac97);
 			return PTR_ERR(regmap);
 		}
-#endif
+	} else {
+		return -ENXIO;
 	}
 
 	snd_soc_component_init_regmap(component, regmap);
@@ -673,14 +673,12 @@ static int wm9712_soc_probe(struct snd_soc_component *component)
 
 static void wm9712_soc_remove(struct snd_soc_component *component)
 {
-#ifdef CONFIG_SND_SOC_AC97_BUS
 	struct wm9712_priv *wm9712 = snd_soc_component_get_drvdata(component);
 
-	if (!wm9712->mfd_pdata) {
+	if (IS_ENABLED(CONFIG_SND_SOC_AC97_BUS) && !wm9712->mfd_pdata) {
 		snd_soc_component_exit_regmap(component);
 		snd_soc_free_ac97_component(wm9712->ac97);
 	}
-#endif
 }
 
 static const struct snd_soc_component_driver soc_component_dev_wm9712 = {
diff --git a/sound/soc/codecs/wm9713.c b/sound/soc/codecs/wm9713.c
index 643863bb32e0..5a2fdf4f69bf 100644
--- a/sound/soc/codecs/wm9713.c
+++ b/sound/soc/codecs/wm9713.c
@@ -1214,8 +1214,7 @@ static int wm9713_soc_probe(struct snd_soc_component *component)
 	if (wm9713->mfd_pdata) {
 		wm9713->ac97 = wm9713->mfd_pdata->ac97;
 		regmap = wm9713->mfd_pdata->regmap;
-	} else {
-#ifdef CONFIG_SND_SOC_AC97_BUS
+	} else if (IS_ENABLED(CONFIG_SND_SOC_AC97_BUS)) {
 		wm9713->ac97 = snd_soc_new_ac97_component(component, WM9713_VENDOR_ID,
 						      WM9713_VENDOR_ID_MASK);
 		if (IS_ERR(wm9713->ac97))
@@ -1225,7 +1224,8 @@ static int wm9713_soc_probe(struct snd_soc_component *component)
 			snd_soc_free_ac97_component(wm9713->ac97);
 			return PTR_ERR(regmap);
 		}
-#endif
+	} else {
+		return -ENXIO;
 	}
 
 	snd_soc_component_init_regmap(component, regmap);
@@ -1238,14 +1238,12 @@ static int wm9713_soc_probe(struct snd_soc_component *component)
 
 static void wm9713_soc_remove(struct snd_soc_component *component)
 {
-#ifdef CONFIG_SND_SOC_AC97_BUS
 	struct wm9713_priv *wm9713 = snd_soc_component_get_drvdata(component);
 
-	if (!wm9713->mfd_pdata) {
+	if (IS_ENABLED(CONFIG_SND_SOC_AC97_BUS) && !wm9713->mfd_pdata) {
 		snd_soc_component_exit_regmap(component);
 		snd_soc_free_ac97_component(wm9713->ac97);
 	}
-#endif
 }
 
 static const struct snd_soc_component_driver soc_component_dev_wm9713 = {
-- 
2.19.0.rc2

