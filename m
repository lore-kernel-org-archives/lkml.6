Return-Path: <SRS0=jXQK=NP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10463ECDE44
	for <linux-kernel@archiver.kernel.org>; Sun,  4 Nov 2018 18:28:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D159A2081D
	for <linux-kernel@archiver.kernel.org>; Sun,  4 Nov 2018 18:28:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D159A2081D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=siol.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387767AbeKEDol (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 4 Nov 2018 22:44:41 -0500
Received: from mailoutvs5.siol.net ([185.57.226.196]:47887 "EHLO mail.siol.net"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2387693AbeKEDok (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Nov 2018 22:44:40 -0500
Received: from localhost (localhost [127.0.0.1])
        by mail.siol.net (Postfix) with ESMTP id 7C905520373;
        Sun,  4 Nov 2018 19:28:45 +0100 (CET)
X-Virus-Scanned: amavisd-new at psrvmta11.zcs-production.pri
Received: from mail.siol.net ([127.0.0.1])
        by localhost (psrvmta11.zcs-production.pri [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id PEPMXrDCeqIV; Sun,  4 Nov 2018 19:28:45 +0100 (CET)
Received: from mail.siol.net (localhost [127.0.0.1])
        by mail.siol.net (Postfix) with ESMTPS id 3AF7B5203B5;
        Sun,  4 Nov 2018 19:28:44 +0100 (CET)
Received: from localhost.localdomain (cpe1-8-82.cable.triera.net [213.161.8.82])
        (Authenticated sender: 031275009)
        by mail.siol.net (Postfix) with ESMTPSA id B35CF520373;
        Sun,  4 Nov 2018 19:28:41 +0100 (CET)
From:   Jernej Skrabec <jernej.skrabec@siol.net>
To:     maxime.ripard@bootlin.com, wens@csie.org
Cc:     robh+dt@kernel.org, mturquette@baylibre.com, sboyd@kernel.org,
        airlied@linux.ie, architt@codeaurora.org, a.hajda@samsung.com,
        Laurent.pinchart@ideasonboard.com, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-sunxi@googlegroups.com, jernej.skrabec@siol.net,
        Icenowy Zheng <icenowy@aosc.io>
Subject: [PATCH v3 27/28] arm64: dts: allwinner: h6: Add HDMI pipeline
Date:   Sun,  4 Nov 2018 19:27:04 +0100
Message-Id: <20181104182705.18047-28-jernej.skrabec@siol.net>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181104182705.18047-1-jernej.skrabec@siol.net>
References: <20181104182705.18047-1-jernej.skrabec@siol.net>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This commit adds all entries needed for HDMI to function properly.

Signed-off-by: Jernej Skrabec <jernej.skrabec@siol.net>
[added DE3 bus]
Signed-off-by: Icenowy Zheng <icenowy@aosc.io>
---
 arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi | 201 +++++++++++++++++++
 1 file changed, 201 insertions(+)

diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi b/arch/arm64/bo=
ot/dts/allwinner/sun50i-h6.dtsi
index 040828d2e2c0..59dda8f89d23 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi
+++ b/arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi
@@ -6,8 +6,11 @@
 #include <dt-bindings/interrupt-controller/arm-gic.h>
 #include <dt-bindings/clock/sun50i-h6-ccu.h>
 #include <dt-bindings/clock/sun50i-h6-r-ccu.h>
+#include <dt-bindings/clock/sun8i-de2.h>
+#include <dt-bindings/clock/sun8i-tcon-top.h>
 #include <dt-bindings/reset/sun50i-h6-ccu.h>
 #include <dt-bindings/reset/sun50i-h6-r-ccu.h>
+#include <dt-bindings/reset/sun8i-de2.h>
=20
 / {
 	interrupt-parent =3D <&gic>;
@@ -86,12 +89,63 @@
 			(GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_HIGH)>;
 	};
=20
+	de: display-engine {
+		compatible =3D "allwinner,sun50i-h6-display-engine";
+		allwinner,pipelines =3D <&mixer0>;
+		status =3D "disabled";
+	};
+
 	soc {
 		compatible =3D "simple-bus";
 		#address-cells =3D <1>;
 		#size-cells =3D <1>;
 		ranges;
=20
+		de3@1000000 {
+			compatible =3D "allwinner,sun50i-h6-de3",
+				     "allwinner,sun50i-a64-de2";
+			reg =3D <0x1000000 0x400000>;
+			allwinner,sram =3D <&de2_sram 1>;
+			#address-cells =3D <1>;
+			#size-cells =3D <1>;
+			ranges =3D <0 0x1000000 0x400000>;
+
+			display_clocks: clock@0 {
+				compatible =3D "allwinner,sun50i-h6-de3-clk";
+				reg =3D <0x0 0x10000>;
+				clocks =3D <&ccu CLK_DE>,
+					 <&ccu CLK_BUS_DE>;
+				clock-names =3D "mod",
+					      "bus";
+				resets =3D <&ccu RST_BUS_DE>;
+				#clock-cells =3D <1>;
+				#reset-cells =3D <1>;
+			};
+
+			mixer0: mixer@100000 {
+				compatible =3D "allwinner,sun50i-h6-de3-mixer-0";
+				reg =3D <0x100000 0x100000>;
+				clocks =3D <&display_clocks CLK_BUS_MIXER0>,
+					 <&display_clocks CLK_MIXER0>;
+				clock-names =3D "bus",
+					      "mod";
+				resets =3D <&display_clocks RST_MIXER0>;
+
+				ports {
+					#address-cells =3D <1>;
+					#size-cells =3D <0>;
+
+					mixer0_out: port@1 {
+						reg =3D <1>;
+
+						mixer0_out_tcon_top_mixer0: endpoint {
+							remote-endpoint =3D <&tcon_top_mixer0_in_mixer0>;
+						};
+					};
+				};
+			};
+		};
+
 		syscon: syscon@3000000 {
 			compatible =3D "allwinner,sun50i-h6-system-control",
 				     "allwinner,sun50i-a64-system-control";
@@ -149,6 +203,11 @@
 			interrupt-controller;
 			#interrupt-cells =3D <3>;
=20
+			hdmi_pins: hdmi-pins {
+				pins =3D "PH8", "PH9", "PH10";
+				function =3D "hdmi";
+			};
+
 			mmc0_pins: mmc0-pins {
 				pins =3D "PF0", "PF1", "PF2", "PF3",
 				       "PF4", "PF5";
@@ -258,6 +317,148 @@
 			status =3D "disabled";
 		};
=20
+		hdmi: hdmi@6000000 {
+			compatible =3D "allwinner,sun50i-h6-dw-hdmi";
+			reg =3D <0x06000000 0x10000>;
+			reg-io-width =3D <1>;
+			interrupts =3D <GIC_SPI 64 IRQ_TYPE_LEVEL_HIGH>;
+			clocks =3D <&ccu CLK_BUS_HDMI>, <&ccu CLK_HDMI_SLOW>,
+				 <&ccu CLK_HDMI>, <&ccu CLK_HDMI_CEC>,
+				 <&ccu CLK_HDCP>, <&ccu CLK_BUS_HDCP>;
+			clock-names =3D "iahb", "isfr", "tmds", "cec", "hdcp",
+				      "hdcp-bus";
+			resets =3D <&ccu RST_BUS_HDMI_SUB>, <&ccu RST_BUS_HDCP>;
+			reset-names =3D "ctrl", "hdcp";
+			phys =3D <&hdmi_phy>;
+			phy-names =3D "hdmi-phy";
+			pinctrl-names =3D "default";
+			pinctrl-0 =3D <&hdmi_pins>;
+			status =3D "disabled";
+
+			ports {
+				#address-cells =3D <1>;
+				#size-cells =3D <0>;
+
+				hdmi_in: port@0 {
+					reg =3D <0>;
+
+					hdmi_in_tcon_top: endpoint {
+						remote-endpoint =3D <&tcon_top_hdmi_out_hdmi>;
+					};
+				};
+
+				hdmi_out: port@1 {
+					reg =3D <1>;
+				};
+			};
+		};
+
+		hdmi_phy: hdmi-phy@6010000 {
+			compatible =3D "allwinner,sun50i-h6-hdmi-phy";
+			reg =3D <0x06010000 0x10000>;
+			clocks =3D <&ccu CLK_BUS_HDMI>, <&ccu CLK_HDMI_SLOW>;
+			clock-names =3D "bus", "mod";
+			resets =3D <&ccu RST_BUS_HDMI>;
+			reset-names =3D "phy";
+			#phy-cells =3D <0>;
+		};
+
+		tcon_top: tcon-top@6510000 {
+			compatible =3D "allwinner,sun50i-h6-tcon-top";
+			reg =3D <0x06510000 0x1000>;
+			clocks =3D <&ccu CLK_BUS_TCON_TOP>,
+				 <&ccu CLK_TCON_TV0>;
+			clock-names =3D "bus",
+				      "tcon-tv0";
+			clock-output-names =3D "tcon-top-tv0";
+			resets =3D <&ccu RST_BUS_TCON_TOP>;
+			reset-names =3D "rst";
+			#clock-cells =3D <1>;
+
+			ports {
+				#address-cells =3D <1>;
+				#size-cells =3D <0>;
+
+				tcon_top_mixer0_in: port@0 {
+					#address-cells =3D <1>;
+					#size-cells =3D <0>;
+					reg =3D <0>;
+
+					tcon_top_mixer0_in_mixer0: endpoint@0 {
+						reg =3D <0>;
+						remote-endpoint =3D <&mixer0_out_tcon_top_mixer0>;
+					};
+				};
+
+				tcon_top_mixer0_out: port@1 {
+					#address-cells =3D <1>;
+					#size-cells =3D <0>;
+					reg =3D <1>;
+
+					tcon_top_mixer0_out_tcon_tv: endpoint@2 {
+						reg =3D <2>;
+						remote-endpoint =3D <&tcon_tv_in_tcon_top_mixer0>;
+					};
+				};
+
+				tcon_top_hdmi_in: port@4 {
+					#address-cells =3D <1>;
+					#size-cells =3D <0>;
+					reg =3D <4>;
+
+					tcon_top_hdmi_in_tcon_tv: endpoint@0 {
+						reg =3D <0>;
+						remote-endpoint =3D <&tcon_tv_out_tcon_top>;
+					};
+				};
+
+				tcon_top_hdmi_out: port@5 {
+					reg =3D <5>;
+
+					tcon_top_hdmi_out_hdmi: endpoint {
+						remote-endpoint =3D <&hdmi_in_tcon_top>;
+					};
+				};
+			};
+		};
+
+		tcon_tv: lcd-controller@6515000 {
+			compatible =3D "allwinner,sun50i-h6-tcon-tv",
+				     "allwinner,sun8i-r40-tcon-tv";
+			reg =3D <0x06515000 0x1000>;
+			interrupts =3D <GIC_SPI 66 IRQ_TYPE_LEVEL_HIGH>;
+			clocks =3D <&ccu CLK_BUS_TCON_TV0>,
+				 <&tcon_top CLK_TCON_TOP_TV0>;
+			clock-names =3D "ahb",
+				      "tcon-ch1";
+			resets =3D <&ccu RST_BUS_TCON_TV0>;
+			reset-names =3D "lcd";
+
+			ports {
+				#address-cells =3D <1>;
+				#size-cells =3D <0>;
+
+				tcon_tv_in: port@0 {
+					reg =3D <0>;
+
+					tcon_tv_in_tcon_top_mixer0: endpoint {
+						remote-endpoint =3D <&tcon_top_mixer0_out_tcon_tv>;
+					};
+				};
+
+				tcon_tv_out: port@1 {
+					#address-cells =3D <1>;
+					#size-cells =3D <0>;
+					reg =3D <1>;
+
+					tcon_tv_out_tcon_top: endpoint@1 {
+						reg =3D <1>;
+						remote-endpoint =3D <&tcon_top_hdmi_in_tcon_tv>;
+					};
+				};
+			};
+		};
+
 		r_ccu: clock@7010000 {
 			compatible =3D "allwinner,sun50i-h6-r-ccu";
 			reg =3D <0x07010000 0x400>;
--=20
2.19.1

