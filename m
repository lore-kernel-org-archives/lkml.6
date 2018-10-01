Return-Path: <SRS0=RFFj=MN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A30DDC43143
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 18:02:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 47B3E208AE
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 18:02:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=android.com header.i=@android.com header.b="tDFHKwd8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 47B3E208AE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=android.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726445AbeJBAlS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Oct 2018 20:41:18 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:34821 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725948AbeJBAlS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Oct 2018 20:41:18 -0400
Received: by mail-pg1-f195.google.com with SMTP id v133-v6so10024317pgb.2
        for <linux-kernel@vger.kernel.org>; Mon, 01 Oct 2018 11:02:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=android.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=F7dJ6MjCMM14/xv2Xt2CBV+pOfmm2Ja9QKo642OPvp0=;
        b=tDFHKwd8N2QA1BXtDaCKtJv21yxigDZ/Qk6dHXNM29eOxXgNntuNS8i5qKUq+5X4bz
         NfaqwdZAH72dCE4YazyM4U/qWkGqFgy8GI6rzjicgOLe3pdl01wV/t9pVHlhk3vn9wu2
         kdMn5PkK7cviHGBupTp9ipSak6cC7rAcvGMTYt2gJrVwL+3pCkMrAQI0cyIKmzL431E0
         ILwhT053R/5IZgZi/mgEsYQ16RxFTcB7e7uwgttOqRJ1v9IRKZ1N6UkGOSfSaO2nP9KB
         /DF04XkWvhcemvRPbL+wY5YXtafmN6URDSUnj2uwZZLCc7zmsMeuanV7mW+kNKllJsNe
         4V7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=F7dJ6MjCMM14/xv2Xt2CBV+pOfmm2Ja9QKo642OPvp0=;
        b=LmMaOPaBzOMuxlgRBPGEasl4mqGrvmWZAdac8+yDs6iKEtRNp98feeoWenTxpY8bTq
         EQYNbCu7Ormzjz51S08fM3m/qjEkeOKEmmQU9jboLD8RQTATSTAmep0K0PW8EBQHeuBU
         WcLqabNjnjXIHNdgLiebigWR4cbNrm1D+NVjKj9vvIkg3epLy8KPuAOydLhwDJVlRqr8
         Q6vSRbpJfmY2ILQ0rtZqrnJnZ3hcudYPm20KtCaDoupg23wrgklI95XL8POYbymdHITL
         MQXy1qSaPVG93pam8CwEUFF2RT/mbb3sXVY9X7SRfjv5acl62whcFeCz5XkA/3Rrq4dU
         67bQ==
X-Gm-Message-State: ABuFfoiD5Ov9+GT5jEjeyZkFfnAFOjSG0ILfFYXnsw3RPuvGmGe2Uwjo
        Tl0DGtsg67r5ss7nIPH5iVvHj2WLqkg=
X-Google-Smtp-Source: ACcGV62SuJmuJis8iOc/Lksj9rrpREMp1ecI8odOiyrHm+2xbd+QPZsLHBQXvHJZoxmNNBGpdqNh3w==
X-Received: by 2002:a62:985a:: with SMTP id q87-v6mr12662710pfd.64.1538416939980;
        Mon, 01 Oct 2018 11:02:19 -0700 (PDT)
Received: from nebulus.mtv.corp.google.com ([2620:0:1000:1612:b4fb:6752:f21f:3502])
        by smtp.gmail.com with ESMTPSA id d186-v6sm24469261pfg.173.2018.10.01.11.02.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 01 Oct 2018 11:02:19 -0700 (PDT)
From:   Mark Salyzyn <salyzyn@android.com>
To:     linux-kernel@vger.kernel.org
Cc:     Mark Salyzyn <salyzyn@android.com>,
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
        Kevin Brodsky <kevin.brodsky@arm.com>,
        Andrew Pinski <apinski@cavium.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-arm-kernel@lists.infradead.org,
        Jeremy Linton <Jeremy.Linton@arm.com>,
        android-kernel@android.com, Marc Zyngier <marc.zyngier@arm.com>,
        Christoffer Dall <christoffer.dall@linaro.org>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: RESEND [PATCH v5 10/12] arm64: vdso: replace gettimeofday.S with global vgettimeofday.C
Date:   Mon,  1 Oct 2018 10:58:30 -0700
Message-Id: <20181001175845.168430-11-salyzyn@android.com>
X-Mailer: git-send-email 2.19.0.605.g01d371f741-goog
In-Reply-To: <20181001175845.168430-1-salyzyn@android.com>
References: <20181001175845.168430-1-salyzyn@android.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Take an effort from the previous 9 patches to recode the arm64 vdso
code from assembler to C previously submitted by
Andrew Pinski <apinski@cavium.com>, rework it for use in both arm and
arm64, overlapping any optimizations for each architecture. But
instead of landing it in arm64, land the result into lib/vdso and
unify both implementations to simplify future maintenance.

