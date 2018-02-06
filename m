Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752858AbeBFJ5S (ORCPT <rfc822;w@1wt.eu>);
        Tue, 6 Feb 2018 04:57:18 -0500
Received: from mailgw01.mediatek.com ([210.61.82.183]:46245 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1752256AbeBFJxQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Feb 2018 04:53:16 -0500
X-UUID: 180fc33fa4674957bd72876a89e93b74-20180206
From: <sean.wang@mediatek.com>
To: <robh+dt@kernel.org>, <matthias.bgg@gmail.com>, <mark.rutland@arm.com>,
        <devicetree@vger.kernel.org>, <linux-mediatek@lists.infradead.org>
CC: <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        Sean Wang <sean.wang@mediatek.com>, Rob Herring <robh@kernel.org>,
        Stephen Boyd <sboyd@codeaurora.org>
Subject: [PATCH v2 01/16] dt-bindings: clock: mediatek: add missing required #reset-cells
Date: Tue, 6 Feb 2018 17:52:50 +0800
Message-ID: <d58fcf36319254d6de4c7fe100cbdca1bbec27a5.1517910489.git.sean.wang@mediatek.com>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <cover.1517910489.git.sean.wang@mediatek.com>
References: <cover.1517910489.git.sean.wang@mediatek.com>
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
Cc: Stephen Boyd <sboyd@codeaurora.org>
Reviewed-by: Rob Herring <robh@kernel.org>
---
 Documentation/devicetree/bindings/arm/mediatek/mediatek,ethsys.txt   | 2 ++
 Documentation/devicetree/bindings/arm/mediatek/mediatek,pciesys.txt  | 2 ++
 Documentation/devicetree/bindings/arm/mediatek/mediatek,ssusbsys.txt | 2 ++
 3 files changed, 6 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/mediatek/mediatek,ethsys.txt b/Documentation/devicetree/bindings/arm/mediatek/mediatek,ethsys.txt
index 7aa3fa1..8f5335b 100644
--- a/Documentation/devicetree/bindings/arm/mediatek/mediatek,ethsys.txt
+++ b/Documentation/devicetree/bindings/arm/mediatek/mediatek,ethsys.txt
@@ -9,6 +9,7 @@ Required Properties:
 	- "mediatek,mt2701-ethsys", "syscon"
 	- "mediatek,mt7622-ethsys", "syscon"
 - #clock-cells: Must be 1
+- #reset-cells: Must be 1
 
 The ethsys controller uses the common clk binding from
 Documentation/devicetree/bindings/clock/clock-bindings.txt
@@ -20,4 +21,5 @@ ethsys: clock-controller@1b000000 {
 	compatible = "mediatek,mt2701-ethsys", "syscon";
 	reg = <0 0x1b000000 0 0x1000>;
 	#clock-cells = <1>;
+	#reset-cells = <1>;
 };
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
