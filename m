Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id yPJnJFN6GVt7OQAAmS7hNA
	; Thu, 07 Jun 2018 18:33:00 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 56AE4608B8; Thu,  7 Jun 2018 18:33:00 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Dw6gMm5Q"
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=2.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,T_DKIMWL_WL_MED,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 77C71606DD;
	Thu,  7 Jun 2018 18:32:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 77C71606DD
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S936384AbeFGSc4 (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Thu, 7 Jun 2018 14:32:56 -0400
Received: from mail-pf0-f194.google.com ([209.85.192.194]:40622 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S936335AbeFGScv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jun 2018 14:32:51 -0400
Received: by mail-pf0-f194.google.com with SMTP id z24-v6so5324489pfe.7
        for <linux-kernel@vger.kernel.org>; Thu, 07 Jun 2018 11:32:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=MPtvFM9RmOmX1Ahr0Fa+Dw3BDhmehCY5YEyrPuKZw+s=;
        b=Dw6gMm5QNPYGAVEoBl2X0jSMciuOdG28Og5H9vMnthpyNiXuLrjAU6YsrEMmsAW9sf
         kc9SikIynGVU2XAH5eNeB4fuMtKK7dQN0281/cGGw4BQ99kMGW9W9e/jcd5dZ3Redx5E
         lfryE6SBALcL5leNR7lmb6aJBAmCEUyJ+HMcL433T0zqzfalOxr3n+A2O/2BjY8P/RT/
         gVMXhM0YzLb/dhXwM3uzZPCnN/Dnz4dGlVKz7Wpb5qwSdLVuonzIGUGxW1ik5K9rHNjZ
         8U1vd3ZQYAkqjkyT8Gk4Q9WiSX5Keo030DMS1RXQkRUoPKYv5tx4EZO8trkAPdhdhMhL
         TgcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=MPtvFM9RmOmX1Ahr0Fa+Dw3BDhmehCY5YEyrPuKZw+s=;
        b=Foh+5QZh328hL1MzMxAdZ4Q1S1cWPdHijuLCdI5IY6FqT0He2aGB++VfBvjup8m0t3
         S+PMT9I7mJWOSR9nboRVj4XxYl/6llqxfdUC6pTp2AgoD7AJKY9QBRRJOSDC97qhrWGf
         /EyQ/SZuWsHU9AbVVl5b+UEy5x60EZ9pBmnpcB/GnyopqDO8udguWx1OG+bW4hfeAA2u
         8kPCznsC74owGm09ZXfS4y8YeFx9r4WRseKPW/HgAxQmKdLw+KPORY77ByZWiM/YbXzF
         P3fYToC+7vyxHmkrWSOlRSnsAYeb6mVQt4EQvJDUZqxZ09VPJGLKnFUTGvZN1qmdtoyE
         oaPg==
X-Gm-Message-State: APt69E2j+qb2Tg/sGBVI4IFaHWkD7Iecow8Ix/m6rcCtupBIPTE+rc6f
        1sg2TriPLDpEe3mHlOvrOrcygt7Hj1k=
X-Google-Smtp-Source: ADUXVKKg6tAPADfZjlBeusLwIAk/aegDdLdfWKbeb6FHm1OZ3mMT0dI0yjr/c2cSok2LCfbMC/jyXA==
X-Received: by 2002:a63:714c:: with SMTP id b12-v6mr1730247pgn.420.1528396370427;
        Thu, 07 Jun 2018 11:32:50 -0700 (PDT)
Received: from ndesaulniers0.svl.corp.google.com ([2620:15c:2a3:1:d33:166f:5b79:14b3])
        by smtp.gmail.com with ESMTPSA id n76-v6sm6932739pfg.98.2018.06.07.11.32.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 07 Jun 2018 11:32:49 -0700 (PDT)
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
        mjg59@google.com, joe@perches.com
Subject: [PATCH v3 3/3] x86: paravirt: make native_save_fl extern inline
Date: Thu,  7 Jun 2018 11:32:19 -0700
Message-Id: <20180607183219.192973-4-ndesaulniers@google.com>
X-Mailer: git-send-email 2.17.1.1185.g55be947832-goog
In-Reply-To: <20180607183219.192973-1-ndesaulniers@google.com>
References: <20180607183219.192973-1-ndesaulniers@google.com>
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
2.17.1.1185.g55be947832-goog
