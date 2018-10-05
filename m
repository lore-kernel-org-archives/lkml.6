Return-Path: <SRS0=9Qwj=MR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0AFFEC00449
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 15:17:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BAC5F2084D
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 15:17:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="SVu1DX80"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BAC5F2084D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728633AbeJEWQj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Oct 2018 18:16:39 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:43856 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728333AbeJEWQj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Oct 2018 18:16:39 -0400
Received: by mail-io1-f67.google.com with SMTP id y10-v6so10921238ioa.10
        for <linux-kernel@vger.kernel.org>; Fri, 05 Oct 2018 08:17:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=pnZcB3x/Ybuygz3ZsoAWJteQ2tTf5rFeELXa4bfOkAU=;
        b=SVu1DX80po4blOvtD2APxJAuo5MTsFofRZndd2ZSyvxu6li3E3MANzCvw1Ojn2+Qxc
         6ZvHeFYBiBwVDrQ5OVVQMIbPa7oj35UuLWc0Xl/qm/i7m+wdVlmrbx9Bnl3lFJIREV9S
         gur1/HWrarAQsN7cgaIorhCwtmsZhqh0dCJRhwT2PCt4+jHtqFmzJODNDBTLvAkRi5Gz
         xCl5LUIn8TXty2q0AnlP7JMkH5YvFvdSRPkJ0x55Nj6L73fzzertGCrzRkW/5F+bnp22
         C6Q0UpDgLCbAm86Oj7guV3lf/HmtInq60gxlX3KNDDXPqet2IxRYVJ6KDW8eIkz5Jbat
         PkPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=pnZcB3x/Ybuygz3ZsoAWJteQ2tTf5rFeELXa4bfOkAU=;
        b=hJabLiHOY8FQ4+EsY0K1a4EntZNiFEfuUZ+T6m7pCZAmJAB9ILxhmQuuKNcp76Kmuq
         +WThbCfGqtRaF3wkpyc1ZGxmrJz29S1hQNKzcWHgiQQHqd2BWoh1C2UTtBocX+3oeXD5
         4FY17m3hXSejGrZY+xTEPhMAUr5Z9MuzwYvI9hAZYgbm+WedBHndUCeudwgzclUl+vyR
         B2r1x90AUb+rnZH6gGoNw1Ng4JMbbwxgJ/zGzWoWtNFcH8TrlQU3+gHb7aggH6z3M8IA
         z6zefvKKdl0cmGlGPk3SG7iMf4SUZG9PWtNbMdiR3IyIUSAeNAOduriDuE7xtSnCS/oU
         DYNQ==
X-Gm-Message-State: ABuFfoil+dgWF2kIwv9OM3x2VWkeplc2xoIW7NlDj4ZqPjUBynydJJ+g
        ifPhqGI8l+RB8XNgrKUZbi5t3w==
X-Google-Smtp-Source: ACcGV63XY0WuUlKzS/0Tg4uCNOmtmhc5L95hnGy9KXgUl+y2o1H/TWnyc3akoUJYrGl+vUw0hJVLAg==
X-Received: by 2002:a6b:5b16:: with SMTP id v22-v6mr7902112ioh.177.1538752649833;
        Fri, 05 Oct 2018 08:17:29 -0700 (PDT)
Received: from ziepe.ca (S010614cc2056d97f.ed.shawcable.net. [174.3.196.123])
        by smtp.gmail.com with ESMTPSA id p1sm879712itk.11.2018.10.05.08.17.27
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 05 Oct 2018 08:17:28 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1g8Rr4-0005b9-TN; Fri, 05 Oct 2018 09:17:26 -0600
Date:   Fri, 5 Oct 2018 09:17:26 -0600
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
        Al Viro <viro@zeniv.linux.org.uk>,
        Jerome Glisse <jglisse@redhat.com>,
        Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH v2 2/3] mm: introduce put_user_page[s](), placeholder
 versions
Message-ID: <20181005151726.GA20776@ziepe.ca>
References: <20181005040225.14292-1-jhubbard@nvidia.com>
 <20181005040225.14292-3-jhubbard@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181005040225.14292-3-jhubbard@nvidia.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 04, 2018 at 09:02:24PM -0700, john.hubbard@gmail.com wrote:
> From: John Hubbard <jhubbard@nvidia.com>
> 
> Introduces put_user_page(), which simply calls put_page().
> This provides a way to update all get_user_pages*() callers,
> so that they call put_user_page(), instead of put_page().
> 
> Also introduces put_user_pages(), and a few dirty/locked variations,
> as a replacement for release_pages(), for the same reasons.
> These may be used for subsequent performance improvements,
> via batching of pages to be released.
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
> CC: Matthew Wilcox <willy@infradead.org>
> CC: Michal Hocko <mhocko@kernel.org>
> CC: Christopher Lameter <cl@linux.com>
> CC: Jason Gunthorpe <jgg@ziepe.ca>
> CC: Dan Williams <dan.j.williams@intel.com>
> CC: Jan Kara <jack@suse.cz>
> CC: Al Viro <viro@zeniv.linux.org.uk>
> CC: Jerome Glisse <jglisse@redhat.com>
> CC: Christoph Hellwig <hch@infradead.org>
> Signed-off-by: John Hubbard <jhubbard@nvidia.com>
>  include/linux/mm.h | 42 ++++++++++++++++++++++++++++++++++++++++--
>  1 file changed, 40 insertions(+), 2 deletions(-)
> 
> diff --git a/include/linux/mm.h b/include/linux/mm.h
> index a61ebe8ad4ca..1a9aae7c659f 100644
> +++ b/include/linux/mm.h
> @@ -137,6 +137,8 @@ extern int overcommit_ratio_handler(struct ctl_table *, int, void __user *,
>  				    size_t *, loff_t *);
>  extern int overcommit_kbytes_handler(struct ctl_table *, int, void __user *,
>  				    size_t *, loff_t *);
> +int set_page_dirty(struct page *page);
> +int set_page_dirty_lock(struct page *page);
>  
>  #define nth_page(page,n) pfn_to_page(page_to_pfn((page)) + (n))
>  
> @@ -943,6 +945,44 @@ static inline void put_page(struct page *page)
>  		__put_page(page);
>  }
>  
> +/* Placeholder version, until all get_user_pages*() callers are updated. */
> +static inline void put_user_page(struct page *page)
> +{
> +	put_page(page);
> +}
> +
> +/* For get_user_pages*()-pinned pages, use these variants instead of
> + * release_pages():
> + */
> +static inline void put_user_pages_dirty(struct page **pages,
> +					unsigned long npages)
> +{
> +	while (npages) {
> +		set_page_dirty(pages[npages]);
> +		put_user_page(pages[npages]);
> +		--npages;
> +	}
> +}

Shouldn't these do the !PageDirty(page) thing?

Jason
