Return-Path: <SRS0=bKrn=NQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90095C46475
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 12:52:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 49A8920819
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 12:52:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="C2Xoc3Ge"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 49A8920819
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729928AbeKEWLh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 5 Nov 2018 17:11:37 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:35377 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729789AbeKEWLF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Nov 2018 17:11:05 -0500
Received: by mail-wr1-f66.google.com with SMTP id z16-v6so9413575wrv.2
        for <linux-kernel@vger.kernel.org>; Mon, 05 Nov 2018 04:51:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Cw2Jl2fS2a5+RXWXIpVniDIQW9kd4KlGM4FcO+GnwTI=;
        b=C2Xoc3Ge4EtncuqPhwlGg4pVYYSoQigdqymcdUenkp1tiysxXPeAlNof5suRyWUiKI
         bnM8BocwDAbfjhz9iw961BX3RTBMDjbpdU8bb9vcSgm4UgDxkmEG3OJNDdIEeJe7Wnv8
         cU14EN+r3Vver+eNDPv1cbelemXwT3mNfU4H+TX1yL1pP3sDMHX0bGAKB1+3l+/BQZLl
         H/pJ1lBUENRYTc9nxLw83nTHZ6VjM4Ymowq7QmNafEe/0p9/7ocXjyJJw91QiTCxFMAZ
         RFDB2u5gB7vyaLzLtUkwX+3pCP+c/rbyAJ/i/JhwGj6FxatV5DlC3RhfyDgrOK1z6YLg
         /sPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Cw2Jl2fS2a5+RXWXIpVniDIQW9kd4KlGM4FcO+GnwTI=;
        b=s/MTGqsPVtCi27mr/V6Yg6ZMZ9NNCoGMkAyuZygySeIm6tBD8ZwngnQK1EzWznAAE/
         YMSUG20Lu8GLE8Nk+Qs2LV60MUG0sVi5T6TOStLDm4haNk5cBLZp6UKECQZ8UP1dSeeB
         tDwSmH2+vgJY4bauRemqk9ivERF0st/7d6MhfCn0QM0dRwEfgR80zQgWzvLhV4szZyMi
         HwnmhTARW7gLwqupCH/WEYNolUOxxr6dLNs9C8+V71agWxmKo0IYN+Q1XCzrj1dW5ay6
         lgq9I59Vvp+SJzM/svnm0asfujKXsX22Gv7lBRQkI9xgOhxnLdAy4zRZxojbdCe+OIvv
         UnVA==
X-Gm-Message-State: AGRZ1gIpCEL2kRayNeK+mdOdfKO4Ruh26OpDbeF9Y37iwOq0JhlDXPgR
        11l2fPd4emx0JDxBj0GStiM8XQ==
X-Google-Smtp-Source: AJdET5eAnyyEHjYSsx7R4sKGhOcNwQlB3gZu3gGDTlHDDM88rhYzqpsxEkdS2RQqoIUfvWAkQDXo9g==
X-Received: by 2002:a5d:424a:: with SMTP id s10-v6mr18452709wrr.260.1541422287926;
        Mon, 05 Nov 2018 04:51:27 -0800 (PST)
Received: from localhost.localdomain ([51.15.160.169])
        by smtp.googlemail.com with ESMTPSA id l4-v6sm56114579wrb.92.2018.11.05.04.51.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 05 Nov 2018 04:51:27 -0800 (PST)
From:   Corentin Labbe <clabbe@baylibre.com>
To:     davem@davemloft.net, ebiggers@kernel.org,
        herbert@gondor.apana.org.au
Cc:     linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        Corentin Labbe <clabbe@baylibre.com>
Subject: [PATCH 3/5] crypto: crypto_user_stat: split user space crypto stat structures
Date:   Mon,  5 Nov 2018 12:51:12 +0000
Message-Id: <1541422274-40060-4-git-send-email-clabbe@baylibre.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1541422274-40060-1-git-send-email-clabbe@baylibre.com>
References: <1541422274-40060-1-git-send-email-clabbe@baylibre.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It is cleaner to have each stat in their own structures.

Signed-off-by: Corentin Labbe <clabbe@baylibre.com>
---
 crypto/crypto_user_stat.c       |  20 +++----
 include/uapi/linux/cryptouser.h | 101 ++++++++++++++++++++------------
 2 files changed, 73 insertions(+), 48 deletions(-)

