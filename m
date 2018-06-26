Return-Path: <SRS0=cv1S=JM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F95DC43145
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 09:22:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BDD5E2677A
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 09:22:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="FZNQGjeK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BDD5E2677A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933982AbeFZJWj (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Jun 2018 05:22:39 -0400
Received: from mail-wr0-f193.google.com ([209.85.128.193]:44534 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933794AbeFZJWc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jun 2018 05:22:32 -0400
Received: by mail-wr0-f193.google.com with SMTP id p12-v6so14823106wrn.11
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jun 2018 02:22:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Pyv1sGt65yF554e8vZ0B1y+2vFmmAQCdYZPZIKxIZYM=;
        b=FZNQGjeKjhaMGmMQFLsKYA0/FjQDWD06mn2tZ67deyQBKg/HntOIvXMZ22FEzv72p1
         SdF/ZuQ3EQZbmbv8jLd8QsICeJyYgtWaRCOvB1AalvoYZeAdUGMMnTbx5mPr+FUiMJQS
         OUPf/3EdgECvrbai4HCqXD1sCp0ZHwoN7hoKI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Pyv1sGt65yF554e8vZ0B1y+2vFmmAQCdYZPZIKxIZYM=;
        b=UgQWYTOYW8hiZr/8amxZ/a9tykJlldoCmjAFrRSOLhOSM4KmH4JDEqGO19h4yZVYCV
         ejcJmri7SjUPa0Lrezb6Q2oANqSTUZU3jH7PnPkS2yiuM3DgOiq1cAPVqZa+X8Rfr6Ge
         rNzEIFeqC2dEl2iTveG0MRwZ+Y8ZZAywtcIyMPdjCYAtEFt1ii9b7LbB2IGFLvkZKfA+
         EB0lFbJNMdDhwm5uYLr6rWhAAQs8oTZoXPqkF1SzlAUAfbo6ejb9iqcTKssCrlr7BZ9O
         RUB+5k2F8DshGAXkdxtOlfkazEQnOG3DvNThZXgsq9Ub0cvQDOez0NE+Wj41ynoyH/vO
         WT+A==
X-Gm-Message-State: APt69E3DJjWIiWlETNM4r1gHoXgmgby9zZOSbsidGoaqPdJhy+cOGp6a
        POVJzvymH7wefTLtZgSjm+FjPA==
X-Google-Smtp-Source: AAOMgpffIwoHFQ9gWeh21w+CSbJQCTVUnuqUPx50XdB1jM6YLo4Dp+Aov2GtD4D8/eTud+oEbPVEFg==
X-Received: by 2002:adf:b710:: with SMTP id l16-v6mr741965wre.115.1530004951104;
        Tue, 26 Jun 2018 02:22:31 -0700 (PDT)
Received: from localhost.localdomain (cpc90716-aztw32-2-0-cust92.18-1.cable.virginm.net. [86.26.100.93])
        by smtp.gmail.com with ESMTPSA id x5-v6sm1438456wrr.3.2018.06.26.02.22.30
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 26 Jun 2018 02:22:30 -0700 (PDT)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     broonie@kernel.org, robh+dt@kernel.org, alsa-devel@alsa-project.org
Cc:     devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        lgirdwood@gmail.com, bgoswami@codeaurora.org, tiwai@suse.com,
        perex@perex.cz, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, niklas.cassel@linaro.org,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH v2 07/12] ASoC: qdsp6: q6afe-dai: support dt based module loading
Date:   Tue, 26 Jun 2018 10:20:11 +0100
Message-Id: <20180626092016.9296-8-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180626092016.9296-1-srinivas.kandagatla@linaro.org>
References: <20180626092016.9296-1-srinivas.kandagatla@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch uses new compatible string to make DT based module loading work.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 sound/soc/qcom/qdsp6/q6afe-dai.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/sound/soc/qcom/qdsp6/q6afe-dai.c b/sound/soc/qcom/qdsp6/q6afe-dai.c
index 5002dd05bf27..1d2e5013c121 100644
--- a/sound/soc/qcom/qdsp6/q6afe-dai.c
+++ b/sound/soc/qcom/qdsp6/q6afe-dai.c
@@ -1290,9 +1290,16 @@ static int q6afe_dai_dev_remove(struct platform_device *pdev)
 	return 0;
 }
 
+static const struct of_device_id q6afe_dai_device_id[] = {
+	{ .compatible = "qcom,q6afe-dais" },
+	{},
+};
+MODULE_DEVICE_TABLE(of, q6afe_dai_device_id);
+
 static struct platform_driver q6afe_dai_platform_driver = {
 	.driver = {
 		.name = "q6afe-dai",
+		.of_match_table = of_match_ptr(q6afe_dai_device_id),
 	},
 	.probe = q6afe_dai_dev_probe,
 	.remove = q6afe_dai_dev_remove,
-- 
2.16.2

