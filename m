Return-Path: <SRS0=tadO=N6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74070C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 19:54:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 29B7920831
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 19:54:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="WgzFCN0x"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 29B7920831
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730639AbeKTGS5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Nov 2018 01:18:57 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:34986 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730580AbeKTGS5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Nov 2018 01:18:57 -0500
Received: by mail-wr1-f68.google.com with SMTP id 96so16476204wrb.2
        for <linux-kernel@vger.kernel.org>; Mon, 19 Nov 2018 11:53:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=dWXP8bfAb0arTsDj10OlXMvdF+qUKCfdBd1p6fv//0k=;
        b=WgzFCN0xFqeWAcNb8VOHdhvfIgcGokBsFM4XAduUZaK/RqpikvCzUTsT4ndkRYVwMM
         rfxJpuCLeXRTtvk9Sw3cQTPv8IrCezXtX5c5QaVCkYWtOzShA29H6NaZF/JHOzkIXctC
         pUK0cNe2XtfG7A4IPBfklXq4vGVqqaIZhdDn5J5IQyt7GeyuSObBRbjT8mV2ZtrlJNEn
         Qhrr0inyDDYzZON76+M2d+lSfBIncC4UrOZrUygQhB1fCxwfz91JGXDLD6jkExqo0xuV
         s5jVgxXTZlvH2MS3QUwcjTD0/ZTaoYcptPf2Fd7dH3v3S6BtRdIsuTTMXrKwirRrxMmw
         rLew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=dWXP8bfAb0arTsDj10OlXMvdF+qUKCfdBd1p6fv//0k=;
        b=bJjs3ScX3yq5Vb2fxyCrFKjP+xn0EhrArEP4q0wCyfp7DeXX97B7Foj8Mr0j4Qjg+1
         nHm9cMninVUf3+Ye3jPje38Eeu4bkN7xC0Sw8YDMgOIKygNsqpuN2nP24Ttu5codGmOm
         4riWVnVVpoJOiAJO2NAvsJjkzL5nXiJdrgnAIyJN4tMj+I8Fnx2kim2i4ra+Nv78YrHZ
         ON86MluOuSuIY449xxvWzwJD3nZILlKAbmjnATN052UXShxbBO2KP41N2eYr48DVB+c0
         nAi8vUHhpMHlCD38/XZCYEwo4gmHZAb97IkW+VuM5YkgWG9yKyJP13hXJUClj+rHU3nB
         DRCw==
X-Gm-Message-State: AA+aEWbt1jSydjXwlaxRy/OFSNpJTt44wyL9UDSdOOQCGl7KA6wiRFOD
        z55wpB0j/WZWzt/vaefmuByDFQ==
X-Google-Smtp-Source: AFSGD/UcW/tNIIlfz2ZurNcSbGoikb2FnTxI3YEM8uNiqSoO5dgsGryH7oHlEgOKS1LNkmcF3GOkLw==
X-Received: by 2002:a5d:45d0:: with SMTP id b16mr11207899wrs.86.1542657225074;
        Mon, 19 Nov 2018 11:53:45 -0800 (PST)
Received: from localhost.localdomain ([51.15.160.169])
        by smtp.googlemail.com with ESMTPSA id i16sm22954132wmd.28.2018.11.19.11.53.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 19 Nov 2018 11:53:44 -0800 (PST)
From:   Corentin Labbe <clabbe@baylibre.com>
To:     davem@davemloft.net, ebiggers@kernel.org,
        herbert@gondor.apana.org.au, nhorman@tuxdriver.com
Cc:     linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        Corentin Labbe <clabbe@baylibre.com>
Subject: [PATCH v2 09/11] crypto: crypto_user_stat: remove intermediate variable
Date:   Mon, 19 Nov 2018 19:53:28 +0000
Message-Id: <1542657210-37739-10-git-send-email-clabbe@baylibre.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1542657210-37739-1-git-send-email-clabbe@baylibre.com>
References: <1542657210-37739-1-git-send-email-clabbe@baylibre.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The use of the v64 intermediate variable is useless, and removing it
bring to much readable code.

Signed-off-by: Corentin Labbe <clabbe@baylibre.com>
---
 crypto/crypto_user_stat.c | 132 ++++++++++++--------------------------
 1 file changed, 41 insertions(+), 91 deletions(-)

