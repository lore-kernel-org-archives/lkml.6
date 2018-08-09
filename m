Return-Path: <SRS0=+sa6=KY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 371DDC46464
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 08:04:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D696821C2B
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 08:04:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="FtSiWHt9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D696821C2B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729003AbeHIK2D (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Aug 2018 06:28:03 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:43012 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727237AbeHIK2C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Aug 2018 06:28:02 -0400
Received: by mail-lf1-f65.google.com with SMTP id f135-v6so3446237lfg.10
        for <linux-kernel@vger.kernel.org>; Thu, 09 Aug 2018 01:04:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=7WTclrGEYFttiKU/tkRSk3eitrGKcacl4PA+OwnByLo=;
        b=FtSiWHt9pKnQc6MKiwOG/MmoV3b9qhrGiv23QOfAqABoV/BvuM3qPf7gVxanMsc9DO
         +JwNk/lndB6aCtaOoM6kEN9Fx8hVVSj3+BKhhF2fLQnDvTnk7k/7t60v5AFrWMxLYRWI
         kv4Q4yfVVfOAWzRI2UgOFRa74RU2M2QFnw3Xw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=7WTclrGEYFttiKU/tkRSk3eitrGKcacl4PA+OwnByLo=;
        b=YxfoYC3OwyV/0e5wHjLHg+IJXO+dsr2uSwzFqtuH3q/T3s1hgqlrrY1p6qRNp4y+s4
         kLeXr/SgYvdYOYii5TOuvYegbGywtzokU+DqUZMZMv/VyAm3VZ1uH/nIBMWpYHx/8tNl
         VmdraGVHP2pu5MeSSKrXHe6XxzkQZZ8r/+ezzKHW5AbdsVw6Q7NuHpMYsCuRLxRYdQ55
         vlDddDO9/esVWmbxVtC/0Z2xVt35LPumFnkM4pYAD5A5nJi9ito7x2D5TiRis0FD61v7
         1bub9YVb45+UZy9xFSSrAQskJ3A0emwaFOPbwwBewB8/L9SD1TK2qGip6jQQxq24M67S
         +TxA==
X-Gm-Message-State: AOUpUlGG11TFuO+itEZx45Zbmn7VjSLTtTT2iqDCnqAgo5EDzIf2OOwr
        L0HT1J4ROnKOoCopFcrs4kQq9Q==
X-Google-Smtp-Source: AA+uWPyQZEVVg9NGAnrgTCR7og/YMbyZwTT6/CziGPQd7gMFrY4RIFQttQsoGxnJ3nAAfFyqXQazbg==
X-Received: by 2002:a19:12df:: with SMTP id 92-v6mr808879lfs.80.1533801859999;
        Thu, 09 Aug 2018 01:04:19 -0700 (PDT)
Received: from localhost (c-2c3d70d5.07-21-73746f28.bbcust.telenor.se. [213.112.61.44])
        by smtp.gmail.com with ESMTPSA id r63-v6sm1030606lja.18.2018.08.09.01.04.19
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 09 Aug 2018 01:04:19 -0700 (PDT)
From:   Anders Roxell <anders.roxell@linaro.org>
To:     yamada.masahiro@socionext.com, michal.lkml@markovi.net,
        shuah@kernel.org, bamv2005@gmail.com, brgl@bgdev.pl,
        pbonzini@redhat.com, akpm@linux-foundation.org,
        rppt@linux.vnet.ibm.com, aarcange@redhat.com
Cc:     linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, netdev@vger.kernel.org,
        Anders Roxell <anders.roxell@linaro.org>
Subject: [PATCH v5] selftests: add headers_install to lib.mk
Date:   Thu,  9 Aug 2018 10:04:02 +0200
Message-Id: <20180809080402.24469-1-anders.roxell@linaro.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <3f332e65-0b33-9952-6aba-f9c8953a1f26@kernel.org>
References: <3f332e65-0b33-9952-6aba-f9c8953a1f26@kernel.org>
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

Rebased onto next-20180808

Cheers,
Anders

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
index c88d56de7fda..49dc0c6e1f23 100644
--- a/Makefile
+++ b/Makefile
@@ -299,19 +299,7 @@ KERNELRELEASE = $(shell cat include/config/kernel.release 2> /dev/null)
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
index dd0e5163f01f..34d492b77a7c 100644
--- a/tools/testing/selftests/kvm/Makefile
+++ b/tools/testing/selftests/kvm/Makefile
@@ -34,9 +34,6 @@ $(LIBKVM_OBJ): $(OUTPUT)/%.o: %.c
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
index 9cca68e440a0..919aa2ac00af 100644
--- a/tools/testing/selftests/net/Makefile
+++ b/tools/testing/selftests/net/Makefile
@@ -15,6 +15,7 @@ TEST_GEN_FILES += udpgso udpgso_bench_tx udpgso_bench_rx
 TEST_GEN_PROGS = reuseport_bpf reuseport_bpf_cpu reuseport_bpf_numa
 TEST_GEN_PROGS += reuseport_dualstack reuseaddr_conflict tls
 
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
index 9881876d2aa0..e94b7b14bcb2 100644
--- a/tools/testing/selftests/vm/Makefile
+++ b/tools/testing/selftests/vm/Makefile
@@ -26,10 +26,6 @@ TEST_PROGS := run_vmtests
 
 include ../lib.mk
 
-$(OUTPUT)/userfaultfd: ../../../../usr/include/linux/kernel.h
 $(OUTPUT)/userfaultfd: LDLIBS += -lpthread
 
 $(OUTPUT)/mlock-random-test: LDLIBS += -lcap
-
-../../../../usr/include/linux/kernel.h:
-	make -C ../../../.. headers_install
-- 
2.18.0

