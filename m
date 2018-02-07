Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754392AbeBGOdX (ORCPT <rfc822;w@1wt.eu>);
        Wed, 7 Feb 2018 09:33:23 -0500
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:51650 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754338AbeBGOdP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Feb 2018 09:33:15 -0500
From: Marc Zyngier <marc.zyngier@arm.com>
To: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc: Sudeep Holla <sudeep.holla@arm.com>,
        Robin Murphy <robin.murphy@arm.com>, Liviu Dudau <liviu.dudau@arm.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: [PATCH 2/2] arm64: dts: juno: Describe the full GICv2m region
Date: Wed,  7 Feb 2018 14:32:55 +0000
Message-Id: <20180207143255.17003-3-marc.zyngier@arm.com>
X-Mailer: git-send-email 2.14.2
In-Reply-To: <20180207143255.17003-1-marc.zyngier@arm.com>
References: <20180207143255.17003-1-marc.zyngier@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Robin Murphy <robin.murphy@arm.com>

Juno's GICv2m implementation consists of four frames providing 32
interrupts each. Since it is possible to plug in enough PCIe endpoints
to consume more than 32 MSIs, and the driver already has a bodge to
handle multiple frames, let's expose the other three as well.

Signed-off-by: Robin Murphy <robin.murphy@arm.com>
Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
---
 arch/arm64/boot/dts/arm/juno-base.dtsi | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/arch/arm64/boot/dts/arm/juno-base.dtsi b/arch/arm64/boot/dts/arm/juno-base.dtsi
index f165f04db0c9..f8088c45b060 100644
--- a/arch/arm64/boot/dts/arm/juno-base.dtsi
+++ b/arch/arm64/boot/dts/arm/juno-base.dtsi
@@ -68,11 +68,30 @@
 		interrupt-controller;
 		interrupts = <GIC_PPI 9 (GIC_CPU_MASK_SIMPLE(6) | IRQ_TYPE_LEVEL_HIGH)>;
 		ranges = <0 0 0 0x2c1c0000 0 0x40000>;
+
 		v2m_0: v2m@0 {
 			compatible = "arm,gic-v2m-frame";
 			msi-controller;
 			reg = <0 0 0 0x1000>;
 		};
+
+		v2m@10000 {
+			compatible = "arm,gic-v2m-frame";
+			msi-controller;
+			reg = <0 0x10000 0 0x1000>;
+		};
+
+		v2m@20000 {
+			compatible = "arm,gic-v2m-frame";
+			msi-controller;
+			reg = <0 0x20000 0 0x1000>;
+		};
+
+		v2m@30000 {
+			compatible = "arm,gic-v2m-frame";
+			msi-controller;
+			reg = <0 0x30000 0 0x1000>;
+		};
 	};
 
 	timer {
-- 
2.14.2
