Return-Path: <SRS0=3XDn=JT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47330C6778A
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 15:06:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 037EB20BED
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 15:06:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="dJCXHP/Q"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 037EB20BED
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933168AbeGCPGM (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Jul 2018 11:06:12 -0400
Received: from mail-wr0-f195.google.com ([209.85.128.195]:45518 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932234AbeGCPGJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jul 2018 11:06:09 -0400
Received: by mail-wr0-f195.google.com with SMTP id u7-v6so2319614wrn.12
        for <linux-kernel@vger.kernel.org>; Tue, 03 Jul 2018 08:06:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=+/7wjwDfXPMTHStIdXMtbrV9zCpsB3mZqK/ZsgqQh3Q=;
        b=dJCXHP/Q+L3RPljhd1/dJ3VmKgVMBOSkVkeK5/XblRNxmsm7EDDk8FEGhZjmloj/EN
         PmM20WUPwEu/Zm4jJfCFPLq8cRMGc6NLre2JQSO3mXFDvalg5/tMImXQhCbp4J2kyTqc
         xp2nPgbx5PYttPCjhL3qCDLcVkWEp3V5M+bE2gF/x/bMPgvekIa0S2SAkg9nahudgqbm
         PiJ+k/+KZd6x2IsMwHLW5fctm798WGP6oQWHWGmTAha1ZJgQDZecLNpVx2y+530OkUs9
         dx2aEOh65XB+VEY00gDvaj5RRoTZGj56U725z5W03Bk28Tuxv4s7llh/yc5vQxTOs+3p
         thZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=+/7wjwDfXPMTHStIdXMtbrV9zCpsB3mZqK/ZsgqQh3Q=;
        b=tlLUHciX4y0mWrZXQsLtNs3Iy5HrKZdw1dmpHUBNLvQHvcdlzfn0kxmMly2yHCG3ta
         cN9KdcsjcQj5cVPE3SvyZiid9K5oNVHNuXMLakIe3RvSPybMIivhihOMLDQeZuCcWqij
         Ql65ppJHHlLujJMR5K0yk3AJPrI6/yM09CcgL86h7hWvBNJ/DVXQJUV5xBn0j9au1dI7
         ErQbU3hoA4itGoPgpwy9S1y7dG8C8vHvY8yvEDzYz//IxXZ9sBJIhDinsnJ1XhMWTNNm
         UvxqA1JQhQ0FSEeA0mRmst2otfQI3tjUZXDlQCHxkVwK8fyD/eMvgQjVgfbB1RY1qktQ
         d/LQ==
X-Gm-Message-State: APt69E3edq2F/iI0FifJx1tUoXjyFwRfi15Sd5gRTV6wmHueeCI0NnHN
        CfkJB+hc1uQbxk4TAOtpAAiNJA==
X-Google-Smtp-Source: AAOMgpdWoRVnwz1pyunnMBX5L9RWLhij/Qsdhzv54ArpJmVR8pnIiuACwS6RCw6z6ynb38i4FGkhTA==
X-Received: by 2002:adf:a285:: with SMTP id s5-v6mr22240974wra.114.1530630367915;
        Tue, 03 Jul 2018 08:06:07 -0700 (PDT)
Received: from boomer.baylibre.local ([90.63.244.31])
        by smtp.googlemail.com with ESMTPSA id x16-v6sm2905842wme.12.2018.07.03.08.06.06
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 03 Jul 2018 08:06:07 -0700 (PDT)
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>
Cc:     Jerome Brunet <jbrunet@baylibre.com>, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/3] ASoC: es7134: correct required power supplies
Date:   Tue,  3 Jul 2018 17:05:59 +0200
Message-Id: <20180703150600.17697-3-jbrunet@baylibre.com>
X-Mailer: git-send-email 2.14.4
In-Reply-To: <20180703150600.17697-1-jbrunet@baylibre.com>
References: <20180703150600.17697-1-jbrunet@baylibre.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Drop AVDD in favor of PVDD to match the names used in the datasheet
and only claim PVDD on the es7154. The es7134 and es7144 don't have
a separate supply for the digital I/O.

Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
---
 sound/soc/codecs/es7134.c | 44 +++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 41 insertions(+), 3 deletions(-)

diff --git a/sound/soc/codecs/es7134.c b/sound/soc/codecs/es7134.c
index 5ad59c38fed1..80f2936cefed 100644
--- a/sound/soc/codecs/es7134.c
+++ b/sound/soc/codecs/es7134.c
@@ -35,6 +35,10 @@ struct es7134_clock_mode {
 struct es7134_chip {
 	const struct es7134_clock_mode *modes;
 	unsigned int mode_num;
+	const struct snd_soc_dapm_widget *extra_widgets;
+	unsigned int extra_widget_num;
+	const struct snd_soc_dapm_route *extra_routes;
+	unsigned int extra_route_num;
 };
 
 struct es7134_data {
@@ -110,6 +114,34 @@ static int es7134_set_fmt(struct snd_soc_dai *codec_dai, unsigned int fmt)
 	return 0;
 }
 
+static int es7134_component_probe(struct snd_soc_component *c)
+{
+	struct snd_soc_dapm_context *dapm = snd_soc_component_get_dapm(c);
+	struct es7134_data *priv = snd_soc_component_get_drvdata(c);
+	const struct es7134_chip *chip = priv->chip;
+	int ret;
+
+	if (chip->extra_widget_num) {
+		ret = snd_soc_dapm_new_controls(dapm, chip->extra_widgets,
+						chip->extra_widget_num);
+		if (ret) {
+			dev_err(c->dev, "failed to add extra widgets\n");
+			return ret;
+		}
+	}
+
+	if (chip->extra_route_num) {
+		ret = snd_soc_dapm_add_routes(dapm, chip->extra_routes,
+					      chip->extra_route_num);
+		if (ret) {
+			dev_err(c->dev, "failed to add extra routes\n");
+			return ret;
+		}
+	}
+
+	return 0;
+}
+
 static const struct snd_soc_dai_ops es7134_dai_ops = {
 	.set_fmt	= es7134_set_fmt,
 	.hw_params	= es7134_hw_params,
@@ -158,9 +190,16 @@ static const struct es7134_clock_mode es7134_modes[] = {
 	},
 };
 
+/* Digital I/O are also supplied by VDD on the es7134 */
+static const struct snd_soc_dapm_route es7134_extra_routes[] = {
+	{ "Playback", NULL, "VDD", }
+};
+
 static const struct es7134_chip es7134_chip = {
 	.modes = es7134_modes,
 	.mode_num = ARRAY_SIZE(es7134_modes),
+	.extra_routes = es7134_extra_routes,
+	.extra_route_num = ARRAY_SIZE(es7134_extra_routes),
 };
 
 static const struct snd_soc_dapm_widget es7134_dapm_widgets[] = {
@@ -168,17 +207,16 @@ static const struct snd_soc_dapm_widget es7134_dapm_widgets[] = {
 	SND_SOC_DAPM_OUTPUT("AOUTR"),
 	SND_SOC_DAPM_DAC("DAC", "Playback", SND_SOC_NOPM, 0, 0),
 	SND_SOC_DAPM_REGULATOR_SUPPLY("VDD", 0, 0),
-	SND_SOC_DAPM_REGULATOR_SUPPLY("AVDD", 0, 0),
 };
 
 static const struct snd_soc_dapm_route es7134_dapm_routes[] = {
 	{ "AOUTL", NULL, "DAC" },
 	{ "AOUTR", NULL, "DAC" },
-	{ "Playback", NULL, "VDD" },
-	{ "DAC", NULL, "AVDD" },
+	{ "DAC", NULL, "VDD" },
 };
 
 static const struct snd_soc_component_driver es7134_component_driver = {
+	.probe			= es7134_component_probe,
 	.dapm_widgets		= es7134_dapm_widgets,
 	.num_dapm_widgets	= ARRAY_SIZE(es7134_dapm_widgets),
 	.dapm_routes		= es7134_dapm_routes,
-- 
2.14.4

