Return-Path: <SRS0=Yw3T=OB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E94FBC43441
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 10:12:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B59A120866
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 10:12:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B59A120866
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393950AbeKVUut (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Nov 2018 15:50:49 -0500
Received: from terminus.zytor.com ([198.137.202.136]:50987 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387936AbeKVUut (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Nov 2018 15:50:49 -0500
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id wAMABdiE3743814
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Thu, 22 Nov 2018 02:11:39 -0800
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id wAMABdrN3743811;
        Thu, 22 Nov 2018 02:11:39 -0800
Date:   Thu, 22 Nov 2018 02:11:39 -0800
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Andy Lutomirski <tipbot@zytor.com>
Message-ID: <tip-af2ebdcf044039e89da3cd44c0f04dea317020c5@git.kernel.org>
Cc:     torvalds@linux-foundation.org, tglx@linutronix.de, luto@kernel.org,
        riel@surriel.com, mingo@kernel.org, bp@alien8.de,
        peterz@infradead.org, dave.hansen@linux.intel.com, hpa@zytor.com,
        linux-kernel@vger.kernel.org, yu-cheng.yu@intel.com
Reply-To: yu-cheng.yu@intel.com, torvalds@linux-foundation.org,
          tglx@linutronix.de, luto@kernel.org, riel@surriel.com,
          bp@alien8.de, mingo@kernel.org, peterz@infradead.org,
          dave.hansen@linux.intel.com, hpa@zytor.com,
          linux-kernel@vger.kernel.org
In-Reply-To: <e023f20352b0d05a8b0205629897917262d2ad68.1542841400.git.luto@kernel.org>
References: <e023f20352b0d05a8b0205629897917262d2ad68.1542841400.git.luto@kernel.org>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/mm] x86/vsyscall/64: Use X86_PF constants in the simulated
 #PF error code
Git-Commit-ID: af2ebdcf044039e89da3cd44c0f04dea317020c5
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

Commit-ID:  af2ebdcf044039e89da3cd44c0f04dea317020c5
Gitweb:     https://git.kernel.org/tip/af2ebdcf044039e89da3cd44c0f04dea317020c5
Author:     Andy Lutomirski <luto@kernel.org>
AuthorDate: Wed, 21 Nov 2018 15:11:26 -0800
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Thu, 22 Nov 2018 09:24:27 +0100

x86/vsyscall/64: Use X86_PF constants in the simulated #PF error code

Rather than hardcoding 6 with a comment, use the defined constants.

Signed-off-by: Andy Lutomirski <luto@kernel.org>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: H. Peter Anvin <hpa@zytor.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Rik van Riel <riel@surriel.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Yu-cheng Yu <yu-cheng.yu@intel.com>
Link: http://lkml.kernel.org/r/e023f20352b0d05a8b0205629897917262d2ad68.1542841400.git.luto@kernel.org
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 arch/x86/entry/vsyscall/vsyscall_64.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/entry/vsyscall/vsyscall_64.c b/arch/x86/entry/vsyscall/vsyscall_64.c
index 85fd85d52ffd..d78bcc03e60e 100644
--- a/arch/x86/entry/vsyscall/vsyscall_64.c
+++ b/arch/x86/entry/vsyscall/vsyscall_64.c
@@ -102,7 +102,7 @@ static bool write_ok_or_segv(unsigned long ptr, size_t size)
 	if (!access_ok(VERIFY_WRITE, (void __user *)ptr, size)) {
 		struct thread_struct *thread = &current->thread;
 
-		thread->error_code	= 6;  /* user fault, no page, write */
+		thread->error_code	= X86_PF_USER | X86_PF_WRITE;
 		thread->cr2		= ptr;
 		thread->trap_nr		= X86_TRAP_PF;
 
