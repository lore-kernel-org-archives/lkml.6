Return-Path: <SRS0=G4S6=JN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E25EC43142
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 11:51:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3802324046
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 11:51:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QgpG92ZG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3802324046
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S964941AbeF0LvE (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Jun 2018 07:51:04 -0400
Received: from mail-pl0-f68.google.com ([209.85.160.68]:46718 "EHLO
        mail-pl0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752057AbeF0LvC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jun 2018 07:51:02 -0400
Received: by mail-pl0-f68.google.com with SMTP id 30-v6so910378pld.13;
        Wed, 27 Jun 2018 04:51:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=OHrEo2AgVKrod/SdBxhYo7jnJCktAxE7xLDt8XqsCR8=;
        b=QgpG92ZGqgOvhpGcTIPLblvrigqDPXs4tM77UGfinfT91jF8GloKZR7/OlJdxiDlkh
         /WOyfbTuXP+fVAOGl1ud829ooIId8ABiP0Xl3/aeAgY48im4iXk6svLnqLxh0BXPr8Ck
         n7QjQ6bKsCEu3MfzSxWf8cfHvn9vkTKMYtTvFwneBOPvSqUheYtZni9uRXUL2Bm24XTA
         dbKycBTNxVufDoFOIp9NzLq6A2BH9EO2GuPObkPr+S8ouuiWfo6Cp+oGYNR1leRQDEWd
         Fr3uE3NwJObICBbUw0cVaNKwOmh+ieGFJjFGfk6J7tG7tbP0FafnMcGiQrcOScEvX4vV
         ShXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=OHrEo2AgVKrod/SdBxhYo7jnJCktAxE7xLDt8XqsCR8=;
        b=OyfbTuKL5k+2JvG8rto/Eg6ncqZwBdCtwAhB05RSu+F7I6Dr8Ha8i1egdoqiaUsQRM
         CEVT/V/pAkG/Tq3L8V9TeZO72TTBOXC+v206kZMRvmjumpdFdPAT/K/We/S5mXjgvD0R
         eZWfXR7c0cqes88N4CZOp8zDnDoWgV58oKl98SgBynvjQZMdHiWdSUn25gn9sCVckV7z
         mPoFfkV3PNEhFr9hvDi+3615MSxpOXSwGuoA3+ckUeoI3zfdKkMcYILX4o65XQjrSHKi
         UZfoGN6CXPmEYvwrkqXBAIAmEiYaNuuEWi3w/QFlsBg8QZRBpZm67aBCAY2Ki4/dwDOU
         fOCQ==
X-Gm-Message-State: APt69E3Ja8SNcmWNcn8UKrmLkD9N2QjBzMgiwVhXCj7oEFgCN9CM4WUO
        AY7f2KqIL/svsE3O9VlcwDQ=
X-Google-Smtp-Source: ADUXVKKVHppyGBNMwdvHYDLzcWHWKBb/QQrpaZ4GdB/Rjen7Co4EEWWuWtUmgi946fw+QWXQ3CZ36w==
X-Received: by 2002:a17:902:8d98:: with SMTP id v24-v6mr5834318plo.250.1530100261244;
        Wed, 27 Jun 2018 04:51:01 -0700 (PDT)
Received: from localhost.didichuxing.com ([13.94.31.177])
        by smtp.gmail.com with ESMTPSA id n2-v6sm68056pgp.71.2018.06.27.04.50.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 27 Jun 2018 04:51:00 -0700 (PDT)
From:   Yafang Shao <laoar.shao@gmail.com>
To:     edumazet@google.com, davem@davemloft.net
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Yafang Shao <laoar.shao@gmail.com>
Subject: [PATCH net-next] tcp: replace LINUX_MIB_TCPOFODROP with LINUX_MIB_TCPRMEMFULLDROP for drops due to receive buffer full
Date:   Wed, 27 Jun 2018 07:50:16 -0400
Message-Id: <1530100216-13070-1-git-send-email-laoar.shao@gmail.com>
X-Mailer: git-send-email 1.8.3.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When sk_rmem_alloc is larger than the receive buffer and we can't
schedule more memory for it, the skb will be dropped.

In above situation, if this skb is put into the ofo queue,
LINUX_MIB_TCPOFODROP is incremented to track it,
while if this skb is put into the receive queue, there's no record.

So LINUX_MIB_TCPOFODROP is replaced with LINUX_MIB_TCPRMEMFULLDROP to track
this behavior.

Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
---
 include/uapi/linux/snmp.h |  2 +-
 net/ipv4/proc.c           |  2 +-
 net/ipv4/tcp_input.c      | 10 +++++++---
 3 files changed, 9 insertions(+), 5 deletions(-)

diff --git a/include/uapi/linux/snmp.h b/include/uapi/linux/snmp.h
index 97517f3..3a83322 100644
--- a/include/uapi/linux/snmp.h
+++ b/include/uapi/linux/snmp.h
@@ -243,7 +243,6 @@ enum
 	LINUX_MIB_TCPRETRANSFAIL,		/* TCPRetransFail */
 	LINUX_MIB_TCPRCVCOALESCE,		/* TCPRcvCoalesce */
 	LINUX_MIB_TCPOFOQUEUE,			/* TCPOFOQueue */
-	LINUX_MIB_TCPOFODROP,			/* TCPOFODrop */
 	LINUX_MIB_TCPOFOMERGE,			/* TCPOFOMerge */
 	LINUX_MIB_TCPCHALLENGEACK,		/* TCPChallengeACK */
 	LINUX_MIB_TCPSYNCHALLENGE,		/* TCPSYNChallenge */
@@ -280,6 +279,7 @@ enum
 	LINUX_MIB_TCPDELIVEREDCE,		/* TCPDeliveredCE */
 	LINUX_MIB_TCPACKCOMPRESSED,		/* TCPAckCompressed */
 	LINUX_MIB_TCPZEROWINDOWDROP,		/* TCPZeroWindowDrop */
+	LINUX_MIB_TCPRMEMFULLDROP,              /* TCPRmemFullDrop */
 	__LINUX_MIB_MAX
 };
 
diff --git a/net/ipv4/proc.c b/net/ipv4/proc.c
index 225ef34..43ee02d 100644
--- a/net/ipv4/proc.c
+++ b/net/ipv4/proc.c
@@ -251,7 +251,6 @@ static int sockstat_seq_show(struct seq_file *seq, void *v)
 	SNMP_MIB_ITEM("TCPRetransFail", LINUX_MIB_TCPRETRANSFAIL),
 	SNMP_MIB_ITEM("TCPRcvCoalesce", LINUX_MIB_TCPRCVCOALESCE),
 	SNMP_MIB_ITEM("TCPOFOQueue", LINUX_MIB_TCPOFOQUEUE),
-	SNMP_MIB_ITEM("TCPOFODrop", LINUX_MIB_TCPOFODROP),
 	SNMP_MIB_ITEM("TCPOFOMerge", LINUX_MIB_TCPOFOMERGE),
 	SNMP_MIB_ITEM("TCPChallengeACK", LINUX_MIB_TCPCHALLENGEACK),
 	SNMP_MIB_ITEM("TCPSYNChallenge", LINUX_MIB_TCPSYNCHALLENGE),
@@ -288,6 +287,7 @@ static int sockstat_seq_show(struct seq_file *seq, void *v)
 	SNMP_MIB_ITEM("TCPDeliveredCE", LINUX_MIB_TCPDELIVEREDCE),
 	SNMP_MIB_ITEM("TCPAckCompressed", LINUX_MIB_TCPACKCOMPRESSED),
 	SNMP_MIB_ITEM("TCPZeroWindowDrop", LINUX_MIB_TCPZEROWINDOWDROP),
+	SNMP_MIB_ITEM("TCPRmemFullDrop", LINUX_MIB_TCPRMEMFULLDROP),
 	SNMP_MIB_SENTINEL
 };
 
diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
index 9c5b341..d11abb8 100644
--- a/net/ipv4/tcp_input.c
+++ b/net/ipv4/tcp_input.c
@@ -4442,7 +4442,7 @@ static void tcp_data_queue_ofo(struct sock *sk, struct sk_buff *skb)
 	tcp_ecn_check_ce(sk, skb);
 
 	if (unlikely(tcp_try_rmem_schedule(sk, skb, skb->truesize))) {
-		NET_INC_STATS(sock_net(sk), LINUX_MIB_TCPOFODROP);
+		NET_INC_STATS(sock_net(sk), LINUX_MIB_TCPRMEMFULLDROP);
 		tcp_drop(sk, skb);
 		return;
 	}
@@ -4611,8 +4611,10 @@ int tcp_send_rcvq(struct sock *sk, struct msghdr *msg, size_t size)
 	skb->data_len = data_len;
 	skb->len = size;
 
-	if (tcp_try_rmem_schedule(sk, skb, skb->truesize))
+	if (tcp_try_rmem_schedule(sk, skb, skb->truesize)) {
+		NET_INC_STATS(sock_net(sk), LINUX_MIB_TCPRMEMFULLDROP);
 		goto err_free;
+	}
 
 	err = skb_copy_datagram_from_iter(skb, 0, &msg->msg_iter, size);
 	if (err)
@@ -4677,8 +4679,10 @@ static void tcp_data_queue(struct sock *sk, struct sk_buff *skb)
 queue_and_out:
 		if (skb_queue_len(&sk->sk_receive_queue) == 0)
 			sk_forced_mem_schedule(sk, skb->truesize);
-		else if (tcp_try_rmem_schedule(sk, skb, skb->truesize))
+		else if (tcp_try_rmem_schedule(sk, skb, skb->truesize)) {
+			NET_INC_STATS(sock_net(sk), LINUX_MIB_TCPRMEMFULLDROP);
 			goto drop;
+		}
 
 		eaten = tcp_queue_rcv(sk, skb, 0, &fragstolen);
 		tcp_rcv_nxt_update(tp, TCP_SKB_CB(skb)->end_seq);
-- 
1.8.3.1

