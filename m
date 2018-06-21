Return-Path: <SRS0=bmN+=JH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AAA65C43141
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 16:23:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6116A208CE
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 16:23:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="YrTPqyFV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6116A208CE
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933508AbeFUQXs (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Jun 2018 12:23:48 -0400
Received: from mail-qt0-f202.google.com ([209.85.216.202]:43497 "EHLO
        mail-qt0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933346AbeFUQXn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jun 2018 12:23:43 -0400
Received: by mail-qt0-f202.google.com with SMTP id j2-v6so2898745qtn.10
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jun 2018 09:23:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:date:in-reply-to:message-id:references:subject:from:to
         :cc;
        bh=69zGo/r6+0irgRW+5JOoApDxQgRAUSTQ2lETVwGDrV0=;
        b=YrTPqyFVtXsMAvvC5f5FlE1rzB5VeSdti6iX58Isa6cVmz2PRckosBrTZ5w2rs4uIj
         hXbElK+IDt19xVxdp6+Ej58/YGBIfozLYxh4cNMmpMiK7BTcUWNRnmgP7RvhL7ut0v9w
         THXUgfYFZ3axU7uHsYtg4A02xPDbqJ7Yp/ai0w3SHqGBfnObeJYV7cpyMMd1LtmUsY5g
         ydsE9E5eJIAoa61wuBIoljqU6MLCCgC+mlBEe3umrKVOe9ddAGyFw+/nVP/tnjy+oj4P
         CEVNylQy2JGqrLErk4nK+FB0hicYy5w0SbPDo4Vqt8PQc03syxJdEPDGHgCOscG95Eeq
         et2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id
         :references:subject:from:to:cc;
        bh=69zGo/r6+0irgRW+5JOoApDxQgRAUSTQ2lETVwGDrV0=;
        b=swlpCede9dHUZii/PcAqepLi1q2sobt7RbZ4Qtj3btpuY8wHm9/RUTJFCg7vBlg7ne
         gFtbPJM21bR2LhJ2KuVJi5/+lOW1eworaxtt3kvhIW6COBdGqKxAfutPHkTDXmWqXcz5
         H4jmFSAONiGIfHAxEIboIM6dv/mIMPSPbP8ZAke/MEicpGlfAXi9bjmMv6SmGvodp4dQ
         vn5nAsYYBVSamoLiN40xND+tTgRLqY3+nLdOfUWZZ5AO8QMHeskNIpTBFqX/3sPJMqlo
         eO6REeqKv7vWe/zjtVphJ9FX5CTNjfggknSO8Zw/lCi68XTtZjzRjn5BKku3wxhM4UkL
         KiDg==
X-Gm-Message-State: APt69E2HLf8eJSPVXilCzRQ44pOfhWQS9z1QGNayPOOnq3IOfSFnxH7H
        pewc3uHX5mwqwc9Mo01joA2WE0tQsmF3bjRuoug=
X-Google-Smtp-Source: ADUXVKLDjcBLaZU3T6NBtD9qXhtx8YPSSonWXRKDxUZLixu0q5c66xT5K2h1Rgk/eX4EAfXz0AOTD/gjUC1MiYZGZBQ=
MIME-Version: 1.0
X-Received: by 2002:a0c:89ed:: with SMTP id 42-v6mr13747177qvs.36.1529598221996;
 Thu, 21 Jun 2018 09:23:41 -0700 (PDT)
Date:   Thu, 21 Jun 2018 09:23:24 -0700
In-Reply-To: <20180621162324.36656-1-ndesaulniers@google.com>
Message-Id: <20180621162324.36656-4-ndesaulniers@google.com>
References: <20180621162324.36656-1-ndesaulniers@google.com>
X-Mailer: git-send-email 2.18.0.rc2.346.g013aa6912e-goog
Subject: [PATCH v6 3/3] x86: paravirt: make native_save_fl extern inline
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
        andrea.parri@amarulasolutions.com
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
 arch/x86/include/asm/irqflags.h |  2 +-
 arch/x86/kernel/Makefile        |  1 +
 arch/x86/kernel/irqflags.S      | 26 ++++++++++++++++++++++++++
 3 files changed, 28 insertions(+), 1 deletion(-)
 create mode 100644 arch/x86/kernel/irqflags.S

diff --git a/arch/x86/include/asm/irqflags.h b/arch/x86/include/asm/irqflags.h
index 89f08955fff7..c4fc17220df9 100644
--- a/arch/x86/include/asm/irqflags.h
+++ b/arch/x86/include/asm/irqflags.h
@@ -13,7 +13,7 @@
  * Interrupt control:
  */
 
-static inline unsigned long native_save_fl(void)
+extern inline unsigned long native_save_fl(void)
 {
 	unsigned long flags;
 
diff --git a/arch/x86/kernel/Makefile b/arch/x86/kernel/Makefile
index 02d6f5cf4e70..8824d01c0c35 100644
--- a/arch/x86/kernel/Makefile
+++ b/arch/x86/kernel/Makefile
@@ -61,6 +61,7 @@ obj-y			+= alternative.o i8253.o hw_breakpoint.o
 obj-y			+= tsc.o tsc_msr.o io_delay.o rtc.o
 obj-y			+= pci-iommu_table.o
 obj-y			+= resource.o
+obj-y			+= irqflags.o
 
 obj-y				+= process.o
 obj-y				+= fpu/
diff --git a/arch/x86/kernel/irqflags.S b/arch/x86/kernel/irqflags.S
new file mode 100644
index 000000000000..ddeeaac8adda
--- /dev/null
+++ b/arch/x86/kernel/irqflags.S
@@ -0,0 +1,26 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+
+#include <asm/asm.h>
+#include <asm/export.h>
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
2.18.0.rc2.346.g013aa6912e-goog

