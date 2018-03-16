Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753305AbeCPJjh (ORCPT <rfc822;w@1wt.eu>);
        Fri, 16 Mar 2018 05:39:37 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:45132 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752624AbeCPJje (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Mar 2018 05:39:34 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 8B13460F94
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
Subject: [PATCH v2 08/13] ARM: dts: ipq4019: Add ipq4019-ap.dk07.1 common data
Date: Fri, 16 Mar 2018 15:08:16 +0530
Message-Id: <1521193101-4586-9-git-send-email-sricharan@codeaurora.org>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1521193101-4586-1-git-send-email-sricharan@codeaurora.org>
References: <1521193101-4586-1-git-send-email-sricharan@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the common data for all dk07 based boards.

Signed-off-by: Sricharan R <sricharan@codeaurora.org>
---
 arch/arm/boot/dts/qcom-ipq4019-ap.dk07.1.dtsi | 83 +++++++++++++++++++++++++++
 1 file changed, 83 insertions(+)
 create mode 100644 arch/arm/boot/dts/qcom-ipq4019-ap.dk07.1.dtsi

diff --git a/arch/arm/boot/dts/qcom-ipq4019-ap.dk07.1.dtsi b/arch/arm/boot/dts/qcom-ipq4019-ap.dk07.1.dtsi
new file mode 100644
index 0000000..37a2ea8
--- /dev/null
+++ b/arch/arm/boot/dts/qcom-ipq4019-ap.dk07.1.dtsi
@@ -0,0 +1,83 @@
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
+	reserved-memory {
+		#address-cells = <1>;
+		#size-cells = <1>;
+		ranges;
+
+		rsvd1@87000000 {
+			/* Reserved for other subsystem */
+			reg = <0x87000000 0x500000>;
+			no-map;
+		};
+
+		wifi_dump@87500000 {
+			reg = <0x87500000 0x600000>;
+			no-map;
+		};
+
+		rsvd2@87B00000 {
+			/* Reserved for other subsystem */
+			reg = <0x87B00000 0x500000>;
+			no-map;
+		};
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
+		blsp_dma: dma@7884000 {
+			status = "ok";
+		};
+
+		i2c_0: i2c@78b7000 { /* BLSP1 QUP2 */
+			pinctrl-0 = <&i2c_0_pins>;
+			pinctrl-names = "default";
+			status = "ok";
+		};
+
+		qpic_bam: dma@7984000 {
+			status = "ok";
+		};
+
+		nand: qpic-nand@79b0000 {
+			status = "ok";
+		};
+	};
+};
-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, hosted by The Linux Foundation
