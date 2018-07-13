Return-Path: <SRS0=Zbfl=J5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 514E1ECDFB3
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 12:50:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0BBBB20873
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 12:50:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="WMnvtPRu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0BBBB20873
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731397AbeGMNFY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Jul 2018 09:05:24 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:35152 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730595AbeGMNFX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jul 2018 09:05:23 -0400
Received: by mail-wm0-f66.google.com with SMTP id a9-v6so2471503wmb.0
        for <linux-kernel@vger.kernel.org>; Fri, 13 Jul 2018 05:50:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=5AtKow8jsYotDy005opx8iz+uph+cDuvICmcTFVjXK0=;
        b=WMnvtPRueVzQbsKfBUU+LK5Ixi05eAUY1sFI674KYh1MnQPtYhvXsf8ho5jcAbP90u
         u8WhmXv0zXkqZGLX49eNGmQI3+UqAyHtveFQr2+UgSruONUamZTyFcYB64kkpcfLqcGr
         6xlEj0ePCFhMD5meLxfhvBPWoqO75uNhZfnH50+CJ5iX58i14mKGO0QOuFI8Ccv5HkCo
         wN+UXvI7TfvyLeHh9JLus0Z20qH9gLb6BCJIbfTIPCcGHmg8QeSASjhsOQb7RUr26paG
         +vj7IObMSlS8sVTF/LMvvvy02y2n3wJkagq79rnPu4OdxH5B7p30fk90RrZjDOm2HdDu
         VP5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=5AtKow8jsYotDy005opx8iz+uph+cDuvICmcTFVjXK0=;
        b=rzZovKsp0XKNnnTDIiVAF6dKReaQQ03ZBwWPIRi3lbaqo6EEEmliSsx8dHcu57NLqI
         5pTJe1JtfNEXubXZn32RVzTq47jSA2REpMTsw2Xw58+Rv/4A+qaL8KsmJjUjGoqsmYqq
         Ao23LzboQVFU/DST4zEo4fFa2vcFujJVW6B5vsC85tG6xMMZQkS+2M5bzPxvUqB5LC14
         njrwfsq/A9mwd+zASxNRUyX4wc0x4xyLyf5Kz1dzwBbnIBxWmE/IGLk8yhrWGV84psAt
         QZUmE+Hyuzc2lRBQojiwGS2iNx9MVLpsOemV56JXai3qxMHoB30ePsJh0y+jdB8rvASp
         QLpg==
X-Gm-Message-State: AOUpUlGHI/BAybdLbvQMDMcATi1BLpbSZygE7MHlTEj13yj43A3G7bo8
        mwu2e4Pm2O30O9xG0DcsL+RLAw==
X-Google-Smtp-Source: AAOMgpdhd0JvZaedIBVko9T6jnOpD365SzRRTa3jXWvaHB/0mXTgPGYnKWcxm2P/Shh6PwMgqIOaFg==
X-Received: by 2002:a1c:c904:: with SMTP id f4-v6mr4137276wmb.140.1531486250354;
        Fri, 13 Jul 2018 05:50:50 -0700 (PDT)
Received: from boomer.baylibre.local ([90.63.244.31])
        by smtp.googlemail.com with ESMTPSA id f76-v6sm8541524wme.30.2018.07.13.05.50.49
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 13 Jul 2018 05:50:49 -0700 (PDT)
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>
Cc:     Jerome Brunet <jbrunet@baylibre.com>, alsa-devel@alsa-project.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] ASoC: allow soc-core to pick up name prefixes from component nodes
Date:   Fri, 13 Jul 2018 14:50:43 +0200
Message-Id: <20180713125043.13242-3-jbrunet@baylibre.com>
X-Mailer: git-send-email 2.14.4
In-Reply-To: <20180713125043.13242-1-jbrunet@baylibre.com>
References: <20180713125043.13242-1-jbrunet@baylibre.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When the component does not match the configuration table provided
by the card, let soc-core check the component node for a name prefix

Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
---
 sound/soc/soc-core.c | 28 +++++++++++++++++++++++-----
 1 file changed, 23 insertions(+), 5 deletions(-)

diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
index 00bd58d167dd..3be0310d5c81 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -1193,15 +1193,27 @@ void snd_soc_remove_dai_link(struct snd_soc_card *card,
 }
 EXPORT_SYMBOL_GPL(snd_soc_remove_dai_link);
 
+static void soc_set_of_name_prefix(struct snd_soc_component *component)
+{
+	struct device_node *component_of_node = component->dev->of_node;
+	const char *str;
+	int ret;
+
+	if (!component_of_node && component->dev->parent)
+		component_of_node = component->dev->parent->of_node;
+
+	ret = of_property_read_string(component_of_node, "sound-name-prefix",
+				      &str);
+	if (!ret)
+		component->name_prefix = str;
+}
+
 static void soc_set_name_prefix(struct snd_soc_card *card,
 				struct snd_soc_component *component)
 {
 	int i;
 
-	if (card->codec_conf == NULL)
-		return;
-
-	for (i = 0; i < card->num_configs; i++) {
+	for (i = 0; i < card->num_configs && card->codec_conf; i++) {
 		struct snd_soc_codec_conf *map = &card->codec_conf[i];
 		struct device_node *component_of_node = component->dev->of_node;
 
@@ -1213,8 +1225,14 @@ static void soc_set_name_prefix(struct snd_soc_card *card,
 		if (map->dev_name && strcmp(component->name, map->dev_name))
 			continue;
 		component->name_prefix = map->name_prefix;
-		break;
+		return;
 	}
+
+	/*
+	 * If there is no configuration table or no match in the table,
+	 * check if a prefix is provided in the node
+	 */
+	soc_set_of_name_prefix(component);
 }
 
 static int soc_probe_component(struct snd_soc_card *card,
-- 
2.14.4

