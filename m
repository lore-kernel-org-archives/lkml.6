Return-Path: <SRS0=qUjc=JZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D888C6778A
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 11:44:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1A28620896
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 11:44:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="krGIEz4i"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1A28620896
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932797AbeGILoM (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Jul 2018 07:44:12 -0400
Received: from mail-pl0-f65.google.com ([209.85.160.65]:38202 "EHLO
        mail-pl0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754525AbeGILoH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jul 2018 07:44:07 -0400
Received: by mail-pl0-f65.google.com with SMTP id b1-v6so5931190pls.5
        for <linux-kernel@vger.kernel.org>; Mon, 09 Jul 2018 04:44:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=6BLPkOT/SgEgQAvO08/wD9B+TzSAkRr3OD36saLthVg=;
        b=krGIEz4i4NdigSSlPbjl9Y+cWuquQd3yMIMxvCdLjIbXTfU9rP6NzwGhxRVfSqbvup
         4NwX9wDbE7Fmxgxhi0oj0AbguwfwK/BfsbuM8ZyvxMJ7d0IQhvG7Vf7CZXdmR+thymRN
         /6SBPXd3WuxYJGI+Y+0/xSh6qA85sUt28Nrjs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=6BLPkOT/SgEgQAvO08/wD9B+TzSAkRr3OD36saLthVg=;
        b=KUgR/Vvt7hXnDSyPS/OnYGY6cNbgwZb+ARAKz8VjXcYLTEfSw1YirewRLkIU62PEGq
         5vcOHu4Tao38SqMRsGNSDJz9X3p/MIjHa9mKIRVqamNjhdla8zJi4pk30J0DCijADrdA
         ku/6gxuqtp+cw9fCxxL6CEHE+T8e7OdFk9tP2eK6AiCIEFKqVs2k0ps4VA81lT7oB1JS
         NP9PzE32Jen08uR/E9hLsOka9d9gyIHXKcQypLAkXk8qltXOruNeWcOROt342nJzs3Q9
         2fTuG9gnTMXIqIcY+YnDJMkBLZhihaTapztS/v7ENEkGTzbDC8HAUWd0KFWLCYbPP+S0
         kj2Q==
X-Gm-Message-State: APt69E3GwW7nqiWABdckOG3CZcsm9pgvb3mn1q7xaTq0EQuGDIIxulW4
        zk63dl80gw+vat8rDEru/9D3QQnvRwI=
X-Google-Smtp-Source: AAOMgpcEIDv0T9Fpeh4bdtvg1pigTP0+9GTkO1ch6xkFacGmJsOMhBmSfPkPnq+VJ/HQqR+7a4iItA==
X-Received: by 2002:a17:902:6b86:: with SMTP id p6-v6mr20395916plk.75.1531136646865;
        Mon, 09 Jul 2018 04:44:06 -0700 (PDT)
Received: from localhost ([103.249.91.93])
        by smtp.gmail.com with ESMTPSA id n18-v6sm32311344pfa.50.2018.07.09.04.44.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 09 Jul 2018 04:44:06 -0700 (PDT)
From:   Amit Kucheria <amit.kucheria@linaro.org>
To:     linux-kernel@vger.kernel.org
Cc:     rnayak@codeaurora.org, linux-arm-msm@vger.kernel.org,
        bjorn.andersson@linaro.org, edubezval@gmail.com,
        smohanad@codeaurora.org, vivek.gautam@codeaurora.org,
        andy.gross@linaro.org, Zhang Rui <rui.zhang@intel.com>,
        linux-pm@vger.kernel.org
Subject: [PATCH v6 2/7] thermal: tsens: Add support to split up register address space into two
Date:   Mon,  9 Jul 2018 17:13:24 +0530
Message-Id: <e7c5c74bd5ad1820f0f015d8e9b3d7c7b24854a4.1531135999.git.amit.kucheria@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <cover.1531135999.git.amit.kucheria@linaro.org>
References: <cover.1531135999.git.amit.kucheria@linaro.org>
In-Reply-To: <cover.1531135999.git.amit.kucheria@linaro.org>
References: <cover.1531135999.git.amit.kucheria@linaro.org>
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

