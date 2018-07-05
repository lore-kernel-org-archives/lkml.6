Return-Path: <SRS0=71UW=JV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CE2BC6778C
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 10:14:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EEE80240DA
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 10:14:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="NaBRTITC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EEE80240DA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753694AbeGEKOV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Jul 2018 06:14:21 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:52091 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753403AbeGEKN6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jul 2018 06:13:58 -0400
Received: by mail-wm0-f67.google.com with SMTP id s12-v6so10196165wmc.1
        for <linux-kernel@vger.kernel.org>; Thu, 05 Jul 2018 03:13:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=TXdUAVIbftx6DVW3m0tqzagDNSKCycxA7cOp98dNZx0=;
        b=NaBRTITCwK0dffFBAuyFSlxPZsYsGRtUsxV55v/00NNLYLCpykl+kjzNFI6iW92O2x
         SxEh7+nt0a6GbzleCq2X+W3NVdMpycMo0klf/gkXYeyVp/+GSbniGmtvAHComgX7Ie+H
         HwHc8/pioGaVVwVEs1CmawjIcP3OG9kgw2n4kTCEfpSnz+O7QeIaNv0DQAIQhonHVXvI
         6uEFKIl2BVIXp5z0YDngdEe3uB/BR07EHJ5kzUMaGxtgKV3yYd7FCaFx4L6toafrGz2t
         pYAchQjwtBHgKjtb9nY/u/fBopxvZinQoiykbL0OMpUfzVOwYjvBuoA98lXieYfU5Dwa
         WRDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=TXdUAVIbftx6DVW3m0tqzagDNSKCycxA7cOp98dNZx0=;
        b=PEme844Ed8uh6yuJUzP6+ZGttw016joeDrGvGA9YWBlaXsSHcW69T1/CCW/e4dOpoi
         pGum4jzWmUwLMy0+ZKSdKtBOw9SQy1oyCnYaGMpM966dSAwEjC7mcurLX6XakU30XJ4Z
         72lAG0dxaqUUMYLcM0CHowtUSBVl9gZ0LhozXn/iwdx3kzcJByB/dqqiLBLX1wsWlHGO
         jPQJpn5DrinBznZOiCgI2SPemBqOr68RkhoT5e2dq+cExw8hMaT/0i3LvuNHLfmqTfqr
         UEYClgAzXAkTAj6s9KI9ODbcfDjGU53N2IudWLWNbQrrCIPWFXoR98bxAYEsxDjvfzGn
         7a4Q==
X-Gm-Message-State: APt69E0qAJTF3kuFz9EBtLj9jAFXwFhygpd1JzOmEMe5VanqFJL3isaW
        Yn6lT66ebxPcwWlIGnAFN4BNg+Qy
X-Google-Smtp-Source: AAOMgpcPygSCSAQz9yvJa6Yvbxu9hQEKw+hK8Uhl9UlD9DezYQEXBS3JvmQR+DFPVk/HDf7nuewPQg==
X-Received: by 2002:a1c:8d0a:: with SMTP id p10-v6mr3847502wmd.121.1530785637626;
        Thu, 05 Jul 2018 03:13:57 -0700 (PDT)
Received: from boomer.baylibre.local ([90.63.244.31])
        by smtp.googlemail.com with ESMTPSA id z18-v6sm5175510wrr.76.2018.07.05.03.13.56
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 05 Jul 2018 03:13:57 -0700 (PDT)
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>
Cc:     Jerome Brunet <jbrunet@baylibre.com>, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] ASoC: dpcm: rework runtime stream merge
Date:   Thu,  5 Jul 2018 12:13:48 +0200
Message-Id: <20180705101349.7520-2-jbrunet@baylibre.com>
X-Mailer: git-send-email 2.14.4
In-Reply-To: <20180705101349.7520-1-jbrunet@baylibre.com>
References: <20180705101349.7520-1-jbrunet@baylibre.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The goal of this patch is to simplify a bit dpcm runtime stream merge
by removing several local variables.

ATM, merge functions return the BE 'filter' values which should then be
filtered against the FE stream values. This create a lot of local
variable and unnecessary init of min and max.

Instead of this, we can pass the FE stream values directly and let the
BE filtering functions perform the merge 'in-place'

Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
---
 sound/soc/soc-pcm.c | 39 +++++++++++++++------------------------
 1 file changed, 15 insertions(+), 24 deletions(-)

