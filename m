Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Google-Smtp-Source: AIpwx49crpxddzN++vPZWRjk2kDyRUgvei0u5hrztY5XfJCiljgrmdi7en7cNJkou6+LPZycNpCR
ARC-Seal: i=1; a=rsa-sha256; t=1523528613; cv=none;
        d=google.com; s=arc-20160816;
        b=Rqqpsx4PpgszYRYIa9GIjK1xAPJIVuUE8oMsLtwWCmZy4FPmsw5VlojP24s2c+WSaL
         E8yrQtqm1KxB4uc6V/kkySfYVr7jYHzTl17BPvxQIlze4PTzRHBWHc9gxJCGhYWakopn
         mBIcFvyvEMm7P85GS2YIfprO4MRpggPZcpUP/hM69KJS5W6S0fBlWAFj2ivHCYH7fmTy
         VJWoE5t6chpHYJ2tcWTO/5ueMAO2GY+Oay4K0wFkjLZI1GQwb4nRQa52vLC0RLOkp78D
         M+zADNnE85UAQ/InTdW6krJGlDiVay1Sl6YHUVlBI9E+5vnL4xJc/7cP+VH2FpEBHPgk
         4edw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=list-id:precedence:sender:message-id:date:subject:cc:to:from
         :dkim-signature:arc-authentication-results;
        bh=Id1OQ5ez5lATV2e4gVWS0nvE6Gr1QCermEdrCAr0Djs=;
        b=i1FigzUedFGO3/s+7iJyv1VsaFalG2w2t3LavN9gr7Xq34GAhdX1thF0N04mQZC49A
         omyiVz18W8YGn24YkXHt405WKMlPzCq20XQgq6QIC6etv/dciCWsoZEbkFkW1rdlw2HS
         KlGRWD4vpyUQVEI/cTO7uBrnFaqJa0BYHGv2hhJXyP9mcPCcfZR9J/uDRMH1/vBBytL0
         PDJ3UO7Itrwx01dPkqIn16yMHsrGmqIWrGY7QlI3XOuhCTM2QMbEEh7ycFG8cKLWsick
         tKXONukzzGsIeSEmTjfF9+//KDCswbqVcV2l3jaz1t+RgXYR+QoUNILn+hJZ4tYtHh1p
         A5Fw==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=neutral (body hash did not verify) header.i=@linaro.org header.s=google header.b=XKQfezgx;
       spf=pass (google.com: best guess record for domain of linux-kselftest-owner@vger.kernel.org designates 209.132.180.67 as permitted sender) smtp.mailfrom=linux-kselftest-owner@vger.kernel.org;
       dmarc=fail (p=NONE sp=NONE dis=NONE) header.from=linaro.org
Authentication-Results: mx.google.com;
       dkim=neutral (body hash did not verify) header.i=@linaro.org header.s=google header.b=XKQfezgx;
       spf=pass (google.com: best guess record for domain of linux-kselftest-owner@vger.kernel.org designates 209.132.180.67 as permitted sender) smtp.mailfrom=linux-kselftest-owner@vger.kernel.org;
       dmarc=fail (p=NONE sp=NONE dis=NONE) header.from=linaro.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752713AbeDLKXU (ORCPT <rfc822;gregkh@linuxfoundation.org>);
        Thu, 12 Apr 2018 06:23:20 -0400
