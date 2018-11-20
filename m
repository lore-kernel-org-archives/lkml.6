Return-Path: <SRS0=i6x1=N7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2AA69C28CF8
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 15:32:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DFA1F206BB
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 15:32:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E7L5B6lv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DFA1F206BB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729970AbeKUCBp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Nov 2018 21:01:45 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:54825 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725898AbeKUCBn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Nov 2018 21:01:43 -0500
Received: by mail-wm1-f67.google.com with SMTP id r63-v6so2541561wma.4;
        Tue, 20 Nov 2018 07:31:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=UAVjVxrHy7jY0LD8rLTX0Nt447suhUTP5t0nzIFbdzg=;
        b=E7L5B6lvChTyKw1pqzpd7T+z6RZMF/JG26xYCU0vavXvAqEJ0H194iP8eSryW8kaMw
         F5//T2FUXh8KsDyBQh+sR88PKkbAOYlXZVGGwGcsaAeord2Y1SoL54/X+qO+83IQphuM
         CpwRpFHkjTGnpQMkMS44NiQuM1lD8DxikH1AlT6EkXAPgUYtf7thjesy+srXQf15eNkm
         okm7O7msB3Fk9fj3WKOhXoGMH5+BXsGisqq2BAvtbczrCUBCfhupLZww+jhYL+v4Bpnd
         7LCQ+ZU3Z1RYxWwEQgb7JkQNOwyAuhif1+5wAAAsiuN3yrF1TgkiLv6YxBYm/8ppKj1J
         qHwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=UAVjVxrHy7jY0LD8rLTX0Nt447suhUTP5t0nzIFbdzg=;
        b=C5RyY5+FZyHCrcE3XyNSzVeOJQfr0uIfbdQScgEfOMga/g4IovPsmkI3llxQiKWJYp
         Reb1mnFX2bgPxuHSLnMwwZlJn2vgcpcE4kjmOoSFkjM2E4RwE+LAclJGazOeUfjqrQ6Z
         urF1s7TxSPjh3vE1WHIVUhXL/SUkPEHx4x+kxIjdhfk1gLu+HtDtD7W+1ZxHqxiaClGU
         At47z+2Ed7P/Bnm33HS3Y6uMVrz0HX+jiivsDjOxCPV9j69xJ1QCCFlj+4hRonenSiBb
         SSrZrt9lUpNZBagxYnstUHpEUpBiyO78KIanX0hGlaOcJoWb3tRHgZBKE2lqHBH3WdJk
         jBmA==
X-Gm-Message-State: AGRZ1gLU54FdH0648dr/Rv13fFCJmCSWcGDW71513gHuf2FKbU0ac5au
        Xwa8pD25bqJJ8QO4eQtAAS4=
X-Google-Smtp-Source: AFSGD/VAH1OR78zL6To3VWVtf/8aiVkX5+7F81vDlu47T5yDS43QTemEe1SW3noUIRu33oiL6vhjJw==
X-Received: by 2002:a1c:7ec9:: with SMTP id z192-v6mr2504093wmc.43.1542727919065;
        Tue, 20 Nov 2018 07:31:59 -0800 (PST)
Received: from NewMoon.iit.local ([90.147.180.254])
        by smtp.gmail.com with ESMTPSA id k73sm14677464wmd.36.2018.11.20.07.31.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 20 Nov 2018 07:31:58 -0800 (PST)
From:   Andrea Merello <andrea.merello@gmail.com>
To:     vkoul@kernel.org, dan.j.williams@intel.com,
        michal.simek@xilinx.com, appana.durga.rao@xilinx.com,
        dmaengine@vger.kernel.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        robh+dt@kernel.org, mark.rutland@arm.com,
        devicetree@vger.kernel.org, radhey.shyam.pandey@xilinx.com,
        Andrea Merello <andrea.merello@gmail.com>
Subject: [PATCH v6 1/7] dmaengine: xilinx_dma: commonize DMA copy size calculation
Date:   Tue, 20 Nov 2018 16:31:45 +0100
Message-Id: <20181120153151.18024-1-andrea.merello@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch removes a bit of duplicated code by introducing a new
function that implements calculations for DMA copy size, and
prepares for changes to the copy size calculation that will
happen in following patches.

Suggested-by: Vinod Koul <vkoul@kernel.org>
Signed-off-by: Andrea Merello <andrea.merello@gmail.com>
Reviewed-by: Radhey Shyam Pandey <radhey.shyam.pandey@xilinx.com>
---
Changes in v4:
	- introduce this patch in the patch series
Changes in v5:
	None
Changes in v6:
	- 2/7 was basically redoing what done here. Anticipate
	  here the introduction of a local temporary variable
	  so that 2/7 just add stuff
	- add dma chan ptr argument to xilinx_calc_cma_copysize()
	  to prepare for 2/7
	- introduce max_buffer_len variable in advance, to prepare
	  for 4/7
	- reword for above changes
---
 drivers/dma/xilinx/xilinx_dma.c | 39 ++++++++++++++++++++++++++-------
 1 file changed, 31 insertions(+), 8 deletions(-)

