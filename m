Return-Path: <SRS0=cv1S=JM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8096C43144
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 09:23:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 61FD42677B
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 09:23:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="WiSBo2VI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 61FD42677B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934060AbeFZJXJ (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Jun 2018 05:23:09 -0400
Received: from mail-wm0-f48.google.com ([74.125.82.48]:34248 "EHLO
        mail-wm0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933876AbeFZJWg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jun 2018 05:22:36 -0400
Received: by mail-wm0-f48.google.com with SMTP id l15-v6so14706563wmc.1
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jun 2018 02:22:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=E2b1SF4lGljXSzLfPBJn6UYbkgznGupv6vAh0HdCRDw=;
        b=WiSBo2VIvv0zIiPAaiAstN0mLB+Ie6xfF4IWD1J9gArWonO8jGdVczMzamSNW52mAt
         valQvT10y+MlBNSzOZkn4OHO7mHzkmlsewH6gcIkXbO/1mxSfRnSr0yzlcTN7tT/bTAX
         ES2G8QELF74VCqJlGy/gBbkNxz95kpLW2Qs44=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=E2b1SF4lGljXSzLfPBJn6UYbkgznGupv6vAh0HdCRDw=;
        b=sgtvluz17y9GtiegRlaPULRqbQyaQcdJBOLNUx/2iy5TFfcaJSt8oYyIV0ktETsgYw
         guzObXJpdj6K9VHhQKrM6bn2a/AwVrjBYLAAm1nSylv7a2JLD1czjJTRWgbiMvcRrpRQ
         H48CiUZ2P3jQUoa5M761nY58LYL3rlTZj2Fw0nH/yx75bAiPBX3L/8hlJpbsGeyP1Ntq
         DTCG3BUpo80CrioD6m8Gn1iG/+vTLuxxlDkLYkmLuf2JxDFNjpt4cCFTp9wAG294hEuY
         JMxlcWO0lME4zj/b3SeEufj24AKLClQ1cjdLWKTSDJFHkVXyTACs3S5+hRH4I34JAelz
         Vnzg==
X-Gm-Message-State: APt69E3SxhkMbp9SZk2k3mqK6dDQDv2rZAcIudSTt811cd0u30CE8Z6Z
        KkZfyVrDEwnkssnsViD1LeCi8Q==
X-Google-Smtp-Source: AAOMgpfTR1J6W5SXAmymsM/QkUqQ2iA7pd84rmBofWlWZS+mXIeCiX8Npd2xIc3zJmEToJIZyH6pfQ==
X-Received: by 2002:a1c:b3c3:: with SMTP id c186-v6mr984726wmf.41.1530004955576;
        Tue, 26 Jun 2018 02:22:35 -0700 (PDT)
Received: from localhost.localdomain (cpc90716-aztw32-2-0-cust92.18-1.cable.virginm.net. [86.26.100.93])
        by smtp.gmail.com with ESMTPSA id x5-v6sm1438456wrr.3.2018.06.26.02.22.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 26 Jun 2018 02:22:35 -0700 (PDT)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     broonie@kernel.org, robh+dt@kernel.org, alsa-devel@alsa-project.org
Cc:     devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        lgirdwood@gmail.com, bgoswami@codeaurora.org, tiwai@suse.com,
        perex@perex.cz, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, niklas.cassel@linaro.org,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH v2 11/12] ASoC: qdsp6: q6routing: add proper error check
Date:   Tue, 26 Jun 2018 10:20:15 +0100
Message-Id: <20180626092016.9296-12-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180626092016.9296-1-srinivas.kandagatla@linaro.org>
References: <20180626092016.9296-1-srinivas.kandagatla@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

q6adm_open can return error pointer or a null in error cases.
Fix the return handling.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 sound/soc/qcom/qdsp6/q6routing.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/qcom/qdsp6/q6routing.c b/sound/soc/qcom/qdsp6/q6routing.c
index ab696bf8d1d3..c80fdbc2442e 100644
--- a/sound/soc/qcom/qdsp6/q6routing.c
+++ b/sound/soc/qcom/qdsp6/q6routing.c
@@ -310,7 +310,7 @@ int q6routing_stream_open(int fedai_id, int perf_mode,
 			      session->channels, topology, perf_mode,
 			      session->bits_per_sample, 0, 0);
 
-	if (!copp) {
+	if (IS_ERR_OR_NULL(copp)) {
 		mutex_unlock(&routing_data->lock);
 		return -EINVAL;
 	}
-- 
2.16.2

