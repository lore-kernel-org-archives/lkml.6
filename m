Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2387443-1519633644-6-11880633367858491868
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES fren, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: 
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1519633643; b=KXvv8a1XLS0va35hRSc6uHA27JpqjtVMbtXoEy27EX+aW57
    0PeCGXwvjm7LIyDg4s7NC/rgB23RbsasaN+slRhu1GcKzfysVnZ+FVEBvB87LmRe
    K3P+c2E+4NrIVJn4N6QwtL5cN962P/VdE/dkOMPCuMAbMFpCZlfBAeyaXh/rrlyt
    RfgTIoQw+lMJos/R7GRR/njcLYjDGXNc2ATUHhUIcBEmHXxcquviWhkudDP/2eWO
    H9R0GPWDTnQtXiiWfNBod1AnSNWMDTHacfrJBRj+Rh8GAM2t7GmwOfzU28+xTh2T
    bHP4rKxjjXhq4nnVYv0lOpsXwdE1v99kYP7eoVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:subject:date:message-id
    :in-reply-to:references:sender:list-id; s=arctest; t=1519633643;
    bh=E4PLUgLdMJiPt35VITpiyZYx813szBZN2dNVjcYWHUQ=; b=HKmRpBvAEvTl
    dWHV4YaUXkv7JgUelXzudnxis+7e7J1IRpkJWyPtRchYGtiCXgOmp5JPMaPUAt9k
    mqNuVYqqq8BduerVHA5WQ8Fve8K82TPhP9vDv7R/He7DAB/uUB0DA3y9B6xsOFm1
    MMJCARbkCuhvVOqMdlCnyQB47Y0yhyLo3PY1KdgpCYyYz7SUrodlgdqKeuqVTnGR
    NUk3f62T6BJ74RywK3H6BZUm3e8nZJBLrWVQLG3KJ+jfveT8LB1MsPy/qaN7OwyQ
    R1JOGOgQ22AAfDlj6YaVzVLxD0q4TUbK42g9u3UUAMjGA0VNWUZ+YYJ3PrXLcqYF
    FgsVN7AonA==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=linaro.org header.i=@linaro.org header.b=S3WGURxE x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=google;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=linaro.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=BWymVXqT;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linaro.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=linaro.org header.i=@linaro.org header.b=S3WGURxE x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=google;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=linaro.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=BWymVXqT;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linaro.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752842AbeBZI1T (ORCPT <rfc822;greg@kroah.com>);
        Mon, 26 Feb 2018 03:27:19 -0500
Received: from mail-pg0-f68.google.com ([74.125.83.68]:46765 "EHLO
        mail-pg0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752524AbeBZI1P (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 26 Feb 2018 03:27:15 -0500
X-Google-Smtp-Source: AH8x22690KXUM4b5Q8JvDWMjh0ZoGKn965bRsMycXm2ZBRA1JScLst0lAotBmZIvQJy4fhlhFNWqdg==
From: Alex Shi <alex.shi@linaro.org>
To: Marc Zyngier <marc.zyngier@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        stable@vger.kernel.org, Russell King <linux@armlinux.org.uk>,
        linux-arm-kernel@lists.infradead.org (moderated list:ARM PORT),
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH 47/52] arm: Invalidate BTB on prefetch abort outside of user mapping on Cortex A8, A9, A12 and A17
Date: Mon, 26 Feb 2018 16:20:21 +0800
Message-Id: <1519633227-29832-48-git-send-email-alex.shi@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1519633227-29832-1-git-send-email-alex.shi@linaro.org>
References: <1519633227-29832-1-git-send-email-alex.shi@linaro.org>
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Marc Zyngier <marc.zyngier@arm.com>

** Not yet queued for inclusion in mainline **

In order to prevent aliasing attacks on the branch predictor,
invalidate the BTB on CPUs that are known to be affected when taking
a prefetch abort on a address that is outside of a user task limit.

Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
Signed-off-by: Will Deacon <will.deacon@arm.com>
Signed-off-by: Alex Shi <alex.shi@linaro.org>
---
 arch/arm/include/asm/cp15.h |  2 ++
 arch/arm/mm/fault.c         | 25 ++++++++++++++++
 arch/arm/mm/fsr-2level.c    |  4 +--
 arch/arm/mm/fsr-3level.c    | 69 +++++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 98 insertions(+), 2 deletions(-)

diff --git a/arch/arm/include/asm/cp15.h b/arch/arm/include/asm/cp15.h
index dbdbce1..0672ddc 100644
--- a/arch/arm/include/asm/cp15.h
+++ b/arch/arm/include/asm/cp15.h
@@ -64,6 +64,8 @@
 #define __write_sysreg(v, r, w, c, t)	asm volatile(w " " c : : "r" ((t)(v)))
 #define write_sysreg(v, ...)		__write_sysreg(v, __VA_ARGS__)
 
+#define BPIALL				__ACCESS_CP15(c7, 0, c5, 6)
+
 extern unsigned long cr_alignment;	/* defined in entry-armv.S */
 
 static inline unsigned long get_cr(void)
diff --git a/arch/arm/mm/fault.c b/arch/arm/mm/fault.c
index f7861dc..17fd0c7 100644
--- a/arch/arm/mm/fault.c
+++ b/arch/arm/mm/fault.c
@@ -20,6 +20,7 @@
 #include <linux/highmem.h>
 #include <linux/perf_event.h>
 
+#include <asm/cp15.h>
 #include <asm/exception.h>
 #include <asm/pgtable.h>
 #include <asm/system_misc.h>
@@ -395,12 +396,36 @@ do_page_fault(unsigned long addr, unsigned int fsr, struct pt_regs *regs)
 	__do_kernel_fault(mm, addr, fsr, regs);
 	return 0;
 }
