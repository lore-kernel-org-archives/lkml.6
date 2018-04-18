Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753975AbeDROlB (ORCPT <rfc822;w@1wt.eu>);
        Wed, 18 Apr 2018 10:41:01 -0400
Received: from relay6-d.mail.gandi.net ([217.70.183.198]:44743 "EHLO
        relay6-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753132AbeDROk7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Apr 2018 10:40:59 -0400
X-Originating-IP: 2.224.242.101
From: Jacopo Mondi <jacopo+renesas@jmondi.org>
To: architt@codeaurora.org, a.hajda@samsung.com,
        Laurent.pinchart@ideasonboard.com, airlied@linux.ie,
        vladimir_zapolskiy@mentor.com, horms@verge.net.au,
        magnus.damm@gmail.com, geert@linux-m68k.org,
        niklas.soderlund@ragnatech.se, sergei.shtylyov@cogentembedded.com,
        robh+dt@kernel.org, mark.rutland@arm.com
Cc: Jacopo Mondi <jacopo+renesas@jmondi.org>,
        dri-devel@lists.freedesktop.org, linux-renesas-soc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v9 1/2] dt-bindings: display: bridge: Document THC63LVD1024 LVDS decoder
Date: Wed, 18 Apr 2018 16:40:28 +0200
Message-Id: <1524062429-325-2-git-send-email-jacopo+renesas@jmondi.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1524062429-325-1-git-send-email-jacopo+renesas@jmondi.org>
References: <1524062429-325-1-git-send-email-jacopo+renesas@jmondi.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Document Thine THC63LVD1024 LVDS decoder device tree bindings.

Signed-off-by: Jacopo Mondi <jacopo+renesas@jmondi.org>
Reviewed-by: Andrzej Hajda <a.hajda@samsung.com>
Reviewed-by: Niklas Söderlund <niklas.soderlund+renesas@ragnatech.se>
Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Reviewed-by: Rob Herring <robh@kernel.org>
---
 .../bindings/display/bridge/thine,thc63lvd1024.txt | 60 ++++++++++++++++++++++
 1 file changed, 60 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/display/bridge/thine,thc63lvd1024.txt

diff --git a/Documentation/devicetree/bindings/display/bridge/thine,thc63lvd1024.txt b/Documentation/devicetree/bindings/display/bridge/thine,thc63lvd1024.txt
new file mode 100644
index 0000000..37f0c04
--- /dev/null
+++ b/Documentation/devicetree/bindings/display/bridge/thine,thc63lvd1024.txt
@@ -0,0 +1,60 @@
+Thine Electronics THC63LVD1024 LVDS decoder
+-------------------------------------------
+
+The THC63LVD1024 is a dual link LVDS receiver designed to convert LVDS streams
+to parallel data outputs. The chip supports single/dual input/output modes,
+handling up to two LVDS input streams and up to two digital CMOS/TTL outputs.
+
+Single or dual operation mode, output data mapping and DDR output modes are
+configured through input signals and the chip does not expose any control bus.
+
+Required properties:
+- compatible: Shall be "thine,thc63lvd1024"
+- vcc-supply: Power supply for TTL output, TTL CLOCKOUT signal, LVDS input,
+  PPL and digital circuitry
+
+Optional properties:
+- powerdown-gpios: Power down GPIO signal, pin name "/PDWN". Active low
+- oe-gpios: Output enable GPIO signal, pin name "OE". Active high
+
+The THC63LVD1024 video port connections are modeled according
+to OF graph bindings specified by Documentation/devicetree/bindings/graph.txt
+
+Required video port nodes:
+- port@0: First LVDS input port
+- port@2: First digital CMOS/TTL parallel output
+
+Optional video port nodes:
+- port@1: Second LVDS input port
+- port@3: Second digital CMOS/TTL parallel output
+
+Example:
+--------
+
+	thc63lvd1024: lvds-decoder {
+		compatible = "thine,thc63lvd1024";
+
+		vcc-supply = <&reg_lvds_vcc>;
+		powerdown-gpios = <&gpio4 15 GPIO_ACTIVE_LOW>;
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
+			};
+		};
+	};
-- 
2.7.4
