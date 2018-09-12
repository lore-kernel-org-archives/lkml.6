Return-Path: <SRS0=BZo9=L2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7ECD2C4646A
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 12:57:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1FEF620880
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 12:57:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e0u9DlRG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1FEF620880
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726913AbeILSCM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Sep 2018 14:02:12 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:42194 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726359AbeILSCM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Sep 2018 14:02:12 -0400
Received: by mail-pf1-f193.google.com with SMTP id l9-v6so972854pff.9
        for <linux-kernel@vger.kernel.org>; Wed, 12 Sep 2018 05:57:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=gFnRApD8eTXgqbVIHj0hu91RWfJLjjc9RcyY4TNYqsI=;
        b=e0u9DlRGmztv/Kc+BgJ6kII9u9PQy8Ii1d2Rf/dRY4qklN11VR0XvJnOnhxIcZNoBS
         T6SL02whota60VWrKL0GG+VqbkD96OfkkHI0U/gzvZ+qWHxstk3SY7eLP1xEhG3pJ3/O
         6WMNw+l5KKfxwn9g5MoAx09CCRAZtr8hdpHYv6M8rbOEQH7lQwCiSo+WjCMnk7uUZTtk
         RR5Cshlt4y5kv/LNOoW/vxGpZnPUVdeD7GRbRUJYM3Z+yw3yqvaibSeS4X3gRJ/Jvqkl
         WDxrpubQ4vkpcHU8RB4Hey1ercvGmVUiECFp/+fU93UZe1zkmnsGe5Kmcs7QJLYnGroq
         I7rQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=gFnRApD8eTXgqbVIHj0hu91RWfJLjjc9RcyY4TNYqsI=;
        b=M/9OSNO9y6rjG1rOKhFjKYzQfeZCcxpXNu651+2r9/3v9SxfsGReZuC11ZAZp8rhof
         TJ3guP/a9MuBb2U1oTTrfp8zvja9H2e7+iXvscTdNYQjDSn1zQUjA6WwNVlvpQaxfYd1
         vkWdg9Okv2YxxQYAm2q4AIC0SDzulFTiKCDPS9VinjfPEVo+5LMvgglLn+DqVieVYv4x
         jXExKI/mhUOuKFjVjc32nNRHvTW9cw/wG6TkMLQmaCtMt3TT50N9dJgm/7oMsh6zoKzU
         exOEMIVGSBQh6REFW6eXluKCLxKX1Ye3VFylhtoap7mCmNqw9fVMhn2uZJmfKUK7P6oF
         BKEA==
X-Gm-Message-State: APzg51DgnFaxiAGkZVr7nWHsga8NvPOqrKE5IhLGDzifJxqblCPcXGWA
        nVaFArMw6ImC/zRs/v4GfsU=
X-Google-Smtp-Source: ANB0VdY00fKF1gbwHALKXWV+e//wf9nKM9HXWwcAFdyKt53dR+CHZH2O7ige9jM3JlzbNK7C1b7BEQ==
X-Received: by 2002:a63:334c:: with SMTP id z73-v6mr2154603pgz.220.1536757067266;
        Wed, 12 Sep 2018 05:57:47 -0700 (PDT)
Received: from localhost (14-202-194-140.static.tpgi.com.au. [14.202.194.140])
        by smtp.gmail.com with ESMTPSA id m26-v6sm3214292pfi.102.2018.09.12.05.57.45
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 12 Sep 2018 05:57:46 -0700 (PDT)
Date:   Wed, 12 Sep 2018 22:57:43 +1000
From:   Balbir Singh <bsingharora@gmail.com>
To:     Michal Hocko <mhocko@kernel.org>
Cc:     Arun KS <arunks@codeaurora.org>, akpm@linux-foundation.org,
        dan.j.williams@intel.com, vbabka@suse.cz,
        pasha.tatashin@oracle.com, iamjoonsoo.kim@lge.com,
        osalvador@suse.de, malat@debian.org, gregkh@linuxfoundation.org,
        yasu.isimatu@gmail.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, arunks.linux@gmail.com,
        vinmenon@codeaurora.org
