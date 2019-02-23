Return-Path: <SRS0=lz5G=Q6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D6BDC43381
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Feb 2019 09:34:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2797F20684
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Feb 2019 09:34:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550914452;
	bh=BE+Ht68vrPkWEqMzVpHz3gSyVVjtRpyBgBwENGP8Wck=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=DP1tzn3FLJjAstwUfu5j9gqk9as94wnzCcafQ46r76SKekuzbAhQW7GAcjyewbFyC
	 8hvU7o2NZtj238+xPJ0Cp7tnRHQRZjAoZlY7oo4I+waW5yVMSiUa2d4zSYyw19BOUZ
	 ILM7yytZVmqzVa0v0+GZ0aEa1ggJPVhaFxsRMP00=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727751AbfBWJeK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 23 Feb 2019 04:34:10 -0500
Received: from mail.kernel.org ([198.145.29.99]:34124 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725886AbfBWJeK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Feb 2019 04:34:10 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 60A2020684;
        Sat, 23 Feb 2019 09:34:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550914449;
        bh=BE+Ht68vrPkWEqMzVpHz3gSyVVjtRpyBgBwENGP8Wck=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=DlDo/9DU0xKODrKgieCuFodg9TU2ghJFFe3+AWZ5hWd2uppbvqEejmlpFVK8tl5BW
         /d3v+Ga3FvZrc/mOWoQ3Sm8kjfvX36RnaMrc3mLwc6ERyqeE0JMEnuQjlwQsj4cQda
         PTHat39MQuud05dynNu55t+usSC3rpyQuqOVI96w=
Date:   Sat, 23 Feb 2019 10:34:07 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Oded Gabbay <oded.gabbay@gmail.com>
Cc:     "Linux-Kernel@Vger. Kernel. Org" <linux-kernel@vger.kernel.org>,
        Dan Carpenter <dan.carpenter@oracle.com>
Subject: Re: [PATCH 2/2] habanalabs: driver's Kconfig must select
 DMA_SHARED_BUFFER
Message-ID: <20190223093407.GA26471@kroah.com>
References: <20190222192959.241499-1-oded.gabbay@gmail.com>
 <20190222192959.241499-2-oded.gabbay@gmail.com>
 <20190223091659.GA25029@kroah.com>
 <CAFCwf13nv5Q6dy=dH=GtoMYNyZHMCnQ=C68kLhkcJ8P0LaSdqw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFCwf13nv5Q6dy=dH=GtoMYNyZHMCnQ=C68kLhkcJ8P0LaSdqw@mail.gmail.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 23, 2019 at 11:19:07AM +0200, Oded Gabbay wrote:
> On Sat, Feb 23, 2019 at 11:17 AM Greg KH <gregkh@linuxfoundation.org> wrote:
> >
> > On Fri, Feb 22, 2019 at 09:29:59PM +0200, Oded Gabbay wrote:
> > > The driver uses the DMA_BUF module which is built only if
> > > DMA_SHARED_BUFFER is selected. DMA_SHARED_BUFFER doesn't have any
> > > dependencies so it is ok to select it (as done by many other components).
> > >
> > > Signed-off-by: Oded Gabbay <oded.gabbay@gmail.com>
> >
> > kbuild reported this, right?  You should always add that type of credit
> > to the patch.  I'll go add it by hand this time...
> >
> > thanks,
> >
> > greg k-h
> 
> Ah, I didn't know that, sorry. It wasn't enforced in drm :(

Really?  The drm developers should know better, that's not ok :(
