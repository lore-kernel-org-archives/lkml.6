Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1883814-1518711037-2-9979455074200649351
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES enda,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1518711036; b=KmPPXL0EHul+LJKbffNbGwruzxrutEv1lp9eF1NQPzmibvV
    EGp14IPhtf3bWUASTBUebfYTXc7ed8cfo0z83rmkeNVVO5RgrKXlgA/sKghiDFsj
    u7FEKtPXZcU58AX96PjEdLtRt+UxnhIurRizU1ArYxUOgZdZ+xsCsGJcsvywiot8
    /KJ1KMiHJ7p8gfPd+mh23/xqtn+l3lJWRFsTLqLJoeo438d+kveKVHgekRufGphh
    h/mYuf6iDzFyYfqSKI2SjZ9ZYyXJ+dkTUm7XxFGMgq+gZiCeQVDeadJX8qhKIDD0
    cGBRL9E25VEH3dOWfzmTy+7r1zNp5e/m+KDFDZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1518711036; bh=3052UsBYMhPEoUl2uelHgyrcWf
    zB0DMGwcDA1ca2YLk=; b=JfchDjkWYWvVTJXoujspcscwhR4mLmAHHcIM1U9UyQ
    nHg0vHzXXpOWYPkFqDR1+ohK/1burg9zAV7I7UtEseu43+kvAEqowJPcjnmoprBM
    TtX3rxF9LL6xID8d/nWQvF6IQPbZoWX6vPI9swjvtczzGpIO7P3kzH6K4JR2mz4t
    adyiAj0OC7jIEb5IxwU8Cxw9HBiMCD5qN2Is+bY3CG/nRevKX1ganGKiE4M0Fw5u
    99XKhK+b3DRIDaAOsoQIA+ph5eibggKY6Y4S3YK6soQuUVuoh10XZ672lNgF+r/O
    9F0/fmgJ4f+nsxCcV0rHJehNaLGXPa+Vqcn1KfVsmRMA==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1424474AbeBOQKd (ORCPT <rfc822;greg@kroah.com>);
        Thu, 15 Feb 2018 11:10:33 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:34930 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1424461AbeBOPpX (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 15 Feb 2018 10:45:23 -0500
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Andrey Konovalov <andreyknvl@google.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Michal Marek <michal.lkml@markovi.net>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: [PATCH 4.15 148/202] kasan: dont emit builtin calls when sanitization is off
Date: Thu, 15 Feb 2018 16:17:28 +0100
Message-Id: <20180215151720.750037629@linuxfoundation.org>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180215151712.768794354@linuxfoundation.org>
References: <20180215151712.768794354@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Andrey Konovalov <andreyknvl@google.com>

commit 0e410e158e5baa1300bdf678cea4f4e0cf9d8b94 upstream.

With KASAN enabled the kernel has two different memset() functions, one
with KASAN checks (memset) and one without (__memset).  KASAN uses some
macro tricks to use the proper version where required.  For example
memset() calls in mm/slub.c are without KASAN checks, since they operate
on poisoned slab object metadata.

The issue is that clang emits memset() calls even when there is no
memset() in the source code.  They get linked with improper memset()
implementation and the kernel fails to boot due to a huge amount of KASAN
reports during early boot stages.

The solution is to add -fno-builtin flag for files with KASAN_SANITIZE :=
n marker.

Link: http://lkml.kernel.org/r/8ffecfffe04088c52c42b92739c2bd8a0bcb3f5e.1516384594.git.andreyknvl@google.com
Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
Acked-by: Nick Desaulniers <ndesaulniers@google.com>
Cc: Masahiro Yamada <yamada.masahiro@socionext.com>
Cc: Michal Marek <michal.lkml@markovi.net>
Cc: Andrey Ryabinin <aryabinin@virtuozzo.com>
Cc: Alexander Potapenko <glider@google.com>
Cc: Dmitry Vyukov <dvyukov@google.com>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 Makefile               |    3 ++-
 scripts/Makefile.kasan |    3 +++
 scripts/Makefile.lib   |    2 +-
 3 files changed, 6 insertions(+), 2 deletions(-)

--- a/Makefile
+++ b/Makefile
@@ -432,7 +432,8 @@ export MAKE AWK GENKSYMS INSTALLKERNEL P
 export HOSTCXX HOSTCXXFLAGS LDFLAGS_MODULE CHECK CHECKFLAGS
 
 export KBUILD_CPPFLAGS NOSTDINC_FLAGS LINUXINCLUDE OBJCOPYFLAGS LDFLAGS
-export KBUILD_CFLAGS CFLAGS_KERNEL CFLAGS_MODULE CFLAGS_KASAN CFLAGS_UBSAN
+export KBUILD_CFLAGS CFLAGS_KERNEL CFLAGS_MODULE
+export CFLAGS_KASAN CFLAGS_KASAN_NOSANITIZE CFLAGS_UBSAN
 export KBUILD_AFLAGS AFLAGS_KERNEL AFLAGS_MODULE
 export KBUILD_AFLAGS_MODULE KBUILD_CFLAGS_MODULE KBUILD_LDFLAGS_MODULE
 export KBUILD_AFLAGS_KERNEL KBUILD_CFLAGS_KERNEL
--- a/scripts/Makefile.kasan
+++ b/scripts/Makefile.kasan
@@ -31,4 +31,7 @@ else
 endif
 
 CFLAGS_KASAN += $(call cc-option, -fsanitize-address-use-after-scope)
+
+CFLAGS_KASAN_NOSANITIZE := -fno-builtin
+
 endif
--- a/scripts/Makefile.lib
+++ b/scripts/Makefile.lib
@@ -121,7 +121,7 @@ endif
 ifeq ($(CONFIG_KASAN),y)
 _c_flags += $(if $(patsubst n%,, \
 		$(KASAN_SANITIZE_$(basetarget).o)$(KASAN_SANITIZE)y), \
-		$(CFLAGS_KASAN))
+		$(CFLAGS_KASAN), $(CFLAGS_KASAN_NOSANITIZE))
 endif
 
 ifeq ($(CONFIG_UBSAN),y)
