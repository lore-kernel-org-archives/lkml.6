Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753388AbeCPHhv (ORCPT <rfc822;w@1wt.eu>);
        Fri, 16 Mar 2018 03:37:51 -0400
Received: from conuserg-08.nifty.com ([210.131.2.75]:20642 "EHLO
        conuserg-08.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753127AbeCPHhn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Mar 2018 03:37:43 -0400
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-08.nifty.com w2G7bOa6029139
X-Nifty-SrcIP: [153.142.97.92]
From: Masahiro Yamada <yamada.masahiro@socionext.com>
To: linux-kbuild@vger.kernel.org
Cc: Michal Marek <michal.lkml@markovi.net>,
        Nicolas Pitre <nicolas.pitre@linaro.org>, linux-kernel@vger.kernel.org,
        Masahiro Yamada <yamada.masahiro@socionext.com>
Subject: [PATCH v4 3/7] kbuild: move 'scripts' target below
Date: Fri, 16 Mar 2018 16:37:11 +0900
Message-Id: <1521185836-19120-4-git-send-email-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1521185836-19120-1-git-send-email-yamada.masahiro@socionext.com>
References: <1521185836-19120-1-git-send-email-yamada.masahiro@socionext.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Just a trivial change to prepare for the next commit.
This target is still invisible from external module building.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

Changes in v4:
  - Remove a garbage code to fix build error

Changes in v3: None
Changes in v2: None

 Makefile | 15 +++++++--------
 1 file changed, 7 insertions(+), 8 deletions(-)

diff --git a/Makefile b/Makefile
index ac8755d..9bf6697 100644
--- a/Makefile
+++ b/Makefile
@@ -567,14 +567,6 @@ endif
 export KBUILD_MODULES KBUILD_BUILTIN
 
 ifeq ($(KBUILD_EXTMOD),)
-# Additional helpers built in scripts/
-# Carefully list dependencies so we do not try to build scripts twice
-# in parallel
-PHONY += scripts
-scripts: scripts_basic include/config/auto.conf include/config/tristate.conf \
-	 asm-generic gcc-plugins
-	$(Q)$(MAKE) $(build)=$(@)
-
 # Objects we will link into vmlinux / subdirs we need to visit
 init-y		:= init/
 drivers-y	:= drivers/ sound/ firmware/
@@ -1070,6 +1062,13 @@ endef
 include/config/kernel.release: include/config/auto.conf FORCE
 	$(call filechk,kernel.release)
 
+# Additional helpers built in scripts/
+# Carefully list dependencies so we do not try to build scripts twice
+# in parallel
+PHONY += scripts
+scripts: scripts_basic include/config/auto.conf include/config/tristate.conf \
+	 asm-generic gcc-plugins
+	$(Q)$(MAKE) $(build)=$(@)
 
 # Things we need to do before we recursively start building the kernel
 # or the modules are listed in "prepare".
-- 
2.7.4
