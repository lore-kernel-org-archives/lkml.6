Return-Path: <SRS0=4Txr=QO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF5CEC282C2
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 12:58:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A23F421904
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 12:58:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="kqUUuTqf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727572AbfBGM6C (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Feb 2019 07:58:02 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:35911 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727551AbfBGM6B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Feb 2019 07:58:01 -0500
Received: by mail-pg1-f194.google.com with SMTP id n2so4461652pgm.3
        for <linux-kernel@vger.kernel.org>; Thu, 07 Feb 2019 04:58:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=s/+Bl7ZGzK0cL5xDzP2iXR4sdWkOPpcYJr4QjVnhB2E=;
        b=kqUUuTqf6t77NM2iITIK9KZYMmkFrG7p/o5oOL3T33x4MXiTQionlWirsNZlJWaOWC
         x9otmvrNrBcI9KmbSy9N84eDBK70OoI5U0i2RCOxTiqw5l4rqFawHU+GfKSetwteRasn
         xOlLv4lNubM64WrzRuMuNDpi1Iryj/j/ScvOClDM/Bov0Yk1ci6WbxHjqCoDRhPJfVYF
         KNOTMalZKMQkYpOi8b3V233YGWvVbRrwsvsEDmozoYJR3dZMjVTcP+bfrthnenQGGvDm
         XSR4vZ/7XQxphTjIPy/4KnX+dLsATTqMnnHpFkRUOGEVIGA4aWdZ/4pFkx5Lre1wqgib
         UpZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=s/+Bl7ZGzK0cL5xDzP2iXR4sdWkOPpcYJr4QjVnhB2E=;
        b=UTDLWnM4sOp3JzMNqn5eVEhLnyNpf7I/VvTPADLngobqk919Yidth0/4cBsEri6tVQ
         1G2S2JS90ciGxJTYXJeyO7KBuH4heD/2g/rCUmEfu4qA3M66Xevf5rdjp1CP9JHC+60S
         jpgxfWv14KkOKD5fPICicVkP2sZ5NEp6ooRE9iGl5tFXQe2eHgYtUdVsFl+PdXM0+qu/
         5Bf739u5le22xLlHSe3CxivzaREs5xbKXOcslGZ/yYQt33Ey90TfrBRmRIoazvlB87OL
         Rfkl9hBXwukZw8EpOlPGyIFPTmEGIpR3aDT1qlVUR3RKWtiBESCiv7oYMaMxektoEld+
         TnzQ==
X-Gm-Message-State: AHQUAuYtpLlOCHO3DN6Nq5Db9aPpB1IUI8/w58IpnzZs9AixoDVhAbPg
        UIRsCe7ZffZ+iCsGk7IIZG9b/e2aHsQ=
X-Google-Smtp-Source: AHgI3IZB3sTz3fXHDZSajKKA93HyX/qYiueyNM6oi02ab5S6k4leZ51zCGoegkBGY524maHeWApvqQ==
X-Received: by 2002:aa7:8286:: with SMTP id s6mr15777283pfm.63.1549544280325;
        Thu, 07 Feb 2019 04:58:00 -0800 (PST)
Received: from localhost ([2402:3a80:c80:4138:75dd:3900:1d90:762f])
        by smtp.gmail.com with ESMTPSA id i5sm13404835pfg.34.2019.02.07.04.57.58
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 07 Feb 2019 04:57:59 -0800 (PST)
From:   Amit Kucheria <amit.kucheria@linaro.org>
To:     linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        bjorn.andersson@linaro.org, edubezval@gmail.com,
        andy.gross@linaro.org, Daniel Lezcano <daniel.lezcano@linaro.org>,
        David Brown <david.brown@linaro.org>,
        Zhang Rui <rui.zhang@intel.com>
