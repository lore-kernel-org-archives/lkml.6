Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932249AbeDZQ5t (ORCPT <rfc822;w@1wt.eu>);
        Thu, 26 Apr 2018 12:57:49 -0400
Received: from perceval.ideasonboard.com ([213.167.242.64]:58064 "EHLO
        perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756892AbeDZQyG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Apr 2018 12:54:06 -0400
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
Subject: [PATCH 14/17] arm64: dts: r8a77965-salvator-x: Add DU external dot clocks
Date: Thu, 26 Apr 2018 17:53:43 +0100
Message-Id: <20180426165346.494-15-kieran.bingham+renesas@ideasonboard.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180426165346.494-1-kieran.bingham+renesas@ideasonboard.com>
References: <20180426165346.494-1-kieran.bingham+renesas@ideasonboard.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Takeshi Kihara <takeshi.kihara.df@renesas.com>

The DU1 external dot clock is provided by the fixed frequency clock
generator X21, while the DU0 and DU3 clocks are provided by the
programmable Versaclock5 clock generator.

Signed-off-by: Takeshi Kihara <takeshi.kihara.df@renesas.com>
Signed-off-by: Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>
---
 arch/arm64/boot/dts/renesas/r8a77965-salvator-x.dts | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/arch/arm64/boot/dts/renesas/r8a77965-salvator-x.dts b/arch/arm64/boot/dts/renesas/r8a77965-salvator-x.dts
index 75d890d91df9..a2b8fb20fef8 100644
--- a/arch/arm64/boot/dts/renesas/r8a77965-salvator-x.dts
+++ b/arch/arm64/boot/dts/renesas/r8a77965-salvator-x.dts
@@ -19,3 +19,15 @@
 		reg = <0x0 0x48000000 0x0 0x78000000>;
 	};
 };
+
+&du {
+	clocks = <&cpg CPG_MOD 724>,
+		 <&cpg CPG_MOD 723>,
+		 <&cpg CPG_MOD 721>,
+		 <&cpg CPG_MOD 727>,
+		 <&versaclock5 1>,
+		 <&x21_clk>,
+		 <&versaclock5 2>;
+	clock-names = "du.0", "du.1", "du.3", "lvds.0",
+		      "dclkin.0", "dclkin.1", "dclkin.3";
+};
-- 
2.17.0
