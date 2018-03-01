Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S967240AbeCAJq6 (ORCPT <rfc822;w@1wt.eu>);
        Thu, 1 Mar 2018 04:46:58 -0500
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:17643 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S967169AbeCAJpR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Mar 2018 04:45:17 -0500
From: <patrice.chotard@st.com>
To: <robh+dt@kernel.org>, <mark.rutland@arm.com>, <linux@armlinux.org.uk>,
        <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <alexandre.torgue@st.com>,
        <lee.jones@linaro.org>
CC: <mcoquelin.stm32@gmail.com>, Patrice Chotard <patrice.chotard@st.com>
Subject: [PATCH 2/6] ARM: dts: stm32: Enable sdio1 for stm32f746-disco
Date: Thu, 1 Mar 2018 10:43:37 +0100
Message-ID: <1519897421-23803-3-git-send-email-patrice.chotard@st.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1519897421-23803-1-git-send-email-patrice.chotard@st.com>
References: <1519897421-23803-1-git-send-email-patrice.chotard@st.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.75.127.44]
X-ClientProxiedBy: SFHDAG1NODE1.st.com (10.75.127.1) To SFHDAG6NODE3.st.com
 (10.75.127.18)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-03-01_05:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Patrice Chotard <patrice.chotard@st.com>

Adds SDIO related DT nodes for stm32f746-disco board.

Signed-off-by: Patrice Chotard <patrice.chotard@st.com>
---
 arch/arm/boot/dts/stm32f746-disco.dts | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/arch/arm/boot/dts/stm32f746-disco.dts b/arch/arm/boot/dts/stm32f746-disco.dts
index 623b6f2bc361..ab65f812e8ae 100644
--- a/arch/arm/boot/dts/stm32f746-disco.dts
+++ b/arch/arm/boot/dts/stm32f746-disco.dts
@@ -44,6 +44,7 @@
 #include "stm32f746.dtsi"
 #include "stm32f746-pinctrl.dtsi"
 #include <dt-bindings/input/input.h>
+#include <dt-bindings/gpio/gpio.h>
 
 / {
 	model = "STMicroelectronics STM32F746-DISCO board";
@@ -76,12 +77,30 @@
 		regulator-name = "vcc5_host1";
 		regulator-always-on;
 	};
+
+	mmc_vcard: mmc_vcard {
+		compatible = "regulator-fixed";
+		regulator-name = "mmc_vcard";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+	};
 };
 
 &clk_hse {
 	clock-frequency = <25000000>;
 };
 
+&sdio1 {
+	status = "okay";
+	vmmc-supply = <&mmc_vcard>;
+	cd-gpios = <&gpioc 13 GPIO_ACTIVE_HIGH>;
+	cd-inverted;
+	pinctrl-names = "default", "opendrain";
+	pinctrl-0 = <&sdio_pins>;
+	pinctrl-1 = <&sdio_pins_od>;
+	bus-width = <4>;
+};
+
 &usart1 {
 	pinctrl-0 = <&usart1_pins_b>;
 	pinctrl-names = "default";
-- 
1.9.1
