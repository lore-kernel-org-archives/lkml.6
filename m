Return-Path: <SRS0=aB5v=OC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8ECEAC43441
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Nov 2018 12:03:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 328BB20672
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Nov 2018 12:03:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="ub8S3tSW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 328BB20672
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2503970AbeKWWqh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 23 Nov 2018 17:46:37 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:44215 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2503925AbeKWWqg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Nov 2018 17:46:36 -0500
Received: by mail-wr1-f68.google.com with SMTP id z5so7801370wrt.11
        for <linux-kernel@vger.kernel.org>; Fri, 23 Nov 2018 04:02:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=jsZ65dZ2V8FgX5MZpxSHLCYeN6im2pCyOwmQajp1r0M=;
        b=ub8S3tSWSxcMivL6myGH4vG80TK6Rmzq+A5PCgslllD0yabXJwQp8/ZvvCUTN5h64X
         SYubD8ZAExiAKu0a2f5EWtA+8vNrINBIECs2wqoj3sR+g/XelVfcVaOKrd03CIH1KGbj
         xDwxMCLJN9uojKyvNO/gx7mTKu40wG9zHtfJA3DmAHFP9ZWDHbaRaCVOv/1esdv0f5Gc
         tpILbMYCIK567fn6wfHe07HMRtgNIks2wpE4Kw+KGsvgjIKC6lPAikZUrBXP4uPdOq0V
         lZFJbJHoYXcvvVrbWLOYK5Ba/TSCIbwQpfaHNT0sV9qFhx167c0E8zbIrzyKMdt6mV+w
         clyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=jsZ65dZ2V8FgX5MZpxSHLCYeN6im2pCyOwmQajp1r0M=;
        b=mJGRYtMQeN6FaAJCb1oI8TVbXoio6Ql+DsO4vBsorsIXF8VBZUEWz/xoxlsLrUhsVA
         rl7oKr0Nk2kyIIR+FZMyjxnTyIuerpDKgs3kD155Lk+4+ozfZFp3LbwNCF7bzj5Ep4qh
         Q34l3AudyWDlt2rsdQYXp8snFPvP2gBV97SBwsuH2sg7t4gXNriKP4FYGvVdT1J9hHPP
         FPopXsQn0e+MNqizscVPFUkka/xICbYh0bEdWGbG8R1Cltvavm7CQDtbqyC5REZ9fCQ2
         ZpqvFGU9Q1S7pJVk1qlFmghQyHc4sJTrnI8TeBdBRWEs280Y7CLUW77RJhlQqe4kbQEy
         StRQ==
X-Gm-Message-State: AA+aEWbKXlv/RU235pMXxuBUEq9EyldDzoONp7QMW0thLpUWyWATVVXq
        56GVU4Rb+Pyszsx7z/eNs8MQ/A==
X-Google-Smtp-Source: AFSGD/VQBfOeoGorc1fsIVl6SCyzHFyUxHxYEpQh7JlWr3YwkatHDWI4wIHZ3uiGpO0/vwl/XyBhpQ==
X-Received: by 2002:adf:80cf:: with SMTP id 73mr10525083wrl.57.1542974555992;
        Fri, 23 Nov 2018 04:02:35 -0800 (PST)
Received: from localhost.localdomain ([51.15.160.169])
        by smtp.googlemail.com with ESMTPSA id a18sm25164379wrp.13.2018.11.23.04.02.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 23 Nov 2018 04:02:34 -0800 (PST)
From:   Corentin Labbe <clabbe@baylibre.com>
To:     davem@davemloft.net, ebiggers@kernel.org,
        herbert@gondor.apana.org.au, nhorman@tuxdriver.com
Cc:     linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        Corentin Labbe <clabbe@baylibre.com>
Subject: [PATCH v4 03/11] crypto: crypto_user_stat: convert all stats from u32 to u64
Date:   Fri, 23 Nov 2018 12:02:13 +0000
Message-Id: <1542974541-23024-4-git-send-email-clabbe@baylibre.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1542974541-23024-1-git-send-email-clabbe@baylibre.com>
References: <1542974541-23024-1-git-send-email-clabbe@baylibre.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

All the 32-bit fields need to be 64-bit.  In some cases, UINT32_MAX crypto
operations can be done in seconds.

Reported-by: Eric Biggers <ebiggers@kernel.org>
Signed-off-by: Corentin Labbe <clabbe@baylibre.com>
---
 crypto/algapi.c                 |  10 +--
 crypto/crypto_user_stat.c       | 114 +++++++++++++++-----------------
 include/crypto/acompress.h      |   8 +--
 include/crypto/aead.h           |   8 +--
 include/crypto/akcipher.h       |  16 ++---
 include/crypto/hash.h           |   6 +-
 include/crypto/kpp.h            |  12 ++--
 include/crypto/rng.h            |   8 +--
 include/crypto/skcipher.h       |   8 +--
 include/linux/crypto.h          |  46 ++++++-------
 include/uapi/linux/cryptouser.h |  38 +++++------
 11 files changed, 133 insertions(+), 141 deletions(-)

