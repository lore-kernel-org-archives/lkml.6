Return-Path: <SRS0=7Z+k=KK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6AF22C67790
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 02:32:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 19CB820891
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 02:32:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b="FTNsChMd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 19CB820891
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=arista.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730068AbeGZDrK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Jul 2018 23:47:10 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:37671 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729343AbeGZDqh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jul 2018 23:46:37 -0400
Received: by mail-ed1-f68.google.com with SMTP id b10-v6so337493eds.4
        for <linux-kernel@vger.kernel.org>; Wed, 25 Jul 2018 19:32:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=googlenew;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=KCeAxvHJEN7nZzQxXjsKSgSnkOfwm2ki5ucxqt54z5o=;
        b=FTNsChMd4KEpHIzR6Ju5p/AZXvQSqyIEAEiDSX2MfbBw40ZegsLxyRmQzMdLUintSW
         P4HbaYsgS+3NlY2utzRiKgKOq3tOyktorDqtTw+YRKoxy36AJcuIKjlrPk67Z3LQeI4d
         Qt4be+MSFnxBvAj88Lu/SvuRZx2+2sru/45RuLO/j/7Uz0VW0WWln5ETmXpD/9PsUc8E
         gD5V8gNSjiY8SpuhbX8uyLlD13Rv+Op22Vh802sXTxNlerh0XLEhwW7w3VPNIaPoxEJD
         kP1Yk1kQF4coHUjijRLfQP8KOcM6VzHfY8/nidvFegjS11sYBfiCJCOngUHG5G+PLRHz
         dW8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=KCeAxvHJEN7nZzQxXjsKSgSnkOfwm2ki5ucxqt54z5o=;
        b=nE9hwe3Hsl3z4lOg07Tjjajs3P95TzUrWp7eu7GgiK+8c0vqdqaOAtooMGdrKBmLh8
         vRYd15oxMA382C0e8BxxcGly45yngWdmwhFLZDLajBgxoHaGySrIFE0ci83U67BvcOUQ
         LR5V3cdA+pBmCrsdgdEwELfX/78ek6aRIvtSgalhxY/CrSuixP5391e9dmlHI7mYlcS8
         J7Ax+49otZyf81hSaq+dx1KJZRSw/vTKPw37km8zBBrS5zWyAytAqJIe0KU1kcl4y62W
         QDamaoiPP9Spml1C/rdWh3dJ+fpgEAslVAlNApxIh3ddQGdshBgoR+ILK0u41j+otuI1
         SFTQ==
X-Gm-Message-State: AOUpUlH8MxF/CKWAiSythURG7bp3A7ttG8VkZxIz1JRCeWrfEq4ETZzb
        8pZAGoRbYpWcSimk2QWUdwsxyGh08gg=
X-Google-Smtp-Source: AAOMgpdEtmEx68bzyJqIexxQ6PTGSYiW6yXpczIQkBRvjyaYSGHUYR/eAB2Fa9ptczAZwl/M/QM1IA==
X-Received: by 2002:a50:f297:: with SMTP id f23-v6mr539264edm.40.1532572322757;
        Wed, 25 Jul 2018 19:32:02 -0700 (PDT)
Received: from dhcp.ire.aristanetworks.com ([217.173.96.166])
        by smtp.gmail.com with ESMTPSA id x13-v6sm241024edx.17.2018.07.25.19.32.01
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 25 Jul 2018 19:32:02 -0700 (PDT)
From:   Dmitry Safonov <dima@arista.com>
To:     linux-kernel@vger.kernel.org
Cc:     Dmitry Safonov <dima@arista.com>,
        "David S. Miller" <davem@davemloft.net>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Steffen Klassert <steffen.klassert@secunet.com>,
        Dmitry Safonov <0x7f454c46@gmail.com>, netdev@vger.kernel.org
Subject: [PATCH 14/18] xfrm: Add compat support for xfrm_user_polexpire messages
Date:   Thu, 26 Jul 2018 03:31:40 +0100
Message-Id: <20180726023144.31066-15-dima@arista.com>
X-Mailer: git-send-email 2.13.6
In-Reply-To: <20180726023144.31066-1-dima@arista.com>
References: <20180726023144.31066-1-dima@arista.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Parse polexpire messages sent by userspace according to in_compat_syscall().
Applications that used native bind() syscall are in XFRMNLGRP_EXPIRE, so
send there xfrm_usersa_info messages (with 64-bit ABI). Compatible
applications are added to kernel-hidden XFRMNLGRP_COMPAT_EXPIRE group, so
send there xfrm_usersa_info messages_packed (with 32-bit ABI)

Cc: "David S. Miller" <davem@davemloft.net>
Cc: Herbert Xu <herbert@gondor.apana.org.au>
Cc: Steffen Klassert <steffen.klassert@secunet.com>
Cc: netdev@vger.kernel.org
Signed-off-by: Dmitry Safonov <dima@arista.com>
---
 net/xfrm/xfrm_user.c | 89 +++++++++++++++++++++++++++++++++++-----------------
 1 file changed, 61 insertions(+), 28 deletions(-)

diff --git a/net/xfrm/xfrm_user.c b/net/xfrm/xfrm_user.c
index 89f891a0a9a4..2fe6174b8a18 100644
--- a/net/xfrm/xfrm_user.c
+++ b/net/xfrm/xfrm_user.c
@@ -84,6 +84,12 @@ struct xfrm_user_acquire_packed {
 	__u32					seq;
 } __packed;
 
