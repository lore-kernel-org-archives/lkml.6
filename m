Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751058AbeCIFnn (ORCPT <rfc822;w@1wt.eu>);
        Fri, 9 Mar 2018 00:43:43 -0500
Received: from gateway32.websitewelcome.com ([192.185.145.111]:41340 "EHLO
        gateway32.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1750880AbeCIFnm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Mar 2018 00:43:42 -0500
Date: Thu, 8 Mar 2018 23:43:40 -0600
From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
To: "David S. Miller" <davem@davemloft.net>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <garsilva@embeddedor.com>
Subject: [PATCH] pktgen: Remove VLA usage
Message-ID: <20180309054340.GA14439@embeddedgus>
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
X-Source-IP: 189.175.117.58
X-Source-L: No
X-Exim-ID: 1euAof-000f55-FB
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: (embeddedgus) [189.175.117.58]:33626
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 3
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In preparation to enabling -Wvla, remove VLA usage and replace it
with a fixed-length array instead.

Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
---
David,

I'm not sure how often this function is being called and,
depending on the frequency it may be worth to use
dynamic memory allocation instead?

Thanks
--
Gustavo

 net/core/pktgen.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/core/pktgen.c b/net/core/pktgen.c
index d81bddd..e2d6ae3 100644
--- a/net/core/pktgen.c
+++ b/net/core/pktgen.c
@@ -907,7 +907,7 @@ static ssize_t pktgen_if_write(struct file *file,
 
 	if (debug) {
 		size_t copy = min_t(size_t, count, 1023);
-		char tb[copy + 1];
+		char tb[1024];
 		if (copy_from_user(tb, user_buffer, copy))
 			return -EFAULT;
 		tb[copy] = 0;
-- 
2.7.4
