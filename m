Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754716AbeBGQcE (ORCPT <rfc822;w@1wt.eu>);
        Wed, 7 Feb 2018 11:32:04 -0500
Received: from bhuna.collabora.co.uk ([46.235.227.227]:42330 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754421AbeBGQcC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Feb 2018 11:32:02 -0500
From: Enric Balletbo i Serra <enric.balletbo@collabora.com>
To: Heiko Stuebner <heiko@sntech.de>
Cc: Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Brian Norris <briannorris@chromium.org>, groeck@chromium.org,
        devicetree@vger.kernel.org, linux-rockchip@lists.infradead.org,
        linux-kernel@vger.kernel.org, Yakir Yang <ykk@rock-chips.com>
Subject: [PATCH 1/3] arm64: dts: rockchip: introduce pclk_vio_grf in eDP device node
Date: Wed,  7 Feb 2018 17:31:48 +0100
Message-Id: <20180207163150.16332-1-enric.balletbo@collabora.com>
X-Mailer: git-send-email 2.15.1
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yakir Yang <ykk@rock-chips.com>

The pclk_vio_grf supply power for VIO GRF IOs, if it is disabled,
driver would failed to operate the VIO GRF registers.

The clock is optional but one of the side effects of don't have this clk
is that the Samsung Chromebook Plus fails to recover display after a
suspend/resume with following errors:

    rockchip-dp ff970000.edp: Input stream clock not detected.
    rockchip-dp ff970000.edp: Timeout of video streamclk ok
    rockchip-dp ff970000.edp: unable to config video

Signed-off-by: Yakir Yang <ykk@rock-chips.com>
Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
---
 arch/arm64/boot/dts/rockchip/rk3399.dtsi | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/rockchip/rk3399.dtsi b/arch/arm64/boot/dts/rockchip/rk3399.dtsi
index 9551e773ff78..beef28f7309d 100644
--- a/arch/arm64/boot/dts/rockchip/rk3399.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3399.dtsi
@@ -1741,8 +1741,8 @@
 		compatible = "rockchip,rk3399-edp";
 		reg = <0x0 0xff970000 0x0 0x8000>;
 		interrupts = <GIC_SPI 10 IRQ_TYPE_LEVEL_HIGH 0>;
-		clocks = <&cru PCLK_EDP>, <&cru PCLK_EDP_CTRL>;
-		clock-names = "dp", "pclk";
+		clocks = <&cru PCLK_EDP>, <&cru PCLK_EDP_CTRL>, <&cru PCLK_VIO_GRF>;
+		clock-names = "dp", "pclk", "grf";
 		pinctrl-names = "default";
 		pinctrl-0 = <&edp_hpd>;
 		power-domains = <&power RK3399_PD_EDP>;
-- 
2.15.1
