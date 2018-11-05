Return-Path: <SRS0=bKrn=NQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B62F4ECDE43
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 12:51:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 743C820866
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 12:51:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="LzsYsdTq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 743C820866
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729861AbeKEWLH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 5 Nov 2018 17:11:07 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:46252 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729792AbeKEWLG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Nov 2018 17:11:06 -0500
Received: by mail-wr1-f67.google.com with SMTP id 74-v6so9371330wrb.13
        for <linux-kernel@vger.kernel.org>; Mon, 05 Nov 2018 04:51:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=0bKoIVDEvBCfvmdePQUvmidHV3aD7Gg3V/flQsVkXNA=;
        b=LzsYsdTqgsgffuPQXohFqBJyUGdAgBDRQ1u6DA8cdPaapIYPhZkg+/rfk/SEPuBDJI
         7VHMq7dK+wBu5ZqbgC8nFRE7F0p0rsKarM8vJCptUFxyvfe0KOXovHKQRFZAtMF0+m8I
         yyx63zlHlTtEUuQLrl40h3YE0xAAdLchHt75kVnlXU8m6PRy/Wz+MxkONwhTII/H84ZC
         kQYVPsDllowN48xD3wK9IePRilSusmA9y6pq7VbPtExu0A24BzgjiIUPlaFzQuW5YubL
         YDKAQnoOxOF3RFNPKBa7xz0FuvO7MBziGlUJNfgVDjx1WG/ftkkY43oqQzc5W0+xzl6q
         zRwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=0bKoIVDEvBCfvmdePQUvmidHV3aD7Gg3V/flQsVkXNA=;
        b=W8OnL/cPo21haPGokXEP0zja0Qm3LA0ECU0NQEta7IwP3ybwkKivzIY2V+YMuy7SGK
         rn64VUKNaVSXvqbkQeBTfFxfGKh20eUkpi44XQk2b0je+TiHKG3NVGbWkINn9SIhsakT
         iX4+WsT5FMobQioEeuBzgyT/jIVxGAMONNjOjcnRnKFMEXVXyyUL9UBn1StH6w2jk0xR
         9HcqWTqVQe41hhmighorI026JNJA7s7GEEQMHU3y3RmP9D2h8GrAtK6A3UIMJJhTrfvi
         PBlh+Kr/edYZ3gD8vaE0Ec9r2vFp6aXJU3ye+ObOz+ROLEf5Ov6wTEBuA6Bx0465clKZ
         G91Q==
X-Gm-Message-State: AGRZ1gIDQLisWqlMryio9Q8hw3pmRxaYZPbnufhJrs7jQbMPuaXCVunL
        i074YIhHnQm1E42Z5kDwQ/yH2Va57lk=
X-Google-Smtp-Source: AJdET5cm1ildsAB4gVn4ft1FgoqELKdx2HKlKzpv04tIWdhYBek8IWQ/H+b/xyFtNXRGqQrXQ4aZlw==
X-Received: by 2002:adf:fd49:: with SMTP id h9-v6mr20031347wrs.280.1541422288960;
        Mon, 05 Nov 2018 04:51:28 -0800 (PST)
Received: from localhost.localdomain ([51.15.160.169])
        by smtp.googlemail.com with ESMTPSA id l4-v6sm56114579wrb.92.2018.11.05.04.51.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 05 Nov 2018 04:51:28 -0800 (PST)
From:   Corentin Labbe <clabbe@baylibre.com>
To:     davem@davemloft.net, ebiggers@kernel.org,
        herbert@gondor.apana.org.au
Cc:     linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        Corentin Labbe <clabbe@baylibre.com>
Subject: [PATCH 4/5] crypto: tool: getstat: convert user space example to the new crypto_user_stat uapi
Date:   Mon,  5 Nov 2018 12:51:13 +0000
Message-Id: <1541422274-40060-5-git-send-email-clabbe@baylibre.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1541422274-40060-1-git-send-email-clabbe@baylibre.com>
References: <1541422274-40060-1-git-send-email-clabbe@baylibre.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch converts the getstat example tool to the recent changes done in crypto_user_stat
- changed all stats to u64
- separated struct stats for each crypto alg

Signed-off-by: Corentin Labbe <clabbe@baylibre.com>
---
 tools/crypto/getstat.c | 54 +++++++++++++++++++++---------------------
 1 file changed, 27 insertions(+), 27 deletions(-)

