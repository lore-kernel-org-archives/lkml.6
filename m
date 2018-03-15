Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751551AbeCOLPJ (ORCPT <rfc822;w@1wt.eu>);
        Thu, 15 Mar 2018 07:15:09 -0400
Received: from relay5-d.mail.gandi.net ([217.70.183.197]:58271 "EHLO
        relay5-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750745AbeCOLPI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Mar 2018 07:15:08 -0400
X-Originating-IP: 2.224.242.101
From: Jacopo Mondi <jacopo+renesas@jmondi.org>
To: architt@codeaurora.org, a.hajda@samsung.com,
        Laurent.pinchart@ideasonboard.com, airlied@linux.ie,
        horms@verge.net.au, magnus.damm@gmail.com, geert@linux-m68k.org,
        niklas.soderlund@ragnatech.se, sergei.shtylyov@cogentembedded.com,
        robh+dt@kernel.org, mark.rutland@arm.com
Cc: Jacopo Mondi <jacopo+renesas@jmondi.org>,
        dri-devel@lists.freedesktop.org, linux-renesas-soc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v4 1/3] dt-bindings: display: bridge: Document THC63LVD1024 LVDS decoder
Date: Thu, 15 Mar 2018 11:56:29 +0100
Message-Id: <1521111391-3515-2-git-send-email-jacopo+renesas@jmondi.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1521111391-3515-1-git-send-email-jacopo+renesas@jmondi.org>
References: <1521111391-3515-1-git-send-email-jacopo+renesas@jmondi.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Document Thine THC63LVD1024 LVDS decoder device tree bindings.

Signed-off-by: Jacopo Mondi <jacopo+renesas@jmondi.org>
---
 .../bindings/display/bridge/thine,thc63lvd1024.txt | 63 ++++++++++++++++++++++
 1 file changed, 63 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/display/bridge/thine,thc63lvd1024.txt

diff --git a/Documentation/devicetree/bindings/display/bridge/thine,thc63lvd1024.txt b/Documentation/devicetree/bindings/display/bridge/thine,thc63lvd1024.txt
new file mode 100644
index 0000000..0936bde
--- /dev/null
+++ b/Documentation/devicetree/bindings/display/bridge/thine,thc63lvd1024.txt
@@ -0,0 +1,63 @@
+Thine Electronics THC63LVD1024 LVDS decoder
+-------------------------------------------
+
+The THC63LVD1024 is a dual link LVDS receiver designed to convert LVDS streams
+to parallel data outputs. The chip supports single/dual input/output modes,
+handling up to two two input LVDS stream and up to two digital CMOS/TTL outputs.
+
+Required properties:
+- compatible: Shall be "thine,thc63lvd1024",
+
+Optional properties:
+- vcc-supply: Power supply for TTL output and digital circuitry
+- cvcc-supply: Power supply for TTL CLOCKOUT signal
+- lvcc-supply: Power supply for LVDS inputs
+- pvcc-supply: Power supply for PLL circuitry
+- pdwn-gpios: Power down GPIO signal. Active low.
+- oe-gpios: Output enable GPIO signal. Active high.
+
+The THC63LVD1024 video port connections are modeled according
+to OF graph bindings specified by Documentation/devicetree/bindings/graph.txt
+
+Required video port nodes:
+- Port@0: First LVDS input port
+- Port@2: First digital CMOS/TTL parallel output
+
+Optional video port nodes:
+- Port@1: Second LVDS input port
+- Port@3: Second digital CMOS/TTL parallel output
+
+Example:
+--------
+
+	thc63lvd1024: lvds-decoder {
+		compatible = "thine,thc63lvd1024";
+
+		vcc-supply = <&reg_lvds_vcc>;
+		lvcc-supply = <&reg_lvds_lvcc>;
+
+		pdwn-gpio = <&gpio4 15 GPIO_ACTIVE_LOW>;
+
+		ports {
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			port@0 {
+				reg = <0>;
+
+				lvds_dec_in_0: endpoint {
+					remote-endpoint = <&lvds_out>;
+				};
+			};
+
+			port@2{
+				reg = <2>;
+
+				lvds_dec_out_2: endpoint {
+					remote-endpoint = <&adv7511_in>;
+				};
+
+			};
+
+		};
+	};
-- 
2.7.4
