Return-Path: <SRS0=J4ua=MJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33A04C43382
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 16:03:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D0B2921547
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 16:03:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D0B2921547
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728401AbeI0WW3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Sep 2018 18:22:29 -0400
Received: from terminus.zytor.com ([198.137.202.136]:43427 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727599AbeI0WW2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Sep 2018 18:22:28 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w8RG2Z5q083311
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Thu, 27 Sep 2018 09:02:35 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w8RG2ZFs083308;
        Thu, 27 Sep 2018 09:02:35 -0700
Date:   Thu, 27 Sep 2018 09:02:35 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Ard Biesheuvel <tipbot@zytor.com>
Message-ID: <tip-b40a142b12b5c4312171140ff2bc92971b8a7a09@git.kernel.org>
Cc:     hpa@zytor.com, heiko.carstens@de.ibm.com, peterz@infradead.org,
        jeyu@kernel.org, arnd@arndb.de, ard.biesheuvel@linaro.org,
        catalin.marinas@arm.com, keescook@chromium.org,
        will.deacon@arm.com, rostedt@goodmis.org,
        linux-kernel@vger.kernel.org, schwidefsky@de.ibm.com,
        tglx@linutronix.de, mingo@kernel.org
Reply-To: will.deacon@arm.com, keescook@chromium.org, jeyu@kernel.org,
          hpa@zytor.com, heiko.carstens@de.ibm.com, peterz@infradead.org,
          ard.biesheuvel@linaro.org, catalin.marinas@arm.com,
          arnd@arndb.de, schwidefsky@de.ibm.com, mingo@kernel.org,
          tglx@linutronix.de, linux-kernel@vger.kernel.org,
          rostedt@goodmis.org
In-Reply-To: <20180919065144.25010-5-ard.biesheuvel@linaro.org>
References: <20180919065144.25010-5-ard.biesheuvel@linaro.org>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:core/core] x86: Add support for 64-bit place relative
 relocations
Git-Commit-ID: b40a142b12b5c4312171140ff2bc92971b8a7a09
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  b40a142b12b5c4312171140ff2bc92971b8a7a09
Gitweb:     https://git.kernel.org/tip/b40a142b12b5c4312171140ff2bc92971b8a7a09
Author:     Ard Biesheuvel <ard.biesheuvel@linaro.org>
AuthorDate: Tue, 18 Sep 2018 23:51:39 -0700
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Thu, 27 Sep 2018 17:56:47 +0200

x86: Add support for 64-bit place relative relocations

Add support for R_X86_64_PC64 relocations, which operate on 64-bit
quantities holding a relative symbol reference. Also remove the
definition of R_X86_64_NUM: given that it is currently unused, it
is unclear what the new value should be.

Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-s390@vger.kernel.org
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Heiko Carstens <heiko.carstens@de.ibm.com>
Cc: Kees Cook <keescook@chromium.org>
Cc: Will Deacon <will.deacon@arm.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Martin Schwidefsky <schwidefsky@de.ibm.com>
Cc: Jessica Yu <jeyu@kernel.org>
Link: https://lkml.kernel.org/r/20180919065144.25010-5-ard.biesheuvel@linaro.org

---
 arch/x86/include/asm/elf.h |  3 +--
 arch/x86/kernel/module.c   |  6 ++++++
 arch/x86/tools/relocs.c    | 10 ++++++++++
 arch/x86/um/asm/elf.h      |  3 +--
 4 files changed, 18 insertions(+), 4 deletions(-)

diff --git a/arch/x86/include/asm/elf.h b/arch/x86/include/asm/elf.h
index 0d157d2a1e2a..a357031d85b5 100644
--- a/arch/x86/include/asm/elf.h
+++ b/arch/x86/include/asm/elf.h
@@ -62,8 +62,7 @@ typedef struct user_fxsr_struct elf_fpxregset_t;
 #define R_X86_64_PC16		13	/* 16 bit sign extended pc relative */
 #define R_X86_64_8		14	/* Direct 8 bit sign extended  */
 #define R_X86_64_PC8		15	/* 8 bit sign extended pc relative */
-
-#define R_X86_64_NUM		16
+#define R_X86_64_PC64		24	/* Place relative 64-bit signed */
 
 /*
  * These are used to set parameters in the core dumps.
diff --git a/arch/x86/kernel/module.c b/arch/x86/kernel/module.c
index f58336af095c..b052e883dd8c 100644
--- a/arch/x86/kernel/module.c
+++ b/arch/x86/kernel/module.c
@@ -201,6 +201,12 @@ int apply_relocate_add(Elf64_Shdr *sechdrs,
 				goto overflow;
 #endif
 			break;
+		case R_X86_64_PC64:
+			if (*(u64 *)loc != 0)
+				goto invalid_relocation;
+			val -= (u64)loc;
+			*(u64 *)loc = val;
+			break;
 		default:
 			pr_err("%s: Unknown rela relocation: %llu\n",
 			       me->name, ELF64_R_TYPE(rel[i].r_info));
diff --git a/arch/x86/tools/relocs.c b/arch/x86/tools/relocs.c
index 3a6c8ebc8032..0b08067c45f3 100644
--- a/arch/x86/tools/relocs.c
+++ b/arch/x86/tools/relocs.c
@@ -196,6 +196,7 @@ static const char *rel_type(unsigned type)
 #if ELF_BITS == 64
 		REL_TYPE(R_X86_64_NONE),
 		REL_TYPE(R_X86_64_64),
+		REL_TYPE(R_X86_64_PC64),
 		REL_TYPE(R_X86_64_PC32),
 		REL_TYPE(R_X86_64_GOT32),
 		REL_TYPE(R_X86_64_PLT32),
@@ -782,6 +783,15 @@ static int do_reloc64(struct section *sec, Elf_Rel *rel, ElfW(Sym) *sym,
 			add_reloc(&relocs32neg, offset);
 		break;
 
+	case R_X86_64_PC64:
+		/*
+		 * Only used by jump labels
+		 */
+		if (is_percpu_sym(sym, symname))
+			die("Invalid R_X86_64_PC64 relocation against per-CPU symbol %s\n",
+			    symname);
+		break;
+
 	case R_X86_64_32:
 	case R_X86_64_32S:
 	case R_X86_64_64:
diff --git a/arch/x86/um/asm/elf.h b/arch/x86/um/asm/elf.h
index 548197212a45..413f3519d9a1 100644
--- a/arch/x86/um/asm/elf.h
+++ b/arch/x86/um/asm/elf.h
@@ -116,8 +116,7 @@ do {								\
 #define R_X86_64_PC16		13	/* 16 bit sign extended pc relative */
 #define R_X86_64_8		14	/* Direct 8 bit sign extended  */
 #define R_X86_64_PC8		15	/* 8 bit sign extended pc relative */
-
-#define R_X86_64_NUM		16
+#define R_X86_64_PC64		24	/* Place relative 64-bit signed */
 
 /*
  * This is used to ensure we don't load something for the wrong architecture.
