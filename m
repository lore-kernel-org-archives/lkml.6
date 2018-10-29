Return-Path: <SRS0=Xm/m=NJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64D71C0044C
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 23:52:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 28EF62082D
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 23:52:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WZJiJ7Fs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 28EF62082D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726701AbeJ3Inq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Oct 2018 04:43:46 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:37641 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725824AbeJ3Inp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Oct 2018 04:43:45 -0400
Received: by mail-pf1-f193.google.com with SMTP id j23-v6so4839002pfi.4;
        Mon, 29 Oct 2018 16:52:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=wOKJE9uIABdH60US3sClxZQrg6R8PI279i9FOlxRlG4=;
        b=WZJiJ7FsHbbeZO/tb/j+6S3Yk1wYRnL75lNXEYERbkmvnjNG2uXoHgzIr4XbzLVfOK
         7aVetERjzAO5EQfMfRY1G+h2EeJhdiMyehZUEDWsPPXX3hCcmANOJRtO8I0L1BsWbLBD
         Oi9aU5g/KYBdP2/wt0PfGRqlctLjW3Hcgao3BVaCdwbmAszwjxhPcspRvXbHsqvNUUtV
         VIGFdT5Ezm7cYkLJn82k4M0WO77ISyjSnHZvI6llxFKUoEDYKI7djvt6VdlBZ0+z1a5K
         ASlyo5+GxSFOPNNYXsfYPcTUqBfjx10fosupbrzRNRmyWFsR8kd5TwNZeP0GoI1NLZW5
         M2mQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=wOKJE9uIABdH60US3sClxZQrg6R8PI279i9FOlxRlG4=;
        b=EhjkDLeTrKvYpZv96LI8UPgSPo4GEG9L2ljPQBaleIIofTBcF1y7KyPfetAchcPwop
         /A0KfPBsvjeNXHkZu0zMK5MnOw+Z4YZtPsHffKU1Jz7scMpqabRpNG84ga1onXaIkId6
         CB4GjgtkzcMROdIRF//i9t5TpbmcCLci2ldQMskt9MiBF8Cq97ilprZ9a4gcTRZMhy/D
         EKmVKtregipXXnh6+k/wkAR+wP0DFSqr+kpjAvIA2sIsD5gZelmx5kqeLSR90WUUqSlE
         xbXtL0L/TGCAWzRs3HRm1jXCT35yHxnBUrucZQopWPW3WUIJ49H6z1ubULvUDAIZZfXR
         2CQw==
X-Gm-Message-State: AGRZ1gJIND/ttWhBl2KMcem6nMOAP6B9DBUr67MyElonVScyBC+twgMm
        uGOOQTEWvmI1IcozW1GO6wgDmHoj
X-Google-Smtp-Source: AJdET5f47m1khXFFfa05z8/iowOKmbFK5hnpI9SiwtLHld0dxYAF5hEKNCViFgZU9rKJo/TtkHsh8A==
X-Received: by 2002:a62:460c:: with SMTP id t12-v6mr510305pfa.206.1540857161524;
        Mon, 29 Oct 2018 16:52:41 -0700 (PDT)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.250])
        by smtp.gmail.com with ESMTPSA id k13-v6sm22537981pff.30.2018.10.29.16.52.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 29 Oct 2018 16:52:40 -0700 (PDT)
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
Subject: [PATCH 4/6] of/fdt: Populate phys_initrd_start/phys_initrd_size from FDT
Date:   Mon, 29 Oct 2018 16:52:04 -0700
Message-Id: <20181029235206.30060-5-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181029235206.30060-1-f.fainelli@gmail.com>
References: <20181029235206.30060-1-f.fainelli@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If the architecture implements ARCH_HAS_PHYS_INITRD, make the FDT
scanning code populate the physical address of the start of the FDT and
its size.

Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 arch/arm/mm/init.c | 2 +-
 drivers/of/fdt.c   | 4 ++++
 2 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/arch/arm/mm/init.c b/arch/arm/mm/init.c
index 8f364aa24172..517e95cfb5d2 100644
--- a/arch/arm/mm/init.c
+++ b/arch/arm/mm/init.c
@@ -237,7 +237,7 @@ static void __init arm_initrd_init(void)
 	phys_addr_t start;
 	unsigned long size;
 
-	/* FDT scan will populate initrd_start */
+	/* FDT scan will populate initrd_start and phys_initrd_start */
 	if (initrd_start && !phys_initrd_size) {
 		phys_initrd_start = __virt_to_phys(initrd_start);
 		phys_initrd_size = initrd_end - initrd_start;
diff --git a/drivers/of/fdt.c b/drivers/of/fdt.c
index 76c83c1ffeda..313cd4f24258 100644
--- a/drivers/of/fdt.c
+++ b/drivers/of/fdt.c
@@ -899,6 +899,10 @@ static void __early_init_dt_declare_initrd(unsigned long start,
 	initrd_start = (unsigned long)__va(start);
 	initrd_end = (unsigned long)__va(end);
 	initrd_below_start_ok = 1;
+#ifdef CONFIG_ARCH_HAS_PHYS_INITRD
+	phys_initrd_start = start;
+	phys_initrd_size = end - start;
+#endif
 }
 #endif
 
-- 
2.17.1

