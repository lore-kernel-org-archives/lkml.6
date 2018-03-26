Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Google-Smtp-Source: AG47ELsJSHhMY9XMS5GW4MD7PYMhafTnDeVhHLve4z/N37xabZgdpq4j7QfaeUxE/+ZwLLtNMYpH
ARC-Seal: i=1; a=rsa-sha256; t=1522056845; cv=none;
        d=google.com; s=arc-20160816;
        b=xzOomkn8jiYlYG4D8pVuSAd/aXUhFnBnTbr8dAVInUaZ9zBJpzyX4S42fNYRdpSf+L
         h5MtriLeR/4z+Ur30HCqF6VzzzAawIpl9nyBbKsc0nHDBDHRrEO3Kr7ltDVy8i+6HBJb
         EmHI8U2a8bVAdzVY1asHxVlxno3Vqa2OJA8N7OWfDWXBgs/OxygT75S9xFYu/I08qvOq
         LhGnfkuEdhD+UPKz7RuYBsMandkKdBCWqfJcwC0DxEMHya0o1KSwx+aCXNDEb5rkdveZ
         6D5nmD5iaOO2F6wz5NjshMt2wkZNzG4WN6n4gdWwXN9j30PQOSXFFHXWjz0QOA7LFJz0
         f8jg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=list-id:precedence:sender:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=XlIcmtmRX9dnrAFvzrWd1oV7pLayyIUSSXpFWxZi8/E=;
        b=CVzhg2+re6Vy7KIgSS6yWWjxNBeBSXJQqR6kZKmCVE1Oae08ZP8PsZqUrYuME/BcPV
         ORmbDIZABp15C65bJWIe9Qv1w8VLEvhaQalnH34P6y6y0PzDkXuKAVOVuakCjjeXJdhN
         KxD9bxe5GkDntHLlRXYn+wAxyvH/jusK1sLy81FdwNPbCDyaRmmHJBKuci6Wp+xrInhG
         Ryfa2vXlUkGXytiDQJjmWgQsG1jI1hngUCvgfR6E85mbRzR96/OiZVWeytYn1nU+dCzc
         8XVRULN9iRDEjbFqWf5HEMgSMhdB1MmdvO/twlUXhJRNGt3bLFAzcTaITJxIPfQI86Re
         P0og==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of linux-kselftest-owner@vger.kernel.org designates 209.132.180.67 as permitted sender) smtp.mailfrom=linux-kselftest-owner@vger.kernel.org
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of linux-kselftest-owner@vger.kernel.org designates 209.132.180.67 as permitted sender) smtp.mailfrom=linux-kselftest-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751752AbeCZJdS (ORCPT <rfc822;gregkh@linuxfoundation.org>);
        Mon, 26 Mar 2018 05:33:18 -0400
Received: from mga17.intel.com ([192.55.52.151]:43806 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751380AbeCZJdO (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 26 Mar 2018 05:33:14 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.48,364,1517904000";
   d="scan'208";a="36851574"
From: changbin.du@intel.com
To: shuah@kernel.org
Cc: linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        Changbin Du <changbin.du@intel.com>
Subject: [PATCH 2/4] selftests/gpio: fix paths in Makefile
Date: Mon, 26 Mar 2018 17:23:26 +0800
Message-Id: <1522056208-4004-3-git-send-email-changbin.du@intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1522056208-4004-1-git-send-email-changbin.du@intel.com>
References: <1522056208-4004-1-git-send-email-changbin.du@intel.com>
Sender: linux-kselftest-owner@vger.kernel.org
X-Mailing-List: linux-kselftest@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1595992278211823198?=
X-GMAIL-MSGID: =?utf-8?q?1595992278211823198?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Changbin Du <changbin.du@intel.com>

With previous improvement, the generated files from tools/gpio/ will
put into tools/testing/selftests/gpio/. Let's fix the paths in Makefile
and .gitignore.

Signed-off-by: Changbin Du <changbin.du@intel.com>
---
 tools/testing/selftests/.gitignore      |  4 ----
 tools/testing/selftests/gpio/.gitignore |  4 ++++
 tools/testing/selftests/gpio/Makefile   | 14 +++++++-------
 3 files changed, 11 insertions(+), 11 deletions(-)

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
index 1bbb475..73f0778 100644
--- a/tools/testing/selftests/gpio/Makefile
+++ b/tools/testing/selftests/gpio/Makefile
@@ -3,11 +3,11 @@
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
 
@@ -21,9 +21,9 @@ endef
 CFLAGS += -O2 -g -std=gnu99 -Wall -I../../../../usr/include/
 LDLIBS += -lmount -I/usr/include/libmount
 
-$(BINARIES): ../../../gpio/gpio-utils.o ../../../../usr/include/linux/gpio.h
+$(BINARIES): gpio-utils.o ../../../../usr/include/linux/gpio.h
 
-../../../gpio/gpio-utils.o:
+gpio-utils.o:
 	make ARCH=$(ARCH) CROSS_COMPILE=$(CROSS_COMPILE) -C ../../../gpio
 
 ../../../../usr/include/linux/gpio.h:
-- 
2.7.4

