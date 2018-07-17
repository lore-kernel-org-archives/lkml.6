Return-Path: <SRS0=QM4b=KB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64774ECDFB3
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 15:37:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0FCF02086E
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 15:37:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="mkPDfy2T"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0FCF02086E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731404AbeGQQKS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Jul 2018 12:10:18 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:36376 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731296AbeGQQKR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jul 2018 12:10:17 -0400
Received: by mail-wm0-f68.google.com with SMTP id s14-v6so2007594wmc.1
        for <linux-kernel@vger.kernel.org>; Tue, 17 Jul 2018 08:37:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=yoo5n4dhpulCSFNRPHfsRmRUHZHqOi5jkgvB0Euf0Sg=;
        b=mkPDfy2TrU9TpaAJ+aww5QTfB8F/rkYM23QejFTw1hkEqPzKDy2lg+uMve0YbQLe70
         2k50Kd7GEPbHwdcf7Um8zihA/PArsgs7C8ivn6fY3QS5OTYSiaxZW+HuzJVD4lfupreS
         pajhG0hujS2nM4tQnKDLMljis0W75cLDttcGM0QEtnkqG149/7W2/3PKkYPW0tUlO7ja
         39VjtWuylPqVB+Zu8nq9aGSXWU3wDAxG3dXj5Bcv1miGzWOPuGApSu8QiLUPq6H4xmlp
         1M3TypZxs3buLDg9pThLuXO+vDfTWO5Mmcj0yQBotrdyLjCR1fb9AwSsdO3Zu6CqRlcc
         93+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=yoo5n4dhpulCSFNRPHfsRmRUHZHqOi5jkgvB0Euf0Sg=;
        b=CpaxKjYyujwaqZMisYqlmncJ/u0N+gSEm9hdaYv1HMON8iCUx8iZ87lFDwyE9TL+u5
         vJEVjP1DGZBHziOLZkx3Kkg5NKektLkBddyL3gAS/gegPyZ7h7Jcz8DHqRcdufud28mY
         /hsnx6dVtERJQeWurpLVitEVttYVZ/yesgh3ikirG14cx/b3NkUIYarsRrSChBHAjvqP
         hJqDyNuJ/L9AS+e5q7ArtPT9w2J2lA2v3T+W8W71RnRgojx+UUBMimLCyMW6Lh5Zk9ta
         7zKn0c4IGu2J4wD+26GI3i5N3qT9a6KTZjeoQM2uYWVjfn8SnDvtj8ufHvpkTmKdKBXq
         IuNQ==
X-Gm-Message-State: AOUpUlEhfqGM18cN8ZCaSTxQgyAcAwuL/ro23Bp0gyrWZjpj7YOntogl
        Dts63A/rPoeZFKPghFFNZwnpIA==
X-Google-Smtp-Source: AAOMgpc995b1jmCC/CEWqHFmDSSNWOsmhhzibjX7wSF3scH69quIlP88N9XLR49qlkNZt7tqo4AWZg==
X-Received: by 2002:a1c:3f08:: with SMTP id m8-v6mr1826562wma.88.1531841823914;
        Tue, 17 Jul 2018 08:37:03 -0700 (PDT)
Received: from boomer.baylibre.local ([90.63.244.31])
        by smtp.googlemail.com with ESMTPSA id h12-v6sm16971464wmb.3.2018.07.17.08.37.02
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 17 Jul 2018 08:37:03 -0700 (PDT)
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Carlo Caione <carlo@caione.org>
Cc:     Jerome Brunet <jbrunet@baylibre.com>, alsa-devel@alsa-project.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-amlogic@lists.infradead.org
Subject: [PATCH 13/15] ASoC: export snd_soc_of_get_slot_mask
Date:   Tue, 17 Jul 2018 17:36:40 +0200
Message-Id: <20180717153643.8806-17-jbrunet@baylibre.com>
X-Mailer: git-send-email 2.14.4
In-Reply-To: <20180717153643.8806-1-jbrunet@baylibre.com>
References: <20180717153643.8806-1-jbrunet@baylibre.com>
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

