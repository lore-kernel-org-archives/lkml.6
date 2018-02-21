Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751407AbeBUWZB (ORCPT <rfc822;w@1wt.eu>);
        Wed, 21 Feb 2018 17:25:01 -0500
Received: from kvm5.telegraphics.com.au ([98.124.60.144]:36460 "EHLO
        kvm5.telegraphics.com.au" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750811AbeBUWY6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Feb 2018 17:24:58 -0500
Date: Thu, 22 Feb 2018 09:24:59 +1100 (AEDT)
From: Finn Thain <fthain@telegraphics.com.au>
To: "David S. Miller" <davem@davemloft.net>
cc: netdev@vger.kernel.org, linux-m68k@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] net/smc9194: Remove bogus CONFIG_MAC reference
Message-ID: <alpine.LNX.2.21.1802191406040.8@nippy.intranet>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

AFAIK the only version of smc9194.c with Mac support is the one in the
linux-mac68k CVS repo, which never made it to the mainline.

Despite that, from v2.3.45, arch/m68k/config.in listed CONFIG_SMC9194
under CONFIG_MAC. This mistake got carried over into Kconfig in v2.5.55.
(See pre-git era "[PATCH] add m68k dependencies to net driver config".)

Signed-off-by: Finn Thain <fthain@telegraphics.com.au>
---
 drivers/net/ethernet/smsc/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/smsc/Kconfig b/drivers/net/ethernet/smsc/Kconfig
index 63aca9f847e1..4c2f612e4414 100644
--- a/drivers/net/ethernet/smsc/Kconfig
+++ b/drivers/net/ethernet/smsc/Kconfig
@@ -20,7 +20,7 @@ if NET_VENDOR_SMSC
 
 config SMC9194
 	tristate "SMC 9194 support"
-	depends on (ISA || MAC && BROKEN)
+	depends on ISA
 	select CRC32
 	---help---
 	  This is support for the SMC9xxx based Ethernet cards. Choose this
-- 
2.16.1
