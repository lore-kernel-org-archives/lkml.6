Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752025AbeCWHkV (ORCPT <rfc822;w@1wt.eu>);
        Fri, 23 Mar 2018 03:40:21 -0400
Received: from regular1.263xmail.com ([211.150.99.140]:54902 "EHLO
        regular1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751806AbeCWHkS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Mar 2018 03:40:18 -0400
X-263anti-spam: KSV:0;
X-MAIL-GRAY: 0
X-MAIL-DELIVERY: 1
X-KSVirus-check: 0
X-ABS-CHECKED: 4
X-RL-SENDER: jeffy.chen@rock-chips.com
X-FST-TO: linux-kernel@vger.kernel.org
X-SENDER-IP: 103.29.142.67
X-LOGIN-NAME: jeffy.chen@rock-chips.com
X-UNIQUE-TAG: <ec0014e0d5462b4ee037c556beb434ff>
X-ATTACHMENT-NUM: 0
X-DNS-TYPE: 0
From: Jeffy Chen <jeffy.chen@rock-chips.com>
To: linux-kernel@vger.kernel.org
Cc: jcliang@chromium.org, robin.murphy@arm.com, xxm@rock-chips.com,
        tfiga@chromium.org, Jeffy Chen <jeffy.chen@rock-chips.com>,
        devicetree@vger.kernel.org, Heiko Stuebner <heiko@sntech.de>,
        linux-rockchip@lists.infradead.org, iommu@lists.linux-foundation.org,
        Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Joerg Roedel <joro@8bytes.org>, linux-arm-kernel@lists.infradead.org
Subject: [PATCH v8 09/14] dt-bindings: iommu/rockchip: Add clock property
Date: Fri, 23 Mar 2018 15:38:09 +0800
Message-Id: <20180323073814.5802-10-jeffy.chen@rock-chips.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20180323073814.5802-1-jeffy.chen@rock-chips.com>
References: <20180323073814.5802-1-jeffy.chen@rock-chips.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add clock property, since we are going to control clocks in rockchip
iommu driver.

Signed-off-by: Jeffy Chen <jeffy.chen@rock-chips.com>
Reviewed-by: Robin Murphy <robin.murphy@arm.com>
---

Changes in v8: None
Changes in v7: None
Changes in v6: None
Changes in v5: None
Changes in v4: None
Changes in v3: None
Changes in v2: None

 Documentation/devicetree/bindings/iommu/rockchip,iommu.txt | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/Documentation/devicetree/bindings/iommu/rockchip,iommu.txt b/Documentation/devicetree/bindings/iommu/rockchip,iommu.txt
index 2098f7732264..6ecefea1c6f9 100644
--- a/Documentation/devicetree/bindings/iommu/rockchip,iommu.txt
+++ b/Documentation/devicetree/bindings/iommu/rockchip,iommu.txt
@@ -14,6 +14,11 @@ Required properties:
                     "single-master" device, and needs no additional information
                     to associate with its master device.  See:
                     Documentation/devicetree/bindings/iommu/iommu.txt
+- clocks          : A list of clocks required for the IOMMU to be accessible by
+                    the host CPU.
+- clock-names     : Should contain the following:
+	"iface" - Main peripheral bus clock (PCLK/HCL) (required)
+	"aclk"  - AXI bus clock (required)
 
 Optional properties:
 - rockchip,disable-mmu-reset : Don't use the mmu reset operation.
@@ -27,5 +32,7 @@ Example:
 		reg = <0xff940300 0x100>;
 		interrupts = <GIC_SPI 16 IRQ_TYPE_LEVEL_HIGH>;
 		interrupt-names = "vopl_mmu";
+		clocks = <&cru ACLK_VOP1>, <&cru HCLK_VOP1>;
+		clock-names = "aclk", "iface";
 		#iommu-cells = <0>;
 	};
-- 
2.11.0
