Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Google-Smtp-Source: AH8x224Y4S6tqJvbw/50dJLIHZURkIIxhZZR1YyESNPNkO6DFKQAnaFMrqZamb6P5ektt2PnbskD
ARC-Seal: i=1; a=rsa-sha256; t=1519255405; cv=none;
        d=google.com; s=arc-20160816;
        b=Z0kWEGsLDttyxxEOnkRZjEb9reWyxTeq7F53bW5uitxzp2TXUQmQJz8OkPPfFAA/YI
         SgIlZHsZ39OSlk+dzOafww0v1/bHBL2IxYThRJF5sTvPHNIS8pL15Zg5EEb9eOBuQbWX
         GB2Bcn2zlFBBeRWa3zxIqABpeddNBLpUcPyTACrHBLAC8F3mridhVRmPb0LBgAiiy2x/
         /J4mxekInWP47tRLAa2hJHKu+pbCZNOJyvz3q61Ofr6Bc6t5Xgu9oYbr3MMXPxnvGzyv
         h4Z0MBDqimyUCDnbZlsu/5ZLJkoyMQaCwBhp47DQerM15Nh/8U0afj3jrT0KCOowJDRZ
         d6lg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=list-id:precedence:sender:content-transfer-encoding:mime-version
         :references:in-reply-to:message-id:date:subject:cc:to:from
         :dkim-signature:arc-authentication-results;
        bh=x4Wke0zUnkgw+AQbxh6SqP6V+t30SOGv0EvNF/aqK0U=;
        b=PkTUcvRKQ2ngMvcfU/D0s+lv6JALQYGDrvx9nqvXSzO6zNDa8y0iSk9Oe0kHIfPJko
         fHofplB4ALaEnRn+MjXPsAzFSUV2YDOAWIe60r/jaRaQNLNtPZEkFCpbniIEs4Kkkvk4
         XTwciyON/3Xa/oMMfWbCC2/ce6zIVYDOwt0+4eGjQVrff3zRKB9bLnzQL2yvDwNZ7jbX
         Ln6p4PjjZ2216BG3k4uCCvbx+bICH+QFajauC5F8tQus75AWzHWUZY11+Mi5Ye8N0ahR
         SDASddlkko07Gr+bS0N+965oT/q7x6Fnyrz36y5s5jlnCpLfSkTupLUTxUWwddqtU4TO
         NbAQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=neutral (body hash did not verify) header.i=@linaro.org header.s=google header.b=kqL4orWw;
       spf=pass (google.com: best guess record for domain of linux-kselftest-owner@vger.kernel.org designates 209.132.180.67 as permitted sender) smtp.mailfrom=linux-kselftest-owner@vger.kernel.org;
       dmarc=fail (p=NONE sp=NONE dis=NONE) header.from=linaro.org
Authentication-Results: mx.google.com;
       dkim=neutral (body hash did not verify) header.i=@linaro.org header.s=google header.b=kqL4orWw;
       spf=pass (google.com: best guess record for domain of linux-kselftest-owner@vger.kernel.org designates 209.132.180.67 as permitted sender) smtp.mailfrom=linux-kselftest-owner@vger.kernel.org;
       dmarc=fail (p=NONE sp=NONE dis=NONE) header.from=linaro.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751296AbeBUXXZ (ORCPT <rfc822;gregkh@linuxfoundation.org>);
        Wed, 21 Feb 2018 18:23:25 -0500
