Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74AA2C282C2
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 07:37:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 429D3222BE
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 07:37:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="AdEP2CMh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388658AbfBMHh0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Feb 2019 02:37:26 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:39439 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732703AbfBMHhZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Feb 2019 02:37:25 -0500
Received: by mail-pl1-f193.google.com with SMTP id 101so778262pld.6
        for <linux-kernel@vger.kernel.org>; Tue, 12 Feb 2019 23:37:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=Tl+ZjTV+KcU5fBDKs0m9ebGZGFjjPg77/C3uMSParLg=;
        b=AdEP2CMhP7BXPDbHs2hRRQpvChf0BfjKB8D8qrFMOp0JQ+AsZ3LCIiZMNLf6ntk4zG
         2UoJqaj0Whc7RbxKH5qjnyh+jA8hGanetgehCBZpHQyWpYehxof/juRpE9uR4WKjqSKc
         VDhfSDsf1khjau98RGV/7WdLLxRgco7j6IUHt6vkY0vPeaqiErBCeHBrlyEPC8LtYgUY
         ycv7R7M1d0aRsmVFORh/M4Di6yY6HlZaMKEhMUrkhS2vTPFqEmk19Z0bkPPQHGpOnVK+
         oxjE8HTsEwmd/boJ1Bgstio/VtD9V7BTxrim/sNL3O31WHrkMlqKf76zUCq+PFkqcA10
         6TBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=Tl+ZjTV+KcU5fBDKs0m9ebGZGFjjPg77/C3uMSParLg=;
        b=kTbvjTNoHOM4MbZz0AnPjHF3xnmPMrDOqYvIqOSasacPa1JQG0lzYmVjgegX7+cvUY
         8c/PAMfcDh6VcHF2QjthOfmP/KpOsti8nRIqukZL1OMdbUYKQ8K/HUIqZRTecU2djgqm
         Ub5fcAFU7hRfjDQnxHzEz2oXlsNcRjZB0j1uSgj+Sb9P8JMp86sx0D+MJRZ0UxdKCZVW
         YWHdYBIVjsL8Lyl3dkGKHSoFgh33kGfwW0sDj2CPYj4hE+ub2d1XDEFkbxksWWlI7DSm
         5yLiF1Mg+SpdoKDX9PJzhRzmTFrT+eBoBpP1uM9+XxS/e7ghEDbZECDw1A7eH8RyK/m8
         opyQ==
X-Gm-Message-State: AHQUAuZI+QGYTV23ro6nqpoyEvD7+nxLjVBDTdaYBqK+zhGNaG9o5ih9
        g0kJTyjn5a//7B50ZTMTNOSV8Q==
X-Google-Smtp-Source: AHgI3IZvbs5kh7UjdkUtTaiQG4kVxfiNHUhtqYYlaQJNtZsU6fCjVCWo76SXsy7jCIjz3DVLBZQ26Q==
X-Received: by 2002:a17:902:9b90:: with SMTP id y16mr6872638plp.0.1550043444685;
        Tue, 12 Feb 2019 23:37:24 -0800 (PST)
Received: from baolinwangubtpc.spreadtrum.com ([117.18.48.102])
        by smtp.gmail.com with ESMTPSA id m67sm27060706pfm.73.2019.02.12.23.37.21
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 12 Feb 2019 23:37:23 -0800 (PST)
From:   Baolin Wang <baolin.wang@linaro.org>
To:     broonie@kernel.org, robh+dt@kernel.org, mark.rutland@arm.com
Cc:     orsonzhai@gmail.com, zhang.lyra@gmail.com, lanqing.liu@unisoc.com,
        baolin.wang@linaro.org, linux-spi@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/3] spi: sprd: Add the SPI irq function for the SPI DMA mode
Date:   Wed, 13 Feb 2019 15:36:09 +0800
Message-Id: <11e55b5f9b0d83649a5b81c7e3fdb667cd3ddc5b.1550043082.git.baolin.wang@linaro.org>
X-Mailer: git-send-email 1.7.9.5
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Lanqing Liu <lanqing.liu@unisoc.com>

The SPI irq event will use to complete the SPI work in the SPI DMA mode,
so this patch is a preparation for the following DMA mode support.

