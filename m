Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752008AbeCYW2h (ORCPT <rfc822;w@1wt.eu>);
        Sun, 25 Mar 2018 18:28:37 -0400
Received: from terminus.zytor.com ([198.137.202.136]:49129 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750839AbeCYW2d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Mar 2018 18:28:33 -0400
Date: Sun, 25 Mar 2018 15:27:36 -0700
From: tip-bot for Sven Wegener <tipbot@zytor.com>
Message-ID: <tip-e847f6aaf68f6156a5e9b26afe1a7316b9ab697e@git.kernel.org>
Cc: sven.wegener@stealer.net, torvalds@linux-foundation.org,
        linux-kernel@vger.kernel.org, keescook@chromium.org, mka@chromium.org,
        mingo@kernel.org, tglx@linutronix.de, vgoyal@redhat.com,
        peterz@infradead.org, sam@ravnborg.org, hpa@zytor.com
Reply-To: hpa@zytor.com, peterz@infradead.org, sam@ravnborg.org,
        vgoyal@redhat.com, tglx@linutronix.de, keescook@chromium.org,
        mingo@kernel.org, mka@chromium.org, linux-kernel@vger.kernel.org,
        torvalds@linux-foundation.org, sven.wegener@stealer.net
In-Reply-To: <alpine.LNX.2.21.1803242219380.30139@titan.int.lan.stealer.net>
References: <alpine.LNX.2.21.1803242219380.30139@titan.int.lan.stealer.net>
To: linux-tip-commits@vger.kernel.org
Subject: [tip:x86/urgent] x86/purgatory: Avoid creating stray .<pid>.d
 files, remove -MD from KBUILD_CFLAGS
Git-Commit-ID: e847f6aaf68f6156a5e9b26afe1a7316b9ab697e
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

Commit-ID:  e847f6aaf68f6156a5e9b26afe1a7316b9ab697e
Gitweb:     https://git.kernel.org/tip/e847f6aaf68f6156a5e9b26afe1a7316b9ab697e
Author:     Sven Wegener <sven.wegener@stealer.net>
AuthorDate: Sat, 24 Mar 2018 22:21:13 +0100
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Sun, 25 Mar 2018 11:04:02 +0200

x86/purgatory: Avoid creating stray .<pid>.d files, remove -MD from KBUILD_CFLAGS

The kernel build system already takes care of generating the dependency
files. Having the additional -MD in KBUILD_CFLAGS leads to stray
.<pid>.d files in the build directory when we call the cc-option macro.

Signed-off-by: Sven Wegener <sven.wegener@stealer.net>
Cc: H. Peter Anvin <hpa@zytor.com>
Cc: Kees Cook <keescook@chromium.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Matthias Kaehlcke <mka@chromium.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Sam Ravnborg <sam@ravnborg.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Vivek Goyal <vgoyal@redhat.com>
Link: http://lkml.kernel.org/r/alpine.LNX.2.21.1803242219380.30139@titan.int.lan.stealer.net
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 arch/x86/purgatory/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/purgatory/Makefile b/arch/x86/purgatory/Makefile
index 2f15a2ac4209..d70c15de417b 100644
--- a/arch/x86/purgatory/Makefile
+++ b/arch/x86/purgatory/Makefile
@@ -16,7 +16,7 @@ KCOV_INSTRUMENT := n
 # in turn leaves some undefined symbols like __fentry__ in purgatory and not
 # sure how to relocate those. Like kexec-tools, use custom flags.
 
-KBUILD_CFLAGS := -fno-strict-aliasing -Wall -Wstrict-prototypes -fno-zero-initialized-in-bss -fno-builtin -ffreestanding -c -MD -Os -mcmodel=large
+KBUILD_CFLAGS := -fno-strict-aliasing -Wall -Wstrict-prototypes -fno-zero-initialized-in-bss -fno-builtin -ffreestanding -c -Os -mcmodel=large
 KBUILD_CFLAGS += -m$(BITS)
 KBUILD_CFLAGS += $(call cc-option,-fno-PIE)
 
