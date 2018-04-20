Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754337AbeDTJPM (ORCPT <rfc822;w@1wt.eu>);
        Fri, 20 Apr 2018 05:15:12 -0400
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:48150 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1754172AbeDTJPJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Apr 2018 05:15:09 -0400
From: Pierre-Yves MORDRET <pierre-yves.mordret@st.com>
To: Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Russell King <linux@armlinux.org.uk>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        <devicetree@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
CC: Pierre-Yves MORDRET <pierre-yves.mordret@st.com>
Subject: [PATCH v1 4/4] ARM: dts: stm32: Add DMAMUX support on STM32MP157C
Date: Fri, 20 Apr 2018 11:14:41 +0200
Message-ID: <1524215681-14555-5-git-send-email-pierre-yves.mordret@st.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1524215681-14555-1-git-send-email-pierre-yves.mordret@st.com>
References: <1524215681-14555-1-git-send-email-pierre-yves.mordret@st.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.75.127.116]
X-ClientProxiedBy: GPXDAG2NODE5.st.com (10.75.127.69) To GPXDAG5NODE5.st.com
 (10.75.127.78)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-04-20_03:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Activate DMAMUX for STM32MP157C

Signed-off-by: Pierre-Yves MORDRET <pierre-yves.mordret@st.com>
---
  Version history:
     v1:
        * Initial
---
---
 arch/arm/boot/dts/stm32mp157c.dtsi | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/arch/arm/boot/dts/stm32mp157c.dtsi b/arch/arm/boot/dts/stm32mp157c.dtsi
index 3c0ca6c..da4c39e 100644
--- a/arch/arm/boot/dts/stm32mp157c.dtsi
+++ b/arch/arm/boot/dts/stm32mp157c.dtsi
@@ -174,6 +174,7 @@
 			clocks = <&rcc DMA1>;
 			#dma-cells = <4>;
 			st,mem2mem;
+			dma-requests = <8>;
 		};
 
 		dma2: dma@48001000 {
@@ -190,6 +191,17 @@
 			clocks = <&rcc DMA2>;
 			#dma-cells = <4>;
 			st,mem2mem;
+			dma-requests = <8>;
+		};
+
+		dmamux1: dma-router@48002000 {
+			compatible = "st,stm32h7-dmamux";
+			reg = <0x48002000 0x1c>;
+			#dma-cells = <3>;
+			dma-requests = <128>;
+			dma-masters = <&dma1 &dma2>;
+			dma-channels = <16>;
+			clocks = <&rcc DMAMUX>;
 		};
 
 		rcc: rcc@50000000 {
-- 
2.7.4
