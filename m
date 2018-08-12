Return-Path: <SRS0=4YaO=K3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A56AC46460
	for <linux-kernel@archiver.kernel.org>; Sun, 12 Aug 2018 14:23:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AD78321A41
	for <linux-kernel@archiver.kernel.org>; Sun, 12 Aug 2018 14:23:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oOBP+Q/z"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AD78321A41
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728068AbeHLRB7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 12 Aug 2018 13:01:59 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:40367 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727801AbeHLRB7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Aug 2018 13:01:59 -0400
Received: by mail-pf1-f195.google.com with SMTP id e13-v6so6537080pff.7;
        Sun, 12 Aug 2018 07:23:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=COmVWli3xDiAXh1JOcjjcqo0dvdvAJdxWkbkpagkf7M=;
        b=oOBP+Q/z5Q3mcG6A3oY926TcQqSL690bHaOerb+gDKYEySMFLvZ1ZUASbi/6a8XLdN
         OrnrmjcDIyI5FB+jxowu+oEFG0QHlE2eDYIEq/tao2XgdRQU1iqEIReItaIAczawY08p
         NXi5O/irTCmT9L2ZYoOL5HVtWsepm+QnDOwADmrK0yjpS1Vy7qF8cwSLh5j+9fcILeJU
         jfD0bs9BRixmzu2JJOPW84nClpcrsiZRp4TLuz0alIYyxIJj8yiAtzEDHy+hNuwpQsGl
         3CzLLgJkEaUGhC4ybq6HoNSLrjkW0c7TCs8P05qjlUipCiAI7bnRDTrkKNSNZsW2XZS8
         pypw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=COmVWli3xDiAXh1JOcjjcqo0dvdvAJdxWkbkpagkf7M=;
        b=S9lj6+KphvWdqxmRCH0v/XsoUQBEqK9DHCfgo/Bw1k8GZoNF9vgx/AczOM7QvJ6rXx
         xylJo+8MnH9nBdOvPpfBapU2R2UH9hUHDnreQdVy+ZFDROEmKyFUDZtjFgrztzAi4evo
         /hef4l/iP5WprxfpQhwij1lZq5VpmdNx6u2odYGFEhD8Ju9Ibfxf7zdMxXVoUwROCLL6
         GE46tFe6ANcbnOiBSimAQfRutYKXq7SC4gwXfWKx7ltX8Oyi6zzmyVc+JAq4lJHRLZ6/
         qVdaQTTcf8QCR9Yh8iw8OR6lDunIBrU/lcxPeh0bn96Zg5x/EFJ4Rq9Dc0c+RMSxopAJ
         H+OA==
X-Gm-Message-State: AOUpUlEYS8AslxPjIcr53kiumuPkjUkVLT9MVHbcDr41jjZFQeduzJmC
        E0wJwBLavrZCg0HqJH83Vg==
X-Google-Smtp-Source: AA+uWPwiZnZPFyLKmhkS1GD2+682GUUKv5dNclV3X3Ja4rw+WyrcxAMS7MkyxQMeHDKctP6KfH8mrA==
X-Received: by 2002:a62:c699:: with SMTP id x25-v6mr15437045pfk.16.1534083826011;
        Sun, 12 Aug 2018 07:23:46 -0700 (PDT)
Received: from localhost.localdomain (host86-141-127-107.range86-141.btcentralplus.com. [86.141.127.107])
        by smtp.googlemail.com with ESMTPSA id 64-v6sm30782052pfi.89.2018.08.12.07.23.38
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 12 Aug 2018 07:23:45 -0700 (PDT)
From:   Craig Tatlor <ctatlor97@gmail.com>
Cc:     ctatlor97@gmail.com, linux-arm-msm@vger.kernel.org,
        Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>, linux-soc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH V2] arm64: dts: sdm630 SoC and Sony Pioneer (Xperia XA2) support
Date:   Sun, 12 Aug 2018 15:23:12 +0100
Message-Id: <20180812142317.19991-1-ctatlor97@gmail.com>
X-Mailer: git-send-email 2.18.0
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Initial device tree support for Qualcomm SDM630 SoC and
Sony Pioneer (Xperia XA2).

