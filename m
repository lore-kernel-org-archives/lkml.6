Return-Path: <SRS0=1Lvk=PY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 939EBC43444
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 17:10:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 578A720651
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 17:10:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="QQqt5Z5O"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405603AbfAPRKu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Jan 2019 12:10:50 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:35797 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405486AbfAPRKt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jan 2019 12:10:49 -0500
Received: by mail-pl1-f193.google.com with SMTP id p8so3314068plo.2
        for <linux-kernel@vger.kernel.org>; Wed, 16 Jan 2019 09:10:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=GvaGd5Qa7PcuxUq/r8GFXFG1FEuIWEy4GqPFolG9iUI=;
        b=QQqt5Z5O2H7oIxoZeFjry1ABrYrhostw7JbpxWIgLTZ0iJm5v1u6vgyoVQRF/gFQZy
         XUr0QR8FSQJpHCbnfwhBc9JkydtynTMfRMSxfmm1XmcvNJAjBkiafL1TgY1QW9+Q1zI4
         RjlLe6zFaw2VWaD5afqIigf0LTzeHqw3J22Sc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=GvaGd5Qa7PcuxUq/r8GFXFG1FEuIWEy4GqPFolG9iUI=;
        b=MwhvcgoZN2u2gkI5OjH2N/0/taRPjPfTZrMSFyuwWuLlaHHyhAgAA+OI7ytugornNz
         AU8COTRG2NS0F2pwYFjA+cyoEmLQMFtOW4Z2Rd6fNPCIH17KYR60k8awT3Qn3GksaIuH
         aAs2UgdJ/g7Xo9iDZxPAxgS//ov9mQZaYeuRA2/+nowZZUymfU4HU8m3PcEMoVQjeZ93
         /JgxgD8lGaHouVDFwA0So3c9fzDOJRclnwqPReoScp9+UzydMsInVScebV3uiCq+Ub3j
         kQ0oSvvZJGYHg4Auw0AWgnUd55w+WlAptKX3vtUiYcfSRaxlNhJhuV5ULY/D662n3rbL
         xSGA==
X-Gm-Message-State: AJcUukcNyIfVu+wqL5naYil9dBBXUxBQnzDD4JXQMdZz+BDkiX+U8fKS
        QsQnxUpGKIbqUAPkdTnABkw66EokmK5fBQ==
X-Google-Smtp-Source: ALg8bN6QSyhmNN8OYdpQj1WLhF4G3UWoQr/ZtLB71UxcnCH32cTAFCIaJYl+aidjgLEWGhmBZAzakA==
X-Received: by 2002:a17:902:7687:: with SMTP id m7mr10780477pll.187.1547658647933;
        Wed, 16 Jan 2019 09:10:47 -0800 (PST)
Received: from localhost.localdomain ([2601:1c2:680:1319:4e72:b9ff:fe99:466a])
        by smtp.gmail.com with ESMTPSA id h129sm17914023pfb.110.2019.01.16.09.10.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 16 Jan 2019 09:10:46 -0800 (PST)
From:   John Stultz <john.stultz@linaro.org>
To:     lkml <linux-kernel@vger.kernel.org>
Cc:     Youlin Wang <wwx575822@notesmail.huawei.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Vinod Koul <vkoul@kernel.org>,
        Zhuangluan Su <suzhuangluan@hisilicon.com>,
        Ryan Grachek <ryan@edited.us>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        dmaengine@vger.kernel.org, Tanglei Han <hantanglei@huawei.com>,
        John Stultz <john.stultz@linaro.org>
Subject: [PATCH 3/8 v4] dma: k3dma: Upgrade k3dma driver to support hisi_asp_dma hardware
Date:   Wed, 16 Jan 2019 09:10:24 -0800
Message-Id: <1547658629-25378-4-git-send-email-john.stultz@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1547658629-25378-1-git-send-email-john.stultz@linaro.org>
References: <1547658629-25378-1-git-send-email-john.stultz@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Youlin Wang <wwx575822@notesmail.huawei.com>

On the hi3660 hardware there are two (at least) DMA controllers,
the DMA-P (Peripherial DMA) and the DMA-A (Audio DMA). The
two blocks are similar, but have some slight differences. This
resulted in the vendor implementing two separate drivers, which
after review, they have been able to condense and re-use the
existing k3dma driver.

