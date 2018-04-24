Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756662AbeDXHz0 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 24 Apr 2018 03:55:26 -0400
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:19306 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1756630AbeDXHzP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Apr 2018 03:55:15 -0400
From: yannick fertre <yannick.fertre@st.com>
To: Philippe Cornu <philippe.cornu@st.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Loic Pallardy <loic.pallardy@st.com>,
        "Gerald Baeza" <gerald.baeza@st.com>,
        Patrice Chotard <patrice.chotard@st.com>,
        "Kamel Kholti" <kamel.kholti@st.com>
CC: Benjamin Gaignard <benjamin.gaignard@st.com>
Subject: [PATCH v1 2/2] ARM: dts: stm32: add dsi support on stm32mp157c
Date: Tue, 24 Apr 2018 09:54:48 +0200
Message-ID: <1524556488-5404-3-git-send-email-yannick.fertre@st.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1524556488-5404-1-git-send-email-yannick.fertre@st.com>
References: <1524556488-5404-1-git-send-email-yannick.fertre@st.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.201.23.68]
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-04-24_01:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add dsi support on stm32mp157c

Signed-off-by: yannick fertre <yannick.fertre@st.com>
---
 arch/arm/boot/dts/stm32mp157c.dtsi | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/arm/boot/dts/stm32mp157c.dtsi b/arch/arm/boot/dts/stm32mp157c.dtsi
index af6cc48..c61cb6d 100644
--- a/arch/arm/boot/dts/stm32mp157c.dtsi
+++ b/arch/arm/boot/dts/stm32mp157c.dtsi
@@ -168,6 +168,16 @@
 			#reset-cells = <1>;
 		};
 
+		dsi: dsi@5a000000 {
+			compatible = "st,stm32-dsi";
+			reg = <0x5a000000 0x800>;
+			clocks = <&rcc DSI_K>, <&clk_hse>, <&rcc DSI_PX>;
+			clock-names = "pclk", "ref", "px_clk";
+			resets = <&rcc DSI_R>;
+			reset-names = "apb";
+			status = "disabled";
+		};
+
 		ltdc: display-controller@5a001000 {
 			compatible = "st,stm32-ltdc";
 			reg = <0x5a001000 0x400>;
-- 
1.9.1
