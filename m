Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752393AbeEQIbp (ORCPT <rfc822;w@1wt.eu>);
        Thu, 17 May 2018 04:31:45 -0400
Received: from mail.bootlin.com ([62.4.15.54]:41883 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751965AbeEQIaj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 May 2018 04:30:39 -0400
From: Antoine Tenart <antoine.tenart@bootlin.com>
To: davem@davemloft.net, kishon@ti.com, linux@armlinux.org.uk,
        gregory.clement@bootlin.com, andrew@lunn.ch, jason@lakedaemon.net,
        sebastian.hesselbarth@gmail.com
Cc: Antoine Tenart <antoine.tenart@bootlin.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, thomas.petazzoni@bootlin.com,
        maxime.chevallier@bootlin.com, miquel.raynal@bootlin.com,
        nadavh@marvell.com, stefanc@marvell.com, ymarkman@marvell.com,
        mw@semihalf.com, linux-arm-kernel@lists.infradead.org
Subject: [PATCH net-next v3 09/10] arm64: dts: marvell: 8040-db: describe the 10G interfaces as fixed-link
Date: Thu, 17 May 2018 10:29:38 +0200
Message-Id: <20180517082939.14598-10-antoine.tenart@bootlin.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180517082939.14598-1-antoine.tenart@bootlin.com>
References: <20180517082939.14598-1-antoine.tenart@bootlin.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds a fixed-link node to both 10G interfaces of the 8040-db
board. This is required as the mvpp2 driver now uses phylink. The best
solution would have been to describe the SFP cages but they are not
wired correctly, and thus unusable, so we chose to use fixed-link
instead.

Signed-off-by: Antoine Tenart <antoine.tenart@bootlin.com>
---
 arch/arm64/boot/dts/marvell/armada-8040-db.dts | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/arm64/boot/dts/marvell/armada-8040-db.dts b/arch/arm64/boot/dts/marvell/armada-8040-db.dts
index 5689fb23bbab..1bac437369a1 100644
--- a/arch/arm64/boot/dts/marvell/armada-8040-db.dts
+++ b/arch/arm64/boot/dts/marvell/armada-8040-db.dts
@@ -177,6 +177,11 @@
 &cp0_eth0 {
 	status = "okay";
 	phy-mode = "10gbase-kr";
+
+	fixed-link {
+		speed = <10000>;
+		full-duplex;
+	};
 };
 
 &cp0_eth2 {
@@ -303,6 +308,11 @@
 &cp1_eth0 {
 	status = "okay";
 	phy-mode = "10gbase-kr";
+
+	fixed-link {
+		speed = <10000>;
+		full-duplex;
+	};
 };
 
 &cp1_eth1 {
-- 
2.17.0