apinski@cavium.com makes the following claims in the original patch:

This allows the compiler to optimize the divide by 1000 and remove
the other divides.

On ThunderX, gettimeofday improves by 32%.  On ThunderX 2,
gettimeofday improves by 18%.

Note I noticed a bug in the old (arm64) implementation of
__kernel_clock_getres; it was checking only the lower 32bits of the
pointer; this would work for most cases but could fail in a few.

<end of claim>

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
Cc: Kevin Brodsky <kevin.brodsky@arm.com>
Cc: Andrew Pinski <apinski@cavium.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: linux-kernel@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org
Cc: Jeremy Linton <Jeremy.Linton@arm.com>
Cc: android-kernel@android.com

v2:
- turned off profiling, restored quiet_cmd_vdsoas.

v3:
- move arch/arm/vdso/vgettimeofday.c to lib/vdso/vgettimeofday.c.
- adjust vgettimeofday.c to be a better global candidate, switch to
  using ARCH_PROVIDES_TIMER and __arch_counter_get() as more generic.

v4:
- simplify arch_vdso_read_counter, use read_sysreg.
- Use GENMASK_ULL macro for ARCH_CLOCK_FIXED_MASK.
- update commit message.
- add vdso_wtm_clock_nsec_t, vdso_xtime_clock_sec_t and
  vdso_raw_time_nsec_t.

v5:
- comment about asm/processor.h and asm/sysreg.h regarding why
  they have been added in compiler.h for porting clarity.
- add linux/hrtimer.h to compiler.h and comment for porting clarity.
- strip out excess unused definitions in asm-offsets.c.
---
 arch/arm64/include/asm/vdso_datapage.h |  23 +-
 arch/arm64/kernel/asm-offsets.c        |  36 ---
 arch/arm64/kernel/vdso.c               |   2 +-
 arch/arm64/kernel/vdso/Makefile        |  29 ++-
 arch/arm64/kernel/vdso/compiler.h      |  69 ++++++
 arch/arm64/kernel/vdso/datapage.h      |  59 +++++
 arch/arm64/kernel/vdso/gettimeofday.S  | 328 -------------------------
 arch/arm64/kernel/vdso/vgettimeofday.c |   3 +
 8 files changed, 175 insertions(+), 374 deletions(-)
 create mode 100644 arch/arm64/kernel/vdso/compiler.h
 create mode 100644 arch/arm64/kernel/vdso/datapage.h
 delete mode 100644 arch/arm64/kernel/vdso/gettimeofday.S
 create mode 100644 arch/arm64/kernel/vdso/vgettimeofday.c

diff --git a/arch/arm64/include/asm/vdso_datapage.h b/arch/arm64/include/asm/vdso_datapage.h
index 2b9a63771eda..95f4a7abab80 100644
--- a/arch/arm64/include/asm/vdso_datapage.h
+++ b/arch/arm64/include/asm/vdso_datapage.h
@@ -20,16 +20,31 @@
 
 #ifndef __ASSEMBLY__
 
