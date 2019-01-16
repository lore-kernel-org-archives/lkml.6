Return-Path: <SRS0=1Lvk=PY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 567B3C43387
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 17:11:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 24EF420651
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 17:11:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="QvFTI9So"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405830AbfAPRLO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Jan 2019 12:11:14 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:35349 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405568AbfAPRKw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jan 2019 12:10:52 -0500
Received: by mail-pg1-f193.google.com with SMTP id s198so3103637pgs.2
        for <linux-kernel@vger.kernel.org>; Wed, 16 Jan 2019 09:10:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=DtHgU4ueai0Fc/l8/P+ZyuzlLrZL8W/NSq8eqAtoCSo=;
        b=QvFTI9Sov4OjpoQNmN8XuMB6Qc8GaSkqLQW+gISNJvTIAnBPN82rZkr+wdjJV/bCL5
         jxrPQwFaly2X0KEAA06y/qYYICNPyHWcZsBR3BjX1P2I9GrhYYxo2lUzkCP75vKRt4yy
         eyP3AVlhiIGL6g/kY5VRWVLzxTiMM/Tkb6MbA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=DtHgU4ueai0Fc/l8/P+ZyuzlLrZL8W/NSq8eqAtoCSo=;
        b=kwZOM089x/FoWgwHlam6FZ64ABy/jwcA1b1QmYhJJytZVJv1dxxZt+4q9GC/7YgHaI
         G9qHLqWgqMEqAin5c5je/DMcnAHU7J1vOz8gQnXqlAoD8cFmGG7yqjiHH0s8lv0UFZ5R
         +GvpE32aU4kQn/A7OuyP0UimdVo/21Dpx5Bu72q225/zjWF99mNhy0e9sI0sZKFuJyZX
         KOiNEOoPfloXbpK3766BOWvGBfCirkxcTxc+wd2LO93skBNnyqGIN6motnUVm3uKoNEe
         sl3yPAfcktYDtlFhGh4NuOTuypNgXSYtQr8mVP4vaW3YNtT9xNbe1KujJGu/fuZ1Ip5b
         bhEw==
X-Gm-Message-State: AJcUukcUsPyXZMOj0A2almaPiQnlWYA1kSvOBaK+LTINlmO9W5Qx+r1h
        7aOkHo7/7SUD2Tb+GUXa7NUbHmm+/eHrYg==
X-Google-Smtp-Source: ALg8bN4S7ttfBJzPlvyjL0k9V2t/idlYC93XsDxB2432OpFJUlF/tWYWMWKFi8QWac0fR6QhjF+sbw==
X-Received: by 2002:a63:4948:: with SMTP id y8mr9820591pgk.32.1547658651293;
        Wed, 16 Jan 2019 09:10:51 -0800 (PST)
Received: from localhost.localdomain ([2601:1c2:680:1319:4e72:b9ff:fe99:466a])
        by smtp.gmail.com with ESMTPSA id h129sm17914023pfb.110.2019.01.16.09.10.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 16 Jan 2019 09:10:50 -0800 (PST)
From:   John Stultz <john.stultz@linaro.org>
To:     lkml <linux-kernel@vger.kernel.org>
Cc:     Li Yu <liyu65@hisilicon.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Vinod Koul <vkoul@kernel.org>,
        Tanglei Han <hantanglei@huawei.com>,
        Zhuangluan Su <suzhuangluan@hisilicon.com>,
        Ryan Grachek <ryan@edited.us>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Guodong Xu <guodong.xu@linaro.org>, dmaengine@vger.kernel.org,
        John Stultz <john.stultz@linaro.org>
Subject: [PATCH 5/8 v4] dma: k3dma: Add support for dma-channel-mask
Date:   Wed, 16 Jan 2019 09:10:26 -0800
Message-Id: <1547658629-25378-6-git-send-email-john.stultz@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1547658629-25378-1-git-send-email-john.stultz@linaro.org>
References: <1547658629-25378-1-git-send-email-john.stultz@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Li Yu <liyu65@hisilicon.com>

