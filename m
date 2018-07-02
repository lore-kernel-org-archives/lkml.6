Return-Path: <SRS0=/0sc=JS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13B7FC3279B
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 09:17:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C110A25BD5
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 09:17:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oilNGHhV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C110A25BD5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965152AbeGBJRi (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Jul 2018 05:17:38 -0400
Received: from mail-pg0-f66.google.com ([74.125.83.66]:34476 "EHLO
        mail-pg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965065AbeGBJRC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jul 2018 05:17:02 -0400
Received: by mail-pg0-f66.google.com with SMTP id y5-v6so589747pgv.1;
        Mon, 02 Jul 2018 02:17:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=EQVId5BaxXTT+wTsMq+BhzFviOhh7WwA7pQZIcCrrpA=;
        b=oilNGHhVBtMrAOyB1Z9OhOw454sWnzJ6XbWQrnKc6L33huvhOWJBPW4mzZyOTubFIM
         SApfEM3iFi2VHzhr2n2HNqYnnbEVbNoVhl6hTpSeBw50PQkyWbyXGMEbhLcOBL41DYp0
         v+iN1A3dp5AWMnRvn+oGwF1CWiJDvC9JcYHscnAaVEM+SWwT0E+VMPtbRR6K21yPoglb
         KPOVLXfh8+IhEsgd8F8zosK+A3Zma8G8ypRBLoGzD53TUM9SNW/JomAnPTuzoduN2Oy1
         6WMPegk82jAHA/qEPB0iMmeJNKrVxvALKsnV/JWXxof34EhwU8pCc+igPJBbX6/I+QuC
         cfKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=EQVId5BaxXTT+wTsMq+BhzFviOhh7WwA7pQZIcCrrpA=;
        b=kBywvG8hqlL9nlvLzqqBfHV35GzePyYgVvamTsyN7FjdqPJCYS0I2JXLhwLo71PtJr
         K7wXXj03P0lX6qQDz83BME47sR0NyflZRZSrHZ61VawKHKPvnUirH9VcCxPThzsGT8nF
         Az54Fadc34GzVtT0kXp2DdSCwp9xBDhmxiI5JpoOU8ev3I6HRc+lbc1WUHA034Yxhpzt
         MQWEreHFEz3bjbsd2EwI/hzx1sc6rEhJZDSUzgcLTNqoTQzSwAGNg7qvoKGk6m0PBSKj
         8cctaN5lzF8stEJc1VhA62lAEudInHjQSX3JI0mvYq28OIEtmWVvUNWnmChIeBk3k2QJ
         MADQ==
X-Gm-Message-State: APt69E1tG/8kJMTy6x1w4PRHtFD0fr7eNVv8rVas/AoG5AY7/zAeRL/1
        mjhKiYVpEu78Jaif/oOmsyB4gQ==
X-Google-Smtp-Source: AAOMgpdFZn4IpLgyriMGm2PXlusTJksmZBi+sDKf3Bgxz1eowYa0P+lzKS5WGL+7dReCKOUL9zbttw==
X-Received: by 2002:a65:4545:: with SMTP id x5-v6mr20981422pgr.4.1530523021746;
        Mon, 02 Jul 2018 02:17:01 -0700 (PDT)
Received: from localhost.localdomain ([211.196.191.92])
        by smtp.gmail.com with ESMTPSA id 67-v6sm24527627pga.9.2018.07.02.02.16.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 02 Jul 2018 02:17:01 -0700 (PDT)
From:   Taeung Song <treeze.taeung@gmail.com>
To:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>
Cc:     Teng Qin <qinteng@fb.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, Taeung Song <treeze.taeung@gmail.com>
Subject: [PATCH 3/4] samples/bpf: Check the error of write() and read()
Date:   Mon,  2 Jul 2018 18:14:52 +0900
Message-Id: <1530522893-8961-4-git-send-email-treeze.taeung@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1530522893-8961-1-git-send-email-treeze.taeung@gmail.com>
References: <1530522893-8961-1-git-send-email-treeze.taeung@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

test_task_rename() and test_urandom_read()
can be failed during write() and read(),
So check the result of them.

Signed-off-by: Taeung Song <treeze.taeung@gmail.com>
---
 samples/bpf/test_overhead_user.c | 20 +++++++++++++++-----
 1 file changed, 15 insertions(+), 5 deletions(-)

diff --git a/samples/bpf/test_overhead_user.c b/samples/bpf/test_overhead_user.c
index 6caf47a..8a88d9c 100644
--- a/samples/bpf/test_overhead_user.c
+++ b/samples/bpf/test_overhead_user.c
@@ -6,6 +6,7 @@
  */
 #define _GNU_SOURCE
 #include <sched.h>
+#include <errno.h>
 #include <stdio.h>
 #include <sys/types.h>
 #include <asm/unistd.h>
@@ -44,8 +45,12 @@ static void test_task_rename(int cpu)
 		exit(1);
 	}
 	start_time = time_get_ns();
-	for (i = 0; i < MAX_CNT; i++)
-		write(fd, buf, sizeof(buf));
+	for (i = 0; i < MAX_CNT; i++) {
+		if (write(fd, buf, sizeof(buf)) < 0) {
+			printf("task rename failed: %s\n", strerror(errno));
+			break;
+		}
+	}
 	printf("task_rename:%d: %lld events per sec\n",
 	       cpu, MAX_CNT * 1000000000ll / (time_get_ns() - start_time));
 	close(fd);
@@ -55,7 +60,7 @@ static void test_urandom_read(int cpu)
 {
 	__u64 start_time;
 	char buf[4];
-	int i, fd;
+	int i, fd, err = 0;
 
 	fd = open("/dev/urandom", O_RDONLY);
 	if (fd < 0) {
@@ -63,8 +68,13 @@ static void test_urandom_read(int cpu)
 		exit(1);
 	}
 	start_time = time_get_ns();
-	for (i = 0; i < MAX_CNT; i++)
-		read(fd, buf, sizeof(buf));
+	for (i = 0; i < MAX_CNT; i++) {
+		err = read(fd, buf, sizeof(buf));
+		if (err < 0 || err >= sizeof(buf)) {
+			printf("failed to read from /dev/urandom: %s\n", strerror(errno));
+			break;
+		}
+	}
 	printf("urandom_read:%d: %lld events per sec\n",
 	       cpu, MAX_CNT * 1000000000ll / (time_get_ns() - start_time));
 	close(fd);
-- 
2.7.4

