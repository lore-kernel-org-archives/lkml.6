Return-Path: <SRS0=01Bl=QN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C774C282CB
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 00:13:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B49482175B
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 00:13:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b="A7EZdAvP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730131AbfBFANW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Feb 2019 19:13:22 -0500
Received: from mail-ed1-f66.google.com ([209.85.208.66]:40962 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728088AbfBFAL2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Feb 2019 19:11:28 -0500
Received: by mail-ed1-f66.google.com with SMTP id p15so195924edy.8
        for <linux-kernel@vger.kernel.org>; Tue, 05 Feb 2019 16:11:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=googlenew;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=WndM51WU8pdzt6jdP5YI2BkN/CZXXxuxHJ2OoBlOljk=;
        b=A7EZdAvPLS/rG5JMmil4URAheEtwIZ/tJxdroVMUQZiUYuk95aqKzyGt88gx1C+MeE
         AWeXTuX6ZAeOPfNCDWM8zDXbJUb0v3aoDCPHmpv6MSkLjuGGGS+a1qaKQwAlXtxROw0o
         zbKxCseGM3rP21xV1SyytIF6QTfgnibMohoE6sVO/NEwhDoOf3SCrQ0e7rX8wswDtI0b
         rFAIldE/uWgGENUK50hHI6anE4BpN4r5jDeDERFy4gx5kb6X9NPHvkjQyRP5Bd9Sszvj
         XGRFjBiJ9DYkKdcFXlQTXNR4vzXrT2k0WLqnZ/uLVplYLo7z1l6BuQFC8uh8ioJrM5fX
         xzcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=WndM51WU8pdzt6jdP5YI2BkN/CZXXxuxHJ2OoBlOljk=;
        b=o/mV/wES27107p/NLc1QQLfHR409cDM1QcQuhhpH1axeE1mB0d0WdDA2THimZkeuKL
         65IdawgbJU+kOyHDPf9OrebLc3sVxLaRupkA+JVfEaI8OGQAPZ9hKrw9QTbrW+00D/X/
         n4wQ6520Nqp8BGX6p9oIY/ECO6Z/d+bbeGEt/23qKbqcxCOKvhAh4Z4A7xXzXfvK3gii
         ZRGB5GMnX7517u6SsVdealpB+8g1MCqhRMnCkMssbip4dF/yBpD+vXP01SBt16U0s7V2
         aEYzg9SFBDPKTBueuB/Ua1x3sQchqXNC2ZgQ01zEs3kPBp0ZXaqRwuLAd+TW+NNKPa5Q
         wuFw==
X-Gm-Message-State: AHQUAuauQblOV0wOSCdYenJAm4u2NnP0wyhbtv4i8RyqtjZ9ewdfXxL4
        TlFOfE208oNsQHL5o0mi1/1A7YX2K1U=
X-Google-Smtp-Source: AHgI3IYrj64CLb2Ot6yd5X7ocX6hmOyH4oR6AE9Wlle81eKf1xj/kF1coy3Tg+RfM1yUAPbQ9Gd5KA==
X-Received: by 2002:a50:9770:: with SMTP id d45mr5664532edb.49.1549411885630;
        Tue, 05 Feb 2019 16:11:25 -0800 (PST)
Received: from Mindolluin.ire.aristanetworks.com ([217.173.96.166])
        by smtp.gmail.com with ESMTPSA id p30sm5489594eda.68.2019.02.05.16.11.24
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 05 Feb 2019 16:11:24 -0800 (PST)
From:   Dmitry Safonov <dima@arista.com>
To:     linux-kernel@vger.kernel.org
Cc:     Andrei Vagin <avagin@openvz.org>, Dmitry Safonov <dima@arista.com>,
        Adrian Reber <adrian@lisas.de>,
        Andrei Vagin <avagin@gmail.com>,
        Andy Lutomirski <luto@kernel.org>,
        Andy Tucker <agtucker@google.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Cyrill Gorcunov <gorcunov@openvz.org>,
        Dmitry Safonov <0x7f454c46@gmail.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>,
        Jeff Dike <jdike@addtoit.com>, Oleg Nesterov <oleg@redhat.com>,
        Pavel Emelyanov <xemul@virtuozzo.com>,
        Shuah Khan <shuah@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        containers@lists.linux-foundation.org, criu@openvz.org,
        linux-api@vger.kernel.org, x86@kernel.org
Subject: [PATCH 12/32] x86/vdso/timens: Add offsets page in vvar
Date:   Wed,  6 Feb 2019 00:10:46 +0000
Message-Id: <20190206001107.16488-13-dima@arista.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190206001107.16488-1-dima@arista.com>
References: <20190206001107.16488-1-dima@arista.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andrei Vagin <avagin@openvz.org>

As modern applications fetch time from VDSO without entering the kernel,
it's needed to provide offsets for userspace code inside time namespace.

A page for timens offsets is allocated on time namespace construction.
Put that page into VVAR for tasks inside timens and zero page for
host processes.

As VDSO code is already optimized as much as possible in terms of speed,
any new if-condition in VDSO code is undesirable; the goal is to provide
two .so(s), as was originally suggested by Andy and Thomas:
- for host tasks with optimized-out clk_to_ns() without any penalty
- for processes inside timens with clk_to_ns()
For this purpose, define clk_to_ns() under BUILD_VDSO_TIME_NS, which
will be enabled in the makefile for timens.so in following patches.

VDSO mappings are platform-specific, add Kconfig dependency for arch.

Signed-off-by: Andrei Vagin <avagin@gmail.com>
Co-developed-by: Dmitry Safonov <dima@arista.com>
Signed-off-by: Dmitry Safonov <dima@arista.com>
---
 arch/Kconfig                          |  5 ++++
 arch/x86/Kconfig                      |  1 +
 arch/x86/entry/vdso/vclock_gettime.c  | 42 +++++++++++++++++++++++++++
 arch/x86/entry/vdso/vdso-layout.lds.S |  9 +++++-
 arch/x86/entry/vdso/vdso2c.c          |  3 ++
 arch/x86/entry/vdso/vma.c             | 12 ++++++++
 arch/x86/include/asm/vdso.h           |  1 +
 init/Kconfig                          |  1 +
 8 files changed, 73 insertions(+), 1 deletion(-)

diff --git a/arch/Kconfig b/arch/Kconfig
index 4cfb6de48f79..fd2f96993db9 100644
--- a/arch/Kconfig
+++ b/arch/Kconfig
@@ -704,6 +704,11 @@ config HAVE_ARCH_HASH
 config ISA_BUS_API
 	def_bool ISA
 
+config ARCH_HAS_VDSO_TIME_NS
+	bool
+	help
+	 VDSO can add time-ns offsets without entering kernel.
+
 #
 # ABI hall of shame
 #
diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 68261430fe6e..b415519a293f 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -70,6 +70,7 @@ config X86
 	select ARCH_HAS_STRICT_MODULE_RWX
 	select ARCH_HAS_SYNC_CORE_BEFORE_USERMODE
 	select ARCH_HAS_UBSAN_SANITIZE_ALL
+	select ARCH_HAS_VDSO_TIME_NS
 	select ARCH_HAS_ZONE_DEVICE		if X86_64
 	select ARCH_HAVE_NMI_SAFE_CMPXCHG
 	select ARCH_MIGHT_HAVE_ACPI_PDC		if ACPI
diff --git a/arch/x86/entry/vdso/vclock_gettime.c b/arch/x86/entry/vdso/vclock_gettime.c
index 007b3fe9d727..cb55bd994497 100644
--- a/arch/x86/entry/vdso/vclock_gettime.c
+++ b/arch/x86/entry/vdso/vclock_gettime.c
@@ -21,6 +21,7 @@
 #include <linux/math64.h>
 #include <linux/time.h>
 #include <linux/kernel.h>
+#include <linux/timens_offsets.h>
 
 #define gtod (&VVAR(vsyscall_gtod_data))
 
@@ -38,6 +39,11 @@ extern u8 hvclock_page
 	__attribute__((visibility("hidden")));
 #endif
 
+#ifdef BUILD_VDSO_TIME_NS
+extern u8 timens_page
+	__attribute__((visibility("hidden")));
+#endif
+
 #ifndef BUILD_VDSO32
 
 notrace static long vdso_fallback_gettime(long clock, struct timespec *ts)
@@ -139,6 +145,38 @@ notrace static inline u64 vgetcyc(int mode)
 	return U64_MAX;
 }
 
