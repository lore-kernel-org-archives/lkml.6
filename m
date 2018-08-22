Return-Path: <SRS0=FObM=LF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4940C4321D
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Aug 2018 09:54:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8E80C20C0D
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Aug 2018 09:54:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WowV7DWP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8E80C20C0D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728827AbeHVNTD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Aug 2018 09:19:03 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:41957 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728505AbeHVNTC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Aug 2018 09:19:02 -0400
Received: by mail-pf1-f193.google.com with SMTP id 79-v6so728257pfi.8
        for <linux-kernel@vger.kernel.org>; Wed, 22 Aug 2018 02:54:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=N7S57ufStfshOoFitiDFv5zGzXw10KZSWqqdYuKvCmA=;
        b=WowV7DWPVhT6W9nRebSDyZDB0o30XPTrZ4mb7EO+jYoN7ULDZaCE9e9kjAqBZ+hqdU
         1mqfxWVAhYdojgPpIhALurlrSYbnQ8avm+nCdtCtXLja6sHnZi+qYnc9jHs1qkRsTPB3
         NkqFWXz8kkVtEAZktP1614sLMM6WWhkqZfw2K4Dzpb8ccVO69fDCnpUCQR5vzeXvx/LB
         a0xi/olEsFiF72qQlshFgylpKHY1ZgkHyFnrJpp2A5ICJ7aw+xeyYRA6l7S2+yC8PJis
         A3vkPL+k46vvlBpXMkW+nuKnK69PzTaiH5R7LjCxJ7ex+AwNVXeXHmWHDfuhLv7lsDjr
         xrCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=N7S57ufStfshOoFitiDFv5zGzXw10KZSWqqdYuKvCmA=;
        b=k0phizRAXnnhwMbfMEWpeNTtarWqbN/vzNE2xloa5HbUkOBiyMES9PbrRC7FqBI6i7
         T+bkVbNIJzoD4rtqLE4f4ZvKfv5d3BC32HhYrPVfjhNdLm73Ts6Qht2H1mYctF50TVcn
         sdk3RJEYn2ABg3mW3YhRsoytUwC3t4YEiN77WiIJcYBDsCXFQ4rpK7Og8NjKpVQk/bNV
         tZCBvYcKPSUVBRExRiWiLahBLsFKHEriUbpTIN5Afvi42v7vdkeyuH+bjFfkA3Zt29ae
         kVODSj2QHb2WWqMSzH1ukWGZqRsAeOjU9Ys+ybP1fo5+m9dGlELVJaQ6JSTR8RfvYprT
         +s5Q==
X-Gm-Message-State: AOUpUlE2tpRboK37fnp1EtItRB74NmLbKN0fCw4KwCv9Le9jocfAzhT3
        VNaqKXiOvXneOqkRP89cVQc=
X-Google-Smtp-Source: AA+uWPyDWx5vnDMtKy9qFuIYZQ6zqT7jNayg+M6+AF8tnb0HoKKpWROfiAvvG4kVmRlLdAoLsWZzCA==
X-Received: by 2002:a63:ac54:: with SMTP id z20-v6mr15679995pgn.74.1534931691587;
        Wed, 22 Aug 2018 02:54:51 -0700 (PDT)
Received: from toy.corp.qihoo.net ([104.192.108.9])
        by smtp.gmail.com with ESMTPSA id z20-v6sm3126105pfd.99.2018.08.22.02.54.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 22 Aug 2018 02:54:51 -0700 (PDT)
From:   Jun Yao <yaojun8558363@gmail.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     catalin.marinas@arm.com, will.deacon@arm.com, james.morse@arm.com,
        linux-kernel@vger.kernel.org
Subject: [RESEND PATCH v4 4/6] arm64/mm: Create the final page table directly in swapper_pg_dir.
Date:   Wed, 22 Aug 2018 17:54:30 +0800
Message-Id: <20180822095432.12125-5-yaojun8558363@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180822095432.12125-1-yaojun8558363@gmail.com>
References: <20180822095432.12125-1-yaojun8558363@gmail.com>
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
index 61d7cee3eaa6..2446911f4262 100644
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
index f7e544f6f3eb..b7f9afb628ac 100644
--- a/arch/arm64/mm/mmu.c
+++ b/arch/arm64/mm/mmu.c
@@ -642,35 +642,10 @@ void __init set_init_mm_pgd(pgd_t *pgd)
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
 	set_init_mm_pgd(swapper_pg_dir);
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

