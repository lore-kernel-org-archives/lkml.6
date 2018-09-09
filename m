Return-Path: <SRS0=M2MR=LX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B71AC4321E
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Sep 2018 03:14:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DEEB520868
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Sep 2018 03:14:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="prP9TBm+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DEEB520868
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726614AbeIIICr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 9 Sep 2018 04:02:47 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:39757 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726084AbeIIICr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Sep 2018 04:02:47 -0400
Received: by mail-pl1-f195.google.com with SMTP id w14-v6so8218798plp.6;
        Sat, 08 Sep 2018 20:14:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=GhY3DmQ9BsvZWqdEEN8HV7YTQMSzzMSmMd7WY+M+bZI=;
        b=prP9TBm+I/plKQo6oZXy/J7sXSXTcxCSzI66qtK6TWtd6SJ5Qr9NmKgbJ5kHIWHaQk
         FIDrq5Y+/7XAtIiqkAIMF8QcoqvYDDpJdSfc43XN1odc764HQi2UfpmMCPspi/iqb6dZ
         U8AsNGZ9OTD9isNrQEeZSReRtskSs1wuWJI98RHiFnBWB3xVZdiSsY0HzPplb/Em2tK6
         x8If+4CvOuvsxQ0HiWtmJR8x2R2lu4brkqVKzS8wnQnBa4k5AESTA4j53McvRQ2Z/RKZ
         U5xvzM3ki84vHhxwpzT4bnl6IWprGSI3iSZTk7t28+3TNxqkXh8C9Ob1DSfukUvJRUb6
         VjgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=GhY3DmQ9BsvZWqdEEN8HV7YTQMSzzMSmMd7WY+M+bZI=;
        b=VafqNLX3cl6kDHLB0dZq2nrOTK0UGo1Th7EutNFdiHYpDGwUw9vBOr1GC9piPUQh6T
         igrzt11MSbeYFqiPnLJeXYbgjBreFf3nZ9nNjVn2IQD36uxXuz066uW/+fS4Hr2deJJw
         zyvaE6N6Q1NUJQLAfbtbyC32QIvsAKG6FEo79KEnIhWM4ySURo1IzKT3l/w9ty2aSeWI
         dQC6P+gut8KoNBSLC598qCQ8ZCvvG9Cba8xjHoz7B1ceB47nVDk7nQG9BMbxQiTh4EwA
         vB8+uTzrYTDsfiam3DAGaDLrLRjc+JxpYtwPnrHKYiJ/am+13hExngqoZgMm3bPdHljv
         TNoA==
X-Gm-Message-State: APzg51AXqEugRqe1cwCqKIUaTWyeJTy/U4TLIGls7tsE+d0FMKo/GCUy
        tsyuzq1HtQoj4eEVuaieRLA=
X-Google-Smtp-Source: ANB0VdaDL8xMyjcgraNYiyjwVfAlRIG5cMN8CRs0vVJ47hOur4zE60/Xpu/dJ8JLpCrgH3V7KDH/8g==
X-Received: by 2002:a17:902:6b4b:: with SMTP id g11-v6mr13002053plt.19.1536462885125;
        Sat, 08 Sep 2018 20:14:45 -0700 (PDT)
Received: from bogon.didichuxing.com ([203.100.54.194])
        by smtp.gmail.com with ESMTPSA id c17-v6sm29086961pfk.187.2018.09.08.20.14.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 08 Sep 2018 20:14:44 -0700 (PDT)
From:   Yafang Shao <laoar.shao@gmail.com>
To:     edumazet@google.com, davem@davemloft.net
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Yafang Shao <laoar.shao@gmail.com>
Subject: [PATCH v2 net-next 1/2] tcp: show number of network segments in some SNMP counters
Date:   Sun,  9 Sep 2018 11:14:21 +0800
Message-Id: <1536462862-11767-1-git-send-email-laoar.shao@gmail.com>
X-Mailer: git-send-email 1.8.3.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It is better to show the number of network segments in bellow SNMP
counters, because that could be more useful for the user.
For example, the user could easily figure out how mant packets are
dropped and how many packets are queued in the out-of-oder queue.

