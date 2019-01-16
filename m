Return-Path: <SRS0=1Lvk=PY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8683AC43387
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 11:58:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5C3F0206C2
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 11:58:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389103AbfAPL6t (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Jan 2019 06:58:49 -0500
Received: from terminus.zytor.com ([198.137.202.136]:52395 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732007AbfAPL6s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jan 2019 06:58:48 -0500
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x0GBwZ3t252939
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Wed, 16 Jan 2019 03:58:35 -0800
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x0GBwZtH252936;
        Wed, 16 Jan 2019 03:58:35 -0800
Date:   Wed, 16 Jan 2019 03:58:35 -0800
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Borislav Petkov <tipbot@zytor.com>
Message-ID: <tip-c1d4e4192aa4e7408a81c32a77e7c867a07f8aa2@git.kernel.org>
Cc:     hpa@zytor.com, mingo@kernel.org, bp@suse.de, x86@kernel.org,
        thomas.lendacky@amd.com, peterz@infradead.org, tglx@linutronix.de,
        luto@amacapital.net, linux-kernel@vger.kernel.org,
        jpoimboe@redhat.com
Reply-To: linux-kernel@vger.kernel.org, luto@amacapital.net,
          jpoimboe@redhat.com, thomas.lendacky@amd.com, x86@kernel.org,
          bp@suse.de, tglx@linutronix.de, peterz@infradead.org,
          mingo@kernel.org, hpa@zytor.com
In-Reply-To: <20181211222326.14581-3-bp@alien8.de>
References: <20181211222326.14581-3-bp@alien8.de>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/alternatives] x86/alternatives: Print containing function
Git-Commit-ID: c1d4e4192aa4e7408a81c32a77e7c867a07f8aa2
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

Commit-ID:  c1d4e4192aa4e7408a81c32a77e7c867a07f8aa2
Gitweb:     https://git.kernel.org/tip/c1d4e4192aa4e7408a81c32a77e7c867a07f8aa2
Author:     Borislav Petkov <bp@suse.de>
AuthorDate: Mon, 10 Dec 2018 12:30:30 +0100
Committer:  Borislav Petkov <bp@suse.de>
CommitDate: Wed, 16 Jan 2019 12:41:57 +0100

x86/alternatives: Print containing function

... in the "debug-alternative" output so that one can find her way
easier when staring at the vmlinux disassembly.

For example:

  apply_alternatives: feat: 3*32+18, old: (read_tsc+0x0/0x10 (ffffffff8101d1c0) len: 5), repl: (ffffffff824e6d33, len: 5)
  					   ^^^^^^^^^^^^^^^^^
  ffffffff8101d1c0: old_insn: 0f 31 90 90 90
  ffffffff824e6d33: rpl_insn: 0f ae e8 0f 31
  ffffffff8101d1c0: final_insn: 0f ae e8 0f 31

No functional changes.

Signed-off-by: Borislav Petkov <bp@suse.de>
Cc: Andy Lutomirski <luto@amacapital.net>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: Josh Poimboeuf <jpoimboe@redhat.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Tom Lendacky <thomas.lendacky@amd.com>
Cc: X86 ML <x86@kernel.org>
Link: https://lkml.kernel.org/r/20181211222326.14581-3-bp@alien8.de
---
 arch/x86/kernel/alternative.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kernel/alternative.c b/arch/x86/kernel/alternative.c
index ebeac487a20c..d458c7973c56 100644
--- a/arch/x86/kernel/alternative.c
+++ b/arch/x86/kernel/alternative.c
@@ -393,10 +393,10 @@ void __init_or_module noinline apply_alternatives(struct alt_instr *start,
 			continue;
 		}
 
-		DPRINTK("feat: %d*32+%d, old: (%px len: %d), repl: (%px, len: %d), pad: %d",
+		DPRINTK("feat: %d*32+%d, old: (%pS (%px) len: %d), repl: (%px, len: %d), pad: %d",
 			a->cpuid >> 5,
 			a->cpuid & 0x1f,
-			instr, a->instrlen,
+			instr, instr, a->instrlen,
 			replacement, a->replacementlen, a->padlen);
 
 		DUMP_BYTES(instr, a->instrlen, "%px: old_insn: ", instr);
