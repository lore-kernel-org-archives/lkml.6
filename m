Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752551AbeEOG3w (ORCPT <rfc822;w@1wt.eu>);
        Tue, 15 May 2018 02:29:52 -0400
Received: from terminus.zytor.com ([198.137.202.136]:36653 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752219AbeEOG3u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 May 2018 02:29:50 -0400
Date: Mon, 14 May 2018 23:29:14 -0700
From: "tip-bot for Paul E. McKenney" <tipbot@zytor.com>
Message-ID: <tip-35bb6ee6790600d29c598ebbf262359341f34e38@git.kernel.org>
Cc: tglx@linutronix.de, mingo@kernel.org, stern@rowland.harvard.edu,
        linux-kernel@vger.kernel.org, will.deacon@arm.com,
        akpm@linux-foundation.org, paulmck@linux.vnet.ibm.com,
        torvalds@linux-foundation.org, pbonzini@redhat.com, hpa@zytor.com,
        peterz@infradead.org
Reply-To: tglx@linutronix.de, akpm@linux-foundation.org,
        paulmck@linux.vnet.ibm.com, will.deacon@arm.com,
        stern@rowland.harvard.edu, linux-kernel@vger.kernel.org,
        mingo@kernel.org, torvalds@linux-foundation.org, pbonzini@redhat.com,
        peterz@infradead.org, hpa@zytor.com
In-Reply-To: <1526340837-12222-5-git-send-email-paulmck@linux.vnet.ibm.com>
References: <1526340837-12222-5-git-send-email-paulmck@linux.vnet.ibm.com>
To: linux-tip-commits@vger.kernel.org
Subject: [tip:locking/core] tools/memory-order: Improve key for SELF and SV
Git-Commit-ID: 35bb6ee6790600d29c598ebbf262359341f34e38
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

Commit-ID:  35bb6ee6790600d29c598ebbf262359341f34e38
Gitweb:     https://git.kernel.org/tip/35bb6ee6790600d29c598ebbf262359341f34e38
Author:     Paul E. McKenney <paulmck@linux.vnet.ibm.com>
AuthorDate: Mon, 14 May 2018 16:33:43 -0700
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Tue, 15 May 2018 08:11:16 +0200

tools/memory-order: Improve key for SELF and SV

The key for "SELF" was missing completely and the key for "SV" was
a bit obtuse.  This commit therefore adds a key for "SELF" and improves
the one for "SV".

Reported-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
Acked-by: Alan Stern <stern@rowland.harvard.edu>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Will Deacon <will.deacon@arm.com>
Cc: akiyks@gmail.com
Cc: boqun.feng@gmail.com
Cc: dhowells@redhat.com
Cc: j.alglave@ucl.ac.uk
Cc: linux-arch@vger.kernel.org
Cc: luc.maranget@inria.fr
Cc: npiggin@gmail.com
Cc: parri.andrea@gmail.com
Link: http://lkml.kernel.org/r/1526340837-12222-5-git-send-email-paulmck@linux.vnet.ibm.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 tools/memory-model/Documentation/cheatsheet.txt | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/tools/memory-model/Documentation/cheatsheet.txt b/tools/memory-model/Documentation/cheatsheet.txt
index c0eafdaddfa4..46fe79afc737 100644
--- a/tools/memory-model/Documentation/cheatsheet.txt
+++ b/tools/memory-model/Documentation/cheatsheet.txt
@@ -26,4 +26,5 @@ Key:	C:	Ordering is cumulative
 	DR:	Dependent read (address dependency)
 	DW:	Dependent write (address, data, or control dependency)
 	RMW:	Atomic read-modify-write operation
-	SV	Same-variable access
+	SELF:	Orders self, as opposed to accesses before and/or after
+	SV:	Orders later accesses to the same variable
