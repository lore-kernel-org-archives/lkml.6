Return-Path: <SRS0=rk9P=OH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.7 required=3.0 tests=FREEMAIL_REPLYTO_END_DIGIT,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA34AC43441
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 14:20:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AAC9420832
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 14:20:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AAC9420832
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728619AbeK2BWq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Nov 2018 20:22:46 -0500
Received: from terminus.zytor.com ([198.137.202.136]:43099 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728342AbeK2BWq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Nov 2018 20:22:46 -0500
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id wASEKFt72320587
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Wed, 28 Nov 2018 06:20:15 -0800
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id wASEKE1Q2320584;
        Wed, 28 Nov 2018 06:20:14 -0800
Date:   Wed, 28 Nov 2018 06:20:14 -0800
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Tim Chen <tipbot@zytor.com>
Message-ID: <tip-8eb729b77faf83ac4c1f363a9ad68d042415f24c@git.kernel.org>
Cc:     ak@linux.intel.com, tim.c.chen@linux.intel.com,
        dave.hansen@intel.com, gregkh@linuxfoundation.org,
        keescook@chromium.org, longman9394@gmail.com, peterz@infradead.org,
        aarcange@redhat.com, jkosina@suse.cz, arjan@linux.intel.com,
        david.c.stewart@intel.com, casey.schaufler@intel.com,
        torvalds@linux-foundation.org, hpa@zytor.com, jpoimboe@redhat.com,
        linux-kernel@vger.kernel.org, jcm@redhat.com, dwmw@amazon.co.uk,
        tglx@linutronix.de, mingo@kernel.org, asit.k.mallick@intel.com,
        luto@kernel.org, thomas.lendacky@amd.com
Reply-To: longman9394@gmail.com, keescook@chromium.org,
          dave.hansen@intel.com, gregkh@linuxfoundation.org,
          tim.c.chen@linux.intel.com, ak@linux.intel.com,
          thomas.lendacky@amd.com, luto@kernel.org,
          asit.k.mallick@intel.com, mingo@kernel.org, tglx@linutronix.de,
          dwmw@amazon.co.uk, jcm@redhat.com, linux-kernel@vger.kernel.org,
          jpoimboe@redhat.com, hpa@zytor.com,
          torvalds@linux-foundation.org, casey.schaufler@intel.com,
          david.c.stewart@intel.com, arjan@linux.intel.com,
          jkosina@suse.cz, aarcange@redhat.com, peterz@infradead.org
In-Reply-To: <20181125185003.593893901@linutronix.de>
References: <20181125185003.593893901@linutronix.de>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/pti] x86/speculation: Update the TIF_SSBD comment
Git-Commit-ID: 8eb729b77faf83ac4c1f363a9ad68d042415f24c
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

Commit-ID:  8eb729b77faf83ac4c1f363a9ad68d042415f24c
Gitweb:     https://git.kernel.org/tip/8eb729b77faf83ac4c1f363a9ad68d042415f24c
Author:     Tim Chen <tim.c.chen@linux.intel.com>
AuthorDate: Sun, 25 Nov 2018 19:33:29 +0100
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Wed, 28 Nov 2018 11:57:04 +0100

x86/speculation: Update the TIF_SSBD comment

"Reduced Data Speculation" is an obsolete term. The correct new name is
"Speculative store bypass disable" - which is abbreviated into SSBD.

Signed-off-by: Tim Chen <tim.c.chen@linux.intel.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Ingo Molnar <mingo@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Jiri Kosina <jkosina@suse.cz>
Cc: Tom Lendacky <thomas.lendacky@amd.com>
Cc: Josh Poimboeuf <jpoimboe@redhat.com>
Cc: Andrea Arcangeli <aarcange@redhat.com>
Cc: David Woodhouse <dwmw@amazon.co.uk>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Dave Hansen <dave.hansen@intel.com>
Cc: Casey Schaufler <casey.schaufler@intel.com>
Cc: Asit Mallick <asit.k.mallick@intel.com>
Cc: Arjan van de Ven <arjan@linux.intel.com>
Cc: Jon Masters <jcm@redhat.com>
Cc: Waiman Long <longman9394@gmail.com>
Cc: Greg KH <gregkh@linuxfoundation.org>
Cc: Dave Stewart <david.c.stewart@intel.com>
Cc: Kees Cook <keescook@chromium.org>
Cc: stable@vger.kernel.org
Link: https://lkml.kernel.org/r/20181125185003.593893901@linutronix.de


---
 arch/x86/include/asm/thread_info.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/include/asm/thread_info.h b/arch/x86/include/asm/thread_info.h
index 2ff2a30a264f..523c69efc38a 100644
--- a/arch/x86/include/asm/thread_info.h
+++ b/arch/x86/include/asm/thread_info.h
@@ -79,7 +79,7 @@ struct thread_info {
 #define TIF_SIGPENDING		2	/* signal pending */
 #define TIF_NEED_RESCHED	3	/* rescheduling necessary */
 #define TIF_SINGLESTEP		4	/* reenable singlestep on user return*/
-#define TIF_SSBD			5	/* Reduced data speculation */
+#define TIF_SSBD		5	/* Speculative store bypass disable */
 #define TIF_SYSCALL_EMU		6	/* syscall emulation active */
 #define TIF_SYSCALL_AUDIT	7	/* syscall auditing active */
 #define TIF_SECCOMP		8	/* secure computing */
