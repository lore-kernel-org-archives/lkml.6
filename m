Return-Path: <SRS0=BpFy=NK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8D47C6786F
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 23:08:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 605D120664
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 23:08:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b0sSpAaX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 605D120664
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728773AbeJaID2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Oct 2018 04:03:28 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:35105 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727858AbeJaID1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Oct 2018 04:03:27 -0400
Received: by mail-pl1-f195.google.com with SMTP id n4-v6so5716737plp.2;
        Tue, 30 Oct 2018 16:07:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=7vZ19uPI3mKDruwtH4hU5/wYDf7iys0covNZuN4RSWo=;
        b=b0sSpAaXkV+xyGM/W1Dq7x6l7i0iLY0M7JtiE3/s6y5TUBH+cGaQtDtOf93jahVdTD
         oHL1TVOyTgX86GsDq8LUIF0rgG32sT1DUbSy9encWrmXzJL67dodIxnKZSuu0NhjzDhv
         Q4sL/vKzhJ/Hd7Z3YIESj66/39l9rbOXK9dcH1Hl0qpebYme9SM1d+bJGDzh7zQbE1TC
         uBKgNoEdFV8goBbm0j6gKye5vA/9TfvH6NThX98aaqss9Tv/bHhZCLHcW0n1uXyG0SHx
         We98aLGRQmim90uKOWeIG2eEFr64WCV+lVFiTE7dms5EPnCe0tZibhjhmXmgQolatwXM
         tVuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=7vZ19uPI3mKDruwtH4hU5/wYDf7iys0covNZuN4RSWo=;
        b=IanwQFm8bBu33AB4wJajrBB1uROreqA3iWY7HQjusIKo0bM+tyOteTioM5qpaYZe6G
         nY/ymUy0fBCceJv9NEckrFF+uFgbuc2xacy0HBgMl4MuZErM6YgOX3x6UqOhxoUbJlwd
         jbuNRrbMawLohHy//wM23jypaxQsv3po9qyC0x88GRtSInH9pQDv6Mx7tg1Ks/+Y3w6f
         1Zt/cgKxW119mm56l36GjgvNv+eoNAUGNQwUVqLiEAbARFb/OycxMf4mRHTTu5wa1QMx
         mAYudPAFOaaXS0ikg5DUx0IuuItSy7qFNdj9z7N6WfZNy0TUVhh4jyreqCE6chcj6c1y
         8Q+g==
X-Gm-Message-State: AGRZ1gJKyxsHhfMJ0JVf9d4468qMQIC8JeswoDmHNGxxFcUiXrabNCws
        Y1oC8aS8frf+MwWX8+0nNNMVm6t/
X-Google-Smtp-Source: AJdET5eviuElsLX8rPl6Mz0asQbMeCOFXEQ6YBKHFU4VYo0dfi/kdR8jNLu5Vd+mraOxhHnBsbScag==
X-Received: by 2002:a17:902:4165:: with SMTP id e92-v6mr681021pld.209.1540940878369;
        Tue, 30 Oct 2018 16:07:58 -0700 (PDT)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.250])
        by smtp.gmail.com with ESMTPSA id f14-v6sm3431689pgr.87.2018.10.30.16.07.56
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 30 Oct 2018 16:07:57 -0700 (PDT)
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
Subject: [PATCH v2 6/6] arch: Move initrd= parsing into do_mounts_initrd.c
Date:   Tue, 30 Oct 2018 16:07:21 -0700
Message-Id: <20181030230721.28429-7-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181030230721.28429-1-f.fainelli@gmail.com>
References: <20181030230721.28429-1-f.fainelli@gmail.com>
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
index ba145065c579..369d3d699929 100644
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
+		initrd_start = __va(phys_initrd_start);
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
index e95cee656a55..9045afacd10b 100644
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

