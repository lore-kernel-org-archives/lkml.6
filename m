Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752504AbeEQGUg (ORCPT <rfc822;w@1wt.eu>);
        Thu, 17 May 2018 02:20:36 -0400
Received: from conuserg-10.nifty.com ([210.131.2.77]:26312 "EHLO
        conuserg-10.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752378AbeEQGT7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 May 2018 02:19:59 -0400
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-10.nifty.com w4H6HbUT002841
X-Nifty-SrcIP: [153.142.97.92]
From: Masahiro Yamada <yamada.masahiro@socionext.com>
To: linux-kbuild@vger.kernel.org
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
        Sam Ravnborg <sam@ravnborg.org>, Ulf Magnusson <ulfalizer@gmail.com>,
        "Luis R . Rodriguez" <mcgrof@kernel.org>, linux-kernel@vger.kernel.org,
        Nicholas Piggin <npiggin@gmail.com>, Kees Cook <keescook@chromium.org>,
        Emese Revfy <re.emese@gmail.com>, x86@kernel.org,
        Masahiro Yamada <yamada.masahiro@socionext.com>
Subject: [PATCH v4 31/31] arm64: move GCC version check for ARCH_SUPPORTS_INT128 to Kconfig
Date: Thu, 17 May 2018 15:17:10 +0900
Message-Id: <1526537830-22606-32-git-send-email-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1526537830-22606-1-git-send-email-yamada.masahiro@socionext.com>
References: <1526537830-22606-1-git-send-email-yamada.masahiro@socionext.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This becomes much neater in Kconfig.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
Acked-by: Will Deacon <will.deacon@arm.com>
Reviewed-by: Kees Cook <keescook@chromium.org>
---

Changes in v4:
 - Rebase

Changes in v3:
 - Newly added

Changes in v2: None

 arch/arm64/Kconfig  | 1 +
 arch/arm64/Makefile | 6 ------
 2 files changed, 1 insertion(+), 6 deletions(-)

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index eb2cf49..119b18e 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -43,6 +43,7 @@ config ARM64
 	select ARCH_USE_QUEUED_RWLOCKS
 	select ARCH_SUPPORTS_MEMORY_FAILURE
 	select ARCH_SUPPORTS_ATOMIC_RMW
+	select ARCH_SUPPORTS_INT128 if GCC_VERSION >= 50000 || CC_IS_CLANG
 	select ARCH_SUPPORTS_NUMA_BALANCING
 	select ARCH_WANT_COMPAT_IPC_PARSE_VERSION
 	select ARCH_WANT_FRAME_POINTERS
diff --git a/arch/arm64/Makefile b/arch/arm64/Makefile
index 87f7d2f..cefd1e9 100644
--- a/arch/arm64/Makefile
+++ b/arch/arm64/Makefile
@@ -56,12 +56,6 @@ KBUILD_AFLAGS	+= $(lseinstr) $(brokengasinst)
 KBUILD_CFLAGS	+= $(call cc-option,-mabi=lp64)
 KBUILD_AFLAGS	+= $(call cc-option,-mabi=lp64)
 
-ifeq ($(cc-name),clang)
-KBUILD_CFLAGS	+= -DCONFIG_ARCH_SUPPORTS_INT128
-else
-KBUILD_CFLAGS	+= $(call cc-ifversion, -ge, 0500, -DCONFIG_ARCH_SUPPORTS_INT128)
-endif
-
 ifeq ($(CONFIG_CPU_BIG_ENDIAN), y)
 KBUILD_CPPFLAGS	+= -mbig-endian
 CHECKFLAGS	+= -D__AARCH64EB__
-- 
2.7.4
