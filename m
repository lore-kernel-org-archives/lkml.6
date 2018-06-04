Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751354AbeFDRQS (ORCPT <rfc822;w@1wt.eu>);
        Mon, 4 Jun 2018 13:16:18 -0400
Received: from mout.gmx.net ([212.227.17.22]:48799 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750987AbeFDRQQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jun 2018 13:16:16 -0400
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
To: Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>, Heiko Stuebner <heiko@sntech.de>,
        Shawn Lin <shawn.lin@rock-chips.com>,
        Vagrant Cascadian <vagrant@debian.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Pierre-Hugues Husson <phh@phh.me>, Jianqun Xu <jay.xu@rock-chips.com>,
        Kever Yang <kever.yang@rock-chips.com>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        Heinrich Schuchardt <xypron.glpk@gmx.de>
Subject: [PATCH 1/1] arm64: dts: rockchip: correct voltage selector Firefly-RK3399
Date: Mon,  4 Jun 2018 19:15:23 +0200
Message-Id: <20180604171523.28454-1-xypron.glpk@gmx.de>
X-Mailer: git-send-email 2.17.1
X-Provags-ID: V03:K1:Lbv6wA/j7fgagAN++ULMMkM7jVhWx8vYo3cCFNRJgoMaNJ7SQ7/
 ZyAvO2oo0ESAbb3MfQrBVcA6cR4f5gaK6A7ZX7AjZCo2+bMySR/dQw6c2FuBZl9ggm4oy/N
 yflalbmI30L7JurtN2iXM5IwO6UqUw7D2VCvTaUM41o/q541bjpjzcsdcvnNy97T00zHhDs
 hA1WpPrOZ8zCEI6yVM8Cg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:FP+NKcw2tyY=:yKYaInVpIIz7Ce5q73NF1Q
 VV4s2/0AhSHYoYUWWIU/InjmDxrDMagbVa9S+7+A6Koqr4j7f2OKRbp530wASl1Y7aYpstz6w
 ZKMwIUN3Qw+WirjP5kmuEou/iS0jenDSuiG4JDFy9bnNdURzeB4ziDpEYRp8A+NkPV1CaqCx8
 COMX7MlR5sHXGPAdECJZB5085itO3PpZngjc0y3YBruAOO2IgHXEccukIarFuV+hgYD5gMuK/
 aqPKfsjzpwbFePXy9ofqdt0WZ12D29IcGBHovXSHCCKasY960edX7aCR1Pths9xu4kzOOoD80
 GNVm/Lued7k3Rk3ryGEawAh/muRBjme3g8wKkuo2NmLDHpfL+po98De+Uiut7iAvnlW4CK0P7
 ifCPOYw/EsHe4jFvxN1dGyDk0PyEkxy3/1F7ORZqpE8L+kK+jE786UdIzF0+ChVf3F2xZsVPp
 z9pxNRIK81vj9zQtMW8d/4ccuCjP0RUzFdQV36CWumJH2LWWfntSE0Aszs81K7tX3Yr129ltR
 8X9MMkz7EmHfKVvIa4Es8mW6rP4NkLQjTDNxcIPi1AiEEl01hFZIRayeokplyuDT8SX5xUAi4
 xX2yXUK8RZSaWlFneFCOWuarQXzxlawRxUN+HV2W+z76bY9vBIzcU4nVVTbO7X6/nlj+XtpL2
 3iOVcwZsfEpJmOuuz4PcQfP2pE1AvZ1UM/osNvBOcmXM9u8kcOfVeKezZav2Y3180cpLOF4NL
 m4pYxSbrZcXm8KYl/80QRWs+Wl75cnMOWiq9UiFVNL1zI50FxxqbT+AYn6c=
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Without this patch the Firefly-RK3399 board boot process hangs after these
lines:

   fan53555-regulator 0-0040: FAN53555 Option[8] Rev[1] Detected!
   fan53555-reg: supplied by vcc_sys
   vcc1v8_s3: supplied by vcc_1v8

Blacklisting driver fan53555 allows booting.

The device tree uses a value of fcs,suspend-voltage-selector different to
any other board.

Changing this setting to the usual value is sufficient to enable booting.

Signed-off-by: Heinrich Schuchardt <xypron.glpk@gmx.de>
---
 arch/arm64/boot/dts/rockchip/rk3399-firefly.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/rockchip/rk3399-firefly.dts b/arch/arm64/boot/dts/rockchip/rk3399-firefly.dts
index 4f28628aa091..50940ef844a7 100644
--- a/arch/arm64/boot/dts/rockchip/rk3399-firefly.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3399-firefly.dts
@@ -458,7 +458,7 @@
 	vdd_cpu_b: regulator@40 {
 		compatible = "silergy,syr827";
 		reg = <0x40>;
-		fcs,suspend-voltage-selector = <0>;
+		fcs,suspend-voltage-selector = <1>;
 		regulator-name = "vdd_cpu_b";
 		regulator-min-microvolt = <712500>;
 		regulator-max-microvolt = <1500000>;
-- 
2.17.1
