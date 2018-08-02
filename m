Return-Path: <SRS0=MSGh=KR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11F0BC43142
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 14:10:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B3D2F2150E
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 14:10:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NC7NwQxT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B3D2F2150E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732558AbeHBQBr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Aug 2018 12:01:47 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:36740 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732533AbeHBQBq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Aug 2018 12:01:46 -0400
Received: by mail-wr1-f67.google.com with SMTP id h9-v6so2299647wro.3;
        Thu, 02 Aug 2018 07:10:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=6U8OjZp1aNLtxv3SHkdF70T4ai4ppTPufaREl0hEaVo=;
        b=NC7NwQxTv0HljieeseJTwhkdZgSd7mFTuT/xOu07kdZm8AjMdqDjyRwHt16Yl2/Tv4
         +iL8EewGXE+KsdsNAQIm2fxUoom+y3uL2VoBe5jitGO0mAW9pg1cTgAh2pJhci1x71hl
         /QA4d4+OzKs/bIBDzkXqFcyTlaWF6XFCcTHYEyJ7zXmmM5QAOtJxazh/8Y0ggK8VsBqp
         Hwa8ah6BmUh1jEFyZ7pIAsEko18hLGGNE3axqmEyoqoCsAWc8QmSTG/oONCsRcDBoJ+r
         qlS6XDDXPhoAD/tRx3d+sTmgxKWCR1/zfW8+gTcwS2OxCI3FtTk7+k0zgFNtiQnPxWDC
         Yz7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=6U8OjZp1aNLtxv3SHkdF70T4ai4ppTPufaREl0hEaVo=;
        b=StWdRpF7YIzfJRbTbrMV5+n6G+v2WBC1gwfG3845tOTk9IV1vsUmrf8mMpvapSNsGo
         xwcHbsRf6HV8ZR21s2IU1DTZNLa4S8ci0oSal+1cAbN6ywTG2o04IGUeZ9VJWBqx5bNw
         oMEJeTCFRzrRTUyBZe1MP56vdPXJ9xUc6q03eJXmaZmfV7AmGlW8I0rKe7kOzhgDkzA8
         GUmRcmEbohWdwqmM/ibNp2UQ8AFULHH4TGnKYOXZkSEnr52X7u+2LDcFF1jINzvVwJzr
         Dl2ShI/7HGgWUEzZ2tKsd+NPxhnUHEVsjRyaR+kUia0JwNjkQQXaWRc9gLscxvZRh8JO
         htzw==
X-Gm-Message-State: AOUpUlEWtSBvX6eMSASiTxTAJLD1f6Our7JhQOdK0PLywfCjSZN91os5
        q51L/XSGx5CRolq2w1zJRoc=
X-Google-Smtp-Source: AAOMgpfs/l3B2fdbgBOhmC40D/qnZ7aT0hCkuYpGzyHiSgivo/tFd4eZu0062KOn5Yfi1Wvj+jLKUQ==
X-Received: by 2002:adf:fec8:: with SMTP id q8-v6mr2192742wrs.164.1533219022144;
        Thu, 02 Aug 2018 07:10:22 -0700 (PDT)
Received: from NewMoon.iit.local ([90.147.180.254])
        by smtp.gmail.com with ESMTPSA id d78-v6sm3392310wma.37.2018.08.02.07.10.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 02 Aug 2018 07:10:21 -0700 (PDT)
From:   Andrea Merello <andrea.merello@gmail.com>
To:     vkoul@kernel.org, dan.j.williams@intel.com,
        michal.simek@xilinx.com, appana.durga.rao@xilinx.com,
        dmaengine@vger.kernel.org
Cc:     v4-000linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, robh+dt@kernel.org,
        mark.rutland@arm.com, devicetree@vger.kernel.org,
        radhey.shyam.pandey@xilinx.com,
        Andrea Merello <andrea.merello@gmail.com>
Subject: [PATCH v4 4/7] dmaengine: xilinx_dma: program hardware supported buffer length
Date:   Thu,  2 Aug 2018 16:10:09 +0200
Message-Id: <20180802141012.19970-4-andrea.merello@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180802141012.19970-1-andrea.merello@gmail.com>
References: <20180802141012.19970-1-andrea.merello@gmail.com>
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
Changes in v4:
	- upper bound for the property should be 26, not 23
	- add warn for width > 23 as per xilinx original patch
	- rework due to changes introduced in 1/6
---
 drivers/dma/xilinx/xilinx_dma.c | 36 +++++++++++++++++++++++++--------
 1 file changed, 28 insertions(+), 8 deletions(-)

diff --git a/drivers/dma/xilinx/xilinx_dma.c b/drivers/dma/xilinx/xilinx_dma.c
index aaa6de8a70e4..b17f24e4ec35 100644
--- a/drivers/dma/xilinx/xilinx_dma.c
+++ b/drivers/dma/xilinx/xilinx_dma.c
@@ -158,7 +158,9 @@
 #define XILINX_DMA_REG_BTT		0x28
 
 /* AXI DMA Specific Masks/Bit fields */