diff --git a/crypto/algapi.c b/crypto/algapi.c
index f5396c88e8cd..42fe316f80ee 100644
--- a/crypto/algapi.c
+++ b/crypto/algapi.c
@@ -259,13 +259,13 @@ static struct crypto_larval *__crypto_register_alg(struct crypto_alg *alg)
 	list_add(&larval->alg.cra_list, &crypto_alg_list);
 
 #ifdef CONFIG_CRYPTO_STATS
-	atomic_set(&alg->encrypt_cnt, 0);
-	atomic_set(&alg->decrypt_cnt, 0);
+	atomic64_set(&alg->encrypt_cnt, 0);
+	atomic64_set(&alg->decrypt_cnt, 0);
 	atomic64_set(&alg->encrypt_tlen, 0);
 	atomic64_set(&alg->decrypt_tlen, 0);
-	atomic_set(&alg->verify_cnt, 0);
-	atomic_set(&alg->cipher_err_cnt, 0);
-	atomic_set(&alg->sign_cnt, 0);
+	atomic64_set(&alg->verify_cnt, 0);
+	atomic64_set(&alg->cipher_err_cnt, 0);
+	atomic64_set(&alg->sign_cnt, 0);
 #endif
 
 out:
diff --git a/crypto/crypto_user_stat.c b/crypto/crypto_user_stat.c
index a6fb2e6f618d..352569f378a0 100644
--- a/crypto/crypto_user_stat.c
+++ b/crypto/crypto_user_stat.c
@@ -35,22 +35,21 @@ static int crypto_report_aead(struct sk_buff *skb, struct crypto_alg *alg)
 {
 	struct crypto_stat raead;
 	u64 v64;
-	u32 v32;
 
 	memset(&raead, 0, sizeof(raead));
 
 	strscpy(raead.type, "aead", sizeof(raead.type));
 
-	v32 = atomic_read(&alg->encrypt_cnt);
-	raead.stat_encrypt_cnt = v32;
+	v64 = atomic64_read(&alg->encrypt_cnt);
+	raead.stat_encrypt_cnt = v64;
 	v64 = atomic64_read(&alg->encrypt_tlen);
 	raead.stat_encrypt_tlen = v64;
-	v32 = atomic_read(&alg->decrypt_cnt);
-	raead.stat_decrypt_cnt = v32;
+	v64 = atomic64_read(&alg->decrypt_cnt);
+	raead.stat_decrypt_cnt = v64;
 	v64 = atomic64_read(&alg->decrypt_tlen);
 	raead.stat_decrypt_tlen = v64;
-	v32 = atomic_read(&alg->aead_err_cnt);
-	raead.stat_aead_err_cnt = v32;
+	v64 = atomic64_read(&alg->aead_err_cnt);
+	raead.stat_aead_err_cnt = v64;
 
 	return nla_put(skb, CRYPTOCFGA_STAT_AEAD, sizeof(raead), &raead);
 }
@@ -59,22 +58,21 @@ static int crypto_report_cipher(struct sk_buff *skb, struct crypto_alg *alg)
 {
 	struct crypto_stat rcipher;
 	u64 v64;
-	u32 v32;
 
 	memset(&rcipher, 0, sizeof(rcipher));
 
 	strscpy(rcipher.type, "cipher", sizeof(rcipher.type));
 
-	v32 = atomic_read(&alg->encrypt_cnt);
-	rcipher.stat_encrypt_cnt = v32;
+	v64 = atomic64_read(&alg->encrypt_cnt);
+	rcipher.stat_encrypt_cnt = v64;
 	v64 = atomic64_read(&alg->encrypt_tlen);
 	rcipher.stat_encrypt_tlen = v64;
-	v32 = atomic_read(&alg->decrypt_cnt);
-	rcipher.stat_decrypt_cnt = v32;
+	v64 = atomic64_read(&alg->decrypt_cnt);
+	rcipher.stat_decrypt_cnt = v64;
 	v64 = atomic64_read(&alg->decrypt_tlen);
 	rcipher.stat_decrypt_tlen = v64;
-	v32 = atomic_read(&alg->cipher_err_cnt);
-	rcipher.stat_cipher_err_cnt = v32;
+	v64 = atomic64_read(&alg->cipher_err_cnt);
+	rcipher.stat_cipher_err_cnt = v64;
 
 	return nla_put(skb, CRYPTOCFGA_STAT_CIPHER, sizeof(rcipher), &rcipher);
 }
