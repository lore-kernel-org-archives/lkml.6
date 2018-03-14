Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752192AbeCNOx0 (ORCPT <rfc822;w@1wt.eu>);
        Wed, 14 Mar 2018 10:53:26 -0400
Received: from mout.kundenserver.de ([212.227.126.187]:48965 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751456AbeCNOxX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Mar 2018 10:53:23 -0400
From: Arnd Bergmann <arnd@arndb.de>
To: linux-arch@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>
Cc: linux-kernel@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>
Subject: [PATCH 16/16] ktest: remove obsolete architectures
Date: Wed, 14 Mar 2018 15:53:07 +0100
Message-Id: <20180314145317.2128199-1-arnd@arndb.de>
X-Mailer: git-send-email 2.9.0
In-Reply-To: <20180314143529.1456168-1-arnd@arndb.de>
References: <20180314143529.1456168-1-arnd@arndb.de>
X-Provags-ID: V03:K0:8XY9qwRq+7ibZRYz5tpUixibWhRQT8kseTc9jIUalIT1JtnmeAT
 NDeAQuhqR76lI/adBniQ11jIZ/ZIOoYsS6/H8KC6/WfNWJ3CzEXAgOfmXc8fRVexxVF1LVn
 1NYNVVeT/wzNXg+BTugC/9IFYXzcULGeL9pYxYM07onBVpOlCAJrdRCUuMdXczhS1gT9LFd
 eOh5hJ1fbwz53e7GJWBgw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:/V/cTAhrwdw=:X2HHCsxbBwRPtn9tgcyla3
 A7aC5imLkajdRoXF3XSQ15PYZem9kg7QoXnImGLZi8NwVDRA6gDnguk4qXPS5NfReUoND4MTt
 ajU7R6tXgFtOn2guMCxOv41KL7z+XBw41UCicCqWPQK7mm72I8lYpgzkpsjgS1CVzS11ETCBU
 i0trcjlybJ2KkSHMj3Vw1DChUFfz8SQ2uw5UfLXKbXGXMtnIYuHLrQhboSlxc1PtH6sLcB5Ja
 Loj0/Rd//bjFeEFpkyPsXMPHUP29izTBxFBKw+/z7CHU0xknxaXGUJDQEDM5jZR0+t8GM5hR1
 xbnSQBns5o0zFlhnht8fqZY0sxAid5OSrum85dJ7uUpVzYqOfQllbFAuv6blN9Ahy2Yuq+0px
 QI4zi9x3CLtD/Tsu7mLW6wwxCKeSDbJQ3xTiSIOA7+ESNJ5kUw0o81KQV8/q7WwKzZTX5jxXg
 10KRTGER3hvu4loKM7zWu62CyMXPaCXCCYgysovxEx+ZN2S5KbMT0OWqpQbMQJJKqUU/KyPV4
 lf+7vXpSTROgR70xVlTU65Lb0qSVK6y+BjjpzhppxJmoWozOu49HuG+JuKRlr5FYaDwJvDJw3
 s+TcYhyjxjHnhMX3DnwYQ83GaLhvI7c9GCbqQkk1xEK6HXmhf4uw9l1tNP+xGWG6eEXxeVfCF
 ry8zVQ/08Jj9o3nB2JfQ+rvVBX3dcZDabNvl2syxqGGWNb/XBxB2kgK2xOK3QpnzU+4nWdYHi
 MTXmMSD4fvZ5ghbq2Q+6xsIU5XRx/1vLUQuB7A==
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A number of architectures are being removed from the kernel, so
we no longer need to test them.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 tools/testing/ktest/examples/crosstests.conf | 31 +---------------------------
 1 file changed, 1 insertion(+), 30 deletions(-)

diff --git a/tools/testing/ktest/examples/crosstests.conf b/tools/testing/ktest/examples/crosstests.conf
index a1203148dfa1..6907f32590b2 100644
--- a/tools/testing/ktest/examples/crosstests.conf
+++ b/tools/testing/ktest/examples/crosstests.conf
@@ -59,7 +59,7 @@ DO_DEFAULT := 1
 
 # By setting both DO_FAILED and DO_DEFAULT to zero, you can pick a single
 # arch that you want to test. (uncomment RUN and chose your arch)
-#RUN := m32r
+#RUN := arm
 
 # At the bottom of the config file exists a bisect test. You can update that
 # test and set DO_FAILED and DO_DEFAULT to zero, and uncomment this variable
@@ -106,33 +106,11 @@ TEST_START IF ${RUN} == arm || ${DO_DEFAULT}
 CROSS = arm-unknown-linux-gnueabi
 ARCH = arm
 
-# black fin
-TEST_START IF ${RUN} == bfin || ${DO_DEFAULT}
-CROSS = bfin-uclinux
-ARCH = blackfin
-BUILD_OPTIONS = -j8 vmlinux
-
-# cris - FAILS?
-TEST_START IF ${RUN} == cris || ${RUN} == cris64 || ${DO_FAILED}
-CROSS = cris-linux
-ARCH = cris
-
-# cris32 - not right arch?
-TEST_START IF ${RUN} == cris || ${RUN} == cris32 || ${DO_FAILED}
-CROSS = crisv32-linux
-ARCH = cris
-
 # ia64
 TEST_START IF ${RUN} == ia64 || ${DO_DEFAULT}
 CROSS = ia64-linux
 ARCH = ia64
 
-# frv
-TEST_START IF ${RUN} == frv || ${DO_FAILED}
-CROSS = frv-linux
-ARCH = frv
-GCC_VER = 4.5.1
-
 # m68k fails with error?
 TEST_START IF ${RUN} == m68k || ${DO_DEFAULT}
 CROSS = m68k-linux
@@ -148,13 +126,6 @@ TEST_START IF ${RUN} == mips || ${RUN} == mips32 || ${DO_DEFAULT}
 CROSS = mips-linux
 ARCH = mips
 
-# m32r
-TEST_START IF ${RUN} == m32r || ${DO_FAILED}
-CROSS = m32r-linux
-ARCH = m32r
-GCC_VER = 4.5.1
-BUILD_OPTIONS = -j8 vmlinux
-
 # parisc64 failed?
 TEST_START IF ${RUN} == hppa || ${RUN} == hppa64 || ${DO_FAILED}
 CROSS = hppa64-linux
-- 
2.9.0
