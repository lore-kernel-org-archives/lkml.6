Return-Path: <SRS0=OLKc=O6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FROM,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A84F7C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 18:14:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7A6CE21920
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 18:14:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N2niqEom"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404284AbeLUSOt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Dec 2018 13:14:49 -0500
Received: from mail-lj1-f193.google.com ([209.85.208.193]:44811 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725814AbeLUSOs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Dec 2018 13:14:48 -0500
Received: by mail-lj1-f193.google.com with SMTP id k19-v6so5507732lji.11;
        Fri, 21 Dec 2018 10:14:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references:reply-to
         :mime-version:content-transfer-encoding;
        bh=9pkoDpWnQ0hyqDvaxlvdmZrME9c2qqzlc2zOv6te5xY=;
        b=N2niqEomFo+rals4bkw3xGbTBjGwxa/HjF9TepnB4pLUjTMQIoZ7v9NVFAHvYtA9gY
         /0oYQRkwRCEM/u8qr8aLfkPZbFq08vKAZrJbeRw+uPsmd1krMueHpwqVSWjWPyHJzZaw
         PZNRYzHlOXJQisYA87u0/ENAQ4P71tLBmcdqbPDndtRNBd4/Iko2g/ZGDVNsdjKMAj6O
         HEe4/wIgfiQh4kQzYdNojImGEYlQXTiGQwU/CvMINRzDx+6hF2dWBiUbCqC8PVrSR4RO
         zs+3oyb3DLgLu8gImsLRxllVJm3T8bTtcMSk7ZqGUzsimoakWJXB9iCFE24/c/a4ekVm
         7ZRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:reply-to:mime-version:content-transfer-encoding;
        bh=9pkoDpWnQ0hyqDvaxlvdmZrME9c2qqzlc2zOv6te5xY=;
        b=NVqXG+BFhbt2A/vL/JEC4ALdmu2D2r700TDJa9iSSW1qcdLJhxErj1RdQLZ0LkvJgs
         PAnUjfO3XSB15XyGSrKb1WXFFdAEw8LKdMHvJ7wOqh0F9dpdrFo3J7OIuAieA/606Ezz
         FWaLt9zWHQs4nLeY8vWdr7RUK9GIUo9nxeORrKnhOQcctvBg/R4jg8aHOPW/bUzRF0wK
         /6xyjQB2PHgKk5Igu5kB9s3JkPkqTsd3mTjRCge2yfwYtaPffrgSmIu+1RS4PKE6inyN
         x6OEdMbYOFonv+gQnBgRX3rvMUTCU5g6IH51S/BRZWMyXhf9//OUgNmXZR6qD64Nzrfa
         VOFA==
X-Gm-Message-State: AJcUukfF+KmPbk8Sh/UETMumFGzhH7+grPDRBuQdxuxGihhqx5U46CAC
        EAHVrhU7EXbfZIRpOdnnwkA=
X-Google-Smtp-Source: AFSGD/XIkFyHzT2h0WZYCzCstedNVsVpCOdIZJXFreII8gK7lJaMNaWsCWFp0aHljWPuf+HZlBsPEQ==
X-Received: by 2002:a2e:908b:: with SMTP id l11-v6mr2285752ljg.150.1545416086374;
        Fri, 21 Dec 2018 10:14:46 -0800 (PST)
Received: from localhost.localdomain (dmhwpt3bffxn8z3-j6k-4.rev.dnainternet.fi. [2001:14bb:51:a4c8:5c24:24d7:ca5f:e7d2])
        by smtp.gmail.com with ESMTPSA id m63-v6sm5444564lje.81.2018.12.21.10.14.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 21 Dec 2018 10:14:45 -0800 (PST)
From:   Igor Stoppa <igor.stoppa@gmail.com>
X-Google-Original-From: Igor Stoppa <igor.stoppa@huawei.com>
To:     Andy Lutomirski <luto@amacapital.net>,
        Matthew Wilcox <willy@infradead.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Mimi Zohar <zohar@linux.vnet.ibm.com>,
        Thiago Jung Bauermann <bauerman@linux.ibm.com>
Cc:     igor.stoppa@huawei.com, Nadav Amit <nadav.amit@gmail.com>,
        Kees Cook <keescook@chromium.org>,
        Ahmed Soliman <ahmedsoliman@mena.vt.edu>,
        linux-integrity@vger.kernel.org,
        kernel-hardening@lists.openwall.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 01/12] x86_64: memset_user()
Date:   Fri, 21 Dec 2018 20:14:12 +0200
Message-Id: <20181221181423.20455-2-igor.stoppa@huawei.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181221181423.20455-1-igor.stoppa@huawei.com>
References: <20181221181423.20455-1-igor.stoppa@huawei.com>
Reply-To: Igor Stoppa <igor.stoppa@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Create x86_64 specific version of memset for user space, based on
clear_user().
This will be used for implementing wr_memset() in the __wr_after_init
scenario, where write-rare variables have an alternate mapping for
writing.

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
 arch/x86/lib/usercopy_64.c        | 54 +++++++++++++++++++++++++++++++
 2 files changed, 60 insertions(+)

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
index 1bd837cdc4b1..84f8f8a20b30 100644
--- a/arch/x86/lib/usercopy_64.c
+++ b/arch/x86/lib/usercopy_64.c
@@ -9,6 +9,60 @@
 #include <linux/uaccess.h>
 #include <linux/highmem.h>
 
+/*
+ * Memset Userspace
+ */
+
+unsigned long __memset_user(void __user *addr, int c, unsigned long size)
+{
+	long __d0;
+	unsigned long  pattern = 0;
+	int i;
+
+	for (i = 0; i < 8; i++)
+		pattern = (pattern << 8) | (0xFF & c);
+	might_fault();
+	/* no memory constraint: gcc doesn't know about this memory */
+	stac();
+	asm volatile(
+		"       movq %[val], %%rdx\n"
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
+		: [size1] "r"(size & 7), "[size8]" (size / 8), "[dst]"(addr),
+		  [val] "ri"(pattern)
+		: "rdx");
+
+	clac();
+	return size;
+}
+EXPORT_SYMBOL(__memset_user);
+
+unsigned long memset_user(void __user *to, int c, unsigned long n)
+{
+	if (access_ok(VERIFY_WRITE, to, n))
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

