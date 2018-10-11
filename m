Return-Path: <SRS0=bA34=MX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1333DC677FC
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 20:31:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B0E6220644
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 20:31:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="WBlsMmHN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B0E6220644
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725902AbeJLEAd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Oct 2018 00:00:33 -0400
Received: from mail-io1-f74.google.com ([209.85.166.74]:51440 "EHLO
        mail-io1-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725742AbeJLEAc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Oct 2018 00:00:32 -0400
Received: by mail-io1-f74.google.com with SMTP id z9-v6so6898992iog.18
        for <linux-kernel@vger.kernel.org>; Thu, 11 Oct 2018 13:31:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=eECGZ7zgHaOkyIeJc2S18LiRW9XEEqnkBBRxWwCTjgc=;
        b=WBlsMmHNlunZU5eyzxqxwQfehc/iOHgjBTalkbbOiIANwYXW5ZYDoMZdyfK5y14rRI
         M5+bmDl7CqpoTnuVRmLtqHJNcEztJqawA8IHLMNk37ULeFkfnmECnpZ4Du/J7cWEbHNj
         cEdCfBkY96PlR2ZN3eiJ3pcuuO18yY9+0UiVLZ/i7N8f8oVkypcIoCcuf8FueNBe4ntJ
         gEhNOw5uKV8WR9jVQi6GpH25RLqNM8bfOlKeN6/kN4ojVcP+7yEstVbjEUs4iqXT8wrE
         y+drHO0TIvD+nWD0ti/wx4vZKhmgWiWxN/y/m/+5TXuI9GgcGIEyLPkf3XarMfacIG6S
         Vh+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=eECGZ7zgHaOkyIeJc2S18LiRW9XEEqnkBBRxWwCTjgc=;
        b=KpQn26t0EUwFGv6ARH+gGDYD4KfyrcOPJf8vCjWDhfo35N+SRUNt0Rv2kZm5vWg6rA
         pO866SAtsUjkpoMRTu2xlRDEMn9hfp8QaqvGPYaFWSc938riIrfn0lC41/KGfDT4bkcl
         khuc2dQhgYkxuOFAwa9Owm2tENL4Me2zDN3q/mD4xWi8P/Uem1WtBJ7H4erxNQRYCImu
         TF5PLnTCKYsuFDU/uAEugMB7FNUZmrUL5reM60c6r08EwDyjagRU+qDAGdiH59i0KKgQ
         8MQwNQKH51rFh/AjeRsE3OT147VWB8V3K1RvWlUpWi6dYdQKVmbpk1zKjHt81qzO46v7
         VJug==
X-Gm-Message-State: ABuFfoiK7yPFDl5R8AaptPw6pkWj4NZVqpwp0QZHsY4DVGnecVVSEQWD
        7NXyKrHJn2Km5hTsBY7YhMxeqkMDNLM6KpZEGxs=
X-Google-Smtp-Source: ACcGV60FxIyjqcG0qVQ/kIO/WL1FMP3WGHNkZdx1fa3V46efJSJ6CaZbWea5IP7f/6PgwfmHpBiLKQcLDR19n0Cdtlc=
X-Received: by 2002:a24:dd45:: with SMTP id t66-v6mr5776020itf.5.1539289898802;
 Thu, 11 Oct 2018 13:31:38 -0700 (PDT)
Date:   Thu, 11 Oct 2018 13:31:26 -0700
In-Reply-To: <1539274203.2623.56.camel@linux.vnet.ibm.com>
Message-Id: <20181011203126.15338-1-ndesaulniers@google.com>
Mime-Version: 1.0
References: <1539274203.2623.56.camel@linux.vnet.ibm.com>
X-Mailer: git-send-email 2.19.0.605.g01d371f741-goog
Subject: [PATCH] KEYS: trusted: fix -Wvarags warning
From:   ndesaulniers@google.com
To:     jejb@linux.vnet.ibm.com, dhowells@redhat.com
Cc:     natechancellor@gmail.com, ebiggers@google.com,
        Nick Desaulniers <ndesaulniers@google.com>,
        Mimi Zohar <zohar@linux.vnet.ibm.com>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        linux-integrity@vger.kernel.org, keyrings@vger.kernel.org,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

by swapping h2 and h3.

security/keys/trusted.c:146:17: warning: passing an object that
undergoes default
      argument promotion to 'va_start' has undefined behavior [-Wvarargs]
        va_start(argp, h3);
                       ^
security/keys/trusted.c:126:37: note: parameter of type 'unsigned
char' is declared here
unsigned char *h2, unsigned char h3, ...)
                               ^

