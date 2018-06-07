Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id IGI0FAkSGVsGLAAAmS7hNA
	; Thu, 07 Jun 2018 11:09:27 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id B3446607E7; Thu,  7 Jun 2018 11:09:27 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="W0xJb5NN"
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=2.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id C071F601C3;
	Thu,  7 Jun 2018 11:09:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org C071F601C3
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753562AbeFGLJZ (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Thu, 7 Jun 2018 07:09:25 -0400
Received: from mail-lf0-f68.google.com ([209.85.215.68]:40671 "EHLO
        mail-lf0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751974AbeFGLJW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jun 2018 07:09:22 -0400
Received: by mail-lf0-f68.google.com with SMTP id q11-v6so14021315lfc.7
        for <linux-kernel@vger.kernel.org>; Thu, 07 Jun 2018 04:09:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=AFXhYddk7eb+LAnEdRC9wWoDzHaenHeZ8rvWOiTnbKI=;
        b=W0xJb5NNLpPK2vnZ7v8WoQ02CTBOQ2GJawQpyTbX1o3HF5xNiseHeyv62RvxqgtDZI
         fKwT7Yj4pV4kTBKAg8fx0GbqMSbAU6O9Zw9bke9qs645uk0gCVFeK8eUi/Xd3aNKPtr6
         gIVgcw9gsYvcY2Q4tJbotKHDucADhKEs1RXGs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=AFXhYddk7eb+LAnEdRC9wWoDzHaenHeZ8rvWOiTnbKI=;
        b=aY3s8h6Ua5c1RZEi6HuLEUGS0C5JGivyCMwVroBanPA1FFLbg6tgF+W3QaQKyUapx0
         ca+2xSpDnnQvr2Zgh8SrcgGXvC4yhUx92/sUVgId9gDLxa3PQNGO8S88VZOJGuLIPhAl
         IFMIQ7/20m3csiHkTmFdLxwdICTzrB5BH0RyKBDyci5eyYfnnla8bP7rGK/A2exIJkVF
         cXhWsvPYOHv5OFaJSBdUq5H22TyTDigiL4jDZFDv9vf1VYfCXu7zQQobSn24EN/mfe3N
         vB+RyNSTGYk8cwLneRMlyJo8vosy0zsjQs/qwt4Lld+E/DPGqLLOSHqarflV43bEmh5p
         8otg==
X-Gm-Message-State: APt69E0ULTR7Ww2hTaaQNxxBhQLsJV7RJ9NPC/XzTqWFFy3mpHLO8hd7
        GRoVwBqpu5um4lo/Xr1RdRc0JA==
X-Google-Smtp-Source: ADUXVKIL2NFFE8MhGrGnLFP0eyyyy4DDODiQt0CYWcGI9TTPA1WXmleW4alST2ylN8p4o4OKES0hAA==
X-Received: by 2002:a19:7316:: with SMTP id o22-v6mr941495lfc.6.1528369761061;
        Thu, 07 Jun 2018 04:09:21 -0700 (PDT)
Received: from localhost (c-2c3d70d5.07-21-73746f28.bbcust.telenor.se. [213.112.61.44])
        by smtp.gmail.com with ESMTPSA id h24-v6sm1900714lfc.63.2018.06.07.04.09.19
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 07 Jun 2018 04:09:20 -0700 (PDT)
From: Anders Roxell <anders.roxell@linaro.org>
To: yamada.masahiro@socionext.com, michal.lkml@markovi.net,
        shuah@kernel.org, bamv2005@gmail.com, brgl@bgdev.pl,
        pbonzini@redhat.com, akpm@linux-foundation.org,
        rppt@linux.vnet.ibm.com, aarcange@redhat.com
Cc: linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, netdev@vger.kernel.org,
        Anders Roxell <anders.roxell@linaro.org>
Subject: [PATCH v4] selftests: add headers_install to lib.mk
Date: Thu,  7 Jun 2018 13:09:11 +0200
Message-Id: <20180607110911.12252-1-anders.roxell@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180413090351.25662-1-anders.roxell@linaro.org>
References: <20180413090351.25662-1-anders.roxell@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If the kernel headers aren't installed we can't build all the tests.
Add a new make target rule 'khdr' in the file lib.mk to generate the
kernel headers and that gets include for every test-dir Makefile that
includes lib.mk If the testdir in turn have its own sub-dirs the
top_srcdir needs to be set to the linux-rootdir to be able to generate
the kernel headers.

Signed-off-by: Anders Roxell <anders.roxell@linaro.org>
Reviewed-by: Fathi Boudra <fathi.boudra@linaro.org>
---
 Makefile                                           | 14 +-------------
 scripts/subarch.include                            | 13 +++++++++++++
 tools/testing/selftests/android/Makefile           |  2 +-
 tools/testing/selftests/android/ion/Makefile       |  2 ++
 tools/testing/selftests/futex/functional/Makefile  |  1 +
 tools/testing/selftests/gpio/Makefile              |  7 ++-----
 tools/testing/selftests/kvm/Makefile               |  7 ++-----
 tools/testing/selftests/lib.mk                     | 12 ++++++++++++
 tools/testing/selftests/net/Makefile               |  1 +
 .../selftests/networking/timestamping/Makefile     |  1 +
 tools/testing/selftests/vm/Makefile                |  4 ----
 11 files changed, 36 insertions(+), 28 deletions(-)
 create mode 100644 scripts/subarch.include

diff --git a/Makefile b/Makefile
index 6b9aea95ae3a..8050072300fa 100644
--- a/Makefile
+++ b/Makefile
@@ -286,19 +286,7 @@ KERNELRELEASE = $(shell cat include/config/kernel.release 2> /dev/null)
 KERNELVERSION = $(VERSION)$(if $(PATCHLEVEL),.$(PATCHLEVEL)$(if $(SUBLEVEL),.$(SUBLEVEL)))$(EXTRAVERSION)
 export VERSION PATCHLEVEL SUBLEVEL KERNELRELEASE KERNELVERSION
 
-# SUBARCH tells the usermode build what the underlying arch is.  That is set
-# first, and if a usermode build is happening, the "ARCH=um" on the command
-# line overrides the setting of ARCH below.  If a native build is happening,
-# then ARCH is assigned, getting whatever value it gets normally, and
-# SUBARCH is subsequently ignored.
-
-SUBARCH := $(shell uname -m | sed -e s/i.86/x86/ -e s/x86_64/x86/ \
-				  -e s/sun4u/sparc64/ \
-				  -e s/arm.*/arm/ -e s/sa110/arm/ \
-				  -e s/s390x/s390/ -e s/parisc64/parisc/ \
-				  -e s/ppc.*/powerpc/ -e s/mips.*/mips/ \
-				  -e s/sh[234].*/sh/ -e s/aarch64.*/arm64/ \
-				  -e s/riscv.*/riscv/)
+include scripts/subarch.include
 
 # Cross compiling and selecting different set of gcc/bin-utils
 # ---------------------------------------------------------------------------
diff --git a/scripts/subarch.include b/scripts/subarch.include
new file mode 100644
index 000000000000..650682821126
--- /dev/null
+++ b/scripts/subarch.include
@@ -0,0 +1,13 @@
+# SUBARCH tells the usermode build what the underlying arch is.  That is set
+# first, and if a usermode build is happening, the "ARCH=um" on the command
+# line overrides the setting of ARCH below.  If a native build is happening,
+# then ARCH is assigned, getting whatever value it gets normally, and
+# SUBARCH is subsequently ignored.
+
+SUBARCH := $(shell uname -m | sed -e s/i.86/x86/ -e s/x86_64/x86/ \
+				  -e s/sun4u/sparc64/ \
+				  -e s/arm.*/arm/ -e s/sa110/arm/ \
+				  -e s/s390x/s390/ -e s/parisc64/parisc/ \
+				  -e s/ppc.*/powerpc/ -e s/mips.*/mips/ \
+				  -e s/sh[234].*/sh/ -e s/aarch64.*/arm64/ \
+				  -e s/riscv.*/riscv/)
diff --git a/tools/testing/selftests/android/Makefile b/tools/testing/selftests/android/Makefile
index 72c25a3cb658..d9a725478375 100644
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
index e03695287f76..88cfe88e466f 100644
--- a/tools/testing/selftests/android/ion/Makefile
+++ b/tools/testing/selftests/android/ion/Makefile
@@ -10,6 +10,8 @@ $(TEST_GEN_FILES): ipcsocket.c ionutils.c
 
 TEST_PROGS := ion_test.sh
 
+KSFT_KHDR_INSTALL := 1
+top_srcdir = ../../../../..
 include ../../lib.mk
 
 $(OUTPUT)/ionapp_export: ionapp_export.c ipcsocket.c ionutils.c
diff --git a/tools/testing/selftests/futex/functional/Makefile b/tools/testing/selftests/futex/functional/Makefile
index ff8feca49746..ad1eeb14fda7 100644
--- a/tools/testing/selftests/futex/functional/Makefile
+++ b/tools/testing/selftests/futex/functional/Makefile
@@ -18,6 +18,7 @@ TEST_GEN_FILES := \
 
 TEST_PROGS := run.sh
 
+top_srcdir = ../../../../..
 include ../../lib.mk
 
 $(TEST_GEN_FILES): $(HEADERS)
diff --git a/tools/testing/selftests/gpio/Makefile b/tools/testing/selftests/gpio/Makefile
index 1bbb47565c55..4665cdbf1a8d 100644
--- a/tools/testing/selftests/gpio/Makefile
+++ b/tools/testing/selftests/gpio/Makefile
@@ -21,11 +21,8 @@ endef
 CFLAGS += -O2 -g -std=gnu99 -Wall -I../../../../usr/include/
 LDLIBS += -lmount -I/usr/include/libmount
 
-$(BINARIES): ../../../gpio/gpio-utils.o ../../../../usr/include/linux/gpio.h
+$(BINARIES):| khdr
+$(BINARIES): ../../../gpio/gpio-utils.o
 
 ../../../gpio/gpio-utils.o:
 	make ARCH=$(ARCH) CROSS_COMPILE=$(CROSS_COMPILE) -C ../../../gpio
-
-../../../../usr/include/linux/gpio.h:
-	make -C ../../../.. headers_install INSTALL_HDR_PATH=$(shell pwd)/../../../../usr/
-
diff --git a/tools/testing/selftests/kvm/Makefile b/tools/testing/selftests/kvm/Makefile
index d9d00319b07c..bcb69380bbab 100644
--- a/tools/testing/selftests/kvm/Makefile
+++ b/tools/testing/selftests/kvm/Makefile
@@ -32,9 +32,6 @@ $(LIBKVM_OBJ): $(OUTPUT)/%.o: %.c
 $(OUTPUT)/libkvm.a: $(LIBKVM_OBJ)
 	$(AR) crs $@ $^
 
-$(LINUX_HDR_PATH):
-	make -C $(top_srcdir) headers_install
-
-all: $(STATIC_LIBS) $(LINUX_HDR_PATH)
+all: $(STATIC_LIBS)
 $(TEST_GEN_PROGS): $(STATIC_LIBS)
-$(TEST_GEN_PROGS) $(LIBKVM_OBJ): | $(LINUX_HDR_PATH)
+$(STATIC_LIBS):| khdr
diff --git a/tools/testing/selftests/lib.mk b/tools/testing/selftests/lib.mk
index 17ab36605a8e..0a8e75886224 100644
--- a/tools/testing/selftests/lib.mk
+++ b/tools/testing/selftests/lib.mk
@@ -16,8 +16,20 @@ TEST_GEN_PROGS := $(patsubst %,$(OUTPUT)/%,$(TEST_GEN_PROGS))
 TEST_GEN_PROGS_EXTENDED := $(patsubst %,$(OUTPUT)/%,$(TEST_GEN_PROGS_EXTENDED))
 TEST_GEN_FILES := $(patsubst %,$(OUTPUT)/%,$(TEST_GEN_FILES))
 
+top_srcdir ?= ../../../..
+include $(top_srcdir)/scripts/subarch.include
+ARCH		?= $(SUBARCH)
+
 all: $(TEST_GEN_PROGS) $(TEST_GEN_PROGS_EXTENDED) $(TEST_GEN_FILES)
 
+.PHONY: khdr
+khdr:
+	make ARCH=$(ARCH) -C $(top_srcdir) headers_install
+
+ifdef KSFT_KHDR_INSTALL
+$(TEST_GEN_PROGS) $(TEST_GEN_PROGS_EXTENDED) $(TEST_GEN_FILES):| khdr
+endif
+
 .ONESHELL:
 define RUN_TEST_PRINT_RESULT
 	TEST_HDR_MSG="selftests: "`basename $$PWD`:" $$BASENAME_TEST";	\
diff --git a/tools/testing/selftests/net/Makefile b/tools/testing/selftests/net/Makefile
index 663e11e85727..d515dabc6b0d 100644
--- a/tools/testing/selftests/net/Makefile
+++ b/tools/testing/selftests/net/Makefile
@@ -15,6 +15,7 @@ TEST_GEN_FILES += udpgso udpgso_bench_tx udpgso_bench_rx
 TEST_GEN_PROGS = reuseport_bpf reuseport_bpf_cpu reuseport_bpf_numa
 TEST_GEN_PROGS += reuseport_dualstack reuseaddr_conflict
 
+KSFT_KHDR_INSTALL := 1
 include ../lib.mk
 
 $(OUTPUT)/reuseport_bpf_numa: LDFLAGS += -lnuma
diff --git a/tools/testing/selftests/networking/timestamping/Makefile b/tools/testing/selftests/networking/timestamping/Makefile
index a728040edbe1..14cfcf006936 100644
--- a/tools/testing/selftests/networking/timestamping/Makefile
+++ b/tools/testing/selftests/networking/timestamping/Makefile
@@ -5,6 +5,7 @@ TEST_PROGS := hwtstamp_config rxtimestamp timestamping txtimestamp
 
 all: $(TEST_PROGS)
 
+top_srcdir = ../../../../..
 include ../../lib.mk
 
 clean:
diff --git a/tools/testing/selftests/vm/Makefile b/tools/testing/selftests/vm/Makefile
index fdefa2295ddc..58759454b1d0 100644
--- a/tools/testing/selftests/vm/Makefile
+++ b/tools/testing/selftests/vm/Makefile
@@ -25,10 +25,6 @@ TEST_PROGS := run_vmtests
 
 include ../lib.mk
 
-$(OUTPUT)/userfaultfd: ../../../../usr/include/linux/kernel.h
 $(OUTPUT)/userfaultfd: LDLIBS += -lpthread
 
 $(OUTPUT)/mlock-random-test: LDLIBS += -lcap
-
-../../../../usr/include/linux/kernel.h:
-	make -C ../../../.. headers_install
-- 
2.17.1
