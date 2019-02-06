Return-Path: <SRS0=01Bl=QN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FD22C282CB
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 00:12:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DF34A2175B
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 00:12:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b="fFrBudei"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729642AbfBFALx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Feb 2019 19:11:53 -0500
Received: from mail-ed1-f66.google.com ([209.85.208.66]:33872 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729393AbfBFALq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Feb 2019 19:11:46 -0500
Received: by mail-ed1-f66.google.com with SMTP id b3so4515581ede.1
        for <linux-kernel@vger.kernel.org>; Tue, 05 Feb 2019 16:11:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=googlenew;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Fl8AOsvztsHa751NXA7/6V+IVjg1Wd0DoDDENkF65DM=;
        b=fFrBudeiT+jYMw7NT1bddLBFNxD1uUVxy0dHM2b13Pt7BqCV6ZyH8uwF6bDE0V1qNc
         G3dgSpfZifmN4hAKugcRerszgT4P5xC6+ZT+RSb1LTgzTBDztBfCtlr19uSPoM+cfH5Y
         82jf66qwpqXN/y0BAYjLiuSUd8xOByOdLjWvFZ3Krj4v/yta68hmvsOenYuisotR5Txg
         i9BZLA62Jjvrmb8NALafTwCw5MipWIxrzj2rjP+PoeySn0dmDTlB9kR65yydtVXX95wK
         3yB6zgufwQc36Wg3UwUNoEPga4ADi/pqAFWf5lodKjgZZwS0DZa6h3FvQVWadnEAYNLp
         Q8nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Fl8AOsvztsHa751NXA7/6V+IVjg1Wd0DoDDENkF65DM=;
        b=eHplgKje2TgfebmLBlXJO1pB0qXopPTHUDH1OHKPKVM1uTnJngd1GMqmXa5MswMLvg
         j02ArAxTDp9/5IKrEfSJfo3ghzd51g8ZkuCfSAW3YT9VQii89hZybhL4uJOsqcjTOKlR
         /H0t3ElhrDfQj+7tJncGEYNzAE73ZqaIM/2xlej9XvO5+NBmU25TmsKzPhqBqrbB/fcI
         ZP56qpLQw+Hc7EJBrrZIIOvZx/mPA1T9Wn5OG0Fwu2I9eMlxYO9nR2Kx4IpIFZQjDzwM
         quCiAFNkDRx0afT06+dvQpsqqxrx9kNjMWu2mVbuBP6EYXMr2aZLx0hnx+D5NophhKz4
         THRQ==
X-Gm-Message-State: AHQUAuaujA9eimf4uZBb37Uzh91Qm9832b9SI1Dq/zg1K/Uk30qVOy8V
        L7+uqYuJ/nsBOU0PrZtO3x8txAOuBNY=
X-Google-Smtp-Source: AHgI3Ia4Ee1bzYLxFL0h1g4mfqWE4SgJfAIHrc8biv0IDplo5lfzOvVYgu3FO3xaqKlu89YgrWvNIg==
X-Received: by 2002:a50:b5c6:: with SMTP id a64mr6071277ede.112.1549411904434;
        Tue, 05 Feb 2019 16:11:44 -0800 (PST)
Received: from Mindolluin.ire.aristanetworks.com ([217.173.96.166])
        by smtp.gmail.com with ESMTPSA id p30sm5489594eda.68.2019.02.05.16.11.43
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 05 Feb 2019 16:11:43 -0800 (PST)
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
Subject: [PATCH 26/32] selftest/timens: Add a test for clock_nanosleep()
Date:   Wed,  6 Feb 2019 00:11:00 +0000
Message-Id: <20190206001107.16488-27-dima@arista.com>
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

Check that clock_nanosleep() takes into account clock offsets.

Signed-off-by: Andrei Vagin <avagin@gmail.com>
Signed-off-by: Dmitry Safonov <dima@arista.com>
---
 tools/testing/selftests/timens/.gitignore     |  1 +
 tools/testing/selftests/timens/Makefile       |  2 +-
 .../selftests/timens/clock_nanosleep.c        | 99 +++++++++++++++++++
 3 files changed, 101 insertions(+), 1 deletion(-)
 create mode 100644 tools/testing/selftests/timens/clock_nanosleep.c

diff --git a/tools/testing/selftests/timens/.gitignore b/tools/testing/selftests/timens/.gitignore
index b609f6ee9fb9..9b6c8ddac2c8 100644
--- a/tools/testing/selftests/timens/.gitignore
+++ b/tools/testing/selftests/timens/.gitignore
@@ -1,2 +1,3 @@
+clock_nanosleep
 timens
 timerfd
diff --git a/tools/testing/selftests/timens/Makefile b/tools/testing/selftests/timens/Makefile
index 66b90cd28e5c..76a1dc891184 100644
--- a/tools/testing/selftests/timens/Makefile
+++ b/tools/testing/selftests/timens/Makefile
@@ -1,4 +1,4 @@
-TEST_GEN_PROGS := timens timerfd
+TEST_GEN_PROGS := timens timerfd clock_nanosleep
 
 CFLAGS := -Wall -Werror
 
diff --git a/tools/testing/selftests/timens/clock_nanosleep.c b/tools/testing/selftests/timens/clock_nanosleep.c
new file mode 100644
index 000000000000..9a1689e5a0e1
--- /dev/null
+++ b/tools/testing/selftests/timens/clock_nanosleep.c
@@ -0,0 +1,99 @@
+// SPDX-License-Identifier: GPL-2.0
+#define _GNU_SOURCE
+#include <sched.h>
+
+#include <sys/timerfd.h>
+#include <sys/syscall.h>
+#include <time.h>
+#include <unistd.h>
+#include <stdlib.h>
+#include <stdio.h>
+#include <stdint.h>
+
+#include "log.h"
+#include "timens.h"
+
+static long long get_elapsed_time(int clockid, struct timespec *start)
+{
+	struct timespec curr;
+	long long secs, nsecs;
+
+	if (clock_gettime(clockid, &curr) == -1)
+		return pr_perror("clock_gettime");
+
+	secs = curr.tv_sec - start->tv_sec;
+	nsecs = curr.tv_nsec - start->tv_nsec;
+	if (nsecs < 0) {
+		secs--;
+		nsecs += 1000000000;
+	}
+	if (nsecs > 1000000000) {
+		secs++;
+		nsecs -= 1000000000;
+	}
+	return secs * 1000 + nsecs / 1000000;
+}
+
+int run_test(int clockid)
+{
+	long long elapsed;
+	int i;
+
+	for (i = 0; i < 2; i++) {
+		struct timespec now = {};
+		struct timespec start;
+
+		if (clock_gettime(clockid, &start) == -1)
+			return pr_perror("clock_gettime");
+
+
+		if (i == 1) {
+			now.tv_sec = start.tv_sec;
+			now.tv_nsec = start.tv_nsec;
+		}
+
+		now.tv_sec += 2;
+		clock_nanosleep(clockid, i ? TIMER_ABSTIME : 0, &now, NULL);
+
+		elapsed = get_elapsed_time(clockid, &start);
+		if (elapsed < 1900 || elapsed > 2100) {
+			pr_fail("clockid: %d abs: %d elapsed: %lld\n",
+				clockid, i, elapsed);
+			return 1;
+		}
+		ksft_test_result_pass("clockid: %d abs:%d\n", clockid, i);
+	}
+
+	return 0;
+}
+
+int main(int argc, char *argv[])
+{
+	int ret, nsfd;
+
+	nscheck();
+
+	if (unshare(CLONE_NEWTIME))
+		return pr_perror("unshare");
+
+	if (_settime(CLOCK_MONOTONIC, 7 * 24 * 3600))
+		return 1;
+	if (_settime(CLOCK_BOOTTIME, 9 * 24 * 3600))
+		return 1;
+
+	nsfd = open("/proc/self/ns/time_for_children", O_RDONLY);
+	if (nsfd < 0)
+		return pr_perror("Unable to open timens_for_children");
+
+	if (setns(nsfd, CLONE_NEWTIME))
+		return pr_perror("Unable to set timens");
+
+	ret = 0;
+	ret |= run_test(CLOCK_MONOTONIC);
+
+	if (ret)
+		ksft_exit_fail();
+	ksft_exit_pass();
+	return ret;
+}
+
-- 
2.20.1

