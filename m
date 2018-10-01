Return-Path: <SRS0=RFFj=MN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D23DC43143
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 10:30:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A345E2064A
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 10:30:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="p5lh2jgP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A345E2064A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729263AbeJARH1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Oct 2018 13:07:27 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:42831 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729095AbeJARH1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Oct 2018 13:07:27 -0400
Received: by mail-wr1-f66.google.com with SMTP id b11-v6so13282797wru.9;
        Mon, 01 Oct 2018 03:30:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=BuqiJ2fLUAzPyqlCL2lXV95rZaNViJafD17WkvulLeA=;
        b=p5lh2jgPCiZovnBrwA7PdKBKtR7X2/L1K6yHw9jfwuSYmxmJm0fTnvIz8kLdiN2UEX
         CdiiwXSsbvkx/XC7kn1MtbVLaBiXiysLrR02wnwbKZZ1LMtN9lbDKFxFz7NAFpBtPtfC
         bWPMUVN/GfmHTxCqQztUEjlBp7cVcdnbQvw7EjHdRjwAhMDhGtX+z3H1hVMOdCsQhZeT
         X1neFIpRFfG/7Pxcr9zpnFIz6rCCrBY9LDjhdqCUshI5HDGiLS5JdUqBUoKIczowsVMr
         M+4HFqUWjZ5HcjQ8NbL6V+mCntGX4fCqJ0hMgMPvguHRuwTxR6Zl0aIdiX4jAP3uG+1s
         AG1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=BuqiJ2fLUAzPyqlCL2lXV95rZaNViJafD17WkvulLeA=;
        b=LPCYjNxdaZR/NRx2hLj8dy4heqQ6/Vsa9z1mHzrSeOlmLQyAUqInXYhZyySFb6MiUT
         qvY9PPPFKQGzlzI3PO7268mvDvi5o8x6g2Uklx2iK6l7BpUIzIhkNRb+NItfyAWIiA4j
         nCcRK7lc1eiikAaoUSZHayVIcgKv3jGSVMYyD+XASNl9E7zsAhcJemX6XbE8Tn9UC/ns
         UvZccYA6sawK5PAqr2IeAeYKf1IYUCl0Qrar7R/eH6NNvqx4ZgCyv5Anb0Xe5OmysCW9
         DABSMv3baPpNmp+VLyMkXWHyiNGQIYCyin5o3jJtHgLX2aA4tEsEM7ya5uv+AbKk8zOF
         dqRg==
X-Gm-Message-State: ABuFfojNMsdoL/+l7gufI0pAMBMdW5nEPmip6ih9rlp3FBWj+p9E7Pg1
        cLt/zd/4MTEcRT/2s4GHNjQ=
X-Google-Smtp-Source: ACcGV630DRn5/r46cOMaiSGDv6Id+eC9HG3KQ5F00PgCggNJWLds4S7zQ/Ngup/rwpRzUxpWOyss3Q==
X-Received: by 2002:adf:c793:: with SMTP id l19-v6mr1083751wrg.230.1538389815908;
        Mon, 01 Oct 2018 03:30:15 -0700 (PDT)
Received: from laptop.localdomain ([37.122.159.87])
        by smtp.gmail.com with ESMTPSA id g8-v6sm2461169wmf.45.2018.10.01.03.30.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 01 Oct 2018 03:30:15 -0700 (PDT)
From:   Yasha Cherikovsky <yasha.che3@gmail.com>
To:     Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@mips.com>,
        James Hogan <jhogan@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, linux-mips@linux-mips.org,
        devicetree@vger.kernel.org
Cc:     Yasha Cherikovsky <yasha.che3@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: [RFC v2 1/7] MIPS: Add support for the Lexra LX5280 CPU
Date:   Mon,  1 Oct 2018 13:29:46 +0300
Message-Id: <20181001102952.7913-2-yasha.che3@gmail.com>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20181001102952.7913-1-yasha.che3@gmail.com>
References: <20181001102952.7913-1-yasha.che3@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Lexra LX5280 CPU [1][2] implements the MIPS-I ISA,
without unaligned load/store instructions (lwl, lwr, swl, swr).
The programming model of this CPU is very similar
to the R3000 programming model, with a few differences.

The Realtek RTL8186 SoC has this CPU, so this patch is required
for future RTL8186 SoC support.

The LX5280 CPU has no documented TLB unit (only SMMU, a simple MMU unit
which is not enough for usual Linux).
However, the RTL8186 SoC does include a TLB unit with the CPU
(programmed like R3000 TLB).

So this patch adds support *only* for LX5280s that have a TLB unit.

This patch includes:
- Adding Kconfig entries for LX5280
- Adding CPU_LX5280 to the cpu_type_enum
- Passing -march=lx5280 to the compiler
- Using existing R3000 code/behavior where possible
- Wait instruction support (for better idle power consuption)
- RDHWR instruction emulation from the page fault handler
  (more details in a code comment)

[1] https://www.linux-mips.org/wiki/Lexra
[2] https://wikidevi.com/wiki/Lexra_LX5280

