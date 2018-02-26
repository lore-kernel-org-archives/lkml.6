Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752460AbeBZIgi (ORCPT <rfc822;w@1wt.eu>);
        Mon, 26 Feb 2018 03:36:38 -0500
Received: from mailgw02.mediatek.com ([210.61.82.184]:60050 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751575AbeBZIeP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Feb 2018 03:34:15 -0500
X-UUID: 0971185db2ad48cd898d63a30c79b535-20180226
From: Zhiyong Tao <zhiyong.tao@mediatek.com>
To: <robh+dt@kernel.org>, <linus.walleij@linaro.org>,
        <mark.rutland@arm.com>, <matthias.bgg@gmail.com>
CC: <srv_heupstream@mediatek.com>, <liguo.zhang@mediatek.com>,
        <yingjoe.chen@mediatek.com>, <hongkun.cao@mediatek.com>,
        <biao.huang@mediatek.com>, <yt.shen@mediatek.com>,
        <hongzhou.yang@mediatek.com>, <erin.lo@mediatek.com>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>, <linux-gpio@vger.kernel.org>,
        Zhiyong Tao <zhiyong.tao@mediatek.com>
Subject: [PATCH v2 2/4] arm64: dts: mt2712: add pintcrl device node.
Date: Mon, 26 Feb 2018 16:34:00 +0800
Message-ID: <1519634042-12063-3-git-send-email-zhiyong.tao@mediatek.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1519634042-12063-1-git-send-email-zhiyong.tao@mediatek.com>
References: <1519634042-12063-1-git-send-email-zhiyong.tao@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK: N
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds pintcrl device node for mt2712.

Signed-off-by: Zhiyong Tao <zhiyong.tao@mediatek.com>
---
 arch/arm64/boot/dts/mediatek/mt2712e.dtsi | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/arch/arm64/boot/dts/mediatek/mt2712e.dtsi b/arch/arm64/boot/dts/mediatek/mt2712e.dtsi
index d7688bc..fb3b051 100644
--- a/arch/arm64/boot/dts/mediatek/mt2712e.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt2712e.dtsi
@@ -9,6 +9,7 @@
 #include <dt-bindings/interrupt-controller/irq.h>
 #include <dt-bindings/interrupt-controller/arm-gic.h>
 #include <dt-bindings/power/mt2712-power.h>
+#include "mt2712-pinfunc.h"
 
 / {
 	compatible = "mediatek,mt2712";
@@ -258,6 +259,23 @@
 		#clock-cells = <1>;
 	};
 
+	syscfg_pctl_a: syscfg_pctl_a@10005000 {
+		compatible = "mediatek,mt2712-pctl-a-syscfg", "syscon";
+		reg = <0 0x10005000 0 0x1000>;
+	};
+
+	pio: pinctrl@10005000 {
+		compatible = "mediatek,mt2712-pinctrl";
+		reg = <0 0x1000b000 0 0x1000>;
+		mediatek,pctl-regmap = <&syscfg_pctl_a>;
+		pins-are-numbered;
+		gpio-controller;
+		#gpio-cells = <2>;
+		interrupt-controller;
+		#interrupt-cells = <2>;
+		interrupts = <GIC_SPI 153 IRQ_TYPE_LEVEL_HIGH>;
+	};
+
 	scpsys: scpsys@10006000 {
 		compatible = "mediatek,mt2712-scpsys", "syscon";
 		#power-domain-cells = <1>;
-- 
1.9.1
