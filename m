Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754237AbeDJPAt (ORCPT <rfc822;w@1wt.eu>);
        Tue, 10 Apr 2018 11:00:49 -0400
Received: from mx1.mpynet.fi ([82.197.21.84]:28927 "EHLO mx1.mpynet.fi"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753089AbeDJPAq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Apr 2018 11:00:46 -0400
From: Tuomas Tynkkynen <tuomas@tuxera.com>
To: Maxime Ripard <maxime.ripard@free-electrons.com>,
        Chen-Yu Tsai <wens@csie.org>
CC: Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        <devicetree@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, Tuomas Tynkkynen <tuomas@tuxera.com>
Subject: [PATCH] ARM: dts: sunxi: Change sun7i-a20-olimex-som204-evb to not use cd-inverted
Date: Tue, 10 Apr 2018 17:51:19 +0300
Message-ID: <20180410145119.27362-1-tuomas@tuxera.com>
X-Mailer: git-send-email 2.16.3
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: tuxera-exch.ad.tuxera.com (10.20.48.11) To
 tuxera-exch.ad.tuxera.com (10.20.48.11)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit 45e01f401a2a16 ("ARM: dts: sunxi: Switch MMC nodes away from
cd-inverted property") changed most of the sunxi boards away from using
the cd-inverted property in MMC nodes. However, the
sun7i-a20-olimex-som204-evb board which got merged concurrently with
that commit is now using cd-inverted. Switch it away from using
cd-inverted to be consistent with rest of the sunxi boards.

Signed-off-by: Tuomas Tynkkynen <tuomas@tuxera.com>
---
 arch/arm/boot/dts/sun7i-a20-olimex-som204-evb.dts | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/sun7i-a20-olimex-som204-evb.dts b/arch/arm/boot/dts/sun7i-a20-olimex-som204-evb.dts
index eae8e267b9ef..3d7b5c848fef 100644
--- a/arch/arm/boot/dts/sun7i-a20-olimex-som204-evb.dts
+++ b/arch/arm/boot/dts/sun7i-a20-olimex-som204-evb.dts
@@ -172,8 +172,7 @@
 	pinctrl-0 = <&mmc0_pins_a>;
 	vmmc-supply = <&reg_vcc3v3>;
 	bus-width = <4>;
-	cd-gpios = <&pio 7 1 GPIO_ACTIVE_HIGH>;
-	cd-inverted;
+	cd-gpios = <&pio 7 1 GPIO_ACTIVE_LOW>;
 	status = "okay";
 };
 
-- 
2.16.3
