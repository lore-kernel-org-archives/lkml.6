Return-Path: <SRS0=TRGe=OU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D60CC07E85
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 13:47:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 621F420851
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 13:47:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="OXfs8+T9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 621F420851
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726671AbeLKNra (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Dec 2018 08:47:30 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:40162 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726653AbeLKNr1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Dec 2018 08:47:27 -0500
Received: by mail-wm1-f68.google.com with SMTP id q26so2298233wmf.5
        for <linux-kernel@vger.kernel.org>; Tue, 11 Dec 2018 05:47:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=x8YYSFigv4RU7j7xI4uPHxbxUgrWCBqBqOSREZXXKOw=;
        b=OXfs8+T9xSRXfRguqjtSXuj0tn4XCU7QRhO1JWnm6xRGmRPk/aUY8trzyOiZ0Q0F7y
         PN4TydfL9OAqsgq7sBZupcVyRx15BGuiXi0Oc/d++nAGCwkVxK1fyp8b0ARdGqBa/wVf
         drLKBLygnVw+LRAJ17mTkk/KR5Kt98nDP4+8VPetqEImDdxZpX0iFQWsJscWwiMgbPUX
         l4YC2x8db6i72zVfviAX0PxNW/W6ukVIyhnVl9npVKOp29kKGE8F506KDe/2ndr/0U+1
         VorNZsr0WpJYA+c5MBAoHZ3nQ4+0Qsk1vqumtGIfXmhRy+PXVvudkb3Xr01JsGbRTIdD
         5D8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=x8YYSFigv4RU7j7xI4uPHxbxUgrWCBqBqOSREZXXKOw=;
        b=E6UPM079X11WZbU7U3RRMtx36u80ubCY/HqsRQsEVxjrGrZkGHgjkJAX8Y6WqpWATK
         xAh3G11ODpZ4rp1r56aHc0XuKVXkgt/uzY3UrVZz2WuEzfpZDF81K+6DTcASefjDd5iI
         vUMwtmUkmwzou2w/EkpbEydrlSiR5WDg0EmIhtGTq6kwfBqkC1u1mjA/+UedbSTn/r7W
         wQ6ivTInTcZ7KFy75ZkxHy9UsIeSKUVC4nqWRXbFyphOgTy7eytRtGJGJ/XIMwqF2il0
         H6l1+ViRezqlh3otORq1ZctLyEaHI7IiE3UoTXA0EhC47bTYfE/7nLzQ6gaRF/wwJUDV
         0yeg==
X-Gm-Message-State: AA+aEWaQ/1rKYIbHzsEo6QKBlAbTcMmGglt4HQ3nf1TQ2KJnglTHY/RM
        kdR4HgPUrqqBRTYmnJ2klIC19A==
X-Google-Smtp-Source: AFSGD/VjtMarNsJjkvFNpGf48/DDFin3dNqxbhh+q18rKhMb1ew+f2DQPxQ6Zoy2G+AajeDLTaPUOA==
X-Received: by 2002:a7b:cb96:: with SMTP id m22mr2432266wmi.39.1544536045551;
        Tue, 11 Dec 2018 05:47:25 -0800 (PST)
Received: from boomer.local ([2a01:e34:eeb6:4690:106b:bae3:31ed:7561])
        by smtp.googlemail.com with ESMTPSA id 126sm113768wmd.1.2018.12.11.05.47.24
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 11 Dec 2018 05:47:25 -0800 (PST)
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Mark Brown <broonie@kernel.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Carlo Caione <carlo@caione.org>
Cc:     Jerome Brunet <jbrunet@baylibre.com>, alsa-devel@alsa-project.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-amlogic@lists.infradead.org
Subject: [PATCH 1/4] ASoC: meson: axg-toddr: add support for spdifin backend
Date:   Tue, 11 Dec 2018 14:47:10 +0100
Message-Id: <20181211134713.4908-2-jbrunet@baylibre.com>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181211134713.4908-1-jbrunet@baylibre.com>
References: <20181211134713.4908-1-jbrunet@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

add IEC958_SUBFRAME_LE to the list of format accepted by the fifo frontend.

As opposed to what was initially noted in the toddr dai driver, the spdifin
does not place the msb at bit 28, it just output a whole spdif subframe.

Placing the msb at bit 28 in the toddr driver just filters out the parity,
user, channel status and validity bits. It is better to just provide the
whole spdif subframe to the userspace and let the iec958 plugin deal with
it.

Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
---
 sound/soc/meson/axg-fifo.h  |  3 ++-
 sound/soc/meson/axg-toddr.c | 15 +++++----------
 2 files changed, 7 insertions(+), 11 deletions(-)

diff --git a/sound/soc/meson/axg-fifo.h b/sound/soc/meson/axg-fifo.h
index cb6c4013ca33..d9f516cfbeda 100644
--- a/sound/soc/meson/axg-fifo.h
+++ b/sound/soc/meson/axg-fifo.h
@@ -25,7 +25,8 @@ struct snd_soc_pcm_runtime;
 					 SNDRV_PCM_FMTBIT_S16_LE |	\
 					 SNDRV_PCM_FMTBIT_S20_LE |	\
 					 SNDRV_PCM_FMTBIT_S24_LE |	\
-					 SNDRV_PCM_FMTBIT_S32_LE)
+					 SNDRV_PCM_FMTBIT_S32_LE |	\
+					 SNDRV_PCM_FMTBIT_IEC958_SUBFRAME_LE)
 
 #define AXG_FIFO_BURST			8
 #define AXG_FIFO_MIN_CNT		64
diff --git a/sound/soc/meson/axg-toddr.c b/sound/soc/meson/axg-toddr.c
index c2c9bb312586..0e9ca3882ae5 100644
--- a/sound/soc/meson/axg-toddr.c
+++ b/sound/soc/meson/axg-toddr.c
@@ -25,6 +25,8 @@
 #define CTRL0_TODDR_LSB_POS_MASK	GENMASK(7, 3)
 #define CTRL0_TODDR_LSB_POS(x)		((x) << 3)
 
+#define TODDR_MSB_POS	31
+
 static int axg_toddr_pcm_new(struct snd_soc_pcm_runtime *rtd,
 			     struct snd_soc_dai *dai)
 {
@@ -36,14 +38,7 @@ static int axg_toddr_dai_hw_params(struct snd_pcm_substream *substream,
 				   struct snd_soc_dai *dai)
 {
 	struct axg_fifo *fifo = snd_soc_dai_get_drvdata(dai);
-	unsigned int type, width, msb = 31;
-
-	/*
-	 * NOTE:
-	 * Almost all backend will place the MSB at bit 31, except SPDIF Input
-	 * which will put it at index 28. When adding support for the SPDIF
-	 * Input, we'll need to find which type of backend we are connected to.
-	 */
+	unsigned int type, width;
 
 	switch (params_physical_width(params)) {
 	case 8:
@@ -66,8 +61,8 @@ static int axg_toddr_dai_hw_params(struct snd_pcm_substream *substream,
 			   CTRL0_TODDR_MSB_POS_MASK |
 			   CTRL0_TODDR_LSB_POS_MASK,
 			   CTRL0_TODDR_TYPE(type) |
-			   CTRL0_TODDR_MSB_POS(msb) |
-			   CTRL0_TODDR_LSB_POS(msb - (width - 1)));
+			   CTRL0_TODDR_MSB_POS(TODDR_MSB_POS) |
+			   CTRL0_TODDR_LSB_POS(TODDR_MSB_POS - (width - 1)));
 
 	return 0;
 }
-- 
2.19.2

