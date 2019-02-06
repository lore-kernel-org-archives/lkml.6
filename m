Return-Path: <SRS0=01Bl=QN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D751C169C4
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 22:45:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4073E218D9
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 22:45:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=intel-com.20150623.gappssmtp.com header.i=@intel-com.20150623.gappssmtp.com header.b="de2N2G/e"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726610AbfBFWo6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Feb 2019 17:44:58 -0500
Received: from mail-ot1-f68.google.com ([209.85.210.68]:34106 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726162AbfBFWo6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Feb 2019 17:44:58 -0500
Received: by mail-ot1-f68.google.com with SMTP id t5so15060180otk.1
        for <linux-kernel@vger.kernel.org>; Wed, 06 Feb 2019 14:44:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=XFjuZa9EThrf5IvV1ixPwSd23JzyLsLNT9vnOAew2W4=;
        b=de2N2G/e5D0ca+8pvHpuRPjzFS+xczhbc4gjFlLDeG+zHj5jeybV5BI2FThr9cCOi+
         Es8lMPUqE3qO/Q+rfdxbneHCzSbtUOSbUKNEfBjFqUsM1xil9/ghFzFuuO/XreIj/B0O
         /xJPF4t+KhQtfooLNJm8u04S3FyUIsPdEz9QZMk+K1Ac7i7vDyXSCPpLh70pWfglQ0Vc
         vpbwFExoR7z9gG16NCYq26SmTV/YYq4/xh6l0ucsxxw/qqx0GXu3ruoRdbpvwE30Za9Q
         mUTouzI2T5XXN/omdeUmJb5MuSINfEaySOrDJZ9LPhIKljIm4NzFe4ETNRC7fK6Rt+m4
         JAjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XFjuZa9EThrf5IvV1ixPwSd23JzyLsLNT9vnOAew2W4=;
        b=H1znsvXdc+bWE3D/0nC9dVt0SANNEjGe5ix9ezKJ7qBR1K/y+S5PwCRVdgQFscDVQb
         3i7JxoiUcYhhiJxjLvand8iQBkWGILHdA8W4+P7XiyIXzNkuBffKPx4hBOK/6Oee33Qq
         F2S3p0YM6WzRDUuOdylhbGwMU81d+kUuon+dmeclA/J45Ym9bQwmWycPMWSz5vemmtpl
         tWggFEI/Or4pI5oJUQ+AHWOUfnMHv81MwjOvC8ewyxHZ1ON7rzJx0fHjS/FKTJIuFrhY
         we2O30tPIEHjE+BrXaHZMQ5XbO+wHdWKUL8sfSQA6ZcjybgSRjXVsYICMjzqMWRcsU8U
         CdfQ==
X-Gm-Message-State: AHQUAuYEnyYNeI0u1kXuR1felxhFB2LCQW8p8Kw5Zr3rpWy3EJWOymHI
        maW9Yzl6SGGNnsdQaUvFInwNesQzM+1KbxaC8wxXqg==
X-Google-Smtp-Source: AHgI3IZ1IoWGhI2GcwS/xdNJ+ERSkJIEi64BzN6fZt2VHpDtwTv+/PUM2OnQJC74i1O2ufPzFTXDcK9IOXicacFZeMg=
X-Received: by 2002:aca:ecc7:: with SMTP id k190mr935462oih.0.1549493096761;
 Wed, 06 Feb 2019 14:44:56 -0800 (PST)
MIME-Version: 1.0
References: <20190205175059.GB21617@iweiny-DESK2.sc.intel.com>
 <20190206095000.GA12006@quack2.suse.cz> <20190206173114.GB12227@ziepe.ca>
 <20190206175233.GN21860@bombadil.infradead.org> <47820c4d696aee41225854071ec73373a273fd4a.camel@redhat.com>
 <01000168c43d594c-7979fcf8-b9c1-4bda-b29a-500efe001d66-000000@email.amazonses.com>
 <20190206210356.GZ6173@dastard> <20190206220828.GJ12227@ziepe.ca> <0c868bc615a60c44d618fb0183fcbe0c418c7c83.camel@redhat.com>
In-Reply-To: <0c868bc615a60c44d618fb0183fcbe0c418c7c83.camel@redhat.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Wed, 6 Feb 2019 14:44:45 -0800
Message-ID: <CAPcyv4hqya1iKCfHJRXQJRD4qXZa3VjkoKGw6tEvtWNkKVbP+A@mail.gmail.com>
Subject: Re: [LSF/MM TOPIC] Discuss least bad options for resolving
 longterm-GUP usage by RDMA
To:     Doug Ledford <dledford@redhat.com>
Cc:     Jason Gunthorpe <jgg@ziepe.ca>, Dave Chinner <david@fromorbit.com>,
        Christopher Lameter <cl@linux.com>,
        Matthew Wilcox <willy@infradead.org>, Jan Kara <jack@suse.cz>,
        Ira Weiny <ira.weiny@intel.com>,
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

On Wed, Feb 6, 2019 at 2:25 PM Doug Ledford <dledford@redhat.com> wrote:
>
> On Wed, 2019-02-06 at 15:08 -0700, Jason Gunthorpe wrote:
> > On Thu, Feb 07, 2019 at 08:03:56AM +1100, Dave Chinner wrote:
> > > On Wed, Feb 06, 2019 at 07:16:21PM +0000, Christopher Lameter wrote:
> > > > On Wed, 6 Feb 2019, Doug Ledford wrote:
> > > >
> > > > > > Most of the cases we want revoke for are things like truncate().
> > > > > > Shouldn't happen with a sane system, but we're trying to avoid users
> > > > > > doing awful things like being able to DMA to pages that are now part of
> > > > > > a different file.
> > > > >
> > > > > Why is the solution revoke then?  Is there something besides truncate
> > > > > that we have to worry about?  I ask because EBUSY is not currently
> > > > > listed as a return value of truncate, so extending the API to include
> > > > > EBUSY to mean "this file has pinned pages that can not be freed" is not
> > > > > (or should not be) totally out of the question.
> > > > >
> > > > > Admittedly, I'm coming in late to this conversation, but did I miss the
> > > > > portion where that alternative was ruled out?
> > > >
> > > > Coming in late here too but isnt the only DAX case that we are concerned
> > > > about where there was an mmap with the O_DAX option to do direct write
> > > > though? If we only allow this use case then we may not have to worry about
> > > > long term GUP because DAX mapped files will stay in the physical location
> > > > regardless.
> > >
> > > No, that is not guaranteed. Soon as we have reflink support on XFS,
> > > writes will physically move the data to a new physical location.
> > > This is non-negotiatiable, and cannot be blocked forever by a gup
> > > pin.
> > >
> > > IOWs, DAX on RDMA requires a) page fault capable hardware so that
> > > the filesystem can move data physically on write access, and b)
> > > revokable file leases so that the filesystem can kick userspace out
> > > of the way when it needs to.
> >
> > Why do we need both? You want to have leases for normal CPU mmaps too?
> >
> > > Truncate is a red herring. It's definitely a case for revokable
> > > leases, but it's the rare case rather than the one we actually care
> > > about. We really care about making copy-on-write capable filesystems like
> > > XFS work with DAX (we've got people asking for it to be supported
> > > yesterday!), and that means DAX+RDMA needs to work with storage that
> > > can change physical location at any time.
> >
> > Then we must continue to ban longterm pin with DAX..
> >
> > Nobody is going to want to deploy a system where revoke can happen at
> > any time and if you don't respond fast enough your system either locks
> > with some kind of FS meltdown or your process gets SIGKILL.
> >
> > I don't really see a reason to invest so much design work into
> > something that isn't production worthy.
> >
> > It *almost* made sense with ftruncate, because you could architect to
> > avoid ftruncate.. But just any FS op might reallocate? Naw.
> >
> > Dave, you said the FS is responsible to arbitrate access to the
> > physical pages..
> >
> > Is it possible to have a filesystem for DAX that is more suited to
> > this environment? Ie designed to not require block reallocation (no
> > COW, no reflinks, different approach to ftruncate, etc)
>
> Can someone give me a real world scenario that someone is *actually*
> asking for with this?

