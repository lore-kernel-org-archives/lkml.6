Return-Path: <SRS0=9Qwj=MR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7F35C00449
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 16:16:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6C22A208E7
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 16:16:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6C22A208E7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729786AbeJEXPn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Oct 2018 19:15:43 -0400
Received: from mout.kundenserver.de ([217.72.192.75]:43299 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728732AbeJEXPn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Oct 2018 19:15:43 -0400
Received: from wuerfel.lan ([109.193.40.16]) by mrelayeu.kundenserver.de
 (mreue106 [212.227.15.145]) with ESMTPA (Nemesis) id
 1MHFsE-1fvJbf1zY8-00DHuV; Fri, 05 Oct 2018 18:15:31 +0200
Received: from wuerfel.lan ([109.193.40.16]) by mrelayeu.kundenserver.de
 (mreue106 [212.227.15.145]) with ESMTPA (Nemesis) id
 1MHFsE-1fvJbf1zY8-00DHuV; Fri, 05 Oct 2018 18:15:31 +0200
From:   Arnd Bergmann <arnd@arndb.de>
To:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        "David S. Miller" <davem@davemloft.net>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        John Fastabend <john.fastabend@gmail.com>,
        Martin KaFai Lau <kafai@fb.com>,
        Toshiaki Makita <makita.toshiaki@lab.ntt.co.jp>,
        Lawrence Brakmo <brakmo@fb.com>, Andrey Ignatov <rdna@fb.com>,
        Jesper Dangaard Brouer <brouer@redhat.com>,
        Jakub Kicinski <jakub.kicinski@netronome.com>,
        Mathieu Xhonneux <m.xhonneux@gmail.com>,
        David Ahern <dsahern@gmail.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] bpf: fix building without CONFIG_INET
Date:   Fri,  5 Oct 2018 18:15:12 +0200
Message-Id: <20181005161526.843924-1-arnd@arndb.de>
X-Mailer: git-send-email 2.18.0
X-Provags-ID: V03:K1:21p0oYgZ1g/q4chYe+cQfny2c7BghJLZg/1D9f+VxNN2Zz3cTwl
 9VpPjmyV++j6SvxqOCT+69jwLnrGRAU+E2KBNNef10hIVXFC+Jg5/bjn0j8CNqzOHCFGpAS
 q/XLy87vev/+BRkOrYwPwaVGhuYg38KnUit3UOs8RKgBHJITUPqYVSDzIT1B2PIAvTL62J+
 HcXW3tKFQeF0bEl0R3mkA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:alU/d3z2WcM=:bwAG5nKQjLW9Wr9EZn5Xc9
 KGqTX7S2qDtzxRR1Id1Kw0Tm3ea7KefwIOOPTwukE/EBFe7Fu2bwigk1EOCikWH7160rn3fAX
 XgM1ZvHMNYySxkyGx6mKRRCiDUPeqXmLAGdCO7wYAju2MS4UMLSHY92cuYDJPyZzwl9Uhk4Kw
 fHgxtSWNl+ELRwtL7lANef1kQwW/lRSl4u+e/UeBvauL5XdZcNPAIgg6umcvkZ5VNvTP3D4hM
 8zZ4pi3I/JpXxLBsJtzbBMncJhAbvBR2FKt33FrUgXr8cahT4mDdV8qm1e6WWplgQcIgCrUlt
 TrghNQZhDth8FnzhV27NkdfFGeRDTKVuGMdX7HLQue9azVY2kifX5iBAuZN+z44OSUm3BQtlX
 c+jn3EvqMUvGM7A/H8Uop/H8zxqrYc4+ZRj9oegU1n1R/A2MHcPOCwll8JQeYlCBpUzDq4p0s
 2mzVuad/trDmlt9RVsnKDSc4fuexTMZ/t7FbjExnrm4zfi4fTgWVW+U1u1mMvnBiW5wNp6pmI
 9OwZXv96x2AJSugHDyQuFvDtFHJT+lHx2VrjFY3Z/C+QdDlyK/AFEA4+pRHixiZP0cCNfQxQL
 GxTD8dagZZmmmfrObH01TcaeVH1c255x0lIR/67NTJuCiIW2FQrXBYdAaDaY4M4h9rZuuGlaC
 nFiSGyA8K9FX7Mq6gDzggqHpD6cS8nEePgUxlrrVcOBk9tReZ/NUL151Jemh25QpDanQ=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The newly added TCP and UDP handling fails to link when CONFIG_INET
