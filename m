Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966394AbeCAGgU (ORCPT <rfc822;w@1wt.eu>);
        Thu, 1 Mar 2018 01:36:20 -0500
Received: from conuserg-12.nifty.com ([210.131.2.79]:25515 "EHLO
        conuserg-12.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S966373AbeCAGgS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Mar 2018 01:36:18 -0500
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-12.nifty.com w216YiUZ022072
X-Nifty-SrcIP: [153.142.97.92]
From: Masahiro Yamada <yamada.masahiro@socionext.com>
To: linux-kbuild@vger.kernel.org
Cc: Sam Ravnborg <sam@ravnborg.org>, Ulf Magnusson <ulfalizer@gmail.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Marc Herbert <marc.herbert@intel.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 1/2] kconfig: invoke oldconfig instead of silentoldconfig from local*config
Date: Thu,  1 Mar 2018 15:34:36 +0900
Message-Id: <1519886077-31914-1-git-send-email-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The purpose of local{yes,mod}config is to arrange the .config file
based on actually loaded modules.  It is unnecessary to update
include/generated/autoconf.h and include/config/* stuff here.
They will be updated as needed during the build.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
Reviewed-by: Ulf Magnusson <ulfalizer@gmail.com>
---

Changes in v3:
  - Fix alignment of back-slashes

Changes in v2:
  - newly added

 scripts/kconfig/Makefile | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/scripts/kconfig/Makefile b/scripts/kconfig/Makefile
index cb3ec53..41e2a9f 100644
--- a/scripts/kconfig/Makefile
+++ b/scripts/kconfig/Makefile
@@ -49,11 +49,11 @@ localyesconfig localmodconfig: $(obj)/streamline_config.pl $(obj)/conf
 			cmp -s .tmp.config .config ||			\
 			(mv -f .config .config.old.1;			\
 			 mv -f .tmp.config .config;			\
-			 $(obj)/conf $(silent) --silentoldconfig $(Kconfig); \
+			 $(obj)/conf $(silent) --oldconfig $(Kconfig);	\
 			 mv -f .config.old.1 .config.old)		\
 	else								\
 			mv -f .tmp.config .config;			\
-			$(obj)/conf $(silent) --silentoldconfig $(Kconfig); \
+			$(obj)/conf $(silent) --oldconfig $(Kconfig);	\
 	fi
 	$(Q)rm -f .tmp.config
 
-- 
2.7.4
