Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932406AbeCEWpr (ORCPT <rfc822;w@1wt.eu>);
        Mon, 5 Mar 2018 17:45:47 -0500
Received: from gateway20.websitewelcome.com ([192.185.67.41]:46631 "EHLO
        gateway20.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752508AbeCEWpq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Mar 2018 17:45:46 -0500
Date: Mon, 5 Mar 2018 15:56:14 -0600
From: "Gustavo A. R. Silva" <garsilva@embeddedor.com>
To: Jon Maloy <jon.maloy@ericsson.com>, Ying Xue <ying.xue@windriver.com>,
        "David S. Miller" <davem@davemloft.net>
Cc: netdev@vger.kernel.org, tipc-discussion@lists.sourceforge.net,
        linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <garsilva@embeddedor.com>
Subject: [PATCH] tipc: bcast: use true and false for boolean values
Message-ID: <20180305215614.GA15175@embeddedor.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.24 (2015-08-30)
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 187.162.245.224
X-Source-L: No
X-Exim-ID: 1esy5e-0022RZ-Up
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: 187-162-245-224.static.axtel.net (embeddedor) [187.162.245.224]:41286
X-Source-Auth: garsilva@embeddedor.com
X-Email-Count: 23
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Assign true or false to boolean variables instead of an integer value.

This issue was detected with the help of Coccinelle.

Signed-off-by: Gustavo A. R. Silva <garsilva@embeddedor.com>
---
 net/tipc/bcast.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/tipc/bcast.c b/net/tipc/bcast.c
index 37892b3..f371117 100644
--- a/net/tipc/bcast.c
+++ b/net/tipc/bcast.c
@@ -574,5 +574,5 @@ void tipc_nlist_purge(struct tipc_nlist *nl)
 {
 	tipc_dest_list_purge(&nl->list);
 	nl->remote = 0;
-	nl->local = 0;
+	nl->local = false;
 }
-- 
2.7.4
