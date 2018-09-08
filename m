Return-Path: <SRS0=P5JM=LW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C66F0C4321E
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Sep 2018 16:58:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5A3612064D
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Sep 2018 16:58:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fiL2ir8N"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5A3612064D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727592AbeIHVpN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 8 Sep 2018 17:45:13 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:44677 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726766AbeIHVpN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Sep 2018 17:45:13 -0400
Received: by mail-pg1-f193.google.com with SMTP id r1-v6so8434750pgp.11;
        Sat, 08 Sep 2018 09:58:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=ZC+x5YdYKHH5XIfsqdWsWQBrSjGQMwaEa1m4lU2A67g=;
        b=fiL2ir8N2zxt6uuaphv/F356LjhungT/I9h7rS5peoJRmpq25UgBdIWu4KMHjXzM/Z
         1OvTQUOAjb+KZyWq8LZ0ZFiP8o8A41zz6Wx8VWnP67u6h/NDStRM7D4uhdagnvFrm1NO
         VKiZoZajfPjTf8ltTYVt05K5wldYK6ezShWGlG0tQWkK9XISChHfpBkq4/QtyUYtn26+
         IZQx6e4+XnYFqJkFt05MXZHgXH/4LGmeN4+VwzD35yJ8mbOQjPKkwiPOnE640pjUJS01
         +2F/GwEaYvccKglXZVCSHkVFkQ+2sDt3WjSKcavVXgj1SDQHKWL2Z6l4GSRldR1LUujg
         Lyqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=ZC+x5YdYKHH5XIfsqdWsWQBrSjGQMwaEa1m4lU2A67g=;
        b=aQm/t9A8GgusdPO7mEb24sCojF4DJtGRa8Hm/j7h6+MsIT3i1CGVTHJh4PQRB//Exm
         EkQ/xaHtJR5cYSQxZ/15oS2/IWzrqChjicoPHCTDsNvZEh6KncgIqlUdcfuPaNRN2bJy
         O865nMxKNJb5kUjhxHjUvR26xICanGef2FZTj3w4IrIpq7e/jYxSj+FSTecS8TPa4XAN
         o6ArsMChNi0DtJcXbFdqe+h73gSwAXckIo8o/9/n1buiIEOCJK8JBqnUFXa38aoGX2Bd
         ITVQYrlYSJjMoJF0Mqarr3VTEVMpsrSWspm1N0rUsFPPdS3ybj8D8zxHY73/Fo9oCrjl
         lmOQ==
X-Gm-Message-State: APzg51A+p8vWA1NtcXqv6DmyU96CcZiNFEYF0mrr8KdJsDJWPXK8BOJM
        GZEn2tEmniDJCvQWqbdzbWoowqiK
X-Google-Smtp-Source: ANB0VdZXLuJELpxpqnqdGruRIUy0vg01/5rtBt8swPR6Rns8Hp8GL0malg1/ZQBwlSObYMec4kuh6A==
X-Received: by 2002:a63:6a06:: with SMTP id f6-v6mr14128093pgc.63.1536425928471;
        Sat, 08 Sep 2018 09:58:48 -0700 (PDT)
Received: from bogon.didichuxing.com ([203.100.54.194])
        by smtp.gmail.com with ESMTPSA id z6-v6sm14601209pgr.41.2018.09.08.09.58.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 08 Sep 2018 09:58:47 -0700 (PDT)
From:   Yafang Shao <laoar.shao@gmail.com>
To:     edumazet@google.com, davem@davemloft.net
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Yafang Shao <laoar.shao@gmail.com>
Subject: [PATCH net-next] tcp: show number of network segments in some SNMP counters
Date:   Sun,  9 Sep 2018 00:58:18 +0800
Message-Id: <1536425898-12059-1-git-send-email-laoar.shao@gmail.com>
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
index 62508a2..90f449b 100644
--- a/net/ipv4/tcp_input.c
+++ b/net/ipv4/tcp_input.c
@@ -4496,7 +4496,8 @@ static void tcp_data_queue_ofo(struct sock *sk, struct sk_buff *skb)
 	tcp_ecn_check_ce(sk, skb);
 
 	if (unlikely(tcp_try_rmem_schedule(sk, skb, skb->truesize))) {
-		NET_INC_STATS(sock_net(sk), LINUX_MIB_TCPOFODROP);
+		NET_ADD_STATS(sock_net(sk), LINUX_MIB_TCPOFODROP,
+			      tcp_skb_pcount(skb));
 		tcp_drop(sk, skb);
 		return;
 	}
@@ -4505,7 +4506,8 @@ static void tcp_data_queue_ofo(struct sock *sk, struct sk_buff *skb)
 	tp->pred_flags = 0;
 	inet_csk_schedule_ack(sk);
 
