Return-Path: <SRS0=i6x1=N7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18AC8C41536
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 12:34:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A50C82087E
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 12:34:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="D/VC5XpJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A50C82087E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729601AbeKTXCU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Nov 2018 18:02:20 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:54203 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729574AbeKTXCT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Nov 2018 18:02:19 -0500
Received: by mail-wm1-f65.google.com with SMTP id g131so1947753wmg.3
        for <linux-kernel@vger.kernel.org>; Tue, 20 Nov 2018 04:33:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=DnCS1rs6b2H/3VHK6H3MQrXNsxUPLpLFhvXASv311qQ=;
        b=D/VC5XpJ5b6HBsD4n9YVXvC7VXA5kYe9cg8PzJeLH9siY76PyomDuEWM0dXS2Y3jqA
         URDRoDwFpOLKncWPuQV5hO/dHegHTBhBgwixVEzXU6Yp+3+9hQJX3APkicmLQOTpwrgv
         K58GlE2GqPwcLZcPhzKi/a3jfohyiqwoBPeokN8wNeFnUGTAVl6dAXQumEEBLlLGwWcw
         Ksy5em0QRhbmbh3jJk6virTFrEkaPsU1VRkqgwb2u4QiXwzXN2klFcapNxyddl9tp8ua
         nkrNCIzrwCqKTP//k8f60u6PYNLvx70KmuzLp0af5RzzmoT8eD3K2NqaprUQMBfQg7Y+
         uUiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=DnCS1rs6b2H/3VHK6H3MQrXNsxUPLpLFhvXASv311qQ=;
        b=jrLKM7aLJos2s0QoSC7QzCvZbSEZQX5yzlfS6ZOm2tNRMoFZCpTU1TNk6iF37ET+Q2
         T4lsRG8sJV2os1gn8g0PPt56ZKLC2VQdFiRYhKHMiFdDkSAikPsJpMvezRm5SXbpULlm
         iY4wsyo9infgGWLgwcrSD32k1HDhdHY6khIBCoY5lTRykr2cmGFxxYXAYY2xH+IPLa06
         9kbK2SP1AMkJc0mlgJyiKoq+svJFdb6t0DQVR3A/7A7bUZlaaFvtakommvNH9uL2WSwd
         WGHngEK1WQi3CaVjpw4vJzM4KkPLAxSWwzvgV7b9RnV1Tu5qusgQrGPscGGSx9SyZS2k
         p2MA==
X-Gm-Message-State: AA+aEWbPoWXYzghcO2fXIj99FSGwQyw0cohtSpSlEIrBRdod/hCBSgX2
        w4foO3NtGs5uiK4NfRNrok+0Jw==
X-Google-Smtp-Source: AJdET5dJk1qYix0wyq1LXsHSuDsoFEmlLRL/p+PnNcUZ7rceoHp55a9zdIQeaA1RL/VuG2kWzxB1yg==
X-Received: by 2002:a1c:1c88:: with SMTP id c130-v6mr2024948wmc.115.1542717203545;
        Tue, 20 Nov 2018 04:33:23 -0800 (PST)
Received: from localhost.localdomain ([51.15.160.169])
        by smtp.googlemail.com with ESMTPSA id x81sm2766951wmg.17.2018.11.20.04.33.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 20 Nov 2018 04:33:22 -0800 (PST)
From:   Corentin Labbe <clabbe@baylibre.com>
To:     davem@davemloft.net, ebiggers@kernel.org,
        herbert@gondor.apana.org.au, nhorman@tuxdriver.com
Cc:     linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        Corentin Labbe <clabbe@baylibre.com>
Subject: [PATCH v3 04/10] crypto: crypto_user_stat: split user space crypto stat structures
Date:   Tue, 20 Nov 2018 12:32:20 +0000
Message-Id: <1542717146-34917-5-git-send-email-clabbe@baylibre.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1542717146-34917-1-git-send-email-clabbe@baylibre.com>
References: <1542717146-34917-1-git-send-email-clabbe@baylibre.com>
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

