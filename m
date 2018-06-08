Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id KsrlJmOEGluvdAAAmS7hNA
	; Fri, 08 Jun 2018 13:28:03 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 8BD53607E4; Fri,  8 Jun 2018 13:28:03 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,MAILING_LIST_MULTI
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id A5471607DC;
	Fri,  8 Jun 2018 13:28:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org A5471607DC
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=c-s.fr
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752716AbeFHN1r (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Fri, 8 Jun 2018 09:27:47 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:53068 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752148AbeFHN1o (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jun 2018 09:27:44 -0400
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 412NWD1Ks6z9ty8Q;
        Fri,  8 Jun 2018 15:27:36 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id s7iegNX0j8uU; Fri,  8 Jun 2018 15:27:36 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 412NWD0lMQz9ty8M;
        Fri,  8 Jun 2018 15:27:36 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 5BD208BB62;
        Fri,  8 Jun 2018 15:27:37 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id DmMEgrgw9zxV; Fri,  8 Jun 2018 15:27:37 +0200 (CEST)
Received: from po14934vm.idsi0.si.c-s.fr (po15451.idsi0.si.c-s.fr [172.25.231.2])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 28B758BB5D;
        Fri,  8 Jun 2018 15:27:37 +0200 (CEST)
Received: by po14934vm.idsi0.si.c-s.fr (Postfix, from userid 0)
        id 205E86F846; Fri,  8 Jun 2018 13:27:37 +0000 (UTC)
Message-Id: <8581e4d6076a9791e94b43ec693196d3e89bcf91.1528463979.git.christophe.leroy@c-s.fr>
In-Reply-To: <85de16f5629ac9f4a815230cced361908758b53a.1528463979.git.christophe.leroy@c-s.fr>
References: <85de16f5629ac9f4a815230cced361908758b53a.1528463979.git.christophe.leroy@c-s.fr>
From: Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH v5 2/4] selftests/powerpc: Add test for strlen()
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>, wei.guo.simon@gmail.com
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date: Fri,  8 Jun 2018 13:27:37 +0000 (UTC)
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
 v5: no change
 v4: new

 .../testing/selftests/powerpc/stringloops/Makefile |   5 +-
 .../testing/selftests/powerpc/stringloops/string.c |  36 ++++++
 .../testing/selftests/powerpc/stringloops/strlen.c | 123 +++++++++++++++++++++
 3 files changed, 163 insertions(+), 1 deletion(-)
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
index 000000000000..e87ca65ea156
--- /dev/null
+++ b/tools/testing/selftests/powerpc/stringloops/strlen.c
@@ -0,0 +1,123 @@
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
+static int testcase(void)
+{
+	char *s;
+	unsigned long i;
+	struct timespec ts_start, ts_end;
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
+	clock_gettime(CLOCK_MONOTONIC, &ts_start);
+
+	s[SIZE - 1] = 0;
+	for (i = 0; i < ITERATIONS_BENCH; i++)
+		test_strlen(s);
+
+	clock_gettime(CLOCK_MONOTONIC, &ts_end);
+
+	printf("len %3.3d : time = %.6f\n", SIZE, ts_end.tv_sec - ts_start.tv_sec + (ts_end.tv_nsec - ts_start.tv_nsec) / 1e9);
+
+	clock_gettime(CLOCK_MONOTONIC, &ts_start);
+
+	s[16] = 0;
+	for (i = 0; i < ITERATIONS_BENCH; i++)
+		test_strlen(s);
+
+	clock_gettime(CLOCK_MONOTONIC, &ts_end);
+
+	printf("len 16  : time = %.6f\n", ts_end.tv_sec - ts_start.tv_sec + (ts_end.tv_nsec - ts_start.tv_nsec) / 1e9);
+
+	clock_gettime(CLOCK_MONOTONIC, &ts_start);
+
+	s[4] = 0;
+	for (i = 0; i < ITERATIONS_BENCH; i++)
+		test_strlen(s);
+
+	clock_gettime(CLOCK_MONOTONIC, &ts_end);
+
+	printf("len 4   : time = %.6f\n", ts_end.tv_sec - ts_start.tv_sec + (ts_end.tv_nsec - ts_start.tv_nsec) / 1e9);
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
