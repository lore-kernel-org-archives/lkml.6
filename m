Return-Path: <SRS0=Grn6=OM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 448C6C04EB9
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 11:36:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0BEC720834
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 11:36:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0BEC720834
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mediatek.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726487AbeLCLhR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Dec 2018 06:37:17 -0500
Received: from mailgw02.mediatek.com ([210.61.82.184]:3307 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726425AbeLCLhR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Dec 2018 06:37:17 -0500
X-UUID: d22328657df249f18fdf5e9c8ff78795-20181203
X-UUID: d22328657df249f18fdf5e9c8ff78795-20181203
Received: from mtkmrs01.mediatek.inc [(172.21.131.159)] by mailgw02.mediatek.com
        (envelope-from <yt.shen@mediatek.com>)
        (mhqrelay.mediatek.com ESMTP with TLS)
        with ESMTP id 1376685759; Mon, 03 Dec 2018 19:36:28 +0800
Received: from mtkcas08.mediatek.inc (172.21.101.126) by
 mtkmbs03n2.mediatek.inc (172.21.101.182) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Mon, 3 Dec 2018 19:36:20 +0800
Received: from mtkslt301.mediatek.inc (10.21.14.114) by mtkcas08.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Mon, 3 Dec 2018 19:36:20 +0800
From:   YT Shen <yt.shen@mediatek.com>
To:     Matthias Brugger <matthias.bgg@gmail.com>
CC:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <srv_heupstream@mediatek.com>,
        Chunfeng Yun <chunfeng.yun@mediatek.com>
Subject: [PATCH 1/8] arm64: dts: Add USB3 related nodes for MT2712
Date:   Mon, 3 Dec 2018 19:35:55 +0800
Message-ID: <1543836962-18293-2-git-send-email-yt.shen@mediatek.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1543836962-18293-1-git-send-email-yt.shen@mediatek.com>
References: <1543836962-18293-1-git-send-email-yt.shen@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: F5F477937E8AA2AA19E356C8422B10103A832962DCE1682161467BC89E607AE32000:8
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Chunfeng Yun <chunfeng.yun@mediatek.com>

This patch adds USB3 related nodes for mt2712m1 platform.

Signed-off-by: Chunfeng Yun <chunfeng.yun@mediatek.com>
---
 arch/arm64/boot/dts/mediatek/mt2712-evb.dts |  98 ++++++++++++++++++++++
 arch/arm64/boot/dts/mediatek/mt2712e.dtsi   | 126 ++++++++++++++++++++++++++++
 2 files changed, 224 insertions(+)

diff --git a/arch/arm64/boot/dts/mediatek/mt2712-evb.dts b/arch/arm64/boot/dts/mediatek/mt2712-evb.dts
index 98d6275..1353dad 100644
--- a/arch/arm64/boot/dts/mediatek/mt2712-evb.dts
+++ b/arch/arm64/boot/dts/mediatek/mt2712-evb.dts
@@ -6,6 +6,7 @@
  */
 
 /dts-v1/;
+#include <dt-bindings/gpio/gpio.h>
 #include "mt2712e.dtsi"
 
 / {
@@ -41,6 +42,53 @@
 		regulator-max-microvolt = <1000000>;
 	};
 
+	extcon_usb: extcon_iddig {
+		compatible = "linux,extcon-usb-gpio";
+		id-gpio = <&pio 12 GPIO_ACTIVE_HIGH>;
+	};
+
+	extcon_usb1: extcon_iddig1 {
+		compatible = "linux,extcon-usb-gpio";
+		id-gpio = <&pio 14 GPIO_ACTIVE_HIGH>;
+	};
+
+	usb_p0_vbus: regulator@2 {
+		compatible = "regulator-fixed";
+		regulator-name = "p0_vbus";
+		regulator-min-microvolt = <5000000>;
+		regulator-max-microvolt = <5000000>;
+		gpio = <&pio 13 GPIO_ACTIVE_HIGH>;
+		enable-active-high;
+	};
+
+	usb_p1_vbus: regulator@3 {
+		compatible = "regulator-fixed";
+		regulator-name = "p1_vbus";
+		regulator-min-microvolt = <5000000>;
+		regulator-max-microvolt = <5000000>;
+		gpio = <&pio 15 GPIO_ACTIVE_HIGH>;
+		enable-active-high;
+	};
+
+	usb_p2_vbus: regulator@4 {
+		compatible = "regulator-fixed";
+		regulator-name = "p2_vbus";
+		regulator-min-microvolt = <5000000>;
+		regulator-max-microvolt = <5000000>;
+		gpio = <&pio 16 GPIO_ACTIVE_HIGH>;
+		enable-active-high;
+	};
+
+	usb_p3_vbus: regulator@5 {
+		compatible = "regulator-fixed";
+		regulator-name = "p3_vbus";
+		regulator-min-microvolt = <5000000>;
+		regulator-max-microvolt = <5000000>;
+		gpio = <&pio 17 GPIO_ACTIVE_HIGH>;
+		enable-active-high;
+		regulator-always-on;
+	};
+
 };
 
 &auxadc {
@@ -59,7 +107,57 @@
 	proc-supply = <&cpus_fixed_vproc1>;
 };
 
