Return-Path: <green.hu@gmail.com>
X-Cyrus-Session-Id: sloti22d1t05-3695236-1518513129-2-7363471032737121959
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, FREEMAIL_FROM 0.001, RCVD_IN_DNSWL_NONE -0.0001,
  RCVD_IN_MSPIKE_H3 -0.01, RCVD_IN_MSPIKE_WL -0.01, SPF_PASS -0.001,
  LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='74.125.83.65', Host='mail-pg0-f65.google.com', Country='US',
  FromHeader='com', MailFrom='com'
X-Spam-charsets: 
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: green.hu@gmail.com
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1518513128; b=DIjavNQUuawut68Ux/aCkyyhiBfayVS3x5jOluwaH2E0jzO
    17DSZgCKeMR5vbmx8bUDiGjXtdATT+ZNHantQkQl8qn9hJBwe9TtwmP7z8U0RKyK
    RZOx+TcXvot9KprgGKzmf70tq8Ve7FRYs4Mj6hm9n+yvN19y8D8IlPnxwy5UHeZ/
    SxIGMVaZ7fTlOlg2XhtHfh631UxBDBDEYtk9DVa1IyVUGfzbLApZB+eagKtpB6E9
    2XXdyA7EKgGtwd9xqHk2mlIgOH/ZoQZsLfUF4Kqe/Of6OqLN6eJKudcdWNsKnJDg
    nMPz5BRaE96e0/HFSAO5DDwb3VIT7JooVbLiMrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:in-reply-to:references; s=arctest; t=
    1518513128; bh=qqvurvrClowxVShKz8LMIXEu+nVWu82SKhjKLsPvssw=; b=h
    KTq/9rMWqOgcJK/YoyCwM3QBWXyI72QY3etZDalJvTK9mmoGF950uL7za2A8O5vN
    kyMXcUWzYRUu69xqBHadsQKP1oKw5Op6QOk2wwSc9YsNcrgC/j+DoWtYGHyLFGzu
    lw2MlbkBeNQWXytXvbfrsPgCQLW5Kx9fq+pglCi+qd9T17YghPCgyMgLuY2VKYKO
    /9XAIhCVt1yGhDhkJAyBbNrMIGl7IGNXPZlrTBI2rH3WVuqZGzrEm47AhS6ijsG3
    7fjnPUHDebElbbO6y3WGy3DxmuozyeoapAUlKe/XXkX2CXnaT4GoZTYAO8g5ixsf
    RdjtcVvdWwr5zShT9xxAw==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=E/VukaxI x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=pass (p=none,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=74.125.83.65 (mail-pg0-f65.google.com);
    spf=pass smtp.mailfrom=green.hu@gmail.com smtp.helo=mail-pg0-f65.google.com;
    x-aligned-from=pass;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=p4rspzQu;
    x-ptr=pass x-ptr-helo=mail-pg0-f65.google.com x-ptr-lookup=mail-pg0-f65.google.com;
    x-return-mx=pass smtp.domain=gmail.com smtp.result=pass smtp_is_org_domain=yes header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=E/VukaxI x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=pass (p=none,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=74.125.83.65 (mail-pg0-f65.google.com);
    spf=pass smtp.mailfrom=green.hu@gmail.com smtp.helo=mail-pg0-f65.google.com;
    x-aligned-from=pass;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=p4rspzQu;
    x-ptr=pass x-ptr-helo=mail-pg0-f65.google.com x-ptr-lookup=mail-pg0-f65.google.com;
    x-return-mx=pass smtp.domain=gmail.com smtp.result=pass smtp_is_org_domain=yes header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
X-Google-Smtp-Source: AH8x227wV0UzclfFT2d7RXF7sPYeR0ueq42g4TeZHisbnrmagIaDFJzn0ctOLBxow/OCfDvhVOQdPQ==
From: Greentime Hu <green.hu@gmail.com>
X-Google-Original-From: Greentime Hu <greentime@andestech.com>
To: greentime@andestech.com,
	linux-kernel@vger.kernel.org,
	arnd@arndb.de,
	linux-arch@vger.kernel.org,
	tglx@linutronix.de,
	jason@lakedaemon.net,
	marc.zyngier@arm.com,
	robh+dt@kernel.org,
	netdev@vger.kernel.org,
	deanbo422@gmail.com,
	devicetree@vger.kernel.org,
	viro@zeniv.linux.org.uk,
	dhowells@redhat.com,
	will.deacon@arm.com,
	daniel.lezcano@linaro.org,
	linux-serial@vger.kernel.org,
	geert.uytterhoeven@gmail.com,
	linus.walleij@linaro.org,
	mark.rutland@arm.com,
	greg@kroah.com,
	ren_guo@c-sky.com,
	rdunlap@infradead.org,
	davem@davemloft.net,
	jonas@southpole.se,
	stefan.kristiansson@saunalahti.fi,
	shorne@gmail.com
Cc: green.hu@gmail.com,
	Vincent Chen <vincentc@andestech.com>
Subject: [PATCH v7 18/37] nds32: ELF definitions
Date: Tue, 13 Feb 2018 17:09:22 +0800
Message-Id: <24b075d1b99f22b0920ebb0186b5f5af8256f31c.1518505384.git.greentime@andestech.com>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <cover.1518505384.git.greentime@andestech.com>
References: <cover.1518505384.git.greentime@andestech.com>
In-Reply-To: <cover.1518505384.git.greentime@andestech.com>
References: <cover.1518505384.git.greentime@andestech.com>
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

This patch adds definitions for the ELF format, relocation types, vdso
locations and EXEC_PAGESIZE.

Signed-off-by: Vincent Chen <vincentc@andestech.com>
Signed-off-by: Greentime Hu <greentime@andestech.com>
Acked-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/nds32/include/asm/elf.h         | 171 +++++++++++++++++++++++++++++++++++
 arch/nds32/include/uapi/asm/auxvec.h |  12 +++
 arch/nds32/include/uapi/asm/param.h  |  11 +++
 3 files changed, 194 insertions(+)
 create mode 100644 arch/nds32/include/asm/elf.h
 create mode 100644 arch/nds32/include/uapi/asm/auxvec.h
 create mode 100644 arch/nds32/include/uapi/asm/param.h

diff --git a/arch/nds32/include/asm/elf.h b/arch/nds32/include/asm/elf.h
new file mode 100644
index 000000000000..56c479058802
--- /dev/null
+++ b/arch/nds32/include/asm/elf.h
@@ -0,0 +1,171 @@
+// SPDX-License-Identifier: GPL-2.0
+// Copyright (C) 2005-2017 Andes Technology Corporation
+
+#ifndef __ASMNDS32_ELF_H
+#define __ASMNDS32_ELF_H
+
+/*
+ * ELF register definitions..
+ */
+
+#include <asm/ptrace.h>
+
+typedef unsigned long elf_greg_t;
+typedef unsigned long elf_freg_t[3];
+
+extern unsigned int elf_hwcap;
+
+#define EM_NDS32			167
+
+#define R_NDS32_NONE			0
+#define R_NDS32_16_RELA			19
+#define R_NDS32_32_RELA			20
+#define R_NDS32_9_PCREL_RELA		22
+#define R_NDS32_15_PCREL_RELA		23
+#define R_NDS32_17_PCREL_RELA		24
+#define R_NDS32_25_PCREL_RELA		25
+#define R_NDS32_HI20_RELA		26
+#define R_NDS32_LO12S3_RELA		27
+#define R_NDS32_LO12S2_RELA		28
+#define R_NDS32_LO12S1_RELA		29
+#define R_NDS32_LO12S0_RELA		30
+#define R_NDS32_SDA15S3_RELA    	31
+#define R_NDS32_SDA15S2_RELA    	32
+#define R_NDS32_SDA15S1_RELA    	33
+#define R_NDS32_SDA15S0_RELA    	34
+#define R_NDS32_GOT20			37
+#define R_NDS32_25_PLTREL		38
+#define R_NDS32_COPY			39
+#define R_NDS32_GLOB_DAT		40
+#define R_NDS32_JMP_SLOT		41
+#define R_NDS32_RELATIVE		42
+#define R_NDS32_GOTOFF			43
+#define R_NDS32_GOTPC20			44
+#define R_NDS32_GOT_HI20		45
+#define R_NDS32_GOT_LO12		46
+#define R_NDS32_GOTPC_HI20		47
+#define R_NDS32_GOTPC_LO12		48
+#define R_NDS32_GOTOFF_HI20		49
+#define R_NDS32_GOTOFF_LO12		50
+#define R_NDS32_INSN16			51
+#define R_NDS32_LABEL			52
+#define R_NDS32_LONGCALL1		53
+#define R_NDS32_LONGCALL2		54
+#define R_NDS32_LONGCALL3		55
+#define R_NDS32_LONGJUMP1		56
+#define R_NDS32_LONGJUMP2		57
+#define R_NDS32_LONGJUMP3		58
+#define R_NDS32_LOADSTORE		59
+#define R_NDS32_9_FIXED_RELA		60
+#define R_NDS32_15_FIXED_RELA		61
+#define R_NDS32_17_FIXED_RELA		62
+#define R_NDS32_25_FIXED_RELA		63
+#define R_NDS32_PLTREL_HI20		64
+#define R_NDS32_PLTREL_LO12		65
+#define R_NDS32_PLT_GOTREL_HI20		66
+#define R_NDS32_PLT_GOTREL_LO12		67
+#define R_NDS32_LO12S0_ORI_RELA		72
+#define R_NDS32_DWARF2_OP1_RELA     	77
+#define R_NDS32_DWARF2_OP2_RELA     	78
+#define R_NDS32_DWARF2_LEB_RELA     	79
+#define R_NDS32_WORD_9_PCREL_RELA	94
+#define R_NDS32_LONGCALL4 		107
+#define R_NDS32_RELA_NOP_MIX		192
+#define R_NDS32_RELA_NOP_MAX		255
+
+#define ELF_NGREG (sizeof (struct user_pt_regs) / sizeof(elf_greg_t))
+#define ELF_CORE_COPY_REGS(dest, regs)	\
+	*(struct user_pt_regs *)&(dest) = (regs)->user_regs;
+
+typedef elf_greg_t elf_gregset_t[ELF_NGREG];
+
+/* Core file format: The core file is written in such a way that gdb
+   can understand it and provide useful information to the user (under
+   linux we use the 'trad-core' bfd).  There are quite a number of
+   obstacles to being able to view the contents of the floating point
+   registers, and until these are solved you will not be able to view the
+   contents of them.  Actually, you can read in the core file and look at
+   the contents of the user struct to find out what the floating point
+   registers contain.
+   The actual file contents are as follows:
+   UPAGE: 1 page consisting of a user struct that tells gdb what is present
+   in the file.  Directly after this is a copy of the task_struct, which
+   is currently not used by gdb, but it may come in useful at some point.
+   All of the registers are stored as part of the upage.  The upage should
+   always be only one page.
+   DATA: The data area is stored.  We use current->end_text to
+   current->brk to pick up all of the user variables, plus any memory
+   that may have been malloced.  No attempt is made to determine if a page
+   is demand-zero or if a page is totally unused, we just cover the entire
+   range.  All of the addresses are rounded in such a way that an integral
+   number of pages is written.
+   STACK: We need the stack information in order to get a meaningful
+   backtrace.  We need to write the data from (esp) to
+   current->start_stack, so we round each of these off in order to be able
+   to write an integer number of pages.
+   The minimum core file size is 3 pages, or 12288 bytes.
+*/
+
+struct user_fp {
+        unsigned long long fd_regs[32];
+        unsigned long fpcsr;
+};
+
+typedef struct user_fp elf_fpregset_t;
+
+struct elf32_hdr;
+#define elf_check_arch(x)		((x)->e_machine == EM_NDS32)
+
+/*
+ * These are used to set parameters in the core dumps.
+ */
+#define ELF_CLASS	ELFCLASS32
+#ifdef __NDS32_EB__
+#define ELF_DATA	ELFDATA2MSB;
+#else
+#define ELF_DATA	ELFDATA2LSB;
+#endif
+#define ELF_ARCH	EM_NDS32
+#define USE_ELF_CORE_DUMP
+#define ELF_EXEC_PAGESIZE	PAGE_SIZE
+
+/* This is the location that an ET_DYN program is loaded if exec'ed.  Typical
+   use of this is to invoke "./ld.so someprog" to test out a new version of
+   the loader.  We need to make sure that it is out of the way of the program
+   that it will "exec", and that there is sufficient room for the brk.  */
+
+#define ELF_ET_DYN_BASE	(2 * TASK_SIZE / 3)
+
+/* When the program starts, a1 contains a pointer to a function to be
+   registered with atexit, as per the SVR4 ABI.  A value of 0 means we
+   have no such handler.  */
+#define ELF_PLAT_INIT(_r, load_addr)	(_r)->uregs[0] = 0
+
+/* This yields a mask that user programs can use to figure out what
+   instruction set this cpu supports. */
+
+#define ELF_HWCAP	(elf_hwcap)
+
+#ifdef __KERNEL__
+
+#define ELF_PLATFORM    (NULL)
+
+/* Old NetWinder binaries were compiled in such a way that the iBCS
+   heuristic always trips on them.  Until these binaries become uncommon
+   enough not to care, don't trust the `ibcs' flag here.  In any case
+   there is no other ELF system currently supported by iBCS.
+   @@ Could print a warning message to encourage users to upgrade.  */
+#define SET_PERSONALITY(ex)	set_personality(PER_LINUX)
+
+#endif
+
+#define ARCH_DLINFO						\
+do {								\
+	NEW_AUX_ENT(AT_SYSINFO_EHDR,				\
+		    (elf_addr_t)current->mm->context.vdso);	\
+} while (0)
+#define ARCH_HAS_SETUP_ADDITIONAL_PAGES 1
+struct linux_binprm;
+int arch_setup_additional_pages(struct linux_binprm *, int);
+
+#endif
diff --git a/arch/nds32/include/uapi/asm/auxvec.h b/arch/nds32/include/uapi/asm/auxvec.h
new file mode 100644
index 000000000000..56043ce4972f
--- /dev/null
+++ b/arch/nds32/include/uapi/asm/auxvec.h
@@ -0,0 +1,12 @@
+// SPDX-License-Identifier: GPL-2.0
+// Copyright (C) 2005-2017 Andes Technology Corporation
+
+#ifndef __ASM_AUXVEC_H
+#define __ASM_AUXVEC_H
+
+/* VDSO location */
+#define AT_SYSINFO_EHDR	33
+
+#define AT_VECTOR_SIZE_ARCH 1
+
+#endif
diff --git a/arch/nds32/include/uapi/asm/param.h b/arch/nds32/include/uapi/asm/param.h
new file mode 100644
index 000000000000..e3fb723ee362
--- /dev/null
+++ b/arch/nds32/include/uapi/asm/param.h
@@ -0,0 +1,11 @@
+// SPDX-License-Identifier: GPL-2.0
+// Copyright (C) 2005-2017 Andes Technology Corporation
+
+#ifndef __ASM_NDS32_PARAM_H
+#define __ASM_NDS32_PARAM_H
+
+#define EXEC_PAGESIZE	8192
+
+#include <asm-generic/param.h>
+
+#endif /* __ASM_NDS32_PARAM_H */
-- 
2.16.1
