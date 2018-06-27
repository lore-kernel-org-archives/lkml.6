Return-Path: <SRS0=G4S6=JN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E29B3C43144
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 19:52:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9779025AB7
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 19:52:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TkzLInkO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9779025AB7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966409AbeF0TwN (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Jun 2018 15:52:13 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:40227 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965488AbeF0TwM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jun 2018 15:52:12 -0400
Received: by mail-wm0-f68.google.com with SMTP id z13-v6so6697371wma.5
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jun 2018 12:52:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :content-transfer-encoding:user-agent;
        bh=+QIlBl3l0U7ycwYFbMc/6MTYX/9DVfg1AFUASUNpDoM=;
        b=TkzLInkOkd7UgXDOn3mjxh9TiM0INWmqkjIEZlbwno3xjUfuCC4xBEG/7CivGsYV+C
         I8KR1L/CkBvX8sqjr7roS7MlAieZG+l5MAtXwEaRPcw3AxFYcZWwL3gqjUwQ5nhLjJIJ
         D3UTKECw8/mtx9Jcab9pL5qbliNeZzOt5pM9KH7YTCYHaclIP+E8hUSPkAi9sN+FRLBX
         4mSjLuJuW2fLtw/a/qXQ/tSpMD1/7Q05wOipC/CmjdMxYrMsTK5sgYr1MUwyJ1YbGP+p
         9Bj3JDyaq2NwmSWyXv5p960YeIaIHh1dT9tg+0+8VRG08cCDfp8tBbOYSbJzHEUn/fSA
         iLdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:content-transfer-encoding:user-agent;
        bh=+QIlBl3l0U7ycwYFbMc/6MTYX/9DVfg1AFUASUNpDoM=;
        b=gCDzUo424/9iB6Y4hVWID6oF6gjifda/33UTHPevxl6HUX3xkw9YuP6tdWtkMsZ6vk
         L6KrdgkF2Un3cDmSvjmetMqQz8vqTRmdLTwm5IefntpLxEvZpb5LmqmtHGSJ5e0+UNIV
         p2f3W3KqSaMn7aZMmPfgWyLKNBE8WYfp/+0GiF/UxQshk2NeM+D0mKVR5i84PIvPNd7O
         mAF+UjzFYnWm/MUhm/p2fe00XHOdlUUDud/X+bBGZR/0qdVbGUNjW536mEP0BsopqDeB
         /JTy1GIoDT/LFx1XA3GCSw1d+MymAp6J3pDR2A3A6JgqqiAhvRorc2/ktHHEgD6g/qs7
         seWA==
X-Gm-Message-State: APt69E3XXfxeWcLgpo0hFy7NXyznLxyIGtaglkfMHksMavkA4TRIQrc8
        uI/JOVejw/il955SSSJ2Gw==
X-Google-Smtp-Source: AAOMgpdS/xHXZ6hZYhJ8CCT1WTU8XLd0wFRi+1Xi6b6pkOrVb6l7O74tIDq0NHrhUQOogxGHsAvL9g==
X-Received: by 2002:a1c:1389:: with SMTP id 131-v6mr6050225wmt.65.1530129131389;
        Wed, 27 Jun 2018 12:52:11 -0700 (PDT)
Received: from avx2 (nat4-minsk-pool-46-53-177-92.telecom.by. [46.53.177.92])
        by smtp.gmail.com with ESMTPSA id e188-v6sm18068172wmf.21.2018.06.27.12.52.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 27 Jun 2018 12:52:10 -0700 (PDT)
Date:   Wed, 27 Jun 2018 22:52:09 +0300
From:   Alexey Dobriyan <adobriyan@gmail.com>
To:     akpm@linux-foundation.org
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] proc: test /proc/thread-self symlink
Message-ID: <20180627195209.GC18113@avx2>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Same story: I have WIP patch to make it faster, so better have a test
as well.

Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>
---

 tools/testing/selftests/proc/.gitignore    |    1 
 tools/testing/selftests/proc/Makefile      |    1 
 tools/testing/selftests/proc/proc.h        |    5 ++
 tools/testing/selftests/proc/thread-self.c |   64 +++++++++++++++++++++++++++++
 4 files changed, 71 insertions(+)