Moreover the SPI interrupt can be fired when removing the SPI controller,
so we should make sure the SPI controller has stopped the queue in
remove function before freeing the SPI irq.

Signed-off-by: Lanqing Liu <lanqing.liu@unisoc.com>
Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
---
Changes from v1:
 - Return IRQ_NONE if detecting incorrect interrupt status.
 - Add spi_controller_suspend in remove function.
---
 drivers/spi/spi-sprd.c |   51 ++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 51 insertions(+)

diff --git a/drivers/spi/spi-sprd.c b/drivers/spi/spi-sprd.c
index fa324ce..d1ddeee 100644
--- a/drivers/spi/spi-sprd.c
+++ b/drivers/spi/spi-sprd.c
@@ -133,6 +133,7 @@ struct sprd_spi {
 	void __iomem *base;
 	struct device *dev;
 	struct clk *clk;
+	int irq;
 	u32 src_clk;
 	u32 hw_mode;
 	u32 trans_len;
@@ -141,6 +142,7 @@ struct sprd_spi {
 	u32 hw_speed_hz;
 	u32 len;
 	int status;
+	struct completion xfer_completion;
 	const void *tx_buf;
 	void *rx_buf;
 	int (*read_bufs)(struct sprd_spi *ss, u32 len);
@@ -575,6 +577,48 @@ static int sprd_spi_transfer_one(struct spi_controller *sctlr,
 	return ret;
 }
 
+static irqreturn_t sprd_spi_handle_irq(int irq, void *data)
+{
+	struct sprd_spi *ss = (struct sprd_spi *)data;
+	u32 val = readl_relaxed(ss->base + SPRD_SPI_INT_MASK_STS);
+
+	if (val & SPRD_SPI_MASK_TX_END) {
+		writel_relaxed(SPRD_SPI_TX_END_CLR, ss->base + SPRD_SPI_INT_CLR);
+		if (!(ss->trans_mode & SPRD_SPI_RX_MODE))
+			complete(&ss->xfer_completion);
+
+		return IRQ_HANDLED;
+	}
+
+	if (val & SPRD_SPI_MASK_RX_END) {
+		writel_relaxed(SPRD_SPI_RX_END_CLR, ss->base + SPRD_SPI_INT_CLR);
+		complete(&ss->xfer_completion);
+
+		return IRQ_HANDLED;
+	}
+
+	return IRQ_NONE;
+}
+
+static int sprd_spi_irq_init(struct platform_device *pdev, struct sprd_spi *ss)
+{
+	int ret;
+
+	ss->irq = platform_get_irq(pdev, 0);
+	if (ss->irq < 0) {
+		dev_err(&pdev->dev, "failed to get irq resource\n");
+		return ss->irq;
+	}
+
+	ret = devm_request_irq(&pdev->dev, ss->irq, sprd_spi_handle_irq,
+				0, pdev->name, ss);
+	if (ret)
+		dev_err(&pdev->dev, "failed to request spi irq %d, ret = %d\n",
+			ss->irq, ret);
+
+	return ret;
+}
+
 static int sprd_spi_clk_init(struct platform_device *pdev, struct sprd_spi *ss)
 {
 	struct clk *clk_spi, *clk_parent;
@@ -635,11 +679,16 @@ static int sprd_spi_probe(struct platform_device *pdev)
 	sctlr->max_speed_hz = min_t(u32, ss->src_clk >> 1,
 				    SPRD_SPI_MAX_SPEED_HZ);
 
+	init_completion(&ss->xfer_completion);
 	platform_set_drvdata(pdev, sctlr);
 	ret = sprd_spi_clk_init(pdev, ss);
 	if (ret)
 		goto free_controller;
 
+	ret = sprd_spi_irq_init(pdev, ss);
+	if (ret)
+		goto free_controller;
+
 	ret = clk_prepare_enable(ss->clk);
 	if (ret)
 		goto free_controller;
@@ -690,6 +739,8 @@ static int sprd_spi_remove(struct platform_device *pdev)
 		return ret;
 	}
 
+	spi_controller_suspend(sctlr);
+
 	clk_disable_unprepare(ss->clk);
 	pm_runtime_put_noidle(&pdev->dev);
 	pm_runtime_disable(&pdev->dev);
-- 
1.7.9.5

