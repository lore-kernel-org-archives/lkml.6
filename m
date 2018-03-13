Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933481AbeCMQnm (ORCPT <rfc822;w@1wt.eu>);
        Tue, 13 Mar 2018 12:43:42 -0400
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:29187 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S933586AbeCMQmy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Mar 2018 12:42:54 -0400
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
Subject: [PATCH v1 1/8] dt-bindings: stm32-dma: introduce DMA features bitfield
Date: Tue, 13 Mar 2018 17:42:00 +0100
Message-ID: <1520959327-25760-2-git-send-email-pierre-yves.mordret@st.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1520959327-25760-1-git-send-email-pierre-yves.mordret@st.com>
References: <1520959327-25760-1-git-send-email-pierre-yves.mordret@st.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.75.127.49]
X-ClientProxiedBy: SFHDAG2NODE3.st.com (10.75.127.6) To SFHDAG5NODE2.st.com
 (10.75.127.14)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-03-13_07:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This bitfield intends to address features to be activated within the
driver. Initially the mask was only meant for FIFO Threshold management.
Backward compatibility is preserved but the meaning of this field has been
extended to features instead of only threshold.

Signed-off-by: Pierre-Yves MORDRET <pierre-yves.mordret@st.com>
---
  Version history:
    v1:
       * Initial
---
---
 Documentation/devicetree/bindings/dma/stm32-dma.txt | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/dma/stm32-dma.txt b/Documentation/devicetree/bindings/dma/stm32-dma.txt
index 0b55718..c5f5190 100644
--- a/Documentation/devicetree/bindings/dma/stm32-dma.txt
+++ b/Documentation/devicetree/bindings/dma/stm32-dma.txt
@@ -62,14 +62,14 @@ channel: a phandle to the DMA controller plus the following four integer cells:
 	0x1: medium
 	0x2: high
 	0x3: very high
-4. A 32bit mask specifying the DMA FIFO threshold configuration which are device
-   dependent:
- -bit 0-1: Fifo threshold
+4. A 32bit bitfield value specifying DMA features which are device dependent:
+ -bit 0-1: DMA FIFO threshold selection
 	0x0: 1/4 full FIFO
 	0x1: 1/2 full FIFO
 	0x2: 3/4 full FIFO
 	0x3: full FIFO
 
+
 Example:
 
 	usart1: serial@40011000 {
-- 
2.7.4
