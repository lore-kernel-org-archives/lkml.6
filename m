Return-Path: <SRS0=VxZE=JO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36DD5C43144
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 04:23:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D8BFB214C2
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 04:23:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PLlTop09"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D8BFB214C2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753083AbeF1EXf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Jun 2018 00:23:35 -0400
Received: from mail-pl0-f66.google.com ([209.85.160.66]:39472 "EHLO
        mail-pl0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751414AbeF1EXe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jun 2018 00:23:34 -0400
Received: by mail-pl0-f66.google.com with SMTP id s24-v6so2104804plq.6;
        Wed, 27 Jun 2018 21:23:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=80oQ5BXM/Zqa4PsJVTYoHlyaKq7RnK4JoIQmTlYc7gM=;
        b=PLlTop092VwwaQgrRhEVAniO5BZJi62Pj0lk4WUCt3DwzFt1zJ3s0qUOKVqLWB/J2Z
         i/YIkHuzDaBUjFCJWgthdjIM8Box6qC/oWHtMP6jZ9zcVqXsgBMYhggKRrLZvLwisRlJ
         YpSLRXIFWMJevXNLKe38ZZXsIZQjeKQs/lWwLz66aS4YPD4ClZJi2pgvgsSg+IDWPHHV
         u0YjXrItiTkefKrVqURNuReIXbZW93sTFnHZMYtWiXoWPyR25FbfUleY+k9vHtjQmwkD
         w9WmHeSrDq0dv7IWc7HlaGOHvapjzmRdStVmi0Gd51q/1eAgnmyWGOrOr5HxKDaA940r
         LvxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=80oQ5BXM/Zqa4PsJVTYoHlyaKq7RnK4JoIQmTlYc7gM=;
        b=QQlB/7PslyQM+7ry2YBIgp+zmCfG+Ju72KU07Ir197lkGu9YibNZIPTcdMqD1/2U+0
         54eLnJDNnhkbN/KfPhsD1dlsbEXDoQmPyMxZrdrIC9dVz1TMDTN1RqsDt5ao+TG8awKn
         vQvLeEfEg008fGkPttyiHXnNaB0ZX784kEJ71+RUgRFg1jlouW+UUTk7XPOk1Rvarc3o
         Sa1J2AZaCqaagiEgzVIi1FDU4kpr4d2W7kN/ljazk6Cq0h6s6mLtlnje0Y+uIhiz/cMa
         GUmD+phG6eB4ov9b2Qg0QW2tp7mYH+cEmxBcbbQmySSGgpzMncZThNgRs6Q0YmZtIPsH
         LY6A==
X-Gm-Message-State: APt69E3kmDo/HG08LT4CjovNFc2Rr/MBiBC8w0x1ndZUsMc5Ev5aewHN
        TcOhmVGHemGmKg5eqhr00FA=
X-Google-Smtp-Source: ADUXVKJKFOT5lkUj78WEFuo8aFiGicu1zJImgt7QJHCeDqDr79HLBovygTDPROWnxfD8fGm0Kbbc0A==
X-Received: by 2002:a17:902:a9:: with SMTP id a38-v6mr9045270pla.102.1530159813684;
        Wed, 27 Jun 2018 21:23:33 -0700 (PDT)
Received: from localhost.didichuxing.com ([13.94.31.177])
        by smtp.gmail.com with ESMTPSA id h13-v6sm8371307pgp.13.2018.06.27.21.23.24
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 27 Jun 2018 21:23:33 -0700 (PDT)
From:   Yafang Shao <laoar.shao@gmail.com>
To:     edumazet@google.com
Cc:     davem@davemloft.net, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, Yafang Shao <laoar.shao@gmail.com>
Subject: [PATCH v2 net-next] tcp: add new SNMP counter for drops when try to queue in rcv queue
Date:   Thu, 28 Jun 2018 00:22:56 -0400
Message-Id: <1530159776-29919-1-git-send-email-laoar.shao@gmail.com>
X-Mailer: git-send-email 1.8.3.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When sk_rmem_alloc is larger than the receive buffer and we can't
schedule more memory for it, the skb will be dropped.

In above situation, if this skb is put into the ofo queue,
LINUX_MIB_TCPOFODROP is incremented to track it.

While if this skb is put into the receive queue, there's no record.
So a new SNMP counter is introduced to track this behavior.

LINUX_MIB_TCPRCVQDROP:  Number of packets meant to be queued in rcv queue
			but dropped because socket rcvbuf limit hit.

Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
---
 include/uapi/linux/snmp.h | 1 +
 net/ipv4/proc.c           | 1 +
 net/ipv4/tcp_input.c      | 8 ++++++--
 3 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/include/uapi/linux/snmp.h b/include/uapi/linux/snmp.h
index 97517f3..e5ebc83 100644
--- a/include/uapi/linux/snmp.h
+++ b/include/uapi/linux/snmp.h
@@ -280,6 +280,7 @@ enum
 	LINUX_MIB_TCPDELIVEREDCE,		/* TCPDeliveredCE */
 	LINUX_MIB_TCPACKCOMPRESSED,		/* TCPAckCompressed */
 	LINUX_MIB_TCPZEROWINDOWDROP,		/* TCPZeroWindowDrop */
+	LINUX_MIB_TCPRCVQDROP,			/* TCPRcvQDrop */
 	__LINUX_MIB_MAX
 };
 
diff --git a/net/ipv4/proc.c b/net/ipv4/proc.c
index 225ef34..b46e4cf 100644
--- a/net/ipv4/proc.c
+++ b/net/ipv4/proc.c
@@ -288,6 +288,7 @@ static int sockstat_seq_show(struct seq_file *seq, void *v)
 	SNMP_MIB_ITEM("TCPDeliveredCE", LINUX_MIB_TCPDELIVEREDCE),
 	SNMP_MIB_ITEM("TCPAckCompressed", LINUX_MIB_TCPACKCOMPRESSED),
 	SNMP_MIB_ITEM("TCPZeroWindowDrop", LINUX_MIB_TCPZEROWINDOWDROP),
+	SNMP_MIB_ITEM("TCPRcvQDrop", LINUX_MIB_TCPRCVQDROP),
 	SNMP_MIB_SENTINEL
 };
 
diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
index 9c5b341..eecd359 100644
--- a/net/ipv4/tcp_input.c
+++ b/net/ipv4/tcp_input.c
@@ -4611,8 +4611,10 @@ int tcp_send_rcvq(struct sock *sk, struct msghdr *msg, size_t size)
 	skb->data_len = data_len;
 	skb->len = size;
 
-	if (tcp_try_rmem_schedule(sk, skb, skb->truesize))
+	if (tcp_try_rmem_schedule(sk, skb, skb->truesize)) {
+		NET_INC_STATS(sock_net(sk), LINUX_MIB_TCPRCVQDROP);
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
+			NET_INC_STATS(sock_net(sk), LINUX_MIB_TCPRCVQDROP);
 			goto drop;
+		}
 
 		eaten = tcp_queue_rcv(sk, skb, 0, &fragstolen);
 		tcp_rcv_nxt_update(tp, TCP_SKB_CB(skb)->end_seq);
-- 
1.8.3.1

