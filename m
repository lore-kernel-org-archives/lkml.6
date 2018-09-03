Return-Path: <SRS0=G629=LR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41F06C43334
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 13:44:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DAACA20862
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 13:44:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sirena.org.uk header.i=@sirena.org.uk header.b="k/Ecn3gk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DAACA20862
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727443AbeICSFH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Sep 2018 14:05:07 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:53470 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725982AbeICSFH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Sep 2018 14:05:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=zWknDz7uyM8GMtxhR3a9By0kOcZkFWc+yZWkGYPkMTA=; b=k/Ecn3gkDWoT
        G8Cr/J1SbSBJI/IJUFzCHNqFjwx0QsXypWzbJSwkY44Irda3KaU/FmZkPjUqdpb9u4vPHVqFsBufQ
        dNkZGu6eh/qEHAbELxVsyWs8VZvS3snCEepQKp6TpIWnU7aT3HDlq2KQYtCWSe3C84CnzqqNlqPXZ
        Mc7hk=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1fwp9q-0000GW-3I; Mon, 03 Sep 2018 13:44:46 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id CE64311227AE; Mon,  3 Sep 2018 14:44:45 +0100 (BST)
From:   Mark Brown <broonie@kernel.org>
To:     Codrin Ciubotariu <codrin.ciubotariu@microchip.com>
Cc:     Florian Meier <florian.meier@koalo.de>,
        Mark Brown <broonie@kernel.org>, alsa-devel@alsa-project.org,
        devicetree@vger.kernel.org, broonie@kernel.org, robh+dt@kernel.org,
        alexandre.belloni@bootlin.com, nicolas.ferre@microchip.com,
        cristian.birsan@microchip.com, florian.meier@koalo.de,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        alsa-devel@alsa-project.org
