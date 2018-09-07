Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 744AAC433F5
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 06:25:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2CC3420861
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 06:25:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MKv0YsWf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2CC3420861
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727644AbeIGLEu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 07:04:50 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:39788 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725970AbeIGLEt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 07:04:49 -0400
Received: by mail-wm0-f66.google.com with SMTP id q8-v6so13445246wmq.4;
        Thu, 06 Sep 2018 23:25:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=SLdnCYIzmHwIXEy+JAJi0InUj83qMBeYcAZFj8j99Uo=;
        b=MKv0YsWfRZCx5I+TJdKJLq/KA5QkcrDCt7shmx/O6X/fsvk0oXqOqw8+N+93wCxFyD
         Mpcc5WdllJ5uO2EI7CiTMOMO+dbZVk87axYMzNgmYRp7h2cRx3Du62bTP0Qoc3990g7w
         s9IwVs1NV2DBZlXJw7QXuiPfUY/nyS4kZXK+kYfcebwj/1wG85suJv0l760jb2GPp5cC
         f3hWW3nrSfucDPlXP9C1LxExEg7OKHN+n54SHtcd+T4acigSQP47QCB/CzhK9ZY/D8O4
         lhOt1bSaRKP/zUPxfgQbYYz/esqmomLBMzBzs3dG4x2eP8bHXpDxvhL8jcDg+vzalqQo
         b7GA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=SLdnCYIzmHwIXEy+JAJi0InUj83qMBeYcAZFj8j99Uo=;
        b=ZHr1zhb7PsXbS9wLmjNqbULQ4Ai8QutwXRz1S5uMbhldLbR9USKdJ/NY+yGS/YwaCh
         TBYuvjIokUEGNSXEjVALr3JQusg1TTM0r5fJaG+ovZTGCzU+nU1LIjXQBdXQEyRyYuSN
         bPBLraasaTb6NYwRzgsogkDyYdYfL7cTtSRyMWcya0s3XYsXJhET8X4xuxBI/e89xZiS
         u2b+RHO03a2PDvxIRlr/wZ/sZPgraVjHeW2d4SLZSgKC3CAVwbhgwzvg5mUj2NATltEg
         sph1blvehCoC1hxRlZFXvTNA6oQxbDgeL6NX1nngH9lO1XTIsCgoFQ/LzKctk9cvHWNE
         rlpg==
X-Gm-Message-State: APzg51B0l+tocZXo2PbEAa6aVyIQwe1pqAzTOjiHlTV8CqEQZSLf7AbM
        jiMJbNScLg/uB2GLWiYivO4cAznGqkg=
X-Google-Smtp-Source: ANB0VdbYN2ErQ2qS5rqYX+bUwz6xLS1DNL/hjXrhOXu1MQKkh322XY57jsALBlR+kblUw6cmwkT1Bw==
X-Received: by 2002:a7b:c143:: with SMTP id z3-v6mr3972211wmi.105.1536301524188;
        Thu, 06 Sep 2018 23:25:24 -0700 (PDT)
Received: from NewMoon.iit.local ([90.147.180.254])
        by smtp.gmail.com with ESMTPSA id w10-v6sm8387233wrp.31.2018.09.06.23.25.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 06 Sep 2018 23:25:23 -0700 (PDT)
From:   Andrea Merello <andrea.merello@gmail.com>
To:     vkoul@kernel.org, dan.j.williams@intel.com,
        michal.simek@xilinx.com, appana.durga.rao@xilinx.com,
        dmaengine@vger.kernel.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        robh+dt@kernel.org, mark.rutland@arm.com,
        devicetree@vger.kernel.org, radhey.shyam.pandey@xilinx.com,
        Andrea Merello <andrea.merello@gmail.com>
Subject: [PATCH v5 5/7] dmaengine: xilinx_dma: autodetect whether the HW supports scatter-gather
Date:   Fri,  7 Sep 2018 08:25:00 +0200
Message-Id: <20180907062502.8241-5-andrea.merello@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180907062502.8241-1-andrea.merello@gmail.com>
References: <20180907062502.8241-1-andrea.merello@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The AXIDMA and CDMA HW can be either direct-access or scatter-gather
version. These are SW incompatible.

The driver can handle both versions: a DT property was used to
tell the driver whether to assume the HW is in scatter-gather mode.

