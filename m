Return-Path: <SRS0=fRGm=MU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 792F3C65C20
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 19:42:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 30D5221479
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 19:42:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="UwIzmnZb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 30D5221479
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726932AbeJIC4E (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Oct 2018 22:56:04 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:40440 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726441AbeJIC4E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Oct 2018 22:56:04 -0400
Received: by mail-pl1-f196.google.com with SMTP id 1-v6so10509584plv.7
        for <linux-kernel@vger.kernel.org>; Mon, 08 Oct 2018 12:42:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=nEZF5arHSWr6SMMAhYtSjs3zSHMez3qp1E9gJMN7IzQ=;
        b=UwIzmnZbNBXyXVu+5PPihsCa5YAlgcuxXSJRwKaTYV0mUZI55GRabdcRb9+cNUIBNl
         eYDRhdrVIEuK3NW8G0nsb/d8umF5HswN/VFOEGJTXc6yP8+dTjZLivwaHLbJsdP9YX+w
         UqEU1MP0JFwOWQjyOK5soxAAwL3yIggJWwyxF4+cCNmD1sC8biowkDSNXlU0dmRyLAgl
         d3e572/KSLYLrDucojjdA8+5b1b0WH3EBrB6/IBjdR8p3nhc4uIUEi0iHx8gS24+a8K8
         dbeW1xESpRNOtLtXfkjYjX/F3nt1aTctnKDJi5JtwqsBm/Le/udjejRTk9CUxmWyQoUK
         Dwxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=nEZF5arHSWr6SMMAhYtSjs3zSHMez3qp1E9gJMN7IzQ=;
        b=DE9UfHU45ynDY5/5cSdGgI8nUFWHJLKrBGSajuW3Y7epe9mEM/AAxRk5N9kFtb7SfH
         vGlKvEQfXrklSB4TlzOGl/T2q3JbSO0HnH9+ZeGq/wH99Dm/MAwltX6pgc3N57rjSO/5
         HtE5fe1fBOuNrwFWrGcAnZDr9pGRoen4IZKudo3qkJrdqb94vm+ZQtB5948sQqQ+/Qxr
         IuAYGzilEsYgwG9OlVkEuvyJWWzRI9SpOtztQWgxNkjkD2PdvsUzXX8QR5BLGra9NVID
         NtUVd7usBj3nnlacpD3+Y5IpTcEQ41s9uNlfDSrJRiYUHHzK/JJ0vY6vXySf93Mbpk+I
         0b+w==
X-Gm-Message-State: ABuFfojDw4/BwfRk9V83t1Zh6dreaX7mhO5ynRZWmpo898cFan6MaCh+
        B8fUWyqN1ubAvQtMprmESZJM1g==
X-Google-Smtp-Source: ACcGV60GViczSYa7ByPFvFPjRG7LLXLeyXlZJSil/YbGqHOIc1QeZsftcGccO5sFt7FKouABviy2dQ==
X-Received: by 2002:a17:902:8481:: with SMTP id c1-v6mr25780011plo.158.1539027762496;
        Mon, 08 Oct 2018 12:42:42 -0700 (PDT)
Received: from ziepe.ca (S010614cc2056d97f.ed.shawcable.net. [174.3.196.123])
        by smtp.gmail.com with ESMTPSA id m20-v6sm12763474pgv.93.2018.10.08.12.42.40
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 08 Oct 2018 12:42:41 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1g9bQO-0007s8-9r; Mon, 08 Oct 2018 13:42:40 -0600
Date:   Mon, 8 Oct 2018 13:42:40 -0600
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
Subject: Re: [PATCH v3 3/3] infiniband/mm: convert put_page() to
 put_user_page*()
Message-ID: <20181008194240.GA27639@ziepe.ca>
References: <20181006024949.20691-1-jhubbard@nvidia.com>
 <20181006024949.20691-4-jhubbard@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181006024949.20691-4-jhubbard@nvidia.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 05, 2018 at 07:49:49PM -0700, john.hubbard@gmail.com wrote:
> From: John Hubbard <jhubbard@nvidia.com>
> 
> For code that retains pages via get_user_pages*(),
> release those pages via the new put_user_page(), or
> put_user_pages*(), instead of put_page()
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
> ---
>  drivers/infiniband/core/umem.c              |  7 ++++---
>  drivers/infiniband/core/umem_odp.c          |  2 +-
>  drivers/infiniband/hw/hfi1/user_pages.c     | 11 ++++-------
>  drivers/infiniband/hw/mthca/mthca_memfree.c |  6 +++---
>  drivers/infiniband/hw/qib/qib_user_pages.c  | 11 ++++-------
>  drivers/infiniband/hw/qib/qib_user_sdma.c   |  8 ++++----
>  drivers/infiniband/hw/usnic/usnic_uiom.c    |  7 ++++---
>  7 files changed, 24 insertions(+), 28 deletions(-)

I have no issues with this, do you want this series to go through the
rdma tree? Otherwise:

Acked-by: Jason Gunthorpe <jgg@mellanox.com>

Thanks,
Jason
