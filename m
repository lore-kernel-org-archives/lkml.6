Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753070AbeCXViD (ORCPT <rfc822;w@1wt.eu>);
        Sat, 24 Mar 2018 17:38:03 -0400
Received: from smtp1.stealer.net ([88.198.224.204]:52596 "EHLO
        smtp1.stealer.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752931AbeCXViC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Mar 2018 17:38:02 -0400
Date: Sat, 24 Mar 2018 22:21:13 +0100 (CET)
From: Sven Wegener <sven.wegener@stealer.net>
To: x86@kernel.org
cc: linux-kernel@vger.kernel.org
Subject: [PATCH] x86/purgatory: Remove -MD from KBUILD_CFLAGS
Message-ID: <alpine.LNX.2.21.1803242219380.30139@titan.int.lan.stealer.net>
User-Agent: Alpine 2.21 (LNX 202 2017-01-01)
Organization: STEALER.net
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Score: -1.1
X-Spam-Bar: -
X-Spam-Report: Scanned by SpamAssassin 3.4.1 2015-04-28 on smtp1.stealer.net at Sat, 24 Mar 2018 21:21:33 +0000
 Bayes: 0.0000 Tokens: new, 21; hammy, 104; neutral, 54; spammy, 2.
 AutoLearn: no autolearn_force=no
 * -1.9 BAYES_00 BODY: Bayes spam probability is 0 to 1%
 *      [score: 0.0000]
 *  0.8 RDNS_NONE Delivered to internal network by a host with no rDNS
X-Spam-Signature: 84efb85b8077eafccc75ed74e9104b6f8e73e507
X-DomainKey-Status: 
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The kernel build system already takes care of generating the dependency
files. Having the additional -MD in KBUILD_CFLAGS leads to stray
.<pid>.d files in the build directory when we call the cc-option macro.

Signed-off-by: Sven Wegener <sven.wegener@stealer.net>
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
 
