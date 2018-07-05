Return-Path: <SRS0=71UW=JV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A731C6778E
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 10:14:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 08D4D240D4
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 10:14:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="fDzw7OAq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 08D4D240D4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753628AbeGEKOC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Jul 2018 06:14:02 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:50296 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753566AbeGEKN7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jul 2018 06:13:59 -0400
Received: by mail-wm0-f68.google.com with SMTP id v25-v6so10200226wmc.0
        for <linux-kernel@vger.kernel.org>; Thu, 05 Jul 2018 03:13:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=cVYC+ZhnuEHN+jRguqV9kW73Jca7exrDTjee/g2Yifk=;
        b=fDzw7OAqq6v7Il4BGuES0x9bqHFj2E0jdYiJ8VN8kgDmAUSFyGXEUdtzk/WICo9NPp
         n1P+2FIyDIGt9YQ1UXCPmi6PYEnoGsk1tgM96r8kvMeO1ITBQhzlq7BB7q2u7n0hiXww
         EGtUxUIpmr7Z1R+IJ1vW9+2O4VgqHOwpTAJli8Jvo1VGKh6ho9fIECmC0vLm5X6wymqV
         +NIj83exZO4lpbNTsMVg1lozbdO25nqYCDInb0jOLuusaI6gvOoxm89XBNGQdyC8cFMg
         9Tt0nxsFPfum94khyibOpGDkQwGukDQTCE6xwXDYFGwhbR2wM1wKmeRnDgtSt+K7eDIP
         o18A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=cVYC+ZhnuEHN+jRguqV9kW73Jca7exrDTjee/g2Yifk=;
        b=ZrUsxtU/si+S9nTbwXZTkEdP7rkd0Q4zFmbw9LZwY4xo5T9JxvO0xaS+w0dr4IDF3N
         Wf5ZglvcNE7bNAxeFMkGEcaUEFKykUS0fASyFgoMsfrQobevF2lcWSURjlXoOjZ4zcpn
         5vDYR5pVbdnjsEkysu6RRry6wz2qzm9SaDSzEMkH9Lkb3Qlq1BlzIMjs8Eauu1l1S6XF
         aHo+gTSuxIsska89d4WmpRKmr7QKR71ZruStKBgMSMJHFHAzywW3bsQBw3dFgT/5ztpT
         Wp+u92rsZV7gi4UIEGdeFUjKHlpHGM6AEzwdCJ9ZTekh40fQsjg7tUYe4SgzF53+TmPP
         tK0A==
X-Gm-Message-State: APt69E3s7sqjL0VTtf6ioKDDMgCdcsRhZ4+WXSTQWmA0gMuJoZpimyqI
        hdpW6YGdh7Ybm+qUeScvGN0qpg==
X-Google-Smtp-Source: AAOMgpd/sb0lCeBI8i2GJtIFIOM+j1ZQ1QebkF+NwrdOyCxDP+LC/DigzYgWtHYehJod9fmPcMtgEA==
X-Received: by 2002:a1c:ea53:: with SMTP id i80-v6mr4071294wmh.113.1530785638476;
        Thu, 05 Jul 2018 03:13:58 -0700 (PDT)
Received: from boomer.baylibre.local ([90.63.244.31])
        by smtp.googlemail.com with ESMTPSA id z18-v6sm5175510wrr.76.2018.07.05.03.13.57
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 05 Jul 2018 03:13:57 -0700 (PDT)
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>
Cc:     Jerome Brunet <jbrunet@baylibre.com>, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] ASoC: dpcm: add rate merge to the BE stream merge
Date:   Thu,  5 Jul 2018 12:13:49 +0200
Message-Id: <20180705101349.7520-3-jbrunet@baylibre.com>
X-Mailer: git-send-email 2.14.4
In-Reply-To: <20180705101349.7520-1-jbrunet@baylibre.com>
References: <20180705101349.7520-1-jbrunet@baylibre.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As done for format and channels, add the possibility to merge
the backend rates on the frontend rates.

This useful if the backend does not support all rates supported by the
frontend, or if several backends (cpu and codecs) with different
capabilities are connected to the same frontend.

Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
---
 include/sound/soc.h |  2 ++
 sound/soc/soc-pcm.c | 60 +++++++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 62 insertions(+)

