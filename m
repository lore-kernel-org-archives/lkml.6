Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753336AbeCPJjk (ORCPT <rfc822;w@1wt.eu>);
        Fri, 16 Mar 2018 05:39:40 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:45324 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753283AbeCPJjh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Mar 2018 05:39:37 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 198C660F5C
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=sricharan@codeaurora.org
From: Sricharan R <sricharan@codeaurora.org>
To: robh+dt@kernel.org, robh@kernel.org, mark.rutland@arm.com,
        linux@armlinux.org.uk, andy.gross@linaro.org, david.brown@linaro.org,
        catalin.marinas@arm.com, will.deacon@arm.com, sboyd@codeaurora.org,
        bjorn.andersson@linaro.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org,
        absahu@codeaurora.org
Cc: sricharan@codeaurora.org
Subject: [PATCH v2 09/13] ARM: dts: ipq4019: Add qcom-ipq4019-ap.dk07.1-c1 board file
Date: Fri, 16 Mar 2018 15:08:17 +0530
Message-Id: <1521193101-4586-10-git-send-email-sricharan@codeaurora.org>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1521193101-4586-1-git-send-email-sricharan@codeaurora.org>
References: <1521193101-4586-1-git-send-email-sricharan@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Sricharan R <sricharan@codeaurora.org>
---
 arch/arm/boot/dts/Makefile                      |  1 +
 arch/arm/boot/dts/qcom-ipq4019-ap.dk07.1-c1.dts | 65 +++++++++++++++++++++++++
 2 files changed, 66 insertions(+)
 create mode 100644 arch/arm/boot/dts/qcom-ipq4019-ap.dk07.1-c1.dts

diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index b71487a..8c93fd0 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -749,6 +749,7 @@ dtb-$(CONFIG_ARCH_QCOM) += \
 	qcom-ipq4019-ap.dk01.1-c1.dtb \
 	qcom-ipq4019-ap.dk04.1-c1.dtb \
 	qcom-ipq4019-ap.dk04.1-c3.dtb \
+	qcom-ipq4019-ap.dk07.1-c1.dtb \
 	qcom-ipq8064-ap148.dtb \
 	qcom-msm8660-surf.dtb \
 	qcom-msm8960-cdp.dtb \
diff --git a/arch/arm/boot/dts/qcom-ipq4019-ap.dk07.1-c1.dts b/arch/arm/boot/dts/qcom-ipq4019-ap.dk07.1-c1.dts
new file mode 100644
index 0000000..4562f7f
--- /dev/null
+++ b/arch/arm/boot/dts/qcom-ipq4019-ap.dk07.1-c1.dts
@@ -0,0 +1,65 @@
+// SPDX-License-Identifier: GPL-2.0
+// Copyright (c) 2018, The Linux Foundation. All rights reserved.
+
+#include "qcom-ipq4019-ap.dk07.1.dtsi"
+
+/ {
+	model = "Qualcomm Technologies, Inc. IPQ40xx/AP-DK07.1-C1";
+
+	soc {
+		pcie0: pci@40000000 {
+			status = "ok";
+			perst-gpio = <&tlmm 38 0x1>;
+		};
+
+		spi_1: spi@78b6000 { /* BLSP1 QUP2 */
+			status = "ok";
+		};
+
+		pinctrl@1000000 {
+			serial_1_pins: serial1_pinmux {
+				mux {
+					pins = "gpio8", "gpio9",
+						"gpio10", "gpio11";
+					function = "blsp_uart1";
+					bias-disable;
+				};
+			};
+
+			spi_0_pins: spi_0_pinmux {
+				pinmux {
+					function = "blsp_spi0";
+					pins = "gpio13", "gpio14", "gpio15";
+					bias-disable;
+				};
+				pinmux_cs {
+					function = "gpio";
+					pins = "gpio12";
+					bias-disable;
+					output-high;
+				};
+			};
+		};
+
+		serial@78b0000 {
+			pinctrl-0 = <&serial_1_pins>;
+			pinctrl-names = "default";
+			status = "ok";
+		};
+
+		spi_0: spi@78b5000 { /* BLSP1 QUP1 */
+			pinctrl-0 = <&spi_0_pins>;
+			pinctrl-names = "default";
+			status = "ok";
+			cs-gpios = <&tlmm 12 0>;
+
+			m25p80@0 {
+				#address-cells = <1>;
+				#size-cells = <1>;
+				reg = <0>;
+				compatible = "n25q128a11";
+				spi-max-frequency = <24000000>;
+			};
+		};
+	};
+};
-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, hosted by The Linux Foundation
