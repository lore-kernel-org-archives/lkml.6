Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933574AbeCMQmx (ORCPT <rfc822;w@1wt.eu>);
        Tue, 13 Mar 2018 12:42:53 -0400
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:21690 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S933466AbeCMQmt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Mar 2018 12:42:49 -0400
From: Pierre-Yves MORDRET <pierre-yves.mordret@st.com>
To: Vinod Koul <vinod.koul@intel.com>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        Dan Williams <dan.j.williams@intel.com>,
        "M'boumba Cedric Madianga" <cedric.madianga@gmail.com>,
        <dmaengine@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>
CC: Pierre-Yves MORDRET <pierre-yves.mordret@st.com>
Subject: [PATCH v1 8/8] dmaengine: stm32-dma: fix typo and reported checkpatch warnings
Date: Tue, 13 Mar 2018 17:42:07 +0100
Message-ID: <1520959327-25760-9-git-send-email-pierre-yves.mordret@st.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1520959327-25760-1-git-send-email-pierre-yves.mordret@st.com>
References: <1520959327-25760-1-git-send-email-pierre-yves.mordret@st.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.75.127.49]
X-ClientProxiedBy: SFHDAG7NODE2.st.com (10.75.127.20) To SFHDAG5NODE2.st.com
 (10.75.127.14)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-03-13_07:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix typo in a comment and solved reported checkpatch warnings.

Signed-off-by: Pierre-Yves MORDRET <pierre-yves.mordret@st.com>
---
  Version history:
    v1:
       * Initial
---
---
 drivers/dma/stm32-dma.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/drivers/dma/stm32-dma.c b/drivers/dma/stm32-dma.c
index 38c545d..8c58073 100644
--- a/drivers/dma/stm32-dma.c
+++ b/drivers/dma/stm32-dma.c
@@ -66,7 +66,8 @@
 #define STM32_DMA_SCR_PINC		BIT(9) /* Peripheral increment mode */
 #define STM32_DMA_SCR_CIRC		BIT(8) /* Circular mode */
 #define STM32_DMA_SCR_PFCTRL		BIT(5) /* Peripheral Flow Controller */
-#define STM32_DMA_SCR_TCIE		BIT(4) /* Transfer Cplete Int Enable*/
+#define STM32_DMA_SCR_TCIE		BIT(4) /* Transfer Complete Int Enable
+						*/
 #define STM32_DMA_SCR_TEIE		BIT(2) /* Transfer Error Int Enable */
 #define STM32_DMA_SCR_DMEIE		BIT(1) /* Direct Mode Err Int Enable */
 #define STM32_DMA_SCR_EN		BIT(0) /* Stream Enable */
@@ -1094,7 +1095,7 @@ static enum dma_status stm32_dma_tx_status(struct dma_chan *c,
 	u32 residue = 0;
 
 	status = dma_cookie_status(c, cookie, state);
-	if ((status == DMA_COMPLETE) || (!state))
+	if (status == DMA_COMPLETE || !state)
 		return status;
 
 	spin_lock_irqsave(&chan->vchan.lock, flags);
@@ -1158,7 +1159,7 @@ static void stm32_dma_desc_free(struct virt_dma_desc *vdesc)
 }
 
 static void stm32_dma_set_config(struct stm32_dma_chan *chan,
-			  struct stm32_dma_cfg *cfg)
+				 struct stm32_dma_cfg *cfg)
 {
 	stm32_dma_clear_reg(&chan->chan_reg);
 
@@ -1190,8 +1191,8 @@ static struct dma_chan *stm32_dma_of_xlate(struct of_phandle_args *dma_spec,
 	cfg.stream_config = dma_spec->args[2];
 	cfg.features = dma_spec->args[3];
 
-	if ((cfg.channel_id >= STM32_DMA_MAX_CHANNELS) ||
-	    (cfg.request_line >= STM32_DMA_MAX_REQUEST_ID)) {
+	if (cfg.channel_id >= STM32_DMA_MAX_CHANNELS ||
+	    cfg.request_line >= STM32_DMA_MAX_REQUEST_ID) {
 		dev_err(dev, "Bad channel and/or request id\n");
 		return NULL;
 	}
-- 
2.7.4