+
+static int __maybe_unused
+do_pabt_page_fault(unsigned long addr, unsigned int fsr, struct pt_regs *regs)
+{
+#ifdef CONFIG_HARDEN_BRANCH_PREDICTOR
+	if (addr > TASK_SIZE) {
+		switch (read_cpuid_part()) {
+		case ARM_CPU_PART_CORTEX_A8:
+		case ARM_CPU_PART_CORTEX_A9:
+		case ARM_CPU_PART_CORTEX_A12:
+		case ARM_CPU_PART_CORTEX_A17:
+			write_sysreg(0, BPIALL);
+			break;
+		}
+	}
+#endif
+	return do_page_fault(addr, fsr, regs);
+}
 #else					/* CONFIG_MMU */
 static int
 do_page_fault(unsigned long addr, unsigned int fsr, struct pt_regs *regs)
 {
 	return 0;
 }
+
+static int
+do_pabt_page_fault(unsigned long addr, unsigned int fsr, struct pt_regs *regs)
+{
+	return 0;
+}
 #endif					/* CONFIG_MMU */
 
 /*
diff --git a/arch/arm/mm/fsr-2level.c b/arch/arm/mm/fsr-2level.c
index 18ca74c..4cede9b 100644
--- a/arch/arm/mm/fsr-2level.c
+++ b/arch/arm/mm/fsr-2level.c
@@ -50,7 +50,7 @@ static struct fsr_info ifsr_info[] = {
 	{ do_bad,		SIGBUS,  0,		"unknown 4"			   },
 	{ do_translation_fault,	SIGSEGV, SEGV_MAPERR,	"section translation fault"	   },
 	{ do_bad,		SIGSEGV, SEGV_ACCERR,	"page access flag fault"	   },
-	{ do_page_fault,	SIGSEGV, SEGV_MAPERR,	"page translation fault"	   },
+	{ do_pabt_page_fault,	SIGSEGV, SEGV_MAPERR,	"page translation fault"	   },
 	{ do_bad,		SIGBUS,	 0,		"external abort on non-linefetch"  },
 	{ do_bad,		SIGSEGV, SEGV_ACCERR,	"section domain fault"		   },
 	{ do_bad,		SIGBUS,  0,		"unknown 10"			   },
@@ -58,7 +58,7 @@ static struct fsr_info ifsr_info[] = {
 	{ do_bad,		SIGBUS,	 0,		"external abort on translation"	   },
 	{ do_sect_fault,	SIGSEGV, SEGV_ACCERR,	"section permission fault"	   },
 	{ do_bad,		SIGBUS,	 0,		"external abort on translation"	   },
-	{ do_page_fault,	SIGSEGV, SEGV_ACCERR,	"page permission fault"		   },
+	{ do_pabt_page_fault,	SIGSEGV, SEGV_ACCERR,	"page permission fault"		   },
 	{ do_bad,		SIGBUS,  0,		"unknown 16"			   },
 	{ do_bad,		SIGBUS,  0,		"unknown 17"			   },
 	{ do_bad,		SIGBUS,  0,		"unknown 18"			   },
diff --git a/arch/arm/mm/fsr-3level.c b/arch/arm/mm/fsr-3level.c
index ab4409a..2745f7f 100644
--- a/arch/arm/mm/fsr-3level.c
+++ b/arch/arm/mm/fsr-3level.c
@@ -65,4 +65,73 @@ static struct fsr_info fsr_info[] = {
 	{ do_bad,		SIGBUS,  0,		"unknown 63"			},
 };
 
+#ifdef CONFIG_HARDEN_BRANCH_PREDICTOR
+static struct fsr_info ifsr_info[] = {
+	{ do_bad,		SIGBUS,  0,		"unknown 0"			},
+	{ do_bad,		SIGBUS,  0,		"unknown 1"			},
+	{ do_bad,		SIGBUS,  0,		"unknown 2"			},
+	{ do_bad,		SIGBUS,  0,		"unknown 3"			},
+	{ do_bad,		SIGBUS,  0,		"reserved translation fault"	},
+	{ do_translation_fault,	SIGSEGV, SEGV_MAPERR,	"level 1 translation fault"	},
+	{ do_translation_fault,	SIGSEGV, SEGV_MAPERR,	"level 2 translation fault"	},
+	{ do_pabt_page_fault,	SIGSEGV, SEGV_MAPERR,	"level 3 translation fault"	},
+	{ do_bad,		SIGBUS,  0,		"reserved access flag fault"	},
+	{ do_bad,		SIGSEGV, SEGV_ACCERR,	"level 1 access flag fault"	},
+	{ do_pabt_page_fault,	SIGSEGV, SEGV_ACCERR,	"level 2 access flag fault"	},
+	{ do_pabt_page_fault,	SIGSEGV, SEGV_ACCERR,	"level 3 access flag fault"	},
+	{ do_bad,		SIGBUS,  0,		"reserved permission fault"	},
+	{ do_bad,		SIGSEGV, SEGV_ACCERR,	"level 1 permission fault"	},
+	{ do_pabt_page_fault,	SIGSEGV, SEGV_ACCERR,	"level 2 permission fault"	},
+	{ do_pabt_page_fault,	SIGSEGV, SEGV_ACCERR,	"level 3 permission fault"	},
+	{ do_bad,		SIGBUS,  0,		"synchronous external abort"	},
+	{ do_bad,		SIGBUS,  0,		"asynchronous external abort"	},
+	{ do_bad,		SIGBUS,  0,		"unknown 18"			},
+	{ do_bad,		SIGBUS,  0,		"unknown 19"			},
+	{ do_bad,		SIGBUS,  0,		"synchronous abort (translation table walk)" },
+	{ do_bad,		SIGBUS,  0,		"synchronous abort (translation table walk)" },
+	{ do_bad,		SIGBUS,  0,		"synchronous abort (translation table walk)" },
+	{ do_bad,		SIGBUS,  0,		"synchronous abort (translation table walk)" },
+	{ do_bad,		SIGBUS,  0,		"synchronous parity error"	},
+	{ do_bad,		SIGBUS,  0,		"asynchronous parity error"	},
+	{ do_bad,		SIGBUS,  0,		"unknown 26"			},
+	{ do_bad,		SIGBUS,  0,		"unknown 27"			},
+	{ do_bad,		SIGBUS,  0,		"synchronous parity error (translation table walk" },
+	{ do_bad,		SIGBUS,  0,		"synchronous parity error (translation table walk" },
+	{ do_bad,		SIGBUS,  0,		"synchronous parity error (translation table walk" },
+	{ do_bad,		SIGBUS,  0,		"synchronous parity error (translation table walk" },
+	{ do_bad,		SIGBUS,  0,		"unknown 32"			},
+	{ do_bad,		SIGBUS,  BUS_ADRALN,	"alignment fault"		},
+	{ do_bad,		SIGBUS,  0,		"debug event"			},
+	{ do_bad,		SIGBUS,  0,		"unknown 35"			},
+	{ do_bad,		SIGBUS,  0,		"unknown 36"			},
+	{ do_bad,		SIGBUS,  0,		"unknown 37"			},
+	{ do_bad,		SIGBUS,  0,		"unknown 38"			},
+	{ do_bad,		SIGBUS,  0,		"unknown 39"			},
+	{ do_bad,		SIGBUS,  0,		"unknown 40"			},
+	{ do_bad,		SIGBUS,  0,		"unknown 41"			},
+	{ do_bad,		SIGBUS,  0,		"unknown 42"			},
+	{ do_bad,		SIGBUS,  0,		"unknown 43"			},
+	{ do_bad,		SIGBUS,  0,		"unknown 44"			},
+	{ do_bad,		SIGBUS,  0,		"unknown 45"			},
+	{ do_bad,		SIGBUS,  0,		"unknown 46"			},
+	{ do_bad,		SIGBUS,  0,		"unknown 47"			},
+	{ do_bad,		SIGBUS,  0,		"unknown 48"			},
+	{ do_bad,		SIGBUS,  0,		"unknown 49"			},
+	{ do_bad,		SIGBUS,  0,		"unknown 50"			},
+	{ do_bad,		SIGBUS,  0,		"unknown 51"			},
+	{ do_bad,		SIGBUS,  0,		"implementation fault (lockdown abort)" },
+	{ do_bad,		SIGBUS,  0,		"unknown 53"			},
+	{ do_bad,		SIGBUS,  0,		"unknown 54"			},
+	{ do_bad,		SIGBUS,  0,		"unknown 55"			},
+	{ do_bad,		SIGBUS,  0,		"unknown 56"			},
+	{ do_bad,		SIGBUS,  0,		"unknown 57"			},
+	{ do_bad,		SIGBUS,  0,		"implementation fault (coprocessor abort)" },
+	{ do_bad,		SIGBUS,  0,		"unknown 59"			},
+	{ do_bad,		SIGBUS,  0,		"unknown 60"			},
+	{ do_bad,		SIGBUS,  0,		"unknown 61"			},
+	{ do_bad,		SIGBUS,  0,		"unknown 62"			},
+	{ do_bad,		SIGBUS,  0,		"unknown 63"			},
+};
+#else
 #define ifsr_info	fsr_info
+#endif
-- 
2.7.4
