Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752967AbeERJsL (ORCPT <rfc822;w@1wt.eu>);
        Fri, 18 May 2018 05:48:11 -0400
Received: from mail-pg0-f65.google.com ([74.125.83.65]:35095 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752876AbeERJsH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 May 2018 05:48:07 -0400
X-Google-Smtp-Source: AB8JxZqTd1YedepyFPnjVHe+VvVtaNFAklgVkelJ1OIqW9Bv39RbmYpWfnawuRZtKrSq4/vkVgSvWA==
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
Subject: [PATCH v2 19/26] arm64: dts: allwinner: a64: Add HDMI pipeline
Date: Fri, 18 May 2018 15:15:29 +0530
Message-Id: <20180518094536.17201-20-jagan@amarulasolutions.com>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20180518094536.17201-1-jagan@amarulasolutions.com>
References: <20180518094536.17201-1-jagan@amarulasolutions.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

HDMI pipeline on Allwinner A64 has similar behavior like A83T
where tcon1 is connected to HDMI.

Setup the pipeline according to that.

Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
---
Changes for v2:
- none

 arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi b/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
index 4ffd4787acd2..8ec6559d10cc 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
+++ b/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
@@ -257,6 +257,10 @@
 					#size-cells = <0>;
 					reg = <1>;
 
+					tcon1_out_hdmi: endpoint@1 {
+						reg = <1>;
+						remote-endpoint = <&hdmi_in_tcon1>;
+					};
 				};
 			};
 		};
@@ -719,6 +723,23 @@
 			phys = <&hdmi_phy>;
 			phy-names = "hdmi-phy";
 			status = "disabled";
+
+			ports {
+				#address-cells = <1>;
+				#size-cells = <0>;
+
+				hdmi_in: port@0 {
+					reg = <0>;
+
+					hdmi_in_tcon1: endpoint {
+						remote-endpoint = <&tcon1_out_hdmi>;
+					};
+				};
+
+				hdmi_out: port@1 {
+					reg = <1>;
+				};
+			};
 		};
 
 		hdmi_phy: hdmi-phy@1ef0000 {
-- 
2.14.3
