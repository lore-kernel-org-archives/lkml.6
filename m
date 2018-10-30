Return-Path: <SRS0=BpFy=NK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 073E9ECDE44
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 23:08:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BF3D320827
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 23:07:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y5lqsB1L"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BF3D320827
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728760AbeJaIDZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Oct 2018 04:03:25 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:45913 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727858AbeJaIDY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Oct 2018 04:03:24 -0400
Received: by mail-pl1-f196.google.com with SMTP id o19-v6so6272095pll.12;
        Tue, 30 Oct 2018 16:07:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=+6N59L7uziOsAgqyzMTMg5i7pzRvo06QUV0Qk4gJdCk=;
        b=Y5lqsB1LgOfxx/6499Fqa4AUIsjBk42mCDBfZsLZVekA1MCAdylnlDRhb20aBFoXJu
         BaQI7HEK48j8zOiBgokkAKxTFfQv3JyG5UyliaFQkG7bCsktN1hzOD6jGKor3cQ5hQR1
         eES0B3Q7/bHbaxNGh1hagCi56P9Vqclo3mmA+ofJKs7pKbmh10vkQHK71zTFrFJQyu4i
         AgilZ2T2t0Q8ra7+12DEHpndfFHNipxepyFcf2rc4GUh8sULediv+12EH234rwaX5SYv
         v09ECYSrYEM7Cgb7yrgp7lHMVcY3018DU1qPiaGpxWcGCkbOLPy7l4vfy+Ey+1briBog
         6vyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=+6N59L7uziOsAgqyzMTMg5i7pzRvo06QUV0Qk4gJdCk=;
        b=jwdzI96Jpy3P6PTQEcf1m4EMY46SvvPU6ULyWNi21FGp/uWVNUdHU1ZhhTFVWxOK4a
         N3wYPk8celPzQUUE6XE+Iou1vY4f3lhRG2dbhzye0a5U54WfIbmJh5WQaETv8lc9r0MA
         V6zhVSMF/Hx+j6kYDdHqerUxT1sosKEbU8BeSKgnhy1FrWLzN6LU6t2cv9CXq1s6USz6
         mpgXs0y0fwwQcq6GryEQcotCbcL8GY4DwE0Yhv/x5bzCg6bmWi5tWu/EjZAWP3cKsVa7
         W8Mk2wD55hW/MYL9QTSZAFj7Cg+0hypsT9VVcrYoSmYn9lXLFGfm7bHQGv9D6C/wMyJn
         t5/Q==
X-Gm-Message-State: AGRZ1gLWuSPQSJBIlLqrjjDJdhve1N1o7m+V1+spRRDH+DXt8T37U9Re
        V/YEGiNi8QeILrBsaf/UnmhJ3u9/
X-Google-Smtp-Source: AJdET5e6Tm0V1+7ThnrWuHbriYgLtVlcTsTc7PUBcGRqkVYR8PmLtYFIK6zqxKx4hbSb69j3aXQ7CA==
X-Received: by 2002:a17:902:9a94:: with SMTP id w20-v6mr684585plp.115.1540940875965;
        Tue, 30 Oct 2018 16:07:55 -0700 (PDT)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.250])
        by smtp.gmail.com with ESMTPSA id f14-v6sm3431689pgr.87.2018.10.30.16.07.53
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 30 Oct 2018 16:07:54 -0700 (PDT)
From:   Florian Fainelli <f.fainelli@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Russell King <rmk+kernel@armlinux.org.uk>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Andrey Konovalov <andreyknvl@google.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Laura Abbott <labbott@redhat.com>,
        Stefan Agner <stefan@agner.ch>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Greg Hackmann <ghackmann@android.com>,
        Kristina Martsenko <kristina.martsenko@arm.com>,
        CHANDAN VN <chandan.vn@samsung.com>,
        linux-arm-kernel@lists.infradead.org (moderated list:ARM64 PORT
        (AARCH64 ARCHITECTURE)),
        devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED
        DEVICE TREE), rppt@linux.ibm.com, linux@armlinux.org.uk,
        green.hu@gmail.com, deanbo422@gmail.com, gxt@pku.edu.cn,
        ard.biesheuvel@linaro.org, linux-snps-arc@lists.infradead.org,
        vgupta@synopsys.com
Subject: [PATCH v2 5/6] of/fdt: Remove custom __early_init_dt_declare_initrd() implementation
Date:   Tue, 30 Oct 2018 16:07:20 -0700
Message-Id: <20181030230721.28429-6-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181030230721.28429-1-f.fainelli@gmail.com>
References: <20181030230721.28429-1-f.fainelli@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now that ARM64 uses phys_initrd_start/phys_initrd_size, we can get rid
of its custom __early_init_dt_declare_initrd() which causes a fair
amount of objects rebuild when changing CONFIG_BLK_DEV_INITRD. In order
to make sure ARM64 does not produce a BUG() when VM debugging is turned
on though, we must avoid early calls to __va() which is what
__early_init_dt_declare_initrd() does and wrap this around to avoid
running that code on ARM64.

Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 arch/arm64/include/asm/memory.h | 8 --------
 drivers/of/fdt.c                | 9 +++++++--
 2 files changed, 7 insertions(+), 10 deletions(-)

diff --git a/arch/arm64/include/asm/memory.h b/arch/arm64/include/asm/memory.h
index b96442960aea..dc3ca21ba240 100644
--- a/arch/arm64/include/asm/memory.h
+++ b/arch/arm64/include/asm/memory.h
@@ -168,14 +168,6 @@
 #define IOREMAP_MAX_ORDER	(PMD_SHIFT)
 #endif
 
-#ifdef CONFIG_BLK_DEV_INITRD
-#define __early_init_dt_declare_initrd(__start, __end)			\
-	do {								\
-		initrd_start = (__start);				\
-		initrd_end = (__end);					\
-	} while (0)
-#endif
-
 #ifndef __ASSEMBLY__
 
 #include <linux/bitops.h>
diff --git a/drivers/of/fdt.c b/drivers/of/fdt.c
index e34cb49231b5..f2b5becae96a 100644
--- a/drivers/of/fdt.c
+++ b/drivers/of/fdt.c
@@ -892,15 +892,20 @@ const void * __init of_flat_dt_match_machine(const void *default_match,
 }
 
 #ifdef CONFIG_BLK_DEV_INITRD
-#ifndef __early_init_dt_declare_initrd
 static void __early_init_dt_declare_initrd(unsigned long start,
 					   unsigned long end)
 {
+	/* ARM64 would cause a BUG to occur here when CONFIG_DEBUG_VM is
+	 * enabled since __va() is called too early. ARM64 does make use
+	 * of phys_initrd_start/phys_initrd_size so we can skip this
+	 * conversion.
+	 */
+#if (!IS_ENABLED(CONFIG_ARM64))
 	initrd_start = (unsigned long)__va(start);
 	initrd_end = (unsigned long)__va(end);
 	initrd_below_start_ok = 1;
-}
 #endif
+}
 
 /**
  * early_init_dt_check_for_initrd - Decode initrd location from flat tree
-- 
2.17.1

