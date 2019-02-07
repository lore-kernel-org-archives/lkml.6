Return-Path: <SRS0=4Txr=QO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A5F5C282C2
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 12:57:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4A3FF2190A
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 12:57:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="UW9DDb/p"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727350AbfBGM5G (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Feb 2019 07:57:06 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:45137 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727328AbfBGM5E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Feb 2019 07:57:04 -0500
Received: by mail-pg1-f194.google.com with SMTP id y4so4441705pgc.12
        for <linux-kernel@vger.kernel.org>; Thu, 07 Feb 2019 04:57:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=wVxETCRj9csXkr178RqwaQ70WDjkLA5uLcl3mAGgLOI=;
        b=UW9DDb/pi65Xvl3Vz6Dw/OUA3Fl59q2P8ug5ik4Lqrdku78njfs4S7lYoVItyoKwSS
         0Jki7sO0+S3jNoH006zE3qz+5wKYGMmrzS5X5ddkHMtPV322cM/zL/bsSZP5t8iII9n8
         l2mf+IDhm+NGDwIuFQ3JP2bmyNVO2NtB3ldcuMT0pFfuDVmv8fsojOhgkwOdMGZ0sF5J
         YvckbF/fXCv0PBXq3dYxqBNjrD7+P3qDvZ6h2mSsqjBd73D0T6tECYz9Cqb8+QtChgSI
         FVODwGrNHYkr6u9xokCGlkRK5tC1GJkoMfms/w8fpwfbFTUEWQpFTU/7HxNIwXcSMwuO
         6aKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=wVxETCRj9csXkr178RqwaQ70WDjkLA5uLcl3mAGgLOI=;
        b=DUeDF0T5tOPEHfDityLvNfrjrGcsrTJkqTZfYOABqEbu7YS7GCArtNjboMR0yFntPM
         RqEsvLfEU2sPjIrNbYMHVQr9dJAG3g2Nte82Wir9RwoZv8NB/M00/DUGLyBAskFYwKiw
         10WOF25b72SoMaRRSa0Ewh7QvjojuG7NBi4AWYAiaSdp/E8wcvq7Jy9gfHNkHycX/K5S
         DU9LpWsMleLS5j7zSxRvNKrG1NopknLpoQvRZrlITk8lH+tUb+TkHFeA68iX7xu23Z9r
         obgHO+BRJU4xG4w6tPY3EJQTc0vjZuK4dVrCqXgEZEpIZ+OrI72blU3voC7aR1QEdYov
         RiLg==
X-Gm-Message-State: AHQUAuZtIAEi0Hs/zXcn5LZ3YqlZR6bgi+N0TjU1g6WXuGlBa84lQuab
        eEMtW9mnE69C6rA7+ldotEQQcvD25ic=
X-Google-Smtp-Source: AHgI3IZr/oJ97iPLgE5/4pLR/BPeSCbmoogs1PFg2iKQi3hqj9FIYA0Mt7NU3poy6wgKCcYOSkNi9A==
X-Received: by 2002:a63:4d22:: with SMTP id a34mr12920642pgb.432.1549544223702;
        Thu, 07 Feb 2019 04:57:03 -0800 (PST)
Received: from localhost ([2402:3a80:c80:4138:75dd:3900:1d90:762f])
        by smtp.gmail.com with ESMTPSA id l74sm19418631pfb.145.2019.02.07.04.57.02
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 07 Feb 2019 04:57:03 -0800 (PST)
From:   Amit Kucheria <amit.kucheria@linaro.org>
To:     linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        bjorn.andersson@linaro.org, edubezval@gmail.com,
        andy.gross@linaro.org, Daniel Lezcano <daniel.lezcano@linaro.org>,
        David Brown <david.brown@linaro.org>,
        Zhang Rui <rui.zhang@intel.com>
Cc:     linux-pm@vger.kernel.org
Subject: [PATCH v1 18/24] drivers: thermal: tsens: Move get_temp_tsens_v2 to allow sharing
Date:   Thu,  7 Feb 2019 16:19:36 +0530
Message-Id: <461cc91a35b5766fe1b44a5fae647c40e4de7f80.1549525708.git.amit.kucheria@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1549525708.git.amit.kucheria@linaro.org>
References: <cover.1549525708.git.amit.kucheria@linaro.org>
In-Reply-To: <cover.1549525708.git.amit.kucheria@linaro.org>
References: <cover.1549525708.git.amit.kucheria@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Just rename the function and move it to allow code sharing with future
versions of TSENS IP

Signed-off-by: Amit Kucheria <amit.kucheria@linaro.org>
---
 drivers/thermal/qcom/tsens-common.c | 35 +++++++++++++++++++++++++++
 drivers/thermal/qcom/tsens-v2.c     | 37 +----------------------------
 drivers/thermal/qcom/tsens.h        |  1 +
 3 files changed, 37 insertions(+), 36 deletions(-)

diff --git a/drivers/thermal/qcom/tsens-common.c b/drivers/thermal/qcom/tsens-common.c
index d981effed493..ed975a2430d9 100644
--- a/drivers/thermal/qcom/tsens-common.c
+++ b/drivers/thermal/qcom/tsens-common.c
@@ -102,6 +102,41 @@ static inline int code_to_degc(u32 adc_code, const struct tsens_sensor *s)
 	return degc;
 }
 
