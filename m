Return-Path: <SRS0=IMz2=NL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBFBCC0044C
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 19:29:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AF74C2081B
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 19:29:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="vA8N1UIx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AF74C2081B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729713AbeKAE2n (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Nov 2018 00:28:43 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:45755 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726234AbeKAE2l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Nov 2018 00:28:41 -0400
Received: by mail-pf1-f194.google.com with SMTP id v5-v6so3188526pfm.12;
        Wed, 31 Oct 2018 12:29:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=7tZFK7bYGAH6azDS0jVMH4AjaPmsUCiqxVsDGGft9WU=;
        b=vA8N1UIxQSNN3c9Eg3wKCuIOUlLhDFbSdwknGtTPeuB23mOKhHq+pAx49cvurIx/1H
         E0Xefpwx6txhNs7gRipgsiYZN3oPbJSUY6QM9Kmd+dG4wPWXWx6Q+xxBweRWmPyIw2Wi
         Kk9zRCPXTj+ihsDe/vqNTxiTUisWP1Q2mPRJAhI/unv23fbnP9TfMcCad+Tb89jqcK29
         Z6Fh28nkxt1e4TwKpKMLnnbDmMICWibih7w9wogkIYR2XekkZ/9A4JwWx7A/MUU5MgKF
         1qqK+kl1mPkZPFnvr+X9RA+Pzw8tVmNDkcb5p34vcdNOvDIPmA5tmJlSNL2sFrHfRr8r
         1WJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=7tZFK7bYGAH6azDS0jVMH4AjaPmsUCiqxVsDGGft9WU=;
        b=Bx7DXYgNAx2loJLRTIGbgYCFXJJcr2RE/3/GS/4YfUrLvjM+iRmwZu8Sp5Q3wc4suq
         62ltCCVadqCzDgf/xHn2wmI6wc9UZrmzktSdxarSKhE1mYeQZJn3bQ8LD8Ab6J98XBos
         N9SK2lb3jdMDCddqNlYKWhT/iP6wMO3A/chY/s+imEukD1XgWMeuieTObd8uMffoNZ+Z
         o5t0GEQCC/GERQZ1TJJZNMJeo9zs3w5UozgdvDYpRx5Icb0Yw9jEiRd9pf7UrO2HImBM
         q20YNt0LlqGr32ehNzQ1xXfLxnAUmkmQaS1lvtzr9fGGa30E1qTRtyzmdlAcycH+cZNI
         ZO/w==
X-Gm-Message-State: AGRZ1gL1PULS1leg1a/yjMbxROEebS/IeiNF+tOu4WCAvif6Xksz1umY
        4G9JxdK0zyGOsiECnMljZFkZY8Ue
X-Google-Smtp-Source: AJdET5fLCucVlH6aV8ts9uo9jBCJeyn6ATPQBfMxTR64pVzzv0mNeOVph4rvAhlZHpsx8FVIk4m1Rw==
X-Received: by 2002:a63:bd51:: with SMTP id d17mr4418712pgp.443.1541014154473;
        Wed, 31 Oct 2018 12:29:14 -0700 (PDT)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.250])
        by smtp.gmail.com with ESMTPSA id z26-v6sm28926456pfh.77.2018.10.31.12.29.12
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 31 Oct 2018 12:29:13 -0700 (PDT)
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
Subject: [PATCH v3 3/6] of/fdt: Populate phys_initrd_start/phys_initrd_size from FDT
Date:   Wed, 31 Oct 2018 12:28:40 -0700
Message-Id: <20181031192843.13230-4-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181031192843.13230-1-f.fainelli@gmail.com>
References: <20181031192843.13230-1-f.fainelli@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now that we have central and global variables holding the physical
address and size of the initrd, we can have
early_init_dt_check_for_initrd() populate
phys_initrd_start/phys_initrd_size for us.

This allows us to remove a chunk of code from arch/arm/mm/init.c
introduced with commit 65939301acdb ("arm: set initrd_start/initrd_end
for fdt scan").

Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 arch/arm/mm/init.c | 6 ------
 drivers/of/fdt.c   | 2 ++
 2 files changed, 2 insertions(+), 6 deletions(-)

diff --git a/arch/arm/mm/init.c b/arch/arm/mm/init.c
index 87d59a53861d..4bfa08e27319 100644
--- a/arch/arm/mm/init.c
+++ b/arch/arm/mm/init.c
@@ -236,12 +236,6 @@ static void __init arm_initrd_init(void)
 	phys_addr_t start;
 	unsigned long size;
 
-	/* FDT scan will populate initrd_start */
-	if (initrd_start && !phys_initrd_size) {
-		phys_initrd_start = __virt_to_phys(initrd_start);
-		phys_initrd_size = initrd_end - initrd_start;
-	}
-
 	initrd_start = initrd_end = 0;
 
 	if (!phys_initrd_size)
diff --git a/drivers/of/fdt.c b/drivers/of/fdt.c
index 76c83c1ffeda..e34cb49231b5 100644
--- a/drivers/of/fdt.c
+++ b/drivers/of/fdt.c
@@ -925,6 +925,8 @@ static void __init early_init_dt_check_for_initrd(unsigned long node)
 	end = of_read_number(prop, len/4);
 
 	__early_init_dt_declare_initrd(start, end);
+	phys_initrd_start = start;
+	phys_initrd_size = end - start;
 
 	pr_debug("initrd_start=0x%llx  initrd_end=0x%llx\n",
 		 (unsigned long long)start, (unsigned long long)end);
-- 
2.17.1

