Return-Path: <SRS0=r9ZY=MB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BA82ECE564
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 20:51:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D9A2B21528
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 20:51:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b="LAO4KzWR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D9A2B21528
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=arista.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733195AbeITCa6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Sep 2018 22:30:58 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:34131 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733152AbeITCau (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Sep 2018 22:30:50 -0400
Received: by mail-ed1-f66.google.com with SMTP id u1-v6so6053485eds.1
        for <linux-kernel@vger.kernel.org>; Wed, 19 Sep 2018 13:51:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=googlenew;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=6WS+ZgnYZgB9hS1UsjCp2BVypHFJoS2o6YaRbqPUoaw=;
        b=LAO4KzWRzjl8bjZRaVaTVBNLYet4WqJXSuEL4Lz1ys7IHx7bMLU6Ho+VQJUwgd8j2V
         gEsvgNSUrHBYEaDHcnmU43fIZL4GN/ey1c7BVkuyGYlPqfJqgDrIfG3aXooXgFzsxAHE
         gVCQZKohC3Us3I0j0rtqf7Q9+c92sOEIzy+ehP/yLhLla5XjbQbycSUsUjH2BvS2zfjv
         m9A37IHjYUJmjHrC4ul/Ssh3hy4JKj9upFmDEuKsset33DdqAViNUlmk+n2ecTE0DPFu
         x6gLJhcTvjweK97aUUBtbpE/Ub9+Yxj5c53WoGxBBKG+q+OZnD/Vwfk5/ojWNq/BoNJD
         XD7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=6WS+ZgnYZgB9hS1UsjCp2BVypHFJoS2o6YaRbqPUoaw=;
        b=EdBX+Ic3mu0XxuXSGdZCid3SP25405TZcHW0ALrvVK8EDTlPQUpeMyWJakWibginzi
         84Zaw1vYUWdzgOfOQdNYJ25EgXucCM2Iug0dVFT/M+oiJE5L800BRmLJQV4lHRAl4JGM
         +9+pseM1hwsihZPKuNMQyFBwd7Bw0gsg5v4LJQH0jfG3DEJZJW4Kt4ac4bCFDOTAjm6h
         wtdo9UClxCsFj5h6zISmANdL9m0N5ARwIqN1RWnehk8cRHqj8AgpPWaRHcHqefth7baG
         OkZHB8ZkBjq8ZGFO1RAU4oHlhDo8kIUVO2Cebyq4W9IaIbi378ypHCBky7OyT6y4dH5F
         u2gQ==
X-Gm-Message-State: APzg51BUxLqPSUb80zMsd5HA10yCtplGfZHkjv/imuc/ADMXkz0da9tL
        6H+mJEj8n2mBkCrBDZkkeymwpqvGtN0=
X-Google-Smtp-Source: ANB0VdaFODWpZFIKqe1QLhyn1jdD+jHxGzIuBcccyb7iVmcZHURRaVNX4CY/Ad6oMGH/h/K9SCBatw==
X-Received: by 2002:a50:b3c8:: with SMTP id t8-v6mr61010739edd.95.1537390269440;
        Wed, 19 Sep 2018 13:51:09 -0700 (PDT)
Received: from dhcp.ire.aristanetworks.com ([217.173.96.166])
        by smtp.gmail.com with ESMTPSA id t17-v6sm1747729edb.27.2018.09.19.13.51.08
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 19 Sep 2018 13:51:08 -0700 (PDT)
From:   Dmitry Safonov <dima@arista.com>
To:     linux-kernel@vger.kernel.org
Cc:     Dmitry Safonov <0x7f454c46@gmail.com>,
        Andrei Vagin <avagin@openvz.org>,
        Dmitry Safonov <dima@arista.com>,
        Adrian Reber <adrian@lisas.de>,
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
Subject: [RFC 20/20] timens/selftest: Add timer offsets test
Date:   Wed, 19 Sep 2018 21:50:37 +0100
Message-Id: <20180919205037.9574-21-dima@arista.com>
X-Mailer: git-send-email 2.13.6
In-Reply-To: <20180919205037.9574-1-dima@arista.com>
References: <20180919205037.9574-1-dima@arista.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andrei Vagin <avagin@openvz.org>

Check that timer_create takes into account clock offsets.

Cc: linux-kselftest@vger.kernel.org
Signed-off-by: Andrei Vagin <avagin@openvz.org>
Signed-off-by: Dmitry Safonov <dima@arista.com>
---
 tools/testing/selftests/timens/.gitignore |  1 +
 tools/testing/selftests/timens/Makefile   |  3 +-
 tools/testing/selftests/timens/timer.c    | 95 +++++++++++++++++++++++++++++++
 3 files changed, 98 insertions(+), 1 deletion(-)
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
index 000000000000..e3a0951aadc8
--- /dev/null
+++ b/tools/testing/selftests/timens/timer.c
@@ -0,0 +1,95 @@
+// SPDX-License-Identifier: GPL-2.0
+#define _GNU_SOURCE
+#include <sched.h>
+
+#include <sys/syscall.h>
+#include <time.h>
+#include <unistd.h>
+#include <stdlib.h>
+#include <stdio.h>
+#include <stdint.h>
+#include <signal.h>
+#include <time.h>
+
+#include "log.h"
+
+#ifndef CLONE_NEWTIME
+#define CLONE_NEWTIME   0x00001000	  /* New time namespace */
+#endif
+
+int run_test(int clockid)
+{
+	struct itimerspec new_value;
+	struct timespec now;
+	long long elapsed;
+	timer_t fd;
+	int i;
+
+	if (clock_gettime(clockid, &now) == -1)
+		return pr_perror("clock_gettime");
+
+	for (i = 0; i < 2; i++) {
+		struct sigevent sevp = {.sigev_notify = SIGEV_NONE};
+		int flags = 0;
+
+		pr_msg("timerfd_settime: %d", "INFO", clockid);
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
+			pr_fail("elapsed: %lld\n", elapsed);
+			return 1;
+		}
+	}
+
+	printf("PASS\n");
+
+	return 0;
+}
+
+int main(int argc, char *argv[])
+{
+	struct timespec tp;
+	int ret;
+
+	if (unshare(CLONE_NEWTIME))
+		return pr_perror("unshare");
+
+	if (clock_gettime(CLOCK_MONOTONIC, &tp))
+		return pr_perror("clock_gettime");
+	tp.tv_sec -= 70 * 24 * 3600;
+	if (clock_settime(CLOCK_MONOTONIC, &tp))
+		return pr_perror("clock_settime");
+
+	if (clock_gettime(CLOCK_BOOTTIME, &tp))
+		return pr_perror("clock_gettime");
+	tp.tv_sec -= 9 * 24 * 3600;
+	tp.tv_nsec = 0;
+	if (clock_settime(CLOCK_BOOTTIME, &tp))
+		return pr_perror("clock_settime");
+
+	ret = 0;
+	ret |= run_test(CLOCK_BOOTTIME);
+	ret |= run_test(CLOCK_MONOTONIC);
+	return ret;
+}
+
-- 
2.13.6

