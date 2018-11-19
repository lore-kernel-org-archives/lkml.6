Return-Path: <SRS0=tadO=N6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6341C43610
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 19:53:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5D39A20831
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 19:53:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="kCUHPjan"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5D39A20831
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730697AbeKTGS7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Nov 2018 01:18:59 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:46889 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730591AbeKTGS6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Nov 2018 01:18:58 -0500
Received: by mail-wr1-f68.google.com with SMTP id l9so20478388wrt.13
        for <linux-kernel@vger.kernel.org>; Mon, 19 Nov 2018 11:53:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=fw0tsC/WlysUEo/SnPHksOSlM+Qdc29Zn/D5BPg2H4E=;
        b=kCUHPjanxMiPfZDTnUdr0Hm1lve3qUU8yT/jYslZzn0BcheJEhnbROg1qAZg2aly6N
         QKlj/bnah2au7esaCX0IVakAq0WSF9rE8soVc7LERDb0ckWe+7vC3Ty/9IkAUYuZ9wzS
         ZuB1Rr2PcuB+XEKsQ6kZlsBk9SaSex0B1HZqnAaBOptMTssNjW4Ao5uwVIwsikaqPNJo
         pLdfbFfzSF21nNN9LclUkTDg+ZQTBleh4s7Yk9m+8cY+luMZ+JWXyQYOZFJepFnn0ZGC
         WuxpC6cDbuEQW8ZEcIR0x4U8F3e61biYu0ne7Told9WyHWNVbLW0acoVadjaIbsWGtVl
         +K8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=fw0tsC/WlysUEo/SnPHksOSlM+Qdc29Zn/D5BPg2H4E=;
        b=XCyjv4E8DHokLCG/rLlmtuHdreVU4mGcO16eRnMoj/BUiK6ebgdGR655enlUDNb75O
         lAlX2QJ9gY9q4NCXXXfcaKTwWWwyCT+k4EpBoOCM5kzfbdbpnWprB73qmDWnVXo/h51Z
         9x2Wu/6PulL1mcyKOgeMfZZdBPyDHdB6eE2CVH4vjqsUIdSLX78izgfGMxciud/PxM4j
         Ate5l0tcSDlEEs0V6Li3Gn1Nnh91oXSjclPuYg/ba61gesjcQvasz/ev6D/TvevCathA
         8qYmhDAfn/WAPPkKOz1CW4P9wvxZ3P8uciZmWY6bmpYLh3hPYYQQETvWGOlYPvKvDMPb
         0TkQ==
X-Gm-Message-State: AGRZ1gJu3sIbaN1dvrfFyyh7RYPiYfvs3Px2VK9mV7cdUrzSwwwAUsds
        A/+8vzZJ43KGRoOTYSGL/buc9Q==
X-Google-Smtp-Source: AJdET5fDKf+S0TK+fojvmLHPrgowHWDJs1SEE0H4QscWBfViccvemHAWb/7uUQVofBdXYAaZLX+iQw==
X-Received: by 2002:a5d:4cc6:: with SMTP id c6-v6mr19010966wrt.75.1542657226218;
        Mon, 19 Nov 2018 11:53:46 -0800 (PST)
Received: from localhost.localdomain ([51.15.160.169])
        by smtp.googlemail.com with ESMTPSA id i16sm22954132wmd.28.2018.11.19.11.53.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 19 Nov 2018 11:53:45 -0800 (PST)
From:   Corentin Labbe <clabbe@baylibre.com>
To:     davem@davemloft.net, ebiggers@kernel.org,
        herbert@gondor.apana.org.au, nhorman@tuxdriver.com
Cc:     linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        Corentin Labbe <clabbe@baylibre.com>
Subject: [PATCH v2 10/11] crypto: crypto_user_stat: Split stats in multiple structures
Date:   Mon, 19 Nov 2018 19:53:29 +0000
Message-Id: <1542657210-37739-11-git-send-email-clabbe@baylibre.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1542657210-37739-1-git-send-email-clabbe@baylibre.com>
References: <1542657210-37739-1-git-send-email-clabbe@baylibre.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Like for userspace, this patch splits stats into multiple structures,
one for each algorithm class.
Signed-off-by: Corentin Labbe <clabbe@baylibre.com>
---
 crypto/algapi.c            |   8 +-
 crypto/crypto_user_stat.c  |  82 ++++++++--------
 include/crypto/acompress.h |  12 +--
 include/crypto/aead.h      |  12 +--
 include/crypto/akcipher.h  |  20 ++--
 include/crypto/hash.h      |  10 +-
 include/crypto/kpp.h       |  12 +--
 include/crypto/rng.h       |  10 +-
 include/crypto/skcipher.h  |  12 +--
 include/linux/crypto.h     | 192 ++++++++++++++++++++++++-------------
 10 files changed, 210 insertions(+), 160 deletions(-)

diff --git a/crypto/algapi.c b/crypto/algapi.c
index 42fe316f80ee..1c1e0c299272 100644
--- a/crypto/algapi.c
+++ b/crypto/algapi.c
@@ -259,13 +259,7 @@ static struct crypto_larval *__crypto_register_alg(struct crypto_alg *alg)
 	list_add(&larval->alg.cra_list, &crypto_alg_list);
 
 #ifdef CONFIG_CRYPTO_STATS