diff --git a/crypto/crypto_user_stat.c b/crypto/crypto_user_stat.c
index 352569f378a0..3c14be2f7a1b 100644
--- a/crypto/crypto_user_stat.c
+++ b/crypto/crypto_user_stat.c
@@ -33,7 +33,7 @@ struct crypto_dump_info {
 
 static int crypto_report_aead(struct sk_buff *skb, struct crypto_alg *alg)
 {
-	struct crypto_stat raead;
+	struct crypto_stat_aead raead;
 	u64 v64;
 
 	memset(&raead, 0, sizeof(raead));
@@ -56,7 +56,7 @@ static int crypto_report_aead(struct sk_buff *skb, struct crypto_alg *alg)
 
 static int crypto_report_cipher(struct sk_buff *skb, struct crypto_alg *alg)
 {
-	struct crypto_stat rcipher;
+	struct crypto_stat_cipher rcipher;
 	u64 v64;
 
 	memset(&rcipher, 0, sizeof(rcipher));
@@ -79,7 +79,7 @@ static int crypto_report_cipher(struct sk_buff *skb, struct crypto_alg *alg)
 
 static int crypto_report_comp(struct sk_buff *skb, struct crypto_alg *alg)
 {
-	struct crypto_stat rcomp;
+	struct crypto_stat_compress rcomp;
 	u64 v64;
 
 	memset(&rcomp, 0, sizeof(rcomp));
@@ -101,7 +101,7 @@ static int crypto_report_comp(struct sk_buff *skb, struct crypto_alg *alg)
 
 static int crypto_report_acomp(struct sk_buff *skb, struct crypto_alg *alg)
 {
-	struct crypto_stat racomp;
+	struct crypto_stat_compress racomp;
 	u64 v64;
 
 	memset(&racomp, 0, sizeof(racomp));
@@ -123,7 +123,7 @@ static int crypto_report_acomp(struct sk_buff *skb, struct crypto_alg *alg)
 
 static int crypto_report_akcipher(struct sk_buff *skb, struct crypto_alg *alg)
 {
-	struct crypto_stat rakcipher;
+	struct crypto_stat_akcipher rakcipher;
 	u64 v64;
 
 	memset(&rakcipher, 0, sizeof(rakcipher));
@@ -150,7 +150,7 @@ static int crypto_report_akcipher(struct sk_buff *skb, struct crypto_alg *alg)
 
 static int crypto_report_kpp(struct sk_buff *skb, struct crypto_alg *alg)
 {
-	struct crypto_stat rkpp;
+	struct crypto_stat_kpp rkpp;
 	u64 v;
 
 	memset(&rkpp, 0, sizeof(rkpp));
@@ -171,7 +171,7 @@ static int crypto_report_kpp(struct sk_buff *skb, struct crypto_alg *alg)
 
 static int crypto_report_ahash(struct sk_buff *skb, struct crypto_alg *alg)
 {
-	struct crypto_stat rhash;
+	struct crypto_stat_hash rhash;
 	u64 v64;
 
 	memset(&rhash, 0, sizeof(rhash));
@@ -190,7 +190,7 @@ static int crypto_report_ahash(struct sk_buff *skb, struct crypto_alg *alg)
 
 static int crypto_report_shash(struct sk_buff *skb, struct crypto_alg *alg)
 {
-	struct crypto_stat rhash;
+	struct crypto_stat_hash rhash;
 	u64 v64;
 
 	memset(&rhash, 0, sizeof(rhash));
@@ -209,7 +209,7 @@ static int crypto_report_shash(struct sk_buff *skb, struct crypto_alg *alg)
 
 static int crypto_report_rng(struct sk_buff *skb, struct crypto_alg *alg)
 {
-	struct crypto_stat rrng;
+	struct crypto_stat_rng rrng;
 	u64 v64;
 
 	memset(&rrng, 0, sizeof(rrng));
@@ -248,7 +248,7 @@ static int crypto_reportstat_one(struct crypto_alg *alg,
 	if (nla_put_u32(skb, CRYPTOCFGA_PRIORITY_VAL, alg->cra_priority))
 		goto nla_put_failure;
 	if (alg->cra_flags & CRYPTO_ALG_LARVAL) {
-		struct crypto_stat rl;
+		struct crypto_stat_larval rl;
 
 		memset(&rl, 0, sizeof(rl));
 		strscpy(rl.type, "larval", sizeof(rl.type));
diff --git a/include/uapi/linux/cryptouser.h b/include/uapi/linux/cryptouser.h
index 9f8187077ce4..790b5c6511e5 100644
--- a/include/uapi/linux/cryptouser.h
+++ b/include/uapi/linux/cryptouser.h
@@ -76,47 +76,72 @@ struct crypto_user_alg {
 	__u32 cru_flags;
 };
 
-struct crypto_stat {
-	char type[CRYPTO_MAX_NAME];
-	union {
-		__u64 stat_encrypt_cnt;
-		__u64 stat_compress_cnt;
-		__u64 stat_generate_cnt;
-		__u64 stat_hash_cnt;
-		__u64 stat_setsecret_cnt;
-	};
-	union {
-		__u64 stat_encrypt_tlen;
-		__u64 stat_compress_tlen;
-		__u64 stat_generate_tlen;
-		__u64 stat_hash_tlen;
-	};
-	union {
-		__u64 stat_akcipher_err_cnt;
-		__u64 stat_cipher_err_cnt;
-		__u64 stat_compress_err_cnt;
-		__u64 stat_aead_err_cnt;
-		__u64 stat_hash_err_cnt;
-		__u64 stat_rng_err_cnt;
-		__u64 stat_kpp_err_cnt;
-	};
-	union {
-		__u64 stat_decrypt_cnt;
-		__u64 stat_decompress_cnt;
-		__u64 stat_seed_cnt;
-		__u64 stat_generate_public_key_cnt;
-	};
-	union {
-		__u64 stat_decrypt_tlen;
-		__u64 stat_decompress_tlen;
-	};
-	union {
-		__u64 stat_verify_cnt;
-		__u64 stat_compute_shared_secret_cnt;
-	};
+struct crypto_stat_cipher {
+	char type[CRYPTO_MAX_NAME];
+	__u64 stat_encrypt_cnt;
+	__u64 stat_encrypt_tlen;
+	__u64 stat_decrypt_cnt;
+	__u64 stat_decrypt_tlen;
+	__u64 stat_cipher_err_cnt;
+};
+
+struct crypto_stat_aead {
+	char type[CRYPTO_MAX_NAME];
+	__u64 stat_encrypt_cnt;
+	__u64 stat_encrypt_tlen;
+	__u64 stat_decrypt_cnt;
+	__u64 stat_decrypt_tlen;
+	__u64 stat_cipher_err_cnt;
+	__u64 stat_aead_err_cnt;
+};
+
+struct crypto_stat_akcipher {
+	char type[CRYPTO_MAX_NAME];
+	__u64 stat_encrypt_cnt;
+	__u64 stat_encrypt_tlen;
+	__u64 stat_decrypt_cnt;
+	__u64 stat_decrypt_tlen;
+	__u64 stat_akcipher_err_cnt;
+	__u64 stat_verify_cnt;
 	__u64 stat_sign_cnt;
 };
 
+struct crypto_stat_compress {
+	char type[CRYPTO_MAX_NAME];
+	__u64 stat_compress_cnt;
+	__u64 stat_compress_tlen;
+	__u64 stat_decompress_cnt;
+	__u64 stat_decompress_tlen;
+	__u64 stat_compress_err_cnt;
+};
+
+struct crypto_stat_rng {
+	char type[CRYPTO_MAX_NAME];
+	__u64 stat_generate_cnt;
+	__u64 stat_generate_tlen;
+	__u64 stat_rng_err_cnt;
+	__u64 stat_seed_cnt;
+};
+
+struct crypto_stat_hash {
+	char type[CRYPTO_MAX_NAME];
+	__u64 stat_hash_cnt;
+	__u64 stat_hash_tlen;
+	__u64 stat_hash_err_cnt;
+};
+
+struct crypto_stat_kpp {
+	char type[CRYPTO_MAX_NAME];
+	__u64 stat_setsecret_cnt;
+	__u64 stat_kpp_err_cnt;
+	__u64 stat_generate_public_key_cnt;
+	__u64 stat_compute_shared_secret_cnt;
+};
+
+struct crypto_stat_larval {
+	char type[CRYPTO_MAX_NAME];
+};
+
 struct crypto_report_larval {
 	char type[CRYPTO_MAX_NAME];
 };
-- 
2.18.1