diff --git a/crypto/crypto_user_stat.c b/crypto/crypto_user_stat.c
index 838123758423..7b668c659122 100644
--- a/crypto/crypto_user_stat.c
+++ b/crypto/crypto_user_stat.c
@@ -34,22 +34,16 @@ struct crypto_dump_info {
 static int crypto_report_aead(struct sk_buff *skb, struct crypto_alg *alg)
 {
 	struct crypto_stat_aead raead;
-	u64 v64;
 
 	memset(&raead, 0, sizeof(raead));
 
 	strscpy(raead.type, "aead", sizeof(raead.type));
 
-	v64 = atomic64_read(&alg->encrypt_cnt);
-	raead.stat_encrypt_cnt = v64;
-	v64 = atomic64_read(&alg->encrypt_tlen);
-	raead.stat_encrypt_tlen = v64;
-	v64 = atomic64_read(&alg->decrypt_cnt);
-	raead.stat_decrypt_cnt = v64;
-	v64 = atomic64_read(&alg->decrypt_tlen);
-	raead.stat_decrypt_tlen = v64;
-	v64 = atomic64_read(&alg->aead_err_cnt);
-	raead.stat_aead_err_cnt = v64;
+	raead.stat_encrypt_cnt = atomic64_read(&alg->encrypt_cnt);
+	raead.stat_encrypt_tlen = atomic64_read(&alg->encrypt_tlen);
+	raead.stat_decrypt_cnt = atomic64_read(&alg->decrypt_cnt);
+	raead.stat_decrypt_tlen = atomic64_read(&alg->decrypt_tlen);
+	raead.stat_aead_err_cnt = atomic64_read(&alg->aead_err_cnt);
 
 	return nla_put(skb, CRYPTOCFGA_STAT_AEAD, sizeof(raead), &raead);
 }
@@ -57,22 +51,16 @@ static int crypto_report_aead(struct sk_buff *skb, struct crypto_alg *alg)
 static int crypto_report_cipher(struct sk_buff *skb, struct crypto_alg *alg)
 {
 	struct crypto_stat_cipher rcipher;
-	u64 v64;
 
 	memset(&rcipher, 0, sizeof(rcipher));
 
 	strscpy(rcipher.type, "cipher", sizeof(rcipher.type));
 
-	v64 = atomic64_read(&alg->encrypt_cnt);
-	rcipher.stat_encrypt_cnt = v64;
-	v64 = atomic64_read(&alg->encrypt_tlen);
-	rcipher.stat_encrypt_tlen = v64;
-	v64 = atomic64_read(&alg->decrypt_cnt);
-	rcipher.stat_decrypt_cnt = v64;
-	v64 = atomic64_read(&alg->decrypt_tlen);
-	rcipher.stat_decrypt_tlen = v64;
-	v64 = atomic64_read(&alg->cipher_err_cnt);
-	rcipher.stat_cipher_err_cnt = v64;
+	rcipher.stat_encrypt_cnt = atomic64_read(&alg->encrypt_cnt);
+	rcipher.stat_encrypt_tlen = atomic64_read(&alg->encrypt_tlen);
+	rcipher.stat_decrypt_cnt =  atomic64_read(&alg->decrypt_cnt);
+	rcipher.stat_decrypt_tlen = atomic64_read(&alg->decrypt_tlen);
+	rcipher.stat_cipher_err_cnt =  atomic64_read(&alg->cipher_err_cnt);
 
 	return nla_put(skb, CRYPTOCFGA_STAT_CIPHER, sizeof(rcipher), &rcipher);
 }
@@ -80,21 +68,15 @@ static int crypto_report_cipher(struct sk_buff *skb, struct crypto_alg *alg)
 static int crypto_report_comp(struct sk_buff *skb, struct crypto_alg *alg)
 {
 	struct crypto_stat_compress rcomp;
-	u64 v64;
 
 	memset(&rcomp, 0, sizeof(rcomp));
 
 	strscpy(rcomp.type, "compression", sizeof(rcomp.type));
-	v64 = atomic64_read(&alg->compress_cnt);
-	rcomp.stat_compress_cnt = v64;
-	v64 = atomic64_read(&alg->compress_tlen);
-	rcomp.stat_compress_tlen = v64;
-	v64 = atomic64_read(&alg->decompress_cnt);
-	rcomp.stat_decompress_cnt = v64;
-	v64 = atomic64_read(&alg->decompress_tlen);
-	rcomp.stat_decompress_tlen = v64;
-	v64 = atomic64_read(&alg->compress_err_cnt);
-	rcomp.stat_compress_err_cnt = v64;
+	rcomp.stat_compress_cnt = atomic64_read(&alg->compress_cnt);
+	rcomp.stat_compress_tlen = atomic64_read(&alg->compress_tlen);
+	rcomp.stat_decompress_cnt = atomic64_read(&alg->decompress_cnt);
+	rcomp.stat_decompress_tlen = atomic64_read(&alg->decompress_tlen);
+	rcomp.stat_compress_err_cnt = atomic64_read(&alg->compress_err_cnt);
 
 	return nla_put(skb, CRYPTOCFGA_STAT_COMPRESS, sizeof(rcomp), &rcomp);
 }
@@ -102,21 +84,15 @@ static int crypto_report_comp(struct sk_buff *skb, struct crypto_alg *alg)
 static int crypto_report_acomp(struct sk_buff *skb, struct crypto_alg *alg)
 {
 	struct crypto_stat_compress racomp;
-	u64 v64;
 
 	memset(&racomp, 0, sizeof(racomp));
 
 	strscpy(racomp.type, "acomp", sizeof(racomp.type));
-	v64 = atomic64_read(&alg->compress_cnt);
-	racomp.stat_compress_cnt = v64;
-	v64 = atomic64_read(&alg->compress_tlen);
-	racomp.stat_compress_tlen = v64;
-	v64 = atomic64_read(&alg->decompress_cnt);
-	racomp.stat_decompress_cnt = v64;
-	v64 = atomic64_read(&alg->decompress_tlen);
-	racomp.stat_decompress_tlen = v64;
-	v64 = atomic64_read(&alg->compress_err_cnt);
-	racomp.stat_compress_err_cnt = v64;
+	racomp.stat_compress_cnt = atomic64_read(&alg->compress_cnt);
+	racomp.stat_compress_tlen = atomic64_read(&alg->compress_tlen);
+	racomp.stat_decompress_cnt =  atomic64_read(&alg->decompress_cnt);
+	racomp.stat_decompress_tlen = atomic64_read(&alg->decompress_tlen);
+	racomp.stat_compress_err_cnt = atomic64_read(&alg->compress_err_cnt);
 
 	return nla_put(skb, CRYPTOCFGA_STAT_ACOMP, sizeof(racomp), &racomp);
 }
@@ -124,25 +100,17 @@ static int crypto_report_acomp(struct sk_buff *skb, struct crypto_alg *alg)
 static int crypto_report_akcipher(struct sk_buff *skb, struct crypto_alg *alg)
 {
 	struct crypto_stat_akcipher rakcipher;
-	u64 v64;
 
 	memset(&rakcipher, 0, sizeof(rakcipher));
 
 	strscpy(rakcipher.type, "akcipher", sizeof(rakcipher.type));
-	v64 = atomic64_read(&alg->encrypt_cnt);
-	rakcipher.stat_encrypt_cnt = v64;
-	v64 = atomic64_read(&alg->encrypt_tlen);
-	rakcipher.stat_encrypt_tlen = v64;
-	v64 = atomic64_read(&alg->decrypt_cnt);
-	rakcipher.stat_decrypt_cnt = v64;
-	v64 = atomic64_read(&alg->decrypt_tlen);
-	rakcipher.stat_decrypt_tlen = v64;
-	v64 = atomic64_read(&alg->sign_cnt);
-	rakcipher.stat_sign_cnt = v64;
-	v64 = atomic64_read(&alg->verify_cnt);
-	rakcipher.stat_verify_cnt = v64;
-	v64 = atomic64_read(&alg->akcipher_err_cnt);
-	rakcipher.stat_akcipher_err_cnt = v64;
+	rakcipher.stat_encrypt_cnt = atomic64_read(&alg->encrypt_cnt);
+	rakcipher.stat_encrypt_tlen = atomic64_read(&alg->encrypt_tlen);
+	rakcipher.stat_decrypt_cnt = atomic64_read(&alg->decrypt_cnt);
+	rakcipher.stat_decrypt_tlen = atomic64_read(&alg->decrypt_tlen);
+	rakcipher.stat_sign_cnt = atomic64_read(&alg->sign_cnt);
+	rakcipher.stat_verify_cnt = atomic64_read(&alg->verify_cnt);
+	rakcipher.stat_akcipher_err_cnt = atomic64_read(&alg->akcipher_err_cnt);
 
 	return nla_put(skb, CRYPTOCFGA_STAT_AKCIPHER,
 		       sizeof(rakcipher), &rakcipher);
@@ -151,20 +119,15 @@ static int crypto_report_akcipher(struct sk_buff *skb, struct crypto_alg *alg)
 static int crypto_report_kpp(struct sk_buff *skb, struct crypto_alg *alg)
 {
 	struct crypto_stat_kpp rkpp;
-	u64 v;
 
 	memset(&rkpp, 0, sizeof(rkpp));
 
 	strscpy(rkpp.type, "kpp", sizeof(rkpp.type));
 
-	v = atomic64_read(&alg->setsecret_cnt);
-	rkpp.stat_setsecret_cnt = v;
-	v = atomic64_read(&alg->generate_public_key_cnt);
-	rkpp.stat_generate_public_key_cnt = v;
-	v = atomic64_read(&alg->compute_shared_secret_cnt);
-	rkpp.stat_compute_shared_secret_cnt = v;
-	v = atomic64_read(&alg->kpp_err_cnt);
-	rkpp.stat_kpp_err_cnt = v;
+	rkpp.stat_setsecret_cnt = atomic64_read(&alg->setsecret_cnt);
+	rkpp.stat_generate_public_key_cnt = atomic64_read(&alg->generate_public_key_cnt);
+	rkpp.stat_compute_shared_secret_cnt = atomic64_read(&alg->compute_shared_secret_cnt);
+	rkpp.stat_kpp_err_cnt = atomic64_read(&alg->kpp_err_cnt);
 
 	return nla_put(skb, CRYPTOCFGA_STAT_KPP, sizeof(rkpp), &rkpp);
 }
@@ -172,18 +135,14 @@ static int crypto_report_kpp(struct sk_buff *skb, struct crypto_alg *alg)
 static int crypto_report_ahash(struct sk_buff *skb, struct crypto_alg *alg)
 {
 	struct crypto_stat_hash rhash;
-	u64 v64;
 
 	memset(&rhash, 0, sizeof(rhash));
 
 	strscpy(rhash.type, "ahash", sizeof(rhash.type));
 
-	v64 = atomic64_read(&alg->hash_cnt);
-	rhash.stat_hash_cnt = v64;
-	v64 = atomic64_read(&alg->hash_tlen);
-	rhash.stat_hash_tlen = v64;
-	v64 = atomic64_read(&alg->hash_err_cnt);
-	rhash.stat_hash_err_cnt = v64;
+	rhash.stat_hash_cnt = atomic64_read(&alg->hash_cnt);
+	rhash.stat_hash_tlen = atomic64_read(&alg->hash_tlen);
+	rhash.stat_hash_err_cnt = atomic64_read(&alg->hash_err_cnt);
 
 	return nla_put(skb, CRYPTOCFGA_STAT_HASH, sizeof(rhash), &rhash);
 }
@@ -191,18 +150,14 @@ static int crypto_report_ahash(struct sk_buff *skb, struct crypto_alg *alg)
 static int crypto_report_shash(struct sk_buff *skb, struct crypto_alg *alg)
 {
 	struct crypto_stat_hash rhash;
-	u64 v64;
 
 	memset(&rhash, 0, sizeof(rhash));
 
 	strscpy(rhash.type, "shash", sizeof(rhash.type));
 
-	v64 = atomic64_read(&alg->hash_cnt);
-	rhash.stat_hash_cnt = v64;
-	v64 = atomic64_read(&alg->hash_tlen);
-	rhash.stat_hash_tlen = v64;
-	v64 = atomic64_read(&alg->hash_err_cnt);
-	rhash.stat_hash_err_cnt = v64;
+	rhash.stat_hash_cnt =  atomic64_read(&alg->hash_cnt);
+	rhash.stat_hash_tlen = atomic64_read(&alg->hash_tlen);
+	rhash.stat_hash_err_cnt = atomic64_read(&alg->hash_err_cnt);
 
 	return nla_put(skb, CRYPTOCFGA_STAT_HASH, sizeof(rhash), &rhash);
 }
@@ -210,20 +165,15 @@ static int crypto_report_shash(struct sk_buff *skb, struct crypto_alg *alg)
 static int crypto_report_rng(struct sk_buff *skb, struct crypto_alg *alg)
 {
 	struct crypto_stat_rng rrng;
-	u64 v64;
 
 	memset(&rrng, 0, sizeof(rrng));
 
 	strscpy(rrng.type, "rng", sizeof(rrng.type));
 
-	v64 = atomic64_read(&alg->generate_cnt);
-	rrng.stat_generate_cnt = v64;
-	v64 = atomic64_read(&alg->generate_tlen);
-	rrng.stat_generate_tlen = v64;
-	v64 = atomic64_read(&alg->seed_cnt);
-	rrng.stat_seed_cnt = v64;
-	v64 = atomic64_read(&alg->rng_err_cnt);
-	rrng.stat_rng_err_cnt = v64;
+	rrng.stat_generate_cnt = atomic64_read(&alg->generate_cnt);
+	rrng.stat_generate_tlen = atomic64_read(&alg->generate_tlen);
+	rrng.stat_seed_cnt = atomic64_read(&alg->seed_cnt);
+	rrng.stat_rng_err_cnt = atomic64_read(&alg->rng_err_cnt);
 
 	return nla_put(skb, CRYPTOCFGA_STAT_RNG, sizeof(rrng), &rrng);
 }
-- 
2.18.1

