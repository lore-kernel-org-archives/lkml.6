Return-Path: <SRS0=7Z+k=KK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6A7EC6778F
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 02:33:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6896820671
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 02:33:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b="U/6JC4Bn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6896820671
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=arista.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729118AbeGZDqc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Jul 2018 23:46:32 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:37667 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729068AbeGZDqb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jul 2018 23:46:31 -0400
Received: by mail-ed1-f67.google.com with SMTP id b10-v6so337390eds.4
        for <linux-kernel@vger.kernel.org>; Wed, 25 Jul 2018 19:31:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=googlenew;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=z0/Zo1rLDSxi7qxt1pPuM8s6wHm2XpbvzzFP5iHNqfs=;
        b=U/6JC4BnzxMboPkLVBVavLCIqOlvOVi2NLv6lzFswodbBBUZYel/XEfZqUJBhNyfWK
         5CJSB75qCxbY3Tpn4PGgKpFzs1STR9wHNPGou+F+rcGztfTh6guwfsJnebPnXb4rkLh/
         d3UdEWMl5uix0XCbpQ5mig3cLOXM75vctMYsudNH5KQMWzU34ijo58bj5VnqnkDYOmA2
         WlVPQjOy+UyIRS0DNZFnoBTy67u9SnQ2gu/008KLpvlk+4fDT6gqj0emRa9zTS4kTXF2
         zU1tLEaU3r7Ljn1frneRGc44aagVtu0pW4Yscw46Kk7Aq0kLVb4ciJk3lgeera6klzCA
         IWwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=z0/Zo1rLDSxi7qxt1pPuM8s6wHm2XpbvzzFP5iHNqfs=;
        b=TWNz+lAF4413mNeYZ+GxCN8O5DVXYZeDU78shvQsIzIEOAf/cgYBCIVd8K8CY/6Yy9
         fG1A+AzCul1mMHAYz/AV2i0AM2j+VQMluBzJycx3pl1cvAvi208OKZbS/MZ0mnemyLOr
         IlYQ7sjGSEsgaUTbE/zOXjK30gpbYU1Ud4Ye1hee1wLnBMzV1tLMm8/deDtzCp9DnQqk
         4zomY0ZoGb67mlt+VBlf7xaaQvN+nF1suLenW76XokNWczAHZiYnnnqlrQ2jzZga0oy7
         0lRLh0U7ixUWyhTsgLE2+3gE/pfiRfK0tkOBWpcPjHTimNVOG3NvLN7KM/MQx9lx3SaM
         +zlg==
X-Gm-Message-State: AOUpUlFcccvdKrx0vVarBbuaJYPUeJpMu2Xv7Ai2AtyA7N4p3EsoxUMM
        +ekW/U4vjCBz1eGWLpiMDHdgwHDhBjk=
X-Google-Smtp-Source: AAOMgpdJUeteyxV2p3f5r7V72YCr2yyBTkotDSofFXL8V7KvkYz+YnP7JZsWEwv3Ql14rPaMgCHkmQ==
X-Received: by 2002:a50:c251:: with SMTP id t17-v6mr513489edf.108.1532572316829;
        Wed, 25 Jul 2018 19:31:56 -0700 (PDT)
Received: from dhcp.ire.aristanetworks.com ([217.173.96.166])
        by smtp.gmail.com with ESMTPSA id x13-v6sm241024edx.17.2018.07.25.19.31.55
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 25 Jul 2018 19:31:56 -0700 (PDT)
From:   Dmitry Safonov <dima@arista.com>
To:     linux-kernel@vger.kernel.org
Cc:     Dmitry Safonov <dima@arista.com>,
        "David S. Miller" <davem@davemloft.net>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Steffen Klassert <steffen.klassert@secunet.com>,
        Dmitry Safonov <0x7f454c46@gmail.com>, netdev@vger.kernel.org
Subject: [PATCH 09/18] xfrm: Dump usersa_info in compat/native formats
Date:   Thu, 26 Jul 2018 03:31:35 +0100
Message-Id: <20180726023144.31066-10-dima@arista.com>
X-Mailer: git-send-email 2.13.6
In-Reply-To: <20180726023144.31066-1-dima@arista.com>
References: <20180726023144.31066-1-dima@arista.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Create xfrm_usersa_info in netlink messages in 32/64-bit UABI according
to type of syscall used to dump xfrm state.

Cc: "David S. Miller" <davem@davemloft.net>
Cc: Herbert Xu <herbert@gondor.apana.org.au>
Cc: Steffen Klassert <steffen.klassert@secunet.com>
Cc: netdev@vger.kernel.org
Signed-off-by: Dmitry Safonov <dima@arista.com>
---
 net/xfrm/xfrm_user.c | 55 ++++++++++++++++++++++++++++++++++++++++------------
 1 file changed, 43 insertions(+), 12 deletions(-)

diff --git a/net/xfrm/xfrm_user.c b/net/xfrm/xfrm_user.c
index b123e788488f..63622264a3a9 100644
--- a/net/xfrm/xfrm_user.c
+++ b/net/xfrm/xfrm_user.c
@@ -799,9 +799,9 @@ static int xfrm_del_sa(struct sk_buff *skb, struct nlmsghdr *nlh,
 	return err;
 }
 
