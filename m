Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S936063AbeEYGNQ (ORCPT <rfc822;w@1wt.eu>);
        Fri, 25 May 2018 02:13:16 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:57728 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935423AbeEYGNM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 May 2018 02:13:12 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 8D05160C65
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
Subject: [PATCH v8 09/12] ARM: dts: ipq4019: Add qcom-ipq4019-ap.dk07.1-c2 board file
Date: Fri, 25 May 2018 11:41:19 +0530
Message-Id: <1527228682-12285-10-git-send-email-sricharan@codeaurora.org>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1527228682-12285-1-git-send-email-sricharan@codeaurora.org>
References: <1527228682-12285-1-git-send-email-sricharan@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Reviewed-by: Abhishek Sahu <absahu@codeaurora.org>
Acked-by: Bjorn Andersson <bjorn.andersson@linaro.org>
Signed-off-by: Sricharan R <sricharan@codeaurora.org>
---
 arch/arm/boot/dts/Makefile                      |  1 +
 arch/arm/boot/dts/qcom-ipq4019-ap.dk07.1-c2.dts | 25 +++++++++++++++++++++++++
 2 files changed, 26 insertions(+)
 create mode 100644 arch/arm/boot/dts/qcom-ipq4019-ap.dk07.1-c2.dts

diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index 596cce3..02b7f1d 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -763,6 +763,7 @@ dtb-$(CONFIG_ARCH_QCOM) += \
 	qcom-ipq4019-ap.dk04.1-c1.dtb \
 	qcom-ipq4019-ap.dk04.1-c3.dtb \
 	qcom-ipq4019-ap.dk07.1-c1.dtb \
+	qcom-ipq4019-ap.dk07.1-c2.dtb \
 	qcom-ipq8064-ap148.dtb \
 	qcom-msm8660-surf.dtb \
 	qcom-msm8960-cdp.dtb \
diff --git a/arch/arm/boot/dts/qcom-ipq4019-ap.dk07.1-c2.dts b/arch/arm/boot/dts/qcom-ipq4019-ap.dk07.1-c2.dts
new file mode 100644
index 0000000..af7a902
--- /dev/null
+++ b/arch/arm/boot/dts/qcom-ipq4019-ap.dk07.1-c2.dts
@@ -0,0 +1,25 @@
+// SPDX-License-Identifier: GPL-2.0
+// Copyright (c) 2018, The Linux Foundation. All rights reserved.
+
+#include "qcom-ipq4019-ap.dk07.1.dtsi"
+
+/ {
+	model = "Qualcomm Technologies, Inc. IPQ4019/AP-DK07.1-C2";
+	compatible = "qcom,ipq4019-ap-dk07.1-c2";
+
+	soc {
+		pinctrl@1000000 {
+			serial_1_pins: serial1-pinmux {
+				pins = "gpio8", "gpio9";
+				function = "blsp_uart1";
+				bias-disable;
+			};
+		};
+
+		serial@78b0000 {
+			pinctrl-0 = <&serial_1_pins>;
+			pinctrl-names = "default";
+			status = "ok";
+		};
+	};
+};
-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, hosted by The Linux Foundation
