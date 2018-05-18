Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753342AbeERIUe (ORCPT <rfc822;w@1wt.eu>);
        Fri, 18 May 2018 04:20:34 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:49602 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753266AbeERIU2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 May 2018 04:20:28 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 4F3F9610D8
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=sricharan@codeaurora.org
From: Sricharan R <sricharan@codeaurora.org>
To: robh+dt@kernel.org, robh@kernel.org, mark.rutland@arm.com,
        linux@armlinux.org.uk, andy.gross@linaro.org, david.brown@linaro.org,
        catalin.marinas@arm.com, will.deacon@arm.com, sboyd@codeaurora.org,
        bjorn.andersson@linaro.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org,
        absahu@codeaurora.org, marc.zyngier@arm.com, richardcochran@gmail.com,
        sricharan@codeaurora.org
Subject: [PATCH V7 07/12] ARM: dts: ipq4019: Add ipq4019-ap.dk07.1 common data
Date: Fri, 18 May 2018 13:49:20 +0530
Message-Id: <1526631565-9972-8-git-send-email-sricharan@codeaurora.org>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1526631565-9972-1-git-send-email-sricharan@codeaurora.org>
References: <1526631565-9972-1-git-send-email-sricharan@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the common data for all dk07 based boards.

Reviewed-by: Abhishek Sahu <absahu@codeaurora.org>
Signed-off-by: Sricharan R <sricharan@codeaurora.org>
---
 arch/arm/boot/dts/qcom-ipq4019-ap.dk07.1.dtsi | 75 +++++++++++++++++++++++++++
 1 file changed, 75 insertions(+)
 create mode 100644 arch/arm/boot/dts/qcom-ipq4019-ap.dk07.1.dtsi

diff --git a/arch/arm/boot/dts/qcom-ipq4019-ap.dk07.1.dtsi b/arch/arm/boot/dts/qcom-ipq4019-ap.dk07.1.dtsi
new file mode 100644
index 0000000..9f1a5a66
--- /dev/null
+++ b/arch/arm/boot/dts/qcom-ipq4019-ap.dk07.1.dtsi
@@ -0,0 +1,75 @@
+// SPDX-License-Identifier: GPL-2.0
+// Copyright (c) 2018, The Linux Foundation. All rights reserved.
+
+#include "qcom-ipq4019.dtsi"
+#include <dt-bindings/input/input.h>
+#include <dt-bindings/gpio/gpio.h>
+
+/ {
+	model = "Qualcomm Technologies, Inc. IPQ4019/AP-DK07.1";
+
+	memory {
+		device_type = "memory";
+		reg = <0x80000000 0x20000000>; /* 512MB */
+	};
+
+	aliases {
+		serial0 = &blsp1_uart1;
+		serial1 = &blsp1_uart2;
+	};
+
+	chosen {
+		stdout-path = "serial0:115200n8";
+	};
+
+	soc {
+		pinctrl@1000000 {
+			serial_0_pins: serial0-pinmux {
+				pins = "gpio16", "gpio17";
+				function = "blsp_uart0";
+				bias-disable;
+			};
+
+			i2c_0_pins: i2c-0-pinmux {
+				pins = "gpio20", "gpio21";
+				function = "blsp_i2c0";
+				bias-disable;
+			};
+
+			nand_pins: nand-pins {
+				pins = "gpio53", "gpio55", "gpio56",
+				       "gpio57", "gpio58", "gpio59",
+				       "gpio60", "gpio62", "gpio63",
+				       "gpio64", "gpio65", "gpio66",
+				       "gpio67", "gpio68", "gpio69";
+				function = "qpic";
+                        };
+		};
+
+		serial@78af000 {
+			pinctrl-0 = <&serial_0_pins>;
+			pinctrl-names = "default";
+			status = "ok";
+		};
+
+		dma@7884000 {
+			status = "ok";
+		};
+
+		i2c@78b7000 { /* BLSP1 QUP2 */
+			pinctrl-0 = <&i2c_0_pins>;
+			pinctrl-names = "default";
+			status = "ok";
+		};
+
+		dma@7984000 {
+			status = "ok";
+		};
+
+		qpic-nand@79b0000 {
+			pinctrl-0 = <&nand_pins>;
+			pinctrl-names = "default";
+			status = "ok";
+		};
+	};
+};
-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, hosted by The Linux Foundation
