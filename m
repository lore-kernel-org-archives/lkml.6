Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753345AbeCaHGy (ORCPT <rfc822;w@1wt.eu>);
        Sat, 31 Mar 2018 03:06:54 -0400
Received: from smtprelay0112.hostedemail.com ([216.40.44.112]:43073 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1753028AbeCaHGA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 31 Mar 2018 03:06:00 -0400
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,:::,RULES_HIT:41:355:379:541:800:960:973:981:988:989:1260:1345:1359:1437:1534:1540:1711:1714:1730:1747:1777:1792:2393:2559:2562:3138:3139:3140:3141:3142:3351:3865:3866:4250:4321:5007:6261:7903:10004:10848:11026:11657:11658:11914:12043:12114:12296:12438:12555:12895:12986:13069:13311:13357:14181:14384:14394:14721:21080:21627:30012:30054,0,RBL:47.151.150.235:@perches.com:.lbl8.mailshell.net-62.8.0.100 64.201.201.201,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:fn,MSBL:0,DNSBL:neutral,Custom_rules:0:0:0,LFtime:19,LUA_SUMMARY:none
X-HE-Tag: owner11_8b7face455605
X-Filterd-Recvd-Size: 1567
From: Joe Perches <joe@perches.com>
To: linux-kernel@vger.kernel.org
Cc: netdev@vger.kernel.org
Subject: [PATCH 10/12] mvpp2: Use ether_broadcast_addr instead of a local array
Date: Sat, 31 Mar 2018 00:05:25 -0700
Message-Id: <8e2cec37fd78de62c6e5f683528e8554d1e823b0.1522479609.git.joe@perches.com>
X-Mailer: git-send-email 2.15.0
In-Reply-To: <cover.1522479607.git.joe@perches.com>
References: <cover.1522479607.git.joe@perches.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Save a small bit of object code by using the new global instead.

Signed-off-by: Joe Perches <joe@perches.com>
---
 drivers/net/ethernet/marvell/mvpp2.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/marvell/mvpp2.c b/drivers/net/ethernet/marvell/mvpp2.c
index 7fc1bbf51c44..a848b92f5961 100644
--- a/drivers/net/ethernet/marvell/mvpp2.c
+++ b/drivers/net/ethernet/marvell/mvpp2.c
@@ -7345,11 +7345,9 @@ static int mvpp2_open(struct net_device *dev)
 {
 	struct mvpp2_port *port = netdev_priv(dev);
 	struct mvpp2 *priv = port->priv;
-	unsigned char mac_bcast[ETH_ALEN] = {
-			0xff, 0xff, 0xff, 0xff, 0xff, 0xff };
 	int err;
 
-	err = mvpp2_prs_mac_da_accept(port, mac_bcast, true);
+	err = mvpp2_prs_mac_da_accept(port, ether_broadcast_addr, true);
 	if (err) {
 		netdev_err(dev, "mvpp2_prs_mac_da_accept BC failed\n");
 		return err;
-- 
2.15.0
