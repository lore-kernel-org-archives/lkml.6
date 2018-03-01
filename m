Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S967637AbeCAKy3 (ORCPT <rfc822;w@1wt.eu>);
        Thu, 1 Mar 2018 05:54:29 -0500
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:43684 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S967490AbeCAKyZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Mar 2018 05:54:25 -0500
From: <patrice.chotard@st.com>
To: <robh+dt@kernel.org>, <mark.rutland@arm.com>, <linux@armlinux.org.uk>,
        <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <alexandre.torgue@st.com>,
        <lee.jones@linaro.org>
CC: <mcoquelin.stm32@gmail.com>, Patrice Chotard <patrice.chotard@st.com>
Subject: [PATCH v2 3/6] ARM: dts: stm32: Enable sdio1 for stm32f746-eval
Date: Thu, 1 Mar 2018 11:53:40 +0100
Message-ID: <1519901623-23216-4-git-send-email-patrice.chotard@st.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1519901623-23216-1-git-send-email-patrice.chotard@st.com>
References: <1519901623-23216-1-git-send-email-patrice.chotard@st.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.75.127.45]
X-ClientProxiedBy: SFHDAG5NODE1.st.com (10.75.127.13) To SFHDAG6NODE3.st.com
 (10.75.127.18)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-03-01_06:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Patrice Chotard <patrice.chotard@st.com>

Adds SDIO related DT nodes for stm32f746-eval board.

broken-cd property is needed as card detect signal is
connected to a GPIO expander which is not yet supported
in kernel linux.

Signed-off-by: Patrice Chotard <patrice.chotard@st.com>
---

v2: _ rename sdio_pins / sdio_od_pins to sdio_pins_a / sdio_od_pins_a 

 arch/arm/boot/dts/stm32746g-eval.dts | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/arch/arm/boot/dts/stm32746g-eval.dts b/arch/arm/boot/dts/stm32746g-eval.dts
index b2d4b8c46677..32b74d52d87f 100644
--- a/arch/arm/boot/dts/stm32746g-eval.dts
+++ b/arch/arm/boot/dts/stm32746g-eval.dts
@@ -91,6 +91,13 @@
 		clocks = <&rcc 0 STM32F7_AHB1_CLOCK(OTGHSULPI)>;
 		clock-names = "main_clk";
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
@@ -113,6 +120,16 @@
 	status = "okay";
 };
 
+&sdio1 {
+	status = "okay";
+	vmmc-supply = <&mmc_vcard>;
+	broken-cd;
+	pinctrl-names = "default", "opendrain";
+	pinctrl-0 = <&sdio_pins_a>;
+	pinctrl-1 = <&sdio_pins_od_a>;
+	bus-width = <4>;
+};
+
 &usart1 {
 	pinctrl-0 = <&usart1_pins_a>;
 	pinctrl-names = "default";
-- 
1.9.1
