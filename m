Return-Path: <SRS0=QLNC=JI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 358DBC43143
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 03:24:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E42E323C8C
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 03:24:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="chNCEB6s"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E42E323C8C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934371AbeFVDYo (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Jun 2018 23:24:44 -0400
Received: from mail-pl0-f65.google.com ([209.85.160.65]:41480 "EHLO
        mail-pl0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934351AbeFVDYl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jun 2018 23:24:41 -0400
Received: by mail-pl0-f65.google.com with SMTP id w8-v6so2746830ply.8
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jun 2018 20:24:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=+TGsoxWDLx0eUmV2mltgdZ45P5o8tIzkTFsYHg4OQtk=;
        b=chNCEB6sm09PWStU9jTmEJfkARLnMmFnIs3LWB96Ywi5xtXH5QD1kZmuLICKkG/YUr
         9JDMDEMkYhwGSrFr8hhXi8S45xfv4vl4beRKRE2kKx7cKATL8CPRPSnQumlicFK49Dbc
         xcbO7o3b0TP7xQU85XLQZcIswV33L6Z4izJSk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=+TGsoxWDLx0eUmV2mltgdZ45P5o8tIzkTFsYHg4OQtk=;
        b=bn22tSPjr50i3DyeDUFLNfe1tcxFAE9RwnMnp+V0fIO76Mn3kD2uF6P/LU26ojwF8T
         Dh39v96mud7Mg6nyy8qWqK6lQXe+Y1R8OFpBqi/YUyY81xmR9JOtqcHs8OvlNh4t1bUi
         Fp+xJD2v4F4KQMiKFIKvt8VwKqJzm/0RzZXEB+n0RubXQMTdG28CkoG37LWgN+b2ns1R
         YSLEijsQqYpOgQaWgTiqZXIy5CO8ppXxfYsgQnwOSuJ1cmU86VdmpiVZOZfxRk2t0HTc
         OnaWc58VYSlu8Dj3PWXT9EkXG3OzB5ulE8O2x4bzS4OFPtHbd6bM4s37fuGUSl0eY1M0
         HYvw==
X-Gm-Message-State: APt69E3mWseUESHO5mtAlAjIyIk6CJSucXgdplrnbinZMqNjfzKNxJDo
        plUazkv+ordoWeHce/Sfr9h3LA==
X-Google-Smtp-Source: ADUXVKLxUayHvahlXZHsWxOHdqZYIykCEJxhcy83THpA6nl+jKqwZt19aZc/C/fKbTMzYVWjzd/xaQ==
X-Received: by 2002:a17:902:2983:: with SMTP id h3-v6mr31419435plb.232.1529637880909;
        Thu, 21 Jun 2018 20:24:40 -0700 (PDT)
Received: from localhost.localdomain ([45.56.155.153])
        by smtp.gmail.com with ESMTPSA id a23-v6sm9286253pfn.113.2018.06.21.20.24.36
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 21 Jun 2018 20:24:40 -0700 (PDT)
From:   Guodong Xu <guodong.xu@linaro.org>
To:     vkoul@kernel.org, robh+dt@kernel.org, mark.rutland@arm.com,
        dan.j.williams@intel.com
Cc:     liyu65@hisilicon.com, suzhuangluan@hisilicon.com,
        xuhongtao8@hisilicon.com, zhongkaihua@huawei.com,
        xuezhiliang@hisilicon.com, xupeng7@huawei.com,
        sunliang10@huawei.com, fengbaopeng@hisilicon.com,
        dmaengine@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Guodong Xu <guodong.xu@linaro.org>
Subject: [PATCH 2/3] k3dma: add support to reserved minimum channels
Date:   Fri, 22 Jun 2018 11:24:15 +0800
Message-Id: <20180622032416.20133-3-guodong.xu@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180622032416.20133-1-guodong.xu@linaro.org>
References: <20180622032416.20133-1-guodong.xu@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Li Yu <liyu65@hisilicon.com>

On k3 series of SoC, DMA controller reserves some channels for
other on-chip coprocessors. By adding support to dma_min_chan, kernel
will not be able to use these reserved channels.

One example is on Hi3660 platform, channel 0 is reserved to lpm3.

Please also refer to Documentation/devicetree/bindings/dma/k3dma.txt

Signed-off-by: Li Yu <liyu65@hisilicon.com>
Signed-off-by: Guodong Xu <guodong.xu@linaro.org>
---
 drivers/dma/k3dma.c | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/drivers/dma/k3dma.c b/drivers/dma/k3dma.c
index fa31cccbe04f..13cec12742e3 100644
--- a/drivers/dma/k3dma.c
+++ b/drivers/dma/k3dma.c
@@ -113,6 +113,7 @@ struct k3_dma_dev {
 	struct dma_pool		*pool;
 	u32			dma_channels;
 	u32			dma_requests;
+	u32			dma_min_chan;
 	unsigned int		irq;
 };
 
@@ -309,7 +310,7 @@ static void k3_dma_tasklet(unsigned long arg)
 
 	/* check new channel request in d->chan_pending */
 	spin_lock_irq(&d->lock);
-	for (pch = 0; pch < d->dma_channels; pch++) {
+	for (pch = d->dma_min_chan; pch < d->dma_channels; pch++) {
 		p = &d->phy[pch];
 
 		if (p->vchan == NULL && !list_empty(&d->chan_pending)) {
@@ -326,7 +327,7 @@ static void k3_dma_tasklet(unsigned long arg)
 	}
 	spin_unlock_irq(&d->lock);
 
-	for (pch = 0; pch < d->dma_channels; pch++) {
+	for (pch = d->dma_min_chan; pch < d->dma_channels; pch++) {
 		if (pch_alloc & (1 << pch)) {
 			p = &d->phy[pch];
 			c = p->vchan;
@@ -825,6 +826,8 @@ static int k3_dma_probe(struct platform_device *op)
 				"dma-channels", &d->dma_channels);
 		of_property_read_u32((&op->dev)->of_node,
 				"dma-requests", &d->dma_requests);
+		of_property_read_u32((&op->dev)->of_node,
+				"dma-min-chan", &d->dma_min_chan);
 	}
 
 	d->clk = devm_clk_get(&op->dev, NULL);
@@ -848,12 +851,12 @@ static int k3_dma_probe(struct platform_device *op)
 		return -ENOMEM;
 
 	/* init phy channel */
-	d->phy = devm_kcalloc(&op->dev,
-		d->dma_channels, sizeof(struct k3_dma_phy), GFP_KERNEL);
+	d->phy = devm_kcalloc(&op->dev, (d->dma_channels - d->dma_min_chan),
+			sizeof(struct k3_dma_phy), GFP_KERNEL);
 	if (d->phy == NULL)
 		return -ENOMEM;
 
-	for (i = 0; i < d->dma_channels; i++) {
+	for (i = d->dma_min_chan; i < d->dma_channels; i++) {
 		struct k3_dma_phy *p = &d->phy[i];
 
 		p->idx = i;
-- 
2.17.1

