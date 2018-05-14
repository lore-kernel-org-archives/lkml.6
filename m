Return-Path: <linux-serial-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-616870-1526293472-2-10181590231299016772
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, MAILING_LIST_MULTI -1,
  ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5, UNPARSEABLE_RELAY 0.001,
  LANGUAGES unknown, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: 
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-serial-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1526293471; b=Z4LvGcCRkoytakjNMECk6GYijNUl995iN/IWOYPLca9eV9ZoFQ
    qGfN/WHh1qk2ru3+cJlm64UoAvM3A5Nz66zEptAjOTDZbSEqTRs8F8vCmlN6hdZV
    PXJY0VQCCoyet6+ut2p15kASs5pcfxRhs5jd6GG1QcpncaW4V0vK587RMa8E8cUl
    zd1BHPqXWK+LZMfO5EQ/KoEUYlFX3jRJrD2Xbitb6BY5EVoVngRzJw91kYI6wiLx
    kD04qlCw1k5E4J5rxQP/vcY9Eb+FuPG2JORMuFZilHdbWRMthAoXSNqq1oKE+dOt
    ak34uGnM8KI9nQniSKJEdhmF9sv5ptQr3t8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1526293471; bh=EAoUf+txZ6P6f5SaSJiGo+ETqE+FlW
    ptS6ivKTDSHyM=; b=DPzXUC0YyeIMBc17uaNg8qmZktfrR/8OF84mmBO6u0edJv
    M8loEm4RF7S7CC/Bpk6qnxb5p0ziqozoolcoEsooozilJqH2slVtLS9JEUpXemT8
    uG/khJb0orhFglOYloaevPqKUkP0rM75MAroGn+JHN/3/6G7IVi5XeQkcm7y+oiz
    aLtqsf5PlLpUr9SJkWY3TM2ruHgRmzMCM3Hvyii4dZylqhwKCN43+dHEL3DirsWP
    SW04L3O2ZT2uiapMBDYqvMrSVjd6ahlVlFQRy0bLEcFA6F8shjkF+IWsSkmL85hb
    v5x9dQE/+fy9gsuWRY7Ev9seSHBGKaeTI0RNdtgg==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=mediatek.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-serial-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=mediatek.com header.result=pass
    header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=mediatek.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-serial-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=mediatek.com header.result=pass
      header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfPa0ErY82x4uCnJglNb7WLuZMMipq/XoWfZSk+V20qw5oclmJnQtPb4aRsVs34tiSp5d76HR9YhR6s8IIDn/0HAnhcsDXpGAgxwTgpK16u0XGFOVhVAb
    52k8nKo+3NIdNx++Ueo2DR/BdhT5s3wpmlLP1iPJ19UwJqAsK1rlpO1CLOcth2zsaRCUuBQN/bszlkXemBiufvNhMuvXSfAgnXr253ZDmIM5tgFMmw5dsI8D