-	atomic64_set(&alg->encrypt_cnt, 0);
-	atomic64_set(&alg->decrypt_cnt, 0);
-	atomic64_set(&alg->encrypt_tlen, 0);
-	atomic64_set(&alg->decrypt_tlen, 0);
-	atomic64_set(&alg->verify_cnt, 0);
-	atomic64_set(&alg->cipher_err_cnt, 0);
-	atomic64_set(&alg->sign_cnt, 0);
+	memset(&alg->stats, 0, sizeof(alg->stats));
 #endif
 
 out:
diff --git a/crypto/crypto_user_stat.c b/crypto/crypto_user_stat.c
index 7b668c659122..113bf1691560 100644
--- a/crypto/crypto_user_stat.c
+++ b/crypto/crypto_user_stat.c
@@ -39,11 +39,11 @@ static int crypto_report_aead(struct sk_buff *skb, struct crypto_alg *alg)
 
 	strscpy(raead.type, "aead", sizeof(raead.type));
 
-	raead.stat_encrypt_cnt = atomic64_read(&alg->encrypt_cnt);
-	raead.stat_encrypt_tlen = atomic64_read(&alg->encrypt_tlen);
-	raead.stat_decrypt_cnt = atomic64_read(&alg->decrypt_cnt);
-	raead.stat_decrypt_tlen = atomic64_read(&alg->decrypt_tlen);
-	raead.stat_aead_err_cnt = atomic64_read(&alg->aead_err_cnt);
+	raead.stat_encrypt_cnt = atomic64_read(&alg->stats.aead.encrypt_cnt);
+	raead.stat_encrypt_tlen = atomic64_read(&alg->stats.aead.encrypt_tlen);
+	raead.stat_decrypt_cnt = atomic64_read(&alg->stats.aead.decrypt_cnt);
+	raead.stat_decrypt_tlen = atomic64_read(&alg->stats.aead.decrypt_tlen);
+	raead.stat_aead_err_cnt = atomic64_read(&alg->stats.aead.aead_err_cnt);
 
 	return nla_put(skb, CRYPTOCFGA_STAT_AEAD, sizeof(raead), &raead);
 }
@@ -56,11 +56,11 @@ static int crypto_report_cipher(struct sk_buff *skb, struct crypto_alg *alg)
 
 	strscpy(rcipher.type, "cipher", sizeof(rcipher.type));
 
-	rcipher.stat_encrypt_cnt = atomic64_read(&alg->encrypt_cnt);
-	rcipher.stat_encrypt_tlen = atomic64_read(&alg->encrypt_tlen);
-	rcipher.stat_decrypt_cnt =  atomic64_read(&alg->decrypt_cnt);
-	rcipher.stat_decrypt_tlen = atomic64_read(&alg->decrypt_tlen);
-	rcipher.stat_cipher_err_cnt =  atomic64_read(&alg->cipher_err_cnt);
+	rcipher.stat_encrypt_cnt = atomic64_read(&alg->stats.cipher.encrypt_cnt);
+	rcipher.stat_encrypt_tlen = atomic64_read(&alg->stats.cipher.encrypt_tlen);
+	rcipher.stat_decrypt_cnt =  atomic64_read(&alg->stats.cipher.decrypt_cnt);
+	rcipher.stat_decrypt_tlen = atomic64_read(&alg->stats.cipher.decrypt_tlen);
+	rcipher.stat_cipher_err_cnt =  atomic64_read(&alg->stats.cipher.cipher_err_cnt);
 
 	return nla_put(skb, CRYPTOCFGA_STAT_CIPHER, sizeof(rcipher), &rcipher);
 }
@@ -72,11 +72,11 @@ static int crypto_report_comp(struct sk_buff *skb, struct crypto_alg *alg)
 	memset(&rcomp, 0, sizeof(rcomp));
 
 	strscpy(rcomp.type, "compression", sizeof(rcomp.type));
-	rcomp.stat_compress_cnt = atomic64_read(&alg->compress_cnt);
-	rcomp.stat_compress_tlen = atomic64_read(&alg->compress_tlen);
-	rcomp.stat_decompress_cnt = atomic64_read(&alg->decompress_cnt);
-	rcomp.stat_decompress_tlen = atomic64_read(&alg->decompress_tlen);
-	rcomp.stat_compress_err_cnt = atomic64_read(&alg->compress_err_cnt);
+	rcomp.stat_compress_cnt = atomic64_read(&alg->stats.compress.compress_cnt);
+	rcomp.stat_compress_tlen = atomic64_read(&alg->stats.compress.compress_tlen);
+	rcomp.stat_decompress_cnt = atomic64_read(&alg->stats.compress.decompress_cnt);
+	rcomp.stat_decompress_tlen = atomic64_read(&alg->stats.compress.decompress_tlen);
+	rcomp.stat_compress_err_cnt = atomic64_read(&alg->stats.compress.compress_err_cnt);
 
 	return nla_put(skb, CRYPTOCFGA_STAT_COMPRESS, sizeof(rcomp), &rcomp);
 }
