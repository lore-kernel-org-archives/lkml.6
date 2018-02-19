Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753404AbeBSSKY (ORCPT <rfc822;w@1wt.eu>);
        Mon, 19 Feb 2018 13:10:24 -0500
Received: from gateway34.websitewelcome.com ([192.185.149.105]:41316 "EHLO
        gateway34.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1753185AbeBSSKW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Feb 2018 13:10:22 -0500
Date: Mon, 19 Feb 2018 12:10:20 -0600
From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
To: Santosh Shilimkar <santosh.shilimkar@oracle.com>,
        "David S. Miller" <davem@davemloft.net>
Cc: netdev@vger.kernel.org, linux-rdma@vger.kernel.org,
        rds-devel@oss.oracle.com, linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <garsilva@embeddedor.com>
Subject: [PATCH] rds: send: mark expected switch fall-through in rds_rm_size
Message-ID: <20180219181020.GA19154@embeddedgus>
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
X-Exim-ID: 1enptN-001fdY-OI
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: (embeddedgus) [189.175.117.58]:40002
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 6
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In preparation to enabling -Wimplicit-fallthrough, mark switch cases
where we are expecting to fall through.

Addresses-Coverity-ID: 1465362 ("Missing break in switch")
Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
---
 net/rds/send.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/net/rds/send.c b/net/rds/send.c
index 028ab59..79d158b 100644
--- a/net/rds/send.c
+++ b/net/rds/send.c
@@ -902,6 +902,8 @@ static int rds_rm_size(struct msghdr *msg, int num_sgs)
 
 		case RDS_CMSG_ZCOPY_COOKIE:
 			zcopy_cookie = true;
+			/* fall through */
+
 		case RDS_CMSG_RDMA_DEST:
 		case RDS_CMSG_RDMA_MAP:
 			cmsg_groups |= 2;
-- 
2.7.4
