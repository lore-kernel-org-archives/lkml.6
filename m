Return-Path: <SRS0=IMz2=NL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A46A9C0044C
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 19:29:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5D7F92080A
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 19:29:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="vdltxklZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5D7F92080A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729818AbeKAE2u (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Nov 2018 00:28:50 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:43615 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729675AbeKAE2t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Nov 2018 00:28:49 -0400
Received: by mail-pf1-f194.google.com with SMTP id h4-v6so8082756pfi.10;
        Wed, 31 Oct 2018 12:29:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=5j60GEU6Ljw/I5Ca9LSFmDQ7oj14gOZEndsrmXAstxw=;
        b=vdltxklZMMPkGWW7XdnbZwTVrgnCwrHMn+ZhwZswutL+GQIBajARJtpxPzIBRojnZP
         GJAYp1vGb1c2oAlpgUoxIV7wNfA093b6j05kLcyPZPyFxjOqsaQC3tkb9YbhrATa4qLd
         V1Cpa1S5pAZUaWcq8/WYroncos1IXZlKq/fd4aEK7HdxgucQbMkvPhbsWNskTe9VFyet
         u6m30Q2x8O0/SkV1dmdsOaQb5HsB7Y33KO8TQNQcEyOLxtfWCUWa5B2hDyH2TmgEvqKE
         ID/xFOU4KrEWMc4GEiKD27EyRSzSzrRd21w/lXCs8p3wIbJ/UB5mWOpXjKhf2ZoxkCD6
         reQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=5j60GEU6Ljw/I5Ca9LSFmDQ7oj14gOZEndsrmXAstxw=;
        b=Ap/5+2mw/KYZDQyNQE4NyorPWcIIEfwLxQTH1si+9Z+InaM1mcl5Fz9VnMvh8BoXP/
         h7p50qmIdNy3n2hPa6JulIgKZ2suVv/XE6xtl+4zMTKh6HvUTvVE4WhoCQ4xzyP4UJaX
         ppoysHIMLYwgZ5733CB9MGIoqmWY1n0xe42P6g0vscrY58y1B0xUHaLzXjFccXbC3vbI
         YQmqaRETdEG+uEsiYk/FMT3cKj+vQLVpcNV2tndY+ArDwB/AnMQguP3gz8MQn/DXQsOw
         Gr530/huAZOJCiz6z1Kua57plOhjr4nzkLUkyyD/s7qvaRB9gwxWutY1LQtyipAx+Lk7
         rdVQ==
X-Gm-Message-State: AGRZ1gKEDONWhGNHemBrLVkpseVPDGsIAI3lRNaUHe6dWGKfn2h4KdP8
        QShGGMpZgaHDvlRCnmsqvBLuFtbs
X-Google-Smtp-Source: AJdET5e2+DYaOxaZsBcydUIjBlxIQch6BsGhmfPxRLI72XMBPMdU6VXGLpdwYPq5OUqfOLvH3Sk+zA==
X-Received: by 2002:a62:642:: with SMTP id 63-v6mr4644665pfg.190.1541014161769;
        Wed, 31 Oct 2018 12:29:21 -0700 (PDT)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.250])
        by smtp.gmail.com with ESMTPSA id z26-v6sm28926456pfh.77.2018.10.31.12.29.19
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 31 Oct 2018 12:29:20 -0700 (PDT)
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
Subject: [PATCH v3 6/6] arch: Move initrd= parsing into do_mounts_initrd.c
Date:   Wed, 31 Oct 2018 12:28:43 -0700
Message-Id: <20181031192843.13230-7-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181031192843.13230-1-f.fainelli@gmail.com>
References: <20181031192843.13230-1-f.fainelli@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ARC, ARM, ARM64 and Unicore32 are all capable of parsing the "initrd="
command line parameter to allow specifying the physical address and size
of an initrd. Move that parsing into init/do_mounts_initrd.c such that
we no longer duplicate that logic.

Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 arch/arc/mm/init.c       | 25 +++++--------------------
 arch/arm/mm/init.c       | 17 -----------------
 arch/arm64/mm/init.c     | 18 ------------------
 arch/unicore32/mm/init.c | 18 ------------------
 init/do_mounts_initrd.c  | 17 +++++++++++++++++
 5 files changed, 22 insertions(+), 73 deletions(-)

diff --git a/arch/arc/mm/init.c b/arch/arc/mm/init.c
index ba145065c579..55879a9dee0d 100644
--- a/arch/arc/mm/init.c
+++ b/arch/arc/mm/init.c
@@ -79,24 +79,6 @@ void __init early_init_dt_add_memory_arch(u64 base, u64 size)
 		base, TO_MB(size), !in_use ? "Not used":"");
 }
 
