Return-Path: <SRS0=tadO=N6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39275C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 19:53:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D160B20831
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 19:53:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="BI2QoGbo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D160B20831
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730678AbeKTGS7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Nov 2018 01:18:59 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:44588 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730419AbeKTGS7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Nov 2018 01:18:59 -0500
Received: by mail-wr1-f68.google.com with SMTP id j17-v6so33339062wrq.11
        for <linux-kernel@vger.kernel.org>; Mon, 19 Nov 2018 11:53:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=TKyCAgdoeTVXeIVqhlyRGff0SVQlNn4A8J+U1kZQZiQ=;
        b=BI2QoGboo5BW8LvgTOUJ455NAlPN99Q4sHvMFuqkRe5YORgSq8B+Drnh0GUBKy+8e6
         ZykA0NWrGkJxSr8w0nNpkCtQLc47lycmAjxd9AeQyHA032zS3Mk0yNKVEZum+nJuWaPw
         26Es+TxrXMQRYqWYv/z9RpCKqvVegVgsQK1TXn7bzcT5bOMSvha7jjH4RNfnPvqKmYVc
         S+avbxHCWWbQGqhs8FqRubHuJUrunj6WOdGK/fL9ZmUkp7QhwkTL/4KY64Adm0TaRgDe
         mvVfQH+f2Isu88F/6X6Wsb1UDABvuTMNlyJkAv2WXEHnaQ5E5DhSPBcxDgkdrl/lelhD
         t6Zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=TKyCAgdoeTVXeIVqhlyRGff0SVQlNn4A8J+U1kZQZiQ=;
        b=RwY/WYhUQvxZqT5ITstQU7N+ot6UmKsDrHl54dL2CY29dPLVTxR3T8Ih1oVQcj44jx
         keqRgoymZSdASxbOVREPmTDDG2aWzlviipNiv8zlEzjd1aLxZdXRGMijF8jjVM0DOnPU
         xQgpNO5EgDPfwV+S4BrG/1nXSYTjS6twc1rn2bKkieFH1iUwwe1btmkUkMWZmqV+bSot
         hwVvG0OqTU8RWyRw2GhLA4GMYl8ekcowLRYUWF0J7x2mbvczdEesDn7O4Q3kjFj7Qhys
         AzhktbfotIYtsrKRa80yX48SPeKcG8oHIQbeC0lg6wQcPZxy9ocMQcKr0qNBmbyPR/yL
         mVpg==
X-Gm-Message-State: AGRZ1gKS9G3jlHFUKcqSb3bL2G35oAQYeWIMCFxwkybij5eg6pKF8Zir
        5hAI6Pr8mEpVsRv9OUgtWmtmAzQWs+g=
X-Google-Smtp-Source: AJdET5dCovDBxWZ8xZOxCihrEPk3p4NOlTv+lnEO0yeihUoHXUkE1Ko40hW8ZECBpI4rxOEFYy4YEA==
X-Received: by 2002:a5d:6684:: with SMTP id l4mr21307085wru.154.1542657227071;
        Mon, 19 Nov 2018 11:53:47 -0800 (PST)
Received: from localhost.localdomain ([51.15.160.169])
        by smtp.googlemail.com with ESMTPSA id i16sm22954132wmd.28.2018.11.19.11.53.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 19 Nov 2018 11:53:46 -0800 (PST)
From:   Corentin Labbe <clabbe@baylibre.com>
To:     davem@davemloft.net, ebiggers@kernel.org,
        herbert@gondor.apana.org.au, nhorman@tuxdriver.com
Cc:     linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        Corentin Labbe <clabbe@baylibre.com>
Subject: [PATCH v2 11/11] crypto: crypto_user_stat: rename err_cnt parameter
Date:   Mon, 19 Nov 2018 19:53:30 +0000
Message-Id: <1542657210-37739-12-git-send-email-clabbe@baylibre.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1542657210-37739-1-git-send-email-clabbe@baylibre.com>
References: <1542657210-37739-1-git-send-email-clabbe@baylibre.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since now all crypto stats are on their own structures, it is now
useless to have the algorithm name in the err_cnt member.

Signed-off-by: Corentin Labbe <clabbe@baylibre.com>
---
 crypto/crypto_user_stat.c       | 18 +++++++++---------
 include/crypto/acompress.h      |  4 ++--
 include/crypto/aead.h           |  4 ++--
 include/crypto/akcipher.h       |  8 ++++----
 include/crypto/hash.h           |  4 ++--
 include/crypto/kpp.h            |  6 +++---
 include/crypto/rng.h            |  4 ++--
 include/crypto/skcipher.h       |  4 ++--
 include/linux/crypto.h          | 32 ++++++++++++++++----------------
 include/uapi/linux/cryptouser.h | 14 +++++++-------
 tools/crypto/getstat.c          | 18 +++++++++---------
 11 files changed, 58 insertions(+), 58 deletions(-)

