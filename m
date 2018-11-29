Return-Path: <SRS0=8q1S=OI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7E5CC43441
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 14:44:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 92C9F20673
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 14:44:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="EZKclkcI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 92C9F20673
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387906AbeK3Bth (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Nov 2018 20:49:37 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:42362 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388155AbeK3BsR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Nov 2018 20:48:17 -0500
Received: by mail-wr1-f66.google.com with SMTP id q18so2156955wrx.9
        for <linux-kernel@vger.kernel.org>; Thu, 29 Nov 2018 06:42:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=iV/M8EbvN8TGuValOiY6W/51UjKDNEJVorUmBNxwOt4=;
        b=EZKclkcIg9CYEkoPTu7sIoWZGAueSY9R6zJ/j1l317hooPMp2n5beQBYdP508+ST/c
         tm0oaQOCDgDvAs0HUPDBtSJyHnsz+ysc8sQi9CIA99J8LFG+/q5i9sICNKNyMtXgJ/+f
         V/K3MP/tUqT9vbo2ezKS38pTBjNUJtClBqKUxurzJ6qtzfk9wzacsZBX46gobJCqHUf/
         eNW7sB7XLbH8CbJqnnyZ00NsGG6QY8tuh7mmliteMHX/cuhZyMpe2Q1lDPdGUU+IrmFx
         OV1ZyLeGNDgl43WbkSuXJ6UFWVeKluN1m6fnLGfyVoPw6n7A1FXswMBCr7y5EBajeeEs
         QtBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=iV/M8EbvN8TGuValOiY6W/51UjKDNEJVorUmBNxwOt4=;
        b=WNNfPNwdKM7sRSHm7jO37nkF3hAJrpH5ovjn0ENOJTpb10mUCWXWFqHb6NhWzOr96I
         /tbxO0yZaQ+KudQ/6lVw7haEWELrIGKF/l8TIP27gc5O6X7IPm0IGRQQQugOThgAWxzz
         lJ1oxbrKAiRvwYN0dvI0jgNo1GEFnZemFyrHH9BMWbR2Afu7P0+xGbwSQySxvTu+/T0w
         YGVYKyQPTtO/0aOZ7Uqh+lDiULY3VM+2ZCxoa19385qk0lrUVkF+RZDx/ew3Ww+mebKm
         xyp4VTuzF9fQxQYhkmECZ+lqmytqMfVA9tkCmMcAuA8RJA6fQ3Oy7EC1YV+4Ei8K6gOL
         /+Ww==
X-Gm-Message-State: AA+aEWb+TzcS+8utHkkVTq5UK1GiIUVJa8M4dMxt8dJq8ID7GET0K6lm
        iFE1M7BNa68veay9obrAp1QcIQ==
X-Google-Smtp-Source: AFSGD/UFoFx5vXv6veaLQmsLBGgvlh+XqIoI73Fxb/TsQmmfCdQOvCUcjWpnWxN6H9Jy0YKZcS4Jzg==
X-Received: by 2002:adf:e488:: with SMTP id i8mr1746046wrm.10.1543502560975;
        Thu, 29 Nov 2018 06:42:40 -0800 (PST)
Received: from localhost.localdomain ([51.15.160.169])
        by smtp.googlemail.com with ESMTPSA id t131sm875406wmt.1.2018.11.29.06.42.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 29 Nov 2018 06:42:40 -0800 (PST)
From:   Corentin Labbe <clabbe@baylibre.com>
To:     davem@davemloft.net, ebiggers@kernel.org,
        herbert@gondor.apana.org.au, nhorman@tuxdriver.com
Cc:     linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        Corentin Labbe <clabbe@baylibre.com>
Subject: [PATCH v5 07/11] crypto: crypto_user_stat: Fix invalid stat reporting
Date:   Thu, 29 Nov 2018 14:42:22 +0000
Message-Id: <1543502546-23870-8-git-send-email-clabbe@baylibre.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1543502546-23870-1-git-send-email-clabbe@baylibre.com>
References: <1543502546-23870-1-git-send-email-clabbe@baylibre.com>
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

