Return-Path: <SRS0=J4ua=MJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27B70C43382
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 16:06:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C835E216FE
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 16:06:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C835E216FE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728434AbeI0WZ1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Sep 2018 18:25:27 -0400
Received: from terminus.zytor.com ([198.137.202.136]:44177 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727621AbeI0WZ1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Sep 2018 18:25:27 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w8RG5Llh085254
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Thu, 27 Sep 2018 09:05:21 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w8RG5LbP085251;
        Thu, 27 Sep 2018 09:05:21 -0700
Date:   Thu, 27 Sep 2018 09:05:21 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Heiko Carstens <tipbot@zytor.com>
Message-ID: <tip-13ddb52c165ba47d153b7b040931a5cbe9220866@git.kernel.org>
Cc:     heiko.carstens@de.ibm.com, keescook@chromium.org,
        peterz@infradead.org, linux-kernel@vger.kernel.org,
        ard.biesheuvel@linaro.org, arnd@arndb.de, catalin.marinas@arm.com,
        will.deacon@arm.com, schwidefsky@de.ibm.com, hpa@zytor.com,
        mingo@kernel.org, tglx@linutronix.de, jeyu@kernel.org,
        rostedt@goodmis.org
Reply-To: heiko.carstens@de.ibm.com, keescook@chromium.org,
          peterz@infradead.org, arnd@arndb.de, catalin.marinas@arm.com,
          will.deacon@arm.com, linux-kernel@vger.kernel.org,
          ard.biesheuvel@linaro.org, tglx@linutronix.de,
          schwidefsky@de.ibm.com, hpa@zytor.com, mingo@kernel.org,
          rostedt@goodmis.org, jeyu@kernel.org
In-Reply-To: <20180919065144.25010-10-ard.biesheuvel@linaro.org>
References: <20180919065144.25010-10-ard.biesheuvel@linaro.org>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:core/core] s390/jump_label: Switch to relative references
Git-Commit-ID: 13ddb52c165ba47d153b7b040931a5cbe9220866
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

Commit-ID:  13ddb52c165ba47d153b7b040931a5cbe9220866
Gitweb:     https://git.kernel.org/tip/13ddb52c165ba47d153b7b040931a5cbe9220866
Author:     Heiko Carstens <heiko.carstens@de.ibm.com>
AuthorDate: Tue, 18 Sep 2018 23:51:44 -0700
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Thu, 27 Sep 2018 17:56:49 +0200

s390/jump_label: Switch to relative references

Enable support for relative references in jump_label entries.

Signed-off-by: Heiko Carstens <heiko.carstens@de.ibm.com>
Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-s390@vger.kernel.org
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Kees Cook <keescook@chromium.org>
Cc: Will Deacon <will.deacon@arm.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Martin Schwidefsky <schwidefsky@de.ibm.com>
Cc: Jessica Yu <jeyu@kernel.org>
Link: https://lkml.kernel.org/r/20180919065144.25010-10-ard.biesheuvel@linaro.org

---
 arch/s390/Kconfig                  |  1 +
 arch/s390/include/asm/jump_label.h | 40 +++++++++++++++-----------------------
 arch/s390/kernel/jump_label.c      | 11 ++++++-----
 3 files changed, 23 insertions(+), 29 deletions(-)

diff --git a/arch/s390/Kconfig b/arch/s390/Kconfig
index 9a9c7a6fe925..12dc4c1af96c 100644
--- a/arch/s390/Kconfig
+++ b/arch/s390/Kconfig
@@ -120,6 +120,7 @@ config S390
 	select HAVE_ALIGNED_STRUCT_PAGE if SLUB
 	select HAVE_ARCH_AUDITSYSCALL
 	select HAVE_ARCH_JUMP_LABEL
+	select HAVE_ARCH_JUMP_LABEL_RELATIVE
 	select CPU_NO_EFFICIENT_FFS if !HAVE_MARCH_Z9_109_FEATURES
 	select HAVE_ARCH_SECCOMP_FILTER
 	select HAVE_ARCH_SOFT_DIRTY
diff --git a/arch/s390/include/asm/jump_label.h b/arch/s390/include/asm/jump_label.h
index 40f651292aa7..e2d3e6c43395 100644
--- a/arch/s390/include/asm/jump_label.h
+++ b/arch/s390/include/asm/jump_label.h
@@ -14,41 +14,33 @@
  * We use a brcl 0,2 instruction for jump labels at compile time so it
  * can be easily distinguished from a hotpatch generated instruction.
  */
