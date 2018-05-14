Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753685AbeENMyH (ORCPT <rfc822;w@1wt.eu>);
        Mon, 14 May 2018 08:54:07 -0400
Received: from terminus.zytor.com ([198.137.202.136]:38525 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753628AbeENMyE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 May 2018 08:54:04 -0400
Date: Mon, 14 May 2018 05:53:19 -0700
From: tip-bot for Alexey Dobriyan <tipbot@zytor.com>
Message-ID: <tip-51bad67ffbce0aaa44579f84ef5d05597054ec6a@git.kernel.org>
Cc: mingo@kernel.org, tglx@linutronix.de, luto@kernel.org,
        peterz@infradead.org, jpoimboe@redhat.com, adobriyan@gmail.com,
        torvalds@linux-foundation.org, dvlasenk@redhat.com,
        linux-kernel@vger.kernel.org, h.peter.anvin@intel.com, bp@alien8.de,
        brgerst@gmail.com, hpa@zytor.com
Reply-To: torvalds@linux-foundation.org, tglx@linutronix.de, mingo@kernel.org,
        jpoimboe@redhat.com, adobriyan@gmail.com, luto@kernel.org,
        peterz@infradead.org, brgerst@gmail.com, hpa@zytor.com,
        linux-kernel@vger.kernel.org, dvlasenk@redhat.com,
        h.peter.anvin@intel.com, bp@alien8.de
In-Reply-To: <20180507213755.GA32406@avx2>
References: <20180507213755.GA32406@avx2>
To: linux-tip-commits@vger.kernel.org
Subject: [tip:x86/pti] x86/asm: Pad assembly functions with INT3
 instructions
Git-Commit-ID: 51bad67ffbce0aaa44579f84ef5d05597054ec6a
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

Commit-ID:  51bad67ffbce0aaa44579f84ef5d05597054ec6a
Gitweb:     https://git.kernel.org/tip/51bad67ffbce0aaa44579f84ef5d05597054ec6a
Author:     Alexey Dobriyan <adobriyan@gmail.com>
AuthorDate: Tue, 8 May 2018 00:37:55 +0300
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Mon, 14 May 2018 11:43:03 +0200

x86/asm: Pad assembly functions with INT3 instructions

Use INT3 instead of NOP. All that padding between functions is
an illegal area, no legitimate code should jump into it.

I've checked x86_64 allyesconfig disassembly, all changes looks sane:
INT3 is only used after RET or unconditional JMP.

Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>
Acked-by: H. Peter Anvin <h.peter.anvin@intel.com>
Acked-by: Thomas Gleixner <tglx@linutronix.de>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Brian Gerst <brgerst@gmail.com>
Cc: Denys Vlasenko <dvlasenk@redhat.com>
Cc: Josh Poimboeuf <jpoimboe@redhat.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lkml.kernel.org/r/20180507213755.GA32406@avx2
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 arch/x86/include/asm/linkage.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/include/asm/linkage.h b/arch/x86/include/asm/linkage.h
index 14caa9d9fb7f..c0b70bc1e659 100644
--- a/arch/x86/include/asm/linkage.h
+++ b/arch/x86/include/asm/linkage.h
@@ -18,7 +18,7 @@
 	name:
 
 #if defined(CONFIG_X86_64) || defined(CONFIG_X86_ALIGNMENT_16)
-#define __ALIGN		.p2align 4, 0x90
+#define __ALIGN		.p2align 4, 0xCC
 #define __ALIGN_STR	__stringify(__ALIGN)
 #endif
 
