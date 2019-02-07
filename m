Return-Path: <SRS0=4Txr=QO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83E23C282C4
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 06:00:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 466D021900
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 06:00:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=intel-com.20150623.gappssmtp.com header.i=@intel-com.20150623.gappssmtp.com header.b="oQHOz0Tn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726750AbfBGGAl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Feb 2019 01:00:41 -0500
Received: from mail-ot1-f65.google.com ([209.85.210.65]:42381 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726293AbfBGGAl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Feb 2019 01:00:41 -0500
Received: by mail-ot1-f65.google.com with SMTP id v23so16341775otk.9
        for <linux-kernel@vger.kernel.org>; Wed, 06 Feb 2019 22:00:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=t9UI+A00WyCBHTuJak4tgcvwsNu71LzDt60tTRTPY0A=;
        b=oQHOz0Tnlril3AwK5Unqi0VM6aPU9bTLvHWpWghCYBwK/OJrCtGFj1Wvim7OFpDg+e
         bV8KSViCCSqTSTstJPAI1X2yucKNMhPKWwMqM9fCFdC6pP7lf7+Lqk9TRX3G4fq1eaxX
         FlP0n5eOElFNVno82wUYgzzyZCiatHllVlcAjAg34ITBSwkhc6+5M6MSVmlpFWPFTFNj
         ezoUQ+TwcUmcnzO/zOLfV4XAjhHpbeVt5H00sabPDgLrdcLHDF8NtVgdhr015eSU1Y1K
         41DodgHK68xC6QMboiqvxuXYRvAa8ND3ZbwTu0I7SJjCndqMHYdq95JqOMM5gy3lEpgx
         QmqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=t9UI+A00WyCBHTuJak4tgcvwsNu71LzDt60tTRTPY0A=;
        b=MYLSw7qi86YeucHetKpTltfl3vXgjfPms3SRF0hZ7VhA+7k0E9yEmuDwzQLEdK+U4g
         Z6s/8g59GisK3iYN1I3WsXJ354TcmJ/YYtKxsfDQnrjZ/H9fJ6TdF/ixifxWSRFI+9Vz
         z96F+8bjw4hSGMw+QjTf5CZ5uHT2q1PZ2yt/C5Tqjp7xoemrucpmS1szwEHbNIPQ3laW
         VVn0BMCA+cVahpxZ2bzAJp+1pcCTM03g6o2bUsvAYpt5V6YPXkTkZq3/NvB77RWp5LwV
         Kb6vHX6+eXgkmMX50RmUZm53OipHVH0uN9neyLkSfEuqzbwVKbtCI+UUUtcZrRyeayCh
         X1HA==
X-Gm-Message-State: AHQUAubthCagc/OmfBsFgNOZm4hgGq9Tzw8viZUDJZz7zFSp0AMGQvUL
        m45DuDsRuZfaM1QL9DryTZHcrWXCy8/eo6D63GXpyg==
X-Google-Smtp-Source: AHgI3Ibz0usX0602tfRkv65vvYAyNDRgDuO1huqythSJRGlFE4EHhd5l9sJPZMNUtcteuZQRKCt93W27liyqGJ+I8cc=
X-Received: by 2002:a9d:7493:: with SMTP id t19mr3917392otk.98.1549519239700;
 Wed, 06 Feb 2019 22:00:39 -0800 (PST)
MIME-Version: 1.0
References: <20190205175059.GB21617@iweiny-DESK2.sc.intel.com>
 <20190206095000.GA12006@quack2.suse.cz> <20190206173114.GB12227@ziepe.ca>
 <20190206175233.GN21860@bombadil.infradead.org> <47820c4d696aee41225854071ec73373a273fd4a.camel@redhat.com>
 <01000168c43d594c-7979fcf8-b9c1-4bda-b29a-500efe001d66-000000@email.amazonses.com>
 <20190206210356.GZ6173@dastard> <20190206220828.GJ12227@ziepe.ca>
 <0c868bc615a60c44d618fb0183fcbe0c418c7c83.camel@redhat.com>
 <20190207035258.GD6173@dastard> <20190207052310.GA22726@ziepe.ca>
In-Reply-To: <20190207052310.GA22726@ziepe.ca>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Wed, 6 Feb 2019 22:00:28 -0800
Message-ID: <CAPcyv4jd4gxvt3faYYRbv5gkc6NGOKjY_Z-P0Ph=ss=gWZw7sA@mail.gmail.com>
Subject: Re: [LSF/MM TOPIC] Discuss least bad options for resolving
 longterm-GUP usage by RDMA
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     Dave Chinner <david@fromorbit.com>,
        Doug Ledford <dledford@redhat.com>,
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

On Wed, Feb 6, 2019 at 9:23 PM Jason Gunthorpe <jgg@ziepe.ca> wrote:
>
> On Thu, Feb 07, 2019 at 02:52:58PM +1100, Dave Chinner wrote:
> > On Wed, Feb 06, 2019 at 05:24:50PM -0500, Doug Ledford wrote:
> > > On Wed, 2019-02-06 at 15:08 -0700, Jason Gunthorpe wrote:
> > > > On Thu, Feb 07, 2019 at 08:03:56AM +1100, Dave Chinner wrote:
> > > > > On Wed, Feb 06, 2019 at 07:16:21PM +0000, Christopher Lameter wrote:
> > > > > > On Wed, 6 Feb 2019, Doug Ledford wrote:
> > > > > >
> > > > > > > > Most of the cases we want revoke for are things like truncate().
> > > > > > > > Shouldn't happen with a sane system, but we're trying to avoid users
> > > > > > > > doing awful things like being able to DMA to pages that are now part of
> > > > > > > > a different file.
> > > > > > >
> > > > > > > Why is the solution revoke then?  Is there something besides truncate
> > > > > > > that we have to worry about?  I ask because EBUSY is not currently
> > > > > > > listed as a return value of truncate, so extending the API to include
> > > > > > > EBUSY to mean "this file has pinned pages that can not be freed" is not
> > > > > > > (or should not be) totally out of the question.
> > > > > > >
> > > > > > > Admittedly, I'm coming in late to this conversation, but did I miss the
> > > > > > > portion where that alternative was ruled out?
> > > > > >
> > > > > > Coming in late here too but isnt the only DAX case that we are concerned
> > > > > > about where there was an mmap with the O_DAX option to do direct write
> > > > > > though? If we only allow this use case then we may not have to worry about
> > > > > > long term GUP because DAX mapped files will stay in the physical location
> > > > > > regardless.
> > > > >
> > > > > No, that is not guaranteed. Soon as we have reflink support on XFS,
> > > > > writes will physically move the data to a new physical location.
> > > > > This is non-negotiatiable, and cannot be blocked forever by a gup
> > > > > pin.
> > > > >
> > > > > IOWs, DAX on RDMA requires a) page fault capable hardware so that
> > > > > the filesystem can move data physically on write access, and b)
> > > > > revokable file leases so that the filesystem can kick userspace out
> > > > > of the way when it needs to.
> > > >
> > > > Why do we need both? You want to have leases for normal CPU mmaps too?
> >
> > We don't need them for normal CPU mmaps because that's locally
> > addressable page fault capable hardware. i.e. if we need to
> > serialise something, we just use kernel locks, etc. When it's a
> > remote entity (such as RDMA) we have to get that remote entity to
> > release it's reference/access so the kernel has exclusive access
> > to the resource it needs to act on.
>
> Why can't DAX follow the path of GPU? Jerome has been working on
> patches that let GPU do page migrations and other activities and
> maintain full sync with ODP MRs.
>
> I don't know of a reason why DAX migration would be different from GPU
> migration.

