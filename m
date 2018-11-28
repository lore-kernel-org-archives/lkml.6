Return-Path: <SRS0=rk9P=OH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE4E5C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 12:16:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A791021479
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 12:16:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ab4kNTn3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A791021479
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728044AbeK1XSX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Nov 2018 18:18:23 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:42943 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727676AbeK1XSW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Nov 2018 18:18:22 -0500
Received: by mail-pf1-f194.google.com with SMTP id 64so10076193pfr.9;
        Wed, 28 Nov 2018 04:16:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=Xh6tiGZLNb8HKzn6mfrCdSH7ZYaGCgzrD7GGkf15Y9U=;
        b=ab4kNTn3WH9ycA2B+hKJ+WnYePbJoWhb0mPSEUGI5lJElJdvG3UrffXlPcXQLAlZPE
         o0ujQBMc0pbEA1alzK3qxUD43EnuplHzizb838hrUd5/p9mFOwGyNCQCqF4+fbfQgmu5
         4keQijnPrjAU9PPTLZFaqxiiPXMS6OE63/h58chmKCDpApzkXEk8UNXpXTVSK3KVIz98
         OKnj28p8iHTZYElqi8OL9V2OQ2LQDV3yiNvoeSt5mYubr8yyaFU8dYJiNzDdR5T20MyU
         2BYRxDbuLS0/GDbSn+DimblrozSiM09kaTOWV3bMDHaqst5o/ZdtmAbEfW77SNNdPqvs
         rxKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=Xh6tiGZLNb8HKzn6mfrCdSH7ZYaGCgzrD7GGkf15Y9U=;
        b=rMprI4373YOJe4GJW1Gym8lzFxG5RGrgaH5elUDU6IjxYm+nNGyN4flIFlFjCJWVOI
         ZVoz/q5IgrnRi7+2vwSk+jVvCEyK9HXGet5q5g2n8bS9L5gt7ASOpQ3wRXYtDbTdRKQQ
         le+Cr4ybiieAKJ5i2MpAqHwT5ABQ3qUK62qCZN8c2cj6cOsEjlA+Xae/QvgUXZOlDpvz
         W1lZkhpaP4Fu1J4GxLC2EmKHmVsIcHWjVedAZ+ocMJjryZF7g6MPvyOk4q+ojZ7zigqY
         5n5Etramz54venrXyPrmp1v2f3PDBbvc3bWS3InM5Y05KbRNjhVc415LqBhc+LSMdJL2
         54HQ==
X-Gm-Message-State: AA+aEWZnIcLflclTn0d1PmycE+3xejehUuIrkz4WAFefuo2QECNei3O0
        hwGUHrlqXL37/v1N/eWav1A=
X-Google-Smtp-Source: AFSGD/UUlK5cA3n7woe/xYbSO2WoTPK4FiNd4084pIXpma7+ffXDaQcJQlXxLdg44UoDNfwOJIPvvQ==
X-Received: by 2002:a63:a16:: with SMTP id 22mr32953014pgk.318.1543407413878;
        Wed, 28 Nov 2018 04:16:53 -0800 (PST)
Received: from localhost.localdomain ([203.100.54.194])
        by smtp.gmail.com with ESMTPSA id 85sm11468261pfw.17.2018.11.28.04.16.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 28 Nov 2018 04:16:53 -0800 (PST)
From:   Yafang Shao <laoar.shao@gmail.com>
To:     davem@davemloft.net, edumazet@google.com
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Yafang Shao <laoar.shao@gmail.com>
Subject: [PATCH net-next] tcp: introduce skb_rbtree_walk_safe() and use it in tcp_clean_rtx_queue()
Date:   Wed, 28 Nov 2018 20:16:19 +0800
Message-Id: <1543407379-3144-1-git-send-email-laoar.shao@gmail.com>
X-Mailer: git-send-email 1.8.3.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When walk RB tree, we'd better use skb_rbtree_walk* helpers, that can make
the code more clear.
As skb_rbtree_walk() can't be used in tcp_clean_rtx_queue(), so the new
helper skb_rbtree_walk_safe() is introduced.

Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
---
 include/linux/skbuff.h | 5 +++++
 net/ipv4/tcp_input.c   | 5 ++---
 2 files changed, 7 insertions(+), 3 deletions(-)

diff --git a/include/linux/skbuff.h b/include/linux/skbuff.h
index 73902ac..37ff792 100644
--- a/include/linux/skbuff.h
+++ b/include/linux/skbuff.h
@@ -3256,6 +3256,11 @@ static inline int __skb_grow_rcsum(struct sk_buff *skb, unsigned int len)
 		for (skb = skb_rb_first(root); skb != NULL;			\
 		     skb = skb_rb_next(skb))
 
+#define skb_rbtree_walk_safe(skb, root, tmp)					\
+		for (skb = skb_rb_first(root);					\
+		     tmp = skb ? skb_rb_next(skb) : NULL, skb != NULL;		\
+		     skb = tmp)
+
 #define skb_rbtree_walk_from(skb)						\
 		for (; skb != NULL;						\
 		     skb = skb_rb_next(skb))
diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
index f323978..ab6add2 100644
--- a/net/ipv4/tcp_input.c
+++ b/net/ipv4/tcp_input.c
@@ -3043,7 +3043,7 @@ static int tcp_clean_rtx_queue(struct sock *sk, u32 prior_fack,
 	struct tcp_sock *tp = tcp_sk(sk);
 	u32 prior_sacked = tp->sacked_out;
 	u32 reord = tp->snd_nxt; /* lowest acked un-retx un-sacked seq */
-	struct sk_buff *skb, *next;
+	struct sk_buff *skb, *tmp;
 	bool fully_acked = true;
 	long sack_rtt_us = -1L;
 	long seq_rtt_us = -1L;
@@ -3055,7 +3055,7 @@ static int tcp_clean_rtx_queue(struct sock *sk, u32 prior_fack,
 
 	first_ackt = 0;
 
-	for (skb = skb_rb_first(&sk->tcp_rtx_queue); skb; skb = next) {
+	skb_rbtree_walk_safe(skb, &sk->tcp_rtx_queue, tmp) {
 		struct tcp_skb_cb *scb = TCP_SKB_CB(skb);
 		const u32 start_seq = scb->seq;
 		u8 sacked = scb->sacked;
@@ -3126,7 +3126,6 @@ static int tcp_clean_rtx_queue(struct sock *sk, u32 prior_fack,
 		if (!fully_acked)
 			break;
 
-		next = skb_rb_next(skb);
 		if (unlikely(skb == tp->retransmit_skb_hint))
 			tp->retransmit_skb_hint = NULL;
 		if (unlikely(skb == tp->lost_skb_hint))
-- 
1.8.3.1

