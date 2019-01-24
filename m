Return-Path: <SRS0=jJS3=QA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6858EC282C5
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 20:24:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 360CA218B0
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 20:24:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="GxEUF/mC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728674AbfAXUYf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Jan 2019 15:24:35 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:32782 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728220AbfAXUYe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Jan 2019 15:24:34 -0500
Received: by mail-pf1-f196.google.com with SMTP id c123so3582352pfb.0
        for <linux-kernel@vger.kernel.org>; Thu, 24 Jan 2019 12:24:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=o7egLywBx6XayJjOoobZHgYLmJpcGqlES3T4nO9IJnw=;
        b=GxEUF/mCUMVCKT5nzmeUCxVm0VYUy9eNpqskIkS+Ymqzu6rlYMnNnx6ysfuz8yhG6g
         /qTNwLKnIGjTKKckr3GAHNMQmOPuWddFvEB6uNTbUKkckKoVDl97luVlxizEpcBc+VNK
         uvQP8h7F+J13oqa9Hn0FWHDLmqf06SIcl1ujo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=o7egLywBx6XayJjOoobZHgYLmJpcGqlES3T4nO9IJnw=;
        b=kbwuq593eLWMaySJyOYKv5pBGEnXlteFB7MrjVDf1j8/THS2dt1aqszvz6MEsErN7K
         rrxhAbtbCLLckY8+R7wvcQ6wihyG5xcHKDOabNtsFt39DZWVo+DhXY5Gi4oRZmCZeFJx
         lvm9WMJCsL7iHEW4076i1fTFljBlHeqp+Qt4iDvOIRiMyKCuZ/dcPHYPaP0aF0oRDXM9
         dXMLhDw/mmyaqBm/Q/jIX4QZHzt/kZYyT7OGqgx09wq6llGwVFDDywFJEZWFUxODP8Uw
         7kHH45/HoFlL8o3RzmeQiO6cO6QPhl/q+wx1a7yHXMQLTENlNoKJZ3n5bQcjoV8kYTtK
         0bmQ==
X-Gm-Message-State: AJcUukcWQ58UOgTjGJEzDTeDqXd+scQo+oe2ugpSYqNkCgfBSskMPANM
        XHNyarA/n8oFiny0BX8769mcnkvWkrLycQ==
X-Google-Smtp-Source: ALg8bN7PsIT7vScnvB02yRzQ1C4AY/iarOWVLV7Hm8+12JLqAvfUTagRnFwiEFOt0Qn7FXOgI+Odkg==
X-Received: by 2002:a62:2f06:: with SMTP id v6mr8067333pfv.216.1548361472700;
        Thu, 24 Jan 2019 12:24:32 -0800 (PST)
Received: from localhost.localdomain ([2601:1c2:680:1319:4e72:b9ff:fe99:466a])
        by smtp.gmail.com with ESMTPSA id c72sm45263309pfb.107.2019.01.24.12.24.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 24 Jan 2019 12:24:31 -0800 (PST)
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
Subject: [PATCH 3/8 v5] dma: k3dma: Upgrade k3dma driver to support hisi_asp_dma hardware
Date:   Thu, 24 Jan 2019 12:24:18 -0800
Message-Id: <1548361463-28372-4-git-send-email-john.stultz@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1548361463-28372-1-git-send-email-john.stultz@linaro.org>
References: <1548361463-28372-1-git-send-email-john.stultz@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Youlin Wang <wwx575822@notesmail.huawei.com>

On the hi3660 hardware there are two (at least) DMA controllers,
the DMA-P (Peripheral DMA) and the DMA-A (Audio DMA). The
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
v5:
* Typo, whitespace fixes. Use BIT() macro.
---
 drivers/dma/k3dma.c | 38 +++++++++++++++++++++++++++++++++-----
 1 file changed, 33 insertions(+), 5 deletions(-)

diff --git a/drivers/dma/k3dma.c b/drivers/dma/k3dma.c
index fdec2b6..4dce532 100644
--- a/drivers/dma/k3dma.c
+++ b/drivers/dma/k3dma.c
@@ -116,6 +116,14 @@ struct k3_dma_dev {
 	unsigned int		irq;
 };
 
+
+#define K3_FLAG_NOCLK	BIT(1)
+
+struct k3dma_soc_data {
+	unsigned long flags;
+};
+
+
 #define to_k3_dma(dmadev) container_of(dmadev, struct k3_dma_dev, slave)
 
 static int k3_dma_config_write(struct dma_chan *chan,
@@ -790,8 +798,21 @@ static int k3_dma_transfer_resume(struct dma_chan *chan)
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
@@ -810,6 +831,7 @@ static struct dma_chan *k3_of_dma_simple_xlate(struct of_phandle_args *dma_spec,
 
 static int k3_dma_probe(struct platform_device *op)
 {
+	const struct k3dma_soc_data *soc_data;
 	struct k3_dma_dev *d;
 	const struct of_device_id *of_id;
 	struct resource *iores;
@@ -823,6 +845,10 @@ static int k3_dma_probe(struct platform_device *op)
 	if (!d)
 		return -ENOMEM;
 
+	soc_data = device_get_match_data(&op->dev);
+	if (!soc_data)
+		return -EINVAL;
+
 	d->base = devm_ioremap_resource(&op->dev, iores);
 	if (IS_ERR(d->base))
 		return PTR_ERR(d->base);
@@ -835,10 +861,12 @@ static int k3_dma_probe(struct platform_device *op)
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

