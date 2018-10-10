Return-Path: <SRS0=PZ5q=MW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B33AC43441
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 08:03:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 426372064E
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 08:03:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 426372064E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726725AbeJJPY1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Oct 2018 11:24:27 -0400
Received: from mx2.suse.de ([195.135.220.15]:36956 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725837AbeJJPY1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Oct 2018 11:24:27 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id B2375AFD3;
        Wed, 10 Oct 2018 08:03:26 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 2016F1E3617; Wed, 10 Oct 2018 10:03:26 +0200 (CEST)
Date:   Wed, 10 Oct 2018 10:03:26 +0200
From:   Jan Kara <jack@suse.cz>
To:     john.hubbard@gmail.com
Cc:     Matthew Wilcox <willy@infradead.org>,
        Michal Hocko <mhocko@kernel.org>,
        Christopher Lameter <cl@linux.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Dan Williams <dan.j.williams@intel.com>,
        Jan Kara <jack@suse.cz>, linux-mm@kvack.org,
        LKML <linux-kernel@vger.kernel.org>,
        linux-rdma <linux-rdma@vger.kernel.org>,
        linux-fsdevel@vger.kernel.org, John Hubbard <jhubbard@nvidia.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Jerome Glisse <jglisse@redhat.com>,
        Christoph Hellwig <hch@infradead.org>,
        Ralph Campbell <rcampbell@nvidia.com>
Subject: Re: [PATCH v5 2/3] mm: introduce put_user_page*(), placeholder
 versions
Message-ID: <20181010080326.GB11507@quack2.suse.cz>
References: <20181010041134.14096-1-jhubbard@nvidia.com>
 <20181010041134.14096-3-jhubbard@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181010041134.14096-3-jhubbard@nvidia.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 09-10-18 21:11:33, john.hubbard@gmail.com wrote:
> +/*
> + * put_user_pages() - for each page in the @pages array, release the page
> + * using put_user_page().
> + *
> + * Please see the put_user_page() documentation for details.
> + *
> + * This is just like put_user_pages_dirty(), except that it invokes
> + * set_page_dirty_lock(), instead of set_page_dirty().

This paragraph should be deleted. Other than that the patch looks good.

								Honza

> + *
> + * @pages:  array of pages to be marked dirty and released.
> + * @npages: number of pages in the @pages array.
> + *
> + */
> +void put_user_pages(struct page **pages, unsigned long npages)
> +{
> +	unsigned long index;
> +
> +	for (index = 0; index < npages; index++)
> +		put_user_page(pages[index]);
> +}
> +EXPORT_SYMBOL(put_user_pages);
> +
>  /*
>   * get_kernel_pages() - pin kernel pages in memory
>   * @kiov:	An array of struct kvec structures
> -- 
> 2.19.1
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