diff --git a/tools/crypto/getstat.c b/tools/crypto/getstat.c
index 24115173a483..57fbb94608d4 100644
--- a/tools/crypto/getstat.c
+++ b/tools/crypto/getstat.c
@@ -152,53 +152,53 @@ static int get_stat(const char *drivername)
 
 	if (tb[CRYPTOCFGA_STAT_HASH]) {
 		struct rtattr *rta = tb[CRYPTOCFGA_STAT_HASH];
-		struct crypto_stat *rhash =
-			(struct crypto_stat *)RTA_DATA(rta);
-		printf("%s\tHash\n\tHash: %u bytes: %llu\n\tErrors: %u\n",
+		struct crypto_stat_hash *rhash =
+			(struct crypto_stat_hash *)RTA_DATA(rta);
+		printf("%s\tHash\n\tHash: %llu bytes: %llu\n\tErrors: %llu\n",
 			drivername,
 			rhash->stat_hash_cnt, rhash->stat_hash_tlen,
 			rhash->stat_hash_err_cnt);
 	} else if (tb[CRYPTOCFGA_STAT_COMPRESS]) {
 		struct rtattr *rta = tb[CRYPTOCFGA_STAT_COMPRESS];
-		struct crypto_stat *rblk =
-			(struct crypto_stat *)RTA_DATA(rta);
-		printf("%s\tCompress\n\tCompress: %u bytes: %llu\n\tDecompress: %u bytes: %llu\n\tErrors: %u\n",
+		struct crypto_stat_compress *rblk =
+			(struct crypto_stat_compress *)RTA_DATA(rta);
+		printf("%s\tCompress\n\tCompress: %llu bytes: %llu\n\tDecompress: %llu bytes: %llu\n\tErrors: %llu\n",
 			drivername,
 			rblk->stat_compress_cnt, rblk->stat_compress_tlen,
 			rblk->stat_decompress_cnt, rblk->stat_decompress_tlen,
 			rblk->stat_compress_err_cnt);
 	} else if (tb[CRYPTOCFGA_STAT_ACOMP]) {
 		struct rtattr *rta = tb[CRYPTOCFGA_STAT_ACOMP];
-		struct crypto_stat *rcomp =
-			(struct crypto_stat *)RTA_DATA(rta);
-		printf("%s\tACompress\n\tCompress: %u bytes: %llu\n\tDecompress: %u bytes: %llu\n\tErrors: %u\n",
+		struct crypto_stat_compress *rcomp =
+			(struct crypto_stat_compress *)RTA_DATA(rta);
+		printf("%s\tACompress\n\tCompress: %llu bytes: %llu\n\tDecompress: %llu bytes: %llu\n\tErrors: %llu\n",
 			drivername,
 			rcomp->stat_compress_cnt, rcomp->stat_compress_tlen,
 			rcomp->stat_decompress_cnt, rcomp->stat_decompress_tlen,
 			rcomp->stat_compress_err_cnt);
 	} else if (tb[CRYPTOCFGA_STAT_AEAD]) {
 		struct rtattr *rta = tb[CRYPTOCFGA_STAT_AEAD];
-		struct crypto_stat *raead =
-			(struct crypto_stat *)RTA_DATA(rta);
-		printf("%s\tAEAD\n\tEncrypt: %u bytes: %llu\n\tDecrypt: %u bytes: %llu\n\tErrors: %u\n",
+		struct crypto_stat_aead *raead =
+			(struct crypto_stat_aead *)RTA_DATA(rta);
+		printf("%s\tAEAD\n\tEncrypt: %llu bytes: %llu\n\tDecrypt: %llu bytes: %llu\n\tErrors: %llu\n",
 			drivername,
 			raead->stat_encrypt_cnt, raead->stat_encrypt_tlen,
 			raead->stat_decrypt_cnt, raead->stat_decrypt_tlen,
 			raead->stat_aead_err_cnt);
 	} else if (tb[CRYPTOCFGA_STAT_BLKCIPHER]) {
 		struct rtattr *rta = tb[CRYPTOCFGA_STAT_BLKCIPHER];
-		struct crypto_stat *rblk =
-			(struct crypto_stat *)RTA_DATA(rta);
-		printf("%s\tCipher\n\tEncrypt: %u bytes: %llu\n\tDecrypt: %u bytes: %llu\n\tErrors: %u\n",
+		struct crypto_stat_cipher *rblk =
+			(struct crypto_stat_cipher *)RTA_DATA(rta);
+		printf("%s\tCipher\n\tEncrypt: %llu bytes: %llu\n\tDecrypt: %llu bytes: %llu\n\tErrors: %llu\n",
 			drivername,
 			rblk->stat_encrypt_cnt, rblk->stat_encrypt_tlen,
 			rblk->stat_decrypt_cnt, rblk->stat_decrypt_tlen,
 			rblk->stat_cipher_err_cnt);
 	} else if (tb[CRYPTOCFGA_STAT_AKCIPHER]) {
 		struct rtattr *rta = tb[CRYPTOCFGA_STAT_AKCIPHER];
-		struct crypto_stat *rblk =
-			(struct crypto_stat *)RTA_DATA(rta);
-		printf("%s\tAkcipher\n\tEncrypt: %u bytes: %llu\n\tDecrypt: %u bytes: %llu\n\tSign: %u\n\tVerify: %u\n\tErrors: %u\n",
+		struct crypto_stat_akcipher *rblk =
+			(struct crypto_stat_akcipher *)RTA_DATA(rta);
+		printf("%s\tAkcipher\n\tEncrypt: %llu bytes: %llu\n\tDecrypt: %llu bytes: %llu\n\tSign: %llu\n\tVerify: %llu\n\tErrors: %llu\n",
 			drivername,
 			rblk->stat_encrypt_cnt, rblk->stat_encrypt_tlen,
 			rblk->stat_decrypt_cnt, rblk->stat_decrypt_tlen,
@@ -206,27 +206,27 @@ static int get_stat(const char *drivername)
 			rblk->stat_akcipher_err_cnt);
 	} else if (tb[CRYPTOCFGA_STAT_CIPHER]) {
 		struct rtattr *rta = tb[CRYPTOCFGA_STAT_CIPHER];
-		struct crypto_stat *rblk =
-			(struct crypto_stat *)RTA_DATA(rta);
-		printf("%s\tcipher\n\tEncrypt: %u bytes: %llu\n\tDecrypt: %u bytes: %llu\n\tErrors: %u\n",
+		struct crypto_stat_cipher *rblk =
+			(struct crypto_stat_cipher *)RTA_DATA(rta);
+		printf("%s\tcipher\n\tEncrypt: %llu bytes: %llu\n\tDecrypt: %llu bytes: %llu\n\tErrors: %llu\n",
 			drivername,
 			rblk->stat_encrypt_cnt, rblk->stat_encrypt_tlen,
 			rblk->stat_decrypt_cnt, rblk->stat_decrypt_tlen,
 			rblk->stat_cipher_err_cnt);
 	} else if (tb[CRYPTOCFGA_STAT_RNG]) {
 		struct rtattr *rta = tb[CRYPTOCFGA_STAT_RNG];
-		struct crypto_stat *rrng =
-			(struct crypto_stat *)RTA_DATA(rta);
-		printf("%s\tRNG\n\tSeed: %u\n\tGenerate: %u bytes: %llu\n\tErrors: %u\n",
+		struct crypto_stat_rng *rrng =
+			(struct crypto_stat_rng *)RTA_DATA(rta);
+		printf("%s\tRNG\n\tSeed: %llu\n\tGenerate: %llu bytes: %llu\n\tErrors: %llu\n",
 			drivername,
 			rrng->stat_seed_cnt,
 			rrng->stat_generate_cnt, rrng->stat_generate_tlen,
 			rrng->stat_rng_err_cnt);
 	} else if (tb[CRYPTOCFGA_STAT_KPP]) {
 		struct rtattr *rta = tb[CRYPTOCFGA_STAT_KPP];
-		struct crypto_stat *rkpp =
-			(struct crypto_stat *)RTA_DATA(rta);
-		printf("%s\tKPP\n\tSetsecret: %u\n\tGenerate public key: %u\n\tCompute_shared_secret: %u\n\tErrors: %u\n",
+		struct crypto_stat_kpp *rkpp =
+			(struct crypto_stat_kpp *)RTA_DATA(rta);
+		printf("%s\tKPP\n\tSetsecret: %llu\n\tGenerate public key: %llu\n\tCompute_shared_secret: %llu\n\tErrors: %llu\n",
 			drivername,
 			rkpp->stat_setsecret_cnt,
 			rkpp->stat_generate_public_key_cnt,
-- 
2.18.1

