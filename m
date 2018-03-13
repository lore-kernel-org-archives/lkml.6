Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Google-Smtp-Source: AG47ELuQzXG9cf25elp+c4viXbMOpbE17dgGrmftFGqZEjOtTqS2VjPBseQ5Pl4DCMZvqyViTB22
ARC-Seal: i=1; a=rsa-sha256; t=1520941332; cv=none;
        d=google.com; s=arc-20160816;
        b=JT2rnYXqqE8M9R1itMmBqCrAMRTaxGvS0+JIR/g6iyaOIaRDdpSDfIYLxBub/ZkUp8
         VTFMfyxXp07+JOB7bZn4OqL2K0PtIGkqWVyVrz3mcoIDaFf9madovypJGtd4ugLv4+Rn
         AAx7KYXjbf0e+BbD396xLXs2Z0eIlNJBuu3q+gcsgTOg2CoH3POw1Vrpi0YDfmBIAn1C
         PX2FjWP7QnbZBX9jNbG7IJhIDYkgVy0WjL5KWZxjFm1X65kLGs7bXRIZyxmsl7ySqz88
         zqSVC9ECLhew36Lt0FcJCae/3sQ0fcvRRZOd9znn0/R0Bdm+wkLClc1kycwb0qd20CDi
         Y/lQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=list-id:precedence:sender:content-transfer-encoding:mime-version
         :message-id:date:subject:cc:to:from:dkim-signature
         :arc-authentication-results;
        bh=nTMNTonWtRGkIJWfRPROCQwOHZiO6DLgvjjTo+Foelc=;
        b=EW9HvdxqCCuudniRKPdHlVmcGcZpIOxrF3SYbp3Kp33Qmybh1qVkOUTsIUBbcFej4G
         EGNRZ1FkJ9tNiVLVwhZ8T5iebEYtd20vWDe7xwO3nXvlpg6QmcYUFlM9u0wwzk8u8vDg
         NyxKvtvCeSwFYGxTv5S9fYvkSlsEM9dYS4Js0y6b4a69ZHVAq8sWzqTy6oDa1fHqPTml
         QJMArTZ4mKbeZ5uXRnUmYMxhVc3z1RIMmmz7d/aLpGUXnAy88UG4YvOi1g30GRDmEYPt
         eMEbcpv8YtbgyOuZeIlGMPMiKSRlJgjbNiYFjOWZ5Im6ctHAvjlmUMhTxit1N5TjXWLz
         9ByQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=neutral (body hash did not verify) header.i=@linaro.org header.s=google header.b=idlzWbUR;
       spf=pass (google.com: best guess record for domain of linux-kselftest-owner@vger.kernel.org designates 209.132.180.67 as permitted sender) smtp.mailfrom=linux-kselftest-owner@vger.kernel.org;
       dmarc=fail (p=NONE sp=NONE dis=NONE) header.from=linaro.org
Authentication-Results: mx.google.com;
       dkim=neutral (body hash did not verify) header.i=@linaro.org header.s=google header.b=idlzWbUR;
       spf=pass (google.com: best guess record for domain of linux-kselftest-owner@vger.kernel.org designates 209.132.180.67 as permitted sender) smtp.mailfrom=linux-kselftest-owner@vger.kernel.org;
       dmarc=fail (p=NONE sp=NONE dis=NONE) header.from=linaro.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932904AbeCMLmL (ORCPT <rfc822;gregkh@linuxfoundation.org>);
        Tue, 13 Mar 2018 07:42:11 -0400
Received: from mail-lf0-f66.google.com ([209.85.215.66]:42990 "EHLO
        mail-lf0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932892AbeCMLmK (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 13 Mar 2018 07:42:10 -0400
From: Anders Roxell <anders.roxell@linaro.org>
To: shuah@kernel.org
Cc: linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        dh.herrmann@gmail.com, Anders Roxell <anders.roxell@linaro.org>
Subject: [PATCH 1/2] selftests/memfd/memfd_test.c: fix implicit declaration
Date: Tue, 13 Mar 2018 12:42:04 +0100
Message-Id: <20180313114205.27714-1-anders.roxell@linaro.org>
X-Mailer: git-send-email 2.11.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kselftest-owner@vger.kernel.org
X-Mailing-List: linux-kselftest@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594822578193743011?=
X-GMAIL-MSGID: =?utf-8?q?1594822578193743011?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

gcc warns about implicit declaration.

gcc -D_FILE_OFFSET_BITS=64 -I../../../../include/uapi/
    -I../../../../include/ -I../../../../usr/include/
    memfd_test.c common.o  -o memfd_test
memfd_test.c: In function ‘mfd_assert_get_seals’:
memfd_test.c:74:6: warning: implicit declaration of function ‘fcntl’
    [-Wimplicit-function-declaration]
  r = fcntl(fd, F_GET_SEALS);
      ^~~~~
memfd_test.c: In function ‘mfd_assert_open’:
memfd_test.c:197:6: warning: implicit declaration of function ‘open’
    [-Wimplicit-function-declaration]
  r = open(buf, flags, mode);
      ^~~~
memfd_test.c: In function ‘mfd_assert_write’:
memfd_test.c:328:6: warning: implicit declaration of function ‘fallocate’
    [-Wimplicit-function-declaration]
  r = fallocate(fd,
      ^~~~~~~~~

In the current code, we include the headers that the functions want
according to the man pages, and we add some defines that will be used if
they isn't found in glibc.  The defines was added into the kernel source
in kernel >= 3.16 and glibc requires kernel header files >= 3.2.

Fixes: 4f5ce5e8d7e2 ("selftests: add memfd_create() + sealing tests")
Signed-off-by: Anders Roxell <anders.roxell@linaro.org>
---
 tools/testing/selftests/memfd/memfd_test.c | 25 ++++++++++++++++++++++++-
 1 file changed, 24 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/memfd/memfd_test.c b/tools/testing/selftests/memfd/memfd_test.c
index 10baa1652fc2..0dbeb29c094c 100644
--- a/tools/testing/selftests/memfd/memfd_test.c
+++ b/tools/testing/selftests/memfd/memfd_test.c
@@ -6,7 +6,6 @@
 #include <inttypes.h>
 #include <limits.h>
 #include <linux/falloc.h>
-#include <linux/fcntl.h>
 #include <linux/memfd.h>
 #include <sched.h>
 #include <stdio.h>
@@ -14,13 +13,37 @@
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
 #define MEMFD_STR	"memfd:"
 #define MEMFD_HUGE_STR	"memfd-hugetlb:"
 #define SHARED_FT_STR	"(shared file-table)"
-- 
2.11.0