+int get_temp_tsens_valid(struct tsens_priv *priv, int i, int *temp)
+{
+	struct tsens_sensor *s = &priv->sensor[i];
+	u32 temp_idx = LAST_TEMP_0 + s->hw_id;
+	u32 valid_idx = VALID_0 + s->hw_id;
+	u32 last_temp = 0, valid, mask;
+	int ret;
+
+	ret = regmap_field_read(priv->rf[valid_idx], &valid);
+	if (ret)
+		return ret;
+	while (!valid) {
+		/* Valid bit is 0 for 6 AHB clock cycles.
+		 * At 19.2MHz, 1 AHB clock is ~60ns.
+		 * We should enter this loop very, very rarely.
+		 */
+		ndelay(400);
+		ret = regmap_field_read(priv->rf[valid_idx], &valid);
+		if (ret)
+			return ret;
+	}
+
+	/* Valid bit is set, OK to read the temperature */
+	ret = regmap_field_read(priv->rf[temp_idx], &last_temp);
+	if (ret)
+		return ret;
+
+	mask = GENMASK(priv->fields[LAST_TEMP_0].msb,
+		       priv->fields[LAST_TEMP_0].lsb);
+	/* Convert temperature from deciCelsius to milliCelsius */
+	*temp = sign_extend32(last_temp, fls(mask) - 1) * 100;
+
+	return 0;
+}
+
 int get_temp_common(struct tsens_priv *priv, int i, int *temp)
 {
 	struct tsens_sensor *s = &priv->sensor[i];
diff --git a/drivers/thermal/qcom/tsens-v2.c b/drivers/thermal/qcom/tsens-v2.c
index 0ea93b89bc65..d436b96a6f18 100644
--- a/drivers/thermal/qcom/tsens-v2.c
+++ b/drivers/thermal/qcom/tsens-v2.c
@@ -25,41 +25,6 @@
 #define TM_Sn_STATUS_OFF		0x00a0
 #define TM_TRDY_OFF			0x00e4
 
-static int get_temp_tsens_v2(struct tsens_priv *priv, int i, int *temp)
-{
-	struct tsens_sensor *s = &priv->sensor[i];
-	u32 temp_idx = LAST_TEMP_0 + s->hw_id;
-	u32 valid_idx = VALID_0 + s->hw_id;
-	u32 last_temp = 0, valid, mask;
-	int ret;
-
-	ret = regmap_field_read(priv->rf[valid_idx], &valid);
-	if (ret)
-		return ret;
-	while (!valid) {
-		/* Valid bit is 0 for 6 AHB clock cycles.
-		 * At 19.2MHz, 1 AHB clock is ~60ns.
-		 * We should enter this loop very, very rarely.
-		 */
-		ndelay(400);
-		ret = regmap_field_read(priv->rf[valid_idx], &valid);
-		if (ret)
-			return ret;
-	}
-
-	/* Valid bit is set, OK to read the temperature */
-	ret = regmap_field_read(priv->rf[temp_idx], &last_temp);
-	if (ret)
-		return ret;
-
-	mask = GENMASK(priv->fields[LAST_TEMP_0].msb,
-		       priv->fields[LAST_TEMP_0].lsb);
-	/* Convert temperature from deciCelsius to milliCelsius */
-	*temp = sign_extend32(last_temp, fls(mask) - 1) * 100;
-
-	return 0;
-}
-
 /* v2.x: 8996, 8998, sdm845 */
 
 const struct tsens_features tsens_v2_feat = {
@@ -136,7 +101,7 @@ const struct reg_field tsens_v2_regfields[MAX_REGFIELDS] = {
 
 static const struct tsens_ops ops_generic_v2 = {
 	.init		= init_common,
-	.get_temp	= get_temp_tsens_v2,
+	.get_temp	= get_temp_tsens_valid,
 };
 
 const struct tsens_plat_data data_tsens_v2 = {
diff --git a/drivers/thermal/qcom/tsens.h b/drivers/thermal/qcom/tsens.h
index 9db89dffb719..4b3d71b26c97 100644
--- a/drivers/thermal/qcom/tsens.h
+++ b/drivers/thermal/qcom/tsens.h
@@ -255,6 +255,7 @@ struct tsens_priv {
 char *qfprom_read(struct device *dev, const char *cname);
 void compute_intercept_slope(struct tsens_priv *priv, u32 *pt1, u32 *pt2, u32 mode);
 int init_common(struct tsens_priv *priv);
+int get_temp_tsens_valid(struct tsens_priv *priv, int i, int *temp);
 int get_temp_common(struct tsens_priv *priv, int i, int *temp);
 bool is_sensor_enabled(struct tsens_priv *priv, u32 hw_id);
 
-- 
2.17.1

