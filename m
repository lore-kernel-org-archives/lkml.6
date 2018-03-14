Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752047AbeCNPiN (ORCPT <rfc822;w@1wt.eu>);
        Wed, 14 Mar 2018 11:38:13 -0400
Received: from mout.kundenserver.de ([212.227.126.134]:49897 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750998AbeCNPiK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Mar 2018 11:38:10 -0400
From: Arnd Bergmann <arnd@arndb.de>
To: linux-kernel@vger.kernel.org
Cc: Arnd Bergmann <arnd@arndb.de>, Nicolas Pitre <nico@fluxnic.net>,
        Finn Thain <fthain@telegraphics.com.au>,
        "David S. Miller" <davem@davemloft.net>, netdev@vger.kernel.org
Subject: [PATCH 06/47] net: smsc: remove m32r specific smc91x configuration
Date: Wed, 14 Mar 2018 16:35:19 +0100
Message-Id: <20180314153603.3127932-7-arnd@arndb.de>
X-Mailer: git-send-email 2.9.0
In-Reply-To: <20180314153603.3127932-1-arnd@arndb.de>
References: <20180314153603.3127932-1-arnd@arndb.de>
X-Provags-ID: V03:K0:DW46V2n8dP+FxkKlvkRJwW6+l3EveZFk+zpTozhYtVghiu1ic4l
 DHtyD5FeQmZzUt7xb1PTFWbLnkuv4br7qNb/t0+WSfaRpQ65XrqCfQd41C+HsxtyBkNezY9
 rQtyGqXAoPhZ5cMBao8jROEDMtSjOR9GifF+qsgHdOvaE2QERy+KolM0O7WMQuFNuFdICkz
 evYpR349bIjKXo0ZCG3CQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:mmBnsRyNXqU=:gM5d2KU9ocSVfkAHyxzpDX
 jTijsBhpN1DrpDaQzl5UR+0RlVNnQ457md1r55tTArrgcoj3wOFfaSAm1slWD/tZF6byE+Wtl
 3KtrfqOxg3eeXczpYma9O4rNTHu8FHS3WvhvvUkZyWUMBgi/SqOQoFSU9hy+Rs1ecJOsHF1kP
 EOmPlZPST0aVe4koz9MYNvxZ6pqFGty3C3DiBTdAwy1M0UJxy7pyBedQwxZ+WXD6kx+eQTWaQ
 TRvlpc+/UVzlp66l0M9Alq6uO0H0Y+oHEKSyl83Jss2w7cNvP+p6XbSl8dyWqVXqixtzhrhZD
 r2Jz1LdHunrvQl2ByRZrOMOJXQxarRtiT+htrtkf2HcuDFs8geb04UWex1XWq4oqQMHvLRrc9
 Vf8gCyIPsXkdJqKLG2xMtoQGkCKRg++1A7nCvZmmErAgXi8kOvR67PqdgteW4F+vjlxwIjKk7
 owvWiRwtrLz6JncYRq+bQbhjSTx82c1Lmh0eTAoox5NmGWLc25w4tG8vd703715wqvDqPt6NY
 nc9DJiHkwmNDUoi6mFPxavfGadiz/LqVuk/A2oB2VG4krMpFkE8tVIYHFiV46GAWg9+GSWhIz
 pGhAnfXJAnGYIC9ONb+5othaKWN0oeoVVqFsFavjXaGkflY1g1GqDm2Zv2qvR4B5Pf2Gg0uRs
 cqrwpKhB5fCSnBzIlZa5D8Z/adZV8bvRLqnVGvxeeCfFCinO6CmAsgBYd//Qr+sD1qHvcA0kx
 unlQKVrTfsnWU98Lq9OKJffZuqDO0nkdqTaWBg==
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The m32r architecture is getting removed, so this part can be
cleaned up as well.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/net/ethernet/smsc/Kconfig  |  4 ++--
 drivers/net/ethernet/smsc/smc91x.h | 26 --------------------------
 2 files changed, 2 insertions(+), 28 deletions(-)

diff --git a/drivers/net/ethernet/smsc/Kconfig b/drivers/net/ethernet/smsc/Kconfig
index 4c2f612e4414..1c2b6663f7ce 100644
--- a/drivers/net/ethernet/smsc/Kconfig
+++ b/drivers/net/ethernet/smsc/Kconfig
@@ -37,8 +37,8 @@ config SMC91X
 	select CRC32
 	select MII
 	depends on !OF || GPIOLIB
-	depends on ARM || ARM64 || ATARI_ETHERNAT || BLACKFIN || COLDFIRE || \
-		   M32R || MIPS || MN10300 || NIOS2 || SUPERH || XTENSA || H8300
+	depends on ARM || ARM64 || ATARI_ETHERNAT || COLDFIRE || \
+		   MIPS || NIOS2 || SUPERH || XTENSA || H8300
 	---help---
 	  This is a driver for SMC's 91x series of Ethernet chipsets,
 	  including the SMC91C94 and the SMC91C111. Say Y if you want it
diff --git a/drivers/net/ethernet/smsc/smc91x.h b/drivers/net/ethernet/smsc/smc91x.h
index 08b17adf0a65..b337ee97e0c0 100644
--- a/drivers/net/ethernet/smsc/smc91x.h
+++ b/drivers/net/ethernet/smsc/smc91x.h
@@ -144,32 +144,6 @@ static inline void _SMC_outw_align4(u16 val, void __iomem *ioaddr, int reg,
 
 #define SMC_IRQ_FLAGS		(0)
 
-#elif   defined(CONFIG_M32R)
-
-#define SMC_CAN_USE_8BIT	0
-#define SMC_CAN_USE_16BIT	1
-#define SMC_CAN_USE_32BIT	0
-
-#define SMC_inb(a, r)		inb(((u32)a) + (r))
-#define SMC_inw(a, r)		inw(((u32)a) + (r))
-#define SMC_outb(v, a, r)	outb(v, ((u32)a) + (r))
-#define SMC_outw(lp, v, a, r)	outw(v, ((u32)a) + (r))
-#define SMC_insw(a, r, p, l)	insw(((u32)a) + (r), p, l)
-#define SMC_outsw(a, r, p, l)	outsw(((u32)a) + (r), p, l)
-
-#define SMC_IRQ_FLAGS		(0)
-
-#define RPC_LSA_DEFAULT		RPC_LED_TX_RX
-#define RPC_LSB_DEFAULT		RPC_LED_100_10
-
-#elif defined(CONFIG_MN10300)
-
-/*
- * MN10300/AM33 configuration
- */
-
-#include <unit/smc91111.h>
-
 #elif defined(CONFIG_ATARI)
 
 #define SMC_CAN_USE_8BIT        1
-- 
2.9.0
