Return-Path: <SRS0=FvrY=LY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 574A2C4321E
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 17:46:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 089DB2086A
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 17:46:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="t7nzvgke"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 089DB2086A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728766AbeIJWl2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Sep 2018 18:41:28 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:43270 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726906AbeIJWl1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Sep 2018 18:41:27 -0400
Received: by mail-lj1-f195.google.com with SMTP id m84-v6so18608524lje.10;
        Mon, 10 Sep 2018 10:46:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=Wtk+EBGKaQy0nbRlL54eNI7K87OTLBPD4Q9HDrFpXJ4=;
        b=t7nzvgkeXSonzrbIT2+hc1gBVe3n/ZHeeWuroKnTwb74HaDaPrrC8LDWNA+pN1NR4a
         llFYDeCdHNYpO02Jox8LOgaRiIGQxqYb75Ybig/0diIiZ+JwCgeNsY1eCkrcLL83g37D
         3KlJcZ30x+s76kYIaXI6Ijxyie+WJ8iiJm2WqWmFQHp9sgoXo2J4/JTV9VX6fZa1Oq9o
         CDp/TWJsCCUcz4LcfgqgQX3Yz09zUO1qiPdDIIRCbzLAMwfR2MwWmGrplFIIZfp+t8se
         M1afx+qtD7dYZOwc8MeuGHrTalSro28h7vlXARhwwJ/i2y0BExYMqZI3ppb5LkKe6gl+
         a6Ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=Wtk+EBGKaQy0nbRlL54eNI7K87OTLBPD4Q9HDrFpXJ4=;
        b=WPJCp/DhzRhdoydsB6Av0lLO4qvCABGZU+qUPKFZB2DRO4nwV36fBTccdBpyGuivkj
         XqVkhc26w9Fy1nnB+vLK9+rVkxbbz1c/hzUzAiQiRXxPBeeHAGPvhATdjB2wCpKm/7iP
         iYo/y9NWE4lZ8c81KYqKF+nu0fM2w4iPeUcdRfEmFUJi+CGu/dG4tSM5A6QPR6zU0Ep+
         IUj1R1JTsonpldk6vOfjK7UwYa9FEn57SxO6ER93hOVCjaHs8eQ1SaTMUNhBteAP0Cs2
         Sx7SudYIseQTw0QldEl1oDbvRFciJ111p/zpq4r5kxWJJY3yI34a00D+i8djcEMcs7Ed
         VX8Q==
X-Gm-Message-State: APzg51C3aR0J1QruyfrPGocGbg34qgTySKLy81h4gFnybmvIV2rTY45n
        cgyKThpjF12hXpvhfBPKjCM=
X-Google-Smtp-Source: ANB0VdYmBnJ3qtPp2YxBtlk9TRRSOU6q6u486u/IPmLKHBoVajASWmLaQ9qF9FmoqhEJyn4ajyaCdw==
X-Received: by 2002:a2e:9448:: with SMTP id o8-v6mr12992151ljh.34.1536601573506;
        Mon, 10 Sep 2018 10:46:13 -0700 (PDT)
Received: from z50.lan (93-181-165-181.internetia.net.pl. [93.181.165.181])
        by smtp.gmail.com with ESMTPSA id r63-v6sm2897896lja.18.2018.09.10.10.46.12
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 10 Sep 2018 10:46:12 -0700 (PDT)
From:   Janusz Krzysztofik <jmkrzyszt@gmail.com>
To:     Tony Lindgren <tony@atomide.com>
Cc:     Aaro Koskinen <aaro.koskinen@iki.fi>,
        Janusz Krzysztofik <jmkrzyszt@gmail.com>,
        linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] ARM: OMAP1: ams-delta-fiq: Use <linux/platform_data/gpio-omap.h>
Date:   Mon, 10 Sep 2018 19:47:22 +0200
Message-Id: <20180910174722.15679-1-jmkrzyszt@gmail.com>
X-Mailer: git-send-email 2.16.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Instead of defining symbols already defined in
linux/platform_data/gpio-omap.h, use that header file.

Since we include the header into an assembler code, prevent C only bits
from being read in.

Signed-off-by: Janusz Krzysztofik <jmkrzyszt@gmail.com>
---
 arch/arm/mach-omap1/ams-delta-fiq-handler.S | 12 +++---------
 include/linux/platform_data/gpio-omap.h     |  4 ++++
 2 files changed, 7 insertions(+), 9 deletions(-)

diff --git a/arch/arm/mach-omap1/ams-delta-fiq-handler.S b/arch/arm/mach-omap1/ams-delta-fiq-handler.S
index 2e2a17364dc9..7c9fb7fe0070 100644
--- a/arch/arm/mach-omap1/ams-delta-fiq-handler.S
+++ b/arch/arm/mach-omap1/ams-delta-fiq-handler.S
@@ -15,6 +15,7 @@
 
 #include <linux/linkage.h>
 #include <linux/platform_data/ams-delta-fiq.h>
+#include <linux/platform_data/gpio-omap.h>
 
 #include <asm/assembler.h>
 
@@ -24,17 +25,10 @@
 #include "soc.h"
 
 /*
- * GPIO related definitions, copied from arch/arm/plat-omap/gpio.c.
- * Unfortunately, those were not placed in a separate header file.
+ * OMAP1510 GPIO related symbol copied from arch/arm/mach-omap1/gpio15xx.c.
+ * Unfortunately, it was not placed in a separate header file.
  */
 #define OMAP1510_GPIO_BASE		0xFFFCE000
-#define OMAP1510_GPIO_DATA_INPUT	0x00
-#define OMAP1510_GPIO_DATA_OUTPUT	0x04
-#define OMAP1510_GPIO_DIR_CONTROL	0x08
-#define OMAP1510_GPIO_INT_CONTROL	0x0c
-#define OMAP1510_GPIO_INT_MASK		0x10
-#define OMAP1510_GPIO_INT_STATUS	0x14
-#define OMAP1510_GPIO_PIN_CONTROL	0x18
 
 /* GPIO register bitmasks */
 #define KEYBRD_DATA_MASK		(0x1 << AMS_DELTA_GPIO_PIN_KEYBRD_DATA)
diff --git a/include/linux/platform_data/gpio-omap.h b/include/linux/platform_data/gpio-omap.h
index 8612855691b2..ed071f76b642 100644
--- a/include/linux/platform_data/gpio-omap.h
+++ b/include/linux/platform_data/gpio-omap.h
@@ -24,8 +24,10 @@
 #ifndef __ASM_ARCH_OMAP_GPIO_H
 #define __ASM_ARCH_OMAP_GPIO_H
 
+#ifndef __ASSEMBLER__
 #include <linux/io.h>
 #include <linux/platform_device.h>
+#endif
 
 #define OMAP1_MPUIO_BASE			0xfffb5000
 
@@ -157,6 +159,7 @@
 #define OMAP_MPUIO(nr)		(OMAP_MAX_GPIO_LINES + (nr))
 #define OMAP_GPIO_IS_MPUIO(nr)	((nr) >= OMAP_MAX_GPIO_LINES)
 
+#ifndef __ASSEMBLER__
 struct omap_gpio_reg_offs {
 	u16 revision;
 	u16 direction;
@@ -215,5 +218,6 @@ static inline void omap2_gpio_resume_after_idle(void)
 {
 }
 #endif
+#endif /* __ASSEMBLER__ */
 
 #endif
-- 
2.16.4

