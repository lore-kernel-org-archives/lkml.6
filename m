Return-Path: <SRS0=ENXv=JG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B709C1B0F6
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 08:37:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BD7D7208B0
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 08:37:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="giK4wPdk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BD7D7208B0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932308AbeFTIhV (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Jun 2018 04:37:21 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:40061 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754774AbeFTIhK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jun 2018 04:37:10 -0400
Received: by mail-wm0-f67.google.com with SMTP id n5-v6so5181856wmc.5;
        Wed, 20 Jun 2018 01:37:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=4IjFTxxF8E/v5DFdSlTutseiCp+RfCzXVe2zCSSu9XY=;
        b=giK4wPdkduoxWVHLJuDuv7pVuEz6fuUrQ8md3BwwGFDbhrvxjS804Gccp7Sghynt0m
         v+QOsWuOev5nzwgHI3ZCFnLFqWOfgZag85A6G/oQ6L6PGUXjfZrPy24v04TWaKpxJHHR
         1L8GrVLMGkquJav/CcbUuZFp9IRHrorRGEmnisB+0rnN0FVRx6RtlbEOwQZ/r5a3s4Yd
         5aipVubVktl0DOnY2voiAmoD1JLLDoM+KjJvyLA1Mw1eywruE/5qWGfJikbRJK7jA1xX
         px36NUF3l6b/mIVkW8dOcst/CZjZDjHvWHxG47nDzgH3o+MUV4OrBqhM4ydYxBvPVZLj
         yADA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=4IjFTxxF8E/v5DFdSlTutseiCp+RfCzXVe2zCSSu9XY=;
        b=NBoWjF0suNfiFHQqJ4TONTvEPa6uc63iLzogrzLD7UbKa2ZHJZCErs4Yo8lMBqxcCa
         AAqFmPWzk20r7+qdcLNMBAwSTv3t63Gmq6wWE55iDMmpaLxVbnbJ90D4HMv4SLa9sKr0
         V8N/UWyUA457Ynz+bil5AmAh3K/t3fwB78UhWnvfIkw4Ji/s9iqT4DVAmn1gpL0Po5C1
         c3zpXa4LpCXZNHObSiVysBLR50kPLmdNF1JPJpIY2tMDEffwgzDSTj5mPW8m10WQJtUd
         UNTPZTfcZi24efSLF4V7zcWzdo8kvoWAxT43+X2q3ldXAySeWqkxZQbcH99J7XSe8vZE
         mDQg==
X-Gm-Message-State: APt69E0aUP9sC9rYmHId1qNYWoBQSLQOquuUS4FmUMfeBFaYwXt0XRBq
        FZDW/TgA7Fz5obdRf0Ll0rc=
X-Google-Smtp-Source: ADUXVKIkwNX/8jYuu3Vm64mlKynITjI+IuWzaml6ccUXqVt2XoSH/6OT8wEZLx4Yh1kRSdf6oqZHNQ==
X-Received: by 2002:a1c:78b:: with SMTP id 133-v6mr984647wmh.59.1529483829337;
        Wed, 20 Jun 2018 01:37:09 -0700 (PDT)
Received: from NewMoon.iit.local ([90.147.180.254])
        by smtp.gmail.com with ESMTPSA id f24-v6sm1615933wmc.0.2018.06.20.01.37.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 20 Jun 2018 01:37:08 -0700 (PDT)
From:   Andrea Merello <andrea.merello@gmail.com>
To:     vkoul@kernel.org, dan.j.williams@intel.com,
        michal.simek@xilinx.com, appana.durga.rao@xilinx.com,
        dmaengine@vger.kernel.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Andrea Merello <andrea.merello@gmail.com>
Subject: [PATCH 2/6] dmaengine: xilinx_dma: fix completion callback is not invoked for each DMA operation
Date:   Wed, 20 Jun 2018 10:36:49 +0200
Message-Id: <20180620083653.17010-2-andrea.merello@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180620083653.17010-1-andrea.merello@gmail.com>
References: <20180620083653.17010-1-andrea.merello@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

API specification says: "On completion of each DMA operation, the next in
queue is started and a tasklet triggered. The tasklet will then call the
client driver completion callback routine for notification, if set."

Currently the driver keeps a "desc_pendingcount" counter of the total
descriptor pending, and it uses as IRQ coalesce threshold, as result it
only calls the CBs after ALL pending operations are completed, which is
wrong.

This patch uses disable IRQ coalesce and checks for the completion flag
for the descriptors (which is further divided in segments).

