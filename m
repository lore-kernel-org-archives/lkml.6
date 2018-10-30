Return-Path: <SRS0=BpFy=NK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D34B0C6786F
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 10:11:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 90EA220831
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 10:11:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="dsEdygTe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 90EA220831
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727240AbeJ3TEV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Oct 2018 15:04:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:42610 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726451AbeJ3TEU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Oct 2018 15:04:20 -0400
Received: from localhost.localdomain (unknown [171.61.91.108])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1E80920831;
        Tue, 30 Oct 2018 10:11:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1540894291;
        bh=pQhNxRhYAK831fNtJ1aV1KR2yptfQes3Nt5An3LbfTg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=dsEdygTeBW0zTvNav3cK9YM+VpKHT0LY1fkqJckCrTeZZZwJpY8O/Hx/avQEIH9ln
         esf1gEthZeFOUPWxdbpy+B5gwIHy+AQ6JkTYQqbHLXl1U8wWLbwEAAe2Nly5M7oqOz
         eiFNlhXjRx5fzVBcrF8jWrW5nmBb1raZ+L7tvp+Y=
From:   Vinod Koul <vkoul@kernel.org>
To:     Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Vinod Koul <vkoul@kernel.org>
Subject: [PATCH 01/17] arm64: dts: qcom: qcs404: add base dts files
Date:   Tue, 30 Oct 2018 15:40:52 +0530
Message-Id: <20181030101108.11041-2-vkoul@kernel.org>
X-Mailer: git-send-email 2.14.4
In-Reply-To: <20181030101108.11041-1-vkoul@kernel.org>
References: <20181030101108.11041-1-vkoul@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add base dts files for QCS404 chipset along with cpu, timer,
gcc and uart2 nodes.

Signed-off-by: Vinod Koul <vkoul@kernel.org>
---
 arch/arm64/boot/dts/qcom/Makefile       |   1 +
 arch/arm64/boot/dts/qcom/qcs404-evb.dts |  21 ++++
 arch/arm64/boot/dts/qcom/qcs404.dtsi    | 175 ++++++++++++++++++++++++++++++++
 3 files changed, 197 insertions(+)
 create mode 100644 arch/arm64/boot/dts/qcom/qcs404-evb.dts
 create mode 100644 arch/arm64/boot/dts/qcom/qcs404.dtsi

