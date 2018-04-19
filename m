Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753549AbeDSPAm (ORCPT <rfc822;w@1wt.eu>);
        Thu, 19 Apr 2018 11:00:42 -0400
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:35553 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752900AbeDSPAj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Apr 2018 11:00:39 -0400
From: Amelie Delaunay <amelie.delaunay@st.com>
To: Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>
CC: <linux-arm-kernel@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Amelie Delaunay <amelie.delaunay@st.com>
Subject: [PATCH 1/3] ARM: dts: stm32: add USBPHYC support to stm32mp157c
Date: Thu, 19 Apr 2018 16:59:54 +0200
Message-ID: <1524149996-27809-2-git-send-email-amelie.delaunay@st.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1524149996-27809-1-git-send-email-amelie.delaunay@st.com>
References: <1524149996-27809-1-git-send-email-amelie.delaunay@st.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.201.20.5]
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-04-19_05:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for USBPHYC (USB PHY Controller) to STM32MP157C SoC.
It manages two usb2 ports.

Signed-off-by: Amelie Delaunay <amelie.delaunay@st.com>
---
 arch/arm/boot/dts/stm32mp157c.dtsi | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/arch/arm/boot/dts/stm32mp157c.dtsi b/arch/arm/boot/dts/stm32mp157c.dtsi
index bc3eddc..c64cac1 100644
--- a/arch/arm/boot/dts/stm32mp157c.dtsi
+++ b/arch/arm/boot/dts/stm32mp157c.dtsi
@@ -167,6 +167,26 @@
 			#reset-cells = <1>;
 		};
 
+		usbphyc: usbphyc@5a006000 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			compatible = "st,stm32mp1-usbphyc";
+			reg = <0x5a006000 0x1000>;
+			clocks = <&rcc USBPHY_K>;
+			resets = <&rcc USBPHY_R>;
+			status = "disabled";
+
+			usbphyc_port0: usb-phy@0 {
+				#phy-cells = <0>;
+				reg = <0>;
+			};
+
+			usbphyc_port1: usb-phy@1 {
+				#phy-cells = <1>;
+				reg = <1>;
+			};
+		};
+
 		usart1: serial@5c000000 {
 			compatible = "st,stm32h7-uart";
 			reg = <0x5c000000 0x400>;
-- 
2.7.4
