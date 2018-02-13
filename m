Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934500AbeBMPhw (ORCPT <rfc822;w@1wt.eu>);
        Tue, 13 Feb 2018 10:37:52 -0500
Received: from terminus.zytor.com ([198.137.202.136]:40355 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934412AbeBMPhs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Feb 2018 10:37:48 -0500
Date: Tue, 13 Feb 2018 07:26:23 -0800
From: tip-bot for Peter Zijlstra <tipbot@zytor.com>
Message-ID: <tip-30d97b098534d1d35b198531870356a29cc066c2@git.kernel.org>
Cc: tglx@linutronix.de, linux-kernel@vger.kernel.org,
        joe.konno@linux.intel.com, mingo@kernel.org, peterz@infradead.org,
        hpa@zytor.com, torvalds@linux-foundation.org
Reply-To: torvalds@linux-foundation.org, tglx@linutronix.de, mingo@kernel.org,
        joe.konno@linux.intel.com, linux-kernel@vger.kernel.org, hpa@zytor.com,
        peterz@infradead.org
In-Reply-To: <20180213132819.GJ25201@hirez.programming.kicks-ass.net>
References: <20180213132819.GJ25201@hirez.programming.kicks-ass.net>
To: linux-tip-commits@vger.kernel.org
Subject: [tip:x86/pti] x86/speculation: Add <asm/msr-index.h> dependency
Git-Commit-ID: 30d97b098534d1d35b198531870356a29cc066c2
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

Commit-ID:  30d97b098534d1d35b198531870356a29cc066c2
Gitweb:     https://git.kernel.org/tip/30d97b098534d1d35b198531870356a29cc066c2
Author:     Peter Zijlstra <peterz@infradead.org>
AuthorDate: Tue, 13 Feb 2018 14:28:19 +0100
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Tue, 13 Feb 2018 14:39:34 +0100

x86/speculation: Add <asm/msr-index.h> dependency

Joe Konno reported a compile failure resulting from using an MSR
without inclusion of <asm/msr-index.h>, and while the current code builds
fine (by accident) this needs fixing for future patches.

Reported-by: Joe Konno <joe.konno@linux.intel.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: arjan@linux.intel.com
Cc: bp@alien8.de
Cc: dan.j.williams@intel.com
Cc: dave.hansen@linux.intel.com
Cc: dwmw2@infradead.org
Cc: dwmw@amazon.co.uk
Cc: gregkh@linuxfoundation.org
Cc: hpa@zytor.com
Cc: jpoimboe@redhat.com
Cc: linux-tip-commits@vger.kernel.org
Cc: luto@kernel.org
Fixes: 20ffa1caecca ("x86/speculation: Add basic IBPB (Indirect Branch Prediction Barrier) support")
Link: http://lkml.kernel.org/r/20180213132819.GJ25201@hirez.programming.kicks-ass.net
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 arch/x86/include/asm/nospec-branch.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/x86/include/asm/nospec-branch.h b/arch/x86/include/asm/nospec-branch.h
index 300cc15..76b0585 100644
--- a/arch/x86/include/asm/nospec-branch.h
+++ b/arch/x86/include/asm/nospec-branch.h
@@ -6,6 +6,7 @@
 #include <asm/alternative.h>
 #include <asm/alternative-asm.h>
 #include <asm/cpufeatures.h>
+#include <asm/msr-index.h>
 
 #ifdef __ASSEMBLY__
 
