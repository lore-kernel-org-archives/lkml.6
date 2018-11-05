Return-Path: <SRS0=bKrn=NQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FB86C0044C
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 12:51:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2920D20866
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 12:51:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="cSmudIWK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2920D20866
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729827AbeKEWLG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 5 Nov 2018 17:11:06 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:33339 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729332AbeKEWLE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Nov 2018 17:11:04 -0500
Received: by mail-wr1-f68.google.com with SMTP id u1-v6so9414814wrn.0
        for <linux-kernel@vger.kernel.org>; Mon, 05 Nov 2018 04:51:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Bh7ZQS67P0Szty+SxMxr1LPymweTuc6vzmZLds2lnxI=;
        b=cSmudIWKZ86hX/70Ndb7sTK6SlA42UkmelKWMlFXnEOIfcvr6CjUeOMPI+ve/fPuS+
         Ww1WMhDihVNHmiK/4SEB8c2fUBG5qpKYJ01cJkx3xrnIR+nDDX9O1yQg0eu5z6yTbhm4
         iqcgNw5zvtqnUcYeZqTueTJPvawvAfBYYCKDhUZklceh9h7PEbzczeVfmj/XKL9h+8k1
         vzC4kYNolGIUxHXbzvq6Q6rfS4n97dPlbT0IreIj/VgovGydL0jhEv4YClurYRrsjZhq
         uBuuAnywny7TtsRWkYYntkIOgIsgTHeqdE5fl32ItyEk3BWcYLLeyiapT9B/+qWBEPMD
         nVhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Bh7ZQS67P0Szty+SxMxr1LPymweTuc6vzmZLds2lnxI=;
        b=QpsgztdQoyApHp7rA2Xz3C7S2MjokO+qKU0vXyPLSEXNxEog9S5QcQAySTUi0jhVao
         K+4BSRNdwjgkYSAsBkU78fEk7psvQLhs+qOKKaqzdkT4xHcqndmgclNwjg8ZnJqDO3ij
         DnL+fxZudn+4ziF50OnxiWXrbvH0XHcb6i2O1W2vOIfaWkoX6NfFrL/RpZBHRA66wFdh
         Pmjd0/iIfRZy1E/qCd/fhcnv5jE7aOAvFUBm6l/bvj0bZuXC4Nq47rQKKh5K0BRBSgX/
         Z+NQ0gROpvAjZ2lv19ZsqDTZ9bBAys8eqRE9sQ31uOMhItPR0qTQCcj2psXAK9V/fDx4
         lrIg==
X-Gm-Message-State: AGRZ1gL/1G3cPsPvRgYQtiaL7Ihyp0LIt2epIJ/+pSN36gVxdZy4CDoY
        Z140MpF1mnvpfioa4dLuImPyNQ==
X-Google-Smtp-Source: AJdET5c2OQ8lEsDj7s3rcUWs2aMyGWIJFyRJmShFk2suPHG+JN+q4lPnsPP2QDwnPRR33sJHDO7R2A==
X-Received: by 2002:adf:cc81:: with SMTP id p1-v6mr1493215wrj.139.1541422286129;
        Mon, 05 Nov 2018 04:51:26 -0800 (PST)
Received: from localhost.localdomain ([51.15.160.169])
        by smtp.googlemail.com with ESMTPSA id l4-v6sm56114579wrb.92.2018.11.05.04.51.25
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 05 Nov 2018 04:51:25 -0800 (PST)
From:   Corentin Labbe <clabbe@baylibre.com>
To:     davem@davemloft.net, ebiggers@kernel.org,
        herbert@gondor.apana.org.au
Cc:     linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        Corentin Labbe <clabbe@baylibre.com>
Subject: [PATCH 1/5] crypto: crypto_user_stat: made crypto_user_stat optional
Date:   Mon,  5 Nov 2018 12:51:10 +0000
Message-Id: <1541422274-40060-2-git-send-email-clabbe@baylibre.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1541422274-40060-1-git-send-email-clabbe@baylibre.com>
References: <1541422274-40060-1-git-send-email-clabbe@baylibre.com>
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
index 5c207c76abf7..1e9e5960946a 100644
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
index 3634ad6fe202..35de61d99cd5 100644
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
+#endif
 
 } CRYPTO_MINALIGN_ATTR;
 
-- 
2.18.1

