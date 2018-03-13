Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Google-Smtp-Source: AG47ELvxnR6RI8swUpmO+9m5eAbw5aOh1ORyNyo3VsETBwq9EwzgvQc9Xow0JE0aljZm7tbvpS/r
ARC-Seal: i=1; a=rsa-sha256; t=1520941381; cv=none;
        d=google.com; s=arc-20160816;
        b=N+odHMPHWYoVGrqbIeOMuTFofoJ5tk1zcTlVv+xpdNUOnoMMyh/4lHHzUhG7fp95qY
         d3znbfkgS0RnfBXCj/AHDI6/tK7r68oJsIrfmwWRYEmYRZaQPhBOIl0wiIKt2su7G+Jn
         8SW995vXINBYuNlLSxItG9p0Jn04t8Teuk6WjGbF9eAUYyDkgqxOLPlXXhfV0t+98y/i
         hQdoIyCxVoMkqY3XfrfMSsgJCFINIsKRTGYoY7uu6JgLjvCj8X1x47UCEimDQlWLHbtJ
         tNbK3EphFC36iO5mbQYMY8ZiBiAkofrpMqiFex8iwbqVa+rkk1zAzFPA93sinmiH4hNz
         XMcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=list-id:precedence:sender:content-transfer-encoding:mime-version
         :references:in-reply-to:message-id:date:subject:cc:to:from
         :dkim-signature:arc-authentication-results;
        bh=ijmnr8lUP1pd1OWHuQ1fLDfd+jY50YzRmsOAWkq1fhk=;
        b=C4o/ISgM93bpP7IhmA5LkKXkFSFoJXVX0YCZqyA3VlNfrF6Pt4oBljT+HyqzeDBqq/
         ZY9mJzft/AJPOkLUcMzCghFAOmWYYGGatkghj4TlHG858Op5m54iKnoGl6oWXQ4AguKM
         eIXR2QCYSa1sszXqJsGU+gMpp72McsNAEAWIOvQ9C5dS+ePh+cogiQ96/OwHdGsfqcDM
         yc48KFtRLN7kotPAzWKMDZXewRfr4YBmVARAvOmLOYCAuRLdqsIdNwS86Ni8mqx/+RtK
         l5UGJ1HOumvjTlV0zUlyXp9uW+5KRCDZSVUX0onU/Ib/7ZVjcl9mXGrFJNxr+dmTeScN
         p8iw==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=neutral (body hash did not verify) header.i=@linaro.org header.s=google header.b=YllNYYuT;
       spf=pass (google.com: best guess record for domain of linux-kselftest-owner@vger.kernel.org designates 209.132.180.67 as permitted sender) smtp.mailfrom=linux-kselftest-owner@vger.kernel.org;
       dmarc=fail (p=NONE sp=NONE dis=NONE) header.from=linaro.org
Authentication-Results: mx.google.com;
       dkim=neutral (body hash did not verify) header.i=@linaro.org header.s=google header.b=YllNYYuT;
       spf=pass (google.com: best guess record for domain of linux-kselftest-owner@vger.kernel.org designates 209.132.180.67 as permitted sender) smtp.mailfrom=linux-kselftest-owner@vger.kernel.org;
       dmarc=fail (p=NONE sp=NONE dis=NONE) header.from=linaro.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932965AbeCMLmT (ORCPT <rfc822;gregkh@linuxfoundation.org>);
        Tue, 13 Mar 2018 07:42:19 -0400
