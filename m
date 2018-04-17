Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753175AbeDQMrW (ORCPT <rfc822;w@1wt.eu>);
        Tue, 17 Apr 2018 08:47:22 -0400
Received: from terminus.zytor.com ([198.137.202.136]:60859 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752684AbeDQMrV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Apr 2018 08:47:21 -0400
Date: Tue, 17 Apr 2018 05:31:20 -0700
From: tip-bot for Laura Abbott <tipbot@zytor.com>
Message-ID: <tip-596a9f6768af58d7034f6ebe559a0d489ae61467@git.kernel.org>
Cc: mingo@kernel.org, tglx@linutronix.de, peterz@infradead.org,
        hpa@zytor.com, yamada.masahiro@socionext.com,
        linux-kernel@vger.kernel.org, jpoimboe@redhat.com,
        torvalds@linux-foundation.org, labbott@redhat.com
Reply-To: labbott@redhat.com, torvalds@linux-foundation.org,
        jpoimboe@redhat.com, linux-kernel@vger.kernel.org,
        yamada.masahiro@socionext.com, hpa@zytor.com, peterz@infradead.org,
        mingo@kernel.org, tglx@linutronix.de
In-Reply-To: <05a360681176f1423cb2fde8faae3a0a0261afc5.1523560825.git.jpoimboe@redhat.com>
References: <05a360681176f1423cb2fde8faae3a0a0261afc5.1523560825.git.jpoimboe@redhat.com>
To: linux-tip-commits@vger.kernel.org
Subject: [tip:core/urgent] objtool: Support HOSTCFLAGS and HOSTLDFLAGS
Git-Commit-ID: 596a9f6768af58d7034f6ebe559a0d489ae61467
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

Commit-ID:  596a9f6768af58d7034f6ebe559a0d489ae61467
Gitweb:     https://git.kernel.org/tip/596a9f6768af58d7034f6ebe559a0d489ae61467
Author:     Laura Abbott <labbott@redhat.com>
AuthorDate: Thu, 12 Apr 2018 14:21:54 -0500
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Tue, 17 Apr 2018 07:59:42 +0200

objtool: Support HOSTCFLAGS and HOSTLDFLAGS

It may be useful to compile host programs with different flags (e.g.
hardening). Ensure that objtool picks up the appropriate flags.

Signed-off-by: Laura Abbott <labbott@redhat.com>
Signed-off-by: Josh Poimboeuf <jpoimboe@redhat.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Masahiro Yamada <yamada.masahiro@socionext.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: linux-kbuild@vger.kernel.org
Link: http://lkml.kernel.org/r/05a360681176f1423cb2fde8faae3a0a0261afc5.1523560825.git.jpoimboe@redhat.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
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
