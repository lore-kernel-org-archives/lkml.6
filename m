Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753079AbeCNIrQ (ORCPT <rfc822;w@1wt.eu>);
        Wed, 14 Mar 2018 04:47:16 -0400
Received: from terminus.zytor.com ([198.137.202.136]:34957 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751459AbeCNIrO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Mar 2018 04:47:14 -0400
Date: Wed, 14 Mar 2018 01:46:16 -0700
From: tip-bot for Andy Lutomirski <tipbot@zytor.com>
Message-ID: <tip-327d53d005ca47b10eae940616ed11c569f75a9b@git.kernel.org>
Cc: peterz@infradead.org, jpoimboe@redhat.com, brgerst@gmail.com,
        hpa@zytor.com, stsp@list.ru, torvalds@linux-foundation.org,
        dvlasenk@redhat.com, tglx@linutronix.de, mingo@kernel.org,
        luto@kernel.org, linux-kernel@vger.kernel.org, bp@alien8.de
Reply-To: mingo@kernel.org, tglx@linutronix.de, torvalds@linux-foundation.org,
        dvlasenk@redhat.com, linux-kernel@vger.kernel.org, bp@alien8.de,
        luto@kernel.org, peterz@infradead.org, jpoimboe@redhat.com,
        stsp@list.ru, hpa@zytor.com, brgerst@gmail.com
In-Reply-To: <b1cc37144038958a469c8f70a5f47a6a5638636a.1521003603.git.luto@kernel.org>
References: <b1cc37144038958a469c8f70a5f47a6a5638636a.1521003603.git.luto@kernel.org>
To: linux-tip-commits@vger.kernel.org
Subject: [tip:x86/pti] selftests/x86/entry_from_vm86: Exit with 1 if we fail
Git-Commit-ID: 327d53d005ca47b10eae940616ed11c569f75a9b
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

Commit-ID:  327d53d005ca47b10eae940616ed11c569f75a9b
Gitweb:     https://git.kernel.org/tip/327d53d005ca47b10eae940616ed11c569f75a9b
Author:     Andy Lutomirski <luto@kernel.org>
AuthorDate: Tue, 13 Mar 2018 22:03:10 -0700
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Wed, 14 Mar 2018 09:21:01 +0100

selftests/x86/entry_from_vm86: Exit with 1 if we fail

Fix a logic error that caused the test to exit with 0 even if test
cases failed.

Signed-off-by: Andy Lutomirski <luto@kernel.org>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Brian Gerst <brgerst@gmail.com>
Cc: Denys Vlasenko <dvlasenk@redhat.com>
Cc: H. Peter Anvin <hpa@zytor.com>
Cc: Josh Poimboeuf <jpoimboe@redhat.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Stas Sergeev <stsp@list.ru>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: bartoldeman@gmail.com
Cc: stable@vger.kernel.org
Link: http://lkml.kernel.org/r/b1cc37144038958a469c8f70a5f47a6a5638636a.1521003603.git.luto@kernel.org
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 tools/testing/selftests/x86/entry_from_vm86.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/x86/entry_from_vm86.c b/tools/testing/selftests/x86/entry_from_vm86.c
index 361466a2eaef..6e85f0d0498d 100644
--- a/tools/testing/selftests/x86/entry_from_vm86.c
+++ b/tools/testing/selftests/x86/entry_from_vm86.c
@@ -318,7 +318,7 @@ int main(void)
 	clearhandler(SIGSEGV);
 
 	/* Make sure nothing explodes if we fork. */
-	if (fork() > 0)
+	if (fork() == 0)
 		return 0;
 
 	return (nerrs == 0 ? 0 : 1);
