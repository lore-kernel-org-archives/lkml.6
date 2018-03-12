Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933542AbeCLDtS (ORCPT <rfc822;w@1wt.eu>);
        Sun, 11 Mar 2018 23:49:18 -0400
Received: from mail-pl0-f67.google.com ([209.85.160.67]:34661 "EHLO
        mail-pl0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932706AbeCLDtQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Mar 2018 23:49:16 -0400
X-Google-Smtp-Source: AG47ELv3RFDUwRZQk6LKc2l93DLuq16sq2lwmoT3WvAeTBtOeq+0naThhbRCjm1J1TGFceQi532buQ==
From: Shunqian Zheng <zhengsq@rock-chips.com>
To: linux-rockchip@lists.infradead.org
Cc: linux-kernel@vger.kernel.org, Shunqian Zheng <zhengsq@rock-chips.com>,
        Jacob Chen <jacob2.chen@rock-chips.com>
Subject: [PATCH v6-1,15/17] arm64: dts: rockchip: add isp0 node for rk3399
Date: Mon, 12 Mar 2018 11:49:07 +0800
Message-Id: <1520826547-24825-1-git-send-email-zhengsq@rock-chips.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <20180308094807.9443-16-jacob-chen@iotwrt.com>
References: <20180308094807.9443-16-jacob-chen@iotwrt.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

rk3399 have two ISP, but we havn't test isp1, so just add isp0 at present.

Signed-off-by: Shunqian Zheng <zhengsq@rock-chips.com>
Signed-off-by: Jacob Chen <jacob2.chen@rock-chips.com>
---
 arch/arm64/boot/dts/rockchip/rk3399.dtsi | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/arch/arm64/boot/dts/rockchip/rk3399.dtsi b/arch/arm64/boot/dts/rockchip/rk3399.dtsi
index 2605118..5729786 100644
--- a/arch/arm64/boot/dts/rockchip/rk3399.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3399.dtsi
@@ -1614,6 +1614,24 @@
 		status = "disabled";
 	};
 
+	isp0: isp0@ff910000 {
+		compatible = "rockchip,rk3399-cif-isp";
+		reg = <0x0 0xff910000 0x0 0x4000>;
+		interrupts = <GIC_SPI 43 IRQ_TYPE_LEVEL_HIGH 0>;
+		clocks = <&cru SCLK_ISP0>,
+			 <&cru ACLK_ISP0>, <&cru ACLK_ISP0_WRAPPER>,
+			 <&cru HCLK_ISP0>, <&cru HCLK_ISP0_WRAPPER>;
+		clock-names = "clk_isp",
+			      "aclk_isp", "aclk_isp_wrap",
+			      "hclk_isp", "hclk_isp_wrap";
+		assigned-clocks = <&cru SCLK_ISP0>, <&cru ACLK_ISP0>;
+		assigned-clock-rates = <500000000>, <400000000>;
+
+		power-domains = <&power RK3399_PD_ISP0>;
+		iommus = <&isp0_mmu>;
+		status = "disabled";
+	};
+
 	isp0_mmu: iommu@ff914000 {
 		compatible = "rockchip,iommu";
 		reg = <0x0 0xff914000 0x0 0x100>, <0x0 0xff915000 0x0 0x100>;
-- 
1.9.1
