Return-Path: <SRS0=cgxA=JU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1153CC3279B
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 09:52:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BF23D21A53
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 09:52:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="NG/Uhmb1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BF23D21A53
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933607AbeGDJwj (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Jul 2018 05:52:39 -0400
Received: from mail-wr0-f196.google.com ([209.85.128.196]:45789 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932839AbeGDJv6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jul 2018 05:51:58 -0400
Received: by mail-wr0-f196.google.com with SMTP id u7-v6so4661382wrn.12
        for <linux-kernel@vger.kernel.org>; Wed, 04 Jul 2018 02:51:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=95o/HT/SaGPK83p31aRyZLuV5q5VAPiiNUedqU0bxEA=;
        b=NG/Uhmb1VwXf9oil929a35cQ3yRSRxfD61nRbD/Afpe2Ufsvbio5CbiDt36J+sM7PX
         OmqGt8bvtyBMK/eneniYAQSRaePofypPsAtg0jDCAnAQWHr78yOl7iGVoD56+63BryCr
         T8e8n342sCHco2cL/8dLHspCj5Vs4E9GY3tSg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=95o/HT/SaGPK83p31aRyZLuV5q5VAPiiNUedqU0bxEA=;
        b=C4GGKGStifX/GX+Jes1mSGonsyoFr8pUWDABhAfhyE2pD6QPgYczWx1mIegIUcazsh
         KIMJzcsQPQScc2TjKB8gRVFg+S6eitJjvmwxL2cF+nV/Zq90uQ+wvlPh9BjiVSyBGZwT
         JDPyPIytua1XMAr+sI/IgAOP2RB5QuKabY62iICCRsXExYlLvwPWgynuXoCN1wwpr9IO
         HMHKP2b/XrxZ+ZSyZYnJhpA0EIbtxqTCajDTtalBFQQgV8/umX5WUkVg2+2OMoMnpCdW
         ULu7vmvaEINJF/b7LWF/AgREZdyDp/3d5y8aL6E5aGqs5mNYZ/Pgoglg2JbPpp1MY4G4
         y/jw==
X-Gm-Message-State: APt69E1Q5LC65pXTUeLRmcyERlULCS64kQ8Q39A2LE7PprIWUe7T/X/b
        C7zeAKuzdOASfQIAY4ejU4DhNw==
X-Google-Smtp-Source: AAOMgpfEskBCW1rl1Fh/EXnSWlNVX6nnh2ppLFYz5UlS5luPBXS6UghxPp7gu3T6kJp0uJyxW3QGCA==
X-Received: by 2002:adf:a0f3:: with SMTP id n48-v6mr1114940wrn.23.1530697917108;
        Wed, 04 Jul 2018 02:51:57 -0700 (PDT)
Received: from localhost.localdomain (cpc90716-aztw32-2-0-cust92.18-1.cable.virginm.net. [86.26.100.93])
        by smtp.gmail.com with ESMTPSA id 125-v6sm6370089wmw.9.2018.07.04.02.51.56
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 04 Jul 2018 02:51:56 -0700 (PDT)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     broonie@kernel.org, alsa-devel@alsa-project.org
Cc:     linux-arm-msm@vger.kernel.org, lgirdwood@gmail.com,
        bgoswami@codeaurora.org, tiwai@suse.com,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH 4/6] ASoC: qdsp6: q6afe-dai: Do not overwrite slim dai num_channels
Date:   Wed,  4 Jul 2018 10:49:42 +0100
Message-Id: <20180704094944.16440-5-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180704094944.16440-1-srinivas.kandagatla@linaro.org>
References: <20180704094944.16440-1-srinivas.kandagatla@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

num_channels for slim dais are aready set int set_channel_map,
do not overwrite them in hw_params.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 sound/soc/qcom/qdsp6/q6afe-dai.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/sound/soc/qcom/qdsp6/q6afe-dai.c b/sound/soc/qcom/qdsp6/q6afe-dai.c
index 8dd3683eb367..074582afda85 100644
--- a/sound/soc/qcom/qdsp6/q6afe-dai.c
+++ b/sound/soc/qcom/qdsp6/q6afe-dai.c
@@ -81,7 +81,6 @@ static int q6slim_hw_params(struct snd_pcm_substream *substream,
 	struct q6afe_dai_data *dai_data = dev_get_drvdata(dai->dev);
 	struct q6afe_slim_cfg *slim = &dai_data->port_config[dai->id].slim;
 
-	slim->num_channels = params_channels(params);
 	slim->sample_rate = params_rate(params);
 
 	switch (params_format(params)) {
-- 
2.16.2

