Return-Path: <SRS0=PZjb=LN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16D7FC433F5
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 11:42:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C16112084D
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 11:42:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="qhLN0+Xl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C16112084D
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728734AbeH3PoG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Aug 2018 11:44:06 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:50785 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728231AbeH3PnJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Aug 2018 11:43:09 -0400
Received: by mail-wm0-f68.google.com with SMTP id s12-v6so1656965wmc.0
        for <linux-kernel@vger.kernel.org>; Thu, 30 Aug 2018 04:41:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=LhBQZOJZ5CY1iejYHh5r+OO80KOFbC9w+x7Kw+7XH2c=;
        b=qhLN0+XlBq6jHDTlSlKfMMmJjUqASaVSiAZ0zywVXpAg+VpUOeqdiJHj/wArfR65XG
         Ut3JLptVruN/PBv/xjcMUVNG81WIKCO+dMG9qK6HWxTAtR/EtQB8CpaH9QF+IGCW4BWn
         YSmQMOUq6FSuRhvb8AempV8E+YLZPSUlE4hF2263DyPfege/APAPyWSrGUaOUqwNEiw3
         O4IibHRF1/nN9/UDdjKaDCSYnTyG5+kjDhFJC2srV9nASdDLL5E5WdrKISQHKKrQN0eP
         M8nLl+weFtfn/3yYYPWxYTFB3bviLyYR2P+BrZHk7c4uvaVyPrL5NiMZclTO4/7ZClBg
         Xtfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=LhBQZOJZ5CY1iejYHh5r+OO80KOFbC9w+x7Kw+7XH2c=;
        b=HRjAJAe7T+1d5+uyffDcRNaXXwPD/KDpffByQksgTQWe1K6E8eSBBiMwGlLNAbDQaL
         NFsGGAZB2kqvZr+CRGQ+t5OVszKt8eLA8T+vyQxP1GwUJUygtPqdMXXm2Rbw+BLpyVcQ
         oxDouGpPQz64vmjGd/KXEGzhwDiTSH+KLA2PNeOF+G4Zo/2yaTYutLQ8BtVgyihSVYkm
         CgKD4/X01Tv6q+aGecAZ6WotQhW8Z1CAZ489qS3w1fCR2Ai65YqgJOkX/WqaXbbl6MQc
         kGnPEsig3w8GEV0RnfmfVdgMsvFBHB/7kiLvYwMLMWIEnRXLyHfCGNX3eBc3D17CreqS
         cVMA==
X-Gm-Message-State: APzg51Ad4BFAC5g6jwuePJPAneCa/r9310tHz26iQxRC4EJ9EVheEAFi
        N3oGbOP2Dd6ea61Nqn9rVoNPAg==
X-Google-Smtp-Source: ANB0Vdb475utvdy0BbImRrjLj8t24oq22bP1K+3VkFe8W8AFPMSWX/v25NfkMksN2tme/fdtdkw3XA==
X-Received: by 2002:a1c:7915:: with SMTP id l21-v6mr1693369wme.136.1535629285313;
        Thu, 30 Aug 2018 04:41:25 -0700 (PDT)
Received: from andreyknvl0.muc.corp.google.com ([2a00:79e0:15:10:84be:a42a:826d:c530])
        by smtp.gmail.com with ESMTPSA id z184-v6sm2175218wmz.0.2018.08.30.04.41.24
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 30 Aug 2018 04:41:24 -0700 (PDT)
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
Subject: [PATCH v6 03/11] arm64: untag user addresses in access_ok and __uaccess_mask_ptr
Date:   Thu, 30 Aug 2018 13:41:08 +0200
Message-Id: <7a37e7363328f4aa10706c0294242eaa5e4e9e89.1535629099.git.andreyknvl@google.com>
X-Mailer: git-send-email 2.19.0.rc0.228.g281dcd1b4d0-goog
In-Reply-To: <cover.1535629099.git.andreyknvl@google.com>
References: <cover.1535629099.git.andreyknvl@google.com>
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
2.19.0.rc0.228.g281dcd1b4d0-goog

