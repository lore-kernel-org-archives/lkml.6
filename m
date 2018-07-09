Return-Path: <SRS0=qUjc=JZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38E72C5CFEB
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 15:54:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E80E120842
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 15:54:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="Km/oUwFB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E80E120842
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933960AbeGIPyD (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Jul 2018 11:54:03 -0400
Received: from mail-pl0-f67.google.com ([209.85.160.67]:37260 "EHLO
        mail-pl0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933066AbeGIPx7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jul 2018 11:53:59 -0400
Received: by mail-pl0-f67.google.com with SMTP id 31-v6so6228682plc.4
        for <linux-kernel@vger.kernel.org>; Mon, 09 Jul 2018 08:53:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=lIEiHn+quZaNr8NIPwbhQSc5h6JpQt9v09YJqQ5JeQU=;
        b=Km/oUwFBEjYHE0Pt7UBAm07A6gDUXieL64lQc5FuwW/S1xRTOcxfDYufjVVuqXb/KZ
         k6qMNaU6o6Go13FaxXZwt6MJJzgs/AvLoBAtPw4H4EBm+1KXD3L3s0+5WNKhMdgM62ZH
         Jy5/FCAkf6t8vZFXdERsIczdjctUHCxaX2KTfkDJj8jluea/PjNUzcX/tXhbDb1ImfJR
         xk3wxU4k5vlVA2MCXB5KLWY+mzfQhmOe6CSvhrTunfJ3Vb29izg6VZeSSrt4Qp4buZmN
         he0PkwueK/5bCSpyuhkiywmKkJuUbyLCvByGJ0Y9CZORN4s9xznoWrQMAjsWXKtOF/LL
         XYuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=lIEiHn+quZaNr8NIPwbhQSc5h6JpQt9v09YJqQ5JeQU=;
        b=TppJ97KM95DWBJkB4ik7s15jkqncwcej5AG0rv8b1t4rcaAzF0zHpRbnmSCdlnDyWM
         6cIO1Cy9N1wEYZLvvxfqHtkhtmBJFFgcfQW9I/NIdE6b6saU/0cpS+oIgrrVci+QO1ug
         qIIz1sTA9yXk+wIkbXI2XXrD+4jO63noD1twV7jyOvfEt8Fl5fG9wQd+HX3AntFnbncq
         tk12FzWkxioUmLkQb47yqdFpoXdJjybHaRS1IyP0Tv9nqEsfeB/8g4P4xoN1VbeMq2zy
         tYa9LgYt3rdbnU3FPMwHJl+aCKKxQWnHk/i2Yw3gxWsVT92oAN/mEJg7eUoFScIvFMf2
         zfwg==
X-Gm-Message-State: APt69E1xD0WzN7iAFV9zyXeLg/KMuq5ramKhxcjlAXVnh5UFeKwJxsI2
        YyBIOLg2KORZHIsuWuAsq179DQ==
X-Google-Smtp-Source: AAOMgpcIHPzfIQyFSvULpYpeqsM9rKe2GyPwBtt6VLLreTfNzQXP6Ce3gTX1CjQkdvw6oon6vnJ8LQ==
X-Received: by 2002:a17:902:201:: with SMTP id 1-v6mr21426208plc.310.1531151639091;
        Mon, 09 Jul 2018 08:53:59 -0700 (PDT)
Received: from ziepe.ca (S010614cc2056d97f.ed.shawcable.net. [174.3.196.123])
        by smtp.gmail.com with ESMTPSA id l85-v6sm33656157pfk.79.2018.07.09.08.53.58
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 09 Jul 2018 08:53:58 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.86_2)
        (envelope-from <jgg@ziepe.ca>)
        id 1fcYU9-0003a4-Nn; Mon, 09 Jul 2018 09:53:57 -0600
Date:   Mon, 9 Jul 2018 09:53:57 -0600
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     john.hubbard@gmail.com
Cc:     Matthew Wilcox <willy@infradead.org>,
        Michal Hocko <mhocko@kernel.org>,
        Christopher Lameter <cl@linux.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Jan Kara <jack@suse.cz>, Al Viro <viro@zeniv.linux.org.uk>,
        linux-mm@kvack.org, LKML <linux-kernel@vger.kernel.org>,
        linux-rdma <linux-rdma@vger.kernel.org>,
        linux-fsdevel@vger.kernel.org, John Hubbard <jhubbard@nvidia.com>
Subject: Re: [PATCH 1/2] mm: introduce put_user_page(), placeholder version
Message-ID: <20180709155357.GA13496@ziepe.ca>
References: <20180709080554.21931-1-jhubbard@nvidia.com>
 <20180709080554.21931-2-jhubbard@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180709080554.21931-2-jhubbard@nvidia.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 09, 2018 at 01:05:53AM -0700, john.hubbard@gmail.com wrote:
> From: John Hubbard <jhubbard@nvidia.com>
> 
> Introduces put_user_page(), which simply calls put_page().
> This provides a safe way to update all get_user_pages*() callers,
> so that they call put_user_page(), instead of put_page().
> 
> Also adds release_user_pages(), a drop-in replacement for
> release_pages(). This is intended to be easily grep-able,
> for later performance improvements, since release_user_pages
> is not batched like release_pages is, and is significantly
> slower.
> 
> Subsequent patches will add functionality to put_user_page().
> 
> Signed-off-by: John Hubbard <jhubbard@nvidia.com>
>  include/linux/mm.h | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
> 
> diff --git a/include/linux/mm.h b/include/linux/mm.h
> index a0fbb9ffe380..db4a211aad79 100644
> +++ b/include/linux/mm.h
> @@ -923,6 +923,20 @@ static inline void put_page(struct page *page)
>  		__put_page(page);
>  }
>  
> +/* Placeholder version, until all get_user_pages*() callers are updated. */
> +static inline void put_user_page(struct page *page)
> +{
> +	put_page(page);
> +}
> +
> +/* A drop-in replacement for release_pages(): */
> +static inline void release_user_pages(struct page **pages,
> +				      unsigned long npages)
> +{
> +	while (npages)
> +		put_user_page(pages[--npages]);
> +}
> +
>  #if defined(CONFIG_SPARSEMEM) && !defined(CONFIG_SPARSEMEM_VMEMMAP)
>  #define SECTION_IN_PAGE_FLAGS
>  #endif

Just as question: Do you think it is worthwhile to have a
release_user_page_dirtied() helper as well?

Ie to indicate that a pages that were grabbed under GUP FOLL_WRITE
were actually written too?

Keeps more of these unimportant details out of the drivers..

Jason
