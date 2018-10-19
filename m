Return-Path: <SRS0=xTli=M7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F352ECDE3D
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Oct 2018 12:27:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 66AA02087A
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Oct 2018 12:27:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="scKilsON"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 66AA02087A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727544AbeJSUdg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Oct 2018 16:33:36 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:35600 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727170AbeJSUdf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Oct 2018 16:33:35 -0400
Received: by mail-wr1-f66.google.com with SMTP id w5-v6so37213618wrt.2
        for <linux-kernel@vger.kernel.org>; Fri, 19 Oct 2018 05:27:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id;
        bh=PTttB8tOVuaj8KEhJudUaoEIxo5NBOeXZ0+PTgREfCA=;
        b=scKilsON7T7m5FSlEcSAGq2DGush8I0sElf8DKGVN1z1qz+8/01K48T/2AoCtjgkt4
         hzxNGq8Ty2u1r6yzvIpTdOUwmcl2ouTGTWSnL5/BAIlJLRxEe3RwjXdbART0V8EE8Fy7
         IOZBKjQSNjcFyzg7Zh0yDd7ZjgyMLt5VAxBsCGwfUoLD5LtjvdPmcOfJnE6Clm1OIUT3
         azTgjWzXuxueJfWLxV0HNob2LkRywKp904oh2FVg8ZkVUEYypfH/Y5KHCAexIlQFtlNK
         SqpGgK766MWBpOmCyyoeelB24RphpnbPi4OO7d1JGeKRM+5wc/dbTCJBnyw3YeJpi2HX
         Z/+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=PTttB8tOVuaj8KEhJudUaoEIxo5NBOeXZ0+PTgREfCA=;
        b=PDjr53IpHLTbwsqwwzzbokOTv2FrqiwsC2DqYzJRO+V30AOQuN10GCnnWt1lKrqhJ0
         an+IZcmTcNUEWaMz3j8z0X0gE2zLnJVEEiAdkR04nvukv/7sRoti9YiBVlXkgkXKD7Qi
         65lVxXeiW++cDNqN4utSeSvbWkjXj+44BEmRRggpgZaweBfPz2OVlbNRYTxlxTXkKmQj
         TeF0XX+B6EKs8yB/9Ue/DjEOVsgqFsU4+f8XJjS+/Dp/iAX4pjnmaUv6qJ9kmemL/4M5
         Q3NAUxImMG10plcI5suxXNTQ+Vo7Vy39TXZL7utO3tABw1uEkVQRJNF8jAz4wzkLYwtU
         vUWA==
X-Gm-Message-State: ABuFfogecp30ZrGhbk7A4x7lr2Nj+3rnjqlVMQKAuQ5bd+K4dxJ3m0Xf
        08036O71Q4Dhrb6wujn5VFVmvw==
X-Google-Smtp-Source: ACcGV62RGLVIVmzyjhYHgx0rOfA6QzEU+jCpjcpDX1tUkiUowAHEUfsc447Ze6rhUb8T1ul+iZY2/A==
X-Received: by 2002:adf:aa90:: with SMTP id h16-v6mr32056912wrc.216.1539952060628;
        Fri, 19 Oct 2018 05:27:40 -0700 (PDT)
Received: from localhost.localdomain ([51.15.160.169])
        by smtp.googlemail.com with ESMTPSA id l67-v6sm8326882wma.20.2018.10.19.05.27.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 19 Oct 2018 05:27:39 -0700 (PDT)
From:   Corentin Labbe <clabbe@baylibre.com>
To:     dan.carpenter@oracle.com, davem@davemloft.net,
        herbert@gondor.apana.org.au
Cc:     linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        Corentin Labbe <clabbe@baylibre.com>
Subject: [PATCH] crypto: crypto_user_stat: Zeroize whole structure given to user space
Date:   Fri, 19 Oct 2018 12:27:25 +0000
Message-Id: <1539952045-18784-1-git-send-email-clabbe@baylibre.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For preventing un-initilized data to be given to user-space (and so leak
potential useful data), the crypto_stat structure must be correctly
initialised.

Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
Fixes: cac5818c25d0 ("crypto: user - Implement a generic crypto statistics")
Signed-off-by: Corentin Labbe <clabbe@baylibre.com>
---
 crypto/crypto_user_stat.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/crypto/crypto_user_stat.c b/crypto/crypto_user_stat.c
