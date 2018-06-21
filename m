Return-Path: <SRS0=bmN+=JH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4F36C43142
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 22:42:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8E280224EC
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 22:42:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LjR0TYOQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8E280224EC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934147AbeFUWmo (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Jun 2018 18:42:44 -0400
Received: from mail-lf0-f66.google.com ([209.85.215.66]:39485 "EHLO
        mail-lf0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934080AbeFUWmj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jun 2018 18:42:39 -0400
Received: by mail-lf0-f66.google.com with SMTP id t2-v6so6617434lfd.6;
        Thu, 21 Jun 2018 15:42:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=2vbpS52U3c1drppG5HeKGcK2y3LcoC6DMLpofYuWJRY=;
        b=LjR0TYOQYaz7PDy3XSg4E8kvZFTilIT71yfHiFQ0MEp8qF4wiQaisnfmURr766snHv
         ESbq7/vqeaTk5ewfbzWhVbE8zJticOq7ldDwBNnvN26KVF/rlKMIGM1/e6yE6oWyDDCO
         r6iu7Qz8Pa1xW10jVPwDnise/JdNahLlh4IF0qNyPH/qFtw8DyOx/jMdtJ/P8Cqk+ifm
         klifkKpfCMisxu84B6pDW/gF3rQ8D8Mg/+HWluJRFqhDFTcHUn2O8cg1E0ZbW+/Mtiqj
         uxcYCb1+UQEUr3ow+q55WKq57Mts0D5apja8E75au9Shx9kIr/D0Ko/ZICd+4aE6zhLz
         kDUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=2vbpS52U3c1drppG5HeKGcK2y3LcoC6DMLpofYuWJRY=;
        b=X2dhEM4K8f1oyCIEyTS8a0IS8gLKlL1IZzrhs1wF/tgRD+gwM88T3yIi3i8yQg1/hO
         /yI+efI+IdgTH+Y7jSvQ0nx7Z7j9k/atjnvlSnNxjwJvmLEQmB6Y33U7BaWDUyF+eOTJ
         Zkyq0wY+uBw1cd1RSm00gn1rC5AETSy6GUaUC9H2kbGnvEmvZKZmeDbV0s1tL2B0U77K
         4+eTlPNLE3Tk0zs1VB+r3m50ZXGCcrGRaOWZbP2fvLzbgOSWuQ9xtUnbG6o0kgGl9zLj
         WZe0ylnSQnSmHAqUI37c5vOduRKbZ78DeA8YAOTlvH5ZLmiVSibiBFc5ggWyYPZCD3TY
         WKNA==
X-Gm-Message-State: APt69E2csavRlE+yxNyKJ5Dh740+tzvqxBqME/WWMghMmYLCsJTk7ImY
        N+i0wvm6Rl/WQTktY1tDEP4=
X-Google-Smtp-Source: ADUXVKJwMRjyt11QPvL3VNCs4RvqVQ6doQvSKtGkua2ZPlsWDIz7Xd9mlHa74mDTPNdUjSun3OP4lQ==
X-Received: by 2002:a2e:9744:: with SMTP id f4-v6mr5319538ljj.5.1529620957393;
        Thu, 21 Jun 2018 15:42:37 -0700 (PDT)
Received: from z50.lan (93-181-165-181.internetia.net.pl. [93.181.165.181])
        by smtp.gmail.com with ESMTPSA id t6-v6sm1046153lje.18.2018.06.21.15.42.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 21 Jun 2018 15:42:36 -0700 (PDT)
From:   Janusz Krzysztofik <jmkrzyszt@gmail.com>
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Tony Lindgren <tony@atomide.com>,
        Aaro Koskinen <aaro.koskinen@iki.fi>
Cc:     "David S . Miller " <davem@davemloft.net>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org,
        linux-input@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Janusz Krzysztofik <jmkrzyszt@gmail.com>
Subject: [PATCH v2 08/10] ARM: OMAP1: Get rid of <mach/ams-delta-fiq.h>
Date:   Fri, 22 Jun 2018 00:41:26 +0200
Message-Id: <20180621224128.17623-8-jmkrzyszt@gmail.com>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20180621224128.17623-1-jmkrzyszt@gmail.com>
References: <20180609140224.32606-1-jmkrzyszt@gmail.com>
 <20180621224128.17623-1-jmkrzyszt@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Split the header file into two parts and move them to directories where
they belong.

Information on internal structure of FIQ buffer is moved to
<linux/platform_data/ams-delta-fiq.h> for ams-delta-serio driver use.

Other information used by ams-delta board init file and FIQ code is
made local to mach-omap1 root directory.

Signed-off-by: Janusz Krzysztofik <jmkrzyszt@gmail.com>
---
Changelog:
v2: rebased on v4.18-rc1, no conflicts

 MAINTAINERS                                        |  1 +
 arch/arm/mach-omap1/ams-delta-fiq-handler.S        |  5 +--
 arch/arm/mach-omap1/ams-delta-fiq.c                |  7 ++--
 arch/arm/mach-omap1/ams-delta-fiq.h                | 41 ++++++++++++++++++++++
 arch/arm/mach-omap1/board-ams-delta.c              |  2 +-
 drivers/input/serio/ams_delta_serio.c              |  3 +-
 .../linux/platform_data}/ams-delta-fiq.h           | 27 +++-----------
 7 files changed, 56 insertions(+), 30 deletions(-)
 create mode 100644 arch/arm/mach-omap1/ams-delta-fiq.h
 rename {arch/arm/mach-omap1/include/mach => include/linux/platform_data}/ams-delta-fiq.h (71%)

diff --git a/MAINTAINERS b/MAINTAINERS
index 9d5eeff51b5f..c78b7dc42a81 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -10391,6 +10391,7 @@ F:	arch/arm/plat-omap/
 F:	arch/arm/configs/omap1_defconfig
 F:	drivers/i2c/busses/i2c-omap.c
 F:	include/linux/platform_data/i2c-omap.h
+F:	include/linux/platform_data/ams-delta-fiq.h
 
 OMAP2+ SUPPORT
 M:	Tony Lindgren <tony@atomide.com>
diff --git a/arch/arm/mach-omap1/ams-delta-fiq-handler.S b/arch/arm/mach-omap1/ams-delta-fiq-handler.S
index bf608441b357..ddc27638ba2a 100644
--- a/arch/arm/mach-omap1/ams-delta-fiq-handler.S
+++ b/arch/arm/mach-omap1/ams-delta-fiq-handler.S
@@ -14,11 +14,12 @@
  */
 
 #include <linux/linkage.h>
-#include <asm/assembler.h>
+#include <linux/platform_data/ams-delta-fiq.h>
 
+#include <asm/assembler.h>
 #include <mach/board-ams-delta.h>
-#include <mach/ams-delta-fiq.h>
 
+#include "ams-delta-fiq.h"
 #include "iomap.h"
 #include "soc.h"
 
diff --git a/arch/arm/mach-omap1/ams-delta-fiq.c b/arch/arm/mach-omap1/ams-delta-fiq.c
index 5a6c59ac9b5f..e72935034d42 100644
--- a/arch/arm/mach-omap1/ams-delta-fiq.c
+++ b/arch/arm/mach-omap1/ams-delta-fiq.c
@@ -19,12 +19,13 @@
 #include <linux/irq.h>
 #include <linux/module.h>
 #include <linux/io.h>
+#include <linux/platform_data/ams-delta-fiq.h>
 
 #include <mach/board-ams-delta.h>
 
 #include <asm/fiq.h>
 
-#include <mach/ams-delta-fiq.h>
+#include "ams-delta-fiq.h"
 
 static struct fiq_handler fh = {
 	.name	= "ams-delta-fiq"
@@ -35,8 +36,8 @@ static struct fiq_handler fh = {
  * The FIQ and IRQ isrs can both read and write it.
  * It is structured as a header section several 32bit slots,
  * followed by the circular buffer where the FIQ isr stores
- * keystrokes received from the qwerty keyboard.
- * See ams-delta-fiq.h for details of offsets.
+ * keystrokes received from the qwerty keyboard.  See
+ * <linux/platform_data/ams-delta-fiq.h> for details of offsets.
  */
 unsigned int fiq_buffer[1024];
 EXPORT_SYMBOL(fiq_buffer);
diff --git a/arch/arm/mach-omap1/ams-delta-fiq.h b/arch/arm/mach-omap1/ams-delta-fiq.h
new file mode 100644
index 000000000000..3f691d68aa62
--- /dev/null
+++ b/arch/arm/mach-omap1/ams-delta-fiq.h
@@ -0,0 +1,41 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+
+/*
+ * arch/arm/mach-omap1/ams-delta-fiq.h
+ *
+ * Taken from the original Amstrad modifications to fiq.h
+ *
+ * Copyright (c) 2004 Amstrad Plc
+ * Copyright (c) 2006 Matt Callow
+ * Copyright (c) 2010 Janusz Krzysztofik
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+#ifndef __AMS_DELTA_FIQ_H
+#define __AMS_DELTA_FIQ_H
+
+#include <mach/irqs.h>
+
+/*
+ * Interrupt number used for passing control from FIQ to IRQ.
+ * IRQ12, described as reserved, has been selected.
+ */
+#define INT_DEFERRED_FIQ	INT_1510_RES12
+/*
+ * Base address of an interrupt handler that the INT_DEFERRED_FIQ belongs to.
+ */
+#if (INT_DEFERRED_FIQ < IH2_BASE)
+#define DEFERRED_FIQ_IH_BASE	OMAP_IH1_BASE
+#else
+#define DEFERRED_FIQ_IH_BASE	OMAP_IH2_BASE
+#endif
+
+#ifndef __ASSEMBLER__
+extern unsigned char qwerty_fiqin_start, qwerty_fiqin_end;
+
+extern void __init ams_delta_init_fiq(struct gpio_chip *chip);
+#endif
+
+#endif
diff --git a/arch/arm/mach-omap1/board-ams-delta.c b/arch/arm/mach-omap1/board-ams-delta.c
index f15c0793c34b..fe9a3e7cbfeb 100644
--- a/arch/arm/mach-omap1/board-ams-delta.c
+++ b/arch/arm/mach-omap1/board-ams-delta.c
@@ -41,10 +41,10 @@
 #include <mach/mux.h>
 
 #include <mach/hardware.h>
-#include <mach/ams-delta-fiq.h>
 #include "camera.h"
 #include <mach/usb.h>
 
+#include "ams-delta-fiq.h"
 #include "iomap.h"
 #include "common.h"
 
diff --git a/drivers/input/serio/ams_delta_serio.c b/drivers/input/serio/ams_delta_serio.c
index 7952a29f9540..2602f7cff5ae 100644
--- a/drivers/input/serio/ams_delta_serio.c
+++ b/drivers/input/serio/ams_delta_serio.c
@@ -22,6 +22,7 @@
  */
 #include <linux/gpio.h>
 #include <linux/irq.h>
+#include <linux/platform_data/ams-delta-fiq.h>
 #include <linux/platform_device.h>
 #include <linux/regulator/consumer.h>
 #include <linux/serio.h>
@@ -30,8 +31,6 @@
 
 #include <mach/board-ams-delta.h>
 
-#include <mach/ams-delta-fiq.h>
-
 #define DRIVER_NAME	"ams-delta-serio"
 
 MODULE_AUTHOR("Matt Callow");
diff --git a/arch/arm/mach-omap1/include/mach/ams-delta-fiq.h b/include/linux/platform_data/ams-delta-fiq.h
similarity index 71%
rename from arch/arm/mach-omap1/include/mach/ams-delta-fiq.h
rename to include/linux/platform_data/ams-delta-fiq.h
index a9769ff396bc..dc0f835ea918 100644
--- a/arch/arm/mach-omap1/include/mach/ams-delta-fiq.h
+++ b/include/linux/platform_data/ams-delta-fiq.h
@@ -1,5 +1,7 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+
 /*
- * arch/arm/mach-omap1/include/ams-delta-fiq.h
+ * include/linux/platform_data/ams-delta-fiq.h
  *
  * Taken from the original Amstrad modifications to fiq.h
  *
@@ -11,24 +13,8 @@
  * it under the terms of the GNU General Public License version 2 as
  * published by the Free Software Foundation.
  */
-#ifndef __AMS_DELTA_FIQ_H
-#define __AMS_DELTA_FIQ_H
-
-#include <mach/irqs.h>
-
-/*
- * Interrupt number used for passing control from FIQ to IRQ.
- * IRQ12, described as reserved, has been selected.
- */
-#define INT_DEFERRED_FIQ	INT_1510_RES12
-/*
- * Base address of an interrupt handler that the INT_DEFERRED_FIQ belongs to.
- */
-#if (INT_DEFERRED_FIQ < IH2_BASE)
-#define DEFERRED_FIQ_IH_BASE	OMAP_IH1_BASE
-#else
-#define DEFERRED_FIQ_IH_BASE	OMAP_IH2_BASE
-#endif
+#ifndef __LINUX_PLATFORM_DATA_AMS_DELTA_FIQ_H
+#define __LINUX_PLATFORM_DATA_AMS_DELTA_FIQ_H
 
 /*
  * These are the offsets from the beginning of the fiq_buffer. They are put here
@@ -71,9 +57,6 @@
 
 #ifndef __ASSEMBLER__
 extern unsigned int fiq_buffer[];
-extern unsigned char qwerty_fiqin_start, qwerty_fiqin_end;
-
-extern void __init ams_delta_init_fiq(struct gpio_chip *chip);
 #endif
 
 #endif
-- 
2.16.4

