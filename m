Return-Path: <SRS0=6f18=J7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94701ECDFB1
	for <linux-kernel@archiver.kernel.org>; Sun, 15 Jul 2018 11:14:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 49D52208E0
	for <linux-kernel@archiver.kernel.org>; Sun, 15 Jul 2018 11:14:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="r3B+up46"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 49D52208E0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726307AbeGOLgc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 15 Jul 2018 07:36:32 -0400
Received: from mail-oi0-f65.google.com ([209.85.218.65]:42800 "EHLO
        mail-oi0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726060AbeGOLgc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Jul 2018 07:36:32 -0400
Received: by mail-oi0-f65.google.com with SMTP id n84-v6so69807702oib.9;
        Sun, 15 Jul 2018 04:13:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=ggVq9sRjBMb4saG9utf/MJBHNhFX7rIyYzyqyzSJfpA=;
        b=r3B+up460JGmfkkZsTS2CHkf2TTY88iDHQoqA1TgMS8ApphbiDsaenFzreFz2FVAbn
         fUzoQXFGZcwu5BTThDBoSJkfaAxpt6cgktIohVxM+G+YCsRY2W3RrIa4PJQPMhGFWeXA
         dc800C5UPz20btpdxvZpf071+snYMNgYFrZ6i36s3wnm657tgMMC0MzzRW3gZ1KLmlWn
         BDDVSgMbE7U8iTcJ1wcRzq1qLcsA94HDQqDIwJEbSSo/Oq42L43GfpRGffc65RhYPyK1
         LhB7I5BsvzTFWhJrfCJTH34pVcQKqhSe09+pkn31pa4T+Ty+e1OlnR9FX+xkhrfrcMbE
         FNDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=ggVq9sRjBMb4saG9utf/MJBHNhFX7rIyYzyqyzSJfpA=;
        b=euqG4cYTQXdgRYiv2GKjmnPLY8hOJRq9SAgy4ZUCxZH8Wt/1ZvGSlvgZEA4MdxZ4Tn
         unKZLYYiG4poGb6Z7yVLk4t2kqEtK3Vd080eyU2c0qi1lONhrccJZSCYMBu2TLEA5nhv
         LYR1qPLL5elo/ew63qnsuSXW7aeZjuz5pPH7HjFsSyVeU+hNd52r0Z2u3vLcASTVOPmR
         yTZSBKkGy2xQjkRNRQAhHjx3xRm2M14yAari+Yly/ypvPZij3kz+spfcp8UVbsib7H67
         SCGkc2CTffUoYIHBM33dfHiTn+Lizb/GMgWvdbzcxOZZQIUZhNCkQxRFoLWq7DT96+tF
         UyQw==
X-Gm-Message-State: AOUpUlFOQb5cF4ol5I86e4aGG7Vgq/HaMbbvNeb2q1Gnzaj0oOSrIFA+
        Q0ZeZF0PczrvLk4FTEVKsj/e4A==
X-Google-Smtp-Source: AAOMgpfSTwcHNhB0jQ6Npdjd1o46K1sphwsrpocRAncXcuFWyYJtL6Vsf0F8JWxEgCKVrJdswhiVSA==
X-Received: by 2002:aca:51c3:: with SMTP id f186-v6mr12957093oib.59.1531653235470;
        Sun, 15 Jul 2018 04:13:55 -0700 (PDT)
Received: from xiebaoyou-VirtualBox.DHCP ([205.204.117.16])
        by smtp.gmail.com with ESMTPSA id q124-v6sm12502387oif.8.2018.07.15.04.13.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 15 Jul 2018 04:13:55 -0700 (PDT)
From:   Baoyou Xie <baoyou.xie@gmail.com>
To:     davem@davemloft.net, willemb@google.com, viro@zeniv.linux.org.uk,
        gregkh@linuxfoundation.org, pombredanne@nexb.com,
        tklauser@distanz.ch, matthew@mjdsystems.ca
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Baoyou Xie <baoyou.xie@gmail.com>
Subject: [PATCH v2] datagram: return from __skb_recv_datagram() as soon as possible
Date:   Sun, 15 Jul 2018 19:13:11 +0800
Message-Id: <1531653191-6456-1-git-send-email-baoyou.xie@gmail.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We got a soft lockup in a heavy busy cloud server where RIP is
at _raw_spin_unlock_irqrestore+0x1b/0x40:
        [] finish_wait+0x56/0x70
        [] __skb_recv_datagram+0x3fb/0x5a0
        [] ? datagram_poll+0x100/0x100
        [] skb_recv_datagram+0x41/0x60
        [] netlink_recvmsg+0x62/0x450
        [] sock_recvmsg+0xbf/0x100
        [] ? futex_wait+0x193/0x280
        [] ? finish_task_switch+0x108/0x170
        [] SYSC_recvfrom+0xe8/0x160
        [] ? __schedule+0x3c8/0x990
        [] SyS_recvfrom+0xe/0x10
        [] system_call_fastpath+0x16/0x1b

In fact, a mistake exists in __skb_recv_datagram(). For example,
if a datagram come in persistently after go through the socket
queue, then __skb_wait_for_more_packets() will find out that the
last peeked skb is not the real last one, so it return 0. this
results in long time outer loop, and can trigger soft lockup.

So this patch changes the loop condition to prevent soft lockup.

Signed-off-by: Baoyou Xie <baoyou.xie@gmail.com>
---
 net/core/datagram.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/net/core/datagram.c b/net/core/datagram.c
index 9938952..76c1001 100644
--- a/net/core/datagram.c
+++ b/net/core/datagram.c
@@ -295,9 +295,11 @@ struct sk_buff *__skb_recv_datagram(struct sock *sk, unsigned int flags,
 				    int *peeked, int *off, int *err)
 {
 	struct sk_buff *skb, *last;
+	unsigned long expire;
 	long timeo;
 
 	timeo = sock_rcvtimeo(sk, flags & MSG_DONTWAIT);
+	expire = jiffies + timeo;
 
 	do {
 		skb = __skb_try_recv_datagram(sk, flags, destructor, peeked,
@@ -307,7 +309,7 @@ struct sk_buff *__skb_recv_datagram(struct sock *sk, unsigned int flags,
 
 		if (*err != -EAGAIN)
 			break;
-	} while (timeo &&
+	} while (time_before(jiffies, expire) &&
 		!__skb_wait_for_more_packets(sk, err, &timeo, last));
 
 	return NULL;
-- 
2.7.4

