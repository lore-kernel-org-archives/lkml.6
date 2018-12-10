Return-Path: <SRS0=GJN7=OT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E152C04EB8
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 15:10:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 08EFE20672
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 15:10:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gCZsw/8I"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 08EFE20672
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727873AbeLJPKI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Dec 2018 10:10:08 -0500
Received: from mail-ed1-f66.google.com ([209.85.208.66]:36345 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727109AbeLJPKI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Dec 2018 10:10:08 -0500
Received: by mail-ed1-f66.google.com with SMTP id f23so9776002edb.3
        for <linux-kernel@vger.kernel.org>; Mon, 10 Dec 2018 07:10:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:reply-to:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=VcRx/sk/JIDgc6qs0A8WB3wEc565b8bdR5XcVGijwTg=;
        b=gCZsw/8InAGPInFqf0PJGVegDnO11zBooZ09tNLmRx0DVNKk84G3Bp6DHFpqhW4jvY
         A3Yk0Q1T5N2LuvXLqaF/6qJU5VFKxeA6FUBxJDRna9wlLcmfw/bnTLBEaku3pfrEdkVy
         HAV9nuHigmKC9i6mq9d/yZnKN0f5AEs0jeQ/rFbyAIqkT1hNFezaX2uf9oCfkmnNrhSU
         rxcT2V78lRUHyPPwiDqPi12GmNIFAALUYz73i5ucwewlGgWc0M4plLm/NzyerENJuIX1
         jNXCyVICpI8nrvVVVwlNwF3G/k9iXOvFMjnSaGi3kujJzSI619XcaHVB2k9gAzHP0uEo
         9ilA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:reply-to
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=VcRx/sk/JIDgc6qs0A8WB3wEc565b8bdR5XcVGijwTg=;
        b=s9yDAAmPLOgbhWgwjTDiTffkPeF7UtOjeH2rTJk4z7Et1pYT8XloU3XJ/pSFfsYw02
         q6QLdfChQehguaKU1jHXVYNaY5xROGt58b4Fzo2jyKp6l/rT7lAn7ef2A2AQ7FuIL3s1
         yWX8KFNhbRnEUp722hxJlmvDrefjxg1+9bANKX9jDFHr0Y4jv/TCrOBRoewISiVoXP9M
         gbIUw6NkuJnK6+FCobO09v4bOsjFTZu4sj5//y3X95T2vTihmfcgkulumfNGnojT9xW1
         jiGMc+dIvIDk9poxbHl8cLAOtSTlk+VlgGr7O/FqBMUG7ffzzVZS3n33aIFGmCo8HHhQ
         ZgHA==
X-Gm-Message-State: AA+aEWaSU6AHQfN5jpWQKgVRZsR1wnYRRItMBMb0ybzZZPl5Kp8+Puts
        oEEhQYqvL25v6LBmfa76Llk=
X-Google-Smtp-Source: AFSGD/WLOm0JHd2RU7ZF/FqE6J0AV+l7wxJhLgAO8TqZB1sZXqfYuu/AYajt6XomYaCxZVP87y8vQg==
X-Received: by 2002:a50:fa0c:: with SMTP id b12mr11349611edq.138.1544454606543;
        Mon, 10 Dec 2018 07:10:06 -0800 (PST)
Received: from localhost ([185.92.221.13])
        by smtp.gmail.com with ESMTPSA id s12sm3434265edb.43.2018.12.10.07.10.05
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 10 Dec 2018 07:10:05 -0800 (PST)
Date:   Mon, 10 Dec 2018 15:10:05 +0000
From:   Wei Yang <richard.weiyang@gmail.com>
To:     Mikhail Zaslonko <zaslonko@linux.ibm.com>
Cc:     akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, mhocko@kernel.org,
        Pavel.Tatashin@microsoft.com, schwidefsky@de.ibm.com,
        heiko.carstens@de.ibm.com, gerald.schaefer@de.ibm.com
Subject: Re: [PATCH 1/1] mm, memory_hotplug: Initialize struct pages for the
 full memory section
Message-ID: <20181210151005.xukiibwbb6ohqyex@master>
Reply-To: Wei Yang <richard.weiyang@gmail.com>
References: <20181210130712.30148-1-zaslonko@linux.ibm.com>
 <20181210130712.30148-2-zaslonko@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181210130712.30148-2-zaslonko@linux.ibm.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 10, 2018 at 02:07:12PM +0100, Mikhail Zaslonko wrote:
>If memory end is not aligned with the sparse memory section boundary, the
>mapping of such a section is only partly initialized. This may lead to
>VM_BUG_ON due to uninitialized struct page access from
>is_mem_section_removable() or test_pages_in_a_zone() function triggered by
>memory_hotplug sysfs handlers:
>
> page:000003d082008000 is uninitialized and poisoned
> page dumped because: VM_BUG_ON_PAGE(PagePoisoned(p))
> Call Trace:
> ([<0000000000385b26>] test_pages_in_a_zone+0xde/0x160)
>  [<00000000008f15c4>] show_valid_zones+0x5c/0x190
>  [<00000000008cf9c4>] dev_attr_show+0x34/0x70
>  [<0000000000463ad0>] sysfs_kf_seq_show+0xc8/0x148
>  [<00000000003e4194>] seq_read+0x204/0x480
>  [<00000000003b53ea>] __vfs_read+0x32/0x178
>  [<00000000003b55b2>] vfs_read+0x82/0x138
>  [<00000000003b5be2>] ksys_read+0x5a/0xb0
>  [<0000000000b86ba0>] system_call+0xdc/0x2d8
> Last Breaking-Event-Address:
>  [<0000000000385b26>] test_pages_in_a_zone+0xde/0x160
> Kernel panic - not syncing: Fatal exception: panic_on_oops
>
>Fix the problem by initializing the last memory section of the highest zone
>in memmap_init_zone() till the very end, even if it goes beyond the zone
>end.
>
>Signed-off-by: Mikhail Zaslonko <zaslonko@linux.ibm.com>
>Reviewed-by: Gerald Schaefer <gerald.schaefer@de.ibm.com>
>Cc: <stable@vger.kernel.org>
>---
> mm/page_alloc.c | 15 +++++++++++++++
> 1 file changed, 15 insertions(+)
>
>diff --git a/mm/page_alloc.c b/mm/page_alloc.c
>index 2ec9cc407216..41ef5508e5f1 100644
>--- a/mm/page_alloc.c
>+++ b/mm/page_alloc.c
>@@ -5542,6 +5542,21 @@ void __meminit memmap_init_zone(unsigned long size, int nid, unsigned long zone,
> 			cond_resched();
> 		}
> 	}
>+#ifdef CONFIG_SPARSEMEM
>+	/*
>+	 * If there is no zone spanning the rest of the section
>+	 * then we should at least initialize those pages. Otherwise we
>+	 * could blow up on a poisoned page in some paths which depend
>+	 * on full sections being initialized (e.g. memory hotplug).
>+	 */
>+	if (end_pfn == max_pfn) {
>+		while (end_pfn % PAGES_PER_SECTION) {
>+			__init_single_page(pfn_to_page(end_pfn), end_pfn, zone,
>+					   nid);
>+			end_pfn++;
>+		}
>+	}
>+#endif

If my understanding is correct, end_pfn is not a valid range.

memmap_init_zone() initialize the range [start_pfn, start_pfn + size). I
am afraid this will break the syntax. 

And max_pfn is also not a valid one. For example, on x86,
update_end_of_memory_vars() will update max_pfn, which is calculated by:

    end_pfn = PFN_UP(start + size);

BTW, as you mentioned this apply to hotplug case. And then why this couldn't
happen during boot up? What differ these two cases?

> }
> 
> #ifdef CONFIG_ZONE_DEVICE
>-- 
>2.16.4

-- 
Wei Yang
Help you, Help me
