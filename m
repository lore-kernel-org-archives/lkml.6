Return-Path: <SRS0=sqHT=JP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7737DC43141
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 15:10:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2F94728027
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 15:10:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="EhdaGlbX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2F94728027
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S936043AbeF2PKr (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Jun 2018 11:10:47 -0400
Received: from mail-wr0-f194.google.com ([209.85.128.194]:42078 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752917AbeF2PJc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jun 2018 11:09:32 -0400
Received: by mail-wr0-f194.google.com with SMTP id p1-v6so9183173wrs.9
        for <linux-kernel@vger.kernel.org>; Fri, 29 Jun 2018 08:09:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=f/9dnffnAhsKKDYTxbHSfWqEtEMVyyr+CWDSPR1bs1Q=;
        b=EhdaGlbX1SpMHMVEZ4H2JaRpRCsCiyi3BtSvmcJwwKJ4/0iHVuyxonrVWYXx9hp9S0
         GSmwXCR6l0rQ0Q/sQQ87XOGuXuKeqgavB0M+Wk5VjinZORPVAQxtrXdPmjdQrHYJu9a+
         hpiaXSX3Rrih+r0gHJ9kP8owrObTiwbJMmWbLh7cZJ8DSk0DNKcd8TQr6Gz/TXF+pWG1
         ZQDPurfQgMYPx7og5mqCM6qyfntzbpUOFDTtclYjcEAsXOU58Jr7AKEE4UnEvvSztYiA
         tLMjkYGAKpisNIGEYf6AQ4ExCnKjPh6iaJqvfoo/ak7oABKbFG5ZAgJqLuoKQR5DWpjM
         JEWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=f/9dnffnAhsKKDYTxbHSfWqEtEMVyyr+CWDSPR1bs1Q=;
        b=s83MnCXVssAr+xzAqAB7wXSvKGnTglQxaeLgxY+KR2lx3XJlx2S48k5B66bmkbSYQ0
         cgFPRyFPgD3J/vbFr3X9nU3go92FrR8fWmLhMiKhL5y/yNtI4jbdyWy6+7QuMLKJh4fp
         wOPmw/Y7yphGG8tF/ERZxW0ULijIe/JbhBHzu66XD7Plt+QWrtUcrT70Xaw2T9juW6/I
         lxX2BTgt/3Rvm+vNlv57IcnaWmYfU9blSTLcogmrqIjtaKjaI/e0tslH63LWPnU7Gl9x
         w/wAHJUM3VA/YvjhZKhR3Dvxm6FevWb82hyFvIeEpOojUMGhfAuSTBOG4v0FfxG4eeHG
         3SgA==
X-Gm-Message-State: APt69E2mKGgdLP8GW7wmyg+N0IW17XbiNBTq2ZVJBQPdV91nD48dgjeD
        GaIXkQiiYvAoQI55jBe8i+Yj4WEO
X-Google-Smtp-Source: AAOMgpeVZOQW6poium2s8lfdk0LKxMVOtYm3D6D76pYLIUL3kQvvNdzkrkk/tSfP0S3twh1KIdfjLQ==
X-Received: by 2002:adf:ff49:: with SMTP id u9-v6mr3760614wrs.15.1530284971714;
        Fri, 29 Jun 2018 08:09:31 -0700 (PDT)
Received: from localhost.localdomain (uluru.liltaz.com. [163.172.81.188])
        by smtp.googlemail.com with ESMTPSA id b6-v6sm11944222wro.52.2018.06.29.08.09.30
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 29 Jun 2018 08:09:31 -0700 (PDT)
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>
Cc:     Jerome Brunet <jbrunet@baylibre.com>, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/5] ASoC: es7134: remove 64kHz rate from the supported rates
Date:   Fri, 29 Jun 2018 17:09:20 +0200
Message-Id: <20180629150924.18197-2-jbrunet@baylibre.com>
X-Mailer: git-send-email 2.14.4
In-Reply-To: <20180629150924.18197-1-jbrunet@baylibre.com>
References: <20180629150924.18197-1-jbrunet@baylibre.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

64Khz is actually not supported by the es7134 according to the datasheet

Fixes: 9000b59d7a12 ("ASoC: es7134: add es7134 DAC driver")
Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
---
 sound/soc/codecs/es7134.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/sound/soc/codecs/es7134.c b/sound/soc/codecs/es7134.c
index 58515bb1a303..2fbb49f5b278 100644
--- a/sound/soc/codecs/es7134.c
+++ b/sound/soc/codecs/es7134.c
@@ -48,7 +48,11 @@ static struct snd_soc_dai_driver es7134_dai = {
 		.stream_name = "Playback",
 		.channels_min = 2,
 		.channels_max = 2,
-		.rates = SNDRV_PCM_RATE_8000_192000,
+		.rates = (SNDRV_PCM_RATE_8000_48000 |
+			  SNDRV_PCM_RATE_88200      |
+			  SNDRV_PCM_RATE_96000      |
+			  SNDRV_PCM_RATE_176400     |
+			  SNDRV_PCM_RATE_192000),
 		.formats = (SNDRV_PCM_FMTBIT_S16_LE  |
 			    SNDRV_PCM_FMTBIT_S18_3LE |
 			    SNDRV_PCM_FMTBIT_S20_3LE |
-- 
2.14.4

