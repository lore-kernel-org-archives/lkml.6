Return-Path: <SRS0=JLMu=PM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CD3AC43387
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 00:19:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D828F217F5
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 00:19:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="Xl2Jxpxi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727310AbfADATN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Jan 2019 19:19:13 -0500
Received: from conuserg-10.nifty.com ([210.131.2.77]:33094 "EHLO
        conuserg-10.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726034AbfADATN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Jan 2019 19:19:13 -0500
Received: from grover.tkatk1.zaq.ne.jp (zaqdadce369.zaq.ne.jp [218.220.227.105]) (authenticated)
        by conuserg-10.nifty.com with ESMTP id x040Ijxk017309;
        Fri, 4 Jan 2019 09:18:45 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-10.nifty.com x040Ijxk017309
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1546561126;
        bh=IaD/HolgSGMUeGhnmpsyJZDiXgKRDX2gM/yw9Qup5i8=;
        h=From:To:Cc:Subject:Date:From;
        b=Xl2JxpxisNF6Imk/pq54MMqSBlX/6Z6plo4qk/hUSdPSDpIL5/pUtMGCEUYEr8Bfu
         kqw5SIAJmZ9wQFYdrwKH50EyxdZ/FEKiOKzWt90pqHJYBypJMb0Rhmwk86XGuxfp1S
         VTVdE1zWuXs3pU5HbucW58RT4I9S+X0kV4Fa3cTGiwzFqsOJHXP6RUYbBHW/Li27kC
         jw1EpUDIC5oI4WtfxBbcafBDxlEJXKIi4nURhzvWBghvwFAjzidyUUMpHA4oAVOHF7
         STcTVSOBH6yoRMakE4eLDrzRlHSC1y39UoBMHb79KWYQyArwIZ8NRnnO4Ww4Q1hQA5
         w992o92rQo1kQ==
X-Nifty-SrcIP: [218.220.227.105]
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
To:     Will Deacon <will.deacon@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        linux-arm-kernel@lists.infradead.org
Cc:     Masahiro Yamada <yamada.masahiro@socionext.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2] arm64: replace arm64-obj-* in Makefile with obj-*
Date:   Fri,  4 Jan 2019 09:18:41 +0900
Message-Id: <1546561121-23086-1-git-send-email-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use the standard obj-$(CONFIG_...) syntex. The behavior is still the
same.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

Changes in v2:
  - Rebase

 arch/arm64/kernel/Makefile | 61 +++++++++++++++++++++++-----------------------
 1 file changed, 30 insertions(+), 31 deletions(-)

diff --git a/arch/arm64/kernel/Makefile b/arch/arm64/kernel/Makefile
index df08d73..cd434d0 100644
--- a/arch/arm64/kernel/Makefile
+++ b/arch/arm64/kernel/Makefile
@@ -12,7 +12,7 @@ CFLAGS_REMOVE_insn.o = -pg
 CFLAGS_REMOVE_return_address.o = -pg
 
 # Object file lists.
-arm64-obj-y		:= debug-monitors.o entry.o irq.o fpsimd.o		\
+obj-y			:= debug-monitors.o entry.o irq.o fpsimd.o		\
 			   entry-fpsimd.o process.o ptrace.o setup.o signal.o	\
 			   sys.o stacktrace.o time.o traps.o io.o vdso.o	\
 			   hyp-stub.o psci.o cpu_ops.o insn.o	\
@@ -27,41 +27,40 @@ OBJCOPYFLAGS := --prefix-symbols=__efistub_
 $(obj)/%.stub.o: $(obj)/%.o FORCE
 	$(call if_changed,objcopy)
 
-arm64-obj-$(CONFIG_COMPAT)		+= sys32.o kuser32.o signal32.o 	\
+obj-$(CONFIG_COMPAT)			+= sys32.o kuser32.o signal32.o 	\
 					   sys_compat.o
