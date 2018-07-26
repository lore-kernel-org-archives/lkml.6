Return-Path: <SRS0=7Z+k=KK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54A7EC67790
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 02:31:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 09DDC2089C
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 02:31:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b="IuPx6A02"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 09DDC2089C
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=arista.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729006AbeGZDq0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Jul 2018 23:46:26 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:35750 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728943AbeGZDq0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jul 2018 23:46:26 -0400
Received: by mail-ed1-f65.google.com with SMTP id e6-v6so339136edr.2
        for <linux-kernel@vger.kernel.org>; Wed, 25 Jul 2018 19:31:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=googlenew;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=WrWPl2mTO+56b2/UhuUMjOwjpqXivoIYoVCVMWPbaM4=;
        b=IuPx6A024eMYwdx18ky8XyWY4ojmsocSWus3vm4VwqJx+5/mbnzFT2PTZlAgXly/SD
         nsfn5vmb/3v473ke5qK5Jnl1FtMB1LMn5Bg6bAuepZvZgP3rWQoCPIAVqtq4AlF0K3SO
         xX8LSoUIB7nS9QfDBSwB1gwUp/O74djCRXTDD258wRb/a9Mnyb1ukOSnZ/m4XVTn7BtQ
         N6r9RBXBXCsASyBHpS0+58aCnqtOgKdWe4cfh7qQ8/NTb8p3Hu16g/2UpcYCxcA4eDT4
         gIxmepdlHgkthhA0QRnG/xTu6HLiSJcC1Lgg8dZRAsCiaAxVOlsg1L7IZ1BDuo+ToRpm
         4Hkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=WrWPl2mTO+56b2/UhuUMjOwjpqXivoIYoVCVMWPbaM4=;
        b=JJvEoQ3+uLb3IeVpM1dLXnQ1Qg2zxhPOAV1NmAMOI9oo2sgy57hfgxB8mfj/3Q4P5x
         liwAJZmnYovqMaYkl+V1Q7J+R6Z7J58bKUQEU3VoKa2sfKf/mtIAPKg1j/AQyGilFHMP
         gx0oqUDCL7xfSf74KH2UtUGtC8oyoBWAMqt4W2QrHtOHzVwFejVLFVyzmTl83p3XGSaU
         i2NfbN+k/cD8ZLwAzjNfrZ35GDSfDAHxDG7JpBTzZEWaohOS7TR4dbg1Fabi/KWDvFa6
         gTJ9lCEIQnfyMkQulscSWN9mZOKHYMNItg0T27Ag0EwFjTa7VYhc0QVBSIMZGqow4Q/j
         2fgw==
X-Gm-Message-State: AOUpUlGtbmkq1zI5MqVyX8z4ksIF015SxKGx7ddXe0XqQaJpuZMEiF+A
        aU4pNf3lmAA7sRS+XTaQ0t7C/GAeHlI=
X-Google-Smtp-Source: AAOMgpfr/dNIVigHNJWGvhBsrd1Gt1SOwFxJkoUF4gwyfJmpnURx5wj/ZeaXF7FArtgltr5SUTj3qg==
X-Received: by 2002:a50:92c5:: with SMTP id l5-v6mr511429eda.52.1532572311104;
        Wed, 25 Jul 2018 19:31:51 -0700 (PDT)
Received: from dhcp.ire.aristanetworks.com ([217.173.96.166])
        by smtp.gmail.com with ESMTPSA id x13-v6sm241024edx.17.2018.07.25.19.31.50
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 25 Jul 2018 19:31:50 -0700 (PDT)
From:   Dmitry Safonov <dima@arista.com>
To:     linux-kernel@vger.kernel.org
Cc:     Dmitry Safonov <dima@arista.com>,
        "David S. Miller" <davem@davemloft.net>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Steffen Klassert <steffen.klassert@secunet.com>,
        Dmitry Safonov <0x7f454c46@gmail.com>, netdev@vger.kernel.org
