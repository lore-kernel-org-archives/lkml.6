Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932163AbeCINwU (ORCPT <rfc822;w@1wt.eu>);
        Fri, 9 Mar 2018 08:52:20 -0500
Received: from relay4-d.mail.gandi.net ([217.70.183.196]:36462 "EHLO
        relay4-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932135AbeCINwR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Mar 2018 08:52:17 -0500
From: Jacopo Mondi <jacopo+renesas@jmondi.org>
To: architt@codeaurora.org, a.hajda@samsung.com,
        Laurent.pinchart@ideasonboard.com, airlied@linux.ie,
        horms@verge.net.au, magnus.damm@gmail.com, geert@linux-m68k.org,
        niklas.soderlund@ragnatech.se, sergei.shtylyov@cogentembedded.com,
        robh+dt@kernel.org, mark.rutland@arm.com
Cc: Jacopo Mondi <jacopo+renesas@jmondi.org>,
        dri-devel@lists.freedesktop.org, linux-renesas-soc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 3/3] arm64: dts: renesas: Add LVDS decoder to R-Car V3M Eagle
Date: Fri,  9 Mar 2018 14:51:40 +0100
Message-Id: <1520603500-15218-4-git-send-email-jacopo+renesas@jmondi.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1520603500-15218-1-git-send-email-jacopo+renesas@jmondi.org>
References: <1520603500-15218-1-git-send-email-jacopo+renesas@jmondi.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The R-Car V3M Eagle board includes a transparent LVDS decoder, connected
to the on-chip LVDS encoder output on one side and to HDMI encoder
ADV7511w on the other one.

As the decoder does not need any configuration it has been so-far
omitted from DTS. Now that a driver for transparent LVDS decoder is
available, describe it in DT as well.

Signed-off-by: Jacopo Mondi <jacopo+renesas@jmondi.org>
---
 arch/arm64/boot/dts/renesas/r8a77970-eagle.dts | 31 ++++++++++++++++++++++++--
 1 file changed, 29 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/renesas/r8a77970-eagle.dts b/arch/arm64/boot/dts/renesas/r8a77970-eagle.dts
index c0fd144..0a95c20 100644
--- a/arch/arm64/boot/dts/renesas/r8a77970-eagle.dts
+++ b/arch/arm64/boot/dts/renesas/r8a77970-eagle.dts
@@ -42,6 +42,33 @@
 			};
 		};
 	};
+
+	lvds,decoder {
+		compatible = "lvds-decoder";
+
+		ports {
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			port@0 {
+				reg = <0>;
+
+				lvds_dec_in: endpoint {
+					remote-endpoint = <&lvds0_out>;
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
 };
 
 &avb {
@@ -98,7 +125,7 @@
 			port@0 {
 				reg = <0>;
 				adv7511_in: endpoint {
-					remote-endpoint = <&lvds0_out>;
+					remote-endpoint = <&lvds_dec_out>;
 				};
 			};
 
@@ -153,7 +180,7 @@
 	ports {
 		port@1 {
 			endpoint {
-				remote-endpoint = <&adv7511_in>;
+				remote-endpoint = <&lvds_dec_in>;
 			};
 		};
 	};
-- 
2.7.4
