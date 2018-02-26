Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2387526-1519634217-2-6653545978929051139
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES enit, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: 
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1519634217; b=EaHjhNj3BEvef1uXUZEAX3Z4zAYFsieK9A2WZrOMSt2f7c/
    TpqNUc6pQmS7UTWH7Lnoypk7D51YlFJFtuqY3VotXOSti6RWHewKcc6nAVFUuu2S
    SYAaaLOijjkK8HBQYJHooWLEBK9H3k9zQvQgPTn6spwP3MAC44zpzjaka77Mj++f
    hWWunV4RBdTumMrkHreT2MFXjFPGZK/gtMKp65W48tI491jqFCx/9EX3uohefIuF
    OevM0vu+RYHCewx/Dw/fzyehPNg7NKUKuX+LiHa08ItllL18zBYZLspOnYzcjlco
    s9fJZaD3KHbTJ4LFVQnTsyIcz+POHtKy5DutS4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:subject:date:message-id
    :in-reply-to:references:sender:list-id; s=arctest; t=1519634217;
    bh=iAPTv5jlMzw6ovOzicmoLxGXCxHRzs8GBzIryr4d66U=; b=KIE2KW0kjwPK
    OL1/taybAZtVoplfz0Vv6K2bUkN5PR47yxlL3G7ILdKhWQrNEtOUFMcSNF/25Owa
    xXnCN/UWWQh12p5irrzwyrl2uP9iDdoRKIYZV5LNdvE55k7lI4otU3p3z+rhBXKi
    Jv1cXnxVUdyzc/zky7iSXyzWwWTkJajrYAtouW/0q1sjRv4MIzaMC0sFMNS/hQ9q
    5WXejA4YsKIF+DdAF4+H+IqNU8Ins74dygYudd/y/bVJtWesJapegdPFRpDCuSww
    ANySD4gFbzcLW7N7gxIUUvfKsFrCMwxZHiJzarF1HKLeTEpLxX9/hXsNOk2+zDB6
    UT1vljKhfg==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=linaro.org header.i=@linaro.org header.b=YBfQoz1u x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=google;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=linaro.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=sC7tgCYS;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linaro.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=linaro.org header.i=@linaro.org header.b=YBfQoz1u x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=google;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=linaro.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=sC7tgCYS;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linaro.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751629AbeBZIgj (ORCPT <rfc822;greg@kroah.com>);
        Mon, 26 Feb 2018 03:36:39 -0500
Received: from mail-pg0-f66.google.com ([74.125.83.66]:42893 "EHLO
        mail-pg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751998AbeBZIW5 (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 26 Feb 2018 03:22:57 -0500
X-Google-Smtp-Source: AH8x226I5xt8ghK4gbzXXuEUBbmSKfcDY2Ya8JDYEDjkHrBYuYS4TCfAmw4uVJEGd3TWLI3OSfKnFw==
From: Alex Shi <alex.shi@linaro.org>
To: Marc Zyngier <marc.zyngier@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        stable@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org (moderated list:ARM64 PORT
        (AARCH64 ARCHITECTURE)), linux-kernel@vger.kernel.org (open list)
Subject: [PATCH 15/52] arm64: uaccess: Mask __user pointers for __arch_{clear, copy_*}_user
Date: Mon, 26 Feb 2018 16:19:49 +0800
Message-Id: <1519633227-29832-16-git-send-email-alex.shi@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1519633227-29832-1-git-send-email-alex.shi@linaro.org>
References: <1519633227-29832-1-git-send-email-alex.shi@linaro.org>
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Will Deacon <will.deacon@arm.com>

Rewritting from commit f71c2ffcb20d upstream. On LTS 4.9, there has no
raw_copy_from/to_user, neither __copy_user_flushcache, and it isn't good
idead to pick up them. The following is origin commit log, that's also
applicable for the new patch.

    Like we've done for get_user and put_user, ensure that user pointers
    are masked before invoking the underlying __arch_{clear,copy_*}_user
    operations.

    Signed-off-by: Will Deacon <will.deacon@arm.com>
    Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>

Signed-off-by: Alex Shi <alex.shi@linaro.org>
---
 arch/arm64/include/asm/uaccess.h | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/arm64/include/asm/uaccess.h b/arch/arm64/include/asm/uaccess.h
index ffa4e39..fbf4ce4 100644
--- a/arch/arm64/include/asm/uaccess.h
+++ b/arch/arm64/include/asm/uaccess.h
@@ -357,14 +357,14 @@ static inline unsigned long __must_check __copy_from_user(void *to, const void _
 {
 	kasan_check_write(to, n);
 	check_object_size(to, n, false);
-	return __arch_copy_from_user(to, from, n);
+	return __arch_copy_from_user(to, __uaccess_mask_ptr(from), n);
 }
 
 static inline unsigned long __must_check __copy_to_user(void __user *to, const void *from, unsigned long n)
 {
 	kasan_check_read(from, n);
 	check_object_size(from, n, true);
-	return __arch_copy_to_user(to, from, n);
+	return __arch_copy_to_user(__uaccess_mask_ptr(to), from, n);
 }
 
 static inline unsigned long __must_check copy_from_user(void *to, const void __user *from, unsigned long n)
@@ -374,7 +374,7 @@ static inline unsigned long __must_check copy_from_user(void *to, const void __u
 	check_object_size(to, n, false);
 
 	if (access_ok(VERIFY_READ, from, n)) {
-		res = __arch_copy_from_user(to, from, n);
+		res = __arch_copy_from_user(to, __uaccess_mask_ptr(from), n);
 	}
 	if (unlikely(res))
 		memset(to + (n - res), 0, res);
@@ -387,7 +387,7 @@ static inline unsigned long __must_check copy_to_user(void __user *to, const voi
 	check_object_size(from, n, true);
 
 	if (access_ok(VERIFY_WRITE, to, n)) {
-		n = __arch_copy_to_user(to, from, n);
+		n = __arch_copy_to_user(__uaccess_mask_ptr(to), from, n);
 	}
 	return n;
 }
@@ -395,7 +395,7 @@ static inline unsigned long __must_check copy_to_user(void __user *to, const voi
 static inline unsigned long __must_check copy_in_user(void __user *to, const void __user *from, unsigned long n)
 {
 	if (access_ok(VERIFY_READ, from, n) && access_ok(VERIFY_WRITE, to, n))
-		n = __copy_in_user(to, from, n);
+		n = __copy_in_user(__uaccess_mask_ptr(to), __uaccess_mask_ptr(from), n);
 	return n;
 }
 
-- 
2.7.4
