Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752365AbeBHO3U (ORCPT <rfc822;w@1wt.eu>);
        Thu, 8 Feb 2018 09:29:20 -0500
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:38727 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751848AbeBHO2f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Feb 2018 09:28:35 -0500
From: Amelie Delaunay <amelie.delaunay@st.com>
To: Lee Jones <lee.jones@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Russell King <linux@armlinux.org.uk>,
        "Alexandre Torgue" <alexandre.torgue@st.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>
CC: <linux-gpio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        "Amelie Delaunay" <amelie.delaunay@st.com>
Subject: [PATCH 4/6] ARM: dts: stm32: add MFX support on I2C1 on stm32746g-eval
Date: Thu, 8 Feb 2018 15:27:35 +0100
Message-ID: <1518100057-23234-5-git-send-email-amelie.delaunay@st.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1518100057-23234-1-git-send-email-amelie.delaunay@st.com>
References: <1518100057-23234-1-git-send-email-amelie.delaunay@st.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.201.20.5]
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-02-08_08:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

MFX is used as gpio expander on stm32746g-eval.

Signed-off-by: Amelie Delaunay <amelie.delaunay@st.com>
---
 arch/arm/boot/dts/stm32746g-eval.dts | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/arch/arm/boot/dts/stm32746g-eval.dts b/arch/arm/boot/dts/stm32746g-eval.dts
index e74ae59..99739f7 100644
--- a/arch/arm/boot/dts/stm32746g-eval.dts
+++ b/arch/arm/boot/dts/stm32746g-eval.dts
@@ -128,6 +128,23 @@
 	i2c-scl-rising-time-ns = <185>;
 	i2c-scl-falling-time-ns = <20>;
 	status = "okay";
+
+	mfx: mfx@42 {
+		compatible = "st,mfx";
+		reg = <0x42>;
+		interrupts = <8 1>;
+		interrupt-parent = <&gpioi>;
+		interrupt-controller;
+		#interrupt-cells = <1>;
+
+		mfxgpio: mfx_gpio {
+			compatible = "st,mfx-gpio";
+			interrupts = <0>;
+			interrupt-parent = <&mfx>;
+			gpio-controller;
+			#gpio-cells = <2>;
+		};
+	};
 };
 
 &mac {
-- 
2.7.4
