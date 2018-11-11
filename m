Return-Path: <SRS0=p8q0=NW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A2C5C43441
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 20:31:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3940420818
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 20:31:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3940420818
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730791AbeKLGU3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 01:20:29 -0500
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:50412 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730408AbeKLFsU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 00:48:20 -0500
Received: from [192.168.4.242] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ben@decadent.org.uk>)
        id 1gLvsf-0000lG-F4; Sun, 11 Nov 2018 19:58:49 +0000
Received: from ben by deadeye with local (Exim 4.91)
        (envelope-from <ben@decadent.org.uk>)
        id 1gLvsa-0001sn-Jm; Sun, 11 Nov 2018 19:58:44 +0000
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org, "Wang Nan" <wangnan0@huawei.com>,
        "Adrian Hunter" <adrian.hunter@intel.com>,
        "Jiri Olsa" <jolsa@kernel.org>,
        "Arnaldo Carvalho de Melo" <acme@redhat.com>,
        "David Ahern" <dsahern@gmail.com>,
        "Namhyung Kim" <namhyung@kernel.org>
Date:   Sun, 11 Nov 2018 19:49:05 +0000
Message-ID: <lsq.1541965745.439242661@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 352/366] perf tools: Move syscall number fallbacks
 from perf-sys.h to tools/arch/x86/include/asm/
In-Reply-To: <lsq.1541965744.387173642@decadent.org.uk>
X-SA-Exim-Connect-IP: 192.168.4.242
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.16.61-rc1 review patch.  If anyone has any objections, please let me know.

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
[bwh: Backported to 3.16:
 - Also remove the deleted headers from LIB_H in Makefile.perf
 - Adjust context]
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
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
@@ -252,6 +252,7 @@ CFLAGS += -I$(src-perf)/arch/$(ARCH)/inc
 CFLAGS += -I$(srctree)/tools/include/
 CFLAGS += -I$(srctree)/arch/$(ARCH)/include/uapi
 CFLAGS += -I$(srctree)/arch/$(ARCH)/include
+CFLAGS += -I$(srctree)/tools/arch/$(ARCH)/include
 CFLAGS += -I$(srctree)/include/uapi
 CFLAGS += -I$(srctree)/include
 
--- a/tools/perf/perf-sys.h
+++ b/tools/perf/perf-sys.h
@@ -14,15 +14,6 @@
 #define rmb()		asm volatile("lock; addl $0,0(%%esp)" ::: "memory")
 #define cpu_relax()	asm volatile("rep; nop" ::: "memory");
 #define CPUINFO_PROC	"model name"
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
@@ -31,15 +22,6 @@
 #define rmb()		asm volatile("lfence" ::: "memory")
 #define cpu_relax()	asm volatile("rep; nop" ::: "memory");
 #define CPUINFO_PROC	"model name"
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
--- a/tools/perf/Makefile.perf
+++ b/tools/perf/Makefile.perf
@@ -239,8 +239,6 @@ LIB_H += util/include/asm/uaccess.h
 LIB_H += util/include/dwarf-regs.h
 LIB_H += util/include/asm/dwarf2.h
 LIB_H += util/include/asm/cpufeature.h
-LIB_H += util/include/asm/unistd_32.h
-LIB_H += util/include/asm/unistd_64.h
 LIB_H += perf.h
 LIB_H += util/annotate.h
 LIB_H += util/cache.h

