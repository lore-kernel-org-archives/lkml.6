Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753853AbeBGKXA (ORCPT <rfc822;w@1wt.eu>);
        Wed, 7 Feb 2018 05:23:00 -0500
Received: from mailgw01.mediatek.com ([210.61.82.183]:47870 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1753539AbeBGKW4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Feb 2018 05:22:56 -0500
X-UUID: a57860025d974894858f14b21fa847c6-20180207
From: <sean.wang@mediatek.com>
To: <robh+dt@kernel.org>, <matthias.bgg@gmail.com>, <rjw@rjwysocki.net>,
        <khilman@baylibre.com>
CC: <ulf.hansson@linaro.org>, <devicetree@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>, <linux-pm@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        Sean Wang <sean.wang@mediatek.com>
Subject: [PATCH v2 1/4] dt-bindings: soc: add SCPSYS binding for MT7623 and MT7623A SoC
Date: Wed, 7 Feb 2018 18:22:47 +0800
Message-ID: <ecfc548fc3d22aa335b50e552ad2ad88427a0bb2.1517998367.git.sean.wang@mediatek.com>
X-Mailer: git-send-email 1.7.9.5
MIME-Version: 1.0
Content-Type: text/plain
X-MTK: N
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sean Wang <sean.wang@mediatek.com>

document the binding for enabling SCPSYS on MediaTek MT7623 and MT7623A
SoC. Where MT7623 SoC has the same definition about power domains with
MT2701, so it's fine to using MT2701 ones as MT7623's fallback.

Signed-off-by: Sean Wang <sean.wang@mediatek.com>
Reviewed-by: Rob Herring <robh@kernel.org>
---
 Documentation/devicetree/bindings/soc/mediatek/scpsys.txt | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/soc/mediatek/scpsys.txt b/Documentation/devicetree/bindings/soc/mediatek/scpsys.txt
index 76bf45b..d6fe16f 100644
--- a/Documentation/devicetree/bindings/soc/mediatek/scpsys.txt
+++ b/Documentation/devicetree/bindings/soc/mediatek/scpsys.txt
@@ -21,6 +21,8 @@ Required properties:
 	- "mediatek,mt2712-scpsys"
 	- "mediatek,mt6797-scpsys"
 	- "mediatek,mt7622-scpsys"
+	- "mediatek,mt7623-scpsys", "mediatek,mt2701-scpsys": For MT7623 SoC
+	- "mediatek,mt7623a-scpsys": For MT7623A SoC
 	- "mediatek,mt8173-scpsys"
 - #power-domain-cells: Must be 1
 - reg: Address range of the SCPSYS unit
@@ -28,10 +30,11 @@ Required properties:
 - clock, clock-names: clocks according to the common clock binding.
                       These are clocks which hardware needs to be
                       enabled before enabling certain power domains.
-	Required clocks for MT2701: "mm", "mfg", "ethif"
+	Required clocks for MT2701 or MT7623: "mm", "mfg", "ethif"
 	Required clocks for MT2712: "mm", "mfg", "venc", "jpgdec", "audio", "vdec"
 	Required clocks for MT6797: "mm", "mfg", "vdec"
 	Required clocks for MT7622: "hif_sel"
+	Required clocks for MT7622A: "ethif"
 	Required clocks for MT8173: "mm", "mfg", "venc", "venc_lt"
 
 Optional properties:
-- 
2.7.4
