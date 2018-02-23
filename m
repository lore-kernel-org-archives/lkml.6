Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751447AbeBWE63 (ORCPT <rfc822;w@1wt.eu>);
        Thu, 22 Feb 2018 23:58:29 -0500
Received: from conuserg-12.nifty.com ([210.131.2.79]:26215 "EHLO
        conuserg-12.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751296AbeBWE61 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Feb 2018 23:58:27 -0500
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-12.nifty.com w1N4uwWA024939
X-Nifty-SrcIP: [153.142.97.92]
From: Masahiro Yamada <yamada.masahiro@socionext.com>
To: linux-kbuild@vger.kernel.org
Cc: Arnd Bergmann <arnd@arndb.de>, Sam Ravnborg <sam@ravnborg.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Matthias Kaehlcke <mka@chromium.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Michal Marek <michal.lkml@markovi.net>, linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] kbuild: test --build-id linker flag by ld-option instead of cc-ldoption
Date: Fri, 23 Feb 2018 13:56:52 +0900
Message-Id: <1519361813-8553-1-git-send-email-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

'--build-id' is passed to $(LD), so it should be tested by 'ld-option'.

This seems a kind of misconversion when ld-option was renamed to
cc-ldoption.

Commit f86fd3066052 ("kbuild: rename ld-option to cc-ldoption") renamed
all instances of 'ld-option' to 'cc-ldoption'.

Then, commit 691ef3e7fdc1 ("kbuild: introduce ld-option") re-added
'ld-option' as a new implementation.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 Makefile | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/Makefile b/Makefile
index 4f295a2..1ed2a15 100644
--- a/Makefile
+++ b/Makefile
@@ -866,8 +866,7 @@ KBUILD_AFLAGS   += $(ARCH_AFLAGS)   $(KAFLAGS)
 KBUILD_CFLAGS   += $(ARCH_CFLAGS)   $(KCFLAGS)
 
 # Use --build-id when available.
-LDFLAGS_BUILD_ID := $(patsubst -Wl$(comma)%,%,\
-			      $(call cc-ldoption, -Wl$(comma)--build-id,))
+LDFLAGS_BUILD_ID := $(call ld-option, --build-id)
 KBUILD_LDFLAGS_MODULE += $(LDFLAGS_BUILD_ID)
 LDFLAGS_vmlinux += $(LDFLAGS_BUILD_ID)
 
-- 
2.7.4
