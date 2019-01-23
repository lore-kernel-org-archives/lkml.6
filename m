Return-Path: <SRS0=drEb=P7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 863DBC282C0
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 11:24:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5210020870
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 11:24:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="JLGl0iAe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727310AbfAWLY0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Jan 2019 06:24:26 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:41637 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727095AbfAWLYZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Jan 2019 06:24:25 -0500
Received: by mail-wr1-f65.google.com with SMTP id x10so1967812wrs.8
        for <linux-kernel@vger.kernel.org>; Wed, 23 Jan 2019 03:24:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id;
        bh=frm1VMyBnwXapbVBQbQmtvxrwaLvFY7ynrwmcgx7S7s=;
        b=JLGl0iAeOUU+TIcS3Vzyq+6mVgLKfDpL3r3dLjdvaraayP6CXatZ/Cb9qMUcGug1lJ
         iOcggUMj+X2ISBQ5rff5DKJpqbtiIf+ztyJAmZ6vDWXhBpmTaruUg8ZRXebcOe4+fBrM
         bQtAzsREYNSG4Cwm7lVOfbvRKRjtuqoNY0olMTg4eMZdM/ouG+Fv7ty07oMbRT1sR3ic
         QJv6D8+JhkztbHhTNX89fsxrh9dYXtkdY0ltAfpSvqkm6JJhcaM7W2WBJUYMvhhhQOBE
         ccsBVEqn0dzgey7NmvwbYcWJ2yub2JBB/mH5FVd8AfEX4DZUKhuOTMhUiBhznyjzH6zh
         Lsyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=frm1VMyBnwXapbVBQbQmtvxrwaLvFY7ynrwmcgx7S7s=;
        b=ZoPMEU5wXpWhnuaKvXjwEuUxuWdiAOD7PvHNjAM7L8CaVExQ8oh0l21eXzldvJI45c
         LrWIoQ/3liNuIsReY/q4z5/nCFAs7yMPCdwM5pOclMnIWTnxwV3Orty3tWI9aaXy+E8G
         iz9MnAkeQSXkNdITHq9dKIHhw5Wp4XqXatMrMZdDowRvekEPQQczQZOel/+NBKMUUQce
         SboCiFktFln9kuJToooYbY35h7x/ebU4IDUq34eIiceFsxv8n09qxN5YI0eGLNA+Oii1
         +rVKBOuyBBi9L1RlEvQdKF6TyEcoej1toDlU6Gb579G/xqKPzhNfgLQ6c5r/4rgol+ec
         decw==
X-Gm-Message-State: AJcUuke7ZGP+7+qxE9W3iuZWqm2w6Yq8P0StZn/JxScWz5pWiJRByNGY
        94swb0nIXTBqvtVjEOwvLIVYcA==
X-Google-Smtp-Source: ALg8bN4g1YD2yMw+RWTqZYR58gMX4n1e5IMCzBI44sUFfnmku5zD59o6heVNbdwWxCwoW+me6ER+zg==
X-Received: by 2002:a5d:6244:: with SMTP id m4mr2237935wrv.314.1548242663996;
        Wed, 23 Jan 2019 03:24:23 -0800 (PST)
Received: from localhost.localdomain ([51.15.160.169])
        by smtp.googlemail.com with ESMTPSA id m6sm75939095wrv.24.2019.01.23.03.24.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 23 Jan 2019 03:24:23 -0800 (PST)
From:   Corentin Labbe <clabbe@baylibre.com>
To:     chunkeey@googlemail.com, davem@davemloft.net,
        herbert@gondor.apana.org.au
Cc:     linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        Corentin Labbe <clabbe@baylibre.com>
Subject: [PATCH] crypto4xx: Fix wrong ppc4xx_trng_probe()/ppc4xx_trng_remove() arguments
Date:   Wed, 23 Jan 2019 11:24:18 +0000
Message-Id: <1548242658-9395-1-git-send-email-clabbe@baylibre.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When building without CONFIG_HW_RANDOM_PPC4XX, I hit the following build failure:
drivers/crypto/amcc/crypto4xx_core.c: In function 'crypto4xx_probe':
drivers/crypto/amcc/crypto4xx_core.c:1407:20: error: passing argument 1 of 'ppc4xx_trng_probe' from incompatible pointer type [-Werror=incompatible-pointer-types]
In file included from drivers/crypto/amcc/crypto4xx_core.c:50:0:
drivers/crypto/amcc/crypto4xx_trng.h:28:20: note: expected 'struct crypto4xx_device *' but argument is of type 'struct crypto4xx_core_device *'
drivers/crypto/amcc/crypto4xx_core.c: In function 'crypto4xx_remove':
drivers/crypto/amcc/crypto4xx_core.c:1434:21: error: passing argument 1 of 'ppc4xx_trng_remove' from incompatible pointer type [-Werror=incompatible-pointer-types]
In file included from drivers/crypto/amcc/crypto4xx_core.c:50:0:
drivers/crypto/amcc/crypto4xx_trng.h:30:20: note: expected 'struct crypto4xx_device *' but argument is of type 'struct crypto4xx_core_device *'

This patch fix the needed argument of ppc4xx_trng_probe()/ppc4xx_trng_remove() in that case.

Fixes: 5343e674f32f ("crypto4xx: integrate ppc4xx-rng into crypto4xx")
Signed-off-by: Corentin Labbe <clabbe@baylibre.com>
---
 drivers/crypto/amcc/crypto4xx_trng.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/crypto/amcc/crypto4xx_trng.h b/drivers/crypto/amcc/crypto4xx_trng.h
index 931d22531f51..7bbda51b7337 100644
--- a/drivers/crypto/amcc/crypto4xx_trng.h
+++ b/drivers/crypto/amcc/crypto4xx_trng.h
@@ -26,9 +26,9 @@ void ppc4xx_trng_probe(struct crypto4xx_core_device *core_dev);
 void ppc4xx_trng_remove(struct crypto4xx_core_device *core_dev);
 #else
 static inline void ppc4xx_trng_probe(
-	struct crypto4xx_device *dev __maybe_unused) { }
+	struct crypto4xx_core_device *dev __maybe_unused) { }
 static inline void ppc4xx_trng_remove(
-	struct crypto4xx_device *dev __maybe_unused) { }
+	struct crypto4xx_core_device *dev __maybe_unused) { }
 #endif
 
 #endif
-- 
2.19.2

