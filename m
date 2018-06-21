Return-Path: <SRS0=bmN+=JH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C787C43140
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 11:58:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E2C0F20883
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 11:58:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tGAH/vNx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E2C0F20883
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933354AbeFUL6g (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Jun 2018 07:58:36 -0400
Received: from mail-wr0-f194.google.com ([209.85.128.194]:39599 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933291AbeFUL6d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jun 2018 07:58:33 -0400
Received: by mail-wr0-f194.google.com with SMTP id w7-v6so2895548wrn.6;
        Thu, 21 Jun 2018 04:58:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=v684pIrATVLLWDKFFulL9cdNmFI1AN+h9Qt80d+4eVM=;
        b=tGAH/vNxnAhvscDJqkuQmEUH/2tXJTXtsGW7jsuCgNxZW+wqG1LyKpe0f7uFPGUrBK
         PQuJoOxGU2L0Xts8CrZH9Bhq/Lv2yI/RcjJZ8B0wKroIIfYk0NiAgvZ1457r1Kr94WIw
         ldBWZDUk0X4Tutql/t2e70OA0P4yk0ygoL0HlBZb+bO/WIj1+PAPJBgfi2VXK5uFWtvS
         YO0v6sQ+jbDANMIe60/SfxRSL0/+qvXL7+GWtHuDNydelBsFQ44L54p0ECVBiiSEJDyO
         1k+t6Yznc+zt9pJGPpz9tf3mRiRsnkEYgxyZN4MK/tRCFrypzq5gq2F7yDGMqK3l8lYz
         gR7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=v684pIrATVLLWDKFFulL9cdNmFI1AN+h9Qt80d+4eVM=;
        b=Nyr2HrY3p48cimEtXWOzuJ8dcOGGIZgxoPlk8qPoRmaoup0vdxMnq25ANr+jjh6+WV
         upUKESrmqesrMJxp6uxU5t6La/l8R8CSH+33wTwAW4DBBw8vsW8Yn/wRQq/1zosq+Azp
         f9KcNpbafbo/p3KAMDJAVLOuR/WOa3J3HNS83eLyMDwQufC4XxfaO7ce4TJ85Y5MKJAu
         B5YiuiOx+Fz+VIwkvEydJc0HChNmXHIHf2g6F8TnOKXjVuwGHYn3CfafOz15bzxkwSWx
         lVYsBEfKv4g4n6znrF7vJBoHxJD3DzvBjzzbFONRJaEPyCVOU83L1m1fL/FLrciW52At
         2jDQ==
X-Gm-Message-State: APt69E1G49SsC9rAYaS9zt9/Kor12QGSpV8bGRJs47qwjZ7KA2jLYi7g
        JbE/m0oXnkbXXYa0273q/eQ=
X-Google-Smtp-Source: ADUXVKLHsGHQqeWLZlggSxgTm432SaT4JkDmECkotyNDk0Nkgxl+16RwfYIzI54ll6nPx8idFdj9Ag==
X-Received: by 2002:adf:f281:: with SMTP id k1-v6mr8589144wro.263.1529582312153;
        Thu, 21 Jun 2018 04:58:32 -0700 (PDT)
Received: from NewMoon.iit.local ([90.147.180.254])
        by smtp.gmail.com with ESMTPSA id e188-v6sm13779773wmf.21.2018.06.21.04.58.30
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 21 Jun 2018 04:58:31 -0700 (PDT)
From:   Andrea Merello <andrea.merello@gmail.com>
To:     vkoul@kernel.org, dan.j.williams@intel.com,
        michal.simek@xilinx.com, appana.durga.rao@xilinx.com,
        dmaengine@vger.kernel.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Radhey Shyam Pandey <radhey.shyam.pandey@xilinx.com>,
        Radhey Shyam Pandey <radheys@xilinx.com>,
        Andrea Merello <andrea.merello@gmail.com>
Subject: [PATCH v2 3/5] dmaengine: xilinx_dma: program hardware supported buffer length
Date:   Thu, 21 Jun 2018 13:58:20 +0200
Message-Id: <20180621115822.20058-3-andrea.merello@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180621115822.20058-1-andrea.merello@gmail.com>
References: <20180621115822.20058-1-andrea.merello@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Radhey Shyam Pandey <radhey.shyam.pandey@xilinx.com>

AXI-DMA IP supports configurable (c_sg_length_width) buffer length
register width, hence read buffer length (xlnx,sg-length-width) DT
property and ensure that driver doesn't program buffer length
exceeding the supported limit. For VDMA and CDMA there is no change.

Signed-off-by: Radhey Shyam Pandey <radheys@xilinx.com>
Signed-off-by: Michal Simek <michal.simek@xilinx.com>
Signed-off-by: Andrea Merello <andrea.merello@gmail.com> [rebase, reword]
---
Changes in v2:
	- drop original patch and replace with the one in Xilinx tree
---
 drivers/dma/xilinx/xilinx_dma.c | 39 +++++++++++++++++++++++----------
 1 file changed, 28 insertions(+), 11 deletions(-)

diff --git a/drivers/dma/xilinx/xilinx_dma.c b/drivers/dma/xilinx/xilinx_dma.c
index 22d7a6b85e65..e10775d30515 100644
--- a/drivers/dma/xilinx/xilinx_dma.c
+++ b/drivers/dma/xilinx/xilinx_dma.c
@@ -158,7 +158,8 @@
 #define XILINX_DMA_REG_BTT		0x28
 
 /* AXI DMA Specific Masks/Bit fields */
-#define XILINX_DMA_MAX_TRANS_LEN	GENMASK(22, 0)
+#define XILINX_DMA_MAX_TRANS_LEN_MIN	8
+#define XILINX_DMA_MAX_TRANS_LEN_MAX	23
 #define XILINX_DMA_CR_COALESCE_MAX	GENMASK(23, 16)
 #define XILINX_DMA_CR_CYCLIC_BD_EN_MASK	BIT(4)
 #define XILINX_DMA_CR_COALESCE_SHIFT	16
@@ -418,6 +419,7 @@ struct xilinx_dma_config {
  * @rxs_clk: DMA s2mm stream clock
  * @nr_channels: Number of channels DMA device supports
  * @chan_id: DMA channel identifier
+ * @max_buffer_len: Max buffer length
  */
 struct xilinx_dma_device {
 	void __iomem *regs;
@@ -437,6 +439,7 @@ struct xilinx_dma_device {
 	struct clk *rxs_clk;
 	u32 nr_channels;
 	u32 chan_id;
+	u32 max_buffer_len;
 };
 
 /* Macros */
@@ -985,7 +988,7 @@ static enum dma_status xilinx_dma_tx_status(struct dma_chan *dchan,
 			list_for_each_entry(segment, &desc->segments, node) {
 				hw = &segment->hw;
 				residue += (hw->control - hw->status) &
-					   XILINX_DMA_MAX_TRANS_LEN;
+					   chan->xdev->max_buffer_len;
 			}
 		}
 		spin_unlock_irqrestore(&chan->lock, flags);
@@ -1237,7 +1240,7 @@ static void xilinx_cdma_start_transfer(struct xilinx_dma_chan *chan)
 
 		/* Start the transfer */
 		dma_ctrl_write(chan, XILINX_DMA_REG_BTT,
-				hw->control & XILINX_DMA_MAX_TRANS_LEN);
+				hw->control & chan->xdev->max_buffer_len);
 	}
 
 	list_splice_tail_init(&chan->pending_list, &chan->active_list);
@@ -1340,7 +1343,7 @@ static void xilinx_dma_start_transfer(struct xilinx_dma_chan *chan)
 
 		/* Start the transfer */
 		dma_ctrl_write(chan, XILINX_DMA_REG_BTT,
-			       hw->control & XILINX_DMA_MAX_TRANS_LEN);
+			       hw->control & chan->xdev->max_buffer_len);
 	}
 
 	list_splice_tail_init(&chan->pending_list, &chan->active_list);