Received: from mail-ot0-f194.google.com ([74.125.82.194]:41145 "EHLO
        mail-ot0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750811AbeBUXXX (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 21 Feb 2018 18:23:23 -0500
From: =?UTF-8?q?Daniel=20D=C3=ADaz?= <daniel.diaz@linaro.org>
To: shuahkh@osg.samsung.com, linux-kselftest@vger.kernel.org
Cc: andy.shevchenko@gmail.com, Fathi Boudra <fathi.boudra@linaro.org>,
        =?UTF-8?q?Daniel=20D=C3=ADaz?= <daniel.diaz@linaro.org>,
        Bamvor Jian Zhang <bamvor.zhangjian@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Shuah Khan <shuah@kernel.org>,
        linux-gpio@vger.kernel.org (open list:GPIO MOCKUP DRIVER),
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v2] selftests: gpio: restructure Makefile
Date: Wed, 21 Feb 2018 17:22:52 -0600
Message-Id: <1519255373-10071-1-git-send-email-daniel.diaz@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1519249964-1630-1-git-send-email-daniel.diaz@linaro.org>
References: <1519249964-1630-1-git-send-email-daniel.diaz@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kselftest-owner@vger.kernel.org
X-Mailing-List: linux-kselftest@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1593049130388691991?=
X-GMAIL-MSGID: =?utf-8?q?1593054756132505729?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Fathi Boudra <fathi.boudra@linaro.org>

This patch cleans up the Makefile by restructuring a couple of
things, namely:
1) change explicit paths in targets for variables
2) substitute a variable (BINARIES) for another, part of the
   selftests build system (TEST_PROGS_EXTENDED)
3) proper cleaning up of the EXTRA objects

The resulting Makefile is much more readable and manageable.

Signed-off-by: Fathi Boudra <fathi.boudra@linaro.org>
Signed-off-by: Daniel Díaz <daniel.diaz@linaro.org>
---
v2: Add commit description

 tools/testing/selftests/gpio/Makefile | 36 +++++++++++++++++------------------
 1 file changed, 17 insertions(+), 19 deletions(-)

diff --git a/tools/testing/selftests/gpio/Makefile b/tools/testing/selftests/gpio/Makefile
index 1bbb475..6890f61 100644
--- a/tools/testing/selftests/gpio/Makefile
+++ b/tools/testing/selftests/gpio/Makefile
@@ -1,31 +1,29 @@
 # SPDX-License-Identifier: GPL-2.0
 
+CFLAGS += -O2 -g -std=gnu99 -Wall -I../../../../usr/include/
+LDLIBS += -lmount -I/usr/include/libmount
+
 TEST_PROGS := gpio-mockup.sh
-TEST_FILES := gpio-mockup-sysfs.sh $(BINARIES)
-BINARIES := gpio-mockup-chardev
-EXTRA_PROGS := ../gpiogpio-event-mon ../gpiogpio-hammer ../gpiolsgpio
-EXTRA_DIRS := ../gpioinclude/
-EXTRA_OBJS := ../gpiogpio-event-mon-in.o ../gpiogpio-event-mon.o
-EXTRA_OBJS += ../gpiogpio-hammer-in.o ../gpiogpio-utils.o ../gpiolsgpio-in.o
-EXTRA_OBJS += ../gpiolsgpio.o
+TEST_FILES := gpio-mockup-sysfs.sh
+TEST_PROGS_EXTENDED := gpio-mockup-chardev
 
-include ../lib.mk
+GPIODIR := ../../../gpio
+GPIOOBJ := gpio-utils.o
+GPIOINC := gpio.h
 
-all: $(BINARIES)
+all: $(GPIOINC) $(TEST_PROGS_EXTENDED)
 
 override define CLEAN
-	$(RM) $(BINARIES) $(EXTRA_PROGS) $(EXTRA_OBJS)
-	$(RM) -r $(EXTRA_DIRS)
+	$(RM) $(TEST_PROGS_EXTENDED)
+	$(MAKE) -C $(GPIODIR) clean
 endef
 
-CFLAGS += -O2 -g -std=gnu99 -Wall -I../../../../usr/include/
-LDLIBS += -lmount -I/usr/include/libmount
-
-$(BINARIES): ../../../gpio/gpio-utils.o ../../../../usr/include/linux/gpio.h
+include ../lib.mk
 
-../../../gpio/gpio-utils.o:
-	make ARCH=$(ARCH) CROSS_COMPILE=$(CROSS_COMPILE) -C ../../../gpio
+$(TEST_PROGS_EXTENDED): $(GPIODIR)/$(GPIOOBJ)
 
-../../../../usr/include/linux/gpio.h:
-	make -C ../../../.. headers_install INSTALL_HDR_PATH=$(shell pwd)/../../../../usr/
+$(GPIODIR)/$(GPIOOBJ):
+	$(MAKE) -C $(GPIODIR)
 
+$(GPIOINC):
+	$(MAKE) -C ../../../.. headers_install
-- 
2.7.4

