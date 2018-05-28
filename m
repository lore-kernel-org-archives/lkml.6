Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933731AbeE1J1d (ORCPT <rfc822;w@1wt.eu>);
        Mon, 28 May 2018 05:27:33 -0400
Received: from conuserg-10.nifty.com ([210.131.2.77]:21768 "EHLO
        conuserg-10.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754373AbeE1JYU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 May 2018 05:24:20 -0400
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-10.nifty.com w4S9MInf027506
X-Nifty-SrcIP: [125.199.20.195]
From: Masahiro Yamada <yamada.masahiro@socionext.com>
To: linux-kbuild@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Kees Cook <keescook@chromium.org>,
        Nicholas Piggin <npiggin@gmail.com>,
        "Luis R . Rodriguez" <mcgrof@suse.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Ulf Magnusson <ulfalizer@gmail.com>, Sam Ravnborg <sam@ravnborg.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>
Subject: [PATCH v5 24/31] kconfig: add CC_IS_GCC and GCC_VERSION
Date: Mon, 28 May 2018 18:22:01 +0900
Message-Id: <1527499328-13213-25-git-send-email-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1527499328-13213-1-git-send-email-yamada.masahiro@socionext.com>
References: <1527499328-13213-1-git-send-email-yamada.masahiro@socionext.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This will be useful to specify the required compiler version,
like this:

config FOO
        bool "Use Foo"
        depends on GCC_VERSION >= 40800
        help
          This feature requires GCC 4.8 or newer.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
Reviewed-by: Kees Cook <keescook@chromium.org>
---

Changes in v5: None
Changes in v4: None
Changes in v3: None
Changes in v2: None

 init/Kconfig | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/init/Kconfig b/init/Kconfig
index f1b0cfb..2e33d93 100644
--- a/init/Kconfig
+++ b/init/Kconfig
@@ -8,6 +8,14 @@ config DEFCONFIG_LIST
 	default ARCH_DEFCONFIG
 	default "arch/$(ARCH)/defconfig"
 
+config CC_IS_GCC
+	def_bool $(success,$(CC) --version | grep -q gcc)
+
+config GCC_VERSION
+	int
+	default $(shell,$(srctree)/scripts/gcc-version.sh -p $(CC) | sed 's/^0*//') if CC_IS_GCC
+	default 0
+
 config CONSTRUCTORS
 	bool
 	depends on !UML
-- 
2.7.4
