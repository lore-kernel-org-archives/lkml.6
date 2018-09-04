Return-Path: <SRS0=7C3F=LS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3710C43334
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 18:33:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8FB02206BA
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 18:33:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="vAymjcbr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8FB02206BA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727972AbeIDXAG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Sep 2018 19:00:06 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:42734 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726507AbeIDXAG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Sep 2018 19:00:06 -0400
Received: by mail-pf1-f194.google.com with SMTP id l9-v6so2104673pff.9
        for <linux-kernel@vger.kernel.org>; Tue, 04 Sep 2018 11:33:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:from:to:cc:date:message-id:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=MdQ8PvK3fEzAtZADK3vfNmYziizL51ukKvOGILhXgkQ=;
        b=vAymjcbry74LyDWWHChMOMli0JaF9Rn1u9+l/ZJehXD6D1Ov2IWrReo5sVaZSuMBHx
         uRql+te+bsLLUaVXxUaUT45NJ3XZvFwmEhHHVGRyVTVdh8yrJhzP53urc2lHn1CrYeUd
         u5VR4nXMOycYVJM4T4oXYW9N2MyZltBXQrShL8oqAp0G2jR0rJn0vZxkFziLQpjxlSLF
         MaJBw0jbGi4CMUv8DNpAWt+k/9UuQHYyFFdXBYQKLLSBVtEdAW97Z8GxdR/SB0YRhQU8
         HxTPetcm2cQ4HB7iLcXPmyP1IfiaDHd8BfV34mbRp6YYlAXIYVSOjeu+1XB9ETZJWwwN
         d/wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:date:message-id:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=MdQ8PvK3fEzAtZADK3vfNmYziizL51ukKvOGILhXgkQ=;
        b=PahXitEAfTFD8B2fR+usAwJLal3Zo+Hvvv6CmCMEqVGREq7rxv7as3Mqin0AQp1muj
         KrKJNrKklisTKjmyLBlkW2BGWdH1Lgn55egcayZgEh3MpdodA7YJ/E03PjLdzgmMwkw3
         G0ibkxOkHLd7WjMHDaFHmt2LudFg41iX8l9OhDQ3ldLBACUN9AwYOOwInCD3nKaBh/Zi
         y5Y8qgRuj22Qwji2wVFedBX7Dt2TOlZh/tinJvB24/RL8I0khF00QM1yF+0a9tSWnUAE
         d1WslST5xjCbF2mWzCOHGvMdk55yinMvAmEJNEtjEuqTY5oPgjs2XaMSgz4dcyqj3Ybm
         +cFQ==
X-Gm-Message-State: APzg51BzLqb6yRogpZAzgqy4qjTys3HF8lMCR9+eQkKJE2OtNrcHxLtt
        oysDDFHhYnVODB6rl3wb1Qo=
X-Google-Smtp-Source: ANB0Vdb3Q48obLzoVJB5Ry2gw1LRc+dCnMA7DUTg3dsOdugcCA0UW9ef986wZqHTXpDLKdMb0XpMMQ==
X-Received: by 2002:a62:9349:: with SMTP id b70-v6mr36589325pfe.193.1536086026730;
        Tue, 04 Sep 2018 11:33:46 -0700 (PDT)
Received: from localhost.localdomain (static-50-53-21-37.bvtn.or.frontiernet.net. [50.53.21.37])
        by smtp.gmail.com with ESMTPSA id n83-v6sm38725497pfk.19.2018.09.04.11.33.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 04 Sep 2018 11:33:46 -0700 (PDT)
Subject: [PATCH 2/2] mm: Create non-atomic version of SetPageReserved for
 init use
From:   Alexander Duyck <alexander.duyck@gmail.com>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc:     alexander.h.duyck@intel.com, pavel.tatashin@microsoft.com,
        mhocko@suse.com, akpm@linux-foundation.org, mingo@kernel.org,
        kirill.shutemov@linux.intel.com
Date:   Tue, 04 Sep 2018 11:33:45 -0700
Message-ID: <20180904183345.4416.76515.stgit@localhost.localdomain>
In-Reply-To: <20180904181550.4416.50701.stgit@localhost.localdomain>
References: <20180904181550.4416.50701.stgit@localhost.localdomain>
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

Signed-off-by: Alexander Duyck <alexander.h.duyck@intel.com>
---
 include/linux/page-flags.h |    1 +
 mm/page_alloc.c            |    4 ++--
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/include/linux/page-flags.h b/include/linux/page-flags.h
index 74bee8cecf4c..57ec3fef7e9f 100644
--- a/include/linux/page-flags.h
+++ b/include/linux/page-flags.h
@@ -292,6 +292,7 @@ static inline int PagePoisoned(const struct page *page)
 
 PAGEFLAG(Reserved, reserved, PF_NO_COMPOUND)
 	__CLEARPAGEFLAG(Reserved, reserved, PF_NO_COMPOUND)
+	__SETPAGEFLAG(Reserved, reserved, PF_NO_COMPOUND)
 PAGEFLAG(SwapBacked, swapbacked, PF_NO_TAIL)
 	__CLEARPAGEFLAG(SwapBacked, swapbacked, PF_NO_TAIL)
 	__SETPAGEFLAG(SwapBacked, swapbacked, PF_NO_TAIL)
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 05e983f42316..9c7d6e971630 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -1231,7 +1231,7 @@ void __meminit reserve_bootmem_region(phys_addr_t start, phys_addr_t end)
 			/* Avoid false-positive PageTail() */
 			INIT_LIST_HEAD(&page->lru);
 
-			SetPageReserved(page);
+			__SetPageReserved(page);
 		}
 	}
 }
@@ -5518,7 +5518,7 @@ void __meminit memmap_init_zone(unsigned long size, int nid, unsigned long zone,
 		page = pfn_to_page(pfn);
 		__init_single_page(page, pfn, zone, nid);
 		if (context == MEMMAP_HOTPLUG)
-			SetPageReserved(page);
+			__SetPageReserved(page);
 
 		/*
 		 * Mark the block movable so that blocks are reserved for

