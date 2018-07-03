Return-Path: <SRS0=3XDn=JT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 754E5C6778C
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 15:06:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2B6E520BED
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 15:06:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="S70QXul1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2B6E520BED
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933436AbeGCPGi (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Jul 2018 11:06:38 -0400
Received: from mail-wr0-f194.google.com ([209.85.128.194]:37600 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932935AbeGCPGK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jul 2018 11:06:10 -0400
Received: by mail-wr0-f194.google.com with SMTP id q10-v6so2325519wrd.4
        for <linux-kernel@vger.kernel.org>; Tue, 03 Jul 2018 08:06:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=BfIwYZonNLacADKQn94fU9JnfG5VCfHAstjGwmYSXBI=;
        b=S70QXul1/iS8qluhhbVdwHAXRplSDvFB8j/9qpAIZjJzcBQS0Odq5L7LKHrKo0CWWU
         jD6SDDJUIFHBPwBBpRu7kI/+BNcXghXY6mHm5hEveF2eoSL+iD76wfvXuhOYpNZuZUPn
         xQl21IX9xXDVzrtCtTl0kJIjaobHQC9Wb4UUDkON77LqaFxhwaCHFN34mdFxqyj6rZIY
         /1KzlYU5/1RqDkL+z6LqufD7KjMvg4s6xpyQ0fn05YIwAH46P8jAznyr1GEstocXLFte
         KzLjcasJQ+f7CjymHitlH+XzNyRMIl6920nZvCI2ST0//jzDx806AMAQa0V77jDzaTTR
         PvnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=BfIwYZonNLacADKQn94fU9JnfG5VCfHAstjGwmYSXBI=;
        b=IvihN+CvJPRcvmu/skyYWwfTBKpSRl7K9Kjt0cai2yVd09dGcf95ydVTWDZXuNsmn7
         s2t1xb2VI97+4qJiTW7rdtLdG1WhVMdMEhQuB3mvpU7T6PU2hiIhvJaISbl0sDXia4kh
         NcXogZWHPz06Mw5l2vt9jK1LRMyHz8gCDOtQxQtjfFG1s/tf2dtUYvQs54CziK0+wjBL
         THDshpNWba1qp7Gcjs7JQYsG1iJ+VUHNjQJgzo6HscQ/KOXaQX4xa6FESk0fnAXskaJ0
         gc3XNs3/w3ht/OkoJgr9KAN+JUH6xnQYNwQrgqgcDUMeZeuvw8P8Pi6eWQtXauQXuG+c
         l1YA==
X-Gm-Message-State: APt69E0hPVDcgWTQyJ1E1z3DwNcZUa+Gq4iecEAyvhaQz9QWBh5qAM8s
        kj21jiACs8L6xUTCCV1Y1HATCw==
X-Google-Smtp-Source: AAOMgpe46+vYWYPLjjEwTj4G0GhTyAS7d2HsLtW1Rm0zf8wKgUSpZvNph66eZayaCF+0mg/cWtkPfw==
X-Received: by 2002:adf:9102:: with SMTP id j2-v6mr23831577wrj.57.1530630369173;
        Tue, 03 Jul 2018 08:06:09 -0700 (PDT)
Received: from boomer.baylibre.local ([90.63.244.31])
        by smtp.googlemail.com with ESMTPSA id x16-v6sm2905842wme.12.2018.07.03.08.06.07
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 03 Jul 2018 08:06:08 -0700 (PDT)
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>
Cc:     Jerome Brunet <jbrunet@baylibre.com>, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 3/3] ASoC: es7134: add support for the es7154
Date:   Tue,  3 Jul 2018 17:06:00 +0200
Message-Id: <20180703150600.17697-4-jbrunet@baylibre.com>
X-Mailer: git-send-email 2.14.4
In-Reply-To: <20180703150600.17697-1-jbrunet@baylibre.com>
References: <20180703150600.17697-1-jbrunet@baylibre.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for the es7154 which is basically an es7134 with an
embedded power amplifier and lower maximum sample rate

Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
---
 sound/soc/codecs/es7134.c | 60 ++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 59 insertions(+), 1 deletion(-)

diff --git a/sound/soc/codecs/es7134.c b/sound/soc/codecs/es7134.c
index 80f2936cefed..6d7bca7b78ca 100644
--- a/sound/soc/codecs/es7134.c
+++ b/sound/soc/codecs/es7134.c
@@ -33,6 +33,7 @@ struct es7134_clock_mode {
 };
 
 struct es7134_chip {
+	struct snd_soc_dai_driver *dai_drv;
 	const struct es7134_clock_mode *modes;
 	unsigned int mode_num;
 	const struct snd_soc_dapm_widget *extra_widgets;
@@ -196,6 +197,7 @@ static const struct snd_soc_dapm_route es7134_extra_routes[] = {
 };
 
 static const struct es7134_chip es7134_chip = {
+	.dai_drv = &es7134_dai,
 	.modes = es7134_modes,
 	.mode_num = ARRAY_SIZE(es7134_modes),
 	.extra_routes = es7134_extra_routes,
@@ -227,6 +229,61 @@ static const struct snd_soc_component_driver es7134_component_driver = {
 	.non_legacy_dai_naming	= 1,
 };
 
+static struct snd_soc_dai_driver es7154_dai = {
+	.name = "es7154-hifi",
+	.playback = {
+		.stream_name = "Playback",
+		.channels_min = 2,
+		.channels_max = 2,
+		.rates = (SNDRV_PCM_RATE_8000_48000 |
+			  SNDRV_PCM_RATE_88200      |
+			  SNDRV_PCM_RATE_96000),
+		.formats = (SNDRV_PCM_FMTBIT_S16_LE  |
+			    SNDRV_PCM_FMTBIT_S18_3LE |
+			    SNDRV_PCM_FMTBIT_S20_3LE |
+			    SNDRV_PCM_FMTBIT_S24_3LE |
+			    SNDRV_PCM_FMTBIT_S24_LE),
+	},
+	.ops = &es7134_dai_ops,
+};
+
+static const struct es7134_clock_mode es7154_modes[] = {
+	{
+		/* Single speed mode */
+		.rate_min = 8000,
+		.rate_max = 50000,
+		.mclk_fs = (unsigned int[]) { 32, 64, 128, 192, 256,
+					      384, 512, 768, 1024 },
+		.mclk_fs_num = 9,
+	}, {
+		/* Double speed mode */
+		.rate_min = 84000,
+		.rate_max = 100000,
+		.mclk_fs = (unsigned int[]) { 128, 192, 256, 384, 512,
+					      768, 1024},
+		.mclk_fs_num = 7,
+	}
+};
+
+/* Es7154 has a separate supply for digital I/O  */
+static const struct snd_soc_dapm_widget es7154_extra_widgets[] = {
+	SND_SOC_DAPM_REGULATOR_SUPPLY("PVDD", 0, 0),
+};
+
+static const struct snd_soc_dapm_route es7154_extra_routes[] = {
+	{ "Playback", NULL, "PVDD", }
+};
+
+static const struct es7134_chip es7154_chip = {
+	.dai_drv = &es7154_dai,
+	.modes = es7154_modes,
+	.mode_num = ARRAY_SIZE(es7154_modes),
+	.extra_routes = es7154_extra_routes,
+	.extra_route_num = ARRAY_SIZE(es7154_extra_routes),
+	.extra_widgets = es7154_extra_widgets,
+	.extra_widget_num = ARRAY_SIZE(es7154_extra_widgets),
+};
+
 static int es7134_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
@@ -245,13 +302,14 @@ static int es7134_probe(struct platform_device *pdev)
 
 	return devm_snd_soc_register_component(&pdev->dev,
 				      &es7134_component_driver,
-				      &es7134_dai, 1);
+				      priv->chip->dai_drv, 1);
 }
 
 #ifdef CONFIG_OF
 static const struct of_device_id es7134_ids[] = {
 	{ .compatible = "everest,es7134", .data = &es7134_chip },
 	{ .compatible = "everest,es7144", .data = &es7134_chip },
+	{ .compatible = "everest,es7154", .data = &es7154_chip },
 	{ }
 };
 MODULE_DEVICE_TABLE(of, es7134_ids);
-- 
2.14.4

