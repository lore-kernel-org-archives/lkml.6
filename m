Return-Path: <SRS0=e/xi=M4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 966ECC04EBD
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 13:14:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5C1A22089E
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 13:14:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Nm0YzlJB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5C1A22089E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727152AbeJPVE1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Oct 2018 17:04:27 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:32839 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726760AbeJPVE1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Oct 2018 17:04:27 -0400
Received: by mail-pg1-f196.google.com with SMTP id y18-v6so10859454pge.0;
        Tue, 16 Oct 2018 06:14:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=og3nps762l1wehgPrVvLZ4tOt6tgHDhsP/lk8/fPWl8=;
        b=Nm0YzlJBr/tFpHAsamNBQRtcflUZ1a3Fhs7jRJoXnpFPig4gbEgKXSD8GJg5pTuCzZ
         flZP8osFYXA9rcYPLY1PyxKzJemBVuQjRz30z6FwFB4TaoUDz2o5xuG/CMsPKZ2UFyqs
         RZ+GE2BV0OhCu0HksSYWPZDL+bdF8YLGRJ14FGakPYH/sq2hk0gVDXssBQ1yLJUjEr7Q
         Xs9PwkS8+UAIHo28AreMJSU7LdlhogWZ2UT0D0x7OwKMjaCFxzh/mt7sv551VBgwuR39
         L/QfwPOstPLfmSkiEpLRxyhfsrZnq5zTvdQQsfeW8zv5Cuo1DGQSTzvpgO2MSayvrNPU
         O72Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=og3nps762l1wehgPrVvLZ4tOt6tgHDhsP/lk8/fPWl8=;
        b=VwYGh3g2ldZjyxyXFSoFo5W7o8+3uiM5JnMy2/ZwOH10mdyj4hzLXPGxALnshPCKhB
         ro4+vKNTWrIke+lsiGOjIk1mrR+rjwDtVFaCOedfCLTbof4A8mmetpIUak+V35ZLixXq
         wfv9qTysstJI3AaeZM+Ce0gitYpFOSnEnGApGxUNcTLGJU6ALtRtsFeAg6gYx9cMMaxC
         qltI7ijb8uUxx/ovblTOZos9g7caIoa/T73B6tKfhswsqTE3C7XVzvIfOSpcZCXtRJqk
         5qCh3a6ydS0+/PnFIJcPf0rU9AUIjjXXhKVk78WEgnP6D459x/YuBS9jnYxB1dzYGhcE
         bORw==
X-Gm-Message-State: ABuFfohCGxo1hSOMONRzUnReVm6eEfC4ZZTQK0XzNtkBi5pP1Etj3/3H
        4UgQeiXAmaENinaYIH//vuE=
X-Google-Smtp-Source: ACcGV633qW2OBNPwm3Of34MQ0PiCfw8SZWKbv1d8VPnZh7InlVEXQra/DC+Bn4ZaPxLg1AladyddzA==
X-Received: by 2002:a63:4f20:: with SMTP id d32-v6mr18957422pgb.231.1539695640808;
        Tue, 16 Oct 2018 06:14:00 -0700 (PDT)
Received: from roar.local0.net ([60.240.252.156])
        by smtp.gmail.com with ESMTPSA id j62-v6sm16043423pgd.40.2018.10.16.06.13.56
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 16 Oct 2018 06:14:00 -0700 (PDT)
From:   Nicholas Piggin <npiggin@gmail.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Nicholas Piggin <npiggin@gmail.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-mm <linux-mm@kvack.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        ppc-dev <linuxppc-dev@lists.ozlabs.org>,
        Ley Foon Tan <ley.foon.tan@intel.com>
Subject: [PATCH v2 1/5] nios2: update_mmu_cache clear the old entry from the TLB
Date:   Tue, 16 Oct 2018 23:13:39 +1000
Message-Id: <20181016131343.20556-2-npiggin@gmail.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20181016131343.20556-1-npiggin@gmail.com>
References: <20181016131343.20556-1-npiggin@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fault paths like do_read_fault will install a Linux pte with the young
bit clear. The CPU will fault again because the TLB has not been
updated, this time a valid pte exists so handle_pte_fault will just
set the young bit with ptep_set_access_flags, which flushes the TLB.

The TLB is flushed so the next attempt will go to the fast TLB handler
which loads the TLB with the new Linux pte. The access then proceeds.

This design is fragile to depend on the young bit being clear after
the initial Linux fault. A proposed core mm change to immediately set
the young bit upon such a fault, results in ptep_set_access_flags not
flushing the TLB because it finds no change to the pte. The spurious
fault fix path only flushes the TLB if the access was a store. If it
was a load, then this results in an infinite loop of page faults.

This change adds a TLB flush in update_mmu_cache, which removes that
TLB entry upon the first fault. This will cause the fast TLB handler
to load the new pte and avoid the Linux page fault entirely.

Reviewed-by: Ley Foon Tan <ley.foon.tan@intel.com>
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 arch/nios2/mm/cacheflush.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/nios2/mm/cacheflush.c b/arch/nios2/mm/cacheflush.c
index 506f6e1c86d5..d58e7e80dc0d 100644
--- a/arch/nios2/mm/cacheflush.c
+++ b/arch/nios2/mm/cacheflush.c
@@ -204,6 +204,8 @@ void update_mmu_cache(struct vm_area_struct *vma,
 	struct page *page;
 	struct address_space *mapping;
 
+	flush_tlb_page(vma, address);
+
 	if (!pfn_valid(pfn))
 		return;
 
-- 
2.18.0

