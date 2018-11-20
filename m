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
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA698C28CF8
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 15:32:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7CEC4208E3
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 15:32:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ogB5lTFm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7CEC4208E3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730106AbeKUCBv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Nov 2018 21:01:51 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:36129 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727135AbeKUCBu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Nov 2018 21:01:50 -0500
Received: by mail-wr1-f67.google.com with SMTP id t3so2438827wrr.3;
        Tue, 20 Nov 2018 07:32:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=4+qTUQgVrsH5WGyEnsnG2mHJoSQ0/3Ge4pcP7YNht8U=;
        b=ogB5lTFm7ZuZs4T50gjUg2yDDGIPay8vvwV4v8zHR8hLzsIjlFfzY684jd2+fDPIlN
         F6cC1RahcN/1utSO8sA6OwXEkpDJMhrLQqOK/ZejNh6jBtaqgwfJln5h39qk79BBw/IR
         mKOQXspeOWZRs+g4CwCZAroV7+ZrFvCZ4Pxaqfls6S6wQZbD6b0blGaatKxch0UgE5G3
         TFf4BE6swiFxeX/hCrpNkMiDnK9lH4BK9jVzH+kAokmSO0gPVhY14XH4SWRm13EJEyRU
         j8e41l/AbH4jZIjK4m/+ABI2Z/GezqHGeOh7w1kMXJx0zjV53e25rPmDHraWFrJl4j9t
         Sp0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=4+qTUQgVrsH5WGyEnsnG2mHJoSQ0/3Ge4pcP7YNht8U=;
        b=RH6EEQecYFyfXS8iyzeanD+WcwPKPWNhyWn5lXujBoG8/zVWv1v2D6udwuv7SJ2u++
         spGJRQB3okfKx09qTxOEhZwaWpnsQeWJnL9eJwBQfIEow71zIDYzOfDjNSQ7aNXlOjia
         dSDZNOel9WhwvaRC+Q1mP8thX1PrFIiQxZhAMpQFQ4SVVOAiQ23+nVScIUOi564B2Beu
         FMGk4/yy44zVKwLr+ibC++mq0/ZsyHWyUG9BzGrFG48iGIZHqKncI40Rp9x18uKueKDv
         LOCCZz3lb/5dKZYNebjk6FuhHBZ4J7javRy1mlB8dikNjNzozYEMUZQJm5+ffz1NTWvI
         Tieg==
X-Gm-Message-State: AA+aEWZYc04r429ojswiy7ZKi+d8WcINtK19IlvlEJksvkJ7oZmAEFbq
        jJhFay5nAfbbEJQVVMv83z8=
X-Google-Smtp-Source: AFSGD/Wgwqu4mZOeo6gWd7BZixfMYcxFMWc9tWShv/oee9CWwCkPYGUBgcnI3b5OjnzuVxoG4r1i0A==
X-Received: by 2002:adf:9cc2:: with SMTP id h2-v6mr2536834wre.322.1542727927050;
        Tue, 20 Nov 2018 07:32:07 -0800 (PST)
Received: from NewMoon.iit.local ([90.147.180.254])
        by smtp.gmail.com with ESMTPSA id k73sm14677464wmd.36.2018.11.20.07.32.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 20 Nov 2018 07:32:06 -0800 (PST)
From:   Andrea Merello <andrea.merello@gmail.com>
To:     vkoul@kernel.org, dan.j.williams@intel.com,
        michal.simek@xilinx.com, appana.durga.rao@xilinx.com,
        dmaengine@vger.kernel.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        robh+dt@kernel.org, mark.rutland@arm.com,
        devicetree@vger.kernel.org, radhey.shyam.pandey@xilinx.com,
        Andrea Merello <andrea.merello@gmail.com>
Subject: [PATCH v6 7/7] dmaengine: xilinx_dma: Drop SG support for VDMA IP
Date:   Tue, 20 Nov 2018 16:31:51 +0100
Message-Id: <20181120153151.18024-7-andrea.merello@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181120153151.18024-1-andrea.merello@gmail.com>
References: <20181120153151.18024-1-andrea.merello@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

xilinx_vdma_start_transfer() is used only for VDMA IP, still it contains
conditional code on has_sg variable. has_sg is set only whenever the HW
does support SG mode, that is never true for VDMA IP.

This patch drops the never-taken branches.

Signed-off-by: Andrea Merello <andrea.merello@gmail.com>
Reviewed-by: Radhey Shyam Pandey <radhey.shyam.pandey@xilinx.com>
---
Changes in V4: introduced this patch in series
Changes in v5:
	None
Changes in v6:
	None
---
 drivers/dma/xilinx/xilinx_dma.c | 84 +++++++++++++--------------------
 1 file changed, 32 insertions(+), 52 deletions(-)

diff --git a/drivers/dma/xilinx/xilinx_dma.c b/drivers/dma/xilinx/xilinx_dma.c
index 41bd8caca09e..a37e28a43885 100644
--- a/drivers/dma/xilinx/xilinx_dma.c
+++ b/drivers/dma/xilinx/xilinx_dma.c
@@ -1100,6 +1100,8 @@ static void xilinx_vdma_start_transfer(struct xilinx_dma_chan *chan)
 	struct xilinx_dma_tx_descriptor *desc, *tail_desc;
 	u32 reg, j;
 	struct xilinx_vdma_tx_segment *tail_segment;
