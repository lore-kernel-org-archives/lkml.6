Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754014AbeBBSHK (ORCPT <rfc822;w@1wt.eu>);
        Fri, 2 Feb 2018 13:07:10 -0500
Received: from hermes.aosc.io ([199.195.250.187]:54927 "EHLO hermes.aosc.io"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753961AbeBBSGF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Feb 2018 13:06:05 -0500
From: Icenowy Zheng <icenowy@aosc.io>
To: Maxime Ripard <maxime.ripard@free-electrons.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Giuseppe Cavallaro <peppe.cavallaro@st.com>,
        Corentin Labbe <clabbe.montjoie@gmail.com>,
        "David S . Miller" <davem@davemloft.net>
Cc: netdev@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-sunxi@googlegroups.com, Icenowy Zheng <icenowy@aosc.io>
Subject: [PATCH 3/3] ARM: sun8i: v3s: enable Ethernet port on the Lichee Pi Zero Dock
Date: Sat,  3 Feb 2018 02:04:56 +0800
Message-Id: <20180202180456.60378-4-icenowy@aosc.io>
In-Reply-To: <20180202180456.60378-1-icenowy@aosc.io>
References: <20180202180456.60378-1-icenowy@aosc.io>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Lichee Pi Zero Dock has an Ethernet port connected to the internal
PHY of the V3s SoC.

Enable it in the device tree.

Signed-off-by: Icenowy Zheng <icenowy@aosc.io>
---
 arch/arm/boot/dts/sun8i-v3s-licheepi-zero-dock.dts | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm/boot/dts/sun8i-v3s-licheepi-zero-dock.dts b/arch/arm/boot/dts/sun8i-v3s-licheepi-zero-dock.dts
index d1311098ea45..9b3465cc0dcd 100644
--- a/arch/arm/boot/dts/sun8i-v3s-licheepi-zero-dock.dts
+++ b/arch/arm/boot/dts/sun8i-v3s-licheepi-zero-dock.dts
@@ -49,12 +49,20 @@
 	compatible = "licheepi,licheepi-zero-dock", "licheepi,licheepi-zero",
 		     "allwinner,sun8i-v3s";
 
+	aliases {
+		ethernet0 = &emac;
+	};
+
 	leds {
 		/* The LEDs use PG0~2 pins, which conflict with MMC1 */
 		status = "disbaled";
 	};
 };
 
+&emac {
+	status = "okay";
+};
+
 &mmc1 {
 	broken-cd;
 	bus-width = <4>;
-- 
2.15.1