Subject: [PATCH 04/18] net/xfrm: Add _packed types for compat users
Date:   Thu, 26 Jul 2018 03:31:30 +0100
Message-Id: <20180726023144.31066-5-dima@arista.com>
X-Mailer: git-send-email 2.13.6
In-Reply-To: <20180726023144.31066-1-dima@arista.com>
References: <20180726023144.31066-1-dima@arista.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

xfrm_usersa_info and xfrm_userpolicy_info structures differ in size
between 64-bit and 32-bit ABI. In 64-bit ABI there is additional
4-byte padding in the end of the structure:

32-bit:
sizeof(xfrm_usersa_info)	= 220
sizeof(xfrm_userpolicy_info)	= 164
64-bit:
sizeof(xfrm_usersa_info)	= 224
sizeof(xfrm_userpolicy_info)	= 168

In preparation to add compat support to xfrm it's needed to add _packed
verstion for those types.

Parse xfrm_usersa_info and xfrm_userpolicy_info netlink messages
sent by userspace using _packed structures (as we don't care about
parsing padding).
Sending _packed notification messages back to userspace will be done
with following patches (in copy_to_user_state() and
copy_to_user_policy()).

Cc: "David S. Miller" <davem@davemloft.net>
Cc: Herbert Xu <herbert@gondor.apana.org.au>
Cc: Steffen Klassert <steffen.klassert@secunet.com>
Cc: netdev@vger.kernel.org
Signed-off-by: Dmitry Safonov <dima@arista.com>
---
 net/xfrm/xfrm_user.c | 89 ++++++++++++++++++++++++++++++++++++++--------------
 1 file changed, 65 insertions(+), 24 deletions(-)

diff --git a/net/xfrm/xfrm_user.c b/net/xfrm/xfrm_user.c
index 2677cb55b7a8..b382cdd3bef6 100644
--- a/net/xfrm/xfrm_user.c
+++ b/net/xfrm/xfrm_user.c
@@ -33,6 +33,34 @@
 #endif
 #include <asm/unaligned.h>
 
+struct xfrm_usersa_info_packed {
+	struct xfrm_selector		sel;
+	struct xfrm_id			id;
+	xfrm_address_t			saddr;
+	struct xfrm_lifetime_cfg	lft;
+	struct xfrm_lifetime_cur	curlft;
+	struct xfrm_stats		stats;
+	__u32				seq;
+	__u32				reqid;
+	__u16				family;
+	__u8				mode;		/* XFRM_MODE_xxx */
+	__u8				replay_window;
+	__u8				flags;
+	__u8				__pad[3];
+} __packed;
+
+struct xfrm_userpolicy_info_packed {
+	struct xfrm_selector		sel;
+	struct xfrm_lifetime_cfg	lft;
+	struct xfrm_lifetime_cur	curlft;
+	__u32				priority;
+	__u32				index;
+	__u8				dir;
+	__u8				action;
+	__u8				flags;
+	__u8				share;
+} __packed;
+
 static int verify_one_alg(struct nlattr **attrs, enum xfrm_attr_type_t type)
 {
 	struct nlattr *rt = attrs[type];
@@ -115,7 +143,7 @@ static inline int verify_sec_ctx_len(struct nlattr **attrs)
 	return 0;
 }
 
