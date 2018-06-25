Return-Path: <SRS0=Q/hc=JL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15638C43144
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 09:28:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BCCF8256B6
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 09:27:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fyJhGAyA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BCCF8256B6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754952AbeFYJ15 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Jun 2018 05:27:57 -0400
Received: from mail-wr0-f193.google.com ([209.85.128.193]:35168 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754253AbeFYJ1w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jun 2018 05:27:52 -0400
Received: by mail-wr0-f193.google.com with SMTP id c13-v6so2947736wrq.2;
        Mon, 25 Jun 2018 02:27:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=3HyvvjIw9Xn6m8m065EZDEFe0ui64C81VQb4RvWy7l4=;
        b=fyJhGAyA/YEpay1w72/DKKaWOKWSQquUi+9jeq0jDTi5EVM2bE0MKtUXmHWbuYGEd4
         wmSbbS4zdSkeI9M7RMrAgPnD1Pd+KyESaB59fg0P2xDRrndBNb6Db9+Vyfqi0sZKkQKf
         064IRhnBChIT5z1gR9R78Jlcm8qo5P2p0J3mEPnwV6QXU0jGrWDBnb2g6XJrqBuPqxpz
         eB/hg71E86KLFMrh1PU2tthVaS+z1UfPgyq/MH8PHj1+9Y7fqAUPmKb5R+KuOwqjySW8
         Q6ouABm7WVLeuCUHVB7SeMmgZF8ssqDDDljPY6qJFCj2qgcx2fVS9cSRkHGOopL8Skb1
         GsNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=3HyvvjIw9Xn6m8m065EZDEFe0ui64C81VQb4RvWy7l4=;
        b=Wc7yJaPOmAwGZ0NXd09Y+UpWA9IaOhiy2I+/6y1BXTuGhi518sm/wlA+7PsoCKXovb
         95i7WW/VdVbLtbFOrKbtCdvzbRTxACfi+Is1iN6C8nrEuioKqFxSMQkzQHkf8ztKDILa
         C8fPoF0cRbetS6dk4/Kbu00Ye+lguhdzuuAoN+Gb6mj2571afFE3hwAB3jRW/wnY7Ti7
         8RFmCP+5GTgvIOFq+7HfZ0OHakUdJwOQcx0g7qASP2ZrflwFPm3YF6nn/nd9DsyWfd9y
         6qd0tJtTmeEWU9MpE07ASavrVTA0BH/1WiHb4HhqtkGoHTxKEtmTbnG3j81EfrqJyr0b
         cMzQ==
X-Gm-Message-State: APt69E0mz8KLjWtkID/NpMIVZMR7HlkzMWxRxsdL9a1XQ0sadrMqrnWc
        x2Bf0ijTR59c1JxIJjuZ++Y=
X-Google-Smtp-Source: AAOMgpdi5lhpdqVZuHe2JytDP57cjUhSX8EnsxJsOqgsSHpyEq6WyLuiU0oMxI+7Bzpp7c9s8+RxTw==
X-Received: by 2002:adf:a706:: with SMTP id c6-v6mr9897597wrd.61.1529918870589;
        Mon, 25 Jun 2018 02:27:50 -0700 (PDT)
Received: from NewMoon.iit.local ([90.147.180.254])
        by smtp.gmail.com with ESMTPSA id v2-v6sm15638779wrm.84.2018.06.25.02.27.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 25 Jun 2018 02:27:49 -0700 (PDT)
From:   Andrea Merello <andrea.merello@gmail.com>
To:     vkoul@kernel.org, dan.j.williams@intel.com,
        michal.simek@xilinx.com, appana.durga.rao@xilinx.com,
        dmaengine@vger.kernel.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Radhey Shyam Pandey <radhey.shyam.pandey@xilinx.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        devicetree@vger.kernel.org,
        Andrea Merello <andrea.merello@gmail.com>
Subject: [PATCH v3 3/5] dmaengine: xilinx_dma: program hardware supported buffer length
Date:   Mon, 25 Jun 2018 11:27:22 +0200
Message-Id: <20180625092724.22164-3-andrea.merello@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180625092724.22164-1-andrea.merello@gmail.com>
References: <20180625092724.22164-1-andrea.merello@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Radhey Shyam Pandey <radhey.shyam.pandey@xilinx.com>

AXI-DMA IP supports configurable (c_sg_length_width) buffer length
register width, hence read buffer length (xlnx,sg-length-width) DT
property and ensure that driver doesn't program buffer length
exceeding the supported limit. For VDMA and CDMA there is no change.

Cc: Rob Herring <robh+dt@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: devicetree@vger.kernel.org
Signed-off-by: Radhey Shyam Pandey <radhey.shyam.pandey@xilinx.com>
Signed-off-by: Michal Simek <michal.simek@xilinx.com>
Signed-off-by: Andrea Merello <andrea.merello@gmail.com> [rebase, reword]
---
Changes in v2:
        - drop original patch and replace with the one in Xilinx tree
Changes in v3:
	- cc DT maintainers/ML
---
 drivers/dma/xilinx/xilinx_dma.c | 35 ++++++++++++++++++++++++---------
 1 file changed, 26 insertions(+), 9 deletions(-)

diff --git a/drivers/dma/xilinx/xilinx_dma.c b/drivers/dma/xilinx/xilinx_dma.c
index 113d9bf1b6a1..7f0ab904b749 100644
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
@@ -1792,7 +1795,7 @@ static struct dma_async_tx_descriptor *xilinx_dma_prep_slave_sg(
 			 * making sure it is less than the hw limit
 			 */
 			copy = min_t(size_t, sg_dma_len(sg) - sg_used,
-				     XILINX_DMA_MAX_TRANS_LEN);
+				     chan->xdev->max_buffer_len);
 
 			if ((copy + sg_used < sg_dma_len(sg)) &&
 			    chan->xdev->common.copy_align) {
@@ -1907,7 +1910,7 @@ static struct dma_async_tx_descriptor *xilinx_dma_prep_dma_cyclic(
 			 * making sure it is less than the hw limit
 			 */
 			copy = min_t(size_t, period_len - sg_used,
-				     XILINX_DMA_MAX_TRANS_LEN);
+				     chan->xdev->max_buffer_len);
 
 			if ((copy + sg_used < period_len) &&
 			    chan->xdev->common.copy_align) {
@@ -2590,7 +2593,7 @@ static int xilinx_dma_probe(struct platform_device *pdev)
 	struct xilinx_dma_device *xdev;
 	struct device_node *child, *np = pdev->dev.of_node;
 	struct resource *io;
-	u32 num_frames, addr_width;
+	u32 num_frames, addr_width, len_width;
 	int i, err;
 
 	/* Allocate and initialize the DMA engine structure */
@@ -2622,8 +2625,22 @@ static int xilinx_dma_probe(struct platform_device *pdev)
 
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

