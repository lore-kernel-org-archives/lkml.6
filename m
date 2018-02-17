Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751499AbeBQT4y (ORCPT <rfc822;w@1wt.eu>);
        Sat, 17 Feb 2018 14:56:54 -0500
Received: from mailgw02.mediatek.com ([210.61.82.184]:19330 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751279AbeBQTzJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Feb 2018 14:55:09 -0500
X-UUID: 0e75611a743a4319b20b06c0ae1ff683-20180218
From: <sean.wang@mediatek.com>
To: <robh+dt@kernel.org>, <matthias.bgg@gmail.com>, <mark.rutland@arm.com>,
        <devicetree@vger.kernel.org>, <linux-mediatek@lists.infradead.org>
CC: <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        Sean Wang <sean.wang@mediatek.com>, Mark Brown <broonie@kernel.org>,
        Philippe Ombredanne <pombredanne@nexb.com>
Subject: [PATCH v3 05/15] arm64: dts: mt7622: add PMIC MT6380 related nodes
Date: Sun, 18 Feb 2018 03:54:40 +0800
Message-ID: <cc3611647afdb0711bd6bf23df67adea0f2a579b.1518895232.git.sean.wang@mediatek.com>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <cover.1518895232.git.sean.wang@mediatek.com>
References: <cover.1518895232.git.sean.wang@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK: N
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sean Wang <sean.wang@mediatek.com>

Enable pwrap and MT6380 on mt7622-rfb1 board. Also add all mt6380
regulator nodes in an alone file to allow similar boards using MT6380
able to resue the configuration.

Signed-off-by: Sean Wang <sean.wang@mediatek.com>
Cc: Mark Brown <broonie@kernel.org>
Cc: Matthias Brugger <matthias.bgg@gmail.com>
Cc: Philippe Ombredanne <pombredanne@nexb.com>
Acked-by: Philippe Ombredanne <pombredanne@nexb.com>
---
 arch/arm64/boot/dts/mediatek/mt6380.dtsi     | 86 ++++++++++++++++++++++++++++
 arch/arm64/boot/dts/mediatek/mt7622-rfb1.dts |  8 +++
 arch/arm64/boot/dts/mediatek/mt7622.dtsi     | 12 ++++
 3 files changed, 106 insertions(+)
 create mode 100644 arch/arm64/boot/dts/mediatek/mt6380.dtsi

diff --git a/arch/arm64/boot/dts/mediatek/mt6380.dtsi b/arch/arm64/boot/dts/mediatek/mt6380.dtsi
new file mode 100644
index 0000000..53b335d
--- /dev/null
+++ b/arch/arm64/boot/dts/mediatek/mt6380.dtsi
@@ -0,0 +1,86 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * dts file for MediaTek MT6380 regulator
+ *
+ * Copyright (c) 2018 MediaTek Inc.
+ * Author: Chenglin Xu <chenglin.xu@mediatek.com>
+ *	   Sean Wang <sean.wang@mediatek.com>
+ */
+
+&pwrap {
+	regulators {
+		compatible = "mediatek,mt6380-regulator";
+
+		mt6380_vcpu_reg: buck-vcore1 {
+			regulator-name = "vcore1";
+			regulator-min-microvolt = < 600000>;
+			regulator-max-microvolt = <1393750>;
+			regulator-ramp-delay = <6250>;
+			regulator-always-on;
+			regulator-boot-on;
+		};
+
+		mt6380_vcore_reg: buck-vcore {
+			regulator-name = "vcore";
+			regulator-min-microvolt = <600000>;
+			regulator-max-microvolt = <1393750>;
+			regulator-ramp-delay = <6250>;
+			regulator-always-on;
+			regulator-boot-on;
+		};
+
+		mt6380_vrf_reg: buck-vrf {
+			regulator-name = "vrf";
+			regulator-min-microvolt = <1200000>;
+			regulator-max-microvolt = <1575000>;
+			regulator-ramp-delay = <0>;
+			regulator-always-on;
+			regulator-boot-on;
+		};
+
+		mt6380_vm_reg: ldo-vm {
+			regulator-name = "vm";
+			regulator-min-microvolt = <1050000>;
+			regulator-max-microvolt = <1400000>;
+			regulator-ramp-delay = <0>;
+			regulator-always-on;
+			regulator-boot-on;
+		};
+
+		mt6380_va_reg: ldo-va {
+			regulator-name = "va";
+			regulator-min-microvolt = <2200000>;
+			regulator-max-microvolt = <3300000>;
+			regulator-ramp-delay = <0>;
+			regulator-always-on;
+			regulator-boot-on;
+		};
+
+		mt6380_vphy_reg: ldo-vphy {
+			regulator-name = "vphy";
+			regulator-min-microvolt = <1800000>;
+			regulator-max-microvolt = <1800000>;
+			regulator-ramp-delay = <0>;
+			regulator-always-on;
+			regulator-boot-on;
+		};
+
+		mt6380_vddr_reg: ldo-vddr {
+			regulator-name = "vddr";
+			regulator-min-microvolt = <1240000>;
+			regulator-max-microvolt = <1840000>;
+			regulator-ramp-delay = <0>;
+			regulator-always-on;
+			regulator-boot-on;
+		};
+
+		mt6380_vt_reg: ldo-vt {
+			regulator-name = "vt";
+			regulator-min-microvolt = <2200000>;
+			regulator-max-microvolt = <3300000>;
+			regulator-ramp-delay = <0>;
+			regulator-always-on;
+			regulator-boot-on;
+		};
+	};
+};
diff --git a/arch/arm64/boot/dts/mediatek/mt7622-rfb1.dts b/arch/arm64/boot/dts/mediatek/mt7622-rfb1.dts
index fc8ef78..42bd3a4 100644
--- a/arch/arm64/boot/dts/mediatek/mt7622-rfb1.dts
+++ b/arch/arm64/boot/dts/mediatek/mt7622-rfb1.dts
@@ -10,6 +10,7 @@
 #include <dt-bindings/input/input.h>
 
 #include "mt7622.dtsi"
+#include "mt6380.dtsi"
 
 / {
 	model = "MediaTek MT7622 RFB1 board";
@@ -222,6 +223,13 @@
 	};
 };
 
+&pwrap {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pmic_bus_pins>;
+
+	status = "okay";
+};
+
 &uart0 {
 	status = "okay";
 };
diff --git a/arch/arm64/boot/dts/mediatek/mt7622.dtsi b/arch/arm64/boot/dts/mediatek/mt7622.dtsi
index 8211bf7..c387c4c 100644
--- a/arch/arm64/boot/dts/mediatek/mt7622.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt7622.dtsi
@@ -102,6 +102,18 @@
 		#reset-cells = <1>;
 	};
 
+	pwrap: pwrap@10001000 {
+		compatible = "mediatek,mt7622-pwrap";
+		reg = <0 0x10001000 0 0x250>;
+		reg-names = "pwrap";
+		clocks = <&infracfg CLK_INFRA_PMIC_PD>,<&pwrap_clk>;
+		clock-names = "spi","wrap";
+		resets = <&infracfg MT7622_INFRA_PMIC_WRAP_RST>;
+		reset-names = "pwrap";
+		interrupts = <GIC_SPI 163 IRQ_TYPE_LEVEL_HIGH>;
+		status = "disabled";
+	};
+
 	pericfg: pericfg@10002000 {
 		compatible = "mediatek,mt7622-pericfg",
 			     "syscon";
-- 
2.7.4