-static inline int verify_replay(struct xfrm_usersa_info *p,
+static inline int verify_replay(struct xfrm_usersa_info_packed *p,
 				struct nlattr **attrs)
 {
 	struct nlattr *rt = attrs[XFRMA_REPLAY_ESN_VAL];
@@ -143,7 +171,7 @@ static inline int verify_replay(struct xfrm_usersa_info *p,
 	return 0;
 }
 
-static int verify_newsa_info(struct xfrm_usersa_info *p,
+static int verify_newsa_info(struct xfrm_usersa_info_packed *p,
 			     struct nlattr **attrs)
 {
 	int err;
@@ -464,7 +492,8 @@ static inline unsigned int xfrm_user_sec_ctx_size(struct xfrm_sec_ctx *xfrm_ctx)
 	return len;
 }
 
-static void copy_from_user_state(struct xfrm_state *x, struct xfrm_usersa_info *p)
+static void copy_from_user_state(struct xfrm_state *x,
+				 struct xfrm_usersa_info_packed *p)
 {
 	memcpy(&x->id, &p->id, sizeof(x->id));
 	memcpy(&x->sel, &p->sel, sizeof(x->sel));
@@ -528,9 +557,8 @@ static void xfrm_update_ae_params(struct xfrm_state *x, struct nlattr **attrs,
 }
 
 static struct xfrm_state *xfrm_state_construct(struct net *net,
-					       struct xfrm_usersa_info *p,
-					       struct nlattr **attrs,
-					       int *errp)
+	       struct xfrm_usersa_info_packed *p,
+	       struct nlattr **attrs, int *errp)
 {
 	struct xfrm_state *x = xfrm_state_alloc(net);
 	int err = -ENOMEM;
@@ -630,7 +658,7 @@ static int xfrm_add_sa(struct sk_buff *skb, struct nlmsghdr *nlh,
 		struct nlattr **attrs)
 {
 	struct net *net = sock_net(skb->sk);
-	struct xfrm_usersa_info *p = nlmsg_data(nlh);
+	struct xfrm_usersa_info_packed *p = nlmsg_data(nlh);
 	struct xfrm_state *x;
 	int err;
 	struct km_event c;
@@ -1331,7 +1359,7 @@ static int verify_policy_type(u8 type)
 	return 0;
 }
 
-static int verify_newpolicy_info(struct xfrm_userpolicy_info *p)
+static int verify_newpolicy_info(struct xfrm_userpolicy_info_packed *p)
 {
 	int ret;
 
@@ -1513,7 +1541,8 @@ static int copy_from_user_policy_type(u8 *tp, struct nlattr **attrs)
 	return 0;
 }
 
-static void copy_from_user_policy(struct xfrm_policy *xp, struct xfrm_userpolicy_info *p)
+static void copy_from_user_policy(struct xfrm_policy *xp,
+		struct xfrm_userpolicy_info_packed *p)
 {
 	xp->priority = p->priority;
 	xp->index = p->index;
@@ -1540,7 +1569,9 @@ static void copy_to_user_policy(struct xfrm_policy *xp, struct xfrm_userpolicy_i
 	p->share = XFRM_SHARE_ANY; /* XXX xp->share */
 }
 
-static struct xfrm_policy *xfrm_policy_construct(struct net *net, struct xfrm_userpolicy_info *p, struct nlattr **attrs, int *errp)
+static struct xfrm_policy *xfrm_policy_construct(struct net *net,
+		struct xfrm_userpolicy_info_packed *p,
+		struct nlattr **attrs, int *errp)
 {
 	struct xfrm_policy *xp = xfrm_policy_alloc(net, GFP_KERNEL);
 	int err;
@@ -1575,7 +1606,7 @@ static int xfrm_add_policy(struct sk_buff *skb, struct nlmsghdr *nlh,
 		struct nlattr **attrs)
 {
 	struct net *net = sock_net(skb->sk);
-	struct xfrm_userpolicy_info *p = nlmsg_data(nlh);
+	struct xfrm_userpolicy_info_packed *p = nlmsg_data(nlh);
 	struct xfrm_policy *xp;
 	struct km_event c;
 	int err;
@@ -2079,7 +2110,7 @@ static int xfrm_add_pol_expire(struct sk_buff *skb, struct nlmsghdr *nlh,
 	struct net *net = sock_net(skb->sk);
 	struct xfrm_policy *xp;
 	struct xfrm_user_polexpire *up = nlmsg_data(nlh);
-	struct xfrm_userpolicy_info *p = &up->pol;
+	struct xfrm_userpolicy_info_packed *p = (void *)&up->pol;
 	u8 type = XFRM_POLICY_TYPE_MAIN;
 	int err = -ENOENT;
 	struct xfrm_mark m;
@@ -2140,7 +2171,7 @@ static int xfrm_add_sa_expire(struct sk_buff *skb, struct nlmsghdr *nlh,
 	struct xfrm_state *x;
 	int err;
 	struct xfrm_user_expire *ue = nlmsg_data(nlh);
-	struct xfrm_usersa_info *p = &ue->state;
+	struct xfrm_usersa_info_packed *p = (struct xfrm_usersa_info_packed *)&ue->state;
 	struct xfrm_mark m;
 	u32 mark = xfrm_mark_get(attrs, &m);
 
@@ -2178,6 +2209,7 @@ static int xfrm_add_acquire(struct sk_buff *skb, struct nlmsghdr *nlh,
 	struct xfrm_mark mark;
 
 	struct xfrm_user_acquire *ua = nlmsg_data(nlh);
+	struct xfrm_userpolicy_info_packed *upi = (void *)&ua->policy;
 	struct xfrm_state *x = xfrm_state_alloc(net);
 	int err = -ENOMEM;
 
@@ -2186,12 +2218,12 @@ static int xfrm_add_acquire(struct sk_buff *skb, struct nlmsghdr *nlh,
 
 	xfrm_mark_get(attrs, &mark);
 
-	err = verify_newpolicy_info(&ua->policy);
+	err = verify_newpolicy_info(upi);
 	if (err)
 		goto free_state;
 
 	/*   build an XP */
-	xp = xfrm_policy_construct(net, &ua->policy, attrs, &err);
+	xp = xfrm_policy_construct(net, upi, attrs, &err);
 	if (!xp)
 		goto free_state;
 
@@ -2881,11 +2913,21 @@ static struct xfrm_policy *xfrm_compile_policy(struct sock *sk, int opt,
 					       u8 *data, int len, int *dir)
 {
 	struct net *net = sock_net(sk);
-	struct xfrm_userpolicy_info *p = (struct xfrm_userpolicy_info *)data;
-	struct xfrm_user_tmpl *ut = (struct xfrm_user_tmpl *) (p + 1);
+	struct xfrm_userpolicy_info *upi = (void *)data;
+	struct xfrm_userpolicy_info_packed *_upi = (void *)data;
+	size_t policy_size;
+	struct xfrm_user_tmpl *ut;
 	struct xfrm_policy *xp;
 	int nr;
 
+	if (in_compat_syscall()) {
+		ut = (struct xfrm_user_tmpl *)(_upi + 1);
+		policy_size = sizeof(*_upi);
+	} else {
+		ut = (struct xfrm_user_tmpl *)(upi + 1);
+		policy_size = sizeof(*upi);
+	}
+
 	switch (sk->sk_family) {
 	case AF_INET:
 		if (opt != IP_XFRM_POLICY) {
@@ -2908,15 +2950,14 @@ static struct xfrm_policy *xfrm_compile_policy(struct sock *sk, int opt,
 
 	*dir = -EINVAL;
 
-	if (len < sizeof(*p) ||
-	    verify_newpolicy_info(p))
+	if (len < policy_size || verify_newpolicy_info(_upi))
 		return NULL;
 
-	nr = ((len - sizeof(*p)) / sizeof(*ut));
-	if (validate_tmpl(nr, ut, p->sel.family))
+	nr = ((len - policy_size) / sizeof(*ut));
+	if (validate_tmpl(nr, ut, _upi->sel.family))
 		return NULL;
 
-	if (p->dir > XFRM_POLICY_OUT)
+	if (_upi->dir > XFRM_POLICY_OUT)
 		return NULL;
 
 	xp = xfrm_policy_alloc(net, GFP_ATOMIC);
@@ -2925,11 +2966,11 @@ static struct xfrm_policy *xfrm_compile_policy(struct sock *sk, int opt,
 		return NULL;
 	}
 
-	copy_from_user_policy(xp, p);
+	copy_from_user_policy(xp, _upi);
 	xp->type = XFRM_POLICY_TYPE_MAIN;
 	copy_templates(xp, ut, nr);
 
-	*dir = p->dir;
+	*dir = _upi->dir;
 
 	return xp;
 }
-- 
2.13.6

