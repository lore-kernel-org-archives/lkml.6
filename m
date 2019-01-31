Return-Path: <SRS0=Wtxu=QH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03CCBC169C4
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 13:41:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C19822085B
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 13:41:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="P9lJ0FxC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387982AbfAaNlh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 31 Jan 2019 08:41:37 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:41138 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387687AbfAaNkH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Jan 2019 08:40:07 -0500
Received: by mail-wr1-f65.google.com with SMTP id x10so3321457wrs.8
        for <linux-kernel@vger.kernel.org>; Thu, 31 Jan 2019 05:40:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=WIf2pyuQ702WnMccPZNUgGnsS4Cx8XVFtl5DbW/a/PU=;
        b=P9lJ0FxCUcgGfuIK3av4VGEFiRIw6MEZD99qrIOY4w/RNXVPRIDTojYqx7IssXiA+d
         vsUjqBvUSENod7LGfKoGrkF0Qlmc46IKaBhJ/eFSAE/6iyDAs5b9wqsFPQ30PQ1/NmCe
         H3u3VeDfUrGTziCvOY00WKGs+XwblFGW2JSE2NiY4xqrfU0HO5ljIn20XnvkTwWBWeTu
         hzrAIs4WJUgUycPmkEMal4I3EoZxwFFIaxz70Jsoe4b1DIuR8vzQeab5zqaeV90QqH6B
         g8rG05x/j0fT/J1UkoOydT1d9ue/OVcjuZ+DUIBzsaponNcODxOSUuvC/SwSlr13LrrR
         +4AA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=WIf2pyuQ702WnMccPZNUgGnsS4Cx8XVFtl5DbW/a/PU=;
        b=LyvjD10U3VQnuDMvpeEtLDuIWdd6VAiH2zJXTGTJxHDZkYYENsis5bJ/+gb3912/fv
         3L9ab0MIsgTc+Cqw4mwaagi4ti3+V1vem41pAYHYoPEf/ZFHlcT8qaInZ5sIeGKUG3bu
         ftdybF6q0ol8X6k5rFSyqd6ShOpfZpkbt7tAjbXjEBOvHwV9gd5KnlJmGqwnTRzVKfC2
         hG9zu0AvD7s525ydR8akn5oTif7ClYhPISl+3pWgkS1UANsX9HecHSBzepm4Y0xBMN3M
         4KZfEcTwzygdrJFi/tnH15D0ICYoUN2UDShktQAtC0XX+/v6AYfWaRtk+Soir806tSsa
         1bfQ==
X-Gm-Message-State: AJcUukfsetUScW/9ACrJ68w4sZFJLpfmjsRQ3SZXwdXKvQOAEQhuJv0Z
        puMtSZD9ffysxX+YQgckmPRzLQ==
X-Google-Smtp-Source: ALg8bN5cAGW/e+JYB7m74gtG1TI9eXhNDzFMbFSN7gxU2VTiEg4F7922+Qi0olC8umKnjmLpsiqqTA==
X-Received: by 2002:a5d:538a:: with SMTP id d10mr33450410wrv.202.1548942004288;
        Thu, 31 Jan 2019 05:40:04 -0800 (PST)
Received: from debian-brgl.home ([2a01:cb1d:af:5b00:6d6c:8493:1ab5:dad7])
        by smtp.gmail.com with ESMTPSA id h10sm5479768wmf.44.2019.01.31.05.40.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 31 Jan 2019 05:40:03 -0800 (PST)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Sekhar Nori <nsekhar@ti.com>, Kevin Hilman <khilman@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Marc Zyngier <marc.zyngier@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [PATCH 19/35] ARM: davinci: cp-intc: remove cp_intc.h
Date:   Thu, 31 Jan 2019 14:39:12 +0100
Message-Id: <20190131133928.17985-20-brgl@bgdev.pl>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190131133928.17985-1-brgl@bgdev.pl>
References: <20190131133928.17985-1-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

There's no need to have a local header for cp-intc. Move the only
declaration for a public function to common.h. Move all register
offsets into the driver source file and drop all unused defines.
Make cp_intc_of_init() static.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
---
 arch/arm/mach-davinci/board-da830-evm.c     |  1 -
 arch/arm/mach-davinci/board-da850-evm.c     |  1 -
 arch/arm/mach-davinci/board-mityomapl138.c  |  1 -
 arch/arm/mach-davinci/board-omapl138-hawk.c |  1 -
 arch/arm/mach-davinci/cp_intc.c             | 20 +++++++-
 arch/arm/mach-davinci/cp_intc.h             | 57 ---------------------
 arch/arm/mach-davinci/include/mach/common.h |  1 +
 7 files changed, 19 insertions(+), 63 deletions(-)
 delete mode 100644 arch/arm/mach-davinci/cp_intc.h

