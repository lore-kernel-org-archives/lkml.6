Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753370AbeEOMaB (ORCPT <rfc822;w@1wt.eu>);
        Tue, 15 May 2018 08:30:01 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:59714 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752343AbeEOM35 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 May 2018 08:29:57 -0400
From: Gilad Ben-Yossef <gilad@benyossef.com>
To: Simon Horman <horms@verge.net.au>, Magnus Damm <magnus.damm@gmail.com>,
        Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>
Cc: Ofir Drang <ofir.drang@arm.com>, linux-renesas-soc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-crypto@vger.kernel.org
Subject: [PATCH 3/3] arm64: dts: renesas: r8a7795: add ccree binding
Date: Tue, 15 May 2018 13:29:29 +0100
Message-Id: <1526387370-17142-4-git-send-email-gilad@benyossef.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1526387370-17142-1-git-send-email-gilad@benyossef.com>
References: <1526387370-17142-1-git-send-email-gilad@benyossef.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add bindings for CryptoCell instance in the SoC.

Signed-off-by: Gilad Ben-Yossef <gilad@benyossef.com>
---
 arch/arm64/boot/dts/renesas/r8a7795.dtsi | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm64/boot/dts/renesas/r8a7795.dtsi b/arch/arm64/boot/dts/renesas/r8a7795.dtsi
index 91486b4..6c76841 100644
--- a/arch/arm64/boot/dts/renesas/r8a7795.dtsi
+++ b/arch/arm64/boot/dts/renesas/r8a7795.dtsi
@@ -528,6 +528,14 @@
 			status = "disabled";
 		};
 
+		arm_cc630p: crypto@e6601000 {
+			compatible = "arm,cryptocell-630p-ree";
+			interrupts = <GIC_SPI 71 IRQ_TYPE_LEVEL_HIGH>;
+			#interrupt-cells = <2>;
+			reg = <0x0 0xe6601000 0 0x1000>;
+			clocks = <&cpg CPG_MOD 229>;
+		};
+
 		i2c3: i2c@e66d0000 {
 			#address-cells = <1>;
 			#size-cells = <0>;
-- 
2.7.4