+	struct xilinx_vdma_tx_segment *segment, *last = NULL;
+	int i = 0;
 
 	/* This function was invoked with lock held */
 	if (chan->err)
@@ -1119,14 +1121,6 @@ static void xilinx_vdma_start_transfer(struct xilinx_dma_chan *chan)
 	tail_segment = list_last_entry(&tail_desc->segments,
 				       struct xilinx_vdma_tx_segment, node);
 
-	/*
-	 * If hardware is idle, then all descriptors on the running lists are
-	 * done, start new transfers
-	 */
-	if (chan->has_sg)
-		dma_ctrl_write(chan, XILINX_DMA_REG_CURDESC,
-				desc->async_tx.phys);
-
 	/* Configure the hardware using info in the config structure */
 	if (chan->has_vflip) {
 		reg = dma_read(chan, XILINX_VDMA_REG_ENABLE_VERTICAL_FLIP);
@@ -1143,15 +1137,11 @@ static void xilinx_vdma_start_transfer(struct xilinx_dma_chan *chan)
 	else
 		reg &= ~XILINX_DMA_DMACR_FRAMECNT_EN;
 
-	/*
-	 * With SG, start with circular mode, so that BDs can be fetched.
-	 * In direct register mode, if not parking, enable circular mode
-	 */
-	if (chan->has_sg || !config->park)
-		reg |= XILINX_DMA_DMACR_CIRC_EN;
-
+	/* If not parking, enable circular mode */
 	if (config->park)
 		reg &= ~XILINX_DMA_DMACR_CIRC_EN;
+	else
+		reg |= XILINX_DMA_DMACR_CIRC_EN;
 
 	dma_ctrl_write(chan, XILINX_DMA_REG_DMACR, reg);
 
@@ -1173,48 +1163,38 @@ static void xilinx_vdma_start_transfer(struct xilinx_dma_chan *chan)
 		return;
 
 	/* Start the transfer */
-	if (chan->has_sg) {
-		dma_ctrl_write(chan, XILINX_DMA_REG_TAILDESC,
-				tail_segment->phys);
-		list_splice_tail_init(&chan->pending_list, &chan->active_list);
-		chan->desc_pendingcount = 0;
-	} else {
-		struct xilinx_vdma_tx_segment *segment, *last = NULL;
-		int i = 0;
-
-		if (chan->desc_submitcount < chan->num_frms)
-			i = chan->desc_submitcount;
-
-		list_for_each_entry(segment, &desc->segments, node) {
-			if (chan->ext_addr)
-				vdma_desc_write_64(chan,
-					XILINX_VDMA_REG_START_ADDRESS_64(i++),
-					segment->hw.buf_addr,
-					segment->hw.buf_addr_msb);
-			else
-				vdma_desc_write(chan,
+	if (chan->desc_submitcount < chan->num_frms)
+		i = chan->desc_submitcount;
+
+	list_for_each_entry(segment, &desc->segments, node) {
+		if (chan->ext_addr)
+			vdma_desc_write_64(chan,
+				   XILINX_VDMA_REG_START_ADDRESS_64(i++),
+				   segment->hw.buf_addr,
+				   segment->hw.buf_addr_msb);
+		else
+			vdma_desc_write(chan,
 					XILINX_VDMA_REG_START_ADDRESS(i++),
 					segment->hw.buf_addr);
 
-			last = segment;
-		}
-
-		if (!last)
-			return;
+		last = segment;
+	}
 
-		/* HW expects these parameters to be same for one transaction */
-		vdma_desc_write(chan, XILINX_DMA_REG_HSIZE, last->hw.hsize);
-		vdma_desc_write(chan, XILINX_DMA_REG_FRMDLY_STRIDE,
-				last->hw.stride);
-		vdma_desc_write(chan, XILINX_DMA_REG_VSIZE, last->hw.vsize);
+	if (!last)
+		return;
 
-		chan->desc_submitcount++;
-		chan->desc_pendingcount--;
-		list_del(&desc->node);
-		list_add_tail(&desc->node, &chan->active_list);
-		if (chan->desc_submitcount == chan->num_frms)
-			chan->desc_submitcount = 0;
-	}
+	/* HW expects these parameters to be same for one transaction */
+	vdma_desc_write(chan, XILINX_DMA_REG_HSIZE, last->hw.hsize);
+	vdma_desc_write(chan, XILINX_DMA_REG_FRMDLY_STRIDE,
+			last->hw.stride);
+	vdma_desc_write(chan, XILINX_DMA_REG_VSIZE, last->hw.vsize);
+
+	chan->desc_submitcount++;
+	chan->desc_pendingcount--;
+	list_del(&desc->node);
+	list_add_tail(&desc->node, &chan->active_list);
+	if (chan->desc_submitcount == chan->num_frms)
+		chan->desc_submitcount = 0;
 
 	chan->idle = false;
 }
-- 
2.17.1

