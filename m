Return-Path: <SRS0=tadO=N6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B354EC43441
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 19:53:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4F0F920831
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 19:53:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="DZsc/uDD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4F0F920831
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730661AbeKTGS6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Nov 2018 01:18:58 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:35921 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730576AbeKTGS4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Nov 2018 01:18:56 -0500
Received: by mail-wr1-f65.google.com with SMTP id t3so3165625wrr.3
        for <linux-kernel@vger.kernel.org>; Mon, 19 Nov 2018 11:53:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=hbTV1P4EudfxkogYWWPIYpXcJLUtfuU5nLZMHdScVHg=;
        b=DZsc/uDDyLTQDrdhln38JlN4FIOYJAEA06Q31MaZ2F2tSWSZG4WRv0pXB0n3o+DXm6
         KyegOQayhT2BFtnGGVkbOup2F6oE2p3NFNp7r9dyY0YvcZ6x1Pn/hDVPL1GXILEeL/HC
         U/ZvZ6JBifVXqr7LqvVz6Qi8DCEL9OM3R4yiJOsClqDr6xAm8VQUQ0mcWM7g7bqidOXh
         w+yLpYS2AMQW9msMEFGNj28cN7L3bM59lEIefJAU4nQNfDhr0Zy08z/9wu9Q0QuId3l5
         q1cvgjoHbzwpdFlw44o1sH9o18xixUr0Az403nGJ+yFiUclOk2theUWbyssOe3kPdtW6
         4bSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=hbTV1P4EudfxkogYWWPIYpXcJLUtfuU5nLZMHdScVHg=;
        b=FheplHxcntbBJ/rbPkSChwc8zCgrpxN5QxofiIq1MaPpfmTcww9Ko219Vo871cmAtp
         tO99fT9xqpO1A+2TetidD6Wjl8jCuosQdvEMyxWl8fyWifYxIs+usuyLWp1thvAPw5+Y
         3ifIRm/b99V7/Qm0pShrFa/dCYCH7QjCvfyl1J+dmN7eTbgKSGBt4+xCx+wn8WH+2Y/R
         ZfFv9NZ1KMS9rHF2Ba2Ys5t3DG6wKja77bTZwr6tb6YEbCaWaY8erxljdaDbibBvam+j
         C/vfAazhm6SW/T2QMiH192KUBK5twqqHpBtD6RXeCDjxgKPVnm1daTfuA5r+p3R0MY1+
         OvBg==
X-Gm-Message-State: AGRZ1gLhB0DnOJEEbNPzLFkDnvZJ1yDZ+YVxwpmrayi070NnGk2vVPYy
        mfv5vfPv36dHw3BaM5Uxaqe+cw==
X-Google-Smtp-Source: AJdET5eXSPa4XSjpY5uVWIKcFe/vjUWXw2UXt8LJSbb15+c17DoI03s/wmDpWEz/I6tqdK7LOA+l2A==
X-Received: by 2002:adf:be0f:: with SMTP id n15mr19951340wrh.267.1542657223270;
        Mon, 19 Nov 2018 11:53:43 -0800 (PST)
Received: from localhost.localdomain ([51.15.160.169])
        by smtp.googlemail.com with ESMTPSA id i16sm22954132wmd.28.2018.11.19.11.53.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 19 Nov 2018 11:53:42 -0800 (PST)
From:   Corentin Labbe <clabbe@baylibre.com>
To:     davem@davemloft.net, ebiggers@kernel.org,
        herbert@gondor.apana.org.au, nhorman@tuxdriver.com
Cc:     linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        Corentin Labbe <clabbe@baylibre.com>
Subject: [PATCH v2 07/11] crypto: crypto_user_stat: fix use_after_free of struct xxx_request
Date:   Mon, 19 Nov 2018 19:53:26 +0000
Message-Id: <1542657210-37739-8-git-send-email-clabbe@baylibre.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1542657210-37739-1-git-send-email-clabbe@baylibre.com>
References: <1542657210-37739-1-git-send-email-clabbe@baylibre.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

All crypto_stats functions use the struct xxx_request for feeding stats,
but in some case this structure could already be freed.

For fixing this, the needed parameters (len and alg) will be stored
before the request being executed.
Fixes: cac5818c25d0 ("crypto: user - Implement a generic crypto statistics")
Reported-by: syzbot <syzbot+6939a606a5305e9e9799@syzkaller.appspotmail.com>

Signed-off-by: Corentin Labbe <clabbe@baylibre.com>
---
 crypto/ahash.c             | 23 ++++++++++--
 crypto/rng.c               |  6 +++-
 include/crypto/acompress.h | 38 ++++++++++++--------
 include/crypto/aead.h      | 38 ++++++++++++--------
 include/crypto/akcipher.h  | 72 ++++++++++++++++++++++----------------
 include/crypto/hash.h      | 30 +++++++++-------
 include/crypto/kpp.h       | 43 ++++++++++++++---------
 include/crypto/rng.h       | 22 +++++++-----
 include/crypto/skcipher.h  | 24 +++++++++----
 include/linux/crypto.h     | 42 ++++++++++++----------
 10 files changed, 216 insertions(+), 122 deletions(-)

