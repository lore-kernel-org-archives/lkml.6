Return-Path: <SRS0=0/YT=MK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61506C43382
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 15:36:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E244220666
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 15:36:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tOkWRa0Z"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E244220666
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729363AbeI1WAj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Sep 2018 18:00:39 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:44340 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728873AbeI1WAj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Sep 2018 18:00:39 -0400
Received: by mail-qt1-f195.google.com with SMTP id c56-v6so2179097qtd.11
        for <linux-kernel@vger.kernel.org>; Fri, 28 Sep 2018 08:36:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=nKm2YRs2GePh2jvk0yw4Oucb/WjAaxWxxbBWcB29RMU=;
        b=tOkWRa0Zd8AySTCMGQqA3W5BBQV+rtbD9+gYtngE4G27h9AVh11Sz1ljrYUOl8RDhc
         JIyWOO+WxI3wDjeMpRmLQxEuu6tWIRKsmNsEYeeEwOBv9KUtEJtSdWuHmHDJVyeTY1zC
         KgLgF2om/w7j8i8qVICv7KciIHjp4YDDJKRIC6lSSt6A9gtpHeTll7vLcmyyQpSKk6uZ
         LE6AeMj4chjK+qSUGk3kehYO/91LS4Q0qZfQmUe3Zwe1FQ6sQmagwcUghSmb1wKnts9i
         hwE2Hov2zHe4XyN8taTHapxer2ECWy14ZZ1VHRO1JvOOqF+ctYBpbzriHXStzhG5eEC4
         +K0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=nKm2YRs2GePh2jvk0yw4Oucb/WjAaxWxxbBWcB29RMU=;
        b=bdMMXPM6DgPvS9aAfyrQ7cRnfAfvp47RT/5pepgzo9wTvrAeckOwT4tZTn097adadh
         h6pt0KM3KJyfrav2lqv18nbAI5uWcVtaDs2d9gFEtvrxiLnZ4t9HEqldN8Y6Q3ALFd9C
         bAfMXf1ZGgi4Q7WSIPJI2yegsWbJE/NINXwABGTC8QXYNjje2KX3OT/k0JHN0zkbpBuM
         fqKzuibhrDvVkcRS1dkrbs/Nej4iHcxqN9Dh+RGv9JE74R691u5uSv95b620Fcvs+u2n
         Nc/BrQZJEZVdvUHf4CdpM/Ho8xlTDLw6XdZIQ20vsGgtGVSCCkOmci7IY+RA/lRLsomo
         Ho0w==
X-Gm-Message-State: ABuFfojcVfH6v1zwj3Qx+040MuxhuiYGWMnOw0NvTl+j4GzB/tmMa9SL
        LTI8yFjQsDKCGbNhxE0ymA==
X-Google-Smtp-Source: ACcGV61JlflqbCrJL/NZqcyOZ9086P0ua+QREl2rBVIzQwIT06i0o01QN/mAHXpN06XGJ67ZZPz1Yg==
X-Received: by 2002:ac8:414a:: with SMTP id e10-v6mr6478907qtm.330.1538148980943;
        Fri, 28 Sep 2018 08:36:20 -0700 (PDT)
Received: from gabell (nat-pool-bos-t.redhat.com. [66.187.233.206])
        by smtp.gmail.com with ESMTPSA id v51-v6sm3113573qtc.65.2018.09.28.08.36.20
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 28 Sep 2018 08:36:20 -0700 (PDT)
Date:   Fri, 28 Sep 2018 11:36:18 -0400
From:   Masayoshi Mizuma <msys.mizuma@gmail.com>
To:     Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>
Cc:     "linux-mm@kvack.org" <linux-mm@kvack.org>,
        Pavel Tatashin <pavel.tatashin@microsoft.com>,
        Michal Hocko <mhocko@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>
Subject: Re: [PATCH v2 3/3] mm: return zero_resv_unavail optimization
Message-ID: <20180928153618.gdxyb337a4w32vit@gabell>
References: <20180925153532.6206-1-msys.mizuma@gmail.com>
 <20180925153532.6206-4-msys.mizuma@gmail.com>
 <20180928001944.GA9242@hori1.linux.bs1.fc.nec.co.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180928001944.GA9242@hori1.linux.bs1.fc.nec.co.jp>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 28, 2018 at 12:19:44AM +0000, Naoya Horiguchi wrote:
