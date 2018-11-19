Return-Path: <SRS0=tadO=N6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BC0BC43441
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 19:53:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 150512086A
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 19:53:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="A5a0kaCa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 150512086A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730612AbeKTGS4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Nov 2018 01:18:56 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:43386 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730087AbeKTGSz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Nov 2018 01:18:55 -0500
Received: by mail-wr1-f65.google.com with SMTP id r10so15827038wrs.10
        for <linux-kernel@vger.kernel.org>; Mon, 19 Nov 2018 11:53:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=iV/M8EbvN8TGuValOiY6W/51UjKDNEJVorUmBNxwOt4=;
        b=A5a0kaCamd7puQ3IQhqzNyGRLI0r9dWbNiiEA0+95daGbIySMj1K/dqH8m5oGomgdg
         9NdTQMQrsifveYvTwqESzqArGOaUi3JaMOPsiY+K2rlxXkHw+ftCAa+dDP9TvPjGBCqv
         OzieJSf/p9GBusTbO7wrCw4ZqmiMpQIOr+yfBJpLgPQvcjUUSUQ2WR2Le0Vyu/dTMgHQ
         NqKpvJ0Y+Hx2nFBvgeq7fDyKIAMolZHTvA48htjaWxaTdeJ09j2aEodiaEpZuaIZpZEl
         XRm4A+SmeUh3OdV0UwgZUdgFjBnpHIzwiPPd+WKQtsCTIOecI+gHgzlJmSVmkr2JFAsk
         ViKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=iV/M8EbvN8TGuValOiY6W/51UjKDNEJVorUmBNxwOt4=;
        b=e3AvqOWC8wn9jAHiMqXZ9QhYOBcV/qaY3lYoLHohgVoyg4GJ1NSWGxwzyEFFc6AubB
         EoQ4dy7gDdp3EswPyjcfT8pio27IzpNcnC3jU+SqDHgCN/Yeu1N1yIzTf+/F7r42K4AC
         hZtOOcrDg/b9hCNCI8CVF5XAylzHjim/8q9Lv1lCXgTtN+1HxN50qPzgrc/4oJXEcFAG
         iSKt3kV6M9FRTAsMDNhN408MM9G8zBwYMMDY1w3zXk3bX7skh97GJpE9xlCiSEQRL1Zt
         j5RID3Gb1kzkuFoKY3H4yeLYFrXnKTuIkb7ni5gOzYWGTsC4tIlj2fz0Qld0It7nsD11
         lT/Q==
X-Gm-Message-State: AA+aEWaAZwmHeU9WoP9KkOuL2oxTn7FO03XDxv/KhybbaEYHkKf7AmV7
        hvKZhdu4iQTmO7hMQbprfQ8ZwQ==
X-Google-Smtp-Source: AFSGD/W6rCLxq767chWSW6S0IxLwMgmutKcv+j0vs6sQY1ajHgybqZq+/0tiIVPg6R3gUrM7NUoVsw==
X-Received: by 2002:a5d:4382:: with SMTP id i2mr16119103wrq.172.1542657224173;
        Mon, 19 Nov 2018 11:53:44 -0800 (PST)
Received: from localhost.localdomain ([51.15.160.169])
        by smtp.googlemail.com with ESMTPSA id i16sm22954132wmd.28.2018.11.19.11.53.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 19 Nov 2018 11:53:43 -0800 (PST)
From:   Corentin Labbe <clabbe@baylibre.com>
To:     davem@davemloft.net, ebiggers@kernel.org,
        herbert@gondor.apana.org.au, nhorman@tuxdriver.com
Cc:     linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        Corentin Labbe <clabbe@baylibre.com>
Subject: [PATCH v2 08/11] crypto: crypto_user_stat: Fix invalid stat reporting
Date:   Mon, 19 Nov 2018 19:53:27 +0000
Message-Id: <1542657210-37739-9-git-send-email-clabbe@baylibre.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1542657210-37739-1-git-send-email-clabbe@baylibre.com>
References: <1542657210-37739-1-git-send-email-clabbe@baylibre.com>
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

