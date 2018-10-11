Return-Path: <SRS0=bA34=MX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 615A8C32788
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 09:50:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2431221476
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 09:50:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2431221476
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727956AbeJKRRS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Oct 2018 13:17:18 -0400
Received: from inva021.nxp.com ([92.121.34.21]:34268 "EHLO inva021.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726035AbeJKRRS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Oct 2018 13:17:18 -0400
Received: from inva021.nxp.com (localhost [127.0.0.1])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 2C0E520017C;
        Thu, 11 Oct 2018 11:50:45 +0200 (CEST)
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com [165.114.16.14])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 5DED320002C;
        Thu, 11 Oct 2018 11:50:39 +0200 (CEST)
Received: from titan.ap.freescale.net (TITAN.ap.freescale.net [10.192.208.233])
        by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id 6769B402EE;
        Thu, 11 Oct 2018 17:50:32 +0800 (SGT)
From:   Peng Ma <peng.ma@nxp.com>
To:     vkoul@kernel.org, leoyang.li@nxp.com
Cc:     robh+dt@kernel.org, mark.rutland@arm.com, shawnguo@kernel.org,
        dan.j.williams@intel.com, zw@zh-kernel.org,
        dmaengine@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linuxppc-dev@lists.ozlabs.org, Wen He <wen.he_1@nxp.com>
Subject: [PATCH 1/7] dmaengine: fsldma: Replace DMA_IN/OUT by FSL_DMA_IN/OUT
Date:   Thu, 11 Oct 2018 17:46:49 +0800
Message-Id: <20181011094655.45707-1-peng.ma@nxp.com>
X-Mailer: git-send-email 2.14.1
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Wen He <wen.he_1@nxp.com>

This patch implement a standard macro call functions is
used to NXP dma drivers.

Signed-off-by: Wen He <wen.he_1@nxp.com>
---
 drivers/dma/fsldma.c |   16 ++++++++--------
 drivers/dma/fsldma.h |    4 ++--
 2 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/drivers/dma/fsldma.c b/drivers/dma/fsldma.c
index 1117b51..39871e0 100644
--- a/drivers/dma/fsldma.c
+++ b/drivers/dma/fsldma.c
@@ -53,42 +53,42 @@
 
 static void set_sr(struct fsldma_chan *chan, u32 val)
 {
-	DMA_OUT(chan, &chan->regs->sr, val, 32);
+	FSL_DMA_OUT(chan, &chan->regs->sr, val, 32);
 }
 
 static u32 get_sr(struct fsldma_chan *chan)
 {
-	return DMA_IN(chan, &chan->regs->sr, 32);
+	return FSL_DMA_IN(chan, &chan->regs->sr, 32);
 }
 
 static void set_mr(struct fsldma_chan *chan, u32 val)
 {
-	DMA_OUT(chan, &chan->regs->mr, val, 32);
+	FSL_DMA_OUT(chan, &chan->regs->mr, val, 32);
 }
 
 static u32 get_mr(struct fsldma_chan *chan)
 {
-	return DMA_IN(chan, &chan->regs->mr, 32);
+	return FSL_DMA_IN(chan, &chan->regs->mr, 32);
 }
 
 static void set_cdar(struct fsldma_chan *chan, dma_addr_t addr)
 {
-	DMA_OUT(chan, &chan->regs->cdar, addr | FSL_DMA_SNEN, 64);
+	FSL_DMA_OUT(chan, &chan->regs->cdar, addr | FSL_DMA_SNEN, 64);
 }
 
 static dma_addr_t get_cdar(struct fsldma_chan *chan)
 {
-	return DMA_IN(chan, &chan->regs->cdar, 64) & ~FSL_DMA_SNEN;
+	return FSL_DMA_IN(chan, &chan->regs->cdar, 64) & ~FSL_DMA_SNEN;
 }
 
 static void set_bcr(struct fsldma_chan *chan, u32 val)
 {
-	DMA_OUT(chan, &chan->regs->bcr, val, 32);
+	FSL_DMA_OUT(chan, &chan->regs->bcr, val, 32);
 }
 
 static u32 get_bcr(struct fsldma_chan *chan)
 {
-	return DMA_IN(chan, &chan->regs->bcr, 32);
+	return FSL_DMA_IN(chan, &chan->regs->bcr, 32);
 }
 
 /*
diff --git a/drivers/dma/fsldma.h b/drivers/dma/fsldma.h
index 4787d48..982845b 100644
--- a/drivers/dma/fsldma.h
+++ b/drivers/dma/fsldma.h
@@ -223,10 +223,10 @@ static void out_le64(u64 __iomem *addr, u64 val)
 }
 #endif
 
-#define DMA_IN(fsl_chan, addr, width)					\
+#define FSL_DMA_IN(fsl_chan, addr, width)				\
 		(((fsl_chan)->feature & FSL_DMA_BIG_ENDIAN) ?		\
 			in_be##width(addr) : in_le##width(addr))
-#define DMA_OUT(fsl_chan, addr, val, width)				\
+#define FSL_DMA_OUT(fsl_chan, addr, val, width)			\
 		(((fsl_chan)->feature & FSL_DMA_BIG_ENDIAN) ?		\
 			out_be##width(addr, val) : out_le##width(addr, val))
 
-- 
1.7.1

