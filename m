Return-Path: <SRS0=35zj=KC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3FE8ECDFBB
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 15:02:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 69AAD2064D
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 15:02:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 69AAD2064D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731110AbeGRPke (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Jul 2018 11:40:34 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:38974 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726613AbeGRPkd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jul 2018 11:40:33 -0400
Received: from localhost (LFbn-1-12238-233.w90-92.abo.wanadoo.fr [90.92.53.233])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id EB14FC21;
        Wed, 18 Jul 2018 15:02:13 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Adrian Hunter <adrian.hunter@intel.com>,
        David Ahern <dsahern@gmail.com>, Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Wang Nan <wangnan0@huawei.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
Subject: [PATCH 4.4 3/3] perf tools: Move syscall number fallbacks from perf-sys.h to tools/arch/x86/include/asm/
Date:   Wed, 18 Jul 2018 17:02:00 +0200
Message-Id: <20180718145156.279116001@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180718145156.152413234@linuxfoundation.org>
References: <20180718145156.152413234@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Arnaldo Carvalho de Melo <acme@redhat.com>

commit cec07f53c398f22576df77052c4777dc13f14962 upstream.

And remove the empty tools/arch/x86/include/asm/unistd_{32,64}.h files
introduced by eae7a755ee81 ("perf tools, x86: Build perf on older
user-space as well").

This way we get closer to mirroring the kernel for cases where __NR_
can't be found for some include path/_GNU_SOURCE/whatever scenario.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: David Ahern <dsahern@gmail.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Wang Nan <wangnan0@huawei.com>
Link: http://lkml.kernel.org/n/tip-kpj6m3mbjw82kg6krk2z529e@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Cc: Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 tools/arch/x86/include/asm/unistd_32.h  |    9 +++++++++
 tools/arch/x86/include/asm/unistd_64.h  |    9 +++++++++
 tools/perf/config/Makefile              |    1 +
 tools/perf/perf-sys.h                   |   18 ------------------
 tools/perf/util/include/asm/unistd_32.h |    1 -
 tools/perf/util/include/asm/unistd_64.h |    1 -
 6 files changed, 19 insertions(+), 20 deletions(-)

--- /dev/null
+++ b/tools/arch/x86/include/asm/unistd_32.h
@@ -0,0 +1,9 @@
+#ifndef __NR_perf_event_open
+# define __NR_perf_event_open 336
+#endif
+#ifndef __NR_futex
+# define __NR_futex 240
+#endif
+#ifndef __NR_gettid
+# define __NR_gettid 224
+#endif
--- /dev/null
+++ b/tools/arch/x86/include/asm/unistd_64.h
@@ -0,0 +1,9 @@
+#ifndef __NR_perf_event_open
+# define __NR_perf_event_open 298
+#endif
+#ifndef __NR_futex
+# define __NR_futex 202
+#endif
+#ifndef __NR_gettid
+# define __NR_gettid 186
+#endif
--- a/tools/perf/config/Makefile
+++ b/tools/perf/config/Makefile
@@ -200,6 +200,7 @@ CFLAGS += -I$(src-perf)/arch/$(ARCH)/inc
 CFLAGS += -I$(srctree)/tools/include/
 CFLAGS += -I$(srctree)/arch/$(ARCH)/include/uapi
 CFLAGS += -I$(srctree)/arch/$(ARCH)/include
+CFLAGS += -I$(srctree)/tools/arch/$(ARCH)/include
 CFLAGS += -I$(srctree)/include/uapi
 CFLAGS += -I$(srctree)/include
 
--- a/tools/perf/perf-sys.h
+++ b/tools/perf/perf-sys.h
@@ -11,29 +11,11 @@
 #if defined(__i386__)
 #define cpu_relax()	asm volatile("rep; nop" ::: "memory");
 #define CPUINFO_PROC	{"model name"}
-#ifndef __NR_perf_event_open
-# define __NR_perf_event_open 336
-#endif
-#ifndef __NR_futex
-# define __NR_futex 240
-#endif
-#ifndef __NR_gettid
-# define __NR_gettid 224
-#endif
 #endif
 
 #if defined(__x86_64__)
 #define cpu_relax()	asm volatile("rep; nop" ::: "memory");
 #define CPUINFO_PROC	{"model name"}
-#ifndef __NR_perf_event_open
-# define __NR_perf_event_open 298
-#endif
-#ifndef __NR_futex
-# define __NR_futex 202
-#endif
-#ifndef __NR_gettid
-# define __NR_gettid 186
-#endif
 #endif
 
 #ifdef __powerpc__
--- a/tools/perf/util/include/asm/unistd_32.h
+++ /dev/null
@@ -1 +0,0 @@
-
--- a/tools/perf/util/include/asm/unistd_64.h
+++ /dev/null
@@ -1 +0,0 @@
-


