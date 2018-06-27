Return-Path: <SRS0=G4S6=JN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 498F3C43144
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 20:42:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E7A7E255FE
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 20:41:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="UDpKNBxJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E7A7E255FE
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755021AbeF0Ul6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Jun 2018 16:41:58 -0400
Received: from mail-pl0-f65.google.com ([209.85.160.65]:38823 "EHLO
        mail-pl0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754820AbeF0Ul4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jun 2018 16:41:56 -0400
Received: by mail-pl0-f65.google.com with SMTP id d10-v6so1592953plo.5
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jun 2018 13:41:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=OkwLo9YxvKe085egdShSLIguaqYgQrkn5A3f36HdP0M=;
        b=UDpKNBxJo8Bby3yBuGfbXT6sqJKi4/x3Hh7X2P+oG7lfB0Y86PbyNqAHKHW2pPzdk/
         jUZlUU8ElB2LAgGKfo8FhWbTHGA7ifUFTMrGgkfkEElXQ2gyW4vHa5vFhAtmHQkbGHmh
         1ZotiNqNjIodhAEw5DFgeilzFPE+SA3T3nvbyQ2PcYq/E6PEUzxwMgrWDAmkMfM0GlRV
         2Dqr54Cj9Y799aISWf+hESuIN+hNx11MhTHmjLKovqdllMB0mooYjEJjPu00oaxMYUIV
         kNDKhU250XQCFpOw/iWJR0LNoTS5nkXI3FxRyH0mVeHG/tVe0yir3lxh7bdimbe1me4R
         TDlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=OkwLo9YxvKe085egdShSLIguaqYgQrkn5A3f36HdP0M=;
        b=QvfJa2H0rJjBxOenAa768kvUwjC5KDTZ3dvh70vB7MPBEyFOX3P2EbrO3180fZLSiT
         SV2pT+6kbxjK0bACtB5aFkp8qqPjkxy9K6q0WxgMuerFkeFW2mujxA/gtAA6TYD//7Gr
         L9/Zpq6qnVj/o1Kk2B/8S2a/CAr4K2afOHtSHcyT83kyXXq0QtNeuA17kCSQrtuBjf+j
         jFg/ep1r0//bC4ZAri5Y4y5xTmBIHIOlJD4PkDiQuQWdvhcUmi2LhQRDJlNG91VGG2on
         cJJFUHanK53CC51IU1Hz+tJb0/6PxS2Qs1BarV1ixoN5y3kFSsHRJhYu8WRqaUa2oYxd
         oVIQ==
X-Gm-Message-State: APt69E3R97i95Vy/JAgoxjFWID8O02+uoCOhHtxb3SzCHjh2dZ2GXt/D
        lYwMd1M3qX4STdLV83Oow8+vsA==
X-Google-Smtp-Source: ADUXVKJlpROODQro2NOMMYbIQj8mLOSSajVomC0k+pZ8i/pKjXWkOtHmcLhJFSktvBFgoAqmfWruNA==
X-Received: by 2002:a17:902:9b98:: with SMTP id y24-v6mr7615092plp.177.1530132115486;
        Wed, 27 Jun 2018 13:41:55 -0700 (PDT)
Received: from shakeelb.mtv.corp.google.com ([2620:15c:2cb:201:3a5f:3a4f:fa44:6b63])
        by smtp.gmail.com with ESMTPSA id t5-v6sm7977593pfh.32.2018.06.27.13.41.53
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 27 Jun 2018 13:41:53 -0700 (PDT)
From:   Shakeel Butt <shakeelb@google.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Greg Thelen <gthelen@google.com>, Roman Gushchin <guro@fb.com>,
        "David S . Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Kirill Tkhai <ktkhai@virtuozzo.com>,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        linux-mm@kvack.org, Shakeel Butt <shakeelb@google.com>
Subject: [RFC PATCH] net, mm: account sock objects to kmemcg
Date:   Wed, 27 Jun 2018 13:41:39 -0700
Message-Id: <20180627204139.225988-1-shakeelb@google.com>
X-Mailer: git-send-email 2.18.0.rc2.346.g013aa6912e-goog
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently the kernel accounts the memory for network traffic through
mem_cgroup_[un]charge_skmem() interface. However the memory accounted
only includes the truesize of sk_buff which does not include the size of
sock objects. In our production environment, with opt-out kmem
accounting, the sock kmem caches (TCP[v6], UDP[v6], RAW[v6], UNIX) are
among the top most charged kmem caches and consume a significant amount
of memory which can not be left as system overhead. So, this patch
converts the kmem caches of more important sock objects to SLAB_ACCOUNT.

Signed-off-by: Shakeel Butt <shakeelb@google.com>
---
 net/ipv4/raw.c      | 1 +
 net/ipv4/tcp_ipv4.c | 2 +-
 net/ipv4/udp.c      | 1 +
 net/ipv6/raw.c      | 1 +
 net/ipv6/tcp_ipv6.c | 2 +-
 net/ipv6/udp.c      | 1 +
 net/unix/af_unix.c  | 1 +
 7 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/net/ipv4/raw.c b/net/ipv4/raw.c
index abb3c9490c55..2c4b04c6461a 100644
--- a/net/ipv4/raw.c
+++ b/net/ipv4/raw.c
@@ -988,6 +988,7 @@ struct proto raw_prot = {
 	.hash		   = raw_hash_sk,
 	.unhash		   = raw_unhash_sk,
 	.obj_size	   = sizeof(struct raw_sock),
+	.slab_flags	   = SLAB_ACCOUNT,
 	.useroffset	   = offsetof(struct raw_sock, filter),
 	.usersize	   = sizeof_field(struct raw_sock, filter),
 	.h.raw_hash	   = &raw_v4_hashinfo,
diff --git a/net/ipv4/tcp_ipv4.c b/net/ipv4/tcp_ipv4.c
index fed3f1c66167..9ae31979aefa 100644
--- a/net/ipv4/tcp_ipv4.c
+++ b/net/ipv4/tcp_ipv4.c
@@ -2459,7 +2459,7 @@ struct proto tcp_prot = {
 	.sysctl_rmem_offset	= offsetof(struct net, ipv4.sysctl_tcp_rmem),
 	.max_header		= MAX_TCP_HEADER,
 	.obj_size		= sizeof(struct tcp_sock),
-	.slab_flags		= SLAB_TYPESAFE_BY_RCU,
+	.slab_flags		= SLAB_TYPESAFE_BY_RCU | SLAB_ACCOUNT,
 	.twsk_prot		= &tcp_timewait_sock_ops,
 	.rsk_prot		= &tcp_request_sock_ops,
 	.h.hashinfo		= &tcp_hashinfo,
diff --git a/net/ipv4/udp.c b/net/ipv4/udp.c
index 9bb27df4dac5..26e07b8a83cc 100644
--- a/net/ipv4/udp.c
+++ b/net/ipv4/udp.c
@@ -2657,6 +2657,7 @@ struct proto udp_prot = {
 	.sysctl_wmem_offset	= offsetof(struct net, ipv4.sysctl_udp_wmem_min),
 	.sysctl_rmem_offset	= offsetof(struct net, ipv4.sysctl_udp_rmem_min),
 	.obj_size		= sizeof(struct udp_sock),
+	.slab_flags		= SLAB_ACCOUNT,
 	.h.udp_table		= &udp_table,
 #ifdef CONFIG_COMPAT
 	.compat_setsockopt	= compat_udp_setsockopt,
diff --git a/net/ipv6/raw.c b/net/ipv6/raw.c
index ce6f0d15b5dd..044ed44e7c16 100644
--- a/net/ipv6/raw.c
+++ b/net/ipv6/raw.c
@@ -1272,6 +1272,7 @@ struct proto rawv6_prot = {
 	.hash		   = raw_hash_sk,
 	.unhash		   = raw_unhash_sk,
 	.obj_size	   = sizeof(struct raw6_sock),
+	.slab_flags	   = SLAB_ACCOUNT,
 	.useroffset	   = offsetof(struct raw6_sock, filter),
 	.usersize	   = sizeof_field(struct raw6_sock, filter),
 	.h.raw_hash	   = &raw_v6_hashinfo,
diff --git a/net/ipv6/tcp_ipv6.c b/net/ipv6/tcp_ipv6.c
index b620d9b72e59..7187609ca25f 100644
--- a/net/ipv6/tcp_ipv6.c
+++ b/net/ipv6/tcp_ipv6.c
@@ -1973,7 +1973,7 @@ struct proto tcpv6_prot = {
 	.sysctl_rmem_offset	= offsetof(struct net, ipv4.sysctl_tcp_rmem),
 	.max_header		= MAX_TCP_HEADER,
 	.obj_size		= sizeof(struct tcp6_sock),
-	.slab_flags		= SLAB_TYPESAFE_BY_RCU,
+	.slab_flags		= SLAB_TYPESAFE_BY_RCU | SLAB_ACCOUNT,
 	.twsk_prot		= &tcp6_timewait_sock_ops,
 	.rsk_prot		= &tcp6_request_sock_ops,
 	.h.hashinfo		= &tcp_hashinfo,
diff --git a/net/ipv6/udp.c b/net/ipv6/udp.c
index e6645cae403e..47c9a3c74981 100644
--- a/net/ipv6/udp.c
+++ b/net/ipv6/udp.c
@@ -1582,6 +1582,7 @@ struct proto udpv6_prot = {
 	.sysctl_wmem_offset     = offsetof(struct net, ipv4.sysctl_udp_wmem_min),
 	.sysctl_rmem_offset     = offsetof(struct net, ipv4.sysctl_udp_rmem_min),
 	.obj_size		= sizeof(struct udp6_sock),
+	.slab_flags		= SLAB_ACCOUNT,
 	.h.udp_table		= &udp_table,
 #ifdef CONFIG_COMPAT
 	.compat_setsockopt	= compat_udpv6_setsockopt,
diff --git a/net/unix/af_unix.c b/net/unix/af_unix.c
index 95b02a71fd47..5e3e377a7269 100644
--- a/net/unix/af_unix.c
+++ b/net/unix/af_unix.c
@@ -742,6 +742,7 @@ static struct proto unix_proto = {
 	.name			= "UNIX",
 	.owner			= THIS_MODULE,
 	.obj_size		= sizeof(struct unix_sock),
+	.slab_flags		= SLAB_ACCOUNT,
 };
 
 static struct sock *unix_create1(struct net *net, struct socket *sock, int kern)
-- 
2.18.0.rc2.346.g013aa6912e-goog

