Return-Path: <SRS0=i6x1=N7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 542E3C4161D
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 12:34:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4D584214F1
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 12:33:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="kYAbbU18"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4D584214F1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729665AbeKTXCX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Nov 2018 18:02:23 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:52952 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729581AbeKTXCX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Nov 2018 18:02:23 -0500
Received: by mail-wm1-f68.google.com with SMTP id r11-v6so1957575wmb.2
        for <linux-kernel@vger.kernel.org>; Tue, 20 Nov 2018 04:33:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=dWXP8bfAb0arTsDj10OlXMvdF+qUKCfdBd1p6fv//0k=;
        b=kYAbbU18/FB5bNfsg+S1RPMVDbeiYvyZq0mRX6L4E31IG5O53rocmcxXMoGHSBgnR4
         3QSkTzLwvAyg/4gMYgGfHjHmtFiF2jK1dJG5DXkAvqnG9bMUcIGk9QYXNw+evCa4QbKx
         j5RRRN7OUdLGzOnswY0DKXV6X+aAUts3rc/QXhABhymeIBexKv807sUdENlXja/5AKoB
         GoyspLZQHTDkT8fwl5r2o7pH7hJ0iW/Pz8ImgaMRTdrVAAHmlyKhrC5G/k2LvqyuEmWB
         3iBcDUzzJxhV+FutitAITyUGeoAQqlnegyi399MsHjElY7BfK6Y8Uja1aRtZVO0Ybw+3
         6Hkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=dWXP8bfAb0arTsDj10OlXMvdF+qUKCfdBd1p6fv//0k=;
        b=GfMJX2orGbeJKQIV+Pji4rKAnxZI5oqvhhh3KorLXKdE2Bwbj70IJd1LPrP4z8Tu58
         7RmBBWAhnSMTxgBJaF0edbid0lP2KdchEk0i9eZg49VNmwOZf5Qt/vRr9r5xRxTYlUy/
         970j19vhQ7BdvcF62paYXkM+/7TwW45ny3bEpGRmwRvhAF/9dnTHTRjCIhqaRKWQvBcH
         UuOb/a6jHiA7171TRuKKYVcyaXVz+swQ+xLlvVo3StsXkJmkRUgTGdA5/Yb7HFw+z8w4
         0u9z27qprScu1CcDdOu23AituvOm7l/d+q8ecOvHIdP8qLc3HcM1x2ZSbByr9QER/MTr
         qj8w==
X-Gm-Message-State: AGRZ1gIk9HhPWih00anf+W5wqYpsAi0NZ0OPefWFaGVc5RjgAguCw2GJ
        c3ufQb2tlbDDFFuL8iyqkyQ/Zg==
X-Google-Smtp-Source: AFSGD/X7PdV6sUmDPlLkjvEbpSCZ09/O9vMc/DSOslweuVAGf+8Us+kxH2yIAZYpcSRwRerjTRj8FQ==
X-Received: by 2002:a1c:9183:: with SMTP id t125mr1974374wmd.79.1542717207661;
        Tue, 20 Nov 2018 04:33:27 -0800 (PST)
Received: from localhost.localdomain ([51.15.160.169])
        by smtp.googlemail.com with ESMTPSA id x81sm2766951wmg.17.2018.11.20.04.33.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 20 Nov 2018 04:33:26 -0800 (PST)
From:   Corentin Labbe <clabbe@baylibre.com>
To:     davem@davemloft.net, ebiggers@kernel.org,
        herbert@gondor.apana.org.au, nhorman@tuxdriver.com
Cc:     linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        Corentin Labbe <clabbe@baylibre.com>
Subject: [PATCH v3 08/10] crypto: crypto_user_stat: remove intermediate variable
Date:   Tue, 20 Nov 2018 12:32:24 +0000
Message-Id: <1542717146-34917-9-git-send-email-clabbe@baylibre.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1542717146-34917-1-git-send-email-clabbe@baylibre.com>
References: <1542717146-34917-1-git-send-email-clabbe@baylibre.com>
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

