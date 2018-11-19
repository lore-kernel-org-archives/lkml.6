Return-Path: <SRS0=tadO=N6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38A62C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 19:53:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 04BFD20831
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 19:53:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="O41se4Hn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 04BFD20831
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730516AbeKTGSt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Nov 2018 01:18:49 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:40379 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730018AbeKTGSs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Nov 2018 01:18:48 -0500
Received: by mail-wm1-f66.google.com with SMTP id q26so6461243wmf.5
        for <linux-kernel@vger.kernel.org>; Mon, 19 Nov 2018 11:53:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=SUhn6ll/JtrCSQiWAzUXFknZ+uLXu9qskXJMh5DKybQ=;
        b=O41se4Hn2yhz8mZzd+C2ySX+tkXa1tvdJ8wmno6P2FvOetGJNmN6ouNQ399IX7/z4C
         0d8xUO6+/yyoOfEyragu4+B/eIx6klVAu8m4fT+1ctlK1CCIlk/GALMO0wpqldddvjRo
         Qu6DAANWJLKLjeHRLEFlFuMR1CdQy3wgOxIDY9uO8MPzbQsTBbu2v/7qzwnvRUCGpk/o
         Qgsj2WrC1nZgNvLoNTlKpuaoLSCmjQFZw9pLv+glTc9craJBdRuByJnDoOM3LTg44uw3
         uEFB+uaf+OX29Q87FauiHKkHk3g6EhQSrq2fYwLHf582ggvCgh5+FGlh27O20lcUlj3W
         w2uQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=SUhn6ll/JtrCSQiWAzUXFknZ+uLXu9qskXJMh5DKybQ=;
        b=hNGOBng5DjLTLbSmK8ZHXABj9LTs7hO5SWn01Pao/h6ZJF9DPhUOe2Og5lxeZKpZc6
         jqwNJRtqCksereMyfXqZwahW8HHHAqCw3fp3yRpewelnDL77FJ1NWjdgqv7IE6P7SaQH
         HFfnUpzWVnGOXZEbhabJ+o8N4pbAZOApHvY+zUXQaBU0OaKxLK99UZVEgSPLZXBPtWs0
         HDOw/MzJ/c3G5mBH2ofmX0maSOFfA9v7tLh74Kwez1uqPXr5WE3ZXcjyupZ63ffyBONj
         ZvtU5+yBS4ZPOP8QmnZcnsskONmSsQiCrKxhWPbm7DbOZtVriVCuqZszp/FRGfIu5JFk
         e1SQ==
X-Gm-Message-State: AA+aEWafItz/NKOtPagxxq5/gWtVzo6mXxEJi82loRTJ12X8dZv0pW22
        +ogfaS9AXoRLwOnizqcXmHIpXQ==
X-Google-Smtp-Source: AJdET5fMyL9ndsMCUSHOgGxJNZIM8E+aBvjIuonzmMqwNk1J/xtiNk645BYsaHRZoWCuZKVSnvABQA==
X-Received: by 2002:a1c:1f43:: with SMTP id f64mr4312141wmf.64.1542657217537;
        Mon, 19 Nov 2018 11:53:37 -0800 (PST)
Received: from localhost.localdomain ([51.15.160.169])
        by smtp.googlemail.com with ESMTPSA id i16sm22954132wmd.28.2018.11.19.11.53.36
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 19 Nov 2018 11:53:36 -0800 (PST)
From:   Corentin Labbe <clabbe@baylibre.com>
To:     davem@davemloft.net, ebiggers@kernel.org,
        herbert@gondor.apana.org.au, nhorman@tuxdriver.com
Cc:     linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        Corentin Labbe <clabbe@baylibre.com>
Subject: [PATCH v2 01/11] crypto: move crypto_alg_get/crypto_alg_put to linux/crypto.h
Date:   Mon, 19 Nov 2018 19:53:20 +0000
Message-Id: <1542657210-37739-2-git-send-email-clabbe@baylibre.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1542657210-37739-1-git-send-email-clabbe@baylibre.com>
References: <1542657210-37739-1-git-send-email-clabbe@baylibre.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since we will need crypto_alg_get/crypto_alg_put for "locking"
crypto_alg when updating stats, we need it to be via linux/crypto.h

Signed-off-by: Corentin Labbe <clabbe@baylibre.com>
---
 crypto/internal.h      | 12 ------------
 include/linux/crypto.h | 12 ++++++++++++
 2 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/crypto/internal.h b/crypto/internal.h
index ef769b5e8ad3..d81f033aeb5c 100644
--- a/crypto/internal.h
+++ b/crypto/internal.h
@@ -91,18 +91,6 @@ unsigned int crypto_alg_extsize(struct crypto_alg *alg);
 int crypto_type_has_alg(const char *name, const struct crypto_type *frontend,
 			u32 type, u32 mask);
 
-static inline struct crypto_alg *crypto_alg_get(struct crypto_alg *alg)
-{
-	refcount_inc(&alg->cra_refcnt);
-	return alg;
-}
-
-static inline void crypto_alg_put(struct crypto_alg *alg)
-{
-	if (refcount_dec_and_test(&alg->cra_refcnt) && alg->cra_destroy)
-		alg->cra_destroy(alg);
-}
-
 static inline int crypto_tmpl_get(struct crypto_template *tmpl)
 {
 	return try_module_get(tmpl->module);
diff --git a/include/linux/crypto.h b/include/linux/crypto.h
index 3634ad6fe202..ac8f4168a831 100644
--- a/include/linux/crypto.h
+++ b/include/linux/crypto.h
@@ -607,6 +607,18 @@ int crypto_unregister_algs(struct crypto_alg *algs, int count);
  */
 int crypto_has_alg(const char *name, u32 type, u32 mask);
 
+static inline struct crypto_alg *crypto_alg_get(struct crypto_alg *alg)
+{
+	refcount_inc(&alg->cra_refcnt);
+	return alg;
+}
+
+static inline void crypto_alg_put(struct crypto_alg *alg)
+{
+	if (refcount_dec_and_test(&alg->cra_refcnt) && alg->cra_destroy)
+		alg->cra_destroy(alg);
+}
+
 /*
  * Transforms: user-instantiated objects which encapsulate algorithms
  * and core processing logic.  Managed via crypto_alloc_*() and
-- 
2.18.1

