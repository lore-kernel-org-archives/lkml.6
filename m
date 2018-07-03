Return-Path: <SRS0=3XDn=JT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DD51C6778A
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 16:00:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 139F623EDE
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 16:00:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 139F623EDE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933901AbeGCQAQ (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Jul 2018 12:00:16 -0400
Received: from terminus.zytor.com ([198.137.202.136]:54243 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932834AbeGCQAH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jul 2018 12:00:07 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w63Fxeuh338598
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Tue, 3 Jul 2018 08:59:40 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w63FxePG338595;
        Tue, 3 Jul 2018 08:59:40 -0700
Date:   Tue, 3 Jul 2018 08:59:40 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   "tip-bot for H. Peter Anvin" <tipbot@zytor.com>
Message-ID: <tip-0e2e160033283e20f688d8bad5b89460cc5bfcc4@git.kernel.org>
Cc:     sedat.dilek@gmail.com, linux-kernel@vger.kernel.org,
        jgross@suse.com, tglx@linutronix.de, hpa@linux.intel.com,
        mingo@kernel.org, peterz@infradead.org,
        torvalds@linux-foundation.org, hpa@zytor.com,
        ndesaulniers@google.com
Reply-To: linux-kernel@vger.kernel.org, jgross@suse.com,
          sedat.dilek@gmail.com, mingo@kernel.org, hpa@linux.intel.com,
          tglx@linutronix.de, hpa@zytor.com, torvalds@linux-foundation.org,
          peterz@infradead.org, ndesaulniers@google.com
In-Reply-To: <20180621162324.36656-3-ndesaulniers@google.com>
References: <20180621162324.36656-3-ndesaulniers@google.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/urgent] x86/asm: Add _ASM_ARG* constants for argument
 registers to <asm/asm.h>
Git-Commit-ID: 0e2e160033283e20f688d8bad5b89460cc5bfcc4
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  0e2e160033283e20f688d8bad5b89460cc5bfcc4
Gitweb:     https://git.kernel.org/tip/0e2e160033283e20f688d8bad5b89460cc5bfcc4
Author:     H. Peter Anvin <hpa@linux.intel.com>
AuthorDate: Thu, 21 Jun 2018 09:23:23 -0700
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Tue, 3 Jul 2018 10:56:27 +0200

x86/asm: Add _ASM_ARG* constants for argument registers to <asm/asm.h>

i386 and x86-64 uses different registers for arguments; make them
available so we don't have to #ifdef in the actual code.

Native size and specified size (q, l, w, b) versions are provided.

Signed-off-by: H. Peter Anvin <hpa@linux.intel.com>
Signed-off-by: Nick Desaulniers <ndesaulniers@google.com>
Reviewed-by: Sedat Dilek <sedat.dilek@gmail.com>
Acked-by: Juergen Gross <jgross@suse.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: acme@redhat.com
Cc: akataria@vmware.com
Cc: akpm@linux-foundation.org
Cc: andrea.parri@amarulasolutions.com
Cc: ard.biesheuvel@linaro.org
Cc: arnd@arndb.de
Cc: aryabinin@virtuozzo.com
Cc: astrachan@google.com
Cc: boris.ostrovsky@oracle.com
Cc: brijesh.singh@amd.com
Cc: caoj.fnst@cn.fujitsu.com
Cc: geert@linux-m68k.org
Cc: ghackmann@google.com
Cc: gregkh@linuxfoundation.org
Cc: jan.kiszka@siemens.com
Cc: jarkko.sakkinen@linux.intel.com
Cc: joe@perches.com
Cc: jpoimboe@redhat.com
Cc: keescook@google.com
Cc: kirill.shutemov@linux.intel.com
Cc: kstewart@linuxfoundation.org
Cc: linux-efi@vger.kernel.org
Cc: linux-kbuild@vger.kernel.org
Cc: manojgupta@google.com
Cc: mawilcox@microsoft.com
Cc: michal.lkml@markovi.net
Cc: mjg59@google.com
Cc: mka@chromium.org
Cc: pombredanne@nexb.com
Cc: rientjes@google.com
Cc: rostedt@goodmis.org
Cc: thomas.lendacky@amd.com
Cc: tstellar@redhat.com
Cc: tweek@google.com
Cc: virtualization@lists.linux-foundation.org
Cc: will.deacon@arm.com
Cc: yamada.masahiro@socionext.com
Link: http://lkml.kernel.org/r/20180621162324.36656-3-ndesaulniers@google.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 arch/x86/include/asm/asm.h | 59 ++++++++++++++++++++++++++++++++++++++++++++++
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