Received: from mail-lf0-f66.google.com ([209.85.215.66]:32886 "EHLO
        mail-lf0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932961AbeCMLmP (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 13 Mar 2018 07:42:15 -0400
From: Anders Roxell <anders.roxell@linaro.org>
To: shuah@kernel.org
Cc: linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        dh.herrmann@gmail.com, Anders Roxell <anders.roxell@linaro.org>
Subject: [PATCH 2/2] selftests/memfd/fuse_test: fix implicit declaration
Date: Tue, 13 Mar 2018 12:42:05 +0100
Message-Id: <20180313114205.27714-2-anders.roxell@linaro.org>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20180313114205.27714-1-anders.roxell@linaro.org>
References: <20180313114205.27714-1-anders.roxell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kselftest-owner@vger.kernel.org
X-Mailing-List: linux-kselftest@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594822630599482355?=
X-GMAIL-MSGID: =?utf-8?q?1594822630599482355?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

gcc warns about implicit declaration.

gcc -D_FILE_OFFSET_BITS=64 -I../../../../include/uapi/
    -I../../../../include/ -I../../../../usr/include/
    fuse_test.c common.o  -o fuse_test
fuse_test.c: In function ‘mfd_assert_get_seals’:
fuse_test.c:67:6: warning: implicit declaration of function ‘fcntl’
    [-Wimplicit-function-declaration]
  r = fcntl(fd, F_GET_SEALS);
      ^~~~~
fuse_test.c: In function ‘main’:
fuse_test.c:261:7: warning: implicit declaration of function ‘open’
    [-Wimplicit-function-declaration]
  fd = open(argv[1], O_RDONLY | O_CLOEXEC);
       ^~~~
make: Leaving directory 'tools/testing/selftests/memfd'

In the current code, we include the headers that the functions want
according to the man pages, and we move common code for memfd to
common.c. Moved F_ADD_SEALS and friends to memfd/common.h since both
fuse_test and memfd_test uses them.

Fixes: 87b2d44026e0 ("selftests: add memfd/sealing page-pinning tests")
Signed-off-by: Anders Roxell <anders.roxell@linaro.org>
---
 tools/testing/selftests/memfd/common.c     | 41 ++++++++++++++++++++-
 tools/testing/selftests/memfd/common.h     | 26 +++++++++++++
 tools/testing/selftests/memfd/fuse_test.c  | 46 ++---------------------
 tools/testing/selftests/memfd/memfd_test.c | 59 ------------------------------
 4 files changed, 70 insertions(+), 102 deletions(-)

diff --git a/tools/testing/selftests/memfd/common.c b/tools/testing/selftests/memfd/common.c
index 8eb3d75f6e60..d1faee61782b 100644
--- a/tools/testing/selftests/memfd/common.c
+++ b/tools/testing/selftests/memfd/common.c
@@ -4,8 +4,10 @@
 
 #include <stdio.h>
 #include <stdlib.h>
-#include <linux/fcntl.h>
 #include <linux/memfd.h>
+#include <sys/types.h>
+#include <sys/stat.h>
+#include <fcntl.h>
 #include <unistd.h>
 #include <sys/syscall.h>
 
@@ -44,3 +46,40 @@ int sys_memfd_create(const char *name, unsigned int flags)
 
 	return syscall(__NR_memfd_create, name, flags);
 }
+
+unsigned int mfd_assert_get_seals(int fd)
+{
+	int r;
+
+	r = fcntl(fd, F_GET_SEALS);
+	if (r < 0) {
+		printf("GET_SEALS(%d) failed: %m\n", fd);
+		abort();
+	}
+
+	return (unsigned int)r;
+}
+
+void mfd_assert_add_seals(int fd, unsigned int seals)
+{
+	int r;
+	unsigned int s;
+
+	s = mfd_assert_get_seals(fd);
+	r = fcntl(fd, F_ADD_SEALS, seals);
+	if (r < 0) {
+		printf("ADD_SEALS(%d, %u -> %u) failed: %m\n", fd, s, seals);
+		abort();
+	}
+}
+
+void mfd_assert_has_seals(int fd, unsigned int seals)
+{
+	unsigned int s;
+
+	s = mfd_assert_get_seals(fd);
+	if (s != seals) {
+		printf("%u != %u = GET_SEALS(%d)\n", seals, s, fd);
+		abort();
+	}
+}
diff --git a/tools/testing/selftests/memfd/common.h b/tools/testing/selftests/memfd/common.h
index 522d2c630bd8..333baf79ffc4 100644
--- a/tools/testing/selftests/memfd/common.h
+++ b/tools/testing/selftests/memfd/common.h
@@ -1,9 +1,35 @@
 #ifndef COMMON_H_
 #define COMMON_H_
 
+#ifndef F_LINUX_SPECIFIC_BASE
+#    define F_LINUX_SPECIFIC_BASE      1024
+#endif
+#ifndef F_ADD_SEALS
+#    define F_ADD_SEALS        (F_LINUX_SPECIFIC_BASE + 9)
+#endif
+#ifndef F_GET_SEALS
+#    define F_GET_SEALS        (F_LINUX_SPECIFIC_BASE + 10)
+#endif
+#ifndef F_SEAL_SEAL
+#    define F_SEAL_SEAL        0x0001 /* prevent further seals from being set */
+#endif
+#ifndef F_SEAL_SHRINK
+#    define F_SEAL_SHRINK      0x0002 /* prevent file from shrinking */
+#endif
+#ifndef F_SEAL_GROW
+#    define F_SEAL_GROW        0x0004 /* prevent file from growing */
+#endif
+#ifndef F_SEAL_WRITE
+#    define F_SEAL_WRITE       0x0008 /* prevent writes */
+#endif
+
 extern int hugetlbfs_test;
 
 unsigned long default_huge_page_size(void);
 int sys_memfd_create(const char *name, unsigned int flags);
 
+void mfd_assert_add_seals(int fd, unsigned int seals);
+void mfd_assert_has_seals(int fd, unsigned int seals);
+unsigned int mfd_assert_get_seals(int fd);
+
 #endif
diff --git a/tools/testing/selftests/memfd/fuse_test.c b/tools/testing/selftests/memfd/fuse_test.c
index b018e835737d..70df77ac1386 100644
--- a/tools/testing/selftests/memfd/fuse_test.c
+++ b/tools/testing/selftests/memfd/fuse_test.c
@@ -20,7 +20,6 @@
 #include <inttypes.h>
 #include <limits.h>
 #include <linux/falloc.h>
-#include <linux/fcntl.h>
 #include <linux/memfd.h>
 #include <sched.h>
 #include <stdio.h>
@@ -28,9 +27,11 @@
 #include <signal.h>
 #include <string.h>
 #include <sys/mman.h>
+#include <sys/types.h>
 #include <sys/stat.h>
 #include <sys/syscall.h>
 #include <sys/wait.h>
+#include <fcntl.h>
 #include <unistd.h>
 
 #include "common.h"
@@ -60,49 +61,10 @@ static int mfd_assert_new(const char *name, loff_t sz, unsigned int flags)
 	return fd;
 }
 
