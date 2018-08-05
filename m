Return-Path: <SRS0=mdhE=KU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1D53C46471
	for <linux-kernel@archiver.kernel.org>; Sun,  5 Aug 2018 10:25:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 65D19217BF
	for <linux-kernel@archiver.kernel.org>; Sun,  5 Aug 2018 10:25:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oZMlv2Mm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 65D19217BF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726459AbeHEM3p (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 5 Aug 2018 08:29:45 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:45048 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726130AbeHEM3p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Aug 2018 08:29:45 -0400
Received: by mail-pf1-f196.google.com with SMTP id k21-v6so5408845pff.11;
        Sun, 05 Aug 2018 03:25:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=6lpnBrpOld5lBf2pMgr2oP18H94RaA9HBcmfI6pGCiM=;
        b=oZMlv2Mmpgp6FpBSke2wwlNFzIBPa4EVeFPExn4u5t2g4UI14Gx1wRkhY7q943nJ6+
         SQumI6ZxeHxlf7mcWta3EI3XZvEQku9hnj5kziaMU6DzBegkKQ+BYcw6zyHnAa1XbpfH
         ucoszwiVZvYeGfupaCUcAnfy09U9rY0v/8sJNG36u2IdxS0SmKeIjkhxT44gF9IGw4lo
         hr3JuEyfLVn/BYaV5R4Y5fecO28kohjrXII2sijkHofy/X3lTve/OQVusznQO6vnrDAU
         +nGen7knOgwu1UWRVb+qAoLO2KV3D7hYkYtHJzJdMQ9gMzoddr7CnD5t0ji1Tm4LESNu
         cXFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=6lpnBrpOld5lBf2pMgr2oP18H94RaA9HBcmfI6pGCiM=;
        b=Ffw4HR1rFFYWYAmruYKV7T+fHVYpCklIVFj2rrUlvsOAgdjO0i1oWRN5YLp08GfvvN
         6hS9JdeVk84jdcPzwN90HqOg5qNIliX0AR+bBBsyjcNF2ax2Wi7g4HGBGjgWRpzhrY5t
         DYnAcWxHIUSpoVzYveYAO3hNXwA7rXYR0uE5bEYIzF3USPbqMtaAqH/maeeugcQVh9sF
         Zj++dBt15dJSwX1NADqp3vHoyp04KEmFk2auQyZ4dHoyPXGOh3a4pbSRqxO8RtDtWaGv
         0RxfD40rCq69cGtloXwso2uSgnvh3RoYPmLyCQPovoexLwGAURHI/PA2KPnzswsZDKQb
         qncg==
X-Gm-Message-State: AOUpUlH3PrZ6TZZL1i6/964A7ev7Zo7mezE7ja8lpkze/KUGtIuth19G
        FZU7GWol6IYor81yF0Z6lts=
X-Google-Smtp-Source: AAOMgpeGQ5YfH3JKgTqpb2CH4esU0zA+f8fUesuxaQyITyjxJ8C8tmjuz6APT1ujxhhG9oFZKOQbOg==
X-Received: by 2002:a63:686:: with SMTP id 128-v6mr10369439pgg.338.1533464739697;
        Sun, 05 Aug 2018 03:25:39 -0700 (PDT)
Received: from bogon.didichuxing.com ([203.100.54.194])
        by smtp.gmail.com with ESMTPSA id b192-v6sm9351692pga.7.2018.08.05.03.25.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 05 Aug 2018 03:25:39 -0700 (PDT)
From:   Yafang Shao <laoar.shao@gmail.com>
To:     edumazet@google.com, davem@davemloft.net
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Yafang Shao <laoar.shao@gmail.com>
Subject: [PATCH net-next v2] tcp: propagate gso_segs to the new skb built in tcp collapse
Date:   Sun,  5 Aug 2018 18:25:07 +0800
Message-Id: <1533464707-11777-1-git-send-email-laoar.shao@gmail.com>
X-Mailer: git-send-email 1.8.3.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The gso_segs of the new built SKB in tcp collapse is inited to 0,
that makes us hard to know the accurate segments number of this new SKB.
We'd better propagate the gso_segs of the collapsed SKB to the new built
one, so when this SKB is dropped (for example when doing tcp prune) the
sk_drops will be added to the correct value.

If the collapsed SKB is fully copied to the new built one, we just add its
gso_segs to the new SKB.
While if the collapsed SKB is partially copied to the new built SKB,
we have to caculate how many segments are copied.
Furthemore, we have to reset the gso_segs of this SKB if is is partially
copied, so in the next round when the left segments are copied it could
propagate the correct value.

Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
---
 net/ipv4/tcp_input.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
index 715d541..72d4fc8 100644
--- a/net/ipv4/tcp_input.c
+++ b/net/ipv4/tcp_input.c
@@ -4915,12 +4915,23 @@ void tcp_rbtree_insert(struct rb_root *root, struct sk_buff *skb)
 
 		/* Copy data, releasing collapsed skbs. */
 		while (copy > 0) {
-			int offset = start - TCP_SKB_CB(skb)->seq;
 			int size = TCP_SKB_CB(skb)->end_seq - start;
+			int offset = start - TCP_SKB_CB(skb)->seq;
 
 			BUG_ON(offset < 0);
 			if (size > 0) {
 				size = min(copy, size);
+				if (copy >= size) {
+					skb_shinfo(nskb)->gso_segs +=
+						max_t(u16, 1, skb_shinfo(skb)->gso_segs);
+				} else {
+					skb_shinfo(nskb)->gso_segs +=
+						DIV_ROUND_UP(copy, skb_shinfo(skb)->gso_size);
+					skb_shinfo(skb)->gso_segs =
+						DIV_ROUND_UP(size - copy, skb_shinfo(skb)->gso_size);
+					size = copy;
+				}
+
 				if (skb_copy_bits(skb, offset, skb_put(nskb, size), size))
 					BUG();
 				TCP_SKB_CB(nskb)->end_seq += size;
-- 
1.8.3.1

