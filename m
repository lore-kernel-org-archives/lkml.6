Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753324AbeCFDWX (ORCPT <rfc822;w@1wt.eu>);
        Mon, 5 Mar 2018 22:22:23 -0500
Received: from regular1.263xmail.com ([211.150.99.131]:50192 "EHLO
        regular1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753238AbeCFDWV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Mar 2018 22:22:21 -0500
X-263anti-spam: KSV:0;
X-MAIL-GRAY: 0
X-MAIL-DELIVERY: 1
X-KSVirus-check: 0
X-ABS-CHECKED: 4
X-RL-SENDER: jeffy.chen@rock-chips.com
X-FST-TO: linux-kernel@vger.kernel.org
X-SENDER-IP: 103.29.142.67
X-LOGIN-NAME: jeffy.chen@rock-chips.com
X-UNIQUE-TAG: <2c0c1dfa8f296e2745e5fd45a1e31a1e>
X-ATTACHMENT-NUM: 0
X-DNS-TYPE: 0
From: Jeffy Chen <jeffy.chen@rock-chips.com>
To: linux-kernel@vger.kernel.org
Cc: jcliang@chromium.org, robin.murphy@arm.com, xxm@rock-chips.com,
        tfiga@chromium.org, Jeffy Chen <jeffy.chen@rock-chips.com>,
        Romain Perier <romain.perier@collabora.com>,
        Arnd Bergmann <arnd@arndb.de>, Liang Chen <cl@rock-chips.com>,
        Rob Herring <robh+dt@kernel.org>, Shawn Lin <shawn.lin@rock-chips.com>,
        Huibin Hong <huibin.hong@rock-chips.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        David Wu <david.wu@rock-chips.com>,
        Finley Xiao <finley.xiao@rock-chips.com>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Heiko Stuebner <heiko@sntech.de>, Jacob Chen <jacob-chen@iotwrt.com>,
        Kever Yang <kever.yang@rock-chips.com>,
        Brian Norris <briannorris@chromium.org>,
        linux-rockchip@lists.infradead.org,
        Rocky Hao <rocky.hao@rock-chips.com>,
        Will Deacon <will.deacon@arm.com>,
        Nickey Yang <nickey.yang@rock-chips.com>, devicetree@vger.kernel.org,
        Mark Yao <markyao0591@gmail.com>, Russell King <linux@armlinux.org.uk>,
        linux-arm-kernel@lists.infradead.org,
        Jianqun Xu <jay.xu@rock-chips.com>,
        Sugar Zhang <sugar.zhang@rock-chips.com>,
        Caesar Wang <wxt@rock-chips.com>, Mark Rutland <mark.rutland@arm.com>
Subject: [PATCH v7 07/14] ARM: dts: rockchip: add clocks in iommu nodes
Date: Tue,  6 Mar 2018 11:21:06 +0800
Message-Id: <20180306032113.22247-4-jeffy.chen@rock-chips.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20180306032113.22247-1-jeffy.chen@rock-chips.com>
References: <20180306030252.3197-1-jeffy.chen@rock-chips.com>
 <20180306032113.22247-1-jeffy.chen@rock-chips.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add clocks in iommu nodes, since we are going to control clocks in
rockchip iommu driver.

Signed-off-by: Jeffy Chen <jeffy.chen@rock-chips.com>
---

Changes in v7: None
Changes in v6:
Add clk names, and modify all iommu nodes in all existing rockchip dts

Changes in v5:
Remove clk names.

Changes in v4: None
Changes in v3: None
Changes in v2: None

 arch/arm/boot/dts/rk3036.dtsi            |  2 ++
 arch/arm/boot/dts/rk322x.dtsi            |  8 ++++++++
 arch/arm/boot/dts/rk3288.dtsi            | 12 ++++++++++++
 arch/arm64/boot/dts/rockchip/rk3328.dtsi | 10 ++++++++++
 arch/arm64/boot/dts/rockchip/rk3368.dtsi | 10 ++++++++++
 arch/arm64/boot/dts/rockchip/rk3399.dtsi | 14 ++++++++++++--
 6 files changed, 54 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/rk3036.dtsi b/arch/arm/boot/dts/rk3036.dtsi
index a97458112ff6..567a6a725f9c 100644
--- a/arch/arm/boot/dts/rk3036.dtsi
+++ b/arch/arm/boot/dts/rk3036.dtsi
@@ -197,6 +197,8 @@
 		reg = <0x10118300 0x100>;
 		interrupts = <GIC_SPI 43 IRQ_TYPE_LEVEL_HIGH>;
 		interrupt-names = "vop_mmu";
+		clocks = <&cru ACLK_LCDC>, <&cru HCLK_LCDC>;
+		clock-names = "aclk", "iface";
 		#iommu-cells = <0>;
 		status = "disabled";
 	};
