Return-Path: <SRS0=/3Wd=NV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE0CEC43441
	for <linux-kernel@archiver.kernel.org>; Sat, 10 Nov 2018 02:07:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9B7F92081C
	for <linux-kernel@archiver.kernel.org>; Sat, 10 Nov 2018 02:07:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b="Czrg8MJg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9B7F92081C
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=soleen.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728526AbeKJLvL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 10 Nov 2018 06:51:11 -0500
Received: from mail-qk1-f194.google.com ([209.85.222.194]:33666 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728094AbeKJLvK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Nov 2018 06:51:10 -0500
Received: by mail-qk1-f194.google.com with SMTP id o89so5041147qko.0
        for <linux-kernel@vger.kernel.org>; Fri, 09 Nov 2018 18:07:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=GdkDlPXROl7OQqx/R1YJHBtZ/H1b7ijqrx0DhoJVH/I=;
        b=Czrg8MJgOHksq2SdqRZhY4KEu+TR4vQhkTIVRGnEeccTBgrOGPzVL0vcwowzWE7hEw
         juz7ZY2dnor1bBOm3FXW5GmawkRRxX7J9q9dinYfB+Oz9j5SVg3zQ0Z3PVdiJ33opRLF
         hUcey+9rMth9sWoO9eVC9jpjLlzeEXOmrb5SwGUsW8JX3Ol8sEBUvGOEBssNkBmj0+Wz
         mihMoMCpwLbcQc/sE8KZI2cLOV+huSGuP41DxByw8njQD6UlyvNZG+MEndsTsFr9jZKe
         Zsgk58JcWy6dLf4UrOW2c2JKtn/B3ZuUkwL/LuJ27eipFoDXZ0mWmotYlXm4n5u89GO2
         MPOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=GdkDlPXROl7OQqx/R1YJHBtZ/H1b7ijqrx0DhoJVH/I=;
        b=bh/GP5htAJKn4cQhCC9IE+pio8V1Pak+6bo4brLsJ8z6gBBhrXZvKjjFOguIZhtl3c
         r1uCpAyOjcIZGbcnooXDdK8Tog9+J5vR48Bw2FYC354NODhFrk9kjHRP9K36i7nsUArN
         3htlcOUF1wl/QaTbkxD2CaISH7jHSg+aLkaZftIZvW8uPa5XsKreZ/clG6hILjec7eld
         xLJTW+t2T1U3/d0GUd+R4VDX7niOZoBtH6uqb5o697aemfLYNrXPpFhqv1rWkuNyYohB
         7MqBUEID1mGa6zcco36qy5Dq4qMqZ1CFL8dVmFovsUOhI2DfPOowlBW8xhv2oIAFnd4v
         EszA==
X-Gm-Message-State: AGRZ1gIqEA428TFbZFDDpI1u+0k3chIfboJPGi/hQV5U9PECGzEOggfb
        8gco5DWJ6CClNw8yDEalqrqGhQ==
X-Google-Smtp-Source: AJdET5fQUA+nPc/dJSXM3jRcTVLQSeI2h2rDyI9C0JI9xVPOlcjtNe2G3aTr95Qu0E25QTmudoIlyg==
X-Received: by 2002:ac8:7518:: with SMTP id u24mr11122510qtq.75.1541815672766;
        Fri, 09 Nov 2018 18:07:52 -0800 (PST)
Received: from xakep.localdomain (c-73-69-118-222.hsd1.nh.comcast.net. [73.69.118.222])
        by smtp.gmail.com with ESMTPSA id a68sm6056169qkj.63.2018.11.09.18.07.51
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 09 Nov 2018 18:07:52 -0800 (PST)
Date:   Fri, 9 Nov 2018 21:07:50 -0500
From:   Pavel Tatashin <pasha.tatashin@soleen.com>
To:     Alexander Duyck <alexander.h.duyck@linux.intel.com>
Cc:     akpm@linux-foundation.org, linux-mm@kvack.org,
        sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-nvdimm@lists.01.org, davem@davemloft.net,
        pavel.tatashin@microsoft.com, mhocko@suse.com, mingo@kernel.org,
        kirill.shutemov@linux.intel.com, dan.j.williams@intel.com,
        dave.jiang@intel.com, rppt@linux.vnet.ibm.com, willy@infradead.org,
        vbabka@suse.cz, khalid.aziz@oracle.com, ldufour@linux.vnet.ibm.com,
        mgorman@techsingularity.net, yi.z.zhang@linux.intel.com
Subject: Re: [mm PATCH v5 5/7] mm: Move hot-plug specific memory init into
 separate functions and optimize
Message-ID: <20181110020750.fsvvzl6hgfvk4qx4@xakep.localdomain>
References: <154145268025.30046.11742652345962594283.stgit@ahduyck-desk1.jf.intel.com>
 <154145279094.30046.504725873397414096.stgit@ahduyck-desk1.jf.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <154145279094.30046.504725873397414096.stgit@ahduyck-desk1.jf.intel.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18-11-05 13:19:50, Alexander Duyck wrote:
> This patch is going through and combining the bits in memmap_init_zone and
> memmap_init_zone_device that are related to hotplug into a single function
> called __memmap_init_hotplug.
> 
> I also took the opportunity to integrate __init_single_page's functionality
> into this function. In doing so I can get rid of some of the redundancy
> such as the LRU pointers versus the pgmap.

Please don't do it, __init_single_page() is hard function to optimize,
do not copy its code. Instead could you you split __init_single_page()
in two parts, something like this:

static inline init_single_page_nolru(struct page *page, unsigned long pfn,
                                       unsigned long zone, int nid) {
        mm_zero_struct_page(page);
        set_page_links(page, zone, nid, pfn);
        init_page_count(page);
        page_mapcount_reset(page);
        page_cpupid_reset_last(page);
#ifdef WANT_PAGE_VIRTUAL
        /* The shift won't overflow because ZONE_NORMAL is below 4G. */
        if (!is_highmem_idx(zone))
                set_page_address(page, __va(pfn << PAGE_SHIFT));
#endif
}


static void __meminit init_single_page(struct page *page, unsigned long pfn, 
                                unsigned long zone, int nid) 
{
        init_single_page_nolru(page, pfn, zone, nid);
        INIT_LIST_HEAD(&page->lru);
}

And call init_single_page_nolru() from __init_pageblock() ? Also, remove
WANT_PAGE_VIRTUAL optimization, I do not think it worse it.

The rest looks very good, please do the above change.

Reviewed-by: Pavel Tatashin <pasha.tatashin@soleen.com>

> 
> Signed-off-by: Alexander Duyck <alexander.h.duyck@linux.intel.com>
> ---
