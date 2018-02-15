Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755161AbeBOIWH (ORCPT <rfc822;w@1wt.eu>);
        Thu, 15 Feb 2018 03:22:07 -0500
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:45066 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1754906AbeBOIVO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Feb 2018 03:21:14 -0500
From: Philippe Cornu <philippe.cornu@st.com>
To: Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Russell King <linux@armlinux.org.uk>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        <devicetree@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
CC: Benjamin Gaignard <benjamin.gaignard@linaro.org>,
        Yannick Fertre <yannick.fertre@st.com>,
        Philippe Cornu <philippe.cornu@st.com>,
        "Vincent Abriou" <vincent.abriou@st.com>
Subject: [PATCH 2/3] ARM: dts: stm32: Add new stm32f469 dtsi file with mipi dsi
Date: Thu, 15 Feb 2018 09:20:13 +0100
Message-ID: <20180215082014.30383-3-philippe.cornu@st.com>
X-Mailer: git-send-email 2.15.1
In-Reply-To: <20180215082014.30383-1-philippe.cornu@st.com>
References: <20180215082014.30383-1-philippe.cornu@st.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.129.6.172]
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-02-15_03:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In the stm32f4 family, mipi dsi is only supported on stm32f469.
So add a new stm32f469 dtsi file & add mipi dsi support inside.

Signed-off-by: Philippe Cornu <philippe.cornu@st.com>
---
 arch/arm/boot/dts/stm32f469.dtsi | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)
 create mode 100644 arch/arm/boot/dts/stm32f469.dtsi

diff --git a/arch/arm/boot/dts/stm32f469.dtsi b/arch/arm/boot/dts/stm32f469.dtsi
new file mode 100644
index 000000000000..5ae5213f68cb
--- /dev/null
+++ b/arch/arm/boot/dts/stm32f469.dtsi
@@ -0,0 +1,19 @@
+/* SPDX-License-Identifier: (GPL-2.0+ OR BSD-3-Clause) */
+/* Copyright (C) STMicroelectronics 2017 - All Rights Reserved */
+
+#include "stm32f429.dtsi"
+
+/ {
+	soc {
+		dsi: dsi@40016c00 {
+			compatible = "st,stm32-dsi";
+			reg = <0x40016c00 0x800>;
+			interrupts = <92>;
+			resets = <&rcc STM32F4_APB2_RESET(DSI)>;
+			reset-names = "apb";
+			clocks = <&rcc 1 CLK_F469_DSI>, <&clk_hse>;
+			clock-names = "pclk", "ref";
+			status = "disabled";
+		};
+	};
+};
-- 
2.15.1