diff --git a/arch/arm/boot/dts/rk322x.dtsi b/arch/arm/boot/dts/rk322x.dtsi
index df1e47858675..be80e9a2c9af 100644
--- a/arch/arm/boot/dts/rk322x.dtsi
+++ b/arch/arm/boot/dts/rk322x.dtsi
@@ -584,6 +584,8 @@
 		reg = <0x20020800 0x100>;
 		interrupts = <GIC_SPI 10 IRQ_TYPE_LEVEL_HIGH>;
 		interrupt-names = "vpu_mmu";
+		clocks = <&cru ACLK_VPU>, <&cru HCLK_VPU>;
+		clock-names = "aclk", "iface";
 		iommu-cells = <0>;
 		status = "disabled";
 	};
@@ -593,6 +595,8 @@
 		reg = <0x20030480 0x40>, <0x200304c0 0x40>;
 		interrupts = <GIC_SPI 8 IRQ_TYPE_LEVEL_HIGH>;
 		interrupt-names = "vdec_mmu";
+		clocks = <&cru ACLK_RKVDEC>, <&cru HCLK_RKVDEC>;
+		clock-names = "aclk", "iface";
 		iommu-cells = <0>;
 		status = "disabled";
 	};
@@ -602,6 +606,8 @@
 		reg = <0x20053f00 0x100>;
 		interrupts = <GIC_SPI 32 IRQ_TYPE_LEVEL_HIGH>;
 		interrupt-names = "vop_mmu";
+		clocks = <&cru ACLK_VOP>, <&cru HCLK_VOP>;
+		clock-names = "aclk", "iface";
 		iommu-cells = <0>;
 		status = "disabled";
 	};
@@ -611,6 +617,8 @@
 		reg = <0x20070800 0x100>;
 		interrupts = <GIC_SPI 31 IRQ_TYPE_LEVEL_HIGH>;
 		interrupt-names = "iep_mmu";
+		clocks = <&cru ACLK_IEP>, <&cru HCLK_IEP>;
+		clock-names = "aclk", "iface";
 		iommu-cells = <0>;
 		status = "disabled";
 	};
diff --git a/arch/arm/boot/dts/rk3288.dtsi b/arch/arm/boot/dts/rk3288.dtsi
index 6102e4e7f35c..ad77c8eb3c38 100644
--- a/arch/arm/boot/dts/rk3288.dtsi
+++ b/arch/arm/boot/dts/rk3288.dtsi
@@ -958,6 +958,8 @@
 		reg = <0x0 0xff900800 0x0 0x40>;
 		interrupts = <GIC_SPI 17 IRQ_TYPE_LEVEL_HIGH>;
 		interrupt-names = "iep_mmu";
+		clocks = <&cru ACLK_IEP>, <&cru HCLK_IEP>;
+		clock-names = "aclk", "iface";
 		#iommu-cells = <0>;
 		status = "disabled";
 	};
@@ -967,6 +969,8 @@
 		reg = <0x0 0xff914000 0x0 0x100>, <0x0 0xff915000 0x0 0x100>;
 		interrupts = <GIC_SPI 14 IRQ_TYPE_LEVEL_HIGH>;
 		interrupt-names = "isp_mmu";
