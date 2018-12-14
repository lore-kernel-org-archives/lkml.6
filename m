Return-Path: <SRS0=kF4g=OX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 327F2C67839
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 04:02:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DC0B62146E
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 04:02:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="YJ3xZdRK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DC0B62146E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726993AbeLNECe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Dec 2018 23:02:34 -0500
Received: from conuserg-11.nifty.com ([210.131.2.78]:38482 "EHLO
        conuserg-11.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726437AbeLNECe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Dec 2018 23:02:34 -0500
Received: from pug.e01.socionext.com (p14092-ipngnfx01kyoto.kyoto.ocn.ne.jp [153.142.97.92]) (authenticated)
        by conuserg-11.nifty.com with ESMTP id wBE41xR2019281;
        Fri, 14 Dec 2018 13:02:00 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-11.nifty.com wBE41xR2019281
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1544760120;
        bh=+qet7+27r1faUUG6UvsIozm++M7m8sU36PxpCCQxBKc=;
        h=From:To:Cc:Subject:Date:From;
        b=YJ3xZdRKQ9hrQM2NWAJmysrcm9e8L2xCTcH5rHh4Py3IGATouaQFQJ+imPt1nULf0
         fJ3btbzNjimUgXQ5x1bwZ2MEBBS83eCuA0DMBddIzrMGpCpq/I66OG5ylD/HpcePH/
         WzWV0u8kshMx5So6YqI9ZqSQNVb9D9A8+LO/hmIyyshCO7ReT9ZIBniDXGjeLUFEOa
         WopFVWvgFVja8M3N0kXpcx9zoYdqIXxxc+RnGL0hMjQu3gaCeB68naUXHPUB7fxY3D
         cc4jf48dUCd5IWf13J1KCnyDL6gqCpLKSPJkqCbuBeg+0G/BYRprE7SI+RPUcbUvrP
         82K2ee/ywsLrw==
X-Nifty-SrcIP: [153.142.97.92]
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        linux-arm-kernel@lists.infradead.org
Cc:     Masahiro Yamada <yamada.masahiro@socionext.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] arm64: replace arm64-obj-* in Makefile with obj-*
Date:   Fri, 14 Dec 2018 13:01:52 +0900
Message-Id: <1544760112-5378-1-git-send-email-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use the standard obj-$(CONFIG_...) syntex. The behavior is still the
same.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 arch/arm64/kernel/Makefile | 59 +++++++++++++++++++++++-----------------------
 1 file changed, 29 insertions(+), 30 deletions(-)

diff --git a/arch/arm64/kernel/Makefile b/arch/arm64/kernel/Makefile
index 583334c..b4e4f7e 100644
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
@@ -27,40 +27,39 @@ OBJCOPYFLAGS := --prefix-symbols=__efistub_
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
+obj-$(CONFIG_ARM64_ACPI_PARKING_PROTOCOL) += acpi_parking_protocol.o
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
+obj-$(CONFIG_CRASH_DUMP)		+= crash_dump.o
+obj-$(CONFIG_CRASH_CORE)		+= crash_core.o
+obj-$(CONFIG_ARM_SDE_INTERFACE)		+= sdei.o
+obj-$(CONFIG_ARM64_SSBD)		+= ssbd.o
 
-obj-y					+= $(arm64-obj-y) vdso/ probes/
-obj-m					+= $(arm64-obj-m)
+obj-y					+= vdso/ probes/
 head-y					:= head.o
 extra-y					+= $(head-y) vmlinux.lds
 
-- 
2.7.4

