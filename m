Return-Path: <SRS0=sqHT=JP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 382E3C43144
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 15:10:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DEF8828011
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 15:10:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="i50s7zXT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DEF8828011
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935647AbeF2PKD (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Jun 2018 11:10:03 -0400
Received: from mail-wr0-f195.google.com ([209.85.128.195]:42085 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932238AbeF2PJh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jun 2018 11:09:37 -0400
Received: by mail-wr0-f195.google.com with SMTP id p1-v6so9183410wrs.9
        for <linux-kernel@vger.kernel.org>; Fri, 29 Jun 2018 08:09:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=y3QIPNk+8o4XPNTxUwkKt4OvhsvkV40uuOIrtve2kJk=;
        b=i50s7zXTWPJyzh8SG7nuc6bx2kvkGL3Fi2T8Y2YP9bKl35QEoFC4n8meOQgolcXGle
         XwpQWWa5QzmFhFNle5qmWSt3g4l9hbS/PGGPXZ9PnFVlT/v+b5ymsU54OEJKKW8GSNDX
         8kWo3IAoxZ8sa3HnigZb0IWZaPw6wTzzWadPfYaId3p3+IcAsA5GBy88Jx0biygjVt7E
         Hbgrz/wu18w787Q93w0R2VhNbds66FuaojIoNLAr3i32zmyyK87j6E+k9RCelvJSZWTX
         mUuijE3j1KD/gPSnsF9dgzSk9F/gvLEdwI5rTvQaJZYDQUEeKHoeDxvoXgR3CtB2GEg1
         5Mhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=y3QIPNk+8o4XPNTxUwkKt4OvhsvkV40uuOIrtve2kJk=;
        b=lJoCTqtcakIOOqBXuO8ENwrkJPhpUUolMaQKXZUs1IOVPnK9SP+dWjBEQDhEiRXOzt
         Wp2vAYcuIlNuqY002JNrAJ/FJ63TDupCczGbscsSLLtG6h2guqwWPuGrhyABPXBapWTc
         JbA3pIRpaDcvq8oQO//aEn87RZ5ppnaD4auAp8GS9Q/XcMmLf2Q41INN0gp8h9d46dsP
         Ii2Nit5LXELE9pS9pB4b2AM/Y5KtrqwZEWjFMccaRNLfKt6wDxr11k9grBDitGr0eQ8t
         D13BBmqNxGKOk/vA84pIcWx7uqwwTZjepepnhejYCiAb9q0ynwdVTUVyco9Yh22yB82D
         Z3BA==
X-Gm-Message-State: APt69E05a+VbPQ5k9P6682DQKLzackjjqBAXwIPPwEXR5TZNuIIXQGfa
        acEZnXpIg750HWdlDugd0a5KvAGK
X-Google-Smtp-Source: AAOMgpdcB4gw1PMFLX/Au6E3Sv5MTaeWvS4Dpnsy86eQ/+9Ikm7jAlTFjYDdb4ITGrXEdOusAMFRvw==
X-Received: by 2002:adf:f246:: with SMTP id b6-v6mr12301865wrp.235.1530284976310;
        Fri, 29 Jun 2018 08:09:36 -0700 (PDT)
Received: from localhost.localdomain (uluru.liltaz.com. [163.172.81.188])
        by smtp.googlemail.com with ESMTPSA id b6-v6sm11944222wro.52.2018.06.29.08.09.35
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 29 Jun 2018 08:09:35 -0700 (PDT)
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>
Cc:     Jerome Brunet <jbrunet@baylibre.com>, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 5/5] ASoC: es7134: add support for the es7154
Date:   Fri, 29 Jun 2018 17:09:24 +0200
Message-Id: <20180629150924.18197-6-jbrunet@baylibre.com>
X-Mailer: git-send-email 2.14.4
In-Reply-To: <20180629150924.18197-1-jbrunet@baylibre.com>
References: <20180629150924.18197-1-jbrunet@baylibre.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for the es7154 which is basically an es7134 with an
embedded power amplifier and lower maximum sample rate

Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
---
 sound/soc/codecs/es7134.c | 47 ++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 46 insertions(+), 1 deletion(-)

diff --git a/sound/soc/codecs/es7134.c b/sound/soc/codecs/es7134.c
index 5ad59c38fed1..935bed820ba5 100644
--- a/sound/soc/codecs/es7134.c
+++ b/sound/soc/codecs/es7134.c
@@ -33,6 +33,7 @@ struct es7134_clock_mode {
 };
 
 struct es7134_chip {
+	struct snd_soc_dai_driver *dai_drv;
 	const struct es7134_clock_mode *modes;
 	unsigned int mode_num;
 };
@@ -159,6 +160,7 @@ static const struct es7134_clock_mode es7134_modes[] = {
 };
 
 static const struct es7134_chip es7134_chip = {
+	.dai_drv = &es7134_dai,
 	.modes = es7134_modes,
 	.mode_num = ARRAY_SIZE(es7134_modes),
 };
@@ -189,6 +191,48 @@ static const struct snd_soc_component_driver es7134_component_driver = {
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
+static const struct es7134_chip es7154_chip = {
+	.dai_drv = &es7154_dai,
+	.modes = es7154_modes,
+	.mode_num = ARRAY_SIZE(es7154_modes),
+};
+
 static int es7134_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
@@ -207,13 +251,14 @@ static int es7134_probe(struct platform_device *pdev)
 
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

