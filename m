Return-Path: <SRS0=aB5v=OC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 373B3C43441
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Nov 2018 12:02:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F2C7520672
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Nov 2018 12:02:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="kC/bxJlA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F2C7520672
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2503939AbeKWWqb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 23 Nov 2018 17:46:31 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:40654 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2409726AbeKWWqa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Nov 2018 17:46:30 -0500
Received: by mail-wm1-f67.google.com with SMTP id q26so11720514wmf.5
        for <linux-kernel@vger.kernel.org>; Fri, 23 Nov 2018 04:02:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=q3QS62MIFQUBTNlO2qw4Vk0ELQhTshDx1aMv2RLYuQY=;
        b=kC/bxJlAkxL1JKkEPVZ8C3spiDH+qeEvqS4rXscuJrvHqP7fUDyS245yVUjceCSqAR
         4fpApl2AA+GrgCtAc3gtQWQsGClTacPjLGSyUX/Urj+HSc0qCrT9TnPhKnqvPwH4vfNK
         0ZHKajFGjeCVSU42q5szsW3dL1JBIM8OLSkHG3wEFjYvzHDekuo+FVxMyCYQOnNJN8uC
         pLpsb6E3lMvMv3L95hiNYEEkyvunRIjT8vENtvqWdSjdxRELWHF+Dcw10b6+mexmZMdd
         PvJiMZCmAZvpNdv3whZ8dLngtSPTvpL/gH4xs/amcX4X3no+zitpsmiRG3YyRkjwOc0f
         cxhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=q3QS62MIFQUBTNlO2qw4Vk0ELQhTshDx1aMv2RLYuQY=;
        b=Zq7YAP+ubGtyZGGbf0pIqNgyCO7gFa15amwneNAsbpxhIV2aYGh/yCNeo/Nze0HdcP
         Q6RJrUiRaWVUekyYhyzPCjJH3qFSM4z09kb9m17gJGtrPWW5K7UGkKQ0PYQAymZe4Zlt
         UT65wdINZwmMfYU2BaLVbStNXVwW757oXCPCi81QDMUSwQ56oOT8317XgE9lM/o+QUJ8
         e1pnrv5obCEIjGeAsdErqUPzUsCbsfBN1qyNUQ13z1+yN+ZaRHcP2e5qvQ1zg6aIyuNA
         eW1ZXEjO9NoJLrydjCTdvXeWqJH1SzK/Dc1yphNFhsrl2ujbbWiOCx/+oX467Uvmv9z5
         qA1w==
X-Gm-Message-State: AA+aEWZD5Ob9f6dGHigc6uBtVf/BvFoFxBx8mK5g7Bquw1rgLGs2dsVp
        jEPPgzZr6deNZcOVO2E3FRyOlw==
X-Google-Smtp-Source: AFSGD/XSVSjuvbvvOf49+jx7rXX9fdBq7kMkgoZG0hzpyvrxpR13yjs6MdZKSNa2hFpggpU04kjkQg==
X-Received: by 2002:a7b:ca53:: with SMTP id m19mr11002087wml.102.1542974551320;
        Fri, 23 Nov 2018 04:02:31 -0800 (PST)
Received: from localhost.localdomain ([51.15.160.169])
        by smtp.googlemail.com with ESMTPSA id a18sm25164379wrp.13.2018.11.23.04.02.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 23 Nov 2018 04:02:29 -0800 (PST)
From:   Corentin Labbe <clabbe@baylibre.com>
To:     davem@davemloft.net, ebiggers@kernel.org,
        herbert@gondor.apana.org.au, nhorman@tuxdriver.com
Cc:     linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        Corentin Labbe <clabbe@baylibre.com>
Subject: [PATCH v4 01/11] crypto: crypto_user_stat: made crypto_user_stat optional
Date:   Fri, 23 Nov 2018 12:02:11 +0000
Message-Id: <1542974541-23024-2-git-send-email-clabbe@baylibre.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1542974541-23024-1-git-send-email-clabbe@baylibre.com>
References: <1542974541-23024-1-git-send-email-clabbe@baylibre.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Even if CRYPTO_STATS is set to n, some part of CRYPTO_STATS are
compiled.
This patch made all part of crypto_user_stat uncompiled in that case.

