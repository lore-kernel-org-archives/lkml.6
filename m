Return-Path: <SRS0=zLEl=JR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8484BC6778A
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Jul 2018 15:31:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2971D20020
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Jul 2018 15:31:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jxEEUufP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2971D20020
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752388AbeGAPbx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 1 Jul 2018 11:31:53 -0400
Received: from mail-pg0-f67.google.com ([74.125.83.67]:45153 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752217AbeGAPbv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Jul 2018 11:31:51 -0400
Received: by mail-pg0-f67.google.com with SMTP id z1-v6so6008416pgv.12;
        Sun, 01 Jul 2018 08:31:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=TLJEHSMc0Ro9D+m+kk9Idvn2jncwryz9UfVUtdBu2PM=;
        b=jxEEUufP+0V5ykg+QX+pVQpYGJijdnufAgSozaUF17jhlzV/9bWERWpBX4czahyDja
         Lpj2m1cv8YmM0jQ7T2Cb8gyN0fqBt8JswZW+7UdOiebsDpP0aGEsC0tpyAC7stdlTsck
         P+ieVqJiVAUz8Gj5+OWYyF3D/S3My++G1VKOTSpkA97bXmRpM31JqVVf9+s8FNRI6+8l
         2hVrPs6G4Ts7Dv5LfmwVFG5e/cIkK0xA8MYXBriUUrW5hIjW7kT3GwHhnVfApV0U192G
         0BAlbM27wb9CjrkXT87Jo0bJ8g1cTj3mSaDkgxpj2Gnk5KA4W0KJ77Dro6XMxfdL5rVn
         2R3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=TLJEHSMc0Ro9D+m+kk9Idvn2jncwryz9UfVUtdBu2PM=;
        b=APgIZHEKuWfyGt3Hb0R3x+QD6LAMxfJ8sQBT3LOzialIoAw4nChhVKNmrWzawb5iPz
         XiO2AxvafUDYsnqpOG1i8rDNXR/2aGqIHLW1h3WDpxonLlZ9/tUJTPToB5mp56HuT2ii
         dlLQrAyhW9ww/XALKu1wGQGrc7ZxnevlVOp6VNBgCiG8ZaJOfIB55LqQ7/aC7gcw+L8J
         NCjowrEOQYsFlOLzt76xc/AQwpa0T3iaxJVsccCQcKARIAZa9CsIGdEmSoOfVZh64HSP
         2AxzN+FKRThSJs3TamyVbNLWBJK3UAwq6vO7WLaHJkumCbp5SIKijnNgmwPwXgguQWrJ
         q+bQ==
X-Gm-Message-State: APt69E2CYz2SCFLnELrF4FIHsGGR6b32DBBc9gadZ72JwL72/1XrhA8y
        WeD9rnIzA9Ul3OvwBcw4Uag=
X-Google-Smtp-Source: AAOMgpeoq97hMLSoUDaeUusmPjZ9olZwWYAjpYw4aQixGmxpRz+P5lWuwJPja9DQmCLlif0zRif+dQ==
X-Received: by 2002:a62:dd8:: with SMTP id 85-v6mr22118526pfn.202.1530459110752;
        Sun, 01 Jul 2018 08:31:50 -0700 (PDT)
Received: from li1588-6.members.linode.com (li1588-6.members.linode.com. [139.162.104.6])
        by smtp.gmail.com with ESMTPSA id y3-v6sm28014433pge.29.2018.07.01.08.31.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 01 Jul 2018 08:31:50 -0700 (PDT)
From:   Yafang Shao <laoar.shao@gmail.com>
To:     davem@davemloft.net, satoru.moriya@hds.com
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Yafang Shao <laoar.shao@gmail.com>
Subject: [PATCH] net: expose sk wmem in sock_exceed_buf_limit tracepoint
Date:   Sun,  1 Jul 2018 23:31:30 +0800
Message-Id: <1530459090-11037-1-git-send-email-laoar.shao@gmail.com>
X-Mailer: git-send-email 1.8.3.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently trace_sock_exceed_buf_limit() only show rmem info,
but wmem limit may also be hit.
So expose wmem info in this tracepoint as well.

Regarding memcg, I think it is better to introduce a new tracepoint(if
that is needed), i.e. trace_memcg_limit_hit other than show memcg info in
trace_sock_exceed_buf_limit.

Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
---
 include/trace/events/sock.h | 30 +++++++++++++++++++++++++-----
 net/core/sock.c             |  6 ++++--
 2 files changed, 29 insertions(+), 7 deletions(-)

diff --git a/include/trace/events/sock.h b/include/trace/events/sock.h
index 3176a39..a0c4b8a 100644
--- a/include/trace/events/sock.h
+++ b/include/trace/events/sock.h
@@ -35,6 +35,10 @@
 		EM(TCP_CLOSING)			\
 		EMe(TCP_NEW_SYN_RECV)
 
+#define skmem_kind_names			\
+		EM(SK_MEM_SEND)			\
+		EMe(SK_MEM_RECV)
+
 /* enums need to be exported to user space */
 #undef EM
 #undef EMe
@@ -44,6 +48,7 @@
 family_names
 inet_protocol_names
 tcp_state_names
+skmem_kind_names
 
 #undef EM
 #undef EMe
@@ -59,6 +64,9 @@
 #define show_tcp_state_name(val)        \
 	__print_symbolic(val, tcp_state_names)
 
+#define show_skmem_kind_names(val)	\
+	__print_symbolic(val, skmem_kind_names)
+
 TRACE_EVENT(sock_rcvqueue_full,
 
 	TP_PROTO(struct sock *sk, struct sk_buff *skb),
@@ -83,9 +91,9 @@
 
 TRACE_EVENT(sock_exceed_buf_limit,
 
-	TP_PROTO(struct sock *sk, struct proto *prot, long allocated),
+	TP_PROTO(struct sock *sk, struct proto *prot, long allocated, int kind),
 
-	TP_ARGS(sk, prot, allocated),
+	TP_ARGS(sk, prot, allocated, kind),
 
 	TP_STRUCT__entry(
 		__array(char, name, 32)
@@ -93,6 +101,10 @@
 		__field(long, allocated)
 		__field(int, sysctl_rmem)
 		__field(int, rmem_alloc)
+		__field(int, sysctl_wmem)
+		__field(int, wmem_alloc)
+		__field(int, wmem_queued)
+		__field(int, kind)
 	),
 
 	TP_fast_assign(
@@ -101,17 +113,25 @@
 		__entry->allocated = allocated;
 		__entry->sysctl_rmem = sk_get_rmem0(sk, prot);
 		__entry->rmem_alloc = atomic_read(&sk->sk_rmem_alloc);
+		__entry->sysctl_wmem = sk_get_wmem0(sk, prot);
+		__entry->wmem_alloc = refcount_read(&sk->sk_wmem_alloc);
+		__entry->wmem_queued = sk->sk_wmem_queued;
+		__entry->kind = kind;
 	),
 
-	TP_printk("proto:%s sysctl_mem=%ld,%ld,%ld allocated=%ld "
-		"sysctl_rmem=%d rmem_alloc=%d",
+	TP_printk("proto:%s sysctl_mem=%ld,%ld,%ld allocated=%ld sysctl_rmem=%d rmem_alloc=%d sysctl_wmem=%d wmem_alloc=%d wmem_queued=%d kind=%s",
 		__entry->name,
 		__entry->sysctl_mem[0],
 		__entry->sysctl_mem[1],
 		__entry->sysctl_mem[2],
 		__entry->allocated,
 		__entry->sysctl_rmem,
-		__entry->rmem_alloc)
+		__entry->rmem_alloc,
+		__entry->sysctl_wmem,
+		__entry->wmem_alloc,
+		__entry->wmem_queued,
+		show_skmem_kind_names(__entry->kind)
+	)
 );
 
 TRACE_EVENT(inet_sock_set_state,
diff --git a/net/core/sock.c b/net/core/sock.c
index bcc4182..65350ed 100644
--- a/net/core/sock.c
+++ b/net/core/sock.c
@@ -2401,9 +2401,10 @@ int __sk_mem_raise_allocated(struct sock *sk, int size, int amt, int kind)
 {
 	struct proto *prot = sk->sk_prot;
 	long allocated = sk_memory_allocated_add(sk, amt);
+	bool charged = true;
 
 	if (mem_cgroup_sockets_enabled && sk->sk_memcg &&
-	    !mem_cgroup_charge_skmem(sk->sk_memcg, amt))
+	    !(charged = mem_cgroup_charge_skmem(sk->sk_memcg, amt)))
 		goto suppress_allocation;
 
 	/* Under limit. */
@@ -2461,7 +2462,8 @@ int __sk_mem_raise_allocated(struct sock *sk, int size, int amt, int kind)
 			return 1;
 	}
 
-	trace_sock_exceed_buf_limit(sk, prot, allocated);
+	if (kind == SK_MEM_SEND || (kind == SK_MEM_RECV && charged))
+		trace_sock_exceed_buf_limit(sk, prot, allocated, kind);
 
 	sk_memory_allocated_sub(sk, amt);
 
-- 
1.8.3.1

