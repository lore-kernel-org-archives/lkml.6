Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751440AbeDVK03 (ORCPT <rfc822;w@1wt.eu>);
        Sun, 22 Apr 2018 06:26:29 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:51329 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751234AbeDVK02 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Apr 2018 06:26:28 -0400
Date: Sun, 22 Apr 2018 12:26:26 +0200 (CEST)
From: Thomas Gleixner <tglx@linutronix.de>
To: Linus Torvalds <torvalds@linux-foundation.org>
cc: LKML <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@kernel.org>
Subject: [GIT pull] core fix for 4.17
Message-ID: <alpine.DEB.2.21.1804221223560.6136@nanos.tec.linutronix.de>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

please pull the latest core-urgent-for-linus git tree from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git core-urgent-for-linus

A single fix for objtool so it uses the host C and LD flags and not the
target ones.

Thanks,

	tglx

------------------>
Laura Abbott (1):
      objtool: Support HOSTCFLAGS and HOSTLDFLAGS


 tools/objtool/Makefile | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/objtool/Makefile b/tools/objtool/Makefile
index 8ae824dbfca3..f76d9914686a 100644
--- a/tools/objtool/Makefile
+++ b/tools/objtool/Makefile
@@ -31,8 +31,8 @@ INCLUDES := -I$(srctree)/tools/include \
 	    -I$(srctree)/tools/arch/$(HOSTARCH)/include/uapi \
 	    -I$(srctree)/tools/objtool/arch/$(ARCH)/include
 WARNINGS := $(EXTRA_WARNINGS) -Wno-switch-default -Wno-switch-enum -Wno-packed
-CFLAGS   += -Wall -Werror $(WARNINGS) -fomit-frame-pointer -O2 -g $(INCLUDES)
-LDFLAGS  += -lelf $(LIBSUBCMD)
+CFLAGS   += -Werror $(WARNINGS) $(HOSTCFLAGS) -g $(INCLUDES)
+LDFLAGS  += -lelf $(LIBSUBCMD) $(HOSTLDFLAGS)
 
 # Allow old libelf to be used:
 elfshdr := $(shell echo '$(pound)include <libelf.h>' | $(CC) $(CFLAGS) -x c -E - | grep elf_getshdr)
