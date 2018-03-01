Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2898263-1519909635-5-7959769409441574029
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES ensv, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: 
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1519909635; b=lk+/6II6Fy4bcBgONcaavCPeY3AJc5HpU+jE2bVvM/n1oNE
    7fRoNP+M5qwj6+v7Asjz8hvRoToXUfp82irigu6OXMQnPjaav7CoFqPWlzAij3WB
    yV9QjAy2iFgy2p5klSBF2JOhud3pbCley65D1OxQIVoQXboq2IqOCodrf4renFb2
    ohD6M5e9ED9SZqx/EjXdEORLV9ALfQV4AQ/kHaqa3reINkdDc94NfGia9entGRi+
    l9vUtnlzxTMiF4jN1E2CQLr7VC6zH/uzDatOd6T5Qxn1p+rR6kWbpbmowiOVIR+q
    qFSaQbqlItWOebh9MxSb7zrf/TC0/VwJkPhOT7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:sender:list-id; s=arctest; t=1519909635;
    bh=B06UrOpFOhDhk8CXgd0QbaeXaNIGUHvFPN317fRlFQ4=; b=XxrFJTrCkr89
    tRD3Ya3Yy8Ij6w9Sgif5YsPEc6YduiqaNcN0ejJuMdq2GWpVNODFUKFZ66uHbF7l
    hbylxCW2FcscsyPfIZUqFmYK8wvwTn25Mv5fqzWhyOSxtnPuFdkkTQQfKhvUVzIy
    WwCwJtiNjzwvM7FYvHIoVpvU3vvBJMsRFY3KLpmjOYimxn74FulbPIiTceBQ9LDD
    EAAqjmbvumY5ohNqgnOeIfOhoxr9/gZ0SleGCrcPHBp2UgEnrv2jAW+8amNqzVlI
    cvUsaGONyxP+2TVak8rNe7Jqwcg5mGxEBLwNrrdOTl7KdnYd7lFnRLjlVgcKUt1o
    HnhA23/Vjg==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=linaro.org header.i=@linaro.org header.b=D/+FhXt5 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=google;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=linaro.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=j264OKcz;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linaro.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=linaro.org header.i=@linaro.org header.b=D/+FhXt5 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=google;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=linaro.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=j264OKcz;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linaro.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1030791AbeCAM5J (ORCPT <rfc822;greg@kroah.com>);
        Thu, 1 Mar 2018 07:57:09 -0500
