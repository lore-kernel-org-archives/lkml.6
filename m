Return-Path: <SRS0=8q1S=OI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD460C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 14:42:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 66ED12146F
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 14:42:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="Zy6VtwLw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 66ED12146F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388457AbeK3BsT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Nov 2018 20:48:19 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:42358 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387755AbeK3BsP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Nov 2018 20:48:15 -0500
Received: by mail-wr1-f67.google.com with SMTP id q18so2156795wrx.9
        for <linux-kernel@vger.kernel.org>; Thu, 29 Nov 2018 06:42:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=DnCS1rs6b2H/3VHK6H3MQrXNsxUPLpLFhvXASv311qQ=;
        b=Zy6VtwLwktLr7OQ8uxJnrF3xgCsyPI69Fyv9iWR7S93YCaeurjl4+5Bbs+YcOtP0w0
         Cg7TopLOW61w7tUJt5t/KyQUxVwEfmpD0qU/FmYFOmO+7TlXKCFCsmQ7lRpy4YEZnNhq
         hqGambPnZcvIkHcjewhYO7zamfCWbAEFkJIvg9t7RGiRy29a1vLIUjMwEd4am2tjKdFu
         t3kBpjISl/oX0EG2bFqKW+vJAVZptEo1W3PtfPnHdGkD3fgzV4NAQck75vOYTmc0bgDt
         0Qz/iNSaa5LDmNQZbWWAIjTZ8HKxW3Wy+5mTqgtXSvFqYUR+FBGRn4StMdOJ1M7UIKE0
         w6eA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=DnCS1rs6b2H/3VHK6H3MQrXNsxUPLpLFhvXASv311qQ=;
        b=hio6sTU7Zlf5UOnfB+dGUpxxvpKRRmKI5MBPbic1xwIUA7EnnUAW3uQ3c4XXWgFzb8
         FAa6fNnNEFprqaxlPvWP9zojJ34iqp/hMzwlrtlxCN9xTibntm4kxDEkfWoWpbDXV4PB
         Nqnlc2UIdDBRucEo/SKZrLb+5ZAK7eHhaxu5uKuxdMjFCVgAKbkK0rB3oTnpyZra+yAf
         bXn4qnEST6EffQNmV2+fhbkuNKlXGpbRT0zD39y3ECofAB5yr6Q6T5FzXXgvlYhurdK+
         aQZBjheIb4NXYp589MUYuyKXSM6ZeX3+X7Hn7FuwvGliqJvQlff2rCw4BfQRcrVQ+Kn7
         fHWg==
X-Gm-Message-State: AA+aEWZiRojvU8Mylcijyw2NskP/dKM7ivVLkccEGUC0Qg2XrjCqEKrC
        bi4P8dO4qMTuaNhGRf13zb6/RQ==
X-Google-Smtp-Source: AFSGD/VkAY8CFCRs+FFJN1VDQoYes/wgq4rCsg1k/fegk1tjSgrIaumUvBSVgJ4AF3g8vqrCmHJO/g==
X-Received: by 2002:adf:8464:: with SMTP id 91mr1759409wrf.251.1543502558171;
        Thu, 29 Nov 2018 06:42:38 -0800 (PST)
Received: from localhost.localdomain ([51.15.160.169])
        by smtp.googlemail.com with ESMTPSA id t131sm875406wmt.1.2018.11.29.06.42.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 29 Nov 2018 06:42:37 -0800 (PST)
From:   Corentin Labbe <clabbe@baylibre.com>
To:     davem@davemloft.net, ebiggers@kernel.org,
        herbert@gondor.apana.org.au, nhorman@tuxdriver.com
Cc:     linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        Corentin Labbe <clabbe@baylibre.com>
Subject: [PATCH v5 04/11] crypto: crypto_user_stat: split user space crypto stat structures
Date:   Thu, 29 Nov 2018 14:42:19 +0000
Message-Id: <1543502546-23870-5-git-send-email-clabbe@baylibre.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1543502546-23870-1-git-send-email-clabbe@baylibre.com>
References: <1543502546-23870-1-git-send-email-clabbe@baylibre.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It is cleaner to have each stat in their own structures.

Signed-off-by: Corentin Labbe <clabbe@baylibre.com>
---
 crypto/crypto_user_stat.c       |  20 +++----
 include/uapi/linux/cryptouser.h | 100 ++++++++++++++++++++------------
 2 files changed, 72 insertions(+), 48 deletions(-)

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
index 9f8187077ce4..3a70f025e27d 100644
--- a/include/uapi/linux/cryptouser.h
+++ b/include/uapi/linux/cryptouser.h
@@ -76,45 +76,69 @@ struct crypto_user_alg {
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
+struct crypto_stat_aead {
+	char type[CRYPTO_MAX_NAME];
+	__u64 stat_encrypt_cnt;
+	__u64 stat_encrypt_tlen;
+	__u64 stat_decrypt_cnt;
+	__u64 stat_decrypt_tlen;
+	__u64 stat_aead_err_cnt;
+};
+
+struct crypto_stat_akcipher {
+	char type[CRYPTO_MAX_NAME];
+	__u64 stat_encrypt_cnt;
+	__u64 stat_encrypt_tlen;
+	__u64 stat_decrypt_cnt;
+	__u64 stat_decrypt_tlen;
+	__u64 stat_verify_cnt;
 	__u64 stat_sign_cnt;
+	__u64 stat_akcipher_err_cnt;
+};
+
+struct crypto_stat_cipher {
+	char type[CRYPTO_MAX_NAME];
+	__u64 stat_encrypt_cnt;
+	__u64 stat_encrypt_tlen;
+	__u64 stat_decrypt_cnt;
+	__u64 stat_decrypt_tlen;
+	__u64 stat_cipher_err_cnt;
+};
+
+struct crypto_stat_compress {
+	char type[CRYPTO_MAX_NAME];
+	__u64 stat_compress_cnt;
+	__u64 stat_compress_tlen;
+	__u64 stat_decompress_cnt;
+	__u64 stat_decompress_tlen;
+	__u64 stat_compress_err_cnt;
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
+	__u64 stat_generate_public_key_cnt;
+	__u64 stat_compute_shared_secret_cnt;
+	__u64 stat_kpp_err_cnt;
+};
+
+struct crypto_stat_rng {
+	char type[CRYPTO_MAX_NAME];
+	__u64 stat_generate_cnt;
+	__u64 stat_generate_tlen;
+	__u64 stat_seed_cnt;
+	__u64 stat_rng_err_cnt;
+};
+
+struct crypto_stat_larval {
+	char type[CRYPTO_MAX_NAME];
 };
 
 struct crypto_report_larval {
-- 
2.18.1

