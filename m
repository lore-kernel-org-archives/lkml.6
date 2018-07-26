Return-Path: <SRS0=7Z+k=KK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07427C6778F
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 02:33:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 85A0120671
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 02:33:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b="aYc3l1nq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 85A0120671
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=arista.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729157AbeGZDqc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Jul 2018 23:46:32 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:45193 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729038AbeGZDqa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jul 2018 23:46:30 -0400
Received: by mail-ed1-f68.google.com with SMTP id s16-v6so324232edq.12
        for <linux-kernel@vger.kernel.org>; Wed, 25 Jul 2018 19:31:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=googlenew;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=wiZ8aVoT42kpmxdAcgdYsgiNgGLj0+jKQc9+v1tE0hs=;
        b=aYc3l1nq2B89lJ0VQgRmhz43+FXp3oLS+dumJCPLhaQX+E4QWnAkHFblEiOhq47oHB
         tq7gyw/RliBToKg/7YdTX8yu0qQZFFn/WMQMeSn6dlOrga4aFW8GjQ1dpXwaoLMb37o/
         RFJOiSFzCwXYp+rQY6unvt1kzqjEW2rn8KrQjNaiHyQjZ9uY9kKOFVb5U9H8jE8l5BpV
         xAzU84MWtHV71jco1wwv3SM+zBQBaE/8IlWRSY1LD/MDWUWatAkVraksBgt9g78vRGd6
         kF0JwAobCKKpz+7zctXrEKuz0+vJYcmuX8v6uaSnU77gNk34mT8cqefDsDH1tTSKGys3
         kmHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=wiZ8aVoT42kpmxdAcgdYsgiNgGLj0+jKQc9+v1tE0hs=;
        b=qw6r0abWC+wWENxv+dGOESrJxVeUAaKUGjS4k1PiSJaj4o+JhBEy+kuMNtcDjAPgHs
         riX80gB4klYCsYVrdlkDI6SF0nF0fy7PHefiZpgwP4DA0oqtzdj/w2mEudowb45NCkO6
         bSrUZXGAK+KSxEr92ByXVN5yQ2S0ju7vc/dhP1RQHYwDJ2DEgdl+fUze85FG9GNU9+7X
         R+oNiquHQrmaGIBLqu6FyjK+BESIv0b5mYrILAl0F5MjE3jRvw1oGbYGBztWs/Kj1E8L
         YA54i/xv5cQUM2HF27KwKs7SCAZe+CT7dzbIzA5nNk2Kz9y11uamRhBV2dh1y7e2I3lh
         RNTQ==
X-Gm-Message-State: AOUpUlHu3R90HroplnjckEjXsyO5MPuW6sr/sTj0JFpqI3S4lxM1ksRQ
        srMRM7wb6iFE2rVvf6i5vmu3CWzmo18=
X-Google-Smtp-Source: AAOMgpdC0OcbhN5cSW1WNQerxn+CdjQUh59rNs+gSv/7q722UiW23CCjlCm53g5Vh5D24aoWlQmlkA==
X-Received: by 2002:aa7:c6c2:: with SMTP id b2-v6mr463393eds.302.1532572314807;
        Wed, 25 Jul 2018 19:31:54 -0700 (PDT)
Received: from dhcp.ire.aristanetworks.com ([217.173.96.166])
        by smtp.gmail.com with ESMTPSA id x13-v6sm241024edx.17.2018.07.25.19.31.53
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 25 Jul 2018 19:31:54 -0700 (PDT)
From:   Dmitry Safonov <dima@arista.com>
To:     linux-kernel@vger.kernel.org
Cc:     Dmitry Safonov <dima@arista.com>,
        "David S. Miller" <davem@davemloft.net>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Steffen Klassert <steffen.klassert@secunet.com>,
        Dmitry Safonov <0x7f454c46@gmail.com>, netdev@vger.kernel.org,
        Eric Paris <eparis@redhat.com>,
        Florian Westphal <fw@strlen.de>,
        Jozsef Kadlecsik <kadlec@blackhole.kfki.hu>,
        Pablo Neira Ayuso <pablo@netfilter.org>,
        Paul Moore <paul@paul-moore.com>, coreteam@netfilter.org,
        linux-audit@redhat.com, netfilter-devel@vger.kernel.org
