Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753096AbeERJsb (ORCPT <rfc822;w@1wt.eu>);
        Fri, 18 May 2018 05:48:31 -0400
Received: from mail-pl0-f68.google.com ([209.85.160.68]:38367 "EHLO
        mail-pl0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752541AbeERJsZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 May 2018 05:48:25 -0400
X-Google-Smtp-Source: AB8JxZpRoEq6hy4ao2r+lZHkxDlvW89riXBGhu9WGAImoTu0EcuANtzQO1N4PlDN2eZ8lz5G/TrheA==
From: Jagan Teki <jagan@amarulasolutions.com>
To: Maxime Ripard <maxime.ripard@free-electrons.com>,
        Chen-Yu Tsai <wens@csie.org>, Icenowy Zheng <icenowy@aosc.io>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>, David Airlie <airlied@linux.ie>,
        dri-devel@lists.freedesktop.org,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, linux-clk@vger.kernel.org,
        Michael Trimarchi <michael@amarulasolutions.com>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-sunxi@googlegroups.com
Cc: Jagan Teki <jagan@amarulasolutions.com>
Subject: [PATCH v2 22/26] arm64: dts: allwinner: a64: nanopi-a64: Enable HDMI output
Date: Fri, 18 May 2018 15:15:32 +0530
Message-Id: <20180518094536.17201-23-jagan@amarulasolutions.com>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20180518094536.17201-1-jagan@amarulasolutions.com>
References: <20180518094536.17201-1-jagan@amarulasolutions.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enable HDMI output on nanopi-a64 board.

Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
---
Changes for v2:
- none

 .../boot/dts/allwinner/sun50i-a64-nanopi-a64.dts   | 26 ++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64-nanopi-a64.dts b/arch/arm64/boot/dts/allwinner/sun50i-a64-nanopi-a64.dts
index e2dce48fa29a..19fe7eed45e9 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-a64-nanopi-a64.dts
+++ b/arch/arm64/boot/dts/allwinner/sun50i-a64-nanopi-a64.dts
@@ -57,6 +57,21 @@
 	chosen {
 		stdout-path = "serial0:115200n8";
 	};
+
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
+};
+
+&de {
+	status = "okay";
 };
 
 &ehci0 {
@@ -67,6 +82,17 @@
 	status = "okay";
 };
 
+&hdmi {
+	hvcc-supply = <&reg_dldo1>;
+	status = "okay";
+};
+
+&hdmi_out {
+	hdmi_out_con: endpoint {
+		remote-endpoint = <&hdmi_con_in>;
+	};
+};
+
 /* i2c1 connected with gpio headers like pine64, bananapi */
 &i2c1 {
 	pinctrl-names = "default";
-- 
2.14.3