+		clocks = <&cru ACLK_ISP>, <&cru HCLK_ISP>;
+		clock-names = "aclk", "iface";
 		#iommu-cells = <0>;
 		rockchip,disable-mmu-reset;
 		status = "disabled";
@@ -1026,6 +1030,8 @@
 		reg = <0x0 0xff930300 0x0 0x100>;
 		interrupts = <GIC_SPI 15 IRQ_TYPE_LEVEL_HIGH>;
 		interrupt-names = "vopb_mmu";
+		clocks = <&cru ACLK_VOP0>, <&cru HCLK_VOP0>;
+		clock-names = "aclk", "iface";
 		power-domains = <&power RK3288_PD_VIO>;
 		#iommu-cells = <0>;
 		status = "disabled";
@@ -1074,6 +1080,8 @@
 		reg = <0x0 0xff940300 0x0 0x100>;
 		interrupts = <GIC_SPI 16 IRQ_TYPE_LEVEL_HIGH>;
 		interrupt-names = "vopl_mmu";
+		clocks = <&cru ACLK_VOP1>, <&cru HCLK_VOP1>;
+		clock-names = "aclk", "iface";
 		power-domains = <&power RK3288_PD_VIO>;
 		#iommu-cells = <0>;
 		status = "disabled";
@@ -1204,6 +1212,8 @@
 		reg = <0x0 0xff9a0800 0x0 0x100>;
 		interrupts = <GIC_SPI 11 IRQ_TYPE_LEVEL_HIGH>;
 		interrupt-names = "vpu_mmu";
+		clocks = <&cru ACLK_VCODEC>, <&cru HCLK_VCODEC>;
+		clock-names = "aclk", "iface";
 		#iommu-cells = <0>;
 		status = "disabled";
 	};
@@ -1213,6 +1223,8 @@
 		reg = <0x0 0xff9c0440 0x0 0x40>, <0x0 0xff9c0480 0x0 0x40>;
 		interrupts = <GIC_SPI 111 IRQ_TYPE_LEVEL_HIGH>;
 		interrupt-names = "hevc_mmu";
+		clocks = <&cru ACLK_HEVC>, <&cru HCLK_HEVC>;
+		clock-names = "aclk", "iface";
 		#iommu-cells = <0>;
 		status = "disabled";
 	};
diff --git a/arch/arm64/boot/dts/rockchip/rk3328.dtsi b/arch/arm64/boot/dts/rockchip/rk3328.dtsi
index be2bfbc6b483..b8e9da15e00c 100644
--- a/arch/arm64/boot/dts/rockchip/rk3328.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3328.dtsi
@@ -595,6 +595,8 @@
 		reg = <0x0 0xff330200 0 0x100>;
 		interrupts = <GIC_SPI 96 IRQ_TYPE_LEVEL_HIGH>;
 		interrupt-names = "h265e_mmu";
+		clocks = <&cru ACLK_H265>, <&cru PCLK_H265>;
+		clock-names = "aclk", "iface";
 		#iommu-cells = <0>;
 		status = "disabled";
 	};
@@ -604,6 +606,8 @@
 		reg = <0x0 0xff340800 0x0 0x40>;
 		interrupts = <GIC_SPI 98 IRQ_TYPE_LEVEL_HIGH>;
 		interrupt-names = "vepu_mmu";
+		clocks = <&cru ACLK_VPU>, <&cru HCLK_VPU>;
+		clock-names = "aclk", "iface";
 		#iommu-cells = <0>;
 		status = "disabled";
 	};
@@ -613,6 +617,8 @@
 		reg = <0x0 0xff350800 0x0 0x40>;
 		interrupts = <GIC_SPI 11 IRQ_TYPE_LEVEL_HIGH>;
 		interrupt-names = "vpu_mmu";
