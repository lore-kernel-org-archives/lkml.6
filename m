Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B887C169C4
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 21:02:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 18DCF217D9
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 21:02:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=intel-com.20150623.gappssmtp.com header.i=@intel-com.20150623.gappssmtp.com header.b="hUIoym1j"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727170AbfBKVCu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 16:02:50 -0500
Received: from mail-ot1-f66.google.com ([209.85.210.66]:33449 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726140AbfBKVCt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 16:02:49 -0500
Received: by mail-ot1-f66.google.com with SMTP id i20so672537otl.0
        for <linux-kernel@vger.kernel.org>; Mon, 11 Feb 2019 13:02:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ue3vXSU/Uyn4dHhRrNll0Xk0Xsd0Oc1wTjLcVxg/RVU=;
        b=hUIoym1jWomz+hQ3cjra7vbu8N5t4Hnlg+PAqHz9/FbJkw5AbL1Sv33KOuBzmBGiuw
         XFTkiY3/ijZ6462k6DJrU7QYA9Vd5lttHeHLC0g1iQcLlLS7j/vcZPHVAConzOdMRrvy
         n2QpK6+M5qBuH4QcCR04be/KEWKPeslapu3m3t0isgfrskGI8tLy1kqohwuqEFTvJPE3
         X1sCVWaUU0De1pZLAqvjBRCwaa7k+YeoI3EnJv4AYoa5NNEY1d7gCQSUmQsO2WEgstLP
         ac5rNKg/bs0GU3zUFz0Eq9XUOeFF4D8Di2ts/s5d0y6iESwJXdZbWcfvbwU4Nt0K7Oin
         LCmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ue3vXSU/Uyn4dHhRrNll0Xk0Xsd0Oc1wTjLcVxg/RVU=;
        b=buoVHzb4MwfonOXT2XLd1wFjPDWpUG/A44BP0e/9YkgqPUSsMjcE0l5n7rbPyQyuAk
         aOxuz3Mvs3OEixLiDe9YxfEgwT3bOUENS1JXkmDmeyYG8Sw3BEDjhNaReqyQj+bSQjUc
         f/UTYtUyZFWGeFkMFb1M5hAgdor+tCSYZLYw0LtNBGqKraVbukdsoe1qZwTXNtfAEwDm
         Z9s70tvSf4zYb6ewoai54/i8G6nNJEGbBc0W9uxn+kJEKas3N7opURTwMy85GKj7byKJ
         LqBqrohItGi9rQ2jr/+9EloYNnFfnvwOIlxHPFVQVM6tg0iGi9LvQjeqqB6ekd75Vnph
         eq2g==
X-Gm-Message-State: AHQUAuburxX6v5OAkipWt9NKHSF5bDEequ6Aiz3mhQRLCPvDlpZooBq6
        sSkVvZxZVqgmd0SrSUxWY9dhTgwaqqWl+rbxYGBdag==
X-Google-Smtp-Source: AHgI3IZxeqNTfWgs9o1UN4GAPAtcCJWm5QBYZL8PcXZdv7fUAGZtHzMZB4bxYkGrLKUuX0CWjIpxvAiXIcKohnPhirs=
X-Received: by 2002:a9d:6a50:: with SMTP id h16mr169743otn.95.1549918968592;
 Mon, 11 Feb 2019 13:02:48 -0800 (PST)
MIME-Version: 1.0
References: <20190208044302.GA20493@dastard> <20190208111028.GD6353@quack2.suse.cz>
 <CAPcyv4iVtBfO8zWZU3LZXLqv-dha1NSG+2+7MvgNy9TibCy4Cw@mail.gmail.com>
 <20190211102402.GF19029@quack2.suse.cz> <CAPcyv4iHso+PqAm-4NfF0svoK4mELJMSWNp+vsG43UaW1S2eew@mail.gmail.com>
 <20190211180654.GB24692@ziepe.ca> <20190211181921.GA5526@iweiny-DESK2.sc.intel.com>
 <20190211182649.GD24692@ziepe.ca> <20190211184040.GF12668@bombadil.infradead.org>
 <CAPcyv4j71WZiXWjMPtDJidAqQiBcHUbcX=+aw11eEQ5C6sA8hQ@mail.gmail.com> <20190211204945.GF24692@ziepe.ca>
In-Reply-To: <20190211204945.GF24692@ziepe.ca>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Mon, 11 Feb 2019 13:02:37 -0800
Message-ID: <CAPcyv4jHjeJxmHMyrbRhg9oeaLK5WbZm-qu1HywjY7bF2DwiDg@mail.gmail.com>
Subject: Re: [LSF/MM TOPIC] Discuss least bad options for resolving
 longterm-GUP usage by RDMA
To:     Jason Gunthorpe <jgg@ziepe.ca>
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
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 11, 2019 at 12:49 PM Jason Gunthorpe <jgg@ziepe.ca> wrote:
>
> On Mon, Feb 11, 2019 at 11:58:47AM -0800, Dan Williams wrote:
> > On Mon, Feb 11, 2019 at 10:40 AM Matthew Wilcox <willy@infradead.org> wrote:
> > >
> > > On Mon, Feb 11, 2019 at 11:26:49AM -0700, Jason Gunthorpe wrote:
> > > > On Mon, Feb 11, 2019 at 10:19:22AM -0800, Ira Weiny wrote:
> > > > > What if user space then writes to the end of the file with a regular write?
> > > > > Does that write end up at the point they truncated to or off the end of the
> > > > > mmaped area (old length)?
> > > >
> > > > IIRC it depends how the user does the write..
> > > >
> > > > pwrite() with a given offset will write to that offset, re-extending
> > > > the file if needed
> > > >
> > > > A file opened with O_APPEND and a write done with write() should
> > > > append to the new end
> > > >
> > > > A normal file with a normal write should write to the FD's current
> > > > seek pointer.
> > > >
> > > > I'm not sure what happens if you write via mmap/msync.
> > > >
> > > > RDMA is similar to pwrite() and mmap.
> > >
> > > A pertinent point that you didn't mention is that ftruncate() does not change
> > > the file offset.  So there's no user-visible change in behaviour.
> >
> > ...but there is. The blocks you thought you freed, especially if the
> > system was under -ENOSPC pressure, won't actually be free after the
> > successful ftruncate().
>
> They won't be free after something dirties the existing mmap either.
>
> Blocks also won't be free if you unlink a file that is currently still
> open.
>
> This isn't really new behavior for a FS.

An mmap write after a fault due to a hole punch is free to trigger
SIGBUS if the subsequent page allocation fails. So no, I don't see
them as the same unless you're allowing for the holder of the MR to
receive a re-fault failure.
