Return-Path: <SRS0=4Txr=QO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0040C282C2
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 12:58:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8CC2721904
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 12:58:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="OUO6Nc8I"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727309AbfBGM6e (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Feb 2019 07:58:34 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:38100 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727664AbfBGM6c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Feb 2019 07:58:32 -0500
Received: by mail-pg1-f195.google.com with SMTP id g189so4458822pgc.5
        for <linux-kernel@vger.kernel.org>; Thu, 07 Feb 2019 04:58:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=7Kre07rqxuYGmES37cZuu+9CLEHFnu9rKvpL3j9UuBM=;
        b=OUO6Nc8I8vPsMM4z+NMO4fUll1Th63CA+OyRLn1l4OS2tIsT4HvnUYhXsJGWNjsfaQ
         u1h27oPvBfrDOlTIZgCtG6JvbEVrtmZ/DiNoGVcap6lcWY8SiGMp0gVQSSXamixQl0py
         K3PFITXsokOq2djeQuC+vb1o7XtDOgxd1TUAuCvR4nfNOBkiccY6Zh6M8/3ASHfy4e1P
         LTaLdJginablYLBH6ddSWQEE+HwC/XiQnHuPbZeSKhucjqSLje9mFKlEpylGk4Tmvae1
         IcvaJ+Tupn9wwa6zxUOdu9eItiaUievK5fSRnk3tO4b564542bY8VxoczRvKtRF0hpdA
         fA5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=7Kre07rqxuYGmES37cZuu+9CLEHFnu9rKvpL3j9UuBM=;
        b=R7Wtsfz4bIsgMESEGWWCar08zfMCAPWTO4HWxmPDMopqM5PSyp/wjyiustbD6iuJvb
         +of3mRI3kXB2y3FVqiSwOHzpVQsgXumcPUMX3HvjbV3eR/kg5cxdy0WoeEu8t2kS22Eh
         CFUpFv9w6cOjjoJtD5su/plS7NOX0ETPypPgYGTyYsVQfWvfLhOMdHQfkRWrJkHhRI7W
         Zh3U8ejsglyes1fzSluiJaYPXOBaANgssSPYzOBazMVecfQCk3+TUQ/RP17EsXsogSMQ
         lCnQEMT/cv2whyYYeGGjaU+KtFNgW2dMbzyjuf64V4fpmH5Y9PSA9bLXkhcF3aNVfhJm
         LngQ==
X-Gm-Message-State: AHQUAubcJ6roZek3Cx959p3WfIZve+uRPxkC9bSUVnWgAybgskRJ5Fti
        9oTCpXhm7NeLbVOabmP9GwFHp/dxUWU=
X-Google-Smtp-Source: AHgI3IbGBmEb5KLi4nO/yhkb8wczZTbJNTwbsRRrk/oZ9jpoN2IZ7QHubxpPrsbVEsZ02E4tSFD/iA==
X-Received: by 2002:a63:555b:: with SMTP id f27mr9879002pgm.313.1549544311695;
        Thu, 07 Feb 2019 04:58:31 -0800 (PST)
Received: from localhost ([2402:3a80:c80:4138:75dd:3900:1d90:762f])
        by smtp.gmail.com with ESMTPSA id i28sm9894347pfi.171.2019.02.07.04.58.29
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 07 Feb 2019 04:58:31 -0800 (PST)
From:   Amit Kucheria <amit.kucheria@linaro.org>
To:     linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        bjorn.andersson@linaro.org, edubezval@gmail.com,
        andy.gross@linaro.org, Daniel Lezcano <daniel.lezcano@linaro.org>,
        David Brown <david.brown@linaro.org>,
        Zhang Rui <rui.zhang@intel.com>
Cc:     linux-pm@vger.kernel.org
Subject: [PATCH v1 13/24] drivers: thermal: tsens: Print IP version
Date:   Thu,  7 Feb 2019 16:19:31 +0530
Message-Id: <ab6dd34ce0236de12ec1e9984931780c3df643f9.1549525708.git.amit.kucheria@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1549525708.git.amit.kucheria@linaro.org>
References: <cover.1549525708.git.amit.kucheria@linaro.org>
In-Reply-To: <cover.1549525708.git.amit.kucheria@linaro.org>
References: <cover.1549525708.git.amit.kucheria@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On some TSENS IP, version is stored. Print that version at init.

Signed-off-by: Amit Kucheria <amit.kucheria@linaro.org>
---
 drivers/thermal/qcom/tsens-common.c | 23 ++++++++++++++++++++++-
 1 file changed, 22 insertions(+), 1 deletion(-)

diff --git a/drivers/thermal/qcom/tsens-common.c b/drivers/thermal/qcom/tsens-common.c
index aae3d71d7eed..39cd5733fd44 100644
--- a/drivers/thermal/qcom/tsens-common.c
+++ b/drivers/thermal/qcom/tsens-common.c
@@ -121,7 +121,7 @@ int __init init_common(struct tsens_priv *priv)
 	void __iomem *tm_base, *srot_base;
 	struct device *dev = priv->dev;
 	struct resource *res;
-	u32 enabled;
+	u32 enabled, maj_ver, min_ver;
 	int ret, i, j;
 	struct platform_device *op = of_find_device_by_node(priv->dev->of_node);
 
@@ -155,6 +155,27 @@ int __init init_common(struct tsens_priv *priv)
 	if (IS_ERR(priv->tm_map))
 		return PTR_ERR(priv->tm_map);
 
+	for (i = 0; i < MAX_REGFIELDS; i++) {
+		priv->rf[i] = NULL;
+	}
+
+	/* alloc regmap_fields in srot_map */
+	if (priv->feat->ver_info) {
+		for (i = 0, j = VER_MAJOR; i < 2; i++, j++) {
+			priv->rf[j] = devm_regmap_field_alloc(dev, priv->srot_map,
+							      priv->fields[j]);
+			if (IS_ERR(priv->rf[j]))
+				return PTR_ERR(priv->rf[j]);
+		}
+		ret = regmap_field_read(priv->rf[VER_MAJOR], &maj_ver);
+		if (ret)
+			return ret;
+		ret = regmap_field_read(priv->rf[VER_MINOR], &min_ver);
+		if (ret)
+			return ret;
+		dev_info(dev, "version: %d.%d\n", maj_ver, min_ver);
+	}
+
 	priv->rf[TSENS_EN] = devm_regmap_field_alloc(dev, priv->srot_map,
 						     priv->fields[TSENS_EN]);
 	if (IS_ERR(priv->rf[TSENS_EN]))
-- 
2.17.1