-static __always_inline bool arch_static_branch(struct static_key *key, bool branch)
+static inline bool arch_static_branch(struct static_key *key, bool branch)
 {
-	asm_volatile_goto("0:	brcl 0,"__stringify(JUMP_LABEL_NOP_OFFSET)"\n"
-		".pushsection __jump_table, \"aw\"\n"
-		".balign 8\n"
-		".quad 0b, %l[label], %0\n"
-		".popsection\n"
-		: : "X" (&((char *)key)[branch]) : : label);
-
+	asm_volatile_goto("0:	brcl	0,"__stringify(JUMP_LABEL_NOP_OFFSET)"\n"
+			  ".pushsection __jump_table,\"aw\"\n"
+			  ".balign	8\n"
+			  ".long	0b-.,%l[label]-.\n"
+			  ".quad	%0-.\n"
+			  ".popsection\n"
+			  : : "X" (&((char *)key)[branch]) : : label);
 	return false;
 label:
 	return true;
 }
 
-static __always_inline bool arch_static_branch_jump(struct static_key *key, bool branch)
+static inline bool arch_static_branch_jump(struct static_key *key, bool branch)
 {
-	asm_volatile_goto("0:	brcl 15, %l[label]\n"
-		".pushsection __jump_table, \"aw\"\n"
-		".balign 8\n"
-		".quad 0b, %l[label], %0\n"
-		".popsection\n"
-		: : "X" (&((char *)key)[branch]) : : label);
-
+	asm_volatile_goto("0:	brcl 15,%l[label]\n"
+			  ".pushsection __jump_table,\"aw\"\n"
+			  ".balign	8\n"
+			  ".long	0b-.,%l[label]-.\n"
+			  ".quad	%0-.\n"
+			  ".popsection\n"
+			  : : "X" (&((char *)key)[branch]) : : label);
 	return false;
 label:
 	return true;
 }
 
-typedef unsigned long jump_label_t;
-
-struct jump_entry {
-	jump_label_t code;
-	jump_label_t target;
-	jump_label_t key;
-};
-
 #endif  /* __ASSEMBLY__ */
 #endif
diff --git a/arch/s390/kernel/jump_label.c b/arch/s390/kernel/jump_label.c
index 43f8430fb67d..50a1798604a8 100644
--- a/arch/s390/kernel/jump_label.c
+++ b/arch/s390/kernel/jump_label.c
@@ -33,13 +33,13 @@ static void jump_label_make_branch(struct jump_entry *entry, struct insn *insn)
 {
 	/* brcl 15,offset */
 	insn->opcode = 0xc0f4;
-	insn->offset = (entry->target - entry->code) >> 1;
+	insn->offset = (jump_entry_target(entry) - jump_entry_code(entry)) >> 1;
 }
 
 static void jump_label_bug(struct jump_entry *entry, struct insn *expected,
 			   struct insn *new)
 {
-	unsigned char *ipc = (unsigned char *)entry->code;
+	unsigned char *ipc = (unsigned char *)jump_entry_code(entry);
 	unsigned char *ipe = (unsigned char *)expected;
 	unsigned char *ipn = (unsigned char *)new;
 
@@ -59,6 +59,7 @@ static void __jump_label_transform(struct jump_entry *entry,
 				   enum jump_label_type type,
 				   int init)
 {
+	void *code = (void *)jump_entry_code(entry);
 	struct insn old, new;
 
 	if (type == JUMP_LABEL_JMP) {
@@ -69,13 +70,13 @@ static void __jump_label_transform(struct jump_entry *entry,
 		jump_label_make_nop(entry, &new);
 	}
 	if (init) {
-		if (memcmp((void *)entry->code, &orignop, sizeof(orignop)))
+		if (memcmp(code, &orignop, sizeof(orignop)))
 			jump_label_bug(entry, &orignop, &new);
 	} else {
-		if (memcmp((void *)entry->code, &old, sizeof(old)))
+		if (memcmp(code, &old, sizeof(old)))
 			jump_label_bug(entry, &old, &new);
 	}
-	s390_kernel_write((void *)entry->code, &new, sizeof(new));
+	s390_kernel_write(code, &new, sizeof(new));
 }
 
 static int __sm_arch_jump_label_transform(void *data)
