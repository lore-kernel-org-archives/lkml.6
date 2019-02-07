Return-Path: <SRS0=4Txr=QO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74551C282C2
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 12:58:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3DFA821904
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 12:58:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="JgfGa/xD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727632AbfBGM6Q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Feb 2019 07:58:16 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:43114 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727621AbfBGM6O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Feb 2019 07:58:14 -0500
Received: by mail-pf1-f194.google.com with SMTP id w73so4723567pfk.10
        for <linux-kernel@vger.kernel.org>; Thu, 07 Feb 2019 04:58:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=DhOH74k9WLUHZ9bc4R59OvEiqm0NxoNRQ6D2mdU8GNA=;
        b=JgfGa/xDJVcgKShX9fKv+jO2xMqrHtpemIF+1QKP5uUtW9DNeAmGjtKpaXnY8h7Gd2
         XyRvEzzkoOir8QfBtzkae+3N99K9yaAiVK0tvCQXWITsyR8D1pEVR0+vkB7tUy5xaE9R
         Z2064Fx9zf4hSE1lJQfjX3mdjKebq6rMlt+Lw7luRP7ZBCrgaL7OKdnGIMhdu/dqITst
         mAJT/5mVBQqp/Hz7qiBR8AYD0HWZmcdVa/08A1s4UbhdXmndIpZUYeoUu5a5pUm1014p
         iS5oY5FiZ2/abEGljYNDhOthiwMkZHucZ9YKsk5xyifCcvV/R46r9N3Q95AMaHlNmQ4n
         GvIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=DhOH74k9WLUHZ9bc4R59OvEiqm0NxoNRQ6D2mdU8GNA=;
        b=pql5bO+EURdZdqHavZ0BTmfJbp4FO3VfiV5mAN/vUJGx4VGlnBmjwbQBcU7mOTG4GX
         Ods7dYGwuxdiK8eRn/hOaPJPPSCXRCc+cJaH/o7oW7P+MRpPq0vwwtQxRX0udP9Ac81v
         AojDJB1fs7vbUQFfEDXsyvI5Qxh8I0xx+CmWlqhbR3Dd5AQbes5RC/F+UDk2zBvlqyOJ
         N+OJjgGzEiUtbBsY0N5id281Mq7VK7xfhfcfwScHxaXL4D4npT+j6t7x0rldJtGiy3B3
         3crsjZc1HJ2Wh045pD9dqxzY5gf6AYg09uhx63yZP5Rsm8ifJ1Z/pUvje+BQNXuhI5tE
         tjcQ==
X-Gm-Message-State: AHQUAuZ3MWznjT3AmFPPZgkT4n6GGVpYYOirE5v+Y/tnZ7lWv5nTNIGs
        BP+JDszyvWqdlgM8Oh4Uom/wQU1U/KE=
X-Google-Smtp-Source: AHgI3IZswpqS9BXtUweo8Lkv6VlZIszZgPd+6TsZmd2//eWCNgcvdobBXOYuA2P6V3/P1g6pe9HmiQ==
X-Received: by 2002:a63:2ac9:: with SMTP id q192mr14686638pgq.58.1549544293499;
        Thu, 07 Feb 2019 04:58:13 -0800 (PST)
Received: from localhost ([2402:3a80:c80:4138:75dd:3900:1d90:762f])
        by smtp.gmail.com with ESMTPSA id i8sm22019348pfj.18.2019.02.07.04.58.12
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 07 Feb 2019 04:58:13 -0800 (PST)
From:   Amit Kucheria <amit.kucheria@linaro.org>
To:     linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        bjorn.andersson@linaro.org, edubezval@gmail.com,
        andy.gross@linaro.org, Daniel Lezcano <daniel.lezcano@linaro.org>,
        David Brown <david.brown@linaro.org>,
        Zhang Rui <rui.zhang@intel.com>
