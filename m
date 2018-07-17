Return-Path: <SRS0=QM4b=KB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3849ECDFB1
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 15:43:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A67EF20657
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 15:43:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="dEDKps7Y"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A67EF20657
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731652AbeGQQQp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Jul 2018 12:16:45 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:37035 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730514AbeGQQQn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jul 2018 12:16:43 -0400
Received: by mail-wr1-f66.google.com with SMTP id q10-v6so1736986wrd.4
        for <linux-kernel@vger.kernel.org>; Tue, 17 Jul 2018 08:43:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=yoo5n4dhpulCSFNRPHfsRmRUHZHqOi5jkgvB0Euf0Sg=;
        b=dEDKps7YDghxieJzjM8X9UBYmwOkqbT2PJEv1Ec+rXPRkYmQMD5laevucQA6IufmN4
         /3AeqbPYdqV/a4jS3Walgiy2KCIHJA5tb5klid5YA3S3YRUmdbuifX+7wRnjaSfBWvFt
         8ofsoodry7PiaiwNxVKcRiVNMjTeiIUzxZ5X4+e/ryvto945E02L8TSuPjcGI9kM85j6
         nt9IYhSCG1sfF8vgOZVmv+Y4yRsYiT6wwBp9o4DubKFwRzh/7J1u7CpD+KzCmVkbAjWz
         ms5AbkWoMC3U/31XxrGhaGx1x7qBF8hRA8mkXokvLh2bzkzU0kITfwyzhu79jq/dw5MV
         SVTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=yoo5n4dhpulCSFNRPHfsRmRUHZHqOi5jkgvB0Euf0Sg=;
        b=lj1KI7zAad21EBQXxIn6/x1d3kDm13bS7wXlQMVkviZPSdgYg/1IDXDbE5SDI+w5vm
         CauPJ/DCnsqxByJqwEavwLln4v9s9Jow0AuDLbD+2DT3zWY/5uHaVL4EJ29GBq4yGdK1
         4il+32OI0qQMlaHOQYPvN5w6k/Snb7bnQwITdUTSZfpdRLq36YahE3VOlizHtMrbm9Bv
         mP0WlfsVMckxKVyWfDV0iMAUQU+8+JlCQVC/g32mm3toazX21H5TfXBJADQaQZrdKWYb
         h7UjplALBZHhtW46X9uwvmcG+uzpE4RnAI6ZKYKcI0BMIYh8Y4a+kDBH+mOOEzznw+zD
         RCbw==
X-Gm-Message-State: AOUpUlGyg8EnRV2GZp+1NAfVbEDu/DyclNnMaJIV9gYsCvdBYmSug5Y1
        pqWdqQyfnkfDkVuxJRppIACE+A==
X-Google-Smtp-Source: AAOMgpcxqwmz2yx5TYq9fELewRLHtmFjpssGJ23u3gChRPAmBKWT+/mGaXHBH3kOlwlVx0XESl+t0w==
X-Received: by 2002:adf:f188:: with SMTP id h8-v6mr1900105wro.214.1531842207504;
        Tue, 17 Jul 2018 08:43:27 -0700 (PDT)
Received: from boomer.baylibre.local ([90.63.244.31])
        by smtp.googlemail.com with ESMTPSA id s12-v6sm17598252wmc.2.2018.07.17.08.43.26
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 17 Jul 2018 08:43:26 -0700 (PDT)
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Carlo Caione <carlo@caione.org>
Cc:     Jerome Brunet <jbrunet@baylibre.com>, alsa-devel@alsa-project.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-amlogic@lists.infradead.org
Subject: [PATCH RESEND 13/15] ASoC: export snd_soc_of_get_slot_mask
Date:   Tue, 17 Jul 2018 17:43:02 +0200
Message-Id: <20180717154304.9973-14-jbrunet@baylibre.com>
X-Mailer: git-send-email 2.14.4
In-Reply-To: <20180717154304.9973-1-jbrunet@baylibre.com>
References: <20180717154304.9973-1-jbrunet@baylibre.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Amlogic's axg card driver can't use snd_soc_of_parse_tdm_slot()
directly because it needs to handle 4 mask for each direction.
Yet the parsing of each mask is the same, so export
snd_soc_of_get_slot_mask() to reuse the the existing code.

Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
---
 include/sound/soc.h  | 3 +++
 sound/soc/soc-core.c | 7 ++++---
 2 files changed, 7 insertions(+), 3 deletions(-)

diff --git a/include/sound/soc.h b/include/sound/soc.h
index a4915148f739..41cec42fb456 100644
--- a/include/sound/soc.h
+++ b/include/sound/soc.h
@@ -1426,6 +1426,9 @@ int snd_soc_of_parse_card_name(struct snd_soc_card *card,
 			       const char *propname);
 int snd_soc_of_parse_audio_simple_widgets(struct snd_soc_card *card,
 					  const char *propname);
+int snd_soc_of_get_slot_mask(struct device_node *np,
+			     const char *prop_name,
+			     unsigned int *mask);
 int snd_soc_of_parse_tdm_slot(struct device_node *np,
 			      unsigned int *tx_mask,
 			      unsigned int *rx_mask,
diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
index 3be0310d5c81..1344e8e602fd 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -3366,9 +3366,9 @@ int snd_soc_of_parse_audio_simple_widgets(struct snd_soc_card *card,
 }
 EXPORT_SYMBOL_GPL(snd_soc_of_parse_audio_simple_widgets);
 
-static int snd_soc_of_get_slot_mask(struct device_node *np,
-				    const char *prop_name,
-				    unsigned int *mask)
+int snd_soc_of_get_slot_mask(struct device_node *np,
+			     const char *prop_name,
+			     unsigned int *mask)
 {
 	u32 val;
 	const __be32 *of_slot_mask = of_get_property(np, prop_name, &val);
@@ -3383,6 +3383,7 @@ static int snd_soc_of_get_slot_mask(struct device_node *np,
 
 	return val;
 }
+EXPORT_SYMBOL_GPL(snd_soc_of_get_slot_mask);
 
 int snd_soc_of_parse_tdm_slot(struct device_node *np,
 			      unsigned int *tx_mask,
-- 
2.14.4

