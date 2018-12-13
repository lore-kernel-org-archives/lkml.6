Return-Path: <SRS0=yjy/=OW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44B50C65BAE
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 03:46:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E01152075B
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 03:46:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="brwX1yRS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E01152075B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726720AbeLMDqS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Dec 2018 22:46:18 -0500
Received: from mail-ed1-f68.google.com ([209.85.208.68]:41190 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726298AbeLMDqS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Dec 2018 22:46:18 -0500
Received: by mail-ed1-f68.google.com with SMTP id z28so828137edi.8
        for <linux-kernel@vger.kernel.org>; Wed, 12 Dec 2018 19:46:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:reply-to:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=W2Op4q2i6IeFtZKnnfZX1g7DkK5MbUhuuO4q/S70Hks=;
        b=brwX1yRSmSBELcW95N7/esKUFzJ8W68yaTeAOxk4tg1PE807xm9G+Rdu4mhLRoDm/F
         U02bG1U94Md8VUDUHWSLXaOIV54oArCrfsNzhHonxPfHb34gFa96fJWbJlXi5VnpKrMo
         bfP0yReCYAIqRRmKXrwqHu5qyaVknqsCejiGcqDvT6uS7ax1F6G1hhbEjXSVaRII1rF4
         0EkvFoRU4Ryr/Y6LNWXXHjjx3Hnz1M07aIJl98a6UwZe/DpmeYknxo03ootk8YLdo3YV
         /9RYYouPP6F2VhFMWPcEUZvUVku9kXD8Gl7jLxqB9ZzoICgk8Im9u6uqrcCpBIJEoOX+
         RJvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:reply-to
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=W2Op4q2i6IeFtZKnnfZX1g7DkK5MbUhuuO4q/S70Hks=;
        b=E9RUeZvUvJqgu82ysG9rh0ew6jzuFJbozXIwa3JJ5Oh8ufVNTcQl2S3EYElCGV50Ed
         Fb9afW0gmSHXzJviNJ3mPxvI8kL4+OALZrvGCnkmuuVBvUN52Ohz6iqPO1jBIQoLBLnj
         4p2cx5PznA3UN2PszVd1ccPXXFCdfdRuXb7rIY2yeuMUiaO+w83uELg4Do9FlGwGxQsi
         yAwPl85/9L1VAa1fOoRKdwwotywnwx48Bw+rHShN3x3IpaabK61iXAJmBLVgPq/ciylb
         ePSaLkQDXcj7QL0LHZqcN52+81OYeXQfs9xCjyIzvQCfwn/0EygYQi2WLuNq5L0+b8eK
         skIg==
X-Gm-Message-State: AA+aEWaISfPd5+5lOx8A4kthzssoVh7ZThbK0RwsqtHPLZLe+hB9O9Co
        lfMJpQfvPfuHxHcPpsum9v7NrK4N
X-Google-Smtp-Source: AFSGD/W/4BQ2DsEkEPsvKEGT0Y3u9RdUGEwvgf86+cp5AbNWXVubumoBn7QitYIlaVqd7Um+ZaVhHg==
X-Received: by 2002:a17:906:b387:: with SMTP id o7-v6mr16927718ejz.124.1544672776452;
        Wed, 12 Dec 2018 19:46:16 -0800 (PST)
Received: from localhost ([185.92.221.13])
        by smtp.gmail.com with ESMTPSA id t24sm273661edb.7.2018.12.12.19.46.15
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 12 Dec 2018 19:46:15 -0800 (PST)
Date:   Thu, 13 Dec 2018 03:46:15 +0000
From:   Wei Yang <richard.weiyang@gmail.com>
To:     Mikhail Zaslonko <zaslonko@linux.ibm.com>
Cc:     akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, mhocko@kernel.org,
        Pavel.Tatashin@microsoft.com, schwidefsky@de.ibm.com,
        heiko.carstens@de.ibm.com, gerald.schaefer@de.ibm.com
Subject: Re: [PATCH v2 1/1] mm, memory_hotplug: Initialize struct pages for
 the full memory section
Message-ID: <20181213034615.4ntpo4cl2oo5mcx4@master>
Reply-To: Wei Yang <richard.weiyang@gmail.com>
References: <20181212172712.34019-1-zaslonko@linux.ibm.com>
 <20181212172712.34019-2-zaslonko@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181212172712.34019-2-zaslonko@linux.ibm.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 12, 2018 at 06:27:12PM +0100, Mikhail Zaslonko wrote:
>If memory end is not aligned with the sparse memory section boundary, the
>mapping of such a section is only partly initialized. This may lead to
>VM_BUG_ON due to uninitialized struct page access from
>is_mem_section_removable() or test_pages_in_a_zone() function triggered by
>memory_hotplug sysfs handlers:
>
>Here are the the panic examples:
> CONFIG_DEBUG_VM=y
> CONFIG_DEBUG_VM_PGFLAGS=y
>
> kernel parameter mem=2050M
> --------------------------
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
> kernel parameter mem=3075M
> --------------------------
> page:000003d08300c000 is uninitialized and poisoned
> page dumped because: VM_BUG_ON_PAGE(PagePoisoned(p))
> Call Trace:
> ([<000000000038596c>] is_mem_section_removable+0xb4/0x190)
>  [<00000000008f12fa>] show_mem_removable+0x9a/0xd8
>  [<00000000008cf9c4>] dev_attr_show+0x34/0x70
>  [<0000000000463ad0>] sysfs_kf_seq_show+0xc8/0x148
>  [<00000000003e4194>] seq_read+0x204/0x480
>  [<00000000003b53ea>] __vfs_read+0x32/0x178
>  [<00000000003b55b2>] vfs_read+0x82/0x138
>  [<00000000003b5be2>] ksys_read+0x5a/0xb0
>  [<0000000000b86ba0>] system_call+0xdc/0x2d8
> Last Breaking-Event-Address:
>  [<000000000038596c>] is_mem_section_removable+0xb4/0x190
> Kernel panic - not syncing: Fatal exception: panic_on_oops
>
>Fix the problem by initializing the last memory section of each zone
>in memmap_init_zone() till the very end, even if it goes beyond the zone
>end.
>
>Signed-off-by: Mikhail Zaslonko <zaslonko@linux.ibm.com>
>Reviewed-by: Gerald Schaefer <gerald.schaefer@de.ibm.com>
>Cc: <stable@vger.kernel.org>
>---
> mm/page_alloc.c | 12 ++++++++++++
> 1 file changed, 12 insertions(+)
>
>diff --git a/mm/page_alloc.c b/mm/page_alloc.c
>index 2ec9cc407216..e2afdb2dc2c5 100644
>--- a/mm/page_alloc.c
>+++ b/mm/page_alloc.c
>@@ -5542,6 +5542,18 @@ void __meminit memmap_init_zone(unsigned long size, int nid, unsigned long zone,
> 			cond_resched();
> 		}
> 	}
>+#ifdef CONFIG_SPARSEMEM
>+	/*
>+	 * If the zone does not span the rest of the section then
>+	 * we should at least initialize those pages. Otherwise we
>+	 * could blow up on a poisoned page in some paths which depend
>+	 * on full sections being initialized (e.g. memory hotplug).
>+	 */
>+	while (end_pfn % PAGES_PER_SECTION) {
>+		__init_single_page(pfn_to_page(end_pfn), end_pfn, zone, nid);
>+		end_pfn++;
>+	}
>+#endif
> }

What will happen if the end_pfn is PAGES_PER_SECTION aligned, but there
is invalid pfn? For example, the page is skipped in the for loop of
memmap_init_zone()?

> 
> #ifdef CONFIG_ZONE_DEVICE
>-- 
>2.16.4

-- 
Wei Yang
Help you, Help me
