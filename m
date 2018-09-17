Return-Path: <SRS0=ZHI1=L7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F35AECE563
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 04:44:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 168BB2086B
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 04:44:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BuJ3m/6x"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 168BB2086B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728520AbeIQKJp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Sep 2018 06:09:45 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:37786 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727124AbeIQKJo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Sep 2018 06:09:44 -0400
Received: by mail-pg1-f195.google.com with SMTP id 2-v6so7048254pgo.4
        for <linux-kernel@vger.kernel.org>; Sun, 16 Sep 2018 21:44:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=8dyl5n92Y/sUneObKhhlDsuCQS6Q3FjZOl6LkwY3YEI=;
        b=BuJ3m/6x36G3hh8AzArJHtreU/uE6pOyub6/3l8pqREAgTTF/1g8NEh4hhZItnOKYZ
         yujo24psr0RkOmST0KDXerxlDT94/yTSxQ88IfSVhUFeEFGpQuB/6b1+n/8FrKXVjo7C
         Er8oLqatI3O59ZvBUGcnGiYKhU58X2vc9pJusxrUp9GHoktHV6a/ZVReKk54BkFah1La
         jiUtVASJkLHS7aOu6SkgcgJz0H/MFllsakmkC6VUQbEdVwuJE9sFbwnojf2vFb52xhpl
         X/AulZJEOuFa+UBmhAOxAt2++6FBEb6W1VSayrmYs7Hz1gvwTxOlOS//xWfh9q5O+mHm
         C8Kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=8dyl5n92Y/sUneObKhhlDsuCQS6Q3FjZOl6LkwY3YEI=;
        b=dwtQYbemK7trLhspPBTv8WF968ZLjh4zHK30MBq8Rv/CTDAWdYgXCNHWrYWTKxLs+a
         xPpu0imL6e89U5+Oo4ZLfm3XjVVRR+gjk9Le1ZyAyEloDbwVaxxZ5xPzyfQpLMfjHg/Q
         JQj3xW2eRS7oT0D3bPxOjx8w7eRr8xawifl3gx9c8ACz9SZDDyEPC0v7LzdD+K5FHfFF
         RYw3tRYr75OpJg7tVoX1rLdONAwE1pqWVt4A2JixYuDzH+qjTQ9O4YR/KdMDuYCzRMFT
         s+dBq0yc4tcjlaphJ49Q58qju3iD2O6WSkqoDod3KUpGosXBbxbrG4Xg/fK1mxAbBfux
         s9AQ==
X-Gm-Message-State: APzg51BrhS06YEzfVDmygASZG9WyPEsfv6eiNQZEaFE1iGcUiMQFHvZo
        lr1xenk6B+S+rmXmzGrenfMVCNCdUKM=
X-Google-Smtp-Source: ANB0VdY6MVzowkyYBlMhTXjeBP8nQVIvr7m4OcvqDBdGniLQJclWn50CGVGCfGg6tJIOflQwTvDMnw==
X-Received: by 2002:a63:e54b:: with SMTP id z11-v6mr21437497pgj.328.1537159447295;
        Sun, 16 Sep 2018 21:44:07 -0700 (PDT)
Received: from toy.corp.qihoo.net ([104.192.108.9])
        by smtp.gmail.com with ESMTPSA id l3-v6sm16876399pff.8.2018.09.16.21.44.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 16 Sep 2018 21:44:06 -0700 (PDT)
From:   Jun Yao <yaojun8558363@gmail.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     catalin.marinas@arm.com, will.deacon@arm.com, james.morse@arm.com,
        linux-kernel@vger.kernel.org
Subject: [PATCH v5 4/6] arm64/mm: Create the final page table directly in swapper_pg_dir.
Date:   Mon, 17 Sep 2018 12:43:31 +0800
Message-Id: <20180917044333.30051-5-yaojun8558363@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180917044333.30051-1-yaojun8558363@gmail.com>
References: <20180917044333.30051-1-yaojun8558363@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As the initial page table is created in the init_pg_dir, we can set
up the final page table directly in the swapper_pg_dir. And it only
contains the top level page table, so we can reduce it to a page
size.

Signed-off-by: Jun Yao <yaojun8558363@gmail.com>
---
 arch/arm64/kernel/vmlinux.lds.S |  2 +-
 arch/arm64/mm/mmu.c             | 29 ++---------------------------
 2 files changed, 3 insertions(+), 28 deletions(-)

diff --git a/arch/arm64/kernel/vmlinux.lds.S b/arch/arm64/kernel/vmlinux.lds.S
index 612ffc0bbe11..a634def77442 100644
--- a/arch/arm64/kernel/vmlinux.lds.S
+++ b/arch/arm64/kernel/vmlinux.lds.S
@@ -237,7 +237,7 @@ SECTIONS
 	. += RESERVED_TTBR0_SIZE;
 #endif
 	swapper_pg_dir = .;
-	. += SWAPPER_DIR_SIZE;
+	. += PAGE_SIZE;
 	swapper_pg_end = .;
 
 	__pecoff_data_size = ABSOLUTE(. - __initdata_begin);
diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
index af80dca335ce..71532bcd76c1 100644
--- a/arch/arm64/mm/mmu.c
+++ b/arch/arm64/mm/mmu.c
@@ -629,35 +629,10 @@ static void __init map_kernel(pgd_t *pgdp)
  */
 void __init paging_init(void)
 {
-	phys_addr_t pgd_phys = early_pgtable_alloc();
-	pgd_t *pgdp = pgd_set_fixmap(pgd_phys);
-
-	map_kernel(pgdp);
-	map_mem(pgdp);
-
-	/*
-	 * We want to reuse the original swapper_pg_dir so we don't have to
-	 * communicate the new address to non-coherent secondaries in
-	 * secondary_entry, and so cpu_switch_mm can generate the address with
-	 * adrp+add rather than a load from some global variable.
-	 *
-	 * To do this we need to go via a temporary pgd.
-	 */
-	cpu_replace_ttbr1(__va(pgd_phys));
-	memcpy(swapper_pg_dir, pgdp, PGD_SIZE);
+	map_kernel(swapper_pg_dir);
+	map_mem(swapper_pg_dir);
 	cpu_replace_ttbr1(lm_alias(swapper_pg_dir));
 	init_mm.pgd = swapper_pg_dir;
-
-	pgd_clear_fixmap();
-	memblock_free(pgd_phys, PAGE_SIZE);
-
-	/*
-	 * We only reuse the PGD from the swapper_pg_dir, not the pud + pmd
-	 * allocated with it.
-	 */
-	memblock_free(__pa_symbol(swapper_pg_dir) + PAGE_SIZE,
-		      __pa_symbol(swapper_pg_end) - __pa_symbol(swapper_pg_dir)
-		      - PAGE_SIZE);
 }
 
 /*
-- 
2.17.1

