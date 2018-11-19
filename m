Return-Path: <SRS0=tadO=N6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B1BBC43441
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 19:54:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 03A6220831
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 19:54:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="M7NdlAe0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 03A6220831
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730718AbeKTGTb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Nov 2018 01:19:31 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:39660 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730535AbeKTGSw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Nov 2018 01:18:52 -0500
Received: by mail-wm1-f65.google.com with SMTP id u13-v6so6483262wmc.4
        for <linux-kernel@vger.kernel.org>; Mon, 19 Nov 2018 11:53:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=0bKoIVDEvBCfvmdePQUvmidHV3aD7Gg3V/flQsVkXNA=;
        b=M7NdlAe05PuesdSgORunUeLZiw5UBbZmakIGI2E5fYbTPpIpwRXO2mfCF20a8tsbjK
         zGQhDHLQ/LAZuGguZP7wqIfrQWiQj3ilvgFUcn/X7sPkK9HlWUDNdsqb3MDPDO60GDR+
         8LslS4T+LtaU+zhgCpi7jZ+vtmP2vWMWaTOQPUdLdiwLJIgWRtO3rh+cMFPRFO9bIyFh
         eibFeu+nVT7lj0WwAr/AN58WzKfJvYMlx9prKHjyKoa+iibozyCCgBkd65bzz6auFqSX
         2eliKh2fyOd6WhkGQkC0wpJ9eFKYYdTRQ3/s5UKhJAcYcY7JYVjgmA3qoqiUgKJk3uqX
         NF0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=0bKoIVDEvBCfvmdePQUvmidHV3aD7Gg3V/flQsVkXNA=;
        b=avh4wKsqigfm1qYgCrfVQuBUP7IN1UDJ2reJwyT2rGGgWuhgo/UOr+q0147jNeWxi0
         GsY4rKRLOx6mVjqUY2YrzGyC2HBosicWGHZ08XGTgTbExZ0lx0G94OUCdfz+GU/d6ydF
         pgHn/M48uHn+2KxyiT65j0oBgmZ8SJZeZV3rr/owKbMj5BnBFndXHBmZFSGLPX/j2JHi
         H9ZT6jdDsrA07KFi4XXLzBYmWvOGQge+xUlHoGfc6xt5mIdCgX6B0rQdn3t8dJEXXLZJ
         SzdhNXfk5d1I6ABwheXMKSEjuHNCdSq/dbL9ZXNMfoqd4VQJoPBtzogCrnLbRBasHddq
         7/uA==
X-Gm-Message-State: AGRZ1gJO2vbc+umpvX95iWz9uwX79lbJtpZLBfpWjX3Kd+gz7A5lDwmD
        9bdsBVLS6BjpL280m9yKDZD4fA==
X-Google-Smtp-Source: AJdET5fuq4I4TM+gs/voxP3V3IImd4q1+JkWKOmTddafoOmJ5IMDTGMy6k4b+W/jR4cwb+jz9ACdJA==
X-Received: by 2002:a1c:b8d:: with SMTP id 135-v6mr8518917wml.128.1542657222203;
        Mon, 19 Nov 2018 11:53:42 -0800 (PST)
Received: from localhost.localdomain ([51.15.160.169])
        by smtp.googlemail.com with ESMTPSA id i16sm22954132wmd.28.2018.11.19.11.53.41
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 19 Nov 2018 11:53:41 -0800 (PST)
From:   Corentin Labbe <clabbe@baylibre.com>
To:     davem@davemloft.net, ebiggers@kernel.org,
        herbert@gondor.apana.org.au, nhorman@tuxdriver.com
Cc:     linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        Corentin Labbe <clabbe@baylibre.com>
Subject: [PATCH v2 06/11] crypto: tool: getstat: convert user space example to the new crypto_user_stat uapi
Date:   Mon, 19 Nov 2018 19:53:25 +0000
Message-Id: <1542657210-37739-7-git-send-email-clabbe@baylibre.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1542657210-37739-1-git-send-email-clabbe@baylibre.com>
References: <1542657210-37739-1-git-send-email-clabbe@baylibre.com>
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

