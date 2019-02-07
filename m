Return-Path: <SRS0=4Txr=QO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9290CC282C2
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 12:57:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5C6A121904
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 12:57:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Rw4Veysd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727324AbfBGM5B (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Feb 2019 07:57:01 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:36848 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727200AbfBGM5A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Feb 2019 07:57:00 -0500
Received: by mail-pg1-f196.google.com with SMTP id n2so4460550pgm.3
        for <linux-kernel@vger.kernel.org>; Thu, 07 Feb 2019 04:57:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=mSp0BJaAkKriZPizUSoQw+VR9SnVdso3SWK1GQEdFzY=;
        b=Rw4VeysdYDxv46ohT/hQhRZ61k/cyvNP2LNx3OQuYGCjF6+NpvEGujKlN1blLXLjZr
         SavbJH9YLLXqOeQEbyAhBTX57keBIhBZFLYmqFBWd4Q3t4rAuy/jvjhQMRZZiy6JQJnW
         onbViFZNGbmr1Pv4AO7/DN5T9SxP5uvvRZ4Q3COF9RbvCnYlL74oQe9IzyFTljMUAQTM
         YxdBrngtI98QAfWZiI6sHzXRzxWrQ0oZYfUCRvif/s6i44V5D32clZtKy8bR8zyJLKcm
         ww9JST7zgyGPimH8hUVLBlOHbSJq9O3mMDj3FyJ0ODxRHMQV4y3RrXvq+rD5OuNs509a
         pbDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=mSp0BJaAkKriZPizUSoQw+VR9SnVdso3SWK1GQEdFzY=;
        b=EPpLD4McRd4koHWzb+nhIrLrMtdlCHoWf6Aoa/Dcuy4THVzOstLCSK6DTkqowp5eDG
         khS+cpVVDj1jwnVcXvzvop8X4AM+hWcnL+VbMjG9XoNmahOmO4pyl5QKg5Zc7WV53+53
         u168JNqEfwlcw13bTpc0gICV4eLFpnUoq/0A26raNT5LdpQEFjRwaE1JJg2t+g9KKNvV
         U1BtLIGSg7gqSXDlR9NQGQew+K6Pceb8WWLSg99JFbx9vGsXS7G/bEg4vTBDOzlnyo3n
         I1s6LvgPtcfNhPDSiM6xHGxE6/qHPaQC4ekk3u/ZyszY8UjJKkB2IlLfRBExo697qV2u
         WvPA==
X-Gm-Message-State: AHQUAuZY4TMAFEFBjdnM/syqlfh9mybfZHoSw/XysoND49ysPYAo13+E
        fUzXOSm5LN4n5wZ5LAk1/ogOxVHYTvM=
X-Google-Smtp-Source: AHgI3IampPr/DGPACAjc6CAaEhObtQ0u59f5LcVD10hy3/z/gIKBi6Xu47qY7EQzvZNbE14bIrOu9w==
X-Received: by 2002:a63:2406:: with SMTP id k6mr14174003pgk.229.1549544219356;
        Thu, 07 Feb 2019 04:56:59 -0800 (PST)
Received: from localhost ([2402:3a80:c80:4138:75dd:3900:1d90:762f])
        by smtp.gmail.com with ESMTPSA id z14sm10034958pgv.47.2019.02.07.04.56.39
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 07 Feb 2019 04:56:58 -0800 (PST)
From:   Amit Kucheria <amit.kucheria@linaro.org>
To:     linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        bjorn.andersson@linaro.org, edubezval@gmail.com,
        andy.gross@linaro.org, Daniel Lezcano <daniel.lezcano@linaro.org>,
        David Brown <david.brown@linaro.org>,
        Zhang Rui <rui.zhang@intel.com>
Cc:     linux-pm@vger.kernel.org
Subject: [PATCH v1 17/24] drivers: thermal: tsens: simplify get_temp_tsens_v2 routine
Date:   Thu,  7 Feb 2019 16:19:35 +0530
Message-Id: <9ee687bdeb1c0529038be823947da02f7d368f53.1549525708.git.amit.kucheria@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1549525708.git.amit.kucheria@linaro.org>
References: <cover.1549525708.git.amit.kucheria@linaro.org>
In-Reply-To: <cover.1549525708.git.amit.kucheria@linaro.org>
References: <cover.1549525708.git.amit.kucheria@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The current implementation is based on an algorithm published in the
docs. Instead of reading the temperature thrice w/o any explanation,
improve the algorithm.

This will become the basis for a common get_temp routine in the future.

Signed-off-by: Amit Kucheria <amit.kucheria@linaro.org>
---
 drivers/thermal/qcom/tsens-v2.c | 55 ++++++++++-----------------------
 1 file changed, 17 insertions(+), 38 deletions(-)

diff --git a/drivers/thermal/qcom/tsens-v2.c b/drivers/thermal/qcom/tsens-v2.c
index 8052266447f5..0ea93b89bc65 100644
--- a/drivers/thermal/qcom/tsens-v2.c
+++ b/drivers/thermal/qcom/tsens-v2.c
@@ -25,58 +25,37 @@
 #define TM_Sn_STATUS_OFF		0x00a0
 #define TM_TRDY_OFF			0x00e4
 
-#define LAST_TEMP_MASK		0xfff
-
-static int get_temp_tsens_v2(struct tsens_priv *priv, int id, int *temp)
+static int get_temp_tsens_v2(struct tsens_priv *priv, int i, int *temp)
 {
-	struct tsens_sensor *s = &priv->sensor[id];
+	struct tsens_sensor *s = &priv->sensor[i];
 	u32 temp_idx = LAST_TEMP_0 + s->hw_id;
 	u32 valid_idx = VALID_0 + s->hw_id;
-	u32 last_temp = 0, last_temp2 = 0, last_temp3 = 0, valid;
+	u32 last_temp = 0, valid, mask;
 	int ret;
 
-	ret = regmap_field_read(priv->rf[temp_idx], &last_temp);
-	if (ret)
-		return ret;
-
 	ret = regmap_field_read(priv->rf[valid_idx], &valid);
 	if (ret)
 		return ret;
-
-	if (valid)
-		goto done;
-
-	/* Try a second time */
-	ret = regmap_field_read(priv->rf[valid_idx], &valid);
-	if (ret)
-		return ret;
-	ret = regmap_field_read(priv->rf[temp_idx], &last_temp2);
-	if (ret)
-		return ret;
-	if (valid) {
-		last_temp = last_temp2;
-		goto done;
+	while (!valid) {
+		/* Valid bit is 0 for 6 AHB clock cycles.
+		 * At 19.2MHz, 1 AHB clock is ~60ns.
+		 * We should enter this loop very, very rarely.
+		 */
+		ndelay(400);
+		ret = regmap_field_read(priv->rf[valid_idx], &valid);
+		if (ret)
+			return ret;
 	}
 
-	/* Try a third/last time */
-	ret = regmap_field_read(priv->rf[valid_idx], &valid);
-	if (ret)
-		return ret;
-	ret = regmap_field_read(priv->rf[temp_idx], &last_temp3);
+	/* Valid bit is set, OK to read the temperature */
+	ret = regmap_field_read(priv->rf[temp_idx], &last_temp);
 	if (ret)
 		return ret;
-	if (valid) {
-		last_temp = last_temp3;
-		goto done;
-	}
 
-	if (last_temp == last_temp2)
-		last_temp = last_temp2;
-	else if (last_temp2 == last_temp3)
-		last_temp = last_temp3;
-done:
+	mask = GENMASK(priv->fields[LAST_TEMP_0].msb,
+		       priv->fields[LAST_TEMP_0].lsb);
 	/* Convert temperature from deciCelsius to milliCelsius */
-	*temp = sign_extend32(last_temp, fls(LAST_TEMP_MASK) - 1) * 100;
+	*temp = sign_extend32(last_temp, fls(mask) - 1) * 100;
 
 	return 0;
 }
-- 
2.17.1

