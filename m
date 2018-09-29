Return-Path: <SRS0=m5O9=ML=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93243C43143
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Sep 2018 19:19:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4E0522088F
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Sep 2018 19:19:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="jf/kYQKA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4E0522088F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727878AbeI3Bsz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 29 Sep 2018 21:48:55 -0400
Received: from mail-it1-f196.google.com ([209.85.166.196]:55377 "EHLO
        mail-it1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727425AbeI3Bsy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Sep 2018 21:48:54 -0400
Received: by mail-it1-f196.google.com with SMTP id c23-v6so6575721itd.5
        for <linux-kernel@vger.kernel.org>; Sat, 29 Sep 2018 12:19:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=XKHId5EDQFt9mluNfZlvByTty2336xY+W5N/WMxxk38=;
        b=jf/kYQKAf6af0X+uWAQ03uvzIwRjGEaTrYhKHfx7XbnWtSbTWnXBUnHnm1AFxjr0NI
         uuzeyE5a6EZQ/6geCPEMU9vqMknX45yEUqF7d58ye2CxoGC+8xsmK9rt1DSdGx4sdJEr
         SONtxja2RRWtruDSKO83ANfkzkwvPuiAn0oo6HlBKNQzURreHkCNGTaOxopphJ6DjcO6
         Nva4O6UFwp1czqcFlBFavdKFBR7zHYfSp93em6TBieelrIRyiJJHIUhDtBvPZ/KxoKIE
         +EKmsO5lAKJf0qcNxkpsiPHgzIbx4kEWKXOCjh+XzvMCmRb/L8a0lBcYLLos9A9njq0+
         cYVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=XKHId5EDQFt9mluNfZlvByTty2336xY+W5N/WMxxk38=;
        b=Pylg0uS/2JQQDu/4oiXam06+6F0+X8tRegTl2SzAXktFii6kKvxko0HOu8t5vfyuXc
         MlgGuJmW5huUuxEeiBBaxpPwHJBtdLwcRYWGlRNkewb/jTAJU2Z7SFpbmGatWK55KL6t
         oKNuREWBZGA0KEVAX94KivpkwAVjxm9mqOKcEvr5b0qScjZRi3Eka1o70pzWzva0uWF1
         d50gaP1Hk7lWwe+tBqWV/ULd4+cBRTaDJAFlpv2/ZE1Zh6Q9ILnsH4OYEH/jSyb9hZ3Q
         8jH/L2haUhK9No65nI+dimAF9RE7l/89T7e9XSUNMf30rwjQbW9RVZjGqHhr8/b6asH2
         c54g==
X-Gm-Message-State: ABuFfohwJbZrTGJJYSkmMgXUXIR1Xe2a3LLVnBtQZlXo0H2YbtTQXqf+
        GGNq1bE2tL3o7sV2qwm18n5n4S7edd0=
X-Google-Smtp-Source: ACcGV60VzUHXcQekIvxAbu8okgsd4Hudbg2xQT5Q2RKc5GDbIMX5kv8MDf7QbNxSWLEFYq/vveZiJQ==
X-Received: by 2002:a24:5214:: with SMTP id d20-v6mr5856945itb.24.1538248757673;
        Sat, 29 Sep 2018 12:19:17 -0700 (PDT)
Received: from ziepe.ca (S010614cc2056d97f.ed.shawcable.net. [174.3.196.123])
        by smtp.gmail.com with ESMTPSA id 77-v6sm3237038itl.10.2018.09.29.12.19.15
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 29 Sep 2018 12:19:16 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1g6Klm-0003m0-SC; Sat, 29 Sep 2018 13:19:14 -0600
Date:   Sat, 29 Sep 2018 13:19:14 -0600
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     John Hubbard <jhubbard@nvidia.com>, john.hubbard@gmail.com,
        Michal Hocko <mhocko@kernel.org>,
        Christopher Lameter <cl@linux.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Jan Kara <jack@suse.cz>, Al Viro <viro@zeniv.linux.org.uk>,
        linux-mm@kvack.org, LKML <linux-kernel@vger.kernel.org>,
        linux-rdma <linux-rdma@vger.kernel.org>,
        linux-fsdevel@vger.kernel.org, Doug Ledford <dledford@redhat.com>,
        Mike Marciniszyn <mike.marciniszyn@intel.com>,
        Dennis Dalessandro <dennis.dalessandro@intel.com>,
        Christian Benvenuti <benve@cisco.com>
Subject: Re: [PATCH 3/4] infiniband/mm: convert to the new put_user_page()
 call
Message-ID: <20180929191914.GA13783@ziepe.ca>
References: <20180928053949.5381-1-jhubbard@nvidia.com>
 <20180928053949.5381-3-jhubbard@nvidia.com>
 <20180928153922.GA17076@ziepe.ca>
 <36bc65a3-8c2a-87df-44fc-89a1891b86db@nvidia.com>
 <20180929162117.GA31216@bombadil.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180929162117.GA31216@bombadil.infradead.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 29, 2018 at 09:21:17AM -0700, Matthew Wilcox wrote:
> On Fri, Sep 28, 2018 at 08:12:33PM -0700, John Hubbard wrote:
> > >> +++ b/drivers/infiniband/core/umem.c
> > >> @@ -60,7 +60,7 @@ static void __ib_umem_release(struct ib_device *dev, struct ib_umem *umem, int d
> > >>  		page = sg_page(sg);
> > >>  		if (!PageDirty(page) && umem->writable && dirty)
> > >>  			set_page_dirty_lock(page);
> > >> -		put_page(page);
> > >> +		put_user_page(page);
> > > 
> > > Would it make sense to have a release/put_user_pages_dirtied to absorb
> > > the set_page_dity pattern too? I notice in this patch there is some
> > > variety here, I wonder what is the right way?
> > > 
> > > Also, I'm told this code here is a big performance bottleneck when the
> > > number of pages becomes very long (think >> GB of memory), so having a
> > > future path to use some kind of batching/threading sound great.
> > 
> > Yes. And you asked for this the first time, too. Consistent! :) Sorry for
> > being slow to pick it up. It looks like there are several patterns, and
> > we have to support both set_page_dirty() and set_page_dirty_lock(). So
> > the best combination looks to be adding a few variations of
> > release_user_pages*(), but leaving put_user_page() alone, because it's
> > the "do it yourself" basic one. Scatter-gather will be stuck with that.
> 
> I think our current interfaces are wrong.  We should really have a
> get_user_sg() / put_user_sg() function that will set up / destroy an
> SG list appropriate for that range of user memory.  This is almost
> orthogonal to the original intent here, so please don't see this as a
> "must do first" kind of argument that might derail the whole thing.

This would be an excellent API, and it is exactly what this 'umem'
code in RDMA is trying to do for RDMA drivers..

I suspect it could do a much better job if it wasn't hindered by the
get_user_pages API - ie it could directly stuff huge pages into the SG
list instead of breaking them up, maybe also avoid the temporary memory
allocations for page * pointers, etc?

Jason
