Return-Path: <SRS0=7Z+k=KK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5757C67790
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 02:32:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6470320671
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 02:32:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b="YlFdrRZv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6470320671
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=arista.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729852AbeGZDqt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Jul 2018 23:46:49 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:35767 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729517AbeGZDql (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jul 2018 23:46:41 -0400
Received: by mail-ed1-f66.google.com with SMTP id e6-v6so339441edr.2
        for <linux-kernel@vger.kernel.org>; Wed, 25 Jul 2018 19:32:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=googlenew;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=UpUTx8N+Vm2EmfbX6c3Ult+ekG63+WTb/ebxMdJKa1I=;
        b=YlFdrRZvNGzbYYLZ+TcwKA16OOTlcVgHFy0KYodMj9dm/woiUZt6DaZk2q3S2D/JVL
         6TldqqsEEAETHXz8geb0GodPVHZHvifvQn87adR0Xqk2CydaGFFdSbgIIQAjkn5HziUm
         A2a6HKhdRDA7S47sCpXKmCD6mtIreNLMEVB7n5bQfS0gefCpDqy3nqJ7tkJpR2o43Qym
         QhaJu0n4khKEsBhZNPoeEIB9W+OZnn5xduAzbbc9yIL07b3QAQIgEjitu6SZewVa+flU
         H3ozBqm2HWZAVqjjCinMv+R0Ne4Ifg8ZaKZf18E3C6ifNU9Jx/e0YrTadX/ayVxF+fFw
         2d4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=UpUTx8N+Vm2EmfbX6c3Ult+ekG63+WTb/ebxMdJKa1I=;
        b=VPBxj/pPtxurxHdu9FNP0U5QECrk1lHfGrMn0702CLEZmjadLYx9kKfye7SwjQxUog
         zQ9L4aFxT5E8cw11/uVR2l84zCeP++n1I68HjnR91a4hsg+KmcAAf1EPNN27GhDbbUDU
         NG/pzi2k6jdWj/GVo8uu71OLiN9btAGOJrhF3me3GVhdx+sDnyWns5IrZ39vNgJeKHJS
         NAqiSyXiu/lgNgwZq6032u2OybElvO72bJjOdQVvwrINlqdMDJ7gxaRr986peRdPd0uL
         C7GC4VBxYcHbh3UxquokPY9XAsbr6Vd5jyqwOHLXU/+6E3Ug0yaxQNMR/slcSMth2C3m
         8PEw==
X-Gm-Message-State: AOUpUlGUtuz0BntbXUtNCV10oVWajjtsW1A6W+N51X660/EM8+3YvJ1W
        dehb6hPO5n+hmzTIVQVdMpIiS+DtGvo=
X-Google-Smtp-Source: AAOMgpeZMreO6WLUW87sKhoovy5flZLFKq+OlLHXxN+JMXnYEk8mLxDgQ77FriOOGdco+LWPmDzSbQ==
X-Received: by 2002:a50:8ee4:: with SMTP id x33-v6mr461634edx.175.1532572326903;
        Wed, 25 Jul 2018 19:32:06 -0700 (PDT)
Received: from dhcp.ire.aristanetworks.com ([217.173.96.166])
        by smtp.gmail.com with ESMTPSA id x13-v6sm241024edx.17.2018.07.25.19.32.05
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 25 Jul 2018 19:32:06 -0700 (PDT)
From:   Dmitry Safonov <dima@arista.com>
To:     linux-kernel@vger.kernel.org
Cc:     Dmitry Safonov <dima@arista.com>,
        "David S. Miller" <davem@davemloft.net>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Steffen Klassert <steffen.klassert@secunet.com>,
        Dmitry Safonov <0x7f454c46@gmail.com>, netdev@vger.kernel.org,
        Fan Du <fan.du@intel.com>
Subject: [PATCH 18/18] xfrm: Enable compat syscalls
Date:   Thu, 26 Jul 2018 03:31:44 +0100
Message-Id: <20180726023144.31066-19-dima@arista.com>
X-Mailer: git-send-email 2.13.6
In-Reply-To: <20180726023144.31066-1-dima@arista.com>
References: <20180726023144.31066-1-dima@arista.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Compatible syscalls were disabled for xfrm with the following commits:
19d7df69fdb2 ("xfrm: Refuse to insert 32 bit userspace socket policies
on 64 bit systems") and 74005991b78a ("xfrm: Do not parse 32bits
compiled xfrm netlink msg on 64bits host").

As some structures in xfrm uapi header were not packed by a mistake,
they differ in size between 64-bit and 32-bit applications:

          32-bit UABI                 |             64-bit UABI
--------------------------------------|--------------------------------------
sizeof(xfrm_usersa_info)     = 220    |    sizeof(xfrm_usersa_info)     = 224
sizeof(xfrm_userpolicy_info) = 164    |    sizeof(xfrm_userpolicy_info) = 168
sizeof(xfrm_userspi_info)    = 228    |    sizeof(xfrm_userspi_info)    = 232
sizeof(xfrm_user_acquire)    = 276    |    sizeof(xfrm_user_acquire)    = 280
sizeof(xfrm_user_expire)     = 224    |    sizeof(xfrm_user_expire)     = 232
sizeof(xfrm_user_polexpire)  = 168    |    sizeof(xfrm_user_polexpire)  = 176

With previous patches compatible layer was added to xfrm, so now we
support users of both ABI. A selftest to check work of ipsec tunnel is
present in net/ipsec. It can be easily compiled as compat application
and doesn't require any compat libraries.

Revert the mentioned commits and check the size of received message
according to native/compat syscall.

Cc: "David S. Miller" <davem@davemloft.net>
Cc: Fan Du <fan.du@intel.com>
Cc: Herbert Xu <herbert@gondor.apana.org.au>
Cc: Steffen Klassert <steffen.klassert@secunet.com>
Cc: netdev@vger.kernel.org
Signed-off-by: Dmitry Safonov <dima@arista.com>
---
 net/xfrm/xfrm_state.c |  3 ---
 net/xfrm/xfrm_user.c  | 35 ++++++++++++++++++++++++++++++-----
 2 files changed, 30 insertions(+), 8 deletions(-)

diff --git a/net/xfrm/xfrm_state.c b/net/xfrm/xfrm_state.c
index 3f48a6925606..515a565bfc37 100644
--- a/net/xfrm/xfrm_state.c
+++ b/net/xfrm/xfrm_state.c
@@ -2057,9 +2057,6 @@ int xfrm_user_policy(struct sock *sk, int optname, u8 __user *optval, int optlen
 	struct xfrm_mgr *km;
 	struct xfrm_policy *pol = NULL;
 
-	if (in_compat_syscall())
-		return -EOPNOTSUPP;
-
 	if (!optval && !optlen) {
 		xfrm_sk_policy_insert(sk, XFRM_POLICY_IN, NULL);
 		xfrm_sk_policy_insert(sk, XFRM_POLICY_OUT, NULL);
diff --git a/net/xfrm/xfrm_user.c b/net/xfrm/xfrm_user.c
index 7e3a132b76fb..f6da6ea65d37 100644
--- a/net/xfrm/xfrm_user.c
+++ b/net/xfrm/xfrm_user.c
@@ -2634,6 +2634,30 @@ static const int xfrm_msg_min[XFRM_NR_MSGTYPES] = {
 	[XFRM_MSG_GETSPDINFO  - XFRM_MSG_BASE] = sizeof(u32),
 };
 
+static const int xfrm_msg_min_compat[XFRM_NR_MSGTYPES] = {
+	[XFRM_MSG_NEWSA       - XFRM_MSG_BASE] = XMSGSIZE(xfrm_usersa_info_packed),
+	[XFRM_MSG_DELSA       - XFRM_MSG_BASE] = XMSGSIZE(xfrm_usersa_id),
+	[XFRM_MSG_GETSA       - XFRM_MSG_BASE] = XMSGSIZE(xfrm_usersa_id),
+	[XFRM_MSG_NEWPOLICY   - XFRM_MSG_BASE] = XMSGSIZE(xfrm_userpolicy_info_packed),
+	[XFRM_MSG_DELPOLICY   - XFRM_MSG_BASE] = XMSGSIZE(xfrm_userpolicy_id),
+	[XFRM_MSG_GETPOLICY   - XFRM_MSG_BASE] = XMSGSIZE(xfrm_userpolicy_id),
+	[XFRM_MSG_ALLOCSPI    - XFRM_MSG_BASE] = XMSGSIZE(xfrm_userspi_info_packed),
+	[XFRM_MSG_ACQUIRE     - XFRM_MSG_BASE] = XMSGSIZE(xfrm_user_acquire_packed),
+	[XFRM_MSG_EXPIRE      - XFRM_MSG_BASE] = XMSGSIZE(xfrm_user_expire_packed),
+	[XFRM_MSG_UPDPOLICY   - XFRM_MSG_BASE] = XMSGSIZE(xfrm_userpolicy_info_packed),
+	[XFRM_MSG_UPDSA       - XFRM_MSG_BASE] = XMSGSIZE(xfrm_usersa_info_packed),
+	[XFRM_MSG_POLEXPIRE   - XFRM_MSG_BASE] = XMSGSIZE(xfrm_user_polexpire_packed),
+	[XFRM_MSG_FLUSHSA     - XFRM_MSG_BASE] = XMSGSIZE(xfrm_usersa_flush),
+	[XFRM_MSG_FLUSHPOLICY - XFRM_MSG_BASE] = 0,
+	[XFRM_MSG_NEWAE       - XFRM_MSG_BASE] = XMSGSIZE(xfrm_aevent_id),
+	[XFRM_MSG_GETAE       - XFRM_MSG_BASE] = XMSGSIZE(xfrm_aevent_id),
+	[XFRM_MSG_REPORT      - XFRM_MSG_BASE] = XMSGSIZE(xfrm_user_report),
+	[XFRM_MSG_MIGRATE     - XFRM_MSG_BASE] = XMSGSIZE(xfrm_userpolicy_id),
+	[XFRM_MSG_GETSADINFO  - XFRM_MSG_BASE] = sizeof(u32),
+	[XFRM_MSG_NEWSPDINFO  - XFRM_MSG_BASE] = sizeof(u32),
+	[XFRM_MSG_GETSPDINFO  - XFRM_MSG_BASE] = sizeof(u32),
+};
+
 #undef XMSGSIZE
 
 static const struct nla_policy xfrma_policy[XFRMA_MAX+1] = {
@@ -2715,10 +2739,7 @@ static int xfrm_user_rcv_msg(struct sk_buff *skb, struct nlmsghdr *nlh,
 	struct net *net = sock_net(skb->sk);
 	struct nlattr *attrs[XFRMA_MAX+1];
 	const struct xfrm_link *link;
-	int type, err;
-
-	if (in_compat_syscall())
-		return -EOPNOTSUPP;
+	int type, err, hdrlen;
 
 	type = nlh->nlmsg_type;
 	if (type > XFRM_MSG_MAX)
@@ -2747,7 +2768,11 @@ static int xfrm_user_rcv_msg(struct sk_buff *skb, struct nlmsghdr *nlh,
 		}
 	}
 
-	err = nlmsg_parse(nlh, xfrm_msg_min[type], attrs,
+	hdrlen = xfrm_msg_min[type];
+	if (in_compat_syscall())
+		hdrlen = xfrm_msg_min_compat[type];
+
+	err = nlmsg_parse(nlh, hdrlen, attrs,
 			  link->nla_max ? : XFRMA_MAX,
 			  link->nla_pol ? : xfrma_policy, extack);
 	if (err < 0)
-- 
2.13.6

