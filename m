Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932821AbeCPCTy (ORCPT <rfc822;w@1wt.eu>);
        Thu, 15 Mar 2018 22:19:54 -0400
Received: from conuserg-11.nifty.com ([210.131.2.78]:44539 "EHLO
        conuserg-11.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752884AbeCPCTM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Mar 2018 22:19:12 -0400
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-11.nifty.com w2G2IoBO003525
X-Nifty-SrcIP: [153.142.97.92]
From: Masahiro Yamada <yamada.masahiro@socionext.com>
To: linux-kbuild@vger.kernel.org
Cc: Nicolas Pitre <nicolas.pitre@linaro.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Michal Marek <michal.lkml@markovi.net>, linux-kernel@vger.kernel.org
Subject: [PATCH v2 3/7] kbuild: move 'scripts' target below
Date: Fri, 16 Mar 2018 11:18:40 +0900
Message-Id: <1521166725-24157-4-git-send-email-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1521166725-24157-1-git-send-email-yamada.masahiro@socionext.com>
References: <1521166725-24157-1-git-send-email-yamada.masahiro@socionext.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Just a trivial change to prepare for the next commit.
This target is still invisible from external module building.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

Changes in v2: None

 Makefile | 15 +++++++--------
 1 file changed, 7 insertions(+), 8 deletions(-)

diff --git a/Makefile b/Makefile
index ac8755d..f8e9e12 100644
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
+	 asm-generic gcc-plugins autoksyms
+	$(Q)$(MAKE) $(build)=$(@)
 
 # Things we need to do before we recursively start building the kernel
 # or the modules are listed in "prepare".
-- 
2.7.4
