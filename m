Return-Path: <SRS0=pNWC=KQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E090C28CF6
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 23:36:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2AFCA20894
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 23:36:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b="F/UU6Sel"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2AFCA20894
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=arista.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732332AbeHBBYz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Aug 2018 21:24:55 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:39987 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729646AbeHBBYy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Aug 2018 21:24:54 -0400
Received: by mail-ed1-f68.google.com with SMTP id e19-v6so258547edq.7
        for <linux-kernel@vger.kernel.org>; Wed, 01 Aug 2018 16:36:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=googlenew;
        h=from:to:cc:subject:date:message-id;
        bh=zysA6SIB37bEfWOqteBNHnQc4SaQRKzqRTTc8rlBub4=;
        b=F/UU6SelhSD3DQnAvbDG797+4q78LsRj5d8HDNebn/7y0KofRgltMGPnG0Hwe1ddi3
         gbNooRArZQAozXv33PVNvxEGic+muSc80w2waYrgTWPeqMbruKWLJfcftAATHyzVRYHO
         HDuMXp6Hqllgrj+LJrLeP3VH088vYTe3gpZG+oGfpDjE1eZabSk1fIBZyZYInMMxjfzL
         TKCtpi/WHcYQT4XITwky6zbD9cmoG9Ga6YbuipmofzQRJlJtIodeOY7AsoWnSol3S+lk
         gF2esoZtIa0msVTwHiAnIod0P5EaYQ7TOUHlqZNeAehlJOpnnRBrh11hJT6TW2r3aTdY
         qUqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=zysA6SIB37bEfWOqteBNHnQc4SaQRKzqRTTc8rlBub4=;
        b=fz2UGFWiGc/AdgMTg01YxaytdiqN84gSvz+1HX50J/BYmOKBgZuRTAxN5MWQ/fPzjA
         Wj2AwAmNRs+7eCVoS75SPpmlR9o+elUjTYeZ4wXFiC7HJqWYwRz5Hko4XSb7u8l+wNaP
         TPu6Jo6zzezomR6syZ2ZCvPjD5LjapPfHD8u41RC7IkBo5QCpJprv63UJD7TDW44qgbO
         N039k1TCewZREt/TxVbmbvCd2BKTCt8jBdB1TK7SYJOn7GKigzt6uso1xrR6M8cNooKR
         pVs6WPL5+iP0MsWiJi4dtWE+LY78deU+r7dLOqxDTLcqIifwFa2W9nb/5lh3ajKwSnaj
         HsNQ==
X-Gm-Message-State: AOUpUlF71Kt5iEy3OuusuUILwymH/Qn8t9Bo7f4PTGzFljt6TPbcXZ2F
        L0p5XDyxypIJHdZbjcxwl9FvzVrvO9s=
X-Google-Smtp-Source: AAOMgpcDEBsTAsdoLojtjIQO0qOFVAQCxUpQSjqQnQjsL7UlT6xDDDmDnb3xScmzv6VA4VwVwCvLHQ==
X-Received: by 2002:aa7:d859:: with SMTP id f25-v6mr728243eds.157.1533166598137;
        Wed, 01 Aug 2018 16:36:38 -0700 (PDT)
Received: from dhcp.ire.aristanetworks.com ([217.173.96.166])
        by smtp.gmail.com with ESMTPSA id b44-v6sm582086edd.93.2018.08.01.16.36.36
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 01 Aug 2018 16:36:37 -0700 (PDT)
From:   Dmitry Safonov <dima@arista.com>
To:     linux-kernel@vger.kernel.org
Cc:     Dmitry Safonov <dima@arista.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Dmitry Safonov <0x7f454c46@gmail.com>,
        Hua Zhong <hzhong@arista.com>, Shuah Khan <shuah@kernel.org>,
        Stuart Ritchie <sritchie@arista.com>,
        linux-kselftest@vger.kernel.org
Subject: [PATCH] mm/selftest: Add MAP_POPULATE test
Date:   Thu,  2 Aug 2018 00:36:36 +0100
Message-Id: <20180801233636.29354-1-dima@arista.com>
X-Mailer: git-send-email 2.13.6
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As many other projects, we use some shmalloc allocator.
At some point we need to make a part of allocated pages back private to
process. And it should be populated straight away.
Check that (MAP_PRIVATE | MAP_POPULATE) actually copies the private page.

Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Dmitry Safonov <0x7f454c46@gmail.com>
Cc: Hua Zhong <hzhong@arista.com>
Cc: Shuah Khan <shuah@kernel.org>
Cc: Stuart Ritchie <sritchie@arista.com>
Cc: linux-kselftest@vger.kernel.org
Signed-off-by: Dmitry Safonov <dima@arista.com>
---
 tools/testing/selftests/vm/.gitignore     |   1 +
 tools/testing/selftests/vm/Makefile       |   1 +
 tools/testing/selftests/vm/map_populate.c | 113 ++++++++++++++++++++++++++++++
 tools/testing/selftests/vm/run_vmtests    |  11 +++
 4 files changed, 126 insertions(+)
 create mode 100644 tools/testing/selftests/vm/map_populate.c

diff --git a/tools/testing/selftests/vm/.gitignore b/tools/testing/selftests/vm/.gitignore
index 342c7bc9dc8c..af5ff83f6d7f 100644
--- a/tools/testing/selftests/vm/.gitignore
+++ b/tools/testing/selftests/vm/.gitignore
@@ -1,6 +1,7 @@
 hugepage-mmap
 hugepage-shm
 map_hugetlb
+map_populate
 thuge-gen
 compaction_test
 mlock2-tests
