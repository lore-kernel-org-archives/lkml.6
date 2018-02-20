Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753288AbeBTRBZ (ORCPT <rfc822;w@1wt.eu>);
        Tue, 20 Feb 2018 12:01:25 -0500
Received: from bastet.se.axis.com ([195.60.68.11]:33926 "EHLO
        bastet.se.axis.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752194AbeBTRBW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Feb 2018 12:01:22 -0500
From: Niklas Cassel <niklas.cassel@axis.com>
To: arm@kernel.org, Jesper Nilsson <jespern@axis.com>,
        Lars Persson <larper@axis.com>, Niklas Cassel <niklass@axis.com>,
        Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Russell King <linux@armlinux.org.uk>
Cc: linux-arm-kernel@axis.com, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/8] ARM: dts: artpec: disable Accelerator Coherency Port
Date: Tue, 20 Feb 2018 18:00:42 +0100
Message-Id: <20180220170049.22809-2-niklas.cassel@axis.com>
X-Mailer: git-send-email 2.14.2
In-Reply-To: <20180220170049.22809-1-niklas.cassel@axis.com>
References: <20180220170049.22809-1-niklas.cassel@axis.com>
X-TM-AS-GCONF: 00
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Accesses via 0x80000000 go through the ACP instead of using the DDR
directly.

Unfortunately the ACP has proven to be the cause of complete system
hangs. Disabling the ACP makes these problems go away.

Signed-off-by: Niklas Cassel <niklas.cassel@axis.com>
---
 arch/arm/boot/dts/artpec6.dtsi | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/artpec6.dtsi b/arch/arm/boot/dts/artpec6.dtsi
index 2ed11773048d..d9776a97d8ff 100644
--- a/arch/arm/boot/dts/artpec6.dtsi
+++ b/arch/arm/boot/dts/artpec6.dtsi
@@ -185,8 +185,7 @@
 		#address-cells = <0x1>;
 		#size-cells = <0x1>;
 		ranges;
-		dma-ranges = <0x80000000 0x00000000 0x40000000>;
-		dma-coherent;
+		dma-ranges;
 
 		ethernet: ethernet@f8010000 {
 			clock-names = "phy_ref_clk", "apb_pclk";
-- 
2.14.2