is disabled:

net/core/filter.o: In function `sk_lookup':
filter.c:(.text+0x7ff8): undefined reference to `tcp_hashinfo'
filter.c:(.text+0x7ffc): undefined reference to `tcp_hashinfo'
filter.c:(.text+0x8020): undefined reference to `__inet_lookup_established'
filter.c:(.text+0x8058): undefined reference to `__inet_lookup_listener'
filter.c:(.text+0x8068): undefined reference to `udp_table'
filter.c:(.text+0x8070): undefined reference to `udp_table'
filter.c:(.text+0x808c): undefined reference to `__udp4_lib_lookup'
net/core/filter.o: In function `bpf_sk_release':
filter.c:(.text+0x82e8): undefined reference to `sock_gen_put'

The compiler can optimize it out and avoid those references for
the most part, but we are missing a few steps here:

- sk_lookup() should always have been marked 'static', this also
  avoids a warning about a missing prototype when building with
  'make W=1'.
- The BPF_CALL_x() macro needs a little change to allow marking
  the unneeded BPF call as 'static' and having the compiler
  drop them.
- The reference to the bpf_func_proto must be made conditional.

Fixes: 6acc9b432e67 ("bpf: Add helper to retrieve socket in BPF")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 include/linux/filter.h |  2 +-
 net/core/filter.c      | 18 +++++++++++-------
 2 files changed, 12 insertions(+), 8 deletions(-)

diff --git a/include/linux/filter.h b/include/linux/filter.h
index 6791a0ac0139..d9ec9d908bbe 100644
--- a/include/linux/filter.h
+++ b/include/linux/filter.h
@@ -428,9 +428,9 @@ struct sock_reuseport;
 		  u64, __ur_3, u64, __ur_4, u64, __ur_5)
 
 #define BPF_CALL_x(x, name, ...)					       \
+	u64 name(__BPF_REG(x, __BPF_DECL_REGS, __BPF_N, __VA_ARGS__));	       \
 	static __always_inline						       \
 	u64 ____##name(__BPF_MAP(x, __BPF_DECL_ARGS, __BPF_V, __VA_ARGS__));   \
