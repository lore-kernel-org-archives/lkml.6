Return-Path: <SRS0=OrLK=KG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0964DC6778A
	for <linux-kernel@archiver.kernel.org>; Sun, 22 Jul 2018 14:36:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 91DDE20875
	for <linux-kernel@archiver.kernel.org>; Sun, 22 Jul 2018 14:36:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QCtAT1Av"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 91DDE20875
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728700AbeGVPdH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 22 Jul 2018 11:33:07 -0400
Received: from mail-pl0-f65.google.com ([209.85.160.65]:43611 "EHLO
        mail-pl0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728351AbeGVPdH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Jul 2018 11:33:07 -0400
Received: by mail-pl0-f65.google.com with SMTP id o7-v6so7126036plk.10;
        Sun, 22 Jul 2018 07:36:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=lUjcKDvIghU4EsT8976QuPug7VfkXlu7FLiWinM825Y=;
        b=QCtAT1AvqDo3PcZBYVj4d2DTcGG1BrFbh9jpj7zSMQhTd9BfpY6kuhm0+rinbOhYqs
         PyZJtzCR/BCE4ikpXzje8IeW17mHPnkaJEYAMFou3sp7h5Xs/XGFBRGt3BSerffz4Ghx
         EVLHzpG9mAdwg8EToJuWsP2makFVwyhmR1Y2WiE1TBI+coYQcbFvw4MQ52Kk4IqyHkAl
         6klK8DU25XUDb1+QEMtNLE+vJcvnDkk7aQwgzQE1NIcCngPsoZEtg8FEKkbcTTDBqa1y
         UXDsNSsoooqveoqUk3HrzwCQLAigWaMHzv630uOVaaNy4/0oLCTIMH3zUzHAdP27eUuU
         aNSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=lUjcKDvIghU4EsT8976QuPug7VfkXlu7FLiWinM825Y=;
        b=IYYAllUX4ws4i1yT79EGwXutv9PZJ/77CmBQxQTeacto9yZQqFq6aAZV5tulOk8u+K
         /h0YYb+0SqM8bK3KZqWt88s9uBA+qyJIWE9viElrTSVo4rASRsbCNcDIXDwiyh+OOvZG
         ouLrquxjJtWW/3URZ8/aPxFxqbrDomLdyv1Orf1i+kV84hKlaDQzlPaoZdCyxuoUlw2O
         FJXczVn5uYxap30Kj+uKaSV1D+FNpQ/ja5GB+aN+ADwbBwTRCOizN7nZEItne/nwjMQb
         9ZdOZVt9vj0WtzAfJ2tUJZ/wZoNYy1Yt4O6nHBSW0v+AjD2eV+UzZ0MsEVSLGvtFASfy
         qWaA==
X-Gm-Message-State: AOUpUlHvXI+An4ZM/AeUMZxnpdU5xjfyuhdUswnepdpzqY+uZsgEksYF
        CfDjZEjEbyzzHaUJLfHQJ0o=
X-Google-Smtp-Source: AAOMgpdcu5o83yFhcQAvD0DKw7p9PoMBcHEKJxbdOeZmZ/omE9hk7PotwIKiQIhvRpMF/I9QR6EdSw==
X-Received: by 2002:a17:902:9b82:: with SMTP id y2-v6mr9378782plp.69.1532270173454;
        Sun, 22 Jul 2018 07:36:13 -0700 (PDT)
Received: from localhost.localdomain ([180.172.91.97])
        by smtp.gmail.com with ESMTPSA id o84-v6sm10717218pfi.165.2018.07.22.07.35.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 22 Jul 2018 07:36:12 -0700 (PDT)
From:   Shaochun Chen <cscnull@gmail.com>
To:     pablo@netfilter.org
Cc:     kadlec@blackhole.kfki.hu, fw@strlen.de, davem@davemloft.net,
        johannes.berg@intel.com, Jason@zx2c4.com, ktkhai@virtuozzo.com,
        lucien.xin@gmail.com, xiyou.wangcong@gmail.com, dsahern@gmail.com,
        netfilter-devel@vger.kernel.org, coreteam@netfilter.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Shaochun Chen <cscnull@gmail.com>
Subject: [PATCH] netlink: fix memory leak of dump
Date:   Sun, 22 Jul 2018 22:33:54 +0800
Message-Id: <20180722143354.23722-1-cscnull@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

1) if netlink_dump_start start fail, the memory of c->data will leak.
so free manually after netlink_dump_start return error.

