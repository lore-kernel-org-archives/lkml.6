Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752534AbeENVQx (ORCPT <rfc822;w@1wt.eu>);
        Mon, 14 May 2018 17:16:53 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:34542 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752500AbeENVQs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 May 2018 17:16:48 -0400
From: Enric Balletbo i Serra <enric.balletbo@collabora.com>
To: MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>, Rob Herring <robh+dt@kernel.org>,
        Will Deacon <will.deacon@arm.com>, Heiko Stuebner <heiko@sntech.de>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, Sandy Huang <hjc@rock-chips.com>,
        David Airlie <airlied@linux.ie>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Derek Basehore <dbasehore@chromium.org>, linux-clk@vger.kernel.org,
        linux-rockchip@lists.infradead.org, dri-devel@lists.freedesktop.org,
        Lin Huang <hl@rock-chips.com>, kernel@collabora.com,
        Sean Paul <seanpaul@chromium.org>,
        linux-arm-kernel@lists.infradead.org,
        Nickey Yang <nickey.yang@rock-chips.com>,
        Yakir Yang <kuankuan.y@gmail.com>,
        Shawn Lin <shawn.lin@rock-chips.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Mark Yao <markyao0591@gmail.com>, Jacob Chen <jacob-chen@iotwrt.com>,
        Kever Yang <kever.yang@rock-chips.com>,
        Brian Norris <briannorris@chromium.org>,
        Douglas Anderson <dianders@chromium.org>,
        Jeffy Chen <jeffy.chen@rock-chips.com>,
        Matthias Kaehlcke <mka@chromium.org>, devicetree@vger.kernel.org,
        Caesar Wang <wxt@rock-chips.com>, Chris Zhong <zyw@rock-chips.com>,
        Shunqian Zheng <zhengsq@rock-chips.com>,
        Mark Rutland <mark.rutland@arm.com>
Subject: [RFC PATCH 10/10] arm64: dts: rockchip: Enable dmc and dfi nodes on gru.
Date: Mon, 14 May 2018 23:16:10 +0200
Message-Id: <20180514211610.26618-11-enric.balletbo@collabora.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180514211610.26618-1-enric.balletbo@collabora.com>
References: <20180514211610.26618-1-enric.balletbo@collabora.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Lin Huang <hl@rock-chips.com>

Enable the DMC (Dynamic Memory Controller) and the DFI (DDR PHY Interface)
nodes on gru/kevin boards so we can support DDR DVFS.

Signed-off-by: Lin Huang <hl@rock-chips.com>
Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
---

 arch/arm64/boot/dts/rockchip/rk3399-gru.dtsi | 21 ++++++++++++++++++++
 arch/arm64/boot/dts/rockchip/rk3399.dtsi     |  2 +-
 2 files changed, 22 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/rockchip/rk3399-gru.dtsi b/arch/arm64/boot/dts/rockchip/rk3399-gru.dtsi
index 18f546f2dfd1..ba2cfdd082b8 100644
--- a/arch/arm64/boot/dts/rockchip/rk3399-gru.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3399-gru.dtsi
@@ -525,6 +525,12 @@
 	extcon = <&usbc_extcon0>, <&usbc_extcon1>;
 };
 
+&dmc_opp_table {
+	opp04 {
+		opp-suspend;
+	};
+};
+
 /*
  * Set some suspend operating points to avoid OVP in suspend
  *
@@ -600,6 +606,10 @@
 		<400000000>;
 };
 
+&display_subsystem {
+	devfreq = <&dmc>;
+};
+
 &emmc_phy {
 	status = "okay";
 };
@@ -766,6 +776,17 @@ ap_i2c_audio: &i2c8 {
 	status = "okay";
 };
 
+&dfi {
+	status = "okay";
+};
+
+&dmc {
+	status = "okay";
+	center-supply = <&ppvar_centerlogic>;
+	upthreshold = <25>;
+	downdifferential = <15>;
+};
+
 &sdhci {
 	/*
 	 * Signal integrity isn't great at 200 MHz and 150 MHz (DDR) gives the
diff --git a/arch/arm64/boot/dts/rockchip/rk3399.dtsi b/arch/arm64/boot/dts/rockchip/rk3399.dtsi
index e012cc8ae3d4..518c742293fc 100644
--- a/arch/arm64/boot/dts/rockchip/rk3399.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3399.dtsi
@@ -160,7 +160,7 @@
 		};
 	};
 
-	display-subsystem {
+	display_subsystem: display-subsystem {
 		compatible = "rockchip,display-subsystem";
 		ports = <&vopl_out>, <&vopb_out>;
 	};
-- 
2.17.0