diff --git a/arch/arm/mach-davinci/board-da830-evm.c b/arch/arm/mach-davinci/board-da830-evm.c
index 41f5a51fee9a..4c1836fa654e 100644
--- a/arch/arm/mach-davinci/board-da830-evm.c
+++ b/arch/arm/mach-davinci/board-da830-evm.c
@@ -37,7 +37,6 @@
 
 #include <mach/common.h>
 #include <mach/irqs.h>
-#include "cp_intc.h"
 #include <mach/mux.h>
 #include <mach/da8xx.h>
 
diff --git a/arch/arm/mach-davinci/board-da850-evm.c b/arch/arm/mach-davinci/board-da850-evm.c
index 317f48560534..548a3c351c02 100644
--- a/arch/arm/mach-davinci/board-da850-evm.c
+++ b/arch/arm/mach-davinci/board-da850-evm.c
@@ -43,7 +43,6 @@
 #include <linux/spi/flash.h>
 
 #include <mach/common.h>
-#include "cp_intc.h"
 #include <mach/da8xx.h>
 #include <mach/mux.h>
 #include <mach/irqs.h>
diff --git a/arch/arm/mach-davinci/board-mityomapl138.c b/arch/arm/mach-davinci/board-mityomapl138.c
index 8df16e81b69e..eb6a9465f229 100644
--- a/arch/arm/mach-davinci/board-mityomapl138.c
+++ b/arch/arm/mach-davinci/board-mityomapl138.c
@@ -27,7 +27,6 @@
 #include <asm/mach-types.h>
 #include <asm/mach/arch.h>
 #include <mach/common.h>
-#include "cp_intc.h"
 #include <mach/da8xx.h>
 #include <linux/platform_data/mtd-davinci.h>
 #include <linux/platform_data/mtd-davinci-aemif.h>
diff --git a/arch/arm/mach-davinci/board-omapl138-hawk.c b/arch/arm/mach-davinci/board-omapl138-hawk.c
index 94c4f126ef86..7f852722ff08 100644
--- a/arch/arm/mach-davinci/board-omapl138-hawk.c
+++ b/arch/arm/mach-davinci/board-omapl138-hawk.c
@@ -27,7 +27,6 @@
 #include <asm/mach/arch.h>
 
 #include <mach/common.h>
-#include "cp_intc.h"
 #include <mach/da8xx.h>
 #include <mach/mux.h>
 
diff --git a/arch/arm/mach-davinci/cp_intc.c b/arch/arm/mach-davinci/cp_intc.c
index 384b72fbefca..817b7616753c 100644
--- a/arch/arm/mach-davinci/cp_intc.c
+++ b/arch/arm/mach-davinci/cp_intc.c
@@ -21,7 +21,22 @@
 
 #include <asm/exception.h>
 #include <mach/common.h>
-#include "cp_intc.h"
+
+#define CP_INTC_CTRL			0x04
+#define CP_INTC_HOST_CTRL		0x0C
+#define CP_INTC_GLOBAL_ENABLE		0x10
+#define CP_INTC_SYS_STAT_IDX_CLR	0x24
+#define CP_INTC_SYS_ENABLE_IDX_SET	0x28
+#define CP_INTC_SYS_ENABLE_IDX_CLR	0x2C
+#define CP_INTC_HOST_ENABLE_IDX_SET	0x34
+#define CP_INTC_HOST_ENABLE_IDX_CLR	0x38
+#define CP_INTC_PRIO_IDX		0x80
+#define CP_INTC_SYS_STAT_CLR(n)		(0x0280 + (n << 2))
+#define CP_INTC_SYS_ENABLE_CLR(n)	(0x0380 + (n << 2))
+#define CP_INTC_CHAN_MAP(n)		(0x0400 + (n << 2))
+#define CP_INTC_SYS_POLARITY(n)		(0x0D00 + (n << 2))
+#define CP_INTC_SYS_TYPE(n)		(0x0D80 + (n << 2))
+#define CP_INTC_HOST_ENABLE(n)		(0x1500 + (n << 2))
 
 static void __iomem *davinci_intc_base;
 
@@ -126,7 +141,8 @@ static const struct irq_domain_ops cp_intc_host_ops = {
 	.xlate = irq_domain_xlate_onetwocell,
 };
 
