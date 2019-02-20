Return-Path: <SRS0=sczE=Q3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADEA0C4360F
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 10:34:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 75A8E20700
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 10:34:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="JbO5IoLH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727598AbfBTKes (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Feb 2019 05:34:48 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:34014 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727556AbfBTKep (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Feb 2019 05:34:45 -0500
Received: by mail-pl1-f195.google.com with SMTP id d15so4871554plr.1
        for <linux-kernel@vger.kernel.org>; Wed, 20 Feb 2019 02:34:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=+u7d9XYBQNeSXVdel6GJuhH8wUXXfIM6H4iGo0fZ/ak=;
        b=JbO5IoLHdiHtdsWfamBh7Tvxqe0XwvEvppak4WN9PRe+d9TqLvsaudzy1PTBrQEmPm
         ihqMOzjkuG07qK1Po7//nKilbRqgxFElENokKJWp8IfQzmxf4fr3RKoU0+i33PgZtR8K
         IuZJnVDRvuBVl2T91zVn1Zly3i8mmFEuiBm5M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=+u7d9XYBQNeSXVdel6GJuhH8wUXXfIM6H4iGo0fZ/ak=;
        b=WcJ6IOc/kEdx/xorK83eWYmx8cEWfsfRTgm/vW6CD+m5WKq1VifhqTKGasPT5HJbO2
         YPyZmezBfDBNKY2d6xjICmRex82fsWKHorzS1ow/gUCRhrvPx+Yx+6mWp+NWIiMPtgWh
         DdNenarm3wEYG1j+ro5XxzG1fuvDzCgKZXp92mmad9hUegisNKiDEzX3IW9+R2iCSlgd
         zJfJP5yOVzcwKwzqlPfbHFOe5PvrzB5kHhXZT3pLXTFbGNbK8NiR8HWpRE5txlUADUqm
         ml0M5uS6BabQI8+TcKihb6WvMqAaPQn49+BLxPRePcpVQ4NRKEns9E+SM1rRkPrntB1M
         krIw==
X-Gm-Message-State: AHQUAuaXsynld3INmHb1SU2QRb1LpQmVWPajuaarf1UDCUK/riK9f9dB
        o/2+lG7NUgxcViMKEHWUq0bv7GRV8VM=
X-Google-Smtp-Source: AHgI3IYnkllIu0k9VReVP2lyD0vtx6DGRQCPAXBNnhytZ6vSFBfd5rPVscCr1KaPjjocDjFfNdxOAg==
X-Received: by 2002:a17:902:f64:: with SMTP id 91mr35960517ply.132.1550658884685;
        Wed, 20 Feb 2019 02:34:44 -0800 (PST)
Received: from mannams-OptiPlex-7010.dhcp.broadcom.net ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id i71sm57426796pfi.170.2019.02.20.02.34.41
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 20 Feb 2019 02:34:43 -0800 (PST)
From:   Srinath Mannam <srinath.mannam@broadcom.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Kishon Vijay Abraham I <kishon@ti.com>
Cc:     Tejun Heo <tj@kernel.org>,
        Jayachandran C <jnair@caviumnetworks.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        bcm-kernel-feedback-list@broadcom.com,
        Srinath Mannam <srinath.mannam@broadcom.com>
Subject: [PATCH v4 3/3] arm64: dts: Add USB DT nodes for Stingray SoC
Date:   Wed, 20 Feb 2019 16:04:02 +0530
Message-Id: <1550658842-19167-4-git-send-email-srinath.mannam@broadcom.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1550658842-19167-1-git-send-email-srinath.mannam@broadcom.com>
References: <1550658842-19167-1-git-send-email-srinath.mannam@broadcom.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add DT nodes for
  - Two xHCI host controllers
  - Two BDC Broadcom USB device controller
  - Five USB PHY controllers

[xHCI0]      [BDC0]            [xHCI1]            [BDC1]
   |           |                  |                 |
  ---------------               -----------------------
   |           |                 |         |         |
[SS-PHY0]   [HS-PHY0]        [SS-PHY1] [HS-PHY2] [HS-PHY1]

[SS-PHY0/HS-PHY0] and [SS-PHY1/HS-PHY1] are combo PHYs has one SS and
one HS PHYs. [HS-PHY2] is a single HS PHY.

xHCI use SS-PHY to detect SS devices and HS-PHY to detect HS/FS/LS
devices. BDC use SS-PHY in SS mode and HS-PHY in HS mode.

xHCI0 port1 is SS-PHY0, port2 is HS-PHY0.
xHCI1 port1 is SS-PHY1, port2 is HS-PHY2 and port3 is HS-PHY1.

