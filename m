Return-Path: <SRS0=BpFy=NK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A889DECDE44
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 23:07:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6EB2520664
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 23:07:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UUXhujGf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6EB2520664
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728744AbeJaIDX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Oct 2018 04:03:23 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:32827 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727858AbeJaIDW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Oct 2018 04:03:22 -0400
Received: by mail-pl1-f195.google.com with SMTP id x6-v6so6303872pln.0;
        Tue, 30 Oct 2018 16:07:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=CteUHCiT3bh5b73LsUL36lgcSDw4lEHSbSt99SlriBg=;
        b=UUXhujGfL14NRDqPfKn6FSvhZSCfkSHNuSb5jfvBJnOc0CLZptOttqXRuyXYZg2bMd
         7rj6ddzD+CbrCTySSyyZzBwZoBP/QKiK7yU0bxDG5+vIHY+OX0ecE83Yl/qeIYA3az1f
         y9RBbutQnQaMojkxq1YZSJUxRQWhDoJnyZeo1czpiEbFe8K9prQ5RmosLxexxJkH6MJ7
         56Aq9Ic81IH1sCbTEPIBvrCY8yJXlTyob+r0xkB+g/K6pxUgDvn9WefsWoE4CBcW5hBC
         oaVUKTab5Zn17XsO9uVcyKnoV+2Y9QiAmGFc9CVGigSw4tRmSOo8xFUGd8S/Jt5SS5Xb
         1Pmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=CteUHCiT3bh5b73LsUL36lgcSDw4lEHSbSt99SlriBg=;
        b=DztnVcRTmrfH39jhSA51rhtTooCm11B3N70B7GFeIjaWTEPKfKF+6tpd+YNdO7xWFh
         vxhZxPh460Sbs076tnB1wwEWRUIwb/9GDJZDdV4LTmvJ050TiToCNFObJcBBBhvra0aT
         Fye+N4lmxeGDorvIlItgfDS7w4cESYx708n5O7Cfb00tHAX9Kgto4TxIhPA9yjNTJBxR
         HX9v7W9SCitUUmFyF3WrK5T9zTh73jeUrNvRgqK0PzMLylMg2M3o7atF67DrJ0BQT6mV
         9K2p0JBw7H/auyIlIj68Uo2lds1vSJZbBLCXvXQ7kw2ouT8lj8MbRJf7N4Lnhc4ewCKq
         /gig==
X-Gm-Message-State: AGRZ1gJQ56vPRyh5RLu9HPOY8AsxapFBQ9WE52/feCumBdu9c76RdEqZ
        Pq8saZOzmYQfnoELdu4mKjHvMWJ4
X-Google-Smtp-Source: AJdET5cyVn4hnvlH85D46Mi/A/vW1eO9/OyDjm75+wkdTfFT/BuaZ4CkNtuXASETZY9tMFK4wqN2ig==
X-Received: by 2002:a17:902:8bc6:: with SMTP id r6-v6mr728986plo.0.1540940873633;
        Tue, 30 Oct 2018 16:07:53 -0700 (PDT)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.250])
        by smtp.gmail.com with ESMTPSA id f14-v6sm3431689pgr.87.2018.10.30.16.07.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 30 Oct 2018 16:07:52 -0700 (PDT)
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
Subject: [PATCH v2 4/6] arm64: Utilize phys_initrd_start/phys_initrd_size
Date:   Tue, 30 Oct 2018 16:07:19 -0700
Message-Id: <20181030230721.28429-5-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181030230721.28429-1-f.fainelli@gmail.com>
References: <20181030230721.28429-1-f.fainelli@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ARM64 is the only architecture that re-defines
__early_init_dt_declare_initrd() in order for that function to populate
initrd_start/initrd_end with physical addresses instead of virtual
addresses. Instead of having an override we can leverage
drivers/of/fdt.c populating phys_initrd_start/phys_initrd_size to
populate those variables for us.

Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 arch/arm64/mm/init.c | 21 +++++++++------------
 1 file changed, 9 insertions(+), 12 deletions(-)

diff --git a/arch/arm64/mm/init.c b/arch/arm64/mm/init.c
index 3cf87341859f..e95cee656a55 100644
--- a/arch/arm64/mm/init.c
+++ b/arch/arm64/mm/init.c
@@ -72,8 +72,8 @@ static int __init early_initrd(char *p)
 	if (*endp == ',') {
 		size = memparse(endp + 1, NULL);
 
-		initrd_start = start;
-		initrd_end = start + size;
+		phys_initrd_start = start;
+		phys_initrd_size = size;
 	}
 	return 0;
 }
@@ -408,14 +408,14 @@ void __init arm64_memblock_init(void)
 		memblock_add(__pa_symbol(_text), (u64)(_end - _text));
 	}
 
-	if (IS_ENABLED(CONFIG_BLK_DEV_INITRD) && initrd_start) {
+	if (IS_ENABLED(CONFIG_BLK_DEV_INITRD) && phys_initrd_size) {
 		/*
 		 * Add back the memory we just removed if it results in the
 		 * initrd to become inaccessible via the linear mapping.
 		 * Otherwise, this is a no-op
 		 */
-		u64 base = initrd_start & PAGE_MASK;
-		u64 size = PAGE_ALIGN(initrd_end) - base;
+		u64 base = phys_initrd_start & PAGE_MASK;
+		u64 size = PAGE_ALIGN(phys_initrd_size);
 
 		/*
 		 * We can only add back the initrd memory if we don't end up
@@ -460,13 +460,10 @@ void __init arm64_memblock_init(void)
 	 */
 	memblock_reserve(__pa_symbol(_text), _end - _text);
 #ifdef CONFIG_BLK_DEV_INITRD
-	if (initrd_start) {
-		memblock_reserve(initrd_start, initrd_end - initrd_start);
-
-		/* the generic initrd code expects virtual addresses */
-		initrd_start = __phys_to_virt(initrd_start);
-		initrd_end = __phys_to_virt(initrd_end);
-	}
+	/* the generic initrd code expects virtual addresses */
+	initrd_start = __phys_to_virt(phys_initrd_start);
+	initrd_end = initrd_start + phys_initrd_size;
+	initrd_below_start_ok = 0;
 #endif
 
 	early_init_fdt_scan_reserved_mem();
-- 
2.17.1

