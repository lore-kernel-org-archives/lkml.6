Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752392AbeDJHqj (ORCPT <rfc822;w@1wt.eu>);
        Tue, 10 Apr 2018 03:46:39 -0400
Received: from mail-pl0-f67.google.com ([209.85.160.67]:41202 "EHLO
        mail-pl0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751978AbeDJHqi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Apr 2018 03:46:38 -0400
X-Google-Smtp-Source: AIpwx48emWzKmAVu8+DlsXaXedrAkYICWGzVVENPSEXblhX4+5ZP5NHngRNfITfp0l/I1wl0DA+Hzg==
From: Baolin Wang <baolin.wang@linaro.org>
To: dan.j.williams@intel.com, vinod.koul@intel.com
Cc: eric.long@spreadtrum.com, broonie@kernel.org,
        dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org,
        baolin.wang@linaro.org
Subject: [PATCH 1/5] dmaengine: sprd: Define the DMA transfer step type
Date: Tue, 10 Apr 2018 15:46:03 +0800
Message-Id: <abdda9da96185f764d58bbf61db9010d0f72d1b3.1523346135.git.baolin.wang@linaro.org>
X-Mailer: git-send-email 1.7.9.5
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Eric Long <eric.long@spreadtrum.com>

Define the DMA transfer step type to make code more readable.

Signed-off-by: Eric Long <eric.long@spreadtrum.com>
Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
---
 drivers/dma/sprd-dma.c |   28 ++++++++++++++++++++++------
 1 file changed, 22 insertions(+), 6 deletions(-)

diff --git a/drivers/dma/sprd-dma.c b/drivers/dma/sprd-dma.c
index b106e8a..af9c156 100644
--- a/drivers/dma/sprd-dma.c
+++ b/drivers/dma/sprd-dma.c
@@ -169,6 +169,22 @@ enum sprd_dma_int_type {
 	SPRD_DMA_CFGERR_INT,
 };
 
+/*
+ * enum sprd_dma_step: define the DMA transfer step type
+ * @SPRD_DMA_NONE_STEP: transfer do not need step
+ * @SPRD_DMA_BYTE_STEP: transfer step is one byte
+ * @SPRD_DMA_SHORT_STEP: transfer step is two bytes
+ * @SPRD_DMA_WORD_STEP: transfer step is one word
+ * @SPRD_DMA_DWORD_STEP: transfer step is double word
+ */
+enum sprd_dma_step {
+	SPRD_DMA_NONE_STEP,
+	SPRD_DMA_BYTE_STEP = BIT(0),
+	SPRD_DMA_SHORT_STEP = BIT(1),
+	SPRD_DMA_WORD_STEP = BIT(2),
+	SPRD_DMA_DWORD_STEP = BIT(3),
+};
+
 /* dma channel hardware configuration */
 struct sprd_dma_chn_hw {
 	u32 pause;
@@ -598,16 +614,16 @@ static int sprd_dma_config(struct dma_chan *chan, struct sprd_dma_desc *sdesc,
 
 	if (IS_ALIGNED(len, 4)) {
 		datawidth = 2;
-		src_step = 4;
-		des_step = 4;
+		src_step = SPRD_DMA_WORD_STEP;
+		des_step = SPRD_DMA_WORD_STEP;
 	} else if (IS_ALIGNED(len, 2)) {
 		datawidth = 1;
-		src_step = 2;
-		des_step = 2;
+		src_step = SPRD_DMA_SHORT_STEP;
+		des_step = SPRD_DMA_SHORT_STEP;
 	} else {
 		datawidth = 0;
-		src_step = 1;
-		des_step = 1;
+		src_step = SPRD_DMA_BYTE_STEP;
+		des_step = SPRD_DMA_BYTE_STEP;
 	}
 
 	fragment_len = SPRD_DMA_MEMCPY_MIN_SIZE;
-- 
1.7.9.5
