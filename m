Return-Path: <SRS0=HMm1=J4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3E2EC43A1D
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 08:39:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8D9FB20883
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 08:39:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="M7W2m7yL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8D9FB20883
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732446AbeGLIs2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Jul 2018 04:48:28 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:45819 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727447AbeGLIs2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jul 2018 04:48:28 -0400
Received: by mail-wr1-f67.google.com with SMTP id c4-v6so8121717wrs.12
        for <linux-kernel@vger.kernel.org>; Thu, 12 Jul 2018 01:39:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=MDWsqzRynEwyRQCUsbdky1TLitXCzuSAazaHyCyJftE=;
        b=M7W2m7yLyFe1hk/nRwb3L8NLWxoQj6jxHpYLMzHfD9rPufU81M+snXtK7+n6Alwq/G
         aStu0vHoaTM1biz0RqK0x7e+3mXsFM/DWTGHLN5twMYi1HiB8BwiWNlm811+DpMtgsTM
         D6113vDpLjc3JgmpgHD0Ai7STDbl41ZvFVJkQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=MDWsqzRynEwyRQCUsbdky1TLitXCzuSAazaHyCyJftE=;
        b=AgNrzRfXJl0Qov/5YEns0YhlyfHrCigqI4SWwRA79rErOcoeiEXDKissoBZ86y7vpc
         OKe/CLjLd1Go60KKzal4x1dGz09kBe9bD+YIoQHuQJ94FiBCuXuyr6svGWYBeFKRKHP0
         RILC7d0uAmQ4qQQcWylMHc38ln5RiHHzf2NN7F0UDAZ4qmlDNHKgucs05oLYWWZsdECY
         FwhJp8vuikxFwgRchR3WYRLR1dztj7lj7JL2yAXYBbPUS8zEg3qJ1RENA9UmyWrVhpuO
         3RAxgaFSydYNBdEHlMjf25r7VlU3kQ0AaW0AFJfTQIrbu5MGtxL2N5fDKGlyWdGfOZMl
         NjHg==
X-Gm-Message-State: AOUpUlFBgyk7QAU8XetZTyvIHpYwoMe/9IW8nVjguzSBXqNXTLnc5D/u
        tjtMGJBIiujODT/pOnOa13pEn3q3kak=
X-Google-Smtp-Source: AAOMgpewnhv2Pdz5+79PmoRkya4+s2+yMQwRiCBtbIWGdwTiDhpMosvJb3dvEWrAUvT/PYrbjPGVbg==
X-Received: by 2002:adf:9101:: with SMTP id j1-v6mr764085wrj.3.1531384792650;
        Thu, 12 Jul 2018 01:39:52 -0700 (PDT)
Received: from localhost ([103.249.91.93])
        by smtp.gmail.com with ESMTPSA id k14-v6sm18584882wrg.38.2018.07.12.01.39.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 12 Jul 2018 01:39:51 -0700 (PDT)
From:   Amit Kucheria <amit.kucheria@linaro.org>
To:     linux-kernel@vger.kernel.org
Cc:     rnayak@codeaurora.org, linux-arm-msm@vger.kernel.org,
        bjorn.andersson@linaro.org, edubezval@gmail.com,
        smohanad@codeaurora.org, vivek.gautam@codeaurora.org,
        andy.gross@linaro.org, dianders@chromium.org, mka@chromium.org,
        Zhang Rui <rui.zhang@intel.com>, linux-pm@vger.kernel.org
Subject: [PATCH v7 2/7] thermal: tsens: Add support to split up register address space into two
Date:   Thu, 12 Jul 2018 14:09:03 +0530
Message-Id: <8f833fee80565c4dfd381697e47f99fb5f9e65d3.1531384019.git.amit.kucheria@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <cover.1531384019.git.amit.kucheria@linaro.org>
References: <cover.1531384019.git.amit.kucheria@linaro.org>
In-Reply-To: <cover.1531384019.git.amit.kucheria@linaro.org>
References: <cover.1531384019.git.amit.kucheria@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are two banks of registers for v2 TSENS IPs: SROT and TM. On older
SoCs these were contiguous, leading to DTs mapping them as one register
address space of size 0x2000. In newer SoCs, these two banks are not
contiguous anymore.

Add logic to init_common() to differentiate between old and new DTs and
adjust associated offsets for the TM register bank so that the old DTs will
continue to function correctly.

Signed-off-by: Amit Kucheria <amit.kucheria@linaro.org>
Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>
Tested-by: Matthias Kaehlcke <mka@chromium.org>
---
 drivers/thermal/qcom/tsens-8996.c   |  4 ++--
 drivers/thermal/qcom/tsens-common.c | 12 ++++++++++++
 drivers/thermal/qcom/tsens.h        |  1 +
 3 files changed, 15 insertions(+), 2 deletions(-)

diff --git a/drivers/thermal/qcom/tsens-8996.c b/drivers/thermal/qcom/tsens-8996.c
index e1f7781..3e60cec 100644
--- a/drivers/thermal/qcom/tsens-8996.c
+++ b/drivers/thermal/qcom/tsens-8996.c
@@ -16,7 +16,7 @@
 #include <linux/regmap.h>
 #include "tsens.h"
 
-#define STATUS_OFFSET	0x10a0
+#define STATUS_OFFSET	0xa0
 #define LAST_TEMP_MASK	0xfff
 #define STATUS_VALID_BIT	BIT(21)
 #define CODE_SIGN_BIT		BIT(11)
@@ -28,7 +28,7 @@ static int get_temp_8996(struct tsens_device *tmdev, int id, int *temp)
 	unsigned int sensor_addr;
 	int last_temp = 0, last_temp2 = 0, last_temp3 = 0, ret;
 
-	sensor_addr = STATUS_OFFSET + s->hw_id * 4;
+	sensor_addr = tmdev->tm_offset + STATUS_OFFSET + s->hw_id * 4;
 	ret = regmap_read(tmdev->map, sensor_addr, &code);
 	if (ret)
 		return ret;
diff --git a/drivers/thermal/qcom/tsens-common.c b/drivers/thermal/qcom/tsens-common.c
index b1449ad..c22dc18 100644
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
@@ -126,11 +127,22 @@ static const struct regmap_config tsens_config = {
 int __init init_common(struct tsens_device *tmdev)
 {
 	void __iomem *base;
+	struct platform_device *op = of_find_device_by_node(tmdev->dev->of_node);
 
+	if (!op)
+		return -EINVAL;
 	base = of_iomap(tmdev->dev->of_node, 0);
 	if (!base)
 		return -EINVAL;
 
+	/* The driver only uses the TM register address space for now */
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

