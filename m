Return-Path: <SRS0=Xm/m=NJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73E8FC0044C
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 11:35:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 45ED22084A
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 11:35:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 45ED22084A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729143AbeJ2UXx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Oct 2018 16:23:53 -0400
Received: from terminus.zytor.com ([198.137.202.136]:40685 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727684AbeJ2UXw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Oct 2018 16:23:52 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w9TBZBeB1519938
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Mon, 29 Oct 2018 04:35:11 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w9TBZBu31519935;
        Mon, 29 Oct 2018 04:35:11 -0700
Date:   Mon, 29 Oct 2018 04:35:11 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Rasmus Villemoes <tipbot@zytor.com>
Message-ID: <tip-2022cceb4e30f1bb4c84d40ffa705aa8d8d68adb@git.kernel.org>
Cc:     tglx@linutronix.de, hpa@zytor.com, linux-kernel@vger.kernel.org,
        linux@rasmusvillemoes.dk, bp@alien8.de, peterz@infradead.org,
        mingo@kernel.org, torvalds@linux-foundation.org
Reply-To: tglx@linutronix.de, peterz@infradead.org, bp@alien8.de,
          torvalds@linux-foundation.org, mingo@kernel.org,
          linux-kernel@vger.kernel.org, hpa@zytor.com,
          linux@rasmusvillemoes.dk
In-Reply-To: <20181026222004.14193-1-linux@rasmusvillemoes.dk>
References: <20181026222004.14193-1-linux@rasmusvillemoes.dk>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/urgent] x86/traps: Use format string with panic() call
Git-Commit-ID: 2022cceb4e30f1bb4c84d40ffa705aa8d8d68adb
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

Commit-ID:  2022cceb4e30f1bb4c84d40ffa705aa8d8d68adb
Gitweb:     https://git.kernel.org/tip/2022cceb4e30f1bb4c84d40ffa705aa8d8d68adb
Author:     Rasmus Villemoes <linux@rasmusvillemoes.dk>
AuthorDate: Sat, 27 Oct 2018 00:20:04 +0200
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Mon, 29 Oct 2018 07:19:26 +0100

x86/traps: Use format string with panic() call

Building with -Wformat-nonliteral gives:

  arch/x86/kernel/traps.c:334:2: warning: format not a string literal and no format arguments [-Wformat-nonliteral]
    panic(message);

handle_stack_overflow() can only be called from two places (kernel/traps.c
and via inline asm in mm/fault.c), in both cases with a string not
containing format specifiers, so we might as well silence this warning
using "%s" as a format string.

Signed-off-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Link: http://lkml.kernel.org/r/20181026222004.14193-1-linux@rasmusvillemoes.dk
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 arch/x86/kernel/traps.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/kernel/traps.c b/arch/x86/kernel/traps.c
index 8f6dcd88202e..9b7c4ca8f0a7 100644
--- a/arch/x86/kernel/traps.c
+++ b/arch/x86/kernel/traps.c
@@ -306,7 +306,7 @@ __visible void __noreturn handle_stack_overflow(const char *message,
 	die(message, regs, 0);
 
 	/* Be absolutely certain we don't return. */
-	panic(message);
+	panic("%s", message);
 }
 #endif
 
