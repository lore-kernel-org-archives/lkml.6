Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-620147-1519836812-2-11650308476000308356
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN', FromHeader='uk',
  MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1519836811; b=Q6R4O7iHyZ+spi2NYk2b9SzG3dnlzvzThE81dB6b0qe5tG4
    36cxjSlnQeHTufA570+0WWM+YG9mBILmsUIPdNFr/5YZVW29jnN+wIvfH3nYkpID
    vv9uD+2tK+hEKFVh9vlm58Q40FrXsbNUfm2LeumoHHKkzSTI6u+nBZSzJTS/RU4m
    Yeq8CpoK7fgA56nU4MHBA79sjL5NXQkXxMCo8AdTMW/pYw8Q5liXC2GE9wupEF/i
    0ZP4hXt5Ll9TzFcvFJ46gu8R+nWCbyHB7KxnFjwb2FzYF/qDo2/g5yIjXmwr7DK7
    J3xbRIoASk/Mhx1F6ybdEt6YO78+8ZuD0mpVA9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=content-type:content-transfer-encoding
    :mime-version:from:to:cc:date:message-id:subject:in-reply-to
    :sender:list-id; s=arctest; t=1519836811; bh=PdhhUpLMH3UMYg5oEs8
    MlueSZg9kkdmBT2Q/jknkxPU=; b=EAQ2fiE98TdogJA3x0gDLZlqkTRQZ6xjuyY
    Mse6tgVaKmRrRztm5nHOtc65O0eKXE5Z1gNMKCmz5fuxDz0YJrEfKxytDTUjrcrZ
    bqbDeRuM1DTTJnbJBfqVew/H2l06cr54AZb0j6pxtscIjG3/Cr/DJ28qo37hmiff
    BWwdIezR9ahBnVYj1U4Xd+KkfARnMUJHHWyw9opHrx/MLlkL60bNTIlJsiOBHH9s
    qOLkvB2xCnyVypezm9kDU9ni1u7SGa4BGwfitLCKGcT/Ng79waaey2XHDmAeptj5
    HLf0jec2ZzwGJoTsC+OlfS/oEDeJalYi4QHF8Isvf2SDtLKoSqw==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=decadent.org.uk;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=decadent.org.uk header.result=pass header_is_org_domain=yes
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=decadent.org.uk;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=decadent.org.uk header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932299AbeB1QxN (ORCPT <rfc822;greg@kroah.com>);
        Wed, 28 Feb 2018 11:53:13 -0500
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:34544 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S934236AbeB1P6E (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 28 Feb 2018 10:58:04 -0500
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From: Ben Hutchings <ben@decadent.org.uk>
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC: akpm@linux-foundation.org, "Denys Vlasenko" <dvlasenk@redhat.com>,
        "Joe Perches" <joe@perches.com>,
        "Linus Torvalds" <torvalds@linux-foundation.org>
Date: Wed, 28 Feb 2018 15:20:18 +0000
Message-ID: <lsq.1519831218.219333313@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 149/254] stddef.h: move offsetofend inside
 #ifndef/#endif guard, neaten
In-Reply-To: <lsq.1519831217.271785318@decadent.org.uk>
X-SA-Exim-Connect-IP: 2a02:8011:400e:2:6f00:88c8:c921:d332
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

3.16.55-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Joe Perches <joe@perches.com>

commit 8c7fbe5795a016259445a61e072eb0118aaf6a61 upstream.

Commit 3876488444e7 ("include/stddef.h: Move offsetofend() from vfio.h
to a generic kernel header") added offsetofend outside the normal
include #ifndef/#endif guard.  Move it inside.

Miscellanea:

o remove unnecessary blank line
o standardize offsetof macros whitespace style

Signed-off-by: Joe Perches <joe@perches.com>
Cc: Denys Vlasenko <dvlasenk@redhat.com>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 include/linux/stddef.h | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

--- a/include/linux/stddef.h
+++ b/include/linux/stddef.h
@@ -3,7 +3,6 @@
 
 #include <uapi/linux/stddef.h>
 
-
 #undef NULL
 #define NULL ((void *)0)
 
@@ -14,10 +13,9 @@ enum {
 
 #undef offsetof
 #ifdef __compiler_offsetof
-#define offsetof(TYPE,MEMBER) __compiler_offsetof(TYPE,MEMBER)
+#define offsetof(TYPE, MEMBER)	__compiler_offsetof(TYPE, MEMBER)
 #else
-#define offsetof(TYPE, MEMBER) ((size_t) &((TYPE *)0)->MEMBER)
-#endif
+#define offsetof(TYPE, MEMBER)	((size_t)&((TYPE *)0)->MEMBER)
 #endif
 
 /**
@@ -28,3 +26,5 @@ enum {
  */
 #define offsetofend(TYPE, MEMBER) \
 	(offsetof(TYPE, MEMBER)	+ sizeof(((TYPE *)0)->MEMBER))
+
+#endif