@@ -83,21 +81,20 @@ static int crypto_report_comp(struct sk_buff *skb, struct crypto_alg *alg)
 {
 	struct crypto_stat rcomp;
 	u64 v64;
-	u32 v32;
 
 	memset(&rcomp, 0, sizeof(rcomp));
 
 	strscpy(rcomp.type, "compression", sizeof(rcomp.type));
-	v32 = atomic_read(&alg->compress_cnt);
-	rcomp.stat_compress_cnt = v32;
+	v64 = atomic64_read(&alg->compress_cnt);
+	rcomp.stat_compress_cnt = v64;
 	v64 = atomic64_read(&alg->compress_tlen);
 	rcomp.stat_compress_tlen = v64;
-	v32 = atomic_read(&alg->decompress_cnt);
-	rcomp.stat_decompress_cnt = v32;
+	v64 = atomic64_read(&alg->decompress_cnt);
+	rcomp.stat_decompress_cnt = v64;
 	v64 = atomic64_read(&alg->decompress_tlen);
 	rcomp.stat_decompress_tlen = v64;
-	v32 = atomic_read(&alg->cipher_err_cnt);
-	rcomp.stat_compress_err_cnt = v32;
+	v64 = atomic64_read(&alg->cipher_err_cnt);
+	rcomp.stat_compress_err_cnt = v64;
 
 	return nla_put(skb, CRYPTOCFGA_STAT_COMPRESS, sizeof(rcomp), &rcomp);
 }
@@ -106,21 +103,20 @@ static int crypto_report_acomp(struct sk_buff *skb, struct crypto_alg *alg)
 {
 	struct crypto_stat racomp;
 	u64 v64;
-	u32 v32;
 
 	memset(&racomp, 0, sizeof(racomp));
 
 	strscpy(racomp.type, "acomp", sizeof(racomp.type));
-	v32 = atomic_read(&alg->compress_cnt);
-	racomp.stat_compress_cnt = v32;
+	v64 = atomic64_read(&alg->compress_cnt);
+	racomp.stat_compress_cnt = v64;
 	v64 = atomic64_read(&alg->compress_tlen);
 	racomp.stat_compress_tlen = v64;
-	v32 = atomic_read(&alg->decompress_cnt);
-	racomp.stat_decompress_cnt = v32;
+	v64 = atomic64_read(&alg->decompress_cnt);
+	racomp.stat_decompress_cnt = v64;
 	v64 = atomic64_read(&alg->decompress_tlen);
 	racomp.stat_decompress_tlen = v64;
-	v32 = atomic_read(&alg->cipher_err_cnt);
-	racomp.stat_compress_err_cnt = v32;
+	v64 = atomic64_read(&alg->cipher_err_cnt);
+	racomp.stat_compress_err_cnt = v64;
 
 	return nla_put(skb, CRYPTOCFGA_STAT_ACOMP, sizeof(racomp), &racomp);
 }
