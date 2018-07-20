Return-Path: <SRS0=cuzA=KE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,URIBL_BLOCKED,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D20F8ECDFBB
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 22:36:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 765C320661
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 22:36:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Pi6osgqu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 765C320661
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728104AbeGTX1H (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Jul 2018 19:27:07 -0400
Received: from mail-it0-f74.google.com ([209.85.214.74]:59802 "EHLO
        mail-it0-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727429AbeGTX1H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jul 2018 19:27:07 -0400
Received: by mail-it0-f74.google.com with SMTP id a10-v6so10157074itc.9
        for <linux-kernel@vger.kernel.org>; Fri, 20 Jul 2018 15:36:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:date:in-reply-to:message-id:references:subject:from:to
         :cc;
        bh=qM+gcHxnNw8fatoafsEqODIm8Gbt98K18oDxxw8G5aw=;
        b=Pi6osgquaWuLHwMjihtp5LmCQS9FMaa8K2Z8A8kreZhqJBxiBRYXBYvW8DTR99SmwJ
         oA9Fq5ONq8vFD1mS2fcJCJkZpM6iXLL7iBf0xW+uQOi4Z83SOk5nCepl+3yt6MdZhugN
         MVM7ViKvw2RwqF1ZsUHn2LIFAT1aLqEGV8RBcOrgqfHEnw2Kp6ci9ewdKzYLR66hqiaM
         CcdvhZS8ugd9HQDgf7qmnKpl3JQdQCvHCJyMUTez6KvVpPFR2Oc9HVeWq4AP4SWKwHnK
         9ZkCJKYdHejerzZeyWsPIeaeveS2Izd8Uo/aWTR3Evgt/idn4MwIm42yVe61B7lrtwCv
         /AWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id
         :references:subject:from:to:cc;
        bh=qM+gcHxnNw8fatoafsEqODIm8Gbt98K18oDxxw8G5aw=;
        b=fqGM4NmpfA/0SKTiD8NC57k15mBGpRJbQcy3ckCkWrHXXSIRC5cUxnsWpCJEe4NWSJ
         fz5tOwl7R4jC9vfzkplSPxMvCXMTYSe8PKXGxEJhmyhc0jfb84ourEupbxtD/+p5anOQ
         1iyTai9oTg4UVqBIfAaGoFosM+8ocYgGmXnXwiUNlscIXaB2lIY5q5HnX9mvbcwRax2+
         H+mQF50hrPzpaOZ9JKFZ3HIKqcjbh4JqSUjxl86E0/NLyjKUKPn63HFPmQomkiVgYK8l
         PiRtIyhQJ465X8AglQs0z7Yr76qPrdemrH9PsRlWY/78AeJvdSuGj9hmrxWVxsKEYIhu
         S/7Q==
X-Gm-Message-State: AOUpUlHDsCzSbJ5MgV7cmgJG1SgL0jzX97Qjf7pRjfR0rNjgNy25OhLO
        nLh8h+HCeLunxVMlnNtSyy8dKXDDwNFip7O7Rr4=
X-Google-Smtp-Source: AAOMgpeWiNwgMMM5StP/Z2yfynj1MS0toEvN2Q3M1ZuBynfZJ3ETQ/a/YoLBIv8VhhWTJmKEg/Enltt5RsfKa7rs//Y=
MIME-Version: 1.0
X-Received: by 2002:a24:5687:: with SMTP id o129-v6mr1814123itb.21.1532126208246;
 Fri, 20 Jul 2018 15:36:48 -0700 (PDT)
Date:   Fri, 20 Jul 2018 15:36:41 -0700
In-Reply-To: <20180718090702.GA6212@kroah.com>
Message-Id: <20180720223642.126080-1-ndesaulniers@google.com>
References: <20180718090702.GA6212@kroah.com>
X-Mailer: git-send-email 2.18.0.233.g985f88cf7e-goog
Subject: [4.4 STABLE BACKPORT] x86: paravirt: make native_save_fl extern inline
From:   Nick Desaulniers <ndesaulniers@google.com>
To:     gregkh@linuxfoundation.org
Cc:     stable@vger.kernel.org, Nick Desaulniers <ndesaulniers@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        Juergen Gross <jgross@suse.com>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

native_save_fl() is marked static inline, but by using it as
a function pointer in arch/x86/kernel/paravirt.c, it MUST be outlined.

paravirt's use of native_save_fl() also requires that no GPRs other than
%rax are clobbered.

Compilers have different heuristics which they use to emit stack guard
code, the emittance of which can break paravirt's callee saved assumption
by clobbering %rcx.

Marking a function definition extern inline means that if this version
cannot be inlined, then the out-of-line version will be preferred. By
having the out-of-line version be implemented in assembly, it cannot be
instrumented with a stack protector, which might violate custom calling
conventions that code like paravirt rely on.

The semantics of extern inline has changed since gnu89. This means that
folks using GCC versions >= 5.1 may see symbol redefinition errors at
link time for subdirs that override KBUILD_CFLAGS (making the C standard
used implicit) regardless of this patch. This has been cleaned up
earlier in the patch set, but is left as a note in the commit message
for future travelers.

Reports:
https://lkml.org/lkml/2018/5/7/534
https://github.com/ClangBuiltLinux/linux/issues/16

Discussion:
https://bugs.llvm.org/show_bug.cgi?id=37512
https://lkml.org/lkml/2018/5/24/1371

Thanks to the many folks that participated in the discussion.

Acked-by: Juergen Gross <jgross@suse.com>
Debugged-by: Alistair Strachan <astrachan@google.com>
Debugged-by: Matthias Kaehlcke <mka@chromium.org>
Reported-by: Sedat Dilek <sedat.dilek@gmail.com>
Signed-off-by: Nick Desaulniers <ndesaulniers@google.com>
Suggested-by: Arnd Bergmann <arnd@arndb.de>
Suggested-by: H. Peter Anvin <hpa@zytor.com>
Suggested-by: Tom Stellar <tstellar@redhat.com>
Tested-by: Sedat Dilek <sedat.dilek@gmail.com>
---
Backport for 4.4. 4.4 is missing commit 784d5699eddc "x86: move exports to
actual definitions" which doesn't apply cleanly, and not really worth
backporting IMO. It's simpler to change this patch from upstream:
+ #include <asm-generic/export.h>
rather than
+ #include <asm/export.h>

 arch/x86/include/asm/irqflags.h |  2 +-
 arch/x86/kernel/Makefile        |  1 +
 arch/x86/kernel/irqflags.S      | 26 ++++++++++++++++++++++++++
 3 files changed, 28 insertions(+), 1 deletion(-)
 create mode 100644 arch/x86/kernel/irqflags.S

diff --git a/arch/x86/include/asm/irqflags.h b/arch/x86/include/asm/irqflags.h
index b77f5edb03b0..0056bc945cd1 100644
--- a/arch/x86/include/asm/irqflags.h
+++ b/arch/x86/include/asm/irqflags.h
@@ -8,7 +8,7 @@
  * Interrupt control:
  */
 
-static inline unsigned long native_save_fl(void)
+extern inline unsigned long native_save_fl(void)
 {
 	unsigned long flags;
 
diff --git a/arch/x86/kernel/Makefile b/arch/x86/kernel/Makefile
index b1b78ffe01d0..7947cee61f61 100644
--- a/arch/x86/kernel/Makefile
+++ b/arch/x86/kernel/Makefile
@@ -41,6 +41,7 @@ obj-y			+= alternative.o i8253.o pci-nommu.o hw_breakpoint.o
 obj-y			+= tsc.o tsc_msr.o io_delay.o rtc.o
 obj-y			+= pci-iommu_table.o
 obj-y			+= resource.o
+obj-y			+= irqflags.o
 
 obj-y				+= process.o
 obj-y				+= fpu/
diff --git a/arch/x86/kernel/irqflags.S b/arch/x86/kernel/irqflags.S
new file mode 100644
index 000000000000..3817eb748eb4
--- /dev/null
+++ b/arch/x86/kernel/irqflags.S
@@ -0,0 +1,26 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+
+#include <asm/asm.h>
+#include <asm-generic/export.h>
+#include <linux/linkage.h>
+
+/*
+ * unsigned long native_save_fl(void)
+ */
+ENTRY(native_save_fl)
+	pushf
+	pop %_ASM_AX
+	ret
+ENDPROC(native_save_fl)
+EXPORT_SYMBOL(native_save_fl)
+
+/*
+ * void native_restore_fl(unsigned long flags)
+ * %eax/%rdi: flags
+ */
+ENTRY(native_restore_fl)
+	push %_ASM_ARG1
+	popf
+	ret
+ENDPROC(native_restore_fl)
+EXPORT_SYMBOL(native_restore_fl)
-- 
2.18.0.233.g985f88cf7e-goog