diff --git a/crypto/ahash.c b/crypto/ahash.c
index 3a348fbcf8f9..9e907fcc8944 100644
--- a/crypto/ahash.c
+++ b/crypto/ahash.c
@@ -364,20 +364,32 @@ static int crypto_ahash_op(struct ahash_request *req,
 
 int crypto_ahash_final(struct ahash_request *req)
 {
+	struct crypto_ahash *tfm = crypto_ahash_reqtfm(req);
+	struct crypto_alg *alg = tfm->base.__crt_alg;
+	unsigned int nbytes = req->nbytes;
 	int ret;
 
+#ifdef CONFIG_CRYPTO_STATS
+	crypto_alg_get(alg);
+#endif
 	ret = crypto_ahash_op(req, crypto_ahash_reqtfm(req)->final);
-	crypto_stat_ahash_final(req, ret);
+	crypto_stat_ahash_final(nbytes, ret, alg);
 	return ret;
 }
 EXPORT_SYMBOL_GPL(crypto_ahash_final);
 
 int crypto_ahash_finup(struct ahash_request *req)
 {
+	struct crypto_ahash *tfm = crypto_ahash_reqtfm(req);
+	struct crypto_alg *alg = tfm->base.__crt_alg;
+	unsigned int nbytes = req->nbytes;
 	int ret;
 
+#ifdef CONFIG_CRYPTO_STATS
+	crypto_alg_get(alg);
+#endif
 	ret = crypto_ahash_op(req, crypto_ahash_reqtfm(req)->finup);
-	crypto_stat_ahash_final(req, ret);
+	crypto_stat_ahash_final(nbytes, ret, alg);
 	return ret;
 }
 EXPORT_SYMBOL_GPL(crypto_ahash_finup);
@@ -385,13 +397,18 @@ EXPORT_SYMBOL_GPL(crypto_ahash_finup);
 int crypto_ahash_digest(struct ahash_request *req)
 {
 	struct crypto_ahash *tfm = crypto_ahash_reqtfm(req);
+	struct crypto_alg *alg = tfm->base.__crt_alg;
+	unsigned int nbytes = req->nbytes;
 	int ret;
 
+#ifdef CONFIG_CRYPTO_STATS
+	crypto_alg_get(alg);
+#endif
 	if (crypto_ahash_get_flags(tfm) & CRYPTO_TFM_NEED_KEY)
 		ret = -ENOKEY;
 	else
 		ret = crypto_ahash_op(req, tfm->digest);
-	crypto_stat_ahash_final(req, ret);
+	crypto_stat_ahash_final(nbytes, ret, alg);
 	return ret;
 }
 EXPORT_SYMBOL_GPL(crypto_ahash_digest);
diff --git a/crypto/rng.c b/crypto/rng.c
index 2406501b90b7..60a21f0124d3 100644
--- a/crypto/rng.c
+++ b/crypto/rng.c
@@ -35,9 +35,13 @@ static int crypto_default_rng_refcnt;
 
 int crypto_rng_reset(struct crypto_rng *tfm, const u8 *seed, unsigned int slen)
 {
+	struct crypto_alg *alg = tfm->base.__crt_alg;
 	u8 *buf = NULL;
 	int err;
 
+#ifdef CONFIG_CRYPTO_STATS
+	crypto_alg_get(alg);
+#endif
 	if (!seed && slen) {
 		buf = kmalloc(slen, GFP_KERNEL);
 		if (!buf)
@@ -50,7 +54,7 @@ int crypto_rng_reset(struct crypto_rng *tfm, const u8 *seed, unsigned int slen)
 	}
 
 	err = crypto_rng_alg(tfm)->seed(tfm, seed, slen);
-	crypto_stat_rng_seed(tfm, err);
+	crypto_stat_rng_seed(alg, err);
 out:
 	kzfree(buf);
 	return err;
diff --git a/include/crypto/acompress.h b/include/crypto/acompress.h
index f79918196811..cb19ba60399b 100644
--- a/include/crypto/acompress.h
+++ b/include/crypto/acompress.h
@@ -234,31 +234,31 @@ static inline void acomp_request_set_params(struct acomp_req *req,
 		req->flags |= CRYPTO_ACOMP_ALLOC_OUTPUT;
 }
 
-static inline void crypto_stat_compress(struct acomp_req *req, int ret)
+static inline void crypto_stat_compress(unsigned int slen, int ret,
+					struct crypto_alg *alg)
 {
 #ifdef CONFIG_CRYPTO_STATS
-	struct crypto_acomp *tfm = crypto_acomp_reqtfm(req);
-
 	if (ret && ret != -EINPROGRESS && ret != -EBUSY) {
-		atomic64_inc(&tfm->base.__crt_alg->compress_err_cnt);
+		atomic64_inc(&alg->compress_err_cnt);
 	} else {
-		atomic64_inc(&tfm->base.__crt_alg->compress_cnt);
-		atomic64_add(req->slen, &tfm->base.__crt_alg->compress_tlen);
+		atomic64_inc(&alg->compress_cnt);
+		atomic64_add(slen, &alg->compress_tlen);
 	}
+	crypto_alg_put(alg);
 #endif
 }
 
-static inline void crypto_stat_decompress(struct acomp_req *req, int ret)
+static inline void crypto_stat_decompress(unsigned int slen, int ret,
+					  struct crypto_alg *alg)
 {
 #ifdef CONFIG_CRYPTO_STATS
-	struct crypto_acomp *tfm = crypto_acomp_reqtfm(req);
-
 	if (ret && ret != -EINPROGRESS && ret != -EBUSY) {
-		atomic64_inc(&tfm->base.__crt_alg->compress_err_cnt);
+		atomic64_inc(&alg->compress_err_cnt);
 	} else {
-		atomic64_inc(&tfm->base.__crt_alg->decompress_cnt);
-		atomic64_add(req->slen, &tfm->base.__crt_alg->decompress_tlen);
+		atomic64_inc(&alg->decompress_cnt);
+		atomic64_add(slen, &alg->decompress_tlen);
 	}
+	crypto_alg_put(alg);
 #endif
 }
 
@@ -274,10 +274,15 @@ static inline void crypto_stat_decompress(struct acomp_req *req, int ret)
 static inline int crypto_acomp_compress(struct acomp_req *req)
 {
 	struct crypto_acomp *tfm = crypto_acomp_reqtfm(req);
+	struct crypto_alg *alg = tfm->base.__crt_alg;
+	unsigned int slen = req->slen;
 	int ret;
 
+#ifdef CONFIG_CRYPTO_STATS
+	crypto_alg_get(alg);
+#endif
 	ret = tfm->compress(req);
-	crypto_stat_compress(req, ret);
+	crypto_stat_compress(slen, ret, alg);
 	return ret;
 }
 
@@ -293,10 +298,15 @@ static inline int crypto_acomp_compress(struct acomp_req *req)
 static inline int crypto_acomp_decompress(struct acomp_req *req)
 {
 	struct crypto_acomp *tfm = crypto_acomp_reqtfm(req);
+	struct crypto_alg *alg = tfm->base.__crt_alg;
+	unsigned int slen = req->slen;
 	int ret;
 
+#ifdef CONFIG_CRYPTO_STATS
+	crypto_alg_get(alg);
+#endif
 	ret = tfm->decompress(req);
-	crypto_stat_decompress(req, ret);
+	crypto_stat_decompress(slen, ret, alg);
 	return ret;
 }
 
diff --git a/include/crypto/aead.h b/include/crypto/aead.h
index 99afd78c665d..11ab5d3fe3ba 100644
--- a/include/crypto/aead.h
+++ b/include/crypto/aead.h
@@ -306,31 +306,31 @@ static inline struct crypto_aead *crypto_aead_reqtfm(struct aead_request *req)
 	return __crypto_aead_cast(req->base.tfm);
 }
 
-static inline void crypto_stat_aead_encrypt(struct aead_request *req, int ret)
+static inline void crypto_stat_aead_encrypt(unsigned int cryptlen,
+					    struct crypto_alg *alg, int ret)
 {
 #ifdef CONFIG_CRYPTO_STATS
-	struct crypto_aead *tfm = crypto_aead_reqtfm(req);
-
 	if (ret && ret != -EINPROGRESS && ret != -EBUSY) {
-		atomic64_inc(&tfm->base.__crt_alg->aead_err_cnt);
+		atomic64_inc(&alg->aead_err_cnt);
 	} else {
-		atomic64_inc(&tfm->base.__crt_alg->encrypt_cnt);
-		atomic64_add(req->cryptlen, &tfm->base.__crt_alg->encrypt_tlen);
+		atomic64_inc(&alg->encrypt_cnt);
+		atomic64_add(cryptlen, &alg->encrypt_tlen);
 	}
+	crypto_alg_put(alg);
 #endif
 }
 
-static inline void crypto_stat_aead_decrypt(struct aead_request *req, int ret)
+static inline void crypto_stat_aead_decrypt(unsigned int cryptlen,
+					    struct crypto_alg *alg, int ret)
 {
 #ifdef CONFIG_CRYPTO_STATS
-	struct crypto_aead *tfm = crypto_aead_reqtfm(req);
-
 	if (ret && ret != -EINPROGRESS && ret != -EBUSY) {
-		atomic64_inc(&tfm->base.__crt_alg->aead_err_cnt);
+		atomic64_inc(&alg->aead_err_cnt);
 	} else {
-		atomic64_inc(&tfm->base.__crt_alg->decrypt_cnt);
-		atomic64_add(req->cryptlen, &tfm->base.__crt_alg->decrypt_tlen);
+		atomic64_inc(&alg->decrypt_cnt);
+		atomic64_add(cryptlen, &alg->decrypt_tlen);
 	}
+	crypto_alg_put(alg);
 #endif
 }
 
@@ -356,13 +356,18 @@ static inline void crypto_stat_aead_decrypt(struct aead_request *req, int ret)
 static inline int crypto_aead_encrypt(struct aead_request *req)
 {
 	struct crypto_aead *aead = crypto_aead_reqtfm(req);
+	struct crypto_alg *alg = aead->base.__crt_alg;
+	unsigned int cryptlen = req->cryptlen;
 	int ret;
 
+#ifdef CONFIG_CRYPTO_STATS
+	crypto_alg_get(alg);
+#endif
 	if (crypto_aead_get_flags(aead) & CRYPTO_TFM_NEED_KEY)
 		ret = -ENOKEY;
 	else
 		ret = crypto_aead_alg(aead)->encrypt(req);
-	crypto_stat_aead_encrypt(req, ret);
+	crypto_stat_aead_encrypt(cryptlen, alg, ret);
 	return ret;
 }
 
@@ -391,15 +396,20 @@ static inline int crypto_aead_encrypt(struct aead_request *req)
 static inline int crypto_aead_decrypt(struct aead_request *req)
 {
 	struct crypto_aead *aead = crypto_aead_reqtfm(req);
+	struct crypto_alg *alg = aead->base.__crt_alg;
+	unsigned int cryptlen = req->cryptlen;
 	int ret;
 
+#ifdef CONFIG_CRYPTO_STATS
+	crypto_alg_get(alg);
+#endif
 	if (crypto_aead_get_flags(aead) & CRYPTO_TFM_NEED_KEY)
 		ret = -ENOKEY;
 	else if (req->cryptlen < crypto_aead_authsize(aead))
 		ret = -EINVAL;
 	else
 		ret = crypto_aead_alg(aead)->decrypt(req);
-	crypto_stat_aead_decrypt(req, ret);
+	crypto_stat_aead_decrypt(cryptlen, alg, ret);
 	return ret;
 }
 
diff --git a/include/crypto/akcipher.h b/include/crypto/akcipher.h
index 97056fd5e718..10dd1eaff211 100644
--- a/include/crypto/akcipher.h
+++ b/include/crypto/akcipher.h
@@ -271,59 +271,53 @@ static inline unsigned int crypto_akcipher_maxsize(struct crypto_akcipher *tfm)
 	return alg->max_size(tfm);
 }
 
