Return-Path: <SRS0=RFFj=MN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 146D8C43143
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 18:05:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C97492089A
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 18:04:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=android.com header.i=@android.com header.b="Vowk1mU3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C97492089A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=android.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726971AbeJBAn4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Oct 2018 20:43:56 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:35114 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725958AbeJBAn4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Oct 2018 20:43:56 -0400
Received: by mail-pg1-f196.google.com with SMTP id v133-v6so10028940pgb.2
        for <linux-kernel@vger.kernel.org>; Mon, 01 Oct 2018 11:04:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=android.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=IQFF4ExiUu4TfBRANNdvJoATwQsjjvcykP41D7fJdOM=;
        b=Vowk1mU3mH6nLMLP+xUivvCqNWtFNily1gSkwBzExrt3slYo/tQ/7RWOtoHCIwv9f8
         0tXT14YJ/i1+3W1LUY417DdAM32dOX72UfRswpwV2aOp5/nFwPo2x7xJexjQC6H3HRta
         PVkimVSJL9Wp4Itnkod7CA5hamz9/WIGVwL2aSmrBTftupDFcjZHHir5msmGiDiuSRV6
         mzvU5maImvwAVJRDhoBd84lIN8/MuahkdTZxMMRWpsEccm+SQeZLe+Yb4Y6xjVc8Qf+Z
         OxtQC/rLIhi4dZcQ8b+8cjCEATulwCF7Kng76oPVA8Di9oZh0rdlutp9LXjDSzW7v3Wr
         cVKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=IQFF4ExiUu4TfBRANNdvJoATwQsjjvcykP41D7fJdOM=;
        b=SUstMyJ8t6wqlnrW6UMNHXWDzd0zUBc7eKzTN7c+grwVHcqvqV+C5XVATmFcJX8/CK
         kHEoG80vwvB/GhF+6Wp3zWBl9BvWF9u3/8GVvGkVfsIZDUb82sQC+BG9m6knHJgY1he3
         CQ+g8BcRj62dkJmr1bZyUXaKoXSlM6QbZ//ypAAEdQVBnCEli6xLIZBhNoEjvBMsC82n
         mWtRPUaGToxHExYiFqX3SaHnsHp3KxsAaU4c7BbYxUB3LGrMdGBhTuzDZ/wJcuY/qmvf
         OTEGNLUFDE0JaCVw6ivnhYDKx79biD+MPgCxiStMBpe4UuYX2vN8fn8DbiZn++ZeQdXd
         4nMg==
X-Gm-Message-State: ABuFfogDcC3hoRf3xJDsI48P5AJfix7mk0Gbt9z3WFroWUcwQVjr/J7s
        d8MxJoyCmTXS+Kw2MzQo+GJ9CqNHrFs=
X-Google-Smtp-Source: ACcGV61Fx/UkERBw4dzYAOjqLmj0pkiUbjmGPQ5joFH8+g/C3XtiM+DfMazfoGxnRIEtvqPEHtklpQ==
X-Received: by 2002:a63:1d10:: with SMTP id d16-v6mr2306525pgd.228.1538417097423;
        Mon, 01 Oct 2018 11:04:57 -0700 (PDT)
Received: from nebulus.mtv.corp.google.com ([2620:0:1000:1612:b4fb:6752:f21f:3502])
        by smtp.gmail.com with ESMTPSA id d186-v6sm24469261pfg.173.2018.10.01.11.04.56
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 01 Oct 2018 11:04:56 -0700 (PDT)
From:   Mark Salyzyn <salyzyn@android.com>
To:     linux-kernel@vger.kernel.org
Cc:     Kevin Brodsky <kevin.brodsky@arm.com>,
        Mark Salyzyn <salyzyn@android.com>,
        James Morse <james.morse@arm.com>,
        Russell King <linux@armlinux.org.uk>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Andy Lutomirski <luto@amacapital.net>,
        Dmitry Safonov <dsafonov@virtuozzo.com>,
        John Stultz <john.stultz@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Laura Abbott <labbott@redhat.com>,
        Kees Cook <keescook@chromium.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Andy Gross <andy.gross@linaro.org>,
        Andrew Pinski <apinski@cavium.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-arm-kernel@lists.infradead.org,
        Jeremy Linton <Jeremy.Linton@arm.com>,
        android-kernel@android.com, Marc Zyngier <marc.zyngier@arm.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>
