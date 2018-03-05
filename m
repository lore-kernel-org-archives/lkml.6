Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934720AbeCELgT (ORCPT <rfc822;w@1wt.eu>);
        Mon, 5 Mar 2018 06:36:19 -0500
Received: from mailgw02.mediatek.com ([210.61.82.184]:52155 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S934691AbeCELgD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Mar 2018 06:36:03 -0500
X-UUID: 05d880d6bcd8407b86ffb36f485389d4-20180305
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
Subject: [PATCH v3 2/4] arm64: dts: mt2712: add pintcrl device node.
Date: Mon, 5 Mar 2018 19:35:43 +0800
Message-ID: <1520249745-6757-3-git-send-email-zhiyong.tao@mediatek.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1520249745-6757-1-git-send-email-zhiyong.tao@mediatek.com>
References: <1520249745-6757-1-git-send-email-zhiyong.tao@mediatek.com>
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
