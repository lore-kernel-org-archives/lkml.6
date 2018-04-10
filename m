Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752435AbeDJHqo (ORCPT <rfc822;w@1wt.eu>);
        Tue, 10 Apr 2018 03:46:44 -0400
Received: from mail-pl0-f65.google.com ([209.85.160.65]:46287 "EHLO
        mail-pl0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751978AbeDJHql (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Apr 2018 03:46:41 -0400
X-Google-Smtp-Source: AIpwx49mMM226TrQFqUpzY8jo7TZEdseerIMasRw9vFl9yHBPcZcHlfgyPZXveAJWXOcaalWPz2y5Q==
From: Baolin Wang <baolin.wang@linaro.org>
To: dan.j.williams@intel.com, vinod.koul@intel.com
Cc: eric.long@spreadtrum.com, broonie@kernel.org,
        dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org,
        baolin.wang@linaro.org
Subject: [PATCH 2/5] dmaengine: sprd: Define the DMA data width type
Date: Tue, 10 Apr 2018 15:46:04 +0800
Message-Id: <695931ac827adb5b2c5a7939341ff61ba00af1a1.1523346135.git.baolin.wang@linaro.org>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <abdda9da96185f764d58bbf61db9010d0f72d1b3.1523346135.git.baolin.wang@linaro.org>
References: <abdda9da96185f764d58bbf61db9010d0f72d1b3.1523346135.git.baolin.wang@linaro.org>
In-Reply-To: <abdda9da96185f764d58bbf61db9010d0f72d1b3.1523346135.git.baolin.wang@linaro.org>
References: <abdda9da96185f764d58bbf61db9010d0f72d1b3.1523346135.git.baolin.wang@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Define the DMA data width type to make code more readable.

Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
---
 drivers/dma/sprd-dma.c |   14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

diff --git a/drivers/dma/sprd-dma.c b/drivers/dma/sprd-dma.c
index af9c156..9f44d6f 100644
--- a/drivers/dma/sprd-dma.c
+++ b/drivers/dma/sprd-dma.c
@@ -185,6 +185,14 @@ enum sprd_dma_step {
 	SPRD_DMA_DWORD_STEP = BIT(3),
 };
 
+/* dma data width values */
+enum sprd_dma_datawidth {
+	SPRD_DMA_DATAWIDTH_1_BYTE,
+	SPRD_DMA_DATAWIDTH_2_BYTES,
+	SPRD_DMA_DATAWIDTH_4_BYTES,
+	SPRD_DMA_DATAWIDTH_8_BYTES,
+};
+
 /* dma channel hardware configuration */
 struct sprd_dma_chn_hw {
 	u32 pause;
@@ -613,15 +621,15 @@ static int sprd_dma_config(struct dma_chan *chan, struct sprd_dma_desc *sdesc,
 	u32 fix_mode = 0, fix_en = 0;
 
 	if (IS_ALIGNED(len, 4)) {
-		datawidth = 2;
+		datawidth = SPRD_DMA_DATAWIDTH_4_BYTES;
 		src_step = SPRD_DMA_WORD_STEP;
 		des_step = SPRD_DMA_WORD_STEP;
 	} else if (IS_ALIGNED(len, 2)) {
-		datawidth = 1;
+		datawidth = SPRD_DMA_DATAWIDTH_2_BYTES;
 		src_step = SPRD_DMA_SHORT_STEP;
 		des_step = SPRD_DMA_SHORT_STEP;
 	} else {
-		datawidth = 0;
+		datawidth = SPRD_DMA_DATAWIDTH_1_BYTE;
 		src_step = SPRD_DMA_BYTE_STEP;
 		des_step = SPRD_DMA_BYTE_STEP;
 	}
-- 
1.7.9.5
