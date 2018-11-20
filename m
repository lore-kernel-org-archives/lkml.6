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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9352CC28CF8
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 15:32:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EF9242087E
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 15:32:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Jp6+I9UL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EF9242087E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730006AbeKUCBs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Nov 2018 21:01:48 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:34931 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727135AbeKUCBr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Nov 2018 21:01:47 -0500
Received: by mail-wr1-f68.google.com with SMTP id 96so2446966wrb.2;
        Tue, 20 Nov 2018 07:32:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=U3HtB1h2/lHtTg364lrXafsr/nzN6yNozC0bkfvryl0=;
        b=Jp6+I9UL6fZUPtWifOERCwRWNAfY/Ap/iNphhSwsVZimOFSCCdkczHJLN77MyNy1wV
         BSiwmQpeZmgGs4iDuu2V3U5NUoFBEZbEt/RkVSFMPY5kxPFDNNyDqIAed7/aVPeh/Kbf
         xXJPsJe5GXwfueOUP+MaL97MsZmDgDGKS5P7ZhRMFHzrrS6xDcfZ0l/A9izHkEoDyArM
         PhZSaeZQzOqlJx+cugUNSN/IPGLUh8DlOJC9xDAI0MvKcEAWrwucQVcQC9mKxjoFM7Ms
         bXLFbdP0ePYc8tRnwj/NdKHwdbGDK3aHFMdoA65SqX0KiN2kC1O+ZGZjq9Z9BZU7D+kV
         //fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=U3HtB1h2/lHtTg364lrXafsr/nzN6yNozC0bkfvryl0=;
        b=c4LLmdctqEX3jifzB3lG1RPHh16loHBIm28p7TuGAK91COXuwHZJrrcH0no8aqXiVX
         Dn3w/XZi6hZOgy10JuwhvAHkY5ZQfVIV/f49JsyLikI/CzGf26wuR+/Z7ZiNrEqhhcvj
         vBK1xe4/7dcU9xnIP6gyIsXd+xP3Z5F0RrMb6fuaO2ioJNmNKeabFWpSjAWWjmPSCTPQ
         ktWmcoI7lmsuuNYU7kPbfiMrQqJyhppSIo024c2BQuxRRQQuzpCN+CXmMX3dy7MNELfF
         Z4t8AJhvNUzmwDaFaf2qeLhfyiiUN4lQAMIQIZxpE8GfExDqGTb3dvotEAW1cSVIyXQ+
         P6TQ==
X-Gm-Message-State: AA+aEWY5E/OsNz1at50hELTHc/iMFvYguxuU3KQKEW9vhyC4l/FIJZnd
        Q9mXKYC6dCp0YU8juEOG+JY=
X-Google-Smtp-Source: AFSGD/U5qoC92UUHdd/fRWqc0u8ijQVJRFvvOSjTWugbhWVf+Gr9OU2wnD7B7e6Iz3IcfeVuZN8yBQ==
X-Received: by 2002:adf:c189:: with SMTP id x9-v6mr2475813wre.233.1542727923400;
        Tue, 20 Nov 2018 07:32:03 -0800 (PST)
Received: from NewMoon.iit.local ([90.147.180.254])
        by smtp.gmail.com with ESMTPSA id k73sm14677464wmd.36.2018.11.20.07.32.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 20 Nov 2018 07:32:02 -0800 (PST)
From:   Andrea Merello <andrea.merello@gmail.com>
To:     vkoul@kernel.org, dan.j.williams@intel.com,
        michal.simek@xilinx.com, appana.durga.rao@xilinx.com,
        dmaengine@vger.kernel.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        robh+dt@kernel.org, mark.rutland@arm.com,
        devicetree@vger.kernel.org, radhey.shyam.pandey@xilinx.com,
        Andrea Merello <andrea.merello@gmail.com>
Subject: [PATCH v6 4/7] dmaengine: xilinx_dma: program hardware supported buffer length
Date:   Tue, 20 Nov 2018 16:31:48 +0100
Message-Id: <20181120153151.18024-4-andrea.merello@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181120153151.18024-1-andrea.merello@gmail.com>
References: <20181120153151.18024-1-andrea.merello@gmail.com>
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
Changes in v6:
	None
---
 drivers/dma/xilinx/xilinx_dma.c | 24 ++++++++++++++++++++----
 1 file changed, 20 insertions(+), 4 deletions(-)

diff --git a/drivers/dma/xilinx/xilinx_dma.c b/drivers/dma/xilinx/xilinx_dma.c
index cbf34dd5e966..0716db61f1d0 100644
--- a/drivers/dma/xilinx/xilinx_dma.c
+++ b/drivers/dma/xilinx/xilinx_dma.c
@@ -161,7 +161,9 @@
 #define XILINX_DMA_REG_BTT		0x28
 
 /* AXI DMA Specific Masks/Bit fields */
-#define XILINX_DMA_MAX_TRANS_LEN	GENMASK(22, 0)
+#define XILINX_DMA_MAX_TRANS_LEN_MIN	8
+#define XILINX_DMA_MAX_TRANS_LEN_MAX	23
+#define XILINX_DMA_V2_MAX_TRANS_LEN_MAX	26
 #define XILINX_DMA_CR_COALESCE_MAX	GENMASK(23, 16)
 #define XILINX_DMA_CR_CYCLIC_BD_EN_MASK	BIT(4)
 #define XILINX_DMA_CR_COALESCE_SHIFT	16
@@ -2622,7 +2624,7 @@ static int xilinx_dma_probe(struct platform_device *pdev)
 	struct xilinx_dma_device *xdev;
 	struct device_node *child, *np = pdev->dev.of_node;
 	struct resource *io;
-	u32 num_frames, addr_width;
+	u32 num_frames, addr_width, len_width;
 	int i, err;
 
 	/* Allocate and initialize the DMA engine structure */
@@ -2654,10 +2656,24 @@ static int xilinx_dma_probe(struct platform_device *pdev)
 
 	/* Retrieve the DMA engine properties from the device tree */
 	xdev->has_sg = of_property_read_bool(node, "xlnx,include-sg");
-	xdev->max_buffer_len = XILINX_DMA_MAX_TRANS_LEN;
+	xdev->max_buffer_len = GENMASK(XILINX_DMA_MAX_TRANS_LEN_MAX - 1, 0);
 
-	if (xdev->dma_config->dmatype == XDMA_TYPE_AXIDMA)
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