Subject: Re: [RFC] memory_hotplug: Free pages as pageblock_order
Message-ID: <20180912125743.GB8537@350D>
References: <1536744405-16752-1-git-send-email-arunks@codeaurora.org>
 <20180912103853.GC10951@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180912103853.GC10951@dhcp22.suse.cz>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 12, 2018 at 12:38:53PM +0200, Michal Hocko wrote:
> On Wed 12-09-18 14:56:45, Arun KS wrote:
> > When free pages are done with pageblock_order, time spend on
> > coalescing pages by buddy allocator can be reduced. With
> > section size of 256MB, hot add latency of a single section
> > shows improvement from 50-60 ms to less than 1 ms, hence
> > improving the hot add latency by 60%.
> 
> Where does the improvement come from? You are still doing the same
> amount of work except that the number of callbacks is lower. Is this the
> real source of 60% improvement?
>

It looks like only the first page of the pageblock is initialized, is
some of the cost amortized in terms of doing one initialization for
the page with order (order) and then relying on split_page and helpers
to do the rest? Of course the number of callbacks reduce by a significant
number as well.

 
> > 
> > If this looks okey, I'll modify users of set_online_page_callback
> > and resend clean patch.
> 
> [...]
> 
> > +static int generic_online_pages(struct page *page, unsigned int order);
> > +static online_pages_callback_t online_pages_callback = generic_online_pages;
> > +
> > +static int generic_online_pages(struct page *page, unsigned int order)
> > +{
> > +	unsigned long nr_pages = 1 << order;
> > +	struct page *p = page;
> > +	unsigned int loop;
> > +
> > +	for (loop = 0 ; loop < nr_pages ; loop++, p++) {
> > +		__ClearPageReserved(p);
> > +		set_page_count(p, 0);
> > +	}
> > +	adjust_managed_page_count(page, nr_pages);
> > +	init_page_count(page);
> > +	__free_pages(page, order);
> > +
> > +	return 0;
> > +}
> > +
> > +static int online_pages_blocks(unsigned long start_pfn, unsigned long nr_pages)
> > +{
> > +	unsigned long pages_per_block = (1 << pageblock_order);
> > +	unsigned long nr_pageblocks = nr_pages / pages_per_block;
> > +//	unsigned long rem_pages = nr_pages % pages_per_block;
> > +	int i, ret, onlined_pages = 0;
> > +	struct page *page;
> > +
> > +	for (i = 0 ; i < nr_pageblocks ; i++) {
> > +		page = pfn_to_page(start_pfn + (i * pages_per_block));
> > +		ret = (*online_pages_callback)(page, pageblock_order);
> > +		if (!ret)
> > +			onlined_pages += pages_per_block;
> > +		else if (ret > 0)
> > +			onlined_pages += ret;
> > +	}
> 
> Could you explain why does the pages_per_block step makes any sense? Why
> don't you simply apply handle the full nr_pages worth of memory range
> instead?
> 
> > +/*
> > +	if (rem_pages)
> > +		onlined_pages += online_page_single(start_pfn + i, rem_pages);
> > +*/

Do we expect no rem_pages with this patch?

> > +
> > +	return onlined_pages;
> > +}
> > +
> >  static int online_pages_range(unsigned long start_pfn, unsigned long nr_pages,
> >  			void *arg)
> >  {
> > -	unsigned long i;
> >  	unsigned long onlined_pages = *(unsigned long *)arg;
> > -	struct page *page;
> >  
> >  	if (PageReserved(pfn_to_page(start_pfn)))
> > -		for (i = 0; i < nr_pages; i++) {
> > -			page = pfn_to_page(start_pfn + i);
> > -			(*online_page_callback)(page);
> > -			onlined_pages++;
> > -		}
> > +		onlined_pages = online_pages_blocks(start_pfn, nr_pages);
> >  
> >  	online_mem_sections(start_pfn, start_pfn + nr_pages);


Balbir Singh.
