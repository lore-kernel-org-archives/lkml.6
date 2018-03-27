Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Google-Smtp-Source: AG47ELuaANDTs9hJSlfoNGAufXTTvnhXxGg5qoH4oB2UqQPIAGfXgPdPhQdn3niQ+f4vGa+iyLIh
ARC-Seal: i=1; a=rsa-sha256; t=1522120916; cv=none;
        d=google.com; s=arc-20160816;
        b=IAsbXAbnFSYFQjDSPHzdRmdW5OX8rw8KA8foUaHnegW6WuC9wLAEJx6hcZn8DNG4Qn
         d56O4dceVH/dPZEzpJyyKg8f962ZI6z6f8qP6EYNMthNjDUh7txw/ldptXn1zAzhk5fg
         Lh+ZCwTjmFtEMpO/735mN7fuWDP01iA21kBZq63rCj6BJLpX/ax1zoUvBTSoitlOvDf8
         SawlmYHl09mP85JtVDQUow+ujLH9+/9Y0uEoC2fzhZqSf2r7gBxOp4vd/lMxW2Ff0vY1
         XcM+9aaPRpxjXMck7u5ot5RkCktScMiNZS3tpYAk5FSg7sAoFAnekeBjg1NZjiw2VwH1
         xp4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=list-id:precedence:sender:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=sBchUs8uDZsFqtZmB4bY8pQizvFxKr733goYD4cKL/8=;
        b=EhHM4AveuWwpGIH6afcF04RlfnM43628+4C2pCm9zpx+036a4KGhpjEfhKGtBIyKl3
         ACSAcZ4LndzRpm8/ldE8BHwlp8Qq8eDnhPIqjQySWq6FQLHp1SWEMf3jyfp9+YviuGAI
         xvt058KPBkaGr89l5vnRpegcOihulymiblr+GgIWh95s5RCWLEoKVh0mPrhYCZF1Yhj6
         I8s4LtkOqwlcuTpGgA2ptSDMk0LCi7qnyt6KHIK4/ge321smMKdUjWweaNd64xalmUMD
         bdLq0Uw7PfPp98ZhGcFouprzRWKdkRsa5ZJCF7RAZ+eo2T9vFdkk4yZ1DfiFVn/N63TO
         lw2A==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of linux-kselftest-owner@vger.kernel.org designates 209.132.180.67 as permitted sender) smtp.mailfrom=linux-kselftest-owner@vger.kernel.org
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of linux-kselftest-owner@vger.kernel.org designates 209.132.180.67 as permitted sender) smtp.mailfrom=linux-kselftest-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752087AbeC0DVW (ORCPT <rfc822;gregkh@linuxfoundation.org>);
        Mon, 26 Mar 2018 23:21:22 -0400
Received: from mga02.intel.com ([134.134.136.20]:63675 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752040AbeC0DVT (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 26 Mar 2018 23:21:19 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.48,366,1517904000";
   d="scan'208";a="215125693"
From: changbin.du@intel.com
To: shuah@kernel.org
Cc: linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        Changbin Du <changbin.du@intel.com>
Subject: [PATCH v2 2/4] selftests/gpio: fix paths in Makefile
Date: Tue, 27 Mar 2018 11:11:32 +0800
Message-Id: <1522120294-24926-3-git-send-email-changbin.du@intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1522120294-24926-1-git-send-email-changbin.du@intel.com>
References: <1522120294-24926-1-git-send-email-changbin.du@intel.com>
Sender: linux-kselftest-owner@vger.kernel.org
X-Mailing-List: linux-kselftest@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1596059461972764837?=
X-GMAIL-MSGID: =?utf-8?q?1596059461972764837?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Changbin Du <changbin.du@intel.com>

With previous improvement, the generated files from tools/gpio/ will
put into tools/testing/selftests/gpio/. Let's fix the paths in Makefile
and .gitignore.

Signed-off-by: Changbin Du <changbin.du@intel.com>

---
v2: fix compiling error when runing make in sub-folder.
---
 tools/testing/selftests/.gitignore      |  4 ----
 tools/testing/selftests/gpio/.gitignore |  4 ++++
 tools/testing/selftests/gpio/Makefile   | 17 +++++++++--------
 3 files changed, 13 insertions(+), 12 deletions(-)

diff --git a/tools/testing/selftests/.gitignore b/tools/testing/selftests/.gitignore
index 9175035..f0600d2 100644
--- a/tools/testing/selftests/.gitignore
+++ b/tools/testing/selftests/.gitignore
@@ -1,5 +1 @@
 kselftest
-gpiogpio-event-mon
-gpiogpio-hammer
-gpioinclude/
-gpiolsgpio
diff --git a/tools/testing/selftests/gpio/.gitignore b/tools/testing/selftests/gpio/.gitignore
index 7d14f74..21e83e1 100644
--- a/tools/testing/selftests/gpio/.gitignore
+++ b/tools/testing/selftests/gpio/.gitignore
@@ -1 +1,5 @@
 gpio-mockup-chardev
+gpio-event-mon
+gpio-hammer
+include/
+lsgpio
diff --git a/tools/testing/selftests/gpio/Makefile b/tools/testing/selftests/gpio/Makefile
index 1bbb475..cb8c134 100644
--- a/tools/testing/selftests/gpio/Makefile
+++ b/tools/testing/selftests/gpio/Makefile
@@ -1,13 +1,14 @@
 # SPDX-License-Identifier: GPL-2.0
 
+OUTPUT ?= $(shell pwd)
 TEST_PROGS := gpio-mockup.sh
 TEST_FILES := gpio-mockup-sysfs.sh $(BINARIES)
 BINARIES := gpio-mockup-chardev
-EXTRA_PROGS := ../gpiogpio-event-mon ../gpiogpio-hammer ../gpiolsgpio
-EXTRA_DIRS := ../gpioinclude/
-EXTRA_OBJS := ../gpiogpio-event-mon-in.o ../gpiogpio-event-mon.o
-EXTRA_OBJS += ../gpiogpio-hammer-in.o ../gpiogpio-utils.o ../gpiolsgpio-in.o
-EXTRA_OBJS += ../gpiolsgpio.o
+EXTRA_PROGS := gpio-event-mon gpio-hammer lsgpio
+EXTRA_DIRS := ./include/
+EXTRA_OBJS := gpio-event-mon-in.o gpio-event-mon.o
+EXTRA_OBJS += gpio-hammer-in.o gpio-utils.o lsgpio-in.o
+EXTRA_OBJS += lsgpio.o
 
 include ../lib.mk
 
@@ -21,10 +22,10 @@ endef
 CFLAGS += -O2 -g -std=gnu99 -Wall -I../../../../usr/include/
 LDLIBS += -lmount -I/usr/include/libmount
 
-$(BINARIES): ../../../gpio/gpio-utils.o ../../../../usr/include/linux/gpio.h
+$(BINARIES): gpio-utils.o ../../../../usr/include/linux/gpio.h
 
-../../../gpio/gpio-utils.o:
-	make ARCH=$(ARCH) CROSS_COMPILE=$(CROSS_COMPILE) -C ../../../gpio
+gpio-utils.o:
+	make ARCH=$(ARCH) CROSS_COMPILE=$(CROSS_COMPILE) OUTPUT=$(OUTPUT)/ -C ../../../gpio
 
 ../../../../usr/include/linux/gpio.h:
 	make -C ../../../.. headers_install INSTALL_HDR_PATH=$(shell pwd)/../../../../usr/
-- 
2.7.4