I don't think we need leases in the ODP case.

> The ODP RDMA HW does support halting RDMA access and interrupting the
> CPU to re-establish access, so you can get your locks/etc as. With
> today's implemetnation DAX has to trigger all the needed MM notifier
> call backs to make this work. Tomorrow it will have to interact with
> the HMM mirror API.
>
> Jerome is already demoing this for the GPU case, so the RDMA ODP HW is
> fine.
>
> Is DAX migration different in some way from GPU's migration that it
> can't use this flow and needs a lease to??? This would be a big
> surprise to me.

Agree, I see no need for leases in the ODP case the mmu_notifier is
already fulfilling the same role as a lease notification.

> > If your argument is that "existing RDMA apps don't have a recall
> > mechanism" then that's what they are going to need to implement to
> > work with DAX+RDMA. Reliable remote access arbitration is required
> > for DAX+RDMA, regardless of what filesysetm the data is hosted on.
>
> My argument is that is a toy configuration that no production user
> would use. It either has the ability to wait for the lease to revoke
> 'forever' without consequence or the application will be critically
> de-stablized by the kernel's escalation to time bound the response.
> (or production systems never get revoke)

I think we're off track on the need for leases for anything other than
non-ODP hardware.

Otherwise this argument seems to be saying there is absolutely no safe
way to recall a memory registration from hardware, which does not make
sense because SIGKILL needs to work as a last resort.

> > Anything less is a potential security hole.
>
> How does it get to a security hole? Obviously the pages under DMA
> can't be re-used for anything..

Writes to storage outside the security domain they were intended due
to the filesystem reallocating the physical blocks.

> > Once we have reflink on DAX, somebody is going to ask for
> > no-compromise RDMA support on these filesystems (e.g. NFSv4 file
> > server on pmem/FS-DAX that allows server side clones and clients use
> > RDMA access) and we're going to have to work out how to support it.
> > Rather than shouting at the messenger (XFS) that reports the hard
> > problems we have to solve, how about we work out exactly what we
> > need to do to support this functionality because it is coming and
> > people want it.
>
> I've thought this was basically solved - use ODP and you get full
> functionality.  Until you just now brought up the idea that ODP is
> not enough..

I think that was a misunderstanding, I struggle to see how a driver
that agrees to be bound by mmu notifications (ODP) has any problems
with anything the filesystem wants to do with the mapping. My
assumption is that ODP == filesystem can invalidate mappings at will
and all is good.

> The arguing here is that there is certainly a subset of people that
> don't want to use ODP. If we tell them a hard 'no' then the
> conversation is done.

Again, SIGKILL must work the RDMA target can't survive that, so it's
not impossible, or are you saying not even SIGKILL can guarantee an
RDMA registration goes idle? Then I can see that "hard no" having real
teeth otherwise it's a matter of software.

> Otherwise, I like the idea of telling them to use a less featureful
> XFS configuration that is 'safe' for non-ODP cases. The kernel has a
> long history of catering to certain configurations by limiting
> functionality or performance.

That's an unsustainable maintenance burden for the filesystem, just
keep the status quo of failing the registration at that point or
requiring a filesystem to not be used.

> I don't like the idea of building toy leases just for this one,
> arguably baroque, case.

What makes it a toy and baroque? Outside of RDMA registrations being
irretrievable I have a gap in my understanding of what makes this
pointless to even attempt?

> > Requiring ODP capable hardware and applications that control RDMA
> > access to use file leases and be able to cancel/recall client side
> > delegations (like NFS is already able to do!) seems like a pretty
>
> So, what happens on NFS if the revoke takes too long?
>
> Jason