Signed-off-by: Yasha Cherikovsky <yasha.che3@gmail.com>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: Paul Burton <paul.burton@mips.com>
Cc: James Hogan <jhogan@kernel.org>
Cc: linux-mips@linux-mips.org
Cc: linux-kernel@vger.kernel.org
---
 arch/mips/Kconfig                    |  30 +++-
 arch/mips/Makefile                   |   1 +
 arch/mips/include/asm/cpu-features.h |   3 +
 arch/mips/include/asm/cpu-type.h     |   4 +
 arch/mips/include/asm/cpu.h          |   9 +
 arch/mips/include/asm/isadep.h       |   3 +-
 arch/mips/include/asm/mipsregs.h     |  10 ++
 arch/mips/include/asm/module.h       |   2 +
 arch/mips/include/asm/pgtable-32.h   |   7 +-
 arch/mips/include/asm/pgtable-bits.h |   9 +-
 arch/mips/include/asm/pgtable.h      |   6 +-
 arch/mips/include/asm/stackframe.h   |   9 +-
 arch/mips/include/asm/traps.h        |   2 +
 arch/mips/kernel/Makefile            |   2 +
 arch/mips/kernel/cpu-probe.c         |   6 +
 arch/mips/kernel/entry.S             |   3 +-
 arch/mips/kernel/genex.S             |   6 +-
 arch/mips/kernel/idle.c              |  10 ++
 arch/mips/kernel/process.c           |   3 +-
 arch/mips/kernel/traps.c             |  42 +++++
 arch/mips/lib/Makefile               |   1 +
 arch/mips/mm/Makefile                |   1 +
 arch/mips/mm/c-lx5280.c              | 251 +++++++++++++++++++++++++++
 arch/mips/mm/cache.c                 |   6 +
 arch/mips/mm/fault.c                 |   4 +
 arch/mips/mm/tlbex.c                 |   1 +
 26 files changed, 408 insertions(+), 23 deletions(-)
 create mode 100644 arch/mips/mm/c-lx5280.c

diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index a6b0391996ea..bbeabd6b0a80 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -1558,6 +1558,17 @@ config CPU_R3000
 	  might be a safe bet.  If the resulting kernel does not work,
 	  try to recompile with R3000.
 
+config CPU_LX5280
+	bool "LX5280"
+	depends on SYS_HAS_CPU_LX5280
+	select CPU_SUPPORTS_32BIT_KERNEL
+	help
+	  Choose this option to build a kernel for the Lexra LX5280 CPU.
+	  Lexra LX5280 implements the MIPS-I instruction set, without
+	  unaligned load and store instructions (lwl, lwr, swl, swr).
+	  Only LX5280 CPUs with a TLB unit are supported.
+
+
 config CPU_TX39XX
 	bool "R39XX"
 	depends on SYS_HAS_CPU_TX39XX
@@ -1939,6 +1950,9 @@ config SYS_HAS_CPU_R3000
 config SYS_HAS_CPU_TX39XX
 	bool
 
+config SYS_HAS_CPU_LX5280
+	bool
+
 config SYS_HAS_CPU_VR41XX
 	bool
 
@@ -2169,7 +2183,7 @@ config PAGE_SIZE_8KB
 
 config PAGE_SIZE_16KB
 	bool "16kB"
-	depends on !CPU_R3000 && !CPU_TX39XX
+	depends on !CPU_R3000 && !CPU_TX39XX && !CPU_LX5280
 	help
 	  Using 16kB page size will result in higher performance kernel at
 	  the price of higher memory consumption.  This option is available on
@@ -2188,7 +2202,7 @@ config PAGE_SIZE_32KB
 
 config PAGE_SIZE_64KB
 	bool "64kB"
-	depends on !CPU_R3000 && !CPU_TX39XX
+	depends on !CPU_R3000 && !CPU_TX39XX && !CPU_LX5280
 	help
 	  Using 64kB page size will result in higher performance kernel at
 	  the price of higher memory consumption.  This option is available on
@@ -2256,15 +2270,15 @@ config CPU_HAS_PREFETCH
 
 config CPU_GENERIC_DUMP_TLB
 	bool
-	default y if !(CPU_R3000 || CPU_R8000 || CPU_TX39XX)
+	default y if !(CPU_R3000 || CPU_R8000 || CPU_TX39XX || CPU_LX5280)
 
 config CPU_R4K_FPU
 	bool
-	default y if !(CPU_R3000 || CPU_TX39XX)
+	default y if !(CPU_R3000 || CPU_TX39XX || CPU_LX5280)
 
 config CPU_R4K_CACHE_TLB
 	bool
-	default y if !(CPU_R3000 || CPU_R8000 || CPU_SB1 || CPU_TX39XX || CPU_CAVIUM_OCTEON)
+	default y if !(CPU_R3000 || CPU_R8000 || CPU_SB1 || CPU_TX39XX || CPU_CAVIUM_OCTEON || CPU_LX5280)
 
 config MIPS_MT_SMP
 	bool "MIPS MT SMP support (1 TC on each available VPE)"
@@ -2501,7 +2515,7 @@ config CPU_MIPSR2_IRQ_EI
 
 config CPU_HAS_SYNC
 	bool
-	depends on !CPU_R3000
+	depends on !(CPU_R3000 || CPU_LX5280)
 	default y
 
 #
@@ -2519,14 +2533,14 @@ config CPU_R4400_WORKAROUNDS
 
 config MIPS_ASID_SHIFT
 	int
-	default 6 if CPU_R3000 || CPU_TX39XX
+	default 6 if CPU_R3000 || CPU_TX39XX || CPU_LX5280
 	default 4 if CPU_R8000
 	default 0
 
 config MIPS_ASID_BITS
 	int
 	default 0 if MIPS_ASID_BITS_VARIABLE
-	default 6 if CPU_R3000 || CPU_TX39XX
+	default 6 if CPU_R3000 || CPU_TX39XX || CPU_LX5280
 	default 8
 
 config MIPS_ASID_BITS_VARIABLE
diff --git a/arch/mips/Makefile b/arch/mips/Makefile
index e2122cca4ae2..293403f38ffe 100644
--- a/arch/mips/Makefile
+++ b/arch/mips/Makefile
@@ -151,6 +151,7 @@ cflags-y += -fno-stack-check
 #
 cflags-$(CONFIG_CPU_R3000)	+= -march=r3000
 cflags-$(CONFIG_CPU_TX39XX)	+= -march=r3900
