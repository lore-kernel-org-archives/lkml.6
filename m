Return-Path: <SRS0=fRGm=MU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55076C65C20
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 18:30:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1DA5B2089D
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 18:30:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PP46/4Nq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1DA5B2089D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=wand.net.nz
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726642AbeJIBnJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Oct 2018 21:43:09 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:44324 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726418AbeJIBnI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Oct 2018 21:43:08 -0400
Received: by mail-pg1-f193.google.com with SMTP id g2-v6so8185939pgu.11;
        Mon, 08 Oct 2018 11:30:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id;
        bh=LFLxEGBqOeOstag7/BfSv1kxS85G+cKXowB+V9H/0wY=;
        b=PP46/4NqVIOPONyaSiZjuhR0ZpLYaVOQ06HHxyRz3uJm+fbnmUgQFa5WvUZ6qIxj09
         wPrInnO6bwOxW4oJ8au4Smvg215ZJFjKYtVYBsULmig2XpuU1Qrp9q0L6aYQXGUXwas2
         uCwsJhVlFbbBPsz33tYLDHH7IxEpLOcq6gdVj3wrO9WxnyOq7Uhriivn5Rtpse7TG2E2
         F2Ayg32TxPp7Xwkl2gDwAgL5X6mW9pedPOrt1tBE30yc0US6aDxHQXt7nOqJgIZSfVRr
         IF4T48DrPyhcuuyPfZfnX+1qqKocecc+haQN2UTTNSL7KBLqPQSkN3ghZHIzcsNFSIZc
         eMIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id;
        bh=LFLxEGBqOeOstag7/BfSv1kxS85G+cKXowB+V9H/0wY=;
        b=ItLufwcXwB60ktg+SwMidzLYWp5NYCJvfc1yOXIo8SWIewHdDN7/82E116C9/7J191
         3c+Ku11xLAaACXSofgzNzVWq9sbirPaWLP7Jbr4OxcX+B9vI0AY9XKe3iZPRlmKpwmlY
         /ZiVL/6DeAYrO2d5S30jjo5zcy8g95YGhiwcPTSI96kq62A9y+hn9PqyTuVmWmaJuKDn
         KKvvS2f/+nOLyORe8/O7mTPvF1Ja6FY+AOgmZpNq3oDbrn+9m7O7pTEzU0dxJ4R72d3H
         ESxQM5vl8tvMi4Hpkp+sL4Vr19HmF/9BQwSU5rYGrEDHirrcL09cCKooIR65WkOuPBa+
         Qy3g==
X-Gm-Message-State: ABuFfog8MwaDAdaZK6adqD7QzfvGN0TLzv76P7FJDXrVo8Tvp585d8FO
        J80Mxp9FXdphUITyBC989dk=
X-Google-Smtp-Source: ACcGV608UW3c25YJ+wBRFdcyTtOQGazumJLVS5Yv4lIRHtLI4U6X9tI4ezrLY3CTydg5vICnietrFg==
X-Received: by 2002:a65:65c6:: with SMTP id y6-v6mr21785204pgv.233.1539023407020;
        Mon, 08 Oct 2018 11:30:07 -0700 (PDT)
Received: from localhost.localdomain ([99.0.85.34])
        by smtp.gmail.com with ESMTPSA id g6-v6sm29667534pgf.33.2018.10.08.11.30.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 08 Oct 2018 11:30:06 -0700 (PDT)
From:   Joe Stringer <joe@wand.net.nz>
To:     daniel@iogearbox.net
Cc:     Arnd Bergmann <arnd@arndb.de>, ast@kernel.org, davem@davemloft.net,
        john.fastabend@gmail.com, kafai@fb.com,
        makita.toshiaki@lab.ntt.co.jp, brakmo@fb.com, rdna@fb.com,
        brouer@redhat.com, jakub.kicinski@netronome.com,
        m.xhonneux@gmail.com, dsahern@gmail.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, liu.song.a23@gmail.com
Subject: [PATCHv2 bpf-next] bpf: fix building without CONFIG_INET
Date:   Mon,  8 Oct 2018 11:30:01 -0700
Message-Id: <20181008183001.10406-1-joe@wand.net.nz>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

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

Wrap the related sections of code in #ifdefs for the config option.

Furthermore, sk_lookup() should always have been marked 'static', this
also avoids a warning about a missing prototype when building with
'make W=1'.

Fixes: 6acc9b432e67 ("bpf: Add helper to retrieve socket in BPF")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Joe Stringer <joe@wand.net.nz>
---
v2: Modify the patch to remove the related code in preprocessor rather
    than relying on compiler optimizations to remove the code.
---
 net/core/filter.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/net/core/filter.c b/net/core/filter.c
index 30c6b2d3ef16..4bbc6567fcb8 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -4817,8 +4817,9 @@ static const struct bpf_func_proto bpf_lwt_seg6_adjust_srh_proto = {
 };
 #endif /* CONFIG_IPV6_SEG6_BPF */
 
-struct sock *sk_lookup(struct net *net, struct bpf_sock_tuple *tuple,
-		       struct sk_buff *skb, u8 family, u8 proto)
+#ifdef CONFIG_INET
+static struct sock *sk_lookup(struct net *net, struct bpf_sock_tuple *tuple,
+			      struct sk_buff *skb, u8 family, u8 proto)
 {
 	int dif = skb->dev->ifindex;
 	bool refcounted = false;
@@ -4951,6 +4952,7 @@ static const struct bpf_func_proto bpf_sk_release_proto = {
 	.ret_type	= RET_INTEGER,
 	.arg1_type	= ARG_PTR_TO_SOCKET,
 };
+#endif /* CONFIG_INET */
 
 bool bpf_helper_changes_pkt_data(void *func)
 {
@@ -5158,12 +5160,14 @@ tc_cls_act_func_proto(enum bpf_func_id func_id, const struct bpf_prog *prog)
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
@@ -5264,12 +5268,14 @@ sk_skb_func_proto(enum bpf_func_id func_id, const struct bpf_prog *prog)
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
2.17.1

