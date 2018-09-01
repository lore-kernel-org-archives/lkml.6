Return-Path: <SRS0=kg8+=LP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E57CC433F4
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Sep 2018 12:21:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 54CA120843
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Sep 2018 12:21:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VQ+BjKUJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 54CA120843
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727438AbeIAQdW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 1 Sep 2018 12:33:22 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:39788 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726825AbeIAQdV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Sep 2018 12:33:21 -0400
Received: by mail-pf1-f194.google.com with SMTP id j8-v6so6700200pff.6;
        Sat, 01 Sep 2018 05:21:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=FQHroXCDBgcHJgR7j2rRNMp0a4BQ/bD8Uhm3czI6kFg=;
        b=VQ+BjKUJ+O6RJXjh4r576AeOjT41YMRDVcxZxOpGMCBIizaAnohGp7iXDZguAn/WpY
         Gseubthy8v7GRJBpOg2OWSHF0vNFnhH8CpyafX2yjZ/pgpZrHV+lS8paxxH9myUhEdRT
         CihqwvmZrim0aDtNfcJLZhy54clMaKr6EBlSMgJfaD2dGp52kf60kMeKJokgO+qZi+JM
         +uT1Vw0WBRHHQyPR/xthBGo7GskTnj+QVtgX546cDIStSFW3n0s7VKf4nQg7IHiN6kJ9
         fpTzUClmGhky+nRleovPnEGV+samaBcM1RpOePAjHwO/VwSZGyvpEQAO3ijPXMm2COEz
         hwEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=FQHroXCDBgcHJgR7j2rRNMp0a4BQ/bD8Uhm3czI6kFg=;
        b=JOmEu+FGnGNJfWTBWQHQj+SZKlFyjV3yLh3wRzYeZtunTtIVh6vJ3rjhvqndB1nfNi
         YS4raNpwi+RDSxuH0sTT85NmRAH7Fo0yAJ7srukiDP0kbGy8znMVpwTdtXCtKBE97CPJ
         t7KRycMUcVNCjjMqxW2JWSi84qSLeEKMD7ZQOd14rzbRFt8cXTMbc6lwfh6JWwLYbV9Z
         7jDFcrZLJghKB6MS+KpgApxkXEjr0cp5N671J0e6igOYBNcgdbNvllq+N3kUtPMZIbrz
         7k3tVjCYQgBu4HohXSeEBciC2mgYTxaGIeNJJ6/YuNAzEC4Fc4OL1ZsWvx0FKK/d5Tzq
         8o3w==
X-Gm-Message-State: APzg51AbZ0lTSAO+0dyWQXwCI6kMdkDQu923wgcPnRxhOFRtiRYfTE3r
        LiWVm0HZE6bWWC1qqRNElAE=
X-Google-Smtp-Source: ANB0VdaBEWb8nxiJx+MHmcEGvqJkfIqjkg/FxbZEA69wshX56ZhDGYyfmPUKqwXjdkVW1NiEHnn9Xg==
X-Received: by 2002:a62:1192:: with SMTP id 18-v6mr20736895pfr.54.1535804489662;
        Sat, 01 Sep 2018 05:21:29 -0700 (PDT)
Received: from bogon.didichuxing.com ([203.100.54.194])
        by smtp.gmail.com with ESMTPSA id z19-v6sm22454043pgi.33.2018.09.01.05.21.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 01 Sep 2018 05:21:28 -0700 (PDT)
From:   Yafang Shao <laoar.shao@gmail.com>
To:     edumazet@google.com, davem@davemloft.net
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Yafang Shao <laoar.shao@gmail.com>
Subject: [PATCH net-next v3] tcp: propagate gso_segs to the new skb built in tcp collapse
Date:   Sat,  1 Sep 2018 20:21:04 +0800
Message-Id: <1535804465-11795-1-git-send-email-laoar.shao@gmail.com>
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
we have to calculate how many segments are copied.
And when do the calculation we must make sure one SKB holds the same
gso_segs.
Furthemore, we have to reset the gso_segs of this SKB if is is partially
copied, so in the next round when the left segments are copied it could
propagate the correct value.

The gso_size will never exceed 65536 as the max size of the new built SKB
is 4K.

Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
---
 net/ipv4/tcp_input.c | 17 +++++++++++++++--
 1 file changed, 15 insertions(+), 2 deletions(-)

diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
index 62508a2..6dc8e2f 100644
--- a/net/ipv4/tcp_input.c
+++ b/net/ipv4/tcp_input.c
@@ -4910,6 +4910,7 @@ void tcp_rbtree_insert(struct rb_root *root, struct sk_buff *skb)
 	while (before(start, end)) {
 		int copy = min_t(int, SKB_MAX_ORDER(0, 0), end - start);
 		struct sk_buff *nskb;
+		int len = copy;
 
 		nskb = alloc_skb(copy, GFP_ATOMIC);
 		if (!nskb)
@@ -4928,12 +4929,24 @@ void tcp_rbtree_insert(struct rb_root *root, struct sk_buff *skb)
 
 		/* Copy data, releasing collapsed skbs. */
 		while (copy > 0) {
-			int offset = start - TCP_SKB_CB(skb)->seq;
 			int size = TCP_SKB_CB(skb)->end_seq - start;
+			int offset = start - TCP_SKB_CB(skb)->seq;
 
 			BUG_ON(offset < 0);
 			if (size > 0) {
-				size = min(copy, size);
+				if (copy >= size) {
+					skb_shinfo(nskb)->gso_segs +=
+						max_t(u16, 1, skb_shinfo(skb)->gso_segs);
+				} else {
+					skb_shinfo(nskb)->gso_size =
+						skb_shinfo(skb)->gso_size;
+					skb_shinfo(nskb)->gso_segs =
+						DIV_ROUND_UP(len, skb_shinfo(nskb)->gso_size);
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