+cflags-$(CONFIG_CPU_LX5280)	+= -march=lx5280
 cflags-$(CONFIG_CPU_R4300)	+= -march=r4300 -Wa,--trap
 cflags-$(CONFIG_CPU_VR41XX)	+= -march=r4100 -Wa,--trap
 cflags-$(CONFIG_CPU_R4X00)	+= -march=r4600 -Wa,--trap
diff --git a/arch/mips/include/asm/cpu-features.h b/arch/mips/include/asm/cpu-features.h
index 9cdb4e4ce258..118e0ff4b54a 100644
--- a/arch/mips/include/asm/cpu-features.h
+++ b/arch/mips/include/asm/cpu-features.h
@@ -75,6 +75,9 @@
 #ifndef cpu_has_octeon_cache
 #define cpu_has_octeon_cache	0
 #endif
+#ifndef cpu_has_lx5280_cache
+#define cpu_has_lx5280_cache	(cpu_data[0].options & MIPS_CPU_LX5280_CACHE)
+#endif
 /* Don't override `cpu_has_fpu' to 1 or the "nofpu" option won't work.  */
 #ifndef cpu_has_fpu
 #define cpu_has_fpu		(current_cpu_data.options & MIPS_CPU_FPU)
diff --git a/arch/mips/include/asm/cpu-type.h b/arch/mips/include/asm/cpu-type.h
index a45af3de075d..bd837232196d 100644
--- a/arch/mips/include/asm/cpu-type.h
+++ b/arch/mips/include/asm/cpu-type.h
@@ -105,6 +105,10 @@ static inline int __pure __get_cpu_type(const int cpu_type)
 	case CPU_TX3927:
 #endif
 
+#ifdef CONFIG_SYS_HAS_CPU_LX5280
+	case CPU_LX5280:
+#endif
+
 #ifdef CONFIG_SYS_HAS_CPU_VR41XX
 	case CPU_VR41XX:
 	case CPU_VR4111:
diff --git a/arch/mips/include/asm/cpu.h b/arch/mips/include/asm/cpu.h
index 5b9d02ef4f60..970a263b52d9 100644
--- a/arch/mips/include/asm/cpu.h
+++ b/arch/mips/include/asm/cpu.h
@@ -90,6 +90,7 @@
 #define PRID_IMP_R5432		0x5400
 #define PRID_IMP_R5500		0x5500
 #define PRID_IMP_LOONGSON_64	0x6300  /* Loongson-2/3 */
+#define PRID_IMP_LX5280		0xC600
 
 #define PRID_IMP_UNKNOWN	0xff00
 