2) In netlink_dump_start, ignore the return of netlink_dump.
Because if cb_running is set to true, cb->dump will be call in anyway.
so if netlink_dump_start start successfully, just return -EINTR.

Signed-off-by: Shaochun Chen <cscnull@gmail.com>
---
 net/netfilter/nf_conntrack_netlink.c |  8 ++++--
 net/netfilter/nf_tables_api.c        | 41 ++++++++++++++++++++--------
 net/netfilter/nfnetlink_acct.c       |  8 ++++--
 net/netlink/af_netlink.c             |  5 +---
 4 files changed, 41 insertions(+), 21 deletions(-)

diff --git a/net/netfilter/nf_conntrack_netlink.c b/net/netfilter/nf_conntrack_netlink.c
index 20a2e37c76d1..31db758bdb7a 100644
--- a/net/netfilter/nf_conntrack_netlink.c
+++ b/net/netfilter/nf_conntrack_netlink.c
@@ -1243,17 +1243,19 @@ static int ctnetlink_get_conntrack(struct net *net, struct sock *ctnl,
 			.dump = ctnetlink_dump_table,
 			.done = ctnetlink_done,
 		};
+		struct ctnetlink_filter *filter = NULL;
 
 		if (cda[CTA_MARK] && cda[CTA_MARK_MASK]) {
-			struct ctnetlink_filter *filter;
-
 			filter = ctnetlink_alloc_filter(cda);
 			if (IS_ERR(filter))
 				return PTR_ERR(filter);
 
 			c.data = filter;
 		}
-		return netlink_dump_start(ctnl, skb, nlh, &c);
+		err = netlink_dump_start(ctnl, skb, nlh, &c);
+		if (err != -EINTR && filter)
+			kfree(filter);
+		return err;
 	}
 
 	err = ctnetlink_parse_zone(cda[CTA_ZONE], &zone);
diff --git a/net/netfilter/nf_tables_api.c b/net/netfilter/nf_tables_api.c
index 896d4a36081d..4635a841f5f2 100644
--- a/net/netfilter/nf_tables_api.c
+++ b/net/netfilter/nf_tables_api.c
@@ -2287,10 +2287,9 @@ static int nf_tables_getrule(struct net *net, struct sock *nlsk,
 			.done = nf_tables_dump_rules_done,
 			.module = THIS_MODULE,
 		};
+		struct nft_rule_dump_ctx *ctx = NULL;
 
 		if (nla[NFTA_RULE_TABLE] || nla[NFTA_RULE_CHAIN]) {
-			struct nft_rule_dump_ctx *ctx;
-
 			ctx = kzalloc(sizeof(*ctx), GFP_ATOMIC);
 			if (!ctx)
 				return -ENOMEM;
@@ -2315,7 +2314,13 @@ static int nf_tables_getrule(struct net *net, struct sock *nlsk,
 			c.data = ctx;
 		}
 
-		return nft_netlink_dump_start_rcu(nlsk, skb, nlh, &c);
+		err = nft_netlink_dump_start_rcu(nlsk, skb, nlh, &c);
+		if (err != -EINTR && ctx) {
+			kfree(ctx->table);
+			kfree(ctx->chain);
+			kfree(ctx);
+		}
+		return err;
 	}
 
 	table = nft_table_lookup(net, nla[NFTA_RULE_TABLE], family, genmask);
@@ -3201,7 +3206,10 @@ static int nf_tables_getset(struct net *net, struct sock *nlsk,
 		*ctx_dump = ctx;
 		c.data = ctx_dump;
 
-		return nft_netlink_dump_start_rcu(nlsk, skb, nlh, &c);
+		err = nft_netlink_dump_start_rcu(nlsk, skb, nlh, &c);
+		if (err != -EINTR)
+			kfree(ctx_dump);
+		return err;
 	}
 
 	/* Only accept unspec with dump */