index 021ad06bbb62..9990c599f648 100644
--- a/crypto/crypto_user_stat.c
+++ b/crypto/crypto_user_stat.c
@@ -37,6 +37,7 @@ static int crypto_report_aead(struct sk_buff *skb, struct crypto_alg *alg)
 	u64 v64;
 	u32 v32;
 
+	memset(&raead, 0, sizeof(struct crypto_stat));
 	strncpy(raead.type, "aead", sizeof(raead.type));
 
 	v32 = atomic_read(&alg->encrypt_cnt);
@@ -65,6 +66,7 @@ static int crypto_report_cipher(struct sk_buff *skb, struct crypto_alg *alg)
 	u64 v64;
 	u32 v32;
 
+	memset(&rcipher, 0, sizeof(struct crypto_stat));
 	strlcpy(rcipher.type, "cipher", sizeof(rcipher.type));
 
 	v32 = atomic_read(&alg->encrypt_cnt);
@@ -93,6 +95,7 @@ static int crypto_report_comp(struct sk_buff *skb, struct crypto_alg *alg)
 	u64 v64;
 	u32 v32;
 
+	memset(&rcomp, 0, sizeof(struct crypto_stat));
 	strlcpy(rcomp.type, "compression", sizeof(rcomp.type));
 	v32 = atomic_read(&alg->compress_cnt);
 	rcomp.stat_compress_cnt = v32;
@@ -120,6 +123,7 @@ static int crypto_report_acomp(struct sk_buff *skb, struct crypto_alg *alg)
 	u64 v64;
 	u32 v32;
 
+	memset(&racomp, 0, sizeof(struct crypto_stat));
 	strlcpy(racomp.type, "acomp", sizeof(racomp.type));
 	v32 = atomic_read(&alg->compress_cnt);
 	racomp.stat_compress_cnt = v32;
@@ -147,6 +151,7 @@ static int crypto_report_akcipher(struct sk_buff *skb, struct crypto_alg *alg)
 	u64 v64;
 	u32 v32;
 
+	memset(&rakcipher, 0, sizeof(struct crypto_stat));
 	strncpy(rakcipher.type, "akcipher", sizeof(rakcipher.type));
 	v32 = atomic_read(&alg->encrypt_cnt);
 	rakcipher.stat_encrypt_cnt = v32;
@@ -177,6 +182,7 @@ static int crypto_report_kpp(struct sk_buff *skb, struct crypto_alg *alg)
 	struct crypto_stat rkpp;
 	u32 v;
 
+	memset(&rkpp, 0, sizeof(struct crypto_stat));
 	strlcpy(rkpp.type, "kpp", sizeof(rkpp.type));
 
 	v = atomic_read(&alg->setsecret_cnt);
@@ -203,6 +209,7 @@ static int crypto_report_ahash(struct sk_buff *skb, struct crypto_alg *alg)
 	u64 v64;
 	u32 v32;
 
+	memset(&rhash, 0, sizeof(struct crypto_stat));
 	strncpy(rhash.type, "ahash", sizeof(rhash.type));
 
 	v32 = atomic_read(&alg->hash_cnt);
@@ -227,6 +234,7 @@ static int crypto_report_shash(struct sk_buff *skb, struct crypto_alg *alg)
 	u64 v64;
 	u32 v32;
 
+	memset(&rhash, 0, sizeof(struct crypto_stat));
 	strncpy(rhash.type, "shash", sizeof(rhash.type));
 
 	v32 = atomic_read(&alg->hash_cnt);
@@ -251,6 +259,7 @@ static int crypto_report_rng(struct sk_buff *skb, struct crypto_alg *alg)
 	u64 v64;
 	u32 v32;
 
+	memset(&rrng, 0, sizeof(struct crypto_stat));
 	strncpy(rrng.type, "rng", sizeof(rrng.type));
 
 	v32 = atomic_read(&alg->generate_cnt);
-- 
2.18.1

