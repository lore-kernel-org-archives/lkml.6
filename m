Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751984AbeBHMYH (ORCPT <rfc822;w@1wt.eu>);
        Thu, 8 Feb 2018 07:24:07 -0500
Received: from lucky1.263xmail.com ([211.157.147.130]:44530 "EHLO
        lucky1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750806AbeBHMYG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Feb 2018 07:24:06 -0500
X-263anti-spam: KSV:0;
X-MAIL-GRAY: 1
X-MAIL-DELIVERY: 0
X-KSVirus-check: 0
X-ABS-CHECKED: 4
X-RL-SENDER: andy.yan@rock-chips.com
X-FST-TO: robh+dt@kernel.org
X-SENDER-IP: 58.22.7.114
X-LOGIN-NAME: andy.yan@rock-chips.com
X-UNIQUE-TAG: <7c028d2e0f72b760144530f71dd451f3>
X-ATTACHMENT-NUM: 0
X-DNS-TYPE: 0
From: Andy Yan <andy.yan@rock-chips.com>
To: robh+dt@kernel.org, shawn.lin@rock-chips.com, heiko@sntech.de
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Andy Yan <andy.yan@rock-chips.com>
Subject: [PATCH v8 3/3] ARM: dts: rockchip: enable sfc for rv1108 evb
Date: Thu,  8 Feb 2018 20:20:33 +0800
Message-Id: <1518092433-3893-1-git-send-email-andy.yan@rock-chips.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1518091958-3672-1-git-send-email-andy.yan@rock-chips.com>
References: <1518091958-3672-1-git-send-email-andy.yan@rock-chips.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enable the sfc support for rv1108 evaluation board.

Signed-off-by: Andy Yan <andy.yan@rock-chips.com>
---

Changes in v8: None
Changes in v7: None
Changes in v6: None
Changes in v5: None
Changes in v4: None
Changes in v3: None
Changes in v2: None

 arch/arm/boot/dts/rv1108-evb.dts | 10 ++++++++++
 arch/arm/boot/dts/rv1108.dtsi    | 13 +++++++++++++
 2 files changed, 23 insertions(+)

diff --git a/arch/arm/boot/dts/rv1108-evb.dts b/arch/arm/boot/dts/rv1108-evb.dts
index ac27e11..5d0ebe3 100644
--- a/arch/arm/boot/dts/rv1108-evb.dts
+++ b/arch/arm/boot/dts/rv1108-evb.dts
@@ -239,6 +239,16 @@
 	};
 };
 
+&sfc {
+	status = "okay";
+	spi-nor@0 {
+		compatible = "jedec,spi-nor";
+		spi-max-frequency = <100000000>;
+		m25p,fast-read;
+		reg = <0>;
+	};
+};
+
 &uart0 {
 	status = "okay";
 };
diff --git a/arch/arm/boot/dts/rv1108.dtsi b/arch/arm/boot/dts/rv1108.dtsi
index 76ea246..30435fc 100644
--- a/arch/arm/boot/dts/rv1108.dtsi
+++ b/arch/arm/boot/dts/rv1108.dtsi
@@ -554,6 +554,19 @@
 		status = "disabled";
 	};
 
+	sfc: sfc@301c0000 {
+		compatible = "rockchip,rv1108-sfc", "rockchip,sfc";
+		#address-cells = <1>;
+		#size-cells = <0>;
+		clocks = <&cru SCLK_SFC>, <&cru HCLK_SFC>;
+		clock-names = "sfc", "hsfc";
+		interrupts = <GIC_SPI 56 IRQ_TYPE_LEVEL_HIGH>;
+		reg = <0x301c0000 0x1000>;
+		/* If you want to use PIO mode, activate this */
+		/*rockchip,sfc-no-dma;*/
+		status = "disabled";
+	};
+
 	gic: interrupt-controller@32010000 {
 		compatible = "arm,gic-400";
 		interrupt-controller;
-- 
2.7.4
