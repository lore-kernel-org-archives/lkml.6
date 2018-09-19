Return-Path: <SRS0=r9ZY=MB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 104CDC433F4
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 20:51:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A4ED52157F
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 20:51:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b="dLBybjOQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A4ED52157F
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=arista.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733094AbeITCao (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Sep 2018 22:30:44 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:42328 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733061AbeITCao (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Sep 2018 22:30:44 -0400
Received: by mail-ed1-f66.google.com with SMTP id l5so6024559edw.9
        for <linux-kernel@vger.kernel.org>; Wed, 19 Sep 2018 13:51:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=googlenew;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=XVsAEZIAO24DX407WQOdaal6kpoSXlvVRNC6hFkL3KI=;
        b=dLBybjOQ2St8/sLtE6mQW0nimZOW6w45TrEptBVwfRNNPe4H0hT4aekPpMNnlr3b1l
         Sxf6GzFuqSebldwVwtSVPy5jwjNIS/ChTvBMae1RKJtWs+POuaZZtXoD9SDOOvbqtE+W
         NxSkFdBmZ6bQYazhq72PuxsQiLFPaqhJeYVXu++xKnQkMCH3BIKdL94LHvVPfuHNeeQN
         LI9IOMKvt4g0OWpCDHDOg43C8z8GfRuoY+q4x6OMjQQj4ekhYkJ1FaU8sv4K5Ore+pWa
         DNfly+TiABtbeEt7V6MXvi4MxS66/lkObAxTsQsmHG5lDCRP4NJLbmpMzRkptzhPRc9q
         oZ5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=XVsAEZIAO24DX407WQOdaal6kpoSXlvVRNC6hFkL3KI=;
        b=eK9G2M/IUke3mKAM7Q1wLXq9i7XpBnTgo39nVGiDLNpkBigYEQXqJfzSd9DWXuhbOk
         MMBymAw3zS561hcq6gqagRkxvvvMlaAAH5epeekuxZPIQCAyZ6sNNXb9cnVOzmak8C9G
         0HZrfw6P/JqoqBrqeOGEQPyU5A0t/PNL+D9YTH0JFwpPPv+1+zddmETbcbDQJXGaHcMr
         5amJLai4ihmpBe8hVUhdSJIGR3Sz8sT3ZKG2+Sruv6xfzLcLEifd6rjNHqyPXqCT2Y10
         4TJ7Ow6bQlNDvu0b1EJcP+J/LXIKmOxjWBb+RmwJZiUYce8acLIS3Wami7pZQXIBVg2E
         nnwA==
X-Gm-Message-State: APzg51DMccFLKs0enyOQon74S69zPw8w+aPXFEL8jTmR0UNO0FaW2QH1
        0ymgETiOKDF6VrGyxUZ2F7NLUKJSGdw=
X-Google-Smtp-Source: ANB0VdZCHV6xPQTA0kvuyZrVJ9uJSCa1/fsm3I5rMtT5YInVorVoVHMRwDiXAmQ7iKd7cQAN/Pz/Zw==
X-Received: by 2002:a50:afa3:: with SMTP id h32-v6mr60771252edd.129.1537390263117;
        Wed, 19 Sep 2018 13:51:03 -0700 (PDT)
Received: from dhcp.ire.aristanetworks.com ([217.173.96.166])
        by smtp.gmail.com with ESMTPSA id t17-v6sm1747729edb.27.2018.09.19.13.51.01
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 19 Sep 2018 13:51:02 -0700 (PDT)
From:   Dmitry Safonov <dima@arista.com>
To:     linux-kernel@vger.kernel.org
Cc:     Dmitry Safonov <0x7f454c46@gmail.com>,
        Dmitry Safonov <dima@arista.com>,
        Adrian Reber <adrian@lisas.de>,
        Andrei Vagin <avagin@openvz.org>,
        Andy Lutomirski <luto@kernel.org>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Cyrill Gorcunov <gorcunov@openvz.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>,
        Jeff Dike <jdike@addtoit.com>, Oleg Nesterov <oleg@redhat.com>,
        Pavel Emelyanov <xemul@virtuozzo.com>,
        Shuah Khan <shuah@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        containers@lists.linux-foundation.org, criu@openvz.org,
        linux-api@vger.kernel.org, x86@kernel.org,
        linux-kselftest@vger.kernel.org
Subject: [RFC 16/20] selftest: Add Time Namespace test for supported clocks
Date:   Wed, 19 Sep 2018 21:50:33 +0100
Message-Id: <20180919205037.9574-17-dima@arista.com>
X-Mailer: git-send-email 2.13.6
In-Reply-To: <20180919205037.9574-1-dima@arista.com>
References: <20180919205037.9574-1-dima@arista.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This test checks that all supported clocks can be changed by
clock_settime.

Cc: linux-kselftest@vger.kernel.org
Signed-off-by: Andrei Vagin <avagin@openvz.org>
Co-developed-by: Andrei Vagin <avagin@openvz.org>
Signed-off-by: Dmitry Safonov <dima@arista.com>
---
 tools/testing/selftests/timens/.gitignore |   1 +
 tools/testing/selftests/timens/Makefile   |   5 +
 tools/testing/selftests/timens/config     |   1 +
 tools/testing/selftests/timens/log.h      |  21 ++++
 tools/testing/selftests/timens/timens.c   | 196 ++++++++++++++++++++++++++++++
 5 files changed, 224 insertions(+)
 create mode 100644 tools/testing/selftests/timens/.gitignore
 create mode 100644 tools/testing/selftests/timens/Makefile
 create mode 100644 tools/testing/selftests/timens/config
 create mode 100644 tools/testing/selftests/timens/log.h
 create mode 100644 tools/testing/selftests/timens/timens.c

diff --git a/tools/testing/selftests/timens/.gitignore b/tools/testing/selftests/timens/.gitignore
new file mode 100644
index 000000000000..27a693229ce1
--- /dev/null
+++ b/tools/testing/selftests/timens/.gitignore
@@ -0,0 +1 @@
+timens
diff --git a/tools/testing/selftests/timens/Makefile b/tools/testing/selftests/timens/Makefile
new file mode 100644
index 000000000000..b877efb78974
--- /dev/null
+++ b/tools/testing/selftests/timens/Makefile
@@ -0,0 +1,5 @@
+TEST_GEN_PROGS := timens
+
+CFLAGS := -Wall -Werror
+
+include ../lib.mk
diff --git a/tools/testing/selftests/timens/config b/tools/testing/selftests/timens/config
new file mode 100644
index 000000000000..4480620f6f49
--- /dev/null
+++ b/tools/testing/selftests/timens/config
@@ -0,0 +1 @@
+CONFIG_TIME_NS=y
diff --git a/tools/testing/selftests/timens/log.h b/tools/testing/selftests/timens/log.h
new file mode 100644
index 000000000000..05fec7f97870
--- /dev/null
+++ b/tools/testing/selftests/timens/log.h
@@ -0,0 +1,21 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+
+#ifndef __SELFTEST_TIMENS_LOG_H__
+#define __SELFTEST_TIMENS_LOG_H__
+
+#define pr_msg(fmt, lvl, ...)						\
+	fprintf(stderr, "[%s] (%s:%d)\t" fmt "\n",			\
+			lvl, __FILE__, __LINE__, ##__VA_ARGS__)
+
+#define pr_p(func, fmt, ...)	func(fmt ": %m", ##__VA_ARGS__)
+
+#define pr_err(fmt, ...)						\
+	({								\
+		pr_msg(fmt, "ERR", ##__VA_ARGS__)			\
+		-1;							\
+	})
+#define pr_fail(fmt, ...)	pr_msg(fmt, "FAIL", ##__VA_ARGS__)
+
+#define pr_perror(fmt, ...)	pr_p(pr_err, fmt, ##__VA_ARGS__)
+
+#endif
diff --git a/tools/testing/selftests/timens/timens.c b/tools/testing/selftests/timens/timens.c
new file mode 100644
index 000000000000..dfa6701214b1
--- /dev/null
+++ b/tools/testing/selftests/timens/timens.c
@@ -0,0 +1,196 @@
+// SPDX-License-Identifier: GPL-2.0
+#define _GNU_SOURCE
+#include <errno.h>
+#include <fcntl.h>
+#include <sched.h>
+#include <stdio.h>
+#include <stdbool.h>
+#include <sys/stat.h>
+#include <sys/syscall.h>
+#include <sys/types.h>
+#include <time.h>
+#include <unistd.h>
+#include <time.h>
+
+#include "log.h"
+
+#ifndef CLONE_NEWTIME
+# define CLONE_NEWTIME	0x00001000
+#endif
+
+/*
+ * Test shouldn't be run for a day, so add 10 days to child
+ * time and check parent's time to be in the same day.
+ */
+#define DAY_IN_SEC			(60*60*24)
+#define TEN_DAYS_IN_SEC			(10*DAY_IN_SEC)
+
+#define ARRAY_SIZE(arr) (sizeof(arr) / sizeof((arr)[0]))
+
+#define CLOCK_TYPES							\
+	ct(CLOCK_BOOTTIME),						\
+	ct(CLOCK_MONOTONIC),						\
+	ct(CLOCK_MONOTONIC_COARSE),					\
+	ct(CLOCK_MONOTONIC_RAW),					\
+
+
+#define ct(clock)	clock
+static clockid_t clocks[] = {
+	CLOCK_TYPES
+};
+#undef ct
+#define ct(clock)	#clock
+static char *clock_names[] = {
+	CLOCK_TYPES
+};
+
+static int child_ns, parent_ns;
+
+static int switch_ns(int fd)
+{
+	if (setns(fd, CLONE_NEWTIME)) {
+		pr_perror("setns()");
+		return -1;
+	}
+
+	return 0;
+}
+
+static int init_namespaces(void)
+{
+	char path[] = "/proc/self/ns/time";
+	struct stat st1, st2;
+
+	parent_ns = open(path, O_RDONLY);
+	if (parent_ns <= 0)
+		return pr_perror("Unable to open %s", path);
+
+	if (fstat(parent_ns, &st1))
+		return pr_perror("Unable to stat the parent timens");
+
+	if (unshare(CLONE_NEWTIME))
+		return pr_perror("Can't unshare() timens");
+
+	child_ns = open(path, O_RDONLY);
+	if (child_ns <= 0)
+		return pr_perror("Unable to open %s", path);
+
+	if (fstat(child_ns, &st2))
+		return pr_perror("Unable to stat the timens");
+
+	if (st1.st_ino == st2.st_ino)
+		return pr_perror("The same child_ns after CLONE_NEWTIME");
+
+	return 0;
+}
+
+static int _gettime(clockid_t clk_id, struct timespec *res, bool raw_syscall)
+{
+	int err;
+
+	if (!raw_syscall) {
+		if (clock_gettime(clk_id, res)) {
+			pr_perror("clock_gettime(%d)", (int)clk_id);
+			return -1;
+		}
+		return 0;
+	}
+
+	err = syscall(SYS_clock_gettime, clk_id, res);
+	if (err)
+		pr_perror("syscall(SYS_clock_gettime(%d))", (int)clk_id);
+
+	return err;
+}
+
+static int _settime(clockid_t clk_id, struct timespec *res, bool raw_syscall)
+{
+	int err;
+
+	if (!raw_syscall) {
+		if (clock_settime(clk_id, res))
+			return pr_perror("clock_settime(%d)", (int)clk_id);
+		return 0;
+	}
+
+	err = syscall(SYS_clock_settime, clk_id, res);
+	if (err)
+		pr_perror("syscall(SYS_clock_settime(%d))", (int)clk_id);
+
+	return err;
+}
+
+static int test_gettime(clockid_t clock_index, bool raw_syscall, time_t offset)
+{
+	struct timespec child_ts_new, parent_ts_old, cur_ts;
+	char *entry = raw_syscall ? "syscall" : "vdso";
+	double precision = 0.0;
+
+	switch (clocks[clock_index]) {
+	case CLOCK_MONOTONIC_COARSE:
+	case CLOCK_MONOTONIC_RAW:
+		precision = -2.0;
+		break;
+	}
+
+	if (switch_ns(parent_ns))
+		return pr_err("switch_ns(%d)", child_ns);
+
+	if (_gettime(clocks[clock_index], &parent_ts_old, raw_syscall))
+		return -1;
+
+	if (switch_ns(child_ns))
+		return pr_err("switch_ns(%d)", child_ns);
+
+	child_ts_new.tv_nsec = parent_ts_old.tv_nsec;
+	child_ts_new.tv_sec = parent_ts_old.tv_sec + offset;
+
+	if (_settime(clocks[clock_index], &child_ts_new, raw_syscall))
+		return -1;
+
+	if (_gettime(clocks[clock_index], &cur_ts, raw_syscall))
+		return -1;
+
+	if (difftime(cur_ts.tv_sec, child_ts_new.tv_sec) < precision) {
+		pr_fail("Child's %s (%s) time has not changed: %lu -> %lu [%lu]",
+			clock_names[clock_index], entry, parent_ts_old.tv_sec,
+			child_ts_new.tv_sec, cur_ts.tv_sec);
+		return -1;
+	}
+
+	if (switch_ns(parent_ns))
+		return pr_err("switch_ns(%d)", parent_ns);
+
+	if (_gettime(clocks[clock_index], &cur_ts, raw_syscall))
+		return -1;
+
+	if (difftime(cur_ts.tv_sec, parent_ts_old.tv_sec) > DAY_IN_SEC) {
+		pr_fail("Parent's %s (%s) time has changed: %lu -> %lu [%lu]",
+			clock_names[clock_index], entry, parent_ts_old.tv_sec,
+			child_ts_new.tv_sec, cur_ts.tv_sec);
+		/* Let's play nice and put it closer to original */
+		clock_settime(clocks[clock_index], &cur_ts);
+		return -1;
+	}
+
+	pr_msg("Passed for %s (%s)", "OK", clock_names[clock_index], entry);
+	return 0;
+}
+
+int main(int argc, char *argv[])
+{
+	unsigned int i;
+	int ret = 0;
+
+	if (init_namespaces())
+		return 1;
+
+	for (i = 0; i < ARRAY_SIZE(clocks); i++) {
+		ret |= test_gettime(i, true, TEN_DAYS_IN_SEC);
+		ret |= test_gettime(i, true, -TEN_DAYS_IN_SEC);
+		ret |= test_gettime(i, false, TEN_DAYS_IN_SEC);
+		ret |= test_gettime(i, false, -TEN_DAYS_IN_SEC);
+	}
+
+	return !!ret;
+}
-- 
2.13.6