diff --git a/arch/arm64/boot/dts/qcom/Makefile b/arch/arm64/boot/dts/qcom/Makefile
index a658c07652a7..3dffa0f58468 100644
--- a/arch/arm64/boot/dts/qcom/Makefile
+++ b/arch/arm64/boot/dts/qcom/Makefile
@@ -8,3 +8,4 @@ dtb-$(CONFIG_ARCH_QCOM)	+= msm8994-angler-rev-101.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= msm8996-mtp.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= msm8998-mtp.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= sdm845-mtp.dtb
+dtb-$(CONFIG_ARCH_QCOM)	+= qcs404-evb.dtb
diff --git a/arch/arm64/boot/dts/qcom/qcs404-evb.dts b/arch/arm64/boot/dts/qcom/qcs404-evb.dts
new file mode 100644
index 000000000000..74dc09ddb0d2
--- /dev/null
+++ b/arch/arm64/boot/dts/qcom/qcs404-evb.dts
@@ -0,0 +1,21 @@
+// SPDX-License-Identifier: GPL-2.0
+// Copyright (c) 2018, Linaro Limited
+
+// QCS EVB DTS
+
+/dts-v1/;
+
+#include "qcs404.dtsi"
+
+/ {
+	model = "Qualcomm Technologies, Inc. QCS404 EVB 1000";
+	compatible = "qcom,qcs404-evb";
+
+	aliases {
+		serial0 = &blsp1_uart2;
+	};
+
+	chosen {
+		stdout-path = "serial0";
+	};
+};
diff --git a/arch/arm64/boot/dts/qcom/qcs404.dtsi b/arch/arm64/boot/dts/qcom/qcs404.dtsi
new file mode 100644
index 000000000000..1bfc272b70e2
--- /dev/null
+++ b/arch/arm64/boot/dts/qcom/qcs404.dtsi
@@ -0,0 +1,175 @@
+// SPDX-License-Identifier: GPL-2.0
+// Copyright (c) 2018, Linaro Limited
+
+#include <dt-bindings/interrupt-controller/arm-gic.h>
+#include <dt-bindings/clock/qcom,gcc-qcs404.h>
+
+/ {
+	interrupt-parent = <&intc>;
+
+	#address-cells = <2>;
+	#size-cells = <2>;
+
+	chosen { };
+
+	memory@80000000 {
+		device_type = "memory";
+		/* We expect the bootloader to fill in the reg */
+		reg = <0 0x0 0 0>;
+	};
+
+	cpus {
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		CPU0: cpu@0 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a53";
+			reg = <0x100>;
+			enable-method = "psci";
+			next-level-cache = <&L2_0>;
+		};
+
+		CPU1: cpu@1 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a53";
+			reg = <0x101>;
+			enable-method = "psci";
+			next-level-cache = <&L2_0>;
+		};
+
+		CPU2: cpu@2 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a53";
+			reg = <0x102>;
+			enable-method = "psci";
+			next-level-cache = <&L2_0>;
+		};
+
+		CPU3: cpu@3 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a53";
+			reg = <0x100>;
+			enable-method = "psci";
+			next-level-cache = <&L2_0>;
+		};
+
+		L2_0: l2-cache {
+			compatible = "cache";
+			cache-level = <2>;
+		};
+	};
+
+	psci {
+		compatible = "arm,psci-1.0";
+		method = "smc";
+	};
+
+	timer {
+		compatible = "arm,armv8-timer";
+		interrupts = <GIC_PPI 2 0xff08>,
+			     <GIC_PPI 3 0xff08>,
+			     <GIC_PPI 4 0xff08>,
+			     <GIC_PPI 1 0xff08>;
+	};
+
+	clocks {
+		xo_board: xo_board {
+			compatible = "fixed-clock";
+			#clock-cells = <0>;
+			clock-frequency = <19200000>;
+		};
+	};
+
+	soc: soc@0 {
+		#address-cells = <1>;
+		#size-cells = <1>;
+		ranges = <0 0 0 0xffffffff>;
+		compatible = "simple-bus";
+
+		intc: interrupt-controller@b000000 {
+			compatible = "qcom,msm-qgic2";
+			interrupt-controller;
+			#interrupt-cells = <3>;
+			reg = <0x0b000000 0x1000>,
+			      <0x0b002000 0x1000>;
+		};
+
+		gcc: clock-controller@1800000 {
+			compatible = "qcom,gcc-qcs404";
+			reg = <0x1800000 0x80000>;
+			#clock-cells = <1>;
+
+			assigned-clocks = <&gcc GCC_APSS_AHB_CLK_SRC>;
+			assigned-clock-rates = <19200000>;
+		};
+
+		timer@b120000 {
+			#address-cells = <1>;
+			#size-cells = <1>;
+			ranges;
+			compatible = "arm,armv7-timer-mem";
+			reg = <0xb120000 0x1000>;
+			clock-frequency = <19200000>;
+
+			frame@b121000 {
+				frame-number = <0>;
+				interrupts = <GIC_SPI 8 IRQ_TYPE_LEVEL_HIGH>,
+					     <GIC_SPI 7 IRQ_TYPE_LEVEL_HIGH>;
+				reg = <0xb121000 0x1000>,
+				      <0xb122000 0x1000>;
+			};
+
+			frame@b123000 {
+				frame-number = <1>;
+				interrupts = <GIC_SPI 9 IRQ_TYPE_LEVEL_HIGH>;
+				reg = <0xb123000 0x1000>;
+				status = "disabled";
+			};
+
+			frame@b124000 {
+				frame-number = <2>;
+				interrupts = <GIC_SPI 10 IRQ_TYPE_LEVEL_HIGH>;
+				reg = <0xb124000 0x1000>;
+				status = "disabled";
+			};
+
+			frame@b125000 {
+				frame-number = <3>;
+				interrupts = <GIC_SPI 11 IRQ_TYPE_LEVEL_HIGH>;
+				reg = <0xb125000 0x1000>;
+				status = "disabled";
+			};
+
+			frame@b126000 {
+				frame-number = <4>;
+				interrupts = <GIC_SPI 12 IRQ_TYPE_LEVEL_HIGH>;
+				reg = <0xb126000 0x1000>;
+				status = "disabled";
+			};
+
+			frame@b127000 {
+				frame-number = <5>;
+				interrupts = <GIC_SPI 13 IRQ_TYPE_LEVEL_HIGH>;
+				reg = <0xb127000 0x1000>;
+				status = "disabled";
+			};
+
+			frame@b128000 {
+				frame-number = <6>;
+				interrupts = <GIC_SPI 14 IRQ_TYPE_LEVEL_HIGH>;
+				reg = <0xb128000 0x1000>;
+				status = "disabled";
+			};
+		};
+
+		blsp1_uart2: serial@78b1000 {
+			compatible = "qcom,msm-uartdm-v1.4", "qcom,msm-uartdm";
+			reg = <0x78b1000 0x200>;
+			interrupts = <GIC_SPI 118 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&gcc GCC_BLSP1_UART2_APPS_CLK>, <&gcc GCC_BLSP1_AHB_CLK>;
+			clock-names = "core", "iface";
+			status = "okay";
+		};
+	};
+};
-- 
2.14.4

