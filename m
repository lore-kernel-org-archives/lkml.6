Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1032427AbeBOAi5 (ORCPT <rfc822;w@1wt.eu>);
        Wed, 14 Feb 2018 19:38:57 -0500
Received: from terminus.zytor.com ([198.137.202.136]:37875 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1032245AbeBOAis (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Feb 2018 19:38:48 -0500
Date: Wed, 14 Feb 2018 16:28:27 -0800
From: tip-bot for Peter Zijlstra <tipbot@zytor.com>
Message-ID: <tip-ea00f301285ea2f07393678cd2b6057878320c9d@git.kernel.org>
Cc: torvalds@linux-foundation.org, linux-kernel@vger.kernel.org,
        tglx@linutronix.de, hpa@zytor.com, peterz@infradead.org,
        mingo@kernel.org, joe.konno@linux.intel.com
Reply-To: mingo@kernel.org, hpa@zytor.com, peterz@infradead.org,
        tglx@linutronix.de, joe.konno@linux.intel.com,
        torvalds@linux-foundation.org, linux-kernel@vger.kernel.org
In-Reply-To: <20180213132819.GJ25201@hirez.programming.kicks-ass.net>
References: <20180213132819.GJ25201@hirez.programming.kicks-ass.net>
To: linux-tip-commits@vger.kernel.org
Subject: [tip:x86/pti] x86/speculation: Add <asm/msr-index.h> dependency
Git-Commit-ID: ea00f301285ea2f07393678cd2b6057878320c9d
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

Commit-ID:  ea00f301285ea2f07393678cd2b6057878320c9d
Gitweb:     https://git.kernel.org/tip/ea00f301285ea2f07393678cd2b6057878320c9d
Author:     Peter Zijlstra <peterz@infradead.org>
AuthorDate: Tue, 13 Feb 2018 14:28:19 +0100
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Thu, 15 Feb 2018 01:15:51 +0100

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
 
