Return-Path: <SRS0=bmN+=JH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E7A0C43140
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 16:24:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 376F62154B
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 16:24:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="KZDQzMmi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 376F62154B
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933578AbeFUQYX (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Jun 2018 12:24:23 -0400
Received: from mail-it0-f74.google.com ([209.85.214.74]:38359 "EHLO
        mail-it0-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933421AbeFUQXi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jun 2018 12:23:38 -0400
Received: by mail-it0-f74.google.com with SMTP id l6-v6so3043928itb.3
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jun 2018 09:23:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:date:in-reply-to:message-id:references:subject:from:to
         :cc;
        bh=6IRyW2+wJGByljsyTJ7DxPDfnQO8dfQWb02gEMcyb/I=;
        b=KZDQzMmiOTmJL4Bg4c61XG5P+PkX8ExmS6RdxYMtWnQXO6tbAUV82YwTJz6bLugXjA
         P89JHaUMiXfrhp4IO0wOxlVvQLfHWiiQxCJJ51KwExaA6jSwwHqdgs1SHoI/kkBRo9Nj
         F1N+vNuBnoBrF5X3EQyFPo9HO6DpfYt9N0UcNjvRkE/9AWXRGOSb8l1JA7ymBehIBxH2
         DStGEl+yPBgYCzm8jLW47ZJCcgI/OiB5i3svl0xcCzXBP7bTvpsuMMSQeis5zj96nD8Y
         lh0AoxB90URn8e/ggtyTNj3diEmWUGbkvMbjIgYSogkL2RXCxOqiaUyMqynuBvWuIqAs
         uYHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id
         :references:subject:from:to:cc;
        bh=6IRyW2+wJGByljsyTJ7DxPDfnQO8dfQWb02gEMcyb/I=;
        b=UA8tqxRc7t6S6oSHZZkYFX2l2TSDzUW7JKySJC5doy3cQ5jk1FXcNyIeOpv/nn9+Lt
         39HEUNR5eWKxiEqeAHSch7tXjOq+XGwm0p/DsubxHqa6Z0uV4MnxXzpJCobrKm/JtXyM
         UEQ1/6W655H71we1qyy/k9AeXwJLpnxgqLmlE+OzKobhW3s+iy9Sd2lPAIuP0m2yvuzK
         4T99gp4RIQV/7EUPAMlOdkib0vMRLfzmjtLvLD37QAeXkJSqe8rHbPsQt4hWPRwcHgnf
         kJnqhZcXnvop3h5OiVS8lYEaLbVAwyTKLhWjRT4VbmAxwBNXosDsHU2RYaHjaKNewr1R
         o8Kg==
X-Gm-Message-State: APt69E2aVZEbIa7+PDbSsN4fiwFBucuklhEWWbhD74mULYEXpcdDZzOJ
        oNndIH3Z/KQeOt1KVjuF5hN/87/esqx7DSij/j4=
X-Google-Smtp-Source: ADUXVKJFUUPUsRNdiQoVlTdOsKnXMZ1OHQCPRT4oOKG69Pxc8FAupYvIq/39emBitL8SYG9oPiC3o/cK2cZfDUvlBPo=
MIME-Version: 1.0
X-Received: by 2002:a24:228c:: with SMTP id o134-v6mr2901471ito.30.1529598217972;
 Thu, 21 Jun 2018 09:23:37 -0700 (PDT)
Date:   Thu, 21 Jun 2018 09:23:23 -0700
In-Reply-To: <20180621162324.36656-1-ndesaulniers@google.com>
Message-Id: <20180621162324.36656-3-ndesaulniers@google.com>
References: <20180621162324.36656-1-ndesaulniers@google.com>
X-Mailer: git-send-email 2.18.0.rc2.346.g013aa6912e-goog
Subject: [PATCH v6 2/3] x86/asm: add _ASM_ARG* constants for argument
 registers to <asm/asm.h>
From:   Nick Desaulniers <ndesaulniers@google.com>
To:     mingo@redhat.com, tglx@linutronix.de
Cc:     akpm@linux-foundation.org, hpa@zytor.com,
        linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org,
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
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "H. Peter Anvin" <hpa@linux.intel.com>

i386 and x86-64 uses different registers for arguments; make them
available so we don't have to #ifdef in the actual code.

Native size and specified size (q, l, w, b) versions are provided.

Acked-by: Juergen Gross <jgross@suse.com>
Reviewed-by: Sedat Dilek <sedat.dilek@gmail.com>
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
2.18.0.rc2.346.g013aa6912e-goog

