Return-Path: <SRS0=7Z+k=KK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7B72C67790
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 02:33:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7FDB220891
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 02:33:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b="pB4lAQD8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7FDB220891
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=arista.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730247AbeGZDrz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Jul 2018 23:47:55 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:46485 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729073AbeGZDqc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jul 2018 23:46:32 -0400
Received: by mail-ed1-f68.google.com with SMTP id o8-v6so324079edt.13
        for <linux-kernel@vger.kernel.org>; Wed, 25 Jul 2018 19:31:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=googlenew;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=96codcclVJ7Yuq6KI06GJPty5De03p58ccgEKnN1XJ4=;
        b=pB4lAQD8JA52RQDlbyrz8G/lQpgXxOqiRByZKMh4bcudH47VT/QGXAIT19/EudhpfT
         gOIGxY6gvszT5pq+r8LsOH78/mv2c4uXHceMInMcixVajDSUkd4LUHVR+42DmyiqZlie
         +kLCeLd8Bw30aVJtDYrM5j6Qg9S2bmHN6L37PcS5+ck782wqJymFtoFPRVInw1qzwCl7
         vAWZ3jGactZhFAO0ugquyunEsTBsFh8mpGxJERwyu8L/fHd81ge76xR5ESw+9ikuAuFK
         bnJi694SmqJqiDCer/+OvpVRv6iZkMJFaWG0ulfKfTkZwhZLT7/ZENNa5Cpu0nNjQ2Oy
         hObg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=96codcclVJ7Yuq6KI06GJPty5De03p58ccgEKnN1XJ4=;
        b=BYCHaQ2MmQxZq7Mm0A9AraVqwJCy45HHHOVacDM8OfP9/BVgSxXtT7Po9QiY+pwMVH
         818EHyGHW8VUfMtf5D3KGKYvHUSXSvjEem4VhapPr97SBcJgfVv+rbuBPV1bmBZlSdVH
         E27CJInMAw2eFjrZZ1DDsIbV/TEcIVv4RXoNgmUfDEMjIyPxkFGjDQYYy5Z2qP7rrZMK
         9k0QBUWYmFB4aIN5cgIyHZX++FwbuowYoKxd2QZjU4UEdBrX4jehUbM9vyoaAE5UTlLm
         Fg2dog/uTmbHFV/ipuOsNCpzAlJ9qIirJKv5f037IOjyMBpqt3+QEMCg1Rcaszafkhnn
         lfrQ==
X-Gm-Message-State: AOUpUlEeQMEqdp2iDeybxCFkBuYdKdGGWnZI5PFoKFwLFMwM5x7sXewc
        461S4fJ88RoI6mszoXV6/VCwj6B9qYc=
X-Google-Smtp-Source: AAOMgpf7wx//fxDQb+4YI//gmBWpATU4VE6MZfgBy4fa5UlhK1Ymm2ZgSgU+2BBnzxFSDgfocdGRsw==
X-Received: by 2002:a50:a347:: with SMTP id 65-v6mr480252edn.299.1532572317784;
        Wed, 25 Jul 2018 19:31:57 -0700 (PDT)
Received: from dhcp.ire.aristanetworks.com ([217.173.96.166])
        by smtp.gmail.com with ESMTPSA id x13-v6sm241024edx.17.2018.07.25.19.31.56
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 25 Jul 2018 19:31:57 -0700 (PDT)
From:   Dmitry Safonov <dima@arista.com>
To:     linux-kernel@vger.kernel.org
Cc:     Dmitry Safonov <dima@arista.com>,
        "David S. Miller" <davem@davemloft.net>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Steffen Klassert <steffen.klassert@secunet.com>,
        Dmitry Safonov <0x7f454c46@gmail.com>, netdev@vger.kernel.org
Subject: [PATCH 10/18] xfrm: Send state notifications in compat format too
Date:   Thu, 26 Jul 2018 03:31:36 +0100
Message-Id: <20180726023144.31066-11-dima@arista.com>
X-Mailer: git-send-email 2.13.6
In-Reply-To: <20180726023144.31066-1-dima@arista.com>
References: <20180726023144.31066-1-dima@arista.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Applications that used native bind() syscall are in XFRMNLGRP_SA, so
send there xfrm_usersa_info messages (with 64-bit ABI). Compatible
applications are added to kernel-hidden XFRMNLGRP_COMPAT_SA group, so
send there xfrm_usersa_info messages_packed (with 32-bit ABI)