--- a/tools/testing/selftests/proc/.gitignore
+++ b/tools/testing/selftests/proc/.gitignore
@@ -10,3 +10,4 @@
 /proc-uptime-002
 /read
 /self
+/thread-self
--- a/tools/testing/selftests/proc/Makefile
+++ b/tools/testing/selftests/proc/Makefile
@@ -14,5 +14,6 @@ TEST_GEN_PROGS += proc-uptime-001
 TEST_GEN_PROGS += proc-uptime-002
 TEST_GEN_PROGS += read
 TEST_GEN_PROGS += self
+TEST_GEN_PROGS += thread-self
 
 include ../lib.mk
--- a/tools/testing/selftests/proc/proc.h
+++ b/tools/testing/selftests/proc/proc.h
@@ -14,6 +14,11 @@ static inline pid_t sys_getpid(void)
 	return syscall(SYS_getpid);
 }
 
+static inline pid_t sys_gettid(void)
+{
+	return syscall(SYS_gettid);
+}
+
 static inline bool streq(const char *s1, const char *s2)
 {
 	return strcmp(s1, s2) == 0;
new file mode 100644
--- /dev/null
+++ b/tools/testing/selftests/proc/thread-self.c
@@ -0,0 +1,64 @@
+/*
+ * Copyright © 2018 Alexey Dobriyan <adobriyan@gmail.com>
+ *
+ * Permission to use, copy, modify, and distribute this software for any
+ * purpose with or without fee is hereby granted, provided that the above
+ * copyright notice and this permission notice appear in all copies.
+ *
+ * THE SOFTWARE IS PROVIDED "AS IS" AND THE AUTHOR DISCLAIMS ALL WARRANTIES
+ * WITH REGARD TO THIS SOFTWARE INCLUDING ALL IMPLIED WARRANTIES OF
+ * MERCHANTABILITY AND FITNESS. IN NO EVENT SHALL THE AUTHOR BE LIABLE FOR
+ * ANY SPECIAL, DIRECT, INDIRECT, OR CONSEQUENTIAL DAMAGES OR ANY DAMAGES
+ * WHATSOEVER RESULTING FROM LOSS OF USE, DATA OR PROFITS, WHETHER IN AN
+ * ACTION OF CONTRACT, NEGLIGENCE OR OTHER TORTIOUS ACTION, ARISING OUT OF
+ * OR IN CONNECTION WITH THE USE OR PERFORMANCE OF THIS SOFTWARE.
+ */
+// Test that /proc/thread-self gives correct TGID/PID.
+#undef NDEBUG
+#include <assert.h>
+#include <sched.h>
+#include <stdio.h>
+#include <unistd.h>
+#include <sys/mman.h>
+#include <sys/wait.h>
+
+#include "proc.h"
+
+int f(void *arg)
+{
+	char buf1[64], buf2[64];
+	pid_t pid, tid;
+	ssize_t rv;
+
+	pid = sys_getpid();
+	tid = sys_gettid();
+	snprintf(buf1, sizeof(buf1), "%u/task/%u", pid, tid);
+
+	rv = readlink("/proc/thread-self", buf2, sizeof(buf2));
+	assert(rv == strlen(buf1));
+	buf2[rv] = '\0';
+	assert(streq(buf1, buf2));
+
+	if (arg)
+		exit(0);
+	return 0;
+}
+
+int main(void)
+{
+	const int PAGE_SIZE = sysconf(_SC_PAGESIZE);
+	pid_t pid;
+	void *stack;
+
+	/* main thread */
+	f((void *)0);
+
+	stack = mmap(NULL, 2 * PAGE_SIZE, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0);
+	assert(stack != MAP_FAILED);
+	/* side thread */
+	pid = clone(f, stack + PAGE_SIZE, CLONE_THREAD|CLONE_SIGHAND|CLONE_VM, (void *)1);
+	assert(pid > 0);
+	pause();
+
+	return 0;
+}
