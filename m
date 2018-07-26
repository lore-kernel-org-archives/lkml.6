Return-Path: <SRS0=7Z+k=KK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28797C6778F
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 02:32:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BB6F520671
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 02:32:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b="cTovwWWm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BB6F520671
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=arista.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729340AbeGZDqe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Jul 2018 23:46:34 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:44817 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729038AbeGZDqe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jul 2018 23:46:34 -0400
Received: by mail-ed1-f65.google.com with SMTP id f23-v6so324046edr.11
        for <linux-kernel@vger.kernel.org>; Wed, 25 Jul 2018 19:32:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=googlenew;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=XhoXMH7Yc+8ti6nLDpEVZ8/X4ueeuqbAkcluI8q7UX0=;
        b=cTovwWWmTmHRDbP/wcFaazUNfntenzKIJEiKv/MaCnuIyjQLwmA0gray2hzf8WZyEp
         lHhLqf1zZLqV4qLG/vZN48zsUeJ2qDvrCUjU1pTha/Q6kfDKEOFXgArLc+9TcjT/gLwX
         HnvEWS9sZQH/mEg9poI3GoGtnMrZ48g+tc5QkSOBEGicUI54UkVxhohRnjxc5tVlcwhg
         Y4juCcq6idSlGWn1pOHh/YPrFWCz5jimDLOxl076gAyXpOrwcqUfnAxDLJWo3C/LN7QM
         Svzc7d7vvJtG0kySm/oXSTtkPOQd+h5j9o0A/XUMQkNA4UbBJEtr936JGo7c1ZTNpbMt
         vKNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=XhoXMH7Yc+8ti6nLDpEVZ8/X4ueeuqbAkcluI8q7UX0=;
        b=rzH4b64tMpib+mc6Pfj/Lno/p0EexTfqXJzPo3p2k/fM7HTih9rDalwjLyjIs0uycW
         J2f4huJvVZKaqIm+QA0PMCdBX2YbDQhBYXt8VXf77H1Bqxc8qniBa04mybgCLTajWrD5
         xhRAJbRffL/pCn0dIFiq7gC24+SV+wE6Ko2R1DVyvY5Tte9jl2zhCNWUEYPDFEwl66lM
         Q0t8BXqaE2WnvfNMKMCql3+zknGbWOVwQY85+FJalVF9Aih5I0iruznagnc8Y5zTFNxE
         QYpANC3yg6WTSqOdNuXy8vZ3EZQK1u0lz3xaQ/fUeP9+ufPAWaNj7rPqgrZ1iTupCjtm
         DenQ==
X-Gm-Message-State: AOUpUlE1uoT9KQQdE+oONDM3qBYkeUQ3xZ+H+fL91O1VBQNfns0yt8Zy
        wAAyCAwvXk9e6xV0pa2H7+OACPPfh60=
X-Google-Smtp-Source: AAOMgpdYDeAFVDdquu//D7WoghhiieG+zFq64FZw32oJGiFDTYaUV1sMvjEEcQHavURySQqbducQCg==
X-Received: by 2002:a50:eacb:: with SMTP id u11-v6mr502663edp.7.1532572319868;
        Wed, 25 Jul 2018 19:31:59 -0700 (PDT)
Received: from dhcp.ire.aristanetworks.com ([217.173.96.166])
        by smtp.gmail.com with ESMTPSA id x13-v6sm241024edx.17.2018.07.25.19.31.58
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 25 Jul 2018 19:31:59 -0700 (PDT)
From:   Dmitry Safonov <dima@arista.com>
To:     linux-kernel@vger.kernel.org
Cc:     Dmitry Safonov <dima@arista.com>,
        "David S. Miller" <davem@davemloft.net>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Steffen Klassert <steffen.klassert@secunet.com>,
        Dmitry Safonov <0x7f454c46@gmail.com>, netdev@vger.kernel.org
Subject: [PATCH 12/18] xfrm: Add compat support for xfrm_userpolicy_info messages
Date:   Thu, 26 Jul 2018 03:31:38 +0100
Message-Id: <20180726023144.31066-13-dima@arista.com>
X-Mailer: git-send-email 2.13.6
In-Reply-To: <20180726023144.31066-1-dima@arista.com>
References: <20180726023144.31066-1-dima@arista.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Parse userpolicy messages sent by userspace according to in_compat_syscall().
Applications that used native bind() syscall are in XFRMNLGRP_POLICY, so
send there xfrm_usersa_info messages (with 64-bit ABI). Compatible
applications are added to kernel-hidden XFRMNLGRP_COMPAT_POLICY group, so
send there xfrm_usersa_info messages_packed (with 32-bit ABI)

