Return-Path: <SRS0=XTOn=JD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9043C5CFC1
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Jun 2018 22:12:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9D824208A6
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Jun 2018 22:12:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="vdqgERtc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9D824208A6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754210AbeFQWMy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 17 Jun 2018 18:12:54 -0400
Received: from mail-pg0-f66.google.com ([74.125.83.66]:45960 "EHLO
        mail-pg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751968AbeFQWMv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Jun 2018 18:12:51 -0400
Received: by mail-pg0-f66.google.com with SMTP id z1-v6so6605984pgv.12
        for <linux-kernel@vger.kernel.org>; Sun, 17 Jun 2018 15:12:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=c1ImnpFnFapnv8Ey9e2SK4D1qQiEYkvrA/d9HRmKDaA=;
        b=vdqgERtcwTKMFmzJJJMmfBEfPExCEPZhTiRmq4uV2CC80aduFarPxwuGn94+klzKh1
         ItYqhgitEIIstsQt5iLbjCCPIUJ7WDqBpn2NmKZ43BsrhKhh7gqu9XtOXSxd6uFGDgro
         /DkTRJd4TecaHRAPzaaqwTw795lb2fxkdU6vHglNifzIUk7j4/2rYyRQwW3xDRTT0aNi
         3NERxjQGj4eSUbMElWmftsQz/hUEAcykIpem59u2IsWzuXkEihXqmRyVw/ufMOE4klP9
         xe+BZ0z/m8Ng2mntrkx6B50CAqLq3I5ObV4v4fu5mPEogNgCCXvmzqP+qVQxz55+vGjv
         lQ1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=c1ImnpFnFapnv8Ey9e2SK4D1qQiEYkvrA/d9HRmKDaA=;
        b=em8drrRrDS32+Y3aXithxQUfxNg2QlnQwRsBva4Ck5Dsz6vv4bxLmgxArTtjgxOf83
         4ktG+T8QTFY0vWbawIF6of8rU558QLAhYP1KuC7pyMg8hzBm2izL/J6ADKKQl4vSM1gj
         l7oposlhE/IlWw+lNTgRHdd8HriY+ccdF5QitMVEBvCNSUXktLHsgumIdcJdc/DB8Bi4
         o344pyS5MoLe9rGWjZVZuhq+OgqOrAhIDuP4IlHrs9SmjT2DwX+WT+YB8lVKPYckiYan
         tf0CBxJBxH8C59HYnUS75onpgBeWs3ujWOzpOct5MkN+91Hu1xVRx/RS+vFNFv+tY0OG
         nBDQ==
X-Gm-Message-State: APt69E27MKQq7o5e6lNt1h++c76ex0pmD0L05u1cvcnjLkHpT0FiYktK
        m4zs8o7XSZ+4tNiWD4cK4AKm2MDVNW0=
X-Google-Smtp-Source: ADUXVKJiPgCjxGNaIWqa1cfdQfSiheIOFMMQsr3riCIvN6LbKQHF6IRGzQVY5zH1aKnW6Np8WaEWMQ==
X-Received: by 2002:a65:40c3:: with SMTP id u3-v6mr8942645pgp.356.1529273570076;
        Sun, 17 Jun 2018 15:12:50 -0700 (PDT)
Received: from localhost (g134.124-44-9.ppp.wakwak.ne.jp. [124.44.9.134])
        by smtp.gmail.com with ESMTPSA id 10-v6sm19281898pgb.40.2018.06.17.15.12.48
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 17 Jun 2018 15:12:49 -0700 (PDT)
From:   Stafford Horne <shorne@gmail.com>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Stafford Horne <shorne@gmail.com>,
        Matthew Wilcox <willy@infradead.org>,
        Jonas Bonn <jonas@southpole.se>,
        Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>,
        openrisc@lists.librecores.org
Subject: [PATCH] openrisc: Call destructor during __pte_free_tlb
Date:   Mon, 18 Jun 2018 07:12:42 +0900
Message-Id: <20180617221243.10126-1-shorne@gmail.com>
X-Mailer: git-send-email 2.17.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This fixes an issue uncovered when a recent change to add the "page
table" flag was merged.  During bootup we see many errors like the
following:

    BUG: Bad page state in process mkdir  pfn:00bae
    page:c1ff15c0 count:0 mapcount:-1024 mapping:00000000 index:0x0
    flags: 0x0()
    raw: 00000000 00000000 00000000 fffffbff 00000000 00000100 00000200 00000000
    page dumped because: nonzero mapcount
    Modules linked in:
    CPU: 0 PID: 46 Comm: mkdir Tainted: G    B             4.17.0-simple-smp-07461-g1d40a5ea01d5-dirty #993
    Call trace:
    [<(ptrval)>] show_stack+0x44/0x54
    [<(ptrval)>] dump_stack+0xb0/0xe8
    [<(ptrval)>] bad_page+0x138/0x174
    [<(ptrval)>] ? cpumask_next+0x24/0x34
    [<(ptrval)>] free_pages_check_bad+0x6c/0xd0
    [<(ptrval)>] free_pcppages_bulk+0x174/0x42c
    [<(ptrval)>] free_unref_page_commit.isra.17+0xb8/0xc8
    [<(ptrval)>] free_unref_page_list+0x10c/0x190
    [<(ptrval)>] ? set_reset_devices+0x0/0x2c
    [<(ptrval)>] release_pages+0x3a0/0x414
    [<(ptrval)>] tlb_flush_mmu_free+0x5c/0x90
    [<(ptrval)>] tlb_flush_mmu+0x90/0xa4
    [<(ptrval)>] arch_tlb_finish_mmu+0x50/0x94
    [<(ptrval)>] tlb_finish_mmu+0x30/0x64
    [<(ptrval)>] exit_mmap+0x110/0x1e0
    [<(ptrval)>] mmput+0x50/0xf0
    [<(ptrval)>] do_exit+0x274/0xa94
    [<(ptrval)>] do_group_exit+0x50/0x110
    [<(ptrval)>] __wake_up_parent+0x0/0x38
    [<(ptrval)>] _syscall_return+0x0/0x4

During the __pte_free_tlb path openrisc fails to call the page
destructor which would clear the new bits that were introduced.
To fix this we are calling the destructor.

It seem openrisc was the only architecture missing this,  all other
architectures either call the destructor like we are doing here or use
pte_free.

Fixes: 1d40a5ea01d53 ("mm: mark pages in use for page tables")
Cc: Matthew Wilcox <willy@infradead.org>
Signed-off-by: Stafford Horne <shorne@gmail.com>
---
 arch/openrisc/include/asm/pgalloc.h | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/arch/openrisc/include/asm/pgalloc.h b/arch/openrisc/include/asm/pgalloc.h
index 3e1a46615120..8999b9226512 100644
--- a/arch/openrisc/include/asm/pgalloc.h
+++ b/arch/openrisc/include/asm/pgalloc.h
@@ -98,8 +98,12 @@ static inline void pte_free(struct mm_struct *mm, struct page *pte)
 	__free_page(pte);
 }
 
+#define __pte_free_tlb(tlb, pte, addr)	\
+do {					\
+	pgtable_page_dtor(pte);		\
+	tlb_remove_page((tlb), (pte));	\
+} while (0)
 
-#define __pte_free_tlb(tlb, pte, addr) tlb_remove_page((tlb), (pte))
 #define pmd_pgtable(pmd) pmd_page(pmd)
 
 #define check_pgt_cache()          do { } while (0)
-- 
2.17.0

