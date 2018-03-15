Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932312AbeCOQ01 (ORCPT <rfc822;w@1wt.eu>);
        Thu, 15 Mar 2018 12:26:27 -0400
Received: from h1.radempa.de ([176.9.142.194]:52245 "EHLO mail.cosmopool.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752140AbeCOQZc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Mar 2018 12:25:32 -0400
From: Harald Geyer <harald@ccbib.org>
To: Maxime Ripard <maxime.ripard@bootlin.com>,
        Chen-Yu Tsai <wens@csie.org>
Cc: Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Andre Przywara <andre.przywara@arm.com>,
        Icenowy Zheng <icenowy@aosc.io>, info@olimex.com,
        Harald Geyer <harald@ccbib.org>
Subject: [PATCHv2 3/5] arm64: dts: allwinner: a64: add simplefb for A64 SoC
Date: Thu, 15 Mar 2018 16:25:08 +0000
Message-Id: <20180315162510.11669-4-harald@ccbib.org>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20180315162510.11669-1-harald@ccbib.org>
References: <20180315162510.11669-1-harald@ccbib.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The A64 SoC features two display pipelines, one has a LCD output, the
other has a HDMI output.

Add support for simplefb for the LCD output. Tested on Teres I.

This patch was inspired by work of Icenowy Zheng.

Signed-off-by: Harald Geyer <harald@ccbib.org>
---
changes since v1: none

 arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi b/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
index 8401e7f887ff..1b2ef28c42bd 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
+++ b/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
@@ -52,6 +52,26 @@
 	#address-cells = <1>;
 	#size-cells = <1>;
 
+	chosen {
+		#address-cells = <1>;
+		#size-cells = <1>;
+		ranges;
+
+/*
+ * The pipeline mixer0-lcd0 depends on clock CLK_MIXER0 from DE2 CCU.
+ * However there is no support for this clock on A64 yet, so we depend
+ * on the upstream clocks here to keep them (and thus CLK_MIXER0) up.
+ */
+		simplefb_lcd: framebuffer-lcd {
+			compatible = "allwinner,simple-framebuffer",
+				     "simple-framebuffer";
+			allwinner,pipeline = "mixer0-lcd0";
+			clocks = <&ccu CLK_TCON0>,
+				 <&ccu CLK_DE>, <&ccu CLK_BUS_DE>;
+			status = "disabled";
+		};
+	};
+
 	cpus {
 		#address-cells = <1>;
 		#size-cells = <0>;
-- 
2.11.0
