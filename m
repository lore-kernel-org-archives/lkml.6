Return-Path: <SRS0=+sa6=KY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3949C46464
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 12:33:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 57E9D21DEC
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 12:33:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="MD/s985U"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 57E9D21DEC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732231AbeHIO6A (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Aug 2018 10:58:00 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:41987 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732170AbeHIO57 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Aug 2018 10:57:59 -0400
Received: by mail-pg1-f196.google.com with SMTP id y4-v6so2689075pgp.9
        for <linux-kernel@vger.kernel.org>; Thu, 09 Aug 2018 05:33:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=3ESQmXQZFM8HUugR+y7kuqNvZLR844rwPBdqMRc4GHg=;
        b=MD/s985U67JRAGE4XjUMo1kDCnx44R//xo5N7NcCMsgalYxjuwZx3InYj6GRi/CFis
         1z1NHcjctzAHYiAIv6kdEJDF88CMMY6d418C84OdhzX8NPFDCaHXeCb2L6xIB1U7NuS5
         +abUaD5hUkHc1v7+jf42YNWLW7XfhPrvAaWyU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=3ESQmXQZFM8HUugR+y7kuqNvZLR844rwPBdqMRc4GHg=;
        b=Z1DY/SQ2vnLohnrGiBPWZ1+xSOUnM+fuuDPEmpTAsy06tTv27yRq69NLwsx1yX7JsY
         gm0eyTrnuGUX2RFyf0kAMHaA4VTZTmddQy+Wqe6xmY9WastNkf2Drc97qLriUlznxMOO
         5VJEHX4O8nxZD+MaTmNJUBdXbG659v62M5zjeKzKDmjSxbSTdrF0HCrGTUXuxQP75uXV
         cCeJ4qBoGr/aEhMcWanYJbvJkZQG7cAv5Q5KhjGIt6ZITA24mw09M7iYNrTbi8wh26yn
         Eok5R2OAJdj697s4zL3ixAiqiP04L98LNDz/0jIAhdmQVbdfmOAN/ufMqDXo5ByCY7hz
         my5w==
X-Gm-Message-State: AOUpUlFgb7BKuY6g508mye72Qyu0yCbHj8iCarUyFXTHI9Ftn0rVwE2O
        mkgXeqJ9MNLhcXHsmYuK1BQA4c66Msk=
X-Google-Smtp-Source: AA+uWPxzAUwNYf+Vegu8iqqg36S0km4gd5a756a+BMMyMjFirZUBseXWHyhnU9hBErAHnkfBaXmw9A==
X-Received: by 2002:a62:2ac8:: with SMTP id q191-v6mr2203566pfq.139.1533817997513;
        Thu, 09 Aug 2018 05:33:17 -0700 (PDT)
Received: from localhost ([45.113.251.134])
        by smtp.gmail.com with ESMTPSA id v7-v6sm21878001pgh.57.2018.08.09.05.33.16
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 09 Aug 2018 05:33:16 -0700 (PDT)
From:   Amit Kucheria <amit.kucheria@linaro.org>
To:     linux-kernel@vger.kernel.org
Cc:     rnayak@codeaurora.org, linux-arm-msm@vger.kernel.org,
        bjorn.andersson@linaro.org, edubezval@gmail.com,
        smohanad@codeaurora.org, andy.gross@linaro.org,
        dianders@chromium.org, mka@chromium.org,
        Zhang Rui <rui.zhang@intel.com>, linux-pm@vger.kernel.org
Subject: [PATCH v1 06/10] thermal: tsens: Add the SROT address map
Date:   Thu,  9 Aug 2018 18:02:38 +0530
Message-Id: <3759de54da8dac772f43c098fcec322de179c1a4.1533815718.git.amit.kucheria@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1533815718.git.amit.kucheria@linaro.org>
References: <cover.1533815718.git.amit.kucheria@linaro.org>
In-Reply-To: <cover.1533815718.git.amit.kucheria@linaro.org>
References: <cover.1533815718.git.amit.kucheria@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On platforms whose device trees specify two address spaces for TSENS, the
second one points to the SROT registers. Initialise the SROT map on those
platforms.

Signed-off-by: Amit Kucheria <amit.kucheria@linaro.org>
---
 drivers/thermal/qcom/tsens-common.c | 14 ++++++++++++--
 drivers/thermal/qcom/tsens.h        |  1 +
 2 files changed, 13 insertions(+), 2 deletions(-)

diff --git a/drivers/thermal/qcom/tsens-common.c b/drivers/thermal/qcom/tsens-common.c
index 0585084630b3..0b8a793f15f4 100644
--- a/drivers/thermal/qcom/tsens-common.c
+++ b/drivers/thermal/qcom/tsens-common.c
@@ -117,16 +117,26 @@ static const struct regmap_config tsens_config = {
 
 int __init init_common(struct tsens_device *tmdev)
 {
-	void __iomem *tm_base;
+	void __iomem *tm_base, *srot_base;
 	struct resource *res;
 	struct platform_device *op = of_find_device_by_node(tmdev->dev->of_node);
 
 	if (!op)
 		return -EINVAL;
 
-	/* The driver only uses the TM register address space for now */
 	if (op->num_resources > 1) {
+		/* DT with separate SROT and TM address space */
 		tmdev->tm_offset = 0;
+		res = platform_get_resource(op, IORESOURCE_MEM, 1);
+		srot_base = devm_ioremap_resource(&op->dev, res);
+		if (IS_ERR(srot_base))
+			return PTR_ERR(srot_base);
+
+		tmdev->srot_map = devm_regmap_init_mmio(tmdev->dev,
+							srot_base, &tsens_config);
+		if (IS_ERR(tmdev->srot_map))
+			return PTR_ERR(tmdev->srot_map);
+
 	} else {
 		/* old DTs where SROT and TM were in a contiguous 2K block */
 		tmdev->tm_offset = 0x1000;
diff --git a/drivers/thermal/qcom/tsens.h b/drivers/thermal/qcom/tsens.h
index 58e98c4d3a8b..b9c4bcf255fa 100644
--- a/drivers/thermal/qcom/tsens.h
+++ b/drivers/thermal/qcom/tsens.h
@@ -70,6 +70,7 @@ struct tsens_device {
 	struct device			*dev;
 	u32				num_sensors;
 	struct regmap			*tm_map;
+	struct regmap			*srot_map;
 	u32				tm_offset;
 	struct tsens_context		ctx;
 	const struct tsens_ops		*ops;
-- 
2.17.1

