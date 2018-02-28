Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933280AbeB1PtH (ORCPT <rfc822;w@1wt.eu>);
        Wed, 28 Feb 2018 10:49:07 -0500
Received: from foss.arm.com ([217.140.101.70]:52174 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932426AbeB1PtF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Feb 2018 10:49:05 -0500
From: Sudeep Holla <sudeep.holla@arm.com>
To: linux-arm-kernel@lists.infradead.org
Cc: Sudeep Holla <sudeep.holla@arm.com>, linux-kernel@vger.kernel.org,
        Liviu Dudau <liviu.dudau@arm.com>, Robin Murphy <robin.murphy@arm.com>,
        Marc Zyngier <marc.zyngier@arm.com>
Subject: [PATCH] arm64: dts: juno: fix size of GICv2m MSI frames
Date: Wed, 28 Feb 2018 15:48:55 +0000
Message-Id: <1519832935-7338-1-git-send-email-sudeep.holla@arm.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <20180207143255.17003-3-marc.zyngier@arm.com>
References: <20180207143255.17003-3-marc.zyngier@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently the size of GICv2m MSI frames are listed as 4kB while the
Juno TRM specifies 64kB for each of these MSI frames.

Though the devices connected themself might just use the first 4kB,
to be consistent with the genaral practice of 64kB boundary alignment
to all the devices, lets keep the size as 64kB. This might also help
in avoiding any surprise when passing the device to a VM.

This patch increase the size of each GICv2m MSI frames from 4kB to 64kB
as per the specification.

Cc: Liviu Dudau <liviu.dudau@arm.com>
Cc: Robin Murphy <robin.murphy@arm.com>
Cc: Marc Zyngier <marc.zyngier@arm.com>
Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
---
 arch/arm64/boot/dts/arm/juno-base.dtsi | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/boot/dts/arm/juno-base.dtsi b/arch/arm64/boot/dts/arm/juno-base.dtsi
index f8088c45b060..eb749c50a736 100644
--- a/arch/arm64/boot/dts/arm/juno-base.dtsi
+++ b/arch/arm64/boot/dts/arm/juno-base.dtsi
@@ -72,25 +72,25 @@
 		v2m_0: v2m@0 {
 			compatible = "arm,gic-v2m-frame";
 			msi-controller;
-			reg = <0 0 0 0x1000>;
+			reg = <0 0 0 0x10000>;
 		};
 
 		v2m@10000 {
 			compatible = "arm,gic-v2m-frame";
 			msi-controller;
-			reg = <0 0x10000 0 0x1000>;
+			reg = <0 0x10000 0 0x10000>;
 		};
 
 		v2m@20000 {
 			compatible = "arm,gic-v2m-frame";
 			msi-controller;
-			reg = <0 0x20000 0 0x1000>;
+			reg = <0 0x20000 0 0x10000>;
 		};
 
 		v2m@30000 {
 			compatible = "arm,gic-v2m-frame";
 			msi-controller;
-			reg = <0 0x30000 0 0x1000>;
+			reg = <0 0x30000 0 0x10000>;
 		};
 	};
 
-- 
2.7.4
