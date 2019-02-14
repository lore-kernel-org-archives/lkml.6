Return-Path: <SRS0=fxkz=QV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69C95C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 23:20:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 440DE21928
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 23:20:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388264AbfBNXUH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Feb 2019 18:20:07 -0500
Received: from mailgw02.mediatek.com ([210.61.82.184]:39419 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728789AbfBNXUA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Feb 2019 18:20:00 -0500
X-UUID: 8ecc2dbf87d64b94b4f8858a697faf2b-20190215
X-UUID: 8ecc2dbf87d64b94b4f8858a697faf2b-20190215
Received: from mtkcas06.mediatek.inc [(172.21.101.30)] by mailgw02.mediatek.com
        (envelope-from <sean.wang@mediatek.com>)
        (mhqrelay.mediatek.com ESMTP with TLS)
        with ESMTP id 1945842484; Fri, 15 Feb 2019 07:19:50 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 mtkmbs01n2.mediatek.inc (172.21.101.79) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Fri, 15 Feb 2019 07:19:42 +0800
Received: from mtkswgap22.mediatek.inc (172.21.77.33) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Fri, 15 Feb 2019 07:19:42 +0800
From:   <sean.wang@mediatek.com>
To:     <robh+dt@kernel.org>, <mark.rutland@arm.com>,
        <marcel@holtmann.org>, <johan.hedberg@gmail.com>
CC:     <devicetree@vger.kernel.org>, <linux-bluetooth@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, Sean Wang <sean.wang@mediatek.com>
Subject: [PATCH 1/6] dt-bindings: net: bluetooth: add support for MediaTek MT7663U and MT7668U UART devices
Date:   Fri, 15 Feb 2019 07:19:33 +0800
Message-ID: <c31b9ed0f2c711f53ad88c96f2d0a1bd22d9de58.1550184473.git.sean.wang@mediatek.com>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <cover.1550184473.git.sean.wang@mediatek.com>
References: <cover.1550184473.git.sean.wang@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: D779B2618311713CB527479DA034E29B1828AC39E163F6697A3287C8909486902000:8
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sean Wang <sean.wang@mediatek.com>

Update binding document with adding support of MT7663U and MT7668U UART
devices to mediatek-bluetooth.

Signed-off-by: Sean Wang <sean.wang@mediatek.com>
---
 .../bindings/net/mediatek-bluetooth.txt       | 64 +++++++++++++++++++
 1 file changed, 64 insertions(+)

diff --git a/Documentation/devicetree/bindings/net/mediatek-bluetooth.txt b/Documentation/devicetree/bindings/net/mediatek-bluetooth.txt
index 14ceb2a5b4e8..41a7dcc80f5b 100644
--- a/Documentation/devicetree/bindings/net/mediatek-bluetooth.txt
+++ b/Documentation/devicetree/bindings/net/mediatek-bluetooth.txt
@@ -33,3 +33,67 @@ Example:
 			clock-names = "ref";
 		};
 	};
+
+MediaTek UART based Bluetooth Devices
+==================================
+
+This device is a serial attached device to UART device and thus it must be a
+child node of the serial node with UART.
+
+Please refer to the following documents for generic properties:
+
+	Documentation/devicetree/bindings/serial/slave-device.txt
+
+Required properties:
+
+- compatible:	Must be
+		  "mediatek,mt7663u-bluetooth": for MT7663U device
+		  "mediatek,mt7668u-bluetooth": for MT7668U device
+- vcc-supply:	Main voltage regulator
+- pinctrl-names: Should be "default", "runtime"
+- pinctrl-0: Should contain UART RXD low when the device is powered up to
+	     enter proper bootstrap mode.
+- pinctrl-1: Should contain UART mode pin ctrl
+
+Optional properties:
+
+- reset-gpios:	GPIO used to reset the device whose initial state keeps low,
+		if the GPIO is missing, then board-level design should be
+		guaranteed.
+- current-speed:  Current baud rate of the device whose defaults to 921600
+
+Example:
+
+	uart1_pins_boot: uart1-default {
+		pins-dat {
+			pinmux = <MT7623_PIN_81_URXD1_FUNC_GPIO81>;
+			output-low;
+		};
+	};
+
+	uart1_pins_runtime: uart1-runtime {
+		pins-dat {
+			pinmux = <MT7623_PIN_81_URXD1_FUNC_URXD1>,
+				 <MT7623_PIN_82_UTXD1_FUNC_UTXD1>;
+		};
+	};
+
+	uart1: serial@11003000 {
+		compatible = "mediatek,mt7623-uart",
+			     "mediatek,mt6577-uart";
+		reg = <0 0x11003000 0 0x400>;
+		interrupts = <GIC_SPI 52 IRQ_TYPE_LEVEL_LOW>;
+		clocks = <&pericfg CLK_PERI_UART1_SEL>,
+			 <&pericfg CLK_PERI_UART1>;
+		clock-names = "baud", "bus";
+
+		bluetooth {
+			compatible = "mediatek,mt7663u-bluetooth";
+			vcc-supply = <&reg_5v>;
+			reset-gpios = <&pio 24 GPIO_ACTIVE_LOW>;
+			pinctrl-names = "default", "runtime";
+			pinctrl-0 = <&uart1_pins_boot>;
+			pinctrl-1 = <&uart1_pins_runtime>;
+			current-speed = <921600>;
+		};
+	};
-- 
2.18.0