@@ -306,6 +307,11 @@ enum cpu_type_enum {
 	 */
 	CPU_TX3912, CPU_TX3922, CPU_TX3927,
 
+	/*
+	 * Lexra processors
+	 */
+	CPU_LX5280,
+
 	/*
 	 * MIPS32 class processors
 	 */
@@ -420,6 +426,9 @@ enum cpu_type_enum {
 				MBIT_ULL(55)	/* CPU shares FTLB entries with another */
 #define MIPS_CPU_MT_PER_TC_PERF_COUNTERS \
 				MBIT_ULL(56)	/* CPU has perf counters implemented per TC (MIPSMT ASE) */
+#define MIPS_CPU_LX5280_CACHE \
+				MBIT_ULL(57)
+
 
 /*
  * CPU ASE encodings
diff --git a/arch/mips/include/asm/isadep.h b/arch/mips/include/asm/isadep.h
index d1683202399b..e725bec9a8ab 100644
--- a/arch/mips/include/asm/isadep.h
+++ b/arch/mips/include/asm/isadep.h
@@ -10,7 +10,8 @@
 #ifndef __ASM_ISADEP_H
 #define __ASM_ISADEP_H
 
-#if defined(CONFIG_CPU_R3000) || defined(CONFIG_CPU_TX39XX)
+#if defined(CONFIG_CPU_R3000) || defined(CONFIG_CPU_TX39XX) || \
+	defined(CONFIG_CPU_LX5280)
 /*
  * R2000 or R3000
  */
diff --git a/arch/mips/include/asm/mipsregs.h b/arch/mips/include/asm/mipsregs.h
index ae461d91cd1f..d3d025d08f3d 100644
--- a/arch/mips/include/asm/mipsregs.h
+++ b/arch/mips/include/asm/mipsregs.h
@@ -81,6 +81,7 @@
 #define CP0_WATCHLO $18
 #define CP0_WATCHHI $19
 #define CP0_XCONTEXT $20
+#define CP0_LX5280_CCTL $20
 #define CP0_FRAMEMASK $21
 #define CP0_DIAGNOSTIC $22
 #define CP0_DEBUG $23
@@ -562,6 +563,12 @@
 #define MIPS_CONF_AT		(_ULCAST_(3) << 13)
 #define MIPS_CONF_M		(_ULCAST_(1) << 31)
 
+/* Bits specific to the Lexra LX5280 CPU. */
+#define LX5280_CCTL_DINVAL		(_ULCAST_(1) << 0)
+#define LX5280_CCTL_IINVAL		(_ULCAST_(1) << 1)
+#define LX5280_CCTL_IMEMFILL		(_ULCAST_(1) << 4)
+#define LX5280_CCTL_IMEMOFF		(_ULCAST_(1) << 5)
+
 /*
  * Bits in the MIPS32/64 PRA coprocessor 0 config registers 1 and above.
  */
@@ -1725,6 +1732,9 @@ do {									\
 #define read_c0_xcontext()	__read_ulong_c0_register($20, 0)
 #define write_c0_xcontext(val)	__write_ulong_c0_register($20, 0, val)
 
+#define read_c0_lx5280_cctl()	__read_ulong_c0_register($20, 0)
+#define write_c0_lx5280_cctl(val)	__write_ulong_c0_register($20, 0, val)
+
 #define read_c0_intcontrol()	__read_32bit_c0_ctrl_register($20)
 #define write_c0_intcontrol(val) __write_32bit_c0_ctrl_register($20, val)
 
diff --git a/arch/mips/include/asm/module.h b/arch/mips/include/asm/module.h
index 6dc0b21b8acd..8547620e20b1 100644
--- a/arch/mips/include/asm/module.h
+++ b/arch/mips/include/asm/module.h
@@ -137,6 +137,8 @@ search_module_dbetables(unsigned long addr)
 #define MODULE_PROC_FAMILY "XLR "
 #elif defined CONFIG_CPU_XLP
 #define MODULE_PROC_FAMILY "XLP "
+#elif defined CONFIG_CPU_LX5280
+#define MODULE_PROC_FAMILY "LX5280 "
 #else
 #error MODULE_PROC_FAMILY undefined for your processor configuration
 #endif
diff --git a/arch/mips/include/asm/pgtable-32.h b/arch/mips/include/asm/pgtable-32.h
index 74afe8c76bdd..54000c0dc56e 100644
--- a/arch/mips/include/asm/pgtable-32.h
+++ b/arch/mips/include/asm/pgtable-32.h
@@ -175,7 +175,8 @@ static inline pte_t pfn_pte(unsigned long pfn, pgprot_t prot)
 	((pte_t *)page_address(pmd_page(*(dir))) + __pte_offset(address))
 #define pte_unmap(pte) ((void)(pte))
 
-#if defined(CONFIG_CPU_R3000) || defined(CONFIG_CPU_TX39XX)
+#if defined(CONFIG_CPU_R3000) || defined(CONFIG_CPU_TX39XX) || \
+	defined(CONFIG_CPU_LX5280)
 
 /* Swap entries must have VALID bit cleared. */
 #define __swp_type(x)			(((x).val >> 10) & 0x1f)
@@ -220,6 +221,8 @@ static inline pte_t pfn_pte(unsigned long pfn, pgprot_t prot)
 
 #endif /* defined(CONFIG_PHYS_ADDR_T_64BIT) && defined(CONFIG_CPU_MIPS32) */
 
-#endif /* defined(CONFIG_CPU_R3000) || defined(CONFIG_CPU_TX39XX) */
+#endif /* defined(CONFIG_CPU_R3000) || defined(CONFIG_CPU_TX39XX) || \
+	* defined(CONFIG_CPU_LX5280)
+	*/
 
 #endif /* _ASM_PGTABLE_32_H */
diff --git a/arch/mips/include/asm/pgtable-bits.h b/arch/mips/include/asm/pgtable-bits.h
index f88a48cd68b2..75bb141f308d 100644
--- a/arch/mips/include/asm/pgtable-bits.h
+++ b/arch/mips/include/asm/pgtable-bits.h
@@ -80,7 +80,8 @@ enum pgtable_bits {
 	_PAGE_MODIFIED_SHIFT,
 };
 
-#elif defined(CONFIG_CPU_R3000) || defined(CONFIG_CPU_TX39XX)
+#elif defined(CONFIG_CPU_R3000) || defined(CONFIG_CPU_TX39XX) || \
+	defined(CONFIG_CPU_LX5280)
 
 /* Page table bits used for r3k systems */
 enum pgtable_bits {
@@ -146,7 +147,8 @@ enum pgtable_bits {
 #define _PAGE_GLOBAL		(1 << _PAGE_GLOBAL_SHIFT)
 #define _PAGE_VALID		(1 << _PAGE_VALID_SHIFT)
 #define _PAGE_DIRTY		(1 << _PAGE_DIRTY_SHIFT)
-#if defined(CONFIG_CPU_R3000) || defined(CONFIG_CPU_TX39XX)
+#if defined(CONFIG_CPU_R3000) || defined(CONFIG_CPU_TX39XX) || \
+	defined(CONFIG_CPU_LX5280)
 # define _CACHE_UNCACHED	(1 << _CACHE_UNCACHED_SHIFT)
 # define _CACHE_MASK		_CACHE_UNCACHED
 # define _PFN_SHIFT		PAGE_SHIFT
@@ -204,7 +206,8 @@ static inline uint64_t pte_to_entrylo(unsigned long pte_val)
 /*
  * Cache attributes
  */
-#if defined(CONFIG_CPU_R3000) || defined(CONFIG_CPU_TX39XX)
+#if defined(CONFIG_CPU_R3000) || defined(CONFIG_CPU_TX39XX) || \
+	defined(CONFIG_CPU_LX5280)
 
 #define _CACHE_CACHABLE_NONCOHERENT 0
 #define _CACHE_UNCACHED_ACCELERATED _CACHE_UNCACHED
diff --git a/arch/mips/include/asm/pgtable.h b/arch/mips/include/asm/pgtable.h
index 129e0328367f..688ac35441ab 100644
--- a/arch/mips/include/asm/pgtable.h
+++ b/arch/mips/include/asm/pgtable.h
@@ -197,7 +197,8 @@ static inline void pte_clear(struct mm_struct *mm, unsigned long addr, pte_t *pt
 static inline void set_pte(pte_t *ptep, pte_t pteval)
 {
 	*ptep = pteval;
-#if !defined(CONFIG_CPU_R3000) && !defined(CONFIG_CPU_TX39XX)
+#if !defined(CONFIG_CPU_R3000) && !defined(CONFIG_CPU_TX39XX) && \
+	!defined(CONFIG_CPU_LX5280)
 	if (pte_val(pteval) & _PAGE_GLOBAL) {
 		pte_t *buddy = ptep_buddy(ptep);
 		/*
@@ -256,7 +257,8 @@ static inline void set_pte(pte_t *ptep, pte_t pteval)
 static inline void pte_clear(struct mm_struct *mm, unsigned long addr, pte_t *ptep)
 {
 	htw_stop();
-#if !defined(CONFIG_CPU_R3000) && !defined(CONFIG_CPU_TX39XX)
+#if !defined(CONFIG_CPU_R3000) && !defined(CONFIG_CPU_TX39XX) && \
+	!defined(CONFIG_CPU_LX5280)
 	/* Preserve global status for the pair */
 	if (pte_val(*ptep_buddy(ptep)) & _PAGE_GLOBAL)
 		set_pte_at(mm, addr, ptep, __pte(_PAGE_GLOBAL));
diff --git a/arch/mips/include/asm/stackframe.h b/arch/mips/include/asm/stackframe.h
index 2161357cc68f..698e635f7afc 100644
--- a/arch/mips/include/asm/stackframe.h
+++ b/arch/mips/include/asm/stackframe.h
@@ -42,7 +42,8 @@
 	cfi_restore \reg \offset \docfi
 	.endm
 
-#if defined(CONFIG_CPU_R3000) || defined(CONFIG_CPU_TX39XX)
+#if defined(CONFIG_CPU_R3000) || defined(CONFIG_CPU_TX39XX) || \
+	defined(CONFIG_CPU_LX5280)
 #define STATMASK 0x3f
 #else
 #define STATMASK 0x1f
@@ -349,7 +350,8 @@
 		cfi_ld	sp, PT_R29, \docfi
 		.endm
 
-#if defined(CONFIG_CPU_R3000) || defined(CONFIG_CPU_TX39XX)
+#if defined(CONFIG_CPU_R3000) || defined(CONFIG_CPU_TX39XX) || \
+	defined(CONFIG_CPU_LX5280)
 
 		.macro	RESTORE_SOME docfi=0
 		.set	push
@@ -477,7 +479,8 @@
 		.macro	KMODE
 		mfc0	t0, CP0_STATUS
 		li	t1, ST0_CU0 | (STATMASK & ~1)
-#if defined(CONFIG_CPU_R3000) || defined(CONFIG_CPU_TX39XX)
+#if defined(CONFIG_CPU_R3000) || defined(CONFIG_CPU_TX39XX) || \
+	defined(CONFIG_CPU_LX5280)
 		andi	t2, t0, ST0_IEP
 		srl	t2, 2
 		or	t0, t2
diff --git a/arch/mips/include/asm/traps.h b/arch/mips/include/asm/traps.h
index f41cf3ee82a7..e611a3d0ac99 100644
--- a/arch/mips/include/asm/traps.h
+++ b/arch/mips/include/asm/traps.h
@@ -39,4 +39,6 @@ extern int register_nmi_notifier(struct notifier_block *nb);
 	register_nmi_notifier(&fn##_nb);				\
 })
 
+int simulate_rdhwr_in_page_fault(struct pt_regs *regs);
+
 #endif /* _ASM_TRAPS_H */
diff --git a/arch/mips/kernel/Makefile b/arch/mips/kernel/Makefile
index f10e1e15e1c6..7fe3f3d4d4b4 100644
--- a/arch/mips/kernel/Makefile
+++ b/arch/mips/kernel/Makefile
@@ -39,12 +39,14 @@ obj-$(CONFIG_FUNCTION_TRACER)	+= mcount.o ftrace.o
 sw-y				:= r4k_switch.o
 sw-$(CONFIG_CPU_R3000)		:= r2300_switch.o
 sw-$(CONFIG_CPU_TX39XX)		:= r2300_switch.o
+sw-$(CONFIG_CPU_LX5280)		:= r2300_switch.o
 sw-$(CONFIG_CPU_CAVIUM_OCTEON)	:= octeon_switch.o
 obj-y				+= $(sw-y)
 
 obj-$(CONFIG_CPU_R4K_FPU)	+= r4k_fpu.o
 obj-$(CONFIG_CPU_R3000)		+= r2300_fpu.o
 obj-$(CONFIG_CPU_TX39XX)	+= r2300_fpu.o
+obj-$(CONFIG_CPU_LX5280)	+= r2300_fpu.o
 
 obj-$(CONFIG_SMP)		+= smp.o
 obj-$(CONFIG_SMP_UP)		+= smp-up.o
diff --git a/arch/mips/kernel/cpu-probe.c b/arch/mips/kernel/cpu-probe.c
index b2509c19cfb5..d7e39635fbe7 100644
--- a/arch/mips/kernel/cpu-probe.c
+++ b/arch/mips/kernel/cpu-probe.c
@@ -1516,6 +1516,12 @@ static inline void cpu_probe_legacy(struct cpuinfo_mips *c, unsigned int cpu)
 			break;
 		}
 
+		break;
+	case PRID_IMP_LX5280:
+		c->cputype = CPU_LX5280;
+		__cpu_name[cpu] = "Lexra LX5280";
+		c->options = MIPS_CPU_TLB | MIPS_CPU_LX5280_CACHE;
+		c->tlbsize = 16; // TODO Lexra: RTL8186 only. use dt?
 		break;
 	}
 }
diff --git a/arch/mips/kernel/entry.S b/arch/mips/kernel/entry.S
index d7de8adcfcc8..ab4cb33020c5 100644
--- a/arch/mips/kernel/entry.S
+++ b/arch/mips/kernel/entry.S
@@ -102,7 +102,8 @@ restore_partial:		# restore partial frame
 	SAVE_AT
 	SAVE_TEMP
 	LONG_L	v0, PT_STATUS(sp)
-#if defined(CONFIG_CPU_R3000) || defined(CONFIG_CPU_TX39XX)
+#if defined(CONFIG_CPU_R3000) || defined(CONFIG_CPU_TX39XX) || \
+	defined(CONFIG_CPU_LX5280)
 	and	v0, ST0_IEP
 #else
 	and	v0, ST0_IE
diff --git a/arch/mips/kernel/genex.S b/arch/mips/kernel/genex.S
index 37b9383eacd3..7d789e20e6ea 100644
--- a/arch/mips/kernel/genex.S
+++ b/arch/mips/kernel/genex.S
@@ -165,7 +165,8 @@ NESTED(handle_int, PT_SIZE, sp)
 	.set	push
 	.set	noat
 	mfc0	k0, CP0_STATUS
-#if defined(CONFIG_CPU_R3000) || defined(CONFIG_CPU_TX39XX)
+#if defined(CONFIG_CPU_R3000) || defined(CONFIG_CPU_TX39XX) || \
+	defined(CONFIG_CPU_LX5280)
 	and	k0, ST0_IEP
 	bnez	k0, 1f
 
@@ -584,7 +585,8 @@ isrdhwr:
 	get_saved_sp	/* k1 := current_thread_info */
 	.set	noreorder
 	MFC0	k0, CP0_EPC
-#if defined(CONFIG_CPU_R3000) || defined(CONFIG_CPU_TX39XX)
+#if defined(CONFIG_CPU_R3000) || defined(CONFIG_CPU_TX39XX) || \
+	defined(CONFIG_CPU_LX5280)
 	ori	k1, _THREAD_MASK
 	xori	k1, _THREAD_MASK
 	LONG_L	v1, TI_TP_VALUE(k1)
diff --git a/arch/mips/kernel/idle.c b/arch/mips/kernel/idle.c
index 7c246b69c545..336d1498a175 100644
--- a/arch/mips/kernel/idle.c
+++ b/arch/mips/kernel/idle.c
@@ -115,6 +115,13 @@ static void au1k_wait(void)
 	: : "r" (au1k_wait), "r" (c0status));
 }
 
+static void lx5280_wait(void)
+{
+	/* Execute LX5280 'sleep' instruction */
+	asm volatile(".word 0x42000038");
+	local_irq_enable();
+}
+
 static int __initdata nowait;
 
 static int __init wait_disable(char *s)
@@ -249,6 +256,9 @@ void __init check_wait(void)
 		   cpu_wait = r4k_wait;
 		 */
 		break;
+	case CPU_LX5280:
+		cpu_wait = lx5280_wait;
+		break;
 	default:
 		break;
 	}
diff --git a/arch/mips/kernel/process.c b/arch/mips/kernel/process.c
index 9670e70139fd..2f92f203dcd0 100644
--- a/arch/mips/kernel/process.c
+++ b/arch/mips/kernel/process.c
@@ -138,7 +138,8 @@ int copy_thread_tls(unsigned long clone_flags, unsigned long usp,
 		p->thread.reg17 = kthread_arg;
 		p->thread.reg29 = childksp;
 		p->thread.reg31 = (unsigned long) ret_from_kernel_thread;
-#if defined(CONFIG_CPU_R3000) || defined(CONFIG_CPU_TX39XX)
+#if defined(CONFIG_CPU_R3000) || defined(CONFIG_CPU_TX39XX) || \
+	defined(CONFIG_CPU_LX5280)
 		status = (status & ~(ST0_KUP | ST0_IEP | ST0_IEC)) |
 			 ((status & (ST0_KUC | ST0_IEC)) << 2);
 #else
diff --git a/arch/mips/kernel/traps.c b/arch/mips/kernel/traps.c
index 8d505a21396e..dda828c4e955 100644
--- a/arch/mips/kernel/traps.c
+++ b/arch/mips/kernel/traps.c
@@ -686,6 +686,48 @@ static int simulate_rdhwr_mm(struct pt_regs *regs, unsigned int opcode)
 	return -1;
 }
 
+/*
+ * When most MIPS CPUs hit 'rdwhr' instruction, they raise a 'reserved
+ * instruction' exception if the instruction is unsupported.
+ * This is not the case with the LX5280 CPU, on which
+ * 'rdhwr' instruction raises a page fault.
+ * So for LX5280, we must do the 'rdhwr' simulation in the
+ * page fault handler.
+ *
+ * Returns 0 on successful simulation.
+ * Register state is not affected on failure.
+ */
+int simulate_rdhwr_in_page_fault(struct pt_regs *regs)
+{
+#ifdef CONFIG_CPU_LX5280
+	unsigned long old_epc = regs->cp0_epc;
+	unsigned long old31 = regs->regs[31];
+	unsigned int opcode = 0;
+	unsigned int __user *epc;
+
+	if (get_isa16_mode(regs->cp0_epc))
+		goto err;
+
+	epc = (unsigned int __user *)exception_epc(regs);
+	if (unlikely(get_user(opcode, epc)))
+		goto err;
+
+	if (unlikely(compute_return_epc(regs) < 0))
+		goto err;
+
+	if (!simulate_rdhwr_normal(regs, opcode))
+		return 0;  /* Success */
+
+err:
+	regs->cp0_epc = old_epc;		/* Undo skip-over.  */
+	regs->regs[31] = old31;
+
+	return -1;
+#else /* !CONFIG_CPU_LX5280 */
+	return -1;
+#endif
+}
+
 static int simulate_sync(struct pt_regs *regs, unsigned int opcode)
 {
 	if ((opcode & OPCODE) == SPEC0 && (opcode & FUNC) == SYNC) {
diff --git a/arch/mips/lib/Makefile b/arch/mips/lib/Makefile
index 6537e022ef62..7d44d11ed9bc 100644
--- a/arch/mips/lib/Makefile
+++ b/arch/mips/lib/Makefile
@@ -14,6 +14,7 @@ lib-$(CONFIG_GENERIC_CSUM)	:= $(filter-out csum_partial.o, $(lib-y))
 obj-$(CONFIG_CPU_GENERIC_DUMP_TLB) += dump_tlb.o
 obj-$(CONFIG_CPU_R3000)		+= r3k_dump_tlb.o
 obj-$(CONFIG_CPU_TX39XX)	+= r3k_dump_tlb.o
+obj-$(CONFIG_CPU_LX5280)	+= r3k_dump_tlb.o
 
 # libgcc-style stuff needed in the kernel
 obj-y += bswapsi.o bswapdi.o multi3.o
diff --git a/arch/mips/mm/Makefile b/arch/mips/mm/Makefile
index c463bdad45c7..1b3e55c26012 100644
--- a/arch/mips/mm/Makefile
+++ b/arch/mips/mm/Makefile
@@ -20,6 +20,7 @@ obj-$(CONFIG_HUGETLB_PAGE)	+= hugetlbpage.o
 
 obj-$(CONFIG_CPU_R4K_CACHE_TLB) += c-r4k.o cex-gen.o tlb-r4k.o
 obj-$(CONFIG_CPU_R3000)		+= c-r3k.o tlb-r3k.o
+obj-$(CONFIG_CPU_LX5280) 	+= c-lx5280.o tlb-r3k.o
 obj-$(CONFIG_CPU_R8000)		+= c-r4k.o cex-gen.o tlb-r8k.o
 obj-$(CONFIG_CPU_SB1)		+= c-r4k.o cerr-sb1.o cex-sb1.o tlb-r4k.o
 obj-$(CONFIG_CPU_TX39XX)	+= c-tx39.o tlb-r3k.o
diff --git a/arch/mips/mm/c-lx5280.c b/arch/mips/mm/c-lx5280.c
new file mode 100644
index 000000000000..c974be564906
--- /dev/null
+++ b/arch/mips/mm/c-lx5280.c
@@ -0,0 +1,251 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * c-lx5280.c: Lexra LX5280 CPU cache code.
+ *
+ * Copyright (C) 2018 Yasha Cherikovsky
+ */
+#include <linux/kernel.h>
+#include <linux/sched.h>
+#include <linux/smp.h>
+#include <linux/mm.h>
+#include <linux/of.h>
+
+#include <asm/page.h>
+#include <asm/pgtable.h>
+#include <asm/mmu_context.h>
+#include <asm/isadep.h>
+#include <asm/io.h>
+#include <asm/bootinfo.h>
+#include <asm/cpu.h>
+
+static unsigned int icache_size, dcache_size;		/* Size in bytes */
+static unsigned int icache_lsize, dcache_lsize;		/* Size in bytes */
+
+
+#define _nop() \
+do { \
+	__asm__ __volatile__("nop"); \
+} while (0)
+
+
+static inline void __lx5280_flush_dcache_internal(void)
+{
+	unsigned long cctl;
+
+	cctl = read_c0_lx5280_cctl();
+	_nop();
+	_nop();
+	_nop();
+	_nop();
+	_nop();
+	_nop();
+	write_c0_lx5280_cctl(cctl & (~LX5280_CCTL_DINVAL));
+	_nop();
+	_nop();
+	_nop();
+	_nop();
+	_nop();
+	_nop();
+	write_c0_lx5280_cctl(cctl | (LX5280_CCTL_DINVAL));
+	_nop();
+	_nop();
+	_nop();
+	_nop();
+	_nop();
+	_nop();
+}
+
+static inline void __lx5280_flush_icache_internal(void)
+{
+	unsigned long cctl;
+
+	cctl = read_c0_lx5280_cctl();
+	_nop();
+	_nop();
+	_nop();
+	_nop();
+	_nop();
+	_nop();
+	write_c0_lx5280_cctl(cctl & (~LX5280_CCTL_IINVAL));
+	_nop();
+	_nop();
+	_nop();
+	_nop();
+	_nop();
+	_nop();
+	write_c0_lx5280_cctl(cctl | (LX5280_CCTL_IINVAL));
+	_nop();
+	_nop();
+	_nop();
+	_nop();
+	_nop();
+	_nop();
+}
+
+static void __lx5280_flush_icache(void)
+{
+	unsigned long flags;
+
+	local_irq_save(flags);
+	__lx5280_flush_icache_internal();
+	local_irq_restore(flags);
+}
+
+static void __lx5280_flush_dcache(void)
+{
+	unsigned long flags;
+
+	local_irq_save(flags);
+	__lx5280_flush_dcache_internal();
+	local_irq_restore(flags);
+}
+
+static void lx5280_flush_icache_range(unsigned long start, unsigned long end)
+{
+	__lx5280_flush_icache();
+}
+
+static void lx5280_flush_dcache_range(unsigned long start, unsigned long end)
+{
+	__lx5280_flush_dcache();
+}
+
+static void lx5280___flush_cache_all(void)
+{
+	unsigned long flags;
+
+	local_irq_save(flags);
+	__lx5280_flush_dcache_internal();
+	__lx5280_flush_icache_internal();
+	local_irq_restore(flags);
+}
+
+static void lx5280_flush_cache_all(void)
+{
+	lx5280___flush_cache_all();
+}
+
+static void lx5280_flush_cache_mm(struct mm_struct *mm)
+{
+	lx5280_flush_cache_all();
+}
+
+static void lx5280_flush_cache_range(struct vm_area_struct *vma,
+				  unsigned long start, unsigned long end)
+{
+	lx5280_flush_cache_all();
+}
+
+static void lx5280_flush_cache_page(struct vm_area_struct *vma,
+				 unsigned long addr, unsigned long pfn)
+{
+	unsigned long kaddr = KSEG0ADDR(pfn << PAGE_SHIFT);
+	struct mm_struct *mm = vma->vm_mm;
+	pgd_t *pgdp;
+	pud_t *pudp;
+	pmd_t *pmdp;
+	pte_t *ptep;
+
+	pr_debug("cpage[%08lx,%08lx]\n",
+		 cpu_context(smp_processor_id(), mm), addr);
+
+	/* No ASID => no such page in the cache.  */
+	if (cpu_context(smp_processor_id(), mm) == 0)
+		return;
+
+	pgdp = pgd_offset(mm, addr);
+	pudp = pud_offset(pgdp, addr);
+	pmdp = pmd_offset(pudp, addr);
+	ptep = pte_offset(pmdp, addr);
+
+	/* Invalid => no such page in the cache.  */
+	if (!(pte_val(*ptep) & _PAGE_PRESENT))
+		return;
+
+	lx5280_flush_dcache_range(kaddr, kaddr + PAGE_SIZE);
+	lx5280_flush_icache_range(kaddr, kaddr + PAGE_SIZE);
+}
+
+static void local_lx5280_flush_data_cache_page(void *addr)
+{
+	__lx5280_flush_dcache();
+}
+
+static void lx5280_flush_data_cache_page(unsigned long addr)
+{
+	__lx5280_flush_dcache();
+}
+
+static void lx5280_flush_cache_sigtramp(unsigned long addr)
+{
+	lx5280_flush_cache_all();
+}
+
+static void lx5280_flush_kernel_vmap_range(unsigned long vaddr, int size)
+{
+	lx5280_flush_cache_all();
+}
+
+static void lx5280_dma_cache_wback_inv(unsigned long start, unsigned long size)
+{
+	lx5280_flush_dcache_range(start, start + size);
+}
+
+static u32 of_property_read_u32_or_panic(struct device_node *np,
+		const char *propname)
+{
+	u32 out_value;
+
+	if (of_property_read_u32(np, propname, &out_value))
+		panic("Unable to get %s from devicetree", propname);
+	return out_value;
+}
+
+void lx5280_cache_init(void)
+{
+	extern void build_clear_page(void);
+	extern void build_copy_page(void);
+	struct device_node *np;
+
+	np = of_get_cpu_node(0, NULL);
+	if (!np)
+		panic("Unable to find cpu node in devicetree");
+
+	dcache_size = of_property_read_u32_or_panic(np, "d-cache-size");
+	icache_size = of_property_read_u32_or_panic(np, "i-cache-size");
+	dcache_lsize = of_property_read_u32_or_panic(np, "d-cache-line-size");
+	icache_lsize = of_property_read_u32_or_panic(np, "i-cache-line-size");
+
+	of_node_put(np);
+
+	current_cpu_data.dcache.linesz = dcache_lsize;
+	current_cpu_data.icache.linesz = icache_lsize;
+
+	flush_cache_all = lx5280_flush_cache_all;
+	__flush_cache_all = lx5280___flush_cache_all;
+	flush_cache_mm = lx5280_flush_cache_mm;
+	flush_cache_range = lx5280_flush_cache_range;
+	flush_cache_page = lx5280_flush_cache_page;
+	flush_icache_range = lx5280_flush_icache_range;
+	local_flush_icache_range = lx5280_flush_icache_range;
+	__flush_icache_user_range = lx5280_flush_icache_range;
+	__local_flush_icache_user_range = lx5280_flush_icache_range;
+
+	__flush_kernel_vmap_range = lx5280_flush_kernel_vmap_range;
+
+	flush_cache_sigtramp = lx5280_flush_cache_sigtramp;
+	local_flush_data_cache_page = local_lx5280_flush_data_cache_page;
+	flush_data_cache_page = lx5280_flush_data_cache_page;
+
+	_dma_cache_wback_inv = lx5280_dma_cache_wback_inv;
+	_dma_cache_wback = lx5280_dma_cache_wback_inv;
+	_dma_cache_inv = lx5280_dma_cache_wback_inv;
+
+	pr_info("Primary instruction cache %dkB, linesize %d bytes.\n",
+		icache_size >> 10, icache_lsize);
+	pr_info("Primary data cache %dkB, linesize %d bytes.\n",
+		dcache_size >> 10, dcache_lsize);
+
+	build_clear_page();
+	build_copy_page();
+}
diff --git a/arch/mips/mm/cache.c b/arch/mips/mm/cache.c
index 0d3c656feba0..873e62cfc821 100644
--- a/arch/mips/mm/cache.c
+++ b/arch/mips/mm/cache.c
@@ -234,6 +234,12 @@ void cpu_cache_init(void)
 		octeon_cache_init();
 	}
 
+	if (cpu_has_lx5280_cache) {
+		extern void __weak lx5280_cache_init(void);
+
+		lx5280_cache_init();
+	}
+
 	setup_protection_map();
 }
 
diff --git a/arch/mips/mm/fault.c b/arch/mips/mm/fault.c
index 5f71f2b903b7..159fd009f5bd 100644
--- a/arch/mips/mm/fault.c
+++ b/arch/mips/mm/fault.c
@@ -26,6 +26,7 @@
 #include <asm/mmu_context.h>
 #include <asm/ptrace.h>
 #include <asm/highmem.h>		/* For VMALLOC_END */
+#include <asm/traps.h>
 #include <linux/kdebug.h>
 
 int show_unhandled_signals = 1;
@@ -204,6 +205,9 @@ static void __kprobes __do_page_fault(struct pt_regs *regs, unsigned long write,
 bad_area_nosemaphore:
 	/* User mode accesses just cause a SIGSEGV */
 	if (user_mode(regs)) {
+		if (!simulate_rdhwr_in_page_fault(regs))
+			return;
+
 		tsk->thread.cp0_badvaddr = address;
 		tsk->thread.error_code = write;
 		if (show_unhandled_signals &&
diff --git a/arch/mips/mm/tlbex.c b/arch/mips/mm/tlbex.c
index 79b9f2ad3ff5..95e745795724 100644
--- a/arch/mips/mm/tlbex.c
+++ b/arch/mips/mm/tlbex.c
@@ -2616,6 +2616,7 @@ void build_tlb_refill_handler(void)
 	case CPU_TX3912:
 	case CPU_TX3922:
 	case CPU_TX3927:
+	case CPU_LX5280:
 #ifndef CONFIG_MIPS_PGD_C0_CONTEXT
 		if (cpu_has_local_ebase)
 			build_r3000_tlb_refill_handler();
-- 
2.19.0