Cc: "David S. Miller" <davem@davemloft.net>
Cc: Herbert Xu <herbert@gondor.apana.org.au>
Cc: Steffen Klassert <steffen.klassert@secunet.com>
Cc: netdev@vger.kernel.org
Signed-off-by: Dmitry Safonov <dima@arista.com>
---
 net/xfrm/xfrm_user.c | 38 +++++++++++++++++++++++++++++---------
 1 file changed, 29 insertions(+), 9 deletions(-)

diff --git a/net/xfrm/xfrm_user.c b/net/xfrm/xfrm_user.c
index 63622264a3a9..230462077dc9 100644
--- a/net/xfrm/xfrm_user.c
+++ b/net/xfrm/xfrm_user.c
@@ -2856,18 +2856,24 @@ static inline unsigned int xfrm_sa_len(struct xfrm_state *x)
 	return l;
 }
 
-static int xfrm_notify_sa(struct xfrm_state *x, const struct km_event *c)
+static int __xfrm_notify_sa(struct xfrm_state *x,
+		const struct km_event *c, bool compat)
 {
 	struct net *net = xs_net(x);
-	struct xfrm_usersa_info *p;
 	struct xfrm_usersa_id *id;
 	struct nlmsghdr *nlh;
 	struct sk_buff *skb;
 	unsigned int len = xfrm_sa_len(x);
-	unsigned int headlen;
+	unsigned int headlen, usersa_info_size;
+	void *usersa_info;
 	int err;
 
-	headlen = sizeof(*p);
+	if (compat)
+		usersa_info_size = sizeof(struct xfrm_usersa_info_packed);
+	else
+		usersa_info_size = sizeof(struct xfrm_usersa_info);
+	headlen = usersa_info_size;
+
 	if (c->event == XFRM_MSG_DELSA) {
 		len += nla_total_size(headlen);
 		headlen = sizeof(*id);
@@ -2884,7 +2890,7 @@ static int xfrm_notify_sa(struct xfrm_state *x, const struct km_event *c)
 	if (nlh == NULL)
 		goto out_free_skb;
 
-	p = nlmsg_data(nlh);
+	usersa_info = nlmsg_data(nlh);
 	if (c->event == XFRM_MSG_DELSA) {
 		struct nlattr *attr;
 
@@ -2895,26 +2901,40 @@ static int xfrm_notify_sa(struct xfrm_state *x, const struct km_event *c)
 		id->family = x->props.family;
 		id->proto = x->id.proto;
 
-		attr = nla_reserve(skb, XFRMA_SA, sizeof(*p));
+		attr = nla_reserve(skb, XFRMA_SA, usersa_info_size);
 		err = -EMSGSIZE;
 		if (attr == NULL)
 			goto out_free_skb;
 
-		p = nla_data(attr);
+		usersa_info = nla_data(attr);
 	}
-	err = copy_to_user_state_extra(x, p, skb);
+
+	if (compat)
+		err = copy_to_user_state_extra(x, usersa_info, skb);
+	else
+		err = copy_to_user_state_extra_compat(x, usersa_info, skb);
 	if (err)
 		goto out_free_skb;
 
 	nlmsg_end(skb, nlh);
 
-	return xfrm_nlmsg_multicast(net, skb, 0, XFRMNLGRP_SA);
+	return xfrm_nlmsg_multicast(net, skb, 0,
+			compat ? XFRMNLGRP_COMPAT_SA : XFRMNLGRP_SA);
 
 out_free_skb:
 	kfree_skb(skb);
 	return err;
 }
 
+static int xfrm_notify_sa(struct xfrm_state *x, const struct km_event *c)
+{
+	int ret = __xfrm_notify_sa(x, c, false);
+
+	if ((ret && ret != -ESRCH) || !IS_ENABLED(CONFIG_COMPAT))
+		return ret;
+	return __xfrm_notify_sa(x, c, true);
+}
+
 static int xfrm_send_state_notify(struct xfrm_state *x, const struct km_event *c)
 {
 
-- 
2.13.6

