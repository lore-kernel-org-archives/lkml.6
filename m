Return-Path: <SRS0=yjy/=OW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CF41C67839
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 08:36:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 405A620849
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 08:36:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="BYclqQkR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 405A620849
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727214AbeLMIgr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Dec 2018 03:36:47 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:37023 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725949AbeLMIgr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Dec 2018 03:36:47 -0500
Received: by mail-wm1-f67.google.com with SMTP id g67so1434893wmd.2
        for <linux-kernel@vger.kernel.org>; Thu, 13 Dec 2018 00:36:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id;
        bh=GBvbuflI3tHjbAYUm96HadBjILlkS6dUAwM22uDvsHo=;
        b=BYclqQkRp9GGqTFEjoIiiRc3o5V2Q2eWb7JNw9xlWroLsalZLsIOo1KsQmTqKZN3sV
         WWH0D9rQRdQn+86NC4YMzOq+frIEUeF4O56W+61UrEFT5Bqoktk25eA3rHGn55ryQhB3
         HzAcyYCP3ZO/rA/pqEx1vIltb3hd4CcZqCIrhK4Qmt6GfTqrB28idqNKA/XXRhARfrho
         GOMTzro6VJ2xJDYpBqIl+aJriAd6gF3u+zu3xyc/7cMqbEQYppQeyKx9RQtFuJx1mY6D
         jZeDnKN1lP7kbZ8zEMvSESjuKGpPwvhQ8j1AlMNv9dfY2FTLRNtpaEaJMFURWjpzEz8v
         QiaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=GBvbuflI3tHjbAYUm96HadBjILlkS6dUAwM22uDvsHo=;
        b=St1qykn+Npi1NUvqjAs3nXdmHVTB4yLJ78NaW/HmiWIg4rdBga7HZuFF7j6IphOaZY
         vC+JMcEmcqEE4HD8hcIEGXU3849mwu8G9FdK8KUoGMeiPIPSgOKYq/AnBmFXWETsqSVM
         vGpNgoaSqXI4dHgVbK4t8ifqMDIQmBBLNbo6EhbqeYKf2oXNdCSIHqtCdrjg+Ifgdj/n
         gbw1oX9fN+3CAZhwnjVKqwhTuNl0+g5+zNjQz2lCNhSCBTmXZBRWnha27TvbU5m98KOU
         piOKHT5T610N8BJvYDMHGi36MnoVk2gsQKX8nkvfyTXoab7KCWpnIWDPXcjvx0Vd3OAX
         SDfg==
X-Gm-Message-State: AA+aEWaRx1dK1tYP8xZ434A2/sdQ94Km3QGnpRvgxWAs83jPyb8L/Jpf
        +gxz2rLEnAHlEmTAfKDAXWojZQ==
X-Google-Smtp-Source: AFSGD/XuigEPunBzZu+7vY7f4ytmzyLmGN+YbRRL7P78AvPtJJNN+10Rva3qe/U7jJst4u24hfU1pA==
X-Received: by 2002:a1c:58ce:: with SMTP id m197mr9735031wmb.31.1544690204929;
        Thu, 13 Dec 2018 00:36:44 -0800 (PST)
Received: from localhost.localdomain ([51.15.160.169])
        by smtp.googlemail.com with ESMTPSA id e19sm1823258wrc.25.2018.12.13.00.36.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 13 Dec 2018 00:36:44 -0800 (PST)
From:   Corentin Labbe <clabbe@baylibre.com>
To:     davem@davemloft.net, herbert@gondor.apana.org.au
Cc:     linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        Corentin Labbe <clabbe@baylibre.com>
Subject: [PATCH 1/2] crypto: crypto_user_stat: remove unused dump functions
Date:   Thu, 13 Dec 2018 08:36:37 +0000
Message-Id: <1544690198-21993-1-git-send-email-clabbe@baylibre.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch removes unused dump functions for crypto_user_stats.
There are remains of the copy/paste of crypto_user_base to
crypto_user_stat and I forgot to remove them.

