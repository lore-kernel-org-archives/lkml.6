Return-Path: <SRS0=71UW=JV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 619EFC6778C
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 08:29:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 25D5424195
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 08:29:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 25D5424195
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=c-s.fr
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753432AbeGEI3E (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Jul 2018 04:29:04 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:60474 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753207AbeGEI3C (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jul 2018 04:29:02 -0400
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 41LrcC57P9z9ttgB;
        Thu,  5 Jul 2018 10:28:59 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id qgDNgV8DM_sw; Thu,  5 Jul 2018 10:28:59 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 41LrcC4d7Sz9ttg7;
        Thu,  5 Jul 2018 10:28:59 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id CB4AC8B7C3;
        Thu,  5 Jul 2018 10:29:00 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id JLn1W5u0za59; Thu,  5 Jul 2018 10:29:00 +0200 (CEST)
Received: from po14934vm.idsi0.si.c-s.fr (po15451.idsi0.si.c-s.fr [172.25.231.4])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id A29528B7BC;
        Thu,  5 Jul 2018 10:29:00 +0200 (CEST)
Received: by po14934vm.idsi0.si.c-s.fr (Postfix, from userid 0)
        id 9F1516FFC6; Thu,  5 Jul 2018 08:29:00 +0000 (UTC)
Message-Id: <1abe816b610944b1ea685f2429422d0b1c33e525.1530777873.git.christophe.leroy@c-s.fr>
In-Reply-To: <9f98f2bd0e9948b8042773f6190c0416d2577b5e.1530777873.git.christophe.leroy@c-s.fr>
References: <9f98f2bd0e9948b8042773f6190c0416d2577b5e.1530777873.git.christophe.leroy@c-s.fr>
From:   Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH v7 2/4] selftests/powerpc: Add test for strlen()
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>, wei.guo.simon@gmail.com,
        segher@kernel.crashing.org
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date:   Thu,  5 Jul 2018 08:29:00 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds a test for strlen()

string.c contains a copy of strlen() from lib/string.c

The test first tests the correctness of strlen() by comparing
the result with libc strlen(). It tests all cases of alignment.

It them tests the duration of an aligned strlen() on a 4 bytes string,
on a 16 bytes string and on a 256 bytes string.

Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
---
 v7: no change
 v6: refactorised the benchmark test
 v5: no change
 v4: new

 .../testing/selftests/powerpc/stringloops/Makefile |   5 +-
 .../testing/selftests/powerpc/stringloops/string.c |  36 ++++++
 .../testing/selftests/powerpc/stringloops/strlen.c | 127 +++++++++++++++++++++
 3 files changed, 167 insertions(+), 1 deletion(-)
 create mode 100644 tools/testing/selftests/powerpc/stringloops/string.c
 create mode 100644 tools/testing/selftests/powerpc/stringloops/strlen.c

diff --git a/tools/testing/selftests/powerpc/stringloops/Makefile b/tools/testing/selftests/powerpc/stringloops/Makefile
index 1e7301d4bac9..df663ee9ddb3 100644
--- a/tools/testing/selftests/powerpc/stringloops/Makefile
+++ b/tools/testing/selftests/powerpc/stringloops/Makefile
@@ -10,9 +10,12 @@ $(OUTPUT)/memcmp_64: CFLAGS += -m64
 $(OUTPUT)/memcmp_32: memcmp.c
 $(OUTPUT)/memcmp_32: CFLAGS += -m32
 
+$(OUTPUT)/strlen: strlen.c string.o
+$(OUTPUT)/string.o: string.c
+
 ASFLAGS = $(CFLAGS)
 
-TEST_GEN_PROGS := memcmp_32 memcmp_64
+TEST_GEN_PROGS := memcmp_32 memcmp_64 strlen
 
 include ../../lib.mk
 
diff --git a/tools/testing/selftests/powerpc/stringloops/string.c b/tools/testing/selftests/powerpc/stringloops/string.c
new file mode 100644
index 000000000000..d05200481017
--- /dev/null
+++ b/tools/testing/selftests/powerpc/stringloops/string.c
@@ -0,0 +1,36 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ *  linux/lib/string.c
+ *
+ *  Copyright (C) 1991, 1992  Linus Torvalds
+ */
+
+/*
+ * stupid library routines.. The optimized versions should generally be found
+ * as inline code in <asm-xx/string.h>
+ *
+ * These are buggy as well..
+ *
+ * * Fri Jun 25 1999, Ingo Oeser <ioe@informatik.tu-chemnitz.de>
+ * -  Added strsep() which will replace strtok() soon (because strsep() is
+ *    reentrant and should be faster). Use only strsep() in new code, please.
+ *
+ * * Sat Feb 09 2002, Jason Thomas <jason@topic.com.au>,
+ *                    Matthew Hawkins <matt@mh.dropbear.id.au>
+ * -  Kissed strtok() goodbye
+ */
+
+#include <stddef.h>
+
+/**
+ * strlen - Find the length of a string
+ * @s: The string to be sized
+ */
+size_t test_strlen(const char *s)
+{
+	const char *sc;
+
+	for (sc = s; *sc != '\0'; ++sc)
+		/* nothing */;
+	return sc - s;
+}
diff --git a/tools/testing/selftests/powerpc/stringloops/strlen.c b/tools/testing/selftests/powerpc/stringloops/strlen.c
new file mode 100644
index 000000000000..9055ebc484d0
--- /dev/null
+++ b/tools/testing/selftests/powerpc/stringloops/strlen.c
@@ -0,0 +1,127 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <malloc.h>
+#include <stdlib.h>
+#include <string.h>
+#include <time.h>
+#include "utils.h"
+
+#define SIZE 256
+#define ITERATIONS 1000
+#define ITERATIONS_BENCH 100000
+
+int test_strlen(const void *s);
+
+/* test all offsets and lengths */
+static void test_one(char *s)
+{
+	unsigned long offset;
+
+	for (offset = 0; offset < SIZE; offset++) {
+		int x, y;
+		unsigned long i;
+
+		y = strlen(s + offset);
+		x = test_strlen(s + offset);
+
+		if (x != y) {
+			printf("strlen() returned %d, should have returned %d (%p offset %ld)\n", x, y, s, offset);
+
+			for (i = offset; i < SIZE; i++)
+				printf("%02x ", s[i]);
+			printf("\n");
+		}
+	}
+}
+
+static void bench_test(char *s)
+{
+	struct timespec ts_start, ts_end;
+	int i;
+
+	clock_gettime(CLOCK_MONOTONIC, &ts_start);
+
+	for (i = 0; i < ITERATIONS_BENCH; i++)
+		test_strlen(s);
+
+	clock_gettime(CLOCK_MONOTONIC, &ts_end);
+
+	printf("len %3.3d : time = %.6f\n", test_strlen(s), ts_end.tv_sec - ts_start.tv_sec + (ts_end.tv_nsec - ts_start.tv_nsec) / 1e9);
+}
+
+static int testcase(void)
+{
+	char *s;
+	unsigned long i;
+
+	s = memalign(128, SIZE);
+	if (!s) {
+		perror("memalign");
+		exit(1);
+	}
+
+	srandom(1);
+
+	memset(s, 0, SIZE);
+	for (i = 0; i < SIZE; i++) {
+		char c;
+
+		do {
+			c = random() & 0x7f;
+		} while (!c);
+		s[i] = c;
+		test_one(s);
+	}
+
+	for (i = 0; i < ITERATIONS; i++) {
+		unsigned long j;
+
+		for (j = 0; j < SIZE; j++) {
+			char c;
+
+			do {
+				c = random() & 0x7f;
+			} while (!c);
+			s[j] = c;
+		}
+		for (j = 0; j < sizeof(long); j++) {
+			s[SIZE - 1 - j] = 0;
+			test_one(s);
+		}
+	}
+
+	for (i = 0; i < SIZE; i++) {
+		char c;
+
+		do {
+			c = random() & 0x7f;
+		} while (!c);
+		s[i] = c;
+	}
+
+	bench_test(s);
+
+	s[16] = 0;
+	bench_test(s);
+
+	s[8] = 0;
+	bench_test(s);
+
+	s[4] = 0;
+	bench_test(s);
+
+	s[3] = 0;
+	bench_test(s);
+
+	s[2] = 0;
+	bench_test(s);
+
+	s[1] = 0;
+	bench_test(s);
+
+	return 0;
+}
+
+int main(void)
+{
+	return test_harness(testcase, "strlen");
+}
-- 
2.13.3