diff --git a/sound/soc/soc-pcm.c b/sound/soc/soc-pcm.c
index b959af4cff3a..54141a69b6b0 100644
--- a/sound/soc/soc-pcm.c
+++ b/sound/soc/soc-pcm.c
@@ -1672,29 +1672,28 @@ int dpcm_be_dai_startup(struct snd_soc_pcm_runtime *fe, int stream)
 }
 
 static void dpcm_init_runtime_hw(struct snd_pcm_runtime *runtime,
-				 struct snd_soc_pcm_stream *stream,
-				 u64 formats)
+				 struct snd_soc_pcm_stream *stream)
 {
 	runtime->hw.rate_min = stream->rate_min;
 	runtime->hw.rate_max = stream->rate_max;
 	runtime->hw.channels_min = stream->channels_min;
 	runtime->hw.channels_max = stream->channels_max;
 	if (runtime->hw.formats)
-		runtime->hw.formats &= formats & stream->formats;
+		runtime->hw.formats &= stream->formats;
 	else
-		runtime->hw.formats = formats & stream->formats;
+		runtime->hw.formats = stream->formats;
 	runtime->hw.rates = stream->rates;
 }
 
-static u64 dpcm_runtime_base_format(struct snd_pcm_substream *substream)
+static void dpcm_runtime_merge_format(struct snd_pcm_substream *substream,
+				      u64 *formats)
 {
 	struct snd_soc_pcm_runtime *fe = substream->private_data;
 	struct snd_soc_dpcm *dpcm;
-	u64 formats = ULLONG_MAX;
 	int stream = substream->stream;
 
 	if (!fe->dai_link->dpcm_merged_format)
-		return formats;
+		return;
 
 	/*
 	 * It returns merged BE codec format
@@ -1722,16 +1721,14 @@ static u64 dpcm_runtime_base_format(struct snd_pcm_substream *substream)
 			else
 				codec_stream = &codec_dai_drv->capture;
 
-			formats &= codec_stream->formats;
+			*formats &= codec_stream->formats;
 		}
 	}
-
-	return formats;
 }
 
-static void dpcm_runtime_base_chan(struct snd_pcm_substream *substream,
-				   unsigned int *channels_min,
-				   unsigned int *channels_max)
+static void dpcm_runtime_merge_chan(struct snd_pcm_substream *substream,
+				    unsigned int *channels_min,
+				    unsigned int *channels_max)
 {
 	struct snd_soc_pcm_runtime *fe = substream->private_data;
 	struct snd_soc_dpcm *dpcm;
@@ -1740,9 +1737,6 @@ static void dpcm_runtime_base_chan(struct snd_pcm_substream *substream,
 	if (!fe->dai_link->dpcm_merged_chan)
 		return;
 
-	*channels_min = 0;
-	*channels_max = UINT_MAX;
-
 	/*
 	 * It returns merged BE codec channel;
 	 * if FE want to use it (= dpcm_merged_chan)
@@ -1789,18 +1783,15 @@ static void dpcm_set_fe_runtime(struct snd_pcm_substream *substream)
 	struct snd_soc_pcm_runtime *rtd = substream->private_data;
 	struct snd_soc_dai *cpu_dai = rtd->cpu_dai;
 	struct snd_soc_dai_driver *cpu_dai_drv = cpu_dai->driver;
-	u64 format = dpcm_runtime_base_format(substream);
-	unsigned int channels_min = 0, channels_max = UINT_MAX;
 
 	if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK)
-		dpcm_init_runtime_hw(runtime, &cpu_dai_drv->playback, format);
+		dpcm_init_runtime_hw(runtime, &cpu_dai_drv->playback);
 	else
-		dpcm_init_runtime_hw(runtime, &cpu_dai_drv->capture, format);
-
-	dpcm_runtime_base_chan(substream, &channels_min, &channels_max);
+		dpcm_init_runtime_hw(runtime, &cpu_dai_drv->capture);
 
-	runtime->hw.channels_min = max(channels_min, runtime->hw.channels_min);
-	runtime->hw.channels_max = min(channels_max, runtime->hw.channels_max);
+	dpcm_runtime_merge_format(substream, &runtime->hw.formats);
+	dpcm_runtime_merge_chan(substream, &runtime->hw.channels_min,
+				&runtime->hw.channels_max);
 }
 
 static int dpcm_fe_dai_do_trigger(struct snd_pcm_substream *substream, int cmd);
-- 
2.14.4

