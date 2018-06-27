Return-Path: <SRS0=G4S6=JN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16710C43142
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 15:37:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C56C6260F3
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 15:37:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="rOmAR9U3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C56C6260F3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934914AbeF0PhJ (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Jun 2018 11:37:09 -0400
Received: from mail-wr0-f195.google.com ([209.85.128.195]:46728 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934130AbeF0PhH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jun 2018 11:37:07 -0400
Received: by mail-wr0-f195.google.com with SMTP id t6-v6so2489870wrq.13
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jun 2018 08:37:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id;
        bh=ePBNCvJz3xvHJS0zMubFqbnZQOi/FaMeoOc4XqqaujI=;
        b=rOmAR9U3iYztRC4+WrxG9/eXsYk9FCmt4z2fMbIJOllCJfupXqk63FFVNYAJ9RnnR7
         9w7ekYiLtR978VuV+qNCjQ5oJTOBZaG9BHS4rBLVIbOcDC5/VnZw3JlOC3NoS0ELtS7X
         b1Q2xv8JvcU0LtlNfiZMSrZFQ5hH7VdPEk45dRccYLXdxscTF3mgnWVPPWuua3mGxCGI
         bwD/T3AwIUl/p7omjxO7V1mLwYmXnGsqXO4AlOEItS+RveHm61G2JD6H8fQ6JDwVVhha
         3TL7vSXgd3MolWXOPgq9cpPSMEjYhkcCLxGJQuBwaZ07ucn2iq7GmY6SzcjhO0o96Dad
         pLHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=ePBNCvJz3xvHJS0zMubFqbnZQOi/FaMeoOc4XqqaujI=;
        b=ATsBnfcqAcy2Q8W/sRMuX3bN4bHrsrvYnauF+yfaFnt/fRq8sKNlpqUGHaTDbZSrvO
         ymKVOGLUYZ1iIjWyDKgmwFwmqx+4wtxEdmw73drtSj8dZKCMyIPCSGIrsNp2L1wr5RrB
         jZG5EdA+MGCrfbv6qrIH5AubxW0QhvhkS/2qXuAp+zjHD1NOKf8dwgIQ+fZhK8Wkf+m9
         FxYRoxqCsSO0ktUiOH5K8oRRrFYd1jvcd/BnNM+7tOOVkLM0EqcJx5554+LDJjjVlp/i
         IuhRv7eCRs6Z/Pfq+AX/oBreINtQVxwthvJuhZeR3c/6uyoh2y/CnoJ0sJ7Oc8Snd5Ll
         HkUw==
X-Gm-Message-State: APt69E3lUjF9/XSWCScgsCc1SK4AsjrGu0v/OPtSVXchByMiadZQcojb
        hegAK1o3IgYy8p+BdBdHyhtUPg==
X-Google-Smtp-Source: AAOMgpd2cRYx6AVEjfFXju7LCoopJ+jIbmBX8UOrP39dKFpln+3dFCb/p5E8key7zzCHTAzPWtiBcw==
X-Received: by 2002:adf:f811:: with SMTP id s17-v6mr5363980wrp.172.1530113826410;
        Wed, 27 Jun 2018 08:37:06 -0700 (PDT)
Received: from boomer.baylibre.local ([90.63.244.31])
        by smtp.googlemail.com with ESMTPSA id m145-v6sm5583678wma.19.2018.06.27.08.37.05
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 27 Jun 2018 08:37:05 -0700 (PDT)
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>
Cc:     Jerome Brunet <jbrunet@baylibre.com>, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] ASoC: dpcm: don't merge format from invalid codec dai
Date:   Wed, 27 Jun 2018 17:36:38 +0200
Message-Id: <20180627153638.11832-1-jbrunet@baylibre.com>
X-Mailer: git-send-email 2.14.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When merging codec formats, dpcm_runtime_base_format() should skip
the codecs which are not supporting the current stream direction.

At the moment, if a BE link has more than one codec, and only one
of these codecs has no capture DAI, it becomes impossible to start
a capture stream because the merged format would be 0.

Skipping invalid codec DAI solves the problem.

Fixes: b073ed4e2126 ("ASoC: soc-pcm: DPCM cares BE format")
Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
---
 sound/soc/soc-pcm.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/sound/soc/soc-pcm.c b/sound/soc/soc-pcm.c
index 5141409ccaed..a58d8e7bf52b 100644
--- a/sound/soc/soc-pcm.c
+++ b/sound/soc/soc-pcm.c
@@ -1694,6 +1694,14 @@ static u64 dpcm_runtime_base_format(struct snd_pcm_substream *substream)
 		int i;
 
 		for (i = 0; i < be->num_codecs; i++) {
+			/*
+			 * Skip CODECs which don't support the current stream
+			 * type. See soc_pcm_init_runtime_hw() for more details
+			 */
+			if (!snd_soc_dai_stream_valid(be->codec_dais[i],
+						      stream))
+				continue;
+
 			codec_dai_drv = be->codec_dais[i]->driver;
 			if (stream == SNDRV_PCM_STREAM_PLAYBACK)
 				codec_stream = &codec_dai_drv->playback;
-- 
2.14.4

