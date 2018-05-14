Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752580AbeENVRL (ORCPT <rfc822;w@1wt.eu>);
        Mon, 14 May 2018 17:17:11 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:34518 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752465AbeENVQr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 May 2018 17:16:47 -0400
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
        Nickey Yang <nickey.yang@rock-chips.com>, devicetree@vger.kernel.org,
        Yakir Yang <kuankuan.y@gmail.com>, Mark Yao <markyao0591@gmail.com>,
        Jacob Chen <jacob-chen@iotwrt.com>,
        Kever Yang <kever.yang@rock-chips.com>,
        Brian Norris <briannorris@chromium.org>,
        Shawn Lin <shawn.lin@rock-chips.com>,
        Douglas Anderson <dianders@chromium.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Caesar Wang <wxt@rock-chips.com>, Mark Rutland <mark.rutland@arm.com>
Subject: [RFC PATCH 09/10] arm64: dts: rk3399: Add dfi and dmc nodes.
Date: Mon, 14 May 2018 23:16:09 +0200
Message-Id: <20180514211610.26618-10-enric.balletbo@collabora.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180514211610.26618-1-enric.balletbo@collabora.com>
References: <20180514211610.26618-1-enric.balletbo@collabora.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Lin Huang <hl@rock-chips.com>

These are required to support DDR DVFS on rk3399 platform. The patch also
introduces two new files (rk3399-dram.h and rk3399-dram-default-timing)
with default DRAM settings.

Signed-off-by: Lin Huang <hl@rock-chips.com>
Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
---

 .../rockchip/rk3399-dram-default-timing.dtsi  | 38 ++++++++++
 arch/arm64/boot/dts/rockchip/rk3399-dram.h    | 73 +++++++++++++++++++
 .../boot/dts/rockchip/rk3399-op1-opp.dtsi     | 29 ++++++++
 arch/arm64/boot/dts/rockchip/rk3399.dtsi      | 20 +++++
 4 files changed, 160 insertions(+)
 create mode 100644 arch/arm64/boot/dts/rockchip/rk3399-dram-default-timing.dtsi
 create mode 100644 arch/arm64/boot/dts/rockchip/rk3399-dram.h

diff --git a/arch/arm64/boot/dts/rockchip/rk3399-dram-default-timing.dtsi b/arch/arm64/boot/dts/rockchip/rk3399-dram-default-timing.dtsi
new file mode 100644
index 000000000000..4dfe3e1d8bdf
--- /dev/null
+++ b/arch/arm64/boot/dts/rockchip/rk3399-dram-default-timing.dtsi
@@ -0,0 +1,38 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR X11)
+/*
+ * Copyright (c) 2016-2018, Fuzhou Rockchip Electronics Co., Ltd
+ *
+ * Author: Lin Huang <hl@rock-chips.com>
+ */
+
+#include "rk3399-dram.h"
+
+rockchip,ddr3_speed_bin = <21>;
+rockchip,pd_idle = <0x40>;
+rockchip,sr_idle = <0x2>;
+rockchip,sr_mc_gate_idle = <0x3>;
+rockchip,srpd_lite_idle	= <0x4>;
+rockchip,standby_idle = <0x2000>;
+rockchip,dram_dll_dis_freq = <300000000>;
+rockchip,phy_dll_dis_freq = <125000000>;
+rockchip,auto_pd_dis_freq = <666000000>;
+rockchip,ddr3_odt_dis_freq = <333000000>;
+rockchip,ddr3_drv = <DDR3_DS_40ohm>;
+rockchip,ddr3_odt = <DDR3_ODT_120ohm>;
+rockchip,phy_ddr3_ca_drv = <PHY_DRV_ODT_40>;
+rockchip,phy_ddr3_dq_drv = <PHY_DRV_ODT_40>;
+rockchip,phy_ddr3_odt = <PHY_DRV_ODT_240>;
+rockchip,lpddr3_odt_dis_freq = <333000000>;
+rockchip,lpddr3_drv = <LP3_DS_34ohm>;
+rockchip,lpddr3_odt = <LP3_ODT_240ohm>;
+rockchip,phy_lpddr3_ca_drv = <PHY_DRV_ODT_40>;
+rockchip,phy_lpddr3_dq_drv = <PHY_DRV_ODT_40>;
+rockchip,phy_lpddr3_odt = <PHY_DRV_ODT_240>;
+rockchip,lpddr4_odt_dis_freq = <333000000>;
+rockchip,lpddr4_drv = <LP4_PDDS_60ohm>;
+rockchip,lpddr4_dq_odt = <LP4_DQ_ODT_40ohm>;
+rockchip,lpddr4_ca_odt = <LP4_CA_ODT_40ohm>;
+rockchip,phy_lpddr4_ca_drv = <PHY_DRV_ODT_40>;
+rockchip,phy_lpddr4_ck_cs_drv = <PHY_DRV_ODT_80>;
+rockchip,phy_lpddr4_dq_drv = <PHY_DRV_ODT_80>;
+rockchip,phy_lpddr4_odt = <PHY_DRV_ODT_60>;
diff --git a/arch/arm64/boot/dts/rockchip/rk3399-dram.h b/arch/arm64/boot/dts/rockchip/rk3399-dram.h
new file mode 100644
index 000000000000..4b3d4a79923b
--- /dev/null
+++ b/arch/arm64/boot/dts/rockchip/rk3399-dram.h
@@ -0,0 +1,73 @@
+/* SPDX-License-Identifier: (GPL-2.0+ OR X11) */
+/*
+ * Copyright (c) 2016-2018, Fuzhou Rockchip Electronics Co., Ltd
+ *
+ * Author: Lin Huang <hl@rock-chips.com>
+ */
+
+#ifndef _DTS_DRAM_ROCKCHIP_RK3399_H
+#define _DTS_DRAM_ROCKCHIP_RK3399_H
+
+#define DDR3_DS_34ohm		34
+#define DDR3_DS_40ohm		40
+
+#define DDR3_ODT_DIS		0
+#define DDR3_ODT_40ohm		40
+#define DDR3_ODT_60ohm		60
+#define DDR3_ODT_120ohm		120
+
+#define LP2_DS_34ohm		34
+#define LP2_DS_40ohm		40
+#define LP2_DS_48ohm		48
+#define LP2_DS_60ohm		60
+#define LP2_DS_68_6ohm		68	/* optional */
+#define LP2_DS_80ohm		80
+#define LP2_DS_120ohm		120	/* optional */
+
+#define LP3_DS_34ohm		34
+#define LP3_DS_40ohm		40
+#define LP3_DS_48ohm		48
+#define LP3_DS_60ohm		60
+#define LP3_DS_80ohm		80
+#define LP3_DS_34D_40U		3440
+#define LP3_DS_40D_48U		4048
+#define LP3_DS_34D_48U		3448
+
+#define LP3_ODT_DIS		0
+#define LP3_ODT_60ohm		60
+#define LP3_ODT_120ohm		120
+#define LP3_ODT_240ohm		240
+
+#define LP4_PDDS_40ohm		40
+#define LP4_PDDS_48ohm		48
+#define LP4_PDDS_60ohm		60
+#define LP4_PDDS_80ohm		80
+#define LP4_PDDS_120ohm		120
+#define LP4_PDDS_240ohm		240
+
+#define LP4_DQ_ODT_40ohm	40
+#define LP4_DQ_ODT_48ohm	48
+#define LP4_DQ_ODT_60ohm	60
+#define LP4_DQ_ODT_80ohm	80
+#define LP4_DQ_ODT_120ohm	120
+#define LP4_DQ_ODT_240ohm	240
+#define LP4_DQ_ODT_DIS		0
+
+#define LP4_CA_ODT_40ohm	40
+#define LP4_CA_ODT_48ohm	48
+#define LP4_CA_ODT_60ohm	60
+#define LP4_CA_ODT_80ohm	80
+#define LP4_CA_ODT_120ohm	120
+#define LP4_CA_ODT_240ohm	240
+#define LP4_CA_ODT_DIS		0
+
+#define PHY_DRV_ODT_Hi_Z	0
+#define PHY_DRV_ODT_240		240
+#define PHY_DRV_ODT_120		120
+#define PHY_DRV_ODT_80		80
+#define PHY_DRV_ODT_60		60
+#define PHY_DRV_ODT_48		48
+#define PHY_DRV_ODT_40		40
+#define PHY_DRV_ODT_34_3	34
+
+#endif /* _DTS_DRAM_ROCKCHIP_RK3399_H */
diff --git a/arch/arm64/boot/dts/rockchip/rk3399-op1-opp.dtsi b/arch/arm64/boot/dts/rockchip/rk3399-op1-opp.dtsi
index d8a120f945c8..4c634e58425d 100644
--- a/arch/arm64/boot/dts/rockchip/rk3399-op1-opp.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3399-op1-opp.dtsi
@@ -147,6 +147,31 @@
 			opp-microvolt = <1075000>;
 		};
 	};
