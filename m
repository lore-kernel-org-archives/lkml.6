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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7EBC2C28CF8
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 15:32:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A4635206BB
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 15:32:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AsPYakNh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A4635206BB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730121AbeKUCCF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Nov 2018 21:02:05 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:41273 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725898AbeKUCBr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Nov 2018 21:01:47 -0500
Received: by mail-wr1-f68.google.com with SMTP id x10so2421587wrs.8;
        Tue, 20 Nov 2018 07:32:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=E4uDeGcHjS28m8Y3GVEAHI2k3FFYlV0squiBOxB4Zjo=;
        b=AsPYakNhleTtSFGYfr0/v67a68rWA3Vc+aszgL11cX7RURvBlC98QyB8M1ZBql69ik
         6DgOp7SOUXSIuk5DvA4XP1IlogC4PgiJ8kL7alI9ZDayEMSIYGDfXfa2ASQJg8B2QLEs
         tBUIft3AYZo/BsVa3qXT1BeETsqUgQEJ4HZk/7sMWfihPBlQ9ul3q10wnOJlO+INh3S8
         xc5zG/xV2WyOTkhXw+XMzo6HoA26hkLey40WbqQboha0ohsbYvSLuW4XYR0XmGfs5R9d
         RNK7Q0hGwb+vkC4IMUQi8x8sDc2AxmalHNk3N9lod/QaDIxBuzaVwod2ASQloeyGZq+0
         Mu0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=E4uDeGcHjS28m8Y3GVEAHI2k3FFYlV0squiBOxB4Zjo=;
        b=EaJOWQFcXDQjkWxwRqjC2UNBu1vmqNRjkaayg32xdU/7x18Wnxhfpc6P0xhMhiXlOq
         XX0s+XD1+i/JST2tCweaELrVkoFEVwEZ/pgNxB7ROLhX1sDkB0m4T5e/0GKTR3680uFc
         qbZZ2kPu7EMoDpDC1jq2ffSiBVpxUMo3xuXGhek4GV9qMEtP+hcH4flON2mZDzFUOX6x
         +PgtJUlUEY3Gio4xkzlb8XmAPUfrPBWY4vFImnnohqpoIA0mwgtO0qzhKwj3Ccr9Dfqd
         4MnErG9sPR5bN/P4myZsWIdCt8WfPFtX278og39KOEYYwzXO0cEXEEr8FfRhNSRO2qhf
         1j3g==
X-Gm-Message-State: AA+aEWYCRAgs/JENWsfCGIxC8AltfGo5rgzCdTH7IWjh0eGwlqXV7W+9
        ZysjT8upRC4GzCb8N7JC1FrUiGN8/ro=
X-Google-Smtp-Source: AFSGD/XsZx4gvLXbkKc1j/8nTLN3FH77y46lBJnwpByol4szNCvTAAlgvgFsSi1VnH5oiExqfFDQrQ==
X-Received: by 2002:a5d:66c1:: with SMTP id k1mr2354209wrw.132.1542727924627;
        Tue, 20 Nov 2018 07:32:04 -0800 (PST)
Received: from NewMoon.iit.local ([90.147.180.254])
        by smtp.gmail.com with ESMTPSA id k73sm14677464wmd.36.2018.11.20.07.32.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 20 Nov 2018 07:32:04 -0800 (PST)
From:   Andrea Merello <andrea.merello@gmail.com>
To:     vkoul@kernel.org, dan.j.williams@intel.com,
        michal.simek@xilinx.com, appana.durga.rao@xilinx.com,
        dmaengine@vger.kernel.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        robh+dt@kernel.org, mark.rutland@arm.com,
        devicetree@vger.kernel.org, radhey.shyam.pandey@xilinx.com,
        Andrea Merello <andrea.merello@gmail.com>
Subject: [PATCH v6 5/7] dmaengine: xilinx_dma: autodetect whether the HW supports scatter-gather
Date:   Tue, 20 Nov 2018 16:31:49 +0100
Message-Id: <20181120153151.18024-5-andrea.merello@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181120153151.18024-1-andrea.merello@gmail.com>
References: <20181120153151.18024-1-andrea.merello@gmail.com>
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
Changes in v6:
	None
---
 drivers/dma/xilinx/xilinx_dma.c | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/drivers/dma/xilinx/xilinx_dma.c b/drivers/dma/xilinx/xilinx_dma.c
index 0716db61f1d0..41bd8caca09e 100644
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
@@ -412,7 +413,6 @@ struct xilinx_dma_config {
  * @dev: Device Structure
  * @common: DMA device structure
  * @chan: Driver specific DMA channel
- * @has_sg: Specifies whether Scatter-Gather is present or not
  * @mcdma: Specifies whether Multi-Channel is present or not
  * @flush_on_fsync: Flush on frame sync
  * @ext_addr: Indicates 64 bit addressing is supported by dma device
@@ -432,7 +432,6 @@ struct xilinx_dma_device {
 	struct device *dev;
 	struct dma_device common;
 	struct xilinx_dma_chan *chan[XILINX_DMA_MAX_CHANS_PER_DEVICE];
-	bool has_sg;
 	bool mcdma;
 	u32 flush_on_fsync;
 	bool ext_addr;
@@ -2417,7 +2416,6 @@ static int xilinx_dma_chan_probe(struct xilinx_dma_device *xdev,
 
 	chan->dev = xdev->dev;
 	chan->xdev = xdev;
-	chan->has_sg = xdev->has_sg;
 	chan->desc_pendingcount = 0x0;
 	chan->ext_addr = xdev->ext_addr;
 	/* This variable ensures that descriptors are not
@@ -2517,6 +2515,15 @@ static int xilinx_dma_chan_probe(struct xilinx_dma_device *xdev,
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
@@ -2655,7 +2662,6 @@ static int xilinx_dma_probe(struct platform_device *pdev)
 		return PTR_ERR(xdev->regs);
 
 	/* Retrieve the DMA engine properties from the device tree */
-	xdev->has_sg = of_property_read_bool(node, "xlnx,include-sg");
 	xdev->max_buffer_len = GENMASK(XILINX_DMA_MAX_TRANS_LEN_MAX - 1, 0);
 
 	if (xdev->dma_config->dmatype == XDMA_TYPE_AXIDMA) {
-- 
2.17.1

