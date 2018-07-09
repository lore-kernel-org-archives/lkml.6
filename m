Return-Path: <SRS0=qUjc=JZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9349C6778A
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 11:28:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5106620020
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 11:28:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="BVA+oEq9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5106620020
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932845AbeGIL21 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Jul 2018 07:28:27 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:47035 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932742AbeGIL2X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jul 2018 07:28:23 -0400
Received: by mail-wr1-f66.google.com with SMTP id s11-v6so10596826wra.13
        for <linux-kernel@vger.kernel.org>; Mon, 09 Jul 2018 04:28:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=6BLPkOT/SgEgQAvO08/wD9B+TzSAkRr3OD36saLthVg=;
        b=BVA+oEq9ZGqfD1xur9WuH/NrHuyfFoBOGw0JvDuGk4x2gUabrkVbqt30Lv56xs7+ds
         FOOD0yQEl86/ofRoBTN63d18ZRnUAcVt6X2mIiW5t4kwuVespHwSWpytCibOaoUbd798
         8aMTbN1EUYGUgGMozrgBDonFXTaHF7TLwU1Lo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=6BLPkOT/SgEgQAvO08/wD9B+TzSAkRr3OD36saLthVg=;
        b=OTuMm2dKLMW3yVDwxg9T2XTheDAiVUaErT6MTr/jaNiHxNhW4wW0x/JQXmlVP53X6X
         osu5kyaJ+SbA0aZqOVbXowLtJCXROJETQtBtMvg3pjITWSRhFFDnnchTB/2Ui+7Tnbgp
         nnb0Oac+OMbarbHCz1OJUIynU8OYRZjPXp6COyHFMMViVssn/K0atwojm8ql4vghVC/o
         8mVtGSEbtHc74mOIHqSmHL9EBZhnPbC7/rFtW1+MplOKlTeZ0OUgspVUSGGI6xpijnJt
         jXxeU0qKNhudB9O/g089v0lZ58s/OBuO9Yb4us3nbLb81uY+GKnKylr4Qq2e4aYEu5V4
         tXNw==
X-Gm-Message-State: APt69E1MsPCEg+O61Zfn0QFnF72vwvXwpI+60VPXCmk7ROUypBcoQIA2
        GEZ1DWrgZI2PcWDjDDIQwxOP+n3BqC8=
X-Google-Smtp-Source: AAOMgpe56fFsKvPRCoxfRlX5MyyBBBG/hG8CH+mF8bhWy7SMfbcQFkykn6qENNizTYdzAU3tacufZw==
X-Received: by 2002:adf:e78d:: with SMTP id n13-v6mr14136743wrm.136.1531135701888;
        Mon, 09 Jul 2018 04:28:21 -0700 (PDT)
Received: from localhost ([49.248.189.240])
        by smtp.gmail.com with ESMTPSA id s10-v6sm25570377wmb.12.2018.07.09.04.28.19
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 09 Jul 2018 04:28:21 -0700 (PDT)
From:   Amit Kucheria <amit.kucheria@linaro.org>
To:     linux-kernel@vger.kernel.org
Cc:     rnayak@codeaurora.org, linux-arm-msm@vger.kernel.org,
        bjorn.andersson@linaro.org, edubezval@gmail.com,
        smohanad@codeaurora.org, vivek.gautam@codeaurora.org,
        andy.gross@linaro.org, Zhang Rui <rui.zhang@intel.com>,
        linux-pm@vger.kernel.org
Subject: [PATCH v5 2/7] thermal: tsens: Add support to split up register address space into two
Date:   Mon,  9 Jul 2018 16:57:35 +0530
Message-Id: <e7c5c74bd5ad1820f0f015d8e9b3d7c7b24854a4.1531133611.git.amit.kucheria@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <cover.1531133611.git.amit.kucheria@linaro.org>
References: <cover.1531133611.git.amit.kucheria@linaro.org>
In-Reply-To: <cover.1531133611.git.amit.kucheria@linaro.org>
References: <cover.1531133611.git.amit.kucheria@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are two banks of registers for v2 TSENS IPs: SROT and TM. On older
SoCs these were contiguous, leading to DTs mapping them as one register
address space of size 0x2000. In newer SoCs, these two banks are not
contiguous anymore.

Fixing old DTs to split the address space into allows us to have cleaner
common code e.g. get_temp() that is shared across new and old platforms.

But we need to add logic to init_common() to differentiate between old and
new DTs and adjust associated offsets for the TM register bank so that the
old DTs will continue to function correctly.

Signed-off-by: Amit Kucheria <amit.kucheria@linaro.org>
---
 drivers/thermal/qcom/tsens-8996.c   |  2 +-
 drivers/thermal/qcom/tsens-common.c | 11 +++++++++++
 drivers/thermal/qcom/tsens.h        |  1 +
 3 files changed, 13 insertions(+), 1 deletion(-)

diff --git a/drivers/thermal/qcom/tsens-8996.c b/drivers/thermal/qcom/tsens-8996.c
index e1f7781..60765b1 100644
--- a/drivers/thermal/qcom/tsens-8996.c
+++ b/drivers/thermal/qcom/tsens-8996.c
@@ -28,7 +28,7 @@ static int get_temp_8996(struct tsens_device *tmdev, int id, int *temp)
 	unsigned int sensor_addr;
 	int last_temp = 0, last_temp2 = 0, last_temp3 = 0, ret;
 
-	sensor_addr = STATUS_OFFSET + s->hw_id * 4;
+	sensor_addr = tmdev->tm_offset + STATUS_OFFSET + s->hw_id * 4;
 	ret = regmap_read(tmdev->map, sensor_addr, &code);
 	if (ret)
 		return ret;
diff --git a/drivers/thermal/qcom/tsens-common.c b/drivers/thermal/qcom/tsens-common.c
index b1449ad..4a741b0 100644
--- a/drivers/thermal/qcom/tsens-common.c
+++ b/drivers/thermal/qcom/tsens-common.c
@@ -16,6 +16,7 @@
 #include <linux/io.h>
 #include <linux/nvmem-consumer.h>
 #include <linux/of_address.h>
+#include <linux/of_platform.h>
 #include <linux/platform_device.h>
 #include <linux/regmap.h>
 #include "tsens.h"
@@ -126,11 +127,21 @@ static const struct regmap_config tsens_config = {
 int __init init_common(struct tsens_device *tmdev)
 {
 	void __iomem *base;
+	struct platform_device *op = of_find_device_by_node(tmdev->dev->of_node);
 
+	if (!op)
+		return -EINVAL;
 	base = of_iomap(tmdev->dev->of_node, 0);
 	if (!base)
 		return -EINVAL;
 
+	if (op->num_resources > 1) {
+		tmdev->tm_offset = 0;
+	} else {
+		/* old DTs where SROT and TM were in a contiguous 2K block */
+		tmdev->tm_offset = 0x1000;
+	}
+
 	tmdev->map = devm_regmap_init_mmio(tmdev->dev, base, &tsens_config);
 	if (IS_ERR(tmdev->map)) {
 		iounmap(base);
diff --git a/drivers/thermal/qcom/tsens.h b/drivers/thermal/qcom/tsens.h
index dc56e1e..d785b37 100644
--- a/drivers/thermal/qcom/tsens.h
+++ b/drivers/thermal/qcom/tsens.h
@@ -77,6 +77,7 @@ struct tsens_device {
 	struct device			*dev;
 	u32				num_sensors;
 	struct regmap			*map;
+	u32				tm_offset;
 	struct tsens_context		ctx;
 	const struct tsens_ops		*ops;
 	struct tsens_sensor		sensor[0];
-- 
2.7.4