diff --git a/crypto/crypto_user_stat.c b/crypto/crypto_user_stat.c
index 113bf1691560..0ba00aaeb810 100644
--- a/crypto/crypto_user_stat.c
+++ b/crypto/crypto_user_stat.c
@@ -43,7 +43,7 @@ static int crypto_report_aead(struct sk_buff *skb, struct crypto_alg *alg)
 	raead.stat_encrypt_tlen = atomic64_read(&alg->stats.aead.encrypt_tlen);
 	raead.stat_decrypt_cnt = atomic64_read(&alg->stats.aead.decrypt_cnt);
 	raead.stat_decrypt_tlen = atomic64_read(&alg->stats.aead.decrypt_tlen);
-	raead.stat_aead_err_cnt = atomic64_read(&alg->stats.aead.aead_err_cnt);
+	raead.stat_err_cnt = atomic64_read(&alg->stats.aead.err_cnt);
 
 	return nla_put(skb, CRYPTOCFGA_STAT_AEAD, sizeof(raead), &raead);
 }
@@ -60,7 +60,7 @@ static int crypto_report_cipher(struct sk_buff *skb, struct crypto_alg *alg)
 	rcipher.stat_encrypt_tlen = atomic64_read(&alg->stats.cipher.encrypt_tlen);
 	rcipher.stat_decrypt_cnt =  atomic64_read(&alg->stats.cipher.decrypt_cnt);
 	rcipher.stat_decrypt_tlen = atomic64_read(&alg->stats.cipher.decrypt_tlen);
-	rcipher.stat_cipher_err_cnt =  atomic64_read(&alg->stats.cipher.cipher_err_cnt);
+	rcipher.stat_err_cnt =  atomic64_read(&alg->stats.cipher.err_cnt);
 
 	return nla_put(skb, CRYPTOCFGA_STAT_CIPHER, sizeof(rcipher), &rcipher);
 }
@@ -76,7 +76,7 @@ static int crypto_report_comp(struct sk_buff *skb, struct crypto_alg *alg)
 	rcomp.stat_compress_tlen = atomic64_read(&alg->stats.compress.compress_tlen);
 	rcomp.stat_decompress_cnt = atomic64_read(&alg->stats.compress.decompress_cnt);
 	rcomp.stat_decompress_tlen = atomic64_read(&alg->stats.compress.decompress_tlen);
-	rcomp.stat_compress_err_cnt = atomic64_read(&alg->stats.compress.compress_err_cnt);
+	rcomp.stat_err_cnt = atomic64_read(&alg->stats.compress.err_cnt);
 
 	return nla_put(skb, CRYPTOCFGA_STAT_COMPRESS, sizeof(rcomp), &rcomp);
 }
@@ -92,7 +92,7 @@ static int crypto_report_acomp(struct sk_buff *skb, struct crypto_alg *alg)
 	racomp.stat_compress_tlen = atomic64_read(&alg->stats.compress.compress_tlen);
 	racomp.stat_decompress_cnt =  atomic64_read(&alg->stats.compress.decompress_cnt);
 	racomp.stat_decompress_tlen = atomic64_read(&alg->stats.compress.decompress_tlen);
-	racomp.stat_compress_err_cnt = atomic64_read(&alg->stats.compress.compress_err_cnt);
+	racomp.stat_err_cnt = atomic64_read(&alg->stats.compress.err_cnt);
 
 	return nla_put(skb, CRYPTOCFGA_STAT_ACOMP, sizeof(racomp), &racomp);
 }
@@ -110,7 +110,7 @@ static int crypto_report_akcipher(struct sk_buff *skb, struct crypto_alg *alg)
 	rakcipher.stat_decrypt_tlen = atomic64_read(&alg->stats.akcipher.decrypt_tlen);
 	rakcipher.stat_sign_cnt = atomic64_read(&alg->stats.akcipher.sign_cnt);
 	rakcipher.stat_verify_cnt = atomic64_read(&alg->stats.akcipher.verify_cnt);
-	rakcipher.stat_akcipher_err_cnt = atomic64_read(&alg->stats.akcipher.akcipher_err_cnt);
+	rakcipher.stat_err_cnt = atomic64_read(&alg->stats.akcipher.err_cnt);
 
 	return nla_put(skb, CRYPTOCFGA_STAT_AKCIPHER,
 		       sizeof(rakcipher), &rakcipher);
