Return-Path: <linux-efi-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3570355-1527872193-2-10648696681699264514
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-charsets: 
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: linux@kroah.com
X-Delivered-to: linux@kroah.com
X-Mail-from: linux-efi-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1527872193; b=ZyXvjqA68IH+JHpOACIOfyP/hswbz+kdmQqFMqhOgwhUrV7oRA
    SAE7F/hEeZuX20zF2aWU+Ww/y7bGoPV/Az4gn1PBs09Ge/c5Dqs5br6WFcVQxa6q
    rSGkJqrJXowKRfftM4qu4Or5WD61E1Kf52HT//ZdgoZ21f5/B0TfGsiWmvnElrC7
    soutSPnSEsMsou9Pf36RRzAvWZc+LQaMgt72B2CWRXb8EMRtmh6KYFAP4+RjB4hs
    zbhC6ClZkYF9D7sVO2HnapSGnE0VLw8qcIF61UQYAfSbaEhS1km38O8b0m0bcdvW
    yM8Nr2NtDpsy9kzIC4HbrnZnWYTO5J9rRD1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:sender:list-id; s=fm2; t=1527872193; bh=
    C2D5GvjcC7V4FORbwxZ69U4sLMhcRajdQiFRlMfP7No=; b=ECa6qpgwMMlfq/J0
    pJnoK4UQxhagX1LM9b9zwTpSx+x8H/viMHu84osZFPGu9+00V9d37zq1mVqaK1pF
    nJiyBxALIrOYco4QU6So75/zIMuqnlPYM0Qq2IB2j8ppy7fjeCgDpuZ0CkamnJfb
    iad8bj8YJxGT29YMpdrvupQqt0wklnpmhCB6E3p6v8XaPvxXS1lxzyR3IYdBMzSt
    hINA9sRyqc9wDxEC26W+camG8JlqoTKJB0X/39CIkdm0YYwfV9/+A4e3aKJpfOV9
    KIZGDxZq9BZFylZ7jxN4QMlZJIM+Y+ZFXJkod0UQqY98GvXxn3uxNAy/VlxtEQuu
    eZhcsA==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=fail (body has been altered, 2048-bit rsa key sha256)
    header.d=google.com header.i=@google.com header.b=E6Qrpvol
    header.a=rsa-sha256 header.s=20161025 x-bits=2048;
    dmarc=fail (p=reject,has-list-id=yes,d=reject) header.from=google.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-efi-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=fail (body has been altered, 2048-bit rsa key)
    header.d=1e100.net header.i=@1e100.net header.b=BMT9VOQf;
    x-ptr=pass smtp.helo=vger.kernel.org policy.ptr=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=google.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=40 state=0
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (body has been altered, 2048-bit rsa key sha256)
      header.d=google.com header.i=@google.com header.b=E6Qrpvol
      header.a=rsa-sha256 header.s=20161025 x-bits=2048;
    dmarc=fail (p=reject,has-list-id=yes,d=reject) header.from=google.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-efi-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=fail (body has been altered, 2048-bit rsa key)
      header.d=1e100.net header.i=@1e100.net header.b=BMT9VOQf;
    x-ptr=pass smtp.helo=vger.kernel.org policy.ptr=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=google.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=40 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfCF8BXPDCjU7ptTG3E+Vrpu6QFCSGN8gybFfd2ipZhiTcuqd/Kq1jEDCMESI3MHdQzMiUgYQFQQl8htUDWzuldBX0Q3/UAThtpn/FGCU9448bFxxskYm
    FrAKeZPBFuj0m6yOX+xIqOurX5RsLJF1HBxsxSu+nYuPZMKUidECvF6YFZNJW+ZEadHXCnfF8VZ3KehPmDVuE6X2xISwzpjHHHNj7NdFLrdqviNujWdwoZLl
X-CM-Analysis: v=2.3 cv=Tq3Iegfh c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=xqWC_Br6kY4A:10 a=7mUfYlMuFuIA:10
    a=D19gQVrFAAAA:8 a=NEAV23lmAAAA:8 a=Twlkf-z8AAAA:8 a=1XWaLZrsAAAA:8
    a=cm27Pg_UAAAA:8 a=pGLkceISAAAA:8 a=oGMlB6cnAAAA:8 a=20KFwNOVAAAA:8
    a=VwQbUJbxAAAA:8 a=sApZseF_516eCH-e1ggA:9 a=x8gzFH9gYPwA:10
    a=W4TVW4IDbPiebHqcZpNg:22 a=-74SuR6ZdpOK_LpdRCUo:22 a=xmb-EsYY8bH0VWELuYED:22
    a=NdAtdrkLVvyUPsUoGJp4:22 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753427AbeFAQ4c (ORCPT <rfc822;linux@kroah.com>);
        Fri, 1 Jun 2018 12:56:32 -0400
Received: from mail-pl0-f66.google.com ([209.85.160.66]:42498 "EHLO
        mail-pl0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753199AbeFAQ4E (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Fri, 1 Jun 2018 12:56:04 -0400
X-Google-Smtp-Source: ADUXVKLilYrOPo4CaRibHDM5lRCQXyWid6uLBXI8vO+9RXGzowpXb0F1Zy8EkanAXi2HqcvFjBo5cw==
From: Nick Desaulniers <ndesaulniers@google.com>
To: akpm@linux-foundation.org, ard.biesheuvel@linaro.org,
        aryabinin@virtuozzo.com, akataria@vmware.com,
        boris.ostrovsky@oracle.com, brijesh.singh@amd.com,
        caoj.fnst@cn.fujitsu.com, gregkh@linuxfoundation.org,
        hpa@zytor.com, jan.kiszka@siemens.com,
        jarkko.sakkinen@linux.intel.com, jgross@suse.com,
        jpoimboe@redhat.com, kirill.shutemov@linux.intel.com,
        mingo@redhat.com, mjg59@google.com, mka@chromium.org,
        ndesaulniers@google.com, pombredanne@nexb.com, rostedt@goodmis.org,
        tglx@linutronix.de, thomas.lendacky@amd.com, tweek@google.com
Cc: linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org,
        x86@kernel.org, virtualization@lists.linux-foundation.org
Subject: [PATCH 3/3] x86: paravirt: make native_save_fl extern inline
Date: Fri,  1 Jun 2018 09:55:50 -0700
Message-Id: <20180601165550.90053-4-ndesaulniers@google.com>
X-Mailer: git-send-email 2.17.0.921.gf22659ad46-goog
In-Reply-To: <20180601165550.90053-1-ndesaulniers@google.com>
References: <20180601165550.90053-1-ndesaulniers@google.com>
Sender: linux-efi-owner@vger.kernel.org
X-Mailing-List: linux-efi@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

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
index 000000000000..937bd08c3f79
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
+ * %rdi: flags
+ */
+ENTRY(native_restore_fl)
+	push %_ASM_DI
+	popf
+	ret
+ENDPROC(native_restore_fl)
+EXPORT_SYMBOL(native_restore_fl)
-- 
2.17.0.921.gf22659ad46-goog

