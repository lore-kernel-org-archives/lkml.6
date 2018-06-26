Return-Path: <SRS0=cv1S=JM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E0FAC43144
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 09:23:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E98842677A
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 09:23:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="Je1E1usH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E98842677A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934031AbeFZJXH (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Jun 2018 05:23:07 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:53487 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933915AbeFZJWh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jun 2018 05:22:37 -0400
Received: by mail-wm0-f66.google.com with SMTP id x6-v6so1024764wmc.3
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jun 2018 02:22:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Z8cQifS22+BwNW4/GYrMuZjPH47YuUxuB9EcEpOh/0A=;
        b=Je1E1usH57yMpPxpQmwa4/nzwX3G12VvqkZBzCRPZWgtoqIUOXH3SKaHzBbkrjVTPc
         fqCzPmtKky6s1rtsUs87xepcisP5zQe0GT55HlQ3qc08brvMfEgaIbzT2QvdePgJdVVX
         FTflDaXwtUahDnvhUSXwtsJ1NzdZnV0zOszpU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Z8cQifS22+BwNW4/GYrMuZjPH47YuUxuB9EcEpOh/0A=;
        b=KfASrDUBDMLsRfYpXlzxWeRxD0nEO0A+pYfmx5dooUYaDmPHPLUDFdLMu83dH/g2MG
         ZXzfCmpSvjz3Fg7BYo4xeBeo0dsq/WT912er3AtXZAZvBDJ7RiHb3mnJiwPOaYY9j9wU
         LUswQ5Duh4MNSJ3pMqF+3ldbdKZu7ymS6DX5Tyx3KrizA9VslXgTBIu5MvQOdDdQtejL
         DjLViAh0n6ooA0+KFoiviIraNfm1BNi1HnH6MWthWCqquu5FJsVcRP0FPJZXlys3FDpU
         A3JvLaf5dcsoJl3mZKy6VWI5WMpnXANuCyuZ7rdwhXLu1s1wdeT8IhrPedZ7Btrjjdev
         wEdg==
X-Gm-Message-State: APt69E0ZpVFdUFc5CED+HY4VbEKjOlAMVJZm+hhzX86RsBrM1/BFvrgr
        ZFn3IQ9ta5B3NlUHtt0bJhRI7w==
X-Google-Smtp-Source: AAOMgpfeTl1FhgtoL44WXLGFQPTxVJ9OfosZLVXAcw4zRErzfWwucxbjxmUVTgiLuNFr+rE6Ay5K/w==
X-Received: by 2002:a1c:ab02:: with SMTP id u2-v6mr580875wme.10.1530004956627;
        Tue, 26 Jun 2018 02:22:36 -0700 (PDT)
Received: from localhost.localdomain (cpc90716-aztw32-2-0-cust92.18-1.cable.virginm.net. [86.26.100.93])
        by smtp.gmail.com with ESMTPSA id x5-v6sm1438456wrr.3.2018.06.26.02.22.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 26 Jun 2018 02:22:36 -0700 (PDT)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     broonie@kernel.org, robh+dt@kernel.org, alsa-devel@alsa-project.org
Cc:     devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        lgirdwood@gmail.com, bgoswami@codeaurora.org, tiwai@suse.com,
        perex@perex.cz, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, niklas.cassel@linaro.org,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH v2 12/12] ASoC: qdsp6: q6asm: remove unused struct q6asm member
Date:   Tue, 26 Jun 2018 10:20:16 +0100
Message-Id: <20180626092016.9296-13-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180626092016.9296-1-srinivas.kandagatla@linaro.org>
References: <20180626092016.9296-1-srinivas.kandagatla@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

pcmdev in struct q6asm seems be left over and unused, so just remove it.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 sound/soc/qcom/qdsp6/q6asm.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/sound/soc/qcom/qdsp6/q6asm.c b/sound/soc/qcom/qdsp6/q6asm.c
index c4fd28f168d5..2b2c7233bb5f 100644
--- a/sound/soc/qcom/qdsp6/q6asm.c
+++ b/sound/soc/qcom/qdsp6/q6asm.c
@@ -174,7 +174,6 @@ struct q6asm {
 	struct device *dev;
 	struct q6core_svc_api_info ainfo;
 	wait_queue_head_t mem_wait;
-	struct platform_device *pcmdev;
 	spinlock_t slock;
 	struct audio_client *session[MAX_SESSIONS + 1];
 };
-- 
2.16.2

