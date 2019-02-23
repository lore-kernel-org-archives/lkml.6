Return-Path: <SRS0=lz5G=Q6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C56BC43381
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Feb 2019 08:00:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 302A3206BA
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Feb 2019 08:00:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550908823;
	bh=xjKFxr8bMCVS4GLGeKa2wFkLUgeSGo66Gv53TDAz3sA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=jm4zNUuXNw7ddiiNgUK+vgnqI2LTE9LMsW13Q1NIfBaw6qUyuZbNE7Jd/RAoF0dYn
	 359KgdSLHWgYtTFX/0F8kyxwAAqdn5DnkpVCqE29Bza25sZERDPS7NcCDBzLJP7LVd
	 kCUtYFfnTu1diGJ2kNh6vqj+TPBcF/CmmUwMpbfY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726124AbfBWIAV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 23 Feb 2019 03:00:21 -0500
Received: from mail.kernel.org ([198.145.29.99]:55924 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725868AbfBWIAV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Feb 2019 03:00:21 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C8430206BA;
        Sat, 23 Feb 2019 08:00:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550908820;
        bh=xjKFxr8bMCVS4GLGeKa2wFkLUgeSGo66Gv53TDAz3sA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=GtwWKZCK4y6NsjcTr8AvTBuJR7jw1Tu9G8KxgRCfc7qr5ahc2JOCWwXkr+exrVKvL
         Jc1/n+QDVaOPa5D89ejrVEKBWm+Eq9yvHTSWM/8eDTh4k7Zfs6hPEfiHYw4Ds4TbHb
         aoyiDsrVrv3Jk3SqiE02xiIzZFGQ+zAxuIH0JnVM=
Date:   Sat, 23 Feb 2019 09:00:17 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Marcin Ciupak <marcin.s.ciupak@gmail.com>
Cc:     Joe Perches <joe@perches.com>, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org,
        Dan Carpenter <dan.carpenter@oracle.com>
Subject: Re: [PATCH v4] staging: nrf24: add new driver for 2.4GHz radio
 transceiver
Message-ID: <20190223080017.GC2640@kroah.com>
References: <20190213194035.n2ldlt7xque5qaps@metis.ciupak.eu>
 <20190219102010.GA18634@kroah.com>
 <20190222202055.udjbsm5qkxzkqcdh@metis.ciupak.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190222202055.udjbsm5qkxzkqcdh@metis.ciupak.eu>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 22, 2019 at 09:20:56PM +0100, Marcin Ciupak wrote:
> On Tue, Feb 19, 2019 at 11:20:10AM +0100, Greg Kroah-Hartman wrote:
> > On Wed, Feb 13, 2019 at 08:40:35PM +0100, Marcin Ciupak wrote:
> > > This patch adds driver for Nordic Semiconductor nRF24L01+ radio
> > > transceiver.
> > > 
> > > Signed-off-by: Marcin Ciupak <marcin.s.ciupak@gmail.com>
> > > ---
> > > Changes in v2:
> > >   - add terminating newlines to all logging formats
> > > Changes in v3:
> > >   - patch subject
> > >   - comments cleanup
> > >   - goto labels cleanup
> > >   - scnprintf bugfix
> > >   - ida_simple_remove bugfix
> > > Changes in v4:
> > >   - fix smatch warnings
> > 
> > What is preventing this from being merged today with the normal
> > subsystem for this type of drivers?  Why does this have to go into
> > staging?
> > 
> > thanks,
> > 
> > greg k-h
> 
> As per TODO file:
> +Todo:
> +- opening and closing pipes via sysfs

That's not what sysfs is for, so that can't be a TODO item :)

> +- improve switching in between RX and TX
> +- improve handling of MAX_RT interrupt

That's just logic cleanup, no reason to have it in staging.

> +- find and fix bugs

Same here.

> +- code cleanup

What specifically do you mean by this?  And why can't you just spend a
day and do it now?

> 
> Additionally, I would like to add ioctl (or any similar) interface
> as configuration via sysfs is not very efficent in here.

sysfs is not for configuration, that is what configfs is for, please use
that instead.

> My beliefes are that this driver needs some time in staging, but I might
> be wrong and if you believe otherwise just let me know and I will try to
> push it ti regular sybsystem.

I think you need to use the standard apis that the kernel has for
drivers like this (v4l?) and work on getting the driver into the proper
subsystem first.  I don't see what the goal of getting it into staging
is going to do to help you out with that.

thanks,

greg k-h
