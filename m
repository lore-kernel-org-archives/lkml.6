Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932681AbeCEWL4 (ORCPT <rfc822;w@1wt.eu>);
        Mon, 5 Mar 2018 17:11:56 -0500
Received: from gateway23.websitewelcome.com ([192.185.50.104]:20197 "EHLO
        gateway23.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751275AbeCEWLz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Mar 2018 17:11:55 -0500
Date: Mon, 5 Mar 2018 16:11:54 -0600
From: "Gustavo A. R. Silva" <garsilva@embeddedor.com>
To: "David S. Miller" <davem@davemloft.net>,
        Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>,
        Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <garsilva@embeddedor.com>
Subject: [PATCH] ipv6: ndisc: use true and false for boolean values
Message-ID: <20180305221154.GA17126@embeddedor.com>
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
X-Exim-ID: 1esyKo-002I4k-KJ
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: 187-162-245-224.static.axtel.net (embeddedor) [187.162.245.224]:41320
X-Source-Auth: garsilva@embeddedor.com
X-Email-Count: 9
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Assign true or false to boolean variables instead of an integer value.

This issue was detected with the help of Coccinelle.

Signed-off-by: Gustavo A. R. Silva <garsilva@embeddedor.com>
---
 net/ipv6/ndisc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/ipv6/ndisc.c b/net/ipv6/ndisc.c
index 0a19ce3..8af5eef 100644
--- a/net/ipv6/ndisc.c
+++ b/net/ipv6/ndisc.c
@@ -527,7 +527,7 @@ void ndisc_send_na(struct net_device *dev, const struct in6_addr *daddr,
 	}
 
 	if (!dev->addr_len)
-		inc_opt = 0;
+		inc_opt = false;
 	if (inc_opt)
 		optlen += ndisc_opt_addr_space(dev,
 					       NDISC_NEIGHBOUR_ADVERTISEMENT);
-- 
2.7.4
