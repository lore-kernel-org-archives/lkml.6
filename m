Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752471AbeCNQps (ORCPT <rfc822;w@1wt.eu>);
        Wed, 14 Mar 2018 12:45:48 -0400
Received: from conuserg-07.nifty.com ([210.131.2.74]:38067 "EHLO
        conuserg-07.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751991AbeCNQou (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Mar 2018 12:44:50 -0400
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-07.nifty.com w2EGiSdS001049
X-Nifty-SrcIP: [125.199.20.195]
From: Masahiro Yamada <yamada.masahiro@socionext.com>
To: linux-kbuild@vger.kernel.org
Cc: Nicolas Pitre <nicolas.pitre@linaro.org>,
        Jarod Wilson <jarod@redhat.com>, Prarit Bhargava <prarit@redhat.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Michal Marek <michal.lkml@markovi.net>, linux-kernel@vger.kernel.org
Subject: [PATCH 3/7] kbuild: move 'scripts' target below
Date: Thu, 15 Mar 2018 01:44:17 +0900
Message-Id: <1521045861-22418-4-git-send-email-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1521045861-22418-1-git-send-email-yamada.masahiro@socionext.com>
References: <1521045861-22418-1-git-send-email-yamada.masahiro@socionext.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Just a trivial change to prepare for the next commit.
This target is still invisible from external module building.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 Makefile | 15 +++++++--------
 1 file changed, 7 insertions(+), 8 deletions(-)

diff --git a/Makefile b/Makefile
index 5eb5d9d..fab0e19 100644
--- a/Makefile
+++ b/Makefile
@@ -556,14 +556,6 @@ endif
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
@@ -1059,6 +1051,13 @@ endef
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
