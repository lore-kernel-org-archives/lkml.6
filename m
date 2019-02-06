Return-Path: <SRS0=01Bl=QN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4981AC282CB
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 00:12:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0E351217F9
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 00:12:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b="Fa9Zaofz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726700AbfBFAMX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Feb 2019 19:12:23 -0500
Received: from mail-ed1-f65.google.com ([209.85.208.65]:40244 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729449AbfBFALt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Feb 2019 19:11:49 -0500
Received: by mail-ed1-f65.google.com with SMTP id g22so4471215edr.7
        for <linux-kernel@vger.kernel.org>; Tue, 05 Feb 2019 16:11:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=googlenew;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=K+VkMcFaa1biyDBhwzyqIBYBMVZNJxs5nnhJFjSl9OQ=;
        b=Fa9Zaofz9sU84BAhunNPcRRRmoq3wozR/WxOlNudfP7Uwchm7o/rJdKT2TE6iTzmum
         A2de+XjDqaKPkJjDtw8HdQkJEMApXqL/IF7QZu5at3EQwc97DsgmPXws704AcsDhnmEf
         taHzU+IABoUd2S4W1qGcL7AZZMLOgEISGdk0vicguWQz656/5SKHcl5LM0u12HDi+OFc
         zZjduy02ETi3j2WMxAjU7roSNIeQq/kbb/lZUEqUwbcmqTFQjnhLRxqm9juGFINSpqva
         L2xHa93otxACkJAh4IJAKTkinx5z39iLPI3rSo5qBHBXN04pB6SS0QzqKd8AjuvZPVKA
         HeIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=K+VkMcFaa1biyDBhwzyqIBYBMVZNJxs5nnhJFjSl9OQ=;
        b=AWOgkaW28Z78SjmSxbnSzjrbZVQuEXVtUmnCMwkGsIHY1Mb5J2P/It33VQ8Cqnqf/9
         PcrQ7XngXWJHqpjWwlUKGFqFJA5/8+3Dq3eAkQg1CV2atI64ksR5JpBO2yy4HWMnYWez
         GZ5smLwYPX7FP24XVcYh/4pRUu0/N/evs2fQ+cXtP0hrOrS8pOqPtUVJ5rToqeHbbbUf
         z3qUcHGsHe+Z+Mn4FArKa5r2AYjr2Dr5oCMnr1qIhTb98PrO/H9D7ll2h+PvRMfabW0c
         QO2m2Id2Oa+3XnwH7c/WM1JehpBNDVF2lrgjHLbILm5vG2wcpjGphwO4nlryNBVo6yx5
         FM/w==
X-Gm-Message-State: AHQUAuaylTazf29MpkNqM/H1zriHk2sf2SNaLcK/gz+kgHYd5hTML1oB
        A9Cw2DA0g02HCPoc6r0K6NXYvFrZM/Y=
X-Google-Smtp-Source: AHgI3IaFYzafF3SqZvS2FIv0RuVY5A1dRqZFp4CqSm3XEdhtCkv0I4gi00VFfVnblD+2Nb+AqS3IpQ==
X-Received: by 2002:a50:c20a:: with SMTP id n10mr6165504edf.60.1549411906992;
        Tue, 05 Feb 2019 16:11:46 -0800 (PST)
Received: from Mindolluin.ire.aristanetworks.com ([217.173.96.166])
        by smtp.gmail.com with ESMTPSA id p30sm5489594eda.68.2019.02.05.16.11.45
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 05 Feb 2019 16:11:46 -0800 (PST)
From:   Dmitry Safonov <dima@arista.com>
To:     linux-kernel@vger.kernel.org
Cc:     Andrei Vagin <avagin@openvz.org>, Dmitry Safonov <dima@arista.com>,
        Adrian Reber <adrian@lisas.de>,
        Andrei Vagin <avagin@gmail.com>,
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
Subject: [PATCH 28/32] selftest/timens: Add timer offsets test
Date:   Wed,  6 Feb 2019 00:11:02 +0000
Message-Id: <20190206001107.16488-29-dima@arista.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190206001107.16488-1-dima@arista.com>
References: <20190206001107.16488-1-dima@arista.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andrei Vagin <avagin@openvz.org>

Check that timer_create() takes into account clock offsets.

Signed-off-by: Andrei Vagin <avagin@gmail.com>
Signed-off-by: Dmitry Safonov <dima@arista.com>
---
 tools/testing/selftests/timens/.gitignore |   1 +
 tools/testing/selftests/timens/Makefile   |   3 +-
 tools/testing/selftests/timens/timer.c    | 115 ++++++++++++++++++++++
 3 files changed, 118 insertions(+), 1 deletion(-)
 create mode 100644 tools/testing/selftests/timens/timer.c

diff --git a/tools/testing/selftests/timens/.gitignore b/tools/testing/selftests/timens/.gitignore
index 94ffdd9cead7..3b7eda8f35ce 100644
--- a/tools/testing/selftests/timens/.gitignore
+++ b/tools/testing/selftests/timens/.gitignore
@@ -1,4 +1,5 @@
 clock_nanosleep
 procfs
 timens
+timer
 timerfd
diff --git a/tools/testing/selftests/timens/Makefile b/tools/testing/selftests/timens/Makefile
index f96f50d1fef8..ae1ffd24cc43 100644
--- a/tools/testing/selftests/timens/Makefile
+++ b/tools/testing/selftests/timens/Makefile
@@ -1,5 +1,6 @@
-TEST_GEN_PROGS := timens timerfd clock_nanosleep procfs
+TEST_GEN_PROGS := timens timerfd timer clock_nanosleep procfs
 
 CFLAGS := -Wall -Werror
+LDFLAGS := -lrt
 
 include ../lib.mk
diff --git a/tools/testing/selftests/timens/timer.c b/tools/testing/selftests/timens/timer.c
new file mode 100644
index 000000000000..aeb5623d25e4
--- /dev/null
+++ b/tools/testing/selftests/timens/timer.c
@@ -0,0 +1,115 @@
+// SPDX-License-Identifier: GPL-2.0
+#define _GNU_SOURCE
+#include <sched.h>
+
+#include <sys/syscall.h>
+#include <sys/types.h>
+#include <sys/wait.h>
+#include <time.h>
+#include <unistd.h>
+#include <stdlib.h>
+#include <stdio.h>
+#include <stdint.h>
+#include <signal.h>
+#include <time.h>
+
+#include "log.h"
+#include "timens.h"
+
+int run_test(int clockid, struct timespec now)
+{
+	struct itimerspec new_value;
+	long long elapsed;
+	timer_t fd;
+	int i;
+
+	for (i = 0; i < 2; i++) {
+		struct sigevent sevp = {.sigev_notify = SIGEV_NONE};
+		int flags = 0;
+
+		new_value.it_value.tv_sec = 3600;
+		new_value.it_value.tv_nsec = 0;
+		new_value.it_interval.tv_sec = 1;
+		new_value.it_interval.tv_nsec = 0;
+
+		if (i == 1) {
+			new_value.it_value.tv_sec += now.tv_sec;
+			new_value.it_value.tv_nsec += now.tv_nsec;
+		}
+
+		if (timer_create(clockid, &sevp, &fd) == -1)
+			return pr_perror("timerfd_create");
+
+		if (i == 1)
+			flags |= TIMER_ABSTIME;
+		if (timer_settime(fd, flags, &new_value, NULL) == -1)
+			return pr_perror("timerfd_settime");
+
+		if (timer_gettime(fd, &new_value) == -1)
+			return pr_perror("timerfd_gettime");
+
+		elapsed = new_value.it_value.tv_sec;
+		if (abs(elapsed - 3600) > 60) {
+			ksft_test_result_fail("clockid: %d elapsed: %lld\n",
+					      clockid, elapsed);
+			return 1;
+		}
+	}
+
+	ksft_test_result_pass("clockid=%d\n", clockid);
+
+	return 0;
+}
+
+int main(int argc, char *argv[])
+{
+	int ret, status, len, fd;
+	char buf[4096];
+	pid_t pid;
+	struct timespec btime_now, mtime_now;
+
+	nscheck();
+
+	clock_gettime(CLOCK_MONOTONIC, &mtime_now);
+	clock_gettime(CLOCK_BOOTTIME, &btime_now);
+
+	if (unshare(CLONE_NEWTIME))
+		return pr_perror("unshare");
+
+	len = snprintf(buf, sizeof(buf), "%d %d 0\n%d %d 0",
+			CLOCK_MONOTONIC, 70 * 24 * 3600,
+			CLOCK_BOOTTIME, 9 * 24 * 3600);
+	fd = open("/proc/self/timens_offsets", O_WRONLY);
+	if (fd < 0)
+		return pr_perror("/proc/self/timens_offsets");
+
+	if (write(fd, buf, len) != len)
+		return pr_perror("/proc/self/timens_offsets");
+
+	close(fd);
+	mtime_now.tv_sec += 70 * 24 * 3600;
+	btime_now.tv_sec += 9 * 24 * 3600;
+
+	pid = fork();
+	if (pid < 0)
+		return pr_perror("Unable to fork");
+	if (pid == 0) {
+		ret = 0;
+		ret |= run_test(CLOCK_BOOTTIME, btime_now);
+		ret |= run_test(CLOCK_MONOTONIC, mtime_now);
+
+		if (ret)
+			ksft_exit_fail();
+		ksft_exit_pass();
+		return ret;
+	}
+
+	if (waitpid(pid, &status, 0) != pid)
+		return pr_perror("Unable to wait the child process");
+
+	if (WIFEXITED(status))
+		return WEXITSTATUS(status);
+
+	return 1;
+}
+
-- 
2.20.1

