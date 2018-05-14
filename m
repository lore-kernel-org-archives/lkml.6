Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752138AbeENKBS (ORCPT <rfc822;w@1wt.eu>);
        Mon, 14 May 2018 06:01:18 -0400
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:7451 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751219AbeENKBQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 May 2018 06:01:16 -0400
From: Lionel Debieve <lionel.debieve@st.com>
To: Alexandre Torgue <alexandre.torgue@st.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Russell King <linux@armlinux.org.uk>
CC: <linux-arm-kernel@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH 1/1] ARM: dts: stm32: Add HASH support on stm32mp157c
Date: Mon, 14 May 2018 12:00:34 +0200
Message-ID: <20180514100034.10282-1-lionel.debieve@st.com>
X-Mailer: git-send-email 2.15.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.201.23.65]
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-05-14_02:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch add HASH instance of the stm32mp157c SoC

Signed-off-by: Lionel Debieve <lionel.debieve@st.com>
---
 arch/arm/boot/dts/stm32mp157c.dtsi | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/arch/arm/boot/dts/stm32mp157c.dtsi b/arch/arm/boot/dts/stm32mp157c.dtsi
index b66f673b5038..cb39fb6d9960 100644
--- a/arch/arm/boot/dts/stm32mp157c.dtsi
+++ b/arch/arm/boot/dts/stm32mp157c.dtsi
@@ -702,6 +702,18 @@
 			status = "disabled";
 		};
 
+		hash1: hash@54002000 {
+			compatible = "st,stm32f756-hash";
+			reg = <0x54002000 0x400>;
+			interrupts = <GIC_SPI 80 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&rcc HASH1>;
+			resets = <&rcc HASH1_R>;
+			dmas = <&mdma1 31 0x10 0x1000A02 0x0 0x0 0x0>;
+			dma-names = "in";
+			dma-maxburst = <2>;
+			status = "disabled";
+		};
+
 		rng1: rng@54003000 {
 			compatible = "st,stm32-rng";
 			reg = <0x54003000 0x400>;
-- 
2.15.1
