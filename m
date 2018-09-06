Return-Path: <SRS0=QnR0=LU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BD70C433F5
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 19:21:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E6E9D20659
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 19:21:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lixom-net.20150623.gappssmtp.com header.i=@lixom-net.20150623.gappssmtp.com header.b="PQkbjwiy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E6E9D20659
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lixom.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729457AbeIFX54 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Sep 2018 19:57:56 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:36991 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728929AbeIFX5z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Sep 2018 19:57:55 -0400
Received: by mail-pg1-f193.google.com with SMTP id 2-v6so5724416pgo.4
        for <linux-kernel@vger.kernel.org>; Thu, 06 Sep 2018 12:21:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lixom-net.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id;
        bh=uQco4RZ7XsTXdP6JhzYXyveuQOj30uCl2stSRFiheM4=;
        b=PQkbjwiyekXNWPDb3dvggZlm+k81BRI3N+xlIiI9bKM00HyGxqtf5DocRu3D59ukWb
         aMp9jBh7QhR1z2yHaQ/7XatLWbwynUHJ80j8tVulCppKAFy/QdGWvThR1pYls2B4n+iY
         S8OChVYN4PtDrN+XRgfjQfHTnUToXIkMLdzpeT6ExLXPT7vF7ZuY/FVPpzgtD0uwN/AX
         do5czfE04KotKN1cNTbxhMf4nITrABSZkKiCKNTGLnMUyPbLDEANv0pxP2kn0OkQD7if
         rsbt6deEFBM2AhcO1rR8xlFrAc1ilS4C+u4VtXDyU/AnS+UjQrPcEDpqqMFjDdQY85dP
         6KYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=uQco4RZ7XsTXdP6JhzYXyveuQOj30uCl2stSRFiheM4=;
        b=I60/wD6L4dZfu2mrtaQiFnyduvSjTj+VXqvwAKmXcP5E1e5ZjiZj6RgDrNCPV1HPgJ
         9s/9qXgNu46mx0Lr5qoJ0+18vmm4kAAORZdIgZQJS9vTWgCiR/keaDPGhcRCdZZzS+ZF
         N2rWPm/E4dNqtBNk5ou2NCW5WrLyaGs9mKZ4xLlN3oMglOIlUzfXZviLmC+LS4R8KH+Y
         t2Cp2ClsOk/clh/Nk+DZYU1rLO8d4w9UJKnGQmDHBz1gWjcBwf0GusPdoCMDnT0iarYN
         JveEtelosOub6F+4nGw3ZNmczQuFCklfRdMeO1Jq/rRqp0ITjcABjst7vwJYm28ihi0z
         TSDw==
X-Gm-Message-State: APzg51Cz6gIllrca528Bo7MqGXD1RKaVI+RpFW3dUubfVnt+JAi7WavY
        PmSFn96pNVdIrNASKHpLWud1PQ==
X-Google-Smtp-Source: ANB0VdZ1RroRsZPf762iGXi75DHRyX+4cQZ3nnXAKcWXv2w1DXNxLbDBVdWi1aVrpkTLzTlQuKCRSg==
X-Received: by 2002:a63:2d87:: with SMTP id t129-v6mr4431396pgt.128.1536261661525;
        Thu, 06 Sep 2018 12:21:01 -0700 (PDT)
Received: from localhost.localdomain (99-152-116-91.lightspeed.sntcca.sbcglobal.net. [99.152.116.91])
        by smtp.gmail.com with ESMTPSA id e7-v6sm7101154pgc.55.2018.09.06.12.20.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 06 Sep 2018 12:21:00 -0700 (PDT)
From:   Olof Johansson <olof@lixom.net>
To:     Eric Dumazet <edumazet@google.com>,
        "David S . Miller" <davem@davemloft.net>
Cc:     Neil Horman <nhorman@tuxdriver.com>,
        Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>,
        Vlad Yasevich <vyasevich@gmail.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>,
        Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-sctp@vger.kernel.org, netdev@vger.kernel.org,
        linux-decnet-user@lists.sourceforge.net, kernel-team@fb.com,
        Olof Johansson <olof@lixom.net>
Subject: [PATCH] net/sock: move memory_allocated over to percpu_counter variables
Date:   Thu,  6 Sep 2018 12:20:34 -0700
Message-Id: <20180906192034.8467-1-olof@lixom.net>
X-Mailer: git-send-email 2.11.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Today these are all global shared variables per protocol, and in
particular tcp_memory_allocated can get hot on a system with
large number of CPUs and a substantial number of connections.

