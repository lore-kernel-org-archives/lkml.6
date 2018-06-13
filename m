Return-Path: <SRS0=lWsm=I7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	T_DKIMWL_WL_MED,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 3AA7EC004E4
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 21:05:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E3FA7208C4
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 21:05:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="UXND3AnE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E3FA7208C4
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935920AbeFMVFp (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Jun 2018 17:05:45 -0400
Received: from mail-pl0-f68.google.com ([209.85.160.68]:35332 "EHLO
        mail-pl0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935864AbeFMVFl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jun 2018 17:05:41 -0400
Received: by mail-pl0-f68.google.com with SMTP id k1-v6so2234136plt.2
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jun 2018 14:05:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Zqjot39DunbhP4pkC0JAzSp9fG4S1vlyBqgNYKwMT10=;
        b=UXND3AnEyhnCy7ajoyJPB3EYpwN5YK5as8jWkaIHLrSIplRLf9fUGIlvXMSVGUnUn/
         ps5ljNZAU7HiGIlH4PIgBYEol1LiUuKe/W2zP0Ixiv6PdhxIEx0zNT/Ui+aeEc7315zU
         drL5XpMiJO576PyJxpA+Fe3MNJKjV5ojfm3eN5ABMLexBVaFU961cSXzIovmBcTRRnfm
         UKtvvUsKy1I7TTG3/P/IpPXNF9tU3zeR03TS4GJqnfqSQS/yyv0a+MWVwJgB/fzWm6nL
         i72+XS99lRLlUcPwMTVZtFGjgqpWp+kqT7hZE/2s+MyF0SKf40gzxC8LoK6IsMUsh6Le
         fo1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Zqjot39DunbhP4pkC0JAzSp9fG4S1vlyBqgNYKwMT10=;
        b=E0fJ5BTH5IxUghK5KpFueRjCbUHxG+0BWjTDOxlEK2LYHpsJyL157pvReTsL8jSp0i
         A0kkeH/e1NoxIqEUVKjnA0a2pxzvEfV9g8/rwLVcASJGCSMbWxzKnjg0tVucvgSWKp9t
         aPNuh7ZxR66+Eq6ppQ8EqFgRfTGgfujEF0Jt7vMZJkK/VMwx4tHTAhtkeJiH2AkGh6Gj
         FS9qi4xNAys5sil5YMV/neMHz767dtoqi0kI/fng2S7ar1cc/iXvbDr+TNduACSC5Tqm
         ptu9Ai4WKGwNhcfyVVsHhIqNubwQGQnWNYmA+/CDzlW8W6gtJDHIpw4bF9FJjJ7xYrhF
         Mb1g==
X-Gm-Message-State: APt69E1YMZiLzZzbjhHc0ef/xCmsunsqXlB9jArIXRpd2p6YcIacJS8P
        xskl8SIV/fX9Pbej9xw8oJjjfg==
X-Google-Smtp-Source: ADUXVKKb67/0noP1w8NI4QQZnaH4e+BHqcuQXKem9rGMm4QdIAoF5tDv7BDgZnd/4Gj3Yfz9+MET+g==
X-Received: by 2002:a17:902:5a09:: with SMTP id q9-v6mr6745773pli.300.1528923940673;
        Wed, 13 Jun 2018 14:05:40 -0700 (PDT)
Received: from ndesaulniers0.svl.corp.google.com ([2620:15c:2a3:1:d33:166f:5b79:14b3])
        by smtp.gmail.com with ESMTPSA id n76-v6sm8692976pfg.98.2018.06.13.14.05.38
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 13 Jun 2018 14:05:39 -0700 (PDT)
From:   Nick Desaulniers <ndesaulniers@google.com>
To:     akpm@linux-foundation.org, hpa@zytor.com, mingo@redhat.com,
        tglx@linutronix.de
Cc:     linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org,
        x86@kernel.org, virtualization@lists.linux-foundation.org,
        astrachan@google.com, manojgupta@google.com, ghackmann@google.com,
        sedat.dilek@gmail.com, tstellar@redhat.com, keescook@google.com,
        yamada.masahiro@socionext.com, michal.lkml@markovi.net,
        linux-kbuild@vger.kernel.org, geert@linux-m68k.org,
        will.deacon@arm.com, mawilcox@microsoft.com, arnd@arndb.de,
        rientjes@google.com, acme@redhat.com, pombredanne@nexb.com,
        aryabinin@virtuozzo.com, kstewart@linuxfoundation.org,
        boris.ostrovsky@oracle.com, jan.kiszka@siemens.com,
        rostedt@goodmis.org, kirill.shutemov@linux.intel.com,
        ard.biesheuvel@linaro.org, akataria@vmware.com,
        brijesh.singh@amd.com, caoj.fnst@cn.fujitsu.com,
        gregkh@linuxfoundation.org, jarkko.sakkinen@linux.intel.com,
        jgross@suse.com, jpoimboe@redhat.com, mka@chromium.org,
        ndesaulniers@google.com, thomas.lendacky@amd.com, tweek@google.com,
        mjg59@google.com, joe@perches.com,
        andrea.parri@amarulasolutions.com,
        "H. Peter Anvin" <hpa@linux.intel.com>
Subject: [PATCH v5 2/3] x86/asm: add _ASM_ARG* constants for argument registers to <asm/asm.h>
Date:   Wed, 13 Jun 2018 14:05:17 -0700
Message-Id: <20180613210518.113983-3-ndesaulniers@google.com>
X-Mailer: git-send-email 2.18.0.rc1.244.gcf134e6275-goog
In-Reply-To: <20180613210518.113983-1-ndesaulniers@google.com>
References: <20180613210518.113983-1-ndesaulniers@google.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "H. Peter Anvin" <hpa@linux.intel.com>

i386 and x86-64 uses different registers for arguments; make them
available so we don't have to #ifdef in the actual code.

Native size and specified size (q, l, w, b) versions are provided.

Suggested-by: Sedat Dilek <sedat.dilek@gmail.com>
Signed-off-by: H. Peter Anvin <hpa@linux.intel.com>
Signed-off-by: Nick Desaulniers <ndesaulniers@google.com>
---
 arch/x86/include/asm/asm.h | 59 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 59 insertions(+)

diff --git a/arch/x86/include/asm/asm.h b/arch/x86/include/asm/asm.h
index 219faaec51df..990770f9e76b 100644
--- a/arch/x86/include/asm/asm.h
+++ b/arch/x86/include/asm/asm.h
@@ -46,6 +46,65 @@
 #define _ASM_SI		__ASM_REG(si)
 #define _ASM_DI		__ASM_REG(di)
 
+#ifndef __x86_64__
+/* 32 bit */
+
+#define _ASM_ARG1	_ASM_AX
+#define _ASM_ARG2	_ASM_DX
+#define _ASM_ARG3	_ASM_CX
+
+#define _ASM_ARG1L	eax
+#define _ASM_ARG2L	edx
+#define _ASM_ARG3L	ecx
+
+#define _ASM_ARG1W	ax
+#define _ASM_ARG2W	dx
+#define _ASM_ARG3W	cx
+
+#define _ASM_ARG1B	al
+#define _ASM_ARG2B	dl
+#define _ASM_ARG3B	cl
+
+#else
+/* 64 bit */
+
+#define _ASM_ARG1	_ASM_DI
+#define _ASM_ARG2	_ASM_SI
+#define _ASM_ARG3	_ASM_DX
+#define _ASM_ARG4	_ASM_CX
+#define _ASM_ARG5	r8
+#define _ASM_ARG6	r9
+
+#define _ASM_ARG1Q	rdi
+#define _ASM_ARG2Q	rsi
+#define _ASM_ARG3Q	rdx
+#define _ASM_ARG4Q	rcx
+#define _ASM_ARG5Q	r8
+#define _ASM_ARG6Q	r9
+
+#define _ASM_ARG1L	edi
+#define _ASM_ARG2L	esi
+#define _ASM_ARG3L	edx
+#define _ASM_ARG4L	ecx
+#define _ASM_ARG5L	r8d
+#define _ASM_ARG6L	r9d
+
+#define _ASM_ARG1W	di
+#define _ASM_ARG2W	si
+#define _ASM_ARG3W	dx
+#define _ASM_ARG4W	cx
+#define _ASM_ARG5W	r8w
+#define _ASM_ARG6W	r9w
+
+#define _ASM_ARG1B	dil
+#define _ASM_ARG2B	sil
+#define _ASM_ARG3B	dl
+#define _ASM_ARG4B	cl
+#define _ASM_ARG5B	r8b
+#define _ASM_ARG6B	r9b
+
+#endif
+
 /*
  * Macros to generate condition code outputs from inline assembly,
  * The output operand must be type "bool".
-- 
2.18.0.rc1.244.gcf134e6275-goog