-int __init cp_intc_of_init(struct device_node *node, struct device_node *parent)
+static int __init cp_intc_of_init(struct device_node *node,
+				  struct device_node *parent)
 {
 	u32 num_irq		= davinci_soc_info.intc_irq_num;
 	u8 *irq_prio		= davinci_soc_info.intc_irq_prios;
diff --git a/arch/arm/mach-davinci/cp_intc.h b/arch/arm/mach-davinci/cp_intc.h
deleted file mode 100644
index 827bbe9baed4..000000000000
--- a/arch/arm/mach-davinci/cp_intc.h
+++ /dev/null
@@ -1,57 +0,0 @@
-/*
- * TI Common Platform Interrupt Controller (cp_intc) definitions
- *
- * Author: Steve Chen <schen@mvista.com>
- * Copyright (C) 2008-2009, MontaVista Software, Inc. <source@mvista.com>
- *
- * This file is licensed under the terms of the GNU General Public License
- * version 2. This program is licensed "as is" without any warranty of any
- * kind, whether express or implied.
- */
-#ifndef __ASM_HARDWARE_CP_INTC_H
-#define __ASM_HARDWARE_CP_INTC_H
-
-#define CP_INTC_REV			0x00
-#define CP_INTC_CTRL			0x04
-#define CP_INTC_HOST_CTRL		0x0C
-#define CP_INTC_GLOBAL_ENABLE		0x10
-#define CP_INTC_GLOBAL_NESTING_LEVEL	0x1C
-#define CP_INTC_SYS_STAT_IDX_SET	0x20
-#define CP_INTC_SYS_STAT_IDX_CLR	0x24
-#define CP_INTC_SYS_ENABLE_IDX_SET	0x28
-#define CP_INTC_SYS_ENABLE_IDX_CLR	0x2C
-#define CP_INTC_GLOBAL_WAKEUP_ENABLE	0x30
-#define CP_INTC_HOST_ENABLE_IDX_SET	0x34
-#define CP_INTC_HOST_ENABLE_IDX_CLR	0x38
-#define CP_INTC_PACING_PRESCALE 	0x40
-#define CP_INTC_VECTOR_BASE		0x50
-#define CP_INTC_VECTOR_SIZE		0x54
-#define CP_INTC_VECTOR_NULL		0x58
-#define CP_INTC_PRIO_IDX		0x80
-#define CP_INTC_PRIO_VECTOR		0x84
-#define CP_INTC_SECURE_ENABLE		0x90
-#define CP_INTC_SECURE_PRIO_IDX 	0x94
-#define CP_INTC_PACING_PARAM(n) 	(0x0100 + (n << 4))
-#define CP_INTC_PACING_DEC(n)		(0x0104 + (n << 4))
-#define CP_INTC_PACING_MAP(n)		(0x0108 + (n << 4))
-#define CP_INTC_SYS_RAW_STAT(n) 	(0x0200 + (n << 2))
-#define CP_INTC_SYS_STAT_CLR(n) 	(0x0280 + (n << 2))
-#define CP_INTC_SYS_ENABLE_SET(n)	(0x0300 + (n << 2))
-#define CP_INTC_SYS_ENABLE_CLR(n)	(0x0380 + (n << 2))
-#define CP_INTC_CHAN_MAP(n)		(0x0400 + (n << 2))
-#define CP_INTC_HOST_MAP(n)		(0x0800 + (n << 2))
-#define CP_INTC_HOST_PRIO_IDX(n)	(0x0900 + (n << 2))
-#define CP_INTC_SYS_POLARITY(n) 	(0x0D00 + (n << 2))
-#define CP_INTC_SYS_TYPE(n)		(0x0D80 + (n << 2))
-#define CP_INTC_WAKEUP_ENABLE(n)	(0x0E00 + (n << 2))
-#define CP_INTC_DEBUG_SELECT(n) 	(0x0F00 + (n << 2))
-#define CP_INTC_SYS_SECURE_ENABLE(n)	(0x1000 + (n << 2))
-#define CP_INTC_HOST_NESTING_LEVEL(n)	(0x1100 + (n << 2))
-#define CP_INTC_HOST_ENABLE(n)		(0x1500 + (n << 2))
-#define CP_INTC_HOST_PRIO_VECTOR(n)	(0x1600 + (n << 2))
-#define CP_INTC_VECTOR_ADDR(n)		(0x2000 + (n << 2))
-
-void cp_intc_init(void);
-int cp_intc_of_init(struct device_node *, struct device_node *);
-
-#endif	/* __ASM_HARDWARE_CP_INTC_H */
diff --git a/arch/arm/mach-davinci/include/mach/common.h b/arch/arm/mach-davinci/include/mach/common.h
index 9e06974c85bb..4177a71db64c 100644
--- a/arch/arm/mach-davinci/include/mach/common.h
+++ b/arch/arm/mach-davinci/include/mach/common.h
@@ -17,6 +17,7 @@
 #include <linux/types.h>
 #include <linux/reboot.h>
 
+void cp_intc_init(void);
 void davinci_timer_init(struct clk *clk);
 
 struct davinci_timer_instance {
-- 
2.20.1

