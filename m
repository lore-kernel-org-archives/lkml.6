Return-Path: <SRS0=TO5I=LL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FA70C433F5
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 13:39:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CBF9E2084C
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 13:39:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="XDgnm6dP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CBF9E2084C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728200AbeH1Rb1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Aug 2018 13:31:27 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:33012 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727950AbeH1Rb0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Aug 2018 13:31:26 -0400
Received: by mail-ed1-f66.google.com with SMTP id h9-v6so1416731edr.0
        for <linux-kernel@vger.kernel.org>; Tue, 28 Aug 2018 06:39:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=Qc/vEh/hM8XwepQBATbsK+sfjDGVHNzidZ0MvqTnDnY=;
        b=XDgnm6dPDHNs8LQ0Rb/kna7P+ofp36RdTusFhENVx3KmXTZDD7DP/yn4TQ8hfCyyTA
         jGWTqm9AqHeO/YJaSE7zOJL44vAO4mTNX/OKccc6WrmrJwVK3ngztkUCpgdqL+4qgh8g
         Qe9iXug49FuePaXhQY5oHP2vjbF3lmo+Hk5g0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=Qc/vEh/hM8XwepQBATbsK+sfjDGVHNzidZ0MvqTnDnY=;
        b=nCCLQ33ah/OHEUH7lG2cSchRh/alHnZhOHeCYkGNHIbh80c65VkdmHQU/DV97qVttu
         fAkKsxzFNBT39UZcns0e+p+VAI0nVsyNlVRHDEMik+//iVtFsgicVH3bTqFtXKD5y/rA
         9MXNBXPq9DiEAId+FVR1YohtO24NxXiwVQ0A0xc7nkuQYXulWa0T/at81UVrjF66PdLa
         w7lIGAcblC1G/0PM3ycAjsnXnclGMsTGxfvxBAh4cNIHtnH+viNbrVRlUJpsE/lf2Bwc
         3gLR71jG8KJB9S/+OKjCqxIAQfy0ebhOHEh950pfd4JxhLxOAYXwevCADEjK4z/OY4O+
         sg8Q==
X-Gm-Message-State: APzg51AYjUMUEUZb84eAuz4FeZqIY/CQvfE8wgvX+LKjmplDcvpzrXqC
        74XwlbLMTt4xTh1kurXR8pbewma0s1A=
X-Google-Smtp-Source: ANB0VdZZEqaasJtlppINcxYHnW7bLJ5jbTUgpqWGT3gzBs6yjp/zfr8IVOPCkh/EwvMl6sX7kswkuA==
X-Received: by 2002:a50:a959:: with SMTP id m25-v6mr2662021edc.22.1535463582490;
        Tue, 28 Aug 2018 06:39:42 -0700 (PDT)
Received: from localhost ([49.248.200.109])
        by smtp.gmail.com with ESMTPSA id i3-v6sm697283eda.84.2018.08.28.06.39.40
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 28 Aug 2018 06:39:41 -0700 (PDT)
From:   Amit Kucheria <amit.kucheria@linaro.org>
To:     linux-kernel@vger.kernel.org
Cc:     rnayak@codeaurora.org, linux-arm-msm@vger.kernel.org,
        bjorn.andersson@linaro.org, edubezval@gmail.com,
        smohanad@codeaurora.org, andy.gross@linaro.org,
        dianders@chromium.org, mka@chromium.org,
        Zhang Rui <rui.zhang@intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        linux-pm@vger.kernel.org
Subject: [PATCH v2 07/11] thermal: tsens: Add the SROT address map
Date:   Tue, 28 Aug 2018 19:08:36 +0530
Message-Id: <d1d2e58288f4d78db924863ac1775c5e2e5c884a.1535462942.git.amit.kucheria@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1535462942.git.amit.kucheria@linaro.org>
References: <cover.1535462942.git.amit.kucheria@linaro.org>
In-Reply-To: <cover.1535462942.git.amit.kucheria@linaro.org>
References: <cover.1535462942.git.amit.kucheria@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On platforms whose device trees specify two address spaces for TSENS, the
second one points to the SROT registers. Initialise the SROT map on those
platforms.

Signed-off-by: Amit Kucheria <amit.kucheria@linaro.org>
Reviewed-by: Matthias Kaehlcke <mka@chromium.org>
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

