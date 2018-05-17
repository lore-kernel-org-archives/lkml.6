Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752181AbeEQKHo (ORCPT <rfc822;w@1wt.eu>);
        Thu, 17 May 2018 06:07:44 -0400
Received: from kvm5.telegraphics.com.au ([98.124.60.144]:59180 "EHLO
        kvm5.telegraphics.com.au" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751395AbeEQKHn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 May 2018 06:07:43 -0400
Date: Thu, 17 May 2018 20:07:36 +1000
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: linux-m68k@vger.kernel.org, linux-kernel@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>, Greg Ungerer <gerg@linux-m68k.org>
Message-Id: <4b31f5239449af31f1d5f9ba312813fd38a5ee0a.1526551115.git.fthain@telegraphics.com.au>
From: Finn Thain <fthain@telegraphics.com.au>
Subject: [PATCH 2/2] Revert "m68k: set dma and coherent masks for platform FEC
 ethernets"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This reverts commit f61e64310b75733d782e930d1fb404b84699eed6.

Initializing the coherent dma mask for a m68k platform device
with DMA_BIT_MASK(32) is no longer necessary because
arch_setup_pdev_archdata() now does so by default.

Cc: Christoph Hellwig <hch@lst.de>
Cc: Greg Ungerer <gerg@linux-m68k.org>
Signed-off-by: Finn Thain <fthain@telegraphics.com.au>
---
 arch/m68k/coldfire/device.c | 12 ++----------
 1 file changed, 2 insertions(+), 10 deletions(-)

diff --git a/arch/m68k/coldfire/device.c b/arch/m68k/coldfire/device.c
index 908d58347790..84938fdbbada 100644
--- a/arch/m68k/coldfire/device.c
+++ b/arch/m68k/coldfire/device.c
@@ -135,11 +135,7 @@ static struct platform_device mcf_fec0 = {
 	.id			= 0,
 	.num_resources		= ARRAY_SIZE(mcf_fec0_resources),
 	.resource		= mcf_fec0_resources,
-	.dev = {
-		.dma_mask		= &mcf_fec0.dev.coherent_dma_mask,
-		.coherent_dma_mask	= DMA_BIT_MASK(32),
-		.platform_data		= FEC_PDATA,
-	}
+	.dev.platform_data	= FEC_PDATA,
 };
 
 #ifdef MCFFEC_BASE1
@@ -171,11 +167,7 @@ static struct platform_device mcf_fec1 = {
 	.id			= 1,
 	.num_resources		= ARRAY_SIZE(mcf_fec1_resources),
 	.resource		= mcf_fec1_resources,
-	.dev = {
-		.dma_mask		= &mcf_fec1.dev.coherent_dma_mask,
-		.coherent_dma_mask	= DMA_BIT_MASK(32),
-		.platform_data		= FEC_PDATA,
-	}
+	.dev.platform_data	= FEC_PDATA,
 };
 #endif /* MCFFEC_BASE1 */
 #endif /* CONFIG_FEC */
-- 
2.16.1
