Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S967848AbeE2WQw (ORCPT <rfc822;w@1wt.eu>);
        Tue, 29 May 2018 18:16:52 -0400
Received: from mail-pg0-f65.google.com ([74.125.83.65]:38956 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S967778AbeE2WQm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 May 2018 18:16:42 -0400
X-Google-Smtp-Source: ADUXVKL34RpEedao1HkBLjkEi/QXiAx7670a2kB8yU0+lQlqt9EEszzrl7zdiULNUxsA0u2f+FpN5g==
From: Thomas Garnier <thgarnie@google.com>
To: kernel-hardening@lists.openwall.com
Cc: Thomas Garnier <thgarnie@google.com>,
        Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v4 02/27] x86: Use symbol name on bug table for PIE support
Date: Tue, 29 May 2018 15:15:03 -0700
Message-Id: <20180529221625.33541-3-thgarnie@google.com>
X-Mailer: git-send-email 2.17.0.921.gf22659ad46-goog
In-Reply-To: <20180529221625.33541-1-thgarnie@google.com>
References: <20180529221625.33541-1-thgarnie@google.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Replace the %c constraint with %P. The %c is incompatible with PIE
because it implies an immediate value whereas %P reference a symbol.

Position Independent Executable (PIE) support will allow to extend the
KASLR randomization range 0xffffffff80000000.

Signed-off-by: Thomas Garnier <thgarnie@google.com>
---
 arch/x86/include/asm/bug.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/include/asm/bug.h b/arch/x86/include/asm/bug.h
index 6804d6642767..3d690a4abf50 100644
--- a/arch/x86/include/asm/bug.h
+++ b/arch/x86/include/asm/bug.h
@@ -35,7 +35,7 @@ do {									\
 	asm volatile("1:\t" ins "\n"					\
 		     ".pushsection __bug_table,\"aw\"\n"		\
 		     "2:\t" __BUG_REL(1b) "\t# bug_entry::bug_addr\n"	\
-		     "\t"  __BUG_REL(%c0) "\t# bug_entry::file\n"	\
+		     "\t"  __BUG_REL(%P0) "\t# bug_entry::file\n"	\
 		     "\t.word %c1"        "\t# bug_entry::line\n"	\
 		     "\t.word %c2"        "\t# bug_entry::flags\n"	\
 		     "\t.org 2b+%c3\n"					\
-- 
2.17.0.921.gf22659ad46-goog