Cc: "David S. Miller" <davem@davemloft.net>
Cc: Herbert Xu <herbert@gondor.apana.org.au>
Cc: Steffen Klassert <steffen.klassert@secunet.com>
Cc: netdev@vger.kernel.org
Signed-off-by: Dmitry Safonov <dima@arista.com>
---
 net/xfrm/xfrm_user.c | 73 +++++++++++++++++++++++++++++++++++++++++-----------
 1 file changed, 58 insertions(+), 15 deletions(-)

diff --git a/net/xfrm/xfrm_user.c b/net/xfrm/xfrm_user.c
index ca1a14f45cf7..df792a3be8f2 100644
--- a/net/xfrm/xfrm_user.c
+++ b/net/xfrm/xfrm_user.c
@@ -1630,9 +1630,9 @@ static void copy_from_user_policy(struct xfrm_policy *xp,
 	/* XXX xp->share = p->share; */
 }
 
-static void copy_to_user_policy(struct xfrm_policy *xp, struct xfrm_userpolicy_info *p, int dir)
+static void __copy_to_user_policy(struct xfrm_policy *xp,
+		struct xfrm_userpolicy_info_packed *p, int dir)
 {
-	memset(p, 0, sizeof(*p));
 	memcpy(&p->sel, &xp->selector, sizeof(p->sel));
 	memcpy(&p->lft, &xp->lft, sizeof(p->lft));
 	memcpy(&p->curlft, &xp->curlft, sizeof(p->curlft));
@@ -1645,6 +1645,20 @@ static void copy_to_user_policy(struct xfrm_policy *xp, struct xfrm_userpolicy_i
 	p->share = XFRM_SHARE_ANY; /* XXX xp->share */
 }
 
+static void copy_to_user_policy(struct xfrm_policy *xp,
+		struct xfrm_userpolicy_info *p, int dir)
+{
+	memset(p, 0, sizeof(*p));
+	__copy_to_user_policy(xp, (struct xfrm_userpolicy_info_packed *)p, dir);
+}
+
+static void copy_to_user_policy_compat(struct xfrm_policy *xp,
+		struct xfrm_userpolicy_info_packed *p, int dir)
+{
+	memset(p, 0, sizeof(*p));
+	__copy_to_user_policy(xp, p, dir);
+}
+
 static struct xfrm_policy *xfrm_policy_construct(struct net *net,
 		struct xfrm_userpolicy_info_packed *p,
 		struct nlattr **attrs, int *errp)
@@ -1795,19 +1809,26 @@ static inline int copy_to_user_policy_type(u8 type, struct sk_buff *skb)
 static int dump_one_policy(struct xfrm_policy *xp, int dir, int count, void *ptr)
 {
 	struct xfrm_dump_info *sp = ptr;
-	struct xfrm_userpolicy_info *p;
 	struct sk_buff *in_skb = sp->in_skb;
 	struct sk_buff *skb = sp->out_skb;
 	struct nlmsghdr *nlh;
+	size_t msg_len;
 	int err;
 
+	if (sp->compat_dump)
+		msg_len = sizeof(struct xfrm_userpolicy_info_packed);
+	else
+		msg_len = sizeof(struct xfrm_userpolicy_info);
 	nlh = nlmsg_put(skb, NETLINK_CB(in_skb).portid, sp->nlmsg_seq,
-			XFRM_MSG_NEWPOLICY, sizeof(*p), sp->nlmsg_flags);
+			XFRM_MSG_NEWPOLICY, msg_len, sp->nlmsg_flags);
 	if (nlh == NULL)
 		return -EMSGSIZE;
 
-	p = nlmsg_data(nlh);
-	copy_to_user_policy(xp, p, dir);
+	if (sp->compat_dump)
+		copy_to_user_policy_compat(xp, nlmsg_data(nlh), dir);
+	else
+		copy_to_user_policy(xp, nlmsg_data(nlh), dir);
+
 	err = copy_to_user_tmpl(xp, skb);
 	if (!err)
 		err = copy_to_user_sec_ctx(xp, skb);
@@ -1852,6 +1873,7 @@ static int xfrm_dump_policy(struct sk_buff *skb, struct netlink_callback *cb)
 	info.out_skb = skb;
 	info.nlmsg_seq = cb->nlh->nlmsg_seq;
 	info.nlmsg_flags = NLM_F_MULTI;
+	info.compat_dump = in_compat_syscall();
 
 	(void) xfrm_policy_walk(net, walk, dump_one_policy, &info);
 
@@ -1874,6 +1896,7 @@ static struct sk_buff *xfrm_policy_netlink(struct sk_buff *in_skb,
 	info.out_skb = skb;
 	info.nlmsg_seq = seq;
 	info.nlmsg_flags = 0;
+	info.compat_dump = in_compat_syscall();
 
 	err = dump_one_policy(xp, dir, 0, &info);
 	if (err) {
@@ -3184,18 +3207,24 @@ static int xfrm_exp_policy_notify(struct xfrm_policy *xp, int dir, const struct
 	return xfrm_nlmsg_multicast(net, skb, 0, XFRMNLGRP_EXPIRE);
 }
 
-static int xfrm_notify_policy(struct xfrm_policy *xp, int dir, const struct km_event *c)
+static int __xfrm_notify_policy(struct xfrm_policy *xp, int dir,
+		const struct km_event *c, bool compat)
 {
 	unsigned int len = nla_total_size(sizeof(struct xfrm_user_tmpl) * xp->xfrm_nr);
+	unsigned int headlen, upi_size;
 	struct net *net = xp_net(xp);
-	struct xfrm_userpolicy_info *p;
 	struct xfrm_userpolicy_id *id;
+	void *userpolicy_info;
 	struct nlmsghdr *nlh;
 	struct sk_buff *skb;
-	unsigned int headlen;
 	int err;
 
-	headlen = sizeof(*p);
+	if (compat)
+		upi_size = sizeof(struct xfrm_userpolicy_info_packed);
+	else
+		upi_size = sizeof(struct xfrm_userpolicy_info);
+	headlen = upi_size;
+
 	if (c->event == XFRM_MSG_DELPOLICY) {
 		len += nla_total_size(headlen);
 		headlen = sizeof(*id);
@@ -3213,7 +3242,7 @@ static int xfrm_notify_policy(struct xfrm_policy *xp, int dir, const struct km_e
 	if (nlh == NULL)
 		goto out_free_skb;
 
-	p = nlmsg_data(nlh);
+	userpolicy_info = nlmsg_data(nlh);
 	if (c->event == XFRM_MSG_DELPOLICY) {
 		struct nlattr *attr;
 
@@ -3225,15 +3254,18 @@ static int xfrm_notify_policy(struct xfrm_policy *xp, int dir, const struct km_e
 		else
 			memcpy(&id->sel, &xp->selector, sizeof(id->sel));
 
-		attr = nla_reserve(skb, XFRMA_POLICY, sizeof(*p));
+		attr = nla_reserve(skb, XFRMA_POLICY, upi_size);
 		err = -EMSGSIZE;
 		if (attr == NULL)
 			goto out_free_skb;
 
-		p = nla_data(attr);
+		userpolicy_info = nla_data(attr);
 	}
 
-	copy_to_user_policy(xp, p, dir);
+	if (compat)
+		copy_to_user_policy_compat(xp, userpolicy_info, dir);
+	else
+		copy_to_user_policy(xp, userpolicy_info, dir);
 	err = copy_to_user_tmpl(xp, skb);
 	if (!err)
 		err = copy_to_user_policy_type(xp->type, skb);
@@ -3244,13 +3276,24 @@ static int xfrm_notify_policy(struct xfrm_policy *xp, int dir, const struct km_e
 
 	nlmsg_end(skb, nlh);
 
-	return xfrm_nlmsg_multicast(net, skb, 0, XFRMNLGRP_POLICY);
+	return xfrm_nlmsg_multicast(net, skb, 0, compat ?
+			XFRMNLGRP_COMPAT_POLICY : XFRMNLGRP_POLICY);
 
 out_free_skb:
 	kfree_skb(skb);
 	return err;
 }
 
+static int xfrm_notify_policy(struct xfrm_policy *xp, int dir,
+		const struct km_event *c)
+{
+	int ret = __xfrm_notify_policy(xp, dir, c, false);
+
+	if ((ret && ret != -ESRCH) || !IS_ENABLED(CONFIG_COMPAT))
+		return ret;
+	return __xfrm_notify_policy(xp, dir, c, true);
+}
+
 static int xfrm_notify_policy_flush(const struct km_event *c)
 {
 	struct net *net = c->net;
-- 
2.13.6

