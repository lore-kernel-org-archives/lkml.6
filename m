Return-Path: <SRS0=IMz2=NL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDA10C0044C
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 19:29:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 93F3B2080A
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 19:29:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D0UGJxw3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 93F3B2080A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729661AbeKAE2k (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Nov 2018 00:28:40 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:42724 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726234AbeKAE2j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Nov 2018 00:28:39 -0400
Received: by mail-pg1-f195.google.com with SMTP id i4-v6so7843122pgq.9;
        Wed, 31 Oct 2018 12:29:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Nke71ZtNfiPXWX+lqnx2jsJDUBi6cIRk7Gj2+Ze+5Dk=;
        b=D0UGJxw3IGuKJzlh+u4+fs2s7gNUwg8fQuGu1ip5JsGEqMxKoquGfU+ihR2eJ3LBMv
         zZ5PrRZdKm714Sjb0mtalmZeVSoaTRyhml3lZ9e7sGe/uGt+PD0zG1NpZD+8w8qaqTP4
         RS+WH28jKMN6W6gaszDpwGisAJYSekv85TE9EHtqGBpFlHQBfFZhNUAvfFihAO+YC/za
         393UONZWP7dwZTUD8eyp7lmjWXaGljzlapCkgqyMQXekjHtNrdOX4f7dQAG2JW/+pFTK
         3j+k4ORwjzwTCo/8RVJnhwLDKoEIkhsVbsoEKQMeH6ICmnlQ1S5T4PWymEyUl42NWf8v
         G3kQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Nke71ZtNfiPXWX+lqnx2jsJDUBi6cIRk7Gj2+Ze+5Dk=;
        b=Op3wy5sIkNrW/XYJTjL5EMtaM7b7L9A4jez6g20IKy4TChoq+m/W4GazrOqL+qjG6g
         FP6RbXfOjEV4EMvhs71ESM8A92uglyDwlTNpSxwFdf67qM8arTrfcbeIufM1DIZU7yec
         9OnLy1vIOjVu1xgiNeVV+rCIj2KONQQGRNspQY0I23fkBhR4HyDd3siFLXgvtUFoVwhV
         07zZ3TIn/yZyVorLyyweWshA/RrsZDh+wS8reYRUovtrb5Cx99RXJZ5/xhHlcu+phkI0
         MECZxZ/MmX/uIqncNpSWMzmcS3kFByNXC0O9XEejXYW9umarB6c41oDTZkPHxQR6ubc3
         WZQw==
X-Gm-Message-State: AGRZ1gJ1iru5LbHEtp7ZJ+vcCCpsdpfMAEpR8JNg0ryforsOfrhAb22e
        2WGPai8Jiq2KXkplIGnH8E4YlNW2
X-Google-Smtp-Source: AJdET5dzBHnEWkvmunA1zp0PYTlyCqOoDYDKWzefUTAi4zGUGEXmQiPQZ5/ZX7frYGKPK/LF0uLSyg==
X-Received: by 2002:a63:344e:: with SMTP id b75mr4264890pga.184.1541014152169;
        Wed, 31 Oct 2018 12:29:12 -0700 (PDT)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.250])
        by smtp.gmail.com with ESMTPSA id z26-v6sm28926456pfh.77.2018.10.31.12.29.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 31 Oct 2018 12:29:11 -0700 (PDT)
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
Subject: [PATCH v3 2/6] arch: Make phys_initrd_start and phys_initrd_size global variables
Date:   Wed, 31 Oct 2018 12:28:39 -0700
Message-Id: <20181031192843.13230-3-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181031192843.13230-1-f.fainelli@gmail.com>
References: <20181031192843.13230-1-f.fainelli@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Make phys_initrd_start and phys_initrd_size global variables declared in
init/do_mounts_initrd.c such that we can later have generic code in
drivers/of/fdt.c populate those variables for us.

This requires both the ARM and unicore32 implementations to be properly
guarded against CONFIG_BLK_DEV_INITRD, and also initialize the variables
to the expected default values (unicore32).

Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 arch/arm/mm/init.c       |  5 ++---
 arch/unicore32/mm/init.c | 10 +++++++---
 include/linux/initrd.h   |  3 +++
 init/do_mounts_initrd.c  |  3 +++
 4 files changed, 15 insertions(+), 6 deletions(-)

diff --git a/arch/arm/mm/init.c b/arch/arm/mm/init.c
index 0cc8e04295a4..87d59a53861d 100644
--- a/arch/arm/mm/init.c
+++ b/arch/arm/mm/init.c
@@ -51,9 +51,7 @@ unsigned long __init __clear_cr(unsigned long mask)
 }
 #endif
 
-static phys_addr_t phys_initrd_start __initdata = 0;
-static unsigned long phys_initrd_size __initdata = 0;
-
+#ifdef CONFIG_BLK_DEV_INITRD
 static int __init early_initrd(char *p)
 {
 	phys_addr_t start;
@@ -90,6 +88,7 @@ static int __init parse_tag_initrd2(const struct tag *tag)
 }
 
 __tagtable(ATAG_INITRD2, parse_tag_initrd2);
+#endif
 
 static void __init find_limits(unsigned long *min, unsigned long *max_low,
 			       unsigned long *max_high)
diff --git a/arch/unicore32/mm/init.c b/arch/unicore32/mm/init.c
index 8f8699e62bd5..f2f815d46846 100644
--- a/arch/unicore32/mm/init.c
+++ b/arch/unicore32/mm/init.c
@@ -31,9 +31,7 @@
 
 #include "mm.h"
 
-static unsigned long phys_initrd_start __initdata = 0x01000000;
-static unsigned long phys_initrd_size __initdata = SZ_8M;
-
+#ifdef CONFIG_BLK_DEV_INITRD
 static int __init early_initrd(char *p)
 {
 	unsigned long start, size;
@@ -49,6 +47,7 @@ static int __init early_initrd(char *p)
 	return 0;
 }
 early_param("initrd", early_initrd);
+#endif
 
 /*
  * This keeps memory configuration data used by a couple memory
@@ -157,6 +156,11 @@ void __init uc32_memblock_init(struct meminfo *mi)
 	memblock_reserve(__pa(_text), _end - _text);
 
 #ifdef CONFIG_BLK_DEV_INITRD
+	if (!phys_initrd_size) {
+		phys_initrd_start = 0x01000000;
+		phys_initrd_size = SZ_8M;
+	}
+
 	if (phys_initrd_size) {
 		memblock_reserve(phys_initrd_start, phys_initrd_size);
 
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
diff --git a/init/do_mounts_initrd.c b/init/do_mounts_initrd.c
index d1a5d885ce13..45865b72f4ea 100644
--- a/init/do_mounts_initrd.c
+++ b/init/do_mounts_initrd.c
@@ -16,6 +16,9 @@ int initrd_below_start_ok;
 unsigned int real_root_dev;	/* do_proc_dointvec cannot handle kdev_t */
 static int __initdata mount_initrd = 1;
 
+phys_addr_t phys_initrd_start __initdata;
+unsigned long phys_initrd_size __initdata;
+
 static int __init no_initrd(char *str)
 {
 	mount_initrd = 0;
-- 
2.17.1

