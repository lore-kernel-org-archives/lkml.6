Return-Path: <SRS0=E8pv=NX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A8ABC43441
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 19:14:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5EDF92245E
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 19:14:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=soleen.com header.i=@soleen.com header.b="SWRnCQ6Q"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5EDF92245E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=soleen.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725950AbeKMFJN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Nov 2018 00:09:13 -0500
Received: from mail-qk1-f196.google.com ([209.85.222.196]:36649 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725790AbeKMFJM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Nov 2018 00:09:12 -0500
Received: by mail-qk1-f196.google.com with SMTP id o125so15305351qkf.3
        for <linux-kernel@vger.kernel.org>; Mon, 12 Nov 2018 11:14:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=KzCdgaPGO4pLWaaV09NUse3TySmW3KJF0T1JyFjXBnI=;
        b=SWRnCQ6QR2F5lQ6PNVGQB5kbIWTZ+b6lhqmELIYZPOdsBH59FJ5DKOwlT1uUTv6hZ4
         uyFvM0VQdWL8HuYmE/adqJKwSjR4fks7oHPSvG7E7d9mfIyiQczXTAvWPMhKYCpHEo/F
         jGLcnPUPiMlolmAafssT95plqsRwz7n/OXHsmuMi0Ir9VQSo109oBiHgwTSjmy6/ZcCw
         IgPDcYEhmiiVza71ToHQa7lnzF4ZBsJWWcC7tEEMLLj8U9l/hHhv+U1DUuNoizGbeskW
         y2GTBfYOdHZRVn55rbStJV3T06poF8gGu/JRRR04WRSQ36/tcK93z86SOaHEzotLRxWS
         jcbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=KzCdgaPGO4pLWaaV09NUse3TySmW3KJF0T1JyFjXBnI=;
        b=hYIUH9Sww6OBL/yFxAe2Jiosdy+ngdt7ngaNID0R2ugJ0LMGwRAqZa/ymKLT66oRNq
         o5+pUGLQYFnZizOFhBhpTQ0M6ztDummZ4PjkSUPwSiGHFyfzN0S7L3MtyIlWcLBPjIxX
         7dA4uYnYkQip6DQWHbg9Q35P5RFrmqAPU/9nc2wg2HiknFW/RMJegmg8Q2SZTbfpWVgQ
         vz9NJQ1tv0g7gIRbQD1ZMUmglHYUl5BUdf7Hl8tApp3QfFVplYn0KVE01UgE2xPJhGM1
         HLOva9pnLHrjy4vYp8swXUBZxwtIVZn+M4evZPimlCNwsrpBnIT6RcGosWVhi4wqktnK
         ec3w==
X-Gm-Message-State: AGRZ1gJOUu4DteSDPPV9moK/dlrqFMhcWe5G4a4rSkNEOnymfFi1MEFo
        4a+w6Q9U8gtvMuWAt2SZrSceyQ==
X-Google-Smtp-Source: AJdET5d1lBTbjnvCI9jydwXYDONgJFtbfxe8sPLaPT2SBVCTVWjR9RHmsBiYD4bP+cHeF/UY1lCBhg==
X-Received: by 2002:a37:ba06:: with SMTP id k6mr2109789qkf.115.1542050077903;
        Mon, 12 Nov 2018 11:14:37 -0800 (PST)
Received: from soleen.tm1wkky2jk1uhgkn0ivaxijq1c.bx.internal.cloudapp.net ([40.117.208.181])
        by smtp.gmail.com with ESMTPSA id a68sm10632053qkj.63.2018.11.12.11.14.36
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 12 Nov 2018 11:14:36 -0800 (PST)
Date:   Mon, 12 Nov 2018 19:14:34 +0000
From:   Pavel Tatashin <pasha.tatashin@soleen.com>
To:     Oscar Salvador <osalvador@techadventures.net>
Cc:     akpm@linux-foundation.org, mhocko@suse.com,
        dan.j.williams@intel.com, yasu.isimatu@gmail.com,
        rppt@linux.vnet.ibm.com, malat@debian.org,
        linux-kernel@vger.kernel.org, pavel.tatashin@microsoft.com,
        jglisse@redhat.com, Jonathan.Cameron@huawei.com, rafael@kernel.org,
        david@redhat.com, dave.jiang@intel.com, linux-mm@kvack.org,
        alexander.h.duyck@linux.intel.com,
        Oscar Salvador <osalvador@suse.de>
Subject: Re: [PATCH 2/5] mm/memory_hotplug: Create add/del_device_memory
 functions
Message-ID: <20181112191434.z5ufchwele3fl6se@soleen.tm1wkky2jk1uhgkn0ivaxijq1c.bx.internal.cloudapp.net>
References: <20181015153034.32203-1-osalvador@techadventures.net>
 <20181015153034.32203-3-osalvador@techadventures.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181015153034.32203-3-osalvador@techadventures.net>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18-10-15 17:30:31, Oscar Salvador wrote:
> From: Oscar Salvador <osalvador@suse.de>
> 
> HMM/devm have a particular handling of memory-hotplug.
> They do not go through the common path, and so, they do not
> call either offline_pages() or online_pages().
> 
> The operations they perform are the following ones:
> 
> 1) Create the linear mapping in case the memory is not private
> 2) Initialize the pages and add the sections
> 3) Move the pages to ZONE_DEVICE
> 
> Due to this particular handling of hot-add/remove memory from HMM/devm,
> I think it would be nice to provide a helper function in order to
> make this cleaner, and not populate other regions with code
> that should belong to memory-hotplug.
> 
> The helpers are named:
> 
> del_device_memory
> add_device_memory
> 
> The idea is that add_device_memory will be in charge of:
> 
> a) call either arch_add_memory() or add_pages(), depending on whether
>    we want a linear mapping
> b) online the memory sections that correspond to the pfn range
> c) call move_pfn_range_to_zone() being zone ZONE_DEVICE to
>    expand zone/pgdat spanned pages and initialize its pages
> 
> del_device_memory, on the other hand, will be in charge of:
> 
> a) offline the memory sections that correspond to the pfn range
> b) call shrink_zone_pgdat_pages(), which shrinks node/zone spanned pages.
> c) call either arch_remove_memory() or __remove_pages(), depending on
>    whether we need to tear down the linear mapping or not
> 
> The reason behind step b) from add_device_memory() and step a)
> from del_device_memory is that now find_smallest/biggest_section_pfn
> will have to check for online sections, and not for valid sections as
> they used to do, because we call offline_mem_sections() in
> offline_pages().
> 
> In order to split up better the patches and ease the review,
> this patch will only make a) case work for add_device_memory(),
> and case c) for del_device_memory.
> 
> The other cases will be added in the next patch.
> 
> These two functions have to be called from devm/HMM code:
> 
> dd_device_memory:
>         - devm_memremap_pages()
>         - hmm_devmem_pages_create()
> 
> del_device_memory:
>         - hmm_devmem_release
>         - devm_memremap_pages_release
> 
> One thing I do not know is whether we can move kasan calls out of the
> hotplug lock or not.
> If we can, we could move the hotplug lock within add/del_device_memory().
> 
> Signed-off-by: Oscar Salvador <osalvador@suse.de>

Looks good to me, thank you.

Reviewed-by: Pavel Tatashin <pasha.tatashin@soleen.com>

Pasha
