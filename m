Return-Path: <SRS0=ZOiK=MF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C172CECE560
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Sep 2018 15:37:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6AE7721479
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Sep 2018 15:37:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FqrXRmG0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6AE7721479
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726589AbeIWVf2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 23 Sep 2018 17:35:28 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:35612 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726342AbeIWVf2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Sep 2018 17:35:28 -0400
Received: by mail-io1-f67.google.com with SMTP id w11-v6so15871247iob.2;
        Sun, 23 Sep 2018 08:37:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=xF2FHSdnYQ6IpyaYZuKMhwbEWwsjIT0kM/Z/tpeuthw=;
        b=FqrXRmG0AM82aaQOsVb0eenNCTsNtBSZlXeFSb1Q9az8JEZyGQXdOTBBeeK2kKucxd
         KA6VHkemEOE87ZNS+KLUuxxS77ivxSpbX/Tb07OfNl+iPk1FdhAYuzjewDuVYUp3kbQ/
         rTTJ9ncI1WFtzn4BzYOfQjaI1l8wfiaB+A9H3m1wH8bXEksXERGJXM1Q1tua7etOAUzT
         Vf2Oee3S4V+o0CCYEgMjG08TRWJuIqpB0U2NsF6UeUoHqy+LrT/D3mW9UE/a2jk7fJse
         YsJjDEVLDTSfpPhUFltq1LvpOj8NhgnQKUumUa1OHgY3ehBAm9mbr2ofIEfm9WDS7Tkb
         cVww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=xF2FHSdnYQ6IpyaYZuKMhwbEWwsjIT0kM/Z/tpeuthw=;
        b=NCgz2BF/Gmgsph4OuMmc6LnaGWeAjuqHYi74EI0Cs2pz8pesfX0oWAxnIkwX3st1WP
         RYMo14LoWcOub2st9kImWYqY5lznHkUgS/+r2bIbkQBS3/K612ZQRZ7JHLVnk0VTIa2g
         +phbj7QetBn2FooYf1GplLR5TQhQb/XX3cOs6zC3nmopdslGFX/KbjAZIt8/eBDcDFy2
         +sd+ZNe0fV40JiVmR7K3mDF7e+nHOrA2mwfgCTHmHGigH33ZzT1TYs5JoJy6NUmgbyz6
         3a2ybNhT4U0TXtGj+Wq68BBeR5ZznkXZATy9KkVdB+eD8FAdqUHvT7joyCJjGLoAcXZu
         krng==
X-Gm-Message-State: ABuFfoj3IRRWjbnIYuQfi2tzFCjdTuYnMfaTOFgfR9VoYpunU84kOjit
        y1Zi67I7ySNUsi1Oq/5PaYt/KnjhBl2Ndw==
X-Google-Smtp-Source: ACcGV63v0WmpXCqvn1M6OqIfKWv6wZMnP5GATwXYor67sAlRefRwNwS8Z2PDPVjPMHcSDQo4Z0lOZw==
X-Received: by 2002:a6b:5903:: with SMTP id n3-v6mr5307421iob.176.1537717054514;
        Sun, 23 Sep 2018 08:37:34 -0700 (PDT)
Received: from localhost.localdomain (c-75-73-34-135.hsd1.mn.comcast.net. [75.73.34.135])
        by smtp.gmail.com with ESMTPSA id o141-v6sm2132531itg.35.2018.09.23.08.37.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 23 Sep 2018 08:37:33 -0700 (PDT)
From:   Adam Ford <aford173@gmail.com>
To:     linux-omap@vger.kernel.org
Cc:     Adam Ford <aford173@gmail.com>,
        =?UTF-8?q?Beno=C3=AEt=20Cousson?= <bcousson@baylibre.com>,
        Tony Lindgren <tony@atomide.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Russell King <linux@armlinux.org.uk>,
        Peter Ujfalusi <peter.ujfalusi@ti.com>,
        Jarkko Nikula <jarkko.nikula@bitmer.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        alsa-devel@alsa-project.org
Subject: [PATCH 3/3] ARM: OMAP2PLUS: Remove references to AM3517-EVM since it's in DT
Date:   Sun, 23 Sep 2018 10:37:18 -0500
Message-Id: <20180923153718.15095-3-aford173@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180923153718.15095-1-aford173@gmail.com>
References: <20180923153718.15095-1-aford173@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since the audio codecs used on the AM3517-EVM are now available
in device tree, and the audio driver wasn't really being used
anyway, this patch removes the remaining AM3517 legacy board
options and sound soc drivers.

Signed-off-by: Adam Ford <aford173@gmail.com>

