Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752083AbeEQGTI (ORCPT <rfc822;w@1wt.eu>);
        Thu, 17 May 2018 02:19:08 -0400
Received: from conuserg-10.nifty.com ([210.131.2.77]:24366 "EHLO
        conuserg-10.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751850AbeEQGS4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 May 2018 02:18:56 -0400
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-10.nifty.com w4H6HbU7002841
X-Nifty-SrcIP: [153.142.97.92]
From: Masahiro Yamada <yamada.masahiro@socionext.com>
To: linux-kbuild@vger.kernel.org
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
        Sam Ravnborg <sam@ravnborg.org>, Ulf Magnusson <ulfalizer@gmail.com>,
        "Luis R . Rodriguez" <mcgrof@kernel.org>, linux-kernel@vger.kernel.org,
        Nicholas Piggin <npiggin@gmail.com>, Kees Cook <keescook@chromium.org>,
        Emese Revfy <re.emese@gmail.com>, x86@kernel.org,
        Masahiro Yamada <yamada.masahiro@socionext.com>
Subject: [PATCH v4 09/31] kconfig: replace $(UNAME_RELEASE) with function call
Date: Thu, 17 May 2018 15:16:48 +0900
Message-Id: <1526537830-22606-10-git-send-email-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1526537830-22606-1-git-send-email-yamada.masahiro@socionext.com>
References: <1526537830-22606-1-git-send-email-yamada.masahiro@socionext.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now that 'shell' function is supported, this can be self-contained in
Kconfig.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
Reviewed-by: Kees Cook <keescook@chromium.org>
Reviewed-by: Ulf Magnusson <ulfalizer@gmail.com>
---

Changes in v4: None
Changes in v3: None
Changes in v2: None

 Makefile     | 3 +--
 init/Kconfig | 4 ++--
 2 files changed, 3 insertions(+), 4 deletions(-)

diff --git a/Makefile b/Makefile
index c6278e6..01b2211 100644
--- a/Makefile
+++ b/Makefile
@@ -284,8 +284,7 @@ include scripts/Kbuild.include
 # Read KERNELRELEASE from include/config/kernel.release (if it exists)
 KERNELRELEASE = $(shell cat include/config/kernel.release 2> /dev/null)
 KERNELVERSION = $(VERSION)$(if $(PATCHLEVEL),.$(PATCHLEVEL)$(if $(SUBLEVEL),.$(SUBLEVEL)))$(EXTRAVERSION)
-UNAME_RELEASE := $(shell uname --release)
-export VERSION PATCHLEVEL SUBLEVEL KERNELRELEASE KERNELVERSION UNAME_RELEASE
+export VERSION PATCHLEVEL SUBLEVEL KERNELRELEASE KERNELVERSION
 
 # SUBARCH tells the usermode build what the underlying arch is.  That is set
 # first, and if a usermode build is happening, the "ARCH=um" on the command
diff --git a/init/Kconfig b/init/Kconfig
index 752816b..66f0463 100644
--- a/init/Kconfig
+++ b/init/Kconfig
@@ -2,9 +2,9 @@ config DEFCONFIG_LIST
 	string
 	depends on !UML
 	option defconfig_list
-	default "/lib/modules/$(UNAME_RELEASE)/.config"
+	default "/lib/modules/$(shell, uname --release)/.config"
 	default "/etc/kernel-config"
-	default "/boot/config-$(UNAME_RELEASE)"
+	default "/boot/config-$(shell, uname --release)"
 	default ARCH_DEFCONFIG
 	default "arch/$(ARCH)/defconfig"
 
-- 
2.7.4
