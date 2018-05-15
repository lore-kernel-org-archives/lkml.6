Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752608AbeEOXtM (ORCPT <rfc822;w@1wt.eu>);
        Tue, 15 May 2018 19:49:12 -0400
Received: from mail-pf0-f193.google.com ([209.85.192.193]:41426 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752274AbeEOXsg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 May 2018 19:48:36 -0400
X-Google-Smtp-Source: AB8JxZq68AfLV+YcsS3JiHolLIPG++dTc1mZ1KDuRQgqMi1rLHm4Q0cjTMXB9WIbX4ZGHM1WD2z/Yg==
From: Florian Fainelli <f.fainelli@gmail.com>
To: netdev@vger.kernel.org
Cc: Florian Fainelli <f.fainelli@gmail.com>,
        "David S. Miller" <davem@davemloft.net>, Andrew Lunn <andrew@lunn.ch>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH net-next 3/3] net: phy: Allow MDIO_MOXART and MDIO_SUN4I with COMPILE_TEST
Date: Tue, 15 May 2018 16:48:25 -0700
Message-Id: <20180515234825.11240-4-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <20180515234825.11240-1-f.fainelli@gmail.com>
References: <20180515234825.11240-1-f.fainelli@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Those drivers build just fine with COMPILE_TEST, so make that possible.

Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 drivers/net/phy/Kconfig | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/phy/Kconfig b/drivers/net/phy/Kconfig
index 0e2305ccc91f..343989f9f9d9 100644
--- a/drivers/net/phy/Kconfig
+++ b/drivers/net/phy/Kconfig
@@ -118,7 +118,7 @@ config MDIO_I2C
 
 config MDIO_MOXART
 	tristate "MOXA ART MDIO interface support"
-	depends on ARCH_MOXART
+	depends on ARCH_MOXART || COMPILE_TEST
 	help
 	  This driver supports the MDIO interface found in the network
 	  interface units of the MOXA ART SoC
@@ -142,7 +142,7 @@ config MDIO_OCTEON
 
 config MDIO_SUN4I
 	tristate "Allwinner sun4i MDIO interface support"
-	depends on ARCH_SUNXI
+	depends on ARCH_SUNXI || COMPILE_TEST
 	help
 	  This driver supports the MDIO interface found in the network
 	  interface units of the Allwinner SoC that have an EMAC (A10,
-- 
2.14.1