Cc:     linux-pm@vger.kernel.org
Subject: [PATCH v1 08/24] drivers: thermal: tsens: Rename constants to prepare to merge with tsens-8974
Date:   Thu,  7 Feb 2019 16:19:26 +0530
Message-Id: <459c70bd13bf8a9231fa3f1c9694231fb9169d18.1549525708.git.amit.kucheria@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1549525708.git.amit.kucheria@linaro.org>
References: <cover.1549525708.git.amit.kucheria@linaro.org>
In-Reply-To: <cover.1549525708.git.amit.kucheria@linaro.org>
References: <cover.1549525708.git.amit.kucheria@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some #defines in tsens-v_0_1.c clash with those in tsens-8974.c. Prefix
them with 8916 to avoid the clash so we can merge the two files.

Signed-off-by: Amit Kucheria <amit.kucheria@linaro.org>
---
 drivers/thermal/qcom/tsens-v0_1.c | 88 +++++++++++++++----------------
 1 file changed, 44 insertions(+), 44 deletions(-)

diff --git a/drivers/thermal/qcom/tsens-v0_1.c b/drivers/thermal/qcom/tsens-v0_1.c
index d4ad4082c800..30909594b1cf 100644
--- a/drivers/thermal/qcom/tsens-v0_1.c
+++ b/drivers/thermal/qcom/tsens-v0_1.c
@@ -7,37 +7,37 @@
 #include "tsens.h"
 
 /* eeprom layout data for 8916 */