SDM630 is based off of the SDM660 soc and all SDM660 specific drivers are
compatible with it. SDM660 is also based off of MSM8998 so it uses some
of its drivers aswell.

The device tree is based on the CAF 4.4 kernel tree.

The device can be booted into the initrd with a shell over UART.

Signed-off-by: Craig Tatlor <ctatlor97@gmail.com>
---

Changes from v1:
   Adds gpio-ranges node to allow gpio-hogs to function


 arch/arm64/boot/dts/qcom/Makefile            |   1 +
 arch/arm64/boot/dts/qcom/sdm630-pins.dtsi    |  17 +
 arch/arm64/boot/dts/qcom/sdm630-pioneer.dts  |  16 +
 arch/arm64/boot/dts/qcom/sdm630-pioneer.dtsi |  22 ++
 arch/arm64/boot/dts/qcom/sdm630.dtsi         | 384 +++++++++++++++++++
 5 files changed, 439 insertions(+)
 create mode 100644 arch/arm64/boot/dts/qcom/sdm630-pins.dtsi
 create mode 100644 arch/arm64/boot/dts/qcom/sdm630-pioneer.dts
 create mode 100644 arch/arm64/boot/dts/qcom/sdm630-pioneer.dtsi
 create mode 100644 arch/arm64/boot/dts/qcom/sdm630.dtsi

