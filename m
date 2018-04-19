Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752407AbeDSCBf (ORCPT <rfc822;w@1wt.eu>);
        Wed, 18 Apr 2018 22:01:35 -0400
Received: from mail-pg0-f67.google.com ([74.125.83.67]:43427 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751878AbeDSCBe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Apr 2018 22:01:34 -0400
X-Google-Smtp-Source: AIpwx4/c8sXwsh7uLDFAS32mYnYCz10+OeDFIK44UW7l/Gx9iXJozuLyDKxbgeHNkksiQEwNS1NuZQ==
From: Baolin Wang <baolin.wang@linaro.org>
To: dan.j.williams@intel.com, vinod.koul@intel.com
Cc: eric.long@spreadtrum.com, broonie@kernel.org,
        dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org,
        baolin.wang@linaro.org
Subject: [PATCH v2 1/5] dmaengine: sprd: Define the DMA transfer step type
Date: Thu, 19 Apr 2018 10:00:46 +0800
Message-Id: <2ec1e8ddade0be5b4412b031b98d0d69a1af421f.1524054807.git.baolin.wang@linaro.org>
X-Mailer: git-send-email 1.7.9.5
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Eric Long <eric.long@spreadtrum.com>

Define the DMA transfer step type to make code more readable.

Signed-off-by: Eric Long <eric.long@spreadtrum.com>
Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
---
Changes since v1:
 - Convert enum structure to macros definition for DMA step type.
---
 drivers/dma/sprd-dma.c |   19 +++++++++++++------
 1 file changed, 13 insertions(+), 6 deletions(-)

diff --git a/drivers/dma/sprd-dma.c b/drivers/dma/sprd-dma.c
index b106e8a..dcfa417 100644
--- a/drivers/dma/sprd-dma.c
+++ b/drivers/dma/sprd-dma.c
@@ -116,6 +116,13 @@
 #define SPRD_DMA_SRC_TRSF_STEP_OFFSET	0
 #define SPRD_DMA_TRSF_STEP_MASK		GENMASK(15, 0)
 
+/* define the DMA transfer step type */
+#define SPRD_DMA_NONE_STEP		0
+#define SPRD_DMA_BYTE_STEP		1
+#define SPRD_DMA_SHORT_STEP		2
+#define SPRD_DMA_WORD_STEP		4
+#define SPRD_DMA_DWORD_STEP		8
+
 #define SPRD_DMA_SOFTWARE_UID		0
 
 /*
@@ -598,16 +605,16 @@ static int sprd_dma_config(struct dma_chan *chan, struct sprd_dma_desc *sdesc,
 
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
