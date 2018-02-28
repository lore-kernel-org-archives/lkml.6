Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752597AbeB1KsZ (ORCPT <rfc822;w@1wt.eu>);
        Wed, 28 Feb 2018 05:48:25 -0500
Received: from mail-pf0-f196.google.com ([209.85.192.196]:35164 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932170AbeB1KsR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Feb 2018 05:48:17 -0500
X-Google-Smtp-Source: AH8x227y9rfywjGxTYVbgmNeud2Wl7DZV0gqt9gs9xQrvdWJVQF+Y+znh22EzjCdHNBqvu0kyQfsVA==
From: Baolin Wang <baolin.wang@linaro.org>
To: robh+dt@kernel.org, mark.rutland@arm.com, catalin.marinas@arm.com,
        will.deacon@arm.com, arnd@arndb.de
Cc: chunyan.zhang@linaro.org, orson.zhai@spreadtrum.com,
        mathieu.poirier@linaro.org, devicetree@vger.kernel.org, arm@kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        broonie@kernel.org, baolin.wang@linaro.org
Subject: [RESEND PATCH 7/7] arm64: dts: Add SC2731 PMIC dts file for Spreadtrum SC9860
Date: Wed, 28 Feb 2018 18:47:10 +0800
Message-Id: <2e0470cdfed459fd01cd92b1ddfcc997848ce425.1519814593.git.baolin.wang@linaro.org>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <5ec790b43c6fea9f36e06b5b20233b2adebd7d50.1519814593.git.baolin.wang@linaro.org>
References: <5ec790b43c6fea9f36e06b5b20233b2adebd7d50.1519814593.git.baolin.wang@linaro.org>
In-Reply-To: <5ec790b43c6fea9f36e06b5b20233b2adebd7d50.1519814593.git.baolin.wang@linaro.org>
References: <5ec790b43c6fea9f36e06b5b20233b2adebd7d50.1519814593.git.baolin.wang@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Spreadtrum SC9860 platform has one SC2731 PMIC, and the SC2731
PMIC integrates all mobile handset power management, audio codec,
battery management and user interface support function in a single
chip.

This patch adds the SC2731 dts file, as well as adding the RTC and
regulator device node for this PMIC.

Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
---
 arch/arm64/boot/dts/sprd/sc2731.dtsi      |  169 +++++++++++++++++++++++++++++
 arch/arm64/boot/dts/sprd/sp9860g-1h10.dts |    1 +
 2 files changed, 170 insertions(+)
 create mode 100644 arch/arm64/boot/dts/sprd/sc2731.dtsi

diff --git a/arch/arm64/boot/dts/sprd/sc2731.dtsi b/arch/arm64/boot/dts/sprd/sc2731.dtsi
new file mode 100644
index 0000000..4331006
--- /dev/null
+++ b/arch/arm64/boot/dts/sprd/sc2731.dtsi
@@ -0,0 +1,169 @@
+/*
+ * Spreadtrum SC2731 PMIC dts file
+ *
+ * Copyright (C) 2018, Spreadtrum Communications Inc.
+ *
+ * SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+ */
+
+&adi_bus {
+	sc2731_pmic: pmic@0 {
+		compatible = "sprd,sc2731";
+		reg = <0>;
+		spi-max-frequency = <26000000>;
+		interrupts = <GIC_SPI 31 IRQ_TYPE_LEVEL_HIGH>;
+		interrupt-controller;
+		#interrupt-cells = <2>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		rtc@280 {
+			compatible = "sprd,sc27xx-rtc", "sprd,sc2731-rtc";
+			reg = <0x280>;
+			interrupt-parent = <&sc2731_pmic>;
+			interrupts = <2 IRQ_TYPE_LEVEL_HIGH>;
+		};
+
+		regulators {
+			compatible = "sprd,sc27xx-regulator";
+
+			vddarm0: BUCK_CPU0 {
+				regulator-name = "vddarm0";
+				regulator-min-microvolt = <400000>;
+				regulator-max-microvolt = <1996875>;
+				regulator-ramp-delay = <25000>;
+				regulator-always-on;
+			};
+
+			vddarm1: BUCK_CPU1 {
+				regulator-name = "vddarm1";
+				regulator-min-microvolt = <400000>;
+				regulator-max-microvolt = <1996875>;
+				regulator-ramp-delay = <25000>;
+				regulator-always-on;
+			};
+
+			dcdcrf: BUCK_RF {
+				regulator-name = "dcdcrf";
+				regulator-min-microvolt = <600000>;
+				regulator-max-microvolt = <2196875>;
+				regulator-ramp-delay = <25000>;
+				regulator-enable-ramp-delay = <100>;
+				regulator-always-on;
+			};
+
+			vddcama0: LDO_CAMA0 {
+				regulator-name = "vddcama0";
+				regulator-min-microvolt = <1200000>;
+				regulator-max-microvolt = <3750000>;
+				regulator-enable-ramp-delay = <100>;
+			};
+
+			vddcama1: LDO_CAMA1 {
+				regulator-name = "vddcama1";
+				regulator-min-microvolt = <1200000>;
+				regulator-max-microvolt = <3750000>;
+				regulator-enable-ramp-delay = <100>;
+				regulator-ramp-delay = <25000>;
+			};
+
+			vddcammot: LDO_CAMMOT {
+				regulator-name = "vddcammot";
+				regulator-min-microvolt = <1200000>;
+				regulator-max-microvolt = <3750000>;
+				regulator-enable-ramp-delay = <100>;
+				regulator-ramp-delay = <25000>;
+			};
+
+			vddvldo: LDO_VLDO {
+				regulator-name = "vddvldo";
+				regulator-min-microvolt = <1200000>;
+				regulator-max-microvolt = <3750000>;
+				regulator-enable-ramp-delay = <100>;
+				regulator-ramp-delay = <25000>;
+			};
+
+			vddemmccore: LDO_EMMCCORE {
+				regulator-name = "vddemmccore";
+				regulator-min-microvolt = <1200000>;
+				regulator-max-microvolt = <3750000>;
+				regulator-enable-ramp-delay = <100>;
+				regulator-ramp-delay = <25000>;
+				regulator-boot-on;
+			};
+
+			vddsdcore: LDO_SDCORE {
+				regulator-name = "vddsdcore";
+				regulator-min-microvolt = <1200000>;
+				regulator-max-microvolt = <3750000>;
+				regulator-enable-ramp-delay = <100>;
+				regulator-ramp-delay = <25000>;
+			};
+
+			vddsdio: LDO_SDIO {
+				regulator-name = "vddsdio";
+				regulator-min-microvolt = <1200000>;
+				regulator-max-microvolt = <3750000>;
+				regulator-enable-ramp-delay = <100>;
+				regulator-ramp-delay = <25000>;
+			};
+
+			vddwifipa: LDO_WIFIPA {
+				regulator-name = "vddwifipa";
+				regulator-min-microvolt = <1200000>;
+				regulator-max-microvolt = <3750000>;
+				regulator-enable-ramp-delay = <100>;
+				regulator-ramp-delay = <25000>;
+			};
+
+			vddusb33: LDO_USB33 {
+				regulator-name = "vddusb33";
+				regulator-min-microvolt = <1200000>;
+				regulator-max-microvolt = <3750000>;
+				regulator-enable-ramp-delay = <100>;
+				regulator-ramp-delay = <25000>;
+			};
+
+			vddcamd0: LDO_CAMD0 {
+				regulator-name = "vddcamd0";
+				regulator-min-microvolt = <1000000>;
+				regulator-max-microvolt = <1793750>;
+				regulator-enable-ramp-delay = <100>;
+				regulator-ramp-delay = <25000>;
+			};
+
+			vddcamd1: LDO_CAMD1 {
+				regulator-name = "vddcamd1";
+				regulator-min-microvolt = <1000000>;
+				regulator-max-microvolt = <1793750>;
+				regulator-enable-ramp-delay = <100>;
+				regulator-ramp-delay = <25000>;
+			};
+
+			vddcon: LDO_CON {
+				regulator-name = "vddcon";
+				regulator-min-microvolt = <1000000>;
+				regulator-max-microvolt = <1793750>;
+				regulator-enable-ramp-delay = <100>;
+				regulator-ramp-delay = <25000>;
+			};
+
+			vddcamio: LDO_CAMIO {
+				regulator-name = "vddcamio";
+				regulator-min-microvolt = <1000000>;
+				regulator-max-microvolt = <1793750>;
+				regulator-enable-ramp-delay = <100>;
+				regulator-ramp-delay = <25000>;
+			};
+
+			vddsram: LDO_SRAM {
+				regulator-name = "vddsram";
+				regulator-min-microvolt = <1000000>;
+				regulator-max-microvolt = <1793750>;
+				regulator-enable-ramp-delay = <100>;
+				regulator-ramp-delay = <25000>;
+				regulator-always-on;
+			};
+		};
+	};
+};
diff --git a/arch/arm64/boot/dts/sprd/sp9860g-1h10.dts b/arch/arm64/boot/dts/sprd/sp9860g-1h10.dts
index 550f323..3bd18e3 100644
--- a/arch/arm64/boot/dts/sprd/sp9860g-1h10.dts
+++ b/arch/arm64/boot/dts/sprd/sp9860g-1h10.dts
@@ -9,6 +9,7 @@
 /dts-v1/;
 
 #include "sc9860.dtsi"
+#include "sc2731.dtsi"
 
 / {
 	model = "Spreadtrum SP9860G 3GFHD Board";
-- 
1.7.9.5