Subject: [PATCH 07/18] netlink: Pass groups pointer to .bind()
Date:   Thu, 26 Jul 2018 03:31:33 +0100
Message-Id: <20180726023144.31066-8-dima@arista.com>
X-Mailer: git-send-email 2.13.6
In-Reply-To: <20180726023144.31066-1-dima@arista.com>
References: <20180726023144.31066-1-dima@arista.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Netlink messages sent by xfrm differ in size between 64-bit native and
32-bit compatible applications. To know which UABI to use to send the
message from kernel, I'll use the type of bind() syscall.
Xfrm will have hidden from userspace kernel-only groups for compatible
applications.
So, add pointer to groups to netlink_bind().
With later patches xfrm will set a proper compat group for netlink
socket during bind().

Cc: "David S. Miller" <davem@davemloft.net>
Cc: Eric Paris <eparis@redhat.com>
Cc: Florian Westphal <fw@strlen.de>
Cc: Herbert Xu <herbert@gondor.apana.org.au>
Cc: Jozsef Kadlecsik <kadlec@blackhole.kfki.hu>
Cc: Pablo Neira Ayuso <pablo@netfilter.org>
Cc: Paul Moore <paul@paul-moore.com>
Cc: Steffen Klassert <steffen.klassert@secunet.com>
Cc: coreteam@netfilter.org
Cc: linux-audit@redhat.com
Cc: netdev@vger.kernel.org
Cc: netfilter-devel@vger.kernel.org
Signed-off-by: Dmitry Safonov <dima@arista.com>
---
 include/linux/netlink.h   |  2 +-
 kernel/audit.c            |  2 +-
 net/core/rtnetlink.c      | 14 ++++++--------
 net/core/sock_diag.c      | 25 ++++++++++++-------------
 net/netfilter/nfnetlink.c | 24 ++++++++++++++----------
 net/netlink/af_netlink.c  | 27 ++++++++++-----------------
 net/netlink/af_netlink.h  |  4 ++--
 net/netlink/genetlink.c   | 26 ++++++++++++++++++--------
 8 files changed, 64 insertions(+), 60 deletions(-)

diff --git a/include/linux/netlink.h b/include/linux/netlink.h
index f3075d6c7e82..19202648e04a 100644
--- a/include/linux/netlink.h
+++ b/include/linux/netlink.h
@@ -46,7 +46,7 @@ struct netlink_kernel_cfg {
 	unsigned int	flags;
 	void		(*input)(struct sk_buff *skb);
 	struct mutex	*cb_mutex;
-	int		(*bind)(struct net *net, int group);
+	int		(*bind)(struct net *net, unsigned long *groups);
 	void		(*unbind)(struct net *net, int group);
 	bool		(*compare)(struct net *net, struct sock *sk);
 };
diff --git a/kernel/audit.c b/kernel/audit.c
index e7478cb58079..87ca0214bcf2 100644
--- a/kernel/audit.c
+++ b/kernel/audit.c
@@ -1523,7 +1523,7 @@ static void audit_receive(struct sk_buff  *skb)
 }
 
 /* Run custom bind function on netlink socket group connect or bind requests. */
-static int audit_bind(struct net *net, int group)
+static int audit_bind(struct net *net, unsigned long *groups)
 {
 	if (!capable(CAP_AUDIT_READ))
 		return -EPERM;
diff --git a/net/core/rtnetlink.c b/net/core/rtnetlink.c
index e3f743c141b3..0465e692ae32 100644
--- a/net/core/rtnetlink.c
+++ b/net/core/rtnetlink.c
@@ -4683,15 +4683,13 @@ static void rtnetlink_rcv(struct sk_buff *skb)
 	netlink_rcv_skb(skb, &rtnetlink_rcv_msg);
 }
 
-static int rtnetlink_bind(struct net *net, int group)
+static int rtnetlink_bind(struct net *net, unsigned long *groups)
 {
-	switch (group) {
-	case RTNLGRP_IPV4_MROUTE_R:
-	case RTNLGRP_IPV6_MROUTE_R:
-		if (!ns_capable(net->user_ns, CAP_NET_ADMIN))
-			return -EPERM;
-		break;
-	}
+	unsigned long mroute_r;
+
+	mroute_r = 1UL << RTNLGRP_IPV4_MROUTE_R | 1UL << RTNLGRP_IPV6_MROUTE_R;
+	if ((*groups & mroute_r) && !ns_capable(net->user_ns, CAP_NET_ADMIN))
+		return -EPERM;
 	return 0;
 }
 
diff --git a/net/core/sock_diag.c b/net/core/sock_diag.c
index c37b5be7c5e4..befa6759f2ad 100644
--- a/net/core/sock_diag.c
+++ b/net/core/sock_diag.c
@@ -273,20 +273,19 @@ static void sock_diag_rcv(struct sk_buff *skb)
 	mutex_unlock(&sock_diag_mutex);
 }
 
