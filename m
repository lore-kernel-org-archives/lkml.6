Return-Path: <SRS0=7Z+k=KK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2D2BC6778F
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 02:32:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5096B208AD
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 02:32:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b="OtPrFabd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5096B208AD
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=arista.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729378AbeGZDqg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Jul 2018 23:46:36 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:43894 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729204AbeGZDqf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jul 2018 23:46:35 -0400
Received: by mail-ed1-f65.google.com with SMTP id b20-v6so326984edt.10
        for <linux-kernel@vger.kernel.org>; Wed, 25 Jul 2018 19:32:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=googlenew;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Q3uCbXfAPqyJnjkMv2GwF4Igrxwx6DSnJmHdsK7W6YI=;
        b=OtPrFabdEaXGRpoZgDSO3ywHRPcWXjyRJYwyhLW5HDljQnS7IgesMNHWsmZUAi+AFl
         C9FZARVN7yha3LcBkWQ5qF3CWbAjWn6zVR7/h89x6iTP51NBO3PDy7kgKbgCe6Kae1bD
         jN+fb4SGeerIdTChyzx62MBuJPA/xzUDBJMY6vs+X70BVScr83ADiwGbycKwSRF4jSai
         vYsxlDbdS1uOsCu+Ai6D+iepTrLZyNf2E9ZYlqvCs/7laNHf+c53s+KtD4gP/hm54ghV
         POhypYxXRkFv7b98eL5TnaCHl1VOWcGXNchNsXf8ZRqoxt4fldxCoDlxQeyQk3mVwQ8+
         uM9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Q3uCbXfAPqyJnjkMv2GwF4Igrxwx6DSnJmHdsK7W6YI=;
        b=MWVuQ1CgsmFWKfPVIJXK9kgbE29NxhNXtCYIxcqtZtYA2AwU+WVWyp6XurFgGv9S/a
         Ey2toJd/4/zqpkkcvBj+IkbCSbJVDJclB8fRXOeXR4NAWGqemEwp5mtUSu++TOjJCTwO
         4D0UwCs628RY7W1bWog7WNOgPE3Vz58KToXe/7cMni25p0SM2srfC5R4CLJHMSCvMHTi
         MPESWsYgoPDNUID0/6vE/n3YMYC644uCeXZSRh8x8mwJfdrpeE1arH/vnDExdL4bXDnm
         DhYjGhXrZTsxzOjjQ7A4SkUz7l09CMhrsftkxnic8TqJjhvE94Qf3nytu2m0Z3XpCb/6
         s4Mw==
X-Gm-Message-State: AOUpUlHwYKjwS2Yh1pRFNlnZKsWgCD1tSTmuyX0Fu/AYMQxzmil02ZJT
        LsvZTU4EkoPpdu9oR2MW3ISKKL3HsZM=
X-Google-Smtp-Source: AAOMgpcAInUKbv+eZPgrG/WA/bmS/BLxTtm4rvM3QsIXdjuGBslL1+q59gtkIDtr/AeMvMGChu9fVg==
X-Received: by 2002:a50:83e6:: with SMTP id 93-v6mr483167edi.164.1532572321020;
        Wed, 25 Jul 2018 19:32:01 -0700 (PDT)
Received: from dhcp.ire.aristanetworks.com ([217.173.96.166])
        by smtp.gmail.com with ESMTPSA id x13-v6sm241024edx.17.2018.07.25.19.31.59
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 25 Jul 2018 19:32:00 -0700 (PDT)
From:   Dmitry Safonov <dima@arista.com>
To:     linux-kernel@vger.kernel.org
Cc:     Dmitry Safonov <dima@arista.com>,
        "David S. Miller" <davem@davemloft.net>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Steffen Klassert <steffen.klassert@secunet.com>,
        Dmitry Safonov <0x7f454c46@gmail.com>, netdev@vger.kernel.org
Subject: [PATCH 13/18] xfrm: Add compat support for xfrm_user_acquire messages
Date:   Thu, 26 Jul 2018 03:31:39 +0100
Message-Id: <20180726023144.31066-14-dima@arista.com>
X-Mailer: git-send-email 2.13.6
In-Reply-To: <20180726023144.31066-1-dima@arista.com>
References: <20180726023144.31066-1-dima@arista.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Parse acquire messages sent by userspace according to in_compat_syscall().
Applications that used native bind() syscall are in XFRMNLGRP_ACQUIRE, so
send there xfrm_usersa_info messages (with 64-bit ABI). Compatible
applications are added to kernel-hidden XFRMNLGRP_COMPAT_ACQUIRE group, so
send there xfrm_usersa_info messages_packed (with 32-bit ABI)

