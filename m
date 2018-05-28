Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S940311AbeE1Qkd (ORCPT <rfc822;w@1wt.eu>);
        Mon, 28 May 2018 12:40:33 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:38223 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934545AbeE1QkZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 May 2018 12:40:25 -0400
X-Google-Smtp-Source: AB8JxZrY7wjApJfAkAc8OgWu5/ERdF/44EjevydbyhPPfZDBwsmfHr4zSiFextKO0eulkyCzTcJ7Og==
From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
To: Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>
Cc: linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org,
        Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH] sh: pass machine size to sparse
Date: Mon, 28 May 2018 18:40:18 +0200
Message-Id: <20180528164018.16064-1-luc.vanoostenryck@gmail.com>
X-Mailer: git-send-email 2.17.0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

By default, sparse assumes a 64bit machine when compiled on x86-64
and 32bit when compiled on anything else.

This can of course create all sort of problems, like issuing false
warnings like: 'shift too big (32) for type unsigned long', or
worse, to not emit legitimate warnings.

Fix this by passing to sparse the appropriate -m32/-m64 flag

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 arch/sh/Makefile | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/sh/Makefile b/arch/sh/Makefile
index 65300193b..3a195c9d5 100644
--- a/arch/sh/Makefile
+++ b/arch/sh/Makefile
@@ -206,6 +206,8 @@ ifeq ($(CONFIG_DWARF_UNWINDER),y)
   KBUILD_CFLAGS += -fasynchronous-unwind-tables
 endif
 
+CHECKFLAGS += -m$(BITS)
+
 libs-$(CONFIG_SUPERH32)		:= arch/sh/lib/	$(libs-y)
 libs-$(CONFIG_SUPERH64)		:= arch/sh/lib64/ $(libs-y)
 
-- 
2.17.0
