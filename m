Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A138DC282CE
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 23:28:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 67614214DA
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 23:28:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SKFOea9c"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727913AbfBKX2O (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 18:28:14 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:41186 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727132AbfBKX2N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 18:28:13 -0500
Received: by mail-wr1-f67.google.com with SMTP id x10so650007wrs.8;
        Mon, 11 Feb 2019 15:28:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references:reply-to
         :mime-version:content-transfer-encoding;
        bh=ENlTYT6F8yKSgZtSKFAMRVhy2HT+kX2kAlJukSMyeJE=;
        b=SKFOea9clX8kUXjGvLOkAz78zIlXk2l9cAAdszRgpu1WF9+EGlYZ09jCNchdkbmaC2
         8XMzc6EJ4es6RG4yfh8iz6ilF2S8pczy501Lmx3sA+5GTPr5jyKxupxht3iJJYNzHPRS
         dO1Oa2gDPDloNIEL1xoGnm/CWJGTqTk1SNhdetFi8dolnrUHFwi/G35FNwjA4uv5Gq6P
         lQIguAmqnvp87zrCaSOSlTQeiVXRq6JEBjr/N+0tXSKavkX6Ny/HsOH/xnab0RoGwCxf
         2KKeYRqX32cxYQVHhTMaY3YMwATRdRiYfiIA4uI0CuPSdMythsBD+LWEu2/dIFo1YPUL
         MQUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:reply-to:mime-version:content-transfer-encoding;
        bh=ENlTYT6F8yKSgZtSKFAMRVhy2HT+kX2kAlJukSMyeJE=;
        b=UMMfF+7/hdijXVYn6v6vcPqmY5tjIfbcMLfTnQYvGUKc7Kxr6OK1E2x3u3ZezxwSeC
         WUjBv4n8qWcGoh48YeKTkPN7XheH7QVZO6+03PwW8qN0FOlTy5+86t9CNpLLaWBILDJ/
         K2jidMF47MuUnpxHG9uDgCTJpDtGS7UgjaJ4kljrHsN5djWrNoC3QFV5zL0ep9qTZErp
         /mF1S5OvcPjA3Qoe+YY7lY/zOMemcSoIVf51etfxa+INLPSTC30vaSFnYs80GIz/CGbA
         gcp0IcHhJa4Zt7+bxXvwlSixG9b0XVDHbQctMDFm2Df253pIajftEcJmP23q+TPzBgIH
         rQBg==
X-Gm-Message-State: AHQUAuZCdZCGgMNv6mjm/3gN83TAgsOIzCBL/HS7v8/vlEFMNLeZA/G7
        DRYRwbkViVOW1vlkRFslCbQ=
X-Google-Smtp-Source: AHgI3Ib9SM/GU3OSZIUw9Ef85LumnojTRalWrCht9QSJZfsd1LMbft46iDmaDh0LxziZQABUjeSKgA==
X-Received: by 2002:adf:e290:: with SMTP id v16mr532903wri.100.1549927691315;
        Mon, 11 Feb 2019 15:28:11 -0800 (PST)
Received: from localhost.localdomain (bba134232.alshamil.net.ae. [217.165.113.120])
        by smtp.gmail.com with ESMTPSA id e67sm1470295wmg.1.2019.02.11.15.28.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 11 Feb 2019 15:28:10 -0800 (PST)
From:   Igor Stoppa <igor.stoppa@gmail.com>
X-Google-Original-From: Igor Stoppa <igor.stoppa@huawei.com>
Cc:     Igor Stoppa <igor.stoppa@huawei.com>,
        Andy Lutomirski <luto@amacapital.net>,
        Nadav Amit <nadav.amit@gmail.com>,
        Matthew Wilcox <willy@infradead.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Kees Cook <keescook@chromium.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Mimi Zohar <zohar@linux.vnet.ibm.com>,
        Thiago Jung Bauermann <bauerman@linux.ibm.com>,
        Ahmed Soliman <ahmedsoliman@mena.vt.edu>,
        linux-integrity@vger.kernel.org,
        kernel-hardening@lists.openwall.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: [RFC PATCH v4 02/12] __wr_after_init: x86_64: memset_user()
Date:   Tue, 12 Feb 2019 01:27:39 +0200
Message-Id: <afc5b052d43606a3d53e674fb2e36abbf984c516.1549927666.git.igor.stoppa@huawei.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <cover.1549927666.git.igor.stoppa@huawei.com>
References: <cover.1549927666.git.igor.stoppa@huawei.com>
Reply-To: Igor Stoppa <igor.stoppa@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