diff --git a/arch/arm/mach-omap2/Kconfig b/arch/arm/mach-omap2/Kconfig
index 9f27b486a536..7473a88c3201 100644
--- a/arch/arm/mach-omap2/Kconfig
+++ b/arch/arm/mach-omap2/Kconfig
@@ -196,11 +196,6 @@ config MACH_OMAP2_TUSB6010
 	depends on ARCH_OMAP2 && SOC_OMAP2420
 	default y if MACH_NOKIA_N8X0
 
-config MACH_OMAP3517EVM
-	bool "OMAP3517/ AM3517 EVM board"
-	depends on ARCH_OMAP3
-	default y
-
 config MACH_OMAP3_PANDORA
 	bool "OMAP3 Pandora"
 	depends on ARCH_OMAP3
diff --git a/sound/soc/omap/Kconfig b/sound/soc/omap/Kconfig
index 6dccea6fdaeb..3d418482d242 100644
--- a/sound/soc/omap/Kconfig
+++ b/sound/soc/omap/Kconfig
@@ -78,15 +78,6 @@ config SND_OMAP_SOC_OSK5912
 	help
 	  Say Y if you want to add support for SoC audio on osk5912.
 
-config SND_OMAP_SOC_AM3517EVM
-	tristate "SoC Audio support for OMAP3517 / AM3517 EVM"
-	depends on SND_SDMA_SOC && MACH_OMAP3517EVM && I2C
-	select SND_OMAP_SOC_MCBSP
-	select SND_SOC_TLV320AIC23_I2C
-	help
-	  Say Y if you want to add support for SoC audio on the OMAP3517 / AM3517
-	  EVM.
-
 config SND_OMAP_SOC_OMAP_TWL4030
 	tristate "SoC Audio support for TI SoC based boards with twl4030 codec"
 	depends on TWL4030_CORE && SND_SDMA_SOC
diff --git a/sound/soc/omap/Makefile b/sound/soc/omap/Makefile
index 53eba3413485..af50cdd6eea9 100644
--- a/sound/soc/omap/Makefile
+++ b/sound/soc/omap/Makefile
@@ -17,7 +17,6 @@ snd-soc-n810-objs := n810.o
 snd-soc-rx51-objs := rx51.o
 snd-soc-ams-delta-objs := ams-delta.o
 snd-soc-osk5912-objs := osk5912.o
-snd-soc-am3517evm-objs := am3517evm.o
 snd-soc-omap-abe-twl6040-objs := omap-abe-twl6040.o
 snd-soc-omap-twl4030-objs := omap-twl4030.o
 snd-soc-omap3pandora-objs := omap3pandora.o
@@ -26,7 +25,6 @@ obj-$(CONFIG_SND_OMAP_SOC_N810) += snd-soc-n810.o
 obj-$(CONFIG_SND_OMAP_SOC_RX51) += snd-soc-rx51.o
 obj-$(CONFIG_SND_OMAP_SOC_AMS_DELTA) += snd-soc-ams-delta.o
 obj-$(CONFIG_SND_OMAP_SOC_OSK5912) += snd-soc-osk5912.o
-obj-$(CONFIG_SND_OMAP_SOC_AM3517EVM) += snd-soc-am3517evm.o
 obj-$(CONFIG_SND_OMAP_SOC_OMAP_ABE_TWL6040) += snd-soc-omap-abe-twl6040.o
 obj-$(CONFIG_SND_OMAP_SOC_OMAP_TWL4030) += snd-soc-omap-twl4030.o
 obj-$(CONFIG_SND_OMAP_SOC_OMAP3_PANDORA) += snd-soc-omap3pandora.o
