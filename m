Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752339AbeEQUI1 (ORCPT <rfc822;w@1wt.eu>);
        Thu, 17 May 2018 16:08:27 -0400
Received: from mail-pl0-f66.google.com ([209.85.160.66]:36214 "EHLO
        mail-pl0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752014AbeEQUHx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 May 2018 16:07:53 -0400
X-Google-Smtp-Source: AB8JxZoxIShQDfJ32Uczm5YHo+NwtlLtIXQbmhpJ1GkFQbRlw32u2fYmgskOJebaJosGJ6v3cz6EYg==
From: Florian Fainelli <f.fainelli@gmail.com>
To: netdev@vger.kernel.org
Cc: fugang.duan@nxp.com, Florian Fainelli <f.fainelli@gmail.com>,
        "David S. Miller" <davem@davemloft.net>, Andrew Lunn <andrew@lunn.ch>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH net-next v3 2/3] net: ethernet: freescale: Allow FEC with COMPILE_TEST
Date: Thu, 17 May 2018 13:07:44 -0700
Message-Id: <20180517200745.19142-3-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <20180517200745.19142-1-f.fainelli@gmail.com>
References: <20180517200745.19142-1-f.fainelli@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Freescale FEC driver builds fine with COMPILE_TEST, so make that
possible.

Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 drivers/net/ethernet/freescale/Kconfig    | 2 +-
 drivers/net/ethernet/freescale/fec.h      | 2 +-
 drivers/net/ethernet/freescale/fec_main.c | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/freescale/Kconfig b/drivers/net/ethernet/freescale/Kconfig
index 6e490fd2345d..a580a3dcbe59 100644
--- a/drivers/net/ethernet/freescale/Kconfig
+++ b/drivers/net/ethernet/freescale/Kconfig
@@ -22,7 +22,7 @@ if NET_VENDOR_FREESCALE
 config FEC
 	tristate "FEC ethernet controller (of ColdFire and some i.MX CPUs)"
 	depends on (M523x || M527x || M5272 || M528x || M520x || M532x || \
-		   ARCH_MXC || SOC_IMX28)
+		   ARCH_MXC || SOC_IMX28 || COMPILE_TEST)
 	default ARCH_MXC || SOC_IMX28 if ARM
 	select PHYLIB
 	imply PTP_1588_CLOCK
diff --git a/drivers/net/ethernet/freescale/fec.h b/drivers/net/ethernet/freescale/fec.h
index e7381f8ef89d..4778b663653e 100644
--- a/drivers/net/ethernet/freescale/fec.h
+++ b/drivers/net/ethernet/freescale/fec.h
@@ -21,7 +21,7 @@
 
 #if defined(CONFIG_M523x) || defined(CONFIG_M527x) || defined(CONFIG_M528x) || \
     defined(CONFIG_M520x) || defined(CONFIG_M532x) || defined(CONFIG_ARM) || \
-    defined(CONFIG_ARM64)
+    defined(CONFIG_ARM64) || defined(CONFIG_COMPILE_TEST)
 /*
  *	Just figures, Motorola would have to change the offsets for
  *	registers in the same peripheral device on different models
diff --git a/drivers/net/ethernet/freescale/fec_main.c b/drivers/net/ethernet/freescale/fec_main.c
index f3e43db0d6cb..4358f586e28f 100644
--- a/drivers/net/ethernet/freescale/fec_main.c
+++ b/drivers/net/ethernet/freescale/fec_main.c
@@ -2107,7 +2107,7 @@ static int fec_enet_get_regs_len(struct net_device *ndev)
 /* List of registers that can be safety be read to dump them with ethtool */
 #if defined(CONFIG_M523x) || defined(CONFIG_M527x) || defined(CONFIG_M528x) || \
 	defined(CONFIG_M520x) || defined(CONFIG_M532x) || defined(CONFIG_ARM) || \
-	defined(CONFIG_ARM64)
+	defined(CONFIG_ARM64) || defined(CONFIG_COMPILE_TEST)
 static u32 fec_enet_register_offset[] = {
 	FEC_IEVENT, FEC_IMASK, FEC_R_DES_ACTIVE_0, FEC_X_DES_ACTIVE_0,
 	FEC_ECNTRL, FEC_MII_DATA, FEC_MII_SPEED, FEC_MIB_CTRLSTAT, FEC_R_CNTRL,
-- 
2.14.1
