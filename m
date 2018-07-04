Return-Path: <SRS0=cgxA=JU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E258C6778C
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 13:37:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BAD5124491
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 13:37:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ODIb3FYA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BAD5124491
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753575AbeGDNhR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Jul 2018 09:37:17 -0400
Received: from mail-pf0-f193.google.com ([209.85.192.193]:40433 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752732AbeGDNhO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jul 2018 09:37:14 -0400
Received: by mail-pf0-f193.google.com with SMTP id z24-v6so2646343pfe.7;
        Wed, 04 Jul 2018 06:37:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=FkEgAOa+gL8jQE9p/cxbCOrb2dhVhs5k8cDZKbF+nQk=;
        b=ODIb3FYAwsfj4RlRPu0oDct3VCYM+89LpYt9FtWcuA3V5rXHjDRWrykpJtrpts6Vgb
         hBZqJ3gszNJzuOT3iTVFCBFRK4IxOQ7N0kRUBCK5V0XDOOdhzab2vUw6GCQ7uO4sJz9k
         A9tdoWFpZg3zreNLvOzdGy9h/XjPkC5SsiJx0Dgo9ZMaXUNktu7yo1uzqfHcOBGaUeMM
         Dvc68UByr6Kio5FxaXPjlc2wOmavMcrzwt/QATxZfq/w3osq4G4cDRXxJswbQrQjgArn
         NlBk6Zrz3OgTt7ndM8ZJjSozfaqoeEZYk06HHXmKqC5KJLcRajIxUAdm/xf2fBcKgAkD
         2F4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=FkEgAOa+gL8jQE9p/cxbCOrb2dhVhs5k8cDZKbF+nQk=;
        b=l3EJczj9J5djy4W+Hc+qlSRigamsFh8ZWrsjwCZDTE7ZfSy78ubi/w0pdiG7oD9lEE
         VqS7ZMec4lAlxGqv6eL5R+AhZ9z1EPdqxGZe8helmduP1YCznW3jeG6LZQS2L4STQfO8
         F/R6EiiSsgbcaQmHbROh3B1v48cYAODWSVOBLosUsDi1mWvagRo6Bm4wNlHjon7xpFYN
         /Bs9iKQ1+rijjSy6B6SVY8TZgf7l87ziLxJmPcY11Hsr4hvoBAXh18tiYtQxRxYTWehJ
         +EGV5d9yd2KdcEgJ5K9eBgfyOsdFYFHVxSxdcvra6ciJfmXXQUfQL/noOE8arFzDy61G
         0XBQ==
X-Gm-Message-State: APt69E1Sq/BjTX3g51ALFS6/zlMB5+rfLKlJ/OK1GuhwKBuP9DE6bKS0
        R/Ci/i6n5YoJ+72uuJHZMa8R/w==
X-Google-Smtp-Source: AAOMgpfu5on74sCjmI14PVB5EDqK+sqlvlpzUrg0wWLaXHuxdAqke1Bo3caz0B8FjgWZKtG6d/+s4w==
X-Received: by 2002:a65:6086:: with SMTP id t6-v6mr2010133pgu.424.1530711433194;
        Wed, 04 Jul 2018 06:37:13 -0700 (PDT)
Received: from localhost.localdomain ([211.196.191.92])
        by smtp.gmail.com with ESMTPSA id i12-v6sm3593913pgd.87.2018.07.04.06.37.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 04 Jul 2018 06:37:12 -0700 (PDT)
From:   Taeung Song <treeze.taeung@gmail.com>
To:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Taeung Song <treeze.taeung@gmail.com>,
        Teng Qin <qinteng@fb.com>
Subject: [PATCH v2 2/4] samples/bpf: Check the result of system()
Date:   Wed,  4 Jul 2018 22:36:37 +0900
Message-Id: <20180704133639.11855-3-treeze.taeung@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180704133639.11855-1-treeze.taeung@gmail.com>
References: <20180704133639.11855-1-treeze.taeung@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

To avoid the below build warning message,
use new generate_load() checking the return value.

  ignoring return value of ‘system’, declared with attribute warn_unused_result

And it also refactors the duplicate code of both
test_perf_event_all_cpu() and test_perf_event_task()

Cc: Teng Qin <qinteng@fb.com>
Signed-off-by: Taeung Song <treeze.taeung@gmail.com>
---
 samples/bpf/trace_event_user.c | 27 ++++++++++++++++++++++++---
 1 file changed, 24 insertions(+), 3 deletions(-)

diff --git a/samples/bpf/trace_event_user.c b/samples/bpf/trace_event_user.c
index 1fa1becfa641..d08046ab81f0 100644
--- a/samples/bpf/trace_event_user.c
+++ b/samples/bpf/trace_event_user.c
@@ -122,6 +122,16 @@ static void print_stacks(void)
 	}
 }
 
+static inline int generate_load(void)
+{
+	if (system("dd if=/dev/zero of=/dev/null count=5000k status=none") < 0) {
+		printf("failed to generate some load with dd: %s\n", strerror(errno));
+		return -1;
+	}
+
+	return 0;
+}
+
 static void test_perf_event_all_cpu(struct perf_event_attr *attr)
 {
 	int nr_cpus = sysconf(_SC_NPROCESSORS_CONF);
@@ -142,7 +152,11 @@ static void test_perf_event_all_cpu(struct perf_event_attr *attr)
 		assert(ioctl(pmu_fd[i], PERF_EVENT_IOC_SET_BPF, prog_fd[0]) == 0);
 		assert(ioctl(pmu_fd[i], PERF_EVENT_IOC_ENABLE) == 0);
 	}
-	system("dd if=/dev/zero of=/dev/null count=5000k status=none");
+
+	if (generate_load() < 0) {
+		error = 1;
+		goto all_cpu_err;
+	}
 	print_stacks();
 all_cpu_err:
 	for (i--; i >= 0; i--) {
@@ -156,7 +170,7 @@ static void test_perf_event_all_cpu(struct perf_event_attr *attr)
 
 static void test_perf_event_task(struct perf_event_attr *attr)
 {
-	int pmu_fd;
+	int pmu_fd, error = 0;
 
 	/* per task perf event, enable inherit so the "dd ..." command can be traced properly.
 	 * Enabling inherit will cause bpf_perf_prog_read_time helper failure.
@@ -171,10 +185,17 @@ static void test_perf_event_task(struct perf_event_attr *attr)
 	}
 	assert(ioctl(pmu_fd, PERF_EVENT_IOC_SET_BPF, prog_fd[0]) == 0);
 	assert(ioctl(pmu_fd, PERF_EVENT_IOC_ENABLE) == 0);
-	system("dd if=/dev/zero of=/dev/null count=5000k status=none");
+
+	if (generate_load() < 0) {
+		error = 1;
+		goto err;
+	}
 	print_stacks();
+err:
 	ioctl(pmu_fd, PERF_EVENT_IOC_DISABLE);
 	close(pmu_fd);
+	if (error)
+		int_exit(0);
 }
 
 static void test_bpf_perf_event(void)
-- 
2.17.1