@@ -1701,7 +1704,7 @@ xilinx_cdma_prep_memcpy(struct dma_chan *dchan, dma_addr_t dma_dst,
 	struct xilinx_cdma_tx_segment *segment;
 	struct xilinx_cdma_desc_hw *hw;
 
-	if (!len || len > XILINX_DMA_MAX_TRANS_LEN)
+	if (!len || len > chan->xdev->max_buffer_len)
 		return NULL;
 
 	desc = xilinx_dma_alloc_tx_descriptor(chan);
@@ -1793,9 +1796,9 @@ static struct dma_async_tx_descriptor *xilinx_dma_prep_slave_sg(
 			 * the next chunck start address is aligned
 			 */
 			copy = sg_dma_len(sg) - sg_used;
-			if (copy > XILINX_DMA_MAX_TRANS_LEN &&
+			if (copy > chan->xdev->max_buffer_len &&
 			    chan->xdev->common.copy_align)
-				copy = rounddown(XILINX_DMA_MAX_TRANS_LEN,
+				copy = rounddown(chan->xdev->max_buffer_len,
 					 (1 << chan->xdev->common.copy_align));
 
 			hw = &segment->hw;
@@ -1903,9 +1906,9 @@ static struct dma_async_tx_descriptor *xilinx_dma_prep_dma_cyclic(
 			 * the next chunck start address is aligned
 			 */
 			copy = period_len - sg_used;
-			if (copy > XILINX_DMA_MAX_TRANS_LEN &&
+			if (copy > chan->xdev->max_buffer_len &&
 			    chan->xdev->common.copy_align)
-				copy = rounddown(XILINX_DMA_MAX_TRANS_LEN,
+				copy = rounddown(chan->xdev->max_buffer_len,
 					 (1 << chan->xdev->common.copy_align));
 
 			hw = &segment->hw;
@@ -2580,7 +2583,7 @@ static int xilinx_dma_probe(struct platform_device *pdev)
 	struct xilinx_dma_device *xdev;
 	struct device_node *child, *np = pdev->dev.of_node;
 	struct resource *io;
-	u32 num_frames, addr_width;
+	u32 num_frames, addr_width, len_width;
 	int i, err;
 
 	/* Allocate and initialize the DMA engine structure */
@@ -2612,8 +2615,22 @@ static int xilinx_dma_probe(struct platform_device *pdev)
 
 	/* Retrieve the DMA engine properties from the device tree */
 	xdev->has_sg = of_property_read_bool(node, "xlnx,include-sg");
-	if (xdev->dma_config->dmatype == XDMA_TYPE_AXIDMA)
+	xdev->max_buffer_len = GENMASK(XILINX_DMA_MAX_TRANS_LEN_MAX - 1, 0);
+
+	if (xdev->dma_config->dmatype == XDMA_TYPE_AXIDMA) {
 		xdev->mcdma = of_property_read_bool(node, "xlnx,mcdma");
+		if (!of_property_read_u32(node, "xlnx,sg-length-width",
+					  &len_width)) {
+			if (len_width < XILINX_DMA_MAX_TRANS_LEN_MIN ||
+			    len_width > XILINX_DMA_MAX_TRANS_LEN_MAX) {
+				dev_warn(xdev->dev,
+					 "invalid xlnx,sg-length-width property value using default width\n");
+			} else {
+				xdev->max_buffer_len = GENMASK(len_width - 1,
+							       0);
+			}
+		}
+	}
 
 	if (xdev->dma_config->dmatype == XDMA_TYPE_VDMA) {
 		err = of_property_read_u32(node, "xlnx,num-fstores",
-- 
2.17.1