-static inline void crypto_stat_akcipher_encrypt(struct akcipher_request *req,
-						int ret)
+static inline void crypto_stat_akcipher_encrypt(unsigned int src_len, int ret,
+						struct crypto_alg *alg)
 {
 #ifdef CONFIG_CRYPTO_STATS
-	struct crypto_akcipher *tfm = crypto_akcipher_reqtfm(req);
-
 	if (ret && ret != -EINPROGRESS && ret != -EBUSY) {
-		atomic64_inc(&tfm->base.__crt_alg->akcipher_err_cnt);
+		atomic64_inc(&alg->akcipher_err_cnt);
 	} else {
-		atomic64_inc(&tfm->base.__crt_alg->encrypt_cnt);
-		atomic64_add(req->src_len, &tfm->base.__crt_alg->encrypt_tlen);
+		atomic64_inc(&alg->encrypt_cnt);
+		atomic64_add(src_len, &alg->encrypt_tlen);
 	}
+	crypto_alg_put(alg);
 #endif
 }
 
-static inline void crypto_stat_akcipher_decrypt(struct akcipher_request *req,
-						int ret)
+static inline void crypto_stat_akcipher_decrypt(unsigned int src_len, int ret,
+						struct crypto_alg *alg)
 {
 #ifdef CONFIG_CRYPTO_STATS
-	struct crypto_akcipher *tfm = crypto_akcipher_reqtfm(req);
-
 	if (ret && ret != -EINPROGRESS && ret != -EBUSY) {
-		atomic64_inc(&tfm->base.__crt_alg->akcipher_err_cnt);
+		atomic64_inc(&alg->akcipher_err_cnt);
 	} else {
-		atomic64_inc(&tfm->base.__crt_alg->decrypt_cnt);
-		atomic64_add(req->src_len, &tfm->base.__crt_alg->decrypt_tlen);
+		atomic64_inc(&alg->decrypt_cnt);
+		atomic64_add(src_len, &alg->decrypt_tlen);
 	}
+	crypto_alg_put(alg);
 #endif
 }
 
