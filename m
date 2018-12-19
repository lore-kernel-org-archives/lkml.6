Return-Path: <SRS0=MnXf=O4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50FACC43387
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 16:56:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 22067218F0
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 16:56:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="nnO+dp+W"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730171AbeLSQ4c (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Dec 2018 11:56:32 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:38925 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727544AbeLSQ4b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Dec 2018 11:56:31 -0500
Received: by mail-pl1-f194.google.com with SMTP id 101so9733749pld.6
        for <linux-kernel@vger.kernel.org>; Wed, 19 Dec 2018 08:56:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=q2ENu9tGDYJty8ZA/Cj+ZNe+v4X1aPZJ2b1Kv0BT43U=;
        b=nnO+dp+WpEHnLHJHNjpAHuwMTD+TdPlzGMmRfUq8S567C66T0slsGKgCuXF9lvnZNI
         zvc9DcP9vsVYRTJgAvrzblddkubPVoszdi20spu248WlABMprDxwFX2L8oAgZgZGdNwP
         tGAEV3SgntMOHa4VDxeuDDR/SOhM7xNmpGjVbydh2K9P0Rs4xCnUz9yKxyUj8RxNJNq9
         tfnzgroOJAatrxsHaBzK2hLS8w0WBzKi9Uv0HxpmNvh9gtEY260oWmkJxw6Hs6/+/sZ0
         hTNIQRLk49etZP3/YjpmnGTUEk+1lVLTHgxBzESQkflSyCjfh2Phlh3kDlkdIUNwJfyK
         0PnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=q2ENu9tGDYJty8ZA/Cj+ZNe+v4X1aPZJ2b1Kv0BT43U=;
        b=VUwGweZpblFlX0bTdGfiLAO6sMlLol1aI6249KZ1znKA7EnDXfJB6PuGFxT9+ZHBue
         Xmvvmitoe6rwiN4ap+i3UHY5gZ5EO4cBCAW0lAFWAspxEzY3Bmc3vT9H1JwK5u2qnG0/
         Dwr2YMXT+IK4B9DOWtjHVvjXhtmJTiz7zs8YppgOXX6cYfqUWU4WOvDURgQvUdYfWQqf
         YrKAqSflK9P/85gwUucovSCDf9MPlV2vbODd/AEsOL1FA3SIDAmLLwcG7YN6wlHWxsfn
         MnFUmO/LemkSgY1v8kDuGribDnHChxnlBtvevy33qgR+raWH0g8hnZ5gSXsKjdDRa5J9
         NuEA==
X-Gm-Message-State: AA+aEWaAkdCA4D7nBR6CiqNtVXoWFz4SaL9IX0O3O+y5M7/CadwsyLA6
        mMb/IHNMSEyI/kQZjQ1OODbdGQ==
X-Google-Smtp-Source: AFSGD/XasNMp9fgrsGk8vqmq0gqR8ZEvxznGdL8lP5y47y0MxkN728ntYyLd5ijlMFPXg79yLpeirA==
X-Received: by 2002:a17:902:2a0a:: with SMTP id i10mr20570816plb.323.1545238590666;
        Wed, 19 Dec 2018 08:56:30 -0800 (PST)
Received: from ziepe.ca (S010614cc2056d97f.ed.shawcable.net. [174.3.196.123])
        by smtp.gmail.com with ESMTPSA id f67sm40863304pff.29.2018.12.19.08.56.29
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 19 Dec 2018 08:56:29 -0800 (PST)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1gZf92-0000m6-Ny; Wed, 19 Dec 2018 09:56:28 -0700
Date:   Wed, 19 Dec 2018 09:56:28 -0700
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Jan Kara <jack@suse.cz>
Cc:     Dave Chinner <david@fromorbit.com>,
        Jerome Glisse <jglisse@redhat.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Matthew Wilcox <willy@infradead.org>,
        Dan Williams <dan.j.williams@intel.com>,
        John Hubbard <john.hubbard@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux MM <linux-mm@kvack.org>, tom@talpey.com,
        Al Viro <viro@zeniv.linux.org.uk>, benve@cisco.com,
        Christoph Hellwig <hch@infradead.org>,
        Christopher Lameter <cl@linux.com>,
        "Dalessandro, Dennis" <dennis.dalessandro@intel.com>,
        Doug Ledford <dledford@redhat.com>,
        Michal Hocko <mhocko@kernel.org>, mike.marciniszyn@intel.com,
        rcampbell@nvidia.com,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH 1/2] mm: introduce put_user_page*(), placeholder versions
Message-ID: <20181219165628.GB30553@ziepe.ca>
References: <20181210102846.GC29289@quack2.suse.cz>
 <20181212150319.GA3432@redhat.com>
 <20181212214641.GB29416@dastard>
 <20181214154321.GF8896@quack2.suse.cz>
 <20181216215819.GC10644@dastard>
 <20181218103306.GC18032@quack2.suse.cz>
 <20181218234254.GC31274@dastard>
 <20181219030329.GI21992@ziepe.ca>
 <20181219102825.GN6311@dastard>
 <20181219113540.GC18345@quack2.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181219113540.GC18345@quack2.suse.cz>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 19, 2018 at 12:35:40PM +0100, Jan Kara wrote:
> On Wed 19-12-18 21:28:25, Dave Chinner wrote:
> > On Tue, Dec 18, 2018 at 08:03:29PM -0700, Jason Gunthorpe wrote:
> > > On Wed, Dec 19, 2018 at 10:42:54AM +1100, Dave Chinner wrote:
> > > 
> > > > Essentially, what we are talking about is how to handle broken
> > > > hardware. I say we should just brun it with napalm and thermite
> > > > (i.e. taint the kernel with "unsupportable hardware") and force
> > > > wait_for_stable_page() to trigger when there are GUP mappings if
> > > > the underlying storage doesn't already require it.
> > > 
> > > If you want to ban O_DIRECT/etc from writing to file backed pages,
> > > then just do it.
> > 
> > O_DIRECT IO *isn't the problem*.
> 
> That is not true. O_DIRECT IO is a problem. In some aspects it is
> easier than the problem with RDMA but currently O_DIRECT IO can
> crash your machine or corrupt data the same way RDMA can. Just the
> race window is much smaller. So we have to fix the generic GUP
> infrastructure to make O_DIRECT IO work. I agree that fixing RDMA
> will likely require even more work like revokable leases or what
> not.

This is what I've understood, talking to all the experts. Dave? Why do
you think O_DIRECT is actually OK?

I agree the duration issue with RDMA is different, but don't forget,
O_DIRECT goes out to the network too and has potentially very long
timeouts as well.

If O_DIRECT works fine then lets use the same approach in RDMA??

Jason