@@ -4016,7 +4024,10 @@ static int nf_tables_getsetelem(struct net *net, struct sock *nlsk,
 		dump_ctx->ctx = ctx;
 
 		c.data = dump_ctx;
-		return nft_netlink_dump_start_rcu(nlsk, skb, nlh, &c);
+		err = nft_netlink_dump_start_rcu(nlsk, skb, nlh, &c);
+		if (err != -EINTR)
+			kfree(dump_ctx);
+		return err;
 	}
 
 	if (!nla[NFTA_SET_ELEM_LIST_ELEMENTS])
@@ -5031,18 +5042,22 @@ static int nf_tables_getobj(struct net *net, struct sock *nlsk,
 			.done = nf_tables_dump_obj_done,
 			.module = THIS_MODULE,
 		};
+		struct nft_obj_filter *filter = NULL;
 
 		if (nla[NFTA_OBJ_TABLE] ||
 		    nla[NFTA_OBJ_TYPE]) {
-			struct nft_obj_filter *filter;
-
 			filter = nft_obj_filter_alloc(nla);
 			if (IS_ERR(filter))
 				return -ENOMEM;
 
 			c.data = filter;
 		}
-		return nft_netlink_dump_start_rcu(nlsk, skb, nlh, &c);
+		err = nft_netlink_dump_start_rcu(nlsk, skb, nlh, &c);
+		if (err != -EINTR && filter) {
+			kfree(filter->table);
+			kfree(filter);
+		}
+		return err;
 	}
 
 	if (!nla[NFTA_OBJ_NAME] ||
@@ -5704,17 +5719,21 @@ static int nf_tables_getflowtable(struct net *net, struct sock *nlsk,
 			.done = nf_tables_dump_flowtable_done,
 			.module = THIS_MODULE,
 		};
+		struct nft_flowtable_filter *filter = NULL;
 
 		if (nla[NFTA_FLOWTABLE_TABLE]) {
-			struct nft_flowtable_filter *filter;
-
 			filter = nft_flowtable_filter_alloc(nla);
 			if (IS_ERR(filter))
 				return -ENOMEM;
 
 			c.data = filter;
 		}
-		return nft_netlink_dump_start_rcu(nlsk, skb, nlh, &c);
+		err = nft_netlink_dump_start_rcu(nlsk, skb, nlh, &c);
+		if (err != -EINTR && filter) {
+			kfree(filter->table);
+			kfree(filter);
+		}
+		return err;
 	}
 
 	if (!nla[NFTA_FLOWTABLE_NAME])
diff --git a/net/netfilter/nfnetlink_acct.c b/net/netfilter/nfnetlink_acct.c
index a0e5adf0b3b6..aecdb9cc1c5d 100644
--- a/net/netfilter/nfnetlink_acct.c
+++ b/net/netfilter/nfnetlink_acct.c
@@ -277,17 +277,19 @@ static int nfnl_acct_get(struct net *net, struct sock *nfnl,
 			.dump = nfnl_acct_dump,
 			.done = nfnl_acct_done,
 		};
+		struct nfacct_filter *filter = NULL;
 
 		if (tb[NFACCT_FILTER]) {
-			struct nfacct_filter *filter;
-
 			filter = nfacct_filter_alloc(tb[NFACCT_FILTER]);
 			if (IS_ERR(filter))
 				return PTR_ERR(filter);
 
 			c.data = filter;
 		}
-		return netlink_dump_start(nfnl, skb, nlh, &c);
+		ret = netlink_dump_start(nfnl, skb, nlh, &c);
+		if (ret != -EINTR && filter)
+			kfree(filter);
+		return ret;
 	}
 
 	if (!tb[NFACCT_NAME])
diff --git a/net/netlink/af_netlink.c b/net/netlink/af_netlink.c
index 393573a99a5a..61450461378c 100644
--- a/net/netlink/af_netlink.c
+++ b/net/netlink/af_netlink.c
@@ -2320,13 +2320,10 @@ int __netlink_dump_start(struct sock *ssk, struct sk_buff *skb,
 
 	mutex_unlock(nlk->cb_mutex);
 
-	ret = netlink_dump(sk);
+	netlink_dump(sk);
 
 	sock_put(sk);
 
-	if (ret)
-		return ret;
-
 	/* We successfully started a dump, by returning -EINTR we
 	 * signal not to send ACK even if it was requested.
 	 */
-- 
2.17.1