x86_64 specific version of memset() for user space, memset_user()

In the __wr_after_init scenario, write-rare variables have:
- a primary read-only mapping in kernel memory space
- an alternate, writable mapping, implemented as user-space mapping

The write rare implementation expects the arch code to privide a
memset_user() function, which is currently missing.

clear_user() is the base for memset_user()

Signed-off-by: Igor Stoppa <igor.stoppa@huawei.com>

CC: Andy Lutomirski <luto@amacapital.net>
CC: Nadav Amit <nadav.amit@gmail.com>
CC: Matthew Wilcox <willy@infradead.org>
CC: Peter Zijlstra <peterz@infradead.org>
CC: Kees Cook <keescook@chromium.org>
CC: Dave Hansen <dave.hansen@linux.intel.com>
CC: Mimi Zohar <zohar@linux.vnet.ibm.com>
CC: Thiago Jung Bauermann <bauerman@linux.ibm.com>
CC: Ahmed Soliman <ahmedsoliman@mena.vt.edu>
CC: linux-integrity@vger.kernel.org
CC: kernel-hardening@lists.openwall.com
CC: linux-mm@kvack.org
CC: linux-kernel@vger.kernel.org
---
 arch/x86/include/asm/uaccess_64.h |  6 ++++
 arch/x86/lib/usercopy_64.c        | 51 +++++++++++++++++++++++++++++++++
 2 files changed, 57 insertions(+)

diff --git a/arch/x86/include/asm/uaccess_64.h b/arch/x86/include/asm/uaccess_64.h
index a9d637bc301d..f194bfce4866 100644
--- a/arch/x86/include/asm/uaccess_64.h
+++ b/arch/x86/include/asm/uaccess_64.h
@@ -213,4 +213,10 @@ copy_user_handle_tail(char *to, char *from, unsigned len);
 unsigned long
 mcsafe_handle_tail(char *to, char *from, unsigned len);
 
+unsigned long __must_check
+memset_user(void __user *mem, int c, unsigned long len);
+
+unsigned long __must_check
+__memset_user(void __user *mem, int c, unsigned long len);
+
 #endif /* _ASM_X86_UACCESS_64_H */
diff --git a/arch/x86/lib/usercopy_64.c b/arch/x86/lib/usercopy_64.c
index ee42bb0cbeb3..e61963585354 100644
--- a/arch/x86/lib/usercopy_64.c
+++ b/arch/x86/lib/usercopy_64.c
@@ -9,6 +9,57 @@
 #include <linux/uaccess.h>
 #include <linux/highmem.h>
 
+/*
+ * Memset Userspace
+ */
+
+unsigned long __memset_user(void __user *addr, int c, unsigned long size)
+{
+	long __d0;
+	unsigned long  pattern = 0x0101010101010101UL * (0xFFUL & c);
+
+	might_fault();
+	/* no memory constraint: gcc doesn't know about this memory */
+	stac();
+	asm volatile(
+		"	movq %[pattern], %%rdx\n"
+		"	testq  %[size8],%[size8]\n"
+		"	jz     4f\n"
+		"0:	mov %%rdx,(%[dst])\n"
+		"	addq   $8,%[dst]\n"
+		"	decl %%ecx ; jnz   0b\n"
+		"4:	movq  %[size1],%%rcx\n"
+		"	testl %%ecx,%%ecx\n"
+		"	jz     2f\n"
+		"1:	movb   %%dl,(%[dst])\n"
+		"	incq   %[dst]\n"
+		"	decl %%ecx ; jnz  1b\n"
+		"2:\n"
+		".section .fixup,\"ax\"\n"
+		"3:	lea 0(%[size1],%[size8],8),%[size8]\n"
+		"	jmp 2b\n"
+		".previous\n"
+		_ASM_EXTABLE_UA(0b, 3b)
+		_ASM_EXTABLE_UA(1b, 2b)
+		: [size8] "=&c"(size), [dst] "=&D" (__d0)
+		: [size1] "r" (size & 7), "[size8]" (size / 8),
+		  "[dst]" (addr), [pattern] "r" (pattern)
+		: "rdx");
+
+	clac();
+	return size;
+}
+EXPORT_SYMBOL(__memset_user);
+
+unsigned long memset_user(void __user *to, int c, unsigned long n)
+{
+	if (access_ok(to, n))
+		return __memset_user(to, c, n);
+	return n;
+}
+EXPORT_SYMBOL(memset_user);
+
+
 /*
  * Zero Userspace
  */
-- 
2.19.1

