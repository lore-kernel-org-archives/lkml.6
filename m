Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752474AbeC3Pqx (ORCPT <rfc822;w@1wt.eu>);
        Fri, 30 Mar 2018 11:46:53 -0400
Received: from gateway21.websitewelcome.com ([192.185.45.38]:18352 "EHLO
        gateway21.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1750927AbeC3Pqv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Mar 2018 11:46:51 -0400
Date: Fri, 30 Mar 2018 10:46:49 -0500
From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
To: Armin Schindler <mac@melware.de>, Karsten Keil <isdn@linux-pingi.de>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Subject: [PATCH] ISDN: eicon: message: remove redundant check
Message-ID: <20180330154648.GA13995@embeddedgus>
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
X-Source-IP: 189.145.54.187
X-Source-L: No
X-Exim-ID: 1f1wEs-000KLL-93
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: (embeddedgus) [189.145.54.187]:34700
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 10
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Check on plci->internal_command is unnecessary.

Addresses-Coverity-ID: 1268778 ("Identical code for different branches")
Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
---
 drivers/isdn/hardware/eicon/message.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/isdn/hardware/eicon/message.c b/drivers/isdn/hardware/eicon/message.c
index def7992..0ac18fc 100644
--- a/drivers/isdn/hardware/eicon/message.c
+++ b/drivers/isdn/hardware/eicon/message.c
@@ -13886,8 +13886,6 @@ static void adjust_b_restore(dword Id, PLCI *plci, byte Rc)
 			dbug(1, dprintf("[%06lx] %s,%d: Adjust B restore failed",
 					UnMapId(Id), (char *)(FILE_), __LINE__));
 		}
-		if (plci->internal_command)
-			break;
 		break;
 	}
 }
-- 
2.7.4
