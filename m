Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752484AbeCTCse (ORCPT <rfc822;w@1wt.eu>);
        Mon, 19 Mar 2018 22:48:34 -0400
Received: from mx.socionext.com ([202.248.49.38]:15791 "EHLO mx.socionext.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750949AbeCTCsa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Mar 2018 22:48:30 -0400
From: Katsuhiro Suzuki <suzuki.katsuhiro@socionext.com>
To: linux-arm-kernel@lists.infradead.org,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        devicetree@vger.kernel.org
Cc: Masami Hiramatsu <masami.hiramatsu@linaro.org>,
        Jassi Brar <jaswinder.singh@linaro.org>, linux-kernel@vger.kernel.org,
        Katsuhiro Suzuki <suzuki.katsuhiro@socionext.com>
Subject: [PATCH v2 2/2] ARM: dts: uniphier: add syscon property for UniPhier sound system
Date: Tue, 20 Mar 2018 11:48:24 +0900
Message-Id: <20180320024824.28902-2-suzuki.katsuhiro@socionext.com>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180320024824.28902-1-suzuki.katsuhiro@socionext.com>
References: <20180320024824.28902-1-suzuki.katsuhiro@socionext.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds syscon property for specifying soc-glue core into
device-tree of PXs2 SoC.

Currently, soc-glue core is used for changing the state of S/PDIF
signal output pin to signal output state or Hi-Z state.

Signed-off-by: Katsuhiro Suzuki <suzuki.katsuhiro@socionext.com>
---
 arch/arm/boot/dts/uniphier-pxs2.dtsi | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/uniphier-pxs2.dtsi b/arch/arm/boot/dts/uniphier-pxs2.dtsi
index 595045441c9c..debcbd15c24b 100644
--- a/arch/arm/boot/dts/uniphier-pxs2.dtsi
+++ b/arch/arm/boot/dts/uniphier-pxs2.dtsi
@@ -242,6 +242,7 @@
 			reset-names = "aio";
 			resets = <&sys_rst 40>;
 			#sound-dai-cells = <1>;
+			socionext,syscon = <&soc_glue>;
 
 			i2s_port0: port@0 {
 				i2s_hdmi: endpoint {
@@ -418,7 +419,7 @@
 			};
 		};
 
-		soc-glue@5f800000 {
+		soc_glue: soc-glue@5f800000 {
 			compatible = "socionext,uniphier-pxs2-soc-glue",
 				     "simple-mfd", "syscon";
 			reg = <0x5f800000 0x2000>;
-- 
2.16.2
