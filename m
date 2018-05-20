Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752643AbeETRC0 (ORCPT <rfc822;w@1wt.eu>);
        Sun, 20 May 2018 13:02:26 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:47217 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751521AbeETRCT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 May 2018 13:02:19 -0400
X-UUID: 41caa3c3a5824d9c9ed7d58f72e462e3-20180521
From: <sean.wang@mediatek.com>
To: <robh+dt@kernel.org>, <mark.rutland@arm.com>,
        <linus.walleij@linaro.org>, <matthias.bgg@gmail.com>,
        <devicetree@vger.kernel.org>, <linux-mediatek@lists.infradead.org>
CC: <linux-arm-kernel@lists.infradead.org>, <linux-gpio@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Sean Wang <sean.wang@mediatek.com>
Subject: [PATCH v1 7/7] arm64: dts: mt7622: add EINT support to pinctrl
Date: Mon, 21 May 2018 01:01:53 +0800
Message-ID: <f896f79ebfa9a262c89fdeed89cf086220ca051d.1526835466.git.sean.wang@mediatek.com>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <cover.1526835466.git.sean.wang@mediatek.com>
References: <cover.1526835466.git.sean.wang@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK: N
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sean Wang <sean.wang@mediatek.com>

Add EINT support to pinctrl and set those GPIO keys as interrupt-driven
keys.

Signed-off-by: Sean Wang <sean.wang@mediatek.com>
---
 arch/arm64/boot/dts/mediatek/mt7622-rfb1.dts | 2 +-
 arch/arm64/boot/dts/mediatek/mt7622.dtsi     | 8 +++++++-
 2 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/mediatek/mt7622-rfb1.dts b/arch/arm64/boot/dts/mediatek/mt7622-rfb1.dts
index b783764..1ff003e 100644
--- a/arch/arm64/boot/dts/mediatek/mt7622-rfb1.dts
+++ b/arch/arm64/boot/dts/mediatek/mt7622-rfb1.dts
@@ -34,7 +34,7 @@
 	};
 
 	gpio-keys {
-		compatible = "gpio-keys-polled";
+		compatible = "gpio-keys";
 		poll-interval = <100>;
 
 		factory {
diff --git a/arch/arm64/boot/dts/mediatek/mt7622.dtsi b/arch/arm64/boot/dts/mediatek/mt7622.dtsi
index 9213c96..e2c5450 100644
--- a/arch/arm64/boot/dts/mediatek/mt7622.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt7622.dtsi
@@ -286,9 +286,15 @@
 
 	pio: pinctrl@10211000 {
 		compatible = "mediatek,mt7622-pinctrl";
-		reg = <0 0x10211000 0 0x1000>;
+		reg = <0 0x10211000 0 0x1000>,
+		      <0 0x10005000 0 0x1000>;
+		reg-names = "base", "eint";
 		gpio-controller;
 		#gpio-cells = <2>;
+		interrupt-controller;
+		interrupts = <GIC_SPI 153 IRQ_TYPE_LEVEL_HIGH>;
+		interrupt-parent = <&gic>;
+		#interrupt-cells = <2>;
 	};
 
 	watchdog: watchdog@10212000 {
-- 
2.7.4
