Return-Path: <SRS0=0/YT=MK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C2E4C43382
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 15:39:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 10CB620684
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 15:39:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="g1AzovzO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 10CB620684
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729434AbeI1WDo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Sep 2018 18:03:44 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:40513 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729395AbeI1WDn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Sep 2018 18:03:43 -0400
Received: by mail-pf1-f194.google.com with SMTP id s5-v6so4578140pfj.7
        for <linux-kernel@vger.kernel.org>; Fri, 28 Sep 2018 08:39:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=0TYr5NY0CofeIlHaMY40boMoQxSyihMvmywQ5MlrRjk=;
        b=g1AzovzOI+fZhRpjhjrrvTTojGC1eGEUAuLxbUYqbGohCeWGC9vBDs++clutRYgbUA
         sT4hpQ/SvlScMi0TFVXzCjTE4uim9eeK3OKwl5/hHVqqBrktjyXqDHfpX8MDaWAjEwrc
         DG24B636UeCrOxNz8rOyxiZmgk7ovMBlCzHfZWR6JumYsTvq8dpm9lUAPE21ZTeb2Ze9
         lPiwC0lQS8bOmvtHSDIPsa0w/VkOv7Ka1C3G1cXXF+mXtRUYu4v0OFwoWWF3HhlhGjYv
         GsgDl9C+3JBdcSpqs5qpY8zTaUY9SGtV/9+3VdeBh6LKxmKJDYBqFEorHcfN8hxKKCVT
         PVeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=0TYr5NY0CofeIlHaMY40boMoQxSyihMvmywQ5MlrRjk=;
        b=Bh+gpRkbx4nUIKvJ/8oCKjIgOcXoFg7plonK7eNTm82IDgBIvLqhRU3haoMXo2qovN
         OE6M3Jkynsiz0yzWh6xCcVv1ZFkf4rmCMtSFB5yGE3QtX6FrPN238Gdi/dYTJsz8B7wt
         v/48uuVRMYtbVsWFGFb+YlQwkeHUkHkJCcrdY5gJxnxarF6OzBF5hTlBc8k7ZWnE+28n
         MTMFURR49puqUjyXX99p24iZd/q04c83+AvpLA+DI82JRJRNT1pUJYgcWWlBxP2O6rCQ
         bWHlU22357lf/hm6dUQaHDzi9gNCJMw+aQHgqlJyVnQExzcJBHdnctjHD0a9YneFaWdU
         QGjw==
X-Gm-Message-State: ABuFfoiW38+CSMYG9ue48OdjN/QP/taTerUEqXmpXeBAEFbf6Rr7g9UC
        u0TQezdAo4mFNRpz0gDtTuxDfw==
X-Google-Smtp-Source: ACcGV62ID16YrmQGDzJlXmDVS1/XpD9QIqX0v4nvOZJZsnqTtJWFL0WZacYtiZjotaeIp3SxD6JPnA==
X-Received: by 2002:a63:fa09:: with SMTP id y9-v6mr10062258pgh.177.1538149164518;
        Fri, 28 Sep 2018 08:39:24 -0700 (PDT)
Received: from ziepe.ca (S010614cc2056d97f.ed.shawcable.net. [174.3.196.123])
        by smtp.gmail.com with ESMTPSA id p1-v6sm7789656pfn.53.2018.09.28.08.39.23
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 28 Sep 2018 08:39:23 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1g5urS-0004XA-Tu; Fri, 28 Sep 2018 09:39:22 -0600
Date:   Fri, 28 Sep 2018 09:39:22 -0600
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     john.hubbard@gmail.com
Cc:     Matthew Wilcox <willy@infradead.org>,
        Michal Hocko <mhocko@kernel.org>,
        Christopher Lameter <cl@linux.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Jan Kara <jack@suse.cz>, Al Viro <viro@zeniv.linux.org.uk>,
        linux-mm@kvack.org, LKML <linux-kernel@vger.kernel.org>,
        linux-rdma <linux-rdma@vger.kernel.org>,
        linux-fsdevel@vger.kernel.org, John Hubbard <jhubbard@nvidia.com>,
        Doug Ledford <dledford@redhat.com>,
        Mike Marciniszyn <mike.marciniszyn@intel.com>,
        Dennis Dalessandro <dennis.dalessandro@intel.com>,
        Christian Benvenuti <benve@cisco.com>
Subject: Re: [PATCH 3/4] infiniband/mm: convert to the new put_user_page()
 call
Message-ID: <20180928153922.GA17076@ziepe.ca>
References: <20180928053949.5381-1-jhubbard@nvidia.com>
 <20180928053949.5381-3-jhubbard@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180928053949.5381-3-jhubbard@nvidia.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 27, 2018 at 10:39:47PM -0700, john.hubbard@gmail.com wrote:
> From: John Hubbard <jhubbard@nvidia.com>
> 
> For code that retains pages via get_user_pages*(),
> release those pages via the new put_user_page(),
> instead of put_page().
> 
> This prepares for eventually fixing the problem described
> in [1], and is following a plan listed in [2].
> 
> [1] https://lwn.net/Articles/753027/ : "The Trouble with get_user_pages()"
> 
> [2] https://lkml.kernel.org/r/20180709080554.21931-1-jhubbard@nvidia.com
>     Proposed steps for fixing get_user_pages() + DMA problems.
> 
> CC: Doug Ledford <dledford@redhat.com>
> CC: Jason Gunthorpe <jgg@ziepe.ca>
> CC: Mike Marciniszyn <mike.marciniszyn@intel.com>
> CC: Dennis Dalessandro <dennis.dalessandro@intel.com>
> CC: Christian Benvenuti <benve@cisco.com>
> 
> CC: linux-rdma@vger.kernel.org
> CC: linux-kernel@vger.kernel.org
> CC: linux-mm@kvack.org
> Signed-off-by: John Hubbard <jhubbard@nvidia.com>
>  drivers/infiniband/core/umem.c              | 2 +-
>  drivers/infiniband/core/umem_odp.c          | 2 +-
>  drivers/infiniband/hw/hfi1/user_pages.c     | 2 +-
>  drivers/infiniband/hw/mthca/mthca_memfree.c | 6 +++---
>  drivers/infiniband/hw/qib/qib_user_pages.c  | 2 +-
>  drivers/infiniband/hw/qib/qib_user_sdma.c   | 8 ++++----
>  drivers/infiniband/hw/usnic/usnic_uiom.c    | 2 +-
>  7 files changed, 12 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/infiniband/core/umem.c b/drivers/infiniband/core/umem.c
> index a41792dbae1f..9430d697cb9f 100644
> +++ b/drivers/infiniband/core/umem.c
> @@ -60,7 +60,7 @@ static void __ib_umem_release(struct ib_device *dev, struct ib_umem *umem, int d
>  		page = sg_page(sg);
>  		if (!PageDirty(page) && umem->writable && dirty)
>  			set_page_dirty_lock(page);
> -		put_page(page);
> +		put_user_page(page);

Would it make sense to have a release/put_user_pages_dirtied to absorb
the set_page_dity pattern too? I notice in this patch there is some
variety here, I wonder what is the right way?

Also, I'm told this code here is a big performance bottleneck when the
number of pages becomes very long (think >> GB of memory), so having a
future path to use some kind of batching/threading sound great.

Otherwise this RDMA part seems fine to me, there might be some minor
conflicts however. I assume you want to run this through the -mm tree?

Acked-by: Jason Gunthorpe <jgg@mellanox.com>

Jason
