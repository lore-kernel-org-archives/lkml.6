Return-Path: <SRS0=Q/hc=JL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC0B9C43142
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 12:46:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A6C102597E
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 12:46:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U0mnyulq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A6C102597E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755450AbeFYMqH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Jun 2018 08:46:07 -0400
Received: from mail-pg0-f68.google.com ([74.125.83.68]:34207 "EHLO
        mail-pg0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751529AbeFYMqB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jun 2018 08:46:01 -0400
Received: by mail-pg0-f68.google.com with SMTP id y1-v6so419423pgv.1;
        Mon, 25 Jun 2018 05:46:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=13yXlQw6OltcuYWZwtKCe7PCGAvW0lIib2/SLO0mGM0=;
        b=U0mnyulqHv3PSZxri5z6Le1j5uVQkp9VNhIgsxUvyz1ZuaQ21D3w2zQCjqsv8ICL3p
         a+2oK7ULbZX/kSnWOl7hJWXpzSm0UJLyMBL54Ql91LiKZkYBx8NncvOlF8UWvy3MpI9+
         lIbhTOUEsiDguR4Acm6HH06xk2q2jmJJWb79sJRaMMNC+OfR6WSpdDsimIBWDYYXJKgm
         fWGLvNIN894jlgimHjyMnx5o8U3dQ2kBq3D4Bz+9L7TGRW7YRM9e5Iyx8RbSvIcxAzqN
         Jj0hudYbrfiZKaMTXlCNEXpdiU9kok+2PRSl8OKtkWq+qWNjusaeXDCnoWdf9tzRoj1n
         hM5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=13yXlQw6OltcuYWZwtKCe7PCGAvW0lIib2/SLO0mGM0=;
        b=P9L2sYTFUxag7pmUfXEz8NEfJkDo9yIa/bjYZcyZwH10C/L+e5VWzgurLll4BcMaVB
         wahl7TCAhS+Fm7cbebj5pUtRKTN1GU3Qu6r2QPwxj2ASYLKA41vSzxiW30uR+RPYm+WI
         NyssAgg9VOdRcZz7u7RW+WtEVECFxwgpRCNoywxveXdFTL/yl2Cwv2usocvjkgmqEJFu
         CBZmbPaUt1iqx5JmotA7s9VutLdO/Xxm/91Z2I/Cms3d9c9f7mGzUgmY6mN/Nm+GMrz5
         CT+eR0C4cXB4HkqSewTi4OKv0jm0+2DIH7LeEJSM9dPZPesTKJAs2Bv16c/rQvDvCLHx
         ShQw==
X-Gm-Message-State: APt69E2b09F6O69TXIuoYEnHXhwXZO9RVSbJIy0G0wxmO9/9l/Xx7o17
        yq/J+AbTovrUWQ8TQ+Q47oWeQWS/Xvk=
X-Google-Smtp-Source: ADUXVKLjofGJgYlSBnPgBiKgjVeB8B8l3tLALWXjrLjgpssmPbgX70p+4GSFisv8Erk0MWBob1GEPw==
X-Received: by 2002:a62:930c:: with SMTP id b12-v6mr12901222pfe.193.1529930760215;
        Mon, 25 Jun 2018 05:46:00 -0700 (PDT)
Received: from localhost (g134.124-44-9.ppp.wakwak.ne.jp. [124.44.9.134])
        by smtp.gmail.com with ESMTPSA id m12-v6sm2794431pgs.21.2018.06.25.05.45.59
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 25 Jun 2018 05:45:59 -0700 (PDT)
From:   Stafford Horne <shorne@gmail.com>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Greg KH <gregkh@linuxfoundation.org>, arnd@arndb.de,
        Eric Biggers <ebiggers3@gmail.com>,
        linux-crypto@vger.kernel.org, Stafford Horne <shorne@gmail.com>,
        Max Filippov <jcmvbkbc@gmail.com>,
        Nick Desaulniers <nick.desaulniers@gmail.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH v2 1/2] crypto: Fix -Wstringop-truncation warnings
Date:   Mon, 25 Jun 2018 21:45:37 +0900
Message-Id: <20180625124538.21051-2-shorne@gmail.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180625124538.21051-1-shorne@gmail.com>
References: <20180625124538.21051-1-shorne@gmail.com>
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
explicitly performing '\0' termination.

Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Max Filippov <jcmvbkbc@gmail.com>
Cc: Eric Biggers <ebiggers3@gmail.com>
Cc: Nick Desaulniers <nick.desaulniers@gmail.com>
Signed-off-by: Stafford Horne <shorne@gmail.com>
---
 crypto/ablkcipher.c | 2 ++
 crypto/blkcipher.c  | 1 +
 2 files changed, 3 insertions(+)

diff --git a/crypto/ablkcipher.c b/crypto/ablkcipher.c
index d880a4897159..1edb5000d783 100644
--- a/crypto/ablkcipher.c
+++ b/crypto/ablkcipher.c
@@ -373,6 +373,7 @@ static int crypto_ablkcipher_report(struct sk_buff *skb, struct crypto_alg *alg)
 	strncpy(rblkcipher.type, "ablkcipher", sizeof(rblkcipher.type));
 	strncpy(rblkcipher.geniv, alg->cra_ablkcipher.geniv ?: "<default>",
 		sizeof(rblkcipher.geniv));
+	rblkcipher.geniv[sizeof(rblkcipher.geniv) - 1] = '\0';
 
 	rblkcipher.blocksize = alg->cra_blocksize;
 	rblkcipher.min_keysize = alg->cra_ablkcipher.min_keysize;
@@ -447,6 +448,7 @@ static int crypto_givcipher_report(struct sk_buff *skb, struct crypto_alg *alg)
 	strncpy(rblkcipher.type, "givcipher", sizeof(rblkcipher.type));
 	strncpy(rblkcipher.geniv, alg->cra_ablkcipher.geniv ?: "<built-in>",
 		sizeof(rblkcipher.geniv));
+	rblkcipher.geniv[sizeof(rblkcipher.geniv) - 1] = '\0';
 
 	rblkcipher.blocksize = alg->cra_blocksize;
 	rblkcipher.min_keysize = alg->cra_ablkcipher.min_keysize;
diff --git a/crypto/blkcipher.c b/crypto/blkcipher.c
index 01c0d4aa2563..dd4dcab3766a 100644
--- a/crypto/blkcipher.c
+++ b/crypto/blkcipher.c
@@ -512,6 +512,7 @@ static int crypto_blkcipher_report(struct sk_buff *skb, struct crypto_alg *alg)
 	strncpy(rblkcipher.type, "blkcipher", sizeof(rblkcipher.type));
 	strncpy(rblkcipher.geniv, alg->cra_blkcipher.geniv ?: "<default>",
 		sizeof(rblkcipher.geniv));
+	rblkcipher.geniv[sizeof(rblkcipher.geniv) - 1] = '\0';
 
 	rblkcipher.blocksize = alg->cra_blocksize;
 	rblkcipher.min_keysize = alg->cra_blkcipher.min_keysize;
-- 
2.17.0