-arm64-obj-$(CONFIG_FUNCTION_TRACER)	+= ftrace.o entry-ftrace.o
-arm64-obj-$(CONFIG_MODULES)		+= module.o
-arm64-obj-$(CONFIG_ARM64_MODULE_PLTS)	+= module-plts.o
-arm64-obj-$(CONFIG_PERF_EVENTS)		+= perf_regs.o perf_callchain.o
-arm64-obj-$(CONFIG_HW_PERF_EVENTS)	+= perf_event.o
-arm64-obj-$(CONFIG_HAVE_HW_BREAKPOINT)	+= hw_breakpoint.o
-arm64-obj-$(CONFIG_CPU_PM)		+= sleep.o suspend.o
-arm64-obj-$(CONFIG_CPU_IDLE)		+= cpuidle.o
-arm64-obj-$(CONFIG_JUMP_LABEL)		+= jump_label.o
-arm64-obj-$(CONFIG_KGDB)		+= kgdb.o
-arm64-obj-$(CONFIG_EFI)			+= efi.o efi-entry.stub.o		\
+obj-$(CONFIG_FUNCTION_TRACER)		+= ftrace.o entry-ftrace.o
+obj-$(CONFIG_MODULES)			+= module.o
+obj-$(CONFIG_ARM64_MODULE_PLTS)		+= module-plts.o
+obj-$(CONFIG_PERF_EVENTS)		+= perf_regs.o perf_callchain.o
+obj-$(CONFIG_HW_PERF_EVENTS)		+= perf_event.o
+obj-$(CONFIG_HAVE_HW_BREAKPOINT)	+= hw_breakpoint.o
+obj-$(CONFIG_CPU_PM)			+= sleep.o suspend.o
+obj-$(CONFIG_CPU_IDLE)			+= cpuidle.o
+obj-$(CONFIG_JUMP_LABEL)		+= jump_label.o
+obj-$(CONFIG_KGDB)			+= kgdb.o
+obj-$(CONFIG_EFI)			+= efi.o efi-entry.stub.o		\
 					   efi-rt-wrapper.o
-arm64-obj-$(CONFIG_PCI)			+= pci.o
-arm64-obj-$(CONFIG_ARMV8_DEPRECATED)	+= armv8_deprecated.o
-arm64-obj-$(CONFIG_ACPI)		+= acpi.o
-arm64-obj-$(CONFIG_ACPI_NUMA)		+= acpi_numa.o
-arm64-obj-$(CONFIG_ARM64_ACPI_PARKING_PROTOCOL)	+= acpi_parking_protocol.o
-arm64-obj-$(CONFIG_PARAVIRT)		+= paravirt.o
-arm64-obj-$(CONFIG_RANDOMIZE_BASE)	+= kaslr.o
-arm64-obj-$(CONFIG_HIBERNATION)		+= hibernate.o hibernate-asm.o
-arm64-obj-$(CONFIG_KEXEC_CORE)		+= machine_kexec.o relocate_kernel.o	\
+obj-$(CONFIG_PCI)			+= pci.o
+obj-$(CONFIG_ARMV8_DEPRECATED)		+= armv8_deprecated.o
+obj-$(CONFIG_ACPI)			+= acpi.o
+obj-$(CONFIG_ACPI_NUMA)			+= acpi_numa.o
+obj-$(CONFIG_ARM64_ACPI_PARKING_PROTOCOL)	+= acpi_parking_protocol.o
+obj-$(CONFIG_PARAVIRT)			+= paravirt.o
+obj-$(CONFIG_RANDOMIZE_BASE)		+= kaslr.o
+obj-$(CONFIG_HIBERNATION)		+= hibernate.o hibernate-asm.o
+obj-$(CONFIG_KEXEC_CORE)		+= machine_kexec.o relocate_kernel.o	\
 					   cpu-reset.o
-arm64-obj-$(CONFIG_KEXEC_FILE)		+= machine_kexec_file.o kexec_image.o
-arm64-obj-$(CONFIG_ARM64_RELOC_TEST)	+= arm64-reloc-test.o
+obj-$(CONFIG_KEXEC_FILE)		+= machine_kexec_file.o kexec_image.o
+obj-$(CONFIG_ARM64_RELOC_TEST)		+= arm64-reloc-test.o
 arm64-reloc-test-y := reloc_test_core.o reloc_test_syms.o
-arm64-obj-$(CONFIG_CRASH_DUMP)		+= crash_dump.o
-arm64-obj-$(CONFIG_CRASH_CORE)		+= crash_core.o
-arm64-obj-$(CONFIG_ARM_SDE_INTERFACE)	+= sdei.o
-arm64-obj-$(CONFIG_ARM64_SSBD)		+= ssbd.o
-arm64-obj-$(CONFIG_ARM64_PTR_AUTH)	+= pointer_auth.o
+obj-$(CONFIG_CRASH_DUMP)		+= crash_dump.o
+obj-$(CONFIG_CRASH_CORE)		+= crash_core.o
+obj-$(CONFIG_ARM_SDE_INTERFACE)		+= sdei.o
+obj-$(CONFIG_ARM64_SSBD)		+= ssbd.o
+obj-$(CONFIG_ARM64_PTR_AUTH)		+= pointer_auth.o
 
-obj-y					+= $(arm64-obj-y) vdso/ probes/
-obj-m					+= $(arm64-obj-m)
+obj-y					+= vdso/ probes/
 head-y					:= head.o
 extra-y					+= $(head-y) vmlinux.lds
 
-- 
2.7.4

