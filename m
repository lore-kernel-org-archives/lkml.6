Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751698AbeEQJ70 (ORCPT <rfc822;w@1wt.eu>);
        Thu, 17 May 2018 05:59:26 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:37123 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751047AbeEQJ7X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 May 2018 05:59:23 -0400
X-Google-Smtp-Source: AB8JxZpd+rgSYJxKCFFmFrfxOlzsM8uPuBuP+G2IWTIEVZPDbV7qdwAnoj7nqCqXGko110c/aeUfYQ==
From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To: agross@codeaurora.org, vkoul@kernel.org, dmaengine@vger.kernel.org
Cc: linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH] dmaengine: qcom: bam_dma: fix some doc warnings.
Date: Thu, 17 May 2018 10:59:15 +0100
Message-Id: <20180517095916.11362-1-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.16.2
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Building kernel with W=1 throws up below warnings:
bam_dma.c:459: warning: Function parameter or member 'dir'
	not described in 'bam_chan_init_hw'
bam_dma.c:697: warning: Function parameter or member 'chan'
	not described in 'bam_dma_terminate_all'
bam_dma.c:697: warning: Excess function parameter 'bchan'
	description in 'bam_dma_terminate_all'
bam_dma.c:964: warning: Function parameter or member 'bchan'
	not described in 'bam_start_dma'

Fix these!.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 drivers/dma/qcom/bam_dma.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/dma/qcom/bam_dma.c b/drivers/dma/qcom/bam_dma.c
index 4a828c18099a..a05fff8a1447 100644
--- a/drivers/dma/qcom/bam_dma.c
+++ b/drivers/dma/qcom/bam_dma.c
@@ -451,7 +451,7 @@ static void bam_reset_channel(struct bam_chan *bchan)
 /**
  * bam_chan_init_hw - Initialize channel hardware
  * @bchan: bam channel
- *
+ * @dir: DMA transfer direction
  * This function resets and initializes the BAM channel
  */
 static void bam_chan_init_hw(struct bam_chan *bchan,
@@ -687,7 +687,7 @@ static struct dma_async_tx_descriptor *bam_prep_slave_sg(struct dma_chan *chan,
 
 /**
  * bam_dma_terminate_all - terminate all transactions on a channel
- * @bchan: bam dma channel
+ * @chan: bam dma channel
  *
  * Dequeues and frees all transactions
  * No callbacks are done
@@ -958,7 +958,7 @@ static void bam_apply_new_config(struct bam_chan *bchan,
 
 /**
  * bam_start_dma - start next transaction
- * @bchan - bam dma channel
+ * @bchan: bam dma channel
  */
 static void bam_start_dma(struct bam_chan *bchan)
 {
-- 
2.16.2
