Return-Path: <SRS0=GJTC=JQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A66BC3279B
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Jun 2018 10:11:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DAA17214C4
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Jun 2018 10:11:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R8OvG1zQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DAA17214C4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S936781AbeF3KLD (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 30 Jun 2018 06:11:03 -0400
Received: from mail-pf0-f195.google.com ([209.85.192.195]:46630 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934675AbeF3KK7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Jun 2018 06:10:59 -0400
Received: by mail-pf0-f195.google.com with SMTP id l123-v6so2265382pfl.13;
        Sat, 30 Jun 2018 03:10:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=0fBxVKiB6P7zFYgm5gVeN4Vt+kQXtyxhsPRM1/V59iQ=;
        b=R8OvG1zQXGpBJ5lB5gdhIdL00tjoUfwHWN4VbIOzdLtwXjlsZznNSZzXZID+Nl+Z+D
         XlWjYW1C7ZWfjpRSWccxMCt4jjp2Dcv7mOCDrmIgsaQ+3yiUOHQvg+8xwRL/eJ6OB+05
         MK2oKTe29PqwBHdiFzW061Q4ym76zrTmfnLcgIpGL9q5XVEelKB/f6sunZ0IWW8l58HF
         xvxBo4Q+aApxYJ74lMZxmCDwB84eLq5HQPpJzEEhERiu4CUy93guwBvqhCmkxwLhhAsy
         rupLaJQPkS5ANiXMNQjjysnpSvPI4t1H5704VZsnp589b+MNMSd8qiZFMK9BGXmCkCUr
         eL+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=0fBxVKiB6P7zFYgm5gVeN4Vt+kQXtyxhsPRM1/V59iQ=;
        b=r1deIYrRq9Et2nUg7Mex0Yje7xtERndqV2nBLNNpzYc4N5A+UNUX0z1fM2uB5T86TZ
         CibbirO62RVUW+MIMcRzGTPNQsfEKPDmYW/5G0jwh06qHVz/wbgTsHylDUb0hhlg+5BP
         Kyd1xHl+hLB2iGe5GnA5oqu0xowlFkNKv3q2DvFvvwLyo8syErPTtu4TWMos/lwyF8JV
         ROauup+QaxA/wR1EkgX73ejDOW97VYF2Fht4HpJrxacey05RBA7ODeokEA0JjgnEe0+S
         I6M5uXvc7g0BQOeY0qKKu6miIcoh+E5PMCoyXqltu62j7nnruXRXRjywH3eksioXlWpn
         ZvdQ==
X-Gm-Message-State: APt69E1xMrRsRMw64weO+RgpxjK8JqYLQy39zBbAlutLf3BwQOHXfB0M
        VUxQjm0UlX3EzdwJU7Nfh6D50Phu
X-Google-Smtp-Source: AAOMgpchzgFFiW4iyp9t8Gf6uv2ln2LBFTK0ejWGYTiCvc0z8SjV7sdC5086ZWNcY43Jmk4CMC5afg==
X-Received: by 2002:a62:ea14:: with SMTP id t20-v6mr17929011pfh.117.1530353459302;
        Sat, 30 Jun 2018 03:10:59 -0700 (PDT)
Received: from li1588-6.members.linode.com (li1588-6.members.linode.com. [139.162.104.6])
        by smtp.gmail.com with ESMTPSA id g136-v6sm5589194pfb.23.2018.06.30.03.10.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 30 Jun 2018 03:10:58 -0700 (PDT)
From:   Yafang Shao <laoar.shao@gmail.com>
To:     davem@davemloft.net
Cc:     hannes@cmpxchg.org, mhocko@kernel.org, cgroups@vger.kernel.org,
        linux-mm@kvack.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, Yafang Shao <laoar.shao@gmail.com>
Subject: [PATCH net-next] net, mm: avoid unnecessary memcg charge skmem
Date:   Sat, 30 Jun 2018 18:09:57 +0800
Message-Id: <1530353397-12948-1-git-send-email-laoar.shao@gmail.com>
X-Mailer: git-send-email 1.8.3.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In __sk_mem_raise_allocated(), if mem_cgroup_charge_skmem() return
false, mem_cgroup_uncharge_skmem will be executed.

The logic is as bellow,
__sk_mem_raise_allocated
	ret = mem_cgroup_uncharge_skmem
		try_charge(memcg, gfp_mask|__GFP_NOFAIL, nr_pages);
		return false
	if (!ret)
		mem_cgroup_uncharge_skmem(sk->sk_memcg, amt);

So it is unnecessary to charge if it is not forced.

Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
---
 include/linux/memcontrol.h |  3 ++-
 mm/memcontrol.c            | 12 +++++++++---
 net/core/sock.c            |  5 +++--
 net/ipv4/tcp_output.c      |  2 +-
 4 files changed, 15 insertions(+), 7 deletions(-)

diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
index 6c6fb11..56c07c9 100644
--- a/include/linux/memcontrol.h
+++ b/include/linux/memcontrol.h
@@ -1160,7 +1160,8 @@ static inline void mem_cgroup_wb_stats(struct bdi_writeback *wb,
 #endif	/* CONFIG_CGROUP_WRITEBACK */
 
 struct sock;
-bool mem_cgroup_charge_skmem(struct mem_cgroup *memcg, unsigned int nr_pages);
+bool mem_cgroup_charge_skmem(struct mem_cgroup *memcg, unsigned int nr_pages,
+			     bool force);
 void mem_cgroup_uncharge_skmem(struct mem_cgroup *memcg, unsigned int nr_pages);
 #ifdef CONFIG_MEMCG
 extern struct static_key_false memcg_sockets_enabled_key;
diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index e6f0d5e..1122be2 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -5929,7 +5929,8 @@ void mem_cgroup_sk_free(struct sock *sk)
  * Charges @nr_pages to @memcg. Returns %true if the charge fit within
  * @memcg's configured limit, %false if the charge had to be forced.
  */
-bool mem_cgroup_charge_skmem(struct mem_cgroup *memcg, unsigned int nr_pages)
+bool mem_cgroup_charge_skmem(struct mem_cgroup *memcg, unsigned int nr_pages,
+			     bool force)
 {
 	gfp_t gfp_mask = GFP_KERNEL;
 
@@ -5940,7 +5941,10 @@ bool mem_cgroup_charge_skmem(struct mem_cgroup *memcg, unsigned int nr_pages)
 			memcg->tcpmem_pressure = 0;
 			return true;
 		}
-		page_counter_charge(&memcg->tcpmem, nr_pages);
+
+		if (force)
+			page_counter_charge(&memcg->tcpmem, nr_pages);
+
 		memcg->tcpmem_pressure = 1;
 		return false;
 	}
@@ -5954,7 +5958,9 @@ bool mem_cgroup_charge_skmem(struct mem_cgroup *memcg, unsigned int nr_pages)
 	if (try_charge(memcg, gfp_mask, nr_pages) == 0)
 		return true;
 
-	try_charge(memcg, gfp_mask|__GFP_NOFAIL, nr_pages);
+	if (force)
+		try_charge(memcg, gfp_mask|__GFP_NOFAIL, nr_pages);
+
 	return false;
 }
 
diff --git a/net/core/sock.c b/net/core/sock.c
index bcc4182..148a840 100644
--- a/net/core/sock.c
+++ b/net/core/sock.c
@@ -2401,9 +2401,10 @@ int __sk_mem_raise_allocated(struct sock *sk, int size, int amt, int kind)
 {
 	struct proto *prot = sk->sk_prot;
 	long allocated = sk_memory_allocated_add(sk, amt);
+	bool charged = false;
 
 	if (mem_cgroup_sockets_enabled && sk->sk_memcg &&
-	    !mem_cgroup_charge_skmem(sk->sk_memcg, amt))
+	    !(charged = mem_cgroup_charge_skmem(sk->sk_memcg, amt, false)))
 		goto suppress_allocation;
 
 	/* Under limit. */
@@ -2465,7 +2466,7 @@ int __sk_mem_raise_allocated(struct sock *sk, int size, int amt, int kind)
 
 	sk_memory_allocated_sub(sk, amt);
 
-	if (mem_cgroup_sockets_enabled && sk->sk_memcg)
+	if (mem_cgroup_sockets_enabled && sk->sk_memcg && charged)
 		mem_cgroup_uncharge_skmem(sk->sk_memcg, amt);
 
 	return 0;
diff --git a/net/ipv4/tcp_output.c b/net/ipv4/tcp_output.c
index f8f6129..9b741d4 100644
--- a/net/ipv4/tcp_output.c
+++ b/net/ipv4/tcp_output.c
@@ -3014,7 +3014,7 @@ void sk_forced_mem_schedule(struct sock *sk, int size)
 	sk_memory_allocated_add(sk, amt);
 
 	if (mem_cgroup_sockets_enabled && sk->sk_memcg)
-		mem_cgroup_charge_skmem(sk->sk_memcg, amt);
+		mem_cgroup_charge_skmem(sk->sk_memcg, amt, true);
 }
 
 /* Send a FIN. The caller locks the socket for us.
-- 
1.8.3.1

