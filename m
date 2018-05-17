Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752153AbeEQMHz (ORCPT <rfc822;w@1wt.eu>);
        Thu, 17 May 2018 08:07:55 -0400
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:56192 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1751097AbeEQMHw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 May 2018 08:07:52 -0400
From: Amelie Delaunay <amelie.delaunay@st.com>
To: Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Russell King <linux@armlinux.org.uk>, Arnd Bergmann <arnd@arndb.de>
CC: <linux-arm-kernel@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Amelie Delaunay <amelie.delaunay@st.com>
Subject: [PATCH v2 1/3] ARM: dts: stm32: add RTC support to stm32mp157c
Date: Thu, 17 May 2018 14:07:06 +0200
Message-ID: <1526558828-24456-2-git-send-email-amelie.delaunay@st.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1526558828-24456-1-git-send-email-amelie.delaunay@st.com>
References: <1526558828-24456-1-git-send-email-amelie.delaunay@st.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.201.20.5]
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-05-17_05:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for RTC (Real Time Clock) to STM32MP157C SoC.

Signed-off-by: Amelie Delaunay <amelie.delaunay@st.com>
---
 arch/arm/boot/dts/stm32mp157c.dtsi | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/arm/boot/dts/stm32mp157c.dtsi b/arch/arm/boot/dts/stm32mp157c.dtsi
index b66f673..df2d874 100644
--- a/arch/arm/boot/dts/stm32mp157c.dtsi
+++ b/arch/arm/boot/dts/stm32mp157c.dtsi
@@ -818,6 +818,15 @@
 			status = "disabled";
 		};
 
+		rtc: rtc@5c004000 {
+			compatible = "st,stm32mp1-rtc";
+			reg = <0x5c004000 0x400>;
+			clocks = <&rcc RTCAPB>, <&rcc RTC>;
+			clock-names = "pclk", "rtc_ck";
+			interrupts = <GIC_SPI 3 IRQ_TYPE_LEVEL_HIGH>;
+			status = "disabled";
+		};
+
 		i2c6: i2c@5c009000 {
 			compatible = "st,stm32f7-i2c";
 			reg = <0x5c009000 0x400>;
-- 
2.7.4