@@ -127,7 +127,7 @@ static int crypto_report_kpp(struct sk_buff *skb, struct crypto_alg *alg)
 	rkpp.stat_setsecret_cnt = atomic64_read(&alg->stats.kpp.setsecret_cnt);
 	rkpp.stat_generate_public_key_cnt = atomic64_read(&alg->stats.kpp.generate_public_key_cnt);
 	rkpp.stat_compute_shared_secret_cnt = atomic64_read(&alg->stats.kpp.compute_shared_secret_cnt);
-	rkpp.stat_kpp_err_cnt = atomic64_read(&alg->stats.kpp.kpp_err_cnt);
+	rkpp.stat_err_cnt = atomic64_read(&alg->stats.kpp.err_cnt);
 
 	return nla_put(skb, CRYPTOCFGA_STAT_KPP, sizeof(rkpp), &rkpp);
 }
@@ -142,7 +142,7 @@ static int crypto_report_ahash(struct sk_buff *skb, struct crypto_alg *alg)
 
 	rhash.stat_hash_cnt = atomic64_read(&alg->stats.hash.hash_cnt);
 	rhash.stat_hash_tlen = atomic64_read(&alg->stats.hash.hash_tlen);
-	rhash.stat_hash_err_cnt = atomic64_read(&alg->stats.hash.hash_err_cnt);
+	rhash.stat_err_cnt = atomic64_read(&alg->stats.hash.err_cnt);
 
 	return nla_put(skb, CRYPTOCFGA_STAT_HASH, sizeof(rhash), &rhash);
 }
@@ -157,7 +157,7 @@ static int crypto_report_shash(struct sk_buff *skb, struct crypto_alg *alg)
 
 	rhash.stat_hash_cnt =  atomic64_read(&alg->stats.hash.hash_cnt);
 	rhash.stat_hash_tlen = atomic64_read(&alg->stats.hash.hash_tlen);
-	rhash.stat_hash_err_cnt = atomic64_read(&alg->stats.hash.hash_err_cnt);
+	rhash.stat_err_cnt = atomic64_read(&alg->stats.hash.err_cnt);
 
 	return nla_put(skb, CRYPTOCFGA_STAT_HASH, sizeof(rhash), &rhash);
 }
@@ -173,7 +173,7 @@ static int crypto_report_rng(struct sk_buff *skb, struct crypto_alg *alg)
 	rrng.stat_generate_cnt = atomic64_read(&alg->stats.rng.generate_cnt);
 	rrng.stat_generate_tlen = atomic64_read(&alg->stats.rng.generate_tlen);
 	rrng.stat_seed_cnt = atomic64_read(&alg->stats.rng.seed_cnt);
-	rrng.stat_rng_err_cnt = atomic64_read(&alg->stats.rng.rng_err_cnt);
+	rrng.stat_err_cnt = atomic64_read(&alg->stats.rng.err_cnt);
 
 	return nla_put(skb, CRYPTOCFGA_STAT_RNG, sizeof(rrng), &rrng);
 }
