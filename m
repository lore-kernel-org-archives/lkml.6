Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757082AbeDZQ5U (ORCPT <rfc822;w@1wt.eu>);
        Thu, 26 Apr 2018 12:57:20 -0400
Received: from perceval.ideasonboard.com ([213.167.242.64]:58080 "EHLO
        perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756723AbeDZQyK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Apr 2018 12:54:10 -0400
From: Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>
To: linux-renesas-soc@vger.kernel.org
Cc: Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>,
        Takeshi Kihara <takeshi.kihara.df@renesas.com>,
        Simon Horman <horms@verge.net.au>, Magnus Damm <magnus.damm@gmail.com>,
        Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED
        DEVICE TREE BINDINGS),
        linux-arm-kernel@lists.infradead.org (moderated list:ARM64 PORT
        (AARCH64 ARCHITECTURE)),
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH 17/17] arm64: dts: r8a77965-salvator-xs: Enable HDMI output
Date: Thu, 26 Apr 2018 17:53:46 +0100
Message-Id: <20180426165346.494-18-kieran.bingham+renesas@ideasonboard.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180426165346.494-1-kieran.bingham+renesas@ideasonboard.com>
References: <20180426165346.494-1-kieran.bingham+renesas@ideasonboard.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Takeshi Kihara <takeshi.kihara.df@renesas.com>

This patch enables the HDMI encoder for the Salvator-X 2nd version board
on the R8A77965 SoC and hook it up to the HDMI connector.

Based on code of the Salvator-X 2nd version board
on the R8A7796 SoC device tree
by Geert Uytterhoeven <geert+renesas@glider.be>

Signed-off-by: Takeshi Kihara <takeshi.kihara.df@renesas.com>
Signed-off-by: Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>
---
 .../boot/dts/renesas/r8a77965-salvator-xs.dts   | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/arch/arm64/boot/dts/renesas/r8a77965-salvator-xs.dts b/arch/arm64/boot/dts/renesas/r8a77965-salvator-xs.dts
index 2223cc2bd6bc..dcf1849f1a67 100644
--- a/arch/arm64/boot/dts/renesas/r8a77965-salvator-xs.dts
+++ b/arch/arm64/boot/dts/renesas/r8a77965-salvator-xs.dts
@@ -31,3 +31,20 @@
 	clock-names = "du.0", "du.1", "du.3", "lvds.0",
 		      "dclkin.0", "dclkin.1", "dclkin.3";
 };
+
+&hdmi0 {
+	status = "okay";
+
+	ports {
+		port@1 {
+			reg = <1>;
+			rcar_dw_hdmi0_out: endpoint {
+				remote-endpoint = <&hdmi0_con>;
+			};
+		};
+	};
+};
+
+&hdmi0_con {
+	remote-endpoint = <&rcar_dw_hdmi0_out>;
+};
-- 
2.17.0
