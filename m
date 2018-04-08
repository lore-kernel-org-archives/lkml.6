Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751712AbeDHHMR (ORCPT <rfc822;w@1wt.eu>);
        Sun, 8 Apr 2018 03:12:17 -0400
Received: from mail-sh2.amlogic.com ([58.32.228.45]:60776 "EHLO
        mail-sh2.amlogic.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750810AbeDHHMP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Apr 2018 03:12:15 -0400
From: Yixun Lan <yixun.lan@amlogic.com>
To: Kevin Hilman <khilman@baylibre.com>
CC: Yixun Lan <yixun.lan@amlogic.com>, Carlo Caione <carlo@caione.org>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Heiner Kallweit <hkallweit1@gmail.com>, Rob Herring <robh@kernel.org>,
        Xingyu Chen <xingyu.chen@amlogic.com>,
        <linux-amlogic@lists.infradead.org>,
        <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>
Subject: [PATCH] ARM64: dts: meson-axg: add GPIO interrupt controller support
Date: Sun, 8 Apr 2018 15:10:45 +0000
Message-ID: <20180408151045.1138-1-yixun.lan@amlogic.com>
X-Mailer: git-send-email 2.16.2
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.18.20.250]
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the GPIO interrupt controller driver which found in the Amlogic's
Meson-AXG SoC, the controller share the similar ASIC IP as other meson SoCs.

Signed-off-by: Yixun Lan <yixun.lan@amlogic.com>

---
Hi Kevin
 Please note this patch depend on the GPIO interrupt driver here[0]

[0] http://lkml.kernel.org/r/20180408145700.23520-1-yixun.lan@amlogic.com
---
 arch/arm64/boot/dts/amlogic/meson-axg.dtsi | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/arm64/boot/dts/amlogic/meson-axg.dtsi b/arch/arm64/boot/dts/amlogic/meson-axg.dtsi
index b58808eb3cc8..c1105065de99 100644
--- a/arch/arm64/boot/dts/amlogic/meson-axg.dtsi
+++ b/arch/arm64/boot/dts/amlogic/meson-axg.dtsi
@@ -120,6 +120,15 @@
 			#size-cells = <2>;
 			ranges = <0x0 0x0 0x0 0xffd00000 0x0 0x25000>;
 
+			gpio_intc: interrupt-controller@f080 {
+				compatible = "amlogic,meson-gpio-intc";
+				reg = <0x0 0xf080 0x0 0x10>;
+				interrupt-controller;
+				#interrupt-cells = <2>;
+				amlogic,channel-interrupts = <64 65 66 67 68 69 70 71>;
+				status = "disabled";
+			};
+
 			pwm_ab: pwm@1b000 {
 				compatible = "amlogic,meson-axg-ee-pwm";
 				reg = <0x0 0x1b000 0x0 0x20>;
-- 
2.16.2
