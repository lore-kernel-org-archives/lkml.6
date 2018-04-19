Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753723AbeDSOLZ (ORCPT <rfc822;w@1wt.eu>);
        Thu, 19 Apr 2018 10:11:25 -0400
Received: from mx2.freebsd.org ([8.8.178.116]:13625 "EHLO mx2.freebsd.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753584AbeDSOLW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Apr 2018 10:11:22 -0400
From: kevans@FreeBSD.org
To: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Chen-Yu Tsai <wens@csie.org>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-sunxi@googlegroups.com,
        Kyle Evans <kevans@FreeBSD.org>
Subject: [PATCH v3] ARM: dts: sunxi: Add sid for a83t
Date: Thu, 19 Apr 2018 09:11:03 -0500
Message-Id: <20180419141103.38196-1-kevans@FreeBSD.org>
X-Mailer: git-send-email 2.17.0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Allwinner a83t has a 1 KB sid block with efuse for security rootkey and thermal
calibration data, add node to describe it.

a83t-sid is not currently supported by nvmem/sunxi-sid, but it is
supported in an external driver for FreeBSD.

Signed-off-by: Kyle Evans <kevans@FreeBSD.org>
---

Changes in v3:
- rebased against 4.17

Changes in v2:
- remove bogus "From:" line in commit text, no functional change

 .../devicetree/bindings/nvmem/allwinner,sunxi-sid.txt        | 1 +
 arch/arm/boot/dts/sun8i-a83t.dtsi                            | 5 +++++
 2 files changed, 6 insertions(+)

diff --git a/Documentation/devicetree/bindings/nvmem/allwinner,sunxi-sid.txt b/Documentation/devicetree/bindings/nvmem/allwinner,sunxi-sid.txt
index d69543701d5d..e319fe5e205a 100644
--- a/Documentation/devicetree/bindings/nvmem/allwinner,sunxi-sid.txt
+++ b/Documentation/devicetree/bindings/nvmem/allwinner,sunxi-sid.txt
@@ -4,6 +4,7 @@ Required properties:
 - compatible: Should be one of the following:
   "allwinner,sun4i-a10-sid"
   "allwinner,sun7i-a20-sid"
+  "allwinner,sun8i-a83t-sid"
   "allwinner,sun8i-h3-sid"
   "allwinner,sun50i-a64-sid"
 
diff --git a/arch/arm/boot/dts/sun8i-a83t.dtsi b/arch/arm/boot/dts/sun8i-a83t.dtsi
index 568307639be8..379981389eea 100644
--- a/arch/arm/boot/dts/sun8i-a83t.dtsi
+++ b/arch/arm/boot/dts/sun8i-a83t.dtsi
@@ -492,6 +492,11 @@
 			#size-cells = <0>;
 		};
 
+		sid: eeprom@1c14000 {
+			compatible = "allwinner,sun8i-a83t-sid";
+			reg = <0x1c14000 0x400>;
+		};
+
 		usb_otg: usb@1c19000 {
 			compatible = "allwinner,sun8i-a83t-musb",
 				     "allwinner,sun8i-a33-musb";
-- 
2.17.0