-	u64 name(__BPF_REG(x, __BPF_DECL_REGS, __BPF_N, __VA_ARGS__));	       \
 	u64 name(__BPF_REG(x, __BPF_DECL_REGS, __BPF_N, __VA_ARGS__))	       \
 	{								       \
 		return ____##name(__BPF_MAP(x,__BPF_CAST,__BPF_N,__VA_ARGS__));\
diff --git a/net/core/filter.c b/net/core/filter.c
index 30c6b2d3ef16..dd5fe021f44c 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -4817,7 +4817,7 @@ static const struct bpf_func_proto bpf_lwt_seg6_adjust_srh_proto = {
 };
 #endif /* CONFIG_IPV6_SEG6_BPF */
 
-struct sock *sk_lookup(struct net *net, struct bpf_sock_tuple *tuple,
+static struct sock *sk_lookup(struct net *net, struct bpf_sock_tuple *tuple,
 		       struct sk_buff *skb, u8 family, u8 proto)
 {
 	int dif = skb->dev->ifindex;
@@ -4902,13 +4902,13 @@ bpf_sk_lookup(struct sk_buff *skb, struct bpf_sock_tuple *tuple, u32 len,
 	return (unsigned long) sk;
 }
 
-BPF_CALL_5(bpf_sk_lookup_tcp, struct sk_buff *, skb,
+static BPF_CALL_5(bpf_sk_lookup_tcp, struct sk_buff *, skb,
 	   struct bpf_sock_tuple *, tuple, u32, len, u64, netns_id, u64, flags)
 {
 	return bpf_sk_lookup(skb, tuple, len, IPPROTO_TCP, netns_id, flags);
 }
 
-static const struct bpf_func_proto bpf_sk_lookup_tcp_proto = {
+static const __maybe_unused struct bpf_func_proto bpf_sk_lookup_tcp_proto = {
 	.func		= bpf_sk_lookup_tcp,
 	.gpl_only	= false,
 	.pkt_access	= true,
@@ -4920,13 +4920,13 @@ static const struct bpf_func_proto bpf_sk_lookup_tcp_proto = {
 	.arg5_type	= ARG_ANYTHING,
 };
 
-BPF_CALL_5(bpf_sk_lookup_udp, struct sk_buff *, skb,
+static BPF_CALL_5(bpf_sk_lookup_udp, struct sk_buff *, skb,
 	   struct bpf_sock_tuple *, tuple, u32, len, u64, netns_id, u64, flags)
 {
 	return bpf_sk_lookup(skb, tuple, len, IPPROTO_UDP, netns_id, flags);
 }
 
-static const struct bpf_func_proto bpf_sk_lookup_udp_proto = {
+static const __maybe_unused struct bpf_func_proto bpf_sk_lookup_udp_proto = {
 	.func		= bpf_sk_lookup_udp,
 	.gpl_only	= false,
 	.pkt_access	= true,
@@ -4938,14 +4938,14 @@ static const struct bpf_func_proto bpf_sk_lookup_udp_proto = {
 	.arg5_type	= ARG_ANYTHING,
 };
 
-BPF_CALL_1(bpf_sk_release, struct sock *, sk)
+static BPF_CALL_1(bpf_sk_release, struct sock *, sk)
 {
 	if (!sock_flag(sk, SOCK_RCU_FREE))
 		sock_gen_put(sk);
 	return 0;
 }
 
-static const struct bpf_func_proto bpf_sk_release_proto = {
+static const __maybe_unused struct bpf_func_proto bpf_sk_release_proto = {
 	.func		= bpf_sk_release,
 	.gpl_only	= false,
 	.ret_type	= RET_INTEGER,
@@ -5158,12 +5158,14 @@ tc_cls_act_func_proto(enum bpf_func_id func_id, const struct bpf_prog *prog)
 	case BPF_FUNC_skb_ancestor_cgroup_id:
 		return &bpf_skb_ancestor_cgroup_id_proto;
 #endif
+#ifdef CONFIG_INET
 	case BPF_FUNC_sk_lookup_tcp:
 		return &bpf_sk_lookup_tcp_proto;
 	case BPF_FUNC_sk_lookup_udp:
 		return &bpf_sk_lookup_udp_proto;
 	case BPF_FUNC_sk_release:
 		return &bpf_sk_release_proto;
+#endif
 	default:
 		return bpf_base_func_proto(func_id);
 	}
@@ -5264,12 +5266,14 @@ sk_skb_func_proto(enum bpf_func_id func_id, const struct bpf_prog *prog)
 		return &bpf_sk_redirect_hash_proto;
 	case BPF_FUNC_get_local_storage:
 		return &bpf_get_local_storage_proto;
+#ifdef CONFIG_INET
 	case BPF_FUNC_sk_lookup_tcp:
 		return &bpf_sk_lookup_tcp_proto;
 	case BPF_FUNC_sk_lookup_udp:
 		return &bpf_sk_lookup_udp_proto;
 	case BPF_FUNC_sk_release:
 		return &bpf_sk_release_proto;
+#endif
 	default:
 		return bpf_base_func_proto(func_id);
 	}
-- 
2.18.0

