Return-Path: <SRS0=e/xi=M4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBA09C04EBD
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 13:14:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 999FE2089E
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 13:14:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e11cs6jE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 999FE2089E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727233AbeJPVEn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Oct 2018 17:04:43 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:43373 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727069AbeJPVEm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Oct 2018 17:04:42 -0400
Received: by mail-pl1-f196.google.com with SMTP id 30-v6so11003451plb.10;
        Tue, 16 Oct 2018 06:14:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Uwz2MhBiZj2/RLBte8wwxNWfHSbBq1uBQUZRjpspgrw=;
        b=e11cs6jEoeMmwoBTYdNdNJksH7qI2wwNhzL8dHOfMYBv61ZXmE7ZyV/m0HuwprSE8P
         LFyAsDmOM0lbAcgAwqRMqM/kSCDNmRysuTjQBcOTsE+FYIuV6YatjeYM9khiyj/R3/AY
         QCOLgFdpTNNuFTtQ/BUGeOh8mtqwWkMaj1cDEQfLz/cYm4GL6lZaJ74Hjstyi58GeYBt
         wOKkZeW4oBUFptEPdrDwkxiVepZCC+JvI0CR0+o9yZckDgcyrP91npD4G3d5GNYQsbQN
         Zhnb8I+DxMlfZAf2J/KOOMUmZ9HMuxpolqtPk2C9td0SKgrYsShSDKNx8nkIWCHWN94Z
         0Q0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Uwz2MhBiZj2/RLBte8wwxNWfHSbBq1uBQUZRjpspgrw=;
        b=ANIfmvsu3SVnZx/dMGgMDBqsBwnQJPUcCPcZB4NNgdYwOKkTkJ42g74t+XdD6CdWhu
         U9fr5i7MQl9XQAzHbQEAD31+Za6PmKeLCZfmGxeUuRU9i+V1nm1krXeMZJVk4zFyDO97
         sHEf5XyS/Bkh3f3lWwRtjRCptyfdfKXCaGYsNvhphmhuXgGWyIH1UAezBmjrwSfab55Q
         W37kVUtIM7CPsjNZK6hjlCtCy446B+QkA3AjDM+CYCCum17AEMtBub76Ix11cy91rfgq
         NNC6xJhPh0I3CGcp1Un06cWX0dTGAa8etHiRLE8lcA5JD1MliYCFAdPlCbhzrUPCv2vS
         yukg==
X-Gm-Message-State: ABuFfohCs71I3tO6kRWtUZzH09ke2a1/afE6nnhXmgli2lOC//qyVAGK
        v03DS50hhFIMqwEwdbwi69w=
X-Google-Smtp-Source: ACcGV62O4GEomn4Rji7i3zI4ZPz6+o/83UivhZoWG06/NphsLTdj3gWE9y8+Ptx4lChGWFwrT5esfA==
X-Received: by 2002:a17:902:34a:: with SMTP id 68-v6mr21440986pld.39.1539695656502;
        Tue, 16 Oct 2018 06:14:16 -0700 (PDT)
Received: from roar.local0.net ([60.240.252.156])
        by smtp.gmail.com with ESMTPSA id j62-v6sm16043423pgd.40.2018.10.16.06.14.12
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 16 Oct 2018 06:14:16 -0700 (PDT)
From:   Nicholas Piggin <npiggin@gmail.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Nicholas Piggin <npiggin@gmail.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-mm <linux-mm@kvack.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        ppc-dev <linuxppc-dev@lists.ozlabs.org>,
        Ley Foon Tan <ley.foon.tan@intel.com>
Subject: [PATCH v2 4/5] mm/cow: optimise pte dirty bit handling in fork
Date:   Tue, 16 Oct 2018 23:13:42 +1000
Message-Id: <20181016131343.20556-5-npiggin@gmail.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20181016131343.20556-1-npiggin@gmail.com>
References: <20181016131343.20556-1-npiggin@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

fork clears dirty/accessed bits from new ptes in the child. This logic
has existed since mapped page reclaim was done by scanning ptes when
it may have been quite important. Today with physical based pte
scanning, there is less reason to clear these bits, so this patch
avoids clearing the dirty bit in the child.

Dirty bits are all tested and cleared together, and any dirty bit is
the same as many dirty bits, so from a correctness and writeback
bandwidth point-of-view it does not matter if the child gets a dirty
bit.

Dirty ptes are more costly to unmap because they require flushing
under the page table lock, but it is pretty rare to have a shared
dirty mapping that is copied on fork, so just simplify the code and
avoid this dirty clearing logic.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 mm/memory.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/mm/memory.c b/mm/memory.c
index 0387ee1e3582..9e314339a0bd 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -1028,11 +1028,12 @@ copy_one_pte(struct mm_struct *dst_mm, struct mm_struct *src_mm,
 	}
 
 	/*
-	 * If it's a shared mapping, mark it clean in
-	 * the child
+	 * Child inherits dirty and young bits from parent. There is no
+	 * point clearing them because any cleaning or aging has to walk
+	 * all ptes anyway, and it will notice the bits set in the parent.
+	 * Leaving them set avoids stalls and even page faults on CPUs that
+	 * handle these bits in software.
 	 */
-	if (vm_flags & VM_SHARED)
-		pte = pte_mkclean(pte);
 
 	page = vm_normal_page(vma, addr, pte);
 	if (page) {
-- 
2.18.0

