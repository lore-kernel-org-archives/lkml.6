Return-Path: <SRS0=+sa6=KY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C8B7C46464
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 12:33:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B427121DEC
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 12:33:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="kBj3KSKq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B427121DEC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732257AbeHIO6D (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Aug 2018 10:58:03 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:39239 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732236AbeHIO6D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Aug 2018 10:58:03 -0400
Received: by mail-pf1-f196.google.com with SMTP id j8-v6so2792304pff.6
        for <linux-kernel@vger.kernel.org>; Thu, 09 Aug 2018 05:33:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=njW6jAZWOPdw7KJ/kbY+W+hKS572y0dkgyYwoknGJBU=;
        b=kBj3KSKqdrGbKlEZB8ILVyoVK8wPo4sqH0Ttz37olDY7oM8X97IojsYz+ogQTBqhZ4
         pv3pbYSRO5b8h6DWWzDe4oFYlcmpQ+YOlq1IK0PKsTs9YjjkOXnFlOi2IFJw0m6Ha8Am
         w2Z2T16cRauQxtQDRoQjCYmPqzYfWEY+OX/0o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=njW6jAZWOPdw7KJ/kbY+W+hKS572y0dkgyYwoknGJBU=;
        b=j93qJDoSan/Jpf24SQIlWeRJcBbpi0iFjlDJMcokuL81tCTFRz1zi5u1uXKvHozn7W
         woF6bqMq62CEJBgxQ6N7+NE3FPMYmEZnZXjGA693a2WTS/6f/dKQ2XtM4bfwZpZLZvoj
         EDF91EbXhiWmPWR0UVGOOB3ZBvrDFLuS5n3LkdT2C/KKFOyV44dsA7SOF76aAIUsjTn2
         NhRd/dW6E/n2bHsY6FXoOH2a6vonZvyrW+mYp0aLiL8jWW31xdLq8X0lEP3gKPmh6HSp
         8dwDu4+lvap7VMdcXs0z1+EDRQqqJSRRpr0CuUMfYthZZ/A8aTOFs5lT3VMScyBEBX64
         qKHg==
X-Gm-Message-State: AOUpUlH6rg2aJCfbUzbV4zUu6KpRCXmByoqTp0lhpIMdDCKHTbSl1uEf
        wlgO+e/WfgAzoSCH2zieyiiFFRzNgks=
X-Google-Smtp-Source: AA+uWPxTt2J9lAQx2dtwd9kW9yJMcUG4IfXqvnmVcjSWEMHpzqLHcGqUcYb1mP1qbb5mdT+CD+43sA==
X-Received: by 2002:a62:1449:: with SMTP id 70-v6mr2234037pfu.222.1533818001059;
        Thu, 09 Aug 2018 05:33:21 -0700 (PDT)
Received: from localhost ([45.113.251.134])
        by smtp.gmail.com with ESMTPSA id w192-v6sm7818876pfd.74.2018.08.09.05.33.19
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 09 Aug 2018 05:33:20 -0700 (PDT)
From:   Amit Kucheria <amit.kucheria@linaro.org>
To:     linux-kernel@vger.kernel.org
Cc:     rnayak@codeaurora.org, linux-arm-msm@vger.kernel.org,
        bjorn.andersson@linaro.org, edubezval@gmail.com,
        smohanad@codeaurora.org, andy.gross@linaro.org,
        dianders@chromium.org, mka@chromium.org,
        Zhang Rui <rui.zhang@intel.com>, linux-pm@vger.kernel.org
Subject: [PATCH v1 07/10] thermal: tsens: Check if the IP is correctly enabled by firmware
Date:   Thu,  9 Aug 2018 18:02:39 +0530
Message-Id: <985ed415774fdac9ac21afad4b4b74f30f6c5068.1533815718.git.amit.kucheria@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1533815718.git.amit.kucheria@linaro.org>
References: <cover.1533815718.git.amit.kucheria@linaro.org>
In-Reply-To: <cover.1533815718.git.amit.kucheria@linaro.org>
References: <cover.1533815718.git.amit.kucheria@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The SROT registers are initialised by the secure firmware at boot. We
don't have write access to the registers. Check if the block is enabled
before continuing.

Signed-off-by: Amit Kucheria <amit.kucheria@linaro.org>
---
 drivers/thermal/qcom/tsens-common.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/drivers/thermal/qcom/tsens-common.c b/drivers/thermal/qcom/tsens-common.c
index 0b8a793f15f4..d250b757d1f0 100644
--- a/drivers/thermal/qcom/tsens-common.c
+++ b/drivers/thermal/qcom/tsens-common.c
@@ -12,6 +12,11 @@
 #include <linux/regmap.h>
 #include "tsens.h"
 
+/* SROT */
+#define CTRL_OFFSET		0x4
+#define TSENS_EN		BIT(0)
+
+/* TM */
 #define STATUS_OFFSET		0x30
 #define SN_ADDR_OFFSET		0x4
 #define SN_ST_TEMP_MASK		0x3ff
@@ -119,6 +124,8 @@ int __init init_common(struct tsens_device *tmdev)
 {
 	void __iomem *tm_base, *srot_base;
 	struct resource *res;
+	u32 code;
+	int ret;
 	struct platform_device *op = of_find_device_by_node(tmdev->dev->of_node);
 
 	if (!op)
@@ -151,5 +158,15 @@ int __init init_common(struct tsens_device *tmdev)
 	if (IS_ERR(tmdev->tm_map))
 		return PTR_ERR(tmdev->tm_map);
 
+	if (tmdev->srot_map) {
+		ret = regmap_read(tmdev->srot_map, CTRL_OFFSET, &code);
+		if (ret)
+			return ret;
+		if (!(code & TSENS_EN)) {
+			dev_err(tmdev->dev, "tsens device is not enabled\n");
+			return -ENODEV;
+		}
+	}
+
 	return 0;
 }
-- 
2.17.1

