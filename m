Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id 2CD9LnuaGVu7IwAAmS7hNA
	; Thu, 07 Jun 2018 20:50:19 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id BA9BE6074D; Thu,  7 Jun 2018 20:50:19 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="q0yLiq4U"
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=2.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,T_DKIMWL_WL_MED,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 2A2D0605A2;
	Thu,  7 Jun 2018 20:50:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 2A2D0605A2
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932696AbeFGUuR (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Thu, 7 Jun 2018 16:50:17 -0400
Received: from mail-pg0-f68.google.com ([74.125.83.68]:33519 "EHLO
        mail-pg0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932634AbeFGUuO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jun 2018 16:50:14 -0400
Received: by mail-pg0-f68.google.com with SMTP id e11-v6so5321182pgq.0
        for <linux-kernel@vger.kernel.org>; Thu, 07 Jun 2018 13:50:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=yGeT2z0TEJiRxrbez/GsuqB8RgVtytCBVtTQ7JK4sXk=;
        b=q0yLiq4UUXYjLhkgo6Khtd2rSzXGgII69YbUgaORklAWxE1ORMmkM+/cNn/mvyOJB2
         SZtG10NYmCRUow/xNTFu+uZwPnN/MEXeFkdc4Zwi6lrAONCqHbm0+KuVpblvfhPXw76r
         za6oR1DMVmnPFkiLHT+RD6+ksZkcBOy98ZfVo8RlzsTzrv0/fF78qBWlDgK7ooWL5zf8
         QEo36NWOTXEPEoeslLoEjGbdtKgE4p95fceNfuw5zunvWgDmYNHi72HXRRrUJ3jHnywC
         VZgc2ZlNpxsSVbwcEa43FmNnui6vyW/RnTch2QENEn0LWtrgoudGWNaE31AE7MoIYEjE
         yKDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=yGeT2z0TEJiRxrbez/GsuqB8RgVtytCBVtTQ7JK4sXk=;
        b=XrQkq1RR8vW7nOvR073jzFFL583nBKpEwXvtvuimYX1xzccIs+8OUUHvHRAXFMY7RB
         DiiKMCSO2W47IXRw3ZEW0RcGYP7f4c+NtEDDrzRTu6C87Ata2on1c4+iNaDmBL11sCvn
         VYL+Nn2QEDoSbiQkCPJQMcNN95+UfFqa50VJFI6zmpqrfmnGMo7Rd3SBP2nEXHgo8dNU
         YY/blP8+x61XBRLYB9RyoxaC8zm5zngLBwGZ+kvbdEiwlgpkRiSacWAGW3wnLNqRKiuC
         BD/Jgcp3zEZKBtaicIX2jHS5BzjkJ2t5FS1lhlrfJRd2eKL8uxr135HNbwHgkGJbBgh+
         SbOg==
X-Gm-Message-State: APt69E22rU/abODdNEFnxPcb+Z/7zvXINAXW7s3m+/4E28gaWvJS1S7G
        YSZ1zINvsZzvSjWJESFON8QIoQ==
X-Google-Smtp-Source: ADUXVKITgW7CYltfWcmphTqZwbR4c0+YCzRuihluXb2VzgIEQtK8aFZvDAgVfEb6ie8zkKU49D7u7Q==
X-Received: by 2002:a62:32c6:: with SMTP id y189-v6mr3123267pfy.241.1528404612809;
        Thu, 07 Jun 2018 13:50:12 -0700 (PDT)
Received: from ndesaulniers0.svl.corp.google.com ([2620:15c:2a3:1:d33:166f:5b79:14b3])
        by smtp.gmail.com with ESMTPSA id w18-v6sm3780460pgq.1.2018.06.07.13.50.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 07 Jun 2018 13:50:12 -0700 (PDT)
From: Nick Desaulniers <ndesaulniers@google.com>
To: akpm@linux-foundation.org, hpa@zytor.com, mingo@redhat.com,
        tglx@linutronix.de
Cc: linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org,
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
        "H. Peter Anvin" <hpa@linux.intel.com>
Subject: [PATCH v4 2/3] x86/asm: add _ASM_ARG* constants for argument registers to <asm/asm.h>
Date: Thu,  7 Jun 2018 13:49:26 -0700
Message-Id: <20180607204927.219329-3-ndesaulniers@google.com>
X-Mailer: git-send-email 2.17.1.1185.g55be947832-goog
In-Reply-To: <20180607204927.219329-1-ndesaulniers@google.com>
References: <20180607204927.219329-1-ndesaulniers@google.com>
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
2.17.1.1185.g55be947832-goog
