Return-Path: <SRS0=drEb=P7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACB8EC282C0
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 07:09:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 83E7F20870
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 07:09:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726277AbfAWHJe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Jan 2019 02:09:34 -0500
Received: from gateway34.websitewelcome.com ([192.185.148.164]:12246 "EHLO
        gateway34.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725991AbfAWHJd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Jan 2019 02:09:33 -0500
Received: from cm17.websitewelcome.com (cm17.websitewelcome.com [100.42.49.20])
        by gateway34.websitewelcome.com (Postfix) with ESMTP id 0C9896E79C4
        for <linux-kernel@vger.kernel.org>; Wed, 23 Jan 2019 01:09:33 -0600 (CST)
Received: from gator4166.hostgator.com ([108.167.133.22])
        by cmsmtp with SMTP
        id mCfFg1fSO90onmCfFgT4b7; Wed, 23 Jan 2019 01:09:33 -0600
X-Authority-Reason: nr=8
Received: from [189.250.130.205] (port=46214 helo=embeddedor)
        by gator4166.hostgator.com with esmtpa (Exim 4.91)
        (envelope-from <gustavo@embeddedor.com>)
        id 1gmCfE-0032VP-7r; Wed, 23 Jan 2019 01:09:32 -0600
Date:   Wed, 23 Jan 2019 01:09:31 -0600
From:   "Gustavo A. R. Silva" <gustavo@embeddedor.com>
To:     Jon Maloy <jon.maloy@ericsson.com>,
        Ying Xue <ying.xue@windriver.com>,
        "David S. Miller" <davem@davemloft.net>
Cc:     netdev@vger.kernel.org, tipc-discussion@lists.sourceforge.net,
        linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Subject: [PATCH net-next] tipc: mark expected switch fall-throughs
Message-ID: <20190123070931.GA5514@embeddedor>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 189.250.130.205
X-Source-L: No
X-Exim-ID: 1gmCfE-0032VP-7r
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: (embeddedor) [189.250.130.205]:46214
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 11
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In preparation to enabling -Wimplicit-fallthrough, mark switch cases
where we are expecting to fall through.

This patch fixes the following warnings:

net/tipc/link.c:1125:6: warning: this statement may fall through [-Wimplicit-fallthrough=]
net/tipc/socket.c:736:6: warning: this statement may fall through [-Wimplicit-fallthrough=]
net/tipc/socket.c:2418:7: warning: this statement may fall through [-Wimplicit-fallthrough=]

Warning level 3 was used: -Wimplicit-fallthrough=3

This patch is part of the ongoing efforts to enabling
-Wimplicit-fallthrough.

Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
---
 net/tipc/link.c   | 2 +-
 net/tipc/socket.c | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/net/tipc/link.c b/net/tipc/link.c
index 2792a3cae682..ac306d17f8ad 100644
--- a/net/tipc/link.c
+++ b/net/tipc/link.c
@@ -1126,7 +1126,7 @@ static bool tipc_data_input(struct tipc_link *l, struct sk_buff *skb,
 			skb_queue_tail(mc_inputq, skb);
 			return true;
 		}
-		/* else: fall through */
+		/* fall through */
 	case CONN_MANAGER:
 		skb_queue_tail(inputq, skb);
 		return true;
diff --git a/net/tipc/socket.c b/net/tipc/socket.c
index 1217c90a363b..8fc5acd4820d 100644
--- a/net/tipc/socket.c
+++ b/net/tipc/socket.c
@@ -735,7 +735,7 @@ static __poll_t tipc_poll(struct file *file, struct socket *sock,
 	case TIPC_CONNECTING:
 		if (!tsk->cong_link_cnt && !tsk_conn_cong(tsk))
 			revents |= EPOLLOUT;
-		/* fall thru' */
+		/* fall through */
 	case TIPC_LISTEN:
 		if (!skb_queue_empty(&sk->sk_receive_queue))
 			revents |= EPOLLIN | EPOLLRDNORM;
@@ -2416,7 +2416,7 @@ static int tipc_connect(struct socket *sock, struct sockaddr *dest,
 		 * case is EINPROGRESS, rather than EALREADY.
 		 */
 		res = -EINPROGRESS;
-		/* fall thru' */
+		/* fall through */
 	case TIPC_CONNECTING:
 		if (!timeout) {
 			if (previous == TIPC_CONNECTING)
-- 
2.20.1