@@ -129,25 +125,24 @@ static int crypto_report_akcipher(struct sk_buff *skb, struct crypto_alg *alg)
 {
 	struct crypto_stat rakcipher;
 	u64 v64;
-	u32 v32;
 
 	memset(&rakcipher, 0, sizeof(rakcipher));
 
 	strscpy(rakcipher.type, "akcipher", sizeof(rakcipher.type));
-	v32 = atomic_read(&alg->encrypt_cnt);
-	rakcipher.stat_encrypt_cnt = v32;
+	v64 = atomic64_read(&alg->encrypt_cnt);
+	rakcipher.stat_encrypt_cnt = v64;
 	v64 = atomic64_read(&alg->encrypt_tlen);
 	rakcipher.stat_encrypt_tlen = v64;
-	v32 = atomic_read(&alg->decrypt_cnt);
-	rakcipher.stat_decrypt_cnt = v32;
+	v64 = atomic64_read(&alg->decrypt_cnt);
+	rakcipher.stat_decrypt_cnt = v64;
 	v64 = atomic64_read(&alg->decrypt_tlen);
 	rakcipher.stat_decrypt_tlen = v64;
-	v32 = atomic_read(&alg->sign_cnt);
-	rakcipher.stat_sign_cnt = v32;
-	v32 = atomic_read(&alg->verify_cnt);
-	rakcipher.stat_verify_cnt = v32;
-	v32 = atomic_read(&alg->akcipher_err_cnt);
-	rakcipher.stat_akcipher_err_cnt = v32;
+	v64 = atomic64_read(&alg->sign_cnt);
+	rakcipher.stat_sign_cnt = v64;
+	v64 = atomic64_read(&alg->verify_cnt);
+	rakcipher.stat_verify_cnt = v64;
+	v64 = atomic64_read(&alg->akcipher_err_cnt);
+	rakcipher.stat_akcipher_err_cnt = v64;
 
 	return nla_put(skb, CRYPTOCFGA_STAT_AKCIPHER,
 		       sizeof(rakcipher), &rakcipher);
@@ -156,19 +151,19 @@ static int crypto_report_akcipher(struct sk_buff *skb, struct crypto_alg *alg)
 static int crypto_report_kpp(struct sk_buff *skb, struct crypto_alg *alg)
 {
 	struct crypto_stat rkpp;
-	u32 v;
+	u64 v;
 
 	memset(&rkpp, 0, sizeof(rkpp));
 
 	strscpy(rkpp.type, "kpp", sizeof(rkpp.type));
 
-	v = atomic_read(&alg->setsecret_cnt);
+	v = atomic64_read(&alg->setsecret_cnt);
 	rkpp.stat_setsecret_cnt = v;
-	v = atomic_read(&alg->generate_public_key_cnt);
+	v = atomic64_read(&alg->generate_public_key_cnt);
 	rkpp.stat_generate_public_key_cnt = v;
-	v = atomic_read(&alg->compute_shared_secret_cnt);
+	v = atomic64_read(&alg->compute_shared_secret_cnt);
 	rkpp.stat_compute_shared_secret_cnt = v;
-	v = atomic_read(&alg->kpp_err_cnt);
+	v = atomic64_read(&alg->kpp_err_cnt);
 	rkpp.stat_kpp_err_cnt = v;
 
 	return nla_put(skb, CRYPTOCFGA_STAT_KPP, sizeof(rkpp), &rkpp);
@@ -178,18 +173,17 @@ static int crypto_report_ahash(struct sk_buff *skb, struct crypto_alg *alg)
 {
 	struct crypto_stat rhash;
 	u64 v64;
-	u32 v32;
 
 	memset(&rhash, 0, sizeof(rhash));
 
 	strscpy(rhash.type, "ahash", sizeof(rhash.type));
 
-	v32 = atomic_read(&alg->hash_cnt);
-	rhash.stat_hash_cnt = v32;
+	v64 = atomic64_read(&alg->hash_cnt);
+	rhash.stat_hash_cnt = v64;
 	v64 = atomic64_read(&alg->hash_tlen);
 	rhash.stat_hash_tlen = v64;
-	v32 = atomic_read(&alg->hash_err_cnt);
-	rhash.stat_hash_err_cnt = v32;
+	v64 = atomic64_read(&alg->hash_err_cnt);
+	rhash.stat_hash_err_cnt = v64;
 
 	return nla_put(skb, CRYPTOCFGA_STAT_HASH, sizeof(rhash), &rhash);
 }
@@ -198,18 +192,17 @@ static int crypto_report_shash(struct sk_buff *skb, struct crypto_alg *alg)
 {
 	struct crypto_stat rhash;
 	u64 v64;
-	u32 v32;
 
 	memset(&rhash, 0, sizeof(rhash));
 
 	strscpy(rhash.type, "shash", sizeof(rhash.type));
 
-	v32 = atomic_read(&alg->hash_cnt);
-	rhash.stat_hash_cnt = v32;
+	v64 = atomic64_read(&alg->hash_cnt);
+	rhash.stat_hash_cnt = v64;
 	v64 = atomic64_read(&alg->hash_tlen);
 	rhash.stat_hash_tlen = v64;
-	v32 = atomic_read(&alg->hash_err_cnt);
-	rhash.stat_hash_err_cnt = v32;
+	v64 = atomic64_read(&alg->hash_err_cnt);
+	rhash.stat_hash_err_cnt = v64;
 
 	return nla_put(skb, CRYPTOCFGA_STAT_HASH, sizeof(rhash), &rhash);
 }
@@ -218,20 +211,19 @@ static int crypto_report_rng(struct sk_buff *skb, struct crypto_alg *alg)
 {
 	struct crypto_stat rrng;
 	u64 v64;
-	u32 v32;
 
 	memset(&rrng, 0, sizeof(rrng));
 
 	strscpy(rrng.type, "rng", sizeof(rrng.type));
 
-	v32 = atomic_read(&alg->generate_cnt);
-	rrng.stat_generate_cnt = v32;
+	v64 = atomic64_read(&alg->generate_cnt);
+	rrng.stat_generate_cnt = v64;
 	v64 = atomic64_read(&alg->generate_tlen);
 	rrng.stat_generate_tlen = v64;
-	v32 = atomic_read(&alg->seed_cnt);
-	rrng.stat_seed_cnt = v32;
-	v32 = atomic_read(&alg->hash_err_cnt);
-	rrng.stat_rng_err_cnt = v32;
+	v64 = atomic64_read(&alg->seed_cnt);
+	rrng.stat_seed_cnt = v64;
+	v64 = atomic64_read(&alg->hash_err_cnt);
+	rrng.stat_rng_err_cnt = v64;
 
 	return nla_put(skb, CRYPTOCFGA_STAT_RNG, sizeof(rrng), &rrng);
 }
diff --git a/include/crypto/acompress.h b/include/crypto/acompress.h
index 22e6f412c595..f79918196811 100644
--- a/include/crypto/acompress.h
+++ b/include/crypto/acompress.h
@@ -240,9 +240,9 @@ static inline void crypto_stat_compress(struct acomp_req *req, int ret)
 	struct crypto_acomp *tfm = crypto_acomp_reqtfm(req);
 
 	if (ret && ret != -EINPROGRESS && ret != -EBUSY) {
-		atomic_inc(&tfm->base.__crt_alg->compress_err_cnt);
+		atomic64_inc(&tfm->base.__crt_alg->compress_err_cnt);
 	} else {
-		atomic_inc(&tfm->base.__crt_alg->compress_cnt);
+		atomic64_inc(&tfm->base.__crt_alg->compress_cnt);
 		atomic64_add(req->slen, &tfm->base.__crt_alg->compress_tlen);
 	}
 #endif
@@ -254,9 +254,9 @@ static inline void crypto_stat_decompress(struct acomp_req *req, int ret)
 	struct crypto_acomp *tfm = crypto_acomp_reqtfm(req);
 
 	if (ret && ret != -EINPROGRESS && ret != -EBUSY) {
-		atomic_inc(&tfm->base.__crt_alg->compress_err_cnt);
+		atomic64_inc(&tfm->base.__crt_alg->compress_err_cnt);
 	} else {
-		atomic_inc(&tfm->base.__crt_alg->decompress_cnt);
+		atomic64_inc(&tfm->base.__crt_alg->decompress_cnt);
 		atomic64_add(req->slen, &tfm->base.__crt_alg->decompress_tlen);
 	}
 #endif
diff --git a/include/crypto/aead.h b/include/crypto/aead.h
index 0d765d7bfb82..99afd78c665d 100644
--- a/include/crypto/aead.h
+++ b/include/crypto/aead.h
@@ -312,9 +312,9 @@ static inline void crypto_stat_aead_encrypt(struct aead_request *req, int ret)
 	struct crypto_aead *tfm = crypto_aead_reqtfm(req);
 
 	if (ret && ret != -EINPROGRESS && ret != -EBUSY) {
-		atomic_inc(&tfm->base.__crt_alg->aead_err_cnt);
+		atomic64_inc(&tfm->base.__crt_alg->aead_err_cnt);
 	} else {
-		atomic_inc(&tfm->base.__crt_alg->encrypt_cnt);
+		atomic64_inc(&tfm->base.__crt_alg->encrypt_cnt);
 		atomic64_add(req->cryptlen, &tfm->base.__crt_alg->encrypt_tlen);
 	}
 #endif
@@ -326,9 +326,9 @@ static inline void crypto_stat_aead_decrypt(struct aead_request *req, int ret)
 	struct crypto_aead *tfm = crypto_aead_reqtfm(req);
 
 	if (ret && ret != -EINPROGRESS && ret != -EBUSY) {
-		atomic_inc(&tfm->base.__crt_alg->aead_err_cnt);
+		atomic64_inc(&tfm->base.__crt_alg->aead_err_cnt);
 	} else {
-		atomic_inc(&tfm->base.__crt_alg->decrypt_cnt);
+		atomic64_inc(&tfm->base.__crt_alg->decrypt_cnt);
 		atomic64_add(req->cryptlen, &tfm->base.__crt_alg->decrypt_tlen);
 	}
 #endif
diff --git a/include/crypto/akcipher.h b/include/crypto/akcipher.h
index ee072a82d39d..97056fd5e718 100644
--- a/include/crypto/akcipher.h
+++ b/include/crypto/akcipher.h
@@ -278,9 +278,9 @@ static inline void crypto_stat_akcipher_encrypt(struct akcipher_request *req,
 	struct crypto_akcipher *tfm = crypto_akcipher_reqtfm(req);
 
 	if (ret && ret != -EINPROGRESS && ret != -EBUSY) {
-		atomic_inc(&tfm->base.__crt_alg->akcipher_err_cnt);
+		atomic64_inc(&tfm->base.__crt_alg->akcipher_err_cnt);
 	} else {
-		atomic_inc(&tfm->base.__crt_alg->encrypt_cnt);
+		atomic64_inc(&tfm->base.__crt_alg->encrypt_cnt);
 		atomic64_add(req->src_len, &tfm->base.__crt_alg->encrypt_tlen);
 	}
 #endif
@@ -293,9 +293,9 @@ static inline void crypto_stat_akcipher_decrypt(struct akcipher_request *req,
 	struct crypto_akcipher *tfm = crypto_akcipher_reqtfm(req);
 
 	if (ret && ret != -EINPROGRESS && ret != -EBUSY) {
-		atomic_inc(&tfm->base.__crt_alg->akcipher_err_cnt);
+		atomic64_inc(&tfm->base.__crt_alg->akcipher_err_cnt);
 	} else {
-		atomic_inc(&tfm->base.__crt_alg->decrypt_cnt);
+		atomic64_inc(&tfm->base.__crt_alg->decrypt_cnt);
 		atomic64_add(req->src_len, &tfm->base.__crt_alg->decrypt_tlen);
 	}
 #endif
@@ -308,9 +308,9 @@ static inline void crypto_stat_akcipher_sign(struct akcipher_request *req,
 	struct crypto_akcipher *tfm = crypto_akcipher_reqtfm(req);
 
 	if (ret && ret != -EINPROGRESS && ret != -EBUSY)
-		atomic_inc(&tfm->base.__crt_alg->akcipher_err_cnt);
+		atomic64_inc(&tfm->base.__crt_alg->akcipher_err_cnt);
 	else
-		atomic_inc(&tfm->base.__crt_alg->sign_cnt);
+		atomic64_inc(&tfm->base.__crt_alg->sign_cnt);
 #endif
 }
 
@@ -321,9 +321,9 @@ static inline void crypto_stat_akcipher_verify(struct akcipher_request *req,
 	struct crypto_akcipher *tfm = crypto_akcipher_reqtfm(req);
 
 	if (ret && ret != -EINPROGRESS && ret != -EBUSY)
-		atomic_inc(&tfm->base.__crt_alg->akcipher_err_cnt);
+		atomic64_inc(&tfm->base.__crt_alg->akcipher_err_cnt);
 	else
-		atomic_inc(&tfm->base.__crt_alg->verify_cnt);
+		atomic64_inc(&tfm->base.__crt_alg->verify_cnt);
 #endif
 }
 
diff --git a/include/crypto/hash.h b/include/crypto/hash.h
index bc7796600338..52920bed05ba 100644
--- a/include/crypto/hash.h
+++ b/include/crypto/hash.h
@@ -418,7 +418,7 @@ static inline void crypto_stat_ahash_update(struct ahash_request *req, int ret)
 	struct crypto_ahash *tfm = crypto_ahash_reqtfm(req);
 
 	if (ret && ret != -EINPROGRESS && ret != -EBUSY)
-		atomic_inc(&tfm->base.__crt_alg->hash_err_cnt);
+		atomic64_inc(&tfm->base.__crt_alg->hash_err_cnt);
 	else
 		atomic64_add(req->nbytes, &tfm->base.__crt_alg->hash_tlen);
 #endif
@@ -430,9 +430,9 @@ static inline void crypto_stat_ahash_final(struct ahash_request *req, int ret)
 	struct crypto_ahash *tfm = crypto_ahash_reqtfm(req);
 
 	if (ret && ret != -EINPROGRESS && ret != -EBUSY) {
-		atomic_inc(&tfm->base.__crt_alg->hash_err_cnt);
+		atomic64_inc(&tfm->base.__crt_alg->hash_err_cnt);
 	} else {
-		atomic_inc(&tfm->base.__crt_alg->hash_cnt);
+		atomic64_inc(&tfm->base.__crt_alg->hash_cnt);
 		atomic64_add(req->nbytes, &tfm->base.__crt_alg->hash_tlen);
 	}
 #endif
diff --git a/include/crypto/kpp.h b/include/crypto/kpp.h
index f517ba6d3a27..bd5103a80919 100644
--- a/include/crypto/kpp.h
+++ b/include/crypto/kpp.h
@@ -272,9 +272,9 @@ static inline void crypto_stat_kpp_set_secret(struct crypto_kpp *tfm, int ret)
 {
 #ifdef CONFIG_CRYPTO_STATS
 	if (ret)
-		atomic_inc(&tfm->base.__crt_alg->kpp_err_cnt);
+		atomic64_inc(&tfm->base.__crt_alg->kpp_err_cnt);
 	else
-		atomic_inc(&tfm->base.__crt_alg->setsecret_cnt);
+		atomic64_inc(&tfm->base.__crt_alg->setsecret_cnt);
 #endif
 }
 
@@ -285,9 +285,9 @@ static inline void crypto_stat_kpp_generate_public_key(struct kpp_request *req,
 	struct crypto_kpp *tfm = crypto_kpp_reqtfm(req);
 
 	if (ret)
-		atomic_inc(&tfm->base.__crt_alg->kpp_err_cnt);
+		atomic64_inc(&tfm->base.__crt_alg->kpp_err_cnt);
 	else
-		atomic_inc(&tfm->base.__crt_alg->generate_public_key_cnt);
+		atomic64_inc(&tfm->base.__crt_alg->generate_public_key_cnt);
 #endif
 }
 
@@ -298,9 +298,9 @@ static inline void crypto_stat_kpp_compute_shared_secret(struct kpp_request *req
 	struct crypto_kpp *tfm = crypto_kpp_reqtfm(req);
 
 	if (ret)
-		atomic_inc(&tfm->base.__crt_alg->kpp_err_cnt);
+		atomic64_inc(&tfm->base.__crt_alg->kpp_err_cnt);
 	else
-		atomic_inc(&tfm->base.__crt_alg->compute_shared_secret_cnt);
+		atomic64_inc(&tfm->base.__crt_alg->compute_shared_secret_cnt);
 #endif
 }
 
diff --git a/include/crypto/rng.h b/include/crypto/rng.h
index 0d781fa77161..bdcaac34e9d7 100644
--- a/include/crypto/rng.h
+++ b/include/crypto/rng.h
@@ -126,9 +126,9 @@ static inline void crypto_stat_rng_seed(struct crypto_rng *tfm, int ret)
 {
 #ifdef CONFIG_CRYPTO_STATS
 	if (ret && ret != -EINPROGRESS && ret != -EBUSY)
-		atomic_inc(&tfm->base.__crt_alg->rng_err_cnt);
+		atomic64_inc(&tfm->base.__crt_alg->rng_err_cnt);
 	else
-		atomic_inc(&tfm->base.__crt_alg->seed_cnt);
+		atomic64_inc(&tfm->base.__crt_alg->seed_cnt);
 #endif
 }
 
@@ -137,9 +137,9 @@ static inline void crypto_stat_rng_generate(struct crypto_rng *tfm,
 {
 #ifdef CONFIG_CRYPTO_STATS
 	if (ret && ret != -EINPROGRESS && ret != -EBUSY) {
-		atomic_inc(&tfm->base.__crt_alg->rng_err_cnt);
+		atomic64_inc(&tfm->base.__crt_alg->rng_err_cnt);
 	} else {
-		atomic_inc(&tfm->base.__crt_alg->generate_cnt);
+		atomic64_inc(&tfm->base.__crt_alg->generate_cnt);
 		atomic64_add(dlen, &tfm->base.__crt_alg->generate_tlen);
 	}
 #endif
diff --git a/include/crypto/skcipher.h b/include/crypto/skcipher.h
index 925f547cdcfa..dff54731ddf4 100644
--- a/include/crypto/skcipher.h
+++ b/include/crypto/skcipher.h
@@ -491,9 +491,9 @@ static inline void crypto_stat_skcipher_encrypt(struct skcipher_request *req,
 {
 #ifdef CONFIG_CRYPTO_STATS
 	if (ret && ret != -EINPROGRESS && ret != -EBUSY) {
-		atomic_inc(&alg->cipher_err_cnt);
+		atomic64_inc(&alg->cipher_err_cnt);
 	} else {
-		atomic_inc(&alg->encrypt_cnt);
+		atomic64_inc(&alg->encrypt_cnt);
 		atomic64_add(req->cryptlen, &alg->encrypt_tlen);
 	}
 #endif
@@ -504,9 +504,9 @@ static inline void crypto_stat_skcipher_decrypt(struct skcipher_request *req,
 {
 #ifdef CONFIG_CRYPTO_STATS
 	if (ret && ret != -EINPROGRESS && ret != -EBUSY) {
-		atomic_inc(&alg->cipher_err_cnt);
+		atomic64_inc(&alg->cipher_err_cnt);
 	} else {
-		atomic_inc(&alg->decrypt_cnt);
+		atomic64_inc(&alg->decrypt_cnt);
 		atomic64_add(req->cryptlen, &alg->decrypt_tlen);
 	}
 #endif
diff --git a/include/linux/crypto.h b/include/linux/crypto.h
index 3e05053b8d57..b109b50906e7 100644
--- a/include/linux/crypto.h
+++ b/include/linux/crypto.h
@@ -517,11 +517,11 @@ struct crypto_alg {
 
 #ifdef CONFIG_CRYPTO_STATS
 	union {
-		atomic_t encrypt_cnt;
-		atomic_t compress_cnt;
-		atomic_t generate_cnt;
-		atomic_t hash_cnt;
-		atomic_t setsecret_cnt;
+		atomic64_t encrypt_cnt;
+		atomic64_t compress_cnt;
+		atomic64_t generate_cnt;
+		atomic64_t hash_cnt;
+		atomic64_t setsecret_cnt;
 	};
 	union {
 		atomic64_t encrypt_tlen;
@@ -530,29 +530,29 @@ struct crypto_alg {
 		atomic64_t hash_tlen;
 	};
 	union {
-		atomic_t akcipher_err_cnt;
-		atomic_t cipher_err_cnt;
-		atomic_t compress_err_cnt;
-		atomic_t aead_err_cnt;
-		atomic_t hash_err_cnt;
-		atomic_t rng_err_cnt;
-		atomic_t kpp_err_cnt;
+		atomic64_t akcipher_err_cnt;
+		atomic64_t cipher_err_cnt;
+		atomic64_t compress_err_cnt;
+		atomic64_t aead_err_cnt;
+		atomic64_t hash_err_cnt;
+		atomic64_t rng_err_cnt;
+		atomic64_t kpp_err_cnt;
 	};
 	union {
-		atomic_t decrypt_cnt;
-		atomic_t decompress_cnt;
-		atomic_t seed_cnt;
-		atomic_t generate_public_key_cnt;
+		atomic64_t decrypt_cnt;
+		atomic64_t decompress_cnt;
+		atomic64_t seed_cnt;
+		atomic64_t generate_public_key_cnt;
 	};
 	union {
 		atomic64_t decrypt_tlen;
 		atomic64_t decompress_tlen;
 	};
 	union {
-		atomic_t verify_cnt;
-		atomic_t compute_shared_secret_cnt;
+		atomic64_t verify_cnt;
+		atomic64_t compute_shared_secret_cnt;
 	};
-	atomic_t sign_cnt;
+	atomic64_t sign_cnt;
 #endif /* CONFIG_CRYPTO_STATS */
 
 } CRYPTO_MINALIGN_ATTR;
@@ -983,9 +983,9 @@ static inline void crypto_stat_ablkcipher_encrypt(struct ablkcipher_request *req
 		crypto_ablkcipher_crt(crypto_ablkcipher_reqtfm(req));
 
 	if (ret && ret != -EINPROGRESS && ret != -EBUSY) {
-		atomic_inc(&crt->base->base.__crt_alg->cipher_err_cnt);
+		atomic64_inc(&crt->base->base.__crt_alg->cipher_err_cnt);
 	} else {
-		atomic_inc(&crt->base->base.__crt_alg->encrypt_cnt);
+		atomic64_inc(&crt->base->base.__crt_alg->encrypt_cnt);
 		atomic64_add(req->nbytes, &crt->base->base.__crt_alg->encrypt_tlen);
 	}
 #endif
@@ -999,9 +999,9 @@ static inline void crypto_stat_ablkcipher_decrypt(struct ablkcipher_request *req
 		crypto_ablkcipher_crt(crypto_ablkcipher_reqtfm(req));
 
 	if (ret && ret != -EINPROGRESS && ret != -EBUSY) {
-		atomic_inc(&crt->base->base.__crt_alg->cipher_err_cnt);
+		atomic64_inc(&crt->base->base.__crt_alg->cipher_err_cnt);
 	} else {
-		atomic_inc(&crt->base->base.__crt_alg->decrypt_cnt);
+		atomic64_inc(&crt->base->base.__crt_alg->decrypt_cnt);
 		atomic64_add(req->nbytes, &crt->base->base.__crt_alg->decrypt_tlen);
 	}
 #endif
diff --git a/include/uapi/linux/cryptouser.h b/include/uapi/linux/cryptouser.h
index 6dafbc3e4414..9f8187077ce4 100644
--- a/include/uapi/linux/cryptouser.h
+++ b/include/uapi/linux/cryptouser.h
@@ -79,11 +79,11 @@ struct crypto_user_alg {
 struct crypto_stat {
 	char type[CRYPTO_MAX_NAME];
 	union {
-		__u32 stat_encrypt_cnt;
-		__u32 stat_compress_cnt;
-		__u32 stat_generate_cnt;
-		__u32 stat_hash_cnt;
-		__u32 stat_setsecret_cnt;
+		__u64 stat_encrypt_cnt;
+		__u64 stat_compress_cnt;
+		__u64 stat_generate_cnt;
+		__u64 stat_hash_cnt;
+		__u64 stat_setsecret_cnt;
 	};
 	union {
 		__u64 stat_encrypt_tlen;
@@ -92,29 +92,29 @@ struct crypto_stat {
 		__u64 stat_hash_tlen;
 	};
 	union {
-		__u32 stat_akcipher_err_cnt;
-		__u32 stat_cipher_err_cnt;
-		__u32 stat_compress_err_cnt;
-		__u32 stat_aead_err_cnt;
-		__u32 stat_hash_err_cnt;
-		__u32 stat_rng_err_cnt;
-		__u32 stat_kpp_err_cnt;
+		__u64 stat_akcipher_err_cnt;
+		__u64 stat_cipher_err_cnt;
+		__u64 stat_compress_err_cnt;
+		__u64 stat_aead_err_cnt;
+		__u64 stat_hash_err_cnt;
+		__u64 stat_rng_err_cnt;
+		__u64 stat_kpp_err_cnt;
 	};
 	union {
-		__u32 stat_decrypt_cnt;
-		__u32 stat_decompress_cnt;
-		__u32 stat_seed_cnt;
-		__u32 stat_generate_public_key_cnt;
+		__u64 stat_decrypt_cnt;
+		__u64 stat_decompress_cnt;
+		__u64 stat_seed_cnt;
+		__u64 stat_generate_public_key_cnt;
 	};
 	union {
 		__u64 stat_decrypt_tlen;
 		__u64 stat_decompress_tlen;
 	};
 	union {
-		__u32 stat_verify_cnt;
-		__u32 stat_compute_shared_secret_cnt;
+		__u64 stat_verify_cnt;
+		__u64 stat_compute_shared_secret_cnt;
 	};
-	__u32 stat_sign_cnt;
+	__u64 stat_sign_cnt;
 };
 
 struct crypto_report_larval {
-- 
2.18.1