diff --git a/arch/arm64/boot/dts/qcom/Makefile b/arch/arm64/boot/dts/qcom/Makefile
index 9319e74b8906..80f98bb19998 100644
--- a/arch/arm64/boot/dts/qcom/Makefile
+++ b/arch/arm64/boot/dts/qcom/Makefile
@@ -6,4 +6,5 @@ dtb-$(CONFIG_ARCH_QCOM)	+= msm8916-mtp.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= msm8992-bullhead-rev-101.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= msm8994-angler-rev-101.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= msm8996-mtp.dtb
+dtb-$(CONFIG_ARCH_QCOM)	+= sdm630-pioneer.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= sdm845-mtp.dtb
diff --git a/arch/arm64/boot/dts/qcom/sdm630-pins.dtsi b/arch/arm64/boot/dts/qcom/sdm630-pins.dtsi
new file mode 100644
index 000000000000..78b79c1076f1
--- /dev/null
+++ b/arch/arm64/boot/dts/qcom/sdm630-pins.dtsi
@@ -0,0 +1,17 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2018, Craig Tatlor. */
+
+&tlmm {
+	blsp1_uart1_default: blsp1_uart1_default {
+		pinmux {
+			pins = "gpio0", "gpio1", "gpio2", "gpio3";
+			function = "gpio";
+		};
+
+		pinconf {
+			pins = "gpio0", "gpio1", "gpio2", "gpio3";
+			drive-strength = <2>;
+			bias-disable;
+		};
+	};
+};
diff --git a/arch/arm64/boot/dts/qcom/sdm630-pioneer.dts b/arch/arm64/boot/dts/qcom/sdm630-pioneer.dts
new file mode 100644
index 000000000000..67c7e3b57739
--- /dev/null
+++ b/arch/arm64/boot/dts/qcom/sdm630-pioneer.dts
@@ -0,0 +1,16 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2018, Craig Tatlor. */
+
+/dts-v1/;
+
+#include "sdm630-pioneer.dtsi"
+
+/ {
+	model = "Sony Xperia XA2";
+	compatible = "sony,pioneer", "qcom,sdm630";
+
+	/* required for bootloader to select correct board */
+	qcom,board-id = <8 0>;
+	qcom,pmic-id = <0x0001001b 0x0101011a 0x0 0x0>,
+			<0x0001001b 0x0201011a 0x0 0x0>;
+};
diff --git a/arch/arm64/boot/dts/qcom/sdm630-pioneer.dtsi b/arch/arm64/boot/dts/qcom/sdm630-pioneer.dtsi
new file mode 100644
index 000000000000..512792c23369
--- /dev/null
+++ b/arch/arm64/boot/dts/qcom/sdm630-pioneer.dtsi
@@ -0,0 +1,22 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2018, Craig Tatlor. */
+
+#include "sdm630.dtsi"
+
+/ {
+	aliases {
+		serial0 = &blsp1_uart1;
+	};
+
+	chosen {
+		stdout-path = "serial0:115200n8";
+	};
+};
+
+&soc {
+	serial@c170000 {
+		status = "okay";
+		pinctrl-names = "default";
+		pinctrl-0 = <&blsp1_uart1_default>;
+	};
+};
diff --git a/arch/arm64/boot/dts/qcom/sdm630.dtsi b/arch/arm64/boot/dts/qcom/sdm630.dtsi
new file mode 100644
index 000000000000..8a544979b7c0
--- /dev/null
+++ b/arch/arm64/boot/dts/qcom/sdm630.dtsi
@@ -0,0 +1,384 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2018, Craig Tatlor. */
+
+#include <dt-bindings/interrupt-controller/arm-gic.h>
+#include <dt-bindings/clock/qcom,gcc-sdm660.h>
+
+/ {
+	model = "Qualcomm Technologies, Inc. SDM630";
+
+	interrupt-parent = <&intc>;
+
+	qcom,msm-id = <318 0x0>;
+
+	#address-cells = <2>;
+	#size-cells = <2>;
+
+	chosen { };
+
+	memory {
+		device_type = "memory";
+		/* We expect the bootloader to fill in the reg */
+		reg = <0 0 0 0>;
+	};
+
+
+	cpus {
+		#address-cells = <2>;
+		#size-cells = <0>;
+
+		CPU0: cpu@100 {
+			device_type = "cpu";
+			compatible = "arm,armv8";
+			reg = <0x0 0x100>;
+			enable-method = "psci";
+			efficiency = <1126>;
+			next-level-cache = <&L2_1>;
+			L2_1: l2-cache {
+				compatible = "arm,arch-cache";
+				cache-level = <2>;
+			};
+			L1_I_100: l1-icache {
+				compatible = "arm,arch-cache";
+			};
+			L1_D_100: l1-dcache {
+				compatible = "arm,arch-cache";
+			};
+		};
+
+		CPU1: cpu@101 {
+			device_type = "cpu";
+			compatible = "arm,armv8";
+			reg = <0x0 0x101>;
+			enable-method = "psci";
+			efficiency = <1126>;
+			next-level-cache = <&L2_1>;
+			L1_I_101: l1-icache {
+				compatible = "arm,arch-cache";
+			};
+			L1_D_101: l1-dcache {
+				compatible = "arm,arch-cache";
+			};
+		};
+
+		CPU2: cpu@102 {
+			device_type = "cpu";
+			compatible = "arm,armv8";
+			reg = <0x0 0x102>;
+			enable-method = "psci";
+			efficiency = <1126>;
+			next-level-cache = <&L2_1>;
+			L1_I_102: l1-icache {
+				compatible = "arm,arch-cache";
+			};
+			L1_D_102: l1-dcache {
+				compatible = "arm,arch-cache";
+			};
+		};
+
+		CPU3: cpu@103 {
+			device_type = "cpu";
+			compatible = "arm,armv8";
+			reg = <0x0 0x103>;
+			enable-method = "psci";
+			efficiency = <1126>;
+			next-level-cache = <&L2_1>;
+			L1_I_103: l1-icache {
+				compatible = "arm,arch-cache";
+			};
+			L1_D_103: l1-dcache {
+				compatible = "arm,arch-cache";
+			};
+		};
+
+		CPU4: cpu@0 {
+			device_type = "cpu";
+			compatible = "arm,armv8";
+			reg = <0x0 0x0>;
+			enable-method = "psci";
+			efficiency = <1024>;
+			next-level-cache = <&L2_0>;
+			L2_0: l2-cache {
+				compatible = "arm,arch-cache";
+				cache-level = <2>;
+			};
+			L1_I_0: l1-icache {
+				compatible = "arm,arch-cache";
+			};
+			L1_D_0: l1-dcache {
+				compatible = "arm,arch-cache";
+			};
+		};
+
+		CPU5: cpu@1 {
+			device_type = "cpu";
+			compatible = "arm,armv8";
+			reg = <0x0 0x1>;
+			enable-method = "psci";
+			efficiency = <1024>;
+			next-level-cache = <&L2_0>;
+			L1_I_1: l1-icache {
+				compatible = "arm,arch-cache";
+			};
+			L1_D_1: l1-dcache {
+				compatible = "arm,arch-cache";
+			};
+		};
+
+		CPU6: cpu@2 {
+			device_type = "cpu";
+			compatible = "arm,armv8";
+			reg = <0x0 0x2>;
+			enable-method = "psci";
+			efficiency = <1024>;
+			next-level-cache = <&L2_0>;
+			L1_I_2: l1-icache {
+				compatible = "arm,arch-cache";
+			};
+			L1_D_2: l1-dcache {
+				compatible = "arm,arch-cache";
+			};
+		};
+
+		CPU7: cpu@3 {
+			device_type = "cpu";
+			compatible = "arm,armv8";
+			reg = <0x0 0x3>;
+			enable-method = "psci";
+			efficiency = <1024>;
+			next-level-cache = <&L2_0>;
+			L1_I_3: l1-icache {
+				compatible = "arm,arch-cache";
+			};
+			L1_D_3: l1-dcache {
+				compatible = "arm,arch-cache";
+			};
+		};
+
+		cpu-map {
+			cluster0 {
+				core0 {
+					cpu = <&CPU4>;
+				};
+
+				core1 {
+					cpu = <&CPU5>;
+				};
+
+				core2 {
+					cpu = <&CPU6>;
+				};
+
+				core3 {
+					cpu = <&CPU7>;
+				};
+			};
+
+			cluster1 {
+				core0 {
+					cpu = <&CPU0>;
+				};
+
+				core1 {
+					cpu = <&CPU1>;
+				};
+
+				core2 {
+					cpu = <&CPU2>;
+				};
+
+				core3 {
+					cpu = <&CPU3>;
+				};
+			};
+		};
+	};
+
+	timer {
+		compatible = "arm,armv8-timer";
+		interrupts = <GIC_PPI 1 IRQ_TYPE_LEVEL_LOW>,
+			     <GIC_PPI 2 IRQ_TYPE_LEVEL_LOW>,
+			     <GIC_PPI 3 IRQ_TYPE_LEVEL_LOW>,
+			     <GIC_PPI 0 IRQ_TYPE_LEVEL_LOW>;
+	};
+
+	clocks {
+		xo_board {
+			compatible = "fixed-clock";
+			#clock-cells = <0>;
+			clock-frequency = <19200000>;
+			clock-output-names = "xo_board";
+		};
+
+		sleep_clk {
+			compatible = "fixed-clock";
+			#clock-cells = <0>;
+			clock-frequency = <32764>;
+			clock-output-names = "sleep_clk";
+		};
+	};
+
+	psci {
+		compatible = "arm,psci-1.0";
+		method = "smc";
+	};
+
+	firmware {
+		scm {
+			compatible = "qcom,scm-sdm660";
+		};
+	};
+
+
+	rpm-glink {
+		compatible = "qcom,glink-rpm";
+
+		interrupts = <GIC_SPI 168 IRQ_TYPE_EDGE_RISING>;
+
+		qcom,rpm-msg-ram = <&rpm_msg_ram>;
+
+		mboxes = <&apcs_glb 0>;
+	};
+
+	soc: soc {
+		#address-cells = <1>;
+		#size-cells = <1>;
+		ranges = <0 0 0 0xffffffff>;
+		compatible = "simple-bus";
+
+		intc: interrupt-controller@17a00000 {
+			compatible = "arm,gic-v3";
+			reg = <0x17a00000 0x10000>,
+			      <0x17b00000 0x100000>;
+			#interrupt-cells = <3>;
+			#address-cells = <1>;
+			#size-cells = <1>;
+			ranges;
+			interrupt-controller;
+			#redistributor-regions = <1>;
+			redistributor-stride = <0x0 0x20000>;
+			interrupts = <GIC_PPI 9 IRQ_TYPE_LEVEL_HIGH>;
+		};
+
+		gcc: clock-controller@100000 {
+			compatible = "qcom,gcc-sdm660";
+			#clock-cells = <1>;
+			#reset-cells = <1>;
+			#power-domain-cells = <1>;
+			reg = <0x100000 0x94000>;
+		};
+
+		tlmm: pinctrl@3000000 {
+			compatible = "qcom,sdm660-pinctrl";
+			reg = <0x3000000 0xc00000>;
+			interrupts = <GIC_SPI 208 IRQ_TYPE_LEVEL_HIGH>;
+			gpio-controller;
+			gpio-ranges = <&tlmm 0 0 114>;
+			#gpio-cells = <2>;
+			interrupt-controller;
+			#interrupt-cells = <2>;
+		};
+
+		blsp1_uart1: serial@c170000 {
+			compatible = "qcom,msm-uartdm-v1.4", "qcom,msm-uartdm";
+			reg = <0xc170000 0x1000>;
+			interrupts = <GIC_SPI 108 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&gcc GCC_BLSP1_UART2_APPS_CLK>,
+				 <&gcc GCC_BLSP1_AHB_CLK>;
+			clock-names = "core", "iface";
+			status = "disabled";
+		};
+
+		timer@17920000 {
+			#address-cells = <1>;
+			#size-cells = <1>;
+			ranges;
+			compatible = "arm,armv7-timer-mem";
+			reg = <0x17920000 0x1000>;
+
+			frame@17921000 {
+				frame-number = <0>;
+				interrupts = <GIC_SPI 8 IRQ_TYPE_LEVEL_HIGH>,
+					     <GIC_SPI 7 IRQ_TYPE_LEVEL_HIGH>;
+				reg = <0x17921000 0x1000>,
+				      <0x17922000 0x1000>;
+			};
+
+			frame@17923000 {
+				frame-number = <1>;
+				interrupts = <GIC_SPI 9 IRQ_TYPE_LEVEL_HIGH>;
+				reg = <0x17923000 0x1000>;
+				status = "disabled";
+			};
+
+			frame@17924000 {
+				frame-number = <2>;
+				interrupts = <GIC_SPI 10 IRQ_TYPE_LEVEL_HIGH>;
+				reg = <0x17924000 0x1000>;
+				status = "disabled";
+			};
+
+			frame@17925000 {
+				frame-number = <3>;
+				interrupts = <GIC_SPI 11 IRQ_TYPE_LEVEL_HIGH>;
+				reg = <0x17925000 0x1000>;
+				status = "disabled";
+			};
+
+			frame@17926000 {
+				frame-number = <4>;
+				interrupts = <GIC_SPI 12 IRQ_TYPE_LEVEL_HIGH>;
+				reg = <0x17926000 0x1000>;
+				status = "disabled";
+			};
+
+			frame@17927000 {
+				frame-number = <5>;
+				interrupts = <GIC_SPI 13 IRQ_TYPE_LEVEL_HIGH>;
+				reg = <0x17927000 0x1000>;
+				status = "disabled";
+			};
+
+			frame@17928000 {
+				frame-number = <6>;
+				interrupts = <GIC_SPI 14 IRQ_TYPE_LEVEL_HIGH>;
+				reg = <0x17928000 0x1000>;
+				status = "disabled";
+			};
+		};
+
+		spmi_bus: qcom,spmi@800f000 {
+			compatible = "qcom,spmi-pmic-arb";
+			reg =	<0x800f000 0x1000>,
+				<0x8400000 0x1000000>,
+				<0x9400000 0x1000000>,
+				<0xa400000 0x220000>,
+				<0x800a000 0x3000>;
+			reg-names = "core", "chnls", "obsrvr", "intr", "cnfg";
+			interrupt-names = "periph_irq";
+			interrupts = <GIC_SPI 326 IRQ_TYPE_LEVEL_HIGH>;
+			qcom,ee = <0>;
+			qcom,channel = <0>;
+			#address-cells = <2>;
+			#size-cells = <0>;
+			interrupt-controller;
+			#interrupt-cells = <4>;
+			cell-index = <0>;
+		};
+
+		rpm_msg_ram: memory@778000 {
+			compatible = "qcom,rpm-msg-ram";
+			reg = <0x778000 0x7000>;
+		};
+
+		apcs_glb: mailbox@17911000 {
+			compatible = "qcom,msm8998-apcs-hmss-global";
+			reg = <0x17911000 0x1000>;
+
+			#mbox-cells = <1>;
+		};
+
+	};
+};
+
+#include "sdm630-pins.dtsi"
-- 
2.18.0

