Return-Path: <SRS0=drEb=P7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DATE_IN_FUTURE_06_12,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E24EC282C3
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 03:15:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D53AB2085A
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 03:15:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727089AbfAWDOz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Jan 2019 22:14:55 -0500
Received: from mxhk.zte.com.cn ([63.217.80.70]:43226 "EHLO mxhk.zte.com.cn"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726996AbfAWDOv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jan 2019 22:14:51 -0500
Received: from mse01.zte.com.cn (unknown [10.30.3.20])
        by Forcepoint Email with ESMTPS id 64B09FFA3AFA9297F52D;
        Wed, 23 Jan 2019 11:14:49 +0800 (CST)
Received: from notes_smtp.zte.com.cn ([10.30.1.239])
        by mse01.zte.com.cn with ESMTP id x0N3EiNe000690;
        Wed, 23 Jan 2019 11:14:44 +0800 (GMT-8)
        (envelope-from peng.hao2@zte.com.cn)
Received: from localhost.localdomain.localdomain ([10.74.120.59])
          by szsmtp06.zte.com.cn (Lotus Domino Release 8.5.3FP6)
          with ESMTP id 2019012311150463-23654296 ;
          Wed, 23 Jan 2019 11:15:04 +0800 
From:   Peng Hao <peng.hao2@zte.com.cn>
To:     gregkh@linuxfoundation.org, arnd@arndb.de,
        andy.shevchenko@gmail.com
Cc:     linux-kernel@vger.kernel.org, Peng Hao <peng.hao2@zte.com.cn>
Subject: [PATCH V2 1/6]  misc/pvpanic: preparing for pvpanic driver framework
Date:   Wed, 23 Jan 2019 19:37:52 +0800
Message-Id: <1548243477-60654-2-git-send-email-peng.hao2@zte.com.cn>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1548243477-60654-1-git-send-email-peng.hao2@zte.com.cn>
References: <1548243477-60654-1-git-send-email-peng.hao2@zte.com.cn>
X-MIMETrack: Itemize by SMTP Server on SZSMTP06/server/zte_ltd(Release 8.5.3FP6|November
 21, 2013) at 2019-01-23 11:15:04,
        Serialize by Router on notes_smtp/zte_ltd(Release 9.0.1FP7|August  17, 2016) at
 2019-01-23 11:14:37,
        Serialize complete at 2019-01-23 11:14:37
X-MAIL: mse01.zte.com.cn x0N3EiNe000690
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Preparing for pvpanic driver framework. Create a pvpanic driver
directory and move current driver file to new directory.

Signed-off-by: Peng Hao <peng.hao2@zte.com.cn>
---
 drivers/misc/Kconfig                 | 9 +--------
 drivers/misc/Makefile                | 2 +-
 drivers/misc/pvpanic/Kconfig         | 7 +++++++
 drivers/misc/pvpanic/Makefile        | 5 +++++
 drivers/misc/{ => pvpanic}/pvpanic.c | 0
 5 files changed, 14 insertions(+), 9 deletions(-)
 create mode 100644 drivers/misc/pvpanic/Kconfig
 create mode 100644 drivers/misc/pvpanic/Makefile
 rename drivers/misc/{ => pvpanic}/pvpanic.c (100%)

diff --git a/drivers/misc/Kconfig b/drivers/misc/Kconfig
index f417b06..aa3a805 100644
--- a/drivers/misc/Kconfig
+++ b/drivers/misc/Kconfig
@@ -513,14 +513,7 @@ config MISC_RTSX
 	tristate
 	default MISC_RTSX_PCI || MISC_RTSX_USB
 
-config PVPANIC
-	tristate "pvpanic device support"
-	depends on HAS_IOMEM && (ACPI || OF)
-	help
-	  This driver provides support for the pvpanic device.  pvpanic is
-	  a paravirtualized device provided by QEMU; it lets a virtual machine
-	  (guest) communicate panic events to the host.
-
+source "drivers/misc/pvpanic/Kconfig"
 source "drivers/misc/c2port/Kconfig"
 source "drivers/misc/eeprom/Kconfig"
 source "drivers/misc/cb710/Kconfig"
diff --git a/drivers/misc/Makefile b/drivers/misc/Makefile
index e39ccbb..cfe20b3 100644
--- a/drivers/misc/Makefile
+++ b/drivers/misc/Makefile
@@ -58,4 +58,4 @@ obj-$(CONFIG_ASPEED_LPC_SNOOP)	+= aspeed-lpc-snoop.o
 obj-$(CONFIG_PCI_ENDPOINT_TEST)	+= pci_endpoint_test.o
 obj-$(CONFIG_OCXL)		+= ocxl/
 obj-y				+= cardreader/
-obj-$(CONFIG_PVPANIC)   	+= pvpanic.o
+obj-$(CONFIG_PVPANIC)   	+= pvpanic/
diff --git a/drivers/misc/pvpanic/Kconfig b/drivers/misc/pvpanic/Kconfig
new file mode 100644
index 0000000..3e612c6
--- /dev/null
+++ b/drivers/misc/pvpanic/Kconfig
@@ -0,0 +1,7 @@
+config PVPANIC
+	tristate "pvpanic device support"
+	depends on HAS_IOMEM && (ACPI || OF)
+	help
+	  This driver provides support for the pvpanic device.  pvpanic is
+	  a paravirtualized device provided by QEMU; it lets a virtual machine
+	  (guest) communicate panic events to the host.
diff --git a/drivers/misc/pvpanic/Makefile b/drivers/misc/pvpanic/Makefile
new file mode 100644
index 0000000..6394224
--- /dev/null
+++ b/drivers/misc/pvpanic/Makefile
@@ -0,0 +1,5 @@
+# SPDX-License-Identifier: GPL-2.0-or-later
+#
+# Copyright (c) 2018 ZTE Ltd.
+
+obj-$(CONFIG_PVPANIC)            += pvpanic.o
diff --git a/drivers/misc/pvpanic.c b/drivers/misc/pvpanic/pvpanic.c
similarity index 100%
rename from drivers/misc/pvpanic.c
rename to drivers/misc/pvpanic/pvpanic.c
-- 
1.8.3.1

