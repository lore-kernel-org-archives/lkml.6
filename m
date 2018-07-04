Return-Path: <SRS0=cgxA=JU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BA2EC3279B
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 09:52:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 16A9322565
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 09:52:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="fcQhHFce"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 16A9322565
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932439AbeGDJwE (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Jul 2018 05:52:04 -0400
Received: from mail-wm0-f45.google.com ([74.125.82.45]:32834 "EHLO
        mail-wm0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752878AbeGDJwA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jul 2018 05:52:00 -0400
Received: by mail-wm0-f45.google.com with SMTP id z6-v6so12629224wma.0
        for <linux-kernel@vger.kernel.org>; Wed, 04 Jul 2018 02:51:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=U2hFfWmmsNEuowUtZFEQCnLNHtXFTHE2eMSugD1fOFs=;
        b=fcQhHFce0+XGd0vzjSI/rSY7zQ8hSEEOVD2G7ZvhxbU5F/hywUR0bcxr3P9V0wRk2K
         9Oqq8jwIkFrZlJasfWif+HcBaA7/UAus5s4Gq02XaRccSmHUDUV0P0kGExnjr9l62AT4
         j9Fzf5uXG/tPc4AyQrEA3Nf+jgf9lqG6p8Fpk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=U2hFfWmmsNEuowUtZFEQCnLNHtXFTHE2eMSugD1fOFs=;
        b=V39GMsv1YFh3P+ydMD3jm/asfPnmFW6cswxu1qYOzxo5a/9dZrVsRGY9fcZidYc0ih
         znq9D2J5arpT4XQPorO8lvuZMr3xABHFgDJtBtU7ycsKbRSBQ9/kChvOGFe4rxDid0ze
         53f5UJLhMdbV/I4Lf/XMT7pVgnsZvf2xZvRVRon6kXrvPqdNnyaPobpebrFQypoRgh1I
         WLWdVPmLTR0AB7S2ysd8EPBWkJjrVC88ohnp1v2vDrW5cRKLlz/rrtkg6spd/5Hx2lxM
         lvfEztSsUvrSpWcZyRLmNJf8ipG4/jH8Tc0RIfD4yAUaeGHeVHc/zLEeaC9FfS8MIyJm
         fK2w==
X-Gm-Message-State: APt69E2G15XahPBFaMHjUUwFpEeT7OQY619Ue2IQMMIyfQXarqtCEKW9
        gTFWqPmgIXcOCn/+nrrLdtp5Iw==
X-Google-Smtp-Source: AAOMgpdjCWZX2FMBTsRSU7/nlCZpG5La0JWTbxVqG6Exn0J7n4DXKmZrbrTdR9DQKUkIdOhdEUn6UA==
X-Received: by 2002:a1c:17d4:: with SMTP id 203-v6mr1087806wmx.75.1530697918899;
        Wed, 04 Jul 2018 02:51:58 -0700 (PDT)
Received: from localhost.localdomain (cpc90716-aztw32-2-0-cust92.18-1.cable.virginm.net. [86.26.100.93])
        by smtp.gmail.com with ESMTPSA id 125-v6sm6370089wmw.9.2018.07.04.02.51.58
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 04 Jul 2018 02:51:58 -0700 (PDT)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     broonie@kernel.org, alsa-devel@alsa-project.org
Cc:     linux-arm-msm@vger.kernel.org, lgirdwood@gmail.com,
        bgoswami@codeaurora.org, tiwai@suse.com,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH 6/6] ASoC: qdsp6: q6asm-dai: do not close port if its not opened
Date:   Wed,  4 Jul 2018 10:49:44 +0100
Message-Id: <20180704094944.16440-7-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180704094944.16440-1-srinivas.kandagatla@linaro.org>
References: <20180704094944.16440-1-srinivas.kandagatla@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

asm ports are open as part of prepare, so for use cases like
"aplay sample.wav" were sample.wav is not present. This would
call port close eventhough port was never opened. DSP would
return errors for such use cases.

Avoid doing this by checking the port state.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 sound/soc/qcom/qdsp6/q6asm-dai.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/sound/soc/qcom/qdsp6/q6asm-dai.c b/sound/soc/qcom/qdsp6/q6asm-dai.c
index 1196dc7483d2..199d0fb6f90a 100644
--- a/sound/soc/qcom/qdsp6/q6asm-dai.c
+++ b/sound/soc/qcom/qdsp6/q6asm-dai.c
@@ -390,7 +390,9 @@ static int q6asm_dai_close(struct snd_pcm_substream *substream)
 	struct q6asm_dai_rtd *prtd = runtime->private_data;
 
 	if (prtd->audio_client) {
-		q6asm_cmd(prtd->audio_client, CMD_CLOSE);
+		if (prtd->state)
+			q6asm_cmd(prtd->audio_client, CMD_CLOSE);
+
 		q6asm_unmap_memory_regions(substream->stream,
 					   prtd->audio_client);
 		q6asm_audio_client_free(prtd->audio_client);
-- 
2.16.2

