Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Google-Smtp-Source: AH8x225SwOLt77HQs6guDzvKpyj9umwCDYiVGyQ8/od7KqNHD4Rq8z6W6tApAPF84Vh8Jghk76PA
ARC-Seal: i=1; a=rsa-sha256; t=1519250040; cv=none;
        d=google.com; s=arc-20160816;
        b=PoSeKLAHGlb9u2I2PB42chAUPZjmYjQVpgum6eEPvrOlPhbhXzj6zuziHKh51H/fDF
         B2mCrut9ksoCjkgoCOrUqLljOu2ElYjkRFFJXzP6aWF0tP2DWywuq322HwKUILjH5vWR
         i+mUE9scTIgmVy73Req8vr3QnTYj17/HvSIJyUmmocWkSUmo/pvc0j1t6sKPG2/3oKvt
         Ly9KUyLeTLm74QYwY5txpoh9Bl4oQNgZNMjRzfKzR/XgLhb35ULc/dxApe4EMiCiRk2E
         IU4Zu8vDD716lncIMzTpJ6QmNyWPZLeF2mzB3eG+5obgxo2XtJf4VKIQXnnZWyjR4AEg
         uRsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=list-id:precedence:sender:message-id:date:subject:cc:to:from
         :dkim-signature:arc-authentication-results;
        bh=XeUHhpQIMDB2afVvskeaBBRwSQk+YicWLwaxiZPLvQg=;
        b=C/mF3b8kpqPKWUpVHMkwGr2osHdxlu5LOpKPFYywvPCJY9PZ8FTn9gHR3xDauYJSFH
         ej6pJ03GvNsqkTbW1DDDF1ms1yLaDcYSj+ExMrw9SJa5fZyEv+rXDH5eendt6P/PyOhL
         QDiTRpgDxlvzReicX9Yu6EhbYkzq0oDt5LpVpw1jGuiUdhZz90Aer9EW/NE/QaijuzHC
         czk4CziP5DGFyqqJPqTk0VdkTYiROGQUGbz6XU/S7J1fVQQD97OvdxfBrQakvV31skCS
         tcgN1biNJ265ue7PXjNXRizewzaLcd4Bdeu0PNhvshjCZiJ58ywmakx074ZEujD0yCKZ
         9DiQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=neutral (body hash did not verify) header.i=@linaro.org header.s=google header.b=GHfgxZ5l;
       spf=pass (google.com: best guess record for domain of linux-kselftest-owner@vger.kernel.org designates 209.132.180.67 as permitted sender) smtp.mailfrom=linux-kselftest-owner@vger.kernel.org;
       dmarc=fail (p=NONE sp=NONE dis=NONE) header.from=linaro.org
Authentication-Results: mx.google.com;
       dkim=neutral (body hash did not verify) header.i=@linaro.org header.s=google header.b=GHfgxZ5l;
       spf=pass (google.com: best guess record for domain of linux-kselftest-owner@vger.kernel.org designates 209.132.180.67 as permitted sender) smtp.mailfrom=linux-kselftest-owner@vger.kernel.org;
       dmarc=fail (p=NONE sp=NONE dis=NONE) header.from=linaro.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750765AbeBUVx7 (ORCPT <rfc822;gregkh@linuxfoundation.org>);
        Wed, 21 Feb 2018 16:53:59 -0500
Received: from mail-oi0-f66.google.com ([209.85.218.66]:43132 "EHLO
        mail-oi0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750738AbeBUVx6 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 21 Feb 2018 16:53:58 -0500
From: =?UTF-8?q?Daniel=20D=C3=ADaz?= <daniel.diaz@linaro.org>
To: shuahkh@osg.samsung.com, linux-kselftest@vger.kernel.org
Cc: Fathi Boudra <fathi.boudra@linaro.org>,
        Bamvor Jian Zhang <bamvor.zhangjian@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Shuah Khan <shuah@kernel.org>,
        linux-gpio@vger.kernel.org (open list:GPIO MOCKUP DRIVER),
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH 1/2] selftests: gpio: restructure Makefile
Date: Wed, 21 Feb 2018 15:52:43 -0600
Message-Id: <1519249964-1630-1-git-send-email-daniel.diaz@linaro.org>
X-Mailer: git-send-email 2.7.4
Sender: linux-kselftest-owner@vger.kernel.org
X-Mailing-List: linux-kselftest@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1593049130388691991?=
X-GMAIL-MSGID: =?utf-8?q?1593049130388691991?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Fathi Boudra <fathi.boudra@linaro.org>

Signed-off-by: Fathi Boudra <fathi.boudra@linaro.org>
---
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

