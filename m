Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752296AbeEPRwE (ORCPT <rfc822;w@1wt.eu>);
        Wed, 16 May 2018 13:52:04 -0400
Received: from mail-yb0-f194.google.com ([209.85.213.194]:40799 "EHLO
        mail-yb0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752267AbeEPRwC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 May 2018 13:52:02 -0400
X-Google-Smtp-Source: AB8JxZokqClxRLV9CLChWh5cCLnV7grs4pHPAbCJ+Kfs0sUsThmRlpYRTOhxKBujoCpHemtzM1IxXw==
From: William Breathitt Gray <vilhelm.gray@gmail.com>
To: jic23@kernel.org
Cc: benjamin.gaignard@st.com, fabrice.gasnier@st.com,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        William Breathitt Gray <vilhelm.gray@gmail.com>
Subject: [PATCH v6 6/9] dt-bindings: counter: Document stm32 quadrature encoder
Date: Wed, 16 May 2018 13:51:55 -0400
Message-Id: <ccdbbfb2833d274b6bfa234aada57e68d9793dd5.1526487615.git.vilhelm.gray@gmail.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <cover.1526487615.git.vilhelm.gray@gmail.com>
References: <cover.1526487615.git.vilhelm.gray@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Benjamin Gaignard <benjamin.gaignard@st.com>

Add bindings for STM32 Timer quadrature encoder.
It is a sub-node of STM32 Timer which implement the
counter part of the hardware.

Cc: Rob Herring <robh+dt@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Signed-off-by: Benjamin Gaignard <benjamin.gaignard@st.com>
Signed-off-by: William Breathitt Gray <vilhelm.gray@gmail.com>
---
 .../bindings/counter/stm32-timer-cnt.txt      | 26 +++++++++++++++++++
 .../devicetree/bindings/mfd/stm32-timers.txt  |  7 +++++
 2 files changed, 33 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/counter/stm32-timer-cnt.txt

diff --git a/Documentation/devicetree/bindings/counter/stm32-timer-cnt.txt b/Documentation/devicetree/bindings/counter/stm32-timer-cnt.txt
new file mode 100644
index 000000000000..377728128bef
--- /dev/null
+++ b/Documentation/devicetree/bindings/counter/stm32-timer-cnt.txt
@@ -0,0 +1,26 @@
+STMicroelectronics STM32 Timer quadrature encoder
+
+STM32 Timer provides quadrature encoder counter mode to detect
+angular position and direction of rotary elements,
+from IN1 and IN2 input signals.
+
+Must be a sub-node of an STM32 Timer device tree node.
+See ../mfd/stm32-timers.txt for details about the parent node.
+
+Required properties:
+- compatible:		Must be "st,stm32-timer-counter".
+- pinctrl-names: 	Set to "default".
+- pinctrl-0: 		List of phandles pointing to pin configuration nodes,
+			to set IN1/IN2 pins in mode of operation for Low-Power
+			Timer input on external pin.
+
+Example:
+	timers@40010000  {
+		compatible = "st,stm32-timers";
+		...
+		counter {
+			compatible = "st,stm32-timer-counter";
+			pinctrl-names = "default";
+			pinctrl-0 = <&tim1_in_pins>;
+		};
+	};
diff --git a/Documentation/devicetree/bindings/mfd/stm32-timers.txt b/Documentation/devicetree/bindings/mfd/stm32-timers.txt
index 1db6e0057a63..ff9c14ada30b 100644
--- a/Documentation/devicetree/bindings/mfd/stm32-timers.txt
+++ b/Documentation/devicetree/bindings/mfd/stm32-timers.txt
@@ -23,6 +23,7 @@ Optional parameters:
 Optional subnodes:
 - pwm:			See ../pwm/pwm-stm32.txt
 - timer:		See ../iio/timer/stm32-timer-trigger.txt
+- counter:		See ../counter/stm32-timer-cnt.txt
 
 Example:
 	timers@40010000 {
@@ -43,4 +44,10 @@ Example:
 			compatible = "st,stm32-timer-trigger";
 			reg = <0>;
 		};
+
+		counter {
+			compatible = "st,stm32-timer-counter";
+			pinctrl-names = "default";
+			pinctrl-0 = <&tim1_in_pins>;
+		};
 	};
-- 
2.17.0