+notrace static __always_inline void clk_to_ns(clockid_t clk, struct timespec *ts)
+{
+#ifdef BUILD_VDSO_TIME_NS
+	struct timens_offsets *timens = (struct timens_offsets *) &timens_page;
+	struct timespec64 *offset64;
+
+	switch (clk) {
+	case CLOCK_MONOTONIC:
+	case CLOCK_MONOTONIC_COARSE:
+	case CLOCK_MONOTONIC_RAW:
+		offset64 = &timens->monotonic_time_offset;
+		break;
+	case CLOCK_BOOTTIME:
+		offset64 = &timens->monotonic_boottime_offset;
+	default:
+		return;
+	}
+
+	ts->tv_nsec += offset64->tv_nsec;
+	ts->tv_sec += offset64->tv_sec;
+	if (ts->tv_nsec >= NSEC_PER_SEC) {
+		ts->tv_nsec -= NSEC_PER_SEC;
+		ts->tv_sec++;
+	}
+	if (ts->tv_nsec < 0) {
+		ts->tv_nsec += NSEC_PER_SEC;
+		ts->tv_sec--;
+	}
+
+#endif
+}
+
 notrace static int do_hres(clockid_t clk, struct timespec *ts)
 {
 	struct vgtod_ts *base = &gtod->basetime[clk];
@@ -165,6 +203,8 @@ notrace static int do_hres(clockid_t clk, struct timespec *ts)
 	ts->tv_sec = sec + __iter_div_u64_rem(ns, NSEC_PER_SEC, &ns);
 	ts->tv_nsec = ns;
 
+	clk_to_ns(clk, ts);
+
 	return 0;
 }
 
