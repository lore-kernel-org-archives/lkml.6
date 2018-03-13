Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933249AbeCMQsB (ORCPT <rfc822;w@1wt.eu>);
        Tue, 13 Mar 2018 12:48:01 -0400
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:59844 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1752776AbeCMQmj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Mar 2018 12:42:39 -0400
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
Subject: [PATCH v1 0/8] Append several fixes and improvements in STM32 DMA
Date: Tue, 13 Mar 2018 17:41:59 +0100
Message-ID: <1520959327-25760-1-git-send-email-pierre-yves.mordret@st.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.75.127.50]
X-ClientProxiedBy: SFHDAG3NODE2.st.com (10.75.127.8) To SFHDAG5NODE2.st.com
 (10.75.127.14)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-03-13_07:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset appends several fixes and some improvements for STM32 DMAv2.
This includes:
        * Introduce DMA features bitfield
        * Threshold manages with bitfield feature
        * Improve memory burst management
        * Improve DMA IRQ status handling
        * Fix max items per transfer to match FIFO Size
        * Properly mask irq bits to avoid overlaping
        * Fix incomplete configuration in cyclic mode
        * Fix typo and reported checkpatch warnings

---
  Version history:
    v1:
        * Initial
---

Pierre-Yves MORDRET (8):
  dt-bindings: stm32-dma: introduce DMA features bitfield
  dmaengine: stm32-dma: threshold manages with bitfield feature
  dmaengine: stm32-dma: Improve memory burst management
  dmaengine: stm32-dma: fix DMA IRQ status handling
  dmaengine: stm32-dma: fix max items per transfer
  dmaengine: stm32-dma: properly mask irq bits
  dmaengine: stm32-dma: fix incomplete configuration in cyclic mode
  dmaengine: stm32-dma: fix typo and reported checkpatch warnings

 .../devicetree/bindings/dma/stm32-dma.txt          |   6 +-
 drivers/dma/stm32-dma.c                            | 287 +++++++++++++++++----
 2 files changed, 243 insertions(+), 50 deletions(-)

-- 
2.7.4
