Return-Path: <SRS0=t/yM=Q5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DAF7CC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 06:49:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9C2622086C
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 06:49:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550818174;
	bh=KWXf/TdMADLAA0mGugiZQY53wknKR52uLyyXjxcYKr8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=uY5dr7PZl2+hJvXtfNyShajOwqvmlKgo7e88EHW+H8J/Jk3k2G+fds2zkoAR2Jihj
	 v1fcJ0QTCVzwem7eez+1emD8wHSIM6jRqYL6Doq5tEtlLrSjtAOOFZEmpFN2sQvKgD
	 mcEAnFSeLD1n4K7qGC+5+ylWRtdvYsVDMEnoEzqI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725992AbfBVGtd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Feb 2019 01:49:33 -0500
Received: from mail.kernel.org ([198.145.29.99]:44004 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725824AbfBVGtc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Feb 2019 01:49:32 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4C20220823;
        Fri, 22 Feb 2019 06:49:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550818171;
        bh=KWXf/TdMADLAA0mGugiZQY53wknKR52uLyyXjxcYKr8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=RtMUSiF5dQMsYBxWddRmDfdnJZFl8caIgiHnqUMJPTuM74ztQuca4tVi1FCkIBGiO
         QDv8MU4m0/NNO5kRO0Rrsw++sxXGYP3yJeFfOlNqhHNJzR2Wq/EY5354e/Tn0Xh3lA
         0QmxknCJO2+/p+JQZPjpnaH1/nIeob/N+l4jPeaE=
Date:   Fri, 22 Feb 2019 07:49:28 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Jerry Hoemann <jerry.hoemann@hpe.com>
Cc:     Matt Hsiao <matt.hsiao@hpe.com>, linux-kernel@vger.kernel.org,
        arnd@arndb.de, david.altobelli@hpe.com, mark.rusk@hpe.com
Subject: Re: [PATCH 4/4] misc: hpilo: Update driver version
Message-ID: <20190222064928.GA15860@kroah.com>
References: <1550736282-25416-1-git-send-email-matt.hsiao@hpe.com>
 <1550736282-25416-5-git-send-email-matt.hsiao@hpe.com>
 <20190221083256.GA6397@kroah.com>
 <20190222041111.GB31132@anatevka>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190222041111.GB31132@anatevka>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 21, 2019 at 09:11:11PM -0700, Jerry Hoemann wrote:
> On Thu, Feb 21, 2019 at 09:32:56AM +0100, Greg KH wrote:
> ...
> > >  
> > > -MODULE_VERSION("1.5.0");
> > > +MODULE_VERSION("1.5.1");
> > 
> > This line means nothing, it should just be removed entirely.  The
> > "version" of the driver is the kernel version itself.
> 
> Hi Greg,
> 
> This doesn't hold when we do driver updates.

That doesn't matter to the in-kernel code.

> Our primary means of supporting Linux to our customers is via our
> distro partners.  While we prefer to use in distro drivers, HPE does
> from time to time deliver driver updates via the "Service Pack for
> Proliants" -- The SPP. 

That's fine, but again, does not matter to the in-kernel driver at all.

> An SPP driver update can supply an updated module without modifying
> the underlying base kernel version.  Because of this, the underlying
> kernel version number doesn't always imply the version of a module
> being used.
> 
> Even when we use only in kernel drivers, we also have the case where
> our distro partners will back port newer driver versions to an older
> distro release.  This gives the situation where an older kernel
> version can have a newer module than a newer kernel version for
> that distro.
> 
> We have found that having module version bumped when modifying the
> driver helps us identify the version module actually being used.

What happens when your driver gets backports in stable kernel updates
and those updates get merged into distro kernels?  You now have a
version that means something you do not think it means.

I understand that in your viewpoint, your driver's version means
something.  But in reality, it's only the kernel's version that means
something because your driver is just part of the overall kernel, it
does not stand alone.

Your driver is simple enough that the version number doesn't really
change often and the code doesn't either, so you haven't hit these
issues yet, but for others that have tried to manage a "which version is
this driver" when dealing with backports, stable kernels, out-of-tree
drivers, and the like, it really is meaningless.

For this reason, this macro has been removed from many subsystems
already, I forgot about "misc", I might as well sweep it and do it
there too.

If you have an out-of-tree version that you provide to distros, you are
of course free to have the "version" in there if you like, but again,
for the in-kernel version of this code, it does not matter at all.

thanks,

greg k-h