@@ -88,11 +88,11 @@ static int crypto_report_acomp(struct sk_buff *skb, struct crypto_alg *alg)
 	memset(&racomp, 0, sizeof(racomp));
 
 	strscpy(racomp.type, "acomp", sizeof(racomp.type));
-	racomp.stat_compress_cnt = atomic64_read(&alg->compress_cnt);
-	racomp.stat_compress_tlen = atomic64_read(&alg->compress_tlen);
-	racomp.stat_decompress_cnt =  atomic64_read(&alg->decompress_cnt);
-	racomp.stat_decompress_tlen = atomic64_read(&alg->decompress_tlen);
-	racomp.stat_compress_err_cnt = atomic64_read(&alg->compress_err_cnt);
+	racomp.stat_compress_cnt = atomic64_read(&alg->stats.compress.compress_cnt);
+	racomp.stat_compress_tlen = atomic64_read(&alg->stats.compress.compress_tlen);
+	racomp.stat_decompress_cnt =  atomic64_read(&alg->stats.compress.decompress_cnt);
+	racomp.stat_decompress_tlen = atomic64_read(&alg->stats.compress.decompress_tlen);
+	racomp.stat_compress_err_cnt = atomic64_read(&alg->stats.compress.compress_err_cnt);
 
 	return nla_put(skb, CRYPTOCFGA_STAT_ACOMP, sizeof(racomp), &racomp);
 }
@@ -104,13 +104,13 @@ static int crypto_report_akcipher(struct sk_buff *skb, struct crypto_alg *alg)
 	memset(&rakcipher, 0, sizeof(rakcipher));
 
 	strscpy(rakcipher.type, "akcipher", sizeof(rakcipher.type));
-	rakcipher.stat_encrypt_cnt = atomic64_read(&alg->encrypt_cnt);
-	rakcipher.stat_encrypt_tlen = atomic64_read(&alg->encrypt_tlen);
-	rakcipher.stat_decrypt_cnt = atomic64_read(&alg->decrypt_cnt);
-	rakcipher.stat_decrypt_tlen = atomic64_read(&alg->decrypt_tlen);
-	rakcipher.stat_sign_cnt = atomic64_read(&alg->sign_cnt);
-	rakcipher.stat_verify_cnt = atomic64_read(&alg->verify_cnt);
-	rakcipher.stat_akcipher_err_cnt = atomic64_read(&alg->akcipher_err_cnt);
+	rakcipher.stat_encrypt_cnt = atomic64_read(&alg->stats.akcipher.encrypt_cnt);
+	rakcipher.stat_encrypt_tlen = atomic64_read(&alg->stats.akcipher.encrypt_tlen);
+	rakcipher.stat_decrypt_cnt = atomic64_read(&alg->stats.akcipher.decrypt_cnt);
+	rakcipher.stat_decrypt_tlen = atomic64_read(&alg->stats.akcipher.decrypt_tlen);
+	rakcipher.stat_sign_cnt = atomic64_read(&alg->stats.akcipher.sign_cnt);
+	rakcipher.stat_verify_cnt = atomic64_read(&alg->stats.akcipher.verify_cnt);
+	rakcipher.stat_akcipher_err_cnt = atomic64_read(&alg->stats.akcipher.akcipher_err_cnt);
 
 	return nla_put(skb, CRYPTOCFGA_STAT_AKCIPHER,
 		       sizeof(rakcipher), &rakcipher);
@@ -124,10 +124,10 @@ static int crypto_report_kpp(struct sk_buff *skb, struct crypto_alg *alg)
 
 	strscpy(rkpp.type, "kpp", sizeof(rkpp.type));
 
-	rkpp.stat_setsecret_cnt = atomic64_read(&alg->setsecret_cnt);
-	rkpp.stat_generate_public_key_cnt = atomic64_read(&alg->generate_public_key_cnt);
-	rkpp.stat_compute_shared_secret_cnt = atomic64_read(&alg->compute_shared_secret_cnt);
-	rkpp.stat_kpp_err_cnt = atomic64_read(&alg->kpp_err_cnt);
+	rkpp.stat_setsecret_cnt = atomic64_read(&alg->stats.kpp.setsecret_cnt);
+	rkpp.stat_generate_public_key_cnt = atomic64_read(&alg->stats.kpp.generate_public_key_cnt);
+	rkpp.stat_compute_shared_secret_cnt = atomic64_read(&alg->stats.kpp.compute_shared_secret_cnt);
+	rkpp.stat_kpp_err_cnt = atomic64_read(&alg->stats.kpp.kpp_err_cnt);
 
 	return nla_put(skb, CRYPTOCFGA_STAT_KPP, sizeof(rkpp), &rkpp);
 }
@@ -140,9 +140,9 @@ static int crypto_report_ahash(struct sk_buff *skb, struct crypto_alg *alg)
 
 	strscpy(rhash.type, "ahash", sizeof(rhash.type));
 
-	rhash.stat_hash_cnt = atomic64_read(&alg->hash_cnt);
-	rhash.stat_hash_tlen = atomic64_read(&alg->hash_tlen);
-	rhash.stat_hash_err_cnt = atomic64_read(&alg->hash_err_cnt);
+	rhash.stat_hash_cnt = atomic64_read(&alg->stats.hash.hash_cnt);
+	rhash.stat_hash_tlen = atomic64_read(&alg->stats.hash.hash_tlen);
+	rhash.stat_hash_err_cnt = atomic64_read(&alg->stats.hash.hash_err_cnt);
 
 	return nla_put(skb, CRYPTOCFGA_STAT_HASH, sizeof(rhash), &rhash);
 }