I'll point to this example. At the 6:35 mark Kodi talks about the
Oracle use case for DAX + RDMA.

https://youtu.be/ywKPPIE8JfQ?t=395

Currently the only way to get this to work is to use ODP capable
hardware, or Device-DAX. Device-DAX is a facility to map persistent
memory statically through device-file. It's great for statically
allocated use cases, but loses all the nice things (provisioning,
permissions, naming) that a filesystem gives you. This debate is what
to do about non-ODP capable hardware and Filesystem-DAX facility. The
current answer is "no RDMA for you".

> Are DAX users demanding xfs, or is it just the
> filesystem of convenience?

xfs is the only Linux filesystem that supports DAX and reflink.

> Do they need to stick with xfs?

Can you clarify the motivation for that question? This problem exists
for any filesystem that implements an mmap that where the physical
page backing the mapping is identical to the physical storage location
for the file data. I don't see it as an xfs specific problem. Rather,
xfs is taking the lead in this space because it has already deployed
and demonstrated that leases work for the pnfs4 block-server case, so
it seems logical to attempt to extend that case for non-ODP-RDMA.

> Are they
> really trying to do COW backed mappings for the RDMA targets?  Or do
> they want a COW backed FS but are perfectly happy if the specific RDMA
> targets are *not* COW and are statically allocated?

I would expect the COW to be broken at registration time. Only ODP
could possibly support reflink + RDMA. So I think this devolves the
problem back to just the "what to do about truncate/punch-hole"
problem in the specific case of non-ODP hardware combined with the
Filesystem-DAX facility.
