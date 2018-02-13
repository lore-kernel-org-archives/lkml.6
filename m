Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933916AbeBMJE4 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 13 Feb 2018 04:04:56 -0500
Received: from terminus.zytor.com ([198.137.202.136]:45625 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933638AbeBMJEv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Feb 2018 04:04:51 -0500
Date: Tue, 13 Feb 2018 01:04:03 -0800
From: tip-bot for Borislav Petkov <tipbot@zytor.com>
Message-ID: <tip-b498c261107461d5c42140dfddd05df83d8ca078@git.kernel.org>
Cc: bp@alien8.de, jpoimboe@redhat.com, bp@suse.de, tglx@linutronix.de,
        torvalds@linux-foundation.org, linux-kernel@vger.kernel.org,
        luto@kernel.org, dvlasenk@redhat.com, peterz@infradead.org,
        hpa@zytor.com, brgerst@gmail.com, mingo@kernel.org
Reply-To: peterz@infradead.org, dvlasenk@redhat.com, luto@kernel.org,
        mingo@kernel.org, brgerst@gmail.com, hpa@zytor.com, bp@suse.de,
        jpoimboe@redhat.com, bp@alien8.de, linux-kernel@vger.kernel.org,
        tglx@linutronix.de, torvalds@linux-foundation.org
In-Reply-To: <20180212201318.GD14640@pd.tnic>
References: <20180212201318.GD14640@pd.tnic>
To: linux-tip-commits@vger.kernel.org
Subject: [tip:x86/pti] x86/entry/64: Remove the unused 'icebp' macro
Git-Commit-ID: b498c261107461d5c42140dfddd05df83d8ca078
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  b498c261107461d5c42140dfddd05df83d8ca078
Gitweb:     https://git.kernel.org/tip/b498c261107461d5c42140dfddd05df83d8ca078
Author:     Borislav Petkov <bp@suse.de>
AuthorDate: Mon, 12 Feb 2018 21:13:18 +0100
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Tue, 13 Feb 2018 09:04:55 +0100

x86/entry/64: Remove the unused 'icebp' macro

That macro was touched around 2.5.8 times, judging by the full history
linux repo, but it was unused even then. Get rid of it already.

Signed-off-by: Borislav Petkov <bp@suse.de>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Brian Gerst <brgerst@gmail.com>
Cc: Denys Vlasenko <dvlasenk@redhat.com>
Cc: H. Peter Anvin <hpa@zytor.com>
Cc: Josh Poimboeuf <jpoimboe@redhat.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: linux@dominikbrodowski.net
Link: http://lkml.kernel.org/r/20180212201318.GD14640@pd.tnic
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 arch/x86/entry/calling.h | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/arch/x86/entry/calling.h b/arch/x86/entry/calling.h
index 6985440..dce7092 100644
--- a/arch/x86/entry/calling.h
+++ b/arch/x86/entry/calling.h
@@ -159,10 +159,6 @@ For 32-bit we have the following conventions - kernel is built with
 	.if \pop_rdi
 	popq %rdi
 	.endif
-	.endm
-
-	.macro icebp
-	.byte 0xf1
 .endm
 
 /*
