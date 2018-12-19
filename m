Return-Path: <SRS0=MnXf=O4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1DA6C43387
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 21:34:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8ABC02086C
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 21:34:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="vGTkPcUF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730831AbeLSVee (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Dec 2018 16:34:34 -0500
Received: from mail-lj1-f196.google.com ([209.85.208.196]:36559 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730563AbeLSVe2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Dec 2018 16:34:28 -0500
Received: by mail-lj1-f196.google.com with SMTP id g11-v6so18715735ljk.3;
        Wed, 19 Dec 2018 13:34:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references:reply-to
         :mime-version:content-transfer-encoding;
        bh=nF+ce+AsD/YO6oFhBzoP5bXERd0j3/JBWm1ePv97n+k=;
        b=vGTkPcUFo/MMtKaWdBnUN7Wr0yJwxwfs21G27pnVV2k1BB2gRhB1bK7E0cHhYbqIgf
         stDCnsHWMfyP+yrG6oDmTMF96qa/BaUh7n6LG+3tu8TfXBh5Wu8DfaY+PV6lNfvBRdKh
         hNQbHgauq8nMJyjwqmvZjnwDRCxA5mLVfzWQ0bVZJe+zeth1/NOc5HzIGqpMFr/Qrlqx
         aAsQZ/q+cAxCC45Usqy0Xty8HNLpuBvEXpaPgWZc396htU9HqMdTxdiPYyjkaNHn7myJ
         xkIvhC2HOtkTyU5OhrA1C4U6i8nYCJDolSU8uTM4BXBZOybG0Kkmw2kFOsIZCZuoWSro
         lNVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:reply-to:mime-version:content-transfer-encoding;
        bh=nF+ce+AsD/YO6oFhBzoP5bXERd0j3/JBWm1ePv97n+k=;
        b=c29aAqG/aiES3wMGqW5NYipdcI5R5kxD6T6FW+vzOSJHLPilZou42iS6MTCTeKjopF
         kVSUKreQU1Ug/TszktDUDKTXUdVdZfuup0QcbKz1dE0oi90+CsQqqVYWk5K4EDATjsdG
         K8YIaRD/IVj/xAyYTNIFK0Wdn13OQFh6d/D2sJIAgiWtwxpwwBm1f3pIHt/v1vVw7O+d
         ifRSY231NfW0eX7HLKbzdqz4Tl+L2MNHlPD7+PYz1/dMXVCFUyOquiYstTLShcmfcQeh
         eR0hAa5TY1/fBdIjiliW5je0Yu+DzbNHY1lQr2vjh6F1vkA+VjFwHik8qkwwQv/NWaiz
         l6uQ==
X-Gm-Message-State: AA+aEWaa1ZK1K4lSqRJ2GussN/iloVyF7EswsnGx1OluY9u0V6zPInc/
        6b4ctQO0hcFLsbAHMnGXw5g=
X-Google-Smtp-Source: AFSGD/Wy2ENV+x3psGq5BTNSnjgWTYu45qYohRv5i5VPwG4fDvqlbGM3fM6N3dl/AyW8xTUnzykvyA==
X-Received: by 2002:a2e:4601:: with SMTP id t1-v6mr15007443lja.111.1545255266361;
        Wed, 19 Dec 2018 13:34:26 -0800 (PST)
Received: from localhost.localdomain (dmhwpt3bffxn8z3-j6k-4.rev.dnainternet.fi. [2001:14bb:51:a4c8:5c24:24d7:ca5f:e7d2])
        by smtp.gmail.com with ESMTPSA id v64sm3996867lfa.48.2018.12.19.13.34.24
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 19 Dec 2018 13:34:25 -0800 (PST)
From:   Igor Stoppa <igor.stoppa@gmail.com>
X-Google-Original-From: Igor Stoppa <igor.stoppa@huawei.com>
To:     Andy Lutomirski <luto@amacapital.net>,
        Matthew Wilcox <willy@infradead.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Mimi Zohar <zohar@linux.vnet.ibm.com>
Cc:     igor.stoppa@huawei.com, Nadav Amit <nadav.amit@gmail.com>,
        Kees Cook <keescook@chromium.org>,
        linux-integrity@vger.kernel.org,
        kernel-hardening@lists.openwall.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 12/12] x86_64: __clear_user as case of __memset_user
Date:   Wed, 19 Dec 2018 23:33:38 +0200
Message-Id: <20181219213338.26619-13-igor.stoppa@huawei.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181219213338.26619-1-igor.stoppa@huawei.com>
References: <20181219213338.26619-1-igor.stoppa@huawei.com>
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

