Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB8D7C169C4
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 21:10:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 94BAC214DA
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 21:10:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="UP6aQIvZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727281AbfBKVJ7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 16:09:59 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:35394 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726177AbfBKVJ7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 16:09:59 -0500
Received: by mail-pg1-f195.google.com with SMTP id s198so151145pgs.2
        for <linux-kernel@vger.kernel.org>; Mon, 11 Feb 2019 13:09:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=jaq4bJN1qOEXyuMZs7wye4duFdAYcvHrSM8nzJ3aR2Y=;
        b=UP6aQIvZmYiway7xzIgJzuIWXK4W48+TLF0JTke857tZ/pIM7SmP1S60I4O5T7XUQs
         sDVaxnZPHxkGwRokhN95UYV7DGKXLE2zZ2ir7Iy1I5HLwleo9q8B9a60DSARBC8sYAn0
         G45Rte8IxbVnsIsRmsxaB318I9Nfo+0ZKLtbweHoP5iev3mbg0SKHmUix5PSP6jdFB/k
         p9XST+tFajeg3fnQJdzheDATzcj+db/tTvXCyS25fR0oQYq4A17FFHN9ZICkZeGndgmP
         L2NkVYdD1vGBSwdon1iPwrccgVXz5EEQw/9EdbaVQKjc1oyQdQLKQJPsnqLvnzeHX3bd
         GcZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=jaq4bJN1qOEXyuMZs7wye4duFdAYcvHrSM8nzJ3aR2Y=;
        b=dZgz3X7x8FSlVphiuhiYrkiKikzN5ScDUqDDNWUcJNlHFW6kRZEYpGRdCIwUvMI04+
         Rdh7hIExGYEAQ7b8HRs0+zojQJ9tDvU0jiS5T0P9KAEkUOX2TPQM9IRuqF2/x2Mdxlb9
         F80cFKpiBQ38cbjdnxO8JXSFhJhPg/7mmuZ7EbiuBcIn9tsnRCm5yAMGKdd3B6SHC4Zm
         5t11LA6pQv0Akp5cY63I6Qd/F8Wexf4cggneiZm9/sp7gcV2YdlCF06ufkFrh8eQlatS
         hooxW8/ymnQktnr+RKv4uDvtI5LfobkRqizT1/0qjsnDSkl9bj+LVfvqTX+BOFQrN6dT
         eOAQ==
X-Gm-Message-State: AHQUAuaUTs13gc8Cfi/pVJSrJ8U0wVV1lYSw7dooofxH1WZroEtd50Y4
        VQ+Tcb3DkxLcba+TL1OLCMU7Eg==
X-Google-Smtp-Source: AHgI3IZKm0M/wcRUHr9Xw8s/w6oT/zo2vcfzmLBQDdDtuXEOedsgFDBvgoX7Gkg+Ip8nE+Sz4JWwqA==
X-Received: by 2002:a63:5861:: with SMTP id i33mr257286pgm.60.1549919398236;
        Mon, 11 Feb 2019 13:09:58 -0800 (PST)
Received: from ziepe.ca (S010614cc2056d97f.ed.shawcable.net. [174.3.196.123])
        by smtp.gmail.com with ESMTPSA id u66sm26188695pfi.115.2019.02.11.13.09.57
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 11 Feb 2019 13:09:57 -0800 (PST)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1gtIpw-00011F-TG; Mon, 11 Feb 2019 14:09:56 -0700
Date:   Mon, 11 Feb 2019 14:09:56 -0700
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     Matthew Wilcox <willy@infradead.org>,
        Ira Weiny <ira.weiny@intel.com>, Jan Kara <jack@suse.cz>,
        Dave Chinner <david@fromorbit.com>,
        Christopher Lameter <cl@linux.com>,
        Doug Ledford <dledford@redhat.com>,
        lsf-pc@lists.linux-foundation.org,
        linux-rdma <linux-rdma@vger.kernel.org>,
        Linux MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        John Hubbard <jhubbard@nvidia.com>,
        Jerome Glisse <jglisse@redhat.com>,
        Michal Hocko <mhocko@kernel.org>
Subject: Re: [LSF/MM TOPIC] Discuss least bad options for resolving
 longterm-GUP usage by RDMA
Message-ID: <20190211210956.GG24692@ziepe.ca>
References: <CAPcyv4iVtBfO8zWZU3LZXLqv-dha1NSG+2+7MvgNy9TibCy4Cw@mail.gmail.com>
 <20190211102402.GF19029@quack2.suse.cz>
 <CAPcyv4iHso+PqAm-4NfF0svoK4mELJMSWNp+vsG43UaW1S2eew@mail.gmail.com>
 <20190211180654.GB24692@ziepe.ca>
 <20190211181921.GA5526@iweiny-DESK2.sc.intel.com>
 <20190211182649.GD24692@ziepe.ca>
 <20190211184040.GF12668@bombadil.infradead.org>
 <CAPcyv4j71WZiXWjMPtDJidAqQiBcHUbcX=+aw11eEQ5C6sA8hQ@mail.gmail.com>
 <20190211204945.GF24692@ziepe.ca>
 <CAPcyv4jHjeJxmHMyrbRhg9oeaLK5WbZm-qu1HywjY7bF2DwiDg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPcyv4jHjeJxmHMyrbRhg9oeaLK5WbZm-qu1HywjY7bF2DwiDg@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 11, 2019 at 01:02:37PM -0800, Dan Williams wrote:
> On Mon, Feb 11, 2019 at 12:49 PM Jason Gunthorpe <jgg@ziepe.ca> wrote:
> >
> > On Mon, Feb 11, 2019 at 11:58:47AM -0800, Dan Williams wrote:
> > > On Mon, Feb 11, 2019 at 10:40 AM Matthew Wilcox <willy@infradead.org> wrote:
> > > >
> > > > On Mon, Feb 11, 2019 at 11:26:49AM -0700, Jason Gunthorpe wrote:
> > > > > On Mon, Feb 11, 2019 at 10:19:22AM -0800, Ira Weiny wrote:
> > > > > > What if user space then writes to the end of the file with a regular write?
> > > > > > Does that write end up at the point they truncated to or off the end of the
> > > > > > mmaped area (old length)?
> > > > >
> > > > > IIRC it depends how the user does the write..
> > > > >
> > > > > pwrite() with a given offset will write to that offset, re-extending
> > > > > the file if needed
> > > > >
> > > > > A file opened with O_APPEND and a write done with write() should
> > > > > append to the new end
> > > > >
> > > > > A normal file with a normal write should write to the FD's current
> > > > > seek pointer.
> > > > >
> > > > > I'm not sure what happens if you write via mmap/msync.
> > > > >
> > > > > RDMA is similar to pwrite() and mmap.
> > > >
> > > > A pertinent point that you didn't mention is that ftruncate() does not change
> > > > the file offset.  So there's no user-visible change in behaviour.
> > >
> > > ...but there is. The blocks you thought you freed, especially if the
> > > system was under -ENOSPC pressure, won't actually be free after the
> > > successful ftruncate().
> >
> > They won't be free after something dirties the existing mmap either.
> >
> > Blocks also won't be free if you unlink a file that is currently still
> > open.
> >
> > This isn't really new behavior for a FS.
> 
> An mmap write after a fault due to a hole punch is free to trigger
> SIGBUS if the subsequent page allocation fails.

Isn't that already racy? If the mmap user is fast enough can't it
prevent the page from becoming freed in the first place today?

Jason
