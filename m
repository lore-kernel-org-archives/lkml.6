Return-Path: <SRS0=7Z+k=KK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A03CC6778F
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 12:46:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 335C620891
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 12:46:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="PcySDuY5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 335C620891
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730726AbeGZOCm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Jul 2018 10:02:42 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:46905 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730378AbeGZOCf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jul 2018 10:02:35 -0400
Received: by mail-wr1-f66.google.com with SMTP id h14-v6so1582901wrw.13
        for <linux-kernel@vger.kernel.org>; Thu, 26 Jul 2018 05:45:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=7WYqd29pcrxIUECLsEnZrt9IL920I+CRQcYOJWWeBW0=;
        b=PcySDuY5G9Z+Kf1qJ3mhTGR5C7mGXwcovLEzeRTbLZVFATGXGXMd0Z64GE539LOVpi
         gO3Djl2eFvdsytiass27KfWyB7z5QUcdBNQ0p8Y55LkNO4pStaRvBGhe002g5x8No9kp
         aq1MIH2VZ+CiJY9hZYw7YJqiF5hXN8pQc1KLLOQEX7p84eG8zYkbGYEO8qQ6VEKY8IOX
         Q1Uk982vluST1i5NLHC8LtJqDoU5JOp6jqCQhotIw8x9Em4LU6x7MwYf1ve32L2+WRd+
         ejcA5N3rq8jJk8F6Lr5Fz+x77Xa2CzApE9h3Cm+gVrvchO28FcHDVSqOaNAlIQOMd6Iy
         7zpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=7WYqd29pcrxIUECLsEnZrt9IL920I+CRQcYOJWWeBW0=;
        b=bVdMquVT08iGnwuXJjqvNp63PtP/lcjTNzlHOeE5uRsZQOJolc6nYpyIFZhN/Biyi3
         Ax5aFFYDEx0iMEP8g1NhBeVqz79mKtQJnsJKQCRfvc2TtQOhrAM7D5LZhg3uRBbUNwMh
         O1AnIhYkwFqcqrf3jLmpSP06nUWGgakIFAzwjYN22gKWMYuKBX45VGg5T6zrdbt8hKqm
         ZHg6bLBIVqo2SYqOaKJDFWDfVthHJJXjffdI+Ix4Mhv24orUqKl/8UQtNJ8lqmwPr/2S
         vFTP89uD/bfpZpIj7lHxAqqP9YAkzQQ4N8x06hadqf4WEev51FogMaaG+A9Us0/Hfna5
         tk7Q==
X-Gm-Message-State: AOUpUlFjDCqpPBSZwq2fRN1YO6bJQSlR3+gSTPFRAanccohza5Nw302d
        TLn9cklerorHtu4j4psgnOvm+5l4jMM=
X-Google-Smtp-Source: AAOMgpcZ4k2LjjdC7zyCqHpNnifDQzSn4uiklnDQdVeWU3ori52h6tO76WR5OCPjTqud8jDXWKf8TQ==
X-Received: by 2002:adf:e491:: with SMTP id i17-v6mr1536571wrm.145.1532609152778;
        Thu, 26 Jul 2018 05:45:52 -0700 (PDT)
Received: from boomer.baylibre.local ([90.63.244.31])
        by smtp.googlemail.com with ESMTPSA id m207-v6sm1867744wma.31.2018.07.26.05.45.51
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 26 Jul 2018 05:45:52 -0700 (PDT)
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Carlo Caione <carlo@caione.org>, Rob Herring <robh@kernel.org>
Cc:     Jerome Brunet <jbrunet@baylibre.com>, alsa-devel@alsa-project.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-amlogic@lists.infradead.org
Subject: [PATCH 3/3] ASoC: meson: align axg card driver with DT bindings documentation
Date:   Thu, 26 Jul 2018 14:45:44 +0200
Message-Id: <20180726124544.14740-4-jbrunet@baylibre.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180726124544.14740-1-jbrunet@baylibre.com>
References: <20180726124544.14740-1-jbrunet@baylibre.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Drop amlogic prefix in front of the generic DT properties and change
property "name" to "model".

Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
---
 sound/soc/meson/axg-card.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/sound/soc/meson/axg-card.c b/sound/soc/meson/axg-card.c
index d6d1081d94ad..2914ba0d965b 100644
--- a/sound/soc/meson/axg-card.c
+++ b/sound/soc/meson/axg-card.c
@@ -123,7 +123,7 @@ static int axg_card_add_aux_devices(struct snd_soc_card *card)
 	struct snd_soc_aux_dev *aux;
 	int num, i;
 
-	num = of_count_phandle_with_args(node, PREFIX "aux-devs", NULL);
+	num = of_count_phandle_with_args(node, "audio-aux-devs", NULL);
 	if (num == -ENOENT) {
 		/*
 		 * It is ok to have no auxiliary devices but for this card it
@@ -144,8 +144,8 @@ static int axg_card_add_aux_devices(struct snd_soc_card *card)
 	card->num_aux_devs = num;
 
 	for (i = 0; i < card->num_aux_devs; i++, aux++) {
-		aux->codec_of_node = of_parse_phandle(node,
-						      PREFIX "aux-devs", i);
+		aux->codec_of_node =
+			of_parse_phandle(node, "audio-aux-devs", i);
 		if (!aux->codec_of_node)
 			return -EINVAL;
 	}
@@ -610,18 +610,18 @@ static int axg_card_probe(struct platform_device *pdev)
 	priv->card.owner = THIS_MODULE;
 	priv->card.dev = dev;
 
-	ret = snd_soc_of_parse_card_name(&priv->card, PREFIX "name");
+	ret = snd_soc_of_parse_card_name(&priv->card, "model");
 	if (ret < 0)
 		return ret;
 
-	ret = axg_card_parse_of_optional(&priv->card, PREFIX "routing",
+	ret = axg_card_parse_of_optional(&priv->card, "audio-routing",
 					 snd_soc_of_parse_audio_routing);
 	if (ret) {
 		dev_err(dev, "error while parsing routing\n");
 		return ret;
 	}
 
-	ret = axg_card_parse_of_optional(&priv->card, PREFIX "widgets",
+	ret = axg_card_parse_of_optional(&priv->card, "audio-widgets",
 					 snd_soc_of_parse_audio_simple_widgets);
 	if (ret) {
 		dev_err(dev, "error while parsing widgets\n");
-- 
2.17.1

