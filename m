Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756011AbeCHPYf (ORCPT <rfc822;w@1wt.eu>);
        Thu, 8 Mar 2018 10:24:35 -0500
Received: from relay2-d.mail.gandi.net ([217.70.183.194]:38088 "EHLO
        relay2-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754052AbeCHPYd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Mar 2018 10:24:33 -0500
From: Jacopo Mondi <jacopo+renesas@jmondi.org>
To: architt@codeaurora.org, a.hajda@samsung.com,
        Laurent.pinchart@ideasonboard.com, airlied@linux.ie,
        horms@verge.net.au, magnus.damm@gmail.com, geert@linux-m68k.org,
        niklas.soderlund@ragnatech.se, sergei.shtylyov@cogentembedded.com,
        robh+dt@kernel.org, mark.rutland@arm.com
Cc: Jacopo Mondi <jacopo+renesas@jmondi.org>,
        dri-devel@lists.freedesktop.org, linux-renesas-soc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/3] dt-bindings: display: bridge: Document THC63LVD1024 LVDS decoder
Date: Thu,  8 Mar 2018 16:24:01 +0100
Message-Id: <1520522643-11756-2-git-send-email-jacopo+renesas@jmondi.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1520522643-11756-1-git-send-email-jacopo+renesas@jmondi.org>
References: <1520522643-11756-1-git-send-email-jacopo+renesas@jmondi.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Document Thine THC63LVD1024 LVDS decoder.

Signed-off-by: Jacopo Mondi <jacopo+renesas@jmondi.org>
---
 .../bindings/display/bridge/thine,thc63lvd1024.txt | 59 ++++++++++++++++++++++
 1 file changed, 59 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/display/bridge/thine,thc63lvd1024.txt

diff --git a/Documentation/devicetree/bindings/display/bridge/thine,thc63lvd1024.txt b/Documentation/devicetree/bindings/display/bridge/thine,thc63lvd1024.txt
new file mode 100644
index 0000000..53b6453
--- /dev/null
+++ b/Documentation/devicetree/bindings/display/bridge/thine,thc63lvd1024.txt
@@ -0,0 +1,59 @@
+THine Electronics THC63LVD1024 LVDS receiver
+--------------------------------------------
+
+The THC63LVD1024 is an LVDS receiver designed to convert multiple LVDS streams
+to digital CMOS/TTL parallel data.
+
+Required properties:
+- compatible: Shall be one of the following:
+  "thine,thc63lvd1024",
+  "lvds-decoder"
+
+Optional properties:
+- supply-vcc: Power supply for TTL output and digital circuitry
+- supply-cvcc: Power supply for TTL CLOCKOUT signal
+- supply-lvcc: Power supply for LVDS inputs
+- supply-pvcc: Power supply for PLL circuitry
+- pwnd-gpio: Power down GPIO signal. Active low.
+- oe-gpio: Output enable GPIO signal. Active high.
+
+The THC63LVD1024 has two video ports, whose connections are modeled according
+to OF graph bindings specified by Documentation/devicetree/bindings/graph.txt
+
+- Port@0: LVDS input port
+- Port@1: Digital CMOS/TTL parallel output
+
+Example:
+-------
+
+	lvds_decoder: decoder-0 {
+		compatible = "thine,thc63lvd1024";
+
+		vcc-supply = <&reg_lvds_vcc>;
+		lvcc-supply = <&reg_lvds_lvcc>;
+
+		pwdn-gpio = <&gpio4 15 GPIO_ACTIVE_LOW>;
+
+		ports {
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			port@0 {
+				reg = <0>;
+
+				lvds_dec_in: endpoint {
+					remote-endpoint = <&lvds_out>;
+				};
+			};
+
+			port@1{
+				reg = <1>;
+
+				lvds_dec_out: endpoint {
+					remote-endpoint = <&adv7511_in>;
+				};
+
+			};
+
+		};
+	};
-- 
2.7.4
