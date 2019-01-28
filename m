Return-Path: <SRS0=I/I1=QE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28CA0C282CF
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 23:31:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ED1E821783
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 23:31:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="eQE95d5R"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727149AbfA1Xbo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Jan 2019 18:31:44 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:34251 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726762AbfA1Xbn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jan 2019 18:31:43 -0500
Received: by mail-pl1-f193.google.com with SMTP id w4so8478968plz.1
        for <linux-kernel@vger.kernel.org>; Mon, 28 Jan 2019 15:31:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=2GP9OAGVV8ccDNyAepGVTM9EYcpaJQelC09NNR5eJcQ=;
        b=eQE95d5RELF3bKEHIk+lmha6kOQ0S60/ds6r0KKG0IwlLLwBdX92krhKyQwNvZGR22
         JroDhbp8CSVIm5xkiK3cfpE/DG3JQmrX0OBxkC/l7Ha9zqU4VgAdpR7yC433xEiPmHiG
         NwflLaEzl7cZfLwEoDYOMmbqgy4neW6OGhz6qCJwl7OySlTA5FhLaU4VQjcE/b86lRMB
         FaBz4U1Dm3aT82LHJFl8zhg/KPDPlrpyQrsWoAlNSlFme2Y6//8VXjZfZJxAYJZda7LJ
         AnxR/8YSjHI3gFI7Mp1eWaQZNjMxH8QsFLDg+ua0ZTWLuED+rIO8G+Xs65b6sN7kw7vf
         o+8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=2GP9OAGVV8ccDNyAepGVTM9EYcpaJQelC09NNR5eJcQ=;
        b=PEqPGoXCbh4Pna1eU8ahMqzn9AMKa+S3cS89sGPUYfxBiD8k16Dt5NmiSOWlNxt+bt
         RU8P1jPNXRd55dXseuoZpmxJQCUS8VPy1OStTmhgaKfMf0BNZA+vKIT1XChjH7EoOeyF
         8mFAcmtUSJM9124cZoIJ0cYl3nHjVgZGEYFqGYJldKhDeDsrlKSbyFKTMMlc0AxkYMpw
         z/czzEADOo5zfTh0iDz5dGLgtBMqEHe3CleEZzCFU3yzeBMHWWkCjxhE8vuCDihvOrsM
         w8Sju81P3ENNSTXmoQlCovAh6wV6kHBYktd/T7xMYSXEW+oR3dRBU9PiJct96uPBZbUp
         42cw==
X-Gm-Message-State: AJcUukfj6t/Lzz3YYOyJE9oYXUK1PXWGaI29jwTs7ONQTZN6PtqBToLh
        kFwTWTk/dCRqPguiy9hqIhVweQ==
X-Google-Smtp-Source: ALg8bN4cqkJmiZ5gKghLT317LQQcjr7UPbsVs/swAEuVTEf/o6Id+B8XaQopKBWSE6zKZspIugeXaw==
X-Received: by 2002:a17:902:d70b:: with SMTP id w11mr24119215ply.294.1548718302803;
        Mon, 28 Jan 2019 15:31:42 -0800 (PST)
Received: from ziepe.ca (S010614cc2056d97f.ed.shawcable.net. [174.3.196.123])
        by smtp.gmail.com with ESMTPSA id e24sm41669794pfi.153.2019.01.28.15.31.41
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 28 Jan 2019 15:31:41 -0800 (PST)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1goGNQ-0003H9-Sh; Mon, 28 Jan 2019 16:31:40 -0700
Date:   Mon, 28 Jan 2019 16:31:40 -0700
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Davidlohr Bueso <dave@stgolabs.net>
Cc:     akpm@linux-foundation.org, dledford@redhat.com, jack@suse.de,
        ira.weiny@intel.com, linux-rdma@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        dennis.dalessandro@intel.com, mike.marciniszyn@intel.com,
        Davidlohr Bueso <dbueso@suse.de>
Subject: Re: [PATCH 3/6] drivers/IB,qib: do not use mmap_sem
Message-ID: <20190128233140.GA12530@ziepe.ca>
References: <20190121174220.10583-1-dave@stgolabs.net>
 <20190121174220.10583-4-dave@stgolabs.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190121174220.10583-4-dave@stgolabs.net>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 21, 2019 at 09:42:17AM -0800, Davidlohr Bueso wrote:
> The driver uses mmap_sem for both pinned_vm accounting and
> get_user_pages(). By using gup_fast() and letting the mm handle
> the lock if needed, we can no longer rely on the semaphore and
> simplify the whole thing as the pinning is decoupled from the lock.
> 
> This also fixes a bug that __qib_get_user_pages was not taking into
> account the current value of pinned_vm.
> 
> Cc: dennis.dalessandro@intel.com
> Cc: mike.marciniszyn@intel.com
> Reviewed-by: Ira Weiny <ira.weiny@intel.com>
> Signed-off-by: Davidlohr Bueso <dbueso@suse.de>
> ---
>  drivers/infiniband/hw/qib/qib_user_pages.c | 67 ++++++++++--------------------
>  1 file changed, 22 insertions(+), 45 deletions(-)

I need you to respin this patch/series against the latest rdma tree:

git://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git

branch for-next

> diff --git a/drivers/infiniband/hw/qib/qib_user_pages.c b/drivers/infiniband/hw/qib/qib_user_pages.c
> -static int __qib_get_user_pages(unsigned long start_page, size_t num_pages,
> -				struct page **p)
> -{
> -	unsigned long lock_limit;
> -	size_t got;
> -	int ret;
> -
> -	lock_limit = rlimit(RLIMIT_MEMLOCK) >> PAGE_SHIFT;
> -
> -	if (num_pages > lock_limit && !capable(CAP_IPC_LOCK)) {
> -		ret = -ENOMEM;
> -		goto bail;
> -	}
> -
> -	for (got = 0; got < num_pages; got += ret) {
> -		ret = get_user_pages(start_page + got * PAGE_SIZE,
> -				     num_pages - got,
> -				     FOLL_WRITE | FOLL_FORCE,
> -				     p + got, NULL);

As this has been rightly changed to get_user_pages_longterm, and I
think the right answer to solve the conflict is to discard some of
this patch?

Since Andrew is OK with this I can move this ahead once this is
resolved, thanks.

Jason