- LINUX_MIB_TCPRCVQDROP
- LINUX_MIB_TCPZEROWINDOWDROP
- LINUX_MIB_TCPBACKLOGDROP
- LINUX_MIB_TCPMINTTLDROP
- LINUX_MIB_TCPOFODROP
- LINUX_MIB_TCPOFOQUEUE

Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
---
 net/ipv4/tcp_input.c | 18 ++++++++++++------
 net/ipv4/tcp_ipv4.c  |  9 ++++++---
 net/ipv6/tcp_ipv6.c  |  6 ++++--
 3 files changed, 22 insertions(+), 11 deletions(-)

diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
index 62508a2..c2ce334 100644
--- a/net/ipv4/tcp_input.c
+++ b/net/ipv4/tcp_input.c
@@ -4496,7 +4496,8 @@ static void tcp_data_queue_ofo(struct sock *sk, struct sk_buff *skb)
 	tcp_ecn_check_ce(sk, skb);
 
 	if (unlikely(tcp_try_rmem_schedule(sk, skb, skb->truesize))) {
-		NET_INC_STATS(sock_net(sk), LINUX_MIB_TCPOFODROP);
+		NET_ADD_STATS(sock_net(sk), LINUX_MIB_TCPOFODROP,
+			      max_t(u16, 1, skb_shinfo(skb)->gso_segs));
 		tcp_drop(sk, skb);
 		return;
 	}
@@ -4505,7 +4506,8 @@ static void tcp_data_queue_ofo(struct sock *sk, struct sk_buff *skb)
 	tp->pred_flags = 0;
 	inet_csk_schedule_ack(sk);
 
