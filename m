Return-Path: <SRS0=/0sc=JS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6816CC3279B
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 09:17:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 243C225BBA
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 09:17:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SvM77PAa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 243C225BBA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965187AbeGBJRl (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Jul 2018 05:17:41 -0400
Received: from mail-pf0-f196.google.com ([209.85.192.196]:44988 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965025AbeGBJQ7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jul 2018 05:16:59 -0400
Received: by mail-pf0-f196.google.com with SMTP id j3-v6so7214718pfh.11;
        Mon, 02 Jul 2018 02:16:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=U527wIsRpS4ZQzkiO86DH4dg66riqekQsDdV+qSEE2g=;
        b=SvM77PAaP/gjSpjZr0sTLlRovcr6FTo0gxGeGYJ4WsJpWcGoYF2zkQSPmZGthGAQLT
         CJ+h4eVneA+buWQ5EMs9+6FpSvblpSw8dmtI0JWKqmwCyxad4bv2q2NYXDwlQToPFxu7
         0bBhTXBE4cs27bVUVBQegAvb6Gbmn09uz0Sd46Io7X4ezdNRAo4kLmImSwuPkqyiWleR
         Asu+7PaICnQHgkxyH6VWSQMKhMto0b+pffxmViZOBpU+rpro6tJgZmi3pZcBvLBLTeRS
         oF9QppZDOX7h56aW9j1WhurhvT+cYXweyJpNa8oCk4FscPXMXVtnqm/bjRRlIyfP22vG
         kjAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=U527wIsRpS4ZQzkiO86DH4dg66riqekQsDdV+qSEE2g=;
        b=brG1PV0TBZPUD0ndpnB7l4iByL4aaIVbkov/7RPEgqJvxY1pYZS3ctZxhntGoMfr/i
         LB7IS9dJ2Dk7lJ5VKwHoScCU1zdRLkuE0mJi9Hoh852Bq9HAgoIIMP86ZWKrg9I0zla9
         WB5/fP1NbxIYnIQlTX1J4/mMQI/Q8FiQ1EAROzNLf/lHeaXo0NNJIPm699Oi9mQNMZDq
         hUCkgWqmE7BXfqr3Hg5aIhajIaPL6gdWsQRouf6oS6BrInr2HJJT1kRWiO14KxdhGNSo
         YDy0OZEH66ymQj1uCw4oMs+gioqGbOOnHojcNOhKQWDVkqiD/OqBrDSsn/Efrj7s+LO3
         tvsw==
X-Gm-Message-State: APt69E2qcdEO4z+aXX+aKyA3abJ05GBO5XWTyRkU/zxE8fr2v3HuPS/+
        cQm/8ukwe/FXEzsQIdoi4D8=
X-Google-Smtp-Source: AAOMgpdLYG9EjJr6Eeb7W2xOsqqSbdV1uiLJ4wgCzSP2v7QQdjgf8mY6DZ3lRC3QgY/wEdfN+M3vog==
X-Received: by 2002:a65:5a8a:: with SMTP id c10-v6mr16754575pgt.389.1530523018759;
        Mon, 02 Jul 2018 02:16:58 -0700 (PDT)
Received: from localhost.localdomain ([211.196.191.92])
        by smtp.gmail.com with ESMTPSA id 67-v6sm24527627pga.9.2018.07.02.02.16.56
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 02 Jul 2018 02:16:58 -0700 (PDT)
From:   Taeung Song <treeze.taeung@gmail.com>
To:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>
Cc:     Teng Qin <qinteng@fb.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, Taeung Song <treeze.taeung@gmail.com>
Subject: [PATCH 2/4] samples/bpf: Check the result of system()
Date:   Mon,  2 Jul 2018 18:14:51 +0900
Message-Id: <1530522893-8961-3-git-send-email-treeze.taeung@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1530522893-8961-1-git-send-email-treeze.taeung@gmail.com>
References: <1530522893-8961-1-git-send-email-treeze.taeung@gmail.com>
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
index 1fa1bec..d08046ab8 100644
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
2.7.4