-static int sock_diag_bind(struct net *net, int group)
+static int sock_diag_bind(struct net *net, unsigned long *groups)
 {
-	switch (group) {
-	case SKNLGRP_INET_TCP_DESTROY:
-	case SKNLGRP_INET_UDP_DESTROY:
-		if (!sock_diag_handlers[AF_INET])
-			sock_load_diag_module(AF_INET, 0);
-		break;
-	case SKNLGRP_INET6_TCP_DESTROY:
-	case SKNLGRP_INET6_UDP_DESTROY:
-		if (!sock_diag_handlers[AF_INET6])
-			sock_load_diag_module(AF_INET6, 0);
-		break;
-	}
+	unsigned long inet_mask, inet6_mask;
+
+	inet_mask   = 1UL << SKNLGRP_INET_TCP_DESTROY;
+	inet_mask  |= 1UL << SKNLGRP_INET_UDP_DESTROY;
+	inet6_mask  = 1UL << SKNLGRP_INET6_TCP_DESTROY;
+	inet6_mask |= 1UL << SKNLGRP_INET6_UDP_DESTROY;
+
+	if ((*groups & inet_mask) && !sock_diag_handlers[AF_INET])
+		sock_load_diag_module(AF_INET, 0);
+	if ((*groups & inet6_mask) && !sock_diag_handlers[AF_INET6])
+		sock_load_diag_module(AF_INET6, 0);
 	return 0;
 }
 
diff --git a/net/netfilter/nfnetlink.c b/net/netfilter/nfnetlink.c
index e1b6be29848d..6a8893df5285 100644
--- a/net/netfilter/nfnetlink.c
+++ b/net/netfilter/nfnetlink.c
@@ -556,21 +556,25 @@ static void nfnetlink_rcv(struct sk_buff *skb)
 }
 
 #ifdef CONFIG_MODULES
-static int nfnetlink_bind(struct net *net, int group)
+static int nfnetlink_bind(struct net *net, unsigned long *groups)
 {
 	const struct nfnetlink_subsystem *ss;
-	int type;
+	unsigned long _groups = *groups;
+	int type, group_bit, group = -1;
 
-	if (group <= NFNLGRP_NONE || group > NFNLGRP_MAX)
-		return 0;
+	while ((group_bit = __builtin_ffsl(_groups))) {
+		group += group_bit;
 
-	type = nfnl_group2type[group];
+		type = nfnl_group2type[group];
+		rcu_read_lock();
+		ss = nfnetlink_get_subsys(type << 8);
+		rcu_read_unlock();
+		if (!ss)
+			request_module("nfnetlink-subsys-%d", type);
+
+		_groups >>= group_bit;
+	}
 
-	rcu_read_lock();
-	ss = nfnetlink_get_subsys(type << 8);
-	rcu_read_unlock();
-	if (!ss)
-		request_module("nfnetlink-subsys-%d", type);
 	return 0;
 }
 #endif
diff --git a/net/netlink/af_netlink.c b/net/netlink/af_netlink.c
index ac805caed2e2..1e11e706c683 100644
--- a/net/netlink/af_netlink.c
+++ b/net/netlink/af_netlink.c
@@ -668,7 +668,7 @@ static int netlink_create(struct net *net, struct socket *sock, int protocol,
 	struct module *module = NULL;
 	struct mutex *cb_mutex;
 	struct netlink_sock *nlk;
-	int (*bind)(struct net *net, int group);
+	int (*bind)(struct net *net, unsigned long *groups);
 	void (*unbind)(struct net *net, int group);
 	int err = 0;
 
@@ -969,8 +969,7 @@ static int netlink_realloc_groups(struct sock *sk)
 	return err;
 }
 
