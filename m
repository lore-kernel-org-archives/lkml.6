Return-Path: <SRS0=/Ixz=KV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98CE5C46471
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 16:42:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 532CA21A67
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 16:42:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="hY19VVlN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 532CA21A67
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387638AbeHFSuy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Aug 2018 14:50:54 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:33690 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387596AbeHFSux (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Aug 2018 14:50:53 -0400
Received: by mail-wm0-f68.google.com with SMTP id r24-v6so12002076wmh.0
        for <linux-kernel@vger.kernel.org>; Mon, 06 Aug 2018 09:40:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=WADZVauYt2+vN10op76v0l4/uhmUIRsYzVe9gnbEQFA=;
        b=hY19VVlNC+aT5T0+2ijd0mPFjapVd6gfqUj0erw0EDOJ7eBmW+Z2x+XRfZD5O4Ac94
         3I63n27oCUcp10sI/R6BhxKri6mPzwVCDsDOb3SWT19hUTxakDBMMYxpjSdnaqFuVuLc
         bpml4I6XJiFT2ngv+DVV9M2GX/Dx2Z7qOxaYHLhvHwuI7CE/9/5OFZL5C0FrKLsuBTup
         FKle1LaLfIHzrfWzOuj2ESOMv/mfS1XGNWkuASeMkcTFIcbmIBjb+9eD3ytrtzihsmpN
         Eh26t1BM3+6TAUjrYud29s8Qagu0ISZ3YeQG4hAkl/UkhkQfGbdL32tE8/Q1VI+PBaAb
         MdHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=WADZVauYt2+vN10op76v0l4/uhmUIRsYzVe9gnbEQFA=;
        b=uhlR/U1OJqOC5p57zHN2HASX3VA2ANl6lPRstjEhYYq33SWXEnTj2zUEseqX8UkQr3
         HzLbFj5xBGigmbdmCrrcjytIFr7DRYC+6JrqhVri7ZbX1HRxilv/H1IpMHCIesNLgBoZ
         PSlvEKAeLSnIWQ6DkQgcNfFaBmFpkqVfZESt3Vx3qdDXyzKLlwbEW6AdWJUOJ9nvhWkq
         1BDPKC8QuIbX7LH/QeyFnacEjmtfl1uc0FCwL6kyglMIJYtyFArwXpNVxPGz1cHnqtcw
         iIChpWGrWzHZV6oBkX3v3YjGQzRJLg1BR0fSsvSwHZTa6npDdHytnkQQC+nJIxuCBGwf
         63iQ==
X-Gm-Message-State: AOUpUlFUjmv0qDZVbLVIoyMOk4U1fLgaKWN4CtjEvDD/5zY1eRaM26Bi
        RXs5wbMEiRRJO2PvnhSTO7i5vg==
X-Google-Smtp-Source: AAOMgpckRAYy9vorc4eMVCQ1Uc5x51WbaAcr5KT0f6sPPmsBT/dX4REx1PziWt7qxPnzxNWYQXu1Yw==
X-Received: by 2002:a1c:3314:: with SMTP id z20-v6mr11558447wmz.95.1533573657895;
        Mon, 06 Aug 2018 09:40:57 -0700 (PDT)
Received: from andreyknvl0.muc.corp.google.com ([2a00:79e0:15:10:84be:a42a:826d:c530])
        by smtp.gmail.com with ESMTPSA id 66-v6sm16385790wmw.34.2018.08.06.09.40.56
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 06 Aug 2018 09:40:57 -0700 (PDT)
From:   Andrey Konovalov <andreyknvl@google.com>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Andrey Konovalov <andreyknvl@google.com>,
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
        Chintan Pandya <cpandya@codeaurora.org>
Subject: [PATCH v5 03/10] arm64: untag user addresses in access_ok and __uaccess_mask_ptr
Date:   Mon,  6 Aug 2018 18:40:38 +0200
Message-Id: <b0291dd0d487592ed5d62f6fb3e2a5bb97ddc359.1533573460.git.andreyknvl@google.com>
X-Mailer: git-send-email 2.18.0.597.ga71716f1ad-goog
In-Reply-To: <cover.1533573460.git.andreyknvl@google.com>
References: <cover.1533573460.git.andreyknvl@google.com>
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

Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
---
 arch/arm64/include/asm/uaccess.h | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/include/asm/uaccess.h b/arch/arm64/include/asm/uaccess.h
index 2d6451cbaa86..fa7318d3d7d5 100644
--- a/arch/arm64/include/asm/uaccess.h
+++ b/arch/arm64/include/asm/uaccess.h
@@ -105,7 +105,8 @@ static inline unsigned long __range_ok(const void __user *addr, unsigned long si
 #define untagged_addr(addr)		\
 	((__typeof__(addr))sign_extend64((__u64)(addr), 55))
 
-#define access_ok(type, addr, size)	__range_ok(addr, size)
+#define access_ok(type, addr, size)	\
+	__range_ok(untagged_addr(addr), size)
 #define user_addr_max			get_fs
 
 #define _ASM_EXTABLE(from, to)						\
@@ -237,7 +238,8 @@ static inline void uaccess_enable_not_uao(void)
 
 /*
  * Sanitise a uaccess pointer such that it becomes NULL if above the
- * current addr_limit.
+ * current addr_limit. In case the pointer is tagged (has the top byte set),
+ * untag the pointer before checking.
  */
 #define uaccess_mask_ptr(ptr) (__typeof__(ptr))__uaccess_mask_ptr(ptr)
 static inline void __user *__uaccess_mask_ptr(const void __user *ptr)
@@ -245,10 +247,11 @@ static inline void __user *__uaccess_mask_ptr(const void __user *ptr)
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
2.18.0.597.ga71716f1ad-goog