diff --git a/drivers/dma/xilinx/xilinx_dma.c b/drivers/dma/xilinx/xilinx_dma.c
index c12442312595..2c1db500284f 100644
--- a/drivers/dma/xilinx/xilinx_dma.c
+++ b/drivers/dma/xilinx/xilinx_dma.c
@@ -423,6 +423,7 @@ struct xilinx_dma_config {
  * @rxs_clk: DMA s2mm stream clock
  * @nr_channels: Number of channels DMA device supports
  * @chan_id: DMA channel identifier
+ * @max_buffer_len: Max buffer length
  */
 struct xilinx_dma_device {
 	void __iomem *regs;
@@ -442,6 +443,7 @@ struct xilinx_dma_device {
 	struct clk *rxs_clk;
 	u32 nr_channels;
 	u32 chan_id;
+	u32 max_buffer_len;
 };
 
 /* Macros */
@@ -957,6 +959,25 @@ static int xilinx_dma_alloc_chan_resources(struct dma_chan *dchan)
 	return 0;
 }
 
+/**
+ * xilinx_dma_calc_copysize - Calculate the amount of data to copy
+ * @chan: Driver specific DMA channel
+ * @size: Total data that needs to be copied
+ * @done: Amount of data that has been already copied
+ *
+ * Return: Amount of data that has to be copied
+ */
+static int xilinx_dma_calc_copysize(struct xilinx_dma_chan *chan,
+				    int size, int done)
+{
+	size_t copy;
+
+	copy = min_t(size_t, size - done,
+		     chan->xdev->max_buffer_len);
+
+	return copy;
+}
+
 /**
  * xilinx_dma_tx_status - Get DMA transaction status
  * @dchan: DMA channel
@@ -990,7 +1011,7 @@ static enum dma_status xilinx_dma_tx_status(struct dma_chan *dchan,
 			list_for_each_entry(segment, &desc->segments, node) {
 				hw = &segment->hw;
 				residue += (hw->control - hw->status) &
-					   XILINX_DMA_MAX_TRANS_LEN;
+					   chan->xdev->max_buffer_len;
 			}
 		}
 		spin_unlock_irqrestore(&chan->lock, flags);
@@ -1250,7 +1271,7 @@ static void xilinx_cdma_start_transfer(struct xilinx_dma_chan *chan)
 
 		/* Start the transfer */
 		dma_ctrl_write(chan, XILINX_DMA_REG_BTT,
-				hw->control & XILINX_DMA_MAX_TRANS_LEN);
+				hw->control & chan->xdev->max_buffer_len);
 	}
 
 	list_splice_tail_init(&chan->pending_list, &chan->active_list);
@@ -1353,7 +1374,7 @@ static void xilinx_dma_start_transfer(struct xilinx_dma_chan *chan)
 
 		/* Start the transfer */
 		dma_ctrl_write(chan, XILINX_DMA_REG_BTT,
-			       hw->control & XILINX_DMA_MAX_TRANS_LEN);
+			       hw->control & chan->xdev->max_buffer_len);
 	}
 
 	list_splice_tail_init(&chan->pending_list, &chan->active_list);
@@ -1714,7 +1735,7 @@ xilinx_cdma_prep_memcpy(struct dma_chan *dchan, dma_addr_t dma_dst,
 	struct xilinx_cdma_tx_segment *segment;
 	struct xilinx_cdma_desc_hw *hw;
 
-	if (!len || len > XILINX_DMA_MAX_TRANS_LEN)
+	if (!len || len > chan->xdev->max_buffer_len)
 		return NULL;
 
 	desc = xilinx_dma_alloc_tx_descriptor(chan);
@@ -1804,8 +1825,8 @@ static struct dma_async_tx_descriptor *xilinx_dma_prep_slave_sg(
 			 * Calculate the maximum number of bytes to transfer,
 			 * making sure it is less than the hw limit
 			 */
-			copy = min_t(size_t, sg_dma_len(sg) - sg_used,
-				     XILINX_DMA_MAX_TRANS_LEN);
+			copy = xilinx_dma_calc_copysize(chan, sg_dma_len(sg),
+							sg_used);
 			hw = &segment->hw;
 
 			/* Fill in the descriptor */
@@ -1909,8 +1930,8 @@ static struct dma_async_tx_descriptor *xilinx_dma_prep_dma_cyclic(
 			 * Calculate the maximum number of bytes to transfer,
 			 * making sure it is less than the hw limit
 			 */
-			copy = min_t(size_t, period_len - sg_used,
-				     XILINX_DMA_MAX_TRANS_LEN);
+			copy = xilinx_dma_calc_copysize(chan, period_len,
+							sg_used);
 			hw = &segment->hw;
 			xilinx_axidma_buf(chan, hw, buf_addr, sg_used,
 					  period_len * i);
@@ -2624,6 +2645,8 @@ static int xilinx_dma_probe(struct platform_device *pdev)
 
 	/* Retrieve the DMA engine properties from the device tree */
 	xdev->has_sg = of_property_read_bool(node, "xlnx,include-sg");
+	xdev->max_buffer_len = XILINX_DMA_MAX_TRANS_LEN;
+
 	if (xdev->dma_config->dmatype == XDMA_TYPE_AXIDMA)
 		xdev->mcdma = of_property_read_bool(node, "xlnx,mcdma");
 
-- 
2.17.1