-static inline void crypto_stat_akcipher_sign(struct akcipher_request *req,
-					     int ret)
+static inline void crypto_stat_akcipher_sign(int ret, struct crypto_alg *alg)
 {
 #ifdef CONFIG_CRYPTO_STATS
-	struct crypto_akcipher *tfm = crypto_akcipher_reqtfm(req);
-
 	if (ret && ret != -EINPROGRESS && ret != -EBUSY)
-		atomic64_inc(&tfm->base.__crt_alg->akcipher_err_cnt);
+		atomic64_inc(&alg->akcipher_err_cnt);
 	else
-		atomic64_inc(&tfm->base.__crt_alg->sign_cnt);
+		atomic64_inc(&alg->sign_cnt);
+	crypto_alg_put(alg);
 #endif
 }
 
-static inline void crypto_stat_akcipher_verify(struct akcipher_request *req,
-					       int ret)
+static inline void crypto_stat_akcipher_verify(int ret, struct crypto_alg *alg)
 {
 #ifdef CONFIG_CRYPTO_STATS
-	struct crypto_akcipher *tfm = crypto_akcipher_reqtfm(req);
-
 	if (ret && ret != -EINPROGRESS && ret != -EBUSY)
-		atomic64_inc(&tfm->base.__crt_alg->akcipher_err_cnt);
+		atomic64_inc(&alg->akcipher_err_cnt);
 	else
-		atomic64_inc(&tfm->base.__crt_alg->verify_cnt);
+		atomic64_inc(&alg->verify_cnt);
+	crypto_alg_put(alg);
 #endif
 }
 