X-CM-Analysis: v=2.3 cv=Tq3Iegfh c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=VUJBJC2UJ8kA:10 a=mpaa-ttXAAAA:8
    a=VwQbUJbxAAAA:8 a=pwQyWRlSbx7vPP35DrAA:9 a=90v-eZSEv3Jdna-t:21
    a=97mjOwo2QYaU8JvS:21 a=x8gzFH9gYPwA:10 a=6heAxKwa5pAsJatQ0mat:22
    a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752097AbeENKXP (ORCPT <rfc822;greg@kroah.com>);
        Mon, 14 May 2018 06:23:15 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:40231 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1752104AbeENKXL (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Mon, 14 May 2018 06:23:11 -0400
X-UUID: 58003faf34074654be91500afb02a29c-20180514
From: Erin Lo <erin.lo@mediatek.com>
To: Matthias Brugger <matthias.bgg@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC: <devicetree@vger.kernel.org>,
        srv_heupstream <srv_heupstream@mediatek.com>,
        <linux-kernel@vger.kernel.org>, <linux-serial@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <yingjoe.chen@mediatek.com>, <erin.lo@mediatek.com>,
        <mars.cheng@mediatek.com>, Ben Ho <Ben.Ho@mediatek.com>
Subject: [PATCH v2 4/4] arm64: dts: Add Mediatek SoC MT8183 and evaluation board dts and Makefile
Date: Mon, 14 May 2018 18:22:31 +0800
Message-ID: <1526293351-32794-5-git-send-email-erin.lo@mediatek.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1526293351-32794-1-git-send-email-erin.lo@mediatek.com>
References: <1526293351-32794-1-git-send-email-erin.lo@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK: N
Sender: linux-serial-owner@vger.kernel.org
X-Mailing-List: linux-serial@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Ben Ho <Ben.Ho@mediatek.com>

Add basic chip support for Mediatek 8183

Signed-off-by: Ben Ho <Ben.Ho@mediatek.com>
Signed-off-by: Erin Lo <erin.lo@mediatek.com>
---
 arch/arm64/boot/dts/mediatek/Makefile       |   1 +
 arch/arm64/boot/dts/mediatek/mt8183-evb.dts |  31 +++++
 arch/arm64/boot/dts/mediatek/mt8183.dtsi    | 178 ++++++++++++++++++++++++++++
 3 files changed, 210 insertions(+)
 create mode 100644 arch/arm64/boot/dts/mediatek/mt8183-evb.dts
 create mode 100644 arch/arm64/boot/dts/mediatek/mt8183.dtsi

diff --git a/arch/arm64/boot/dts/mediatek/Makefile b/arch/arm64/boot/dts/mediatek/Makefile
index ac17f60..2836261 100644
--- a/arch/arm64/boot/dts/mediatek/Makefile
+++ b/arch/arm64/boot/dts/mediatek/Makefile
@@ -5,3 +5,4 @@ dtb-$(CONFIG_ARCH_MEDIATEK) += mt6795-evb.dtb
 dtb-$(CONFIG_ARCH_MEDIATEK) += mt6797-evb.dtb
 dtb-$(CONFIG_ARCH_MEDIATEK) += mt7622-rfb1.dtb
 dtb-$(CONFIG_ARCH_MEDIATEK) += mt8173-evb.dtb
+dtb-$(CONFIG_ARCH_MEDIATEK) += mt8183-evb.dtb
diff --git a/arch/arm64/boot/dts/mediatek/mt8183-evb.dts b/arch/arm64/boot/dts/mediatek/mt8183-evb.dts
new file mode 100644
index 0000000..9a3d6b7
--- /dev/null
+++ b/arch/arm64/boot/dts/mediatek/mt8183-evb.dts
@@ -0,0 +1,31 @@
+// SPDX-License-Identifier: (GPL-2.0 OR MIT)
+/*
+ * Copyright (c) 2017 MediaTek Inc.
+ * Author: Ben Ho <ben.ho@mediatek.com>
+ *	   Erin Lo <erin.lo@mediatek.com>
+ */
+
+/dts-v1/;
+#include "mt8183.dtsi"
+
+/ {
+	model = "MediaTek MT8183 evaluation board";
+	compatible = "mediatek,mt8183-evb", "mediatek,mt8183";
+
+	aliases {
+		serial0 = &uart0;
+	};
+
+	memory@40000000 {
+		device_type = "memory";
+		reg = <0 0x40000000 0 0x80000000>;
+	};
+
+	chosen {
+		stdout-path = "serial0:921600n8";
+	};
+};
+
+&uart0 {
+	status = "okay";
+};
diff --git a/arch/arm64/boot/dts/mediatek/mt8183.dtsi b/arch/arm64/boot/dts/mediatek/mt8183.dtsi
new file mode 100644
index 0000000..8564a26
--- /dev/null
+++ b/arch/arm64/boot/dts/mediatek/mt8183.dtsi
@@ -0,0 +1,178 @@
+// SPDX-License-Identifier: (GPL-2.0 OR MIT)
+/*
+ * Copyright (c) 2017 MediaTek Inc.
+ * Author: Ben Ho <ben.ho@mediatek.com>
+ *	   Erin Lo <erin.lo@mediatek.com>
+ */
+
+#include <dt-bindings/interrupt-controller/irq.h>
+#include <dt-bindings/interrupt-controller/arm-gic.h>
+
+/ {
+	compatible = "mediatek,mt8183";
+	interrupt-parent = <&sysirq>;
+	#address-cells = <2>;
+	#size-cells = <2>;
+
+	cpus {
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		cpu-map {
+			cluster0 {
+				core0 {
+					cpu = <&cpu0>;
+				};
+				core1 {
+					cpu = <&cpu1>;
+				};
+				core2 {
+					cpu = <&cpu2>;
+				};
+				core3 {
+					cpu = <&cpu3>;
+				};
+			};
+
+			cluster1 {
+				core0 {
+					cpu = <&cpu4>;
+				};
+				core1 {
+					cpu = <&cpu5>;
+				};
+				core2 {
+					cpu = <&cpu6>;
+				};
+				core3 {
+					cpu = <&cpu7>;
+				};
+			};
+		};
+
+		cpu0: cpu@000 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a53";
+			reg = <0x000>;
+			enable-method = "psci";
+		};
+
+		cpu1: cpu@001 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a53";
+			reg = <0x001>;
+			enable-method = "psci";
+		};
+
+		cpu2: cpu@002 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a53";
+			reg = <0x002>;
+			enable-method = "psci";
+		};
+
+		cpu3: cpu@003 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a53";
+			reg = <0x003>;
+			enable-method = "psci";
+		};
+
+		cpu4: cpu@100 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a73";
+			reg = <0x100>;
+			enable-method = "psci";
+		};
+
+		cpu5: cpu@101 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a73";
+			reg = <0x101>;
+			enable-method = "psci";
+		};
+
+		cpu6: cpu@102 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a73";
+			reg = <0x102>;
+			enable-method = "psci";
+		};
+
+		cpu7: cpu@103 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a73";
+			reg = <0x103>;
+			enable-method = "psci";
+		};
+	};
+
+	psci {
+		compatible      = "arm,psci-1.0";
+		method          = "smc";
+	};
+
+	uart_clk: dummy26m {
+		compatible = "fixed-clock";
+		clock-frequency = <26000000>;
+		#clock-cells = <0>;
+	};
+
+	timer {
+		compatible = "arm,armv8-timer";
+		interrupt-parent = <&gic>;
+		interrupts = <GIC_PPI 13 IRQ_TYPE_LEVEL_LOW>,
+			     <GIC_PPI 14 IRQ_TYPE_LEVEL_LOW>,
+			     <GIC_PPI 11 IRQ_TYPE_LEVEL_LOW>,
+			     <GIC_PPI 10 IRQ_TYPE_LEVEL_LOW>;
+	};
+
+	gic: interrupt-controller@0c000000 {
+		compatible = "arm,gic-v3";
+		#interrupt-cells = <3>;
+		interrupt-parent = <&gic>;
+		interrupt-controller;
+		reg = <0 0x0c000000 0 0x40000>,  // CID
+		      <0 0x0c100000 0 0x200000>; // CIR
+		interrupts = <GIC_PPI 9 IRQ_TYPE_LEVEL_HIGH>;
+	};
+
+	sysirq: intpol-controller@0c530a80 {
+		compatible = "mediatek,mt8183-sysirq",
+			     "mediatek,mt6577-sysirq";
+		interrupt-controller;
+		#interrupt-cells = <3>;
+		interrupt-parent = <&gic>;
+		reg = <0 0x0c530a80 0 0x50>;
+	};
+
+	uart0: serial@11002000 {
+		compatible = "mediatek,mt8183-uart",
+			     "mediatek,mt6577-uart";
+		reg = <0 0x11002000 0 0x1000>;
+		interrupts = <GIC_SPI 91 IRQ_TYPE_LEVEL_LOW>;
+		clocks = <&uart_clk>, <&uart_clk>;
+		clock-names = "baud", "bus";
+		status = "disabled";
+	};
+
+	uart1: serial@11003000 {
+		compatible = "mediatek,mt8183-uart",
+			     "mediatek,mt6577-uart";
+		reg = <0 0x11003000 0 0x1000>;
+		interrupts = <GIC_SPI 92 IRQ_TYPE_LEVEL_LOW>;
+		clocks = <&uart_clk>, <&uart_clk>;
+		clock-names = "baud", "bus";
+		status = "disabled";
+	};
+
+	uart2: serial@11004000 {
+		compatible = "mediatek,mt8183-uart",
+			     "mediatek,mt6577-uart";
+		reg = <0 0x11004000 0 0x1000>;
+		interrupts = <GIC_SPI 93 IRQ_TYPE_LEVEL_LOW>;
+		clocks = <&uart_clk>, <&uart_clk>;
+		clock-names = "baud", "bus";
+		status = "disabled";
+	};
+};
-- 
1.9.1

