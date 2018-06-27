Return-Path: <SRS0=G4S6=JN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D92AC43142
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 09:48:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 24A332083B
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 09:48:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="TBiRB1rC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 24A332083B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934191AbeF0Jsg (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Jun 2018 05:48:36 -0400
Received: from mail-wr0-f193.google.com ([209.85.128.193]:33014 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932135AbeF0Jse (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jun 2018 05:48:34 -0400
Received: by mail-wr0-f193.google.com with SMTP id k16-v6so1358982wro.0
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jun 2018 02:48:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id;
        bh=ZOZL8sv6qCH03Q+wXqoFv8CXlSKcTxDgCU0PUbCkIic=;
        b=TBiRB1rCC/H8kM1vnWAQMiCOAIHPgMJz0tRaVVSr6L4S57D/tsegWUDDtO5CW1MPNB
         lTPmZXPw3nU0fb7JrCX2mnVgpqLZszNf5MXH6SQ10LC19zc9h0nnOIhX6FT/EdXgPqeS
         Z7mDXAvtnYyinvG/tiwqyeL5/SKHR8x2O4Ukl5S45BgHG7pjONh19WXTWAyBXVM8CfKG
         7pIjrK5lPvdaGuKFHqsx4AjQxqXTfQJHlhngq6erLD+jaODRiMLOGHMUvjuVP3R2QdoG
         mo8+Aa4bfvnqmNxxyBJ118iSR/Xd2DV0UbdfAg5li+OnrKFtZ8ib2MQAoWHI5bHD21rl
         nDOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=ZOZL8sv6qCH03Q+wXqoFv8CXlSKcTxDgCU0PUbCkIic=;
        b=qhJkt7If5FUV0I+lxAfAW0/1oEF90LbzzU6wpO2a3PfQ3SA6ObwNNmI0nkajWrKLGw
         qf4eSYpO6MhDLxvW6oZntZwGhwJ4Sz1GhVJtGNSz+TXfKyLuNB5m5Cj0IlkKs00SIO8g
         GtXSovrigZPzDMdoNr4Isd/COq1cqMAwF2q5hSTsPdZsDfTVEG0s3stDK+Pmmkf8xBnr
         fBPmERrE73IJkTTCO88ubb5EVTK5Ok3iWUWzI/3Ll0FqHqbdHAv9R85x4ISRwhA2hKbF
         PRzaMgtpNSnEtX4pcy7NBsvenwPQQT/LL92FbfMRi/0XEji8rh/qInAAzK0eTO8ziJJy
         AWGw==
X-Gm-Message-State: APt69E34ow0kGGQPcnyvTRuDjs7BD5y0iu/aBEIuA6sfhcTAUFjJYoFm
        jjeqCjS9Cd9bREsRJB44IB3TIg==
X-Google-Smtp-Source: AAOMgpdhgBK3wnyJOXkYq7fhKcQnTQRFUyymminQE4m5Nz87VYIdZuzJa2Rfm1QWCo+FpDG140Ebpg==
X-Received: by 2002:adf:9226:: with SMTP id 35-v6mr1331238wrj.44.1530092913769;
        Wed, 27 Jun 2018 02:48:33 -0700 (PDT)
Received: from boomer.baylibre.local ([90.63.244.31])
        by smtp.googlemail.com with ESMTPSA id e13-v6sm5576824wrm.45.2018.06.27.02.48.32
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 27 Jun 2018 02:48:33 -0700 (PDT)
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>
Cc:     Jerome Brunet <jbrunet@baylibre.com>, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, Jiada Wang <jiada_wang@mentor.com>
Subject: [PATCH] ASoC: dpcm: extend channel merging to the backend cpu dai
Date:   Wed, 27 Jun 2018 11:48:18 +0200
Message-Id: <20180627094818.5885-1-jbrunet@baylibre.com>
X-Mailer: git-send-email 2.14.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Extend dpcm_merge_chan to also check backend cpu dai channels
capabilities. Apply the same policy as soc_pcm_init_runtime_hw() for
multicodec links and only check cpu dai in this case.

Cc: Jiada Wang <jiada_wang@mentor.com>
Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
---

 Hi Mark,

 As you've probably noticed, this patch applies on top Jiada's patch
 pf4c277b817cc ("ASoC: soc-pcm: DPCM cares BE channel constraint")

 Regards.
 Jerome

 sound/soc/soc-pcm.c | 20 +++++++++++++++++---
 1 file changed, 17 insertions(+), 3 deletions(-)

diff --git a/sound/soc/soc-pcm.c b/sound/soc/soc-pcm.c
index b82d9ff1f47e..5141409ccaed 100644
--- a/sound/soc/soc-pcm.c
+++ b/sound/soc/soc-pcm.c
@@ -1728,12 +1728,26 @@ static void dpcm_runtime_base_chan(struct snd_pcm_substream *substream,
 
 	list_for_each_entry(dpcm, &fe->dpcm[stream].be_clients, list_be) {
 		struct snd_soc_pcm_runtime *be = dpcm->be;
+		struct snd_soc_dai_driver *cpu_dai_drv =  be->cpu_dai->driver;
 		struct snd_soc_dai_driver *codec_dai_drv;
 		struct snd_soc_pcm_stream *codec_stream;
-		int i;
+		struct snd_soc_pcm_stream *cpu_stream;
+
+		if (stream == SNDRV_PCM_STREAM_PLAYBACK)
+			cpu_stream = &cpu_dai_drv->playback;
+		else
+			cpu_stream = &cpu_dai_drv->capture;
+
+		*channels_min = max(*channels_min, cpu_stream->channels_min);
+		*channels_max = min(*channels_max, cpu_stream->channels_max);
+
+		/*
+		 * chan min/max cannot be enforced if there are multiple CODEC
+		 * DAIs connected to a single CPU DAI, use CPU DAI's directly
+		 */
+		if (be->num_codecs == 1) {
+			codec_dai_drv = be->codec_dais[0]->driver;
 
-		for (i = 0; i < be->num_codecs; i++) {
-			codec_dai_drv = be->codec_dais[i]->driver;
 			if (stream == SNDRV_PCM_STREAM_PLAYBACK)
 				codec_stream = &codec_dai_drv->playback;
 			else
-- 
2.14.4

