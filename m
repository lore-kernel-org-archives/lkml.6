Return-Path: <SRS0=7Z+k=KK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C97D0C28CF6
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 10:33:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8555320846
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 10:33:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="JHfy94uO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8555320846
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729510AbeGZLuG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Jul 2018 07:50:06 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:56147 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729450AbeGZLuF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jul 2018 07:50:05 -0400
Received: by mail-wm0-f67.google.com with SMTP id f21-v6so1449895wmc.5
        for <linux-kernel@vger.kernel.org>; Thu, 26 Jul 2018 03:33:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=LnuO8mINuH/6zEhwieXU1MyQ1uhrZQBRKE+R5lMhY9U=;
        b=JHfy94uO0KUBlye3Ri4yZvHQKKeISc0CUzRbZtwLlgsPJ8Gt1oItxh7O0vvX/q5ZAz
         w9peiRZXhYQ5G3OY/LXCJ+3Cdu5XFGeltKLjqkGemvBU6WQKIXahhcM1WefrHclDiU9e
         e4wZBgkr6uxqW8nxQM5F86ZPCJbeMxytR8JlM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=LnuO8mINuH/6zEhwieXU1MyQ1uhrZQBRKE+R5lMhY9U=;
        b=kFiFtnVhtNAXcYRwCsnmEdl6w3cO/vvg5Xhpc3BulmbjKSFrTP8ZQqQ4y90M2Q7KwT
         YKb7FWu/pFJJX9bBDMBl11D7b9nsVFq9ZZ36Qoj9H1MMsERoISNM6dkHp4yhRKvkZH9f
         Z0A0ehatJH7QHV7QlOjDoOmLKfFzEE1dFduv/Z4349UXRwBtm5F26DY3WJCgwdF+mZtr
         1hnP3ExoW/TuvZwYL+1vF99tIgRaCugK2AkF2dfoPKit4BhgT0/dUugMq86Xe6knLQQc
         ++oRpHbWDedly+hiOIqk25GO1qAVGeN/4Fy/g3lm4W0DrfF3/9hur5IfzNeJyhkm0Y6B
         1H/w==
X-Gm-Message-State: AOUpUlE3T6vp4cvvu5aGUMMfKHevj+7Jxh7e9qG1EWsvbZrI5gisgjkS
        z6STaagzXMgeMzPBC4eh22vuqY+ksuo=
X-Google-Smtp-Source: AAOMgpdP0M7RJmFn5l+qENdZ5+AaglRgxQhkkw2EnTT7Ql/qK1wNx6lQuhzWhpqxt79RuzqJx8dT8w==
X-Received: by 2002:a1c:7d47:: with SMTP id y68-v6mr1149937wmc.62.1532601230918;
        Thu, 26 Jul 2018 03:33:50 -0700 (PDT)
Received: from localhost ([49.248.197.57])
        by smtp.gmail.com with ESMTPSA id i125-v6sm2357906wmd.23.2018.07.26.03.33.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 26 Jul 2018 03:33:50 -0700 (PDT)
From:   Amit Kucheria <amit.kucheria@linaro.org>
To:     linux-kernel@vger.kernel.org
Cc:     rnayak@codeaurora.org, linux-arm-msm@vger.kernel.org,
        bjorn.andersson@linaro.org, edubezval@gmail.com,
        smohanad@codeaurora.org, andy.gross@linaro.org,
        dianders@chromium.org, mka@chromium.org,
        Zhang Rui <rui.zhang@intel.com>, linux-pm@vger.kernel.org
Subject: [PATCH v2 3/3] thermal: tsens: Fix negative temperature reporting
Date:   Thu, 26 Jul 2018 16:03:10 +0530
Message-Id: <52516c287c9455676e7cbde4a4fa94282d73367f.1532600791.git.amit.kucheria@linaro.org>
X-Mailer: git-send-email 2.17.GIT
In-Reply-To: <cover.1532600791.git.amit.kucheria@linaro.org>
References: <cover.1532600791.git.amit.kucheria@linaro.org>
In-Reply-To: <cover.1532600791.git.amit.kucheria@linaro.org>
References: <cover.1532600791.git.amit.kucheria@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The current code will always return 0xffffffff in case of negative
temperatures due to a bug in how the binary sign extension is being done.

Use sign_extend32() instead.

Signed-off-by: Amit Kucheria <amit.kucheria@linaro.org>
Reviewed-by: Matthias Kaehlcke <mka@chromium.org>
---
 drivers/thermal/qcom/tsens-v2.c | 13 +++++--------
 1 file changed, 5 insertions(+), 8 deletions(-)

diff --git a/drivers/thermal/qcom/tsens-v2.c b/drivers/thermal/qcom/tsens-v2.c
index 908e3dcb2d5c..44da02f594ac 100644
--- a/drivers/thermal/qcom/tsens-v2.c
+++ b/drivers/thermal/qcom/tsens-v2.c
@@ -5,19 +5,20 @@
  */
 
 #include <linux/regmap.h>
+#include <linux/bitops.h>
 #include "tsens.h"
 
 #define STATUS_OFFSET		0xa0
 #define LAST_TEMP_MASK		0xfff
 #define STATUS_VALID_BIT	BIT(21)
-#define CODE_SIGN_BIT		BIT(11)
 
 static int get_temp_tsens_v2(struct tsens_device *tmdev, int id, int *temp)
 {
 	struct tsens_sensor *s = &tmdev->sensor[id];
 	u32 code;
 	unsigned int status_reg;
-	int last_temp = 0, last_temp2 = 0, last_temp3 = 0, ret;
+	u32 last_temp = 0, last_temp2 = 0, last_temp3 = 0;
+	int ret;
 
 	status_reg = tmdev->tm_offset + STATUS_OFFSET + s->hw_id * 4;
 	ret = regmap_read(tmdev->map, status_reg, &code);
@@ -54,12 +55,8 @@ static int get_temp_tsens_v2(struct tsens_device *tmdev, int id, int *temp)
 	else if (last_temp2 == last_temp3)
 		last_temp = last_temp3;
 done:
-	/* Code sign bit is the sign extension for a negative value */
-	if (last_temp & CODE_SIGN_BIT)
-		last_temp |= ~CODE_SIGN_BIT;
-
-	/* Temperatures are in deciCelicius */
-	*temp = last_temp * 100;
+	/* Convert temperature from deciCelsius to milliCelsius */
+	*temp = sign_extend32(last_temp, fls(LAST_TEMP_MASK) - 1) * 100;
 
 	return 0;
 }
-- 
2.17.GIT

