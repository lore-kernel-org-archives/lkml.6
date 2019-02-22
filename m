Return-Path: <SRS0=t/yM=Q5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05969C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 22:30:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CD9712075A
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 22:30:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726772AbfBVWaK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Feb 2019 17:30:10 -0500
Received: from mout.kundenserver.de ([212.227.126.187]:59847 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725980AbfBVWaJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Feb 2019 17:30:09 -0500
Received: from wuerfel.lan ([109.192.41.194]) by mrelayeu.kundenserver.de
 (mreue009 [212.227.15.129]) with ESMTPA (Nemesis) id
 1MF39M-1gmGhn2OWe-00FSNQ; Fri, 22 Feb 2019 23:29:55 +0100
From:   Arnd Bergmann <arnd@arndb.de>
To:     Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Michal Marek <michal.lkml@markovi.net>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Arnd Bergmann <arnd@arndb.de>, Dmitry Vyukov <dvyukov@google.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Mark Brown <broonie@kernel.org>, Qian Cai <cai@lca.pw>,
        Kostya Serebryany <kcc@google.com>,
        Andrey Konovalov <andreyknvl@google.com>,
        Alexander Potapenko <glider@google.com>,
        linux-kernel@vger.kernel.org, kasan-dev@googlegroups.com,
        linux-kbuild@vger.kernel.org
Subject: [PATCH] [v2] kasan: turn off asan-stack for clang-8 and earlier
Date:   Fri, 22 Feb 2019 23:29:10 +0100
Message-Id: <20190222222950.3997333-1-arnd@arndb.de>
X-Mailer: git-send-email 2.20.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:EQsDhKNCDlCKmr3wDthNBS4aj4njVj4uZe/w3vijzQ2DqPrzKT/
 kWnaIjf6AUMXb7nqAjREyOctiQvsWUG3AP9vfcDiRYW95SVCWxOlL9E8ZEy7NAGKT4RtWQN
 S/+zebh6gqCp1r2MhEBgelOIGivJyDbXADOauTTry5xinRJ8Uzva3lUcQKg8Nu6IpScXShY
 bDtckkFQVAyfVywW+zGkA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:5jZ76+ZLx90=:rKd3DFhmwG/miABR8B0Snb
 6AXc6t7bJg0Ba/ZtpMp/xium1QJ6yUGZ89z0b2Jesmsz/camMrX4qUHw9IOLe1Y6kYgse6gTs
 Qfn9CXIomWxwQJSuzfvRd+58X8ek9oLTIMN9sgH9+YXB63VrNrweBC4uSRwiPoORd7X5jSEg4
 KGuubtOFPwM2hZGWDB3vL9gTRZdS2hmgl9eGELR3fyR4aD6zvwESB5XC4SWb/N0yM10KCNnZc
 7pEJKPPC5g4A4mJSSaa2RnxWLbr63ugO5fDFZwDAaQmkNh8WVmzLnS/3Yuqs9jJabjx4so+uN
 RgDhBQSrHIk9b+NeukHdISSb/1OHrs1gj0ogMREZ4ClZZ86GyIj2bzClE/r4zzDAiU30XyDyw
 D0aq4GxUW627xKQe8/OfEpKgJRS3bpXKKmX2JaL88GCvXYb/+SzrpJ9qlOIeXIWSt5wUKSdIL
 t0txIwwqIcoq8aeUCI/e4ajXAuMxqXm25wMsWm16YMLV4fYxliV9djeeD78n8wcGq8mi3AGpO
 dP3ij3YzZ8AwKf1iJZGzG5qP/dwu2DzpOMStknl+1lg3nMnTmFfLFdL8VD4V7g3sCVuw2lVTA
 56u/cLYqFTRLhT+Y+mJSKznS+OHN45d+z02TuvVeo7we76rdDKv/gw1aK99ycZmedqcIz4bfn
 xKQNq2Lu215q5I7ZtuEjWDlDW5y9R+aBvivPA5v1cbxfP4HhgrywtjCGGjom+bXxjb0iTY/su
 SeIbVIlsKmYiLBYGN4UIJNb7j6hhQjECxJxeoQ==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Building an arm64 allmodconfig kernel with clang results in over 140 warnings
about overly large stack frames, the worst ones being:

drivers/gpu/drm/panel/panel-sitronix-st7789v.c:196:12: error: stack frame size of 20224 bytes in function 'st7789v_prepare'
drivers/video/fbdev/omap2/omapfb/displays/panel-tpo-td028ttec1.c:196:12: error: stack frame size of 13120 bytes in function 'td028ttec1_panel_enable'
drivers/usb/host/max3421-hcd.c:1395:1: error: stack frame size of 10048 bytes in function 'max3421_spi_thread'
drivers/net/wan/slic_ds26522.c:209:12: error: stack frame size of 9664 bytes in function 'slic_ds26522_probe'
drivers/crypto/ccp/ccp-ops.c:2434:5: error: stack frame size of 8832 bytes in function 'ccp_run_cmd'
drivers/media/dvb-frontends/stv0367.c:1005:12: error: stack frame size of 7840 bytes in function 'stv0367ter_algo'

None of these happen with gcc today, and almost all of these are the result
of a single known issue in llvm.  Hopefully it will eventually get fixed with
the clang-9 release.

In the meantime, the best idea I have is to turn off asan-stack for clang-8
and earlier, so we can produce a kernel that is safe to run.

I have posted three patches that address the frame overflow warnings that are
not addressed by turning off asan-stack, so in combination with this change,
we get much closer to a clean allmodconfig build, which in turn is necessary
to do meaningful build regression testing.

It is still possible to turn on the CONFIG_ASAN_STACK option on all versions
of clang, and it's always enabled for gcc, but when CONFIG_COMPILE_TEST is
set, the option remains invisible, so allmodconfig and randconfig builds
(which are normally done with a forced CONFIG_COMPILE_TEST) will still result
in a mostly clean build.

Cc: Andrey Ryabinin <aryabinin@virtuozzo.com>
Cc: Dmitry Vyukov <dvyukov@google.com>
Cc: Nick Desaulniers <ndesaulniers@google.com>
Cc: Mark Brown <broonie@kernel.org>
Cc: Qian Cai <cai@lca.pw>
Cc: Kostya Serebryany <kcc@google.com>
Cc: Andrey Konovalov <andreyknvl@google.com>
Link: https://bugs.llvm.org/show_bug.cgi?id=38809
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
Changes in v2:
- allow CONFIG_KASAN_STACK to be manually enabled/disabled on all
  clang versions, just make the default version specific, and
  ensure that it's turned off for allmodconfig build testing
---
 lib/Kconfig.kasan      | 22 ++++++++++++++++++++++
 scripts/Makefile.kasan |  2 +-
 2 files changed, 23 insertions(+), 1 deletion(-)

diff --git a/lib/Kconfig.kasan b/lib/Kconfig.kasan
index 67d7d1309c52..9950b660e62d 100644
--- a/lib/Kconfig.kasan
+++ b/lib/Kconfig.kasan
@@ -103,6 +103,28 @@ config KASAN_INLINE
 
 endchoice
 
+config KASAN_STACK_ENABLE
+	bool "Enable stack instrumentation (unsafe)" if CC_IS_CLANG && !COMPILE_TEST
+	default !(CLANG_VERSION < 90000)
+	depends on KASAN
+	help
+	  The LLVM stack address sanitizer has a know problem that
+	  causes excessive stack usage in a lot of functions, see
+	  https://bugs.llvm.org/show_bug.cgi?id=38809
+	  Disabling asan-stack makes it safe to run kernels build
+	  with clang-8 with KASAN enabled, though it loses some of
+	  the functionality.
+	  This feature is always disabled when compile-testing with clang-8
+	  or earlier to avoid cluttering the output in stack overflow
+	  warnings, but clang-8 users can still enable it for builds without
+	  CONFIG_COMPILE_TEST.  On gcc and later clang versions it is
+	  assumed to always be safe to use and enabled by default.
+
+config KASAN_STACK
+	int
+	default 1 if KASAN_STACK_ENABLE || CC_IS_GCC
+	default 0
+
 config KASAN_S390_4_LEVEL_PAGING
 	bool "KASan: use 4-level paging"
 	depends on KASAN && S390
diff --git a/scripts/Makefile.kasan b/scripts/Makefile.kasan
index f1fb8e502657..6410bd22fe38 100644
--- a/scripts/Makefile.kasan
+++ b/scripts/Makefile.kasan
@@ -26,7 +26,7 @@ else
 	CFLAGS_KASAN := $(CFLAGS_KASAN_SHADOW) \
 	 $(call cc-param,asan-globals=1) \
 	 $(call cc-param,asan-instrumentation-with-call-threshold=$(call_threshold)) \
-	 $(call cc-param,asan-stack=1) \
+	 $(call cc-param,asan-stack=$(CONFIG_KASAN_STACK)) \
 	 $(call cc-param,asan-instrument-allocas=1)
 endif
 
-- 
2.20.0

