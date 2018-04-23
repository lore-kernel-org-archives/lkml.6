Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755762AbeDWPVA (ORCPT <rfc822;w@1wt.eu>);
        Mon, 23 Apr 2018 11:21:00 -0400
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:16799 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1755525AbeDWPUy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Apr 2018 11:20:54 -0400
From: Lionel Debieve <lionel.debieve@st.com>
To: Alexandre Torgue <alexandre.torgue@st.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Russell King <linux@armlinux.org.uk>
CC: <linux-arm-kernel@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH 1/4] ARM: dts: stm32: Add RNG support on stm32mp157c
Date: Mon, 23 Apr 2018 17:19:44 +0200
Message-ID: <20180423151947.2526-2-lionel.debieve@st.com>
X-Mailer: git-send-email 2.15.1
In-Reply-To: <20180423151947.2526-1-lionel.debieve@st.com>
References: <20180423151947.2526-1-lionel.debieve@st.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.201.23.65]
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-04-23_05:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch add RNG instance of the stm32mp157c SoC

Signed-off-by: Lionel Debieve <lionel.debieve@st.com>
---
 arch/arm/boot/dts/stm32mp157c.dtsi | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/arm/boot/dts/stm32mp157c.dtsi b/arch/arm/boot/dts/stm32mp157c.dtsi
index bc3eddc3eda6..bf00885971b3 100644
--- a/arch/arm/boot/dts/stm32mp157c.dtsi
+++ b/arch/arm/boot/dts/stm32mp157c.dtsi
@@ -5,6 +5,7 @@
  */
 #include <dt-bindings/interrupt-controller/arm-gic.h>
 #include <dt-bindings/clock/stm32mp1-clks.h>
+#include <dt-bindings/reset/stm32mp1-resets.h>
 
 / {
 	#address-cells = <1>;
@@ -167,6 +168,14 @@
 			#reset-cells = <1>;
 		};
 
+		rng1: rng@54003000 {
+			compatible = "st,stm32-rng";
+			reg = <0x54003000 0x400>;
+			clocks = <&rcc RNG1_K>;
+			resets = <&rcc RNG1_R>;
+			status = "disabled";
+		};
+
 		usart1: serial@5c000000 {
 			compatible = "st,stm32h7-uart";
 			reg = <0x5c000000 0x400>;
-- 
2.15.1