-#define XILINX_DMA_MAX_TRANS_LEN	GENMASK(22, 0)
+#define XILINX_DMA_MAX_TRANS_LEN_MIN	8
+#define XILINX_DMA_MAX_TRANS_LEN_MAX	23
+#define XILINX_DMA_V2_MAX_TRANS_LEN_MAX	26
 #define XILINX_DMA_CR_COALESCE_MAX	GENMASK(23, 16)
 #define XILINX_DMA_CR_CYCLIC_BD_EN_MASK	BIT(4)
 #define XILINX_DMA_CR_COALESCE_SHIFT	16
@@ -418,6 +420,7 @@ struct xilinx_dma_config {
  * @rxs_clk: DMA s2mm stream clock
  * @nr_channels: Number of channels DMA device supports
  * @chan_id: DMA channel identifier
+ * @max_buffer_len: Max buffer length
  */
 struct xilinx_dma_device {
 	void __iomem *regs;
@@ -437,6 +440,7 @@ struct xilinx_dma_device {
 	struct clk *rxs_clk;
 	u32 nr_channels;
 	u32 chan_id;
+	u32 max_buffer_len;
 };
 
 /* Macros */
@@ -964,7 +968,7 @@ static int xilinx_dma_calc_copysize(struct xilinx_dma_chan *chan,
 				    int size, int done)
 {
 	size_t copy = min_t(size_t, size - done,
-		     XILINX_DMA_MAX_TRANS_LEN);
+			    chan->xdev->max_buffer_len);
 
 	if ((copy + done < size) &&
 	    chan->xdev->common.copy_align) {
@@ -1011,7 +1015,7 @@ static enum dma_status xilinx_dma_tx_status(struct dma_chan *dchan,
 			list_for_each_entry(segment, &desc->segments, node) {
 				hw = &segment->hw;
 				residue += (hw->control - hw->status) &
-					   XILINX_DMA_MAX_TRANS_LEN;
+					   chan->xdev->max_buffer_len;
 			}
 		}
 		spin_unlock_irqrestore(&chan->lock, flags);
@@ -1263,7 +1267,7 @@ static void xilinx_cdma_start_transfer(struct xilinx_dma_chan *chan)
 
 		/* Start the transfer */
 		dma_ctrl_write(chan, XILINX_DMA_REG_BTT,
-				hw->control & XILINX_DMA_MAX_TRANS_LEN);
+				hw->control & chan->xdev->max_buffer_len);
 	}
 
 	list_splice_tail_init(&chan->pending_list, &chan->active_list);
@@ -1366,7 +1370,7 @@ static void xilinx_dma_start_transfer(struct xilinx_dma_chan *chan)
 
 		/* Start the transfer */
 		dma_ctrl_write(chan, XILINX_DMA_REG_BTT,
-			       hw->control & XILINX_DMA_MAX_TRANS_LEN);
+			       hw->control & chan->xdev->max_buffer_len);
 	}
 
 	list_splice_tail_init(&chan->pending_list, &chan->active_list);
@@ -1727,7 +1731,7 @@ xilinx_cdma_prep_memcpy(struct dma_chan *dchan, dma_addr_t dma_dst,
 	struct xilinx_cdma_tx_segment *segment;
 	struct xilinx_cdma_desc_hw *hw;
 
-	if (!len || len > XILINX_DMA_MAX_TRANS_LEN)
+	if (!len || len > chan->xdev->max_buffer_len)
 		return NULL;
 
 	desc = xilinx_dma_alloc_tx_descriptor(chan);
@@ -2596,7 +2600,7 @@ static int xilinx_dma_probe(struct platform_device *pdev)
 	struct xilinx_dma_device *xdev;
 	struct device_node *child, *np = pdev->dev.of_node;
 	struct resource *io;
-	u32 num_frames, addr_width;
+	u32 num_frames, addr_width, len_width;
 	int i, err;
 
 	/* Allocate and initialize the DMA engine structure */
@@ -2628,8 +2632,24 @@ static int xilinx_dma_probe(struct platform_device *pdev)
 
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
+			    len_width > XILINX_DMA_V2_MAX_TRANS_LEN_MAX) {
+				dev_warn(xdev->dev,
+					 "invalid xlnx,sg-length-width property value. Using default width\n");
+			} else {
+				if (len_width > XILINX_DMA_MAX_TRANS_LEN_MAX)
+					dev_warn(xdev->dev, "Please ensure that IP supports buffer length > 23 bits\n");
+				xdev->max_buffer_len =
+					GENMASK(len_width - 1, 0);
+			}
+		}
+	}
 
 	if (xdev->dma_config->dmatype == XDMA_TYPE_VDMA) {
 		err = of_property_read_u32(node, "xlnx,num-fstores",
-- 
2.17.1

