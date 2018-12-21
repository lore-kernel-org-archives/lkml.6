Return-Path: <SRS0=OLKc=O6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FROM,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB6B0C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 15:21:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A669E217D9
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 15:21:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ut8/sDmI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390989AbeLUPVX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Dec 2018 10:21:23 -0500
Received: from mail-lf1-f67.google.com ([209.85.167.67]:38049 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390960AbeLUPVT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Dec 2018 10:21:19 -0500
Received: by mail-lf1-f67.google.com with SMTP id p86so4153637lfg.5
        for <linux-kernel@vger.kernel.org>; Fri, 21 Dec 2018 07:21:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=i6JjiPCmTaf5vd0jGiuaXaqrB7/Dt9QwI5wneEqTlYM=;
        b=Ut8/sDmI1j0vvoKRrWJL7UzivFbr1XbcS7YKMQ4aYVmr+Pa8rv6F5mz8NUVYff3PeK
         ve2X4eSsZ0DgPHcr78Jm35e5bhdQ5aZj1mNPMC1p+2iDvNj+WBjTjiutv9RL/oqkg8q7
         PQOrRTZ4q4a2goVBcObxEXwR4zDyCUD0FyOye0TaYwTn+uJFg+3F3cDZeRqZPDTnGsJz
         6cHwcG6oX9SbwwyWpabEuMk4YWp6TX8WCjmMt5gW+vfiDmlX/mngFwHrbEzdVHpwh3Ik
         wH0newTL117fZE2cwy3s2c2FIHsDa7AkUCX8F8NwVON6wXTwQvprponSQTqOQbsfLSy9
         52Qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=i6JjiPCmTaf5vd0jGiuaXaqrB7/Dt9QwI5wneEqTlYM=;
        b=UKWar+JvGUapvlBNVmj9xaRvRAJjinFaE39Efkmmmn62CQP6sTQTXoj0R3OvOCWu9m
         NoG+IHfiKLd3uVFdYPA50JvbC2EC8hMCZS1zP813loqAOuG9uCkQ7HH7E7tJKqRvkSCE
         yEPTaUYz05nBJPTtxIZ71f1nDDxxrmo1B++WI/8iQUaXrxaHSbc11uW7qnzGse8JeMYA
         1HUsW+c2J7+xLHLKoi7+Tppcmg34BETvQrCK/Q35eeyQFAYzl2DY3YoQjm2r1yISvOL3
         0KH2WrxZwuokpLIxhr2d+THvaEEeYtkaavIkj4RaZyt2sK38ki/WVYhJ/p/2NzeJiFEd
         +gTw==
X-Gm-Message-State: AA+aEWag1D6vf4im+D0yh713gJnSTeZAfEC/h1My98NQEF3CMSuGloyt
        F2Nz4aGXVQOIkDzC0TdZbMo=
X-Google-Smtp-Source: AFSGD/UjWM9VvfBv0ChRjPCyCwOoYn6QOxMuTLf1obp3YgtDLnXrEP1ss8UbMCseDn654FRbiUOkAA==
X-Received: by 2002:a19:d5:: with SMTP id 204mr1587680lfa.116.1545405676440;
        Fri, 21 Dec 2018 07:21:16 -0800 (PST)
Received: from localhost.localdomain (c90-142-43-138.bredband.comhem.se. [90.142.43.138])
        by smtp.gmail.com with ESMTPSA id q30sm5005601lfi.94.2018.12.21.07.21.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 21 Dec 2018 07:21:15 -0800 (PST)
From:   codekipper@gmail.com
To:     maxime.ripard@free-electrons.com, wens@csie.org,
        linux-sunxi@googlegroups.com
Cc:     linux-arm-kernel@lists.infradead.org, lgirdwood@gmail.com,
        broonie@kernel.org, linux-kernel@vger.kernel.org,
        alsa-devel@alsa-project.org, be17068@iperbole.bo.it,
        Marcus Cooper <codekipper@gmail.com>
Subject: [PATCH v3 3/9] ASoc: sun4i-i2s: Add 20, 24 and 32 bit support
Date:   Fri, 21 Dec 2018 16:21:04 +0100
Message-Id: <20181221152110.17982-4-codekipper@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20181221152110.17982-1-codekipper@gmail.com>
References: <20181221152110.17982-1-codekipper@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Marcus Cooper <codekipper@gmail.com>

Extend the functionality of the driver to include support of 20 and
24 bits per sample for the earlier SoCs.

Newer SoCs can also handle 32bit samples.

Signed-off-by: Marcus Cooper <codekipper@gmail.com>
---
 sound/soc/sunxi/sun4i-i2s.c | 41 ++++++++++++++++++++++++++++++++++---
 1 file changed, 38 insertions(+), 3 deletions(-)

diff --git a/sound/soc/sunxi/sun4i-i2s.c b/sound/soc/sunxi/sun4i-i2s.c
index 80bf29e0cc86..adb988ae9ac5 100644
--- a/sound/soc/sunxi/sun4i-i2s.c
+++ b/sound/soc/sunxi/sun4i-i2s.c
@@ -399,6 +399,11 @@ static int sun4i_i2s_hw_params(struct snd_pcm_substream *substream,
 	case 16:
 		width = DMA_SLAVE_BUSWIDTH_2_BYTES;
 		break;
+	case 20:
+	case 24:
+	case 32:
+		width = DMA_SLAVE_BUSWIDTH_4_BYTES;
+		break;
 	default:
 		dev_err(dai->dev, "Unsupported physical sample width: %d\n",
 			params_physical_width(params));
@@ -411,7 +416,18 @@ static int sun4i_i2s_hw_params(struct snd_pcm_substream *substream,
 		sr = 0;
 		wss = 0;
 		break;
-
+	case 20:
+		sr = 1;
+		wss = 1;
+		break;
+	case 24:
+		sr = 2;
+		wss = 2;
+		break;
+	case 32:
+		sr = 4;
+		wss = 4;
+		break;
 	default:
 		dev_err(dai->dev, "Unsupported sample width: %d\n",
 			params_width(params));
@@ -687,6 +703,13 @@ static int sun4i_i2s_dai_probe(struct snd_soc_dai *dai)
 	return 0;
 }
 
+#define SUN4I_FORMATS	(SNDRV_PCM_FMTBIT_S16_LE | \
+			 SNDRV_PCM_FMTBIT_S20_3LE | \
+			 SNDRV_PCM_FMTBIT_S24_LE)
+
+#define SUN8I_FORMATS	(SUN4I_FORMATS | \
+			 SNDRV_PCM_FMTBIT_S32_LE)
+
 static struct snd_soc_dai_driver sun4i_i2s_dai = {
 	.probe = sun4i_i2s_dai_probe,
 	.capture = {
@@ -694,14 +717,14 @@ static struct snd_soc_dai_driver sun4i_i2s_dai = {
 		.channels_min = 2,
 		.channels_max = 2,
 		.rates = SNDRV_PCM_RATE_8000_192000,
-		.formats = SNDRV_PCM_FMTBIT_S16_LE,
+		.formats = SUN4I_FORMATS,
 	},
 	.playback = {
 		.stream_name = "Playback",
 		.channels_min = 2,
 		.channels_max = 2,
 		.rates = SNDRV_PCM_RATE_8000_192000,
-		.formats = SNDRV_PCM_FMTBIT_S16_LE,
+		.formats = SUN4I_FORMATS,
 	},
 	.ops = &sun4i_i2s_dai_ops,
 	.symmetric_rates = 1,
@@ -1106,6 +1129,18 @@ static int sun4i_i2s_probe(struct platform_device *pdev)
 	i2s->capture_dma_data.addr = res->start + SUN4I_I2S_FIFO_RX_REG;
 	i2s->capture_dma_data.maxburst = 8;
 
+	soc_dai = devm_kmemdup(&pdev->dev, &sun4i_i2s_dai,
+			       sizeof(*soc_dai), GFP_KERNEL);
+	if (!soc_dai) {
+		ret = -ENOMEM;
+		goto err_pm_disable;
+	}
+
+	if (i2s->variant->has_fmt_set_lrck_period) {
+		soc_dai->playback.formats = SUN8I_FORMATS;
+		soc_dai->capture.formats = SUN8I_FORMATS;
+	}
+
 	pm_runtime_enable(&pdev->dev);
 	if (!pm_runtime_enabled(&pdev->dev)) {
 		ret = sun4i_i2s_runtime_resume(&pdev->dev);
-- 
2.20.1