+#ifndef _VDSO_WTM_CLOCK_SEC_T
+#define _VDSO_WTM_CLOCK_SEC_T
+typedef __u64 vdso_wtm_clock_nsec_t;
+#endif
+
+#ifndef _VDSO_XTIME_CLOCK_SEC_T
+#define _VDSO_XTIME_CLOCK_SEC_T
+typedef __u64 vdso_xtime_clock_sec_t;
+#endif
+
+#ifndef _VDSO_RAW_TIME_SEC_T
+#define _VDSO_RAW_TIME_SEC_T
+typedef __u64 vdso_raw_time_sec_t;
+#endif
+
 struct vdso_data {
 	__u64 cs_cycle_last;	/* Timebase at clocksource init */
-	__u64 raw_time_sec;	/* Raw time */
+	vdso_raw_time_sec_t raw_time_sec;	/* Raw time */
 	__u64 raw_time_nsec;
-	__u64 xtime_clock_sec;	/* Kernel time */
-	__u64 xtime_clock_nsec;
+	vdso_xtime_clock_sec_t xtime_clock_sec;	/* Kernel time */
+	__u64 xtime_clock_snsec;
 	__u64 xtime_coarse_sec;	/* Coarse time */
 	__u64 xtime_coarse_nsec;
 	__u64 wtm_clock_sec;	/* Wall to monotonic time */
-	__u64 wtm_clock_nsec;
+	vdso_wtm_clock_nsec_t wtm_clock_nsec;
 	__u32 tb_seq_count;	/* Timebase sequence counter */
 	/* cs_* members must be adjacent and in this order (ldp accesses) */
 	__u32 cs_mono_mult;	/* NTP-adjusted clocksource multiplier */
diff --git a/arch/arm64/kernel/asm-offsets.c b/arch/arm64/kernel/asm-offsets.c
index 323aeb5f2fe6..8938a4223690 100644
--- a/arch/arm64/kernel/asm-offsets.c
+++ b/arch/arm64/kernel/asm-offsets.c
@@ -94,42 +94,6 @@ int main(void)
   DEFINE(DMA_TO_DEVICE,		DMA_TO_DEVICE);
   DEFINE(DMA_FROM_DEVICE,	DMA_FROM_DEVICE);
   BLANK();
-  DEFINE(PREEMPT_DISABLE_OFFSET, PREEMPT_DISABLE_OFFSET);
-  BLANK();
-  DEFINE(CLOCK_REALTIME,	CLOCK_REALTIME);
-  DEFINE(CLOCK_MONOTONIC,	CLOCK_MONOTONIC);
-  DEFINE(CLOCK_MONOTONIC_RAW,	CLOCK_MONOTONIC_RAW);
-  DEFINE(CLOCK_REALTIME_RES,	MONOTONIC_RES_NSEC);
-  DEFINE(CLOCK_REALTIME_COARSE,	CLOCK_REALTIME_COARSE);
-  DEFINE(CLOCK_MONOTONIC_COARSE,CLOCK_MONOTONIC_COARSE);
-  DEFINE(CLOCK_COARSE_RES,	LOW_RES_NSEC);
-  DEFINE(NSEC_PER_SEC,		NSEC_PER_SEC);
-  BLANK();
-  DEFINE(VDSO_CS_CYCLE_LAST,	offsetof(struct vdso_data, cs_cycle_last));
-  DEFINE(VDSO_RAW_TIME_SEC,	offsetof(struct vdso_data, raw_time_sec));
-  DEFINE(VDSO_RAW_TIME_NSEC,	offsetof(struct vdso_data, raw_time_nsec));
-  DEFINE(VDSO_XTIME_CLK_SEC,	offsetof(struct vdso_data, xtime_clock_sec));
-  DEFINE(VDSO_XTIME_CLK_NSEC,	offsetof(struct vdso_data, xtime_clock_nsec));
-  DEFINE(VDSO_XTIME_CRS_SEC,	offsetof(struct vdso_data, xtime_coarse_sec));
-  DEFINE(VDSO_XTIME_CRS_NSEC,	offsetof(struct vdso_data, xtime_coarse_nsec));
-  DEFINE(VDSO_WTM_CLK_SEC,	offsetof(struct vdso_data, wtm_clock_sec));
-  DEFINE(VDSO_WTM_CLK_NSEC,	offsetof(struct vdso_data, wtm_clock_nsec));
-  DEFINE(VDSO_TB_SEQ_COUNT,	offsetof(struct vdso_data, tb_seq_count));
-  DEFINE(VDSO_CS_MONO_MULT,	offsetof(struct vdso_data, cs_mono_mult));
-  DEFINE(VDSO_CS_RAW_MULT,	offsetof(struct vdso_data, cs_raw_mult));
-  DEFINE(VDSO_CS_SHIFT,		offsetof(struct vdso_data, cs_shift));
-  DEFINE(VDSO_TZ_MINWEST,	offsetof(struct vdso_data, tz_minuteswest));
-  DEFINE(VDSO_TZ_DSTTIME,	offsetof(struct vdso_data, tz_dsttime));
-  DEFINE(VDSO_USE_SYSCALL,	offsetof(struct vdso_data, use_syscall));
-  BLANK();
-  DEFINE(TVAL_TV_SEC,		offsetof(struct timeval, tv_sec));
-  DEFINE(TVAL_TV_USEC,		offsetof(struct timeval, tv_usec));
-  DEFINE(TSPEC_TV_SEC,		offsetof(struct timespec, tv_sec));
-  DEFINE(TSPEC_TV_NSEC,		offsetof(struct timespec, tv_nsec));
-  BLANK();
-  DEFINE(TZ_MINWEST,		offsetof(struct timezone, tz_minuteswest));
-  DEFINE(TZ_DSTTIME,		offsetof(struct timezone, tz_dsttime));
-  BLANK();
   DEFINE(CPU_BOOT_STACK,	offsetof(struct secondary_data, stack));
   DEFINE(CPU_BOOT_TASK,		offsetof(struct secondary_data, task));
   BLANK();
diff --git a/arch/arm64/kernel/vdso.c b/arch/arm64/kernel/vdso.c
index 2d419006ad43..59f150c25889 100644
--- a/arch/arm64/kernel/vdso.c
+++ b/arch/arm64/kernel/vdso.c
@@ -238,7 +238,7 @@ void update_vsyscall(struct timekeeper *tk)
 		vdso_data->raw_time_sec         = tk->raw_sec;
 		vdso_data->raw_time_nsec        = tk->tkr_raw.xtime_nsec;
 		vdso_data->xtime_clock_sec	= tk->xtime_sec;
-		vdso_data->xtime_clock_nsec	= tk->tkr_mono.xtime_nsec;
+		vdso_data->xtime_clock_snsec	= tk->tkr_mono.xtime_nsec;
 		vdso_data->cs_mono_mult		= tk->tkr_mono.mult;
 		vdso_data->cs_raw_mult		= tk->tkr_raw.mult;
 		/* tkr_mono.shift == tkr_raw.shift */
diff --git a/arch/arm64/kernel/vdso/Makefile b/arch/arm64/kernel/vdso/Makefile
index b215c712d897..21cad81a4f40 100644
--- a/arch/arm64/kernel/vdso/Makefile
+++ b/arch/arm64/kernel/vdso/Makefile
@@ -6,18 +6,32 @@
 # Heavily based on the vDSO Makefiles for other archs.
 #
 
-obj-vdso := gettimeofday.o note.o sigreturn.o
+obj-vdso-s := note.o sigreturn.o
+obj-vdso-c := vgettimeofday.o
 
 # Build rules
-targets := $(obj-vdso) vdso.so vdso.so.dbg
-obj-vdso := $(addprefix $(obj)/, $(obj-vdso))
+targets := $(obj-vdso-s) $(obj-vdso-c) vdso.so vdso.so.dbg
+obj-vdso-s := $(addprefix $(obj)/, $(obj-vdso-s))
+obj-vdso-c := $(addprefix $(obj)/, $(obj-vdso-c))
+obj-vdso   := $(obj-vdso-c) $(obj-vdso-s)
 
-ccflags-y := -shared -fno-common -fno-builtin
+ccflags-y := -shared -fno-common -fno-builtin -fno-stack-protector
+ccflags-y += -DDISABLE_BRANCH_PROFILING
 ccflags-y += -nostdlib -Wl,-soname=linux-vdso.so.1 \
 		$(call cc-ldoption, -Wl$(comma)--hash-style=sysv)
 
+# Force -O2 to avoid libgcc dependencies
+CFLAGS_REMOVE_vgettimeofday.o = -pg -Os
+CFLAGS_vgettimeofday.o = -O2 -fPIC
+ifneq ($(cc-name),clang)
+CFLAGS_vgettimeofday.o += -mcmodel=tiny
+endif
+
 # Disable gcov profiling for VDSO code
 GCOV_PROFILE := n
+KASAN_SANITIZE := n
+UBSAN_SANITIZE := n
+KCOV_INSTRUMENT := n
 
 # Workaround for bare-metal (ELF) toolchains that neglect to pass -shared
 # down to collect2, resulting in silent corruption of the vDSO image.
@@ -50,12 +64,17 @@ include/generated/vdso-offsets.h: $(obj)/vdso.so.dbg FORCE
 	$(call if_changed,vdsosym)
 
 # Assembly rules for the .S files
-$(obj-vdso): %.o: %.S FORCE
+$(obj-vdso-s): %.o: %.S FORCE
 	$(call if_changed_dep,vdsoas)
 
+$(obj-vdso-c): %.o: %.c FORCE
+	$(call if_changed_dep,vdsocc)
+
 # Actual build commands
 quiet_cmd_vdsold = VDSOL   $@
       cmd_vdsold = $(CC) $(c_flags) -Wl,-n -Wl,-T $^ -o $@
+quiet_cmd_vdsocc = VDSOC   $@
+      cmd_vdsocc = ${CC} $(c_flags) -c -o $@ $<
 quiet_cmd_vdsoas = VDSOA   $@
       cmd_vdsoas = $(CC) $(a_flags) -c -o $@ $<
 
diff --git a/arch/arm64/kernel/vdso/compiler.h b/arch/arm64/kernel/vdso/compiler.h
new file mode 100644
index 000000000000..921a7191b497
--- /dev/null
+++ b/arch/arm64/kernel/vdso/compiler.h
@@ -0,0 +1,69 @@
+/*
+ * Userspace implementations of fallback calls
+ *
+ * Copyright (C) 2017 Cavium, Inc.
+ * Copyright (C) 2012 ARM Limited
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program.  If not, see <http://www.gnu.org/licenses/>.
+ *
+ * Author: Will Deacon <will.deacon@arm.com>
+ * Rewriten into C by: Andrew Pinski <apinski@cavium.com>
+ */
+
+#ifndef __VDSO_COMPILER_H
+#define __VDSO_COMPILER_H
+
+#include <asm/processor.h>	/* for cpu_relax()			*/
+#include <asm/sysreg.h>		/* for read_sysreg()			*/
+#include <asm/unistd.h>
+#include <linux/compiler.h>
+#include <linux/hrtimer.h>	/* for LOW_RES_NSEC and MONOTONIC_RES_NSEC */
+
+#ifdef CONFIG_ARM_ARCH_TIMER
+#define ARCH_PROVIDES_TIMER
+#endif
+
+#define DEFINE_FALLBACK(name, type_arg1, name_arg1, type_arg2, name_arg2) \
+static notrace long name##_fallback(type_arg1 _##name_arg1,		  \
+				    type_arg2 _##name_arg2)		  \
+{									  \
+	register type_arg1 name_arg1 asm("x0") = _##name_arg1;		  \
+	register type_arg2 name_arg2 asm("x1") = _##name_arg2;		  \
+	register long ret asm ("x0");					  \
+	register long nr asm("x8") = __NR_##name;			  \
+									  \
+	asm volatile(							  \
+	"	svc #0\n"						  \
+	: "=r" (ret)							  \
+	: "r" (name_arg1), "r" (name_arg2), "r" (nr)			  \
+	: "memory");							  \
+									  \
+	return ret;							  \
+}
+
+/*
+ * AArch64 implementation of arch_counter_get_cntvct() suitable for vdso
+ */
+static __always_inline notrace u64 arch_vdso_read_counter(void)
+{
+	/* Read the virtual counter. */
+	isb();
+	return read_sysreg(cntvct_el0);
+}
+
+/* Rename exported vdso functions */
+#define __vdso_clock_gettime __kernel_clock_gettime
+#define __vdso_gettimeofday __kernel_gettimeofday
+#define __vdso_clock_getres __kernel_clock_getres
+
+#endif /* __VDSO_COMPILER_H */
diff --git a/arch/arm64/kernel/vdso/datapage.h b/arch/arm64/kernel/vdso/datapage.h
new file mode 100644
index 000000000000..be86a6074cf8
--- /dev/null
+++ b/arch/arm64/kernel/vdso/datapage.h
@@ -0,0 +1,59 @@
+/*
+ * Userspace implementations of __get_datapage
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program.  If not, see <http://www.gnu.org/licenses/>.
+ */
+
+#ifndef __VDSO_DATAPAGE_H
+#define __VDSO_DATAPAGE_H
+
+#include <linux/bitops.h>
+#include <linux/types.h>
+#include <asm/vdso_datapage.h>
+
+/*
+ * We use the hidden visibility to prevent the compiler from generating a GOT
+ * relocation. Not only is going through a GOT useless (the entry couldn't and
+ * mustn't be overridden by another library), it does not even work: the linker
+ * cannot generate an absolute address to the data page.
+ *
+ * With the hidden visibility, the compiler simply generates a PC-relative
+ * relocation (R_ARM_REL32), and this is what we need.
+ */
+extern const struct vdso_data _vdso_data __attribute__((visibility("hidden")));
+
+static inline const struct vdso_data *__get_datapage(void)
+{
+	const struct vdso_data *ret;
+	/*
+	 * This simply puts &_vdso_data into ret. The reason why we don't use
+	 * `ret = &_vdso_data` is that the compiler tends to optimise this in a
+	 * very suboptimal way: instead of keeping &_vdso_data in a register,
+	 * it goes through a relocation almost every time _vdso_data must be
+	 * accessed (even in subfunctions). This is both time and space
+	 * consuming: each relocation uses a word in the code section, and it
+	 * has to be loaded at runtime.
+	 *
+	 * This trick hides the assignment from the compiler. Since it cannot
+	 * track where the pointer comes from, it will only use one relocation
+	 * where __get_datapage() is called, and then keep the result in a
+	 * register.
+	 */
+	asm("" : "=r"(ret) : "0"(&_vdso_data));
+	return ret;
+}
+
+/* We can only guarantee 56 bits of precision. */
+#define ARCH_CLOCK_FIXED_MASK GENMASK_ULL(55, 0)
+
+#endif /* __VDSO_DATAPAGE_H */
diff --git a/arch/arm64/kernel/vdso/gettimeofday.S b/arch/arm64/kernel/vdso/gettimeofday.S
deleted file mode 100644
index c39872a7b03c..000000000000
--- a/arch/arm64/kernel/vdso/gettimeofday.S
+++ /dev/null
@@ -1,328 +0,0 @@
-/*
- * Userspace implementations of gettimeofday() and friends.
- *
- * Copyright (C) 2012 ARM Limited
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program.  If not, see <http://www.gnu.org/licenses/>.
- *
- * Author: Will Deacon <will.deacon@arm.com>
- */
-
-#include <linux/linkage.h>
-#include <asm/asm-offsets.h>
-#include <asm/unistd.h>
-
-#define NSEC_PER_SEC_LO16	0xca00
-#define NSEC_PER_SEC_HI16	0x3b9a
-
-vdso_data	.req	x6
-seqcnt		.req	w7
-w_tmp		.req	w8
-x_tmp		.req	x8
-
-/*
- * Conventions for macro arguments:
- * - An argument is write-only if its name starts with "res".
- * - All other arguments are read-only, unless otherwise specified.
- */
-
-	.macro	seqcnt_acquire
-9999:	ldr	seqcnt, [vdso_data, #VDSO_TB_SEQ_COUNT]
-	tbnz	seqcnt, #0, 9999b
-	dmb	ishld
-	.endm
-
-	.macro	seqcnt_check fail
-	dmb	ishld
-	ldr	w_tmp, [vdso_data, #VDSO_TB_SEQ_COUNT]
-	cmp	w_tmp, seqcnt
-	b.ne	\fail
-	.endm
-
-	.macro	syscall_check fail
-	ldr	w_tmp, [vdso_data, #VDSO_USE_SYSCALL]
-	cbnz	w_tmp, \fail
-	.endm
-
-	.macro get_nsec_per_sec res
-	mov	\res, #NSEC_PER_SEC_LO16
-	movk	\res, #NSEC_PER_SEC_HI16, lsl #16
-	.endm
-
-	/*
-	 * Returns the clock delta, in nanoseconds left-shifted by the clock
-	 * shift.
-	 */
-	.macro	get_clock_shifted_nsec res, cycle_last, mult
-	/* Read the virtual counter. */
-	isb
-	mrs	x_tmp, cntvct_el0
-	/* Calculate cycle delta and convert to ns. */
-	sub	\res, x_tmp, \cycle_last
-	/* We can only guarantee 56 bits of precision. */
-	movn	x_tmp, #0xff00, lsl #48
-	and	\res, x_tmp, \res
-	mul	\res, \res, \mult
-	.endm
-
-	/*
-	 * Returns in res_{sec,nsec} the REALTIME timespec, based on the
-	 * "wall time" (xtime) and the clock_mono delta.
-	 */
-	.macro	get_ts_realtime res_sec, res_nsec, \
-			clock_nsec, xtime_sec, xtime_nsec, nsec_to_sec
-	add	\res_nsec, \clock_nsec, \xtime_nsec
-	udiv	x_tmp, \res_nsec, \nsec_to_sec
-	add	\res_sec, \xtime_sec, x_tmp
-	msub	\res_nsec, x_tmp, \nsec_to_sec, \res_nsec
-	.endm
-
-	/*
-	 * Returns in res_{sec,nsec} the timespec based on the clock_raw delta,
-	 * used for CLOCK_MONOTONIC_RAW.
-	 */
-	.macro	get_ts_clock_raw res_sec, res_nsec, clock_nsec, nsec_to_sec
-	udiv	\res_sec, \clock_nsec, \nsec_to_sec
-	msub	\res_nsec, \res_sec, \nsec_to_sec, \clock_nsec
-	.endm
-
-	/* sec and nsec are modified in place. */
-	.macro add_ts sec, nsec, ts_sec, ts_nsec, nsec_to_sec
-	/* Add timespec. */
-	add	\sec, \sec, \ts_sec
-	add	\nsec, \nsec, \ts_nsec
-
-	/* Normalise the new timespec. */
-	cmp	\nsec, \nsec_to_sec
-	b.lt	9999f
-	sub	\nsec, \nsec, \nsec_to_sec
-	add	\sec, \sec, #1
-9999:
-	cmp	\nsec, #0
-	b.ge	9998f
-	add	\nsec, \nsec, \nsec_to_sec
-	sub	\sec, \sec, #1
-9998:
-	.endm
-
-	.macro clock_gettime_return, shift=0
-	.if \shift == 1
-	lsr	x11, x11, x12
-	.endif
-	stp	x10, x11, [x1, #TSPEC_TV_SEC]
-	mov	x0, xzr
-	ret
-	.endm
-
-	.macro jump_slot jumptable, index, label
-	.if (. - \jumptable) != 4 * (\index)
-	.error "Jump slot index mismatch"
-	.endif
-	b	\label
-	.endm
-
-	.text
-
-/* int __kernel_gettimeofday(struct timeval *tv, struct timezone *tz); */
-ENTRY(__kernel_gettimeofday)
-	.cfi_startproc
-	adr	vdso_data, _vdso_data
-	/* If tv is NULL, skip to the timezone code. */
-	cbz	x0, 2f
-
-	/* Compute the time of day. */
-1:	seqcnt_acquire
-	syscall_check fail=4f
-	ldr	x10, [vdso_data, #VDSO_CS_CYCLE_LAST]
-	/* w11 = cs_mono_mult, w12 = cs_shift */
-	ldp	w11, w12, [vdso_data, #VDSO_CS_MONO_MULT]
-	ldp	x13, x14, [vdso_data, #VDSO_XTIME_CLK_SEC]
-	seqcnt_check fail=1b
-
-	get_nsec_per_sec res=x9
-	lsl	x9, x9, x12
-
-	get_clock_shifted_nsec res=x15, cycle_last=x10, mult=x11
-	get_ts_realtime res_sec=x10, res_nsec=x11, \
-		clock_nsec=x15, xtime_sec=x13, xtime_nsec=x14, nsec_to_sec=x9
-
-	/* Convert ns to us. */
-	mov	x13, #1000
-	lsl	x13, x13, x12
-	udiv	x11, x11, x13
-	stp	x10, x11, [x0, #TVAL_TV_SEC]
-2:
-	/* If tz is NULL, return 0. */
-	cbz	x1, 3f
-	ldp	w4, w5, [vdso_data, #VDSO_TZ_MINWEST]
-	stp	w4, w5, [x1, #TZ_MINWEST]
-3:
-	mov	x0, xzr
-	ret
-4:
-	/* Syscall fallback. */
-	mov	x8, #__NR_gettimeofday
-	svc	#0
-	ret
-	.cfi_endproc
-ENDPROC(__kernel_gettimeofday)
-
-#define JUMPSLOT_MAX CLOCK_MONOTONIC_COARSE
-
-/* int __kernel_clock_gettime(clockid_t clock_id, struct timespec *tp); */
-ENTRY(__kernel_clock_gettime)
-	.cfi_startproc
-	cmp	w0, #JUMPSLOT_MAX
-	b.hi	syscall
-	adr	vdso_data, _vdso_data
-	adr	x_tmp, jumptable
-	add	x_tmp, x_tmp, w0, uxtw #2
-	br	x_tmp
-
-	ALIGN
-jumptable:
-	jump_slot jumptable, CLOCK_REALTIME, realtime
-	jump_slot jumptable, CLOCK_MONOTONIC, monotonic
-	b	syscall
-	b	syscall
-	jump_slot jumptable, CLOCK_MONOTONIC_RAW, monotonic_raw
-	jump_slot jumptable, CLOCK_REALTIME_COARSE, realtime_coarse
-	jump_slot jumptable, CLOCK_MONOTONIC_COARSE, monotonic_coarse
-
-	.if (. - jumptable) != 4 * (JUMPSLOT_MAX + 1)
-	.error	"Wrong jumptable size"
-	.endif
-
-	ALIGN
-realtime:
-	seqcnt_acquire
-	syscall_check fail=syscall
-	ldr	x10, [vdso_data, #VDSO_CS_CYCLE_LAST]
-	/* w11 = cs_mono_mult, w12 = cs_shift */
-	ldp	w11, w12, [vdso_data, #VDSO_CS_MONO_MULT]
-	ldp	x13, x14, [vdso_data, #VDSO_XTIME_CLK_SEC]
-	seqcnt_check fail=realtime
-
-	/* All computations are done with left-shifted nsecs. */
-	get_nsec_per_sec res=x9
-	lsl	x9, x9, x12
-
-	get_clock_shifted_nsec res=x15, cycle_last=x10, mult=x11
-	get_ts_realtime res_sec=x10, res_nsec=x11, \
-		clock_nsec=x15, xtime_sec=x13, xtime_nsec=x14, nsec_to_sec=x9
-	clock_gettime_return, shift=1
-
-	ALIGN
-monotonic:
-	seqcnt_acquire
-	syscall_check fail=syscall
-	ldr	x10, [vdso_data, #VDSO_CS_CYCLE_LAST]
-	/* w11 = cs_mono_mult, w12 = cs_shift */
-	ldp	w11, w12, [vdso_data, #VDSO_CS_MONO_MULT]
-	ldp	x13, x14, [vdso_data, #VDSO_XTIME_CLK_SEC]
-	ldp	x3, x4, [vdso_data, #VDSO_WTM_CLK_SEC]
-	seqcnt_check fail=monotonic
-
-	/* All computations are done with left-shifted nsecs. */
-	lsl	x4, x4, x12
-	get_nsec_per_sec res=x9
-	lsl	x9, x9, x12
-
-	get_clock_shifted_nsec res=x15, cycle_last=x10, mult=x11
-	get_ts_realtime res_sec=x10, res_nsec=x11, \
-		clock_nsec=x15, xtime_sec=x13, xtime_nsec=x14, nsec_to_sec=x9
-
-	add_ts sec=x10, nsec=x11, ts_sec=x3, ts_nsec=x4, nsec_to_sec=x9
-	clock_gettime_return, shift=1
-
-	ALIGN
-monotonic_raw:
-	seqcnt_acquire
-	syscall_check fail=syscall
-	ldr	x10, [vdso_data, #VDSO_CS_CYCLE_LAST]
-	/* w11 = cs_raw_mult, w12 = cs_shift */
-	ldp	w12, w11, [vdso_data, #VDSO_CS_SHIFT]
-	ldp	x13, x14, [vdso_data, #VDSO_RAW_TIME_SEC]
-	seqcnt_check fail=monotonic_raw
-
-	/* All computations are done with left-shifted nsecs. */
-	get_nsec_per_sec res=x9
-	lsl	x9, x9, x12
-
-	get_clock_shifted_nsec res=x15, cycle_last=x10, mult=x11
-	get_ts_clock_raw res_sec=x10, res_nsec=x11, \
-		clock_nsec=x15, nsec_to_sec=x9
-
-	add_ts sec=x10, nsec=x11, ts_sec=x13, ts_nsec=x14, nsec_to_sec=x9
-	clock_gettime_return, shift=1
-
-	ALIGN
-realtime_coarse:
-	seqcnt_acquire
-	ldp	x10, x11, [vdso_data, #VDSO_XTIME_CRS_SEC]
-	seqcnt_check fail=realtime_coarse
-	clock_gettime_return
-
-	ALIGN
-monotonic_coarse:
-	seqcnt_acquire
-	ldp	x10, x11, [vdso_data, #VDSO_XTIME_CRS_SEC]
-	ldp	x13, x14, [vdso_data, #VDSO_WTM_CLK_SEC]
-	seqcnt_check fail=monotonic_coarse
-
-	/* Computations are done in (non-shifted) nsecs. */
-	get_nsec_per_sec res=x9
-	add_ts sec=x10, nsec=x11, ts_sec=x13, ts_nsec=x14, nsec_to_sec=x9
-	clock_gettime_return
-
-	ALIGN
-syscall: /* Syscall fallback. */
-	mov	x8, #__NR_clock_gettime
-	svc	#0
-	ret
-	.cfi_endproc
-ENDPROC(__kernel_clock_gettime)
-
-/* int __kernel_clock_getres(clockid_t clock_id, struct timespec *res); */
-ENTRY(__kernel_clock_getres)
-	.cfi_startproc
-	cmp	w0, #CLOCK_REALTIME
-	ccmp	w0, #CLOCK_MONOTONIC, #0x4, ne
-	ccmp	w0, #CLOCK_MONOTONIC_RAW, #0x4, ne
-	b.ne	1f
-
-	ldr	x2, 5f
-	b	2f
-1:
-	cmp	w0, #CLOCK_REALTIME_COARSE
-	ccmp	w0, #CLOCK_MONOTONIC_COARSE, #0x4, ne
-	b.ne	4f
-	ldr	x2, 6f
-2:
-	cbz	x1, 3f
-	stp	xzr, x2, [x1]
-
-3:	/* res == NULL. */
-	mov	w0, wzr
-	ret
-
-4:	/* Syscall fallback. */
-	mov	x8, #__NR_clock_getres
-	svc	#0
-	ret
-5:
-	.quad	CLOCK_REALTIME_RES
-6:
-	.quad	CLOCK_COARSE_RES
-	.cfi_endproc
-ENDPROC(__kernel_clock_getres)
diff --git a/arch/arm64/kernel/vdso/vgettimeofday.c b/arch/arm64/kernel/vdso/vgettimeofday.c
new file mode 100644
index 000000000000..b73d4011993d
--- /dev/null
+++ b/arch/arm64/kernel/vdso/vgettimeofday.c
@@ -0,0 +1,3 @@
+#include "compiler.h"
+#include "datapage.h"
+#include "../../../../lib/vdso/vgettimeofday.c"
-- 
2.19.0.605.g01d371f741-goog

