Return-Path: <SRS0=fmpj=NT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F12D4ECDE4B
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 14:37:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BA2012081D
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 14:37:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Gb16Vd2d"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BA2012081D
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727369AbeKIAMs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Nov 2018 19:12:48 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:37589 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727020AbeKIAML (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Nov 2018 19:12:11 -0500
Received: by mail-wr1-f66.google.com with SMTP id o15-v6so17865467wrv.4
        for <linux-kernel@vger.kernel.org>; Thu, 08 Nov 2018 06:36:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ZukT/dUNa0Ny3ny2vQGy46SLKrS4BO5zDkycm6cPI6U=;
        b=Gb16Vd2d0GXy5xJf7uLbCjmyiyGw/kcSiV09tZGqiQS4c5FjYJ3DtSN2p78sD5NL8J
         Yu3Tm1nBUr0JKb06DFlm/sg9OAiHkeadtA96DatQGcvTFe0X3Yz+4u38QKXuYLFWQO7r
         ZdZsPI9cYA8WnpK58iVCPR7x7p4ad7K+2zNIHukMlIO53UKw88ProRAPC5E38UFgnPMs
         8hnZ2mwMMoRYlZguF9kBwPkQlLU++3vd4fcGsGzi7ZHuhrMejEt3cElmosvTCXG3RQvw
         z0RTxmozNtOBom8mwr04OoYOPb09mO9j0TiB1QnplSc3B0LSA5GOBmg8attUfsmiPLR9
         tp+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ZukT/dUNa0Ny3ny2vQGy46SLKrS4BO5zDkycm6cPI6U=;
        b=AovBpKGUwp7Xkq4CRECy3kRvIcCtvlkjzGNeb2SSwRNZvjyPW6hGAvT1LQHt6q1qRF
         5MVjz2EtT2PpU6mnZuH6YcyJvedDAB5T6ma83E0MT6gcrQKXeOnGQX+qzXdwcruzi5mH
         Ce1e/ypWIZrSj+YuWPHOGohI9xt670yE3f2POioxGrtIehDKNYN3t5ARz3CJHx7eAG3c
         2lhvHIv97TCgfOYPQhIgcknGNjHUTISoX9aM1Y41cFwdVfIV6JfGII3HJfE9PsYWNUAC
         i156/3wf85iKFHdvg8PqeIsI2xUqmaqNAV+es2FYWHWXe9VfALkhdf/mCOHqKoryF7Ui
         uIxQ==
X-Gm-Message-State: AGRZ1gJIekjv2Vs7NgppDiPZqPQyZYXGf6cxyP6KJ3BeqnIypWCkQGxJ
        jMQ/6VMIZYbWHRfdWBkjjrDmuA==
X-Google-Smtp-Source: AJdET5fkqa1ke/P7dlhhjrTblVnNyY5imtamk9/f/3V2XeRRGv6evK6z/uB52BsyTEJj+iulX88T8Q==
X-Received: by 2002:a5d:4b05:: with SMTP id v5-v6mr4238564wrq.5.1541687784492;
        Thu, 08 Nov 2018 06:36:24 -0800 (PST)
Received: from andreyknvl0.muc.corp.google.com ([2a00:79e0:15:10:84be:a42a:826d:c530])
        by smtp.gmail.com with ESMTPSA id k5-v6sm5421068wre.82.2018.11.08.06.36.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 08 Nov 2018 06:36:23 -0800 (PST)
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
Subject: [PATCH v8 3/8] arm64: untag user addresses in access_ok and __uaccess_mask_ptr
Date:   Thu,  8 Nov 2018 15:36:10 +0100
Message-Id: <b23c2374235a33328817f2586cc055c69d91a2ec.1541687720.git.andreyknvl@google.com>
X-Mailer: git-send-email 2.19.1.930.g4563a0d9d0-goog
In-Reply-To: <cover.1541687720.git.andreyknvl@google.com>
References: <cover.1541687720.git.andreyknvl@google.com>
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
index c1325271e368..abc35cba134b 100644
--- a/arch/arm64/include/asm/uaccess.h
+++ b/arch/arm64/include/asm/uaccess.h
@@ -104,7 +104,8 @@ static inline unsigned long __range_ok(const void __user *addr, unsigned long si
 #define untagged_addr(addr)		\
 	((__typeof__(addr))sign_extend64((__u64)(addr), 55))
 
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
2.19.1.930.g4563a0d9d0-goog

