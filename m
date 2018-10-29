Return-Path: <SRS0=Xm/m=NJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15405C2BC61
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 23:52:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CF26F2084A
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 23:52:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NdfWYyrJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CF26F2084A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726503AbeJ3Inm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Oct 2018 04:43:42 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:34500 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725824AbeJ3Ink (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Oct 2018 04:43:40 -0400
Received: by mail-pl1-f193.google.com with SMTP id f10-v6so4597234plr.1;
        Mon, 29 Oct 2018 16:52:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=xRniQ/SenF/b2HkRCisGu8vGveS5ZrM6Rdu1vfSJ1hU=;
        b=NdfWYyrJaKwj0g5pJz1Dt03O59C9R58Rk2vAj1lodD9y2gN1oN9JDzi77jkpb18I35
         xD8gUuFi8XvlfsnepqG/DnZSP2MlRo9pOG9RI9plDEcle8dggoqCC+Qm9+PLQUydjuMV
         1QleRUKhNLCm0KFls5X0syhY69a3PYAHrBOmtMan9W5+pBy7VaQeveVibXo6pL6+HaYw
         yxVKEoZ3zGFXW62nxN5CqPv/v/yos+nucGc9VwP+QrsZyoN5IvtRsDvIs8VjGm8EU/Ww
         XYrZjkpHG4Hg3WpSahZvJOJWxs6gOh0pyaipEdiuSL6QxxCJaZ+M8HiUPtlR2oOb6UVq
         NxHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=xRniQ/SenF/b2HkRCisGu8vGveS5ZrM6Rdu1vfSJ1hU=;
        b=F87i4HCsGsG4IFxdDMDNLPGRzGMk/97rREMHp9jmP5683fOXhd+sqa0Ak0deCt6t3l
         efNvJM3Og/hwc4+8zBTuBqsfzFB3CA7dNh71g8n4lPmygvjyNT/c/kwG2HXKGg7Fxk11
         yc4f8l4r07xd/g9+M1Icz58ExWesp5FqOBdLkNVc/UaZHGiQvypRdgbnCXXjIXJyRaSf
         YjFHjzM/p9vnX9kzVO/Q/nRh7g6+os0g8SHLDEZikSBJHArsagUIyMb6rdXHFjPyzbvV
         oZwxQwEnrAaBt7SQIlevBHwMAMMCUs2ITym3ZtTNof3zl6ECOA3czsaKRG4Iu+enlP5N
         1krw==
X-Gm-Message-State: AGRZ1gLzPfEx1GuR+JRDu3TJjfM12+jEf6eqL1S5DHKh0sN2/Z3As7mK
        0llxgT54zSVB27nh590NujHw/WjX
X-Google-Smtp-Source: AJdET5e5bw1tFJSx1qa61gkDTjZ9BaPVELRZjfaIRFIPo8U1E7PTr0pTB7nsNKPA3E34HYQe+nw5zA==
X-Received: by 2002:a17:902:7201:: with SMTP id ba1-v6mr902814plb.79.1540857156701;
        Mon, 29 Oct 2018 16:52:36 -0700 (PDT)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.250])
        by smtp.gmail.com with ESMTPSA id k13-v6sm22537981pff.30.2018.10.29.16.52.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 29 Oct 2018 16:52:35 -0700 (PDT)
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
        ard.biesheuvel@linaro.org
Subject: [PATCH 2/6] arch: Make phys_initrd_start and phys_initrd_size global variables
Date:   Mon, 29 Oct 2018 16:52:02 -0700
Message-Id: <20181029235206.30060-3-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181029235206.30060-1-f.fainelli@gmail.com>
References: <20181029235206.30060-1-f.fainelli@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Make phys_initrd_start and phys_initrd_size global variables that will
later be referenced by generic code under drivers/of/fdt.c.

Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 arch/arm/mm/init.c       | 4 ++--
 arch/unicore32/mm/init.c | 4 ++--
 include/linux/initrd.h   | 3 +++
 3 files changed, 7 insertions(+), 4 deletions(-)

diff --git a/arch/arm/mm/init.c b/arch/arm/mm/init.c
index 0cc8e04295a4..8f364aa24172 100644
--- a/arch/arm/mm/init.c
+++ b/arch/arm/mm/init.c
@@ -51,8 +51,8 @@ unsigned long __init __clear_cr(unsigned long mask)
 }
 #endif
 
-static phys_addr_t phys_initrd_start __initdata = 0;
-static unsigned long phys_initrd_size __initdata = 0;
+phys_addr_t phys_initrd_start __initdata = 0;
+unsigned long phys_initrd_size __initdata = 0;
 
 static int __init early_initrd(char *p)
 {
diff --git a/arch/unicore32/mm/init.c b/arch/unicore32/mm/init.c
index 8f8699e62bd5..4dd26d6f02e5 100644
--- a/arch/unicore32/mm/init.c
+++ b/arch/unicore32/mm/init.c
@@ -31,8 +31,8 @@
 
 #include "mm.h"
 
-static unsigned long phys_initrd_start __initdata = 0x01000000;
-static unsigned long phys_initrd_size __initdata = SZ_8M;
+phys_addr_t phys_initrd_start __initdata = 0x01000000;
+unsigned long phys_initrd_size __initdata = SZ_8M;
 
 static int __init early_initrd(char *p)
 {
diff --git a/include/linux/initrd.h b/include/linux/initrd.h
index 84b423044088..14beaff9b445 100644
--- a/include/linux/initrd.h
+++ b/include/linux/initrd.h
@@ -21,4 +21,7 @@ extern int initrd_below_start_ok;
 extern unsigned long initrd_start, initrd_end;
 extern void free_initrd_mem(unsigned long, unsigned long);
 
+extern phys_addr_t phys_initrd_start;
+extern unsigned long phys_initrd_size;
+
 extern unsigned int real_root_dev;
-- 
2.17.1

