Return-Path: <SRS0=HMm1=J4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43F37C43A1D
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 08:40:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F009920883
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 08:40:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="Tcb3f1EJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F009920883
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732505AbeGLIsr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Jul 2018 04:48:47 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:34517 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732484AbeGLIsq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jul 2018 04:48:46 -0400
Received: by mail-wm0-f68.google.com with SMTP id s13-v6so1484077wmc.1
        for <linux-kernel@vger.kernel.org>; Thu, 12 Jul 2018 01:40:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=/Jcia/6RdTo1f61k1V6jn6EIFW590aCTA6rf2xM6d8g=;
        b=Tcb3f1EJ1khAr5wXHhY6J/8jm8GT6vjNrKuf7orWkO5GIP1AH+8XsXIJ67qgBYznt4
         li84hbj0LvP7Vq6OGQkZpU1jOqeCepOtn0MaX1Hpb0qV7KY0q/+wSZ9Han1bS7rGu3wz
         f947CHj093qKhEEycz15qsMxdfS7uc2gAJqNI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=/Jcia/6RdTo1f61k1V6jn6EIFW590aCTA6rf2xM6d8g=;
        b=l/iK4RWjs1gBXdyRlxDFty8hwaj4Bs7ZXbp8e1FpmfKlEfGYSQ8zaZFKvF5FCGTfpW
         +ohGg+6FPzcCKnjB+2wzSFd+zcsNhpP6R3+/44bzQjaJorTMjTmqtfgPETiwGMbp6Lba
         f9AI7/J43KgQlG8Q5pnuUqUdG1TmBHRDLKLRx/ahpnan5hHNPZgOfSIhstclhFxXktQb
         OYinmBKz8HsIfWVRiBPNpwNhztiPKmv2aknmRXgnilBqzWWOKWDuEFxe2NO+Yn4HkPon
         IcKkH2ea5fEUvHLR3/Y2zesjqKTSogt7QVKQMaZBmQZhSa8xxKF70l1yWI1moWYNpTgG
         JjmA==
X-Gm-Message-State: AOUpUlE1phpA8RDyt5aFYAxFyn6mmeS+GlhK8jJq6azmsn+RTCQH2E5Z
        yGsE4vYe1grFnWv008JVBXqBUWrMJ+g=
X-Google-Smtp-Source: AAOMgpc7H0c/790b34NSi7BBm11wWpkNYPIWyco1g8IUUsWsVWY/gWXTSOEcSXNPCGBtsDfYQOcM4g==
X-Received: by 2002:a1c:1802:: with SMTP id 2-v6mr696778wmy.81.1531384809847;
        Thu, 12 Jul 2018 01:40:09 -0700 (PDT)
Received: from localhost ([103.249.91.93])
        by smtp.gmail.com with ESMTPSA id r17-v6sm22764677wrt.44.2018.07.12.01.40.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 12 Jul 2018 01:40:09 -0700 (PDT)
From:   Amit Kucheria <amit.kucheria@linaro.org>
To:     linux-kernel@vger.kernel.org
Cc:     rnayak@codeaurora.org, linux-arm-msm@vger.kernel.org,
        bjorn.andersson@linaro.org, edubezval@gmail.com,
        smohanad@codeaurora.org, vivek.gautam@codeaurora.org,
        andy.gross@linaro.org, dianders@chromium.org, mka@chromium.org,
        Zhang Rui <rui.zhang@intel.com>, linux-pm@vger.kernel.org
Subject: [PATCH v7 4/7] thermal: tsens: Rename tsens-8996 to tsens-v2 for reuse
Date:   Thu, 12 Jul 2018 14:09:05 +0530
Message-Id: <3bd2c05db1bfe6fd3891abd87b0c767152346a1d.1531384019.git.amit.kucheria@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <cover.1531384019.git.amit.kucheria@linaro.org>
References: <cover.1531384019.git.amit.kucheria@linaro.org>
In-Reply-To: <cover.1531384019.git.amit.kucheria@linaro.org>
References: <cover.1531384019.git.amit.kucheria@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The TSENS block inside the 8996 is internally classified as version 2 of
the IP. Several other SoC families use this block and can share this code.

We rename get_temp() to reflect that it can be used across the v2 family.

Signed-off-by: Amit Kucheria <amit.kucheria@linaro.org>
Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>
Tested-by: Matthias Kaehlcke <mka@chromium.org>
---
 drivers/thermal/qcom/Makefile                     |  2 +-
 drivers/thermal/qcom/{tsens-8996.c => tsens-v2.c} | 25 ++++++++---------------
 2 files changed, 9 insertions(+), 18 deletions(-)
 rename drivers/thermal/qcom/{tsens-8996.c => tsens-v2.c} (66%)

diff --git a/drivers/thermal/qcom/Makefile b/drivers/thermal/qcom/Makefile
index 2cc2193..a821929 100644
--- a/drivers/thermal/qcom/Makefile
+++ b/drivers/thermal/qcom/Makefile
@@ -1,2 +1,2 @@
 obj-$(CONFIG_QCOM_TSENS)	+= qcom_tsens.o
-qcom_tsens-y			+= tsens.o tsens-common.o tsens-8916.o tsens-8974.o tsens-8960.o tsens-8996.o
+qcom_tsens-y			+= tsens.o tsens-common.o tsens-8916.o tsens-8974.o tsens-8960.o tsens-v2.o
diff --git a/drivers/thermal/qcom/tsens-8996.c b/drivers/thermal/qcom/tsens-v2.c
similarity index 66%
rename from drivers/thermal/qcom/tsens-8996.c
rename to drivers/thermal/qcom/tsens-v2.c
index 3e60cec..44d3736 100644
--- a/drivers/thermal/qcom/tsens-8996.c
+++ b/drivers/thermal/qcom/tsens-v2.c
@@ -1,27 +1,18 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * Copyright (c) 2015, The Linux Foundation. All rights reserved.
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 and
- * only version 2 as published by the Free Software Foundation.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
- *
+ * Copyright (c) 2018, Linaro Limited
  */
 
-#include <linux/platform_device.h>
 #include <linux/regmap.h>
 #include "tsens.h"
 
-#define STATUS_OFFSET	0xa0
-#define LAST_TEMP_MASK	0xfff
+#define STATUS_OFFSET		0xa0
+#define LAST_TEMP_MASK		0xfff
 #define STATUS_VALID_BIT	BIT(21)
 #define CODE_SIGN_BIT		BIT(11)
 
-static int get_temp_8996(struct tsens_device *tmdev, int id, int *temp)
+static int get_temp_tsens_v2(struct tsens_device *tmdev, int id, int *temp)
 {
 	struct tsens_sensor *s = &tmdev->sensor[id];
 	u32 code;
@@ -73,12 +64,12 @@ static int get_temp_8996(struct tsens_device *tmdev, int id, int *temp)
 	return 0;
 }
 
-static const struct tsens_ops ops_8996 = {
+static const struct tsens_ops ops_generic_v2 = {
 	.init		= init_common,
-	.get_temp	= get_temp_8996,
+	.get_temp	= get_temp_tsens_v2,
 };
 
 const struct tsens_data data_8996 = {
 	.num_sensors	= 13,
-	.ops		= &ops_8996,
+	.ops		= &ops_generic_v2,
 };
-- 
2.7.4