Specifically, it seems that both the C90 (4.8.1.1) and C11 (7.16.1.4)
standards explicitly call this out as undefined behavior:

The parameter parmN is the identifier of the rightmost parameter in
the variable parameter list in the function definition (the one just
before the ...). If the parameter parmN is declared with ... or with a
type that is not compatible with the type that results after
application of the default argument promotions, the behavior is
undefined.

Link: https://github.com/ClangBuiltLinux/linux/issues/41
Suggested-by: James Bottomley <jejb@linux.vnet.ibm.com>
Signed-off-by: Nick Desaulniers <ndesaulniers@google.com>
---
 security/keys/trusted.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/security/keys/trusted.c b/security/keys/trusted.c
index b69d3b1777c2..d425b2b839af 100644
--- a/security/keys/trusted.c
+++ b/security/keys/trusted.c
@@ -123,7 +123,7 @@ static int TSS_rawhmac(unsigned char *digest, const unsigned char *key,
  */
 static int TSS_authhmac(unsigned char *digest, const unsigned char *key,
 			unsigned int keylen, unsigned char *h1,
-			unsigned char *h2, unsigned char h3, ...)
+			unsigned char h2, unsigned char *h3, ...)
 {
 	unsigned char paramdigest[SHA1_DIGEST_SIZE];
 	struct sdesc *sdesc;
@@ -139,7 +139,7 @@ static int TSS_authhmac(unsigned char *digest, const unsigned char *key,
 		return PTR_ERR(sdesc);
 	}
 
-	c = h3;
+	c = h2;
 	ret = crypto_shash_init(&sdesc->shash);
 	if (ret < 0)
 		goto out;
@@ -163,7 +163,7 @@ static int TSS_authhmac(unsigned char *digest, const unsigned char *key,
 	if (!ret)
 		ret = TSS_rawhmac(digest, key, keylen, SHA1_DIGEST_SIZE,
 				  paramdigest, TPM_NONCE_SIZE, h1,
-				  TPM_NONCE_SIZE, h2, 1, &c, 0, 0);
+				  TPM_NONCE_SIZE, h3, 1, &c, 0, 0);
 out:
 	kzfree(sdesc);
 	return ret;
@@ -508,7 +508,7 @@ static int tpm_seal(struct tpm_buf *tb, uint16_t keytype,
 	if (pcrinfosize == 0) {
 		/* no pcr info specified */
 		ret = TSS_authhmac(td->pubauth, sess.secret, SHA1_DIGEST_SIZE,
-				   sess.enonce, td->nonceodd, cont,
+				   sess.enonce, cont, td->nonceodd,
 				   sizeof(uint32_t), &ordinal, SHA1_DIGEST_SIZE,
 				   td->encauth, sizeof(uint32_t), &pcrsize,
 				   sizeof(uint32_t), &datsize, datalen, data, 0,
@@ -516,7 +516,7 @@ static int tpm_seal(struct tpm_buf *tb, uint16_t keytype,
 	} else {
 		/* pcr info specified */
 		ret = TSS_authhmac(td->pubauth, sess.secret, SHA1_DIGEST_SIZE,
-				   sess.enonce, td->nonceodd, cont,
+				   sess.enonce, cont, td->nonceodd,
 				   sizeof(uint32_t), &ordinal, SHA1_DIGEST_SIZE,
 				   td->encauth, sizeof(uint32_t), &pcrsize,
 				   pcrinfosize, pcrinfo, sizeof(uint32_t),
@@ -608,12 +608,12 @@ static int tpm_unseal(struct tpm_buf *tb,
 		return ret;
 	}
 	ret = TSS_authhmac(authdata1, keyauth, TPM_NONCE_SIZE,
-			   enonce1, nonceodd, cont, sizeof(uint32_t),
+			   enonce1, cont, nonceodd, sizeof(uint32_t),
 			   &ordinal, bloblen, blob, 0, 0);
 	if (ret < 0)
 		return ret;
 	ret = TSS_authhmac(authdata2, blobauth, TPM_NONCE_SIZE,
-			   enonce2, nonceodd, cont, sizeof(uint32_t),
+			   enonce2, cont, nonceodd, sizeof(uint32_t),
 			   &ordinal, bloblen, blob, 0, 0);
 	if (ret < 0)
 		return ret;
-- 
2.19.0.605.g01d371f741-goog