Cc:     linux-pm@vger.kernel.org
Subject: [PATCH v1 11/24] drivers: thermal: tsens: Save reference to the device pointer and use it
Date:   Thu,  7 Feb 2019 16:19:29 +0530
Message-Id: <caf59d37fdde5368daf3b59795f39cfb5b5ea6c0.1549525708.git.amit.kucheria@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1549525708.git.amit.kucheria@linaro.org>
References: <cover.1549525708.git.amit.kucheria@linaro.org>
In-Reply-To: <cover.1549525708.git.amit.kucheria@linaro.org>
References: <cover.1549525708.git.amit.kucheria@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Code cleanup making it easier to read

Signed-off-by: Amit Kucheria <amit.kucheria@linaro.org>
---
 drivers/thermal/qcom/tsens-common.c | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/drivers/thermal/qcom/tsens-common.c b/drivers/thermal/qcom/tsens-common.c
index a82e4c928a78..aae3d71d7eed 100644
--- a/drivers/thermal/qcom/tsens-common.c
+++ b/drivers/thermal/qcom/tsens-common.c
@@ -119,6 +119,7 @@ static const struct regmap_config tsens_srot_config = {
 int __init init_common(struct tsens_priv *priv)
 {
 	void __iomem *tm_base, *srot_base;
+	struct device *dev = priv->dev;
 	struct resource *res;
 	u32 enabled;
 	int ret, i, j;
@@ -135,7 +136,7 @@ int __init init_common(struct tsens_priv *priv)
 		if (IS_ERR(srot_base))
 			return PTR_ERR(srot_base);
 
-		priv->srot_map = devm_regmap_init_mmio(priv->dev, srot_base,
+		priv->srot_map = devm_regmap_init_mmio(dev, srot_base,
 							&tsens_srot_config);
 		if (IS_ERR(priv->srot_map))
 			return PTR_ERR(priv->srot_map);
@@ -150,11 +151,11 @@ int __init init_common(struct tsens_priv *priv)
 	if (IS_ERR(tm_base))
 		return PTR_ERR(tm_base);
 
-	priv->tm_map = devm_regmap_init_mmio(priv->dev, tm_base, &tsens_config);
+	priv->tm_map = devm_regmap_init_mmio(dev, tm_base, &tsens_config);
 	if (IS_ERR(priv->tm_map))
 		return PTR_ERR(priv->tm_map);
 
-	priv->rf[TSENS_EN] = devm_regmap_field_alloc(priv->dev, priv->srot_map,
+	priv->rf[TSENS_EN] = devm_regmap_field_alloc(dev, priv->srot_map,
 						     priv->fields[TSENS_EN]);
 	if (IS_ERR(priv->rf[TSENS_EN]))
 		return PTR_ERR(priv->rf[TSENS_EN]);
@@ -162,24 +163,24 @@ int __init init_common(struct tsens_priv *priv)
 	if (ret)
 		return ret;
 	if (!enabled) {
-		dev_err(priv->dev, "tsens device is not enabled\n");
+		dev_err(dev, "tsens device is not enabled\n");
 		return -ENODEV;
 	}
 
-	priv->rf[SENSOR_EN] = devm_regmap_field_alloc(priv->dev, priv->srot_map,
+	priv->rf[SENSOR_EN] = devm_regmap_field_alloc(dev, priv->srot_map,
 						      priv->fields[SENSOR_EN]);
 	if (IS_ERR(priv->rf[SENSOR_EN]))
 		return PTR_ERR(priv->rf[SENSOR_EN]);
 
 	/* now alloc regmap_fields in tm_map */
 	for (i = 0, j = LAST_TEMP_0; i < priv->num_sensors; i++, j++) {
-		priv->rf[j] = devm_regmap_field_alloc(priv->dev, priv->tm_map,
+		priv->rf[j] = devm_regmap_field_alloc(dev, priv->tm_map,
 						      priv->fields[j]);
 		if (IS_ERR(priv->rf[j]))
 			return PTR_ERR(priv->rf[j]);
 	}
 	for (i = 0, j = VALID_0; i < priv->num_sensors; i++, j++) {
-		priv->rf[j] = devm_regmap_field_alloc(priv->dev, priv->tm_map,
+		priv->rf[j] = devm_regmap_field_alloc(dev, priv->tm_map,
 						      priv->fields[j]);
 		if (IS_ERR(priv->rf[j]))
 			return PTR_ERR(priv->rf[j]);
-- 
2.17.1