@@ -341,10 +335,15 @@ static inline int crypto_akcipher_encrypt(struct akcipher_request *req)
 {
 	struct crypto_akcipher *tfm = crypto_akcipher_reqtfm(req);
 	struct akcipher_alg *alg = crypto_akcipher_alg(tfm);
+	struct crypto_alg *calg = tfm->base.__crt_alg;
+	unsigned int src_len = req->src_len;
 	int ret;
 
+#ifdef CONFIG_CRYPTO_STATS
+	crypto_alg_get(calg);
+#endif
 	ret = alg->encrypt(req);
-	crypto_stat_akcipher_encrypt(req, ret);
+	crypto_stat_akcipher_encrypt(src_len, ret, calg);
 	return ret;
 }
 
@@ -362,10 +361,15 @@ static inline int crypto_akcipher_decrypt(struct akcipher_request *req)
 {
 	struct crypto_akcipher *tfm = crypto_akcipher_reqtfm(req);
 	struct akcipher_alg *alg = crypto_akcipher_alg(tfm);
+	struct crypto_alg *calg = tfm->base.__crt_alg;
+	unsigned int src_len = req->src_len;
 	int ret;
 
+#ifdef CONFIG_CRYPTO_STATS
+	crypto_alg_get(calg);
+#endif
 	ret = alg->decrypt(req);
-	crypto_stat_akcipher_decrypt(req, ret);
+	crypto_stat_akcipher_decrypt(src_len, ret, calg);
 	return ret;
 }
 
@@ -383,10 +387,14 @@ static inline int crypto_akcipher_sign(struct akcipher_request *req)
 {
 	struct crypto_akcipher *tfm = crypto_akcipher_reqtfm(req);
 	struct akcipher_alg *alg = crypto_akcipher_alg(tfm);
+	struct crypto_alg *calg = tfm->base.__crt_alg;
 	int ret;
 
+#ifdef CONFIG_CRYPTO_STATS
+	crypto_alg_get(calg);
+#endif
 	ret = alg->sign(req);
-	crypto_stat_akcipher_sign(req, ret);
+	crypto_stat_akcipher_sign(ret, calg);
 	return ret;
 }
 
@@ -404,10 +412,14 @@ static inline int crypto_akcipher_verify(struct akcipher_request *req)
 {
 	struct crypto_akcipher *tfm = crypto_akcipher_reqtfm(req);
 	struct akcipher_alg *alg = crypto_akcipher_alg(tfm);
+	struct crypto_alg *calg = tfm->base.__crt_alg;
 	int ret;
 
+#ifdef CONFIG_CRYPTO_STATS
+	crypto_alg_get(calg);
+#endif
 	ret = alg->verify(req);
-	crypto_stat_akcipher_verify(req, ret);
+	crypto_stat_akcipher_verify(ret, calg);
 	return ret;
 }
 
diff --git a/include/crypto/hash.h b/include/crypto/hash.h
index 52920bed05ba..bf88dea99ff6 100644
--- a/include/crypto/hash.h
+++ b/include/crypto/hash.h
@@ -412,29 +412,29 @@ static inline void *ahash_request_ctx(struct ahash_request *req)
 int crypto_ahash_setkey(struct crypto_ahash *tfm, const u8 *key,
 			unsigned int keylen);
 
-static inline void crypto_stat_ahash_update(struct ahash_request *req, int ret)
+static inline void crypto_stat_ahash_update(unsigned int nbytes, int ret,
+					    struct crypto_alg *alg)
 {
 #ifdef CONFIG_CRYPTO_STATS
-	struct crypto_ahash *tfm = crypto_ahash_reqtfm(req);
-
 	if (ret && ret != -EINPROGRESS && ret != -EBUSY)
-		atomic64_inc(&tfm->base.__crt_alg->hash_err_cnt);
+		atomic64_inc(&alg->hash_err_cnt);
 	else
-		atomic64_add(req->nbytes, &tfm->base.__crt_alg->hash_tlen);
+		atomic64_add(nbytes, &alg->hash_tlen);
+	crypto_alg_put(alg);
 #endif
 }
 
-static inline void crypto_stat_ahash_final(struct ahash_request *req, int ret)
+static inline void crypto_stat_ahash_final(unsigned int nbytes, int ret,
+					   struct crypto_alg *alg)
 {
 #ifdef CONFIG_CRYPTO_STATS
-	struct crypto_ahash *tfm = crypto_ahash_reqtfm(req);
-
 	if (ret && ret != -EINPROGRESS && ret != -EBUSY) {
-		atomic64_inc(&tfm->base.__crt_alg->hash_err_cnt);
+		atomic64_inc(&alg->hash_err_cnt);
 	} else {
-		atomic64_inc(&tfm->base.__crt_alg->hash_cnt);
-		atomic64_add(req->nbytes, &tfm->base.__crt_alg->hash_tlen);
+		atomic64_inc(&alg->hash_cnt);
+		atomic64_add(nbytes, &alg->hash_tlen);
 	}
+	crypto_alg_put(alg);
 #endif
 }
 
