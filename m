Return-Path: <SRS0=01Bl=QN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B196AC169C4
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 22:08:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 75EC6218E0
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 22:08:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="UjACPc/7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726645AbfBFWIb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Feb 2019 17:08:31 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:47062 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726393AbfBFWIa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Feb 2019 17:08:30 -0500
Received: by mail-pg1-f193.google.com with SMTP id w7so3530330pgp.13
        for <linux-kernel@vger.kernel.org>; Wed, 06 Feb 2019 14:08:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=KJwz5D7Q6Dz66NllUORQ/Snomm0KllaaPa/yLCdCQ6s=;
        b=UjACPc/7YocMeD76XYauB6nZ6RDa63UossHuaJ+0TIiKgho/ArpyBlacPPqsZLrNnT
         KnHqLhX8P3aJV8864C9Tt9DI58/184m0jfEFnmLrRvW40Nd86trk3aJ53qkD/bG6gYfh
         IJNio6AyjA6beSbJRPDCSPJ3tMdw7zgulCBAcso4hIw5ocsapg0AumKahiqQVn9xRJYZ
         JQnQLAE5mrdKolFzsQNwfnkQmj4pz6yIiPtguPt+v8g1qFK7im9gyqoQU/XE4iHnxnR7
         YDF4R60zWNu45I8qSRhVYXW0+h+NNHSoJDCLQ4cciOYgXWXrt7gBPQVyio/gcxVZZQaZ
         OrNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=KJwz5D7Q6Dz66NllUORQ/Snomm0KllaaPa/yLCdCQ6s=;
        b=VTYy8URxudDzNtlJB31KpywRO4x5UjmhHOfvHBY0LON8hPhYnaYd0p7ah9wTvaSFFA
         tAxyfTvP1EhuHIje6F1DK4iwJbcR7vZljj2m9QR2zi5kRo4Fykhj3WpbyOPvzgchT1z5
         mmqownjcyJzN3aB9o6xjvgFnH+kbot/s8IMYaETh6twv5iA8WpcEDF1rZdC345ik77cC
         dhUkbWIluhduu+A3Snd/6KfoWcsPxnudtlLVBeXWcCT3CKqitMdk12cFnyEuIuyyjeWn
         f9ndbHKxLX5xiXDDAHEyasMd6ljpAWvvfEzA3kvLSP5VahMInTJ4G2FNRk+dMH0y2IoM
         6Skg==
X-Gm-Message-State: AHQUAuYOx7q5N75Rd6u6DfldHONHbGYImnqXFgknnU/Bh9nppgVmV6jf
        mHTmI7taeJ4Bb7UZRqwOV/mruQ==
X-Google-Smtp-Source: AHgI3IZ9sM2NemHPkXJcEytXog4mo9/7nqUOfJbzWrMCoEPFEnffuZ1BU2oh+A0ce2olQXr6DG07vw==
X-Received: by 2002:a63:ed03:: with SMTP id d3mr11531445pgi.275.1549490909681;
        Wed, 06 Feb 2019 14:08:29 -0800 (PST)
Received: from ziepe.ca (S010614cc2056d97f.ed.shawcable.net. [174.3.196.123])
        by smtp.gmail.com with ESMTPSA id p24sm144065pfj.72.2019.02.06.14.08.28
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 06 Feb 2019 14:08:28 -0800 (PST)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1grVMq-0004ip-7P; Wed, 06 Feb 2019 15:08:28 -0700
Date:   Wed, 6 Feb 2019 15:08:28 -0700
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Dave Chinner <david@fromorbit.com>
Cc:     Christopher Lameter <cl@linux.com>,
        Doug Ledford <dledford@redhat.com>,
        Matthew Wilcox <willy@infradead.org>, Jan Kara <jack@suse.cz>,
        Ira Weiny <ira.weiny@intel.com>,
        lsf-pc@lists.linux-foundation.org, linux-rdma@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        John Hubbard <jhubbard@nvidia.com>,
        Jerome Glisse <jglisse@redhat.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Michal Hocko <mhocko@kernel.org>
