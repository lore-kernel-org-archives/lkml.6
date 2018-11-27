Return-Path: <SRS0=Hds+=OG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C50E2C43441
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 10:33:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8D9C420817
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 10:33:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tcd-ie.20150623.gappssmtp.com header.i=@tcd-ie.20150623.gappssmtp.com header.b="jxFbG8Sq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8D9C420817
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=tcd.ie
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730750AbeK0VbA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Nov 2018 16:31:00 -0500
Received: from mail-ed1-f68.google.com ([209.85.208.68]:36266 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726445AbeK0Va7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Nov 2018 16:30:59 -0500
Received: by mail-ed1-f68.google.com with SMTP id f23so18563977edb.3
        for <linux-kernel@vger.kernel.org>; Tue, 27 Nov 2018 02:33:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tcd-ie.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id;
        bh=/kuCNfpIi+sZF8N3hGFOfrqe+U2khD9BA/v2leQDKRI=;
        b=jxFbG8SqYnt07M8yikbxdwNFB+P6yjv6H25yjROblpQxV8vcoyzqhVI6U7p6vhrb9Z
         6IccYJEE9tr4USiB4CW0EHL9vHth9/5wsbnimZVGR32P3M4bbyDjvyKh49U6tUfdhmxr
         baYhC9wKLomod2pqlDuE78Ci4MXG5CEBp4W27l1Xa9r+sJFHnWd6hFu/uR2859DQd7hf
         Vg3Q2QC3UAPzrvL2gHfJNeSpVQ2z68r/SIaMrOqkWHpAbkyh1f08wjQOY1lqdhpdSzJL
         5yOvl5mS3cT2D7kSzBykr5yLqrCI5WZx+0PboIMlYC7rmFGkzs3J6bZfS2FGmXF7sgk3
         w5TA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=/kuCNfpIi+sZF8N3hGFOfrqe+U2khD9BA/v2leQDKRI=;
        b=c0a0FNQTCHBlHzrn6agXgtvQIXt9xGVkzFRmZHmzh71HArxZuxBC6UL8e63uVDjS/a
         h/MQdrzzabBilHf+omH9K3uuSVf18b/qBxbf6/fBEoc8StY6I+mJ5why58ifNGz0U0OP
         IkRp0zWlDj2oyMDUExxYGjQzMW419YqNTrEFg0IQcuwPCqul/DikpT0gfOSusBqkRP0j
         mZYcSUblTy37QO5UhNyvc7eLGDnRhqjlfFziLZgL6nHMg5Jq/QDt6wChkDo94Y8Dc4Xf
         k0EElgw5/iJCXdtSF5WhEAIs6Hug/cn/qGuIyJzZuUjJ/Y2XvMqSYHdUrI3ZUITFeocz
         0UfA==
X-Gm-Message-State: AA+aEWZ5+etcOW8VQsH5YOifuk2Sld6rsz+uNH/MRkjSPct+VLG0iRer
        42zibBx7T8Ndp9j7LB/bDtEkRw==
X-Google-Smtp-Source: AFSGD/W/7E1bGK2BKESMGJTXR4miv8IRvJmw7kBGg/Fjs36lXKq2G7mMfA/HytdWBcbAhR5s02FIBQ==
X-Received: by 2002:a17:906:4e82:: with SMTP id v2-v6mr19996835eju.149.1543314810659;
        Tue, 27 Nov 2018 02:33:30 -0800 (PST)
Received: from localhost.localdomain (95-45-154-4-dynamic.agg2.phb.bdt-fng.eircom.net. [95.45.154.4])
        by smtp.gmail.com with ESMTPSA id z39sm895739edb.81.2018.11.27.02.33.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 27 Nov 2018 02:33:30 -0800 (PST)
From:   Tom Murphy <murphyt7@tcd.ie>
To:     linux-kselftest@vger.kernel.org
Cc:     Tom Murphy <murphyt7@tcd.ie>, Shuah Khan <shuah@kernel.org>,
        Gerd Hoffmann <kraxel@redhat.com>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] fix dma-buf/udmabuf selftest
Date:   Tue, 27 Nov 2018 10:33:08 +0000
Message-Id: <20181127103312.19368-1-murphyt7@tcd.ie>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch fixes the udmabuf selftest. Currently the selftest is broken. 
I fixed the selftest by setting the F_SEAL_SHRINK seal on the memfd 
file descriptor which is required by udmabuf and added the test to 
the selftest Makefile. 

Signed-off-by: Tom Murphy <murphyt7@tcd.ie>
---
 tools/testing/selftests/Makefile                  |  1 +
 tools/testing/selftests/drivers/dma-buf/Makefile  |  2 ++
 tools/testing/selftests/drivers/dma-buf/udmabuf.c | 11 +++++++++--
 3 files changed, 12 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/Makefile b/tools/testing/selftests/Makefile
index f1fe492c8e17..25efcde61d95 100644
--- a/tools/testing/selftests/Makefile
+++ b/tools/testing/selftests/Makefile
@@ -6,6 +6,7 @@ TARGETS += capabilities
 TARGETS += cgroup
 TARGETS += cpufreq
 TARGETS += cpu-hotplug
+TARGETS += drivers/dma-buf
 TARGETS += efivarfs
 TARGETS += exec
 TARGETS += filesystems
diff --git a/tools/testing/selftests/drivers/dma-buf/Makefile b/tools/testing/selftests/drivers/dma-buf/Makefile
index 4154c3d7aa58..f22c3f7cf612 100644
--- a/tools/testing/selftests/drivers/dma-buf/Makefile
+++ b/tools/testing/selftests/drivers/dma-buf/Makefile
@@ -2,4 +2,6 @@ CFLAGS += -I../../../../../usr/include/
 
 TEST_GEN_PROGS := udmabuf
 
+top_srcdir ?=../../../../..
+
 include ../../lib.mk
diff --git a/tools/testing/selftests/drivers/dma-buf/udmabuf.c b/tools/testing/selftests/drivers/dma-buf/udmabuf.c
index 376b1d6730bd..4de902ea14d8 100644
--- a/tools/testing/selftests/drivers/dma-buf/udmabuf.c
+++ b/tools/testing/selftests/drivers/dma-buf/udmabuf.c
@@ -4,7 +4,7 @@
 #include <unistd.h>
 #include <string.h>
 #include <errno.h>
-#include <fcntl.h>
+#include <linux/fcntl.h>
 #include <malloc.h>
 
 #include <sys/ioctl.h>
@@ -33,12 +33,19 @@ int main(int argc, char *argv[])
 		exit(77);
 	}
 
-	memfd = memfd_create("udmabuf-test", MFD_CLOEXEC);
+	memfd = memfd_create("udmabuf-test", MFD_ALLOW_SEALING);
 	if (memfd < 0) {
 		printf("%s: [skip,no-memfd]\n", TEST_PREFIX);
 		exit(77);
 	}
 
+	ret = fcntl(memfd, F_ADD_SEALS, F_SEAL_SHRINK);
+	if (ret < 0) {
+		printf("%s: [skip,fcntl-add-seals]\n", TEST_PREFIX);
+		exit(77);
+	}
+
+
 	size = getpagesize() * NUM_PAGES;
 	ret = ftruncate(memfd, size);
 	if (ret == -1) {
-- 
2.11.0

