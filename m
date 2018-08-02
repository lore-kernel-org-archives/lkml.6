Return-Path: <SRS0=MSGh=KR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CFCCC43142
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 15:05:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 34A012152A
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 15:05:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="P/zGrPpP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 34A012152A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732608AbeHBQ5a (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Aug 2018 12:57:30 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:36729 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732530AbeHBQ53 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Aug 2018 12:57:29 -0400
Received: by mail-wm0-f68.google.com with SMTP id w24-v6so2948860wmc.1
        for <linux-kernel@vger.kernel.org>; Thu, 02 Aug 2018 08:05:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=lsiz5N5rWCk8QDHzn/s6pltCN2LXL/Z1fx+4l7XaxPI=;
        b=P/zGrPpPpmqpTFPVTBM/mSy7EZXT43pljUdD2jqgxjmhfsSSPowp2RpRUzKIXAyG75
         +UGOKpLyQv8Ytx/EAebr5snN/Zw6s3w+cANGsQuk2zMuZPigMKaBGas238loB0W3gJDP
         5X2pdTDMHU2edAmfD6VeC7pavKT61hGgCwot4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=lsiz5N5rWCk8QDHzn/s6pltCN2LXL/Z1fx+4l7XaxPI=;
        b=NK7Aw8zKfix6NoMaNWBLB0aMbWHdWDFYPUIV4xekwgk2vGU2rMuVgWzVlnIpT9YSs3
         jiNgQbZ21WLMBzxZi6I+shkuRrUV5gMvAvdiLdBY/2lG6PzBXC2n2jtap5mk85PFPWvu
         RRWXzueDwOo7H1SK42Tvo6cZh32QzHYYMaExvBuPsEZuJoexX5LR0CntiBMoTrwOxRWS
         JVs9Bdw1q0RzJSp1Z7X+RL9ZWrluC36qWiLBTS58z4Tn0MzOSV7bRgZ5kqitRs6gJ5Pa
         qf7Xc89mVEUCwjrCV85UfKez8WcryzhACnKp9SYz41cGWJi8pUo+YsCUuOvEphl+QaH1
         a1WQ==
X-Gm-Message-State: AOUpUlFOV09AJ6y++fumjtUJaqYudIqZJ5KSAZcMPV7iXx+7TNitl3mi
        ScxSPBZV4MY7lf0aFGQvU0HfeQ==
X-Google-Smtp-Source: AAOMgpd59Vrq8Pho8AIUaZTWdvGj8WyB4srMX8i9hKxzl1lKdFpEnDTur2mD/qV2LTwKqZdFic4EzQ==
X-Received: by 2002:a1c:5b09:: with SMTP id p9-v6mr2486680wmb.0.1533222353634;
        Thu, 02 Aug 2018 08:05:53 -0700 (PDT)
Received: from localhost.localdomain (cpc90716-aztw32-2-0-cust92.18-1.cable.virginm.net. [86.26.100.93])
        by smtp.gmail.com with ESMTPSA id b126-v6sm2497517wmf.41.2018.08.02.08.05.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 02 Aug 2018 08:05:53 -0700 (PDT)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     broonie@kernel.org, lgirdwood@gmail.com,
        alsa-devel@alsa-project.org
Cc:     perex@perex.cz, tiwai@suse.com, vkoul@kernel.org,
        linux-kernel@vger.kernel.org, rohitkr@codeaurora.org,
        bgoswami@codeaurora.org, stefan.wahren@i2se.com,
        guillaume.tucker@collabora.com,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH 1/3] ASoC: apq8096: remove auto rebinding
Date:   Thu,  2 Aug 2018 16:03:36 +0100
Message-Id: <20180802150338.24538-2-srinivas.kandagatla@linaro.org>
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
 sound/soc/qcom/apq8096.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/sound/soc/qcom/apq8096.c b/sound/soc/qcom/apq8096.c
index 1e4a90d59228..6ee7e66cbaaa 100644
--- a/sound/soc/qcom/apq8096.c
+++ b/sound/soc/qcom/apq8096.c
@@ -48,7 +48,6 @@ static int apq8096_platform_probe(struct platform_device *pdev)
 		return -ENOMEM;
 
 	card->dev = dev;
-	card->auto_bind = true;
 	dev_set_drvdata(dev, card);
 	ret = qcom_snd_parse_of(card);
 	if (ret) {
@@ -74,7 +73,6 @@ static int apq8096_platform_remove(struct platform_device *pdev)
 {
 	struct snd_soc_card *card = dev_get_drvdata(&pdev->dev);
 
-	card->auto_bind = false;
 	snd_soc_unregister_card(card);
 	kfree(card->dai_link);
 	kfree(card);
-- 
2.16.2

