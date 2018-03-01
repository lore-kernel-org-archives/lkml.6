Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2898263-1519909659-2-15595536969113378701
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: 
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1519909658; b=wB27hyJQKhk4ICGgVxe8juyJU01MSlM0RL70gQScCAMW1dh
    hVtdN3QJx78j2JdL+jqmgJtcK8OWtH7srzxQvGqiWYpdBz0Od6r+AauO3XWXWhcS
    Nmr0BmbmOGOjKzKD1w0XOlR8KynJ3RV9queKof0aCFXUAIv4toguOo4t00lRWJoq
    PREfcClD+eXxhMGgyBWZwZXDtxiAmKG3erDRnM2mjKgdcP8RDI6IPlftjjY+TG/u
    ijv6HLby0Ty0UQXrVBiiK3Qq3xCkryU1jygthoN4XTXzLai3GrWVsyTjBXZ82+xL
    NDnZQulycNVj4F6H8MRwuO2RbvG4l34sF+hc64Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:sender:list-id; s=arctest; t=1519909658;
    bh=faQj8JqC4/KwGNZMuLXKQ1k5PdvnOQTh5XG4tCkdUZY=; b=SOy34hyAhAaV
    VkrLvdkR+zJObqhnhTHEondN2qQUYszcnAzsKqpL/tS8IMfCkFuTp2gWFP9TL4gV
    e7Zqc9ugbUnx6CuII+IlbNaziU4QcPPI+PiM9tbCwRatNAG8+aT1AaYbmkLUb0R5
    dGS3UShvOjIJe6jAxL7f+rMiQV10JbrhcXYKzj7wDBz98Ub6VHmqj4tpcBkCYu80
    iAr6paWA6IUf/006yeYLO4eyceWqUvRYyLkjXK8GSRGqTyMzZImK5olrzPf2wkqN
    HHcNURyNb/dngLdZ/ZYg9zonsFRzHyVGA8g1KmxKE9w/IZJsyMLmSJ/XLmcgWZug
    2+vaVf1NPg==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=linaro.org header.i=@linaro.org header.b=VwStRMao x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=google;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=linaro.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=cuz9qrg1;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linaro.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=linaro.org header.i=@linaro.org header.b=VwStRMao x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=google;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=linaro.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=cuz9qrg1;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linaro.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1030568AbeCAM4R (ORCPT <rfc822;greg@kroah.com>);
        Thu, 1 Mar 2018 07:56:17 -0500
Received: from mail-pl0-f66.google.com ([209.85.160.66]:37888 "EHLO
        mail-pl0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1030696AbeCAM4O (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 1 Mar 2018 07:56:14 -0500
X-Google-Smtp-Source: AG47ELuLyhs09p68iErvWloFIswauoMMbsZquBoT1YJy1IYxPErNDZ/MSS7KrSJM7gcSvAfO3Zb5kg==
From: Alex Shi <alex.shi@linaro.org>
To: Marc Zyngier <marc.zyngier@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        stable@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Cc: Mark Rutland <mark.rutland@arm.com>, Alex Shi <alex.shi@linaro.org>
Subject: [PATCH 08/45] arm64: uaccess: consistently check object sizes
Date: Thu,  1 Mar 2018 20:53:45 +0800
Message-Id: <1519908862-11425-9-git-send-email-alex.shi@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1519908862-11425-1-git-send-email-alex.shi@linaro.org>
References: <1519908862-11425-1-git-send-email-alex.shi@linaro.org>
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Mark Rutland <mark.rutland@arm.com>

commit 76624175dca upstream.

Currently in arm64's copy_{to,from}_user, we only check the
source/destination object size if access_ok() tells us the user access
is permissible.

However, in copy_from_user() we'll subsequently zero any remainder on
the destination object. If we failed the access_ok() check, that applies
to the whole object size, which we didn't check.

To ensure that we catch that case, this patch hoists check_object_size()
to the start of copy_from_user(), matching __copy_from_user() and
__copy_to_user(). To make all of our uaccess copy primitives consistent,
the same is done to copy_to_user().

Cc: Catalin Marinas <catalin.marinas@arm.com>
Acked-by: Kees Cook <keescook@chromium.org>
Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Signed-off-by: Will Deacon <will.deacon@arm.com>
Signed-off-by: Alex Shi <alex.shi@linaro.org>
---
 arch/arm64/include/asm/uaccess.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/include/asm/uaccess.h b/arch/arm64/include/asm/uaccess.h
index 94e1457..09c9b59 100644
--- a/arch/arm64/include/asm/uaccess.h
+++ b/arch/arm64/include/asm/uaccess.h
@@ -326,9 +326,9 @@ static inline unsigned long __must_check copy_from_user(void *to, const void __u
 {
 	unsigned long res = n;
 	kasan_check_write(to, n);
+	check_object_size(to, n, false);
 
 	if (access_ok(VERIFY_READ, from, n)) {
-		check_object_size(to, n, false);
 		res = __arch_copy_from_user(to, from, n);
 	}
 	if (unlikely(res))
@@ -339,9 +339,9 @@ static inline unsigned long __must_check copy_from_user(void *to, const void __u
 static inline unsigned long __must_check copy_to_user(void __user *to, const void *from, unsigned long n)
 {
 	kasan_check_read(from, n);
+	check_object_size(from, n, true);
 
 	if (access_ok(VERIFY_WRITE, to, n)) {
-		check_object_size(from, n, true);
 		n = __arch_copy_to_user(to, from, n);
 	}
 	return n;
-- 
2.7.4
