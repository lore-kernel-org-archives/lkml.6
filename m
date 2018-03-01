Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2899084-1519909603-2-8538461744421232739
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES enit, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: 
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1519909602; b=jFytCJVaIY9pSCrP4AZE0AnnSJ7DSY3T5O6UfS5hALnIO/5
    9CCzEx5Qw95zdNMteWc9jcbeSO66wLb2lKFj8+x01YF9z4nR+BzHODQrMyGN6acH
    8Te03kj9o6BlgegGvpvgdnFmBCEl4AsWk9q6567bNQFTPlQHW1F1FH91vTTXVpuO
    J/esyDIbGoHg/UxUtr3WohCOCfZxvTJbq1yffS3jCwDSpnCZlILTROhc1Tvk3vCX
    zYEP8FzFGSB8JNEaCkWxPymwfi5aa0XRJlJuCQWe9E1yfINl7nffJZosrv/a63AK
    cIwVq1P6XlYUxez88eTcyJxEBm+m6pC3d4+VatA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:sender:list-id; s=arctest; t=1519909602;
    bh=v4D/ryQu43SY8kOi0wmbmZowM0pzF7fHoEsCU0j3u2A=; b=rxpHuvkTa1cw
    5PnVf3l7Oq6CpjAm76vNsAwEk1uO5CSQ2857MK9IIMz9X6IU9iqh6pfH/X0Ldx1q
    wZiJ7eTysWXX+B5AiGS+SZasv9ZafEtqPhrcActXJza9UVzmiqmpPir8AtrmBGqU
    xgKS4x436T92//IE7WZ0UQDNxGymPET1y82nbAjiO86JdxRntQGZjGBhz9Gmh2Wz
    B0HDt66wekuHPT0S7Eguk80dQgpOB3QzgYkcs9KbB9dg+XeJYV26ziCB7IH+AwQX
    ujYn6USfJYv238sOcBM1DzcNKgPQYnIlEGMwSofpejv2fUnm8DQQW+zDGoQLymbW
    6Lk68m0B2A==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=linaro.org header.i=@linaro.org header.b=BqtU3wG2 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=google;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=linaro.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=V7yf93ge;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linaro.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=linaro.org header.i=@linaro.org header.b=BqtU3wG2 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=google;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=linaro.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=V7yf93ge;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linaro.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1030864AbeCANG0 (ORCPT <rfc822;greg@kroah.com>);
        Thu, 1 Mar 2018 08:06:26 -0500
Received: from mail-pl0-f65.google.com ([209.85.160.65]:40946 "EHLO
        mail-pl0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1030801AbeCAM5K (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 1 Mar 2018 07:57:10 -0500
X-Google-Smtp-Source: AG47ELtM28j3NTErwSRAVBubs8Hmk2rf26vRT1Khl+LQm7c8JZSxQqPOsYTSgkSdDgbgzmYW0mT7mA==
From: Alex Shi <alex.shi@linaro.org>
To: Marc Zyngier <marc.zyngier@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        stable@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Cc: Alex Shi <alex.shi@linaro.org>
Subject: [PATCH 15/45] arm64: uaccess: Mask __user pointers for __arch_{clear, copy_*}_user
Date: Thu,  1 Mar 2018 20:53:52 +0800
Message-Id: <1519908862-11425-16-git-send-email-alex.shi@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1519908862-11425-1-git-send-email-alex.shi@linaro.org>
References: <1519908862-11425-1-git-send-email-alex.shi@linaro.org>
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
