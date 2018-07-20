Return-Path: <SRS0=cuzA=KE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 497E2ECDFBB
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 07:53:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D4D14206B7
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 07:53:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D4D14206B7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ziswiler.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727602AbeGTIkl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Jul 2018 04:40:41 -0400
Received: from mout.perfora.net ([74.208.4.197]:41123 "EHLO mout.perfora.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727048AbeGTIkl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jul 2018 04:40:41 -0400
Received: from localhost.localdomain.ziswiler.net ([89.217.215.226]) by
 mrelay.perfora.net (mreueus002 [74.208.5.2]) with ESMTPA (Nemesis) id
 0LvjLO-1g5fkm15rQ-017Xy1; Fri, 20 Jul 2018 09:52:13 +0200
From:   Marcel Ziswiler <marcel@ziswiler.com>
To:     alsa-devel@alsa-project.org, linux-tegra@vger.kernel.org,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        Mark Brown <broonie@kernel.org>
Cc:     Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        linux-mips@linux-mips.org,
        Gregory CLEMENT <gregory.clement@bootlin.com>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        James Hogan <jhogan@kernel.org>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Bhumika Goyal <bhumirks@gmail.com>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Takashi Iwai <tiwai@suse.com>,
        Paul Burton <paul.burton@mips.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Lee Jones <lee.jones@linaro.org>,
        Daniel Mack <daniel@zonque.org>,
        Manuel Lauss <manuel.lauss@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        linux-arm-kernel@lists.infradead.org,
        Jaroslav Kysela <perex@perex.cz>,
        Robert Jarzmik <robert.jarzmik@free.fr>,
        patches@opensource.cirrus.com, linux-kernel@vger.kernel.org,
        Han Xu <han.xu@nxp.com>, Donglin Peng <dolinux.peng@gmail.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Boris Brezillon <boris.brezillon@bootlin.com>
Subject: [PATCH] ASoC: wm9712: fix replace codec to component
Date:   Fri, 20 Jul 2018 09:51:48 +0200
Message-Id: <20180720075148.14648-1-marcel@ziswiler.com>
X-Mailer: git-send-email 2.14.4
X-Provags-ID: V03:K1:jgkuzK5IC8EHF4K+efLJ7LCt74be1ZvWsYu53EshPQ8lgi0OG7V
 /3DXb/hCGTLv9bkJdY2Erfg6k2SYSMAVzXAXu9YYXgAFhwavhUbOEjbCkMDskw3d0Elnmqt
 XTdRWmUVj0QZXJDVwC2fdn1r72SV1HqZ0F1wpwEOA+6v4Vmv5CU9Qi2X7CliMwvqyS23+NW
 Y4mQ9/EadW3erMN8545qA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:qwFmHeUNMWg=:aQqWF11ctMgVo/ljbSF6Ib
 PKhgX5X4nIS139T5EQZKVyat+jeJhvHVV8WIA7BgYGRANCxHbDnq5mL9BB2dNIypPGhkPXH4y
 BO5u2RqqidKSOnhUHJosbzhndcWpM779WI0wbDMAJM3d7l+KBRmraoT87vqs1NGsBBAwW5gCN
 8CaYzBPCzBhjaiyiqghdZpXi3Zf58XdGGpXwxdfotWOaFtIvjilBqynyXN6K+WaZwARYa36eJ
 Q0XcVtoH4hPri7/WAMLEVnzwPCIuqW1Wbh//OQNVITmwPCHv36/WPfCcPO8ESiEv47u+E4/9a
 uZNWdQ02/W+hifpTO9OLdeba/82euYMIajDvmPvvqefRWlEK9N7BwjPkTbdNaH0cW6sm+sUUX
 v7L4ZIJwYUYvmu3BsMhhS4nCFe5L5nZcgC2Yo3P+mNDWjb6k/2BLFO74c6NOuK2y+GVBKYhJe
 B7SAfk/RRNdaWdTua1dl3OhgJjF072siOV3buKmFRsq6Nu/d/GDDD0cb409QsQN2KwcjIEPCV
 uoUavxAwkSJubyD9M9o6c2ZDxcew+2A1l2ixb21IhFNPcx2s91vymPxarLxCYIanhbFfqk0Y0
 jm2hmB/DmEkq1Jff0CEdR5yeTa/fBbDoKckeN3N7nyQB2oi8YpOsu+9SQXQoQ8vyPy1uzpQk3
 DCxcAt9VM/KlOp8CzR6RHVz/NoOLyinqybWRDLiQEbb0XqTHDgnIBgM9N3kslFkQ8jkM=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Marcel Ziswiler <marcel.ziswiler@toradex.com>

Since commit 143b44845d87 ("ASoC: wm9712: replace codec to component")
"wm9712-codec" got renamed to "wm9712-component", however, this change
never got propagated down to the actual board/platform drivers. E.g. on
Colibri T20 this lead to the following spew upon boot with sound/touch
being broken:

[    2.214121] tegra-snd-wm9712 sound: ASoC: CODEC DAI wm9712-hifi not registered
[    2.222137] tegra-snd-wm9712 sound: snd_soc_register_card failed (-517)
...
[    2.344384] tegra-snd-wm9712 sound: ASoC: CODEC DAI wm9712-hifi not registered
[    2.351885] tegra-snd-wm9712 sound: snd_soc_register_card failed (-517)
...
[    2.668339] tegra-snd-wm9712 sound: ASoC: CODEC DAI wm9712-hifi not registered
[    2.675811] tegra-snd-wm9712 sound: snd_soc_register_card failed (-517)
...
[    3.208408] tegra-snd-wm9712 sound: ASoC: CODEC DAI wm9712-hifi not registered
[    3.216312] tegra-snd-wm9712 sound: snd_soc_register_card failed (-517)
...
[    3.235397] tegra-snd-wm9712 sound: ASoC: CODEC DAI wm9712-hifi not registered
[    3.248938] tegra-snd-wm9712 sound: snd_soc_register_card failed (-517)
...
[   14.970443] ALSA device list:
[   14.996628]   No soundcards found.

This commit finally fixes this again.

Signed-off-by: Marcel Ziswiler <marcel.ziswiler@toradex.com>

---

 arch/arm/mach-pxa/tosa.c             | 2 +-
 arch/mips/alchemy/devboards/db1300.c | 2 +-
 drivers/mfd/wm97xx-core.c            | 6 +++---
 sound/soc/au1x/db1200.c              | 4 ++--
 sound/soc/fsl/pcm030-audio-fabric.c  | 6 +++---
 sound/soc/fsl/phycore-ac97.c         | 6 +++---
 sound/soc/pxa/e800_wm9712.c          | 4 ++--
 sound/soc/pxa/em-x270.c              | 4 ++--
 sound/soc/pxa/palm27x.c              | 4 ++--
 sound/soc/pxa/tosa.c                 | 4 ++--
 sound/soc/tegra/tegra_wm9712.c       | 4 ++--
 11 files changed, 23 insertions(+), 23 deletions(-)

diff --git a/arch/arm/mach-pxa/tosa.c b/arch/arm/mach-pxa/tosa.c
index cb5cd8e78c94..32011e600496 100644
--- a/arch/arm/mach-pxa/tosa.c
+++ b/arch/arm/mach-pxa/tosa.c
@@ -848,7 +848,7 @@ static struct platform_device sharpsl_rom_device = {
 };
 
 static struct platform_device wm9712_device = {
-	.name	= "wm9712-codec",
+	.name	= "wm9712-component",
 	.id	= -1,
 };
 
diff --git a/arch/mips/alchemy/devboards/db1300.c b/arch/mips/alchemy/devboards/db1300.c
index efb318e03e0a..841a27736eb1 100644
--- a/arch/mips/alchemy/devboards/db1300.c
+++ b/arch/mips/alchemy/devboards/db1300.c
@@ -638,7 +638,7 @@ static struct platform_device db1300_sd0_dev = {
 /**********************************************************************/
 
 static struct platform_device db1300_wm9715_dev = {
-	.name		= "wm9712-codec",
+	.name		= "wm9712-component",
 	.id		= 1,	/* ID of PSC for AC97 audio, see asoc glue! */
 };
 
diff --git a/drivers/mfd/wm97xx-core.c b/drivers/mfd/wm97xx-core.c
index f5a8347f837f..9fec11fc0410 100644
--- a/drivers/mfd/wm97xx-core.c
+++ b/drivers/mfd/wm97xx-core.c
@@ -109,7 +109,7 @@ static const struct regmap_config wm9705_regmap_config = {
 };
 
 static struct mfd_cell wm9705_cells[] = {
-	{ .name = "wm9705-codec", },
+	{ .name = "wm9705-component", },
 	{ .name = "wm97xx-ts", },
 };
 
@@ -177,7 +177,7 @@ static const struct regmap_config wm9712_regmap_config = {
 };
 
 static struct mfd_cell wm9712_cells[] = {
-	{ .name = "wm9712-codec", },
+	{ .name = "wm9712-component", },
 	{ .name = "wm97xx-ts", },
 };
 
@@ -248,7 +248,7 @@ static const struct regmap_config wm9713_regmap_config = {
 };
 
 static struct mfd_cell wm9713_cells[] = {
-	{ .name = "wm9713-codec", },
+	{ .name = "wm9713-component", },
 	{ .name = "wm97xx-ts", },
 };
 
diff --git a/sound/soc/au1x/db1200.c b/sound/soc/au1x/db1200.c
index 301e1fc9a377..d452478d62b4 100644
--- a/sound/soc/au1x/db1200.c
+++ b/sound/soc/au1x/db1200.c
@@ -52,7 +52,7 @@ static struct snd_soc_dai_link db1200_ac97_dai = {
 	.codec_dai_name	= "ac97-hifi",
 	.cpu_dai_name	= "au1xpsc_ac97.1",
 	.platform_name	= "au1xpsc-pcm.1",
-	.codec_name	= "ac97-codec.1",
+	.codec_name	= "ac97-component.1",
 };
 
 static struct snd_soc_card db1200_ac97_machine = {
@@ -68,7 +68,7 @@ static struct snd_soc_dai_link db1300_ac97_dai = {
 	.codec_dai_name	= "wm9712-hifi",
 	.cpu_dai_name	= "au1xpsc_ac97.1",
 	.platform_name	= "au1xpsc-pcm.1",
-	.codec_name	= "wm9712-codec.1",
+	.codec_name	= "wm9712-component.1",
 };
 
 static struct snd_soc_card db1300_ac97_machine = {
diff --git a/sound/soc/fsl/pcm030-audio-fabric.c b/sound/soc/fsl/pcm030-audio-fabric.c
index ec731223cab3..869f4b226ccd 100644
--- a/sound/soc/fsl/pcm030-audio-fabric.c
+++ b/sound/soc/fsl/pcm030-audio-fabric.c
@@ -33,14 +33,14 @@ static struct snd_soc_dai_link pcm030_fabric_dai[] = {
 	.stream_name = "AC97 Analog",
 	.codec_dai_name = "wm9712-hifi",
 	.cpu_dai_name = "mpc5200-psc-ac97.0",
-	.codec_name = "wm9712-codec",
+	.codec_name = "wm9712-component",
 },
 {
 	.name = "AC97.1",
 	.stream_name = "AC97 IEC958",
 	.codec_dai_name = "wm9712-aux",
 	.cpu_dai_name = "mpc5200-psc-ac97.1",
-	.codec_name = "wm9712-codec",
+	.codec_name = "wm9712-component",
 },
 };
 
@@ -85,7 +85,7 @@ static int pcm030_fabric_probe(struct platform_device *op)
 	if (ret)
 		dev_err(&op->dev, "request_module returned: %d\n", ret);
 
-	pdata->codec_device = platform_device_alloc("wm9712-codec", -1);
+	pdata->codec_device = platform_device_alloc("wm9712-component", -1);
 	if (!pdata->codec_device)
 		dev_err(&op->dev, "platform_device_alloc() failed\n");
 
diff --git a/sound/soc/fsl/phycore-ac97.c b/sound/soc/fsl/phycore-ac97.c
index 66fb6c4614d2..dbd81d3b7c2c 100644
--- a/sound/soc/fsl/phycore-ac97.c
+++ b/sound/soc/fsl/phycore-ac97.c
@@ -30,8 +30,8 @@ static struct snd_soc_dai_link imx_phycore_dai_ac97[] = {
 	{
 		.name		= "HiFi",
 		.stream_name	= "HiFi",
-		.codec_dai_name		= "wm9712-hifi",
-		.codec_name	= "wm9712-codec",
+		.codec_dai_name	= "wm9712-hifi",
+		.codec_name	= "wm9712-component",
 		.cpu_dai_name	= "imx-ssi.0",
 		.platform_name	= "imx-ssi.0",
 		.ops		= &imx_phycore_hifi_ops,
@@ -88,7 +88,7 @@ static int __init imx_phycore_init(void)
 	if (ret)
 		goto fail1;
 
-	imx_phycore_snd_device = platform_device_alloc("wm9712-codec", -1);
+	imx_phycore_snd_device = platform_device_alloc("wm9712-component", -1);
 	if (!imx_phycore_snd_device) {
 		ret = -ENOMEM;
 		goto fail2;
diff --git a/sound/soc/pxa/e800_wm9712.c b/sound/soc/pxa/e800_wm9712.c
index 1ed8aa2348f1..937746d1e23e 100644
--- a/sound/soc/pxa/e800_wm9712.c
+++ b/sound/soc/pxa/e800_wm9712.c
@@ -75,7 +75,7 @@ static struct snd_soc_dai_link e800_dai[] = {
 		.cpu_dai_name = "pxa2xx-ac97",
 		.codec_dai_name = "wm9712-hifi",
 		.platform_name = "pxa-pcm-audio",
-		.codec_name = "wm9712-codec",
+		.codec_name = "wm9712-component",
 	},
 	{
 		.name = "AC97 Aux",
@@ -83,7 +83,7 @@ static struct snd_soc_dai_link e800_dai[] = {
 		.cpu_dai_name = "pxa2xx-ac97-aux",
 		.codec_dai_name = "wm9712-aux",
 		.platform_name = "pxa-pcm-audio",
-		.codec_name = "wm9712-codec",
+		.codec_name = "wm9712-component",
 	},
 };
 
diff --git a/sound/soc/pxa/em-x270.c b/sound/soc/pxa/em-x270.c
index e046770ce70e..e958c4c241f6 100644
--- a/sound/soc/pxa/em-x270.c
+++ b/sound/soc/pxa/em-x270.c
@@ -37,7 +37,7 @@ static struct snd_soc_dai_link em_x270_dai[] = {
 		.cpu_dai_name = "pxa2xx-ac97",
 		.codec_dai_name = "wm9712-hifi",
 		.platform_name = "pxa-pcm-audio",
-		.codec_name = "wm9712-codec",
+		.codec_name = "wm9712-component",
 	},
 	{
 		.name = "AC97 Aux",
@@ -45,7 +45,7 @@ static struct snd_soc_dai_link em_x270_dai[] = {
 		.cpu_dai_name = "pxa2xx-ac97-aux",
 		.codec_dai_name = "wm9712-aux",
 		.platform_name = "pxa-pcm-audio",
-		.codec_name = "wm9712-codec",
+		.codec_name = "wm9712-component",
 	},
 };
 
diff --git a/sound/soc/pxa/palm27x.c b/sound/soc/pxa/palm27x.c
index 97167048572d..040db695270e 100644
--- a/sound/soc/pxa/palm27x.c
+++ b/sound/soc/pxa/palm27x.c
@@ -93,7 +93,7 @@ static struct snd_soc_dai_link palm27x_dai[] = {
 	.stream_name = "AC97 HiFi",
 	.cpu_dai_name = "pxa2xx-ac97",
 	.codec_dai_name =  "wm9712-hifi",
-	.codec_name = "wm9712-codec",
+	.codec_name = "wm9712-component",
 	.platform_name = "pxa-pcm-audio",
 	.init = palm27x_ac97_init,
 },
@@ -102,7 +102,7 @@ static struct snd_soc_dai_link palm27x_dai[] = {
 	.stream_name = "AC97 Aux",
 	.cpu_dai_name = "pxa2xx-ac97-aux",
 	.codec_dai_name = "wm9712-aux",
-	.codec_name = "wm9712-codec",
+	.codec_name = "wm9712-component",
 	.platform_name = "pxa-pcm-audio",
 },
 };
diff --git a/sound/soc/pxa/tosa.c b/sound/soc/pxa/tosa.c
index ae9c12e1ea2a..af42417ccec5 100644
--- a/sound/soc/pxa/tosa.c
+++ b/sound/soc/pxa/tosa.c
@@ -189,7 +189,7 @@ static struct snd_soc_dai_link tosa_dai[] = {
 	.cpu_dai_name = "pxa2xx-ac97",
 	.codec_dai_name = "wm9712-hifi",
 	.platform_name = "pxa-pcm-audio",
-	.codec_name = "wm9712-codec",
+	.codec_name = "wm9712-component",
 	.ops = &tosa_ops,
 },
 {
@@ -198,7 +198,7 @@ static struct snd_soc_dai_link tosa_dai[] = {
 	.cpu_dai_name = "pxa2xx-ac97-aux",
 	.codec_dai_name = "wm9712-aux",
 	.platform_name = "pxa-pcm-audio",
-	.codec_name = "wm9712-codec",
+	.codec_name = "wm9712-component",
 	.ops = &tosa_ops,
 },
 };
diff --git a/sound/soc/tegra/tegra_wm9712.c b/sound/soc/tegra/tegra_wm9712.c
index 864a3345972e..aa12be76d15a 100644
--- a/sound/soc/tegra/tegra_wm9712.c
+++ b/sound/soc/tegra/tegra_wm9712.c
@@ -53,7 +53,7 @@ static struct snd_soc_dai_link tegra_wm9712_dai = {
 	.name = "AC97 HiFi",
 	.stream_name = "AC97 HiFi",
 	.codec_dai_name = "wm9712-hifi",
-	.codec_name = "wm9712-codec",
+	.codec_name = "wm9712-component",
 	.init = tegra_wm9712_init,
 };
 
@@ -83,7 +83,7 @@ static int tegra_wm9712_driver_probe(struct platform_device *pdev)
 	card->dev = &pdev->dev;
 	snd_soc_card_set_drvdata(card, machine);
 
-	machine->codec = platform_device_alloc("wm9712-codec", -1);
+	machine->codec = platform_device_alloc("wm9712-component", -1);
 	if (!machine->codec) {
 		dev_err(&pdev->dev, "Can't allocate wm9712 platform device\n");
 		return -ENOMEM;
-- 
2.14.4

