Return-Path: <SRS0=9Qwj=MR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DCF8C00449
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 15:21:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 301A7206B2
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 15:21:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="DmfZxHMj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 301A7206B2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728203AbeJEWUH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Oct 2018 18:20:07 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:34233 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727788AbeJEWUH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Oct 2018 18:20:07 -0400
Received: by mail-io1-f67.google.com with SMTP id w2-v6so4707379ioc.1
        for <linux-kernel@vger.kernel.org>; Fri, 05 Oct 2018 08:20:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=DbWGc5kURAX0EWuzCw8Dmu5V/t52Llu9Q1dCmhRR5+Y=;
        b=DmfZxHMjYyzwvJNlXQ3QryStHWwzTIeW7QHjKUXRNUhATKhpCHOT+4DomSh33HupFb
         AfKIjIHqvdQiKRFXmRij4LQlNFqr3+PAuWafOI8RCeIAqqbWssWnst1Iq0NyQT+Ysg9T
         DgWPDBeUgS1hBCj4qs17FqXOg1RksLn95SeOyTKFT03ib6prAfvOde5QuvwDl1sqBGNq
         eOqHmuHsuF1yxlftdq+jqmVPsKbVO+H3I83uk0xwol/pYZXLad5FOb5Cd3Up5IU0M3Wz
         H9G4rowyW9LZL5E8Ho3er8yyFoJoMEHFRrmYb5p2VGQX5RuHxK9zlX+SGqQHmKsq9Mwu
         cBWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=DbWGc5kURAX0EWuzCw8Dmu5V/t52Llu9Q1dCmhRR5+Y=;
        b=SE8dff9xBOwaWghuIYmsmNy4Yb/cOGKJMy5RqsDupfuDTj0RgMyBv44xxWZOz6UNGG
         2ltQt70n7I953hH8Evo/ffE0xFGmVXVdIE3AW2rXvGbca1O1RulMhgNE9aVTuIHdux9q
         hnHbqMOwCNXrK4nk/aRBCBZvQc2IYGEOkhPoqW2EQp1M7qvxJmPXav8SdMwOHjU2iVtH
         MZr+7Q8Em5n+rDpxpKNT8PfsO9sd9rqXbXuRMuNfuuJlD9xO82cv+/H3l1K0vDTl8Kwc
         nt2iv5TOO9ujIpYJuHPH1JbqUfizMg2R7jtDD2Qh0ITfbfXoZLpayB+KWoRRKSOqJAc3
         l1yA==
X-Gm-Message-State: ABuFfogs3RC4fLjEg7vq5gCyE9ONCu6NISgLtxZdmD7pODV1J4md0bOw
        3P3ZK9D6t7e/jicXKdK0Jm7l3Q==
X-Google-Smtp-Source: ACcGV63zDRR9jqqdFU3fIZaAF2FiuwqQaWMVenJbYt4KlODOp/oWgYFYLLhg7uZKGorFSY8TPjNqPw==
X-Received: by 2002:a6b:8b8b:: with SMTP id n133-v6mr7646186iod.234.1538752857332;
        Fri, 05 Oct 2018 08:20:57 -0700 (PDT)
Received: from ziepe.ca (S010614cc2056d97f.ed.shawcable.net. [174.3.196.123])
        by smtp.gmail.com with ESMTPSA id i71-v6sm976685iti.15.2018.10.05.08.20.56
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 05 Oct 2018 08:20:56 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1g8RuR-0005bZ-F3; Fri, 05 Oct 2018 09:20:55 -0600
Date:   Fri, 5 Oct 2018 09:20:55 -0600
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     john.hubbard@gmail.com
Cc:     Matthew Wilcox <willy@infradead.org>,
        Michal Hocko <mhocko@kernel.org>,
        Christopher Lameter <cl@linux.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Jan Kara <jack@suse.cz>, linux-mm@kvack.org,
        LKML <linux-kernel@vger.kernel.org>,
        linux-rdma <linux-rdma@vger.kernel.org>,
        linux-fsdevel@vger.kernel.org, John Hubbard <jhubbard@nvidia.com>,
        Doug Ledford <dledford@redhat.com>,
        Mike Marciniszyn <mike.marciniszyn@intel.com>,
        Dennis Dalessandro <dennis.dalessandro@intel.com>,
        Christian Benvenuti <benve@cisco.com>
Subject: Re: [PATCH v2 3/3] infiniband/mm: convert to the new
 put_user_page[s]() calls
Message-ID: <20181005152055.GB20776@ziepe.ca>
References: <20181005040225.14292-1-jhubbard@nvidia.com>
 <20181005040225.14292-4-jhubbard@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181005040225.14292-4-jhubbard@nvidia.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 04, 2018 at 09:02:25PM -0700, john.hubbard@gmail.com wrote:
> From: John Hubbard <jhubbard@nvidia.com>
> 
> For code that retains pages via get_user_pages*(),
> release those pages via the new put_user_page(),
> instead of put_page().
> 
> This prepares for eventually fixing the problem described
> in [1], and is following a plan listed in [2], [3], [4].
> 
> [1] https://lwn.net/Articles/753027/ : "The Trouble with get_user_pages()"
> 
> [2] https://lkml.kernel.org/r/20180709080554.21931-1-jhubbard@nvidia.com
>     Proposed steps for fixing get_user_pages() + DMA problems.
> 
> [3]https://lkml.kernel.org/r/20180710082100.mkdwngdv5kkrcz6n@quack2.suse.cz
>     Bounce buffers (otherwise [2] is not really viable).
> 
> [4] https://lkml.kernel.org/r/20181003162115.GG24030@quack2.suse.cz
>     Follow-up discussions.
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
>  drivers/infiniband/core/umem.c              |  2 +-
>  drivers/infiniband/core/umem_odp.c          |  2 +-
>  drivers/infiniband/hw/hfi1/user_pages.c     | 11 ++++-------
>  drivers/infiniband/hw/mthca/mthca_memfree.c |  6 +++---
>  drivers/infiniband/hw/qib/qib_user_pages.c  | 11 ++++-------
>  drivers/infiniband/hw/qib/qib_user_sdma.c   |  8 ++++----
>  drivers/infiniband/hw/usnic/usnic_uiom.c    |  2 +-
>  7 files changed, 18 insertions(+), 24 deletions(-)
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
>  	}

How about ?

if (umem->writable && dirty)
     put_user_pages_dirty_lock(&page, 1);
else
     put_user_page(page);

?

> diff --git a/drivers/infiniband/hw/hfi1/user_pages.c b/drivers/infiniband/hw/hfi1/user_pages.c
> index e341e6dcc388..99ccc0483711 100644
> +++ b/drivers/infiniband/hw/hfi1/user_pages.c
> @@ -121,13 +121,10 @@ int hfi1_acquire_user_pages(struct mm_struct *mm, unsigned long vaddr, size_t np
>  void hfi1_release_user_pages(struct mm_struct *mm, struct page **p,
>  			     size_t npages, bool dirty)
>  {
> -	size_t i;
> -
> -	for (i = 0; i < npages; i++) {
> -		if (dirty)
> -			set_page_dirty_lock(p[i]);
> -		put_page(p[i]);
> -	}
> +	if (dirty)
> +		put_user_pages_dirty_lock(p, npages);
> +	else
> +		put_user_pages(p, npages);

And I know Jan gave the feedback to remove the bool argument, but just
pointing out that quite possibly evey caller will wrapper it in an if
like this..

Jason
