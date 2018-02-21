Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Google-Smtp-Source: AH8x226jlHv1QRHfhhiKfosZDIbsCLoBTZXm9DEfEHvxK6dFhuLHp4NlQL5BljCQZCm+9sB6M9+Q
ARC-Seal: i=1; a=rsa-sha256; t=1519250064; cv=none;
        d=google.com; s=arc-20160816;
        b=vEZsBiXlQyz6DF1/aZIVkJ2uNSrc8dthENiVqlZ0h0m0Di4Sb1xNJjcUQuyyTSXjtE
         LOl2N79G15Cg1LE0BGRLj0V/N572VDP7AWlA101eBeizQ1lngxybyUIKyIqcBX+3Ez5z
         jQlDxfZdA+j6A9Z7vmGTZLfDfDtEFtMK684dXzl6bk3HsFC+Tzq4mbvp37madQv3bY+s
         FT6w3TCsPOdGz4FYDlXrQgDBh5EBT5C2Yk8y5v+30aEWaqBWY+MB3xBe2lPH8MoqVugX
         0LZ/kSQ8MC42TfoB+MCLhekuYiltqfV9bb2ma/3HGmxcEcRloDP7e+qCT7gz8OCDjBzr
         +GDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=list-id:precedence:sender:content-transfer-encoding:mime-version
         :references:in-reply-to:message-id:date:subject:cc:to:from
         :dkim-signature:arc-authentication-results;
        bh=Yhl7/FFWfBAvkt8VTihsOXAxed77vt20PjKmDFBHi8I=;
        b=C3WqhumdAHLMdy9emXdF/F7DPM1nnLTRzWSa6c3N57LL8mFmKCJsZ7aKZZp9HK6e5V
         CLJ+vCIoU1WEKrwhh+3REmLCJGnt6LsYYVmhhhAZtIwpikCumHTFCm7ME+IFMA6MdwyI
         tCEWP/oI/krQ1hBbIQp5E2C0wv8CLjQiWHbUM73g5kN9UmAZf0AX+IJSvD31ydbdRba9
         pJhLUJZlrc314anUxXLZsWe6+PSUbAmdgZp4Q6VHNisGLl2mcUDQX/ud4CtWPY+rDSRW
         9NQV1+J4/wwTwyqiBKfORX+LgyeREXc2cKlW2cq49pXqf3ywrRXJP+zhUDoB4yyC++hJ
         5ozA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=neutral (body hash did not verify) header.i=@linaro.org header.s=google header.b=M9mNIc4l;
       spf=pass (google.com: best guess record for domain of linux-kselftest-owner@vger.kernel.org designates 209.132.180.67 as permitted sender) smtp.mailfrom=linux-kselftest-owner@vger.kernel.org;
       dmarc=fail (p=NONE sp=NONE dis=NONE) header.from=linaro.org
Authentication-Results: mx.google.com;
       dkim=neutral (body hash did not verify) header.i=@linaro.org header.s=google header.b=M9mNIc4l;
       spf=pass (google.com: best guess record for domain of linux-kselftest-owner@vger.kernel.org designates 209.132.180.67 as permitted sender) smtp.mailfrom=linux-kselftest-owner@vger.kernel.org;
       dmarc=fail (p=NONE sp=NONE dis=NONE) header.from=linaro.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751317AbeBUVyX (ORCPT <rfc822;gregkh@linuxfoundation.org>);
        Wed, 21 Feb 2018 16:54:23 -0500
Received: from mail-oi0-f66.google.com ([209.85.218.66]:34513 "EHLO
        mail-oi0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751000AbeBUVyW (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 21 Feb 2018 16:54:22 -0500
From: =?UTF-8?q?Daniel=20D=C3=ADaz?= <daniel.diaz@linaro.org>
To: shuahkh@osg.samsung.com, linux-kselftest@vger.kernel.org
Cc: =?UTF-8?q?Daniel=20D=C3=ADaz?= <daniel.diaz@linaro.org>,
        Bamvor Jian Zhang <bamvor.zhangjian@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Shuah Khan <shuah@kernel.org>,
        linux-gpio@vger.kernel.org (open list:GPIO MOCKUP DRIVER),
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH 2/2] selftests/gpio: Fix OUTPUT directory in Makefile
Date: Wed, 21 Feb 2018 15:52:44 -0600
Message-Id: <1519249964-1630-2-git-send-email-daniel.diaz@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1519249964-1630-1-git-send-email-daniel.diaz@linaro.org>
References: <1519249964-1630-1-git-send-email-daniel.diaz@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kselftest-owner@vger.kernel.org
X-Mailing-List: linux-kselftest@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1593049155220283470?=
X-GMAIL-MSGID: =?utf-8?q?1593049155220283470?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

When simply running `make' from the selftests top dir, this
error shows up:

  cc -O2 -g -std=gnu99 -Wall -I../../../../usr/include/ -I/usr/include/libmount -I/usr/include/blkid -I/usr/include/uuid    gpio-mockup-chardev.c ../../../gpio/gpio-utils.o  -lmount -o gpio-mockup-chardev
  cc: error: ../../../gpio/gpio-utils.o: No such file or directory
  <builtin>: recipe for target 'gpio-mockup-chardev' failed
  make[1]: *** [gpio-mockup-chardev] Error 1

because the output directory is set to "selftests/gpio" and
all binaries built from ../../../gpio/ end up there. In fact,
they appear as, exempli gratia:
* gpiogpio-event-mon
* gpiogpio-hammer
* gpioinclude/
* gpiolsgpio
which is wrong, as it's missing directory separator somewhere.

This patch sets straight the output directory when building
../../../gpio/ so that binaries don't cross paths.

Signed-off-by: Daniel Díaz <daniel.diaz@linaro.org>
---
 tools/testing/selftests/gpio/Makefile | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/gpio/Makefile b/tools/testing/selftests/gpio/Makefile
index 6890f61..46a131a 100644
--- a/tools/testing/selftests/gpio/Makefile
+++ b/tools/testing/selftests/gpio/Makefile
@@ -7,7 +7,7 @@ TEST_PROGS := gpio-mockup.sh
 TEST_FILES := gpio-mockup-sysfs.sh
 TEST_PROGS_EXTENDED := gpio-mockup-chardev
 
-GPIODIR := ../../../gpio
+GPIODIR := $(realpath ../../../gpio)
 GPIOOBJ := gpio-utils.o
 GPIOINC := gpio.h
 
@@ -15,7 +15,7 @@ all: $(GPIOINC) $(TEST_PROGS_EXTENDED)
 
 override define CLEAN
 	$(RM) $(TEST_PROGS_EXTENDED)
-	$(MAKE) -C $(GPIODIR) clean
+	$(MAKE) -C $(GPIODIR) OUTPUT=$(GPIODIR)/ clean
 endef
 
 include ../lib.mk
@@ -23,7 +23,7 @@ include ../lib.mk
 $(TEST_PROGS_EXTENDED): $(GPIODIR)/$(GPIOOBJ)
 
 $(GPIODIR)/$(GPIOOBJ):
-	$(MAKE) -C $(GPIODIR)
+	$(MAKE) OUTPUT=$(GPIODIR)/ -C $(GPIODIR)
 
 $(GPIOINC):
 	$(MAKE) -C ../../../.. headers_install
-- 
2.7.4

