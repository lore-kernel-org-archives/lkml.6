Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751554AbeBTK2H (ORCPT <rfc822;w@1wt.eu>);
        Tue, 20 Feb 2018 05:28:07 -0500
Received: from terminus.zytor.com ([198.137.202.136]:58295 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751324AbeBTK2F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Feb 2018 05:28:05 -0500
Date: Tue, 20 Feb 2018 02:27:37 -0800
From: tip-bot for Jan Beulich <tipbot@zytor.com>
Message-ID: <tip-f2f18b16c779978ece4a04f304a92ff9ac8fbce5@git.kernel.org>
Cc: brgerst@gmail.com, torvalds@linux-foundation.org, dvlasenk@redhat.com,
        JBeulich@suse.com, tglx@linutronix.de, peterz@infradead.org,
        mingo@kernel.org, jpoimboe@redhat.com, linux-kernel@vger.kernel.org,
        jbeulich@suse.com, bp@alien8.de, luto@kernel.org, hpa@zytor.com
Reply-To: linux-kernel@vger.kernel.org, bp@alien8.de, jbeulich@suse.com,
        luto@kernel.org, hpa@zytor.com, brgerst@gmail.com,
        peterz@infradead.org, tglx@linutronix.de, jpoimboe@redhat.com,
        mingo@kernel.org, JBeulich@suse.com, torvalds@linux-foundation.org,
        dvlasenk@redhat.com
In-Reply-To: <5A8AF2AA02000078001A91E9@prv-mh.provo.novell.com>
References: <5A8AF2AA02000078001A91E9@prv-mh.provo.novell.com>
To: linux-tip-commits@vger.kernel.org
Subject: [tip:x86/pti] x86/LDT: Avoid warning in 32-bit builds with older
 gcc
Git-Commit-ID: f2f18b16c779978ece4a04f304a92ff9ac8fbce5
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

Commit-ID:  f2f18b16c779978ece4a04f304a92ff9ac8fbce5
Gitweb:     https://git.kernel.org/tip/f2f18b16c779978ece4a04f304a92ff9ac8fbce5
Author:     Jan Beulich <JBeulich@suse.com>
AuthorDate: Mon, 19 Feb 2018 07:52:10 -0700
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Tue, 20 Feb 2018 09:33:40 +0100

x86/LDT: Avoid warning in 32-bit builds with older gcc

BUG() doesn't always imply "no return", and hence should be followed by
a return statement even if that's obviously (to a human) unreachable.

Signed-off-by: Jan Beulich <jbeulich@suse.com>
Acked-by: Thomas Gleixner <tglx@linutronix.de>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Brian Gerst <brgerst@gmail.com>
Cc: Denys Vlasenko <dvlasenk@redhat.com>
Cc: H. Peter Anvin <hpa@zytor.com>
Cc: Josh Poimboeuf <jpoimboe@redhat.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lkml.kernel.org/r/5A8AF2AA02000078001A91E9@prv-mh.provo.novell.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 arch/x86/include/asm/mmu_context.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/x86/include/asm/mmu_context.h b/arch/x86/include/asm/mmu_context.h
index c931b88..1de72ce 100644
--- a/arch/x86/include/asm/mmu_context.h
+++ b/arch/x86/include/asm/mmu_context.h
@@ -74,6 +74,7 @@ static inline void *ldt_slot_va(int slot)
 	return (void *)(LDT_BASE_ADDR + LDT_SLOT_STRIDE * slot);
 #else
 	BUG();
+	return (void *)fix_to_virt(FIX_HOLE);
 #endif
 }
 
