Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752711AbeDLCcG (ORCPT <rfc822;w@1wt.eu>);
        Wed, 11 Apr 2018 22:32:06 -0400
Received: from conuserg-11.nifty.com ([210.131.2.78]:46108 "EHLO
        conuserg-11.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752401AbeDLCcF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Apr 2018 22:32:05 -0400
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-11.nifty.com w3C2Vbs9024044
X-Nifty-SrcIP: [153.142.97.92]
From: Masahiro Yamada <yamada.masahiro@socionext.com>
To: linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org,
        Masahiro Yamada <yamada.masahiro@socionext.com>
Subject: [PATCH] arm64: dts: uniphier: fix input delay value for legacy mode of eMMC
Date: Thu, 12 Apr 2018 11:31:31 +0900
Message-Id: <1523500291-24008-1-git-send-email-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The property of the legacy mode for the eMMC PHY turned out to
be worng.  Some eMMC devices are unstable due to the set-up/hold
timing violation.  Correct the delay value.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 arch/arm64/boot/dts/socionext/uniphier-ld11.dtsi | 2 +-
 arch/arm64/boot/dts/socionext/uniphier-ld20.dtsi | 2 +-
 arch/arm64/boot/dts/socionext/uniphier-pxs3.dtsi | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/boot/dts/socionext/uniphier-ld11.dtsi b/arch/arm64/boot/dts/socionext/uniphier-ld11.dtsi
index e62bda1..c32dd34 100644
--- a/arch/arm64/boot/dts/socionext/uniphier-ld11.dtsi
+++ b/arch/arm64/boot/dts/socionext/uniphier-ld11.dtsi
@@ -414,7 +414,7 @@
 			mmc-ddr-1_8v;
 			mmc-hs200-1_8v;
 			mmc-pwrseq = <&emmc_pwrseq>;
-			cdns,phy-input-delay-legacy = <4>;
+			cdns,phy-input-delay-legacy = <9>;
 			cdns,phy-input-delay-mmc-highspeed = <2>;
 			cdns,phy-input-delay-mmc-ddr = <3>;
 			cdns,phy-dll-delay-sdclk = <21>;
diff --git a/arch/arm64/boot/dts/socionext/uniphier-ld20.dtsi b/arch/arm64/boot/dts/socionext/uniphier-ld20.dtsi
index 9efe20d..3a5ed78 100644
--- a/arch/arm64/boot/dts/socionext/uniphier-ld20.dtsi
+++ b/arch/arm64/boot/dts/socionext/uniphier-ld20.dtsi
@@ -519,7 +519,7 @@
 			mmc-ddr-1_8v;
 			mmc-hs200-1_8v;
 			mmc-pwrseq = <&emmc_pwrseq>;
-			cdns,phy-input-delay-legacy = <4>;
+			cdns,phy-input-delay-legacy = <9>;
 			cdns,phy-input-delay-mmc-highspeed = <2>;
 			cdns,phy-input-delay-mmc-ddr = <3>;
 			cdns,phy-dll-delay-sdclk = <21>;
diff --git a/arch/arm64/boot/dts/socionext/uniphier-pxs3.dtsi b/arch/arm64/boot/dts/socionext/uniphier-pxs3.dtsi
index 7c8f710..e85d6dd 100644
--- a/arch/arm64/boot/dts/socionext/uniphier-pxs3.dtsi
+++ b/arch/arm64/boot/dts/socionext/uniphier-pxs3.dtsi
@@ -334,7 +334,7 @@
 			mmc-ddr-1_8v;
 			mmc-hs200-1_8v;
 			mmc-pwrseq = <&emmc_pwrseq>;
-			cdns,phy-input-delay-legacy = <4>;
+			cdns,phy-input-delay-legacy = <9>;
 			cdns,phy-input-delay-mmc-highspeed = <2>;
 			cdns,phy-input-delay-mmc-ddr = <3>;
 			cdns,phy-dll-delay-sdclk = <21>;
-- 
2.7.4
