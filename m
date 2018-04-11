Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753469AbeDKOUS (ORCPT <rfc822;w@1wt.eu>);
        Wed, 11 Apr 2018 10:20:18 -0400
Received: from hermes.aosc.io ([199.195.250.187]:48318 "EHLO hermes.aosc.io"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753082AbeDKOUQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Apr 2018 10:20:16 -0400
From: Icenowy Zheng <icenowy@aosc.io>
To: Rob Herring <robh+dt@kernel.org>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Giuseppe Cavallaro <peppe.cavallaro@st.com>,
        Corentin Labbe <clabbe.montjoie@gmail.com>
Cc: netdev@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-sunxi@googlegroups.com, Icenowy Zheng <icenowy@aosc.io>
Subject: [PATCH 1/5] dt-bindings: allow dwmac-sun8i to use other devices' exported regmap
Date: Wed, 11 Apr 2018 22:16:37 +0800
Message-Id: <20180411141641.14675-2-icenowy@aosc.io>
In-Reply-To: <20180411141641.14675-1-icenowy@aosc.io>
References: <20180411141641.14675-1-icenowy@aosc.io>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On some Allwinner SoCs the EMAC clock register needed by dwmac-sun8i is
in another device's memory space. In this situation dwmac-sun8i can use
a regmap exported by the other device with only the EMAC clock register.

Document this situation in the dwmac-sun8i device tree binding
documentation.

Signed-off-by: Icenowy Zheng <icenowy@aosc.io>
---
 Documentation/devicetree/bindings/net/dwmac-sun8i.txt | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/net/dwmac-sun8i.txt b/Documentation/devicetree/bindings/net/dwmac-sun8i.txt
index 3d6d5fa0c4d5..0c5f63a80617 100644
--- a/Documentation/devicetree/bindings/net/dwmac-sun8i.txt
+++ b/Documentation/devicetree/bindings/net/dwmac-sun8i.txt
@@ -20,8 +20,9 @@ Required properties:
 - phy-handle: See ethernet.txt
 - #address-cells: shall be 1
 - #size-cells: shall be 0
-- syscon: A phandle to the syscon of the SoC with one of the following
- compatible string:
+- syscon: A phandle to a device which exports the EMAC clock register as a
+ regmap or to the syscon of the SoC with one of the following compatible
+ string:
   - allwinner,sun8i-h3-system-controller
   - allwinner,sun8i-v3s-system-controller
   - allwinner,sun50i-a64-system-controller
-- 
2.15.1
