Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752182AbeDMFIX (ORCPT <rfc822;w@1wt.eu>);
        Fri, 13 Apr 2018 01:08:23 -0400
Received: from conuserg-07.nifty.com ([210.131.2.74]:54461 "EHLO
        conuserg-07.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750885AbeDMFIP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Apr 2018 01:08:15 -0400
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-07.nifty.com w3D56lg4029209
X-Nifty-SrcIP: [153.142.97.92]
From: Masahiro Yamada <yamada.masahiro@socionext.com>
To: linux-kbuild@vger.kernel.org
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
        Sam Ravnborg <sam@ravnborg.org>, Ulf Magnusson <ulfalizer@gmail.com>,
        Nicholas Piggin <npiggin@gmail.com>, Kees Cook <keescook@chromium.org>,
        Emese Revfy <re.emese@gmail.com>, x86@kernel.org,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 10/30] kconfig: replace $(UNAME_RELEASE) with function call
Date: Fri, 13 Apr 2018 14:06:19 +0900
Message-Id: <1523595999-27433-11-git-send-email-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1523595999-27433-1-git-send-email-yamada.masahiro@socionext.com>
References: <1523595999-27433-1-git-send-email-yamada.masahiro@socionext.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now that 'shell' function is supported, this can be self-contained in
Kconfig.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
Reviewed-by: Kees Cook <keescook@chromium.org>
Reviewed-by: Ulf Magnusson <ulfalizer@gmail.com>
---

Changes in v3: None
Changes in v2: None

 Makefile     | 3 +--
 init/Kconfig | 4 ++--
 2 files changed, 3 insertions(+), 4 deletions(-)

diff --git a/Makefile b/Makefile
index 5298ad7..ca3e3e8 100644
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
index e6dafed5..4b0b636 100644
--- a/init/Kconfig
+++ b/init/Kconfig
@@ -2,9 +2,9 @@ config DEFCONFIG_LIST
 	string
 	depends on !UML
 	option defconfig_list
-	default "/lib/modules/$(UNAME_RELEASE)/.config"
+	default "/lib/modules/$(shell uname --release)/.config"
 	default "/etc/kernel-config"
-	default "/boot/config-$(UNAME_RELEASE)"
+	default "/boot/config-$(shell uname --release)"
 	default ARCH_DEFCONFIG
 	default "arch/$(ARCH)/defconfig"
 
-- 
2.7.4
