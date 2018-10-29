Return-Path: <SRS0=Xm/m=NJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 280A3C0044C
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 23:52:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E25BB2082D
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 23:52:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="p3ns2q3u"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E25BB2082D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726596AbeJ3Inn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Oct 2018 04:43:43 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:40574 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725824AbeJ3Inn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Oct 2018 04:43:43 -0400
Received: by mail-pl1-f194.google.com with SMTP id b9-v6so4573374pls.7;
        Mon, 29 Oct 2018 16:52:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=IdcEyKMm4vYhsKy4CABorYdVSsAXOdKZ8deL2wX7NRA=;
        b=p3ns2q3uzt5IPKy6pThwMWZ+2BxmXDhR3fDNiRBZP3zz+NeZkGWhmEOqgy3IhrdGZq
         vlO3fgpwrVCPFKTqGDaDJ8cLQuK85GgbCTHTKd4VjD0BG2fTiigh+hFiO5GTR33UqAVH
         gn+5ZYyKvFlJ8F/eeWdo6L20gBgbllK3tLGDiQ5cKJxR/8wB3/Cme35fqIIbG3PP51PX
         Api8AXpXIdJs9arp2NYdfj1XQQbM64UIxW8nZRdv3dJRN8uSNraqY4rZohKP7GhFxVP1
         W7ICGYefk0t+wHCjlJFrGi2CNGZsC88l07AQE0t34lKcPPs5vXLtGfDNgjFOPfnutGFP
         FBEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=IdcEyKMm4vYhsKy4CABorYdVSsAXOdKZ8deL2wX7NRA=;
        b=MT2GwGRQk7pi/7jbb9sbLhIiHr18v446r1/psWsT9YXDYIc+JUhiYlosecHUgW/m3k
         RR14JFCPju8+JruFiiWnAO0jzhtIcgfT3tH/Xuk6twCl+MdkwKPOTeMrA3lI5cbG7qtp
         +YUPwrbF6kuqbuyAWZmxBtVwT7sPQEmbSwN3wNISJvbnRxd3W73QWiIL7KAecNgJ3WVB
         YYpc06aKKSxrqgkIum8xDrhqY5AtH+6MTH10dneXkWNAT2Yh7WgWzBgTQQ4DEo/JaB7O
         n9sGxOjo8AkDQq3mv34DR5OIlQcd8wgejEn0c2RKLme9/3aTl4g+14mFa5n4RKqVFaOs
         D77g==
X-Gm-Message-State: AGRZ1gJoyS6VlP5Srj2GR3aYQ6zvkDkZmJtZzqFakciXGKQXtLuCqJxG
        F48yXdQuJBMmmkF23sDTu1t1weH4
X-Google-Smtp-Source: AJdET5f46Izd+jiHB1knz9Af4+W7TgXITKwkUfBEb0OM3n+3u7kESWfwo+gWbpH5EzG5zr+mUBJzEg==
X-Received: by 2002:a17:902:5066:: with SMTP id f35-v6mr16157636plh.145.1540857159247;
        Mon, 29 Oct 2018 16:52:39 -0700 (PDT)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.250])
        by smtp.gmail.com with ESMTPSA id k13-v6sm22537981pff.30.2018.10.29.16.52.36
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 29 Oct 2018 16:52:38 -0700 (PDT)
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
Subject: [PATCH 3/6] arch: Define ARCH_HAS_PHYS_INITRD for ARM and Unicore32
Date:   Mon, 29 Oct 2018 16:52:03 -0700
Message-Id: <20181029235206.30060-4-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181029235206.30060-1-f.fainelli@gmail.com>
References: <20181029235206.30060-1-f.fainelli@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Make ARM and Unicore32 select ARCH_HAS_PHYS_INITRD meaning that they do
define phys_initrd_start/phys_initrd_size and make use of it.

Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 arch/Kconfig           | 7 +++++++
 arch/arm/Kconfig       | 1 +
 arch/unicore32/Kconfig | 1 +
 3 files changed, 9 insertions(+)

diff --git a/arch/Kconfig b/arch/Kconfig
index 9d329608913e..0926f8291782 100644
--- a/arch/Kconfig
+++ b/arch/Kconfig
@@ -865,6 +865,13 @@ config HAVE_ARCH_PREL32_RELOCATIONS
 	  architectures, and don't require runtime relocation on relocatable
 	  kernels.
 
+config ARCH_HAS_PHYS_INITRD
+	bool
+	help
+	  An architecture selects this when it needs to act on the physical
+	  address of the initial ramdisk and allow generic code such as
+	  FDT to populate that address.
+
 source "kernel/gcov/Kconfig"
 
 source "scripts/gcc-plugins/Kconfig"
diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index e8cd55a5b04c..b87c40701b0e 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -11,6 +11,7 @@ config ARM
 	select ARCH_HAS_KCOV
 	select ARCH_HAS_MEMBARRIER_SYNC_CORE
 	select ARCH_HAS_PTE_SPECIAL if ARM_LPAE
+	select ARCH_HAS_PHYS_INITRD
 	select ARCH_HAS_PHYS_TO_DMA
 	select ARCH_HAS_SET_MEMORY
 	select ARCH_HAS_STRICT_KERNEL_RWX if MMU && !XIP_KERNEL
diff --git a/arch/unicore32/Kconfig b/arch/unicore32/Kconfig
index 0c5111b206bd..28a66ae61dcf 100644
--- a/arch/unicore32/Kconfig
+++ b/arch/unicore32/Kconfig
@@ -2,6 +2,7 @@
 config UNICORE32
 	def_bool y
 	select ARCH_HAS_DEVMEM_IS_ALLOWED
+	select ARCH_HAS_PHYS_INITRD
 	select ARCH_MIGHT_HAVE_PC_PARPORT
 	select ARCH_MIGHT_HAVE_PC_SERIO
 	select DMA_DIRECT_OPS
-- 
2.17.1

