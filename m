Return-Path: <SRS0=t/yM=Q5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99579C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 21:18:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 528CA206B6
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 21:18:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YOjcCXFl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726012AbfBVVSy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Feb 2019 16:18:54 -0500
Received: from mail-io1-f65.google.com ([209.85.166.65]:36408 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725811AbfBVVSy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Feb 2019 16:18:54 -0500
Received: by mail-io1-f65.google.com with SMTP id r136so2931277iod.3
        for <linux-kernel@vger.kernel.org>; Fri, 22 Feb 2019 13:18:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=37BrENSbcN3MZdT61/7bLtMwX5rVcDanua85k5YJ4VI=;
        b=YOjcCXFlf8EeMiSctWepEMLjQfkWhk4qqdwgachSUjRCUj8osAo0vqxyq0niu/rt5S
         xGL00/KrH6kDSyp5qZK0bhll5AFYQeLcfCpfyZuP6UKmn13n3JVYsF4IX2f8yCSDCl20
         hQBAmyZr+fNFWvugxLaWChqDgfnqJDRTL0bRqcO2fEAL4zKP8BMk49vMgZjiVEE/Jkhu
         nsLLHVyr/55Y2/vt0lLiyfkApA35H20oN6aEDRgmE2SDriWoBxV4y/DC0Xl1xPoh1z6d
         zM5VFH5oadHMNfaaDQkErcV9JlTOzvGA4CkXi02KpQTYo7w7HQR4zWwpQ2Fo5uipA78W
         HfGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=37BrENSbcN3MZdT61/7bLtMwX5rVcDanua85k5YJ4VI=;
        b=p0Bk+NU7JAfX7uIGT275oZ4TsNiA7+qKFlTWClxiT9wufXAbPxkaYgZrMbcqjJxme4
         XoLgY8vXVoefKoo+wNnpN6hdmLxO8JPutFZkT5EnVIpxN3vCwM2J1fO3QznRbZm+acdJ
         Lj/wfunix0ouAzgd8DYAZz90wNz5arsTEDHk0tHYeGQ2oDsjf0Pnxo7Dm8s1QqaYfSbc
         00Inlq8PWJ2FD7uxsCNTkggvwhoGxBmyq6x/VZV0bvkwuvwIxxlVJGbPcytXXBIKM6nn
         tHNctQo1wag2abGnqApZ/Smg6H0UL1QEYHnahoj0gWxlcsmCDbEyodBOJVa0poG0AwpC
         +fdQ==
X-Gm-Message-State: AHQUAuaacsc+zk5jcXuYKTUy18Q9kFhThj+iYJnQTrHR3hzQ6mpMyHAt
        iXI35xxfS34nSL6POcbC5LM=
X-Google-Smtp-Source: AHgI3IaDwWD4GhHdxiQnuESxRVmbGYnQK/D6N9i8zwnh/kJ8y8EQ6QATP8r5/Vx/Mj5EmNskUVFscA==
X-Received: by 2002:a6b:5006:: with SMTP id e6mr3638625iob.132.1550870332955;
        Fri, 22 Feb 2019 13:18:52 -0800 (PST)
Received: from svens-asus.arcx.com ([184.94.50.30])
        by smtp.gmail.com with ESMTPSA id i5sm1223740itb.3.2019.02.22.13.18.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 22 Feb 2019 13:18:52 -0800 (PST)
From:   Sven Van Asbroeck <thesven73@gmail.com>
X-Google-Original-From: Sven Van Asbroeck <TheSven73@gmail.com>
To:     Russell King - ARM Linux admin <linux@armlinux.org.uk>
Cc:     David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Peter Rosin <peda@axentia.se>
Subject: Re: [PATCH 1/2] drm/i2c: tda998x: adjust CTS_N audio pre-divider calculation
Date:   Fri, 22 Feb 2019 16:18:33 -0500
Message-Id: <20190222211833.17439-1-TheSven73@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190222201641.yryc5pg6i4jkdj7d@shell.armlinux.org.uk>
References: <20190222201641.yryc5pg6i4jkdj7d@shell.armlinux.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Russell, thank you so much for your patience, help and explanation, I really
appreciate it !

On Fri, Feb 22, 2019 at 3:16 PM Russell King - ARM Linux admin <linux@armlinux.org.uk> wrote:
>
> A possible solution to that would be for hdmi-codec to default that to
> zero unless it's been definitively provided by the ASoC "card", which
> would allow the old behaviour of selecting the CTS_N M/K values
> depending on the sample width, which we know works for some people.
>

Yes, that would keep the current users in business without them having to
change anything.

Of course, poor souls like myself would have to patch, say, simple-card so we
could provide a bclk ratio in the devicetree. Which would then propagate down
to the tda998x via hdmi-codec. Which is fine by me.

Combining your two previous suggestions, I get the following. Now sample_width
can be removed from tda998x_audio_params, as it's no longer used.

Would this be a good start?

diff --git a/drivers/gpu/drm/i2c/tda998x_drv.c b/drivers/gpu/drm/i2c/tda998x_drv.c
index a7c39f39793f..a306994ecc79 100644
--- a/drivers/gpu/drm/i2c/tda998x_drv.c
+++ b/drivers/gpu/drm/i2c/tda998x_drv.c
@@ -893,19 +893,25 @@ tda998x_configure_audio(struct tda998x_priv *priv,
 		reg_write(priv, REG_MUX_AP, MUX_AP_SELECT_I2S);
 		clksel_aip = AIP_CLKSEL_AIP_I2S;
 		clksel_fs = AIP_CLKSEL_FS_ACLK;
-		switch (params->sample_width) {
+		switch (params->bclk_ratio) {
 		case 16:
+			cts_n = CTS_N_M(3) | CTS_N_K(0);
+			break;
+		case 32:
 			cts_n = CTS_N_M(3) | CTS_N_K(1);
 			break;
-		case 18:
-		case 20:
-		case 24:
+		case 48:
 			cts_n = CTS_N_M(3) | CTS_N_K(2);
 			break;
-		default:
-		case 32:
+		case 64:
 			cts_n = CTS_N_M(3) | CTS_N_K(3);
 			break;
+		case 128:
+			cts_n = CTS_N_M(0) | CTS_N_K(0);
+			break;
+		default:
+			dev_err(&priv->hdmi->dev, "unsupported I2S bclk ratio\n");
+			return -EINVAL;
 		}
 		break;
 
@@ -982,7 +988,7 @@ static int tda998x_audio_hw_params(struct device *dev, void *data,
 	struct tda998x_priv *priv = dev_get_drvdata(dev);
 	int i, ret;
 	struct tda998x_audio_params audio = {
-		.sample_width = params->sample_width,
+		.bclk_ratio = daifmt->bclk_ratio,
 		.sample_rate = params->sample_rate,
 		.cea = params->cea,
 	};
@@ -1004,6 +1010,23 @@ static int tda998x_audio_hw_params(struct device *dev, void *data,
 			if (priv->audio_port[i].format == AFMT_I2S)
 				audio.config = priv->audio_port[i].config;
 		audio.format = AFMT_I2S;
+		if (!audio.bclk_ratio) {
+			/* compatibility */
+			switch (params->sample_width) {
+			case 16:
+				audio.bclk_ratio = 32;
+				break;
+			case 18:
+			case 20:
+			case 24:
+				audio.bclk_ratio = 48;
+				break;
+			default:
+			case 32:
+				audio.bclk_ratio = 64;
+				break;
+			}
+		}
 		break;
 	case HDMI_SPDIF:
 		for (i = 0; i < ARRAY_SIZE(priv->audio_port); i++)
diff --git a/include/drm/i2c/tda998x.h b/include/drm/i2c/tda998x.h
index 3cb25ccbe5e6..039e1d9af2e0 100644
--- a/include/drm/i2c/tda998x.h
+++ b/include/drm/i2c/tda998x.h
@@ -14,7 +14,7 @@ enum {
 struct tda998x_audio_params {
 	u8 config;
 	u8 format;
-	unsigned sample_width;
+	u8 bclk_ratio;
 	unsigned sample_rate;
 	struct hdmi_audio_infoframe cea;
 	u8 status[5];
diff --git a/include/sound/hdmi-codec.h b/include/sound/hdmi-codec.h
index 9483c55f871b..0fca69880dc3 100644
--- a/include/sound/hdmi-codec.h
+++ b/include/sound/hdmi-codec.h
@@ -42,6 +42,7 @@ struct hdmi_codec_daifmt {
 	unsigned int frame_clk_inv:1;
 	unsigned int bit_clk_master:1;
 	unsigned int frame_clk_master:1;
+	unsigned int bclk_ratio;
 };
 
 /*
diff --git a/sound/soc/codecs/hdmi-codec.c b/sound/soc/codecs/hdmi-codec.c
index d00734d31e04..d82f26854c90 100644
--- a/sound/soc/codecs/hdmi-codec.c
+++ b/sound/soc/codecs/hdmi-codec.c
@@ -524,6 +524,17 @@ static int hdmi_codec_hw_params(struct snd_pcm_substream *substream,
 				       &hcp->daifmt[dai->id], &hp);
 }
 
+static int hdmi_codec_set_bclk_ratio(struct snd_soc_dai *dai,
+				     unsigned int ratio)
+{
+	struct hdmi_codec_priv *hcp = snd_soc_dai_get_drvdata(dai);
+
+	/* FIXME: some validation here would be good? */
+	hcp->daifmt[dai->id].bclk_ratio = ratio;
+
+	return 0;
+}
+
 static int hdmi_codec_set_fmt(struct snd_soc_dai *dai,
 			      unsigned int fmt)
 {
@@ -593,7 +604,11 @@ static int hdmi_codec_set_fmt(struct snd_soc_dai *dai,
 		}
 	}
 
-	hcp->daifmt[dai->id] = cf;
+	hcp->daifmt[dai->id].fmt = cf.fmt;
+	hcp->daifmt[dai->id].bit_clk_inv = cf.bit_clk_inv;
+	hcp->daifmt[dai->id].frame_clk_inv = cf.frame_clk_inv;
+	hcp->daifmt[dai->id].bit_clk_master = cf.bit_clk_master;
+	hcp->daifmt[dai->id].frame_clk_master = cf.frame_clk_master;
 
 	return ret;
 }
@@ -615,6 +630,7 @@ static const struct snd_soc_dai_ops hdmi_dai_ops = {
 	.startup	= hdmi_codec_startup,
 	.shutdown	= hdmi_codec_shutdown,
 	.hw_params	= hdmi_codec_hw_params,
+	.set_bclk_ratio	= hdmi_codec_set_bclk_ratio,
 	.set_fmt	= hdmi_codec_set_fmt,
 	.digital_mute	= hdmi_codec_digital_mute,
 };
-- 
2.17.1