-#ifdef CONFIG_BLK_DEV_INITRD
-static int __init early_initrd(char *p)
-{
-	unsigned long start, size;
-	char *endp;
-
-	start = memparse(p, &endp);
-	if (*endp == ',') {
-		size = memparse(endp + 1, NULL);
-
-		initrd_start = (unsigned long)__va(start);
-		initrd_end = (unsigned long)__va(start + size);
-	}
-	return 0;
-}
-early_param("initrd", early_initrd);
-#endif
-
 /*
  * First memory setup routine called from setup_arch()
  * 1. setup swapper's mm @init_mm
@@ -141,8 +123,11 @@ void __init setup_arch_memory(void)
 	memblock_reserve(low_mem_start, __pa(_end) - low_mem_start);
 
 #ifdef CONFIG_BLK_DEV_INITRD
-	if (initrd_start)
-		memblock_reserve(__pa(initrd_start), initrd_end - initrd_start);
+	if (phys_initrd_size) {
+		memblock_reserve(phys_initrd_start, phys_initrd_size);
+		initrd_start = (unsigned long)__va(phys_initrd_start);
+		initrd_end = initrd_start + phys_initrd_size;
+	}
 #endif
 
 	early_init_fdt_reserve_self();
diff --git a/arch/arm/mm/init.c b/arch/arm/mm/init.c
index 4bfa08e27319..58ec68709606 100644
--- a/arch/arm/mm/init.c
+++ b/arch/arm/mm/init.c
@@ -52,23 +52,6 @@ unsigned long __init __clear_cr(unsigned long mask)
 #endif
 
 #ifdef CONFIG_BLK_DEV_INITRD
-static int __init early_initrd(char *p)
-{
-	phys_addr_t start;
-	unsigned long size;
-	char *endp;
-
-	start = memparse(p, &endp);
-	if (*endp == ',') {
-		size = memparse(endp + 1, NULL);
-
-		phys_initrd_start = start;
-		phys_initrd_size = size;
-	}
-	return 0;
-}
-early_param("initrd", early_initrd);
-
 static int __init parse_tag_initrd(const struct tag *tag)
 {
 	pr_warn("ATAG_INITRD is deprecated; "
diff --git a/arch/arm64/mm/init.c b/arch/arm64/mm/init.c
index 00ef2166bb73..d95a6cb205b8 100644
--- a/arch/arm64/mm/init.c
+++ b/arch/arm64/mm/init.c
@@ -62,24 +62,6 @@
 s64 memstart_addr __ro_after_init = -1;
 phys_addr_t arm64_dma_phys_limit __ro_after_init;
 
-#ifdef CONFIG_BLK_DEV_INITRD
-static int __init early_initrd(char *p)
-{
-	unsigned long start, size;
-	char *endp;
-
-	start = memparse(p, &endp);
-	if (*endp == ',') {
-		size = memparse(endp + 1, NULL);
-
-		phys_initrd_start = start;
-		phys_initrd_size = size;
-	}
-	return 0;
-}
-early_param("initrd", early_initrd);
-#endif
-
 #ifdef CONFIG_KEXEC_CORE
 /*
  * reserve_crashkernel() - reserves memory for crash kernel
diff --git a/arch/unicore32/mm/init.c b/arch/unicore32/mm/init.c
index f2f815d46846..99acdb829a7e 100644
--- a/arch/unicore32/mm/init.c
+++ b/arch/unicore32/mm/init.c
@@ -31,24 +31,6 @@
 
 #include "mm.h"
 
-#ifdef CONFIG_BLK_DEV_INITRD
-static int __init early_initrd(char *p)
-{
-	unsigned long start, size;
-	char *endp;
-
-	start = memparse(p, &endp);
-	if (*endp == ',') {
-		size = memparse(endp + 1, NULL);
-
-		phys_initrd_start = start;
-		phys_initrd_size = size;
-	}
-	return 0;
-}
-early_param("initrd", early_initrd);
-#endif
-
 /*
  * This keeps memory configuration data used by a couple memory
  * initialization functions, as well as show_mem() for the skipping
diff --git a/init/do_mounts_initrd.c b/init/do_mounts_initrd.c
index 45865b72f4ea..732d21f4a637 100644
--- a/init/do_mounts_initrd.c
+++ b/init/do_mounts_initrd.c
@@ -27,6 +27,23 @@ static int __init no_initrd(char *str)
 
 __setup("noinitrd", no_initrd);
 
+static int __init early_initrd(char *p)
+{
+	phys_addr_t start;
+	unsigned long size;
+	char *endp;
+
+	start = memparse(p, &endp);
+	if (*endp == ',') {
+		size = memparse(endp + 1, NULL);
+
+		phys_initrd_start = start;
+		phys_initrd_size = size;
+	}
+	return 0;
+}
+early_param("initrd", early_initrd);
+
 static int init_linuxrc(struct subprocess_info *info, struct cred *new)
 {
 	ksys_unshare(CLONE_FS | CLONE_FILES);
-- 
2.17.1