Received: from mail-lf0-f66.google.com ([209.85.215.66]:46816 "EHLO
        mail-lf0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752552AbeDLKXS (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 12 Apr 2018 06:23:18 -0400
From: Anders Roxell <anders.roxell@linaro.org>
To: shuah@kernel.org
Cc: linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, linux-gpio@vger.kernel.org,
        fathi.boudra@linaro.org, Anders Roxell <anders.roxell@linaro.org>
Subject: [PATCH] selftests: add headers_install to lib.mk
Date: Thu, 12 Apr 2018 12:23:02 +0200
Message-Id: <20180412102302.4532-1-anders.roxell@linaro.org>
X-Mailer: git-send-email 2.16.3
Sender: linux-kselftest-owner@vger.kernel.org
X-Mailing-List: linux-kselftest@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1597535540200601816?=
X-GMAIL-MSGID: =?utf-8?q?1597535540200601816?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

If the kernel headers aren't installed we can't build all the tests.
Add a new make target rule 'khdr' in the file lib.mk to generate the
kernel headers and that gets include for every test-dir Makefile that
includes lib.mk If the testdir in turn have its own sub-dirs the
top_srcdir needs to be set to the linux-rootdir to be able to generate
the kernel headers.

Signed-off-by: Anders Roxell <anders.roxell@linaro.org>
Reviewed-by: Fathi Boudra <fathi.boudra@linaro.org>
---
 tools/testing/selftests/android/Makefile          | 2 +-
 tools/testing/selftests/android/ion/Makefile      | 1 +
 tools/testing/selftests/bpf/Makefile              | 5 ++---
 tools/testing/selftests/futex/functional/Makefile | 1 +
 tools/testing/selftests/gpio/Makefile             | 4 ----
 tools/testing/selftests/kvm/Makefile              | 6 +-----
 tools/testing/selftests/lib.mk                    | 8 ++++++++
 tools/testing/selftests/vm/Makefile               | 3 ---
 8 files changed, 14 insertions(+), 16 deletions(-)

diff --git a/tools/testing/selftests/android/Makefile b/tools/testing/selftests/android/Makefile
index f6304d2be90c..087390bbad68 100644
--- a/tools/testing/selftests/android/Makefile
+++ b/tools/testing/selftests/android/Makefile
@@ -6,7 +6,7 @@ TEST_PROGS := run.sh
 
 include ../lib.mk
 
-all:
+all: khdr
 	@for DIR in $(SUBDIRS); do		\
 		BUILD_TARGET=$(OUTPUT)/$$DIR;	\
 		mkdir $$BUILD_TARGET  -p;	\
diff --git a/tools/testing/selftests/android/ion/Makefile b/tools/testing/selftests/android/ion/Makefile
index e03695287f76..14ecd9805748 100644
--- a/tools/testing/selftests/android/ion/Makefile
+++ b/tools/testing/selftests/android/ion/Makefile
@@ -11,6 +11,7 @@ $(TEST_GEN_FILES): ipcsocket.c ionutils.c
 TEST_PROGS := ion_test.sh
 
 include ../../lib.mk
+top_srcdir = ../../../../../
 
 $(OUTPUT)/ionapp_export: ionapp_export.c ipcsocket.c ionutils.c
 $(OUTPUT)/ionapp_import: ionapp_import.c ipcsocket.c ionutils.c
diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftests/bpf/Makefile
index 0a315ddabbf4..cc611a284087 100644
--- a/tools/testing/selftests/bpf/Makefile
+++ b/tools/testing/selftests/bpf/Makefile
@@ -16,9 +16,8 @@ LDLIBS += -lcap -lelf -lrt -lpthread
 TEST_CUSTOM_PROGS = $(OUTPUT)/urandom_read
 all: $(TEST_CUSTOM_PROGS)
 
-$(TEST_CUSTOM_PROGS): urandom_read
-
-urandom_read: urandom_read.c
+$(TEST_CUSTOM_PROGS):| khdr
+$(TEST_CUSTOM_PROGS): urandom_read.c
 	$(CC) -o $(TEST_CUSTOM_PROGS) -static $<
 
 # Order correspond to 'make run_tests' order
diff --git a/tools/testing/selftests/futex/functional/Makefile b/tools/testing/selftests/futex/functional/Makefile
index ff8feca49746..9f602fb40241 100644
--- a/tools/testing/selftests/futex/functional/Makefile
+++ b/tools/testing/selftests/futex/functional/Makefile
@@ -19,5 +19,6 @@ TEST_GEN_FILES := \
 TEST_PROGS := run.sh
 
 include ../../lib.mk
+top_srcdir = ../../../../../
 
 $(TEST_GEN_FILES): $(HEADERS)
diff --git a/tools/testing/selftests/gpio/Makefile b/tools/testing/selftests/gpio/Makefile
index 1bbb47565c55..768b2be010db 100644
--- a/tools/testing/selftests/gpio/Makefile
+++ b/tools/testing/selftests/gpio/Makefile
@@ -25,7 +25,3 @@ $(BINARIES): ../../../gpio/gpio-utils.o ../../../../usr/include/linux/gpio.h
 
 ../../../gpio/gpio-utils.o:
 	make ARCH=$(ARCH) CROSS_COMPILE=$(CROSS_COMPILE) -C ../../../gpio
-
-../../../../usr/include/linux/gpio.h:
-	make -C ../../../.. headers_install INSTALL_HDR_PATH=$(shell pwd)/../../../../usr/
-
diff --git a/tools/testing/selftests/kvm/Makefile b/tools/testing/selftests/kvm/Makefile
index dc44de904797..ba03ce334212 100644
--- a/tools/testing/selftests/kvm/Makefile
+++ b/tools/testing/selftests/kvm/Makefile
@@ -31,9 +31,5 @@ $(LIBKVM_OBJ): $(OUTPUT)/%.o: %.c
 $(OUTPUT)/libkvm.a: $(LIBKVM_OBJ)
 	$(AR) crs $@ $^
 
-$(LINUX_HDR_PATH):
-	make -C $(top_srcdir) headers_install
-
-all: $(STATIC_LIBS) $(LINUX_HDR_PATH)
+all: $(STATIC_LIBS)
 $(TEST_GEN_PROGS): $(STATIC_LIBS)
-$(TEST_GEN_PROGS) $(LIBKVM_OBJ): | $(LINUX_HDR_PATH)
diff --git a/tools/testing/selftests/lib.mk b/tools/testing/selftests/lib.mk
index 195e9d4739a9..e0bfbc5b1f1f 100644
--- a/tools/testing/selftests/lib.mk
+++ b/tools/testing/selftests/lib.mk
@@ -16,8 +16,16 @@ TEST_GEN_PROGS := $(patsubst %,$(OUTPUT)/%,$(TEST_GEN_PROGS))
 TEST_GEN_PROGS_EXTENDED := $(patsubst %,$(OUTPUT)/%,$(TEST_GEN_PROGS_EXTENDED))
 TEST_GEN_FILES := $(patsubst %,$(OUTPUT)/%,$(TEST_GEN_FILES))
 
+top_srcdir ?= ../../../../
+
 all: $(TEST_GEN_PROGS) $(TEST_GEN_PROGS_EXTENDED) $(TEST_GEN_FILES)
 
+.PHONY: khdr
+khdr:
+	make -C $(top_srcdir) headers_install
+
+$(TEST_GEN_PROGS) $(TEST_GEN_PROGS_EXTENDED) $(TEST_GEN_FILES):| khdr
+
 .ONESHELL:
 define RUN_TESTS
 	@export KSFT_TAP_LEVEL=`echo 1`;
diff --git a/tools/testing/selftests/vm/Makefile b/tools/testing/selftests/vm/Makefile
index fdefa2295ddc..1e34a40745ef 100644
--- a/tools/testing/selftests/vm/Makefile
+++ b/tools/testing/selftests/vm/Makefile
@@ -29,6 +29,3 @@ $(OUTPUT)/userfaultfd: ../../../../usr/include/linux/kernel.h
 $(OUTPUT)/userfaultfd: LDLIBS += -lpthread
 
 $(OUTPUT)/mlock-random-test: LDLIBS += -lcap
-
-../../../../usr/include/linux/kernel.h:
-	make -C ../../../.. headers_install
-- 
2.16.3

