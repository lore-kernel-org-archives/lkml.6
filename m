Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751489AbeDPPD6 (ORCPT <rfc822;w@1wt.eu>);
        Mon, 16 Apr 2018 11:03:58 -0400
Received: from conuserg-11.nifty.com ([210.131.2.78]:62358 "EHLO
        conuserg-11.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751024AbeDPPD4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Apr 2018 11:03:56 -0400
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-11.nifty.com w3GF2eKa006974
X-Nifty-SrcIP: [125.199.20.195]
From: Masahiro Yamada <yamada.masahiro@socionext.com>
To: Simon Horman <horms@verge.net.au>, Magnus Damm <magnus.damm@gmail.com>,
        linux-renesas-soc@vger.kernel.org
Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>,
        linux-arm-kernel@lists.infradead.org,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>
Subject: [PATCH] ARM: dts: renesas: replace toshiba,mmc-wrprotect-disable with disable-wp
Date: Tue, 17 Apr 2018 00:02:32 +0900
Message-Id: <1523890952-20866-1-git-send-email-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Follow up commit 788778b0d21a ("mmc: tmio: deprecate "toshiba,
mmc-wrprotect-disable" DT property").

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 arch/arm/boot/dts/r8a73a4-ape6evm.dts | 4 ++--
 arch/arm/boot/dts/sh73a0.dtsi         | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm/boot/dts/r8a73a4-ape6evm.dts b/arch/arm/boot/dts/r8a73a4-ape6evm.dts
index ec7c86e..125c39c 100644
--- a/arch/arm/boot/dts/r8a73a4-ape6evm.dts
+++ b/arch/arm/boot/dts/r8a73a4-ape6evm.dts
@@ -234,7 +234,7 @@
 &sdhi0 {
 	vmmc-supply = <&vcc_sdhi0>;
 	bus-width = <4>;
-	toshiba,mmc-wrprotect-disable;
+	disable-wp;
 	pinctrl-names = "default";
 	pinctrl-0 = <&sdhi0_pins>;
 	status = "okay";
@@ -244,7 +244,7 @@
 	vmmc-supply = <&ape6evm_fixed_3v3>;
 	bus-width = <4>;
 	broken-cd;
-	toshiba,mmc-wrprotect-disable;
+	disable-wp;
 	pinctrl-names = "default";
 	pinctrl-0 = <&sdhi1_pins>;
 	status = "okay";
diff --git a/arch/arm/boot/dts/sh73a0.dtsi b/arch/arm/boot/dts/sh73a0.dtsi
index 914a7c2..39cc586 100644
--- a/arch/arm/boot/dts/sh73a0.dtsi
+++ b/arch/arm/boot/dts/sh73a0.dtsi
@@ -336,7 +336,7 @@
 			      GIC_SPI 89 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp3_clks SH73A0_CLK_SDHI1>;
 		power-domains = <&pd_a3sp>;
-		toshiba,mmc-wrprotect-disable;
+		disable-wp;
 		cap-sd-highspeed;
 		status = "disabled";
 	};
@@ -348,7 +348,7 @@
 			      GIC_SPI 105 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp3_clks SH73A0_CLK_SDHI2>;
 		power-domains = <&pd_a3sp>;
-		toshiba,mmc-wrprotect-disable;
+		disable-wp;
 		cap-sd-highspeed;
 		status = "disabled";
 	};
-- 
2.7.4
