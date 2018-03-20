Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752176AbeCTCsb (ORCPT <rfc822;w@1wt.eu>);
        Mon, 19 Mar 2018 22:48:31 -0400
Received: from mx.socionext.com ([202.248.49.38]:15788 "EHLO mx.socionext.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751734AbeCTCs2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Mar 2018 22:48:28 -0400
From: Katsuhiro Suzuki <suzuki.katsuhiro@socionext.com>
To: linux-arm-kernel@lists.infradead.org,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        devicetree@vger.kernel.org
Cc: Masami Hiramatsu <masami.hiramatsu@linaro.org>,
        Jassi Brar <jaswinder.singh@linaro.org>, linux-kernel@vger.kernel.org,
        Katsuhiro Suzuki <suzuki.katsuhiro@socionext.com>
Subject: [PATCH v2 1/2] arm64: dts: uniphier: add syscon property for UniPhier sound system
Date: Tue, 20 Mar 2018 11:48:23 +0900
Message-Id: <20180320024824.28902-1-suzuki.katsuhiro@socionext.com>
X-Mailer: git-send-email 2.16.2
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds syscon property for specifying soc-glue core into
device-tree of LD11/LD20 SoC.

Currently, soc-glue core is used for changing the state of S/PDIF
signal output pin to signal output state or Hi-Z state.

Signed-off-by: Katsuhiro Suzuki <suzuki.katsuhiro@socionext.com>
---
 arch/arm64/boot/dts/socionext/uniphier-ld11.dtsi | 3 ++-
 arch/arm64/boot/dts/socionext/uniphier-ld20.dtsi | 3 ++-
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/socionext/uniphier-ld11.dtsi b/arch/arm64/boot/dts/socionext/uniphier-ld11.dtsi
index efa95573b2aa..e62bda1cf2d9 100644
--- a/arch/arm64/boot/dts/socionext/uniphier-ld11.dtsi
+++ b/arch/arm64/boot/dts/socionext/uniphier-ld11.dtsi
@@ -197,6 +197,7 @@
 			reset-names = "aio";
 			resets = <&sys_rst 40>;
 			#sound-dai-cells = <1>;
+			socionext,syscon = <&soc_glue>;
 
 			i2s_port0: port@0 {
 				i2s_hdmi: endpoint {
@@ -479,7 +480,7 @@
 			};
 		};
 
-		soc-glue@5f800000 {
+		soc_glue: soc-glue@5f800000 {
 			compatible = "socionext,uniphier-ld11-soc-glue",
 				     "simple-mfd", "syscon";
 			reg = <0x5f800000 0x2000>;
diff --git a/arch/arm64/boot/dts/socionext/uniphier-ld20.dtsi b/arch/arm64/boot/dts/socionext/uniphier-ld20.dtsi
index 19c935688a77..9efe20d07589 100644
--- a/arch/arm64/boot/dts/socionext/uniphier-ld20.dtsi
+++ b/arch/arm64/boot/dts/socionext/uniphier-ld20.dtsi
@@ -297,6 +297,7 @@
 			reset-names = "aio";
 			resets = <&sys_rst 40>;
 			#sound-dai-cells = <1>;
+			socionext,syscon = <&soc_glue>;
 
 			i2s_port0: port@0 {
 				i2s_hdmi: endpoint {
@@ -525,7 +526,7 @@
 			cdns,phy-dll-delay-sdclk-hsmmc = <21>;
 		};
 
-		soc-glue@5f800000 {
+		soc_glue: soc-glue@5f800000 {
 			compatible = "socionext,uniphier-ld20-soc-glue",
 				     "simple-mfd", "syscon";
 			reg = <0x5f800000 0x2000>;
-- 
2.16.2