Subject: Applied "ASoC: Add driver for PROTO Audio CODEC (with a WM8731)" to the asoc tree
In-Reply-To:  <20180831171436.13360-2-codrin.ciubotariu@microchip.com>
Message-Id: <20180903134445.CE64311227AE@debutante.sirena.org.uk>
Date:   Mon,  3 Sep 2018 14:44:45 +0100 (BST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   ASoC: Add driver for PROTO Audio CODEC (with a WM8731)

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

From a45f8853a5f95e3760dfbd7ba09d3d597d247040 Mon Sep 17 00:00:00 2001
From: Codrin Ciubotariu <codrin.ciubotariu@microchip.com>
Date: Fri, 31 Aug 2018 20:14:35 +0300
Subject: [PATCH] ASoC: Add driver for PROTO Audio CODEC (with a WM8731)

Add support for the MikroElektronika PROTO audio codec board.

URL to the audio chip:
http://www.mikroe.com/add-on-boards/audio-voice/audio-codec-proto/

Signed-off-by: Florian Meier <florian.meier@koalo.de>
Signed-off-by: Codrin Ciubotariu <codrin.ciubotariu@microchip.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/atmel/Kconfig        |  11 +++
 sound/soc/atmel/Makefile       |   2 +
 sound/soc/atmel/mikroe-proto.c | 165 +++++++++++++++++++++++++++++++++
 3 files changed, 178 insertions(+)
 create mode 100644 sound/soc/atmel/mikroe-proto.c

diff --git a/sound/soc/atmel/Kconfig b/sound/soc/atmel/Kconfig
index 64b784e96f84..81a0712d4f14 100644
--- a/sound/soc/atmel/Kconfig
+++ b/sound/soc/atmel/Kconfig
@@ -97,4 +97,15 @@ config SND_ATMEL_SOC_I2S
 	help
 	  Say Y or M if you want to add support for Atmel ASoc driver for boards
 	  using I2S.
+
+config SND_SOC_MIKROE_PROTO
+	tristate "Support for Mikroe-PROTO board"
+	depends on OF
+	select SND_SOC_WM8731
+	help
+	  Say Y or M if you want to add support for MikroElektronika PROTO Audio
+	  Board. This board contains the WM8731 codec, which can be configured
+	  using I2C over SDA (MPU Data Input) and SCL (MPU Clock Input) pins.
+	  Both playback and capture are supported.
+
 endif
diff --git a/sound/soc/atmel/Makefile b/sound/soc/atmel/Makefile
index cd87cb4bcff5..9f41bfa0fea3 100644
--- a/sound/soc/atmel/Makefile
+++ b/sound/soc/atmel/Makefile
@@ -17,6 +17,7 @@ snd-soc-sam9x5-wm8731-objs := sam9x5_wm8731.o
 snd-atmel-soc-classd-objs := atmel-classd.o
 snd-atmel-soc-pdmic-objs := atmel-pdmic.o
 snd-atmel-soc-tse850-pcm5142-objs := tse850-pcm5142.o
+snd-soc-mikroe-proto-objs := mikroe-proto.o
 
 obj-$(CONFIG_SND_AT91_SOC_SAM9G20_WM8731) += snd-soc-sam9g20-wm8731.o
 obj-$(CONFIG_SND_ATMEL_SOC_WM8904) += snd-atmel-soc-wm8904.o
@@ -24,3 +25,4 @@ obj-$(CONFIG_SND_AT91_SOC_SAM9X5_WM8731) += snd-soc-sam9x5-wm8731.o
 obj-$(CONFIG_SND_ATMEL_SOC_CLASSD) += snd-atmel-soc-classd.o
 obj-$(CONFIG_SND_ATMEL_SOC_PDMIC) += snd-atmel-soc-pdmic.o
 obj-$(CONFIG_SND_ATMEL_SOC_TSE850_PCM5142) += snd-atmel-soc-tse850-pcm5142.o
+obj-$(CONFIG_SND_SOC_MIKROE_PROTO) += snd-soc-mikroe-proto.o
diff --git a/sound/soc/atmel/mikroe-proto.c b/sound/soc/atmel/mikroe-proto.c
new file mode 100644
index 000000000000..d47aaa5bf75a
--- /dev/null
+++ b/sound/soc/atmel/mikroe-proto.c
@@ -0,0 +1,165 @@
+/*
+ * ASoC driver for PROTO AudioCODEC (with a WM8731)
+ *
+ * Author:      Florian Meier, <koalo@koalo.de>
+ *	      Copyright 2013
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#include <linux/module.h>
+#include <linux/platform_device.h>
+
+#include <sound/core.h>
+#include <sound/pcm.h>
+#include <sound/soc.h>
+#include <sound/jack.h>
+
+#include "../codecs/wm8731.h"
+
+#define XTAL_RATE 12288000	/* This is fixed on this board */
+
+static int snd_proto_init(struct snd_soc_pcm_runtime *rtd)
+{
+	struct snd_soc_card *card = rtd->card;
+	struct snd_soc_dai *codec_dai = rtd->codec_dai;
+
+	/* Set proto sysclk */
+	int ret = snd_soc_dai_set_sysclk(codec_dai, WM8731_SYSCLK_XTAL,
+					 XTAL_RATE, SND_SOC_CLOCK_IN);
+	if (ret < 0) {
+		dev_err(card->dev, "Failed to set WM8731 SYSCLK: %d\n",
+			ret);
+		return ret;
+	}
+
+	return 0;
+}
+
+static const struct snd_soc_dapm_widget snd_proto_widget[] = {
+	SND_SOC_DAPM_MIC("Microphone Jack", NULL),
+	SND_SOC_DAPM_HP("Headphone Jack", NULL),
+};
+
+static const struct snd_soc_dapm_route snd_proto_route[] = {
+	/* speaker connected to LHPOUT/RHPOUT */
+	{"Headphone Jack", NULL, "LHPOUT"},
+	{"Headphone Jack", NULL, "RHPOUT"},
+
+	/* mic is connected to Mic Jack, with WM8731 Mic Bias */
+	{"MICIN", NULL, "Mic Bias"},
+	{"Mic Bias", NULL, "Microphone Jack"},
+};
+
+/* audio machine driver */
+static struct snd_soc_card snd_proto = {
+	.name		= "snd_mikroe_proto",
+	.owner		= THIS_MODULE,
+	.dapm_widgets	= snd_proto_widget,
+	.num_dapm_widgets = ARRAY_SIZE(snd_proto_widget),
+	.dapm_routes	= snd_proto_route,
+	.num_dapm_routes = ARRAY_SIZE(snd_proto_route),
+};
+
+static int snd_proto_probe(struct platform_device *pdev)
+{
+	struct snd_soc_dai_link *dai;
+	struct device_node *np = pdev->dev.of_node;
+	struct device_node *codec_np, *cpu_np;
+	struct device_node *bitclkmaster = NULL;
+	struct device_node *framemaster = NULL;
+	unsigned int dai_fmt;
+	int ret = 0;
+
+	if (!np) {
+		dev_err(&pdev->dev, "No device node supplied\n");
+		return -EINVAL;
+	}
+
+	snd_proto.dev = &pdev->dev;
+	ret = snd_soc_of_parse_card_name(&snd_proto, "model");
+	if (ret)
+		return ret;
+
+	dai = devm_kzalloc(&pdev->dev, sizeof(*dai), GFP_KERNEL);
+	if (!dai)
+		return -ENOMEM;
+
+	snd_proto.dai_link = dai;
+	snd_proto.num_links = 1;
+
+	dai->name = "WM8731";
+	dai->stream_name = "WM8731 HiFi";
+	dai->codec_dai_name = "wm8731-hifi";
+	dai->init = &snd_proto_init;
+
+	codec_np = of_parse_phandle(np, "audio-codec", 0);
+	if (!codec_np) {
+		dev_err(&pdev->dev, "audio-codec node missing\n");
+		return -EINVAL;
+	}
+	dai->codec_of_node = codec_np;
+
+	cpu_np = of_parse_phandle(np, "i2s-controller", 0);
+	if (!cpu_np) {
+		dev_err(&pdev->dev, "i2s-controller missing\n");
+		return -EINVAL;
+	}
+	dai->cpu_of_node = cpu_np;
+	dai->platform_of_node = cpu_np;
+
+	dai_fmt = snd_soc_of_parse_daifmt(np, NULL,
+					  &bitclkmaster, &framemaster);
+	if (bitclkmaster != framemaster) {
+		dev_err(&pdev->dev, "Must be the same bitclock and frame master\n");
+		return -EINVAL;
+	}
+	if (bitclkmaster) {
+		dai_fmt &= ~SND_SOC_DAIFMT_MASTER_MASK;
+		if (codec_np == bitclkmaster)
+			dai_fmt |= SND_SOC_DAIFMT_CBM_CFM;
+		else
+			dai_fmt |= SND_SOC_DAIFMT_CBS_CFS;
+	}
+	of_node_put(bitclkmaster);
+	of_node_put(framemaster);
+	dai->dai_fmt = dai_fmt;
+
+	of_node_put(codec_np);
+	of_node_put(cpu_np);
+
+	ret = snd_soc_register_card(&snd_proto);
+	if (ret && ret != -EPROBE_DEFER)
+		dev_err(&pdev->dev,
+			"snd_soc_register_card() failed: %d\n", ret);
+
+	return ret;
+}
+
+static int snd_proto_remove(struct platform_device *pdev)
+{
+	return snd_soc_unregister_card(&snd_proto);
+}
+
+static const struct of_device_id snd_proto_of_match[] = {
+	{ .compatible = "mikroe,mikroe-proto", },
+	{},
+};
+MODULE_DEVICE_TABLE(of, snd_proto_of_match);
+
+static struct platform_driver snd_proto_driver = {
+	.driver = {
+		.name   = "snd-mikroe-proto",
+		.of_match_table = snd_proto_of_match,
+	},
+	.probe	  = snd_proto_probe,
+	.remove	 = snd_proto_remove,
+};
+
+module_platform_driver(snd_proto_driver);
+
+MODULE_AUTHOR("Florian Meier");
+MODULE_DESCRIPTION("ASoC Driver for PROTO board (WM8731)");
+MODULE_LICENSE("GPL");
-- 
2.19.0.rc1