Subject: Re: [LSF/MM TOPIC] Discuss least bad options for resolving
 longterm-GUP usage by RDMA
Message-ID: <20190206220828.GJ12227@ziepe.ca>
References: <20190205175059.GB21617@iweiny-DESK2.sc.intel.com>
 <20190206095000.GA12006@quack2.suse.cz>
 <20190206173114.GB12227@ziepe.ca>
 <20190206175233.GN21860@bombadil.infradead.org>
 <47820c4d696aee41225854071ec73373a273fd4a.camel@redhat.com>
 <01000168c43d594c-7979fcf8-b9c1-4bda-b29a-500efe001d66-000000@email.amazonses.com>
 <20190206210356.GZ6173@dastard>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190206210356.GZ6173@dastard>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 07, 2019 at 08:03:56AM +1100, Dave Chinner wrote:
> On Wed, Feb 06, 2019 at 07:16:21PM +0000, Christopher Lameter wrote:
> > On Wed, 6 Feb 2019, Doug Ledford wrote:
> > 
> > > > Most of the cases we want revoke for are things like truncate().
> > > > Shouldn't happen with a sane system, but we're trying to avoid users
> > > > doing awful things like being able to DMA to pages that are now part of
> > > > a different file.
> > >
> > > Why is the solution revoke then?  Is there something besides truncate
> > > that we have to worry about?  I ask because EBUSY is not currently
> > > listed as a return value of truncate, so extending the API to include
> > > EBUSY to mean "this file has pinned pages that can not be freed" is not
> > > (or should not be) totally out of the question.
> > >
> > > Admittedly, I'm coming in late to this conversation, but did I miss the
> > > portion where that alternative was ruled out?
> > 
> > Coming in late here too but isnt the only DAX case that we are concerned
> > about where there was an mmap with the O_DAX option to do direct write
> > though? If we only allow this use case then we may not have to worry about
> > long term GUP because DAX mapped files will stay in the physical location
> > regardless.
> 
> No, that is not guaranteed. Soon as we have reflink support on XFS,
> writes will physically move the data to a new physical location.
> This is non-negotiatiable, and cannot be blocked forever by a gup
> pin.
> 
> IOWs, DAX on RDMA requires a) page fault capable hardware so that
> the filesystem can move data physically on write access, and b)
> revokable file leases so that the filesystem can kick userspace out
> of the way when it needs to.

Why do we need both? You want to have leases for normal CPU mmaps too?

> Truncate is a red herring. It's definitely a case for revokable
> leases, but it's the rare case rather than the one we actually care
> about. We really care about making copy-on-write capable filesystems like
> XFS work with DAX (we've got people asking for it to be supported
> yesterday!), and that means DAX+RDMA needs to work with storage that
> can change physical location at any time.

Then we must continue to ban longterm pin with DAX..

Nobody is going to want to deploy a system where revoke can happen at
any time and if you don't respond fast enough your system either locks
with some kind of FS meltdown or your process gets SIGKILL. 

I don't really see a reason to invest so much design work into
something that isn't production worthy.

It *almost* made sense with ftruncate, because you could architect to
avoid ftruncate.. But just any FS op might reallocate? Naw.

Dave, you said the FS is responsible to arbitrate access to the
physical pages..

Is it possible to have a filesystem for DAX that is more suited to
this environment? Ie designed to not require block reallocation (no
COW, no reflinks, different approach to ftruncate, etc)

> And that's the real problem we need to solve here. RDMA has no trust
> model other than "I'm userspace, I pinned you, trust me!". That's
> not good enough for FS-DAX+RDMA....

It is baked into the silicon, and I don't see much motion on this
front right now. My best hope is that IOMMU PASID will get widely
deployed and RDMA silicon will arrive that can use it. Seems to be
years away, if at all.

At least we have one chip design that can work in a page faulting mode
..

Jason