-#define BASE0_MASK	0x0000007f
-#define BASE1_MASK	0xfe000000
-#define BASE0_SHIFT	0
-#define BASE1_SHIFT	25
-
-#define S0_P1_MASK	0x00000f80
-#define S1_P1_MASK	0x003e0000
-#define S2_P1_MASK	0xf8000000
-#define S3_P1_MASK	0x000003e0
-#define S4_P1_MASK	0x000f8000
-
-#define S0_P2_MASK	0x0001f000
-#define S1_P2_MASK	0x07c00000
-#define S2_P2_MASK	0x0000001f
-#define S3_P2_MASK	0x00007c00
-#define S4_P2_MASK	0x01f00000
-
-#define S0_P1_SHIFT	7
-#define S1_P1_SHIFT	17
-#define S2_P1_SHIFT	27
-#define S3_P1_SHIFT	5
-#define S4_P1_SHIFT	15
-
-#define S0_P2_SHIFT	12
-#define S1_P2_SHIFT	22
-#define S2_P2_SHIFT	0
-#define S3_P2_SHIFT	10
-#define S4_P2_SHIFT	20
-
-#define CAL_SEL_MASK	0xe0000000
-#define CAL_SEL_SHIFT	29
+#define MSM8916_BASE0_MASK	0x0000007f
+#define MSM8916_BASE1_MASK	0xfe000000
+#define MSM8916_BASE0_SHIFT	0
+#define MSM8916_BASE1_SHIFT	25
+
+#define MSM8916_S0_P1_MASK	0x00000f80
+#define MSM8916_S1_P1_MASK	0x003e0000
+#define MSM8916_S2_P1_MASK	0xf8000000
+#define MSM8916_S3_P1_MASK	0x000003e0
+#define MSM8916_S4_P1_MASK	0x000f8000
+
+#define MSM8916_S0_P2_MASK	0x0001f000
+#define MSM8916_S1_P2_MASK	0x07c00000
+#define MSM8916_S2_P2_MASK	0x0000001f
+#define MSM8916_S3_P2_MASK	0x00007c00
+#define MSM8916_S4_P2_MASK	0x01f00000
+
+#define MSM8916_S0_P1_SHIFT	7
+#define MSM8916_S1_P1_SHIFT	17
+#define MSM8916_S2_P1_SHIFT	27
+#define MSM8916_S3_P1_SHIFT	5
+#define MSM8916_S4_P1_SHIFT	15
+
+#define MSM8916_S0_P2_SHIFT	12
+#define MSM8916_S1_P2_SHIFT	22
+#define MSM8916_S2_P2_SHIFT	0
+#define MSM8916_S3_P2_SHIFT	10
+#define MSM8916_S4_P2_SHIFT	20
+
+#define MSM8916_CAL_SEL_MASK	0xe0000000
+#define MSM8916_CAL_SEL_SHIFT	29
 
 static int calibrate_8916(struct tsens_priv *priv)
 {
@@ -54,27 +54,27 @@ static int calibrate_8916(struct tsens_priv *priv)
 	if (IS_ERR(qfprom_csel))
 		return PTR_ERR(qfprom_csel);
 
-	mode = (qfprom_csel[0] & CAL_SEL_MASK) >> CAL_SEL_SHIFT;
+	mode = (qfprom_csel[0] & MSM8916_CAL_SEL_MASK) >> MSM8916_CAL_SEL_SHIFT;
 	dev_dbg(priv->dev, "calibration mode is %d\n", mode);
 
 	switch (mode) {
 	case TWO_PT_CALIB:
-		base1 = (qfprom_cdata[1] & BASE1_MASK) >> BASE1_SHIFT;
-		p2[0] = (qfprom_cdata[0] & S0_P2_MASK) >> S0_P2_SHIFT;
-		p2[1] = (qfprom_cdata[0] & S1_P2_MASK) >> S1_P2_SHIFT;
-		p2[2] = (qfprom_cdata[1] & S2_P2_MASK) >> S2_P2_SHIFT;
-		p2[3] = (qfprom_cdata[1] & S3_P2_MASK) >> S3_P2_SHIFT;
-		p2[4] = (qfprom_cdata[1] & S4_P2_MASK) >> S4_P2_SHIFT;
+		base1 = (qfprom_cdata[1] & MSM8916_BASE1_MASK) >> MSM8916_BASE1_SHIFT;
+		p2[0] = (qfprom_cdata[0] & MSM8916_S0_P2_MASK) >> MSM8916_S0_P2_SHIFT;
+		p2[1] = (qfprom_cdata[0] & MSM8916_S1_P2_MASK) >> MSM8916_S1_P2_SHIFT;
+		p2[2] = (qfprom_cdata[1] & MSM8916_S2_P2_MASK) >> MSM8916_S2_P2_SHIFT;
+		p2[3] = (qfprom_cdata[1] & MSM8916_S3_P2_MASK) >> MSM8916_S3_P2_SHIFT;
+		p2[4] = (qfprom_cdata[1] & MSM8916_S4_P2_MASK) >> MSM8916_S4_P2_SHIFT;
 		for (i = 0; i < priv->num_sensors; i++)
 			p2[i] = ((base1 + p2[i]) << 3);
 		/* Fall through */
 	case ONE_PT_CALIB2:
-		base0 = (qfprom_cdata[0] & BASE0_MASK);
-		p1[0] = (qfprom_cdata[0] & S0_P1_MASK) >> S0_P1_SHIFT;
-		p1[1] = (qfprom_cdata[0] & S1_P1_MASK) >> S1_P1_SHIFT;
-		p1[2] = (qfprom_cdata[0] & S2_P1_MASK) >> S2_P1_SHIFT;
-		p1[3] = (qfprom_cdata[1] & S3_P1_MASK) >> S3_P1_SHIFT;
-		p1[4] = (qfprom_cdata[1] & S4_P1_MASK) >> S4_P1_SHIFT;
+		base0 = (qfprom_cdata[0] & MSM8916_BASE0_MASK);
+		p1[0] = (qfprom_cdata[0] & MSM8916_S0_P1_MASK) >> MSM8916_S0_P1_SHIFT;
+		p1[1] = (qfprom_cdata[0] & MSM8916_S1_P1_MASK) >> MSM8916_S1_P1_SHIFT;
+		p1[2] = (qfprom_cdata[0] & MSM8916_S2_P1_MASK) >> MSM8916_S2_P1_SHIFT;
+		p1[3] = (qfprom_cdata[1] & MSM8916_S3_P1_MASK) >> MSM8916_S3_P1_SHIFT;
+		p1[4] = (qfprom_cdata[1] & MSM8916_S4_P1_MASK) >> MSM8916_S4_P1_SHIFT;
 		for (i = 0; i < priv->num_sensors; i++)
 			p1[i] = (((base0) + p1[i]) << 3);
 		break;
-- 
2.17.1

