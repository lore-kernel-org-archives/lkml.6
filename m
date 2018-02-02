Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752118AbeBBOEI (ORCPT <rfc822;w@1wt.eu>);
        Fri, 2 Feb 2018 09:04:08 -0500
Received: from hermes.aosc.io ([199.195.250.187]:48300 "EHLO hermes.aosc.io"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752085AbeBBODx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Feb 2018 09:03:53 -0500
From: Icenowy Zheng <icenowy@aosc.io>
To: Maxime Ripard <maxime.ripard@free-electrons.com>,
        Chen-Yu Tsai <wens@csie.org>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-sunxi@googlegroups.com,
        Icenowy Zheng <icenowy@aosc.io>
Subject: [PATCH 3/3] ARM: sun8i: v3s: enable audio on Lichee Pi Zero Dock board
Date: Fri,  2 Feb 2018 22:01:53 +0800
Message-Id: <20180202140153.21549-4-icenowy@aosc.io>
In-Reply-To: <20180202140153.21549-1-icenowy@aosc.io>
References: <20180202140153.21549-1-icenowy@aosc.io>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Lichee Pi Zero Dock board has an audio jack and an onboard MIC.

Enable them.

Signed-off-by: Icenowy Zheng <icenowy@aosc.io>
---
 arch/arm/boot/dts/sun8i-v3s-licheepi-zero-dock.dts | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/arm/boot/dts/sun8i-v3s-licheepi-zero-dock.dts b/arch/arm/boot/dts/sun8i-v3s-licheepi-zero-dock.dts
index d1311098ea45..80f477738668 100644
--- a/arch/arm/boot/dts/sun8i-v3s-licheepi-zero-dock.dts
+++ b/arch/arm/boot/dts/sun8i-v3s-licheepi-zero-dock.dts
@@ -55,6 +55,15 @@
 	};
 };
 
+&codec {
+	allwinner,audio-routing =
+		"Headphone", "HP",
+		"Headphone", "HPCOM",
+		"MIC1", "Mic",
+		"Mic",  "HBIAS";
+	status = "okay";
+};
+
 &mmc1 {
 	broken-cd;
 	bus-width = <4>;
-- 
2.15.1
