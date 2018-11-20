Return-Path: <SRS0=i6x1=N7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54F0EC41536
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 12:34:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 14EBE2145D
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 12:33:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="qKAd5ij9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 14EBE2145D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729647AbeKTXCX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Nov 2018 18:02:23 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:37330 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729280AbeKTXCW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Nov 2018 18:02:22 -0500
Received: by mail-wm1-f66.google.com with SMTP id p2-v6so2041010wmc.2
        for <linux-kernel@vger.kernel.org>; Tue, 20 Nov 2018 04:33:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=iV/M8EbvN8TGuValOiY6W/51UjKDNEJVorUmBNxwOt4=;
        b=qKAd5ij97VsJ8SbWLaj3KAJEjmUNSARQp6CFLK4MEEEYMWMr4YcA1UgmLFB3xkhfa6
         zuK16WbCBHvV4f5NYu3hByKpNhQKqbrYFv9oFin68cEDu/YiFlAai2rDkdjFSSPsaINY
         XfbihhHokEh6HJhLFaKogc11dZXNT+dYOo00tgAiRTVkHTvg9dlqaBS87A4hCgBcluKK
         1vS0Qf19zk9qt8c0EnvPwwFfQJb6mnWDF2AKNIaIAI3r1t7UFeyqecHZe7IHxCaJ6/JG
         c29dwSEzFsruU3hf4mKBPchDbtAYWCxphwKR3IOTGRmnuN9HKmbxRYAoogS+J9jGw7y3
         f6SA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=iV/M8EbvN8TGuValOiY6W/51UjKDNEJVorUmBNxwOt4=;
        b=Ib8HzZdnDW/S5WQcCTpjRhd/mBKiKkA5Nn9+PPOvHrq4icV9WJUwTXrQ+Vn2kW3kpi
         sjM4CdLaSlkAvqQDhh5Lw65lRdFxxr52zIuAA8dYe+13fm98eORw6yT56si996dnh15D
         2sgC9P0L4ZGEvLdj1QSEoLTwuxsKnBeNk8WtFadDwWKyzNU3/vXwlw22tDEICwGKeFkW
         3KS93RetfjFym8FqlLsYzLz8QI9PTYHK88cnYQCi6YiLAedVqAm88NSTwzFgMINPJcjT
         GpfbG8Zaaw1vsAzXLjDePii470XpKZPbXmzdZvFOflk7GfL7ECj2mqqJaMgMcxO2/UH0
         GJDA==
X-Gm-Message-State: AGRZ1gIFY6dwb39xz3eIEjXBw79o8wc5wbiHqvPraadgqnu4z8hf5Fz3
        4buNxxUaX9tk380HX7zyf2KXxA==
X-Google-Smtp-Source: AJdET5cYbzNt7IUCJ9EkmyLawZUk521AXfYW9vj8lR0+5cskfXlEVhqEK2PjiNwQyUeWyZ6rV/SZRA==
X-Received: by 2002:a1c:4d12:: with SMTP id o18mr2117526wmh.92.1542717206350;
        Tue, 20 Nov 2018 04:33:26 -0800 (PST)
Received: from localhost.localdomain ([51.15.160.169])
        by smtp.googlemail.com with ESMTPSA id x81sm2766951wmg.17.2018.11.20.04.33.25
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 20 Nov 2018 04:33:25 -0800 (PST)
From:   Corentin Labbe <clabbe@baylibre.com>
To:     davem@davemloft.net, ebiggers@kernel.org,
        herbert@gondor.apana.org.au, nhorman@tuxdriver.com
Cc:     linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        Corentin Labbe <clabbe@baylibre.com>
Subject: [PATCH v3 07/10] crypto: crypto_user_stat: Fix invalid stat reporting
Date:   Tue, 20 Nov 2018 12:32:23 +0000
Message-Id: <1542717146-34917-8-git-send-email-clabbe@baylibre.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1542717146-34917-1-git-send-email-clabbe@baylibre.com>
References: <1542717146-34917-1-git-send-email-clabbe@baylibre.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some error count use the wrong name for getting this data.
But this had not caused any reporting problem, since all error count are shared in the same
union.

Signed-off-by: Corentin Labbe <clabbe@baylibre.com>
---
 crypto/crypto_user_stat.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/crypto/crypto_user_stat.c b/crypto/crypto_user_stat.c
index 3c14be2f7a1b..838123758423 100644
--- a/crypto/crypto_user_stat.c
+++ b/crypto/crypto_user_stat.c
@@ -93,7 +93,7 @@ static int crypto_report_comp(struct sk_buff *skb, struct crypto_alg *alg)
 	rcomp.stat_decompress_cnt = v64;
 	v64 = atomic64_read(&alg->decompress_tlen);
 	rcomp.stat_decompress_tlen = v64;
-	v64 = atomic64_read(&alg->cipher_err_cnt);
+	v64 = atomic64_read(&alg->compress_err_cnt);
 	rcomp.stat_compress_err_cnt = v64;
 
 	return nla_put(skb, CRYPTOCFGA_STAT_COMPRESS, sizeof(rcomp), &rcomp);
@@ -115,7 +115,7 @@ static int crypto_report_acomp(struct sk_buff *skb, struct crypto_alg *alg)
 	racomp.stat_decompress_cnt = v64;
 	v64 = atomic64_read(&alg->decompress_tlen);
 	racomp.stat_decompress_tlen = v64;
-	v64 = atomic64_read(&alg->cipher_err_cnt);
+	v64 = atomic64_read(&alg->compress_err_cnt);
 	racomp.stat_compress_err_cnt = v64;
 
 	return nla_put(skb, CRYPTOCFGA_STAT_ACOMP, sizeof(racomp), &racomp);
@@ -222,7 +222,7 @@ static int crypto_report_rng(struct sk_buff *skb, struct crypto_alg *alg)
 	rrng.stat_generate_tlen = v64;
 	v64 = atomic64_read(&alg->seed_cnt);
 	rrng.stat_seed_cnt = v64;
-	v64 = atomic64_read(&alg->hash_err_cnt);
+	v64 = atomic64_read(&alg->rng_err_cnt);
 	rrng.stat_rng_err_cnt = v64;
 
 	return nla_put(skb, CRYPTOCFGA_STAT_RNG, sizeof(rrng), &rrng);
-- 
2.18.1

