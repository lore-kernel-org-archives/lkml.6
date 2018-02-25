Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751839AbeBYQvB (ORCPT <rfc822;w@1wt.eu>);
        Sun, 25 Feb 2018 11:51:01 -0500
Received: from mail-pl0-f68.google.com ([209.85.160.68]:38650 "EHLO
        mail-pl0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751699AbeBYQu7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Feb 2018 11:50:59 -0500
X-Google-Smtp-Source: AH8x227R7ITvXLAqCfzMj5V7QxZtog9QibfDo6zti0xqdvNCd5XaPeTG0RFUFvlEbCxSi7pSvc1ICQ==
Date: Sun, 25 Feb 2018 08:50:56 -0800
From: Kees Cook <keescook@chromium.org>
To: Ingo Molnar <mingo@kernel.org>
Cc: Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>, linux-kernel@vger.kernel.org
Subject: [PATCH] locking/refcounts: Switch to UD2 for exceptions
Message-ID: <20180225165056.GA11719@beast>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As done in commit 3b3a371cc9bc ("x86/debug: Use UD2 for WARN()"), this
switches to UD2 from UD0 to keep disassembly readable.

Signed-off-by: Kees Cook <keescook@chromium.org>
---
 arch/x86/include/asm/refcount.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/include/asm/refcount.h b/arch/x86/include/asm/refcount.h
index 4e44250e7d0d..ebe0ae2548b6 100644
--- a/arch/x86/include/asm/refcount.h
+++ b/arch/x86/include/asm/refcount.h
@@ -17,7 +17,7 @@
 #define _REFCOUNT_EXCEPTION				\
 	".pushsection .text..refcount\n"		\
 	"111:\tlea %[counter], %%" _ASM_CX "\n"		\
-	"112:\t" ASM_UD0 "\n"				\
+	"112:\t" ASM_UD2 "\n"				\
 	ASM_UNREACHABLE					\
 	".popsection\n"					\
 	"113:\n"					\
-- 
2.7.4


-- 
Kees Cook
Pixel Security
