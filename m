Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751462AbeCII7c (ORCPT <rfc822;w@1wt.eu>);
        Fri, 9 Mar 2018 03:59:32 -0500
Received: from terminus.zytor.com ([198.137.202.136]:52521 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751282AbeCII7a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Mar 2018 03:59:30 -0500
Date: Fri, 9 Mar 2018 00:59:10 -0800
From: tip-bot for Norbert Manthey <tipbot@zytor.com>
Message-ID: <tip-13a453c241b78934a945b1af572d0533612c9bd1@git.kernel.org>
Cc: peterz@infradead.org, torvalds@linux-foundation.org, mingo@kernel.org,
        tglx@linutronix.de, hpa@zytor.com, linux-kernel@vger.kernel.org,
        tautschn@amazon.co.uk, nmanthey@amazon.de
Reply-To: mingo@kernel.org, torvalds@linux-foundation.org,
        peterz@infradead.org, tglx@linutronix.de, hpa@zytor.com,
        nmanthey@amazon.de, tautschn@amazon.co.uk,
        linux-kernel@vger.kernel.org
In-Reply-To: <1519717660-16157-1-git-send-email-nmanthey@amazon.de>
References: <1519717660-16157-1-git-send-email-nmanthey@amazon.de>
To: linux-tip-commits@vger.kernel.org
Subject: [tip:sched/core] sched/fair: Add ';' after label attributes
Git-Commit-ID: 13a453c241b78934a945b1af572d0533612c9bd1
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

Commit-ID:  13a453c241b78934a945b1af572d0533612c9bd1
Gitweb:     https://git.kernel.org/tip/13a453c241b78934a945b1af572d0533612c9bd1
Author:     Norbert Manthey <nmanthey@amazon.de>
AuthorDate: Tue, 27 Feb 2018 08:47:40 +0100
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Fri, 9 Mar 2018 07:59:13 +0100

sched/fair: Add ';' after label attributes

Due to using GCC defines for configuration, some labels might be unused in
certain configurations. While adding a __maybe_unused to the label is
fine in general, the line has to be terminated with ';'. This is also
reflected in the GCC documentation, but GCC parsed the previous variant
without an error message.

This has been spotted while compiling with goto-cc, the compiler for the
CPROVER tool suite.

Signed-off-by: Norbert Manthey <nmanthey@amazon.de>
Signed-off-by: Michael Tautschnig <tautschn@amazon.co.uk>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Link: http://lkml.kernel.org/r/1519717660-16157-1-git-send-email-nmanthey@amazon.de
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 kernel/sched/fair.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index f5591071ae98..097db34d5ba2 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -6797,7 +6797,7 @@ simple:
 
 	p = task_of(se);
 
-done: __maybe_unused
+done: __maybe_unused;
 #ifdef CONFIG_SMP
 	/*
 	 * Move the next running task to the front of
