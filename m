Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754215AbeDYLIB (ORCPT <rfc822;w@1wt.eu>);
        Wed, 25 Apr 2018 07:08:01 -0400
Received: from mail.bootlin.com ([62.4.15.54]:58359 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754120AbeDYLHw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Apr 2018 07:07:52 -0400
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
To: davem@davemloft.net
Cc: Maxime Chevallier <maxime.chevallier@bootlin.com>,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Antoine Tenart <antoine.tenart@bootlin.com>,
        thomas.petazzoni@bootlin.com, gregory.clement@bootlin.com,
        miquel.raynal@bootlin.com, nadavh@marvell.com, stefanc@marvell.com,
        ymarkman@marvell.com, mw@semihalf.com, linux@armlinux.org.uk,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH net 3/3] ARM64: dts: marvell: armada-cp110: Add clocks for the xmdio node
Date: Wed, 25 Apr 2018 13:07:31 +0200
Message-Id: <20180425110731.20153-4-maxime.chevallier@bootlin.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20180425110731.20153-1-maxime.chevallier@bootlin.com>
References: <20180425110731.20153-1-maxime.chevallier@bootlin.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Marvell XSMI controller needs 3 clocks to operate correctly :
 - The MG clock (clk 5)
 - The MG Core clock (clk 6)
 - The GOP clock (clk 18)

 This commit adds them, to avoid system hangs when using these
 interfaces.

Fixes: c7e92def1ef4 ("clk: mvebu: cp110: Fix clock tree representation")
Signed-off-by: Maxime Chevallier <maxime.chevallier@bootlin.com>
---
 arch/arm64/boot/dts/marvell/armada-cp110.dtsi | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm64/boot/dts/marvell/armada-cp110.dtsi b/arch/arm64/boot/dts/marvell/armada-cp110.dtsi
index 6c137ac656e9..ed2f1237ea1e 100644
--- a/arch/arm64/boot/dts/marvell/armada-cp110.dtsi
+++ b/arch/arm64/boot/dts/marvell/armada-cp110.dtsi
@@ -142,6 +142,8 @@
 			#size-cells = <0>;
 			compatible = "marvell,xmdio";
 			reg = <0x12a600 0x10>;
+			clocks = <&CP110_LABEL(clk) 1 5>,
+				 <&CP110_LABEL(clk) 1 6>, <&CP110_LABEL(clk) 1 18>;
 			status = "disabled";
 		};
 
-- 
2.11.0