diff --git a/include/crypto/acompress.h b/include/crypto/acompress.h
index ba0b834d355a..bc3d4742c503 100644
--- a/include/crypto/acompress.h
+++ b/include/crypto/acompress.h
@@ -239,7 +239,7 @@ static inline void crypto_stat_compress(unsigned int slen, int ret,
 {
 #ifdef CONFIG_CRYPTO_STATS
 	if (ret && ret != -EINPROGRESS && ret != -EBUSY) {
-		atomic64_inc(&alg->stats.compress.compress_err_cnt);
+		atomic64_inc(&alg->stats.compress.err_cnt);
 	} else {
 		atomic64_inc(&alg->stats.compress.compress_cnt);
 		atomic64_add(slen, &alg->stats.compress.compress_tlen);
@@ -253,7 +253,7 @@ static inline void crypto_stat_decompress(unsigned int slen, int ret,
 {
 #ifdef CONFIG_CRYPTO_STATS
 	if (ret && ret != -EINPROGRESS && ret != -EBUSY) {
-		atomic64_inc(&alg->stats.compress.compress_err_cnt);
+		atomic64_inc(&alg->stats.compress.err_cnt);
 	} else {
 		atomic64_inc(&alg->stats.compress.decompress_cnt);
 		atomic64_add(slen, &alg->stats.compress.decompress_tlen);
diff --git a/include/crypto/aead.h b/include/crypto/aead.h
index 2b0c73de6a2f..1e4ff5fc60aa 100644
--- a/include/crypto/aead.h
+++ b/include/crypto/aead.h
@@ -311,7 +311,7 @@ static inline void crypto_stat_aead_encrypt(unsigned int cryptlen,
 {
 #ifdef CONFIG_CRYPTO_STATS
 	if (ret && ret != -EINPROGRESS && ret != -EBUSY) {
-		atomic64_inc(&alg->stats.aead.aead_err_cnt);
+		atomic64_inc(&alg->stats.aead.err_cnt);
 	} else {
 		atomic64_inc(&alg->stats.aead.encrypt_cnt);
 		atomic64_add(cryptlen, &alg->stats.aead.encrypt_tlen);
@@ -325,7 +325,7 @@ static inline void crypto_stat_aead_decrypt(unsigned int cryptlen,
 {
 #ifdef CONFIG_CRYPTO_STATS
 	if (ret && ret != -EINPROGRESS && ret != -EBUSY) {
-		atomic64_inc(&alg->stats.aead.aead_err_cnt);
+		atomic64_inc(&alg->stats.aead.err_cnt);
 	} else {
 		atomic64_inc(&alg->stats.aead.decrypt_cnt);
 		atomic64_add(cryptlen, &alg->stats.aead.decrypt_tlen);
diff --git a/include/crypto/akcipher.h b/include/crypto/akcipher.h
index af34ce4306bd..11dd45693c29 100644
--- a/include/crypto/akcipher.h
+++ b/include/crypto/akcipher.h
@@ -276,7 +276,7 @@ static inline void crypto_stat_akcipher_encrypt(unsigned int src_len, int ret,
 {
 #ifdef CONFIG_CRYPTO_STATS
 	if (ret && ret != -EINPROGRESS && ret != -EBUSY) {
-		atomic64_inc(&alg->stats.akcipher.akcipher_err_cnt);
+		atomic64_inc(&alg->stats.akcipher.err_cnt);
 	} else {
 		atomic64_inc(&alg->stats.akcipher.encrypt_cnt);
 		atomic64_add(src_len, &alg->stats.akcipher.encrypt_tlen);
@@ -290,7 +290,7 @@ static inline void crypto_stat_akcipher_decrypt(unsigned int src_len, int ret,
 {
 #ifdef CONFIG_CRYPTO_STATS
 	if (ret && ret != -EINPROGRESS && ret != -EBUSY) {
-		atomic64_inc(&alg->stats.akcipher.akcipher_err_cnt);
+		atomic64_inc(&alg->stats.akcipher.err_cnt);
 	} else {
 		atomic64_inc(&alg->stats.akcipher.decrypt_cnt);
 		atomic64_add(src_len, &alg->stats.akcipher.decrypt_tlen);
@@ -303,7 +303,7 @@ static inline void crypto_stat_akcipher_sign(int ret, struct crypto_alg *alg)
 {
 #ifdef CONFIG_CRYPTO_STATS
 	if (ret && ret != -EINPROGRESS && ret != -EBUSY)
-		atomic64_inc(&alg->stats.akcipher.akcipher_err_cnt);
+		atomic64_inc(&alg->stats.akcipher.err_cnt);
 	else
 		atomic64_inc(&alg->stats.akcipher.sign_cnt);
 	crypto_alg_put(alg);
@@ -314,7 +314,7 @@ static inline void crypto_stat_akcipher_verify(int ret, struct crypto_alg *alg)
 {
 #ifdef CONFIG_CRYPTO_STATS
 	if (ret && ret != -EINPROGRESS && ret != -EBUSY)
-		atomic64_inc(&alg->stats.akcipher.akcipher_err_cnt);
+		atomic64_inc(&alg->stats.akcipher.err_cnt);
 	else
 		atomic64_inc(&alg->stats.akcipher.verify_cnt);
 	crypto_alg_put(alg);
diff --git a/include/crypto/hash.h b/include/crypto/hash.h
index a88a4695ac09..1ee4150d4fc7 100644
--- a/include/crypto/hash.h
+++ b/include/crypto/hash.h
@@ -417,7 +417,7 @@ static inline void crypto_stat_ahash_update(unsigned int nbytes, int ret,
 {
 #ifdef CONFIG_CRYPTO_STATS
 	if (ret && ret != -EINPROGRESS && ret != -EBUSY)
-		atomic64_inc(&alg->stats.hash.hash_err_cnt);
+		atomic64_inc(&alg->stats.hash.err_cnt);
 	else
 		atomic64_add(nbytes, &alg->stats.hash.hash_tlen);
 	crypto_alg_put(alg);
@@ -429,7 +429,7 @@ static inline void crypto_stat_ahash_final(unsigned int nbytes, int ret,
 {
 #ifdef CONFIG_CRYPTO_STATS
 	if (ret && ret != -EINPROGRESS && ret != -EBUSY) {
-		atomic64_inc(&alg->stats.hash.hash_err_cnt);
+		atomic64_inc(&alg->stats.hash.err_cnt);
 	} else {
 		atomic64_inc(&alg->stats.hash.hash_cnt);
 		atomic64_add(nbytes, &alg->stats.hash.hash_tlen);
diff --git a/include/crypto/kpp.h b/include/crypto/kpp.h
index 29ab4c4cd902..8b78e5012533 100644
--- a/include/crypto/kpp.h
+++ b/include/crypto/kpp.h
@@ -272,7 +272,7 @@ static inline void crypto_stat_kpp_set_secret(struct crypto_alg *alg, int ret)
 {
 #ifdef CONFIG_CRYPTO_STATS
 	if (ret)
-		atomic64_inc(&alg->stats.kpp.kpp_err_cnt);
+		atomic64_inc(&alg->stats.kpp.err_cnt);
 	else
 		atomic64_inc(&alg->stats.kpp.setsecret_cnt);
 	crypto_alg_put(alg);
@@ -284,7 +284,7 @@ static inline void crypto_stat_kpp_generate_public_key(struct crypto_alg *alg,
 {
 #ifdef CONFIG_CRYPTO_STATS
 	if (ret)
-		atomic64_inc(&alg->stats.kpp.kpp_err_cnt);
+		atomic64_inc(&alg->stats.kpp.err_cnt);
 	else
 		atomic64_inc(&alg->stats.kpp.generate_public_key_cnt);
 	crypto_alg_put(alg);
@@ -296,7 +296,7 @@ static inline void crypto_stat_kpp_compute_shared_secret(struct crypto_alg *alg,
 {
 #ifdef CONFIG_CRYPTO_STATS
 	if (ret)
-		atomic64_inc(&alg->stats.kpp.kpp_err_cnt);
+		atomic64_inc(&alg->stats.kpp.err_cnt);
 	else
 		atomic64_inc(&alg->stats.kpp.compute_shared_secret_cnt);
 	crypto_alg_put(alg);
diff --git a/include/crypto/rng.h b/include/crypto/rng.h
index d15a27931517..3567c24bd005 100644
--- a/include/crypto/rng.h
+++ b/include/crypto/rng.h
@@ -126,7 +126,7 @@ static inline void crypto_stat_rng_seed(struct crypto_alg *alg, int ret)
 {
 #ifdef CONFIG_CRYPTO_STATS
 	if (ret && ret != -EINPROGRESS && ret != -EBUSY)
-		atomic64_inc(&alg->stats.rng.rng_err_cnt);
+		atomic64_inc(&alg->stats.rng.err_cnt);
 	else
 		atomic64_inc(&alg->stats.rng.seed_cnt);
 	crypto_alg_put(alg);
@@ -138,7 +138,7 @@ static inline void crypto_stat_rng_generate(struct crypto_alg *alg,
 {
 #ifdef CONFIG_CRYPTO_STATS
 	if (ret && ret != -EINPROGRESS && ret != -EBUSY) {
-		atomic64_inc(&alg->stats.rng.rng_err_cnt);
+		atomic64_inc(&alg->stats.rng.err_cnt);
 	} else {
 		atomic64_inc(&alg->stats.rng.generate_cnt);
 		atomic64_add(dlen, &alg->stats.rng.generate_tlen);
diff --git a/include/crypto/skcipher.h b/include/crypto/skcipher.h
index 87eee1dc536a..63582d07cdfc 100644
--- a/include/crypto/skcipher.h
+++ b/include/crypto/skcipher.h
@@ -491,7 +491,7 @@ static inline void crypto_stat_skcipher_encrypt(unsigned int cryptlen,
 {
 #ifdef CONFIG_CRYPTO_STATS
 	if (ret && ret != -EINPROGRESS && ret != -EBUSY) {
-		atomic64_inc(&alg->stats.cipher.cipher_err_cnt);
+		atomic64_inc(&alg->stats.cipher.err_cnt);
 	} else {
 		atomic64_inc(&alg->stats.cipher.encrypt_cnt);
 		atomic64_add(cryptlen, &alg->stats.cipher.encrypt_tlen);
@@ -505,7 +505,7 @@ static inline void crypto_stat_skcipher_decrypt(unsigned int cryptlen,
 {
 #ifdef CONFIG_CRYPTO_STATS
 	if (ret && ret != -EINPROGRESS && ret != -EBUSY) {
-		atomic64_inc(&alg->stats.cipher.cipher_err_cnt);
+		atomic64_inc(&alg->stats.cipher.err_cnt);
 	} else {
 		atomic64_inc(&alg->stats.cipher.decrypt_cnt);
 		atomic64_add(cryptlen, &alg->stats.cipher.decrypt_tlen);
diff --git a/include/linux/crypto.h b/include/linux/crypto.h
index 48499b91fe4a..344be089d787 100644
--- a/include/linux/crypto.h
+++ b/include/linux/crypto.h
@@ -376,14 +376,14 @@ struct compress_alg {
  * @encrypt_tlen:	total data size handled by encrypt requests
  * @decrypt_cnt:	number of decrypt requests
  * @decrypt_tlen:	total data size handled by decrypt requests
- * @aead_err_cnt:	number of error for AEAD requests
+ * @err_cnt:		number of error for AEAD requests
  */
 struct crypto_istat_aead {
 	atomic64_t encrypt_cnt;
 	atomic64_t encrypt_tlen;
 	atomic64_t decrypt_cnt;
 	atomic64_t decrypt_tlen;
-	atomic64_t aead_err_cnt;
+	atomic64_t err_cnt;
 };
 
 /*
@@ -394,7 +394,7 @@ struct crypto_istat_aead {
  * @decrypt_tlen:	total data size handled by decrypt requests
  * @verify_cnt:		number of verify operation
  * @sign_cnt:		number of sign requests
- * @akcipher_err_cnt:	number of error for akcipher requests
+ * @err_cnt:		number of error for akcipher requests
  */
 struct crypto_istat_akcipher {
 	atomic64_t encrypt_cnt;
@@ -403,7 +403,7 @@ struct crypto_istat_akcipher {
 	atomic64_t decrypt_tlen;
 	atomic64_t verify_cnt;
 	atomic64_t sign_cnt;
-	atomic64_t akcipher_err_cnt;
+	atomic64_t err_cnt;
 };
 
 /*
@@ -412,14 +412,14 @@ struct crypto_istat_akcipher {
  * @encrypt_tlen:	total data size handled by encrypt requests
  * @decrypt_cnt:	number of decrypt requests
  * @decrypt_tlen:	total data size handled by decrypt requests
- * @cipher_err_cnt:	number of error for cipher requests
+ * @err_cnt:		number of error for cipher requests
  */
 struct crypto_istat_cipher {
 	atomic64_t encrypt_cnt;
 	atomic64_t encrypt_tlen;
 	atomic64_t decrypt_cnt;
 	atomic64_t decrypt_tlen;
-	atomic64_t cipher_err_cnt;
+	atomic64_t err_cnt;
 };
 
 /*
@@ -428,26 +428,26 @@ struct crypto_istat_cipher {
  * @compress_tlen:	total data size handled by compress requests
  * @decompress_cnt:	number of decompress requests
  * @decompress_tlen:	total data size handled by decompress requests
- * @compress_err_cnt:	number of error for compress requests
+ * @err_cnt:		number of error for compress requests
  */
 struct crypto_istat_compress {
 	atomic64_t compress_cnt;
 	atomic64_t compress_tlen;
 	atomic64_t decompress_cnt;
 	atomic64_t decompress_tlen;
-	atomic64_t compress_err_cnt;
+	atomic64_t err_cnt;
 };
 
 /*
  * struct crypto_istat_hash - statistics for has algorithm
  * @hash_cnt:		number of hash requests
  * @hash_tlen:		total data size hashed
- * @hash_err_cnt:	number of error for hash requests
+ * @err_cnt:		number of error for hash requests
  */
 struct crypto_istat_hash {
 	atomic64_t hash_cnt;
 	atomic64_t hash_tlen;
-	atomic64_t hash_err_cnt;
+	atomic64_t err_cnt;
 };
 
 /*
@@ -455,13 +455,13 @@ struct crypto_istat_hash {
  * @setsecret_cnt:		number of setsecrey operation
  * @generate_public_key_cnt:	number of generate_public_key operation
  * @compute_shared_secret_cnt:	number of compute_shared_secret operation
- * @kpp_err_cnt:		number of error for KPP requests
+ * @err_cnt:			number of error for KPP requests
  */
 struct crypto_istat_kpp {
 	atomic64_t setsecret_cnt;
 	atomic64_t generate_public_key_cnt;
 	atomic64_t compute_shared_secret_cnt;
-	atomic64_t kpp_err_cnt;
+	atomic64_t err_cnt;
 };
 
 /*
@@ -469,13 +469,13 @@ struct crypto_istat_kpp {
  * @generate_cnt:	number of RNG generate requests
  * @generate_tlen:	total data size of generated data by the RNG
  * @seed_cnt:		number of times the RNG was seeded
- * @rng_err_cnt:	number of error for RNG requests
+ * @err_cnt:		number of error for RNG requests
  */
 struct crypto_istat_rng {
 	atomic64_t generate_cnt;
 	atomic64_t generate_tlen;
 	atomic64_t seed_cnt;
-	atomic64_t rng_err_cnt;
+	atomic64_t err_cnt;
 };
 #endif /* CONFIG_CRYPTO_STATS */
 
@@ -1048,7 +1048,7 @@ static inline void crypto_stat_ablkcipher_encrypt(unsigned int nbytes, int ret,
 {
 #ifdef CONFIG_CRYPTO_STATS
 	if (ret && ret != -EINPROGRESS && ret != -EBUSY) {
-		atomic64_inc(&alg->stats.cipher.cipher_err_cnt);
+		atomic64_inc(&alg->stats.cipher.err_cnt);
 	} else {
 		atomic64_inc(&alg->stats.cipher.encrypt_cnt);
 		atomic64_add(nbytes, &alg->stats.cipher.encrypt_tlen);
@@ -1062,7 +1062,7 @@ static inline void crypto_stat_ablkcipher_decrypt(unsigned int nbytes, int ret,
 {
 #ifdef CONFIG_CRYPTO_STATS
 	if (ret && ret != -EINPROGRESS && ret != -EBUSY) {
-		atomic64_inc(&alg->stats.cipher.cipher_err_cnt);
+		atomic64_inc(&alg->stats.cipher.err_cnt);
 	} else {
 		atomic64_inc(&alg->stats.cipher.decrypt_cnt);
 		atomic64_add(nbytes, &alg->stats.cipher.decrypt_tlen);
diff --git a/include/uapi/linux/cryptouser.h b/include/uapi/linux/cryptouser.h
index 3a70f025e27d..4dc1603919ce 100644
--- a/include/uapi/linux/cryptouser.h
+++ b/include/uapi/linux/cryptouser.h
@@ -82,7 +82,7 @@ struct crypto_stat_aead {
 	__u64 stat_encrypt_tlen;
 	__u64 stat_decrypt_cnt;
 	__u64 stat_decrypt_tlen;
-	__u64 stat_aead_err_cnt;
+	__u64 stat_err_cnt;
 };
 
 struct crypto_stat_akcipher {
@@ -93,7 +93,7 @@ struct crypto_stat_akcipher {
 	__u64 stat_decrypt_tlen;
 	__u64 stat_verify_cnt;
 	__u64 stat_sign_cnt;
-	__u64 stat_akcipher_err_cnt;
+	__u64 stat_err_cnt;
 };
 
 struct crypto_stat_cipher {
@@ -102,7 +102,7 @@ struct crypto_stat_cipher {
 	__u64 stat_encrypt_tlen;
 	__u64 stat_decrypt_cnt;
 	__u64 stat_decrypt_tlen;
-	__u64 stat_cipher_err_cnt;
+	__u64 stat_err_cnt;
 };
 
 struct crypto_stat_compress {
@@ -111,14 +111,14 @@ struct crypto_stat_compress {
 	__u64 stat_compress_tlen;
 	__u64 stat_decompress_cnt;
 	__u64 stat_decompress_tlen;
-	__u64 stat_compress_err_cnt;
+	__u64 stat_err_cnt;
 };
 
 struct crypto_stat_hash {
 	char type[CRYPTO_MAX_NAME];
 	__u64 stat_hash_cnt;
 	__u64 stat_hash_tlen;
-	__u64 stat_hash_err_cnt;
+	__u64 stat_err_cnt;
 };
 
 struct crypto_stat_kpp {
@@ -126,7 +126,7 @@ struct crypto_stat_kpp {
 	__u64 stat_setsecret_cnt;
 	__u64 stat_generate_public_key_cnt;
 	__u64 stat_compute_shared_secret_cnt;
-	__u64 stat_kpp_err_cnt;
+	__u64 stat_err_cnt;
 };
 
 struct crypto_stat_rng {
@@ -134,7 +134,7 @@ struct crypto_stat_rng {
 	__u64 stat_generate_cnt;
 	__u64 stat_generate_tlen;
 	__u64 stat_seed_cnt;
-	__u64 stat_rng_err_cnt;
+	__u64 stat_err_cnt;
 };
 
 struct crypto_stat_larval {
diff --git a/tools/crypto/getstat.c b/tools/crypto/getstat.c
index 57fbb94608d4..9e8ff76420fa 100644
--- a/tools/crypto/getstat.c
+++ b/tools/crypto/getstat.c
@@ -157,7 +157,7 @@ static int get_stat(const char *drivername)
 		printf("%s\tHash\n\tHash: %llu bytes: %llu\n\tErrors: %llu\n",
 			drivername,
 			rhash->stat_hash_cnt, rhash->stat_hash_tlen,
-			rhash->stat_hash_err_cnt);
+			rhash->stat_err_cnt);
 	} else if (tb[CRYPTOCFGA_STAT_COMPRESS]) {
 		struct rtattr *rta = tb[CRYPTOCFGA_STAT_COMPRESS];
 		struct crypto_stat_compress *rblk =
@@ -166,7 +166,7 @@ static int get_stat(const char *drivername)
 			drivername,
 			rblk->stat_compress_cnt, rblk->stat_compress_tlen,
 			rblk->stat_decompress_cnt, rblk->stat_decompress_tlen,
-			rblk->stat_compress_err_cnt);
+			rblk->stat_err_cnt);
 	} else if (tb[CRYPTOCFGA_STAT_ACOMP]) {
 		struct rtattr *rta = tb[CRYPTOCFGA_STAT_ACOMP];
 		struct crypto_stat_compress *rcomp =
@@ -175,7 +175,7 @@ static int get_stat(const char *drivername)
 			drivername,
 			rcomp->stat_compress_cnt, rcomp->stat_compress_tlen,
 			rcomp->stat_decompress_cnt, rcomp->stat_decompress_tlen,
-			rcomp->stat_compress_err_cnt);
+			rcomp->stat_err_cnt);
 	} else if (tb[CRYPTOCFGA_STAT_AEAD]) {
 		struct rtattr *rta = tb[CRYPTOCFGA_STAT_AEAD];
 		struct crypto_stat_aead *raead =
@@ -184,7 +184,7 @@ static int get_stat(const char *drivername)
 			drivername,
 			raead->stat_encrypt_cnt, raead->stat_encrypt_tlen,
 			raead->stat_decrypt_cnt, raead->stat_decrypt_tlen,
-			raead->stat_aead_err_cnt);
+			raead->stat_err_cnt);
 	} else if (tb[CRYPTOCFGA_STAT_BLKCIPHER]) {
 		struct rtattr *rta = tb[CRYPTOCFGA_STAT_BLKCIPHER];
 		struct crypto_stat_cipher *rblk =
@@ -193,7 +193,7 @@ static int get_stat(const char *drivername)
 			drivername,
 			rblk->stat_encrypt_cnt, rblk->stat_encrypt_tlen,
 			rblk->stat_decrypt_cnt, rblk->stat_decrypt_tlen,
-			rblk->stat_cipher_err_cnt);
+			rblk->stat_err_cnt);
 	} else if (tb[CRYPTOCFGA_STAT_AKCIPHER]) {
 		struct rtattr *rta = tb[CRYPTOCFGA_STAT_AKCIPHER];
 		struct crypto_stat_akcipher *rblk =
@@ -203,7 +203,7 @@ static int get_stat(const char *drivername)
 			rblk->stat_encrypt_cnt, rblk->stat_encrypt_tlen,
 			rblk->stat_decrypt_cnt, rblk->stat_decrypt_tlen,
 			rblk->stat_sign_cnt, rblk->stat_verify_cnt,
-			rblk->stat_akcipher_err_cnt);
+			rblk->stat_err_cnt);
 	} else if (tb[CRYPTOCFGA_STAT_CIPHER]) {
 		struct rtattr *rta = tb[CRYPTOCFGA_STAT_CIPHER];
 		struct crypto_stat_cipher *rblk =
@@ -212,7 +212,7 @@ static int get_stat(const char *drivername)
 			drivername,
 			rblk->stat_encrypt_cnt, rblk->stat_encrypt_tlen,
 			rblk->stat_decrypt_cnt, rblk->stat_decrypt_tlen,
-			rblk->stat_cipher_err_cnt);
+			rblk->stat_err_cnt);
 	} else if (tb[CRYPTOCFGA_STAT_RNG]) {
 		struct rtattr *rta = tb[CRYPTOCFGA_STAT_RNG];
 		struct crypto_stat_rng *rrng =
@@ -221,7 +221,7 @@ static int get_stat(const char *drivername)
 			drivername,
 			rrng->stat_seed_cnt,
 			rrng->stat_generate_cnt, rrng->stat_generate_tlen,
-			rrng->stat_rng_err_cnt);
+			rrng->stat_err_cnt);
 	} else if (tb[CRYPTOCFGA_STAT_KPP]) {
 		struct rtattr *rta = tb[CRYPTOCFGA_STAT_KPP];
 		struct crypto_stat_kpp *rkpp =
@@ -231,7 +231,7 @@ static int get_stat(const char *drivername)
 			rkpp->stat_setsecret_cnt,
 			rkpp->stat_generate_public_key_cnt,
 			rkpp->stat_compute_shared_secret_cnt,
-			rkpp->stat_kpp_err_cnt);
+			rkpp->stat_err_cnt);
 	} else {
 		fprintf(stderr, "%s is of an unknown algorithm\n", drivername);
 	}
-- 
2.18.1

