Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 936CDC4321E
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 06:25:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 34D7C204EC
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 06:25:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ng5Jwu9N"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 34D7C204EC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727749AbeIGLFH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 07:05:07 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:36319 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725831AbeIGLEu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 07:04:50 -0400
Received: by mail-wm0-f66.google.com with SMTP id j192-v6so13474285wmj.1;
        Thu, 06 Sep 2018 23:25:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=8e5h0rJlmTWn/SkUrpSaeFuxlSy8Y3IfyDjMz/ZKAYw=;
        b=Ng5Jwu9N9JfkQVZVIOspqsxdHiGoOcr8lWcab+Z54nfXsZspRvOc9MtuLgwF+Ph3Mc
         BCL+woL6YxvEJ1fY5bZ3WPG+PvQCkIUcheYuDPx98CUWaSi16hDoftnjWPvuSWdffWxh
         Icok83NAjXKo1cZhg6dz2yr/ocvzgQIoH/p9ENQWzycuziEdd8L3r5Ju7Al33OBTe6iK
         mHO99FyD2q9TOYO8HeFVarY/7VTWwMiXSWelR6Mp0e8hMMRMK6FIKQEAdp9s7qHB2JgX
         cxdqRu0ht2+kPPvMu7pKjonfPn5cNsR3Dw/6wdyB1NpPrHBWfYhXVGNkgUUyxPhKRNF5
         xtcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=8e5h0rJlmTWn/SkUrpSaeFuxlSy8Y3IfyDjMz/ZKAYw=;
        b=jcUKscAjnCAheaM3VReYqUhbo429/vq0KQZWeoKtyDsKDeHjCoTZKNvoWpJ+NwXOzg
         kvTp/SiMDyHGkxgptjaFwOxDblXk8M+USMa+XNDfdM+qt34OZ2zzASiM+FhX/mzkgYnZ
         i+7UpG24r1ek3vyleJ7TDwxlUJ16EU+C2wOU//I0HKcMzVHatCC3CJ25K2WMRi8p3pkl
         CrUkitwt87H+TvkeDLgDXPVoXMmcUdF8fPU5cNL8PgJCRYzSzyg0AGRjGK8PB0WQBXhC
         kEkFfVEm/UJVJ18U2AKmfyfn5E2cEpePkZI+9AGQg2Y/80H+sHUnXHzi4OYFScgSwJ5g
         viYw==
X-Gm-Message-State: APzg51B6RjAxE/ZdDWh/zgBrzNM0fZVxlJIEP5fostrAy8fzJlYgyKYZ
        qS82cgvwEY+UySlFeLmqkGI=
X-Google-Smtp-Source: ANB0VdbgJ1zAVFS2WLOsxPpNjnh/dFP46Tq/qpBpj5udz5ZUBMUHFabciXeBdgHX6e+26ecH+D369w==
X-Received: by 2002:a1c:8682:: with SMTP id i124-v6mr4453038wmd.77.1536301522886;
        Thu, 06 Sep 2018 23:25:22 -0700 (PDT)
Received: from NewMoon.iit.local ([90.147.180.254])
        by smtp.gmail.com with ESMTPSA id w10-v6sm8387233wrp.31.2018.09.06.23.25.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 06 Sep 2018 23:25:22 -0700 (PDT)
From:   Andrea Merello <andrea.merello@gmail.com>
To:     vkoul@kernel.org, dan.j.williams@intel.com,
        michal.simek@xilinx.com, appana.durga.rao@xilinx.com,
        dmaengine@vger.kernel.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        robh+dt@kernel.org, mark.rutland@arm.com,
        devicetree@vger.kernel.org, radhey.shyam.pandey@xilinx.com,
        Andrea Merello <andrea.merello@gmail.com>
Subject: [PATCH v5 4/7] dmaengine: xilinx_dma: program hardware supported buffer length
Date:   Fri,  7 Sep 2018 08:24:59 +0200
Message-Id: <20180907062502.8241-4-andrea.merello@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180907062502.8241-1-andrea.merello@gmail.com>
References: <20180907062502.8241-1-andrea.merello@gmail.com>
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
Changes in v5:
	None
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

