Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A37AC4321E
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 06:25:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 920F320861
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 06:25:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c3492NB2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 920F320861
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727677AbeIGLEw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 07:04:52 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:40538 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727611AbeIGLEv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 07:04:51 -0400
Received: by mail-wm0-f65.google.com with SMTP id 207-v6so13324587wme.5;
        Thu, 06 Sep 2018 23:25:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=FEMoKkzJKGEd2pan1RZSHub8CW5+hNLYSGu4iHTdeb8=;
        b=c3492NB2dogE6/5bD94zfn6zPBy1doJZTICG1U6YQS7B8WMUfLbtPiOaZg7t8TWuQm
         y5bVoDJlhlOlrEmibMwiHXyNSslerqA2t0kAtgIFA9iYFWEXvxwta2hmLb/iUGMCBWP7
         oRO3FYLWkobIGF08qPOB4Y1j3idWSiJ8fwCADuuGvTMoBs18cUWO2hP6Zm1Wb/yiLsVZ
         KuogfekYAHwTgt0lmpDp6CEKU0M1IM3Xb6SZ86qCwG300Yr9tImzb0TrrxOsRgkvXSjf
         G1reKJ10lX+u9U7hIlMFHFXpZcVMmyiBEsM8CYDtXPwioa84VfUfLL/fk0+jQQjcP3vu
         xjYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=FEMoKkzJKGEd2pan1RZSHub8CW5+hNLYSGu4iHTdeb8=;
        b=e1M0ihYbRfjA7K9BqWHCjnhYs9Rp0aOEkcxomQT1VoZSXXKqmxNu7rynFI0MND5+MP
         SZJw2CrByxoyc/TuqLtW/cx1g45WQALRb6NkutGhG+5D6eDrb5G+ahUj+z5et7YNQGrf
         TCVkUI7Po95Q5qRv/MP87lFReDpR8tJIIjCQxg2pm0U3vy0MQzNAsYS8zrMh62RhE9Ht
         9mx0Y0vDdS9894Qt+ULrIuFdOGO96ubRvvbfrKfHluzqUahytfPZ2k8r02upOHvP6M/P
         gbesluyMdC3g48p20HJEiFJKJCJNZXLY+2Ggpty85VcYpTO+zNPXk6FQFioiniNxbY4L
         iRyQ==
X-Gm-Message-State: APzg51CQauKZWrTVFyN7Za+cO7N8ICg2LBRdSAvxM5nPsVSGhUXp94BY
        rMUk2GhumFxbiag1Q+IgaFs=
X-Google-Smtp-Source: ANB0VdYNaGaKu7zukN4TPi+PO62pjY3gjPuWZVaJtu8FKvp235KumkQL5XilByeojUMshGIlsrG5/Q==
X-Received: by 2002:a1c:2e11:: with SMTP id u17-v6mr4134805wmu.102.1536301526621;
        Thu, 06 Sep 2018 23:25:26 -0700 (PDT)
Received: from NewMoon.iit.local ([90.147.180.254])
        by smtp.gmail.com with ESMTPSA id w10-v6sm8387233wrp.31.2018.09.06.23.25.25
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 06 Sep 2018 23:25:25 -0700 (PDT)
From:   Andrea Merello <andrea.merello@gmail.com>
To:     vkoul@kernel.org, dan.j.williams@intel.com,
        michal.simek@xilinx.com, appana.durga.rao@xilinx.com,
        dmaengine@vger.kernel.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        robh+dt@kernel.org, mark.rutland@arm.com,
        devicetree@vger.kernel.org, radhey.shyam.pandey@xilinx.com,
        Andrea Merello <andrea.merello@gmail.com>
Subject: [PATCH v5 7/7] dmaengine: xilinx_dma: Drop SG support for VDMA IP
Date:   Fri,  7 Sep 2018 08:25:02 +0200
Message-Id: <20180907062502.8241-7-andrea.merello@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180907062502.8241-1-andrea.merello@gmail.com>
References: <20180907062502.8241-1-andrea.merello@gmail.com>
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
Changes in v5:
	None
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

