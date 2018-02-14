Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1031644AbeBNUKN (ORCPT <rfc822;w@1wt.eu>);
        Wed, 14 Feb 2018 15:10:13 -0500
Received: from mailoutvs4.siol.net ([213.250.19.137]:37018 "EHLO mail.siol.net"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1031519AbeBNUKF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Feb 2018 15:10:05 -0500
From: Jernej Skrabec <jernej.skrabec@siol.net>
To: maxime.ripard@free-electrons.com, wens@csie.org, airlied@linux.ie,
        robh+dt@kernel.org, mark.rutland@arm.com, mturquette@baylibre.com,
        sboyd@kernel.org, architt@codeaurora.org, a.hajda@samsung.com,
        Laurent.pinchart@ideasonboard.com, narmstrong@baylibre.com,
        Jose.Abreu@synopsys.com
Cc: jernej.skrabec@siol.net, dri-devel@lists.freedesktop.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-sunxi@googlegroups.com
Subject: [PATCH v5 12/12] ARM: dts: sun8i: a83t: Enable HDMI on BananaPi M3
Date: Wed, 14 Feb 2018 21:09:06 +0100
Message-Id: <20180214200906.31509-13-jernej.skrabec@siol.net>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180214200906.31509-1-jernej.skrabec@siol.net>
References: <20180214200906.31509-1-jernej.skrabec@siol.net>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

BananaPi M3 includes HDMI connector, so add support for it.

Signed-off-by: Jernej Skrabec <jernej.skrabec@siol.net>
---
 arch/arm/boot/dts/sun8i-a83t-bananapi-m3.dts | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/arch/arm/boot/dts/sun8i-a83t-bananapi-m3.dts b/arch/arm/boot/dts/sun8i-a83t-bananapi-m3.dts
index 6550bf0e594b..00e47423cd07 100644
--- a/arch/arm/boot/dts/sun8i-a83t-bananapi-m3.dts
+++ b/arch/arm/boot/dts/sun8i-a83t-bananapi-m3.dts
@@ -60,6 +60,17 @@
 		stdout-path = "serial0:115200n8";
 	};
 
+	connector {
+		compatible = "hdmi-connector";
+		type = "a";
+
+		port {
+			hdmi_con_in: endpoint {
+				remote-endpoint = <&hdmi_out_con>;
+			};
+		};
+	};
+
 	reg_usb1_vbus: reg-usb1-vbus {
 		compatible = "regulator-fixed";
 		regulator-name = "usb1-vbus";
@@ -82,6 +93,10 @@
 	};
 };
 
+&de {
+	status = "okay";
+};
+
 &ehci0 {
 	/* Terminus Tech FE 1.1s 4-port USB 2.0 hub here */
 	status = "okay";
@@ -100,6 +115,16 @@
 	status = "okay";
 };
 
+&hdmi {
+	status = "okay";
+};
+
+&hdmi_out {
+	hdmi_out_con: endpoint {
+		remote-endpoint = <&hdmi_con_in>;
+	};
+};
+
 &mdio {
 	rgmii_phy: ethernet-phy@1 {
 		compatible = "ethernet-phy-ieee802.3-c22";
-- 
2.16.1