Thus, this patch adds support for the new "hisi-pcm-asp-dma-1.0"
compatible string in the binding.

One difference with the DMA-A controller, is that it does not
need to initialize a clock. So we skip this by adding and using
soc data flags.

After above this driver will support both k3 and hisi_asp dma
hardware.

Cc: Dan Williams <dan.j.williams@intel.com>
Cc: Vinod Koul <vkoul@kernel.org>
Cc: Zhuangluan Su <suzhuangluan@hisilicon.com>
Cc: Ryan Grachek <ryan@edited.us>
Cc: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc: dmaengine@vger.kernel.org
Acked-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Signed-off-by: Youlin Wang <wwx575822@notesmail.huawei.com>
Signed-off-by: Tanglei Han <hantanglei@huawei.com>
[jstultz: Reworked to use of_match_data, commit msg improvements]
Signed-off-by: John Stultz <john.stultz@linaro.org>
---
v2:
* Reworked to use of_match_data
v3:
* Further rework of the commit message
---
 drivers/dma/k3dma.c | 37 ++++++++++++++++++++++++++++++++-----
 1 file changed, 32 insertions(+), 5 deletions(-)

diff --git a/drivers/dma/k3dma.c b/drivers/dma/k3dma.c
index fdec2b6..df61406 100644
--- a/drivers/dma/k3dma.c
+++ b/drivers/dma/k3dma.c
@@ -116,6 +116,13 @@ struct k3_dma_dev {
 	unsigned int		irq;
 };
 
+
+#define K3_FLAG_NOCLK  (1<<0)
+struct k3dma_soc_data {
+	unsigned long flags;
+};
+
+
 #define to_k3_dma(dmadev) container_of(dmadev, struct k3_dma_dev, slave)
 
 static int k3_dma_config_write(struct dma_chan *chan,
@@ -790,8 +797,21 @@ static int k3_dma_transfer_resume(struct dma_chan *chan)
 	return 0;
 }
 
+static const struct k3dma_soc_data k3_v1_dma_data = {
+	.flags = 0,
+};
+
+static const struct k3dma_soc_data asp_v1_dma_data = {
+	.flags = K3_FLAG_NOCLK,
+};
+
 static const struct of_device_id k3_pdma_dt_ids[] = {
-	{ .compatible = "hisilicon,k3-dma-1.0", },
+	{ .compatible = "hisilicon,k3-dma-1.0",
+	  .data = &k3_v1_dma_data
+	},
+	{ .compatible = "hisilicon,hisi-pcm-asp-dma-1.0",
+	  .data = &asp_v1_dma_data
+	},
 	{}
 };
 MODULE_DEVICE_TABLE(of, k3_pdma_dt_ids);
@@ -810,6 +830,7 @@ static struct dma_chan *k3_of_dma_simple_xlate(struct of_phandle_args *dma_spec,
 
 static int k3_dma_probe(struct platform_device *op)
 {
+	const struct k3dma_soc_data *soc_data;
 	struct k3_dma_dev *d;
 	const struct of_device_id *of_id;
 	struct resource *iores;
@@ -823,6 +844,10 @@ static int k3_dma_probe(struct platform_device *op)
 	if (!d)
 		return -ENOMEM;
 
+	soc_data = device_get_match_data(&op->dev);
+	if (!soc_data)
+		return -EINVAL;
+
 	d->base = devm_ioremap_resource(&op->dev, iores);
 	if (IS_ERR(d->base))
 		return PTR_ERR(d->base);
@@ -835,10 +860,12 @@ static int k3_dma_probe(struct platform_device *op)
 				"dma-requests", &d->dma_requests);
 	}
 
-	d->clk = devm_clk_get(&op->dev, NULL);
-	if (IS_ERR(d->clk)) {
-		dev_err(&op->dev, "no dma clk\n");
-		return PTR_ERR(d->clk);
+	if (!(soc_data->flags & K3_FLAG_NOCLK)) {
+		d->clk = devm_clk_get(&op->dev, NULL);
+		if (IS_ERR(d->clk)) {
+			dev_err(&op->dev, "no dma clk\n");
+			return PTR_ERR(d->clk);
+		}
 	}
 
 	irq = platform_get_irq(op, 0);
-- 
2.7.4

