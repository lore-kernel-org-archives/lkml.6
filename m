Return-Path: <SRS0=bKrn=NQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8D77C0044C
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 22:58:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8E0382081C
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 22:58:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hX90kwsC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8E0382081C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388318AbeKFIUF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Nov 2018 03:20:05 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:42654 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388222AbeKFIUE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Nov 2018 03:20:04 -0500
Received: by mail-pf1-f195.google.com with SMTP id f26-v6so5129577pfn.9;
        Mon, 05 Nov 2018 14:58:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=VgNBTYXASvfvE5mN9VACuM5/lb+HR+nsTuMb/S+Z/g0=;
        b=hX90kwsCj0yrKIiMpZ7BbzUgcA+09UE+Q/W4vNMR20kYsZWoZMckYJyv7JHqrWnt0h
         yiicjwp2yWUN58TjC2wljlRC3YWfEdFxOutYgImI+8pt/4Y4YuMzhAUuVKrnl1lMu7DO
         m45W+18SbXGuIVsv6Be/vpptqn/ZWEmPpEoEcFz889hRt5PFxmw+AGVY/m/jdu0FbK4/
         u/xI9ymccah/ZWD1atE+pQEpk8Xcu+j05VACYam/a1Y3eU5xUcpR6iyeXrp1GaBYSReJ
         sKSJZydJheJlVTo2LdUpp2V8JCXTFGiKWN/0OIDKbcxHf1CqDd9BHoQpf1L/4ods89vk
         8BJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=VgNBTYXASvfvE5mN9VACuM5/lb+HR+nsTuMb/S+Z/g0=;
        b=TzlBm/R60ZsGvIjqG7R75T6hR+8LB5CNB8ZFydZtyochT9xRFUN1hWIayIUaERPApt
         CiZzmJpTFgDbKY+bga9YC66LZbEpbmzRye/LxCzlrvAcLCU1QI4Itrm3gCqYilXfYRhI
         YCTmodqlH4rSQXTdLrcGQITFkaPBfkjow6Aag1ducSOoXpTnDVVTiY7vfRJK0FK+/pus
         jbVXTjLMlk4joElvu6DKyJbrMtSpPj0b6DETFerVXS/zd56zrWRpmB47DO6wl9GdbWsS
         AI4x5rwlpduYAICfwM90N55MwUWSU8HPXG0D7IWZW6+BbjAAO48Ld95CtfMsVMoVLf9D
         Dlrw==
X-Gm-Message-State: AGRZ1gIHieOxeR4HTERlFGrwQ2eWYBDq/ZizOm1kaL4t6fjNqZ5bpIwE
        TLfXzcQgTwMZHmCRfjTIJbaGfVck
X-Google-Smtp-Source: AJdET5flPEUVa4DTrqrXuVeEonToqM7dth/czamRdKp+dc9s1CxfO+MpVIQ0+sNqncZFvhfk1QHf8Q==
X-Received: by 2002:a63:ec12:: with SMTP id j18mr19677663pgh.200.1541458681454;
        Mon, 05 Nov 2018 14:58:01 -0800 (PST)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.250])
        by smtp.gmail.com with ESMTPSA id q195sm12898479pgq.7.2018.11.05.14.57.58
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 05 Nov 2018 14:58:00 -0800 (PST)
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
Subject: [PATCH v4 3/6] of/fdt: Populate phys_initrd_start/phys_initrd_size from FDT
Date:   Mon,  5 Nov 2018 14:54:28 -0800
Message-Id: <20181105225431.24485-4-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181105225431.24485-1-f.fainelli@gmail.com>
References: <20181105225431.24485-1-f.fainelli@gmail.com>
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
index 438625764ccd..a3b6f1f1cbaf 100644
--- a/arch/arm/mm/init.c
+++ b/arch/arm/mm/init.c
@@ -235,12 +235,6 @@ static void __init arm_initrd_init(void)
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
index bb532aae0d92..88760a0983a7 100644
--- a/drivers/of/fdt.c
+++ b/drivers/of/fdt.c
@@ -924,6 +924,8 @@ static void __init early_init_dt_check_for_initrd(unsigned long node)
 	end = of_read_number(prop, len/4);
 
 	__early_init_dt_declare_initrd(start, end);
+	phys_initrd_start = start;
+	phys_initrd_size = end - start;
 
 	pr_debug("initrd_start=0x%llx  initrd_end=0x%llx\n",
 		 (unsigned long long)start, (unsigned long long)end);
-- 
2.17.1

