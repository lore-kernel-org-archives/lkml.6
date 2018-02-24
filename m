Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751665AbeBXX1a (ORCPT <rfc822;w@1wt.eu>);
        Sat, 24 Feb 2018 18:27:30 -0500
Received: from kvm5.telegraphics.com.au ([98.124.60.144]:58370 "EHLO
        kvm5.telegraphics.com.au" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751487AbeBXX1Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Feb 2018 18:27:25 -0500
To: "David S. Miller" <davem@davemloft.net>
Cc: netdev@vger.kernel.org, linux-m68k@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert@linux-m68k.org>
Message-Id: <855f562229a4738706e30bcf232c58f14912f37e.1519514463.git.fthain@telegraphics.com.au>
In-Reply-To: <cover.1519514463.git.fthain@telegraphics.com.au>
References: <cover.1519514463.git.fthain@telegraphics.com.au>
From: Finn Thain <fthain@telegraphics.com.au>
Subject: [PATCH net 2/4] net/macsonic: Drop redundant MACH_IS_MAC test
Date: Sat, 24 Feb 2018 18:27:25 -0500 (EST)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The MACH_IS_MAC test is redundant here because the platform device
won't get registered unless MACH_IS_MAC.

Cc: Geert Uytterhoeven <geert@linux-m68k.org>
Signed-off-by: Finn Thain <fthain@telegraphics.com.au>
---
 drivers/net/ethernet/natsemi/macsonic.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/net/ethernet/natsemi/macsonic.c b/drivers/net/ethernet/natsemi/macsonic.c
index c744912f55a9..f6745a893c82 100644
--- a/drivers/net/ethernet/natsemi/macsonic.c
+++ b/drivers/net/ethernet/natsemi/macsonic.c
@@ -311,9 +311,6 @@ static int mac_onboard_sonic_probe(struct net_device *dev)
 	int sr;
 	bool commslot = macintosh_config->expansion_type == MAC_EXP_PDS_COMM;
 
-	if (!MACH_IS_MAC)
-		return -ENODEV;
-
 	printk(KERN_INFO "Checking for internal Macintosh ethernet (SONIC).. ");
 
 	/* Bogus probing, on the models which may or may not have
-- 
2.16.1
