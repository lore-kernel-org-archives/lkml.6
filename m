Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752515AbeEQGUh (ORCPT <rfc822;w@1wt.eu>);
        Thu, 17 May 2018 02:20:37 -0400
Received: from conuserg-10.nifty.com ([210.131.2.77]:26308 "EHLO
        conuserg-10.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752176AbeEQGT7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 May 2018 02:19:59 -0400
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-10.nifty.com w4H6HbUM002841
X-Nifty-SrcIP: [153.142.97.92]
From: Masahiro Yamada <yamada.masahiro@socionext.com>
To: linux-kbuild@vger.kernel.org
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
        Sam Ravnborg <sam@ravnborg.org>, Ulf Magnusson <ulfalizer@gmail.com>,
        "Luis R . Rodriguez" <mcgrof@kernel.org>, linux-kernel@vger.kernel.org,
        Nicholas Piggin <npiggin@gmail.com>, Kees Cook <keescook@chromium.org>,
        Emese Revfy <re.emese@gmail.com>, x86@kernel.org,
        Masahiro Yamada <yamada.masahiro@socionext.com>
Subject: [PATCH v4 24/31] kconfig: add CC_IS_GCC and GCC_VERSION
Date: Thu, 17 May 2018 15:17:03 +0900
Message-Id: <1526537830-22606-25-git-send-email-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1526537830-22606-1-git-send-email-yamada.masahiro@socionext.com>
References: <1526537830-22606-1-git-send-email-yamada.masahiro@socionext.com>
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

Changes in v4: None
Changes in v3: None
Changes in v2: None

 init/Kconfig | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/init/Kconfig b/init/Kconfig
index 66f0463..c6ac856 100644
--- a/init/Kconfig
+++ b/init/Kconfig
@@ -8,6 +8,14 @@ config DEFCONFIG_LIST
 	default ARCH_DEFCONFIG
 	default "arch/$(ARCH)/defconfig"
 
+config CC_IS_GCC
+	def_bool $(success, $(CC) --version | grep -q gcc)
+
+config GCC_VERSION
+	int
+	default $(shell, $(srctree)/scripts/gcc-version.sh -p $(CC) | sed 's/^0*//') if CC_IS_GCC
+	default 0
+
 config CONSTRUCTORS
 	bool
 	depends on !UML
-- 
2.7.4
