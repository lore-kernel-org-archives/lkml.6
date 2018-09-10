Return-Path: <SRS0=FvrY=LY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77076C43143
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 23:43:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 270B020855
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 23:43:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M5jUdHnp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 270B020855
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726510AbeIKEkP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Sep 2018 00:40:15 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:34826 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725945AbeIKEkO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Sep 2018 00:40:14 -0400
Received: by mail-pl1-f193.google.com with SMTP id g2-v6so9493422plo.2
        for <linux-kernel@vger.kernel.org>; Mon, 10 Sep 2018 16:43:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:from:to:cc:date:message-id:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=lhFr3T5RF4ix/HN80RMUA8xymXKjrz1rlCqR/lwO+vo=;
        b=M5jUdHnplNrgx3jtLSwG+/FiSgIS5lu66K/26ReK6zbipcdAmf2HbSKpXwL++aiju+
         BBPLh+5tfixgC9jksDYNDyOzwlV9qKrTrb3wq1Avw2EtcbsmSbb5ib0kltUcSCuZkk1L
         tUJM4vwwtCW1eWbbOxG5/eM08A/nR81VfKIwm1GYNN9jiWxeqdtUkTee2LITfK3kV+oX
         bQyuH29EMKTNsd9GC774DuOq9xIPkqxxgsQSh26nIvJHbXrSG0u2q385g0pcmvaJKEfQ
         9nFUXSV5uLTUIsICYY0eagbcIS8YZ9EPAqXl4PMy2TeTZ2GAVKo9jxcEUWk3UUtKBzn5
         PotA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:date:message-id:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=lhFr3T5RF4ix/HN80RMUA8xymXKjrz1rlCqR/lwO+vo=;
        b=tphg+oZirt4kFHLgVXD4+ET0DAMBwf6MUnDhAG2OBPhQQp6CH90qQ73i7UpL/9v8fB
         0XgGs3UCuGjrU7csRRkyKe6YYpHkEaja1tpFMfG2t6Vded6DJ195paFFdxuwhfn9DPvn
         P4+cKH2wluQBHDIBsLUSduzW8tvhPEBd8PRDGuS25PIXl2iOfTwgLvNehciSshM2UYiA
         W+k16scE3UnaRZOUxA7Iko2pjYLZKI3WQlmmlDIiuY8LhH12eOOuK4aFehpKaqwBqEva
         b1h8d/v+y5dq/wYFxrpmXbjZzpUmxLzsYs8xnrbhdlZpJB6d1JzLaEa/s9+9wVcMAHSw
         hrmA==
X-Gm-Message-State: APzg51DOBT/3c1cAmPFPeHf57jm4PlnWBuHh7YYG5XvFuODt4Xhk5At7
        aVZalB44V+hCon7sACdHmOg=
X-Google-Smtp-Source: ANB0VdZ9nofLh3IK/Vq5oODEvu42HmX3XMswWPrs5u5Htg1ryZEmW2HxTof/tUVek3Nw+LtN1MGgcw==
X-Received: by 2002:a17:902:344:: with SMTP id 62-v6mr24533133pld.164.1536623029274;
        Mon, 10 Sep 2018 16:43:49 -0700 (PDT)
Received: from localhost.localdomain (static-50-53-21-37.bvtn.or.frontiernet.net. [50.53.21.37])
        by smtp.gmail.com with ESMTPSA id v20-v6sm33973962pfk.12.2018.09.10.16.43.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 10 Sep 2018 16:43:48 -0700 (PDT)
Subject: [PATCH 2/4] mm: Create non-atomic version of SetPageReserved for
 init use
From:   Alexander Duyck <alexander.duyck@gmail.com>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        linux-nvdimm@lists.01.org
Cc:     pavel.tatashin@microsoft.com, mhocko@suse.com,
        dave.jiang@intel.com, mingo@kernel.org, dave.hansen@intel.com,
        jglisse@redhat.com, akpm@linux-foundation.org, logang@deltatee.com,
        dan.j.williams@intel.com, kirill.shutemov@linux.intel.com
Date:   Mon, 10 Sep 2018 16:43:48 -0700
Message-ID: <20180910234348.4068.92164.stgit@localhost.localdomain>
In-Reply-To: <20180910232615.4068.29155.stgit@localhost.localdomain>
References: <20180910232615.4068.29155.stgit@localhost.localdomain>
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
on the systems I have available for testing. On those systems I saw
initialization times drop from around 35 seconds to around 32 seconds to
initialize a 3TB block of persistent memory.

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
 mm/page_alloc.c            |   17 +++++++++++++++--
 2 files changed, 16 insertions(+), 2 deletions(-)

diff --git a/include/linux/page-flags.h b/include/linux/page-flags.h
index d00216cf00f8..1b1f8e0378ae 100644
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
index 89d2a2ab3fe6..a9b095a72fd9 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -1231,7 +1231,12 @@ void __meminit reserve_bootmem_region(phys_addr_t start, phys_addr_t end)
 			/* Avoid false-positive PageTail() */
 			INIT_LIST_HEAD(&page->lru);
 
-			SetPageReserved(page);
+			/*
+			 * no need for atomic set_bit because the struct
+			 * page is not visible yet so nobody should
+			 * access it yet.
+			 */
+			__SetPageReserved(page);
 		}
 	}
 }
@@ -5517,8 +5522,16 @@ void __meminit memmap_init_zone(unsigned long size, int nid, unsigned long zone,
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