diff --git a/tools/testing/selftests/vm/Makefile b/tools/testing/selftests/vm/Makefile
index fdefa2295ddc..9881876d2aa0 100644
--- a/tools/testing/selftests/vm/Makefile
+++ b/tools/testing/selftests/vm/Makefile
@@ -12,6 +12,7 @@ TEST_GEN_FILES += gup_benchmark
 TEST_GEN_FILES += hugepage-mmap
 TEST_GEN_FILES += hugepage-shm
 TEST_GEN_FILES += map_hugetlb
+TEST_GEN_FILES += map_populate
 TEST_GEN_FILES += mlock-random-test
 TEST_GEN_FILES += mlock2-tests
 TEST_GEN_FILES += on-fault-limit
diff --git a/tools/testing/selftests/vm/map_populate.c b/tools/testing/selftests/vm/map_populate.c
new file mode 100644
index 000000000000..df3eacc8eecb
--- /dev/null
+++ b/tools/testing/selftests/vm/map_populate.c
@@ -0,0 +1,113 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) 2018 Dmitry Safonov, Arista Networks
+ *
+ * MAP_POPULATE | MAP_PRIVATE should COW VMA pages.
+ */
+
+#define _GNU_SOURCE
+#include <errno.h>
+#include <fcntl.h>
+#include <sys/mman.h>
+#include <sys/socket.h>
+#include <sys/types.h>
+#include <sys/wait.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <string.h>
+#include <unistd.h>
+
+#ifndef MMAP_SZ
+#define MMAP_SZ		4096
+#endif
+
+#define BUG_ON(condition, description)					\
+	do {								\
+		if (condition) {					\
+			fprintf(stderr, "[FAIL]\t%s:%d\t%s:%s\n", __func__, \
+				__LINE__, (description), strerror(errno)); \
+			exit(1);					\
+		}							\
+	} while (0)
+
+static int parent_f(int sock, unsigned long *smap, int child)
+{
+	int status, ret;
+
+	ret = read(sock, &status, sizeof(int));
+	BUG_ON(ret <= 0, "read(sock)");
+
+	*smap = 0x22222BAD;
+	ret = msync(smap, MMAP_SZ, MS_SYNC);
+	BUG_ON(ret, "msync()");
+
+	ret = write(sock, &status, sizeof(int));
+	BUG_ON(ret <= 0, "write(sock)");
+
+	waitpid(child, &status, 0);
+	BUG_ON(!WIFEXITED(status), "child hasn't suicide by own will");
+
+	return WEXITSTATUS(status);
+}
+
+static int child_f(int sock, unsigned long *smap, int fd)
+{
+	int ret, buf = 0;
+
+	smap = mmap(0, MMAP_SZ, PROT_READ | PROT_WRITE,
+			MAP_PRIVATE | MAP_POPULATE, fd, 0);
+	BUG_ON(smap == MAP_FAILED, "mmap()");
+
+	BUG_ON(*smap != 0xdeadbabe, "MAP_PRIVATE | MAP_POPULATE changed file");
+
+	ret = write(sock, &buf, sizeof(int));
+	BUG_ON(ret <= 0, "write(sock)");
+
+	ret = read(sock, &buf, sizeof(int));
+	BUG_ON(ret <= 0, "read(sock)");
+
+	BUG_ON(*smap == 0x22222BAD, "MAP_POPULATE didn't COW private page");
+	BUG_ON(*smap != 0xdeadbabe, "mapping was corrupted");
+
+	return 0;
+}
+
+int main(int argc, char **argv)
+{
+	int sock[2], child, ret;
+	FILE *ftmp;
+	unsigned long *smap;
+
+	ftmp = tmpfile();
+	BUG_ON(ftmp == 0, "tmpfile()");
+
+	ret = ftruncate(fileno(ftmp), MMAP_SZ);
+	BUG_ON(ret, "ftruncate()");
+
+	smap = mmap(0, MMAP_SZ, PROT_READ | PROT_WRITE,
+			MAP_SHARED, fileno(ftmp), 0);
+	BUG_ON(smap == MAP_FAILED, "mmap()");
+
+	*smap = 0xdeadbabe;
+	/* Probably unnecessary, but let it be. */
+	ret = msync(smap, MMAP_SZ, MS_SYNC);
+	BUG_ON(ret, "msync()");
+
+	ret = socketpair(PF_LOCAL, SOCK_SEQPACKET, 0, sock);
+	BUG_ON(ret, "socketpair()");
+
+	child = fork();
+	BUG_ON(child == -1, "fork()");
+
+	if (child) {
+		ret = close(sock[0]);
+		BUG_ON(ret, "close()");
+
+		return parent_f(sock[1], smap, child);
+	}
+
+	ret = close(sock[1]);
+	BUG_ON(ret, "close()");
+
+	return child_f(sock[0], smap, fileno(ftmp));
+}
diff --git a/tools/testing/selftests/vm/run_vmtests b/tools/testing/selftests/vm/run_vmtests
index 88cbe5575f0c..584a91ae4a8f 100755
--- a/tools/testing/selftests/vm/run_vmtests
+++ b/tools/testing/selftests/vm/run_vmtests
@@ -168,6 +168,17 @@ else
 fi
 
 echo "--------------------"
+echo "running map_populate"
+echo "--------------------"
+./map_populate
+if [ $? -ne 0 ]; then
+	echo "[FAIL]"
+	exitcode=1
+else
+	echo "[PASS]"
+fi
+
+echo "--------------------"
 echo "running mlock2-tests"
 echo "--------------------"
 ./mlock2-tests
-- 
2.13.6