@@ -552,10 +552,16 @@ static inline int crypto_ahash_init(struct ahash_request *req)
  */
 static inline int crypto_ahash_update(struct ahash_request *req)
 {
+	struct crypto_ahash *tfm = crypto_ahash_reqtfm(req);
+	struct crypto_alg *alg = tfm->base.__crt_alg;
+	unsigned int nbytes = req->nbytes;
 	int ret;
 
+#ifdef CONFIG_CRYPTO_STATS
+	crypto_alg_get(alg);
+#endif
 	ret = crypto_ahash_reqtfm(req)->update(req);
-	crypto_stat_ahash_update(req, ret);
+	crypto_stat_ahash_update(nbytes, ret, alg);
 	return ret;
 }
 
diff --git a/include/crypto/kpp.h b/include/crypto/kpp.h
index bd5103a80919..ccab8eac04b9 100644
--- a/include/crypto/kpp.h
+++ b/include/crypto/kpp.h
@@ -268,39 +268,38 @@ struct kpp_secret {
 	unsigned short len;
 };
 
-static inline void crypto_stat_kpp_set_secret(struct crypto_kpp *tfm, int ret)
+static inline void crypto_stat_kpp_set_secret(struct crypto_alg *alg, int ret)
 {
 #ifdef CONFIG_CRYPTO_STATS
 	if (ret)
-		atomic64_inc(&tfm->base.__crt_alg->kpp_err_cnt);
+		atomic64_inc(&alg->kpp_err_cnt);
 	else
-		atomic64_inc(&tfm->base.__crt_alg->setsecret_cnt);
+		atomic64_inc(&alg->setsecret_cnt);
+	crypto_alg_put(alg);
 #endif
 }
 