Subject: RESEND [PATCH v2 6/6] arm64: Wire up and expose the new compat vDSO
Date:   Mon,  1 Oct 2018 10:58:43 -0700
Message-Id: <20181001175845.168430-24-salyzyn@android.com>
X-Mailer: git-send-email 2.19.0.605.g01d371f741-goog
In-Reply-To: <20181001175845.168430-1-salyzyn@android.com>
References: <20181001175845.168430-1-salyzyn@android.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kevin Brodsky <kevin.brodsky@arm.com>

Expose the new compat vDSO via the COMPAT_VDSO config option.

The option is not enabled in defconfig because we really need a 32-bit
compiler this time, and we rely on the user to provide it themselves
by setting CROSS_COMPILE_ARM32. Therefore enabling the option by
default would make little sense, since the user must explicitly set a
non-standard environment variable anyway.

CONFIG_COMPAT_VDSO is not directly used in the code, because we want
to ignore it (build as if it were not set) if the user didn't set
CROSS_COMPILE_ARM32. If the variable has been set to a valid prefix,
CONFIG_VDSO32 will be set; this is the option that the code and
Makefiles test.

For more flexibility, like CROSS_COMPILE, CROSS_COMPILE_ARM32 can also
be set via CONFIG_CROSS_COMPILE_ARM32 (the environment variable
overrides the config option, as expected).

Signed-off-by: Kevin Brodsky <kevin.brodsky@arm.com>
Signed-off-by: Mark Salyzyn <salyzyn@android.com>
Tested-by: Mark Salyzyn <salyzyn@android.com>
Cc: James Morse <james.morse@arm.com>
Cc: Russell King <linux@armlinux.org.uk>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will.deacon@arm.com>
Cc: Andy Lutomirski <luto@amacapital.net>
Cc: Dmitry Safonov <dsafonov@virtuozzo.com>
Cc: John Stultz <john.stultz@linaro.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Laura Abbott <labbott@redhat.com>
Cc: Kees Cook <keescook@chromium.org>
Cc: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc: Andy Gross <andy.gross@linaro.org>
Cc: Andrew Pinski <apinski@cavium.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: linux-kernel@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org
Cc: Jeremy Linton <Jeremy.Linton@arm.com>
Cc: android-kernel@android.com

v2: rebase
---
 arch/arm64/Kconfig         | 24 ++++++++++++++++++++++++
 arch/arm64/Makefile        | 36 ++++++++++++++++++++++++++++++++++--
 arch/arm64/kernel/Makefile |  3 +++
 3 files changed, 61 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index 6e61f01108cb..4ed2f93a9607 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -1335,6 +1335,30 @@ config SYSVIPC_COMPAT
 	def_bool y
 	depends on COMPAT && SYSVIPC
 
+config COMPAT_VDSO
+	bool "32-bit vDSO"
+	depends on COMPAT
+	default n
+	help
+	  Warning: a 32-bit toolchain is necessary to build the vDSO. You
+	  must explicitly define which toolchain should be used by setting
+	  CROSS_COMPILE_ARM32 to the prefix of the 32-bit toolchain (same format
+	  as CROSS_COMPILE). If CROSS_COMPILE_ARM32 is empty, a warning will be
+	  printed and the kernel will be built as if COMPAT_VDSO had not been
+	  set. If CROSS_COMPILE_ARM32 is set to an invalid prefix, compilation
+	  will be aborted.
+
+	  Provide a vDSO to 32-bit processes. It includes the symbols provided
+	  by the vDSO from the 32-bit kernel, so that a 32-bit libc can use
+	  the compat vDSO without modification. It also provides sigreturn
+	  trampolines, replacing the sigreturn page.
+
+config CROSS_COMPILE_ARM32
+	string "32-bit toolchain prefix"
+	help
+	  Same as setting CROSS_COMPILE_ARM32 in the environment, but saved for
+	  future builds. The environment variable overrides this config option.
+
 menu "Power management options"
 
 source "kernel/power/Kconfig"
diff --git a/arch/arm64/Makefile b/arch/arm64/Makefile
index 106039d25e2f..ed6c3c6fb8f8 100644
--- a/arch/arm64/Makefile
+++ b/arch/arm64/Makefile
@@ -49,9 +49,39 @@ $(warning Detected assembler with broken .inst; disassembly will be unreliable)
   endif
 endif
 