Signed-off-by: Corentin Labbe <clabbe@baylibre.com>
---
 crypto/crypto_user_base.c            |  4 +---
 crypto/crypto_user_stat.c            | 33 ----------------------------
 include/crypto/internal/cryptouser.h | 12 ----------
 3 files changed, 1 insertion(+), 48 deletions(-)

diff --git a/crypto/crypto_user_base.c b/crypto/crypto_user_base.c
index 7021efbb35a1..f4f607631429 100644
--- a/crypto/crypto_user_base.c
+++ b/crypto/crypto_user_base.c
@@ -420,9 +420,7 @@ static const struct crypto_link {
 						       .dump = crypto_dump_report,
 						       .done = crypto_dump_report_done},
 	[CRYPTO_MSG_DELRNG	- CRYPTO_MSG_BASE] = { .doit = crypto_del_rng },
-	[CRYPTO_MSG_GETSTAT	- CRYPTO_MSG_BASE] = { .doit = crypto_reportstat,
-						       .dump = crypto_dump_reportstat,
-						       .done = crypto_dump_reportstat_done},
+	[CRYPTO_MSG_GETSTAT	- CRYPTO_MSG_BASE] = { .doit = crypto_reportstat},
 };
 
 static int crypto_user_rcv_msg(struct sk_buff *skb, struct nlmsghdr *nlh,
diff --git a/crypto/crypto_user_stat.c b/crypto/crypto_user_stat.c
index 0ba00aaeb810..3e9a53233d80 100644
--- a/crypto/crypto_user_stat.c
+++ b/crypto/crypto_user_stat.c
@@ -336,37 +336,4 @@ int crypto_reportstat(struct sk_buff *in_skb, struct nlmsghdr *in_nlh,
 	return nlmsg_unicast(crypto_nlsk, skb, NETLINK_CB(in_skb).portid);
 }
 
-int crypto_dump_reportstat(struct sk_buff *skb, struct netlink_callback *cb)
-{
-	struct crypto_alg *alg;
-	struct crypto_dump_info info;
-	int err;
-
-	if (cb->args[0])
-		goto out;
-
-	cb->args[0] = 1;
-
-	info.in_skb = cb->skb;
-	info.out_skb = skb;
-	info.nlmsg_seq = cb->nlh->nlmsg_seq;
-	info.nlmsg_flags = NLM_F_MULTI;
-
-	list_for_each_entry(alg, &crypto_alg_list, cra_list) {
-		err = crypto_reportstat_alg(alg, &info);
-		if (err)
-			goto out_err;
-	}
-
-out:
-	return skb->len;
-out_err:
-	return err;
-}
-
-int crypto_dump_reportstat_done(struct netlink_callback *cb)
-{
-	return 0;
-}
-
 MODULE_LICENSE("GPL");
diff --git a/include/crypto/internal/cryptouser.h b/include/crypto/internal/cryptouser.h
index 3492ab42eefb..40623f4457df 100644
--- a/include/crypto/internal/cryptouser.h
+++ b/include/crypto/internal/cryptouser.h
@@ -4,22 +4,10 @@
 struct crypto_alg *crypto_alg_match(struct crypto_user_alg *p, int exact);
 
 #ifdef CONFIG_CRYPTO_STATS
-int crypto_dump_reportstat(struct sk_buff *skb, struct netlink_callback *cb);
 int crypto_reportstat(struct sk_buff *in_skb, struct nlmsghdr *in_nlh, struct nlattr **attrs);
-int crypto_dump_reportstat_done(struct netlink_callback *cb);
 #else
-static int crypto_dump_reportstat(struct sk_buff *skb, struct netlink_callback *cb)
-{
-	return -ENOTSUPP;
-}
-
 static int crypto_reportstat(struct sk_buff *in_skb, struct nlmsghdr *in_nlh, struct nlattr **attrs)
 {
 	return -ENOTSUPP;
 }
-
-static int crypto_dump_reportstat_done(struct netlink_callback *cb)
-{
-	return -ENOTSUPP;
-}
 #endif
-- 
2.19.2