-	NET_INC_STATS(sock_net(sk), LINUX_MIB_TCPOFOQUEUE);
+	NET_ADD_STATS(sock_net(sk), LINUX_MIB_TCPOFOQUEUE,
+		      max_t(u16, 1, skb_shinfo(skb)->gso_segs));
 	seq = TCP_SKB_CB(skb)->seq;
 	end_seq = TCP_SKB_CB(skb)->end_seq;
 	SOCK_DEBUG(sk, "out of order segment: rcv_next %X seq %X - %X\n",
@@ -4666,7 +4668,8 @@ int tcp_send_rcvq(struct sock *sk, struct msghdr *msg, size_t size)
 	skb->len = size;
 
 	if (tcp_try_rmem_schedule(sk, skb, skb->truesize)) {
-		NET_INC_STATS(sock_net(sk), LINUX_MIB_TCPRCVQDROP);
+		NET_ADD_STATS(sock_net(sk), LINUX_MIB_TCPRCVQDROP,
+			      max_t(u16, 1, skb_shinfo(skb)->gso_segs));
 		goto err_free;
 	}
 
@@ -4725,7 +4728,8 @@ static void tcp_data_queue(struct sock *sk, struct sk_buff *skb)
 	 */
 	if (TCP_SKB_CB(skb)->seq == tp->rcv_nxt) {
 		if (tcp_receive_window(tp) == 0) {
-			NET_INC_STATS(sock_net(sk), LINUX_MIB_TCPZEROWINDOWDROP);
+			NET_ADD_STATS(sock_net(sk), LINUX_MIB_TCPZEROWINDOWDROP,
+				      max_t(u16, 1, skb_shinfo(skb)->gso_segs));
 			goto out_of_window;
 		}
 
@@ -4734,7 +4738,8 @@ static void tcp_data_queue(struct sock *sk, struct sk_buff *skb)
 		if (skb_queue_len(&sk->sk_receive_queue) == 0)
 			sk_forced_mem_schedule(sk, skb->truesize);
 		else if (tcp_try_rmem_schedule(sk, skb, skb->truesize)) {
-			NET_INC_STATS(sock_net(sk), LINUX_MIB_TCPRCVQDROP);
+			NET_ADD_STATS(sock_net(sk), LINUX_MIB_TCPRCVQDROP,
+				      max_t(u16, 1, skb_shinfo(skb)->gso_segs));
 			goto drop;
 		}
 
@@ -4796,7 +4801,8 @@ static void tcp_data_queue(struct sock *sk, struct sk_buff *skb)
 		 * remembering D-SACK for its head made in previous line.
 		 */
 		if (!tcp_receive_window(tp)) {
-			NET_INC_STATS(sock_net(sk), LINUX_MIB_TCPZEROWINDOWDROP);
+			NET_ADD_STATS(sock_net(sk), LINUX_MIB_TCPZEROWINDOWDROP,
+				      max_t(u16, 1, skb_shinfo(skb)->gso_segs));
 			goto out_of_window;
 		}
 		goto queue_and_out;
diff --git a/net/ipv4/tcp_ipv4.c b/net/ipv4/tcp_ipv4.c
index 09547ef..23d7cb5 100644
--- a/net/ipv4/tcp_ipv4.c
+++ b/net/ipv4/tcp_ipv4.c
@@ -475,7 +475,8 @@ void tcp_v4_err(struct sk_buff *icmp_skb, u32 info)
 		goto out;
 
 	if (unlikely(iph->ttl < inet_sk(sk)->min_ttl)) {
-		__NET_INC_STATS(net, LINUX_MIB_TCPMINTTLDROP);
+		__NET_ADD_STATS(net, LINUX_MIB_TCPMINTTLDROP,
+				max_t(u16, 1, skb_shinfo(skb)->gso_segs));
 		goto out;
 	}
 
@@ -1633,7 +1634,8 @@ bool tcp_add_backlog(struct sock *sk, struct sk_buff *skb)
 
 	if (unlikely(sk_add_backlog(sk, skb, limit))) {
 		bh_unlock_sock(sk);
-		__NET_INC_STATS(sock_net(sk), LINUX_MIB_TCPBACKLOGDROP);
+		__NET_ADD_STATS(sock_net(sk), LINUX_MIB_TCPBACKLOGDROP,
+				max_t(u16, 1, skb_shinfo(skb)->gso_segs));
 		return true;
 	}
 	return false;
@@ -1790,7 +1792,8 @@ int tcp_v4_rcv(struct sk_buff *skb)
 		}
 	}
 	if (unlikely(iph->ttl < inet_sk(sk)->min_ttl)) {
-		__NET_INC_STATS(net, LINUX_MIB_TCPMINTTLDROP);
+		__NET_ADD_STATS(net, LINUX_MIB_TCPMINTTLDROP,
+				max_t(u16, 1, skb_shinfo(skb)->gso_segs));
 		goto discard_and_relse;
 	}
 
diff --git a/net/ipv6/tcp_ipv6.c b/net/ipv6/tcp_ipv6.c
index 03e6b7a..bbf7667 100644
--- a/net/ipv6/tcp_ipv6.c
+++ b/net/ipv6/tcp_ipv6.c
@@ -391,7 +391,8 @@ static void tcp_v6_err(struct sk_buff *skb, struct inet6_skb_parm *opt,
 		goto out;
 
 	if (ipv6_hdr(skb)->hop_limit < inet6_sk(sk)->min_hopcount) {
-		__NET_INC_STATS(net, LINUX_MIB_TCPMINTTLDROP);
+		__NET_ADD_STATS(net, LINUX_MIB_TCPMINTTLDROP,
+				max_t(u16, 1, skb_shinfo(skb)->gso_segs));
 		goto out;
 	}
 
@@ -1523,7 +1524,8 @@ static int tcp_v6_rcv(struct sk_buff *skb)
 		}
 	}
 	if (hdr->hop_limit < inet6_sk(sk)->min_hopcount) {
-		__NET_INC_STATS(net, LINUX_MIB_TCPMINTTLDROP);
+		__NET_ADD_STATS(net, LINUX_MIB_TCPMINTTLDROP,
+				max_t(u16, 1, skb_shinfo(skb)->gso_segs));
 		goto discard_and_relse;
 	}
 
-- 
1.8.3.1