-static inline void crypto_stat_kpp_generate_public_key(struct kpp_request *req,
+static inline void crypto_stat_kpp_generate_public_key(struct crypto_alg *alg,
 						       int ret)
 {
 #ifdef CONFIG_CRYPTO_STATS
-	struct crypto_kpp *tfm = crypto_kpp_reqtfm(req);
-
 	if (ret)
-		atomic64_inc(&tfm->base.__crt_alg->kpp_err_cnt);
+		atomic64_inc(&alg->kpp_err_cnt);
 	else
-		atomic64_inc(&tfm->base.__crt_alg->generate_public_key_cnt);
+		atomic64_inc(&alg->generate_public_key_cnt);
+	crypto_alg_put(alg);
 #endif
 }
 
-static inline void crypto_stat_kpp_compute_shared_secret(struct kpp_request *req,
+static inline void crypto_stat_kpp_compute_shared_secret(struct crypto_alg *alg,
 							 int ret)
 {
 #ifdef CONFIG_CRYPTO_STATS
-	struct crypto_kpp *tfm = crypto_kpp_reqtfm(req);
-
 	if (ret)
-		atomic64_inc(&tfm->base.__crt_alg->kpp_err_cnt);
+		atomic64_inc(&alg->kpp_err_cnt);
 	else
-		atomic64_inc(&tfm->base.__crt_alg->compute_shared_secret_cnt);
+		atomic64_inc(&alg->compute_shared_secret_cnt);
+	crypto_alg_put(alg);
 #endif
 }
 
@@ -323,10 +322,14 @@ static inline int crypto_kpp_set_secret(struct crypto_kpp *tfm,
 					const void *buffer, unsigned int len)
 {
 	struct kpp_alg *alg = crypto_kpp_alg(tfm);
+	struct crypto_alg *calg = tfm->base.__crt_alg;
 	int ret;
 
+#ifdef CONFIG_CRYPTO_STATS
+	crypto_alg_get(calg);
+#endif
 	ret = alg->set_secret(tfm, buffer, len);
-	crypto_stat_kpp_set_secret(tfm, ret);
+	crypto_stat_kpp_set_secret(calg, ret);
 	return ret;
 }
 
@@ -347,10 +350,14 @@ static inline int crypto_kpp_generate_public_key(struct kpp_request *req)
 {
 	struct crypto_kpp *tfm = crypto_kpp_reqtfm(req);
 	struct kpp_alg *alg = crypto_kpp_alg(tfm);
+	struct crypto_alg *calg = tfm->base.__crt_alg;
 	int ret;
 
+#ifdef CONFIG_CRYPTO_STATS
+	crypto_alg_get(calg);
+#endif
 	ret = alg->generate_public_key(req);
-	crypto_stat_kpp_generate_public_key(req, ret);
+	crypto_stat_kpp_generate_public_key(calg, ret);
 	return ret;
 }
 
@@ -368,10 +375,14 @@ static inline int crypto_kpp_compute_shared_secret(struct kpp_request *req)
 {
 	struct crypto_kpp *tfm = crypto_kpp_reqtfm(req);
 	struct kpp_alg *alg = crypto_kpp_alg(tfm);
+	struct crypto_alg *calg = tfm->base.__crt_alg;
 	int ret;
 
+#ifdef CONFIG_CRYPTO_STATS
+	crypto_alg_get(calg);
+#endif
 	ret = alg->compute_shared_secret(req);
-	crypto_stat_kpp_compute_shared_secret(req, ret);
+	crypto_stat_kpp_compute_shared_secret(calg, ret);
 	return ret;
 }
 
diff --git a/include/crypto/rng.h b/include/crypto/rng.h
index bdcaac34e9d7..113ba2ef3b23 100644
--- a/include/crypto/rng.h
+++ b/include/crypto/rng.h
@@ -122,26 +122,28 @@ static inline void crypto_free_rng(struct crypto_rng *tfm)
 	crypto_destroy_tfm(tfm, crypto_rng_tfm(tfm));
 }
 
-static inline void crypto_stat_rng_seed(struct crypto_rng *tfm, int ret)
+static inline void crypto_stat_rng_seed(struct crypto_alg *alg, int ret)
 {
 #ifdef CONFIG_CRYPTO_STATS
 	if (ret && ret != -EINPROGRESS && ret != -EBUSY)
-		atomic64_inc(&tfm->base.__crt_alg->rng_err_cnt);
+		atomic64_inc(&alg->rng_err_cnt);
 	else
-		atomic64_inc(&tfm->base.__crt_alg->seed_cnt);
+		atomic64_inc(&alg->seed_cnt);
+	crypto_alg_put(alg);
 #endif
 }
 
-static inline void crypto_stat_rng_generate(struct crypto_rng *tfm,
+static inline void crypto_stat_rng_generate(struct crypto_alg *alg,
 					    unsigned int dlen, int ret)
 {
 #ifdef CONFIG_CRYPTO_STATS
 	if (ret && ret != -EINPROGRESS && ret != -EBUSY) {
-		atomic64_inc(&tfm->base.__crt_alg->rng_err_cnt);
+		atomic64_inc(&alg->rng_err_cnt);
 	} else {
-		atomic64_inc(&tfm->base.__crt_alg->generate_cnt);
-		atomic64_add(dlen, &tfm->base.__crt_alg->generate_tlen);
+		atomic64_inc(&alg->generate_cnt);
+		atomic64_add(dlen, &alg->generate_tlen);
 	}
+	crypto_alg_put(alg);
 #endif
 }
 
@@ -163,10 +165,14 @@ static inline int crypto_rng_generate(struct crypto_rng *tfm,
 				      const u8 *src, unsigned int slen,
 				      u8 *dst, unsigned int dlen)
 {
+	struct crypto_alg *alg = tfm->base.__crt_alg;
 	int ret;
 
+#ifdef CONFIG_CRYPTO_STATS
+	crypto_alg_get(alg);
+#endif
 	ret = crypto_rng_alg(tfm)->generate(tfm, src, slen, dst, dlen);
-	crypto_stat_rng_generate(tfm, dlen, ret);
+	crypto_stat_rng_generate(alg, dlen, ret);
 	return ret;
 }
 
diff --git a/include/crypto/skcipher.h b/include/crypto/skcipher.h
index dff54731ddf4..cec9ef17914e 100644
--- a/include/crypto/skcipher.h
+++ b/include/crypto/skcipher.h
@@ -486,7 +486,7 @@ static inline struct crypto_sync_skcipher *crypto_sync_skcipher_reqtfm(
 	return container_of(tfm, struct crypto_sync_skcipher, base);
 }
 
-static inline void crypto_stat_skcipher_encrypt(struct skcipher_request *req,
+static inline void crypto_stat_skcipher_encrypt(unsigned int cryptlen,
 						int ret, struct crypto_alg *alg)
 {
 #ifdef CONFIG_CRYPTO_STATS
@@ -494,12 +494,13 @@ static inline void crypto_stat_skcipher_encrypt(struct skcipher_request *req,
 		atomic64_inc(&alg->cipher_err_cnt);
 	} else {
 		atomic64_inc(&alg->encrypt_cnt);
-		atomic64_add(req->cryptlen, &alg->encrypt_tlen);
+		atomic64_add(cryptlen, &alg->encrypt_tlen);
 	}
+	crypto_alg_put(alg);
 #endif
 }
 
-static inline void crypto_stat_skcipher_decrypt(struct skcipher_request *req,
+static inline void crypto_stat_skcipher_decrypt(unsigned int cryptlen,
 						int ret, struct crypto_alg *alg)
 {
 #ifdef CONFIG_CRYPTO_STATS
@@ -507,8 +508,9 @@ static inline void crypto_stat_skcipher_decrypt(struct skcipher_request *req,
 		atomic64_inc(&alg->cipher_err_cnt);
 	} else {
 		atomic64_inc(&alg->decrypt_cnt);
-		atomic64_add(req->cryptlen, &alg->decrypt_tlen);
+		atomic64_add(cryptlen, &alg->decrypt_tlen);
 	}
+	crypto_alg_put(alg);
 #endif
 }
 
@@ -526,13 +528,18 @@ static inline void crypto_stat_skcipher_decrypt(struct skcipher_request *req,
 static inline int crypto_skcipher_encrypt(struct skcipher_request *req)
 {
 	struct crypto_skcipher *tfm = crypto_skcipher_reqtfm(req);
+	struct crypto_alg *alg = tfm->base.__crt_alg;
+	unsigned int cryptlen = req->cryptlen;
 	int ret;
 
+#ifdef CONFIG_CRYPTO_STATS
+	crypto_alg_get(alg);
+#endif
 	if (crypto_skcipher_get_flags(tfm) & CRYPTO_TFM_NEED_KEY)
 		ret = -ENOKEY;
 	else
 		ret = tfm->encrypt(req);
-	crypto_stat_skcipher_encrypt(req, ret, tfm->base.__crt_alg);
+	crypto_stat_skcipher_encrypt(cryptlen, ret, alg);
 	return ret;
 }
 
@@ -550,13 +557,18 @@ static inline int crypto_skcipher_encrypt(struct skcipher_request *req)
 static inline int crypto_skcipher_decrypt(struct skcipher_request *req)
 {
 	struct crypto_skcipher *tfm = crypto_skcipher_reqtfm(req);
+	struct crypto_alg *alg = tfm->base.__crt_alg;
+	unsigned int cryptlen = req->cryptlen;
 	int ret;
 
+#ifdef CONFIG_CRYPTO_STATS
+	crypto_alg_get(alg);
+#endif
 	if (crypto_skcipher_get_flags(tfm) & CRYPTO_TFM_NEED_KEY)
 		ret = -ENOKEY;
 	else
 		ret = tfm->decrypt(req);
-	crypto_stat_skcipher_decrypt(req, ret, tfm->base.__crt_alg);
+	crypto_stat_skcipher_decrypt(cryptlen, ret, alg);
 	return ret;
 }
 
diff --git a/include/linux/crypto.h b/include/linux/crypto.h
index c07f7cab5cf7..e67d346157c7 100644
--- a/include/linux/crypto.h
+++ b/include/linux/crypto.h
@@ -987,35 +987,31 @@ static inline struct crypto_ablkcipher *crypto_ablkcipher_reqtfm(
 	return __crypto_ablkcipher_cast(req->base.tfm);
 }
 
-static inline void crypto_stat_ablkcipher_encrypt(struct ablkcipher_request *req,
-						  int ret)
+static inline void crypto_stat_ablkcipher_encrypt(unsigned int nbytes, int ret,
+						  struct crypto_alg *alg)
 {
 #ifdef CONFIG_CRYPTO_STATS
-	struct ablkcipher_tfm *crt =
-		crypto_ablkcipher_crt(crypto_ablkcipher_reqtfm(req));
-
 	if (ret && ret != -EINPROGRESS && ret != -EBUSY) {
-		atomic64_inc(&crt->base->base.__crt_alg->cipher_err_cnt);
+		atomic64_inc(&alg->cipher_err_cnt);
 	} else {
-		atomic64_inc(&crt->base->base.__crt_alg->encrypt_cnt);
-		atomic64_add(req->nbytes, &crt->base->base.__crt_alg->encrypt_tlen);
+		atomic64_inc(&alg->encrypt_cnt);
+		atomic64_add(nbytes, &alg->encrypt_tlen);
 	}
+	crypto_alg_put(alg);
 #endif
 }
 
-static inline void crypto_stat_ablkcipher_decrypt(struct ablkcipher_request *req,
-						  int ret)
+static inline void crypto_stat_ablkcipher_decrypt(unsigned int nbytes, int ret,
+						  struct crypto_alg *alg)
 {
 #ifdef CONFIG_CRYPTO_STATS
-	struct ablkcipher_tfm *crt =
-		crypto_ablkcipher_crt(crypto_ablkcipher_reqtfm(req));
-
 	if (ret && ret != -EINPROGRESS && ret != -EBUSY) {
-		atomic64_inc(&crt->base->base.__crt_alg->cipher_err_cnt);
+		atomic64_inc(&alg->cipher_err_cnt);
 	} else {
-		atomic64_inc(&crt->base->base.__crt_alg->decrypt_cnt);
-		atomic64_add(req->nbytes, &crt->base->base.__crt_alg->decrypt_tlen);
+		atomic64_inc(&alg->decrypt_cnt);
+		atomic64_add(nbytes, &alg->decrypt_tlen);
 	}
+	crypto_alg_put(alg);
 #endif
 }
 
@@ -1034,10 +1030,15 @@ static inline int crypto_ablkcipher_encrypt(struct ablkcipher_request *req)
 {
 	struct ablkcipher_tfm *crt =
 		crypto_ablkcipher_crt(crypto_ablkcipher_reqtfm(req));
+	struct crypto_alg *alg = crt->base->base.__crt_alg;
+	unsigned int nbytes = req->nbytes;
 	int ret;
 
+#ifdef CONFIG_CRYPTO_STATS
+	crypto_alg_get(alg);
+#endif
 	ret = crt->encrypt(req);
-	crypto_stat_ablkcipher_encrypt(req, ret);
+	crypto_stat_ablkcipher_encrypt(nbytes, ret, alg);
 	return ret;
 }
 
@@ -1056,10 +1057,15 @@ static inline int crypto_ablkcipher_decrypt(struct ablkcipher_request *req)
 {
 	struct ablkcipher_tfm *crt =
 		crypto_ablkcipher_crt(crypto_ablkcipher_reqtfm(req));
+	struct crypto_alg *alg = crt->base->base.__crt_alg;
+	unsigned int nbytes = req->nbytes;
 	int ret;
 
+#ifdef CONFIG_CRYPTO_STATS
+	crypto_alg_get(alg);
+#endif
 	ret = crt->decrypt(req);
-	crypto_stat_ablkcipher_decrypt(req, ret);
+	crypto_stat_ablkcipher_decrypt(nbytes, ret, alg);
 	return ret;
 }
 
-- 
2.18.1