+&pio {
+	usb0_id_pins_float: usb0_iddig {
+		pins_iddig {
+			pinmux = <MT2712_PIN_12_IDDIG_P0__FUNC_IDDIG_A>;
+			bias-pull-up;
+		};
+	};
+
+	usb1_id_pins_float: usb1_iddig {
+		pins_iddig {
+			pinmux = <MT2712_PIN_14_IDDIG_P1__FUNC_IDDIG_B>;
+			bias-pull-up;
+		};
+	};
+};
+
+&ssusb {
+	vbus-supply = <&usb_p0_vbus>;
+	extcon = <&extcon_usb>;
+	dr_mode = "otg";
+	wakeup-source;
+	mediatek,u3p-dis-msk = <0x1>;
+	//enable-manual-drd;
+	//maximum-speed = "full-speed";
+	pinctrl-names = "default";
+	pinctrl-0 = <&usb0_id_pins_float>;
+	status = "okay";
+};
+
+&ssusb1 {
+	vbus-supply = <&usb_p1_vbus>;
+	extcon = <&extcon_usb1>;
+	dr_mode = "otg";
+	//mediatek,u3p-dis-msk = <0x1>;
+	enable-manual-drd;
+	wakeup-source;
+	//maximum-speed = "full-speed";
+	pinctrl-names = "default";
+	pinctrl-0 = <&usb1_id_pins_float>;
+	status = "okay";
+};
+
 &uart0 {
 	status = "okay";
 };
 
+&usb_host0 {
+	vbus-supply = <&usb_p2_vbus>;
+	status = "okay";
+};
+
+&usb_host1 {
+	status = "okay";
+};
diff --git a/arch/arm64/boot/dts/mediatek/mt2712e.dtsi b/arch/arm64/boot/dts/mediatek/mt2712e.dtsi
index ee627a7..6c228a2 100644
--- a/arch/arm64/boot/dts/mediatek/mt2712e.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt2712e.dtsi
@@ -8,6 +8,7 @@
 #include <dt-bindings/clock/mt2712-clk.h>
 #include <dt-bindings/interrupt-controller/irq.h>
 #include <dt-bindings/interrupt-controller/arm-gic.h>
+#include <dt-bindings/phy/phy.h>
 #include <dt-bindings/power/mt2712-power.h>
 #include "mt2712-pinfunc.h"
 
@@ -405,6 +406,131 @@
 		status = "disabled";
 	};
 