+		clocks = <&cru ACLK_VPU>, <&cru HCLK_VPU>;
+		clock-names = "aclk", "iface";
 		#iommu-cells = <0>;
 		status = "disabled";
 	};
@@ -622,6 +628,8 @@
 		reg = <0x0 0xff360480 0x0 0x40>, <0x0 0xff3604c0 0x0 0x40>;
 		interrupts = <GIC_SPI 74 IRQ_TYPE_LEVEL_HIGH>;
 		interrupt-names = "rkvdec_mmu";
+		clocks = <&cru ACLK_RKVDEC>, <&cru HCLK_RKVDEC>;
+		clock-names = "aclk", "iface";
 		#iommu-cells = <0>;
 		status = "disabled";
 	};
@@ -631,6 +639,8 @@
 		reg = <0x0 0xff373f00 0x0 0x100>;
 		interrupts = <GIC_SPI 32 IRQ_TYPE_LEVEL_HIGH>;
 		interrupt-names = "vop_mmu";
+		clocks = <&cru ACLK_VOP>, <&cru HCLK_VOP>;
+		clock-names = "aclk", "iface";
 		#iommu-cells = <0>;
 		status = "disabled";
 	};
diff --git a/arch/arm64/boot/dts/rockchip/rk3368.dtsi b/arch/arm64/boot/dts/rockchip/rk3368.dtsi
index 03458ac44201..ad91ced78649 100644
--- a/arch/arm64/boot/dts/rockchip/rk3368.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3368.dtsi
@@ -742,6 +742,8 @@
 		reg = <0x0 0xff900800 0x0 0x100>;
 		interrupts = <GIC_SPI 17 IRQ_TYPE_LEVEL_HIGH>;
 		interrupt-names = "iep_mmu";
+		clocks = <&cru ACLK_IEP>, <&cru HCLK_IEP>;
+		clock-names = "aclk", "iface";
 		#iommu-cells = <0>;
 		status = "disabled";
 	};
@@ -752,6 +754,8 @@
 		      <0x0 0xff915000 0x0 0x100>;
 		interrupts = <GIC_SPI 14 IRQ_TYPE_LEVEL_HIGH>;
 		interrupt-names = "isp_mmu";
+		clocks = <&cru ACLK_ISP>, <&cru HCLK_ISP>;
+		clock-names = "aclk", "iface";
 		#iommu-cells = <0>;
 		rockchip,disable-mmu-reset;
 		status = "disabled";
@@ -762,6 +766,8 @@
 		reg = <0x0 0xff930300 0x0 0x100>;
 		interrupts = <GIC_SPI 15 IRQ_TYPE_LEVEL_HIGH>;
 		interrupt-names = "vop_mmu";
+		clocks = <&cru ACLK_VOP>, <&cru HCLK_VOP>;
+		clock-names = "aclk", "iface";
 		#iommu-cells = <0>;
 		status = "disabled";
 	};
@@ -772,6 +778,8 @@
 		      <0x0 0xff9a0480 0x0 0x40>;
 		interrupts = <GIC_SPI 12 IRQ_TYPE_LEVEL_HIGH>;
 		interrupt-names = "hevc_mmu";
+		clocks = <&cru ACLK_VIDEO>, <&cru HCLK_VIDEO>;
+		clock-names = "aclk", "iface";
 		#iommu-cells = <0>;
 		status = "disabled";
 	};
@@ -782,6 +790,8 @@
 		interrupts = <GIC_SPI 9 IRQ_TYPE_LEVEL_HIGH>,
 			     <GIC_SPI 10 IRQ_TYPE_LEVEL_HIGH>;
 		interrupt-names = "vepu_mmu", "vdpu_mmu";
+		clocks = <&cru ACLK_VIDEO>, <&cru HCLK_VIDEO>;
+		clock-names = "aclk", "iface";
 		#iommu-cells = <0>;
 		status = "disabled";
 	};
