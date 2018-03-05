Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753166AbeCEVuC (ORCPT <rfc822;w@1wt.eu>);
        Mon, 5 Mar 2018 16:50:02 -0500
Received: from gateway31.websitewelcome.com ([192.185.143.47]:11527 "EHLO
        gateway31.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1753121AbeCEVuA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Mar 2018 16:50:00 -0500
Date: Mon, 5 Mar 2018 15:49:59 -0600
From: "Gustavo A. R. Silva" <garsilva@embeddedor.com>
To: Steffen Klassert <steffen.klassert@secunet.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <garsilva@embeddedor.com>
Subject: [PATCH] xfrm_policy: use true and false for boolean values
Message-ID: <20180305214959.GA14055@embeddedor.com>
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
X-Exim-ID: 1esxzb-001wMv-7q
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: 187-162-245-224.static.axtel.net (embeddedor) [187.162.245.224]:41278
X-Source-Auth: garsilva@embeddedor.com
X-Email-Count: 17
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Assign true or false to boolean variables instead of an integer value.

This issue was detected with the help of Coccinelle.

Signed-off-by: Gustavo A. R. Silva <garsilva@embeddedor.com>
---
 net/xfrm/xfrm_policy.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/xfrm/xfrm_policy.c b/net/xfrm/xfrm_policy.c
index eb88a7d..8a0ac6a 100644
--- a/net/xfrm/xfrm_policy.c
+++ b/net/xfrm/xfrm_policy.c
@@ -1743,7 +1743,7 @@ static void xfrm_pcpu_work_fn(struct work_struct *work)
 void xfrm_policy_cache_flush(void)
 {
 	struct xfrm_dst *old;
-	bool found = 0;
+	bool found = false;
 	int cpu;
 
 	might_sleep();
-- 
2.7.4
