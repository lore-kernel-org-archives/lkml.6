Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752454AbeEOXsi (ORCPT <rfc822;w@1wt.eu>);
        Tue, 15 May 2018 19:48:38 -0400
Received: from mail-pl0-f66.google.com ([209.85.160.66]:34052 "EHLO
        mail-pl0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751104AbeEOXsd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 May 2018 19:48:33 -0400
X-Google-Smtp-Source: AB8JxZrhSVYkV6FjkmJES9QeNS58TXvWQDtXPA178lhZ0OB2J9c1Dc+QsaWG0LtZi6zzXp+j/HEy0A==
From: Florian Fainelli <f.fainelli@gmail.com>
To: netdev@vger.kernel.org
Cc: Florian Fainelli <f.fainelli@gmail.com>,
        "David S. Miller" <davem@davemloft.net>, Andrew Lunn <andrew@lunn.ch>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH net-next 1/3] net: ethernet: ti: Allow most drivers with COMPILE_TEST
Date: Tue, 15 May 2018 16:48:23 -0700
Message-Id: <20180515234825.11240-2-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <20180515234825.11240-1-f.fainelli@gmail.com>
References: <20180515234825.11240-1-f.fainelli@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Most of the TI drivers build just fine with COMPILE_TEST, cpmac (AR7) is
the exception because it uses a header file from
arch/mips/include/asm/mach-ar7/ar7.h.

Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 drivers/net/ethernet/ti/Kconfig | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/net/ethernet/ti/Kconfig b/drivers/net/ethernet/ti/Kconfig
index 48a541eb0af2..1f8626999ac6 100644
--- a/drivers/net/ethernet/ti/Kconfig
+++ b/drivers/net/ethernet/ti/Kconfig
@@ -18,7 +18,7 @@ if NET_VENDOR_TI
 
 config TI_DAVINCI_EMAC
 	tristate "TI DaVinci EMAC Support"
-	depends on ARM && ( ARCH_DAVINCI || ARCH_OMAP3 )
+	depends on ARM && ( ARCH_DAVINCI || ARCH_OMAP3 ) || COMPILE_TEST
 	select TI_DAVINCI_MDIO
 	select TI_DAVINCI_CPDMA
 	select PHYLIB
@@ -30,7 +30,7 @@ config TI_DAVINCI_EMAC
 
 config TI_DAVINCI_MDIO
 	tristate "TI DaVinci MDIO Support"
-	depends on ARCH_DAVINCI || ARCH_OMAP2PLUS || ARCH_KEYSTONE
+	depends on ARCH_DAVINCI || ARCH_OMAP2PLUS || ARCH_KEYSTONE || COMPILE_TEST
 	select PHYLIB
 	---help---
 	  This driver supports TI's DaVinci MDIO module.
@@ -40,7 +40,7 @@ config TI_DAVINCI_MDIO
 
 config TI_DAVINCI_CPDMA
 	tristate "TI DaVinci CPDMA Support"
-	depends on ARCH_DAVINCI || ARCH_OMAP2PLUS
+	depends on ARCH_DAVINCI || ARCH_OMAP2PLUS || COMPILE_TEST
 	---help---
 	  This driver supports TI's DaVinci CPDMA dma engine.
 
@@ -60,7 +60,7 @@ config TI_CPSW_ALE
 
 config TI_CPSW
 	tristate "TI CPSW Switch Support"
-	depends on ARCH_DAVINCI || ARCH_OMAP2PLUS
+	depends on ARCH_DAVINCI || ARCH_OMAP2PLUS || COMPILE_TEST
 	select TI_DAVINCI_CPDMA
 	select TI_DAVINCI_MDIO
 	select TI_CPSW_PHY_SEL
@@ -75,7 +75,7 @@ config TI_CPSW
 
 config TI_CPTS
 	bool "TI Common Platform Time Sync (CPTS) Support"
-	depends on TI_CPSW || TI_KEYSTONE_NETCP
+	depends on TI_CPSW || TI_KEYSTONE_NETCP || COMPILE_TEST
 	depends on POSIX_TIMERS
 	---help---
 	  This driver supports the Common Platform Time Sync unit of
@@ -95,8 +95,8 @@ config TI_KEYSTONE_NETCP
 	tristate "TI Keystone NETCP Core Support"
 	select TI_CPSW_ALE
 	select TI_DAVINCI_MDIO
-	depends on OF
-	depends on KEYSTONE_NAVIGATOR_DMA && KEYSTONE_NAVIGATOR_QMSS
+	depends on OF && KEYSTONE_NAVIGATOR_DMA && KEYSTONE_NAVIGATOR_QMSS || \
+		   COMPILE_TEST
 	---help---
 	  This driver supports TI's Keystone NETCP Core.
 
-- 
2.14.1
