Return-Path: <SRS0=GJN7=OT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A57FC04EB8
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 12:51:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4F19020870
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 12:51:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="tvsXwVCK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4F19020870
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727919AbeLJMv4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Dec 2018 07:51:56 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:40219 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727460AbeLJMvQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Dec 2018 07:51:16 -0500
Received: by mail-wr1-f65.google.com with SMTP id p4so10338492wrt.7
        for <linux-kernel@vger.kernel.org>; Mon, 10 Dec 2018 04:51:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=spp1yx5uWvAgxErNR01vKeP4ipxAKNr5cbWijdqL/NI=;
        b=tvsXwVCKLmRdJsM+euD1t0rVUHOOn+/ZTTi3MnnQ9yebryAkbI4hvbPXubAR8j9xbT
         rSzx3Kyplc8mI1Q5cCWawts1mVwnbRT/UG0tp4Xvt5MDVVu5AjP34+MyjU+t6RTFt/1F
         GtjCSp16Bsb0olrw8ju4ga21oFPvQHFAjGiXj06kBSulY2fBvH1/8yimSxJdEzM0IjDe
         S2UHXqy/PlTnElD5PvCE/Ei8NOK6WhW4AzfjK1G4NAKHmzILpvArpdT0x23Ci7QVw1Jf
         siaqLTUGCqHPMIili1iJlbBGd6qfhARL0xDVAgzKR2wFfvkvY0Mi96XrFZLLMJ9KfrPg
         c6gA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=spp1yx5uWvAgxErNR01vKeP4ipxAKNr5cbWijdqL/NI=;
        b=GOPElFrY/9yqE2daTKIK9SKsLw31CcLe88LXdkMmsftJIBqzv+SxQoi0M4iE/aM3pH
         5b9W21OT1FWBjmZlqb0U/Ji+GZjVYp9DZHT0VGYu8JFL+YVKEDUUaSl5E7NdUGgINs0S
         Ki/vNc4znlPTMVy19Cm+tYaNbHf9M8btIS0YYuJ9hIyZT23UIi2j3Fflr+Vznvkk3tFz
         +LKYkbIpgMNq16AaE46GaeEleR3YnXymq/okEBUorf9aTdPCHUjGQuiOYxOt+i8vR1ui
         qgVh8y18AX+t+2JlLSpjyrJyo3ebKN+Fq/oRBAwl9aXhp+taF0+LbomVp6vOsj/EVGOW
         czvQ==
X-Gm-Message-State: AA+aEWafbW2LDz2tJbgxogKfxOxkQX0dG4Mj2FcykziZdd8UpUVMU63F
        IjLPfd4FqbHOnTz2XhNoy7bgMA==
X-Google-Smtp-Source: AFSGD/WK6voMtzDjeOrD0p0dIVtqA5GSBJDXWoYR6ofaTs6wbsSMRcTZb/d4/4QZpcv/PkUOjr5HNQ==
X-Received: by 2002:a5d:684b:: with SMTP id o11mr9182121wrw.316.1544446274117;
        Mon, 10 Dec 2018 04:51:14 -0800 (PST)
Received: from andreyknvl0.muc.corp.google.com ([2a00:79e0:15:10:3180:41f8:3010:ff61])
        by smtp.gmail.com with ESMTPSA id l197sm36893363wma.44.2018.12.10.04.51.12
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 10 Dec 2018 04:51:13 -0800 (PST)
From:   Andrey Konovalov <andreyknvl@google.com>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Kees Cook <keescook@chromium.org>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Ingo Molnar <mingo@kernel.org>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Shuah Khan <shuah@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org,
        linux-mm@kvack.org, linux-arch@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Dmitry Vyukov <dvyukov@google.com>,
        Kostya Serebryany <kcc@google.com>,
        Evgeniy Stepanov <eugenis@google.com>,
        Lee Smith <Lee.Smith@arm.com>,
        Ramana Radhakrishnan <Ramana.Radhakrishnan@arm.com>,
        Jacob Bramley <Jacob.Bramley@arm.com>,
        Ruben Ayrapetyan <Ruben.Ayrapetyan@arm.com>,
        Chintan Pandya <cpandya@codeaurora.org>,
        Luc Van Oostenryck <luc.vanoostenryck@gmail.com>,
        Andrey Konovalov <andreyknvl@google.com>
Subject: [PATCH v9 3/8] arm64: untag user addresses in access_ok and __uaccess_mask_ptr
Date:   Mon, 10 Dec 2018 13:51:00 +0100
Message-Id: <674252952827b57f4259876cd4ddf802f3539356.1544445454.git.andreyknvl@google.com>
X-Mailer: git-send-email 2.20.0.rc2.403.gdbc3b29805-goog
In-Reply-To: <cover.1544445454.git.andreyknvl@google.com>
References: <cover.1544445454.git.andreyknvl@google.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

copy_from_user (and a few other similar functions) are used to copy data
from user memory into the kernel memory or vice versa. Since a user can
provided a tagged pointer to one of the syscalls that use copy_from_user,
we need to correctly handle such pointers.

Do this by untagging user pointers in access_ok and in __uaccess_mask_ptr,
before performing access validity checks.

Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
---
 arch/arm64/include/asm/uaccess.h | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/include/asm/uaccess.h b/arch/arm64/include/asm/uaccess.h
index 3c3864ba3cc1..d28c3b1314ce 100644
--- a/arch/arm64/include/asm/uaccess.h
+++ b/arch/arm64/include/asm/uaccess.h
@@ -104,7 +104,8 @@ static inline unsigned long __range_ok(const void __user *addr, unsigned long si
 #define untagged_addr(addr)		\
 	((__typeof__(addr))sign_extend64((u64)(addr), 55))
 
-#define access_ok(type, addr, size)	__range_ok(addr, size)
+#define access_ok(type, addr, size)	\
+	__range_ok(untagged_addr(addr), size)
 #define user_addr_max			get_fs
 
 #define _ASM_EXTABLE(from, to)						\
@@ -236,7 +237,8 @@ static inline void uaccess_enable_not_uao(void)
 
 /*
  * Sanitise a uaccess pointer such that it becomes NULL if above the
- * current addr_limit.
+ * current addr_limit. In case the pointer is tagged (has the top byte set),
+ * untag the pointer before checking.
  */
 #define uaccess_mask_ptr(ptr) (__typeof__(ptr))__uaccess_mask_ptr(ptr)
 static inline void __user *__uaccess_mask_ptr(const void __user *ptr)
@@ -244,10 +246,11 @@ static inline void __user *__uaccess_mask_ptr(const void __user *ptr)
 	void __user *safe_ptr;
 
 	asm volatile(
-	"	bics	xzr, %1, %2\n"
+	"	bics	xzr, %3, %2\n"
 	"	csel	%0, %1, xzr, eq\n"
 	: "=&r" (safe_ptr)
-	: "r" (ptr), "r" (current_thread_info()->addr_limit)
+	: "r" (ptr), "r" (current_thread_info()->addr_limit),
+	  "r" (untagged_addr(ptr))
 	: "cc");
 
 	csdb();
-- 
2.20.0.rc2.403.gdbc3b29805-goog

