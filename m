Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752721AbeB1OWc (ORCPT <rfc822;w@1wt.eu>);
        Wed, 28 Feb 2018 09:22:32 -0500
Received: from terminus.zytor.com ([198.137.202.136]:57669 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752465AbeB1OW3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Feb 2018 09:22:29 -0500
Date: Wed, 28 Feb 2018 06:21:48 -0800
From: tip-bot for Kees Cook <tipbot@zytor.com>
Message-ID: <tip-cb097be7036aa325adba33d8c41fe77b980b0e77@git.kernel.org>
Cc: linux-kernel@vger.kernel.org, hpa@zytor.com, peterz@infradead.org,
        keescook@chromium.org, mingo@kernel.org, tglx@linutronix.de
Reply-To: mingo@kernel.org, keescook@chromium.org, peterz@infradead.org,
        tglx@linutronix.de, linux-kernel@vger.kernel.org, hpa@zytor.com
In-Reply-To: <20180225165056.GA11719@beast>
References: <20180225165056.GA11719@beast>
To: linux-tip-commits@vger.kernel.org
Subject: [tip:x86/urgent] x86/refcounts: Switch to UD2 for exceptions
Git-Commit-ID: cb097be7036aa325adba33d8c41fe77b980b0e77
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

Commit-ID:  cb097be7036aa325adba33d8c41fe77b980b0e77
Gitweb:     https://git.kernel.org/tip/cb097be7036aa325adba33d8c41fe77b980b0e77
Author:     Kees Cook <keescook@chromium.org>
AuthorDate: Sun, 25 Feb 2018 08:50:56 -0800
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Wed, 28 Feb 2018 15:18:40 +0100

x86/refcounts: Switch to UD2 for exceptions

As done in commit 3b3a371cc9bc ("x86/debug: Use UD2 for WARN()"), this
switches to UD2 from UD0 to keep disassembly readable.

Signed-off-by: Kees Cook <keescook@chromium.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: https://lkml.kernel.org/r/20180225165056.GA11719@beast

---
 arch/x86/include/asm/refcount.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/include/asm/refcount.h b/arch/x86/include/asm/refcount.h
index d65171120e90..4cf11d88d3b3 100644
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