-static void netlink_undo_bind(int group, long unsigned int groups,
-			      struct sock *sk)
+static void netlink_undo_bind(unsigned long groups, struct sock *sk)
 {
 	struct netlink_sock *nlk = nlk_sk(sk);
 	int undo;
@@ -978,7 +977,7 @@ static void netlink_undo_bind(int group, long unsigned int groups,
 	if (!nlk->netlink_unbind)
 		return;
 
-	for (undo = 0; undo < group; undo++)
+	for (undo = 0; undo < nlk->ngroups; undo++)
 		if (test_bit(undo, &groups))
 			nlk->netlink_unbind(sock_net(sk), undo + 1);
 }
@@ -991,7 +990,7 @@ static int netlink_bind(struct socket *sock, struct sockaddr *addr,
 	struct netlink_sock *nlk = nlk_sk(sk);
 	struct sockaddr_nl *nladdr = (struct sockaddr_nl *)addr;
 	int err = 0;
-	long unsigned int groups = nladdr->nl_groups;
+	unsigned long groups = nladdr->nl_groups;
 	bool bound;
 
 	if (addr_len < sizeof(struct sockaddr_nl))
@@ -1021,17 +1020,9 @@ static int netlink_bind(struct socket *sock, struct sockaddr *addr,
 
 	netlink_lock_table();
 	if (nlk->netlink_bind && groups) {
-		int group;
-
-		for (group = 0; group < nlk->ngroups; group++) {
-			if (!test_bit(group, &groups))
-				continue;
-			err = nlk->netlink_bind(net, group + 1);
-			if (!err)
-				continue;
-			netlink_undo_bind(group, groups, sk);
+		err = nlk->netlink_bind(net, &groups);
+		if (err)
 			goto unlock;
-		}
 	}
 
 	/* No need for barriers here as we return to user-space without
@@ -1042,7 +1033,7 @@ static int netlink_bind(struct socket *sock, struct sockaddr *addr,
 			netlink_insert(sk, nladdr->nl_pid) :
 			netlink_autobind(sock);
 		if (err) {
-			netlink_undo_bind(nlk->ngroups, groups, sk);
+			netlink_undo_bind(groups, sk);
 			goto unlock;
 		}
 	}
@@ -1652,7 +1643,9 @@ static int netlink_setsockopt(struct socket *sock, int level, int optname,
 		if (!val || val - 1 >= nlk->ngroups)
 			return -EINVAL;
 		if (optname == NETLINK_ADD_MEMBERSHIP && nlk->netlink_bind) {
-			err = nlk->netlink_bind(sock_net(sk), val);
+			unsigned long groups = 1UL << val;
+
+			err = nlk->netlink_bind(sock_net(sk), &groups);
 			if (err)
 				return err;
 		}
diff --git a/net/netlink/af_netlink.h b/net/netlink/af_netlink.h
index 962de7b3c023..e765172abbb7 100644
--- a/net/netlink/af_netlink.h
+++ b/net/netlink/af_netlink.h
@@ -39,7 +39,7 @@ struct netlink_sock {
 	struct mutex		*cb_mutex;
 	struct mutex		cb_def_mutex;
 	void			(*netlink_rcv)(struct sk_buff *skb);
-	int			(*netlink_bind)(struct net *net, int group);
+	int			(*netlink_bind)(struct net *net, unsigned long *groups);
 	void			(*netlink_unbind)(struct net *net, int group);
 	struct module		*module;
 
@@ -61,7 +61,7 @@ struct netlink_table {
 	unsigned int		groups;
 	struct mutex		*cb_mutex;
 	struct module		*module;
-	int			(*bind)(struct net *net, int group);
+	int			(*bind)(struct net *net, unsigned long *groups);
 	void			(*unbind)(struct net *net, int group);
 	bool			(*compare)(struct net *net, struct sock *sock);
 	int			registered;
diff --git a/net/netlink/genetlink.c b/net/netlink/genetlink.c
index 25eeb6d2a75a..a86b105730cf 100644
--- a/net/netlink/genetlink.c
+++ b/net/netlink/genetlink.c
@@ -960,28 +960,38 @@ static struct genl_family genl_ctrl __ro_after_init = {
 	.netnsok = true,
 };
 
-static int genl_bind(struct net *net, int group)
+static int genl_bind(struct net *net, unsigned long *groups)
 {
+	unsigned long mcgrps;
 	struct genl_family *f;
-	int err = -ENOENT;
+	int err = 0;
 	unsigned int id;
 
 	down_read(&cb_lock);
 
 	idr_for_each_entry(&genl_fam_idr, f, id) {
-		if (group >= f->mcgrp_offset &&
-		    group < f->mcgrp_offset + f->n_mcgrps) {
-			int fam_grp = group - f->mcgrp_offset;
+		int fam_grp_bit, fam_grp = -1;
+
+		mcgrps = (1UL << f->n_mcgrps) - 1;
+		mcgrps <<= f->mcgrp_offset;
+		mcgrps &= *groups;
+
+		if (!mcgrps)
+			continue;
+
+		while ((fam_grp_bit = __builtin_ffsl(mcgrps))) {
+			fam_grp += fam_grp_bit;
 
 			if (!f->netnsok && net != &init_net)
 				err = -ENOENT;
 			else if (f->mcast_bind)
 				err = f->mcast_bind(net, fam_grp);
-			else
-				err = 0;
-			break;
+
+			if (err)
+				goto out;
 		}
 	}
+out:
 	up_read(&cb_lock);
 
 	return err;
-- 
2.13.6

