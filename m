Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751109AbeBQJlE (ORCPT <rfc822;w@1wt.eu>);
        Sat, 17 Feb 2018 04:41:04 -0500
Received: from mail-pl0-f66.google.com ([209.85.160.66]:45340 "EHLO
        mail-pl0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751055AbeBQJlD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Feb 2018 04:41:03 -0500
X-Google-Smtp-Source: AH8x226Tisb2xptxPpe31gflSXVZ01UIiXqKMIB/SYsubWGhk6b5iTBpIWzT3LXpPDD2O3DDC2y7/w==
Date: Sat, 17 Feb 2018 15:12:22 +0530
From: Souptick Joarder <jrdr.linux@gmail.com>
To: jassisinghbrar@gmail.com
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] maillbox: bcm-flexrm-mailbox: Use dma_pool_zalloc()
Message-ID: <20180217094222.GA13241@jordon-HP-15-Notebook-PC>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use dma_pool_zalloc() instead of dma_pool_alloc + memset

Signed-off-by: Souptick Joarder <jrdr.linux@gmail.com>
---
 drivers/mailbox/bcm-flexrm-mailbox.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/mailbox/bcm-flexrm-mailbox.c b/drivers/mailbox/bcm-flexrm-mailbox.c
index a8cf433..8ab077f 100644
--- a/drivers/mailbox/bcm-flexrm-mailbox.c
+++ b/drivers/mailbox/bcm-flexrm-mailbox.c
@@ -1268,7 +1268,7 @@ static int flexrm_startup(struct mbox_chan *chan)
 	}

 	/* Allocate completion memory */
-	ring->cmpl_base = dma_pool_alloc(ring->mbox->cmpl_pool,
+	ring->cmpl_base = dma_pool_zalloc(ring->mbox->cmpl_pool,
 					 GFP_KERNEL, &ring->cmpl_dma_base);
 	if (!ring->cmpl_base) {
 		dev_err(ring->mbox->dev,
@@ -1277,7 +1277,6 @@ static int flexrm_startup(struct mbox_chan *chan)
 		ret = -ENOMEM;
 		goto fail_free_bd_memory;
 	}
-	memset(ring->cmpl_base, 0, RING_CMPL_SIZE);

 	/* Request IRQ */
 	if (ring->irq == UINT_MAX) {
--
1.9.1
