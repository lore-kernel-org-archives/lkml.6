Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756687AbeEJIAT (ORCPT <rfc822;w@1wt.eu>);
        Thu, 10 May 2018 04:00:19 -0400
Received: from mx2.suse.de ([195.135.220.15]:51196 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751313AbeEJIAS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 May 2018 04:00:18 -0400
From: Jiri Slaby <jslaby@suse.cz>
To: chris@zankel.net
Cc: linux-kernel@vger.kernel.org, Jiri Slaby <jslaby@suse.cz>,
        linux-xtensa@linux-xtensa.org
Subject: [PATCH 1/1] xtensa: use generic vga.h
Date: Thu, 10 May 2018 10:00:16 +0200
Message-Id: <20180510080016.18220-1-jslaby@suse.cz>
X-Mailer: git-send-email 2.16.3
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

What the architecture declares is the same as what can be found in
asm-generic/vga.h. So use that header instead.

Signed-off-by: Jiri Slaby <jslaby@suse.cz>
Acked-by: Max Filippov <jcmvbkbc@gmail.com>
Cc: Chris Zankel <chris@zankel.net>
Cc: linux-xtensa@linux-xtensa.org
---
 arch/xtensa/include/asm/Kbuild |  1 +
 arch/xtensa/include/asm/vga.h  | 19 -------------------
 2 files changed, 1 insertion(+), 19 deletions(-)
 delete mode 100644 arch/xtensa/include/asm/vga.h

diff --git a/arch/xtensa/include/asm/Kbuild b/arch/xtensa/include/asm/Kbuild
index e5e1e61c538c..926bbf97450b 100644
--- a/arch/xtensa/include/asm/Kbuild
+++ b/arch/xtensa/include/asm/Kbuild
@@ -25,5 +25,6 @@ generic-y += rwsem.h
 generic-y += sections.h
 generic-y += topology.h
 generic-y += trace_clock.h
+generic-y += vga.h
 generic-y += word-at-a-time.h
 generic-y += xor.h
diff --git a/arch/xtensa/include/asm/vga.h b/arch/xtensa/include/asm/vga.h
deleted file mode 100644
index 1fd8cab3a297..000000000000
--- a/arch/xtensa/include/asm/vga.h
+++ /dev/null
@@ -1,19 +0,0 @@
-/*
- * include/asm-xtensa/vga.h
- *
- * This file is subject to the terms and conditions of the GNU General Public
- * License.  See the file "COPYING" in the main directory of this archive
- * for more details.
- *
- * Copyright (C) 2001 - 2005 Tensilica Inc.
- */
-
-#ifndef _XTENSA_VGA_H
-#define _XTENSA_VGA_H
-
-#define VGA_MAP_MEM(x,s) (unsigned long)phys_to_virt(x)
-
-#define vga_readb(x)	(*(x))
-#define vga_writeb(x,y)	(*(y) = (x))
-
-#endif
-- 
2.16.3