Cc: "David S. Miller" <davem@davemloft.net>
Cc: Herbert Xu <herbert@gondor.apana.org.au>
Cc: Steffen Klassert <steffen.klassert@secunet.com>
Cc: netdev@vger.kernel.org
Signed-off-by: Dmitry Safonov <dima@arista.com>
---
 net/xfrm/xfrm_user.c | 113 +++++++++++++++++++++++++++++++++++----------------
 1 file changed, 77 insertions(+), 36 deletions(-)

diff --git a/net/xfrm/xfrm_user.c b/net/xfrm/xfrm_user.c
index df792a3be8f2..89f891a0a9a4 100644
--- a/net/xfrm/xfrm_user.c
+++ b/net/xfrm/xfrm_user.c
@@ -73,6 +73,17 @@ struct xfrm_user_expire_packed {
 	__u8				__pad[3];
 } __packed;
 
+struct xfrm_user_acquire_packed {
+	struct xfrm_id				id;
+	xfrm_address_t				saddr;
+	struct xfrm_selector			sel;
+	struct xfrm_userpolicy_info_packed	policy;
+	__u32					aalgos;
+	__u32					ealgos;
+	__u32					calgos;
+	__u32					seq;
+} __packed;
+
 /* In-kernel, non-uapi compat groups.
  * As compat/native messages differ, send notifications according
  * to .bind() caller's ABI. There are *_COMPAT hidden from userspace
@@ -2316,8 +2327,8 @@ static int xfrm_add_acquire(struct sk_buff *skb, struct nlmsghdr *nlh,
 	struct nlattr *rt = attrs[XFRMA_TMPL];
 	struct xfrm_mark mark;
 
-	struct xfrm_user_acquire *ua = nlmsg_data(nlh);
-	struct xfrm_userpolicy_info_packed *upi = (void *)&ua->policy;
+	struct xfrm_user_acquire_packed *ua = nlmsg_data(nlh);
+	struct xfrm_user_acquire *_ua = nlmsg_data(nlh);
 	struct xfrm_state *x = xfrm_state_alloc(net);
 	int err = -ENOMEM;
 
@@ -2326,12 +2337,12 @@ static int xfrm_add_acquire(struct sk_buff *skb, struct nlmsghdr *nlh,
 
 	xfrm_mark_get(attrs, &mark);
 
-	err = verify_newpolicy_info(upi);
+	err = verify_newpolicy_info(&ua->policy);
 	if (err)
 		goto free_state;
 
 	/*   build an XP */
-	xp = xfrm_policy_construct(net, upi, attrs, &err);
+	xp = xfrm_policy_construct(net, &ua->policy, attrs, &err);
 	if (!xp)
 		goto free_state;
 
@@ -2348,9 +2359,15 @@ static int xfrm_add_acquire(struct sk_buff *skb, struct nlmsghdr *nlh,
 		x->props.mode = t->mode;
 		x->props.reqid = t->reqid;
 		x->props.family = ut->family;
-		t->aalgos = ua->aalgos;
-		t->ealgos = ua->ealgos;
-		t->calgos = ua->calgos;
+		if (in_compat_syscall()) {
+			t->aalgos = ua->aalgos;
+			t->ealgos = ua->ealgos;
+			t->calgos = ua->calgos;
+		} else {
+			t->aalgos = _ua->aalgos;
+			t->ealgos = _ua->ealgos;
+			t->calgos = _ua->calgos;
+		}
 		err = km_query(x, t, xp);
 
 	}
@@ -3017,25 +3034,32 @@ static int xfrm_send_state_notify(struct xfrm_state *x, const struct km_event *c
 
 }
 
-static inline unsigned int xfrm_acquire_msgsize(struct xfrm_state *x,
-						struct xfrm_policy *xp)
+static int build_acquire(struct sk_buff **skb, struct xfrm_state *x,
+			 struct xfrm_tmpl *xt, struct xfrm_policy *xp,
+			 bool compat)
 {
-	return NLMSG_ALIGN(sizeof(struct xfrm_user_acquire))
+	__u32 seq = xfrm_get_acqseq();
+	struct xfrm_user_acquire_packed *ua;
+	struct nlmsghdr *nlh;
+	unsigned int ua_size, ack_msgsize;
+	int err;
+
+	if (compat)
+		ua_size = NLMSG_ALIGN(sizeof(struct xfrm_user_acquire_packed));
+	else
+		ua_size = NLMSG_ALIGN(sizeof(struct xfrm_user_acquire));
+
+	ack_msgsize = ua_size
 	       + nla_total_size(sizeof(struct xfrm_user_tmpl) * xp->xfrm_nr)
 	       + nla_total_size(sizeof(struct xfrm_mark))
 	       + nla_total_size(xfrm_user_sec_ctx_size(x->security))
 	       + userpolicy_type_attrsize();
-}
 
