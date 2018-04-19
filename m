Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753335AbeDSOfz (ORCPT <rfc822;w@1wt.eu>);
        Thu, 19 Apr 2018 10:35:55 -0400
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:54907 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1753122AbeDSOfy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Apr 2018 10:35:54 -0400
From: Amelie Delaunay <amelie.delaunay@st.com>
To: Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>
CC: <linux-arm-kernel@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Amelie Delaunay <amelie.delaunay@st.com>
Subject: [PATCH 1/2] ARM: dts: stm32: add RTC support to stm32mp157c
Date: Thu, 19 Apr 2018 16:35:24 +0200
Message-ID: <1524148525-25209-2-git-send-email-amelie.delaunay@st.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1524148525-25209-1-git-send-email-amelie.delaunay@st.com>
References: <1524148525-25209-1-git-send-email-amelie.delaunay@st.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.201.20.5]
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-04-19_05:,,
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
index bc3eddc..3333954 100644
--- a/arch/arm/boot/dts/stm32mp157c.dtsi
+++ b/arch/arm/boot/dts/stm32mp157c.dtsi
@@ -174,5 +174,14 @@
 			clocks = <&rcc USART1_K>;
 			status = "disabled";
 		};
+
+		rtc: rtc@5c004000 {
+			compatible = "st,stm32mp1-rtc";
+			reg = <0x5c004000 0x400>;
+			clocks = <&rcc RTCAPB>, <&rcc RTC>;
+			clock-names = "pclk", "rtc_ck";
+			interrupts = <GIC_SPI 3 IRQ_TYPE_HIGH_LEVEL>;
+			status = "disabled";
+		};
 	};
 };
-- 
2.7.4
