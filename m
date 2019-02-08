Return-Path: <SRS0=VkHl=QP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 088CFC169C4
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 15:43:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BCFD820863
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 15:43:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="BHrq0QLK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728039AbfBHPnB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Feb 2019 10:43:01 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:37411 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728009AbfBHPm7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Feb 2019 10:42:59 -0500
Received: by mail-pf1-f194.google.com with SMTP id y126so1839914pfb.4
        for <linux-kernel@vger.kernel.org>; Fri, 08 Feb 2019 07:42:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ddQxupTFAevHfaAh0hqzJoxLrcUdGB63YejynzV9HiU=;
        b=BHrq0QLKY5n1Y5aDZ7iMo33tOtA3g2Vi7KZ7uZdzJH13IN2HrjwFaOgsgSrE61NBaq
         oobQPmZ9NmuDgcQAZ8+Gr056X53wyKf6IsgNzu/1L/4ds3UBXdpUYp6vboylmxtzYdtW
         p0seYcN4YSQzmY+PJybUbvwlbkA7m3zT6cjGU1HPshw8/xybC55FaVzL4vQHG2jgIUjn
         vRK0mwQVlKUen8TXhuOwa0lD7tl83VA8S4gV6qVMqLYVO7MOTdpHaS5xYWQR94tYzc1x
         wsXLNj9T/cUvWOV/Mk1m7DyoaWLXcisB8lJ7AOnNL+TLXr3ZQVkAYUd+UZrjV0NHbv/r
         bZKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ddQxupTFAevHfaAh0hqzJoxLrcUdGB63YejynzV9HiU=;
        b=mNg5BAUmPzZ+CtVE1owwY2wgwUeHtVtth7dT5oDSoFVzpqQEROLHr91W2SaumKN7es
         EkquQOzgUqyE983Po9910ETaQSGr8VRyefFZHLTB7/i59d1DGmLNjPwvi253BKS0p4xQ
         tta/nWsF44n2MP8EiC6VVMjPQC01VXL7XAz1MoOTWzK61lNkivEy6uUuI9PvVd7pWT2N
         n8dkxHBCMA4h9ak+fjmBe09L041H+v/IVUCUFKs7S3ApM+ql0jEA5aFZy1nbXtFRN89e
         fpKbh1fy8F3lDjWElVBvSNX4kX56WiOLSJ/GzT3H1+VCAaEY4f+FgeP+x6Kvk0X0EKCW
         djXg==
X-Gm-Message-State: AHQUAubW0QzaNFyz9i3L/MY51zfyauH96exu433xwP7m4M4VRleV/tFQ
        w4r7jhmxiBoKAF2X3pyYj7kUfA==
X-Google-Smtp-Source: AHgI3IYYNXcBGCuA3MjCFUqgpYJMzmKD2xQN2tI7pDUdvgLeHQRTXlmLbBhdILjWxskz9qKt6jsHAw==
X-Received: by 2002:a63:5723:: with SMTP id l35mr20308156pgb.228.1549640577944;
        Fri, 08 Feb 2019 07:42:57 -0800 (PST)
Received: from ziepe.ca (S010614cc2056d97f.ed.shawcable.net. [174.3.196.123])
        by smtp.gmail.com with ESMTPSA id r3sm10383048pgn.48.2019.02.08.07.42.57
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 08 Feb 2019 07:42:57 -0800 (PST)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1gs8Iq-0006eE-M1; Fri, 08 Feb 2019 08:42:56 -0700
Date:   Fri, 8 Feb 2019 08:42:56 -0700
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Dan Williams <dan.j.williams@intel.com>
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
Subject: Re: [LSF/MM TOPIC] Discuss least bad options for resolving
 longterm-GUP usage by RDMA
Message-ID: <20190208154256.GA25156@ziepe.ca>
References: <20190206210356.GZ6173@dastard>
 <20190206220828.GJ12227@ziepe.ca>
 <0c868bc615a60c44d618fb0183fcbe0c418c7c83.camel@redhat.com>
 <20190207035258.GD6173@dastard>
 <20190207052310.GA22726@ziepe.ca>
 <CAPcyv4jd4gxvt3faYYRbv5gkc6NGOKjY_Z-P0Ph=ss=gWZw7sA@mail.gmail.com>
 <20190207171736.GD22726@ziepe.ca>
 <CAPcyv4hsHeCGjcJNEmMg_6FYEsQ_8Z=bvx+WmO1v_LmoXbJrxA@mail.gmail.com>
 <20190208051950.GA4283@ziepe.ca>
 <CAPcyv4jWnkHxBcU2_Pz99wM02RYab4y25hu_qUE8KCVArYxCeg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPcyv4jWnkHxBcU2_Pz99wM02RYab4y25hu_qUE8KCVArYxCeg@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 07, 2019 at 11:20:37PM -0800, Dan Williams wrote:
> On Thu, Feb 7, 2019 at 9:19 PM Jason Gunthorpe <jgg@ziepe.ca> wrote:
> >
> > On Thu, Feb 07, 2019 at 03:54:58PM -0800, Dan Williams wrote:
> >
> > > > The only production worthy way is to have the FS be a partner in
> > > > making this work without requiring revoke, so the critical RDMA
> > > > traffic can operate safely.
> > >
> > > ...belies a path forward. Just swap out "FS be a partner" with "system
> > > administrator be a partner". In other words, If the RDMA stack can't
> > > tolerate an MR being disabled then the administrator needs to actively
> > > disable the paths that would trigger it. Turn off reflink, don't
> > > truncate, avoid any future FS feature that might generate unwanted
> > > lease breaks.
> >
> > This is what I suggested already, except with explicit kernel aid, not
> > left as some gordian riddle for the administrator to unravel.
> 
> It's a riddle either way. "Why is my truncate failing?"

At least that riddle errs on the side of system safety and will not be
hit anyhow. Doug is right, we already allow ftruncate to fail with
PROT_EXEC maps (ETXTBUSY) so this isn't even abnormal.

Or do as CL says and succeed the ftruncate but nothing happens (the
continuous write philosophy)

> > You already said it is too hard for expert FS developers to maintain a
> > mode switch
> 
> I do disagree with a truncate behavior switch, but reflink already has
> a mkfs switch so it's obviously possible for any future feature that
> might run afoul of the RDMA restrictions to have fs-feature control.

More precedent that this is the right path..

> > It makes much more sense for the admin to flip some kind of bit and
> > the FS guarentees the safety that you are asking the admin to create.
> 
> Flipping the bit changes the ABI contract in backwards incompatible
> ways. I'm saying go the other way, audit the configuration for legacy
> RDMA safety.

We have precedent for this too. Lots of FSs don't support hole punch,
reflink or in some rare cases ftruncate. It is not exactly new ground.
 
> > > In any event, this lets end users pick their filesystem
> > > (modulo RDMA incompatible features), provides an enumeration of
> > > lease break sources in the kernel, and opens up FS-DAX to a wider
> > > array of RDMA adapters. In general this is what Linux has
> > > historically done, give end users technology freedom.
> >
> > I think this is not the Linux model. The kernel should not allow
> > unpriv user space to do an operation that could be unsafe.
> 
> There's permission to block unprivileged writes/truncates to a file,
> otherwise I'm missing what hole is being opened? That said, the horse
> already left the barn. Linux has already shipped in the page-cache
> case "punch hole in the middle of a MR succeeds and leaves the state
> of the file relative to ongoing RDMA inconsistent". Now that we know
> about the bug the question is how do we do better than the current
> status quo of taking all of the functionality away.

I've always felt this is a bug in RDMA - but we have no path to fix
it. The best I can say is that it doesn't cause any security or
corruption problem today.

> > I continue to think this is is the best idea that has come up - but
> > only if the filesystem is involved and expressly tells the kernel
> > layers that this combination of DAX & filesystem is safe.
> 
> I think we're getting into "need to discuss at LSF/MM territory",
> because the concept of "DAX safety", or even DAX as an explicit FS
> capability has been a point of contention since day one. We're trying
> change DAX to be defined by mmap API flags like MAP_SYNC and maybe
> MAP_DIRECT in the future.
> 
> For example, if the MR was not established to a MAP_SYNC vma then the
> kernel should be free to indirect the RDMA through the page-cache like
> the typical non-DAX case. DAX as a global setting is too coarse.

Whatever this flag is would be is linked to the mmap, and maybe you
could make it a per-file flag instead of some mount option, I don't
know. Kind of up to the FS.

I'm just advocating for the idea that the FS itself can reject/deny the
longterm pin request based on its internal status.  If the FS meets
the defined contract then it can allow long term to proceed. Otherwise
it fails.

I feel this is what people actually want here, and is a far more
maintainable overall system than some sketchy lease revoke SIGKILL.

Jason
