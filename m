Return-Path: <SRS0=BpFy=NK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFF62ECDE44
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 23:07:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 872E820664
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 23:07:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hvJ0IUj6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 872E820664
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728693AbeJaIDQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Oct 2018 04:03:16 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:42135 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727858AbeJaIDP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Oct 2018 04:03:15 -0400
Received: by mail-pl1-f195.google.com with SMTP id t6-v6so6276876plo.9;
        Tue, 30 Oct 2018 16:07:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=AtQivvj6hJ1qy9E/5uGhpUB8LlJCIsHqyEiYftwE/sA=;
        b=hvJ0IUj6E4TSFw5faIid8dOJVNztuUimjiQ2pBRDEbegFPU7KU3jUtzmGna1JGIjQh
         zpbXRxI88fTPaDX0IAvmwLjP+dOz4ULY5by+5IkcLSBV4e9ho3K/rdxbf95qPeVB9JVl
         GYkGIydp41I9avFp79go0cFyGGi2kGi7IH6nT9Ovh6+fi+usbhx5OZCaPZB0bstr54Fo
         Z52A5CNiExQZ8qi2pIMQ3dp/8jacVQjHjhWlE4wY+Tr/ZLJ8EbFK6OVC0N9TJKnoFktc
         dCjLDSalCzwKFsKDvSYXcKNuL4cMBlpEwK3QxDmH5PXLp2XN2RXgDrkBXP1kAqygYZs5
         QzFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=AtQivvj6hJ1qy9E/5uGhpUB8LlJCIsHqyEiYftwE/sA=;
        b=q8uJDBULHy1gFHwMnwf3EkHkIXpozJnMYdb1urZwLFwRKK/riX64Y3RB1fq40YklQp
         +jppRvnPqjgERe5w9eAJmG+xsEQW3S6NV42t1kkNiQByEdR6r0c3r6f/5rKwGSQkOT3E
         +rnXPsZrJk2m49InqfhBVFliGwjkNBzs3VdrQMaWldhOt+VQumgtPvL+RQwPtpKRhyQV
         85i7MpoEGEk0JTmwYtY3IISE2CIX4H2DikHdyg7psEFmXnvLboNx5AjSxvS1W/YS4v87
         CvXnkCFyM6C9BuJoeyuy5FM5S+eVfFamjUkkeaXqZeOyshz9nr0x4qV6dNlIJL2Al9R2
         5RCA==
X-Gm-Message-State: AGRZ1gIlN2YAEi/WvaWDL2wzPxrWPAy3Mtt9axCs/naOUBlknfrhvzWh
        Xp6aL1sCweAwynnpE/fH+m6Mj69Y
X-Google-Smtp-Source: AJdET5daocjHV5R6DDcOmZHyh7AJ50MHrydI3vK1pmRlvPBjVfl0KFSXUJ0PpENH1LsHXyuMX3p3qw==
X-Received: by 2002:a17:902:2ac3:: with SMTP id j61-v6mr676468plb.139.1540940866511;
        Tue, 30 Oct 2018 16:07:46 -0700 (PDT)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.250])
        by smtp.gmail.com with ESMTPSA id f14-v6sm3431689pgr.87.2018.10.30.16.07.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 30 Oct 2018 16:07:45 -0700 (PDT)
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
Subject: [PATCH v2 1/6] nds32: Remove phys_initrd_start and phys_initrd_size
Date:   Tue, 30 Oct 2018 16:07:16 -0700
Message-Id: <20181030230721.28429-2-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181030230721.28429-1-f.fainelli@gmail.com>
References: <20181030230721.28429-1-f.fainelli@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This will conflict with a subsequent change making phys_initrd_start and
phys_initrd_size global variables. nds32 does not make use of those nor
provides a suitable declarations so just get rid of them.

Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 arch/nds32/mm/init.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/nds32/mm/init.c b/arch/nds32/mm/init.c
index c713d2ad55dc..32f55a24ccbb 100644
--- a/arch/nds32/mm/init.c
+++ b/arch/nds32/mm/init.c
@@ -22,8 +22,6 @@
 DEFINE_PER_CPU(struct mmu_gather, mmu_gathers);
 DEFINE_SPINLOCK(anon_alias_lock);
 extern pgd_t swapper_pg_dir[PTRS_PER_PGD];
-extern unsigned long phys_initrd_start;
-extern unsigned long phys_initrd_size;
 
 /*
  * empty_zero_page is a special page that is used for
-- 
2.17.1