Signed-off-by: Corentin Labbe <clabbe@baylibre.com>
---
 crypto/Makefile                      |  3 ++-
 crypto/algapi.c                      |  2 ++
 include/crypto/internal/cryptouser.h | 17 +++++++++++++++++
 include/linux/crypto.h               |  2 ++
 4 files changed, 23 insertions(+), 1 deletion(-)

diff --git a/crypto/Makefile b/crypto/Makefile
index 5e789dc2d4fd..799ed5e94606 100644
--- a/crypto/Makefile
+++ b/crypto/Makefile
@@ -54,7 +54,8 @@ cryptomgr-y := algboss.o testmgr.o
 
 obj-$(CONFIG_CRYPTO_MANAGER2) += cryptomgr.o
 obj-$(CONFIG_CRYPTO_USER) += crypto_user.o
-crypto_user-y := crypto_user_base.o crypto_user_stat.o
+crypto_user-y := crypto_user_base.o
+crypto_user-$(CONFIG_CRYPTO_STATS) += crypto_user_stat.o
 obj-$(CONFIG_CRYPTO_CMAC) += cmac.o
 obj-$(CONFIG_CRYPTO_HMAC) += hmac.o
 obj-$(CONFIG_CRYPTO_VMAC) += vmac.o
diff --git a/crypto/algapi.c b/crypto/algapi.c
index 2545c5f89c4c..f5396c88e8cd 100644
--- a/crypto/algapi.c
+++ b/crypto/algapi.c
@@ -258,6 +258,7 @@ static struct crypto_larval *__crypto_register_alg(struct crypto_alg *alg)
 	list_add(&alg->cra_list, &crypto_alg_list);
 	list_add(&larval->alg.cra_list, &crypto_alg_list);
 
+#ifdef CONFIG_CRYPTO_STATS
 	atomic_set(&alg->encrypt_cnt, 0);
 	atomic_set(&alg->decrypt_cnt, 0);
 	atomic64_set(&alg->encrypt_tlen, 0);
@@ -265,6 +266,7 @@ static struct crypto_larval *__crypto_register_alg(struct crypto_alg *alg)
 	atomic_set(&alg->verify_cnt, 0);
 	atomic_set(&alg->cipher_err_cnt, 0);
 	atomic_set(&alg->sign_cnt, 0);
+#endif
 
 out:
 	return larval;
diff --git a/include/crypto/internal/cryptouser.h b/include/crypto/internal/cryptouser.h
index 8db299c25566..3492ab42eefb 100644
--- a/include/crypto/internal/cryptouser.h
+++ b/include/crypto/internal/cryptouser.h
@@ -3,6 +3,23 @@
 
 struct crypto_alg *crypto_alg_match(struct crypto_user_alg *p, int exact);
 
+#ifdef CONFIG_CRYPTO_STATS
 int crypto_dump_reportstat(struct sk_buff *skb, struct netlink_callback *cb);
 int crypto_reportstat(struct sk_buff *in_skb, struct nlmsghdr *in_nlh, struct nlattr **attrs);
 int crypto_dump_reportstat_done(struct netlink_callback *cb);
+#else
+static int crypto_dump_reportstat(struct sk_buff *skb, struct netlink_callback *cb)
+{
+	return -ENOTSUPP;
+}
+
+static int crypto_reportstat(struct sk_buff *in_skb, struct nlmsghdr *in_nlh, struct nlattr **attrs)
+{
+	return -ENOTSUPP;
+}
+
+static int crypto_dump_reportstat_done(struct netlink_callback *cb)
+{
+	return -ENOTSUPP;
+}
+#endif
diff --git a/include/linux/crypto.h b/include/linux/crypto.h
index 3634ad6fe202..3e05053b8d57 100644
--- a/include/linux/crypto.h
+++ b/include/linux/crypto.h
@@ -515,6 +515,7 @@ struct crypto_alg {
 	
 	struct module *cra_module;
 
+#ifdef CONFIG_CRYPTO_STATS
 	union {
 		atomic_t encrypt_cnt;
 		atomic_t compress_cnt;
@@ -552,6 +553,7 @@ struct crypto_alg {
 		atomic_t compute_shared_secret_cnt;
 	};
 	atomic_t sign_cnt;
+#endif /* CONFIG_CRYPTO_STATS */
 
 } CRYPTO_MINALIGN_ATTR;
 
-- 
2.18.1

