Return-Path: <SRS0=7Z+k=KK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29CECC67790
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 02:32:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D2D312089C
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 02:32:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b="hMmVlOjg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D2D312089C
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=arista.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729202AbeGZDqd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Jul 2018 23:46:33 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:33046 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728744AbeGZDqa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jul 2018 23:46:30 -0400
Received: by mail-ed1-f65.google.com with SMTP id x5-v6so342711edr.0
        for <linux-kernel@vger.kernel.org>; Wed, 25 Jul 2018 19:31:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=googlenew;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=KGoK3OMLZtNNtazxqMz9O1g2b/QG4N/rvtrmfVBaNKw=;
        b=hMmVlOjgu3cExAPljGXnFlQTIdhe78lf0XeL2+7TMs2vyPC0CLm9NDLe8hHRqzhPGK
         v5k5DzwZJ9afvV+2eWV4wfxAAW7q2LJ8p+kYm6aZOwVzxJtoeKeE5dgDoTVIsnfLGHSR
         ALvMPhlnF2U07EMdj/LD6BRnKx60Ajtz62Q6oWdxakQjMeRQoWqi2xap/HB0EVsDyjuX
         wL0JhXNgN6IZ0HzPEfuBObuMx0sqD8Wy+2e7BjbVkVN6HOFJcCNuUwFrG2Pm6Ey+zenX
         UPc0IeqrxthOdcy0eBd3xGvkvDNXhsX/ie+x/DG1eZJIJeWRJTDuLTZmcKtqoFO5zOpD
         iqKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=KGoK3OMLZtNNtazxqMz9O1g2b/QG4N/rvtrmfVBaNKw=;
        b=Onfh0wM+Xsl4epuvXGwQAgR3DUGNyIHpJZENc8w1lI8amlxDLmJZs9AVB7poqTPRGa
         0fGeMSPRPWGRUIoC06zPcqRw+BorufeeVl6vyDNs1eqt/XAH5MbE5BESk0DkIcTRDGEa
         nVQZud8IMe22sB59c6P9YM+hpc+bvfsW2FY7B+yXTkuL/FFu7Agir8xKg+elST6/V2Xx
         01CmMv4uS2a+BTx1UnzGxC4uAWlLt/SuUShFUtOTZxSgfi8MbzYEQVqme4pnb+pJzAoX
         jukdoK5oa9lKdhOsLDKLFYwCfvaqDstpr0VF5htKT1xPyWDp74J1Oc+rcxU2AJDTVqlf
         JHBg==
X-Gm-Message-State: AOUpUlG44DrZaNYLao4G6uORdExko7i3/z4MhltRE+Y0i2UBwNftjqb0
        WkK/XGJGw81sIQ9TMMMUKI80dHhaRDw=
X-Google-Smtp-Source: AAOMgpcCx3zX76fNkUdYYaZw3nPEC29UpNy9FQ4yDkLe6RMPV6dLWZLv7f+lyUK2dsznK4WoA9JMRA==
X-Received: by 2002:a50:a402:: with SMTP id u2-v6mr459068edb.237.1532572315834;
        Wed, 25 Jul 2018 19:31:55 -0700 (PDT)
Received: from dhcp.ire.aristanetworks.com ([217.173.96.166])
        by smtp.gmail.com with ESMTPSA id x13-v6sm241024edx.17.2018.07.25.19.31.54
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 25 Jul 2018 19:31:55 -0700 (PDT)
From:   Dmitry Safonov <dima@arista.com>
To:     linux-kernel@vger.kernel.org
Cc:     Dmitry Safonov <dima@arista.com>,
        "David S. Miller" <davem@davemloft.net>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Steffen Klassert <steffen.klassert@secunet.com>,
        Dmitry Safonov <0x7f454c46@gmail.com>, netdev@vger.kernel.org
Subject: [PATCH 08/18] xfrm: Add in-kernel groups for compat notifications
Date:   Thu, 26 Jul 2018 03:31:34 +0100
Message-Id: <20180726023144.31066-9-dima@arista.com>
X-Mailer: git-send-email 2.13.6
In-Reply-To: <20180726023144.31066-1-dima@arista.com>
References: <20180726023144.31066-1-dima@arista.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Introduce kernel-only, hidden from userspace groups.
Application that bind()ed by kernel to such group will receive netlink
messages in compatible ABI on 64-bit kernels.

