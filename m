Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753499AbeDMFJR (ORCPT <rfc822;w@1wt.eu>);
        Fri, 13 Apr 2018 01:09:17 -0400
Received: from conuserg-07.nifty.com ([210.131.2.74]:55853 "EHLO
        conuserg-07.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753296AbeDMFJA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Apr 2018 01:09:00 -0400
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-07.nifty.com w3D56lgM029209
X-Nifty-SrcIP: [153.142.97.92]
From: Masahiro Yamada <yamada.masahiro@socionext.com>
To: linux-kbuild@vger.kernel.org
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
        Sam Ravnborg <sam@ravnborg.org>, Ulf Magnusson <ulfalizer@gmail.com>,
        Nicholas Piggin <npiggin@gmail.com>, Kees Cook <keescook@chromium.org>,
        Emese Revfy <re.emese@gmail.com>, x86@kernel.org,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 28/30] gcc-plugins: allow to enable GCC_PLUGINS for COMPILE_TEST
Date: Fri, 13 Apr 2018 14:06:37 +0900
Message-Id: <1523595999-27433-29-git-send-email-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1523595999-27433-1-git-send-email-yamada.masahiro@socionext.com>
References: <1523595999-27433-1-git-send-email-yamada.masahiro@socionext.com>
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

Kees said to do so because the first two are too noisy, and the last
one would reduce the compile test coverage.  I commented the reasons
in arch/Kconfig.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

Changes in v3: None
Changes in v2: None

 arch/Kconfig | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/arch/Kconfig b/arch/Kconfig
index 9166157..95b9b2e 100644
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
@@ -493,7 +492,7 @@ config GCC_PLUGIN_STRUCTLEAK_BYREF_ALL
 config GCC_PLUGIN_STRUCTLEAK_VERBOSE
 	bool "Report forcefully initialized variables"
 	depends on GCC_PLUGIN_STRUCTLEAK
-	depends on !COMPILE_TEST
+	depends on !COMPILE_TEST	# too noisy
 	help
 	  This option will cause a warning to be printed each time the
 	  structleak plugin finds a variable it thinks needs to be
@@ -533,7 +532,7 @@ config GCC_PLUGIN_RANDSTRUCT
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