-static void copy_to_user_state(struct xfrm_state *x, struct xfrm_usersa_info *p)
+static void __copy_to_user_state(struct xfrm_state *x,
+		struct xfrm_usersa_info_packed *p)
 {
-	memset(p, 0, sizeof(*p));
 	memcpy(&p->id, &x->id, sizeof(p->id));
 	memcpy(&p->sel, &x->sel, sizeof(p->sel));
 	memcpy(&p->lft, &x->lft, sizeof(p->lft));
@@ -818,11 +818,25 @@ static void copy_to_user_state(struct xfrm_state *x, struct xfrm_usersa_info *p)
 	p->seq = x->km.seq;
 }
 
+static void copy_to_user_state(struct xfrm_state *x, struct xfrm_usersa_info *p)
+{
+	memset(p, 0, sizeof(*p));
+	__copy_to_user_state(x, (struct xfrm_usersa_info_packed *)p);
+}
+
+static void copy_to_user_state_compat(struct xfrm_state *x,
+		struct xfrm_usersa_info_packed *p)
+{
+	memset(p, 0, sizeof(*p));
+	__copy_to_user_state(x, p);
+}
+
 struct xfrm_dump_info {
 	struct sk_buff *in_skb;
 	struct sk_buff *out_skb;
 	u32 nlmsg_seq;
 	u16 nlmsg_flags;
+	bool compat_dump;
 };
 
 static int copy_sec_ctx(struct xfrm_sec_ctx *s, struct sk_buff *skb)
@@ -882,14 +896,10 @@ static int copy_to_user_auth(struct xfrm_algo_auth *auth, struct sk_buff *skb)
 }
 
 /* Don't change this without updating xfrm_sa_len! */
-static int copy_to_user_state_extra(struct xfrm_state *x,
-				    struct xfrm_usersa_info *p,
-				    struct sk_buff *skb)
+static int __copy_to_user_state_extra(struct xfrm_state *x, struct sk_buff *skb)
 {
 	int ret = 0;
 
-	copy_to_user_state(x, p);
-
 	if (x->props.extra_flags) {
 		ret = nla_put_u32(skb, XFRMA_SA_EXTRA_FLAGS,
 				  x->props.extra_flags);
@@ -968,23 +978,42 @@ static int copy_to_user_state_extra(struct xfrm_state *x,
 	return ret;
 }
 
+static int copy_to_user_state_extra(struct xfrm_state *x,
+		struct xfrm_usersa_info *p, struct sk_buff *skb)
+{
+	copy_to_user_state(x, p);
+	return __copy_to_user_state_extra(x, skb);
+}
+
+static int copy_to_user_state_extra_compat(struct xfrm_state *x,
+		struct xfrm_usersa_info_packed *p, struct sk_buff *skb)
+{
+	copy_to_user_state_compat(x, p);
+	return __copy_to_user_state_extra(x, skb);
+}
+
 static int dump_one_state(struct xfrm_state *x, int count, void *ptr)
 {
 	struct xfrm_dump_info *sp = ptr;
 	struct sk_buff *in_skb = sp->in_skb;
 	struct sk_buff *skb = sp->out_skb;
-	struct xfrm_usersa_info *p;
 	struct nlmsghdr *nlh;
+	size_t msg_len;
 	int err;
 
+	if (sp->compat_dump)
+		msg_len = sizeof(struct xfrm_usersa_info_packed);
+	else
+		msg_len = sizeof(struct xfrm_usersa_info);
 	nlh = nlmsg_put(skb, NETLINK_CB(in_skb).portid, sp->nlmsg_seq,
-			XFRM_MSG_NEWSA, sizeof(*p), sp->nlmsg_flags);
+			XFRM_MSG_NEWSA, msg_len, sp->nlmsg_flags);
 	if (nlh == NULL)
 		return -EMSGSIZE;
 
-	p = nlmsg_data(nlh);
-
-	err = copy_to_user_state_extra(x, p, skb);
+	if (sp->compat_dump)
+		err = copy_to_user_state_extra_compat(x, nlmsg_data(nlh), skb);
+	else
+		err = copy_to_user_state_extra(x, nlmsg_data(nlh), skb);
 	if (err) {
 		nlmsg_cancel(skb, nlh);
 		return err;
@@ -1018,6 +1047,7 @@ static int xfrm_dump_sa(struct sk_buff *skb, struct netlink_callback *cb)
 	info.out_skb = skb;
 	info.nlmsg_seq = cb->nlh->nlmsg_seq;
 	info.nlmsg_flags = NLM_F_MULTI;
+	info.compat_dump = in_compat_syscall();
 
 	if (!cb->args[0]) {
 		struct nlattr *attrs[XFRMA_MAX+1];
@@ -1064,6 +1094,7 @@ static struct sk_buff *xfrm_state_netlink(struct sk_buff *in_skb,
 	info.out_skb = skb;
 	info.nlmsg_seq = seq;
 	info.nlmsg_flags = 0;
+	info.compat_dump = in_compat_syscall();
 
 	err = dump_one_state(x, 0, &info);
 	if (err) {
-- 
2.13.6