-	NET_INC_STATS(sock_net(sk), LINUX_MIB_TCPOFOQUEUE);
+	NET_ADD_STATS(sock_net(sk), LINUX_MIB_TCPOFOQUEUE,
+		      tcp_skb_pcount(skb));
 	seq = TCP_SKB_CB(skb)->seq;
 	end_seq = TCP_SKB_CB(skb)->end_seq;
 	SOCK_DEBUG(sk, "out of order segment: rcv_next %X seq %X - %X\n",
@@ -4666,7 +4668,8 @@ int tcp_send_rcvq(struct sock *sk, struct msghdr *msg, size_t size)
 	skb->len = size;
 
 	if (tcp_try_rmem_schedule(sk, skb, skb->truesize)) {
-		NET_INC_STATS(sock_net(sk), LINUX_MIB_TCPRCVQDROP);
+		NET_ADD_STATS(sock_net(sk), LINUX_MIB_TCPRCVQDROP,
+			      tcp_skb_pcount(skb));
 		goto err_free;
 	}
 
@@ -4725,7 +4728,8 @@ static void tcp_data_queue(struct sock *sk, struct sk_buff *skb)
 	 */
 	if (TCP_SKB_CB(skb)->seq == tp->rcv_nxt) {
 		if (tcp_receive_window(tp) == 0) {
-			NET_INC_STATS(sock_net(sk), LINUX_MIB_TCPZEROWINDOWDROP);
+			NET_ADD_STATS(sock_net(sk), LINUX_MIB_TCPZEROWINDOWDROP,
+				      tcp_skb_pcount(skb));
 			goto out_of_window;
 		}
 
@@ -4734,7 +4738,8 @@ static void tcp_data_queue(struct sock *sk, struct sk_buff *skb)
 		if (skb_queue_len(&sk->sk_receive_queue) == 0)
 			sk_forced_mem_schedule(sk, skb->truesize);
 		else if (tcp_try_rmem_schedule(sk, skb, skb->truesize)) {
-			NET_INC_STATS(sock_net(sk), LINUX_MIB_TCPRCVQDROP);
+			NET_ADD_STATS(sock_net(sk), LINUX_MIB_TCPRCVQDROP,
+				      tcp_skb_pcount(skb));
 			goto drop;
 		}
 
@@ -4796,7 +4801,8 @@ static void tcp_data_queue(struct sock *sk, struct sk_buff *skb)
 		 * remembering D-SACK for its head made in previous line.
 		 */
 		if (!tcp_receive_window(tp)) {
-			NET_INC_STATS(sock_net(sk), LINUX_MIB_TCPZEROWINDOWDROP);
+			NET_ADD_STATS(sock_net(sk), LINUX_MIB_TCPZEROWINDOWDROP,
+				      tcp_skb_pcount(skb));
 			goto out_of_window;
 		}
 		goto queue_and_out;
diff --git a/net/ipv4/tcp_ipv4.c b/net/ipv4/tcp_ipv4.c
index 09547ef..f2fe14b 100644
--- a/net/ipv4/tcp_ipv4.c
+++ b/net/ipv4/tcp_ipv4.c
@@ -475,7 +475,8 @@ void tcp_v4_err(struct sk_buff *icmp_skb, u32 info)
 		goto out;
 
 	if (unlikely(iph->ttl < inet_sk(sk)->min_ttl)) {
-		__NET_INC_STATS(net, LINUX_MIB_TCPMINTTLDROP);
+		__NET_ADD_STATS(net, LINUX_MIB_TCPMINTTLDROP,
+				tcp_skb_pcount(skb));
 		goto out;
 	}
 
@@ -1633,7 +1634,8 @@ bool tcp_add_backlog(struct sock *sk, struct sk_buff *skb)
 
 	if (unlikely(sk_add_backlog(sk, skb, limit))) {
 		bh_unlock_sock(sk);
-		__NET_INC_STATS(sock_net(sk), LINUX_MIB_TCPBACKLOGDROP);
+		__NET_ADD_STATS(sock_net(sk), LINUX_MIB_TCPBACKLOGDROP,
+				tcp_skb_pcount(skb));
 		return true;
 	}
 	return false;
@@ -1790,7 +1792,8 @@ int tcp_v4_rcv(struct sk_buff *skb)
 		}
 	}
 	if (unlikely(iph->ttl < inet_sk(sk)->min_ttl)) {
-		__NET_INC_STATS(net, LINUX_MIB_TCPMINTTLDROP);
+		__NET_ADD_STATS(net, LINUX_MIB_TCPMINTTLDROP,
+				tcp_skb_pcount(skb));
 		goto discard_and_relse;
 	}
 
diff --git a/net/ipv6/tcp_ipv6.c b/net/ipv6/tcp_ipv6.c
index 03e6b7a..97dfc16 100644
--- a/net/ipv6/tcp_ipv6.c
+++ b/net/ipv6/tcp_ipv6.c
@@ -391,7 +391,8 @@ static void tcp_v6_err(struct sk_buff *skb, struct inet6_skb_parm *opt,
 		goto out;
 
 	if (ipv6_hdr(skb)->hop_limit < inet6_sk(sk)->min_hopcount) {
-		__NET_INC_STATS(net, LINUX_MIB_TCPMINTTLDROP);
+		__NET_ADD_STATS(net, LINUX_MIB_TCPMINTTLDROP,
+				tcp_skb_pcount(skb));
 		goto out;
 	}
 
@@ -1523,7 +1524,8 @@ static int tcp_v6_rcv(struct sk_buff *skb)
 		}
 	}
 	if (hdr->hop_limit < inet6_sk(sk)->min_hopcount) {
-		__NET_INC_STATS(net, LINUX_MIB_TCPMINTTLDROP);
+		__NET_ADD_STATS(net, LINUX_MIB_TCPMINTTLDROP,
+				tcp_skb_pcount(skb));
 		goto discard_and_relse;
 	}
 
-- 
1.8.3.1

