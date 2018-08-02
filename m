Return-Path: <SRS0=MSGh=KR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C53B3C43142
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 15:05:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7F8752151B
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 15:05:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="N3sSoeZu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7F8752151B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732628AbeHBQ5c (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Aug 2018 12:57:32 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:36729 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732426AbeHBQ5b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Aug 2018 12:57:31 -0400
Received: by mail-wm0-f66.google.com with SMTP id w24-v6so2948933wmc.1
        for <linux-kernel@vger.kernel.org>; Thu, 02 Aug 2018 08:05:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=O2VBaKsaHVm856s9KjJ2JKojEQQJw+58cO+gZJ+RQTQ=;
        b=N3sSoeZu2e2XG3SgfC1QjkyZnH4vL0XZ5Q0mhzwqyCjhQempVcGMoxMSS04BRxyAZZ
         ppcenCMA72PbjoActe1U1139sBiRiH1XV7SQfGf6xW9Xo0YMvkwP4NzHpNBzBgxZSsKE
         LpEsL5IqVrACyWoDFUJ36lEXSVclUu6hnB4SE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=O2VBaKsaHVm856s9KjJ2JKojEQQJw+58cO+gZJ+RQTQ=;
        b=FvR794yRmXoksm7rWw2/hGTnfQcrMlqgR4mk2gqNf8zL63HV51mqPhgwUvERAlAKCt
         ojH/MwnBDtdiQ9hgWaL13Sg3WM+TXx1a5KJK1Rs/7ajffyAWzQrEq01lvS23FboMRanZ
         j5f1qazNi5TZxcuAbjBtNbru2q1gphi/YBTlTYyLQt0yRNMl1tTvxTf5POKMuic8BlHT
         2YOpdsEyhSCnmumZDd3Re3VuaCGVFhrQJ2P35LaWsWtgiPr76WUw05PqZfHl6gMKBe8/
         gFIboL1WnwB3PvGeUQY1BKVTyzKgZ7/mas06zxOHom1RA9ZNCZoLvsnkYVozZQ2bV0LH
         +BGA==
X-Gm-Message-State: AOUpUlHvFO+DphWAAyUz9Q94Rf09IoWAcwyOEsqKDT9k97avY5QfRDs8
        KC+zFDVd3Ggj6C4190Iyvw2CiA==
X-Google-Smtp-Source: AAOMgpdFQmZUwBxdTeYibPfedtXIUHQOCM8Gcz5ExXnieZ+oZRQbKSw11NzgEBHfusdjk4WsV2oezA==
X-Received: by 2002:a1c:1182:: with SMTP id 124-v6mr2260730wmr.75.1533222354706;
        Thu, 02 Aug 2018 08:05:54 -0700 (PDT)
Received: from localhost.localdomain (cpc90716-aztw32-2-0-cust92.18-1.cable.virginm.net. [86.26.100.93])
        by smtp.gmail.com with ESMTPSA id b126-v6sm2497517wmf.41.2018.08.02.08.05.53
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 02 Aug 2018 08:05:54 -0700 (PDT)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     broonie@kernel.org, lgirdwood@gmail.com,
        alsa-devel@alsa-project.org
Cc:     perex@perex.cz, tiwai@suse.com, vkoul@kernel.org,
        linux-kernel@vger.kernel.org, rohitkr@codeaurora.org,
        bgoswami@codeaurora.org, stefan.wahren@i2se.com,
        guillaume.tucker@collabora.com,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH 2/3] ASoC: smd845: remove auto rebinding
Date:   Thu,  2 Aug 2018 16:03:37 +0100
Message-Id: <20180802150338.24538-3-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180802150338.24538-1-srinivas.kandagatla@linaro.org>
References: <20180802150338.24538-1-srinivas.kandagatla@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove auto rebinding support, as component framework can deadlock
in few usecases if we are trying to add new/remove component within
a bind/unbind callbacks.

Card rebinding is ASoC core feature so all the previous component
framework stuff in q6dsp remains removed.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 sound/soc/qcom/sdm845.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/sound/soc/qcom/sdm845.c b/sound/soc/qcom/sdm845.c
index bf4ec4646906..be0cb1122036 100644
--- a/sound/soc/qcom/sdm845.c
+++ b/sound/soc/qcom/sdm845.c
@@ -226,7 +226,6 @@ static int sdm845_snd_platform_probe(struct platform_device *pdev)
 		return -ENOMEM;
 
 	card->dev = dev;
-	card->auto_bind = true;
 	dev_set_drvdata(dev, card);
 	ret = qcom_snd_parse_of(card);
 	if (ret) {
@@ -258,7 +257,6 @@ static int sdm845_snd_platform_remove(struct platform_device *pdev)
 	struct snd_soc_card *card = dev_get_drvdata(&pdev->dev);
 	struct sdm845_snd_data *data = snd_soc_card_get_drvdata(card);
 
-	card->auto_bind = false;
 	snd_soc_unregister_card(card);
 	kfree(card->dai_link);
 	kfree(data);
-- 
2.16.2

