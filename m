Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933707AbeE1JZK (ORCPT <rfc822;w@1wt.eu>);
        Mon, 28 May 2018 05:25:10 -0400
Received: from conuserg-10.nifty.com ([210.131.2.77]:22994 "EHLO
        conuserg-10.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933515AbeE1JZD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 May 2018 05:25:03 -0400
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-10.nifty.com w4S9MInl027506
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
Subject: [PATCH v5 30/31] gcc-plugins: allow to enable GCC_PLUGINS for COMPILE_TEST
Date: Mon, 28 May 2018 18:22:07 +0900
Message-Id: <1527499328-13213-31-git-send-email-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1527499328-13213-1-git-send-email-yamada.masahiro@socionext.com>
References: <1527499328-13213-1-git-send-email-yamada.masahiro@socionext.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now that the compiler's plugin support is checked in Kconfig,
all{yes,mod}config will not be bothered.

Remove 'depends on !COMPILE_TEST' for GCC_PLUGINS.

'depends on !COMPILE_TEST' for the following three are still kept:
  GCC_PLUGIN_CYC_COMPLEXITY
  GCC_PLUGIN_STRUCTLEAK_VERBOSE
  GCC_PLUGIN_RANDSTRUCT_PERFORMANCE

Kees suggested to do so because the first two are too noisy, and the
last one would reduce the compile test coverage.  I commented the
reasons in arch/Kconfig.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
Acked-by: Kees Cook <keescook@chromium.org>
---

Changes in v5: None
Changes in v4: None
Changes in v3:
  - Add comment about reason

Changes in v2: None

 arch/Kconfig | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/arch/Kconfig b/arch/Kconfig
index 6051386..e9475d0 100644
--- a/arch/Kconfig
+++ b/arch/Kconfig
@@ -420,7 +420,6 @@ menuconfig GCC_PLUGINS
 	bool "GCC plugins"
 	depends on HAVE_GCC_PLUGINS
 	depends on PLUGIN_HOSTCC != ""
-	depends on !COMPILE_TEST
 	help
 	  GCC plugins are loadable modules that provide extra features to the
 	  compiler. They are useful for runtime instrumentation and static analysis.
@@ -430,7 +429,7 @@ menuconfig GCC_PLUGINS
 config GCC_PLUGIN_CYC_COMPLEXITY
 	bool "Compute the cyclomatic complexity of a function" if EXPERT
 	depends on GCC_PLUGINS
-	depends on !COMPILE_TEST
+	depends on !COMPILE_TEST	# too noisy
 	help
 	  The complexity M of a function's control flow graph is defined as:
 	   M = E - N + 2P
@@ -497,7 +496,7 @@ config GCC_PLUGIN_STRUCTLEAK_BYREF_ALL
 config GCC_PLUGIN_STRUCTLEAK_VERBOSE
 	bool "Report forcefully initialized variables"
 	depends on GCC_PLUGIN_STRUCTLEAK
-	depends on !COMPILE_TEST
+	depends on !COMPILE_TEST	# too noisy
 	help
 	  This option will cause a warning to be printed each time the
 	  structleak plugin finds a variable it thinks needs to be
@@ -537,7 +536,7 @@ config GCC_PLUGIN_RANDSTRUCT
 config GCC_PLUGIN_RANDSTRUCT_PERFORMANCE
 	bool "Use cacheline-aware structure randomization"
 	depends on GCC_PLUGIN_RANDSTRUCT
-	depends on !COMPILE_TEST
+	depends on !COMPILE_TEST	# do not reduce test coverage
 	help
 	  If you say Y here, the RANDSTRUCT randomization will make a
 	  best effort at restricting randomization to cacheline-sized
-- 
2.7.4
