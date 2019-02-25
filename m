Return-Path: <SRS0=3gpS=RA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55147C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 21:47:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 22B55217F4
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 21:47:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551131256;
	bh=ccnXouk1V1o4Ckc1X/FV54cM4p/ais2Y/HzGnWgITkk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=udKVoFb/XfUoeUzQO3+D9rZgiq3EisnDnE0ykIpHWWtTn2iPcMrebZgTKRl2jgeQb
	 D/PZP7EHjVxZqfL0NLp/PgKmTlX0nQqeYxH+QfyNot1fba8lsw/x9e+fv4y5ya+2mj
	 uans3mu0iFmMSgdzGisN0Z8pV2uPdYiG9RQTOAkI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731526AbfBYVre (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Feb 2019 16:47:34 -0500
Received: from mail.kernel.org ([198.145.29.99]:50358 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729070AbfBYVrc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Feb 2019 16:47:32 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4B2B620652;
        Mon, 25 Feb 2019 21:47:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1551131250;
        bh=ccnXouk1V1o4Ckc1X/FV54cM4p/ais2Y/HzGnWgITkk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=g7QTswZMj/HCtvgJmKf2bVKT9YhkLv3VnNQzJzN3IvyyJ7P73u2HNSUQOvV99BiuJ
         jVzvvZzLq1SdPqgdLOEALSPyPzoxUj8F+ZTAtjYDs9In1sgsg+QJz8xLH6ZPBprBCa
         OyjEZ+zCy7dxLLsYKY7lWLvRtOBlv6QIOJY0isoo=
Date:   Mon, 25 Feb 2019 22:44:55 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Jerry Hoemann <jerry.hoemann@hpe.com>
Cc:     Matt Hsiao <matt.hsiao@hpe.com>, linux-kernel@vger.kernel.org,
        arnd@arndb.de, david.altobelli@hpe.com, mark.rusk@hpe.com
Subject: Re: [PATCH 4/4] misc: hpilo: Update driver version
Message-ID: <20190225214455.GA6845@kroah.com>
References: <1550736282-25416-1-git-send-email-matt.hsiao@hpe.com>
 <1550736282-25416-5-git-send-email-matt.hsiao@hpe.com>
 <20190221083256.GA6397@kroah.com>
 <20190222041111.GB31132@anatevka>
 <20190222064928.GA15860@kroah.com>
 <20190225082805.GA10062@anatevka>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190225082805.GA10062@anatevka>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 25, 2019 at 01:28:05AM -0700, Jerry Hoemann wrote:
> On Fri, Feb 22, 2019 at 07:49:28AM +0100, Greg KH wrote:
> > On Thu, Feb 21, 2019 at 09:11:11PM -0700, Jerry Hoemann wrote:
> > 
> > > Our primary means of supporting Linux to our customers is via our
> > > distro partners.  While we prefer to use in distro drivers, HPE does
> > > from time to time deliver driver updates via the "Service Pack for
> > > Proliants" -- The SPP. 
> > 
> > That's fine, but again, does not matter to the in-kernel driver at all.
> 
> Your point?  No one claimed that changing the version number
> of the module changes its functionality.  We're changing the driver
> version number to reflect that the driver's functionality changed.
> 
> We do this to help determine the version running on a system
> in the event we have problems.  It's a support issue.

You last touched that version number in 2016, despite there being
changes made to the driver in the _years_ since then.  So if someone
called in and said, "I have a problem with version "1.5.0", you really
have no idea what that code is.

That shows to me that the version field in the driver means nothing, so
it should be removed.

> > I understand that in your viewpoint, your driver's version means
> > something.  But in reality, it's only the kernel's version that means
> > something because your driver is just part of the overall kernel, it
> > does not stand alone.
> 
> I never claimed a driver stood alone.  jeezz.
> 
> When you say kernel "version", are you trying to say that the version
> string printed by the kernel determines the source of the drivers?
> (I ask, because I have heard other maintainers make this claim.)

Yes.

> The kernel version string only reliably determines the base kernel build.
> Modules can be unloaded and replaced by totally new versions drastically
> different from the version that existed at the time of the base kernel build.

Sure, and if you do that you are on your own, feel free to put what ever
string you want in your external module source code.

Note, you will know that this is an "external" module, the kernel does
tell you that you did this, it is not silent at all.

> The delivery of drivers updates independent of base kernel was old
> practice when I started Unix development 30 years ago.  It was not unique
> to HPE then or now.  I don't see it stopping.

The old model of detaching drivers from the operating system is not at
play here.  When you had different distribution channels, trying to have
a version number made sense to try to get a grip on what is running
where.  That's not the case with Linux, and hasn't been for the past 20+
years.

Linux is distributed as a "whole", kernel+drivers, they are directly
tied together and are one body of work.  Yes, you can have external
modules, but that is not the normal method of operation and one I could
care less about here.  All I care about is that our tree works properly.

And as such, I will continue to state that an individual driver version
number means nothing, as it is the actual version of the kernel itself
that actually means something.

For drivers that actually have active development (unlike this one), it
is very simple to see how the module version gets out of whack.  Take
one patch that goes into the main kernel tree, and have that backported
to the stable and LTS kernels, and all of a sudden your "version number"
means nothing, as the version number of the stable kernel's copy of the
driver did not change.  And you really can't bump it to a different
number from the main version, so what do you do?  Try to come up with
some other intermediate number?  That's not ok as you can't keep up with
that numbering scheme as all that really matters is the kernel version
number itself!

Anyway, as this driver is obviously not under development at all, and
the changes that have happened since 2016 never caused you to change the
number, I'm not going to take this patch, sorry.

greg k-h