Signed-off-by: Srinath Mannam <srinath.mannam@broadcom.com>
Reviewed-by: Florian Fainelli <f.fainelli@gmail.com>
Reviewed-by: Scott Branden <scott.branden@broadcom.com>
---
 .../boot/dts/broadcom/stingray/stingray-usb.dtsi   | 95 ++++++++++++++++++++++
 .../arm64/boot/dts/broadcom/stingray/stingray.dtsi |  1 +
 2 files changed, 96 insertions(+)
 create mode 100644 arch/arm64/boot/dts/broadcom/stingray/stingray-usb.dtsi

diff --git a/arch/arm64/boot/dts/broadcom/stingray/stingray-usb.dtsi b/arch/arm64/boot/dts/broadcom/stingray/stingray-usb.dtsi
new file mode 100644
index 0000000..c0748ee
--- /dev/null
+++ b/arch/arm64/boot/dts/broadcom/stingray/stingray-usb.dtsi
@@ -0,0 +1,95 @@
+// SPDX-License-Identifier: (GPL-2.0 or BSD-3-Clause)
+/*
+ *Copyright(c) 2018 Broadcom
+ */
+	usb {
+		compatible = "simple-bus";
+		dma-ranges;
+		#address-cells = <1>;
+		#size-cells = <1>;
+		ranges = <0x0 0x0 0x68500000 0x00400000>;
+
+		usbphy0: usb-phy@0 {
+			compatible = "brcm,sr-usb-combo-phy";
+			reg = <0x00000000 0x100>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			status = "disabled";
+
+			usb0_phy0: phy@0 {
+				reg = <0>;
+				#phy-cells = <0>;
+			};
+			usb0_phy1: phy@1 {
+				reg = <1>;
+				#phy-cells = <0>;
+			};
+
+		};
+
+		xhci0: usb@1000 {
+			compatible = "generic-xhci";
+			reg = <0x00001000 0x1000>;
+			interrupts = <GIC_SPI 256 IRQ_TYPE_LEVEL_HIGH>;
+			phys = <&usb0_phy1>, <&usb0_phy0>;
+			phy-names = "phy0", "phy1";
+			dma-coherent;
+			status = "disabled";
+		};
+
+		bdc0: usb@2000 {
+			compatible = "brcm,bdc-v0.16";
+			reg = <0x00002000 0x1000>;
+			interrupts = <GIC_SPI 259 IRQ_TYPE_LEVEL_HIGH>;
+			phys = <&usb0_phy1>, <&usb0_phy0>;
+			phy-names = "phy0", "phy1";
+			dma-coherent;
+			status = "disabled";
+		};
+
+		usbphy1: usb-phy@10000 {
+			compatible = "brcm,sr-usb-combo-phy";
+			reg = <0x00010000 0x100>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			status = "disabled";
+
+			usb1_phy0: phy@0 {
+				reg = <0>;
+				#phy-cells = <0>;
+			};
+			usb1_phy1: phy@1 {
+				reg = <1>;
+				#phy-cells = <0>;
+			};
+		};
+
+		usbphy2: usb-phy@20000 {
+			compatible = "brcm,sr-usb-hs-phy";
+			reg = <0x00020000 0x100>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			#phy-cells = <0>;
+			status = "disabled";
+		};
+
+		xhci1: usb@11000 {
+			compatible = "generic-xhci";
+			reg = <0x00011000 0x1000>;
+			interrupts = <GIC_SPI 263 IRQ_TYPE_LEVEL_HIGH>;
+			phys = <&usb1_phy1>, <&usbphy2>, <&usb1_phy0>;
+			phy-names = "phy0", "phy1", "phy2";
+			dma-coherent;
+			status = "disabled";
+		};
+
+		bdc1: usb@21000 {
+			compatible = "brcm,bdc-v0.16";
+			reg = <0x00021000 0x1000>;
+			interrupts = <GIC_SPI 266 IRQ_TYPE_LEVEL_HIGH>;
+			phys = <&usbphy2>;
+			phy-names = "phy0";
+			dma-coherent;
+			status = "disabled";
+		};
+	};
diff --git a/arch/arm64/boot/dts/broadcom/stingray/stingray.dtsi b/arch/arm64/boot/dts/broadcom/stingray/stingray.dtsi
index cfeaa85..21dbb12 100644
--- a/arch/arm64/boot/dts/broadcom/stingray/stingray.dtsi
+++ b/arch/arm64/boot/dts/broadcom/stingray/stingray.dtsi
@@ -287,6 +287,7 @@
 	#include "stingray-fs4.dtsi"
 	#include "stingray-sata.dtsi"
 	#include "stingray-pcie.dtsi"
+	#include "stingray-usb.dtsi"
 
 	hsls {
 		compatible = "simple-bus";
-- 
2.7.4

