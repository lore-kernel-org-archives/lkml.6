Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFB1FC433F5
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 14:36:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6A1AA20869
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 14:36:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="E0r+rPU7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6A1AA20869
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729915AbeIGTRX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 15:17:23 -0400
Received: from mail-oi0-f68.google.com ([209.85.218.68]:42492 "EHLO
        mail-oi0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727659AbeIGTRW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 15:17:22 -0400
Received: by mail-oi0-f68.google.com with SMTP id v198-v6so9928723oif.9
        for <linux-kernel@vger.kernel.org>; Fri, 07 Sep 2018 07:36:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=7uICIwEpFod9siHFcDEy/0W3rcrfNV0csFkXyZ5W1rc=;
        b=E0r+rPU7V1yvYTI8gTotBRFPF4fJWfx8u0WddAnkyHPoSnSACpuh6v9Lv4luAk9nqx
         6oEjopJxRrZw/z9kbtMKp7iUh7xUXi9OkelX6e+geZeNBWjKm03JwuAWKxcstZrYO9LU
         DaZTHigog3vXdUxlmJwZRrSb5rsbS61HQX03c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=7uICIwEpFod9siHFcDEy/0W3rcrfNV0csFkXyZ5W1rc=;
        b=V34YNom+FKbNVCEvivrn12uPZYnMHxDS3Ou+RELBKdSM7xUN4oOdeafwb8i45WU8R8
         KZKvjisyx/dA5HM00y4CYnstVAHRCSLR2F6IdXtpt4dQNUMq1Tl0wCUHxj/qSbFnVXOz
         kL3Aj8Ol2AR+2ztCL2WTLiEydjXtk01kYdF/fwi2zFbd79b0FDDSE9OildeKwJibHJpQ
         PYozj/rVw7rLDO3QStxyl1Y7O0/F+7WwIbqHlXLLJlOvVkLTVQ/EeXMDeAT0yQcuy69b
         4L9F22XGQ+UtRuXV8hIB868jL6JPAifODFaKyyGgHIU0yFfFYAa9Mxhfx1QcFgbKjrxu
         a78A==
X-Gm-Message-State: APzg51ByoKMVjDjGUoKaXD9/Z2h9LJrJdM7xWBzra3TkndcO4B75mmkW
        XBDesfvypiL7bQ091c4Ur/5x8WoHaGGIWA==
X-Google-Smtp-Source: ANB0Vdba0NX3ECkpFQ5JgG3UATvzWExoPcsbOmotDbNGveVHzK05HpwbTrxmpbLj4lovD1u3GlmIAw==
X-Received: by 2002:aca:4186:: with SMTP id o128-v6mr7794664oia.286.1536330969197;
        Fri, 07 Sep 2018 07:36:09 -0700 (PDT)
Received: from aura.cortijodelrio.net ([187.161.144.121])
        by smtp.googlemail.com with ESMTPSA id i132-v6sm10306360oif.20.2018.09.07.07.36.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 07 Sep 2018 07:36:08 -0700 (PDT)
From:   =?UTF-8?q?Daniel=20D=C3=ADaz?= <daniel.diaz@linaro.org>
To:     shuahkh@osg.samsung.com, linux-kselftest@vger.kernel.org
Cc:     linus.walleij@linaro.org,
        =?UTF-8?q?Daniel=20D=C3=ADaz?= <daniel.diaz@linaro.org>,
        Bamvor Jian Zhang <bamv2005@gmail.com>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Shuah Khan <shuah@kernel.org>,
        linux-gpio@vger.kernel.org (open list:GPIO MOCKUP DRIVER),
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v3 2/2] selftests: gpio: Fix OUTPUT directory in Makefile
Date:   Fri,  7 Sep 2018 09:34:55 -0500
Message-Id: <1536330895-8391-2-git-send-email-daniel.diaz@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1536330895-8391-1-git-send-email-daniel.diaz@linaro.org>
References: <1536330895-8391-1-git-send-email-daniel.diaz@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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
which is wrong, as it's missing a directory separator
somewhere.

This patch sets straight the output directory when building
../../../gpio/ so that binaries don't cross paths.

Signed-off-by: Daniel Díaz <daniel.diaz@linaro.org>
---
 tools/testing/selftests/gpio/Makefile | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/gpio/Makefile b/tools/testing/selftests/gpio/Makefile
index a4a01ec8..4664842 100644
--- a/tools/testing/selftests/gpio/Makefile
+++ b/tools/testing/selftests/gpio/Makefile
@@ -7,7 +7,7 @@ TEST_PROGS := gpio-mockup.sh
 TEST_FILES := gpio-mockup-sysfs.sh
 TEST_PROGS_EXTENDED := gpio-mockup-chardev
 
-GPIODIR := ../../../gpio
+GPIODIR := $(realpath ../../../gpio)
 GPIOOBJ := gpio-utils.o
 
 include ../lib.mk
@@ -16,11 +16,11 @@ all: $(TEST_PROGS_EXTENDED)
 
 override define CLEAN
 	$(RM) $(TEST_PROGS_EXTENDED)
-	$(MAKE) -C $(GPIODIR) clean
+	$(MAKE) -C $(GPIODIR) OUTPUT=$(GPIODIR)/ clean
 endef
 
 $(TEST_PROGS_EXTENDED):| khdr
 $(TEST_PROGS_EXTENDED): $(GPIODIR)/$(GPIOOBJ)
 
 $(GPIODIR)/$(GPIOOBJ):
-	$(MAKE) -C $(GPIODIR)
+	$(MAKE) OUTPUT=$(GPIODIR)/ -C $(GPIODIR)
-- 
2.7.4

