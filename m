Return-Path: <SRS0=bKrn=NQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFC0AC0044C
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 22:58:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 889082081C
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 22:58:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CyP0IHV4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 889082081C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388305AbeKFIUD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Nov 2018 03:20:03 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:32884 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388034AbeKFIUC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Nov 2018 03:20:02 -0500
Received: by mail-pf1-f194.google.com with SMTP id v68-v6so1550436pfk.0;
        Mon, 05 Nov 2018 14:57:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=c8Lf7boHwRJXjni27D65zHCfVda/tTM6oSDLxd215Cs=;
        b=CyP0IHV4UZ15O/1av2PxKPc3fsM1dB9agK8a5/x5JbPuU8ehNbg93f2Z+H3p8P3exi
         AUysi1kvzZ/nzXqIkehj9x3Ty4dTQW1tZ2GiD9b1pDhZZhcQLbJBYft327OsaDdMCnda
         Ok0lC9+RrISTA0Gm2gsdkCQnOQ5EZc7azgT+1N9GydyYITmsfSwncHRfXsaMSz2+uGvc
         L2a8wReRvETau5kwO0UB9OCTE1M0zy8aFm9wXpj4c1y1OZ7bQkajvflID0pJmpJR9ruu
         /fO+Un/RWygfM+tHMG3jsuuVW0Dgp6S4GjVs77Y0YVYmTEH8FuFEH3t8NvQ2Sx5fU3mJ
         b6Yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=c8Lf7boHwRJXjni27D65zHCfVda/tTM6oSDLxd215Cs=;
        b=UhqtYdBSEs3dGdOFeDOV10JS/7OhfZ0FNAaibejgCg3ismdUevHlXFSAfqzNYju2xX
         nAgHtAxQrrUxbmzdZQNpuTxafLFV7CBDvFWabJb3G6VhV5e7nDmk2PoxnnIbGGJzAD6u
         aXFt7FCYOhPwSh0uxv1gmayYuTlNTDyM9UCC+9kXMJNoyYgdJCSlaBeLirpXO8M2HwLt
         HitZXmbdV2hd6/GGsXIq8WE/275orP1Uu5Unq89HVJPcqGbk/OPMMTkQFhqXGAKyCLFv
         fMqjjut+SINdTduCqk9FqvdnUvVFnugnQ+FXh+JBnu770Ain5xjAjrbQiVaztX2G30u0
         CMgw==
X-Gm-Message-State: AGRZ1gJYzU/f3c1KoJLw5lqt0iSEqU+6c+TD8txNZZcVJQfs/IdrwylO
        6v5rpOMr2bF6FFh2nWGeENF36ysW
X-Google-Smtp-Source: AJdET5dhuO49dXcbh8I0TtFMYPgWKi2MHznTTc59VzZ9ztIqA5GdnfEoAUgfNQ6fHDM39vsQv0cnNQ==
X-Received: by 2002:a63:4c6:: with SMTP id 189mr21972247pge.391.1541458678847;
        Mon, 05 Nov 2018 14:57:58 -0800 (PST)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.250])
        by smtp.gmail.com with ESMTPSA id q195sm12898479pgq.7.2018.11.05.14.57.56
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 05 Nov 2018 14:57:58 -0800 (PST)
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
Subject: [PATCH v4 2/6] arch: Make phys_initrd_start and phys_initrd_size global variables
Date:   Mon,  5 Nov 2018 14:54:27 -0800
Message-Id: <20181105225431.24485-3-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181105225431.24485-1-f.fainelli@gmail.com>
References: <20181105225431.24485-1-f.fainelli@gmail.com>
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
index 32e4845af2b6..438625764ccd 100644
--- a/arch/arm/mm/init.c
+++ b/arch/arm/mm/init.c
@@ -50,9 +50,7 @@ unsigned long __init __clear_cr(unsigned long mask)
 }
 #endif
 
-static phys_addr_t phys_initrd_start __initdata = 0;
-static unsigned long phys_initrd_size __initdata = 0;
-
+#ifdef CONFIG_BLK_DEV_INITRD
 static int __init early_initrd(char *p)
 {
 	phys_addr_t start;
@@ -89,6 +87,7 @@ static int __init parse_tag_initrd2(const struct tag *tag)
 }
 
 __tagtable(ATAG_INITRD2, parse_tag_initrd2);
+#endif
 
 static void __init find_limits(unsigned long *min, unsigned long *max_low,
 			       unsigned long *max_high)
diff --git a/arch/unicore32/mm/init.c b/arch/unicore32/mm/init.c
index cf4eb9481fd6..02aa2c0b295e 100644
--- a/arch/unicore32/mm/init.c
+++ b/arch/unicore32/mm/init.c
@@ -30,9 +30,7 @@
 
 #include "mm.h"
 
-static unsigned long phys_initrd_start __initdata = 0x01000000;
-static unsigned long phys_initrd_size __initdata = SZ_8M;
-
+#ifdef CONFIG_BLK_DEV_INITRD
 static int __init early_initrd(char *p)
 {
 	unsigned long start, size;
@@ -48,6 +46,7 @@ static int __init early_initrd(char *p)
 	return 0;
 }
 early_param("initrd", early_initrd);
+#endif
 
 /*
  * This keeps memory configuration data used by a couple memory
@@ -156,6 +155,11 @@ void __init uc32_memblock_init(struct meminfo *mi)
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

