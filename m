Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751685AbeBQT5n (ORCPT <rfc822;w@1wt.eu>);
        Sat, 17 Feb 2018 14:57:43 -0500
Received: from mailgw02.mediatek.com ([210.61.82.184]:19330 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751271AbeBQTzH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Feb 2018 14:55:07 -0500
X-UUID: 6a6588bb2e034c7faf034bff86e4edf7-20180218
From: <sean.wang@mediatek.com>
To: <robh+dt@kernel.org>, <matthias.bgg@gmail.com>, <mark.rutland@arm.com>,
        <devicetree@vger.kernel.org>, <linux-mediatek@lists.infradead.org>
CC: <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        Sean Wang <sean.wang@mediatek.com>, Rob Herring <robh@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@codeaurora.org>, <linux-clk@vger.kernel.org>
Subject: [PATCH v3 01/15] dt-bindings: clock: mediatek: add missing required #reset-cells
Date: Sun, 18 Feb 2018 03:54:36 +0800
Message-ID: <7365f2286ff2cebcfb590715cb4a15dedd089046.1518895232.git.sean.wang@mediatek.com>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <cover.1518895232.git.sean.wang@mediatek.com>
References: <cover.1518895232.git.sean.wang@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK: N
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sean Wang <sean.wang@mediatek.com>

All ethsys, pciesys and ssusbsys internally include reset controller, so
explicitly add back these missing cell definitions to related bindings
and examples.

Signed-off-by: Sean Wang <sean.wang@mediatek.com>
Cc: Rob Herring <robh@kernel.org>
Cc: Michael Turquette <mturquette@baylibre.com>
Cc: Stephen Boyd <sboyd@codeaurora.org>
Cc: linux-clk@vger.kernel.org
Reviewed-by: Rob Herring <robh@kernel.org>
---
 Documentation/devicetree/bindings/arm/mediatek/mediatek,ethsys.txt   | 1 +
 Documentation/devicetree/bindings/arm/mediatek/mediatek,pciesys.txt  | 2 ++
 Documentation/devicetree/bindings/arm/mediatek/mediatek,ssusbsys.txt | 2 ++
 3 files changed, 5 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/mediatek/mediatek,ethsys.txt b/Documentation/devicetree/bindings/arm/mediatek/mediatek,ethsys.txt
index 6cc7840..8f5335b 100644
--- a/Documentation/devicetree/bindings/arm/mediatek/mediatek,ethsys.txt
+++ b/Documentation/devicetree/bindings/arm/mediatek/mediatek,ethsys.txt
@@ -9,6 +9,7 @@ Required Properties:
 	- "mediatek,mt2701-ethsys", "syscon"
 	- "mediatek,mt7622-ethsys", "syscon"
 - #clock-cells: Must be 1
+- #reset-cells: Must be 1
 
 The ethsys controller uses the common clk binding from
 Documentation/devicetree/bindings/clock/clock-bindings.txt
diff --git a/Documentation/devicetree/bindings/arm/mediatek/mediatek,pciesys.txt b/Documentation/devicetree/bindings/arm/mediatek/mediatek,pciesys.txt
index d5d5f12..7fe5dc6 100644
--- a/Documentation/devicetree/bindings/arm/mediatek/mediatek,pciesys.txt
+++ b/Documentation/devicetree/bindings/arm/mediatek/mediatek,pciesys.txt
@@ -8,6 +8,7 @@ Required Properties:
 - compatible: Should be:
 	- "mediatek,mt7622-pciesys", "syscon"
 - #clock-cells: Must be 1
+- #reset-cells: Must be 1
 
 The PCIESYS controller uses the common clk binding from
 Documentation/devicetree/bindings/clock/clock-bindings.txt
@@ -19,4 +20,5 @@ pciesys: pciesys@1a100800 {
 	compatible = "mediatek,mt7622-pciesys", "syscon";
 	reg = <0 0x1a100800 0 0x1000>;
 	#clock-cells = <1>;
+	#reset-cells = <1>;
 };
diff --git a/Documentation/devicetree/bindings/arm/mediatek/mediatek,ssusbsys.txt b/Documentation/devicetree/bindings/arm/mediatek/mediatek,ssusbsys.txt
index 00760019..b8184da 100644
--- a/Documentation/devicetree/bindings/arm/mediatek/mediatek,ssusbsys.txt
+++ b/Documentation/devicetree/bindings/arm/mediatek/mediatek,ssusbsys.txt
@@ -8,6 +8,7 @@ Required Properties:
 - compatible: Should be:
 	- "mediatek,mt7622-ssusbsys", "syscon"
 - #clock-cells: Must be 1
+- #reset-cells: Must be 1
 
 The SSUSBSYS controller uses the common clk binding from
 Documentation/devicetree/bindings/clock/clock-bindings.txt
@@ -19,4 +20,5 @@ ssusbsys: ssusbsys@1a000000 {
 	compatible = "mediatek,mt7622-ssusbsys", "syscon";
 	reg = <0 0x1a000000 0 0x1000>;
 	#clock-cells = <1>;
+	#reset-cells = <1>;
 };
-- 
2.7.4
