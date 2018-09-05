Return-Path: <SRS0=wmYC=LT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DAAC4C433F5
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 21:13:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 932D82077C
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 21:13:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PCmXW5Zb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 932D82077C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727763AbeIFBpf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Sep 2018 21:45:35 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:34291 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727721AbeIFBpf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Sep 2018 21:45:35 -0400
Received: by mail-pf1-f195.google.com with SMTP id k19-v6so4118139pfi.1
        for <linux-kernel@vger.kernel.org>; Wed, 05 Sep 2018 14:13:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:from:to:cc:date:message-id:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=qtZLT2M6XG6IyUs6kQVBDxV5Cznym29hpwromAFKuTs=;
        b=PCmXW5ZbDuMnh4HmI+ZPOyS2bhYg+gRI8VlKuZl/2Ag5x5Sj7gjwFpYj2uhDzg0og8
         9GIER6wxBvz67jxWM+1aRDAYF7ETfQ9TpiXfL5XGVaTg3nxIVACgIqQp02uobov1blpx
         MoH2gAcvcLEm1ORyNttzMCMBHZ4OPz0F47CIdPqRQWYWAvK7UVzgbowOoimwNA3oxTQJ
         KxtPPJp45aJw0OU5qKmi3NyRLg1EI8G4jFLxT4YkWBlyveD30QkWuU9uyj7Am1h6wGt2
         NHwZUYOIiY6JNp7Euzyj0C4cuTJ73W28E9X+JC9CZHcq+QuBaQwZuropGo5OKQaGHIPu
         i+cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:date:message-id:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=qtZLT2M6XG6IyUs6kQVBDxV5Cznym29hpwromAFKuTs=;
        b=lzgigz5fp/97IghXjiW3qrF39jX//tOEdqF5RJ1OOJkWrU8h9WbI9aZSGDpx4OOY35
         Xif19/BNZedprokcbtI9foh8czEMG+F4zGTPaySFqAvtF4hqlKrYGe5CcaMzcl24atNN
         Z2UXeiGEAB62CR8BeEJnyAHzyHiImsOwvY3uLM4VJe8tyc0UZYF2JseRfzmzTzCe6Qu4
         ovRT6HltzKC9fDxFUn8E5Lr83nhR8m39kqCDTEozavUIv0kqqVMrKdEvZGisaP1peFmU
         LTs3JVmrjNK3lD/44ZMbHDv10VVRb0lCEjpmdh3VBwr26UMJeUTO9zUu2/mX97iM+o5H
         JHOQ==
X-Gm-Message-State: APzg51B1QEE59Nnkd1iPjrCTx4yuGLgopqeCMTAooF8RC12gvZn0cBKM
        ItceIrFZVuVn20JTThTvBfU=
X-Google-Smtp-Source: ANB0VdYyQruNYAtz2t+A0n+/XIhhDjINyfL74FX8J0goc8LPTaYFYfSAJnOxJDq+ED9a996cwwsbOQ==
X-Received: by 2002:a65:62d8:: with SMTP id m24-v6mr23864849pgv.307.1536182015456;
        Wed, 05 Sep 2018 14:13:35 -0700 (PDT)
Received: from localhost.localdomain (static-50-53-21-37.bvtn.or.frontiernet.net. [50.53.21.37])
        by smtp.gmail.com with ESMTPSA id q25-v6sm3805544pfh.113.2018.09.05.14.13.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 05 Sep 2018 14:13:34 -0700 (PDT)
Subject: [PATCH v2 2/2] mm: Create non-atomic version of SetPageReserved for
 init use
From:   Alexander Duyck <alexander.duyck@gmail.com>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc:     alexander.h.duyck@intel.com, pavel.tatashin@microsoft.com,
        mhocko@suse.com, dave.hansen@intel.com, akpm@linux-foundation.org,
        mingo@kernel.org, kirill.shutemov@linux.intel.com
Date:   Wed, 05 Sep 2018 14:13:34 -0700
Message-ID: <20180905211334.3286.84435.stgit@localhost.localdomain>
In-Reply-To: <20180905211041.3286.19083.stgit@localhost.localdomain>
References: <20180905211041.3286.19083.stgit@localhost.localdomain>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alexander Duyck <alexander.h.duyck@intel.com>

It doesn't make much sense to use the atomic SetPageReserved at init time
when we are using memset to clear the memory and manipulating the page
flags via simple "&=" and "|=" operations in __init_single_page.

This patch adds a non-atomic version __SetPageReserved that can be used
during page init and shows about a 10% improvement in initialization times
on the systems I have available for testing.

I tried adding a bit of documentation based on commit <f1dd2cd13c4> ("mm,
memory_hotplug: do not associate hotadded memory to zones until online").

Ideally the reserved flag should be set earlier since there is a brief
window where the page is initialization via __init_single_page and we have
not set the PG_Reserved flag. I'm leaving that for a future patch set as
that will require a more significant refactor.

Acked-by: Michal Hocko <mhocko@suse.com>
Signed-off-by: Alexander Duyck <alexander.h.duyck@intel.com>
---
 include/linux/page-flags.h |    1 +
 mm/page_alloc.c            |   13 +++++++++++--
 2 files changed, 12 insertions(+), 2 deletions(-)

diff --git a/include/linux/page-flags.h b/include/linux/page-flags.h
index 0e95ca63375a..daee3ea2d1ed 100644
--- a/include/linux/page-flags.h
+++ b/include/linux/page-flags.h
@@ -300,6 +300,7 @@ static inline void page_init_poison(struct page *page, size_t size)
 
 PAGEFLAG(Reserved, reserved, PF_NO_COMPOUND)
 	__CLEARPAGEFLAG(Reserved, reserved, PF_NO_COMPOUND)
+	__SETPAGEFLAG(Reserved, reserved, PF_NO_COMPOUND)
 PAGEFLAG(SwapBacked, swapbacked, PF_NO_TAIL)
 	__CLEARPAGEFLAG(SwapBacked, swapbacked, PF_NO_TAIL)
 	__SETPAGEFLAG(SwapBacked, swapbacked, PF_NO_TAIL)
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 05e983f42316..f2602021032f 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -1231,7 +1231,8 @@ void __meminit reserve_bootmem_region(phys_addr_t start, phys_addr_t end)
 			/* Avoid false-positive PageTail() */
 			INIT_LIST_HEAD(&page->lru);
 
-			SetPageReserved(page);
+			/* no need for atomic set_bit at init time */
+			__SetPageReserved(page);
 		}
 	}
 }
@@ -5517,8 +5518,16 @@ void __meminit memmap_init_zone(unsigned long size, int nid, unsigned long zone,
 not_early:
 		page = pfn_to_page(pfn);
 		__init_single_page(page, pfn, zone, nid);
+
+		/*
+		 * Mark page reserved as it will need to wait for onlining
+		 * phase for it to be fully associated with a zone.
+		 *
+		 * We can use the non-atomic __set_bit operation for setting
+		 * the flag as we are still initializing the pages.
+		 */
 		if (context == MEMMAP_HOTPLUG)
-			SetPageReserved(page);
+			__SetPageReserved(page);
 
 		/*
 		 * Mark the block movable so that blocks are reserved for

