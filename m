Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1425420AbeBOQEk (ORCPT <rfc822;w@1wt.eu>);
        Thu, 15 Feb 2018 11:04:40 -0500
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:36219 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1424770AbeBOQEA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Feb 2018 11:04:00 -0500
From: Amelie Delaunay <amelie.delaunay@st.com>
To: Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Russell King <linux@armlinux.org.uk>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>
CC: <devicetree@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        Amelie Delaunay <amelie.delaunay@st.com>
Subject: [PATCH 2/3] ARM: dts: stm32: add USB OTG FS support for STM32H743 SoC
Date: Thu, 15 Feb 2018 17:03:23 +0100
Message-ID: <1518710604-21632-3-git-send-email-amelie.delaunay@st.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1518710604-21632-1-git-send-email-amelie.delaunay@st.com>
References: <1518710604-21632-1-git-send-email-amelie.delaunay@st.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.201.20.5]
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-02-15_06:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds support for USB OTG FS on STM32H743 SoC.
USB OTG FS controller is the same than the one used on STM32F4 SoCs.

Signed-off-by: Amelie Delaunay <amelie.delaunay@st.com>
---
 arch/arm/boot/dts/stm32h743.dtsi | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/arm/boot/dts/stm32h743.dtsi b/arch/arm/boot/dts/stm32h743.dtsi
index 65d4509..eb4ba90 100644
--- a/arch/arm/boot/dts/stm32h743.dtsi
+++ b/arch/arm/boot/dts/stm32h743.dtsi
@@ -229,6 +229,15 @@
 			status = "disabled";
 		};
 
+		usbotg_fs: usb@40080000 {
+			compatible = "st,stm32f4x9-fsotg";
+			reg = <0x40080000 0x40000>;
+			interrupts = <101>;
+			clocks = <&rcc USB2OTG_CK>;
+			clock-names = "otg";
+			status = "disabled";
+		};
+
 		mdma1: dma@52000000 {
 			compatible = "st,stm32h7-mdma";
 			reg = <0x52000000 0x1000>;
-- 
2.7.4
