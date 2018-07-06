Return-Path: <SRS0=VV0n=JW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B1F6C6778C
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 03:56:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B0DFC24064
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 03:56:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="UeCCy/kn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B0DFC24064
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932424AbeGFD4O (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Jul 2018 23:56:14 -0400
Received: from mail-pf0-f193.google.com ([209.85.192.193]:38284 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932348AbeGFD4M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jul 2018 23:56:12 -0400
Received: by mail-pf0-f193.google.com with SMTP id j17-v6so7218796pfn.5
        for <linux-kernel@vger.kernel.org>; Thu, 05 Jul 2018 20:56:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=GeiCyeTYAnNlTAnZk8bbwnhnfWJCW6BUDmOpTlPEQKk=;
        b=UeCCy/knUULgWF+J4DSAqihvfMaKzsAGxTljMybYmfjV9wxFjxOj/Zue5EAI+Wr0Uq
         NksK/mG80BcDR3I8+rmH8VUtQlxwNCUjvX27t8bQAS4OIDaFX85e02VPgB3M5ajaPRcB
         g44fz8W4WQr5oCgIYkeWX/Ywv5y7tSZ9EJJV0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=GeiCyeTYAnNlTAnZk8bbwnhnfWJCW6BUDmOpTlPEQKk=;
        b=AYWgw7+V6vTannmj0i0aaZnMnPvE/P4stmq6dE7kG5RaBv07+WuAC9IqLlIaPwy8Wg
         8/2IyirtWAFo6THxok9VXgDetsLOvRTD0E50RxTgLwW2HXijexXqGIRtQXWYUgiPcRtO
         3rVYNNvJBO7a+n6YqZepW0aBn+3xf6mHBYQh2AsMiQ9pZYvfINyvUnZQY+NXXhTQcsPW
         F2thQzcc5tjhtRooSO8zwI89DHNhMnthQEn1feUr6+8GRKEHQ3x+gMREaftZFeb+swS9
         dOxPGsaSM7btEUwoO42RlI4LLKXdk2x3FIiMZuwzZD8FV7myaLULPaL303LKO4ci4NFz
         8uIA==
X-Gm-Message-State: APt69E1qz4FvM/enPlsh4FE1/Ucvw380WLdbT/y8n7hgJA8IdNV/2yi1
        tJk9mJkbginbEUsQFdPx3wgnEA==
X-Google-Smtp-Source: AAOMgpe50CBTkH7THvKowgg/nEk5I7e5REODVXbM6EoyZm8c+BW5SHFyZhRHZRsSn+p6dyu+9soRJA==
X-Received: by 2002:a62:3e1a:: with SMTP id l26-v6mr9019822pfa.214.1530849371845;
        Thu, 05 Jul 2018 20:56:11 -0700 (PDT)
Received: from localhost.localdomain ([64.64.108.33])
        by smtp.gmail.com with ESMTPSA id y14-v6sm12568403pgo.22.2018.07.05.20.56.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 05 Jul 2018 20:56:11 -0700 (PDT)
From:   Guodong Xu <guodong.xu@linaro.org>
To:     vkoul@kernel.org, robh+dt@kernel.org, mark.rutland@arm.com,
        dan.j.williams@intel.com, xuwei5@hisilicon.com,
        catalin.marinas@arm.com, will.deacon@arm.com
Cc:     liyu65@hisilicon.com, suzhuangluan@hisilicon.com,
        xuhongtao8@hisilicon.com, zhongkaihua@huawei.com,
        xuezhiliang@hisilicon.com, xupeng7@huawei.com,
        sunliang10@huawei.com, fengbaopeng@hisilicon.com,
        dmaengine@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Guodong Xu <guodong.xu@linaro.org>
Subject: [PATCH v2 2/4] k3dma: add support to reserved minimum channels
Date:   Fri,  6 Jul 2018 11:55:19 +0800
Message-Id: <20180706035521.13736-3-guodong.xu@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180706035521.13736-1-guodong.xu@linaro.org>
References: <20180706035521.13736-1-guodong.xu@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Li Yu <liyu65@hisilicon.com>

On k3 series of SoC, DMA controller reserves some channels for
other on-chip coprocessors. By reading property "hisilicon,dma-min-chan"
from dts node, kernel will not use these reserved channels.

As an example, on Hi3660, channel 0 is reserved for lpm3.

Refer to Documentation/devicetree/bindings/dma/k3dma.txt for more
information.

Signed-off-by: Li Yu <liyu65@hisilicon.com>
Signed-off-by: Guodong Xu <guodong.xu@linaro.org>
---
 drivers/dma/k3dma.c | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/drivers/dma/k3dma.c b/drivers/dma/k3dma.c
index fa31cccbe04f..33efb541acb2 100644
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
+				"hisilicon,dma-min-chan", &d->dma_min_chan);
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

