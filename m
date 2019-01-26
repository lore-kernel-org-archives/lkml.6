Return-Path: <SRS0=RQnK=QC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32C33C282C7
	for <linux-kernel@archiver.kernel.org>; Sat, 26 Jan 2019 13:52:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0155121903
	for <linux-kernel@archiver.kernel.org>; Sat, 26 Jan 2019 13:52:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548510762;
	bh=w8mZxLyq7qP4JBT9W8wOa8LD3hoZRNrrmQu4xNjcZa0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=HkYy4UV/gC3sawoRpO17mSgNEc2z9MAIDhlkeKooy94ky7fCyJPupjb8gulujHd6Q
	 0KOFyyVqVEGiDbfoxQlb7y/SiXWy7Ys1mkRFpUjpnJC8LzTjnwmV6UQLjeyPQwNu67
	 vcy9fYFC4ci7JIlD45Cp8aUfGfC0RK6SUqtGI3qM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726336AbfAZNwk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 26 Jan 2019 08:52:40 -0500
Received: from mail.kernel.org ([198.145.29.99]:56902 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726038AbfAZNwk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Jan 2019 08:52:40 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BB5F921902;
        Sat, 26 Jan 2019 13:52:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548510759;
        bh=w8mZxLyq7qP4JBT9W8wOa8LD3hoZRNrrmQu4xNjcZa0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ChvCUju5w3fm/HLK5L1g8soahgCNS9GQ9XWx9o3W7uQuvt3rD1tzxwRISlTCwXMvi
         px8YKL9zF7Cy41OTQV9fTia9To59+b0fB2l75B+J1RFhSGCuXs4m77nybcj8NxVJsu
         mtZi/UI79MeE9ADgePX2lRAJELZxXFUgQ4+6LeiY=
Date:   Sat, 26 Jan 2019 14:52:36 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Olof Johansson <olof@lixom.net>
Cc:     Dave Airlie <airlied@gmail.com>,
        Oded Gabbay <oded.gabbay@gmail.com>,
        Jerome Glisse <jglisse@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>, ogabbay@habana.ai
Subject: Re: [PATCH 00/15] Habana Labs kernel driver
Message-ID: <20190126135236.GC23749@kroah.com>
References: <20190123000057.31477-1-oded.gabbay@gmail.com>
 <CAPM=9tznaiw+a7rWqfdMMO6Aj3GtsO9vetd=3n9d+bGLW0U8Cg@mail.gmail.com>
 <20190125073745.GD11891@kroah.com>
 <CAOesGMgJUeUMoRXZ98=J8bpfCuZOOMo5pwpVXZX-o-y1dAQsHA@mail.gmail.com>
 <20190125160617.GB14934@kroah.com>
 <CAOesGMicf17+0x6AUCNrUYu=d4uREVCyH8F2JvUz5fN5+=jW_A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOesGMicf17+0x6AUCNrUYu=d4uREVCyH8F2JvUz5fN5+=jW_A@mail.gmail.com>
User-Agent: Mutt/1.11.2 (2019-01-07)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 25, 2019 at 09:12:49AM -0800, Olof Johansson wrote:
> On Fri, Jan 25, 2019 at 8:06 AM Greg Kroah-Hartman
> <gregkh@linuxfoundation.org> wrote:
> >
> > On Fri, Jan 25, 2019 at 07:33:23AM -0800, Olof Johansson wrote:
> > > On Thu, Jan 24, 2019 at 11:37 PM Greg Kroah-Hartman
> > > > As for what directory the code should live in, I suggested "misc" as
> > > > there was no other universal location, and I hate to see new subsystems
> > > > be created with only one driver, as that's pretty sad.  But it's just a
> > > > name/location, I have no dog in the fight, so I really don't care where
> > > > it ends up in the tree, just as long as it gets merged somewhere :)
> > >
> > > I'm usually one to push back against new subsystems too, especially
> > > when I see a framework proposal with just one driver. In this case,
> > > given that we all know more vendors will come along, I think it makes
> > > sense to take the discussion and establish structure now. This should
> > > give some clarity to those who are out there that we haven't seen yet,
> > > and give them a chance to prepare for things such as the low-level
> > > userspace pieces mentioned above.
> > >
> > > So I think setting this up now is the right thing to do, we know there
> > > will be more material here and having a common aggregation of it makes
> > > sense.
> >
> > Ok, how about:
> >         drivers/deep_thought/
> >
> > as a first proposal.
> >
> > Let the bikeshedding begin!  :)
> 
> My original proposal upthread was driver/accel. I'm not sure whether
> Dave and/or anyone else wants to participate to start though, I hope
> they will at least join in once things are heading in the direction
> they want.
> 
> I'll post patches with the proposed moves and documentation of
> expectations shortly, hopefully to collect acks.

Patches all look good to me, I can merge them through my char-misc tree
once we get the acks from the relevant driver maintainers.

thanks,

greg k-h
