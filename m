Return-Path: <SRS0=w+lf=PI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35026C43612
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Dec 2018 17:15:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 044AC21019
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Dec 2018 17:15:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727425AbeLaRP6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 31 Dec 2018 12:15:58 -0500
Received: from mail.bootlin.com ([62.4.15.54]:49491 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727335AbeLaRP5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Dec 2018 12:15:57 -0500
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 66E6D20A44; Mon, 31 Dec 2018 18:15:55 +0100 (CET)
Received: from localhost (lfbn-1-17122-186.w86-248.abo.wanadoo.fr [86.248.186.186])
        by mail.bootlin.com (Postfix) with ESMTPSA id 383B6207A8;
        Mon, 31 Dec 2018 18:15:45 +0100 (CET)
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     linux-rtc@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Subject: [PATCH] rtc: rename core files
Date:   Mon, 31 Dec 2018 18:15:42 +0100
Message-Id: <20181231171542.15111-1-alexandre.belloni@bootlin.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rename core files so there is a clearer separation between the RTC core and
the RTC drivers.

Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
---
 drivers/rtc/Makefile                 | 8 ++++----
 drivers/rtc/{rtc-dev.c => dev.c}     | 0
 drivers/rtc/{rtc-lib.c => lib.c}     | 0
 drivers/rtc/{rtc-proc.c => proc.c}   | 0
 drivers/rtc/{rtc-sysfs.c => sysfs.c} | 0
 5 files changed, 4 insertions(+), 4 deletions(-)
 rename drivers/rtc/{rtc-dev.c => dev.c} (100%)
 rename drivers/rtc/{rtc-lib.c => lib.c} (100%)
 rename drivers/rtc/{rtc-proc.c => proc.c} (100%)
 rename drivers/rtc/{rtc-sysfs.c => sysfs.c} (100%)

diff --git a/drivers/rtc/Makefile b/drivers/rtc/Makefile
index f97c05ef99db..df022d820bee 100644
--- a/drivers/rtc/Makefile
+++ b/drivers/rtc/Makefile
@@ -5,7 +5,7 @@
 
 ccflags-$(CONFIG_RTC_DEBUG)	:= -DDEBUG
 
-obj-$(CONFIG_RTC_LIB)		+= rtc-lib.o
+obj-$(CONFIG_RTC_LIB)		+= lib.o
 obj-$(CONFIG_RTC_HCTOSYS)	+= hctosys.o
 obj-$(CONFIG_RTC_SYSTOHC)	+= systohc.o
 obj-$(CONFIG_RTC_CLASS)		+= rtc-core.o
@@ -17,9 +17,9 @@ rtc-core-y			+= rtc-efi-platform.o
 endif
 
 rtc-core-$(CONFIG_RTC_NVMEM)		+= nvmem.o
-rtc-core-$(CONFIG_RTC_INTF_DEV)		+= rtc-dev.o
-rtc-core-$(CONFIG_RTC_INTF_PROC)	+= rtc-proc.o
-rtc-core-$(CONFIG_RTC_INTF_SYSFS)	+= rtc-sysfs.o
+rtc-core-$(CONFIG_RTC_INTF_DEV)		+= dev.o
+rtc-core-$(CONFIG_RTC_INTF_PROC)	+= proc.o
+rtc-core-$(CONFIG_RTC_INTF_SYSFS)	+= sysfs.o
 
 # Keep the list ordered.
 
diff --git a/drivers/rtc/rtc-dev.c b/drivers/rtc/dev.c
similarity index 100%
rename from drivers/rtc/rtc-dev.c
rename to drivers/rtc/dev.c
diff --git a/drivers/rtc/rtc-lib.c b/drivers/rtc/lib.c
similarity index 100%
rename from drivers/rtc/rtc-lib.c
rename to drivers/rtc/lib.c
diff --git a/drivers/rtc/rtc-proc.c b/drivers/rtc/proc.c
similarity index 100%
rename from drivers/rtc/rtc-proc.c
rename to drivers/rtc/proc.c
diff --git a/drivers/rtc/rtc-sysfs.c b/drivers/rtc/sysfs.c
similarity index 100%
rename from drivers/rtc/rtc-sysfs.c
rename to drivers/rtc/sysfs.c
-- 
2.20.1