Moving it over to a per-cpu variable makes it significantly cheaper,
and the added overhead when summing up the percpu copies is still smaller
than the cost of having a hot cacheline bouncing around.

Signed-off-by: Olof Johansson <olof@lixom.net>
---
 crypto/af_alg.c         | 10 ++++++++--
 include/net/sctp/sctp.h |  3 ++-
 include/net/sock.h      | 12 ++++++------
 include/net/tcp.h       |  2 +-
 include/net/udp.h       |  2 +-
 net/core/sock.c         |  5 ++++-
 net/decnet/af_decnet.c  |  3 ++-
 net/ipv4/tcp.c          |  3 ++-
 net/ipv4/udp.c          |  4 +++-
 net/sctp/protocol.c     |  6 ++++++
 net/sctp/socket.c       |  2 +-
 11 files changed, 36 insertions(+), 16 deletions(-)

diff --git a/crypto/af_alg.c b/crypto/af_alg.c
index b053179e0bc5..1fd75a709d7b 100644
--- a/crypto/af_alg.c
+++ b/crypto/af_alg.c
@@ -29,7 +29,7 @@ struct alg_type_list {
 	struct list_head list;
 };
 
-static atomic_long_t alg_memory_allocated;
+static struct percpu_counter alg_memory_allocated;
 
 static struct proto alg_proto = {
 	.name			= "ALG",
@@ -1183,13 +1183,19 @@ static int __init af_alg_init(void)
 	if (err)
 		goto out;
 
-	err = sock_register(&alg_family);
+	err = percpu_counter_init(&alg_memory_allocated, 0, GFP_KERNEL);
 	if (err != 0)
 		goto out_unregister_proto;
 
+	err = sock_register(&alg_family);
+	if (err != 0)
+		goto out_free_percpu;
+
 out:
 	return err;
 
+out_free_percpu:
+	percpu_counter_destroy(&alg_memory_allocated);
 out_unregister_proto:
 	proto_unregister(&alg_proto);
 	goto out;
diff --git a/include/net/sctp/sctp.h b/include/net/sctp/sctp.h
index 8c2caa370e0f..270579cf310b 100644
--- a/include/net/sctp/sctp.h
+++ b/include/net/sctp/sctp.h
@@ -36,7 +36,7 @@
  *    Sridhar Samudrala     <sri@us.ibm.com>
  *    Ardelle Fan           <ardelle.fan@intel.com>
  *    Ryan Layer            <rmlayer@us.ibm.com>
- *    Kevin Gao             <kevin.gao@intel.com> 
+ *    Kevin Gao             <kevin.gao@intel.com>
  */
 
 #ifndef __net_sctp_h__
@@ -114,6 +114,7 @@ __poll_t sctp_poll(struct file *file, struct socket *sock,
 void sctp_sock_rfree(struct sk_buff *skb);
 void sctp_copy_sock(struct sock *newsk, struct sock *sk,
 		    struct sctp_association *asoc);
+extern struct percpu_counter sctp_memory_allocated;
 extern struct percpu_counter sctp_sockets_allocated;
 int sctp_asconf_mgmt(struct sctp_sock *, struct sctp_sockaddr_entry *);
 struct sk_buff *sctp_skb_recv_datagram(struct sock *, int, int, int *);
diff --git a/include/net/sock.h b/include/net/sock.h
index 433f45fc2d68..45aed5e84b5d 100644
--- a/include/net/sock.h
+++ b/include/net/sock.h
@@ -1114,7 +1114,7 @@ struct proto {
 	/* Memory pressure */
 	void			(*enter_memory_pressure)(struct sock *sk);
 	void			(*leave_memory_pressure)(struct sock *sk);
-	atomic_long_t		*memory_allocated;	/* Current allocated memory. */
+	struct percpu_counter	*memory_allocated;	/* Current allocated memory. */
 	struct percpu_counter	*sockets_allocated;	/* Current number of sockets. */
 	/*
 	 * Pressure flag: try to collapse.
@@ -1237,19 +1237,19 @@ static inline bool sk_under_memory_pressure(const struct sock *sk)
 static inline long
 sk_memory_allocated(const struct sock *sk)
 {
-	return atomic_long_read(sk->sk_prot->memory_allocated);
+	return percpu_counter_sum_positive(sk->sk_prot->memory_allocated);
 }
 
-static inline long
+static inline void
 sk_memory_allocated_add(struct sock *sk, int amt)
 {
-	return atomic_long_add_return(amt, sk->sk_prot->memory_allocated);
+	percpu_counter_add(sk->sk_prot->memory_allocated, amt);
 }
 
 static inline void
 sk_memory_allocated_sub(struct sock *sk, int amt)
 {
-	atomic_long_sub(amt, sk->sk_prot->memory_allocated);
+	percpu_counter_sub(sk->sk_prot->memory_allocated, amt);
 }
 
 static inline void sk_sockets_allocated_dec(struct sock *sk)
@@ -1277,7 +1277,7 @@ proto_sockets_allocated_sum_positive(struct proto *prot)
 static inline long
 proto_memory_allocated(struct proto *prot)
 {
-	return atomic_long_read(prot->memory_allocated);
+	return percpu_counter_sum_positive(prot->memory_allocated);
 }
 
 static inline bool
diff --git a/include/net/tcp.h b/include/net/tcp.h
index 770917d0caa7..2df1754cf3ab 100644
--- a/include/net/tcp.h
+++ b/include/net/tcp.h
@@ -248,7 +248,7 @@ extern long sysctl_tcp_mem[3];
 #define TCP_RACK_STATIC_REO_WND  0x2 /* Use static RACK reo wnd */
 #define TCP_RACK_NO_DUPTHRESH    0x4 /* Do not use DUPACK threshold in RACK */
 
-extern atomic_long_t tcp_memory_allocated;
+extern struct percpu_counter tcp_memory_allocated;
 extern struct percpu_counter tcp_sockets_allocated;
 extern unsigned long tcp_memory_pressure;
 
diff --git a/include/net/udp.h b/include/net/udp.h
index 8482a990b0bb..9e0d9f7091a0 100644
--- a/include/net/udp.h
+++ b/include/net/udp.h
@@ -97,7 +97,7 @@ static inline struct udp_hslot *udp_hashslot2(struct udp_table *table,
 
 extern struct proto udp_prot;
 
-extern atomic_long_t udp_memory_allocated;
+extern struct percpu_counter udp_memory_allocated;
 
 /* sysctl variables for udp */
 extern long sysctl_udp_mem[3];
diff --git a/net/core/sock.c b/net/core/sock.c
index 3730eb855095..0a755f6c8942 100644
--- a/net/core/sock.c
+++ b/net/core/sock.c
@@ -2394,9 +2394,12 @@ EXPORT_SYMBOL(sk_wait_data);
 int __sk_mem_raise_allocated(struct sock *sk, int size, int amt, int kind)
 {
 	struct proto *prot = sk->sk_prot;
-	long allocated = sk_memory_allocated_add(sk, amt);
+	long allocated;
 	bool charged = true;
 
+	sk_memory_allocated_add(sk, amt);
+	allocated = sk_memory_allocated(sk);
+
 	if (mem_cgroup_sockets_enabled && sk->sk_memcg &&
 	    !(charged = mem_cgroup_charge_skmem(sk->sk_memcg, amt)))
 		goto suppress_allocation;
diff --git a/net/decnet/af_decnet.c b/net/decnet/af_decnet.c
index 7d6ff983ba2c..f88af9ae4474 100644
--- a/net/decnet/af_decnet.c
+++ b/net/decnet/af_decnet.c
@@ -156,7 +156,7 @@ static const struct proto_ops dn_proto_ops;
 static DEFINE_RWLOCK(dn_hash_lock);
 static struct hlist_head dn_sk_hash[DN_SK_HASH_SIZE];
 static struct hlist_head dn_wild_sk;
-static atomic_long_t decnet_memory_allocated;
+static struct percpu_counter decnet_memory_allocated;
 
 static int __dn_setsockopt(struct socket *sock, int level, int optname, char __user *optval, unsigned int optlen, int flags);
 static int __dn_getsockopt(struct socket *sock, int level, int optname, char __user *optval, int __user *optlen, int flags);
@@ -2356,6 +2356,7 @@ static int __init decnet_init(void)
 	int rc;
 
 	printk(banner);
+	percpu_counter_init(&decnet_memory_allocated, 0, GFP_KERNEL);
 
 	rc = proto_register(&dn_proto, 1);
 	if (rc != 0)
diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
index 8c4235c098fd..eb6531ba6bd3 100644
--- a/net/ipv4/tcp.c
+++ b/net/ipv4/tcp.c
@@ -289,7 +289,7 @@ EXPORT_SYMBOL_GPL(tcp_orphan_count);
 long sysctl_tcp_mem[3] __read_mostly;
 EXPORT_SYMBOL(sysctl_tcp_mem);
 
-atomic_long_t tcp_memory_allocated;	/* Current allocated memory. */
+struct percpu_counter tcp_memory_allocated;	/* Current allocated memory. */
 EXPORT_SYMBOL(tcp_memory_allocated);
 
 #if IS_ENABLED(CONFIG_SMC)
@@ -3834,6 +3834,7 @@ void __init tcp_init(void)
 	BUILD_BUG_ON(sizeof(struct tcp_skb_cb) >
 		     FIELD_SIZEOF(struct sk_buff, cb));
 
+	percpu_counter_init(&tcp_memory_allocated, 0, GFP_KERNEL);
 	percpu_counter_init(&tcp_sockets_allocated, 0, GFP_KERNEL);
 	percpu_counter_init(&tcp_orphan_count, 0, GFP_KERNEL);
 	inet_hashinfo_init(&tcp_hashinfo);
diff --git a/net/ipv4/udp.c b/net/ipv4/udp.c
index f4e35b2ff8b8..6ec5d2f68ae7 100644
--- a/net/ipv4/udp.c
+++ b/net/ipv4/udp.c
@@ -122,7 +122,7 @@ EXPORT_SYMBOL(udp_table);
 long sysctl_udp_mem[3] __read_mostly;
 EXPORT_SYMBOL(sysctl_udp_mem);
 
-atomic_long_t udp_memory_allocated;
+struct percpu_counter udp_memory_allocated;
 EXPORT_SYMBOL(udp_memory_allocated);
 
 #define MAX_UDP_PORTS 65536
@@ -2923,6 +2923,8 @@ void __init udp_init(void)
 
 	__udp_sysctl_init(&init_net);
 
+	percpu_counter_init(&udp_memory_allocated, 0, GFP_KERNEL);
+
 	/* 16 spinlocks per cpu */
 	udp_busylocks_log = ilog2(nr_cpu_ids) + 4;
 	udp_busylocks = kmalloc(sizeof(spinlock_t) << udp_busylocks_log,
diff --git a/net/sctp/protocol.c b/net/sctp/protocol.c
index e948db29ab53..ca59ca0dc740 100644
--- a/net/sctp/protocol.c
+++ b/net/sctp/protocol.c
@@ -1391,6 +1391,10 @@ static __init int sctp_init(void)
 	if (!sctp_chunk_cachep)
 		goto err_chunk_cachep;
 
+	status = percpu_counter_init(&sctp_memory_allocated, 0, GFP_KERNEL);
+	if (status)
+		goto err_percpu_memory_init;
+
 	status = percpu_counter_init(&sctp_sockets_allocated, 0, GFP_KERNEL);
 	if (status)
 		goto err_percpu_counter_init;
@@ -1559,6 +1563,8 @@ static __init int sctp_init(void)
 err_ehash_alloc:
 	percpu_counter_destroy(&sctp_sockets_allocated);
 err_percpu_counter_init:
+	percpu_counter_destroy(&sctp_memory_allocated);
+err_percpu_memory_init:
 	kmem_cache_destroy(sctp_chunk_cachep);
 err_chunk_cachep:
 	kmem_cache_destroy(sctp_bucket_cachep);
diff --git a/net/sctp/socket.c b/net/sctp/socket.c
index f73e9d38d5ba..60d55573baa5 100644
--- a/net/sctp/socket.c
+++ b/net/sctp/socket.c
@@ -107,7 +107,7 @@ static void sctp_sock_migrate(struct sock *oldsk, struct sock *newsk,
 			      enum sctp_socket_type type);
 
 static unsigned long sctp_memory_pressure;
-static atomic_long_t sctp_memory_allocated;
+struct percpu_counter sctp_memory_allocated;
 struct percpu_counter sctp_sockets_allocated;
 
 static void sctp_enter_memory_pressure(struct sock *sk)
-- 
2.11.0

