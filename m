Return-Path: <SRS0=OLKc=O6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FROM,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79889C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 18:15:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4745821920
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 18:15:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ii7ELF8/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404456AbeLUSPZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Dec 2018 13:15:25 -0500
Received: from mail-lj1-f194.google.com ([209.85.208.194]:35020 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404409AbeLUSPL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Dec 2018 13:15:11 -0500
Received: by mail-lj1-f194.google.com with SMTP id x85-v6so5542522ljb.2;
        Fri, 21 Dec 2018 10:15:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references:reply-to
         :mime-version:content-transfer-encoding;
        bh=SF4qk+bTzK3es4UM9b0qE6afh8/8sQWLd3sxWcWkQd8=;
        b=Ii7ELF8/5y1rVaPhHiLhgDtq4P7/rfzqXnM3EeCH5GRSr2Kq2zzNF5t8kZw3ND0+a6
         10vlyhvH2ZArYPGzD8PwHtf9EFg96E8dJK8mNhL944qEkX0oPwo3++zWdGQklQ9CWU8B
         ETzu3Boaxa10N5Nt8r1xtE9gTtRaR9kkLpPgE8BLmp1z/ycZC0NNjjNhkSeV27VB58Vh
         cylWppIJrf8u0uC15//e4cctuMhk9qlnQyspjtHkl2k33XBKfEPLw9N9gKQ8QuMGKnxR
         26HLuc8Ps/OA9fdgIFgv2Zi8d3KV46SAyUsiabS45ayIX64sTa1CQlIsMkc80vD0t48o
         vIng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:reply-to:mime-version:content-transfer-encoding;
        bh=SF4qk+bTzK3es4UM9b0qE6afh8/8sQWLd3sxWcWkQd8=;
        b=QO7Ash7ubOi6u24zTItpWTGTFzzjqXscZAR7qA3MjsJOcKBC2+QDAB2sPL2somqMWq
         2Fk3/d4q42OnMDutr8gagWfQLXBCErGlKln+uP8pla7AVreEf+ZQ0EZIQ3omy7+YsCgu
         OswePuBxcJXyLRkD4dvQSXWDXxDQRYjsbbMSu6lSnmKLQ/DxZiFYysV1tV6mnU5SgN/t
         y+1DOcLkzv81fPOYQhDdH1x0sWyTgTOgyaJNSkP5xLzKf0zirAmmylU3bv4tx2CHXZcf
         d/BoymiaonCcSrZASvn8PVOxiOwDz3hWEjbo4Poov/rsxHCjweLQ0rk0hDbA1sRPWlkN
         rUEA==
X-Gm-Message-State: AA+aEWbimjMsqtEZZdp+whwtyfOg+l/CfYtqcJfdizk/0heNjTGqf/iQ
        fRMA+dLWn8v1RYWuUZj3RyA=
X-Google-Smtp-Source: AFSGD/U5nUYrabzF4bcWijW9jX9KfZDA5WG1g0TgA4b42uvAMM3t6RmJ/Cf3Ft6Rt3AgJtUscpiQGw==
X-Received: by 2002:a2e:9cd2:: with SMTP id g18-v6mr2461814ljj.161.1545416109279;
        Fri, 21 Dec 2018 10:15:09 -0800 (PST)
Received: from localhost.localdomain (dmhwpt3bffxn8z3-j6k-4.rev.dnainternet.fi. [2001:14bb:51:a4c8:5c24:24d7:ca5f:e7d2])
        by smtp.gmail.com with ESMTPSA id m63-v6sm5444564lje.81.2018.12.21.10.15.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 21 Dec 2018 10:15:08 -0800 (PST)
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
Subject: [PATCH 12/12] x86_64: __clear_user as case of __memset_user
Date:   Fri, 21 Dec 2018 20:14:23 +0200
Message-Id: <20181221181423.20455-13-igor.stoppa@huawei.com>
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

To avoid code duplication, re-use __memset_user(), when clearing
user-space memory.

The overhead should be minimal (2 extra register assignments) and
outside of the writing loop.

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
 arch/x86/lib/usercopy_64.c | 29 +----------------------------
 1 file changed, 1 insertion(+), 28 deletions(-)

diff --git a/arch/x86/lib/usercopy_64.c b/arch/x86/lib/usercopy_64.c
index 84f8f8a20b30..ab6aabb62055 100644
--- a/arch/x86/lib/usercopy_64.c
+++ b/arch/x86/lib/usercopy_64.c
@@ -69,34 +69,7 @@ EXPORT_SYMBOL(memset_user);
 
 unsigned long __clear_user(void __user *addr, unsigned long size)
 {
-	long __d0;
-	might_fault();
-	/* no memory constraint because it doesn't change any memory gcc knows
-	   about */
-	stac();
-	asm volatile(
-		"	testq  %[size8],%[size8]\n"
-		"	jz     4f\n"
-		"0:	movq $0,(%[dst])\n"
-		"	addq   $8,%[dst]\n"
-		"	decl %%ecx ; jnz   0b\n"
-		"4:	movq  %[size1],%%rcx\n"
-		"	testl %%ecx,%%ecx\n"
-		"	jz     2f\n"
-		"1:	movb   $0,(%[dst])\n"
-		"	incq   %[dst]\n"
-		"	decl %%ecx ; jnz  1b\n"
-		"2:\n"
-		".section .fixup,\"ax\"\n"
-		"3:	lea 0(%[size1],%[size8],8),%[size8]\n"
-		"	jmp 2b\n"
-		".previous\n"
-		_ASM_EXTABLE_UA(0b, 3b)
-		_ASM_EXTABLE_UA(1b, 2b)
-		: [size8] "=&c"(size), [dst] "=&D" (__d0)
-		: [size1] "r"(size & 7), "[size8]" (size / 8), "[dst]"(addr));
-	clac();
-	return size;
+	return __memset_user(addr, 0, size);
 }
 EXPORT_SYMBOL(__clear_user);
 
-- 
2.19.1

