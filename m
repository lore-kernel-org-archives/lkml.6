Return-Path: <SRS0=hmx+=JJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43761C43144
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Jun 2018 02:08:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F11C724AAF
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Jun 2018 02:08:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="n8NVHaep"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F11C724AAF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934649AbeFWCI0 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Jun 2018 22:08:26 -0400
Received: from mail-pl0-f66.google.com ([209.85.160.66]:37158 "EHLO
        mail-pl0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934307AbeFWCIX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jun 2018 22:08:23 -0400
Received: by mail-pl0-f66.google.com with SMTP id 31-v6so4266528plc.4;
        Fri, 22 Jun 2018 19:08:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Fqn2rQQxHfn+5uvFZawePFNkUxNVmG8vEiH2xK/JkQg=;
        b=n8NVHaepLmMEIoIxzGnPiEmqYMsccFPZ5Vae5hHe58aJPDYcwIR7Aq528wWAiF6LHu
         Yvjoc2nr8YDoeaXgRj8ING9NdXd7OziaBPxszXg0RuN6At09J/Qzh00xFeNDdrEnW7Pm
         4HdtgU0SqbrjRfbxvQBNtRXRWTO0G5cf62C5vZXwnfBFFwwOhTk9QbawDulblb1in3Qt
         Qe1njd/6+3uL04bEreraEJqMC3ulQAWutsDwpOjqIS0xr042CgYhecxjD1pI5/wrM+Gt
         oA5+NJ/FXWSV19DeBB3FiBMI7aRwk+Zoi8RJIOjZcpU+oqNcQa9Qljs3F1NkLNFq8U8G
         IV/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Fqn2rQQxHfn+5uvFZawePFNkUxNVmG8vEiH2xK/JkQg=;
        b=X8v+PubAlNz3SP3ulw9yx1YldVj6zDLDyd7yhZoKGCzLgEE6bKklmqvXVUaqUvWAd/
         sL9CDsTUxCQAL6Rg09DaOmdS/ryc2VbGv9vVZY/57ceFF+ZqyhWTpAjkElxm4OYh8gdP
         l05R83WMommcewycjBtDY+ydvG8Y2tNcWevobWtRllum6vzszB/vyKmyh8TrqgUO+Hum
         CXIPktEOYpah1iqIULaEi3wLdYtMH9Fcpw9h+Jv9Gcmu+EtLvzMej15YbMuuXlC9EiJy
         auIwNjIh9TSQ++8V0Zq1oaEzu3Eet6mttBmwV0XLXXVCyvy15UdXxfLRRnwe0XWxvvw/
         ka3g==
X-Gm-Message-State: APt69E0celhVbJO6Jwweou9/uRWThJqAPh7bGQWkCk0OyjhMIHNBKxO/
        SSgO3rA1PZJPaamrzEcSVKU2uQBX
X-Google-Smtp-Source: ADUXVKJ/7rBmn2rPkWdouDV4XHfXAjAaL2qLGHjarvrD4HMV/RW5yX3orClPnyIvCTKOivUP9juYKA==
X-Received: by 2002:a17:902:bd95:: with SMTP id q21-v6mr3797708pls.237.1529719702336;
        Fri, 22 Jun 2018 19:08:22 -0700 (PDT)
Received: from localhost (g134.124-44-9.ppp.wakwak.ne.jp. [124.44.9.134])
        by smtp.gmail.com with ESMTPSA id j10-v6sm19730503pfj.158.2018.06.22.19.08.21
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 22 Jun 2018 19:08:21 -0700 (PDT)
From:   Stafford Horne <shorne@gmail.com>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Greg KH <gregkh@linuxfoundation.org>, arnd@arndb.de,
        linux-crypto@vger.kernel.org, Stafford Horne <shorne@gmail.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>
Subject: [RFC PATCH 1/2] crypto: Fix -Wstringop-truncation warnings
Date:   Sat, 23 Jun 2018 11:07:52 +0900
Message-Id: <20180623020753.27266-2-shorne@gmail.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180623020753.27266-1-shorne@gmail.com>
References: <20180623020753.27266-1-shorne@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As of GCC 9.0.0 the build is reporting warnings like:

    crypto/ablkcipher.c: In function ‘crypto_ablkcipher_report’:
    crypto/ablkcipher.c:374:2: warning: ‘strncpy’ specified bound 64 equals destination size [-Wstringop-truncation]
      strncpy(rblkcipher.geniv, alg->cra_ablkcipher.geniv ?: "<default>",
      ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
       sizeof(rblkcipher.geniv));
       ~~~~~~~~~~~~~~~~~~~~~~~~~

This means the strnycpy might create a non null terminated string.  Fix this by
limiting the size of the string copy to include the null terminator.

Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Stafford Horne <shorne@gmail.com>
---
 crypto/ablkcipher.c | 4 ++--
 crypto/blkcipher.c  | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/crypto/ablkcipher.c b/crypto/ablkcipher.c
index d880a4897159..972cd7c879f6 100644
--- a/crypto/ablkcipher.c
+++ b/crypto/ablkcipher.c
@@ -372,7 +372,7 @@ static int crypto_ablkcipher_report(struct sk_buff *skb, struct crypto_alg *alg)
 
 	strncpy(rblkcipher.type, "ablkcipher", sizeof(rblkcipher.type));
 	strncpy(rblkcipher.geniv, alg->cra_ablkcipher.geniv ?: "<default>",
-		sizeof(rblkcipher.geniv));
+		sizeof(rblkcipher.geniv) - 1);
 
 	rblkcipher.blocksize = alg->cra_blocksize;
 	rblkcipher.min_keysize = alg->cra_ablkcipher.min_keysize;
@@ -446,7 +446,7 @@ static int crypto_givcipher_report(struct sk_buff *skb, struct crypto_alg *alg)
 
 	strncpy(rblkcipher.type, "givcipher", sizeof(rblkcipher.type));
 	strncpy(rblkcipher.geniv, alg->cra_ablkcipher.geniv ?: "<built-in>",
-		sizeof(rblkcipher.geniv));
+		sizeof(rblkcipher.geniv) - 1);
 
 	rblkcipher.blocksize = alg->cra_blocksize;
 	rblkcipher.min_keysize = alg->cra_ablkcipher.min_keysize;
diff --git a/crypto/blkcipher.c b/crypto/blkcipher.c
index 01c0d4aa2563..f1644b5cf68c 100644
--- a/crypto/blkcipher.c
+++ b/crypto/blkcipher.c
@@ -511,7 +511,7 @@ static int crypto_blkcipher_report(struct sk_buff *skb, struct crypto_alg *alg)
 
 	strncpy(rblkcipher.type, "blkcipher", sizeof(rblkcipher.type));
 	strncpy(rblkcipher.geniv, alg->cra_blkcipher.geniv ?: "<default>",
-		sizeof(rblkcipher.geniv));
+		sizeof(rblkcipher.geniv) - 1);
 
 	rblkcipher.blocksize = alg->cra_blocksize;
 	rblkcipher.min_keysize = alg->cra_blkcipher.min_keysize;
-- 
2.17.0

