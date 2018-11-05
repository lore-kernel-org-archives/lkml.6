Return-Path: <SRS0=bKrn=NQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 202B0C0044C
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 22:58:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D833F20827
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 22:58:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kDJEVAds"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D833F20827
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388333AbeKFIUH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Nov 2018 03:20:07 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:46601 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388222AbeKFIUG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Nov 2018 03:20:06 -0500
Received: by mail-pf1-f193.google.com with SMTP id r64-v6so5125162pfb.13;
        Mon, 05 Nov 2018 14:58:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=7Vou5vVu4RKvAqs88jCWoihjXzu3Wlr6TO2JLowYDRM=;
        b=kDJEVAdsERwYIlX5+2Vrkqaj0BTN6p8aDefmLjKN5mbEGb+FBljef9xNHVvNFNrgTi
         Q/ZfbsmxXzcEnUC1VHDmsH19JmKFfglQScp+oUo+M0SFCgMdI6pOx9NFZk8bsZV8unLJ
         Ud1svpoLogycdF4H0r4zLTJ88pD1QvT2NpHb5pzNUu01xBUvKLN6MBBgLCU+MAntw9Ts
         EZes07bkorRQ2wJO1fx0eTKEndC1lmMj41fRXcepJAOh+GzqJSmR932FXSJqw4xu9vhQ
         UE9KizynXofvpcV9HEncqXKyJSwvO+SqtskYbau8AR9uj/aa5S7G6srBSZIPjqJt89HG
         Mwiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=7Vou5vVu4RKvAqs88jCWoihjXzu3Wlr6TO2JLowYDRM=;
        b=iCMambCmUgHc/aDtbOs6kj+/VOXKmEnBwcUVOvlUcoJyCwzhPkWKUpF1Rmm51dztMT
         ZT9wM/ev6CLPtz2GY76wmBMCscubApbShZndeZVsraDu+7QiFSK7VygRF3NOfxdNjYvM
         Dir3lEq17K3YfCInYukBf9aWFS5OV31O47fMoqsLaOy1zAOJYcok4EOz8As9RvfYdWb4
         H0cChwrXST9FWM+Xde30SWCbCK83ipgVdZgSRKvLaaJURvLlknZAT97brpThDSJ6NyLT
         ZjrNtta7cfwpQ7FOGnF79PXsG5opHShNhERAeVHjcLPrH6qTmDv20ubvhnR1pE75tpRX
         uZkg==
X-Gm-Message-State: AGRZ1gJkeiveSZZAJG56yeHvQD6Xr5wXvkBC4HaLk+pjc0aLdXV+svdf
        CXpJmR9Ld+OB45wIk90BB66hew4v
X-Google-Smtp-Source: AJdET5ddyQGSqhxevM1e6bjyaRrdfkIWp7CNFVqSujcFoCbLvaIi7LmRdXKDg66XjYTAe4Fs8cYSFA==
X-Received: by 2002:a63:6906:: with SMTP id e6mr21284110pgc.144.1541458683551;
        Mon, 05 Nov 2018 14:58:03 -0800 (PST)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.250])
        by smtp.gmail.com with ESMTPSA id q195sm12898479pgq.7.2018.11.05.14.58.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 05 Nov 2018 14:58:02 -0800 (PST)
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
Subject: [PATCH v4 4/6] arm64: Utilize phys_initrd_start/phys_initrd_size
Date:   Mon,  5 Nov 2018 14:54:29 -0800
Message-Id: <20181105225431.24485-5-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181105225431.24485-1-f.fainelli@gmail.com>
References: <20181105225431.24485-1-f.fainelli@gmail.com>
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
 arch/arm64/mm/init.c | 20 ++++++++------------
 1 file changed, 8 insertions(+), 12 deletions(-)

diff --git a/arch/arm64/mm/init.c b/arch/arm64/mm/init.c
index 9d9582cac6c4..a66ffcde5f13 100644
--- a/arch/arm64/mm/init.c
+++ b/arch/arm64/mm/init.c
@@ -71,8 +71,8 @@ static int __init early_initrd(char *p)
 	if (*endp == ',') {
 		size = memparse(endp + 1, NULL);
 
-		initrd_start = start;
-		initrd_end = start + size;
+		phys_initrd_start = start;
+		phys_initrd_size = size;
 	}
 	return 0;
 }
@@ -407,14 +407,14 @@ void __init arm64_memblock_init(void)
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
@@ -458,15 +458,11 @@ void __init arm64_memblock_init(void)
 	 * pagetables with memblock.
 	 */
 	memblock_reserve(__pa_symbol(_text), _end - _text);
-#ifdef CONFIG_BLK_DEV_INITRD
-	if (initrd_start) {
-		memblock_reserve(initrd_start, initrd_end - initrd_start);
-
+	if (IS_ENABLED(CONFIG_BLK_DEV_INITRD) && phys_initrd_size) {
 		/* the generic initrd code expects virtual addresses */
-		initrd_start = __phys_to_virt(initrd_start);
-		initrd_end = __phys_to_virt(initrd_end);
+		initrd_start = __phys_to_virt(phys_initrd_start);
+		initrd_end = initrd_start + phys_initrd_size;
 	}
-#endif
 
 	early_init_fdt_scan_reserved_mem();
 
-- 
2.17.1

