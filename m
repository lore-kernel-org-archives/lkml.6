Return-Path: <SRS0=zRJA=NN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4687C32789
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 15:20:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CED7F20657
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 15:20:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CED7F20657
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727417AbeKCA1q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 2 Nov 2018 20:27:46 -0400
Received: from mout.kundenserver.de ([212.227.126.131]:58361 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726260AbeKCA1q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Nov 2018 20:27:46 -0400
Received: from wuerfel.lan ([109.192.41.194]) by mrelayeu.kundenserver.de
 (mreue009 [212.227.15.129]) with ESMTPA (Nemesis) id
 1M1HmE-1gGwGl1Jus-002mbo; Fri, 02 Nov 2018 16:19:25 +0100
Received: from wuerfel.lan ([109.192.41.194]) by mrelayeu.kundenserver.de
 (mreue009 [212.227.15.129]) with ESMTPA (Nemesis) id
 1M1HmE-1gGwGl1Jus-002mbo; Fri, 02 Nov 2018 16:19:25 +0100
From:   Arnd Bergmann <arnd@arndb.de>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Cc:     Robert Jarzmik <robert.jarzmik@free.fr>,
        Arnd Bergmann <arnd@arndb.de>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        Charles Keepax <ckeepax@opensource.cirrus.com>,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        patches@opensource.cirrus.com
Subject: [PATCH] [v2] ASoC: wm97xx: fix uninitialized regmap pointer problem
Date:   Fri,  2 Nov 2018 16:18:21 +0100
Message-Id: <20181102151922.889131-1-arnd@arndb.de>
X-Mailer: git-send-email 2.18.0
X-Provags-ID: V03:K1:oIhgZpapvZj1izMFj4I9NkMbYVIe2+oZf6Xb8V9bLSg+Jmafy59
 g9BQfSxhATwfH/ZULHnBecYTAXsjRwd8a4ZS8C0z1+5FofZ4id4b1r8iUY0lJlEJFqriDhz
 QsnGh0ZalJhqdSvtj/YvBk/0q0R7+iyukvWLMGkuEH8gb5TF5TFJq7tbK08FkFb9qANrv6i
 2WcZA6HKziUbH78pI2rDg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:/F++M8gpaWQ=:h3dTp5GK1AawCCIwOF/085
 ZyfDvbz1h4146XD8lnBQYTk1Wa3TzMVD5tSaiEmQKR6V9EJRsVGdvJnyvnunD6ZwgErdO0ApX
 whcVqK/VgfX4+IF2fLN8wHKcL/9nSkUu0D50mNQrdCcXo0wyUKf/fFTqav0pVc6RI/bUrK2L5
 LuEnDlax/aaSRV1hqIa+a0DPAguDXLjrw394fsEI/ZdFaVdteSUjiP24Cy9x2HD3twbboLW7v
 YNhHSQI6MCgIBLXKI6KGy2nHn/iZA19sdtXqu1KVb7QPDaVwakS9ILUz1MtBETwnnEuFSgJeq
 zxsY1f4tikcGrWKrzniO+0lboNY2pFQYLMaYNuqUNeM0rigJo0dTmgjIuqlP+plsJazwDTdZz
 9eS0vYtt1LP92OH6bbda0QGqX/8nV5vYXCO3mj3lHJOv5PyQWnKGUfyD7QuWb2DqOKRWTMFsK
 nQkrwqHxS+oT0PcNye/EAMWgz+yvDwXuKwiApDQO20+4Gt7LBevkj3sj7zLavBtYrPuZKLWcb
 clr15UvD+PlhiLw9ry0qL0Cya/rIndOKd/STFqUWQCBWHqq+dUr9ZXTLLsD042h8FaCoHPPuR
 tlQ3cuPoyH9oBJ4nh5++XzsDx9qRX/PnPzHRx9xXjC9upF6QWT84Tatg9xbkiqEmrXSxEVKmB
 CEdrsperYmuOiIgCnEFe7bktyAzzLUB8NhSIBpTELMxynmCunTz5IpXQIn8CWPXXzn6U=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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
---
v2: fix a missing check that Charles pointed out
---
 include/sound/soc.h       |  2 +-
 sound/soc/codecs/wm9705.c | 10 ++++------
 sound/soc/codecs/wm9712.c | 10 ++++------
 sound/soc/codecs/wm9713.c | 10 ++++------
 4 files changed, 13 insertions(+), 19 deletions(-)

diff --git a/include/sound/soc.h b/include/sound/soc.h
index 70c10a8f3e90..3e0ac310a3df 100644
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
2.18.0