diff --git a/arch/arm64/boot/dts/rockchip/rk3399.dtsi b/arch/arm64/boot/dts/rockchip/rk3399.dtsi
index da0078eda485..8cb4ed5d43cc 100644
--- a/arch/arm64/boot/dts/rockchip/rk3399.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3399.dtsi
@@ -1234,6 +1234,8 @@
 		reg = <0x0 0xff650800 0x0 0x40>;
 		interrupts = <GIC_SPI 115 IRQ_TYPE_LEVEL_HIGH 0>;
 		interrupt-names = "vpu_mmu";
+		clocks = <&cru ACLK_VCODEC>, <&cru HCLK_VCODEC>;
+		clock-names = "aclk", "iface";
 		#iommu-cells = <0>;
 		status = "disabled";
 	};
@@ -1243,6 +1245,8 @@
 		reg = <0x0 0xff660480 0x0 0x40>, <0x0 0xff6604c0 0x0 0x40>;
 		interrupts = <GIC_SPI 117 IRQ_TYPE_LEVEL_HIGH 0>;
 		interrupt-names = "vdec_mmu";
+		clocks = <&cru ACLK_VDU>, <&cru HCLK_VDU>;
+		clock-names = "aclk", "iface";
 		#iommu-cells = <0>;
 		status = "disabled";
 	};
@@ -1252,6 +1256,8 @@
 		reg = <0x0 0xff670800 0x0 0x40>;
 		interrupts = <GIC_SPI 42 IRQ_TYPE_LEVEL_HIGH 0>;
 		interrupt-names = "iep_mmu";
+		clocks = <&cru ACLK_IEP>, <&cru HCLK_IEP>;
+		clock-names = "aclk", "iface";
 		#iommu-cells = <0>;
 		status = "disabled";
 	};
@@ -1597,7 +1603,7 @@
 		interrupts = <GIC_SPI 119 IRQ_TYPE_LEVEL_HIGH 0>;
 		interrupt-names = "vopl_mmu";
 		clocks = <&cru ACLK_VOP1>, <&cru HCLK_VOP1>;
-		clock-names = "aclk", "hclk";
+		clock-names = "aclk", "iface";
 		power-domains = <&power RK3399_PD_VOPL>;
 		#iommu-cells = <0>;
 		status = "disabled";
@@ -1654,7 +1660,7 @@
 		interrupts = <GIC_SPI 118 IRQ_TYPE_LEVEL_HIGH 0>;
 		interrupt-names = "vopb_mmu";
 		clocks = <&cru ACLK_VOP0>, <&cru HCLK_VOP0>;
-		clock-names = "aclk", "hclk";
+		clock-names = "aclk", "iface";
 		power-domains = <&power RK3399_PD_VOPB>;
 		#iommu-cells = <0>;
 		status = "disabled";
@@ -1665,6 +1671,8 @@
 		reg = <0x0 0xff914000 0x0 0x100>, <0x0 0xff915000 0x0 0x100>;
 		interrupts = <GIC_SPI 43 IRQ_TYPE_LEVEL_HIGH 0>;
 		interrupt-names = "isp0_mmu";
+		clocks = <&cru ACLK_ISP0_NOC>, <&cru HCLK_ISP0_NOC>;
+		clock-names = "aclk", "iface";
 		#iommu-cells = <0>;
 		rockchip,disable-mmu-reset;
 		status = "disabled";
@@ -1675,6 +1683,8 @@
 		reg = <0x0 0xff924000 0x0 0x100>, <0x0 0xff925000 0x0 0x100>;
 		interrupts = <GIC_SPI 44 IRQ_TYPE_LEVEL_HIGH 0>;
 		interrupt-names = "isp1_mmu";
+		clocks = <&cru ACLK_ISP1_NOC>, <&cru HCLK_ISP1_NOC>;
+		clock-names = "aclk", "iface";
 		#iommu-cells = <0>;
 		rockchip,disable-mmu-reset;
 		status = "disabled";
-- 
2.11.0
