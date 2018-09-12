Return-Path: <SRS0=BZo9=L2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 770CEC4646A
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 09:53:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 26846204EC
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 09:53:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="gSDuBvzg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 26846204EC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727726AbeILO5k (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Sep 2018 10:57:40 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:44719 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727685AbeILO5j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Sep 2018 10:57:39 -0400
Received: by mail-ed1-f68.google.com with SMTP id s10-v6so1234588edb.11
        for <linux-kernel@vger.kernel.org>; Wed, 12 Sep 2018 02:53:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=FjREbFGVR4U2BlmcUg5I3xLlSlYd4TVVX+ZjdpIMju8=;
        b=gSDuBvzg5L1d1hFDoKnmjQix+KFeP1cO2uVFU56g2/qrZxMTvgh2xfjzWq5lb0E0Tk
         Wvv+qDIhwcL7lBs/wnayTmppcEG2rfEQkaD8auHl1nwy1UgBRHa9C4uWrT3LQB29XTgS
         eP+tbT6VRGAjL5x8b42lx36NpdXb7tRSIlNTo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=FjREbFGVR4U2BlmcUg5I3xLlSlYd4TVVX+ZjdpIMju8=;
        b=Zir30yUTw+kTQhi1ao957BbPXh9vATr3CM3/uUb+gUnpO2eG4WOYoYnotMtjs+yJKh
         ddr36Cm9C6+vzjcpQ4q/PU5jA7WyY/pPte+UKunrfmywnxboj7O/6wRQ9X7ne8zRKpgi
         +Wwn1rp9L7TL3AbbAULmkUXOwXNGdccF8LhbKCL2xLKHzG6DtFwpHTZXHDxFXMKrXWld
         /H9UVsAw4IUdpIJWhdT0RVdFMpqFiZevDVzUuvWhfze8eYnYkQI0aExCJvoYEGMxFJn/
         aphMUWbRX4eKh4/qwYPiQ4YQybumU/iSS1MqSFUGaI43F/Po0J/fj4JE/EJ7ZLRZnFTo
         vHnQ==
X-Gm-Message-State: APzg51CdcuDiApFhyBJs+9P6OgszVBJ6arDzfQeFiA2lH13LN5y8hobk
        f5puOxbWQs7uh3wEYuX/yKO4TCZ7MZw=
X-Google-Smtp-Source: ANB0VdYlqb3HRo8aP5ClmwxcBK3IK1VPxxiE7ngroUoagHKqfYqJNBJLtL7vp8BYdd9dEVfZHNLKRA==
X-Received: by 2002:a50:86b5:: with SMTP id r50-v6mr1736811eda.201.1536746031759;
        Wed, 12 Sep 2018 02:53:51 -0700 (PDT)
Received: from localhost ([49.248.190.214])
        by smtp.gmail.com with ESMTPSA id a19-v6sm481328edd.69.2018.09.12.02.53.49
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 12 Sep 2018 02:53:50 -0700 (PDT)
From:   Amit Kucheria <amit.kucheria@linaro.org>
To:     linux-kernel@vger.kernel.org
Cc:     rnayak@codeaurora.org, linux-arm-msm@vger.kernel.org,
        bjorn.andersson@linaro.org, edubezval@gmail.com,
        smohanad@codeaurora.org, andy.gross@linaro.org,
        dianders@chromium.org, mka@chromium.org,
        Zhang Rui <rui.zhang@intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        linux-pm@vger.kernel.org
Subject: [PATCH v3 05/16] thermal: tsens: Add the SROT address map
Date:   Wed, 12 Sep 2018 15:22:50 +0530
Message-Id: <2900c1006e7e978403b1b95448f9c959c7ae486a.1536744310.git.amit.kucheria@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1536744310.git.amit.kucheria@linaro.org>
References: <cover.1536744310.git.amit.kucheria@linaro.org>
In-Reply-To: <cover.1536744310.git.amit.kucheria@linaro.org>
References: <cover.1536744310.git.amit.kucheria@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On platforms whose device trees specify two address spaces for TSENS, the
second one points to the SROT registers. Initialise the SROT map on those
platforms.

Signed-off-by: Amit Kucheria <amit.kucheria@linaro.org>
Reviewed-by: Matthias Kaehlcke <mka@chromium.org>
Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>
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