> On Tue, Sep 25, 2018 at 11:35:32AM -0400, Masayoshi Mizuma wrote:
> > From: Pavel Tatashin <pavel.tatashin@microsoft.com>
> > 
> > When checking for valid pfns in zero_resv_unavail(), it is not necessary to
> > verify that pfns within pageblock_nr_pages ranges are valid, only the first
> > one needs to be checked. This is because memory for pages are allocated in
> > contiguous chunks that contain pageblock_nr_pages struct pages.
> > 
> > Signed-off-by: Pavel Tatashin <pavel.tatashin@microsoft.com>
> > Reviewed-off-by: Masayoshi Mizuma <m.mizuma@jp.fujitsu.com>
> 
> According to convention, review tag is formatted like "Reviewed-by: ...",

Sorry for the typo...

> Otherwise, looks good to me.
> 
> Acked-by: Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>

Thanks!

- Masa

> 
> > ---
> >  mm/page_alloc.c | 46 ++++++++++++++++++++++++++--------------------
> >  1 file changed, 26 insertions(+), 20 deletions(-)
> > 
> > diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> > index 3b9d89e..bd5b7e4 100644
> > --- a/mm/page_alloc.c
> > +++ b/mm/page_alloc.c
> > @@ -6440,6 +6440,29 @@ void __init free_area_init_node(int nid, unsigned long *zones_size,
> >  }
> >  
> >  #if defined(CONFIG_HAVE_MEMBLOCK) && !defined(CONFIG_FLAT_NODE_MEM_MAP)
> > +
> > +/*
> > + * Zero all valid struct pages in range [spfn, epfn), return number of struct
> > + * pages zeroed
> > + */
> > +static u64 zero_pfn_range(unsigned long spfn, unsigned long epfn)
> > +{
> > +	unsigned long pfn;
> > +	u64 pgcnt = 0;
> > +
> > +	for (pfn = spfn; pfn < epfn; pfn++) {
> > +		if (!pfn_valid(ALIGN_DOWN(pfn, pageblock_nr_pages))) {
> > +			pfn = ALIGN_DOWN(pfn, pageblock_nr_pages)
> > +				+ pageblock_nr_pages - 1;
> > +			continue;
> > +		}
> > +		mm_zero_struct_page(pfn_to_page(pfn));
> > +		pgcnt++;
> > +	}
> > +
> > +	return pgcnt;
> > +}
> > +
> >  /*
> >   * Only struct pages that are backed by physical memory are zeroed and
> >   * initialized by going through __init_single_page(). But, there are some
> > @@ -6455,7 +6478,6 @@ void __init free_area_init_node(int nid, unsigned long *zones_size,
> >  void __init zero_resv_unavail(void)
> >  {
> >  	phys_addr_t start, end;
> > -	unsigned long pfn;
> >  	u64 i, pgcnt;
> >  	phys_addr_t next = 0;
> >  
> > @@ -6465,34 +6487,18 @@ void __init zero_resv_unavail(void)
> >  	pgcnt = 0;
> >  	for_each_mem_range(i, &memblock.memory, NULL,
> >  			NUMA_NO_NODE, MEMBLOCK_NONE, &start, &end, NULL) {
> > -		if (next < start) {
> > -			for (pfn = PFN_DOWN(next); pfn < PFN_UP(start); pfn++) {
> > -				if (!pfn_valid(ALIGN_DOWN(pfn, pageblock_nr_pages)))
> > -					continue;
> > -				mm_zero_struct_page(pfn_to_page(pfn));
> > -				pgcnt++;
> > -			}
> > -		}
> > +		if (next < start)
> > +			pgcnt += zero_pfn_range(PFN_DOWN(next), PFN_UP(start));
> >  		next = end;
> >  	}
> > -	for (pfn = PFN_DOWN(next); pfn < max_pfn; pfn++) {
> > -		if (!pfn_valid(ALIGN_DOWN(pfn, pageblock_nr_pages)))
> > -			continue;
> > -		mm_zero_struct_page(pfn_to_page(pfn));
> > -		pgcnt++;
> > -	}
> > -
> > +	pgcnt += zero_pfn_range(PFN_DOWN(next), max_pfn);
> >  
> >  	/*
> >  	 * Struct pages that do not have backing memory. This could be because
> >  	 * firmware is using some of this memory, or for some other reasons.
> > -	 * Once memblock is changed so such behaviour is not allowed: i.e.
> > -	 * list of "reserved" memory must be a subset of list of "memory", then
> > -	 * this code can be removed.
> >  	 */
> >  	if (pgcnt)
> >  		pr_info("Zeroed struct page in unavailable ranges: %lld pages", pgcnt);
> > -
> >  }
> >  #endif /* CONFIG_HAVE_MEMBLOCK && !CONFIG_FLAT_NODE_MEM_MAP */
> >  
> > -- 
> > 2.18.0
> > 
> > 
