Return-Path: <SRS0=4Txr=QO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6AFCC282C2
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 12:57:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8DB1F2190A
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 12:57:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="L1bQ4mXV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727383AbfBGM5K (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Feb 2019 07:57:10 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:36890 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727353AbfBGM5I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Feb 2019 07:57:08 -0500
Received: by mail-pl1-f194.google.com with SMTP id b5so4742791plr.4
        for <linux-kernel@vger.kernel.org>; Thu, 07 Feb 2019 04:57:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=F38/1f+iUBZrVnisIpGjF3Hp0h3BqeGBxfZgCYkmLmo=;
        b=L1bQ4mXVizD1Xxwy0FWGbtUwpPj9kj0ohpkP/IduUWPdiXE2UmcW+s3FTFOaABsenA
         iuklS8oBX0ipYWtzacQXGYeJ9zp4BiGWEmH0ZxgxzatybXiNCshzE9LlAot8yOszXhR7
         tnEJsLwttLm8nnlhpz67Yd9Ty0xscHjwM4fuMMzKG+eyofMdNynrVIRS1MEfmYA0cTJ9
         Hols7WCAd+kzqHaQnUIs0p1Rc7q9qP9iuL63EFcG7g+WWEzf7SCBhxzgtGpHYDtc9N4H
         2yl2pEhJY4mZA1eUbh5QUmuYhG1pORp0GZxsWGnXOzMmbmm15r1RXJyYU8PFInGnUMI2
         Djlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=F38/1f+iUBZrVnisIpGjF3Hp0h3BqeGBxfZgCYkmLmo=;
        b=iwotzztEV3x2sHKtdtbdU78fHVaWxunrjdUH7vXhPVtoSoeVogw8733yTzbEOKBrbt
         GKkK1JxlLE12yCxPFghYX9G4jGyWyJV9m6/6mNxbKFUSu//lMrOVX3zTPIu7wH1TDpZG
         wWAXKbppkfN5fLhiLXyyUvLz98fIwGG1+eBwciLMms4hnva0FLf+t0fTwTv1Sq0bOWLi
         BwCvr7ylY8QbB7jydyFjG3h74co+J3dqFiDiDmAQ0aUPgE/f9lUBGFGc5YYfVLO3kDwi
         BY0YRNK0ub567q8UtAWPqyagh9ThYSvjBxAtKeaNCiSQJMiLhXYolID4l16xqumHWNVX
         yXIg==
X-Gm-Message-State: AHQUAuZsf5AyCkSs1WEu/hIQ/Bbd40cMiaNJzHqJiiED/8UDrPq9PwzP
        sOaoY8KbAMUC69qTdZqQIx+oen8D/rQ=
X-Google-Smtp-Source: AHgI3IbATsGowqoBjtJT9aUwjz/Db4/oHdHiS21hw0UGDNauUI7D8sgOD7G2WD2c3WnMx7DJ4L7suQ==
X-Received: by 2002:a17:902:1745:: with SMTP id i63mr16055283pli.145.1549544227583;
        Thu, 07 Feb 2019 04:57:07 -0800 (PST)
Received: from localhost ([2402:3a80:c80:4138:75dd:3900:1d90:762f])
        by smtp.gmail.com with ESMTPSA id y5sm42218744pge.49.2019.02.07.04.57.06
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 07 Feb 2019 04:57:07 -0800 (PST)
From:   Amit Kucheria <amit.kucheria@linaro.org>
To:     linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        bjorn.andersson@linaro.org, edubezval@gmail.com,
        andy.gross@linaro.org, Daniel Lezcano <daniel.lezcano@linaro.org>,
        David Brown <david.brown@linaro.org>,
        Zhang Rui <rui.zhang@intel.com>
Cc:     linux-pm@vger.kernel.org
Subject: [PATCH v1 19/24] drivers: thermal: tsens: Common get_temp() learns to do ADC conversion
Date:   Thu,  7 Feb 2019 16:19:37 +0530
Message-Id: <187981aec80d2695c6cb4765600d2fe979122805.1549525708.git.amit.kucheria@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1549525708.git.amit.kucheria@linaro.org>
References: <cover.1549525708.git.amit.kucheria@linaro.org>
In-Reply-To: <cover.1549525708.git.amit.kucheria@linaro.org>
References: <cover.1549525708.git.amit.kucheria@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

get_temp() learns to return temperature regardless of whether it is
returned as ADC code or direct temperature.

Signed-off-by: Amit Kucheria <amit.kucheria@linaro.org>
---
 drivers/thermal/qcom/tsens-common.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/drivers/thermal/qcom/tsens-common.c b/drivers/thermal/qcom/tsens-common.c
index ed975a2430d9..a935d2335eea 100644
--- a/drivers/thermal/qcom/tsens-common.c
+++ b/drivers/thermal/qcom/tsens-common.c
@@ -129,10 +129,15 @@ int get_temp_tsens_valid(struct tsens_priv *priv, int i, int *temp)
 	if (ret)
 		return ret;
 
-	mask = GENMASK(priv->fields[LAST_TEMP_0].msb,
-		       priv->fields[LAST_TEMP_0].lsb);
-	/* Convert temperature from deciCelsius to milliCelsius */
-	*temp = sign_extend32(last_temp, fls(mask) - 1) * 100;
+	if (priv->feat->adc) {
+		/* Convert temperature from ADC code to milliCelsius */
+		*temp = code_to_degc(last_temp, s) * 1000;
+	} else {
+		mask = GENMASK(priv->fields[LAST_TEMP_0].msb,
+			       priv->fields[LAST_TEMP_0].lsb);
+		/* Convert temperature from deciCelsius to milliCelsius */
+		*temp = sign_extend32(last_temp, fls(mask) - 1) * 100;
+	}
 
 	return 0;
 }
-- 
2.17.1