This patch makes the driver to autodetect this information. The DT
property is not required anymore.

No changes for VDMA.

Cc: Rob Herring <robh+dt@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: devicetree@vger.kernel.org
Cc: Radhey Shyam Pandey <radhey.shyam.pandey@xilinx.com>
Signed-off-by: Andrea Merello <andrea.merello@gmail.com>
Reviewed-by: Radhey Shyam Pandey <radhey.shyam.pandey@xilinx.com>
---
Changes in v2:
	- autodetect only in !VDMA case
Changes in v3:
	- cc DT maintainers/ML
Changes in v4:
	- fix typos in commit message
Changes in v5:
	None
---
 drivers/dma/xilinx/xilinx_dma.c | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/drivers/dma/xilinx/xilinx_dma.c b/drivers/dma/xilinx/xilinx_dma.c
index b17f24e4ec35..78d0f2f8225e 100644
--- a/drivers/dma/xilinx/xilinx_dma.c
+++ b/drivers/dma/xilinx/xilinx_dma.c
@@ -86,6 +86,7 @@
 #define XILINX_DMA_DMASR_DMA_DEC_ERR		BIT(6)
 #define XILINX_DMA_DMASR_DMA_SLAVE_ERR		BIT(5)
 #define XILINX_DMA_DMASR_DMA_INT_ERR		BIT(4)
+#define XILINX_DMA_DMASR_SG_MASK		BIT(3)
 #define XILINX_DMA_DMASR_IDLE			BIT(1)
 #define XILINX_DMA_DMASR_HALTED		BIT(0)
 #define XILINX_DMA_DMASR_DELAY_MASK		GENMASK(31, 24)
@@ -407,7 +408,6 @@ struct xilinx_dma_config {
  * @dev: Device Structure
  * @common: DMA device structure
  * @chan: Driver specific DMA channel
- * @has_sg: Specifies whether Scatter-Gather is present or not
  * @mcdma: Specifies whether Multi-Channel is present or not
  * @flush_on_fsync: Flush on frame sync
  * @ext_addr: Indicates 64 bit addressing is supported by dma device
@@ -427,7 +427,6 @@ struct xilinx_dma_device {
 	struct device *dev;
 	struct dma_device common;
 	struct xilinx_dma_chan *chan[XILINX_DMA_MAX_CHANS_PER_DEVICE];
-	bool has_sg;
 	bool mcdma;
 	u32 flush_on_fsync;
 	bool ext_addr;
@@ -2400,7 +2399,6 @@ static int xilinx_dma_chan_probe(struct xilinx_dma_device *xdev,
 
 	chan->dev = xdev->dev;
 	chan->xdev = xdev;
-	chan->has_sg = xdev->has_sg;
 	chan->desc_pendingcount = 0x0;
 	chan->ext_addr = xdev->ext_addr;
 	/* This variable ensures that descriptors are not
@@ -2493,6 +2491,15 @@ static int xilinx_dma_chan_probe(struct xilinx_dma_device *xdev,
 		chan->stop_transfer = xilinx_dma_stop_transfer;
 	}
 
+	/* check if SG is enabled (only for AXIDMA and CDMA) */
+	if (xdev->dma_config->dmatype != XDMA_TYPE_VDMA) {
+		if (dma_ctrl_read(chan, XILINX_DMA_REG_DMASR) &
+		    XILINX_DMA_DMASR_SG_MASK)
+			chan->has_sg = true;
+		dev_dbg(chan->dev, "ch %d: SG %s\n", chan->id,
+			chan->has_sg ? "enabled" : "disabled");
+	}
+
 	/* Initialize the tasklet */
 	tasklet_init(&chan->tasklet, xilinx_dma_do_tasklet,
 			(unsigned long)chan);
@@ -2631,7 +2638,6 @@ static int xilinx_dma_probe(struct platform_device *pdev)
 		return PTR_ERR(xdev->regs);
 
 	/* Retrieve the DMA engine properties from the device tree */
-	xdev->has_sg = of_property_read_bool(node, "xlnx,include-sg");
 	xdev->max_buffer_len = GENMASK(XILINX_DMA_MAX_TRANS_LEN_MAX - 1, 0);
 
 	if (xdev->dma_config->dmatype == XDMA_TYPE_AXIDMA) {
-- 
2.17.1

