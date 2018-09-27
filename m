Return-Path: <SRS0=J4ua=MJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 177D9C43382
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 16:04:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BE0BB216FE
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 16:04:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BE0BB216FE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728192AbeI0WXA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Sep 2018 18:23:00 -0400
Received: from terminus.zytor.com ([198.137.202.136]:38183 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727437AbeI0WW7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Sep 2018 18:22:59 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w8RG382r083537
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Thu, 27 Sep 2018 09:03:08 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w8RG38FB083534;
        Thu, 27 Sep 2018 09:03:08 -0700
Date:   Thu, 27 Sep 2018 09:03:08 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Ard Biesheuvel <tipbot@zytor.com>
Message-ID: <tip-9fc0f798ab8a6c042d811e45086260eb59be45c1@git.kernel.org>
Cc:     tglx@linutronix.de, will.deacon@arm.com, keescook@chromium.org,
        schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com,
        catalin.marinas@arm.com, arnd@arndb.de,
        linux-kernel@vger.kernel.org, rostedt@goodmis.org,
        peterz@infradead.org, ard.biesheuvel@linaro.org, hpa@zytor.com,
        mingo@kernel.org, jeyu@kernel.org
Reply-To: peterz@infradead.org, ard.biesheuvel@linaro.org,
          mingo@kernel.org, hpa@zytor.com, jeyu@kernel.org,
          rostedt@goodmis.org, arnd@arndb.de, catalin.marinas@arm.com,
          linux-kernel@vger.kernel.org, tglx@linutronix.de,
          will.deacon@arm.com, schwidefsky@de.ibm.com,
          heiko.carstens@de.ibm.com, keescook@chromium.org
In-Reply-To: <20180919065144.25010-6-ard.biesheuvel@linaro.org>
References: <20180919065144.25010-6-ard.biesheuvel@linaro.org>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:core/core] x86/jump_label: Switch to jump_entry accessors
Git-Commit-ID: 9fc0f798ab8a6c042d811e45086260eb59be45c1
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

Commit-ID:  9fc0f798ab8a6c042d811e45086260eb59be45c1
Gitweb:     https://git.kernel.org/tip/9fc0f798ab8a6c042d811e45086260eb59be45c1
Author:     Ard Biesheuvel <ard.biesheuvel@linaro.org>
AuthorDate: Tue, 18 Sep 2018 23:51:40 -0700
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Thu, 27 Sep 2018 17:56:48 +0200

x86/jump_label: Switch to jump_entry accessors

In preparation of switching x86 to use place-relative references for
the code, target and key members of struct jump_entry, replace direct
references to the struct members with invocations of the new accessors.
This will allow us to make the switch by modifying the accessors only.

This incorporates a cleanup of __jump_label_transform() proposed by
Peter.

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
Link: https://lkml.kernel.org/r/20180919065144.25010-6-ard.biesheuvel@linaro.org

---
 arch/x86/kernel/jump_label.c | 62 ++++++++++++++++++--------------------------
 1 file changed, 25 insertions(+), 37 deletions(-)

diff --git a/arch/x86/kernel/jump_label.c b/arch/x86/kernel/jump_label.c
index eeea935e9bb5..aac0c1f7e354 100644
--- a/arch/x86/kernel/jump_label.c
+++ b/arch/x86/kernel/jump_label.c
@@ -42,55 +42,40 @@ static void __ref __jump_label_transform(struct jump_entry *entry,
 					 void *(*poker)(void *, const void *, size_t),
 					 int init)
 {
-	union jump_code_union code;
+	union jump_code_union jmp;
 	const unsigned char default_nop[] = { STATIC_KEY_INIT_NOP };
 	const unsigned char *ideal_nop = ideal_nops[NOP_ATOMIC5];
+	const void *expect, *code;
+	int line;
+
+	jmp.jump = 0xe9;
+	jmp.offset = jump_entry_target(entry) -
+		     (jump_entry_code(entry) + JUMP_LABEL_NOP_SIZE);
 
 	if (early_boot_irqs_disabled)
 		poker = text_poke_early;
 
 	if (type == JUMP_LABEL_JMP) {
 		if (init) {
-			/*
-			 * Jump label is enabled for the first time.
-			 * So we expect a default_nop...
-			 */
-			if (unlikely(memcmp((void *)entry->code, default_nop, 5)
-				     != 0))
-				bug_at((void *)entry->code, __LINE__);
+			expect = default_nop; line = __LINE__;
 		} else {
-			/*
-			 * ...otherwise expect an ideal_nop. Otherwise
-			 * something went horribly wrong.
-			 */
-			if (unlikely(memcmp((void *)entry->code, ideal_nop, 5)
-				     != 0))
-				bug_at((void *)entry->code, __LINE__);
+			expect = ideal_nop; line = __LINE__;
 		}
 
-		code.jump = 0xe9;
-		code.offset = entry->target -
-				(entry->code + JUMP_LABEL_NOP_SIZE);
+		code = &jmp.code;
 	} else {
-		/*
-		 * We are disabling this jump label. If it is not what
-		 * we think it is, then something must have gone wrong.
-		 * If this is the first initialization call, then we
-		 * are converting the default nop to the ideal nop.
-		 */
 		if (init) {
-			if (unlikely(memcmp((void *)entry->code, default_nop, 5) != 0))
-				bug_at((void *)entry->code, __LINE__);
+			expect = default_nop; line = __LINE__;
 		} else {
-			code.jump = 0xe9;
-			code.offset = entry->target -
-				(entry->code + JUMP_LABEL_NOP_SIZE);
-			if (unlikely(memcmp((void *)entry->code, &code, 5) != 0))
-				bug_at((void *)entry->code, __LINE__);
+			expect = &jmp.code; line = __LINE__;
 		}
-		memcpy(&code, ideal_nops[NOP_ATOMIC5], JUMP_LABEL_NOP_SIZE);
+
+		code = ideal_nop;
 	}
 
+	if (memcmp((void *)jump_entry_code(entry), expect, JUMP_LABEL_NOP_SIZE))
+		bug_at((void *)jump_entry_code(entry), line);
+
 	/*
 	 * Make text_poke_bp() a default fallback poker.
 	 *
@@ -99,11 +84,14 @@ static void __ref __jump_label_transform(struct jump_entry *entry,
 	 * always nop being the 'currently valid' instruction
 	 *
 	 */
-	if (poker)
-		(*poker)((void *)entry->code, &code, JUMP_LABEL_NOP_SIZE);
-	else
-		text_poke_bp((void *)entry->code, &code, JUMP_LABEL_NOP_SIZE,
-			     (void *)entry->code + JUMP_LABEL_NOP_SIZE);
+	if (poker) {
+		(*poker)((void *)jump_entry_code(entry), code,
+			 JUMP_LABEL_NOP_SIZE);
+		return;
+	}
+
+	text_poke_bp((void *)jump_entry_code(entry), code, JUMP_LABEL_NOP_SIZE,
+		     (void *)jump_entry_code(entry) + JUMP_LABEL_NOP_SIZE);
 }
 
 void arch_jump_label_transform(struct jump_entry *entry,
