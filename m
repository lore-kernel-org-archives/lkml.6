Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755049AbeCVNAP (ORCPT <rfc822;w@1wt.eu>);
        Thu, 22 Mar 2018 09:00:15 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:36852 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755030AbeCVNAK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Mar 2018 09:00:10 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org F265E60F72
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=sricharan@codeaurora.org
From: Sricharan R <sricharan@codeaurora.org>
To: robh+dt@kernel.org, robh@kernel.org, mark.rutland@arm.com,
        linux@armlinux.org.uk, andy.gross@linaro.org, david.brown@linaro.org,
        catalin.marinas@arm.com, will.deacon@arm.com, sboyd@codeaurora.org,
        bjorn.andersson@linaro.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org,
        absahu@codeaurora.org, marc.zyngier@arm.com, richardcochran@gmail.com
Cc: sricharan@codeaurora.org
Subject: [PATCH v4 08/13] ARM: dts: ipq4019: Add ipq4019-ap.dk07.1 common data
Date: Thu, 22 Mar 2018 18:28:47 +0530
Message-Id: <1521723532-28361-9-git-send-email-sricharan@codeaurora.org>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1521723532-28361-1-git-send-email-sricharan@codeaurora.org>
References: <1521723532-28361-1-git-send-email-sricharan@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the common data for all dk07 based boards.

Reviewed-by: Abhishek Sahu <absahu@codeaurora.org>
Signed-off-by: Sricharan R <sricharan@codeaurora.org>
---
 arch/arm/boot/dts/qcom-ipq4019-ap.dk07.1.dtsi | 68 +++++++++++++++++++++++++++
 1 file changed, 68 insertions(+)
 create mode 100644 arch/arm/boot/dts/qcom-ipq4019-ap.dk07.1.dtsi

diff --git a/arch/arm/boot/dts/qcom-ipq4019-ap.dk07.1.dtsi b/arch/arm/boot/dts/qcom-ipq4019-ap.dk07.1.dtsi
new file mode 100644
index 0000000..8072c8c
--- /dev/null
+++ b/arch/arm/boot/dts/qcom-ipq4019-ap.dk07.1.dtsi
@@ -0,0 +1,68 @@
+// SPDX-License-Identifier: GPL-2.0
+// Copyright (c) 2018, The Linux Foundation. All rights reserved.
+
+#include "qcom-ipq4019.dtsi"
+#include <dt-bindings/input/input.h>
+#include <dt-bindings/gpio/gpio.h>
+
+/ {
+	model = "Qualcomm Technologies, Inc. IPQ4019/AP-DK07.1";
+	compatible = "qcom,ipq4019";
+
+	memory {
+		device_type = "memory";
+		reg = <0x80000000 0x20000000>; /* 512MB */
+	};
+
+	aliases {
+		serial0 = &blsp1_uart1;
+	};
+
+	chosen {
+		stdout-path = "serial0:115200n8";
+	};
+
+	soc {
+		pinctrl@1000000 {
+			serial_0_pins: serial0_pinmux {
+				mux {
+					pins = "gpio16", "gpio17";
+					function = "blsp_uart0";
+					bias-disable;
+				};
+			};
+
+			i2c_0_pins: i2c_0_pinmux {
+				mux {
+					pins = "gpio20", "gpio21";
+					function = "blsp_i2c0";
+					bias-disable;
+				};
+			};
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
+			status = "ok";
+		};
+	};
+};
-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, hosted by The Linux Foundation