Add dma-channel-mask as a property for k3dma, it defines
available dma channels which a non-secure mode driver can use.

One sample usage of this is in Hi3660 SoC. DMA channel 0 is
reserved to lpm3, which is a coprocessor for power management. So
as a result, any request in kernel (which runs on main processor
and in non-secure mode) should start from at least channel 1.

Cc: Dan Williams <dan.j.williams@intel.com>
Cc: Vinod Koul <vkoul@kernel.org>
Cc: Tanglei Han <hantanglei@huawei.com>
Cc: Zhuangluan Su <suzhuangluan@hisilicon.com>
Cc: Ryan Grachek <ryan@edited.us>
Cc: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc: Guodong Xu <guodong.xu@linaro.org>
Cc: dmaengine@vger.kernel.org
Signed-off-by: Li Yu <liyu65@hisilicon.com>
[jstultz: Reworked to use a channel mask]
Signed-off-by: John Stultz <john.stultz@linaro.org>
---
v3: Rename to hisi-dma-avail-chan
v4: Rename to dma-channel-mask
---
 drivers/dma/k3dma.c | 20 +++++++++++++++++++-
 1 file changed, 19 insertions(+), 1 deletion(-)

diff --git a/drivers/dma/k3dma.c b/drivers/dma/k3dma.c
index b2060bf..ed19b1f 100644
--- a/drivers/dma/k3dma.c
+++ b/drivers/dma/k3dma.c
@@ -111,6 +111,7 @@ struct k3_dma_dev {
 	struct dma_pool		*pool;
 	u32			dma_channels;
 	u32			dma_requests;
+	u32			dma_channel_mask;
 	unsigned int		irq;
 };
 
@@ -318,6 +319,9 @@ static void k3_dma_tasklet(unsigned long arg)
 	/* check new channel request in d->chan_pending */
 	spin_lock_irq(&d->lock);
 	for (pch = 0; pch < d->dma_channels; pch++) {
+		if (!(d->dma_channel_mask & (1<<pch)))
+			continue;
+
 		p = &d->phy[pch];
 
 		if (p->vchan == NULL && !list_empty(&d->chan_pending)) {
@@ -335,6 +339,9 @@ static void k3_dma_tasklet(unsigned long arg)
 	spin_unlock_irq(&d->lock);
 
 	for (pch = 0; pch < d->dma_channels; pch++) {
+		if (!(d->dma_channel_mask & (1<<pch)))
+			continue;
+
 		if (pch_alloc & (1 << pch)) {
 			p = &d->phy[pch];
 			c = p->vchan;
@@ -855,6 +862,13 @@ static int k3_dma_probe(struct platform_device *op)
 				"dma-channels", &d->dma_channels);
 		of_property_read_u32((&op->dev)->of_node,
 				"dma-requests", &d->dma_requests);
+		ret = of_property_read_u32((&op->dev)->of_node,
+				"dma-channel-mask", &d->dma_channel_mask);
+		if (ret) {
+			dev_warn(&op->dev,
+				 "dma-channel-mask doesn't exist, considering all as available.\n");
+			d->dma_channel_mask = (u32)~0UL;
+		}
 	}
 
 	if (!(soc_data->flags & K3_FLAG_NOCLK)) {
@@ -886,8 +900,12 @@ static int k3_dma_probe(struct platform_device *op)
 		return -ENOMEM;
 
 	for (i = 0; i < d->dma_channels; i++) {
-		struct k3_dma_phy *p = &d->phy[i];
+		struct k3_dma_phy *p;
+
+		if (!(d->dma_channel_mask & (1<<i)))
+			continue;
 
+		p = &d->phy[i];
 		p->idx = i;
 		p->base = d->base + i * 0x40;
 	}
-- 
2.7.4