Received: from mail-pg0-f66.google.com ([74.125.83.66]:41327 "EHLO
        mail-pg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1030789AbeCAM5C (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 1 Mar 2018 07:57:02 -0500
X-Google-Smtp-Source: AG47ELsj8/N9BmPe04eqb9FPvC24xYKDpVP8wgcHlRMGFnwC+82inZWq/GwfEgDId/anSFRAIo99yA==
From: Alex Shi <alex.shi@linaro.org>
To: Marc Zyngier <marc.zyngier@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        stable@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Cc: Alex Shi <alex.shi@linaro.org>
Subject: [PATCH 14/45] arm64: uaccess: Don't bother eliding access_ok checks in __{get, put}_user
Date: Thu,  1 Mar 2018 20:53:51 +0800
Message-Id: <1519908862-11425-15-git-send-email-alex.shi@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1519908862-11425-1-git-send-email-alex.shi@linaro.org>
References: <1519908862-11425-1-git-send-email-alex.shi@linaro.org>
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Will Deacon <will.deacon@arm.com>

commit 84624087dd7e upstream.

access_ok isn't an expensive operation once the addr_limit for the current
thread has been loaded into the cache. Given that the initial access_ok
check preceding a sequence of __{get,put}_user operations will take
the brunt of the miss, we can make the __* variants identical to the
full-fat versions, which brings with it the benefits of address masking.

The likely cost in these sequences will be from toggling PAN/UAO, which
we can address later by implementing the *_unsafe versions.

Reviewed-by: Robin Murphy <robin.murphy@arm.com>
Signed-off-by: Will Deacon <will.deacon@arm.com>
Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
Signed-off-by: Alex Shi <alex.shi@linaro.org>
---
 arch/arm64/include/asm/uaccess.h | 54 ++++++++++++++++++++++++----------------
 1 file changed, 32 insertions(+), 22 deletions(-)

diff --git a/arch/arm64/include/asm/uaccess.h b/arch/arm64/include/asm/uaccess.h
index 00025c5..ffa4e39 100644
--- a/arch/arm64/include/asm/uaccess.h
+++ b/arch/arm64/include/asm/uaccess.h
@@ -248,30 +248,35 @@ do {									\
 	(x) = (__force __typeof__(*(ptr)))__gu_val;			\
 } while (0)
 
-#define __get_user(x, ptr)						\
+#define __get_user_check(x, ptr, err)					\
 ({									\
-	int __gu_err = 0;						\
-	__get_user_err((x), (ptr), __gu_err);				\
-	__gu_err;							\
+	__typeof__(*(ptr)) __user *__p = (ptr);				\
+	might_fault();							\
+	if (access_ok(VERIFY_READ, __p, sizeof(*__p))) {		\
+		__p = uaccess_mask_ptr(__p);				\
+		__get_user_err((x), __p, (err));			\
+	} else {							\
+		(x) = 0; (err) = -EFAULT;				\
+	}								\
 })
 
 #define __get_user_error(x, ptr, err)					\
 ({									\
-	__get_user_err((x), (ptr), (err));				\
+	__get_user_check((x), (ptr), (err));				\
 	(void)0;							\
 })
 
 #define __get_user_unaligned __get_user
 
-#define get_user(x, ptr)						\
+#define __get_user(x, ptr)						\
 ({									\
-	__typeof__(*(ptr)) __user *__p = (ptr);				\
-	might_fault();							\
-	access_ok(VERIFY_READ, __p, sizeof(*__p)) ?			\
-		__p = uaccess_mask_ptr(__p), __get_user((x), __p) :	\
-		((x) = 0, -EFAULT);					\
+	int __gu_err = 0;						\
+	__get_user_check((x), (ptr), __gu_err);				\
+	__gu_err;							\
 })
 
+#define get_user	__get_user
+
 #define __put_user_asm(instr, alt_instr, reg, x, addr, err, feature)	\
 	asm volatile(							\
 	"1:"ALTERNATIVE(instr "     " reg "1, [%2]\n",			\
@@ -314,30 +319,35 @@ do {									\
 	uaccess_disable_not_uao();					\
 } while (0)
 
-#define __put_user(x, ptr)						\
+#define __put_user_check(x, ptr, err)					\
 ({									\
-	int __pu_err = 0;						\
-	__put_user_err((x), (ptr), __pu_err);				\
-	__pu_err;							\
+	__typeof__(*(ptr)) __user *__p = (ptr);				\
+	might_fault();							\
+	if (access_ok(VERIFY_WRITE, __p, sizeof(*__p))) {		\
+		__p = uaccess_mask_ptr(__p);				\
+		__put_user_err((x), __p, (err));			\
+	} else	{							\
+		(err) = -EFAULT;					\
+	}								\
 })
 
 #define __put_user_error(x, ptr, err)					\
 ({									\
-	__put_user_err((x), (ptr), (err));				\
+	__put_user_check((x), (ptr), (err));				\
 	(void)0;							\
 })
 
 #define __put_user_unaligned __put_user
 
-#define put_user(x, ptr)						\
+#define __put_user(x, ptr)						\
 ({									\
-	__typeof__(*(ptr)) __user *__p = (ptr);				\
-	might_fault();							\
-	access_ok(VERIFY_WRITE, __p, sizeof(*__p)) ?			\
-		__p = uaccess_mask_ptr(__p), __put_user((x), __p) :	\
-		-EFAULT;						\
+	int __pu_err = 0;						\
+	__put_user_check((x), (ptr), __pu_err);				\
+	__pu_err;							\
 })
 
+#define put_user	__put_user
+
 extern unsigned long __must_check __arch_copy_from_user(void *to, const void __user *from, unsigned long n);
 extern unsigned long __must_check __arch_copy_to_user(void __user *to, const void *from, unsigned long n);
 extern unsigned long __must_check __copy_in_user(void __user *to, const void __user *from, unsigned long n);
-- 
2.7.4