@@ -178,6 +218,8 @@ notrace static void do_coarse(clockid_t clk, struct timespec *ts)
 		ts->tv_sec = base->sec;
 		ts->tv_nsec = base->nsec;
 	} while (unlikely(gtod_read_retry(gtod, seq)));
+
+	clk_to_ns(clk, ts);
 }
 
 notrace int __vdso_clock_gettime(clockid_t clock, struct timespec *ts)
diff --git a/arch/x86/entry/vdso/vdso-layout.lds.S b/arch/x86/entry/vdso/vdso-layout.lds.S
index 93c6dc7812d0..ba216527e59f 100644
--- a/arch/x86/entry/vdso/vdso-layout.lds.S
+++ b/arch/x86/entry/vdso/vdso-layout.lds.S
@@ -7,6 +7,12 @@
  * This script controls its layout.
  */
 
+#ifdef CONFIG_TIME_NS
+# define TIMENS_SZ	PAGE_SIZE
+#else
+# define TIMENS_SZ	0
+#endif
+
 SECTIONS
 {
 	/*
@@ -16,7 +22,7 @@ SECTIONS
 	 * segment.
 	 */
 
-	vvar_start = . - 3 * PAGE_SIZE;
+	vvar_start = . - (3 * PAGE_SIZE + TIMENS_SZ);
 	vvar_page = vvar_start;
 
 	/* Place all vvars at the offsets in asm/vvar.h. */
@@ -28,6 +34,7 @@ SECTIONS
 
 	pvclock_page = vvar_start + PAGE_SIZE;
 	hvclock_page = vvar_start + 2 * PAGE_SIZE;
+	timens_page = vvar_start + 3 * PAGE_SIZE;
 
 	. = SIZEOF_HEADERS;
 
diff --git a/arch/x86/entry/vdso/vdso2c.c b/arch/x86/entry/vdso/vdso2c.c
index 26d7177c119e..ed66b023d4b9 100644
--- a/arch/x86/entry/vdso/vdso2c.c
+++ b/arch/x86/entry/vdso/vdso2c.c
@@ -76,6 +76,7 @@ enum {
 	sym_hpet_page,
 	sym_pvclock_page,
 	sym_hvclock_page,
+	sym_timens_page,
 };
 
 const int special_pages[] = {
@@ -83,6 +84,7 @@ const int special_pages[] = {
 	sym_hpet_page,
 	sym_pvclock_page,
 	sym_hvclock_page,
+	sym_timens_page,
 };
 
 struct vdso_sym {
@@ -96,6 +98,7 @@ struct vdso_sym required_syms[] = {
 	[sym_hpet_page] = {"hpet_page", true},
 	[sym_pvclock_page] = {"pvclock_page", true},
 	[sym_hvclock_page] = {"hvclock_page", true},
+	[sym_timens_page] = {"timens_page", true},
 	{"VDSO32_NOTE_MASK", true},
 	{"__kernel_vsyscall", true},
 	{"__kernel_sigreturn", true},
diff --git a/arch/x86/entry/vdso/vma.c b/arch/x86/entry/vdso/vma.c
index babc4e7a519c..d1031db94093 100644
--- a/arch/x86/entry/vdso/vma.c
+++ b/arch/x86/entry/vdso/vma.c
@@ -14,6 +14,7 @@
 #include <linux/elf.h>
 #include <linux/cpu.h>
 #include <linux/ptrace.h>
+#include <linux/time_namespace.h>
 #include <asm/pvclock.h>
 #include <asm/vgtod.h>
 #include <asm/proto.h>
@@ -23,6 +24,7 @@
 #include <asm/desc.h>
 #include <asm/cpufeature.h>
 #include <asm/mshyperv.h>
+#include <asm/page.h>
 
 #if defined(CONFIG_X86_64)
 unsigned int __read_mostly vdso64_enabled = 1;
@@ -123,6 +125,16 @@ static vm_fault_t vvar_fault(const struct vm_special_mapping *sm,
 		if (tsc_pg && vclock_was_used(VCLOCK_HVCLOCK))
 			return vmf_insert_pfn(vma, vmf->address,
 					vmalloc_to_pfn(tsc_pg));
+	} else if (sym_offset == image->sym_timens_page) {
+		struct time_namespace *ns = current->nsproxy->time_ns;
+		unsigned long pfn;
+
+		if (!ns->offsets)
+			pfn = page_to_pfn(ZERO_PAGE(0));
+		else
+			pfn = page_to_pfn(virt_to_page(ns->offsets));
+
+		return vmf_insert_pfn(vma, vmf->address, pfn);
 	}
 
 	return VM_FAULT_SIGBUS;
diff --git a/arch/x86/include/asm/vdso.h b/arch/x86/include/asm/vdso.h
index 27566e57e87d..619322065b8e 100644
--- a/arch/x86/include/asm/vdso.h
+++ b/arch/x86/include/asm/vdso.h
@@ -22,6 +22,7 @@ struct vdso_image {
 	long sym_hpet_page;
 	long sym_pvclock_page;
 	long sym_hvclock_page;
+	long sym_timens_page;
 	long sym_VDSO32_NOTE_MASK;
 	long sym___kernel_sigreturn;
 	long sym___kernel_rt_sigreturn;
diff --git a/init/Kconfig b/init/Kconfig
index 03ed7b2694b5..14e94a64064a 100644
--- a/init/Kconfig
+++ b/init/Kconfig
@@ -967,6 +967,7 @@ config UTS_NS
 
 config TIME_NS
 	bool "TIME namespace"
+	depends on ARCH_HAS_VDSO_TIME_NS
 	default y
 	help
 	  In this namespace boottime and monotonic clocks can be set.
-- 
2.20.1