diff --git a/include/sound/soc.h b/include/sound/soc.h
index 870ba6b64817..a4915148f739 100644
--- a/include/sound/soc.h
+++ b/include/sound/soc.h
@@ -964,6 +964,8 @@ struct snd_soc_dai_link {
 	unsigned int dpcm_merged_format:1;
 	/* DPCM used FE & BE merged channel */
 	unsigned int dpcm_merged_chan:1;
+	/* DPCM used FE & BE merged rate */
+	unsigned int dpcm_merged_rate:1;
 
 	/* pmdown_time is ignored at stop */
 	unsigned int ignore_pmdown_time:1;
diff --git a/sound/soc/soc-pcm.c b/sound/soc/soc-pcm.c
index 54141a69b6b0..98be04b543ae 100644
--- a/sound/soc/soc-pcm.c
+++ b/sound/soc/soc-pcm.c
@@ -1777,6 +1777,64 @@ static void dpcm_runtime_merge_chan(struct snd_pcm_substream *substream,
 	}
 }
 
+static void dpcm_runtime_merge_rate(struct snd_pcm_substream *substream,
+				    unsigned int *rates,
+				    unsigned int *rate_min,
+				    unsigned int *rate_max)
+{
+	struct snd_soc_pcm_runtime *fe = substream->private_data;
+	struct snd_soc_dpcm *dpcm;
+	int stream = substream->stream;
+
+	if (!fe->dai_link->dpcm_merged_rate)
+		return;
+
+	/*
+	 * It returns merged BE codec channel;
+	 * if FE want to use it (= dpcm_merged_chan)
+	 */
+
+	list_for_each_entry(dpcm, &fe->dpcm[stream].be_clients, list_be) {
+		struct snd_soc_pcm_runtime *be = dpcm->be;
+		struct snd_soc_dai_driver *cpu_dai_drv =  be->cpu_dai->driver;
+		struct snd_soc_dai_driver *codec_dai_drv;
+		struct snd_soc_pcm_stream *codec_stream;
+		struct snd_soc_pcm_stream *cpu_stream;
+		int i;
+
+		if (stream == SNDRV_PCM_STREAM_PLAYBACK)
+			cpu_stream = &cpu_dai_drv->playback;
+		else
+			cpu_stream = &cpu_dai_drv->capture;
+
+		*rate_min = max(*rate_min, cpu_stream->rate_min);
+		*rate_max = min_not_zero(*rate_max, cpu_stream->rate_max);
+		*rates = snd_pcm_rate_mask_intersect(*rates, cpu_stream->rates);
+
+		for (i = 0; i < be->num_codecs; i++) {
+			/*
+			 * Skip CODECs which don't support the current stream
+			 * type. See soc_pcm_init_runtime_hw() for more details
+			 */
+			if (!snd_soc_dai_stream_valid(be->codec_dais[i],
+						      stream))
+				continue;
+
+			codec_dai_drv = be->codec_dais[i]->driver;
+			if (stream == SNDRV_PCM_STREAM_PLAYBACK)
+				codec_stream = &codec_dai_drv->playback;
+			else
+				codec_stream = &codec_dai_drv->capture;
+
+			*rate_min = max(*rate_min, codec_stream->rate_min);
+			*rate_max = min_not_zero(*rate_max,
+						 codec_stream->rate_max);
+			*rates = snd_pcm_rate_mask_intersect(*rates,
+						codec_stream->rates);
+		}
+	}
+}
+
 static void dpcm_set_fe_runtime(struct snd_pcm_substream *substream)
 {
 	struct snd_pcm_runtime *runtime = substream->runtime;
@@ -1792,6 +1850,8 @@ static void dpcm_set_fe_runtime(struct snd_pcm_substream *substream)
 	dpcm_runtime_merge_format(substream, &runtime->hw.formats);
 	dpcm_runtime_merge_chan(substream, &runtime->hw.channels_min,
 				&runtime->hw.channels_max);
+	dpcm_runtime_merge_rate(substream, &runtime->hw.rates,
+				&runtime->hw.rate_min, &runtime->hw.rate_max);
 }
 
 static int dpcm_fe_dai_do_trigger(struct snd_pcm_substream *substream, int cmd);
-- 
2.14.4

