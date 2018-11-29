Return-Path: <SRS0=8q1S=OI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.2 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82FDDC43441
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 14:43:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3F21220673
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 14:43:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="Pz6MuSP1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3F21220673
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388189AbeK3BtT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Nov 2018 20:49:19 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:34874 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387727AbeK3BsS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Nov 2018 20:48:18 -0500
Received: by mail-wr1-f65.google.com with SMTP id 96so2177266wrb.2
        for <linux-kernel@vger.kernel.org>; Thu, 29 Nov 2018 06:42:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=dWXP8bfAb0arTsDj10OlXMvdF+qUKCfdBd1p6fv//0k=;
        b=Pz6MuSP1hUmFNPtk0073tnzS/eh9AiHtUrAyW9MEyCiDvcaJmB5bDbt1h6G486+ci6
         1e61qQzPVvv0cW4NpYuR7KjPaR+yl4/fCk/17GOoACbBVV84uRCYzNXtWuJ6syMYpV6b
         tmodxmulZlIAWvJK59kWPzAbkM+QyFSDIAPU4xb6Fz1qbDXHQjyssi5v783BN6SXpeBm
         MLWR3nZNd5TLxnsZGsM8umQBXB6BUdXbVxzK/QcDhb4uLM/XEhzo5OllNL0NiMBmpgJw
         j/4NIT6YGzM6sOzxxpu+yxJhmUpTVXb766OWIAzwjGDPqXjDJAutl7cST1xy5T2DxpN8
         9SUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=dWXP8bfAb0arTsDj10OlXMvdF+qUKCfdBd1p6fv//0k=;
        b=VLTPWqXSMwZsCxVm0h0BsiJt7s+X8qE1K/mcCYA1V7h8sFEX+6FiK5S4B0n/VrHf+S
         9l/9qZz+jI4GXB1tRXmjvTVPHIZ3sEXwZiV91V6JOiDkJn9WR6Zg4cMazGIvHe69bQUj
         xZlrLyv5hbYNVAoGevyChYYhfMsgoBqyz0Fb5zqyolNMM7wef+I0OBOhlEOX0kh35gpr
         3hczngObxUBkWinBGu5n0Ugmd0Ni/dUqFPQtQbd9bMBZ43WK2xyaPEPg7f2nWmMuNTeg
         OId03ylHfUfLWsB3hVKiFKqUm/2RnqvzxGIOIc0lJe4qfO0MOO5d6ztnpQtOJbFpy2+Q
         pChQ==
X-Gm-Message-State: AA+aEWa7uFfailK60+UqfqOb6IXFKgGhCwIQQJi/BXfxd7HdxqWlF4lm
        ISAcW9JLXZtUs5yh9/+xRyS5mA==
X-Google-Smtp-Source: AFSGD/Xx42nvWUsHVJ+kXp5wiCvhZ1weOIrwVgtjPDxMeWPrJTIOqJQTStBz4BJLVsQ/zpXw/2dqaA==
X-Received: by 2002:a5d:4e4a:: with SMTP id r10mr1799084wrt.54.1543502562067;
        Thu, 29 Nov 2018 06:42:42 -0800 (PST)
Received: from localhost.localdomain ([51.15.160.169])
        by smtp.googlemail.com with ESMTPSA id t131sm875406wmt.1.2018.11.29.06.42.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 29 Nov 2018 06:42:41 -0800 (PST)
From:   Corentin Labbe <clabbe@baylibre.com>
To:     davem@davemloft.net, ebiggers@kernel.org,
        herbert@gondor.apana.org.au, nhorman@tuxdriver.com
Cc:     linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        Corentin Labbe <clabbe@baylibre.com>
Subject: [PATCH v5 08/11] crypto: crypto_user_stat: remove intermediate variable
Date:   Thu, 29 Nov 2018 14:42:23 +0000
Message-Id: <1543502546-23870-9-git-send-email-clabbe@baylibre.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1543502546-23870-1-git-send-email-clabbe@baylibre.com>
References: <1543502546-23870-1-git-send-email-clabbe@baylibre.com>
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

