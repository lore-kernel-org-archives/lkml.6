Return-Path: <SRS0=bmN+=JH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B6CBC43141
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 11:58:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AA14520883
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 11:58:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YYmqEaKl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AA14520883
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933297AbeFUL6c (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Jun 2018 07:58:32 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:32768 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933130AbeFUL6a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jun 2018 07:58:30 -0400
Received: by mail-wm0-f65.google.com with SMTP id z6-v6so2931949wma.0;
        Thu, 21 Jun 2018 04:58:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=lI/z+yKhhFOkL1kzRd55CKW4Yhq8MBfhB4UVprsjI94=;
        b=YYmqEaKly5AfIHq25H010eo2FvAp4Pgxs4L1LsmAN/+w5MxNprV25rcoYuLUiflS5D
         wDrBLGqPNXBE5EJ15DtJRYJJoM8/EKD7ZInckd5KkmDo18YWLWUG7iwbKJo+P3BWK3ov
         rw8Sr2M3jXGhf5yrsRJEgQkESQms8hBjnKw7h2PnXrxSllr0incul+I6ALZxcY5whryh
         75c5ihidy7FD20umPOkpW42+AG2sZVV6KpUNaTwq1/9kxEoP/F4UD71cJ06Pj0R4JyNh
         brvIvy1Uh3eRce6fDjcfErndwLmoesiEWoEQdG+pmwq2EiF6WrcGj50NZJ1etLQlYWNq
         ciUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=lI/z+yKhhFOkL1kzRd55CKW4Yhq8MBfhB4UVprsjI94=;
        b=OZlpUTzLOzHi/s8n7eF5kgikqH7vXDROMZY5MaZn+sqHpHhhUwqNxQmEzz/vDwacre
         czvMxhhZO5M40mPepBKUtIy9lo/4i4xMV8I0cDeVP0VE0nyXlTAR6tYoj6S5Mcry1x9c
         dB+JKU8qnAONfIf7Lc3fWz1yhhnD0L2HrHKRQeJ5bu7fgjQuScxXjozxOce+iFhjwDB2
         /0xaS35YvROwp/ItYFEpJA6Z39xnnM8B0SY/WCYSOjvtn9Gxr3ehnpbM1Z5dg4SbVGGM
         uFubKcHa43wxjEaBtZwCxVVdWb+AejD82fMyp5Z7YCyzO9D4rvK6e/l8152JtRSUPQXE
         gdGg==
X-Gm-Message-State: APt69E0KiFpIIwFwPe3PATpL86me1OnxuvCTxU7rOm7RhvSRrvRXUvJt
        dU3kCy4oD/9lN5NsnsoxkiQ=
X-Google-Smtp-Source: ADUXVKJErvMGErQUP9yfH+BT3D6axs3H8uzfOmaoU4K80n+ZWHoot/NSvu6Z4O4NxPITPMhc0+kcCw==
X-Received: by 2002:a1c:9788:: with SMTP id z130-v6mr5136377wmd.88.1529582309584;
        Thu, 21 Jun 2018 04:58:29 -0700 (PDT)
Received: from NewMoon.iit.local ([90.147.180.254])
        by smtp.gmail.com with ESMTPSA id e188-v6sm13779773wmf.21.2018.06.21.04.58.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 21 Jun 2018 04:58:28 -0700 (PDT)
From:   Andrea Merello <andrea.merello@gmail.com>
To:     vkoul@kernel.org, dan.j.williams@intel.com,
        michal.simek@xilinx.com, appana.durga.rao@xilinx.com,
        dmaengine@vger.kernel.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Andrea Merello <andrea.merello@gmail.com>
Subject: [PATCH v2 1/5] dmaengine: xilinx_dma: in axidma slave_sg and dma_cyclic mode align split descriptors
Date:   Thu, 21 Jun 2018 13:58:18 +0200
Message-Id: <20180621115822.20058-1-andrea.merello@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Whenever a single or cyclic transaction is prepared, the driver
could eventually split it over several SG descriptors in order
to deal with the HW maximum transfer length.

This could end up in DMA operations starting from a misaligned
address. This seems fatal for the HW if DRE is not enabled.

This patch eventually adjusts the transfer size in order to make sure
all operations start from an aligned address.

Signed-off-by: Andrea Merello <andrea.merello@gmail.com>
---
Changes in v2:
	- don't introduce copy_mask field, rather rely on already-esistent
	  copy_align field. Suggested by Radhey Shyam Pandey
	- reword title
---
 drivers/dma/xilinx/xilinx_dma.c | 22 ++++++++++++++++------
 1 file changed, 16 insertions(+), 6 deletions(-)

diff --git a/drivers/dma/xilinx/xilinx_dma.c b/drivers/dma/xilinx/xilinx_dma.c
index 27b523530c4a..22d7a6b85e65 100644
--- a/drivers/dma/xilinx/xilinx_dma.c
+++ b/drivers/dma/xilinx/xilinx_dma.c
@@ -1789,10 +1789,15 @@ static struct dma_async_tx_descriptor *xilinx_dma_prep_slave_sg(
 
 			/*
 			 * Calculate the maximum number of bytes to transfer,
-			 * making sure it is less than the hw limit
+			 * making sure it is less than the hw limit and that
+			 * the next chunck start address is aligned
 			 */
-			copy = min_t(size_t, sg_dma_len(sg) - sg_used,
-				     XILINX_DMA_MAX_TRANS_LEN);
+			copy = sg_dma_len(sg) - sg_used;
+			if (copy > XILINX_DMA_MAX_TRANS_LEN &&
+			    chan->xdev->common.copy_align)
+				copy = rounddown(XILINX_DMA_MAX_TRANS_LEN,
+					 (1 << chan->xdev->common.copy_align));
+
 			hw = &segment->hw;
 
 			/* Fill in the descriptor */
@@ -1894,10 +1899,15 @@ static struct dma_async_tx_descriptor *xilinx_dma_prep_dma_cyclic(
 
 			/*
 			 * Calculate the maximum number of bytes to transfer,
-			 * making sure it is less than the hw limit
+			 * making sure it is less than the hw limit and that
+			 * the next chunck start address is aligned
 			 */
-			copy = min_t(size_t, period_len - sg_used,
-				     XILINX_DMA_MAX_TRANS_LEN);
+			copy = period_len - sg_used;
+			if (copy > XILINX_DMA_MAX_TRANS_LEN &&
+			    chan->xdev->common.copy_align)
+				copy = rounddown(XILINX_DMA_MAX_TRANS_LEN,
+					 (1 << chan->xdev->common.copy_align));
+
 			hw = &segment->hw;
 			xilinx_axidma_buf(chan, hw, buf_addr, sg_used,
 					  period_len * i);
-- 
2.17.1

