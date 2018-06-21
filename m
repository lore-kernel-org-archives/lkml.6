Return-Path: <SRS0=bmN+=JH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D35A0C43141
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 11:59:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8F94420883
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 11:59:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i9ZEUz9i"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8F94420883
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933410AbeFUL7C (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Jun 2018 07:59:02 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:36002 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933130AbeFUL6f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jun 2018 07:58:35 -0400
Received: by mail-wm0-f68.google.com with SMTP id v131-v6so5543651wma.1;
        Thu, 21 Jun 2018 04:58:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=4W4DIDdGxuBxRPucSmvi31v19mPHgZ+Wwutdvb775Ak=;
        b=i9ZEUz9iI+JZUKtpRiNvgfDlT0Im+UVX+XiJNYarjZCa9DLrhupC4vKDYV+P1x3aH7
         yBvf7LFRwDtYc/Zey1YJplbC2pHbk4W7HAaenUlNfz0CEx03f7pUVyKbVMhKuoStfs1A
         9O1NWXOF0RuoycowxM4tIiuJIMOpLry9GW0h1TLQq0dLky/ZCvx6IHPyj+Ya8y4NZNfR
         6SsDOy3WI7EuM/DSOAbgweubNPQDgoob7ccz7TmXmE/UZJI8SWRRfoLT6IbZp4uXhn7O
         boptzJx6Ty1jvv41E5Z000Dr3FQahIkKzpUtjV1TLcyFTq7fStHWn1T7cex0l7jHxAae
         0XbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=4W4DIDdGxuBxRPucSmvi31v19mPHgZ+Wwutdvb775Ak=;
        b=i1bwrq8sDw26lrMhoDT1aFlD9Yc4bnUDDwcg/hXaxrz5YOVdJcmqKhstBt7azsOcBg
         aoOqVuiqjk9zY+eLuQdLZtjFcgblxlCJAfEeHY9B2aWQVvZMCkaFoo9ejF9eT0IAV7UV
         Qk7NFMd3iwodvkS3qfseS8N/k+wpqc1KFdLDIpQLhvD5isTGqJYgHuk5g8mU71lu7H6n
         5ipQapDgof4H+QGKGY2Exme9UJ8+pv7Pf2L7XbLZ4ar9a8foK41DKIX3g1D5wH2TELu6
         dP+bu2x0AGFWUiG542C/gEz/+Wc2iWO1tfZqyeZxQ1HoGc1Ad10NvkM9pSNbTqxKKLPY
         5BWQ==
X-Gm-Message-State: APt69E2jkKV+5UqgXdgoUQUmovBE/kRBAif+xA1xZpZvI1sM4BrvGSym
        r8gVvfbUh60YNlTXto2xPTs=
X-Google-Smtp-Source: ADUXVKJlR4CIBRjqrjAs1nSW5xy1Uf6LjyCb/amB4wh+LUTExcczGVwtVlJGqWuIrEgqcWlp8VcX7g==
X-Received: by 2002:a1c:4a16:: with SMTP id x22-v6mr4543637wma.122.1529582313377;
        Thu, 21 Jun 2018 04:58:33 -0700 (PDT)
Received: from NewMoon.iit.local ([90.147.180.254])
        by smtp.gmail.com with ESMTPSA id e188-v6sm13779773wmf.21.2018.06.21.04.58.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 21 Jun 2018 04:58:32 -0700 (PDT)
From:   Andrea Merello <andrea.merello@gmail.com>
To:     vkoul@kernel.org, dan.j.williams@intel.com,
        michal.simek@xilinx.com, appana.durga.rao@xilinx.com,
        dmaengine@vger.kernel.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Andrea Merello <andrea.merello@gmail.com>
Subject: [PATCH v2 4/5] dmaengine: xilinx_dma: autodetect whether the HW supports scatter-gather
Date:   Thu, 21 Jun 2018 13:58:21 +0200
Message-Id: <20180621115822.20058-4-andrea.merello@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180621115822.20058-1-andrea.merello@gmail.com>
References: <20180621115822.20058-1-andrea.merello@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The AXIDMA and CDMA HW can be either direct-access or scatter-gather
version. These are SW incompatible.

The driver can handle both version: a DT property was used to
tell the driver whether to assume the HW is is scatter-gather mode.

This patch makes the driver to autodetect this information. The DT
property is not required anymore.

No changes for VDMA.

Signed-off-by: Andrea Merello <andrea.merello@gmail.com>
---
Changes in v2:
	- autodetect only in !VDMA case
---
 drivers/dma/xilinx/xilinx_dma.c | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/drivers/dma/xilinx/xilinx_dma.c b/drivers/dma/xilinx/xilinx_dma.c
index e10775d30515..fac8f09ece5d 100644
--- a/drivers/dma/xilinx/xilinx_dma.c
+++ b/drivers/dma/xilinx/xilinx_dma.c
@@ -86,6 +86,7 @@
 #define XILINX_DMA_DMASR_DMA_DEC_ERR		BIT(6)
 #define XILINX_DMA_DMASR_DMA_SLAVE_ERR		BIT(5)
 #define XILINX_DMA_DMASR_DMA_INT_ERR		BIT(4)
+#define XILINX_DMA_DMASR_SG_MASK		BIT(3)
 #define XILINX_DMA_DMASR_IDLE			BIT(1)
 #define XILINX_DMA_DMASR_HALTED		BIT(0)
 #define XILINX_DMA_DMASR_DELAY_MASK		GENMASK(31, 24)
@@ -406,7 +407,6 @@ struct xilinx_dma_config {
  * @dev: Device Structure
  * @common: DMA device structure
  * @chan: Driver specific DMA channel
- * @has_sg: Specifies whether Scatter-Gather is present or not
  * @mcdma: Specifies whether Multi-Channel is present or not
  * @flush_on_fsync: Flush on frame sync
  * @ext_addr: Indicates 64 bit addressing is supported by dma device
@@ -426,7 +426,6 @@ struct xilinx_dma_device {
 	struct device *dev;
 	struct dma_device common;
 	struct xilinx_dma_chan *chan[XILINX_DMA_MAX_CHANS_PER_DEVICE];
-	bool has_sg;
 	bool mcdma;
 	u32 flush_on_fsync;
 	bool ext_addr;
@@ -2383,7 +2382,6 @@ static int xilinx_dma_chan_probe(struct xilinx_dma_device *xdev,
 
 	chan->dev = xdev->dev;
 	chan->xdev = xdev;
-	chan->has_sg = xdev->has_sg;
 	chan->desc_pendingcount = 0x0;
 	chan->ext_addr = xdev->ext_addr;
 	/* This variable ensures that descriptors are not
@@ -2476,6 +2474,15 @@ static int xilinx_dma_chan_probe(struct xilinx_dma_device *xdev,
 		chan->stop_transfer = xilinx_dma_stop_transfer;
 	}
 
+	/* check if SG is enabled (only for AXIDMA and CDMA) */
+	if (xdev->dma_config->dmatype != XDMA_TYPE_VDMA) {
+		if (dma_ctrl_read(chan, XILINX_DMA_REG_DMASR) &
+		    XILINX_DMA_DMASR_SG_MASK)
+			chan->has_sg = true;
+		dev_dbg(chan->dev, "ch %d: SG %s\n", chan->id,
+			chan->has_sg ? "enabled" : "disabled");
+	}
+
 	/* Initialize the tasklet */
 	tasklet_init(&chan->tasklet, xilinx_dma_do_tasklet,
 			(unsigned long)chan);
@@ -2614,7 +2621,6 @@ static int xilinx_dma_probe(struct platform_device *pdev)
 		return PTR_ERR(xdev->regs);
 
 	/* Retrieve the DMA engine properties from the device tree */
-	xdev->has_sg = of_property_read_bool(node, "xlnx,include-sg");
 	xdev->max_buffer_len = GENMASK(XILINX_DMA_MAX_TRANS_LEN_MAX - 1, 0);
 
 	if (xdev->dma_config->dmatype == XDMA_TYPE_AXIDMA) {
-- 
2.17.1

