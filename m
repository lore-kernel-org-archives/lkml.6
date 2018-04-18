Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753994AbeDRPr2 (ORCPT <rfc822;w@1wt.eu>);
        Wed, 18 Apr 2018 11:47:28 -0400
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:1845 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1753087AbeDRPrZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Apr 2018 11:47:25 -0400
From: Fabrice Gasnier <fabrice.gasnier@st.com>
To: <alexandre.torgue@st.com>, <robh+dt@kernel.org>
CC: <mcoquelin.stm32@gmail.com>, <mark.rutland@arm.com>,
        <linux-arm-kernel@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <fabrice.gasnier@st.com>
Subject: [PATCH] ARM: dts: stm32: Add DAC support to stm32mp157c
Date: Wed, 18 Apr 2018 17:46:31 +0200
Message-ID: <1524066391-843-1-git-send-email-fabrice.gasnier@st.com>
X-Mailer: git-send-email 1.9.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.75.127.119]
X-ClientProxiedBy: GPXDAG3NODE4.st.com (10.75.127.71) To GPXDAG5NODE6.st.com
 (10.75.127.79)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-04-18_03:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for DAC (Digital to Analog Converter) to STM32MP157C.
STM32MP157C DAC has two output channels.

Signed-off-by: Fabrice Gasnier <fabrice.gasnier@st.com>
---
 arch/arm/boot/dts/stm32mp157c.dtsi | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/arch/arm/boot/dts/stm32mp157c.dtsi b/arch/arm/boot/dts/stm32mp157c.dtsi
index bc3eddc..fd44b4d 100644
--- a/arch/arm/boot/dts/stm32mp157c.dtsi
+++ b/arch/arm/boot/dts/stm32mp157c.dtsi
@@ -136,6 +136,30 @@
 			status = "disabled";
 		};
 
+		dac: dac@40017000 {
+			compatible = "st,stm32h7-dac-core";
+			reg = <0x40017000 0x400>;
+			clocks = <&rcc DAC12>;
+			clock-names = "pclk";
+			#address-cells = <1>;
+			#size-cells = <0>;
+			status = "disabled";
+
+			dac1: dac@1 {
+				compatible = "st,stm32-dac";
+				#io-channels-cells = <1>;
+				reg = <1>;
+				status = "disabled";
+			};
+
+			dac2: dac@2 {
+				compatible = "st,stm32-dac";
+				#io-channels-cells = <1>;
+				reg = <2>;
+				status = "disabled";
+			};
+		};
+
 		uart7: serial@40018000 {
 			compatible = "st,stm32h7-uart";
 			reg = <0x40018000 0x400>;
-- 
1.9.1
