Return-Path: <SRS0=ENXv=JG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C3F8C1B0F2
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 08:42:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BCBA2208B3
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 08:42:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WvjaXMlQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BCBA2208B3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932551AbeFTImF (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Jun 2018 04:42:05 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:55305 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750793AbeFTIhI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jun 2018 04:37:08 -0400
Received: by mail-wm0-f67.google.com with SMTP id v16-v6so4558756wmh.5;
        Wed, 20 Jun 2018 01:37:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=262zpq+do1+LiPh3ZhYGAc8Ufq93ppZA8LA0JFynjZg=;
        b=WvjaXMlQnEVdtSnOWGzyMrO62EPtiGoSjSyUJNX/L4dNtz5nuVjAqXuk3P8oRfok+D
         ZrXNgNTvHPumzm6qKJIeFvj97jh/DTFH86ubuvzc+jLp0jqhqRtuGfo7cCUp30BI5Yxq
         akDr+imBl6RXy4J+J8pJdY4MJ4rnzYFLPYanG47V4zL/rmbe+bYKyhis4AV3pxp3BhYA
         oWnQXH6dL0a5xk4VbQ+/QTcq3byGy5qn6DZXiCTf7/zIl6gXufQCihe3f+kTkrM8VUZZ
         Y9/rRfaPOiqT3uBaII/V8l19+xPacBliSjFjiHpwt/khvzHWbXfFfq5JoJXQMOCSgkCD
         U0EQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=262zpq+do1+LiPh3ZhYGAc8Ufq93ppZA8LA0JFynjZg=;
        b=ghNyoWSGR8b9B37DjBTzTmXd/cahF/be8OOxKYLnsVC7W5hblZjovSw0Woi1Wdvuh9
         7eYkHQsb6x6EiMUxMN62i0Ykj+G73Nh/moLFGOfPRP1ovwrbn8lK5uYEaHzKqPX1EwW6
         rLcuA4csZPXNf3vk+gtgT1pjvgt+wYrx4hkJTVH9LoX6K4fG30bDQ4bO/6Rh++Hf/fIL
         WiNmCU+NMqk04uU/ilQ1ZqbY/7c2k3LLPiTgftAnAEpZzrF6rpjPEabVSwCyEwMSZZS4
         N6GPAQi8fh9SusAava3EtO89Sc7LrO1USSz+fV346X7HrHRHq57ByRYD6jmZ/9oa2okj
         zp1g==
X-Gm-Message-State: APt69E0XZby6j4FYod7Rng0md3hh3L7HIv4sZSu/khshADZmN6jEX+cl
        xxk2ETxiixsu1op3FUcy2nA=
X-Google-Smtp-Source: ADUXVKKVO2lUws9L46s3QD4Gwn1b9Cz8U9Nbckife4SwhW/lGt4vFtKq5efMzbWBDCeo5qRiotbGsw==
X-Received: by 2002:a1c:7d56:: with SMTP id y83-v6mr1011018wmc.65.1529483827353;
        Wed, 20 Jun 2018 01:37:07 -0700 (PDT)
Received: from NewMoon.iit.local ([90.147.180.254])
        by smtp.gmail.com with ESMTPSA id f24-v6sm1615933wmc.0.2018.06.20.01.37.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 20 Jun 2018 01:37:06 -0700 (PDT)
From:   Andrea Merello <andrea.merello@gmail.com>
To:     vkoul@kernel.org, dan.j.williams@intel.com,
        michal.simek@xilinx.com, appana.durga.rao@xilinx.com,
        dmaengine@vger.kernel.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Andrea Merello <andrea.merello@gmail.com>
Subject: [PATCH 1/6] dmaengine: xilinx_dma: fix splitting transfer causes misalignments
Date:   Wed, 20 Jun 2018 10:36:48 +0200
Message-Id: <20180620083653.17010-1-andrea.merello@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Whenever a single or cyclic transaction is prepared, the driver
could eventually split it over several SG descriptors in order
to deal with the HW maximum transfer length.

This could end up in DMA operations starting from a misaligned
address. This seems fatal for the HW.

This patch eventually adjusts the transfer size in order to make sure
all operations start from an aligned address.

Signed-off-by: Andrea Merello <andrea.merello@gmail.com>
---
 drivers/dma/xilinx/xilinx_dma.c | 27 ++++++++++++++++++++-------
 1 file changed, 20 insertions(+), 7 deletions(-)

diff --git a/drivers/dma/xilinx/xilinx_dma.c b/drivers/dma/xilinx/xilinx_dma.c
index 27b523530c4a..a516e7ffef21 100644
--- a/drivers/dma/xilinx/xilinx_dma.c
+++ b/drivers/dma/xilinx/xilinx_dma.c
@@ -376,6 +376,7 @@ struct xilinx_dma_chan {
 	void (*start_transfer)(struct xilinx_dma_chan *chan);
 	int (*stop_transfer)(struct xilinx_dma_chan *chan);
 	u16 tdest;
+	u32 copy_mask;
 };
 
 /**
@@ -1789,10 +1790,14 @@ static struct dma_async_tx_descriptor *xilinx_dma_prep_slave_sg(
 
 			/*
 			 * Calculate the maximum number of bytes to transfer,
-			 * making sure it is less than the hw limit
+			 * making sure it is less than the hw limit and that
+			 * the next chuck start address is aligned
 			 */
-			copy = min_t(size_t, sg_dma_len(sg) - sg_used,
-				     XILINX_DMA_MAX_TRANS_LEN);
+			copy = sg_dma_len(sg) - sg_used;
+			if (copy > XILINX_DMA_MAX_TRANS_LEN)
+				copy = XILINX_DMA_MAX_TRANS_LEN &
+					chan->copy_mask;
+
 			hw = &segment->hw;
 
 			/* Fill in the descriptor */
@@ -1894,10 +1899,14 @@ static struct dma_async_tx_descriptor *xilinx_dma_prep_dma_cyclic(
 
 			/*
 			 * Calculate the maximum number of bytes to transfer,
-			 * making sure it is less than the hw limit
+			 * making sure it is less than the hw limit and that
+			 * the next chuck start address is aligned
 			 */
-			copy = min_t(size_t, period_len - sg_used,
-				     XILINX_DMA_MAX_TRANS_LEN);
+			copy = period_len - sg_used;
+			if (copy > XILINX_DMA_MAX_TRANS_LEN)
+				copy = XILINX_DMA_MAX_TRANS_LEN &
+					chan->copy_mask;
+
 			hw = &segment->hw;
 			xilinx_axidma_buf(chan, hw, buf_addr, sg_used,
 					  period_len * i);
@@ -2402,8 +2411,12 @@ static int xilinx_dma_chan_probe(struct xilinx_dma_device *xdev,
 	if (width > 8)
 		has_dre = false;
 
-	if (!has_dre)
+	if (has_dre) {
+		chan->copy_mask = ~0;
+	} else {
 		xdev->common.copy_align = fls(width - 1);
+		chan->copy_mask = ~(width - 1);
+	}
 
 	if (of_device_is_compatible(node, "xlnx,axi-vdma-mm2s-channel") ||
 	    of_device_is_compatible(node, "xlnx,axi-dma-mm2s-channel") ||
-- 
2.17.1

