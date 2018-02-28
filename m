Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751857AbeB1ARj (ORCPT <rfc822;w@1wt.eu>);
        Tue, 27 Feb 2018 19:17:39 -0500
Received: from conuserg-09.nifty.com ([210.131.2.76]:24337 "EHLO
        conuserg-09.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751899AbeB1AQs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Feb 2018 19:16:48 -0500
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-09.nifty.com w1S0Fahp000353
X-Nifty-SrcIP: [125.199.20.195]
From: Masahiro Yamada <yamada.masahiro@socionext.com>
To: linux-kbuild@vger.kernel.org
Cc: Marc Herbert <marc.herbert@intel.com>,
        Ulf Magnusson <ulfalizer@gmail.com>, Sam Ravnborg <sam@ravnborg.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 5/6] kconfig: invoke oldconfig instead of silentoldconfig from local*config
Date: Wed, 28 Feb 2018 09:15:25 +0900
Message-Id: <1519776926-30459-6-git-send-email-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1519776926-30459-1-git-send-email-yamada.masahiro@socionext.com>
References: <1519776926-30459-1-git-send-email-yamada.masahiro@socionext.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The purpose of local{yes,mod}config is to arrange the .config file
based on actually loaded modules.  It is unnecessary to update
include/generated/autoconf.h and include/config/* stuff here.

They will be automatically updated during the build.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

Changes in v2:
  - newly added

 scripts/kconfig/Makefile | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/scripts/kconfig/Makefile b/scripts/kconfig/Makefile
index c5d1d1a..bf9289a 100644
--- a/scripts/kconfig/Makefile
+++ b/scripts/kconfig/Makefile
@@ -49,11 +49,11 @@ localyesconfig localmodconfig: $(obj)/streamline_config.pl $(obj)/conf
 			cmp -s .tmp.config .config ||			\
 			(mv -f .config .config.old.1;			\
 			 mv -f .tmp.config .config;			\
-			 $(obj)/conf $(silent) --silentoldconfig $(Kconfig); \
+			 $(obj)/conf $(silent) --oldconfig $(Kconfig); \
 			 mv -f .config.old.1 .config.old)		\
 	else								\
 			mv -f .tmp.config .config;			\
-			$(obj)/conf $(silent) --silentoldconfig $(Kconfig); \
+			$(obj)/conf $(silent) --oldconfig $(Kconfig); \
 	fi
 	$(Q)rm -f .tmp.config
 
-- 
2.7.4