-static __u64 mfd_assert_get_seals(int fd)
+static int mfd_busy_add_seals(int fd, unsigned int seals)
 {
 	long r;
-
-	r = fcntl(fd, F_GET_SEALS);
-	if (r < 0) {
-		printf("GET_SEALS(%d) failed: %m\n", fd);
-		abort();
-	}
-
-	return r;
-}
-
-static void mfd_assert_has_seals(int fd, __u64 seals)
-{
-	__u64 s;
-
-	s = mfd_assert_get_seals(fd);
-	if (s != seals) {
-		printf("%llu != %llu = GET_SEALS(%d)\n",
-		       (unsigned long long)seals, (unsigned long long)s, fd);
-		abort();
-	}
-}
-
-static void mfd_assert_add_seals(int fd, __u64 seals)
-{
-	long r;
-	__u64 s;
-
-	s = mfd_assert_get_seals(fd);
-	r = fcntl(fd, F_ADD_SEALS, seals);
-	if (r < 0) {
-		printf("ADD_SEALS(%d, %llu -> %llu) failed: %m\n",
-		       fd, (unsigned long long)s, (unsigned long long)seals);
-		abort();
-	}
-}
-
-static int mfd_busy_add_seals(int fd, __u64 seals)
-{
-	long r;
-	__u64 s;
+	unsigned int s;
 
 	r = fcntl(fd, F_GET_SEALS);
 	if (r < 0)
diff --git a/tools/testing/selftests/memfd/memfd_test.c b/tools/testing/selftests/memfd/memfd_test.c
index 0dbeb29c094c..af722a639a64 100644
--- a/tools/testing/selftests/memfd/memfd_test.c
+++ b/tools/testing/selftests/memfd/memfd_test.c
@@ -22,28 +22,6 @@
 
 #include "common.h"
 
-#ifndef F_LINUX_SPECIFIC_BASE
-#    define F_LINUX_SPECIFIC_BASE      1024
-#endif
-#ifndef F_ADD_SEALS
-#    define F_ADD_SEALS        (F_LINUX_SPECIFIC_BASE + 9)
-#endif
-#ifndef F_GET_SEALS
-#    define F_GET_SEALS        (F_LINUX_SPECIFIC_BASE + 10)
-#endif
-#ifndef F_SEAL_SEAL
-#    define F_SEAL_SEAL        0x0001 /* prevent further seals from being set */
-#endif
-#ifndef F_SEAL_SHRINK
-#    define F_SEAL_SHRINK      0x0002 /* prevent file from shrinking */
-#endif
-#ifndef F_SEAL_GROW
-#    define F_SEAL_GROW        0x0004 /* prevent file from growing */
-#endif
-#ifndef F_SEAL_WRITE
-#    define F_SEAL_WRITE       0x0008 /* prevent writes */
-#endif
-
 #define MEMFD_STR	"memfd:"
 #define MEMFD_HUGE_STR	"memfd-hugetlb:"
 #define SHARED_FT_STR	"(shared file-table)"
@@ -90,43 +68,6 @@ static void mfd_fail_new(const char *name, unsigned int flags)
 	}
 }
 
-static unsigned int mfd_assert_get_seals(int fd)
-{
-	int r;
-
-	r = fcntl(fd, F_GET_SEALS);
-	if (r < 0) {
-		printf("GET_SEALS(%d) failed: %m\n", fd);
-		abort();
-	}
-
-	return (unsigned int)r;
-}
-
-static void mfd_assert_has_seals(int fd, unsigned int seals)
-{
-	unsigned int s;
-
-	s = mfd_assert_get_seals(fd);
-	if (s != seals) {
-		printf("%u != %u = GET_SEALS(%d)\n", seals, s, fd);
-		abort();
-	}
-}
-
-static void mfd_assert_add_seals(int fd, unsigned int seals)
-{
-	int r;
-	unsigned int s;
-
-	s = mfd_assert_get_seals(fd);
-	r = fcntl(fd, F_ADD_SEALS, seals);
-	if (r < 0) {
-		printf("ADD_SEALS(%d, %u -> %u) failed: %m\n", fd, s, seals);
-		abort();
-	}
-}
-
 static void mfd_fail_add_seals(int fd, unsigned int seals)
 {
 	int r;
-- 
2.11.0

