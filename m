Return-Path: <SRS0=aB5v=OC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95ED8C43441
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Nov 2018 12:02:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4A45520672
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Nov 2018 12:02:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="loSDhPsL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4A45520672
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2504037AbeKWWqp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 23 Nov 2018 17:46:45 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:35670 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2503997AbeKWWqo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Nov 2018 17:46:44 -0500
Received: by mail-wm1-f65.google.com with SMTP id c126so11734222wmh.0
        for <linux-kernel@vger.kernel.org>; Fri, 23 Nov 2018 04:02:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=dWXP8bfAb0arTsDj10OlXMvdF+qUKCfdBd1p6fv//0k=;
        b=loSDhPsLOmIPoz39gZqMSM2ZGKNFIcFBJACL+CY22halmm/sAwTiXcvBAbi6pH2rkg
         GbBBn0SCNCPDUgk47SRnEbGAAHyrJuz2BnAI6ymicgxZJlBnrC/a+fe0n6GaVIalRQ16
         Pb4/TLetM/isyMU2yUcM7LGiSwGRUETFbTqoByjw6Bg8C3sTaRx7978o39Z6WcMb2Xxp
         QGV7BjzElZEIyy6/mPN04solNzp/NVb3HKWj11SUbuHbMzzR4XdH0uFL+ZQzlHEelSV8
         7VEwel90SMBBL6MpY+7U4+oJn4+6dLjU8ZGaI3nOJhZLuopKqvnSutXZyeAvXJVVZFv9
         32Qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=dWXP8bfAb0arTsDj10OlXMvdF+qUKCfdBd1p6fv//0k=;
        b=OOTmWkpsl8OxQyGET0Wo2chopnAos64j22jkdqFtUEzNrf2AaJ+Ogs/bIZ1ehWvu+8
         DSYjm9Q/a80/5KZdqTCqq/77S3HQw8Jjz6LUXgaQ84dBk32yoXlEe1E1PKQMTzye7p6O
         UCwKwFcu6dfUF0oPaTwdVmB4+4YhOQr6qSlWXbqAm0iIY4iS3z1ra8QR0t0kfwP/fF6v
         wg347ZSKlsnW72yS/0NSCxPxGGrMSJi4GdTvrENjIdbuKqo5Q1l1We1pfVUvqpry0Uez
         X7MhSdbJx4EzZUztlO0HTmlEQFTAepCeyxo6GmpRS+Rn4zEQl5yIxirWClEtEnXO94D8
         ey9Q==
X-Gm-Message-State: AA+aEWZn2vlWV7bvao0VDc9wmRtuy8KPHS4hn3C+6Kr42mUWdYLytiZp
        2XHInag3l58H1jKRjlBRLYfA6Q==
X-Google-Smtp-Source: AFSGD/V2qg62AzUZK7lxLl/uTW3dXjwKW9yR8+GimyTP0jGD6l6aZIOjUVGTyDBs5FsD+NIZQ8o7vg==
X-Received: by 2002:a1c:7209:: with SMTP id n9mr13022349wmc.5.1542974565191;
        Fri, 23 Nov 2018 04:02:45 -0800 (PST)
Received: from localhost.localdomain ([51.15.160.169])
        by smtp.googlemail.com with ESMTPSA id a18sm25164379wrp.13.2018.11.23.04.02.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 23 Nov 2018 04:02:43 -0800 (PST)
From:   Corentin Labbe <clabbe@baylibre.com>
To:     davem@davemloft.net, ebiggers@kernel.org,
        herbert@gondor.apana.org.au, nhorman@tuxdriver.com
Cc:     linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        Corentin Labbe <clabbe@baylibre.com>
Subject: [PATCH v4 08/11] crypto: crypto_user_stat: remove intermediate variable
Date:   Fri, 23 Nov 2018 12:02:18 +0000
Message-Id: <1542974541-23024-9-git-send-email-clabbe@baylibre.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1542974541-23024-1-git-send-email-clabbe@baylibre.com>
References: <1542974541-23024-1-git-send-email-clabbe@baylibre.com>
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

