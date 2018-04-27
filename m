Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757703AbeD0IPF (ORCPT <rfc822;w@1wt.eu>);
        Fri, 27 Apr 2018 04:15:05 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:52899 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1757650AbeD0IPC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Apr 2018 04:15:02 -0400
X-UUID: ea93953e2edb49679cc78833dd920f65-20180427
From: <sean.wang@mediatek.com>
To: <sboyd@codeaurora.org>, <mturquette@baylibre.com>,
        <robh+dt@kernel.org>, <matthias.bgg@gmail.com>, <mark.rutland@arm.com>,
        <p.zabel@pengutronix.de>
CC: <devicetree@vger.kernel.org>, <linux-mediatek@lists.infradead.org>,
        <linux-clk@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, Sean Wang <sean.wang@mediatek.com>
Subject: [PATCH v2 1/6] dt-bindings: gpu: mali-utgard: add mediatek,mt7623-mali compatible
Date: Fri, 27 Apr 2018 16:14:42 +0800
Message-ID: <7ab060c2e9ef2b220fc62913b8936b706dfaf202.1524816502.git.sean.wang@mediatek.com>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <cover.1524816502.git.sean.wang@mediatek.com>
References: <cover.1524816502.git.sean.wang@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK: N
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sean Wang <sean.wang@mediatek.com>

The MediaTek MT7623 SoC contains a Mali-450, so add a compatible for it
and define its own vendor-specific properties.

Reviewed-by: Rob Herring <robh@kernel.org>
Signed-off-by: Sean Wang <sean.wang@mediatek.com>
---
 Documentation/devicetree/bindings/gpu/arm,mali-utgard.txt | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/Documentation/devicetree/bindings/gpu/arm,mali-utgard.txt b/Documentation/devicetree/bindings/gpu/arm,mali-utgard.txt
index 99d1c0a..656068f 100644
--- a/Documentation/devicetree/bindings/gpu/arm,mali-utgard.txt
+++ b/Documentation/devicetree/bindings/gpu/arm,mali-utgard.txt
@@ -19,6 +19,7 @@ Required properties:
       + rockchip,rk3228-mali
       + rockchip,rk3328-mali
       + stericsson,db8500-mali
+      + mediatek,mt7623-mali
 
   - reg: Physical base address and length of the GPU registers
 
@@ -89,6 +90,14 @@ to specify one more vendor-specific compatible, among:
       * interrupt-names and interrupts:
         + combined: combined interrupt of all of the above lines
 
+  - mediatek,mt7623-mali
+     Required properties:
+      * resets: phandle to the reset line for the GPU
+      * mediatek,larb: phandle pointed to the local arbiter used to control the
+	access to external memory on the SoC.
+	see Documentation/devicetree/bindings/memory-controllers/mediatek,smi-larb.txt
+	for details
+
 Example:
 
 mali: gpu@1c40000 {
-- 
2.7.4