+	ssusb: usb@11271000 {
+		compatible = "mediatek,mt2712-mtu3", "mediatek,mtu3";
+		reg = <0 0x11271000 0 0x3000>,
+		      <0 0x11280700 0 0x0100>;
+		reg-names = "mac", "ippc";
+		interrupts = <GIC_SPI 122 IRQ_TYPE_LEVEL_LOW>;
+		phys = <&u2port0 PHY_TYPE_USB2>,
+		       <&u2port1 PHY_TYPE_USB2>;
+		power-domains = <&scpsys MT2712_POWER_DOMAIN_USB>;
+		clocks = <&topckgen CLK_TOP_USB30_SEL>;
+		clock-names = "sys_ck";
+		mediatek,syscon-wakeup = <&pericfg 0x510 2>;
+		#address-cells = <2>;
+		#size-cells = <2>;
+		ranges;
+		status = "disabled";
+
+		usb_host0: xhci@11270000 {
+			compatible = "mediatek,mt2712-xhci",
+				     "mediatek,mtk-xhci";
+			reg = <0 0x11270000 0 0x1000>;
+			reg-names = "mac";
+			interrupts = <GIC_SPI 123 IRQ_TYPE_LEVEL_LOW>;
+			power-domains = <&scpsys MT2712_POWER_DOMAIN_USB>;
+			clocks = <&topckgen CLK_TOP_USB30_SEL>, <&clk26m>;
+			clock-names = "sys_ck", "ref_ck";
+			status = "disabled";
+		};
+	};
+
+	u3phy0: usb-phy@11290000 {
+		compatible = "mediatek,mt2712-u3phy";
+		#address-cells = <2>;
+		#size-cells = <2>;
+		ranges;
+		status = "okay";
+
+		u2port0: usb-phy@11290000 {
+			reg = <0 0x11290000 0 0x700>;
+			clocks = <&clk26m>;
+			clock-names = "ref";
+			#phy-cells = <1>;
+			status = "okay";
+		};
+
+		u2port1: usb-phy@11298000 {
+			reg = <0 0x11298000 0 0x700>;
+			clocks = <&clk26m>;
+			clock-names = "ref";
+			#phy-cells = <1>;
+			status = "okay";
+		};
+
+		u3port0: usb-phy@11298700 {
+			reg = <0 0x11298700 0 0x900>;
+			clocks = <&clk26m>;
+			clock-names = "ref";
+			#phy-cells = <1>;
+			status = "okay";
+		};
+	};
+
+	ssusb1: usb@112c1000 {
+		compatible = "mediatek,mt2712-mtu3", "mediatek,mtu3";
+		reg = <0 0x112c1000 0 0x3000>,
+		      <0 0x112d0700 0 0x0100>;
+		reg-names = "mac", "ippc";
+		interrupts = <GIC_SPI 248 IRQ_TYPE_LEVEL_LOW>;
+		phys = <&u2port2 PHY_TYPE_USB2>,
+		       <&u2port3 PHY_TYPE_USB2>,
+		       <&u3port1 PHY_TYPE_USB3>;
+		power-domains = <&scpsys MT2712_POWER_DOMAIN_USB2>;
+		clocks = <&topckgen CLK_TOP_USB30_SEL>;
+		clock-names = "sys_ck";
+		mediatek,syscon-wakeup = <&pericfg 0x514 2>;
+		#address-cells = <2>;
+		#size-cells = <2>;
+		ranges;
+		status = "disabled";
+
+		usb_host1: xhci@112c0000 {
+			compatible = "mediatek,mt2712-xhci",
+				     "mediatek,mtk-xhci";
+			reg = <0 0x112c0000 0 0x1000>;
+			reg-names = "mac";
+			interrupts = <GIC_SPI 249 IRQ_TYPE_LEVEL_LOW>;
+			power-domains = <&scpsys MT2712_POWER_DOMAIN_USB2>;
+			clocks = <&topckgen CLK_TOP_USB30_SEL>, <&clk26m>;
+			clock-names = "sys_ck", "ref_ck";
+			status = "disabled";
+		};
+	};
+
+	u3phy1: usb-phy@112e0000 {
+		compatible = "mediatek,mt2712-u3phy";
+		#address-cells = <2>;
+		#size-cells = <2>;
+		ranges;
+		status = "okay";
+
+		u2port2: usb-phy@112e0000 {
+			reg = <0 0x112e0000 0 0x700>;
+			clocks = <&clk26m>;
+			clock-names = "ref";
+			#phy-cells = <1>;
+			status = "okay";
+		};
+
+		u2port3: usb-phy@112e8000 {
+			reg = <0 0x112e8000 0 0x700>;
+			clocks = <&clk26m>;
+			clock-names = "ref";
+			#phy-cells = <1>;
+			status = "okay";
+		};
+
+		u3port1: usb-phy@112e8700 {
+			reg = <0 0x112e8700 0 0x900>;
+			clocks = <&clk26m>;
+			clock-names = "ref";
+			#phy-cells = <1>;
+			status = "okay";
+		};
+	};
+
 	mfgcfg: syscon@13000000 {
 		compatible = "mediatek,mt2712-mfgcfg", "syscon";
 		reg = <0 0x13000000 0 0x1000>;
-- 
1.9.1

