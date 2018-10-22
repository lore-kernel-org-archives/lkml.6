Return-Path: <SRS0=9pGL=NC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0589C7112C
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Oct 2018 23:44:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E2C5820651
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Oct 2018 23:44:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="mBzyYu1H"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E2C5820651
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726720AbeJWIE6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Oct 2018 04:04:58 -0400
Received: from mail-oi1-f201.google.com ([209.85.167.201]:42120 "EHLO
        mail-oi1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726268AbeJWIE6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Oct 2018 04:04:58 -0400
Received: by mail-oi1-f201.google.com with SMTP id o6-v6so30111133oib.9
        for <linux-kernel@vger.kernel.org>; Mon, 22 Oct 2018 16:44:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=AVaE6qqCM7P1pf2cFcPqWk4W3pnXUdpSoKA8uQ0SjZ4=;
        b=mBzyYu1HdbYE9z8r5x4PGuQhDtMqe4IrmxEbiZGjR45uneCPsqf07yKK18YzpzXCCT
         EsRM0VAhjtUeutUbpYgWJVrShoR+yyt2zU552O3ks7MPiojNA/P5YMXQTvREcGgf8NUi
         KfPv5KbgFoTdnPVQks3lRzxuovXxtyu8hYxB4Yz22M9lQ7dZ6k7S7aAPMhzXvQ9DX9sw
         F5AzTn0gRPOGytm2GlCs24SVbH6u3E3sDCQw1avqon1jeulFHKWhXACLX9eCz37pTvbb
         +W0lnRoywsqrDBzHmZnPQ0zsqLcdnXLNJhQvkylb6qgtvr+2Jw2hPKlgIKN9cmU9dKwP
         ah7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=AVaE6qqCM7P1pf2cFcPqWk4W3pnXUdpSoKA8uQ0SjZ4=;
        b=nDWWRVT8XdQOuVUDcraTZDMEtc2YRTRH8hCNqEl8OH1wNELoFivUAa8izMoZWttlaa
         mA8Xy+yJgrXzj+lAFuFxc4IaCkaqwEOgCsrr096M2vu2AwRo/JtEPslwekpCwSN78om3
         gkM0y1FpbOH48QCheUSzKXIZZqVbPLd1zdnK2dYMu74fooYfLu9kZI43PvCWIe173/Mq
         YPoFIss0Z8jbSjiveTxtoQ9mDWpcEOudEi1iURloFXYDllvODlBHZxDErnhZKR77xUZH
         xVCrNGcbc9/Mrls5dX9d1wJQIZ2sDAvnEq9GP5bWttQqQNozz0agVaZGDoe5uWqM7zx6
         NMgw==
X-Gm-Message-State: ABuFfoiWs+oZ5fEFW1JSgk6GT4cNDh5cRisa4qTy1pXzXGlwNiok1HHx
        YJHldJEJ2kSNuafsuse5XK+ids71qpk31HGI3l8=
X-Google-Smtp-Source: ACcGV62tz4jpL504gq8yGC58f+ICh5t7A1p5mMqKqhrqA/y65g9HBDMq5/8RNd+EHBgG74quCce1vqIdtPoXX8VTHP4=
X-Received: by 2002:a9d:2351:: with SMTP id k17mr38895235otd.34.1540251855357;
 Mon, 22 Oct 2018 16:44:15 -0700 (PDT)
Date:   Mon, 22 Oct 2018 16:43:57 -0700
In-Reply-To: <0147a993d4a94426afa469a8dcc4e5d7@AcuMS.aculab.com>
Message-Id: <20181022234357.82217-1-ndesaulniers@google.com>
Mime-Version: 1.0
References: <0147a993d4a94426afa469a8dcc4e5d7@AcuMS.aculab.com>
X-Mailer: git-send-email 2.19.1.568.g152ad8e336-goog
Subject: [PATCH v2] [PATCH] KEYS: trusted: fix -Wvarags warning
From:   ndesaulniers@google.com
To:     dhowells@redhat.com, jejb@linux.vnet.ibm.com
Cc:     natechancellor@gmail.com, David.Laight@aculab.com,
        denkenz@gmail.com, Nick Desaulniers <ndesaulniers@google.com>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Mimi Zohar <zohar@linux.vnet.ibm.com>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>, keyrings@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the warning reported by Clang:
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
Link: https://www.eskimo.com/~scs/cclass/int/sx11c.html
Suggested-by: David Laight <David.Laight@aculab.com>
Suggested-by: Denis Kenzior <denkenz@gmail.com>
Suggested-by: James Bottomley <jejb@linux.vnet.ibm.com>
Suggested-by: Nathan Chancellor <natechancellor@gmail.com>
Signed-off-by: Nick Desaulniers <ndesaulniers@google.com>
---
v1 -> v2:
* Don't reorder args, just use default function promotion type
of unsigned int.
* Add !! boolean cast as per Denis in
https://lkml.org/lkml/2018/10/12/838.
* Tested with gcc-8 and clang-8.

 include/keys/trusted.h  | 2 +-
 security/keys/trusted.c | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/include/keys/trusted.h b/include/keys/trusted.h
index adbcb6817826..0071298b9b28 100644
--- a/include/keys/trusted.h
+++ b/include/keys/trusted.h
@@ -38,7 +38,7 @@ enum {
 
 int TSS_authhmac(unsigned char *digest, const unsigned char *key,
 			unsigned int keylen, unsigned char *h1,
-			unsigned char *h2, unsigned char h3, ...);
+			unsigned char *h2, unsigned int h3, ...);
 int TSS_checkhmac1(unsigned char *buffer,
 			  const uint32_t command,
 			  const unsigned char *ononce,
diff --git a/security/keys/trusted.c b/security/keys/trusted.c
index ff6789365a12..335ce6d1cf6b 100644
--- a/security/keys/trusted.c
+++ b/security/keys/trusted.c
@@ -123,7 +123,7 @@ static int TSS_rawhmac(unsigned char *digest, const unsigned char *key,
  */
 int TSS_authhmac(unsigned char *digest, const unsigned char *key,
 			unsigned int keylen, unsigned char *h1,
-			unsigned char *h2, unsigned char h3, ...)
+			unsigned char *h2, unsigned int h3, ...)
 {
 	unsigned char paramdigest[SHA1_DIGEST_SIZE];
 	struct sdesc *sdesc;
@@ -139,7 +139,7 @@ int TSS_authhmac(unsigned char *digest, const unsigned char *key,
 		return PTR_ERR(sdesc);
 	}
 
-	c = h3;
+	c = !!h3;
 	ret = crypto_shash_init(&sdesc->shash);
 	if (ret < 0)
 		goto out;
-- 
2.19.1.568.g152ad8e336-goog

