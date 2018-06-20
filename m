Return-Path: <SRS0=ENXv=JG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A465C1B0F2
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 08:40:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2D3B8208B0
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 08:40:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZrTupqdg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2D3B8208B0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754751AbeFTIkQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Jun 2018 04:40:16 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:51289 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752121AbeFTIhP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jun 2018 04:37:15 -0400
Received: by mail-wm0-f68.google.com with SMTP id r15-v6so4575416wmc.1;
        Wed, 20 Jun 2018 01:37:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=t9MQYAOmI7Y6Qy9KdJkOklibnlYSu+GVEsbTDKzHajM=;
        b=ZrTupqdggzhN6U+LEbBXVzi+1McaTYE3YCQWxft9K90uy/e0L1XCj9hhqxOlFDxh6p
         LbTIYGLrksGzUiCUFZSutgyzogKxTyh4OJcf+ObFu2xC/akioWkKscYvoPIz8muw7K29
         iD0RIRUx1spQ2WYAZX4N3XFkkm9FxbpoppklBO9HsHMETx0rqWFnuR5Efy4ewUBYmoya
         5UKFvyYqW2JsHUS1pYtk/1v9nhzX4k2MlUD6LaNSAPubHcvgwJo3+fCU0CRR/zv7IfYU
         esiH5f+6P+BCMsLx5PTb7ZOpqcczMCTtQ5kGKyxKmVjaul1A27Cn0ZXbX39VVPNfxQoG
         yHYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=t9MQYAOmI7Y6Qy9KdJkOklibnlYSu+GVEsbTDKzHajM=;
        b=e8rSIiKmL5V4kiFF+2rRrgWi2Ojwk13+qJQ6qQzDcENxtCH0m3lJVBk6IQC/3xansZ
         yrRpcmmw/XQiuH7RMfzAtDBJdO8Fznu1akGHMQiHAAAqOLbVSzdhEwqp4XNGMKsgnqvb
         EjQIuKbe5xdB9RMJAz31sdRHncN5maXYEnJ3KB34VUmTB/595r2CGFuLrpNGM4lCj7Vg
         EamlogTwOfyv4R5o9tlMrhApbPRML0xXtbvx50X/P+SeIuWWhe7gyR3ve+A1MzSfB00M
         AuLCOcMIQBNo/ddVnMwGt/Rvc26e/XXbmvHQJJaZG7XEOP+mVwyO+7TA2VrZn9J618DU
         48lw==
X-Gm-Message-State: APt69E0qh5qk8nSeQPrGdet4AKz2YDbwxaMxGVJbQbmlS0AHEmELIz18
        WvWNlH//LaE1uTfqV70yjUU=
X-Google-Smtp-Source: ADUXVKLHFymVbJPBVa3Qb+yrIHkr83Q6Wp4zJQL1z5+E5XLf0LQrF1AJDYYrgX84Ys05iYyHpeUyXw==
X-Received: by 2002:a1c:108b:: with SMTP id 133-v6mr1025845wmq.136.1529483833850;
        Wed, 20 Jun 2018 01:37:13 -0700 (PDT)
Received: from NewMoon.iit.local ([90.147.180.254])
        by smtp.gmail.com with ESMTPSA id f24-v6sm1615933wmc.0.2018.06.20.01.37.12
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 20 Jun 2018 01:37:13 -0700 (PDT)
From:   Andrea Merello <andrea.merello@gmail.com>
To:     vkoul@kernel.org, dan.j.williams@intel.com,
        michal.simek@xilinx.com, appana.durga.rao@xilinx.com,
        dmaengine@vger.kernel.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Andrea Merello <andrea.merello@gmail.com>
Subject: [PATCH 5/6] dmaengine: xilinx_dma: autodetect whether the HW supports scatter-gather
Date:   Wed, 20 Jun 2018 10:36:52 +0200
Message-Id: <20180620083653.17010-5-andrea.merello@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180620083653.17010-1-andrea.merello@gmail.com>
References: <20180620083653.17010-1-andrea.merello@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The HW can be either direct-access or scatter-gather version. These are
SW incompatible.

The driver can handle both version: a DT property was used to
tell the driver whether to assume the HW is is scatter-gather mode.

This patch makes the driver to autodetect this information. The DT
property is not required anymore.

Signed-off-by: Andrea Merello <andrea.merello@gmail.com>
---
 drivers/dma/xilinx/xilinx_dma.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/drivers/dma/xilinx/xilinx_dma.c b/drivers/dma/xilinx/xilinx_dma.c
index bdbc8ba9092a..8c6e818e596f 100644
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
@@ -407,7 +408,6 @@ struct xilinx_dma_config {
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
@@ -2391,7 +2390,6 @@ static int xilinx_dma_chan_probe(struct xilinx_dma_device *xdev,
 
 	chan->dev = xdev->dev;
 	chan->xdev = xdev;
-	chan->has_sg = xdev->has_sg;
 	chan->desc_pendingcount = 0x0;
 	chan->ext_addr = xdev->ext_addr;
 	/* This variable ensures that descriptors are not
@@ -2488,6 +2486,13 @@ static int xilinx_dma_chan_probe(struct xilinx_dma_device *xdev,
 		chan->stop_transfer = xilinx_dma_stop_transfer;
 	}
 
+	/* check if SG is enabled */
+	if (dma_ctrl_read(chan, XILINX_DMA_REG_DMASR) &
+		XILINX_DMA_DMASR_SG_MASK)
+		chan->has_sg = true;
+	dev_dbg(chan->dev, "ch %d: SG %s\n", chan->id,
+		chan->has_sg ? "enabled" : "disabled");
+
 	/* Initialize the tasklet */
 	tasklet_init(&chan->tasklet, xilinx_dma_do_tasklet,
 			(unsigned long)chan);
@@ -2626,7 +2631,6 @@ static int xilinx_dma_probe(struct platform_device *pdev)
 		return PTR_ERR(xdev->regs);
 
 	/* Retrieve the DMA engine properties from the device tree */
-
 	if (xdev->dma_config->dmatype == XDMA_TYPE_AXIDMA) {
 		xdev->mcdma = of_property_read_bool(node, "xlnx,mcdma");
 		err = of_property_read_u32(node, "xlnx,lengthregwidth",
-- 
2.17.1

