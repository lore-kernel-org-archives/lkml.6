Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751953AbeB1EWh (ORCPT <rfc822;w@1wt.eu>);
        Tue, 27 Feb 2018 23:22:37 -0500
Received: from kvm5.telegraphics.com.au ([98.124.60.144]:53984 "EHLO
        kvm5.telegraphics.com.au" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751423AbeB1EWd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Feb 2018 23:22:33 -0500
To: "David S. Miller" <davem@davemloft.net>
Cc: netdev@vger.kernel.org, linux-m68k@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert@linux-m68k.org>
Message-Id: <15777453e64262505da0c3b803729672c68e84ff.1519771871.git.fthain@telegraphics.com.au>
In-Reply-To: <cover.1519771871.git.fthain@telegraphics.com.au>
References: <cover.1519771871.git.fthain@telegraphics.com.au>
From: Finn Thain <fthain@telegraphics.com.au>
Subject: [PATCH net 1/2] net/macmace: Drop redundant MACH_IS_MAC test
Date: Tue, 27 Feb 2018 23:22:33 -0500 (EST)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The MACH_IS_MAC test is redundant here because the platform device
won't get registered unless MACH_IS_MAC.
Adopt module_platform_driver() convention.

Cc: Geert Uytterhoeven <geert@linux-m68k.org>
Signed-off-by: Finn Thain <fthain@telegraphics.com.au>
---
 drivers/net/ethernet/apple/macmace.c | 16 +---------------
 1 file changed, 1 insertion(+), 15 deletions(-)

diff --git a/drivers/net/ethernet/apple/macmace.c b/drivers/net/ethernet/apple/macmace.c
index f17a160dbff2..50a43e681a09 100644
--- a/drivers/net/ethernet/apple/macmace.c
+++ b/drivers/net/ethernet/apple/macmace.c
@@ -770,18 +770,4 @@ static struct platform_driver mac_mace_driver = {
 	},
 };
 
-static int __init mac_mace_init_module(void)
-{
-	if (!MACH_IS_MAC)
-		return -ENODEV;
-
-	return platform_driver_register(&mac_mace_driver);
-}
-
-static void __exit mac_mace_cleanup_module(void)
-{
-	platform_driver_unregister(&mac_mace_driver);
-}
-
-module_init(mac_mace_init_module);
-module_exit(mac_mace_cleanup_module);
+module_platform_driver(mac_mace_driver);
-- 
2.16.1
