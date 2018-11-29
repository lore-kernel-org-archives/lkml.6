Return-Path: <SRS0=8q1S=OI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95CDFC43441
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 14:42:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5D60F213A2
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 14:42:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="CKCWEtUu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5D60F213A2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388500AbeK3BsW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Nov 2018 20:48:22 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:44849 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388163AbeK3BsV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Nov 2018 20:48:21 -0500
Received: by mail-wr1-f68.google.com with SMTP id z5so2143477wrt.11
        for <linux-kernel@vger.kernel.org>; Thu, 29 Nov 2018 06:42:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=cBq7eG8tKizxp2XmG8rcRPCZ81p5cfYknd0CBmXioL4=;
        b=CKCWEtUulGPTqfxndJa6Spvt1bYqcvHuF1GuekUmG1k2FwovbsjDMWLhSMM/sr43vS
         g3EDfAjsgZyo4Qkvu6+3iUF5czfQyKQGbwbjjWL7tQZgVwRFLzSCxrE8y+f3TXrQz1Co
         od5Y2GL9tgdMbpC/9p7FP/V6x9mjDCwmCBHqZCfkJy+/FeuoZRYP02hhtd9CpeV32DZC
         2gAGI3saDZeNQ5i1KdATYn4R52BGXs59GYCyvWyJF+YuMCzuYoKl0iBGYVI0EwL1D5OL
         VwbSfcW6ekzDSBu2IxTdNBlm22wDWwgGFVPmUuEeCW+RmCQ8HJdvn53NibMD1w+P5Fkr
         Cxzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=cBq7eG8tKizxp2XmG8rcRPCZ81p5cfYknd0CBmXioL4=;
        b=uaxub0RaJ9fBQY/nPyL/Dty5tnSzeCA2binOf6qFNyKpOVLrQNTH5RFw+seX1U16AG
         s4wTVP9on/sWqdlNKxX1qH7u9bVtEhXBg7w3JWTugkBGOiQqdjnoo9cM2QYT9uaKFs+o
         vhp3L9/Uy8/vz13xLXVp6h6XATNQjlNfvZCykVo2JlRuMZVOJRUlaBCZIGQc3911jPe/
         C0aKdQ2oQUOpyCNyhWkiYIeiihRzzNCKl6uRs++BjJQZFUpC9nBGHi/E/mXbm8XBeipP
         a+L0HxaDHMTQhoqJPEX7ANcEaaBMtFV/i8UFwm/uPhyd9jU/HNlLHgacbCw0rCqqbV7X
         J9pA==
X-Gm-Message-State: AA+aEWbCBeSOyUvWY2pxbS7ueDTb1ZlduknvJY67QvfWXRE34M+DMEbq
        Jb9juNETonETB2P0itK48Uv10w==
X-Google-Smtp-Source: AFSGD/X/mLfsG7xxvxnr8Ytu3dCXde6ciUbx9ssd4JP3yx1ASSmJU4UhJXgIju5ijW3guvryPklELw==
X-Received: by 2002:adf:bb44:: with SMTP id x4mr1728206wrg.24.1543502564809;
        Thu, 29 Nov 2018 06:42:44 -0800 (PST)
Received: from localhost.localdomain ([51.15.160.169])
        by smtp.googlemail.com with ESMTPSA id t131sm875406wmt.1.2018.11.29.06.42.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 29 Nov 2018 06:42:44 -0800 (PST)
From:   Corentin Labbe <clabbe@baylibre.com>
To:     davem@davemloft.net, ebiggers@kernel.org,
        herbert@gondor.apana.org.au, nhorman@tuxdriver.com
Cc:     linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        Corentin Labbe <clabbe@baylibre.com>
Subject: [PATCH v5 11/11] crypto: crypto_user_stat: Add crypto_stats_init
Date:   Thu, 29 Nov 2018 14:42:26 +0000
Message-Id: <1543502546-23870-12-git-send-email-clabbe@baylibre.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1543502546-23870-1-git-send-email-clabbe@baylibre.com>
References: <1543502546-23870-1-git-send-email-clabbe@baylibre.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch add the crypto_stats_init() function.
This will permit to remove some ifdef from __crypto_register_alg().

Signed-off-by: Corentin Labbe <clabbe@baylibre.com>
---
 crypto/algapi.c        | 10 +++++++---
 include/linux/crypto.h |  3 +++
 2 files changed, 10 insertions(+), 3 deletions(-)

diff --git a/crypto/algapi.c b/crypto/algapi.c
index c0d4f9ef6b0f..8b65ada33e5d 100644
--- a/crypto/algapi.c
+++ b/crypto/algapi.c
@@ -258,9 +258,7 @@ static struct crypto_larval *__crypto_register_alg(struct crypto_alg *alg)
 	list_add(&alg->cra_list, &crypto_alg_list);
 	list_add(&larval->alg.cra_list, &crypto_alg_list);
 
-#ifdef CONFIG_CRYPTO_STATS
-	memset(&alg->stats, 0, sizeof(alg->stats));
-#endif
+	crypto_stats_init(alg);
 
 out:
 	return larval;
@@ -1073,6 +1071,12 @@ int crypto_type_has_alg(const char *name, const struct crypto_type *frontend,
 EXPORT_SYMBOL_GPL(crypto_type_has_alg);
 
 #ifdef CONFIG_CRYPTO_STATS
+void crypto_stats_init(struct crypto_alg *alg)
+{
+	memset(&alg->stats, 0, sizeof(alg->stats));
+}
+EXPORT_SYMBOL_GPL(crypto_stats_init);
+
 void crypto_stats_get(struct crypto_alg *alg)
 {
 	crypto_alg_get(alg);
diff --git a/include/linux/crypto.h b/include/linux/crypto.h
index a2967c1a08b1..9850b41e38ae 100644
--- a/include/linux/crypto.h
+++ b/include/linux/crypto.h
@@ -614,6 +614,7 @@ struct crypto_alg {
 } CRYPTO_MINALIGN_ATTR;
 
 #ifdef CONFIG_CRYPTO_STATS
+void crypto_stats_init(struct crypto_alg *alg);
 void crypto_stats_get(struct crypto_alg *alg);
 void crypto_stats_ablkcipher_encrypt(unsigned int nbytes, int ret, struct crypto_alg *alg);
 void crypto_stats_ablkcipher_decrypt(unsigned int nbytes, int ret, struct crypto_alg *alg);
@@ -635,6 +636,8 @@ void crypto_stats_rng_generate(struct crypto_alg *alg, unsigned int dlen, int re
 void crypto_stats_skcipher_encrypt(unsigned int cryptlen, int ret, struct crypto_alg *alg);
 void crypto_stats_skcipher_decrypt(unsigned int cryptlen, int ret, struct crypto_alg *alg);
 #else
+static inline void crypto_stats_init(struct crypto_alg *alg)
+{}
 static inline void crypto_stats_get(struct crypto_alg *alg)
 {}
 static inline void crypto_stats_ablkcipher_encrypt(unsigned int nbytes, int ret, struct crypto_alg *alg)
-- 
2.18.1

