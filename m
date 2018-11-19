Return-Path: <SRS0=tadO=N6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51D87C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 19:53:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1CF002086A
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 19:53:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="wS5UPwp8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1CF002086A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730559AbeKTGSw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Nov 2018 01:18:52 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:54108 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725843AbeKTGSt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Nov 2018 01:18:49 -0500
Received: by mail-wm1-f68.google.com with SMTP id g131so6157271wmg.3
        for <linux-kernel@vger.kernel.org>; Mon, 19 Nov 2018 11:53:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Jnh3ZNR/Fcg+7gTBnx75uTTp6wDqPloHA9MJBWzeT3M=;
        b=wS5UPwp8aX0dDRTEokwMnx6RKskiZEysjBl7k9qWiIPj3jzEnZd0dtFRqQ4DJsDq3T
         /02NXB37XYCsooWnx3Vdc/2imjcfeG83eeu/A78AclgghT1MArAwNkskK8yq1+l/TmmC
         XhVpx/m4xCVDbzdklQNImOKnxeGtn28iK2PFHRUy9Ao0mLcgD9YwR/NxDAGZaSE7DbrX
         vUbEW+Xt1FgUQU8KrCqfKQdN1crBpIH+wabGWKb7OutU1id4H7CtNK/y5ty0daXs2jKs
         JERpiXXLTySxFX7p7QB9ns5tuF4aBzJg51Yi9Sq3nHottaKCNM+6EtoGMGd2f8hGpWZ8
         FoSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Jnh3ZNR/Fcg+7gTBnx75uTTp6wDqPloHA9MJBWzeT3M=;
        b=W0UPbcXfMXIncU/QsQePHyLkcs/tmXTu8vvb/dn9tRa3jmK2gwrQ8YGy0K1LiV5qgb
         OyY050TUGFswhOdLJ56XKkle8nstNGqq3u4e/63csuKoJqn+vRWAWSLgBAztqvUVnOXH
         tzsc0J1T1jf3OEKFqEBZTZ+4YYMxFmizzzgp7ccObTnSxo9OqrCVhjWQmBIfAs+UdHmJ
         +M/J9cx6n06iHPoa1lxpigSXVlTVNt4xvuei3WLz01F9bUUssCAzTUul4QYQ5IjLfkLz
         LPxwZI7jhbv3PjG77bcxldHAFqpHeCLQz0GuW7kOxavaeCzyc7aGno4StcVAM06LlelY
         pKsQ==
X-Gm-Message-State: AA+aEWYR/IlO9I6dwLeKUXMsrfbI8lHc0f4NU7ouUSOsp6R3GXJoe+Ca
        8m6mn8JVa+Sva6zsxLD4MjLBLA==
X-Google-Smtp-Source: AJdET5es0eUjkSB08eugl2wCxgB8mmEwRdfRMha8bUwiqRvPlkGZq3/WoXsd7R9UYmvHyJVYhru95A==
X-Received: by 2002:a1c:ca02:: with SMTP id a2mr8298468wmg.139.1542657218501;
        Mon, 19 Nov 2018 11:53:38 -0800 (PST)
Received: from localhost.localdomain ([51.15.160.169])
        by smtp.googlemail.com with ESMTPSA id i16sm22954132wmd.28.2018.11.19.11.53.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 19 Nov 2018 11:53:37 -0800 (PST)
From:   Corentin Labbe <clabbe@baylibre.com>
To:     davem@davemloft.net, ebiggers@kernel.org,
        herbert@gondor.apana.org.au, nhorman@tuxdriver.com
Cc:     linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        Corentin Labbe <clabbe@baylibre.com>
Subject: [PATCH v2 02/11] crypto: crypto_user_stat: made crypto_user_stat optional
Date:   Mon, 19 Nov 2018 19:53:21 +0000
Message-Id: <1542657210-37739-3-git-send-email-clabbe@baylibre.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1542657210-37739-1-git-send-email-clabbe@baylibre.com>
References: <1542657210-37739-1-git-send-email-clabbe@baylibre.com>
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
index abbd86fdbad2..22f9f84f961d 100644
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
index ac8f4168a831..9dc8d50dc578 100644
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