+struct xfrm_user_polexpire_packed {
+	struct xfrm_userpolicy_info_packed	pol;
+	__u8					hard;
+	__u8					__pad[3];
+} __packed;
+
 /* In-kernel, non-uapi compat groups.
  * As compat/native messages differ, send notifications according
  * to .bind() caller's ABI. There are *_COMPAT hidden from userspace
@@ -2225,7 +2231,15 @@ static int xfrm_add_pol_expire(struct sk_buff *skb, struct nlmsghdr *nlh,
 	int err = -ENOENT;
 	struct xfrm_mark m;
 	u32 mark = xfrm_mark_get(attrs, &m);
+	u8 hard;
 
+	if (in_compat_syscall()) {
+		struct xfrm_user_polexpire_packed *_up = nlmsg_data(nlh);
+
+		hard = _up->hard;
+	} else {
+		hard = up->hard;
+	}
 	err = copy_from_user_policy_type(&type, attrs);
 	if (err)
 		return err;
@@ -2263,11 +2277,11 @@ static int xfrm_add_pol_expire(struct sk_buff *skb, struct nlmsghdr *nlh,
 		goto out;
 
 	err = 0;
-	if (up->hard) {
+	if (hard) {
 		xfrm_policy_delete(xp, p->dir);
 		xfrm_audit_policy_delete(xp, 1, true);
 	}
-	km_policy_expired(xp, p->dir, up->hard, nlh->nlmsg_pid);
+	km_policy_expired(xp, p->dir, hard, nlh->nlmsg_pid);
 
 out:
 	xfrm_pol_put(xp);
@@ -3192,43 +3206,59 @@ static struct xfrm_policy *xfrm_compile_policy(struct sock *sk, int opt,
 	return xp;
 }
 
-static inline unsigned int xfrm_polexpire_msgsize(struct xfrm_policy *xp)
+static int build_polexpire(struct sk_buff **skb, struct xfrm_policy *xp,
+			   int dir, const struct km_event *c, bool compat)
 {
-	return NLMSG_ALIGN(sizeof(struct xfrm_user_polexpire))
+	struct xfrm_user_polexpire_packed *_upe;
+	struct xfrm_user_polexpire *upe;
+	unsigned int upe_size, polexpire_msgsize;
+	int hard = c->data.hard;
+	struct nlmsghdr *nlh;
+	int err;
+
+	if (compat)
+		upe_size = NLMSG_ALIGN(sizeof(struct xfrm_user_polexpire_packed));
+	else
+		upe_size = NLMSG_ALIGN(sizeof(struct xfrm_user_polexpire));
+	polexpire_msgsize = upe_size
 	       + nla_total_size(sizeof(struct xfrm_user_tmpl) * xp->xfrm_nr)
 	       + nla_total_size(xfrm_user_sec_ctx_size(xp->security))
 	       + nla_total_size(sizeof(struct xfrm_mark))
 	       + userpolicy_type_attrsize();
-}
 
-static int build_polexpire(struct sk_buff *skb, struct xfrm_policy *xp,
-			   int dir, const struct km_event *c)
-{
-	struct xfrm_user_polexpire *upe;
-	int hard = c->data.hard;
-	struct nlmsghdr *nlh;
-	int err;
+	*skb = nlmsg_new(polexpire_msgsize, GFP_ATOMIC);
+	if (*skb == NULL)
+		return -ENOMEM;
 
-	nlh = nlmsg_put(skb, c->portid, 0, XFRM_MSG_POLEXPIRE, sizeof(*upe), 0);
+	nlh = nlmsg_put(*skb, c->portid, 0, XFRM_MSG_POLEXPIRE, upe_size, 0);
 	if (nlh == NULL)
 		return -EMSGSIZE;
 
+	_upe = nlmsg_data(nlh);
 	upe = nlmsg_data(nlh);
-	copy_to_user_policy(xp, &upe->pol, dir);
-	err = copy_to_user_tmpl(xp, skb);
+	if (compat)
+		copy_to_user_policy_compat(xp, &_upe->pol, dir);
+	else
+		copy_to_user_policy(xp, &upe->pol, dir);
+
+	err = copy_to_user_tmpl(xp, *skb);
 	if (!err)
-		err = copy_to_user_sec_ctx(xp, skb);
+		err = copy_to_user_sec_ctx(xp, *skb);
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
-	upe->hard = !!hard;
 
-	nlmsg_end(skb, nlh);
+	if (compat)
+		_upe->hard = !!hard;
+	else
+		upe->hard = !!hard;
+
+	nlmsg_end(*skb, nlh);
 	return 0;
 }
 
@@ -3238,14 +3268,17 @@ static int xfrm_exp_policy_notify(struct xfrm_policy *xp, int dir, const struct
 	struct sk_buff *skb;
 	int err;
 
-	skb = nlmsg_new(xfrm_polexpire_msgsize(xp), GFP_ATOMIC);
-	if (skb == NULL)
-		return -ENOMEM;
-
-	err = build_polexpire(skb, xp, dir, c);
-	BUG_ON(err < 0);
+	err = build_polexpire(&skb, xp, dir, c, false);
+	if (err)
+		return err;
+	err = xfrm_nlmsg_multicast(net, skb, 0, XFRMNLGRP_EXPIRE);
+	if ((err && err != -ESRCH) || !IS_ENABLED(CONFIG_COMPAT))
+		return err;
 
-	return xfrm_nlmsg_multicast(net, skb, 0, XFRMNLGRP_EXPIRE);
+	err = build_polexpire(&skb, xp, dir, c, true);
+	if (err)
+		return err;
+	return xfrm_nlmsg_multicast(net, skb, 0, XFRMNLGRP_COMPAT_EXPIRE);
 }
 
 static int __xfrm_notify_policy(struct xfrm_policy *xp, int dir,
-- 
2.13.6

