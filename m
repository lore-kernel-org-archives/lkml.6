Return-Path: <SRS0=r9ZY=MB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1FB9ECE564
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 20:51:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5BCAB21528
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 20:51:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b="T+GbgY2r"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5BCAB21528
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=arista.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733131AbeITCas (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Sep 2018 22:30:48 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:34123 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732982AbeITCaq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Sep 2018 22:30:46 -0400
Received: by mail-ed1-f66.google.com with SMTP id u1-v6so6053330eds.1
        for <linux-kernel@vger.kernel.org>; Wed, 19 Sep 2018 13:51:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=googlenew;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=IWl+BsB9BfevdUY2WNa0fYCOuIWf1cvA+H9ptzwfKtc=;
        b=T+GbgY2rJRZcmW0Pnz/ocICcE6cmIe5Dqnz2XO4s+Jw0UfHOg0JDk/nl1QgrYgVgXe
         oxHjNWCWXlxJmFhRS+/nIKnJ9DSaYYMVuZgXXQo10koRWHP1cP8WKMjeAVn4VkXbh0Ak
         LDe/53p7rZaQB2LqWupbnfUrcm6lsQGMM0/W7kk/uIZGMMYHgqRfqc4qkFk/Fc80lnWP
         rjS+x40PDGYLawc1RFpCEw51WPeJaPAMcRPwVS9x4uUzn0zThrorWhmTFYGaHJeksEU/
         uqF+yOzNLsm9Vj7XuYcvAeX+UgY9l9j7/fxmdai6mfeuwBj3wcTYwF612L82VVJegur9
         +g7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=IWl+BsB9BfevdUY2WNa0fYCOuIWf1cvA+H9ptzwfKtc=;
        b=IiK0NOLepcyfz6OUJXTzVsiXOt3kZODi/Diwna9YSgUtS2iLv8PlRucKnvg9oHygWW
         hcWZkd0jV0OpOZqE/VPevmyf3JKRSYSyGgf9yq/4ZGYz09lSCEuErRc5dXvRL/5XchDo
         fTWLmUEiKqbJb+Q6SVDDpia0MqXlh3Mfuw9c9KwYjgDNv1wzfuCYc7Xm+VZTpDvh8Nqs
         OsnQ+NyTkECk263pKtcIrBi1BMWq2sbCJfYb2Y/cuv7Nq2zlwok3vcr7ZNjy80okKSXg
         0MvEd0pYoJLOuz5vT6qgZ1Mo0z3KJEVPH0F9fHo9DIFXGmMGMqGPASPv3xF8jNUAIPav
         C4dw==
X-Gm-Message-State: APzg51AijGz7G7xPUJ8pECqflsqMIkGRu9GD6oCig0ZgQfUpFCfyUzJV
        6ZJSt/EwW8uRG496yN0RJ6Ar2Arcm+Q=
X-Google-Smtp-Source: ANB0Vdb/vmWbrce2pDgWj184qzrAel450u17meixyH+nIh0zfHrdIOxYQHnGbq34iZH+WQZ1Q+hBjA==
X-Received: by 2002:a50:82c5:: with SMTP id 63-v6mr61268513edg.200.1537390264720;
        Wed, 19 Sep 2018 13:51:04 -0700 (PDT)
Received: from dhcp.ire.aristanetworks.com ([217.173.96.166])
        by smtp.gmail.com with ESMTPSA id t17-v6sm1747729edb.27.2018.09.19.13.51.03
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 19 Sep 2018 13:51:04 -0700 (PDT)
From:   Dmitry Safonov <dima@arista.com>
To:     linux-kernel@vger.kernel.org
Cc:     Dmitry Safonov <0x7f454c46@gmail.com>,
        Andrei Vagin <avagin@gmail.com>,
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
Subject: [RFC 17/20] selftest/timens: Add test for timerfd
Date:   Wed, 19 Sep 2018 21:50:34 +0100
Message-Id: <20180919205037.9574-18-dima@arista.com>
X-Mailer: git-send-email 2.13.6
In-Reply-To: <20180919205037.9574-1-dima@arista.com>
References: <20180919205037.9574-1-dima@arista.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andrei Vagin <avagin@gmail.com>

Check that timerfd_create takes into account clock offsets.

Cc: linux-kselftest@vger.kernel.org
Signed-off-by: Andrei Vagin <avagin@openvz.org>
Signed-off-by: Dmitry Safonov <dima@arista.com>
---
 tools/testing/selftests/timens/.gitignore |  1 +
 tools/testing/selftests/timens/Makefile   |  2 +-
 tools/testing/selftests/timens/timerfd.c  | 96 +++++++++++++++++++++++++++++++
 3 files changed, 98 insertions(+), 1 deletion(-)
 create mode 100644 tools/testing/selftests/timens/timerfd.c

diff --git a/tools/testing/selftests/timens/.gitignore b/tools/testing/selftests/timens/.gitignore
index 27a693229ce1..b609f6ee9fb9 100644
--- a/tools/testing/selftests/timens/.gitignore
+++ b/tools/testing/selftests/timens/.gitignore
@@ -1 +1,2 @@
 timens
+timerfd
diff --git a/tools/testing/selftests/timens/Makefile b/tools/testing/selftests/timens/Makefile
index b877efb78974..66b90cd28e5c 100644
--- a/tools/testing/selftests/timens/Makefile
+++ b/tools/testing/selftests/timens/Makefile
@@ -1,4 +1,4 @@
-TEST_GEN_PROGS := timens
+TEST_GEN_PROGS := timens timerfd
 
 CFLAGS := -Wall -Werror
 
diff --git a/tools/testing/selftests/timens/timerfd.c b/tools/testing/selftests/timens/timerfd.c
new file mode 100644
index 000000000000..914a4cd9a0df
--- /dev/null
+++ b/tools/testing/selftests/timens/timerfd.c
@@ -0,0 +1,96 @@
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
+
+#ifndef CLONE_NEWTIME
+# define CLONE_NEWTIME	0x00001000
+#endif
+
+int run_test(int clockid)
+{
+	struct itimerspec new_value;
+	struct timespec now;
+	long long elapsed;
+	int fd, i;
+
+	if (clock_gettime(clockid, &now))
+		return pr_perror("clock_gettime");
+
+	for (i = 0; i < 2; i++) {
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
+		fd = timerfd_create(clockid, 0);
+		if (fd == -1)
+			return pr_perror("timerfd_create");
+
+		if (i == 1)
+			flags |= TFD_TIMER_ABSTIME;
+
+		if (timerfd_settime(fd, flags, &new_value, NULL))
+			return pr_perror("timerfd_settime");
+
+		if (timerfd_gettime(fd, &new_value))
+			return pr_perror("timerfd_gettime");
+
+		elapsed = new_value.it_value.tv_sec;
+		if (abs(elapsed - 3600) > 60) {
+			printf("FAIL\n");
+			return 1;
+		}
+
+		close(fd);
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
+	tp.tv_sec = 7 * 24 * 3600;
+	if (clock_settime(CLOCK_MONOTONIC, &tp))
+		return pr_perror("clock_settime");
+
+	if (clock_gettime(CLOCK_BOOTTIME, &tp))
+		return pr_perror("clock_gettime");
+	tp.tv_sec += 9 * 24 * 3600;
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