Possibly a better optimization could be using proper IRQ coalesce
threshold to get an IRQ after all segments of the descriptors are done.
But we don't do that yet..

NOTE: for now we do this only for AXI DMA, other DMA flavors are
untested/untouched.
This is loosely based on
commit 65df81a6dc74 ("xilinx_dma: IrqThreshold set incorrectly, unreliable.")
in my linux-4.6-zynq tree

From: Jeremy Trimble [original patch]
Signed-off-by: Andrea Merello <andrea.merello@gmail.com>
---
 drivers/dma/xilinx/xilinx_dma.c | 39 +++++++++++++++++++++------------
 1 file changed, 25 insertions(+), 14 deletions(-)

diff --git a/drivers/dma/xilinx/xilinx_dma.c b/drivers/dma/xilinx/xilinx_dma.c
index a516e7ffef21..cf12f7147f07 100644
--- a/drivers/dma/xilinx/xilinx_dma.c
+++ b/drivers/dma/xilinx/xilinx_dma.c
@@ -164,6 +164,7 @@
 #define XILINX_DMA_CR_COALESCE_SHIFT	16
 #define XILINX_DMA_BD_SOP		BIT(27)
 #define XILINX_DMA_BD_EOP		BIT(26)
+#define XILINX_DMA_BD_CMPLT		BIT(31)
 #define XILINX_DMA_COALESCE_MAX		255
 #define XILINX_DMA_NUM_DESCS		255
 #define XILINX_DMA_NUM_APP_WORDS	5
@@ -1274,12 +1275,9 @@ static void xilinx_dma_start_transfer(struct xilinx_dma_chan *chan)
 
 	reg = dma_ctrl_read(chan, XILINX_DMA_REG_DMACR);
 
-	if (chan->desc_pendingcount <= XILINX_DMA_COALESCE_MAX) {
-		reg &= ~XILINX_DMA_CR_COALESCE_MAX;
-		reg |= chan->desc_pendingcount <<
-				  XILINX_DMA_CR_COALESCE_SHIFT;
-		dma_ctrl_write(chan, XILINX_DMA_REG_DMACR, reg);
-	}
+	reg &= ~XILINX_DMA_CR_COALESCE_MAX;
+	reg |= 1 << XILINX_DMA_CR_COALESCE_SHIFT;
+	dma_ctrl_write(chan, XILINX_DMA_REG_DMACR, reg);
 
 	if (chan->has_sg && !chan->xdev->mcdma)
 		xilinx_write(chan, XILINX_DMA_REG_CURDESC,
@@ -1378,6 +1376,20 @@ static void xilinx_dma_complete_descriptor(struct xilinx_dma_chan *chan)
 		return;
 
 	list_for_each_entry_safe(desc, next, &chan->active_list, node) {
+		if (chan->xdev->dma_config->dmatype == XDMA_TYPE_AXIDMA) {
+			/*
+			 * Check whether the last segment in this descriptor
+			 * has been completed.
+			 */
+			const struct xilinx_axidma_tx_segment *const tail_seg =
+				list_last_entry(&desc->segments,
+						struct xilinx_axidma_tx_segment,
+						node);
+
+			/* we've processed all the completed descriptors */
+			if (!(tail_seg->hw.status & XILINX_DMA_BD_CMPLT))
+				break;
+		}
 		list_del(&desc->node);
 		if (!desc->cyclic)
 			dma_cookie_complete(&desc->async_tx);
@@ -1826,14 +1838,13 @@ static struct dma_async_tx_descriptor *xilinx_dma_prep_slave_sg(
 				   struct xilinx_axidma_tx_segment, node);
 	desc->async_tx.phys = segment->phys;
 
-	/* For the last DMA_MEM_TO_DEV transfer, set EOP */
-	if (chan->direction == DMA_MEM_TO_DEV) {
-		segment->hw.control |= XILINX_DMA_BD_SOP;
-		segment = list_last_entry(&desc->segments,
-					  struct xilinx_axidma_tx_segment,
-					  node);
-		segment->hw.control |= XILINX_DMA_BD_EOP;
-	}
+	/* For the first transfer, set SOP */
+	segment->hw.control |= XILINX_DMA_BD_SOP;
+	/* For the last transfer, set EOP */
+	segment = list_last_entry(&desc->segments,
+				  struct xilinx_axidma_tx_segment,
+				  node);
+	segment->hw.control |= XILINX_DMA_BD_EOP;
 
 	return &desc->async_tx;
 
-- 
2.17.1

