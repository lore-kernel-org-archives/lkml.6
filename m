Return-Path: <SRS0=01Bl=QN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCE26C282CB
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 00:11:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8D9062183E
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 00:11:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b="Nx3OJPKq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729700AbfBFALz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Feb 2019 19:11:55 -0500
Received: from mail-ed1-f65.google.com ([209.85.208.65]:36964 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729498AbfBFALu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Feb 2019 19:11:50 -0500
Received: by mail-ed1-f65.google.com with SMTP id h15so4480480edb.4
        for <linux-kernel@vger.kernel.org>; Tue, 05 Feb 2019 16:11:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=googlenew;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=y864ignTHXAZ4Cw9/Z8wdmVJElW5ggoP8Y5xizXA7FQ=;
        b=Nx3OJPKqDACUIKy0WpLDwAOLesOuJol8rRduBmyTcgrQi5G80mY/152sqsZWp/YbOA
         rdCI0mo5lChAwrqiMsWQXyVZZBavoWmjtKH/PY0++GvpjJygaZiokD8E12qcVkaYoco+
         UeGNDttfv6wfj31KVXCdEA0Vm4XXONLeRIuXsEZbHD0VXO1/c2jhWu1i8L/F2QmlR+wf
         0lF4V8GSyzeb4n/MxfnC+kd5QU93Y0M+eifEe49p6ar0GiKKSJZZBaOO54HJxMycI4yV
         Eeu1qYCak5ozqTusFviiquSWKa+QWxqct5+2AzWYytSdtwGjk6fVV+f3/TTiNUpYVBwp
         g0UA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=y864ignTHXAZ4Cw9/Z8wdmVJElW5ggoP8Y5xizXA7FQ=;
        b=RKiiy+pfRKkZo5WySf6enAFxc/aCX1Y75APPdlwsWFhLAe+17Gmok6MRp7Z38HYU87
         jKHlJkIZka0JDymTqtkZqT+0n5+BzZCYvJxZDWYJvuIt3gAog/oVnRADyG8s0lFBSrOF
         wcf3PLvV400f7guNJ59/c2Ot2m86pS6ckV49lzlr+M5kZLKTbaRea6HQH2mlDfIPB+Aq
         PRGvgfRBnRdBIcxi+53rfLFwJrNSD8PtTupPIWffuUkuWi9UkUxLq/p8GdmoT9AXSMGp
         YqagyP3bN4Iwo/HrVGohGR8W90jtwO6F4qzSdJ0Wq9TuoGlceLuY5jvMkOCt/WCZEk+Y
         7dHg==
X-Gm-Message-State: AHQUAuYpMm0o/12F++VLhiAcCe+hJ464oDl5H51mm61CxV7o/s92Yr9X
        it+O2OznYEyyTsz2mvriIufQxNyyAVw=
X-Google-Smtp-Source: AHgI3Ia+nHUmPCOlt0u+sAGTnTNlbsCdrRZWsvYSM+WIGVmgW/G7YuWO2HpBtlHV66CUS0xQPFjL/A==
X-Received: by 2002:aa7:d602:: with SMTP id c2mr5919710edr.203.1549411908384;
        Tue, 05 Feb 2019 16:11:48 -0800 (PST)
Received: from Mindolluin.ire.aristanetworks.com ([217.173.96.166])
        by smtp.gmail.com with ESMTPSA id p30sm5489594eda.68.2019.02.05.16.11.47
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 05 Feb 2019 16:11:47 -0800 (PST)
From:   Dmitry Safonov <dima@arista.com>
To:     linux-kernel@vger.kernel.org
Cc:     Andrei Vagin <avagin@gmail.com>, Dmitry Safonov <dima@arista.com>,
        Adrian Reber <adrian@lisas.de>,
        Andrei Vagin <avagin@openvz.org>,
        Andy Lutomirski <luto@kernel.org>,
        Andy Tucker <agtucker@google.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Cyrill Gorcunov <gorcunov@openvz.org>,
        Dmitry Safonov <0x7f454c46@gmail.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>,
        Jeff Dike <jdike@addtoit.com>, Oleg Nesterov <oleg@redhat.com>,
        Pavel Emelyanov <xemul@virtuozzo.com>,
        Shuah Khan <shuah@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        containers@lists.linux-foundation.org, criu@openvz.org,
        linux-api@vger.kernel.org, x86@kernel.org
Subject: [PATCH 29/32] selftests: Add a simple perf test for clock_gettime()
Date:   Wed,  6 Feb 2019 00:11:03 +0000
Message-Id: <20190206001107.16488-30-dima@arista.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190206001107.16488-1-dima@arista.com>
References: <20190206001107.16488-1-dima@arista.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andrei Vagin <avagin@gmail.com>

Signed-off-by: Andrei Vagin <avagin@gmail.com>
Signed-off-by: Dmitry Safonov <dima@arista.com>
---
 tools/testing/selftests/timens/.gitignore     |  1 +
 tools/testing/selftests/timens/Makefile       |  8 +-
 tools/testing/selftests/timens/gettime_perf.c | 74 +++++++++++++++++++
 .../selftests/timens/gettime_perf_cold.c      | 63 ++++++++++++++++
 4 files changed, 145 insertions(+), 1 deletion(-)
 create mode 100644 tools/testing/selftests/timens/gettime_perf.c
 create mode 100644 tools/testing/selftests/timens/gettime_perf_cold.c

diff --git a/tools/testing/selftests/timens/.gitignore b/tools/testing/selftests/timens/.gitignore
index 3b7eda8f35ce..6bb90fdb4519 100644
--- a/tools/testing/selftests/timens/.gitignore
+++ b/tools/testing/selftests/timens/.gitignore
@@ -1,4 +1,5 @@
 clock_nanosleep
+gettime_perf
 procfs
 timens
 timer
diff --git a/tools/testing/selftests/timens/Makefile b/tools/testing/selftests/timens/Makefile
index ae1ffd24cc43..ef65bf96b55c 100644
--- a/tools/testing/selftests/timens/Makefile
+++ b/tools/testing/selftests/timens/Makefile
@@ -1,4 +1,10 @@
-TEST_GEN_PROGS := timens timerfd timer clock_nanosleep procfs
+TEST_GEN_PROGS := timens timerfd timer clock_nanosleep procfs gettime_perf
+
+uname_M := $(shell uname -m 2>/dev/null || echo not)
+ARCH ?= $(shell echo $(uname_M) | sed -e s/i.86/i386/)
+ifeq ($(ARCH),x86_64)
+TEST_GEN_PROGS += gettime_perf_cold
+endif
 
 CFLAGS := -Wall -Werror
 LDFLAGS := -lrt
diff --git a/tools/testing/selftests/timens/gettime_perf.c b/tools/testing/selftests/timens/gettime_perf.c
new file mode 100644
index 000000000000..510d77a941d9
--- /dev/null
+++ b/tools/testing/selftests/timens/gettime_perf.c
@@ -0,0 +1,74 @@
+// SPDX-License-Identifier: GPL-2.0
+#define _GNU_SOURCE
+#include <sys/types.h>
+#include <sys/stat.h>
+#include <errno.h>
+#include <fcntl.h>
+#include <sched.h>
+#include <time.h>
+#include <stdio.h>
+#include <unistd.h>
+#include <sys/syscall.h>
+
+#include "log.h"
+#include "timens.h"
+
+//#define TEST_SYSCALL
+
+static void test(clock_t clockid, char *clockstr, bool in_ns)
+{
+	struct timespec tp, start;
+	long i = 0;
+	const int timeout = 3;
+
+#ifndef TEST_SYSCALL
+	clock_gettime(clockid, &start);
+#else
+	syscall(__NR_clock_gettime, clockid, &start);
+#endif
+	tp = start;
+	for (tp = start; start.tv_sec + timeout > tp.tv_sec ||
+			 (start.tv_sec + timeout == tp.tv_sec &&
+			  start.tv_nsec > tp.tv_nsec); i++) {
+#ifndef TEST_SYSCALL
+		clock_gettime(clockid, &tp);
+#else
+		syscall(__NR_clock_gettime, clockid, &tp);
+#endif
+	}
+
+	ksft_test_result_pass("%s:\tclock: %10s\tcycles:\t%10ld\n",
+			      in_ns ? "ns" : "host", clockstr, i);
+}
+
+int main(int argc, char *argv[])
+{
+	time_t offset = 10;
+	int nsfd;
+
+	test(CLOCK_MONOTONIC, "monotonic", false);
+	test(CLOCK_BOOTTIME, "boottime", false);
+
+	nscheck();
+
+	if (unshare(CLONE_NEWTIME))
+		return pr_perror("Can't unshare() timens");
+
+	nsfd = open("/proc/self/ns/time_for_children", O_RDONLY);
+	if (nsfd < 0)
+		return pr_perror("Can't open a time namespace");
+
+	if (_settime(CLOCK_MONOTONIC, offset))
+		return 1;
+	if (_settime(CLOCK_BOOTTIME, offset))
+		return 1;
+
+	if (setns(nsfd, CLONE_NEWTIME))
+		return pr_perror("setns");
+
+	test(CLOCK_MONOTONIC, "monotonic", true);
+	test(CLOCK_BOOTTIME, "boottime", true);
+
+	ksft_exit_pass();
+	return 0;
+}
diff --git a/tools/testing/selftests/timens/gettime_perf_cold.c b/tools/testing/selftests/timens/gettime_perf_cold.c
new file mode 100644
index 000000000000..f72db8a4c903
--- /dev/null
+++ b/tools/testing/selftests/timens/gettime_perf_cold.c
@@ -0,0 +1,63 @@
+// SPDX-License-Identifier: GPL-2.0
+#define _GNU_SOURCE
+#include <sys/types.h>
+#include <sys/stat.h>
+#include <errno.h>
+#include <fcntl.h>
+#include <sched.h>
+#include <time.h>
+#include <stdio.h>
+#include <unistd.h>
+#include <sys/syscall.h>
+#include <string.h>
+
+#include "log.h"
+#include "timens.h"
+
+static __inline__ unsigned long long rdtsc(void)
+{
+	unsigned hi, lo;
+
+	__asm__ __volatile__ ("rdtsc" : "=a"(lo), "=d"(hi));
+	return ((unsigned long long) lo) | (((unsigned long long)hi) << 32);
+}
+
+static void test(clock_t clockid, char *clockstr)
+{
+	struct timespec tp;
+	long long s, e;
+
+	s = rdtsc();
+	clock_gettime(clockid, &tp);
+	e = rdtsc();
+	printf("%lld\n", e - s);
+	return;
+}
+
+int main(int argc, char **argv)
+{
+	time_t offset = 10;
+	int nsfd;
+
+	if (argc == 1) {
+		test(CLOCK_MONOTONIC, "monotonic");
+		return 0;
+	}
+	nscheck();
+
+	if (unshare(CLONE_NEWTIME))
+		return pr_perror("Can't unshare() timens");
+
+	nsfd = open("/proc/self/ns/time_for_children", O_RDONLY);
+	if (nsfd < 0)
+		return pr_perror("Can't open a time namespace");
+
+	if (_settime(CLOCK_MONOTONIC, offset))
+		return 1;
+
+	if (setns(nsfd, CLONE_NEWTIME))
+		return pr_perror("setns");
+
+	test(CLOCK_MONOTONIC, "monotonic");
+	return 0;
+}
-- 
2.20.1

