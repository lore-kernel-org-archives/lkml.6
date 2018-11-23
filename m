Return-Path: <SRS0=aB5v=OC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D01C5C43441
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Nov 2018 12:02:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 93D9F20864
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Nov 2018 12:02:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="Kl4FGvWo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 93D9F20864
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2504024AbeKWWqn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 23 Nov 2018 17:46:43 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:55219 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2503995AbeKWWqm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Nov 2018 17:46:42 -0500
Received: by mail-wm1-f66.google.com with SMTP id r63-v6so11737972wma.4
        for <linux-kernel@vger.kernel.org>; Fri, 23 Nov 2018 04:02:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=iV/M8EbvN8TGuValOiY6W/51UjKDNEJVorUmBNxwOt4=;
        b=Kl4FGvWoBd82PLwIwBWvCH8SRj6fk0MCu+ui3PkxT79ZVqrN44XElPNj6jOIvd86HD
         +FkTi4KrIc9suazwaw4w1v7mYBxuk8WL0eSJwsULltIIJdGkpbZlgFGgoctBOLZniK9Z
         K8mbU5Z6oeVzXtD+2kMOMtYkX86axTs0xPIKlgV7LPKFYME2Jk7gPDm8U8jRORUhtQm0
         xlbb16HnNCzywgYx0/if7RTxDmhEAeUAj6IB0ELWLRj7CF4cIhaxs1GB9JR1M2r2NiQ0
         04W+6/nWCnJdhVek/vGgItECMvjjlcI3dmsdagvnBYvh+O17Q+bXGz7cz4Rh/+4zbqhS
         vgUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=iV/M8EbvN8TGuValOiY6W/51UjKDNEJVorUmBNxwOt4=;
        b=EF6kY7RhOqD+nxrlz1suLxEO8aWFmtOEZMexpCJddWnGdgD4RI1MPPdg53QS78PGfu
         3MW4omnL0/RN5ggjRAqWyjJwxdO3sXV67oFz7v6GKStFqZg5fuZX5cWynAhqwh9H3qyY
         +Wcv44I6TA1rDE2OYmGkB5ODx0muUUhu25Rh84la7VUF6HpiB/7MkG1sl0wJyBdAPlzg
         bbQxjcuRgjfRNzxcIch9lC7la66aIlY2vldy/OxA45y7MzJX3elgc8hMb5lwabsVr77t
         IKXVy21qPE7H2iD6mjcjEMSe7qA4ke7z5KvTJ+4ncy7tbbR194WXgTLDZmyQJhW0j9k/
         Y8iQ==
X-Gm-Message-State: AA+aEWZvTscTkuyXBDoRWijYOAHSNH/LnyAczKNhWyUMzSytQS6dNkxT
        qe8yd/4G6Dd22SJE6B4AVqieej1cj+A=
X-Google-Smtp-Source: AFSGD/WKPKfti6HTVbk/XeeLyS1SFiBE89bkFVuophzZ16oTcIOWMN4gidCxnaQyYL8S5PlQ+lTqiA==
X-Received: by 2002:a7b:ce11:: with SMTP id m17mr7197147wmc.74.1542974563638;
        Fri, 23 Nov 2018 04:02:43 -0800 (PST)
Received: from localhost.localdomain ([51.15.160.169])
        by smtp.googlemail.com with ESMTPSA id a18sm25164379wrp.13.2018.11.23.04.02.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 23 Nov 2018 04:02:42 -0800 (PST)
From:   Corentin Labbe <clabbe@baylibre.com>
To:     davem@davemloft.net, ebiggers@kernel.org,
        herbert@gondor.apana.org.au, nhorman@tuxdriver.com
Cc:     linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        Corentin Labbe <clabbe@baylibre.com>
Subject: [PATCH v4 07/11] crypto: crypto_user_stat: Fix invalid stat reporting
Date:   Fri, 23 Nov 2018 12:02:17 +0000
Message-Id: <1542974541-23024-8-git-send-email-clabbe@baylibre.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1542974541-23024-1-git-send-email-clabbe@baylibre.com>
References: <1542974541-23024-1-git-send-email-clabbe@baylibre.com>
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

