Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73A94C169C4
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 18:26:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3C210222A1
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 18:26:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="Mj3mTK3f"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728841AbfBKS0v (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 13:26:51 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:45997 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727177AbfBKS0v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 13:26:51 -0500
Received: by mail-pl1-f193.google.com with SMTP id r14so670841pls.12
        for <linux-kernel@vger.kernel.org>; Mon, 11 Feb 2019 10:26:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=55A1Tzpnb38ALuz/hEWQoAObFDG1vIZPV+qQfCUbDis=;
        b=Mj3mTK3ftEU3DUrMgeUXpNIZqsHZgLk5/z288iOCtUt/F37QuZN7yX8AqdjQK/3+z6
         Ll/qXwx7iEUTnKtO2m9WEumUT0VYhr8QJfACPOWTXfFCaOJ1FWILDFAVt3CqC5OLAWhF
         Q2oTfHeJb+5KZSHe3FyMzx+89xJnHsnw8AfBu5mGJ1hBXAs/qB4HNZley96iVaaClz3h
         CwREUkexHL8CbdtIVODUeW6IBnN96qJJb1yCpxj5IXKiqQCJBeAzyawqpRAmFTJsyqno
         ed0GlD/AO0zTzPMd4n/+n5LlOWCbB8qShv8Q66fAVkidPBmSYDkEq4HsTsIrZnoxY895
         zl7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=55A1Tzpnb38ALuz/hEWQoAObFDG1vIZPV+qQfCUbDis=;
        b=TwN5oqsm9uhcRVBXS1dvab7LGCEfWpksdpkNZeJhC0gJVs/8mpnTsFLRO2NJ7wiZkt
         JyyTdkNWRuWjIcZYzqLxW6WFKLJbKPnfFbzahlYA2dckYvQadW8RrMDOhDhjApaTP0kU
         DNINF9donAqTzwtFVIr5WIFQFybYWQY/YlYiJRmvMG7LBLK8q3/8JU/OAQyMQEZCoSLo
         7HO1RcLMQ6cW2/8K9Wtzw1OPMQ6/4/xx1tqQwkBO+4MbYE5ng+rEe/OCvcP4TASy8hU8
         7MlE1E7mIa83m8LJusHNZA+yIvgdfF6F8QCgeTL9JR5lM5H3U0gglC9w7Aq3sx2qlcoc
         +F4g==
X-Gm-Message-State: AHQUAubZfbVvBFsiJGpr0rixXEvseWipISCbvl+kU0Df/C36RZECbq2O
        R6LhFLlCqW4cztsrq3bhXfew9Q==
X-Google-Smtp-Source: AHgI3Ib7kX/6bDFMQPp7bF5muCAYEfNne0VIKtJCAfQT8s825HlnDnZfwmnsWqCX2++DlDx6SGgdfg==
X-Received: by 2002:a17:902:346:: with SMTP id 64mr39532911pld.337.1549909610274;
        Mon, 11 Feb 2019 10:26:50 -0800 (PST)
Received: from ziepe.ca (S010614cc2056d97f.ed.shawcable.net. [174.3.196.123])
        by smtp.gmail.com with ESMTPSA id q21sm23886969pfq.138.2019.02.11.10.26.49
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 11 Feb 2019 10:26:49 -0800 (PST)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1gtGI5-0007nw-0s; Mon, 11 Feb 2019 11:26:49 -0700
Date:   Mon, 11 Feb 2019 11:26:49 -0700
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Ira Weiny <ira.weiny@intel.com>
Cc:     Dan Williams <dan.j.williams@intel.com>, Jan Kara <jack@suse.cz>,
        Dave Chinner <david@fromorbit.com>,
        Christopher Lameter <cl@linux.com>,
        Doug Ledford <dledford@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        lsf-pc@lists.linux-foundation.org,
        linux-rdma <linux-rdma@vger.kernel.org>,
        Linux MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        John Hubbard <jhubbard@nvidia.com>,
        Jerome Glisse <jglisse@redhat.com>,
        Michal Hocko <mhocko@kernel.org>
Subject: Re: [LSF/MM TOPIC] Discuss least bad options for resolving
 longterm-GUP usage by RDMA
Message-ID: <20190211182649.GD24692@ziepe.ca>
References: <CAPcyv4hqya1iKCfHJRXQJRD4qXZa3VjkoKGw6tEvtWNkKVbP+A@mail.gmail.com>
 <bfe0fdd5400d41d223d8d30142f56a9c8efc033d.camel@redhat.com>
 <01000168c8e2de6b-9ab820ed-38ad-469c-b210-60fcff8ea81c-000000@email.amazonses.com>
 <20190208044302.GA20493@dastard>
 <20190208111028.GD6353@quack2.suse.cz>
 <CAPcyv4iVtBfO8zWZU3LZXLqv-dha1NSG+2+7MvgNy9TibCy4Cw@mail.gmail.com>
 <20190211102402.GF19029@quack2.suse.cz>
 <CAPcyv4iHso+PqAm-4NfF0svoK4mELJMSWNp+vsG43UaW1S2eew@mail.gmail.com>
 <20190211180654.GB24692@ziepe.ca>
 <20190211181921.GA5526@iweiny-DESK2.sc.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190211181921.GA5526@iweiny-DESK2.sc.intel.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 11, 2019 at 10:19:22AM -0800, Ira Weiny wrote:
> On Mon, Feb 11, 2019 at 11:06:54AM -0700, Jason Gunthorpe wrote:
> > On Mon, Feb 11, 2019 at 09:22:58AM -0800, Dan Williams wrote:
> > 
> > > I honestly don't like the idea that random subsystems can pin down
> > > file blocks as a side effect of gup on the result of mmap. Recall that
> > > it's not just RDMA that wants this guarantee. It seems safer to have
> > > the file be in an explicit block-allocation-immutable-mode so that the
> > > fallocate man page can describe this error case. Otherwise how would
> > > you describe the scenarios under which FALLOC_FL_PUNCH_HOLE fails?
> > 
> > I rather liked CL's version of this - ftruncate/etc is simply racing
> > with a parallel pwrite - and it doesn't fail.
> > 
> > But it also doesnt' trucate/create a hole. Another thread wrote to it
> > right away and the 'hole' was essentially instantly reallocated. This
> > is an inherent, pre-existing, race in the ftrucate/etc APIs.
> 
> I kind of like it as well, except Christopher did not answer my question:
> 
> What if user space then writes to the end of the file with a regular write?
> Does that write end up at the point they truncated to or off the end of the
> mmaped area (old length)?

IIRC it depends how the user does the write..

pwrite() with a given offset will write to that offset, re-extending
the file if needed

A file opened with O_APPEND and a write done with write() should
append to the new end

A normal file with a normal write should write to the FD's current
seek pointer.

I'm not sure what happens if you write via mmap/msync.

RDMA is similar to pwrite() and mmap.

> Or is it safe to consider all gup pinned pages this way?

O_DIRECT still has to work sensibly, and if you ftruncate something
that is currently being written with O_DIRECT it should behave the
same as if the CPU touched the mmap'd memory, IMHO.

The only real change here is that if there is a GUP then ftruncate/etc
races are always resolved as 'GUP user goes last' instead of randomly.

ftrunacte/etc already only work as you'd expect if the operator has
excluded writes. Otherwise blocks are instantly reallocated by another
racing thread. 

I'm not sure why RDMA should be so special to earn an error code ..

Jason