Cc: "David S. Miller" <davem@davemloft.net>
Cc: Herbert Xu <herbert@gondor.apana.org.au>
Cc: Steffen Klassert <steffen.klassert@secunet.com>
Cc: netdev@vger.kernel.org
Signed-off-by: Dmitry Safonov <dima@arista.com>
---
 net/xfrm/xfrm_user.c | 54 +++++++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 53 insertions(+), 1 deletion(-)

diff --git a/net/xfrm/xfrm_user.c b/net/xfrm/xfrm_user.c
index bf2ca93edaf5..b123e788488f 100644
--- a/net/xfrm/xfrm_user.c
+++ b/net/xfrm/xfrm_user.c
@@ -67,6 +67,29 @@ struct xfrm_userspi_info_packed {
 	__u32				max;
 } __packed;
 
+/* In-kernel, non-uapi compat groups.
+ * As compat/native messages differ, send notifications according
+ * to .bind() caller's ABI. There are *_COMPAT hidden from userspace
+ * groups for such task.
+ */
+enum xfrm_nlgroups_kernel {
+	XFRMNLGRP_COMPAT_MIN = XFRMNLGRP_MAX,
+	XFRMNLGRP_COMPAT_ACQUIRE,
+	XFRMNLGRP_COMPAT_EXPIRE,
+	XFRMNLGRP_COMPAT_SA,
+	XFRMNLGRP_COMPAT_POLICY,
+	/* Group messages for the following notifications do not differ
+	 * in size between native and compat structures:
+	 * XFRMNLGRP_AEVENTS,
+	 * XFRMNLGRP_REPORT,
+	 * XFRMNLGRP_MIGRATE,
+	 * XFRMNLGRP_MAPPING,
+	 */
+	__XFRMNLGRP_COMPAT_MAX
+};
+
+#define XFRMNLGRP_KERNEL_MAX	(__XFRMNLGRP_COMPAT_MAX - 1)
+
 static int verify_one_alg(struct nlattr **attrs, enum xfrm_attr_type_t type)
 {
 	struct nlattr *rt = attrs[type];
@@ -2645,6 +2668,34 @@ static void xfrm_netlink_rcv(struct sk_buff *skb)
 	mutex_unlock(&net->xfrm.xfrm_cfg_mutex);
 }
 
+static inline void xfrm_nlgrp_compat(unsigned long *groups,
+		int group, int group_compat)
+{
+	unsigned long group_bit = 1UL << (group - 1);
+
+	if (*groups & group_bit) {
+		*groups &= ~group_bit;
+		*groups |= 1UL << (group_compat - 1);
+	}
+}
+
+static int xfrm_netlink_bind(struct net *net, unsigned long *groups)
+{
+	unsigned long uapi_mask = (1UL << XFRMNLGRP_MAX) - 1;
+
+	*groups &= uapi_mask;
+
+	if (!in_compat_syscall())
+		return 0;
+
+	xfrm_nlgrp_compat(groups, XFRMNLGRP_ACQUIRE, XFRMNLGRP_COMPAT_ACQUIRE);
+	xfrm_nlgrp_compat(groups, XFRMNLGRP_EXPIRE, XFRMNLGRP_COMPAT_EXPIRE);
+	xfrm_nlgrp_compat(groups, XFRMNLGRP_SA, XFRMNLGRP_COMPAT_SA);
+	xfrm_nlgrp_compat(groups, XFRMNLGRP_POLICY, XFRMNLGRP_COMPAT_POLICY);
+
+	return 0;
+}
+
 static inline unsigned int xfrm_expire_msgsize(void)
 {
 	return NLMSG_ALIGN(sizeof(struct xfrm_user_expire))
@@ -3283,8 +3334,9 @@ static int __net_init xfrm_user_net_init(struct net *net)
 {
 	struct sock *nlsk;
 	struct netlink_kernel_cfg cfg = {
-		.groups	= XFRMNLGRP_MAX,
+		.groups	= XFRMNLGRP_KERNEL_MAX,
 		.input	= xfrm_netlink_rcv,
+		.bind	= xfrm_netlink_bind,
 	};
 
 	nlsk = netlink_kernel_create(net, NETLINK_XFRM, &cfg);
-- 
2.13.6