@@ -155,9 +155,9 @@ static int crypto_report_shash(struct sk_buff *skb, struct crypto_alg *alg)
 
 	strscpy(rhash.type, "shash", sizeof(rhash.type));
 
-	rhash.stat_hash_cnt =  atomic64_read(&alg->hash_cnt);
-	rhash.stat_hash_tlen = atomic64_read(&alg->hash_tlen);
-	rhash.stat_hash_err_cnt = atomic64_read(&alg->hash_err_cnt);
+	rhash.stat_hash_cnt =  atomic64_read(&alg->stats.hash.hash_cnt);
+	rhash.stat_hash_tlen = atomic64_read(&alg->stats.hash.hash_tlen);
+	rhash.stat_hash_err_cnt = atomic64_read(&alg->stats.hash.hash_err_cnt);
 
 	return nla_put(skb, CRYPTOCFGA_STAT_HASH, sizeof(rhash), &rhash);
 }
@@ -170,10 +170,10 @@ static int crypto_report_rng(struct sk_buff *skb, struct crypto_alg *alg)
 
 	strscpy(rrng.type, "rng", sizeof(rrng.type));
 
-	rrng.stat_generate_cnt = atomic64_read(&alg->generate_cnt);
-	rrng.stat_generate_tlen = atomic64_read(&alg->generate_tlen);
-	rrng.stat_seed_cnt = atomic64_read(&alg->seed_cnt);
-	rrng.stat_rng_err_cnt = atomic64_read(&alg->rng_err_cnt);
+	rrng.stat_generate_cnt = atomic64_read(&alg->stats.rng.generate_cnt);
+	rrng.stat_generate_tlen = atomic64_read(&alg->stats.rng.generate_tlen);
+	rrng.stat_seed_cnt = atomic64_read(&alg->stats.rng.seed_cnt);
+	rrng.stat_rng_err_cnt = atomic64_read(&alg->stats.rng.rng_err_cnt);
 
 	return nla_put(skb, CRYPTOCFGA_STAT_RNG, sizeof(rrng), &rrng);
 }
