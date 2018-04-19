Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752511AbeDSCBm (ORCPT <rfc822;w@1wt.eu>);
        Wed, 18 Apr 2018 22:01:42 -0400
Received: from mail-pl0-f66.google.com ([209.85.160.66]:38316 "EHLO
        mail-pl0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751878AbeDSCBg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Apr 2018 22:01:36 -0400
X-Google-Smtp-Source: AIpwx48W3gI9+qDI5EJK2z1/LcmYS6hwaks4ILr1zsfRa+UHWJ8/LLRekPyURKdNiegcGKIxubWmdA==
From: Baolin Wang <baolin.wang@linaro.org>
To: dan.j.williams@intel.com, vinod.koul@intel.com
Cc: eric.long@spreadtrum.com, broonie@kernel.org,
        dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org,
        baolin.wang@linaro.org
Subject: [PATCH v2 2/5] dmaengine: sprd: Define the DMA data width type
Date: Thu, 19 Apr 2018 10:00:47 +0800
Message-Id: <a92f8111d23c898c5b696bb3b865e41a20d2f969.1524054807.git.baolin.wang@linaro.org>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <2ec1e8ddade0be5b4412b031b98d0d69a1af421f.1524054807.git.baolin.wang@linaro.org>
References: <2ec1e8ddade0be5b4412b031b98d0d69a1af421f.1524054807.git.baolin.wang@linaro.org>
In-Reply-To: <2ec1e8ddade0be5b4412b031b98d0d69a1af421f.1524054807.git.baolin.wang@linaro.org>
References: <2ec1e8ddade0be5b4412b031b98d0d69a1af421f.1524054807.git.baolin.wang@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Define the DMA data width type to make code more readable.

Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
---
Changes since v1:
- No updates.
---
 drivers/dma/sprd-dma.c |   14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

diff --git a/drivers/dma/sprd-dma.c b/drivers/dma/sprd-dma.c
index dcfa417..65ff0a58 100644
--- a/drivers/dma/sprd-dma.c
+++ b/drivers/dma/sprd-dma.c
@@ -176,6 +176,14 @@ enum sprd_dma_int_type {
 	SPRD_DMA_CFGERR_INT,
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
@@ -604,15 +612,15 @@ static int sprd_dma_config(struct dma_chan *chan, struct sprd_dma_desc *sdesc,
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