+
+	dmc_opp_table: dmc_opp_table {
+		compatible = "operating-points-v2";
+
+		opp00 {
+			opp-hz = /bits/ 64 <200000000>;
+			opp-microvolt = <900000>;
+		};
+		opp01 {
+			opp-hz = /bits/ 64 <400000000>;
+			opp-microvolt = <900000>;
+		};
+		opp02 {
+			opp-hz = /bits/ 64 <666000000>;
+			opp-microvolt = <900000>;
+		};
+		opp03 {
+			opp-hz = /bits/ 64 <800000000>;
+			opp-microvolt = <900000>;
+		};
+		opp04 {
+			opp-hz = /bits/ 64 <928000000>;
+			opp-microvolt = <900000>;
+		};
+	};
 };
 
 &cpu_l0 {
@@ -176,3 +201,7 @@
 &gpu {
 	operating-points-v2 = <&gpu_opp_table>;
 };
+
+&dmc {
+	operating-points-v2 = <&dmc_opp_table>;
+};
diff --git a/arch/arm64/boot/dts/rockchip/rk3399.dtsi b/arch/arm64/boot/dts/rockchip/rk3399.dtsi
index 4550c0f82be9..e012cc8ae3d4 100644
--- a/arch/arm64/boot/dts/rockchip/rk3399.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3399.dtsi
@@ -1830,6 +1830,26 @@
 		status = "disabled";
 	};
 
+	dfi: dfi@ff630000 {
+		reg = <0x00 0xff630000 0x00 0x4000>;
+		compatible = "rockchip,rk3399-dfi";
+		rockchip,pmu = <&pmugrf>;
+		interrupts = <GIC_SPI 131 IRQ_TYPE_LEVEL_HIGH 0>;
+		clocks = <&cru PCLK_DDR_MON>;
+		clock-names = "pclk_ddr_mon";
+		status = "disabled";
+	};
+
+	dmc: dmc {
+		compatible = "rockchip,rk3399-dmc";
+		rockchip,pmu = <&pmugrf>;
+		devfreq-events = <&dfi>;
+		clocks = <&cru SCLK_DDRC>;
+		clock-names = "dmc_clk";
+		#include "rk3399-dram-default-timing.dtsi"
+		status = "disabled";
+	};
+
 	pinctrl: pinctrl {
 		compatible = "rockchip,rk3399-pinctrl";
 		rockchip,grf = <&grf>;
-- 
2.17.0