diff --git a/include/crypto/acompress.h b/include/crypto/acompress.h
index cb19ba60399b..ba0b834d355a 100644
--- a/include/crypto/acompress.h
+++ b/include/crypto/acompress.h
@@ -239,10 +239,10 @@ static inline void crypto_stat_compress(unsigned int slen, int ret,
 {
 #ifdef CONFIG_CRYPTO_STATS
 	if (ret && ret != -EINPROGRESS && ret != -EBUSY) {
-		atomic64_inc(&alg->compress_err_cnt);
+		atomic64_inc(&alg->stats.compress.compress_err_cnt);
 	} else {
-		atomic64_inc(&alg->compress_cnt);
-		atomic64_add(slen, &alg->compress_tlen);
+		atomic64_inc(&alg->stats.compress.compress_cnt);
+		atomic64_add(slen, &alg->stats.compress.compress_tlen);
 	}
 	crypto_alg_put(alg);
 #endif
@@ -253,10 +253,10 @@ static inline void crypto_stat_decompress(unsigned int slen, int ret,
 {
 #ifdef CONFIG_CRYPTO_STATS
 	if (ret && ret != -EINPROGRESS && ret != -EBUSY) {
-		atomic64_inc(&alg->compress_err_cnt);
+		atomic64_inc(&alg->stats.compress.compress_err_cnt);
 	} else {
-		atomic64_inc(&alg->decompress_cnt);
-		atomic64_add(slen, &alg->decompress_tlen);
+		atomic64_inc(&alg->stats.compress.decompress_cnt);
+		atomic64_add(slen, &alg->stats.compress.decompress_tlen);
 	}
 	crypto_alg_put(alg);
 #endif
diff --git a/include/crypto/aead.h b/include/crypto/aead.h
index 11ab5d3fe3ba..2b0c73de6a2f 100644
--- a/include/crypto/aead.h
+++ b/include/crypto/aead.h
@@ -311,10 +311,10 @@ static inline void crypto_stat_aead_encrypt(unsigned int cryptlen,
 {
 #ifdef CONFIG_CRYPTO_STATS
 	if (ret && ret != -EINPROGRESS && ret != -EBUSY) {
-		atomic64_inc(&alg->aead_err_cnt);
+		atomic64_inc(&alg->stats.aead.aead_err_cnt);
 	} else {
-		atomic64_inc(&alg->encrypt_cnt);
-		atomic64_add(cryptlen, &alg->encrypt_tlen);
+		atomic64_inc(&alg->stats.aead.encrypt_cnt);
+		atomic64_add(cryptlen, &alg->stats.aead.encrypt_tlen);
 	}
 	crypto_alg_put(alg);
 #endif
@@ -325,10 +325,10 @@ static inline void crypto_stat_aead_decrypt(unsigned int cryptlen,
 {
 #ifdef CONFIG_CRYPTO_STATS
 	if (ret && ret != -EINPROGRESS && ret != -EBUSY) {
-		atomic64_inc(&alg->aead_err_cnt);
+		atomic64_inc(&alg->stats.aead.aead_err_cnt);
 	} else {
-		atomic64_inc(&alg->decrypt_cnt);
-		atomic64_add(cryptlen, &alg->decrypt_tlen);
+		atomic64_inc(&alg->stats.aead.decrypt_cnt);
+		atomic64_add(cryptlen, &alg->stats.aead.decrypt_tlen);
 	}
 	crypto_alg_put(alg);
 #endif
diff --git a/include/crypto/akcipher.h b/include/crypto/akcipher.h
index 10dd1eaff211..af34ce4306bd 100644
--- a/include/crypto/akcipher.h
+++ b/include/crypto/akcipher.h
@@ -276,10 +276,10 @@ static inline void crypto_stat_akcipher_encrypt(unsigned int src_len, int ret,
 {
 #ifdef CONFIG_CRYPTO_STATS
 	if (ret && ret != -EINPROGRESS && ret != -EBUSY) {
-		atomic64_inc(&alg->akcipher_err_cnt);
+		atomic64_inc(&alg->stats.akcipher.akcipher_err_cnt);
 	} else {
-		atomic64_inc(&alg->encrypt_cnt);
-		atomic64_add(src_len, &alg->encrypt_tlen);
+		atomic64_inc(&alg->stats.akcipher.encrypt_cnt);
+		atomic64_add(src_len, &alg->stats.akcipher.encrypt_tlen);
 	}
 	crypto_alg_put(alg);
 #endif
@@ -290,10 +290,10 @@ static inline void crypto_stat_akcipher_decrypt(unsigned int src_len, int ret,
 {
 #ifdef CONFIG_CRYPTO_STATS
 	if (ret && ret != -EINPROGRESS && ret != -EBUSY) {
-		atomic64_inc(&alg->akcipher_err_cnt);
+		atomic64_inc(&alg->stats.akcipher.akcipher_err_cnt);
 	} else {
-		atomic64_inc(&alg->decrypt_cnt);
-		atomic64_add(src_len, &alg->decrypt_tlen);
+		atomic64_inc(&alg->stats.akcipher.decrypt_cnt);
+		atomic64_add(src_len, &alg->stats.akcipher.decrypt_tlen);
 	}
 	crypto_alg_put(alg);
 #endif
@@ -303,9 +303,9 @@ static inline void crypto_stat_akcipher_sign(int ret, struct crypto_alg *alg)
 {
 #ifdef CONFIG_CRYPTO_STATS
 	if (ret && ret != -EINPROGRESS && ret != -EBUSY)
-		atomic64_inc(&alg->akcipher_err_cnt);
+		atomic64_inc(&alg->stats.akcipher.akcipher_err_cnt);
 	else
-		atomic64_inc(&alg->sign_cnt);
+		atomic64_inc(&alg->stats.akcipher.sign_cnt);
 	crypto_alg_put(alg);
 #endif
 }
@@ -314,9 +314,9 @@ static inline void crypto_stat_akcipher_verify(int ret, struct crypto_alg *alg)
 {
 #ifdef CONFIG_CRYPTO_STATS
 	if (ret && ret != -EINPROGRESS && ret != -EBUSY)
-		atomic64_inc(&alg->akcipher_err_cnt);
+		atomic64_inc(&alg->stats.akcipher.akcipher_err_cnt);
 	else
-		atomic64_inc(&alg->verify_cnt);
+		atomic64_inc(&alg->stats.akcipher.verify_cnt);
 	crypto_alg_put(alg);
 #endif
 }
diff --git a/include/crypto/hash.h b/include/crypto/hash.h
index bf88dea99ff6..a88a4695ac09 100644
--- a/include/crypto/hash.h
+++ b/include/crypto/hash.h
@@ -417,9 +417,9 @@ static inline void crypto_stat_ahash_update(unsigned int nbytes, int ret,
 {
 #ifdef CONFIG_CRYPTO_STATS
 	if (ret && ret != -EINPROGRESS && ret != -EBUSY)
-		atomic64_inc(&alg->hash_err_cnt);
+		atomic64_inc(&alg->stats.hash.hash_err_cnt);
 	else
-		atomic64_add(nbytes, &alg->hash_tlen);
+		atomic64_add(nbytes, &alg->stats.hash.hash_tlen);
 	crypto_alg_put(alg);
 #endif
 }
@@ -429,10 +429,10 @@ static inline void crypto_stat_ahash_final(unsigned int nbytes, int ret,
 {
 #ifdef CONFIG_CRYPTO_STATS
 	if (ret && ret != -EINPROGRESS && ret != -EBUSY) {
-		atomic64_inc(&alg->hash_err_cnt);
+		atomic64_inc(&alg->stats.hash.hash_err_cnt);
 	} else {
-		atomic64_inc(&alg->hash_cnt);
-		atomic64_add(nbytes, &alg->hash_tlen);
+		atomic64_inc(&alg->stats.hash.hash_cnt);
+		atomic64_add(nbytes, &alg->stats.hash.hash_tlen);
 	}
 	crypto_alg_put(alg);
 #endif
diff --git a/include/crypto/kpp.h b/include/crypto/kpp.h
index ccab8eac04b9..29ab4c4cd902 100644
--- a/include/crypto/kpp.h
+++ b/include/crypto/kpp.h
@@ -272,9 +272,9 @@ static inline void crypto_stat_kpp_set_secret(struct crypto_alg *alg, int ret)
 {
 #ifdef CONFIG_CRYPTO_STATS
 	if (ret)
-		atomic64_inc(&alg->kpp_err_cnt);
+		atomic64_inc(&alg->stats.kpp.kpp_err_cnt);
 	else
-		atomic64_inc(&alg->setsecret_cnt);
+		atomic64_inc(&alg->stats.kpp.setsecret_cnt);
 	crypto_alg_put(alg);
 #endif
 }
@@ -284,9 +284,9 @@ static inline void crypto_stat_kpp_generate_public_key(struct crypto_alg *alg,
 {
 #ifdef CONFIG_CRYPTO_STATS
 	if (ret)
-		atomic64_inc(&alg->kpp_err_cnt);
+		atomic64_inc(&alg->stats.kpp.kpp_err_cnt);
 	else
-		atomic64_inc(&alg->generate_public_key_cnt);
+		atomic64_inc(&alg->stats.kpp.generate_public_key_cnt);
 	crypto_alg_put(alg);
 #endif
 }
@@ -296,9 +296,9 @@ static inline void crypto_stat_kpp_compute_shared_secret(struct crypto_alg *alg,
 {
 #ifdef CONFIG_CRYPTO_STATS
 	if (ret)
-		atomic64_inc(&alg->kpp_err_cnt);
+		atomic64_inc(&alg->stats.kpp.kpp_err_cnt);
 	else
-		atomic64_inc(&alg->compute_shared_secret_cnt);
+		atomic64_inc(&alg->stats.kpp.compute_shared_secret_cnt);
 	crypto_alg_put(alg);
 #endif
 }
diff --git a/include/crypto/rng.h b/include/crypto/rng.h
index 113ba2ef3b23..d15a27931517 100644
--- a/include/crypto/rng.h
+++ b/include/crypto/rng.h
@@ -126,9 +126,9 @@ static inline void crypto_stat_rng_seed(struct crypto_alg *alg, int ret)
 {
 #ifdef CONFIG_CRYPTO_STATS
 	if (ret && ret != -EINPROGRESS && ret != -EBUSY)
-		atomic64_inc(&alg->rng_err_cnt);
+		atomic64_inc(&alg->stats.rng.rng_err_cnt);
 	else
-		atomic64_inc(&alg->seed_cnt);
+		atomic64_inc(&alg->stats.rng.seed_cnt);
 	crypto_alg_put(alg);
 #endif
 }
@@ -138,10 +138,10 @@ static inline void crypto_stat_rng_generate(struct crypto_alg *alg,
 {
 #ifdef CONFIG_CRYPTO_STATS
 	if (ret && ret != -EINPROGRESS && ret != -EBUSY) {
-		atomic64_inc(&alg->rng_err_cnt);
+		atomic64_inc(&alg->stats.rng.rng_err_cnt);
 	} else {
-		atomic64_inc(&alg->generate_cnt);
-		atomic64_add(dlen, &alg->generate_tlen);
+		atomic64_inc(&alg->stats.rng.generate_cnt);
+		atomic64_add(dlen, &alg->stats.rng.generate_tlen);
 	}
 	crypto_alg_put(alg);
 #endif
diff --git a/include/crypto/skcipher.h b/include/crypto/skcipher.h
index cec9ef17914e..87eee1dc536a 100644
--- a/include/crypto/skcipher.h
+++ b/include/crypto/skcipher.h
@@ -491,10 +491,10 @@ static inline void crypto_stat_skcipher_encrypt(unsigned int cryptlen,
 {
 #ifdef CONFIG_CRYPTO_STATS
 	if (ret && ret != -EINPROGRESS && ret != -EBUSY) {
-		atomic64_inc(&alg->cipher_err_cnt);
+		atomic64_inc(&alg->stats.cipher.cipher_err_cnt);
 	} else {
-		atomic64_inc(&alg->encrypt_cnt);
-		atomic64_add(cryptlen, &alg->encrypt_tlen);
+		atomic64_inc(&alg->stats.cipher.encrypt_cnt);
+		atomic64_add(cryptlen, &alg->stats.cipher.encrypt_tlen);
 	}
 	crypto_alg_put(alg);
 #endif
@@ -505,10 +505,10 @@ static inline void crypto_stat_skcipher_decrypt(unsigned int cryptlen,
 {
 #ifdef CONFIG_CRYPTO_STATS
 	if (ret && ret != -EINPROGRESS && ret != -EBUSY) {
-		atomic64_inc(&alg->cipher_err_cnt);
+		atomic64_inc(&alg->stats.cipher.cipher_err_cnt);
 	} else {
-		atomic64_inc(&alg->decrypt_cnt);
-		atomic64_add(cryptlen, &alg->decrypt_tlen);
+		atomic64_inc(&alg->stats.cipher.decrypt_cnt);
+		atomic64_add(cryptlen, &alg->stats.cipher.decrypt_tlen);
 	}
 	crypto_alg_put(alg);
 #endif
diff --git a/include/linux/crypto.h b/include/linux/crypto.h
index e67d346157c7..48499b91fe4a 100644
--- a/include/linux/crypto.h
+++ b/include/linux/crypto.h
@@ -369,6 +369,115 @@ struct compress_alg {
 			      unsigned int slen, u8 *dst, unsigned int *dlen);
 };
 
+#ifdef CONFIG_CRYPTO_STATS
+/*
+ * struct crypto_istat_aead - statistics for AEAD algorithm
+ * @encrypt_cnt:	number of encrypt requests
+ * @encrypt_tlen:	total data size handled by encrypt requests
+ * @decrypt_cnt:	number of decrypt requests
+ * @decrypt_tlen:	total data size handled by decrypt requests
+ * @aead_err_cnt:	number of error for AEAD requests
+ */
+struct crypto_istat_aead {
+	atomic64_t encrypt_cnt;
+	atomic64_t encrypt_tlen;
+	atomic64_t decrypt_cnt;
+	atomic64_t decrypt_tlen;
+	atomic64_t aead_err_cnt;
+};
+
+/*
+ * struct crypto_istat_akcipher - statistics for akcipher algorithm
+ * @encrypt_cnt:	number of encrypt requests
+ * @encrypt_tlen:	total data size handled by encrypt requests
+ * @decrypt_cnt:	number of decrypt requests
+ * @decrypt_tlen:	total data size handled by decrypt requests
+ * @verify_cnt:		number of verify operation
+ * @sign_cnt:		number of sign requests
+ * @akcipher_err_cnt:	number of error for akcipher requests
+ */
+struct crypto_istat_akcipher {
+	atomic64_t encrypt_cnt;
+	atomic64_t encrypt_tlen;
+	atomic64_t decrypt_cnt;
+	atomic64_t decrypt_tlen;
+	atomic64_t verify_cnt;
+	atomic64_t sign_cnt;
+	atomic64_t akcipher_err_cnt;
+};
+
+/*
+ * struct crypto_istat_cipher - statistics for cipher algorithm
+ * @encrypt_cnt:	number of encrypt requests
+ * @encrypt_tlen:	total data size handled by encrypt requests
+ * @decrypt_cnt:	number of decrypt requests
+ * @decrypt_tlen:	total data size handled by decrypt requests
+ * @cipher_err_cnt:	number of error for cipher requests
+ */
+struct crypto_istat_cipher {
+	atomic64_t encrypt_cnt;
+	atomic64_t encrypt_tlen;
+	atomic64_t decrypt_cnt;
+	atomic64_t decrypt_tlen;
+	atomic64_t cipher_err_cnt;
+};
+
+/*
+ * struct crypto_istat_compress - statistics for compress algorithm
+ * @compress_cnt:	number of compress requests
+ * @compress_tlen:	total data size handled by compress requests
+ * @decompress_cnt:	number of decompress requests
+ * @decompress_tlen:	total data size handled by decompress requests
+ * @compress_err_cnt:	number of error for compress requests
+ */
+struct crypto_istat_compress {
+	atomic64_t compress_cnt;
+	atomic64_t compress_tlen;
+	atomic64_t decompress_cnt;
+	atomic64_t decompress_tlen;
+	atomic64_t compress_err_cnt;
+};
+
+/*
+ * struct crypto_istat_hash - statistics for has algorithm
+ * @hash_cnt:		number of hash requests
+ * @hash_tlen:		total data size hashed
+ * @hash_err_cnt:	number of error for hash requests
+ */
+struct crypto_istat_hash {
+	atomic64_t hash_cnt;
+	atomic64_t hash_tlen;
+	atomic64_t hash_err_cnt;
+};
+
+/*
+ * struct crypto_istat_kpp - statistics for KPP algorithm
+ * @setsecret_cnt:		number of setsecrey operation
+ * @generate_public_key_cnt:	number of generate_public_key operation
+ * @compute_shared_secret_cnt:	number of compute_shared_secret operation
+ * @kpp_err_cnt:		number of error for KPP requests
+ */
+struct crypto_istat_kpp {
+	atomic64_t setsecret_cnt;
+	atomic64_t generate_public_key_cnt;
+	atomic64_t compute_shared_secret_cnt;
+	atomic64_t kpp_err_cnt;
+};
+
+/*
+ * struct crypto_istat_rng: statistics for RNG algorithm
+ * @generate_cnt:	number of RNG generate requests
+ * @generate_tlen:	total data size of generated data by the RNG
+ * @seed_cnt:		number of times the RNG was seeded
+ * @rng_err_cnt:	number of error for RNG requests
+ */
+struct crypto_istat_rng {
+	atomic64_t generate_cnt;
+	atomic64_t generate_tlen;
+	atomic64_t seed_cnt;
+	atomic64_t rng_err_cnt;
+};
+#endif /* CONFIG_CRYPTO_STATS */
 
 #define cra_ablkcipher	cra_u.ablkcipher
 #define cra_blkcipher	cra_u.blkcipher
@@ -454,32 +563,7 @@ struct compress_alg {
  * @cra_refcnt: internally used
  * @cra_destroy: internally used
  *
- * All following statistics are for this crypto_alg
- * @encrypt_cnt:	number of encrypt requests
- * @decrypt_cnt:	number of decrypt requests
- * @compress_cnt:	number of compress requests
- * @decompress_cnt:	number of decompress requests
- * @generate_cnt:	number of RNG generate requests
- * @seed_cnt:		number of times the rng was seeded
- * @hash_cnt:		number of hash requests
- * @sign_cnt:		number of sign requests
- * @setsecret_cnt:	number of setsecrey operation
- * @generate_public_key_cnt:	number of generate_public_key operation
- * @verify_cnt:			number of verify operation
- * @compute_shared_secret_cnt:	number of compute_shared_secret operation
- * @encrypt_tlen:	total data size handled by encrypt requests
- * @decrypt_tlen:	total data size handled by decrypt requests
- * @compress_tlen:	total data size handled by compress requests
- * @decompress_tlen:	total data size handled by decompress requests
- * @generate_tlen:	total data size of generated data by the RNG
- * @hash_tlen:		total data size hashed
- * @akcipher_err_cnt:	number of error for akcipher requests
- * @cipher_err_cnt:	number of error for akcipher requests
- * @compress_err_cnt:	number of error for akcipher requests
- * @aead_err_cnt:	number of error for akcipher requests
- * @hash_err_cnt:	number of error for akcipher requests
- * @rng_err_cnt:	number of error for akcipher requests
- * @kpp_err_cnt:	number of error for akcipher requests
+ * @stats: union of all possible crypto_istat_xxx structures
  *
  * The struct crypto_alg describes a generic Crypto API algorithm and is common
  * for all of the transformations. Any variable not documented here shall not
@@ -517,42 +601,14 @@ struct crypto_alg {
 
 #ifdef CONFIG_CRYPTO_STATS
 	union {
-		atomic64_t encrypt_cnt;
-		atomic64_t compress_cnt;
-		atomic64_t generate_cnt;
-		atomic64_t hash_cnt;
-		atomic64_t setsecret_cnt;
-	};
-	union {
-		atomic64_t encrypt_tlen;
-		atomic64_t compress_tlen;
-		atomic64_t generate_tlen;
-		atomic64_t hash_tlen;
-	};
-	union {
-		atomic64_t akcipher_err_cnt;
-		atomic64_t cipher_err_cnt;
-		atomic64_t compress_err_cnt;
-		atomic64_t aead_err_cnt;
-		atomic64_t hash_err_cnt;
-		atomic64_t rng_err_cnt;
-		atomic64_t kpp_err_cnt;
-	};
-	union {
-		atomic64_t decrypt_cnt;
-		atomic64_t decompress_cnt;
-		atomic64_t seed_cnt;
-		atomic64_t generate_public_key_cnt;
-	};
-	union {
-		atomic64_t decrypt_tlen;
-		atomic64_t decompress_tlen;
-	};
-	union {
-		atomic64_t verify_cnt;
-		atomic64_t compute_shared_secret_cnt;
-	};
-	atomic64_t sign_cnt;
+		struct crypto_istat_aead aead;
+		struct crypto_istat_akcipher akcipher;
+		struct crypto_istat_cipher cipher;
+		struct crypto_istat_compress compress;
+		struct crypto_istat_hash hash;
+		struct crypto_istat_rng rng;
+		struct crypto_istat_kpp kpp;
+	} stats;
 #endif /* CONFIG_CRYPTO_STATS */
 
 } CRYPTO_MINALIGN_ATTR;
@@ -992,10 +1048,10 @@ static inline void crypto_stat_ablkcipher_encrypt(unsigned int nbytes, int ret,
 {
 #ifdef CONFIG_CRYPTO_STATS
 	if (ret && ret != -EINPROGRESS && ret != -EBUSY) {
-		atomic64_inc(&alg->cipher_err_cnt);
+		atomic64_inc(&alg->stats.cipher.cipher_err_cnt);
 	} else {
-		atomic64_inc(&alg->encrypt_cnt);
-		atomic64_add(nbytes, &alg->encrypt_tlen);
+		atomic64_inc(&alg->stats.cipher.encrypt_cnt);
+		atomic64_add(nbytes, &alg->stats.cipher.encrypt_tlen);
 	}
 	crypto_alg_put(alg);
 #endif
@@ -1006,10 +1062,10 @@ static inline void crypto_stat_ablkcipher_decrypt(unsigned int nbytes, int ret,
 {
 #ifdef CONFIG_CRYPTO_STATS
 	if (ret && ret != -EINPROGRESS && ret != -EBUSY) {
-		atomic64_inc(&alg->cipher_err_cnt);
+		atomic64_inc(&alg->stats.cipher.cipher_err_cnt);
 	} else {
-		atomic64_inc(&alg->decrypt_cnt);
-		atomic64_add(nbytes, &alg->decrypt_tlen);
+		atomic64_inc(&alg->stats.cipher.decrypt_cnt);
+		atomic64_add(nbytes, &alg->stats.cipher.decrypt_tlen);
 	}
 	crypto_alg_put(alg);
 #endif
-- 
2.18.1

