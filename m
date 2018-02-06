Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752776AbeBFEvz (ORCPT <rfc822;w@1wt.eu>);
        Mon, 5 Feb 2018 23:51:55 -0500
Received: from hermes.aosc.io ([199.195.250.187]:50411 "EHLO hermes.aosc.io"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752752AbeBFEvn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Feb 2018 23:51:43 -0500
From: Icenowy Zheng <icenowy@aosc.io>
To: Liam Girdwood <lgirdwood@gmail.com>, Rob Herring <robh+dt@kernel.org>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Chen-Yu Tsai <wens@csie.org>
Cc: linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@googlegroups.com,
        Icenowy Zheng <icenowy@aosc.io>
Subject: [PATCH v2 10/10] ARM: sun8i: h3: set the cpu-supply to VDD-CPUX on ALL-H3-CC H3 ver
Date: Tue,  6 Feb 2018 12:49:05 +0800
Message-Id: <20180206044905.30508-11-icenowy@aosc.io>
In-Reply-To: <20180206044905.30508-1-icenowy@aosc.io>
References: <20180206044905.30508-1-icenowy@aosc.io>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The ALL-H3-CC has a fixed VDD-CPUX voltage at 1.2V, which is supplied
by a regulator.

Set the CPU's cpu-supply property to the VDD-CPUX regulator.

Signed-off-by: Icenowy Zheng <icenowy@aosc.io>
---
New patch in v2.

 arch/arm/boot/dts/sun8i-h3-libretech-all-h3-cc.dts | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm/boot/dts/sun8i-h3-libretech-all-h3-cc.dts b/arch/arm/boot/dts/sun8i-h3-libretech-all-h3-cc.dts
index ca974d872357..02eb50b91a8f 100644
--- a/arch/arm/boot/dts/sun8i-h3-libretech-all-h3-cc.dts
+++ b/arch/arm/boot/dts/sun8i-h3-libretech-all-h3-cc.dts
@@ -112,6 +112,10 @@
 	};
 };
 
+&cpu0 {
+	cpu-supply = <&reg_vdd_cpux>;
+};
+
 &codec {
 	allwinner,audio-routing =
 		"Line Out", "LINEOUT",
-- 
2.15.1