-KBUILD_CFLAGS	+= -mgeneral-regs-only $(lseinstr) $(brokengasinst)
+ifeq ($(CONFIG_COMPAT_VDSO), y)
+  CROSS_COMPILE_ARM32 ?= $(CONFIG_CROSS_COMPILE_ARM32:"%"=%)
+
+  # Check that the user has provided a valid prefix for the 32-bit toolchain.
+  # To prevent selecting the system $(cc-name) by default, the prefix is not
+  # allowed to be empty, unlike CROSS_COMPILE. In the unlikely event that the
+  # system $(cc-name) is actually the 32-bit ARM compiler to be used, the
+  # variable can be set to the dirname (e.g. CROSS_COMPILE_ARM32=/usr/bin/).
+  # Note: this Makefile is read both before and after regenerating the config
+  # (if needed). Any warning appearing before the config has been regenerated
+  # should be ignored. If the error is triggered and you set
+  # CONFIG_CROSS_COMPILE_ARM32, set CROSS_COMPILE_ARM32 to an appropriate value
+  # when invoking make and fix CONFIG_CROSS_COMPILE_ARM32.
+  ifeq ($(CROSS_COMPILE_ARM32),)
+    $(error CROSS_COMPILE_ARM32 not defined or empty, the compat vDSO will not be built)
+  else ifeq ($(cc-name),clang)
+    export CLANG_TRIPLE_ARM32 ?= $(CROSS_COMPILE_ARM32)
+    export CLANG_TARGET_ARM32 := --target=$(notdir $(CLANG_TRIPLE_ARM32:%-=%))
+    export CONFIG_VDSO32 := y
+    vdso32 := -DCONFIG_VDSO32=1
+  else ifeq ($(shell which $(CROSS_COMPILE_ARM32)$(cc-name) 2> /dev/null),)
+    $(error $(CROSS_COMPILE_ARM32)$(cc-name) not found, check CROSS_COMPILE_ARM32)
+  else
+    export CROSS_COMPILE_ARM32
+    export CONFIG_VDSO32 := y
+    vdso32 := -DCONFIG_VDSO32=1
+  endif
+endif
+
+KBUILD_CFLAGS	+= -mgeneral-regs-only $(lseinstr) $(brokengasinst) $(vdso32)
 KBUILD_CFLAGS	+= -fno-asynchronous-unwind-tables
-KBUILD_AFLAGS	+= $(lseinstr) $(brokengasinst)
+KBUILD_CFLAGS	+= $(call cc-option, -mpc-relative-literal-loads)
+KBUILD_AFLAGS	+= $(lseinstr) $(brokengasinst) $(vdso32)
 
 KBUILD_CFLAGS	+= $(call cc-option,-mabi=lp64)
 KBUILD_AFLAGS	+= $(call cc-option,-mabi=lp64)
@@ -156,6 +186,8 @@ archclean:
 prepare: vdso_prepare
 vdso_prepare: prepare0
 	$(Q)$(MAKE) $(build)=arch/arm64/kernel/vdso include/generated/vdso-offsets.h
+	$(if $(CONFIG_VDSO32),$(Q)$(MAKE) $(build)=arch/arm64/kernel/vdso32 \
+					  include/generated/vdso32-offsets.h)
 
 define archhelp
   echo  '* Image.gz      - Compressed kernel image (arch/$(ARCH)/boot/Image.gz)'
diff --git a/arch/arm64/kernel/Makefile b/arch/arm64/kernel/Makefile
index 1c2bd2210f58..6eca683fc5a8 100644
--- a/arch/arm64/kernel/Makefile
+++ b/arch/arm64/kernel/Makefile
@@ -29,7 +29,9 @@ $(obj)/%.stub.o: $(obj)/%.o FORCE
 
 arm64-obj-$(CONFIG_COMPAT)		+= sys32.o signal32.o	\
 					   sys_compat.o
+ifneq ($(CONFIG_VDSO32),y)
 arm64-obj-$(CONFIG_COMPAT)		+= sigreturn32.o
+endif
 arm64-obj-$(CONFIG_KUSER_HELPERS)	+= kuser32.o
 arm64-obj-$(CONFIG_FUNCTION_TRACER)	+= ftrace.o entry-ftrace.o
 arm64-obj-$(CONFIG_MODULES)		+= arm64ksyms.o module.o
@@ -61,6 +63,7 @@ arm64-obj-$(CONFIG_ARM_SDE_INTERFACE)	+= sdei.o
 arm64-obj-$(CONFIG_ARM64_SSBD)		+= ssbd.o
 
 obj-y					+= $(arm64-obj-y) vdso/ probes/
+obj-$(CONFIG_VDSO32)			+= vdso32/
 obj-m					+= $(arm64-obj-m)
 head-y					:= head.o
 extra-y					+= $(head-y) vmlinux.lds
-- 
2.19.0.605.g01d371f741-goog