diff --git a/sound/soc/omap/am3517evm.c b/sound/soc/omap/am3517evm.c
deleted file mode 100644
index d5651026ec10..000000000000
--- a/sound/soc/omap/am3517evm.c
+++ /dev/null
@@ -1,141 +0,0 @@
-/*
- * am3517evm.c  -- ALSA SoC support for OMAP3517 / AM3517 EVM
- *
- * Author: Anuj Aggarwal <anuj.aggarwal@ti.com>
- *
- * Based on sound/soc/omap/beagle.c by Steve Sakoman
- *
- * Copyright (C) 2009 Texas Instruments Incorporated
- *
- * This program is free software; you can redistribute it and/or modify it
- * under the terms of the GNU General Public License as published by the
- * Free Software Foundation version 2.
- *
- * This program is distributed "as is" WITHOUT ANY WARRANTY of any kind,
- * whether express or implied; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU
- * General Public License for more details.
- */
-
-#include <linux/clk.h>
-#include <linux/platform_device.h>
-#include <linux/module.h>
-#include <sound/core.h>
-#include <sound/pcm.h>
-#include <sound/soc.h>
-
-#include <asm/mach-types.h>
-#include <linux/platform_data/asoc-ti-mcbsp.h>
-
-#include "omap-mcbsp.h"
-
-#include "../codecs/tlv320aic23.h"
-
-#define CODEC_CLOCK 	12000000
-
-static int am3517evm_hw_params(struct snd_pcm_substream *substream,
-	struct snd_pcm_hw_params *params)
-{
-	struct snd_soc_pcm_runtime *rtd = substream->private_data;
-	struct snd_soc_dai *codec_dai = rtd->codec_dai;
-	int ret;
-
-	/* Set the codec system clock for DAC and ADC */
-	ret = snd_soc_dai_set_sysclk(codec_dai, 0,
-			CODEC_CLOCK, SND_SOC_CLOCK_IN);
-	if (ret < 0)
-		printk(KERN_ERR "can't set codec system clock\n");
-
-	return ret;
-}
-
-static const struct snd_soc_ops am3517evm_ops = {
-	.hw_params = am3517evm_hw_params,
-};
-
-/* am3517evm machine dapm widgets */
-static const struct snd_soc_dapm_widget tlv320aic23_dapm_widgets[] = {
-	SND_SOC_DAPM_HP("Line Out", NULL),
-	SND_SOC_DAPM_LINE("Line In", NULL),
-	SND_SOC_DAPM_MIC("Mic In", NULL),
-};
-
-static const struct snd_soc_dapm_route audio_map[] = {
-	/* Line Out connected to LLOUT, RLOUT */
-	{"Line Out", NULL, "LOUT"},
-	{"Line Out", NULL, "ROUT"},
-
-	{"LLINEIN", NULL, "Line In"},
-	{"RLINEIN", NULL, "Line In"},
-
-	{"MICIN", NULL, "Mic In"},
-};
-
-/* Digital audio interface glue - connects codec <--> CPU */
-static struct snd_soc_dai_link am3517evm_dai = {
-	.name = "TLV320AIC23",
-	.stream_name = "AIC23",
-	.cpu_dai_name = "omap-mcbsp.1",
-	.codec_dai_name = "tlv320aic23-hifi",
-	.platform_name = "omap-mcbsp.1",
-	.codec_name = "tlv320aic23-codec.2-001a",
-	.dai_fmt = SND_SOC_DAIFMT_DSP_B | SND_SOC_DAIFMT_NB_NF |
-		   SND_SOC_DAIFMT_CBM_CFM,
-	.ops = &am3517evm_ops,
-};
-
-/* Audio machine driver */
-static struct snd_soc_card snd_soc_am3517evm = {
-	.name = "am3517evm",
-	.owner = THIS_MODULE,
-	.dai_link = &am3517evm_dai,
-	.num_links = 1,
-
-	.dapm_widgets = tlv320aic23_dapm_widgets,
-	.num_dapm_widgets = ARRAY_SIZE(tlv320aic23_dapm_widgets),
-	.dapm_routes = audio_map,
-	.num_dapm_routes = ARRAY_SIZE(audio_map),
-};
-
-static struct platform_device *am3517evm_snd_device;
-
-static int __init am3517evm_soc_init(void)
-{
-	int ret;
-
-	if (!machine_is_omap3517evm())
-		return -ENODEV;
-	pr_info("OMAP3517 / AM3517 EVM SoC init\n");
-
-	am3517evm_snd_device = platform_device_alloc("soc-audio", -1);
-	if (!am3517evm_snd_device) {
-		printk(KERN_ERR "Platform device allocation failed\n");
-		return -ENOMEM;
-	}
-
-	platform_set_drvdata(am3517evm_snd_device, &snd_soc_am3517evm);
-
-	ret = platform_device_add(am3517evm_snd_device);
-	if (ret)
-		goto err1;
-
-	return 0;
-
-err1:
-	printk(KERN_ERR "Unable to add platform device\n");
-	platform_device_put(am3517evm_snd_device);
-
-	return ret;
-}
-
-static void __exit am3517evm_soc_exit(void)
-{
-	platform_device_unregister(am3517evm_snd_device);
-}
-
-module_init(am3517evm_soc_init);
-module_exit(am3517evm_soc_exit);
-
-MODULE_AUTHOR("Anuj Aggarwal <anuj.aggarwal@ti.com>");
-MODULE_DESCRIPTION("ALSA SoC OMAP3517 / AM3517 EVM");
-MODULE_LICENSE("GPL v2");
-- 
2.17.1

