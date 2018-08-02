Return-Path: <SRS0=MSGh=KR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85F1DC43142
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 14:10:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3EDAB2150E
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 14:10:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cCoY8ViY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3EDAB2150E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732597AbeHBQBw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Aug 2018 12:01:52 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:55325 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732231AbeHBQBv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Aug 2018 12:01:51 -0400
Received: by mail-wm0-f65.google.com with SMTP id f21-v6so2678843wmc.5;
        Thu, 02 Aug 2018 07:10:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=S8SsR4dVdv/4wZtJLFjZ6eGrkCyYWI+YHEF2LPUUXRw=;
        b=cCoY8ViYeYEKuWFtYnZiXHjUKxCHN7Lco6eB00/SwPSoYkdWTv2ezY0ZAPBCIZ1EXM
         sgtPS/rQ0INqUkIgB6QUxM7JoU3STX1jkX0JsVJuGJIlSibBOWW9hv0mM81jFCD1muTx
         dyKwJ3qg5VVjjAw/jmlfvairTVcvvIZj8iBPwQUcyQ4+DbDQTM2RfoxyyfPLETcfmYls
         zoG3NCNwHQCZHHMMTzisa5SnR7CqerYL4Zq4KCsTYIbEgaCGMlgi2rOozAzvwX5zSDyO
         w8295+ktryYS+Qvv3BVcccGfkHmkxqCethP35lpeJN8w57XvODuPFoev4lT+2t7dDPpd
         5rNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=S8SsR4dVdv/4wZtJLFjZ6eGrkCyYWI+YHEF2LPUUXRw=;
        b=oovZ7QG9xPmoaJpJyvOgRWNzJKbDAg7mwPzNgLNY++KpImf5t/CXGW1ay6ku6JHHkn
         1rCQ3k4bnDHQMZHEw42vbOBxMnYKRCQxu+Uo/T5UDH8V4FP74b0lV+MGBIQ0h+hBy0N8
         3w1/uqWjN4MxwCcGtjOKzhXr5CtO4PFaPFFcSFJaO72CqOsYjlYcvUxghbGCo/8ZbvbI
         Hjad7Io68/x5rT8PR16lPmMb/ZCmoKv2ST0feCBxwumVpySsF84/XYTMLf+kE8uwBo1O
         k0IqKXtKpL0q+3IOW4KGpMcD+nU45UJ4Ryzr8EFDz1QBTbKQHyCpNxEmjFkbH2t0GKi5
         LR4g==
X-Gm-Message-State: AOUpUlEoVt5d561XBCB9maB1QYv2MmfiJrRf+dsC4GXSP8rSrVT4QUbZ
        rOx0QdYRVjo4rNJamd/vsGU=
X-Google-Smtp-Source: AAOMgpegeRYi5FPkVKWuQmFKPuFnKjsK589XEoSFhU0j9YYAkUmwdDZWWNcFB6TfnN0twXU98KmPvA==
X-Received: by 2002:a1c:2142:: with SMTP id h63-v6mr2253193wmh.51.1533219026555;
        Thu, 02 Aug 2018 07:10:26 -0700 (PDT)
Received: from NewMoon.iit.local ([90.147.180.254])
        by smtp.gmail.com with ESMTPSA id d78-v6sm3392310wma.37.2018.08.02.07.10.24
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 02 Aug 2018 07:10:25 -0700 (PDT)
From:   Andrea Merello <andrea.merello@gmail.com>
To:     vkoul@kernel.org, dan.j.williams@intel.com,
        michal.simek@xilinx.com, appana.durga.rao@xilinx.com,
        dmaengine@vger.kernel.org
Cc:     v4-000linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, robh+dt@kernel.org,
        mark.rutland@arm.com, devicetree@vger.kernel.org,
        radhey.shyam.pandey@xilinx.com,
        Andrea Merello <andrea.merello@gmail.com>
Subject: [PATCH v4 7/7] dmaengine: xilinx_dma: Drop SG support for VDMA IP
Date:   Thu,  2 Aug 2018 16:10:12 +0200
Message-Id: <20180802141012.19970-7-andrea.merello@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180802141012.19970-1-andrea.merello@gmail.com>
References: <20180802141012.19970-1-andrea.merello@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

xilinx_vdma_start_transfer() is used only for VDMA IP, still it contains
conditional code on has_sg variable. has_sg is set only whenever the HW
does support SG mode, that is never true for VDMA IP.

This patch drops the never-taken branches.

Signed-off-by: Andrea Merello <andrea.merello@gmail.com>
---
Changes in V4: introduced this patch in series
---
 drivers/dma/xilinx/xilinx_dma.c | 84 +++++++++++++--------------------
 1 file changed, 32 insertions(+), 52 deletions(-)

diff --git a/drivers/dma/xilinx/xilinx_dma.c b/drivers/dma/xilinx/xilinx_dma.c
index 78d0f2f8225e..07ceadef0a00 100644
--- a/drivers/dma/xilinx/xilinx_dma.c
+++ b/drivers/dma/xilinx/xilinx_dma.c
@@ -1093,6 +1093,8 @@ static void xilinx_vdma_start_transfer(struct xilinx_dma_chan *chan)
 	struct xilinx_dma_tx_descriptor *desc, *tail_desc;
 	u32 reg, j;
 	struct xilinx_vdma_tx_segment *tail_segment;
+	struct xilinx_vdma_tx_segment *segment, *last = NULL;
+	int i = 0;
 
 	/* This function was invoked with lock held */
 	if (chan->err)
@@ -1112,14 +1114,6 @@ static void xilinx_vdma_start_transfer(struct xilinx_dma_chan *chan)
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
 	reg = dma_ctrl_read(chan, XILINX_DMA_REG_DMACR);
 
@@ -1128,15 +1122,11 @@ static void xilinx_vdma_start_transfer(struct xilinx_dma_chan *chan)
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
 
@@ -1158,48 +1148,38 @@ static void xilinx_vdma_start_transfer(struct xilinx_dma_chan *chan)
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

