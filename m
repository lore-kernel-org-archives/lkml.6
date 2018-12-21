Return-Path: <SRS0=OLKc=O6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FROM,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0104C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 15:22:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6EA79218D3
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 15:22:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U6qr585s"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391015AbeLUPVa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Dec 2018 10:21:30 -0500
Received: from mail-lf1-f67.google.com ([209.85.167.67]:41532 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390988AbeLUPVY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Dec 2018 10:21:24 -0500
Received: by mail-lf1-f67.google.com with SMTP id c16so4157150lfj.8
        for <linux-kernel@vger.kernel.org>; Fri, 21 Dec 2018 07:21:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=WaF8AFfF7zchnr6jMRHrk5C2QYC8GMssuw/nTJO62Vo=;
        b=U6qr585sBxSIfLRDrNicqGEN9uOJKrt4fr8LvaAGKDSD3SyvethIWfaIaYiDajbcH2
         3klFQ8CEJz3MgAXjRXbMvvxMBzbTYrVW/7C283WJG5nE9fMszouSKk61cXVdWlq/XRKg
         AXzC99PWUUDJ6AZpqCDvtPLVyBamtqWAu3Hea6ZH0ALIZHFpLWUgtsZYkxRGakzEg748
         I/2uMhp8fFlizqFGJAyTy6tAbd4JFrL2c6XnXq1zd03R/KNm5O1kBxhjm8qupywToYYr
         KxVTBH4VZAgM7+YaNPmveC3UxJXfrzPrMu+k7GP6usCZ3qRN7cr4ngLcMI/uS971ae1l
         KBuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=WaF8AFfF7zchnr6jMRHrk5C2QYC8GMssuw/nTJO62Vo=;
        b=WJ/Td0+zeV21bBuU6ks7jlBBPrFDNWTiXSIrGSJTZ3HafUN7jrVA0g61xQlmq9t7Sk
         0zxxz665tjE2qFtoeJKL4o1OB6a00bnl/vTMfqZZeEeJZF0lhSdr9mIhymoFxXZXUq0H
         YsTS26+Vx0Yr+MfrTA78HjAz5yfvs0zj5hM9bm5ghvz8zLrgpfkl/9mjT1R/3xIV12OV
         qIQsnUKF+wA1kWbi+k2Q5tCYpQrX7oACQB85uhV+IJaEn7el5LMWQS7kKiggb6M4YTED
         Reaq3Fw5s1TkUa6rj3vErRB7slwViqjC5s7qofKOVNlJ9tQXXkyt/J3TefltUaL36Ep0
         guEA==
X-Gm-Message-State: AA+aEWb8G6/Uu7Hj9E7pKILbQYvUvd9GiLIvvMVRaPxXPFdaqANAK8JF
        AGTI0K5T8btdSm/oVlMOQ6c=
X-Google-Smtp-Source: AFSGD/V5wWqjvO4yJ3wN68om6a2DmjCFJ9oGRSa6cS+wnGo2HshVYZcficms1BX9spXd0OPO4ZR2Rg==
X-Received: by 2002:a19:c115:: with SMTP id r21mr1682969lff.144.1545405682998;
        Fri, 21 Dec 2018 07:21:22 -0800 (PST)
Received: from localhost.localdomain (c90-142-43-138.bredband.comhem.se. [90.142.43.138])
        by smtp.gmail.com with ESMTPSA id q30sm5005601lfi.94.2018.12.21.07.21.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 21 Dec 2018 07:21:22 -0800 (PST)
From:   codekipper@gmail.com
To:     maxime.ripard@free-electrons.com, wens@csie.org,
        linux-sunxi@googlegroups.com
Cc:     linux-arm-kernel@lists.infradead.org, lgirdwood@gmail.com,
        broonie@kernel.org, linux-kernel@vger.kernel.org,
        alsa-devel@alsa-project.org, be17068@iperbole.bo.it,
        Marcus Cooper <codekipper@gmail.com>
Subject: [PATCH v3 8/9] ASoC: sun4i-i2s: Add set_tdm_slot functionality
Date:   Fri, 21 Dec 2018 16:21:09 +0100
Message-Id: <20181221152110.17982-9-codekipper@gmail.com>
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

Some codecs require a different amount of a bit clocks per frame than
what is calculated by the sample width. Use the tdm slot bindings to
provide this mechanism.

Signed-off-by: Marcus Cooper <codekipper@gmail.com>
---
 sound/soc/sunxi/sun4i-i2s.c | 22 ++++++++++++++++++++--
 1 file changed, 20 insertions(+), 2 deletions(-)

diff --git a/sound/soc/sunxi/sun4i-i2s.c b/sound/soc/sunxi/sun4i-i2s.c
index 8cec2f42c94e..cfcf427270fd 100644
--- a/sound/soc/sunxi/sun4i-i2s.c
+++ b/sound/soc/sunxi/sun4i-i2s.c
@@ -196,6 +196,9 @@ struct sun4i_i2s {
 	const struct sun4i_i2s_quirks	*variant;
 
 	bool bit_clk_master;
+
+	unsigned int	tdm_slots;
+	unsigned int	slot_width;
 };
 
 struct sun4i_i2s_clk_div {
@@ -385,7 +388,7 @@ static int sun4i_i2s_set_clk_rate(struct snd_soc_dai *dai,
 	if (i2s->variant->has_fmt_set_lrck_period)
 		regmap_update_bits(i2s->regmap, SUN4I_I2S_FMT0_REG,
 				   SUN8I_I2S_FMT0_LRCK_PERIOD_MASK,
-				   SUN8I_I2S_FMT0_LRCK_PERIOD(32));
+				   SUN8I_I2S_FMT0_LRCK_PERIOD(word_size));
 
 	/* Set sign extension to pad out LSB with 0 */
 	regmap_field_write(i2s->field_fmt_sext, 0);
@@ -498,7 +501,8 @@ static int sun4i_i2s_hw_params(struct snd_pcm_substream *substream,
 			   sr + i2s->variant->fmt_offset);
 
 	return sun4i_i2s_set_clk_rate(dai, params_rate(params),
-				      params_width(params));
+				      i2s->tdm_slots ?
+				      i2s->slot_width : params_width(params));
 }
 
 static int sun4i_i2s_set_fmt(struct snd_soc_dai *dai, unsigned int fmt)
@@ -749,11 +753,25 @@ static int sun4i_i2s_set_sysclk(struct snd_soc_dai *dai, int clk_id,
 	return 0;
 }
 
+static int sun4i_i2s_set_dai_tdm_slot(struct snd_soc_dai *dai,
+	unsigned int tx_mask, unsigned int rx_mask,
+	int slots, int width)
+{
+	struct sun4i_i2s *i2s = snd_soc_dai_get_drvdata(dai);
+
+	i2s->tdm_slots = slots;
+
+	i2s->slot_width = width;
+
+	return 0;
+}
+
 static const struct snd_soc_dai_ops sun4i_i2s_dai_ops = {
 	.hw_params	= sun4i_i2s_hw_params,
 	.set_fmt	= sun4i_i2s_set_fmt,
 	.set_sysclk	= sun4i_i2s_set_sysclk,
 	.trigger	= sun4i_i2s_trigger,
+	.set_tdm_slot	= sun4i_i2s_set_dai_tdm_slot,
 };
 
 static int sun4i_i2s_dai_probe(struct snd_soc_dai *dai)
-- 
2.20.1

