Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933501AbeE1JYy (ORCPT <rfc822;w@1wt.eu>);
        Mon, 28 May 2018 05:24:54 -0400
Received: from conuserg-10.nifty.com ([210.131.2.77]:22335 "EHLO
        conuserg-10.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933272AbeE1JYl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 May 2018 05:24:41 -0400
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-10.nifty.com w4S9MInm027506
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
Subject: [PATCH v5 31/31] Documentation: kconfig: add recommended way to describe compiler support
Date: Mon, 28 May 2018 18:22:08 +0900
Message-Id: <1527499328-13213-32-git-send-email-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1527499328-13213-1-git-send-email-yamada.masahiro@socionext.com>
References: <1527499328-13213-1-git-send-email-yamada.masahiro@socionext.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It would be nice if the source code is written in the same style.
This proposes the convention for describing the compiler capability
in Kconfig.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

This is not a technical issue, but it would be nice if everybody
follows the same coding style.

Without any documemation, people may write the code in their own way.
For example, there could be some possibilities for the option naming.

  CC_HAS_
  CC_SUPPORTS_
  CC_HAVE_
  ...

IMHO, CC_HAS_ is short and enough to understand the meaning.

CC_SUPPORTS_ is also good, but I personally prefer the shorter one.

Comments are appreciated.


Changes in v5:
  - Newly added

Changes in v4: None
Changes in v3: None
Changes in v2: None

 Documentation/kbuild/kconfig-language.txt | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/Documentation/kbuild/kconfig-language.txt b/Documentation/kbuild/kconfig-language.txt
index 0e966e8..a4eb018 100644
--- a/Documentation/kbuild/kconfig-language.txt
+++ b/Documentation/kbuild/kconfig-language.txt
@@ -473,6 +473,24 @@ config option to 'y' no matter the dependencies.
 The dependencies are moved to the symbol GENERIC_IOMAP and we avoid the
 situation where select forces a symbol equals to 'y'.
 
+Adding features that need compiler support
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+
+There are several features that need compiler support. The recommended way
+to describe the dependency on the compiler feature is to use "depends on"
+followed by a test macro.
+
+config CC_STACKPROTECTOR
+	bool "Stack Protector buffer overflow detection"
+	depends on $(cc-option,-fstack-protector)
+	...
+
+If you need to expose a compiler capability to makefiles and/or C source files,
+CC_HAS_ is the recommended prefix for the config option.
+
+config CC_HAS_STACKPROTECTOR_NONE
+	def_bool $(cc-option,-fno-stack-protector)
+
 Build as module only
 ~~~~~~~~~~~~~~~~~~~~
 To restrict a component build to module-only, qualify its config symbol
-- 
2.7.4