-static int build_acquire(struct sk_buff *skb, struct xfrm_state *x,
-			 struct xfrm_tmpl *xt, struct xfrm_policy *xp)
-{
-	__u32 seq = xfrm_get_acqseq();
-	struct xfrm_user_acquire *ua;
-	struct nlmsghdr *nlh;
-	int err;
+	*skb = nlmsg_new(ack_msgsize, GFP_ATOMIC);
+	if (*skb == NULL)
+		return -ENOMEM;
 
-	nlh = nlmsg_put(skb, 0, 0, XFRM_MSG_ACQUIRE, sizeof(*ua), 0);
+	nlh = nlmsg_put(*skb, 0, 0, XFRM_MSG_ACQUIRE, ua_size, 0);
 	if (nlh == NULL)
 		return -EMSGSIZE;
 
@@ -3043,25 +3067,36 @@ static int build_acquire(struct sk_buff *skb, struct xfrm_state *x,
 	memcpy(&ua->id, &x->id, sizeof(ua->id));
 	memcpy(&ua->saddr, &x->props.saddr, sizeof(ua->saddr));
 	memcpy(&ua->sel, &x->sel, sizeof(ua->sel));
-	copy_to_user_policy(xp, &ua->policy, XFRM_POLICY_OUT);
-	ua->aalgos = xt->aalgos;
-	ua->ealgos = xt->ealgos;
-	ua->calgos = xt->calgos;
-	ua->seq = x->km.seq = seq;
 
-	err = copy_to_user_tmpl(xp, skb);
+	if (compat) {
+		copy_to_user_policy_compat(xp, &ua->policy, XFRM_POLICY_OUT);
+		ua->aalgos = xt->aalgos;
+		ua->ealgos = xt->ealgos;
+		ua->calgos = xt->calgos;
+		ua->seq = x->km.seq = seq;
+	} else {
+		struct xfrm_user_acquire *_ua = nlmsg_data(nlh);
+
+		copy_to_user_policy(xp, &_ua->policy, XFRM_POLICY_OUT);
+		_ua->aalgos = xt->aalgos;
+		_ua->ealgos = xt->ealgos;
+		_ua->calgos = xt->calgos;
+		_ua->seq = x->km.seq = seq;
+	}
+
+	err = copy_to_user_tmpl(xp, *skb);
 	if (!err)
-		err = copy_to_user_state_sec_ctx(x, skb);
+		err = copy_to_user_state_sec_ctx(x, *skb);
 	if (!err)
-		err = copy_to_user_policy_type(xp->type, skb);
+		err = copy_to_user_policy_type(xp->type, *skb);
 	if (!err)
-		err = xfrm_mark_put(skb, &xp->mark);
+		err = xfrm_mark_put(*skb, &xp->mark);
 	if (err) {
-		nlmsg_cancel(skb, nlh);
+		nlmsg_cancel(*skb, nlh);
 		return err;
 	}
 
-	nlmsg_end(skb, nlh);
+	nlmsg_end(*skb, nlh);
 	return 0;
 }
 
@@ -3072,14 +3107,20 @@ static int xfrm_send_acquire(struct xfrm_state *x, struct xfrm_tmpl *xt,
 	struct sk_buff *skb;
 	int err;
 
-	skb = nlmsg_new(xfrm_acquire_msgsize(x, xp), GFP_ATOMIC);
-	if (skb == NULL)
-		return -ENOMEM;
 
-	err = build_acquire(skb, x, xt, xp);
-	BUG_ON(err < 0);
+	err = build_acquire(&skb, x, xt, xp, false);
+	if (err)
+		return err;
+
+	err = xfrm_nlmsg_multicast(net, skb, 0, XFRMNLGRP_ACQUIRE);
+	if ((err && err != -ESRCH) || !IS_ENABLED(CONFIG_COMPAT))
+		return err;
+
+	err = build_acquire(&skb, x, xt, xp, true);
+	if (err)
+		return err;
 
-	return xfrm_nlmsg_multicast(net, skb, 0, XFRMNLGRP_ACQUIRE);
+	return xfrm_nlmsg_multicast(net, skb, 0, XFRMNLGRP_COMPAT_ACQUIRE);
 }
 
 /* User gives us xfrm_user_policy_info followed by an array of 0
-- 
2.13.6

