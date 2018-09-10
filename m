Return-Path: <SRS0=FvrY=LY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FC9BC433F5
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 08:16:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C74122086B
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 08:16:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C74122086B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727841AbeIJNJU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Sep 2018 09:09:20 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:42792 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727683AbeIJNJT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Sep 2018 09:09:19 -0400
Received: from localhost (ip-213-127-74-90.ip.prioritytelecom.net [213.127.74.90])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 26912C23;
        Mon, 10 Sep 2018 08:16:28 +0000 (UTC)
Date:   Mon, 10 Sep 2018 10:16:26 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     "Ahmed S. Darwish" <darwish.07@gmail.com>
Cc:     Simon Que <sque@chromium.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        John Joseph <jnjoseph@google.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Rob Springer <rspringer@google.com>,
        devel@linuxdriverproject.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Todd Poynor <toddpoynor@google.com>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [GIT PULL] Staging/IIO driver patches for 4.19-rc1
Message-ID: <20180910081626.GA31344@kroah.com>
References: <20180818155724.GA22569@kroah.com>
 <20180828103817.GB1397@do-kernel>
 <20180828123607.GB13441@kroah.com>
 <20180828143049.GA7388@darwi-kernel>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180828143049.GA7388@darwi-kernel>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 28, 2018 at 02:30:49PM +0000, Ahmed S. Darwish wrote:
> Hi!
> 
> On Tue, Aug 28, 2018 at 02:36:07PM +0200, Greg KH wrote:
> > On Tue, Aug 28, 2018 at 10:38:17AM +0000, Ahmed S. Darwish wrote:
> > > [ re-send; forgotten lkml CC added; sorry ]
> > >
> > > Hi,
> > >
> > > On Sat, 18 Aug 2018 17:57:24 +0200, Greg KH wrote:
> > > [...]
> > > > addition of some new IIO drivers.  Also added was a "gasket" driver from
> > > > Google that needs loads of work and the erofs filesystem.
> > > >
> > >
> > > Why are we adding __a whole new in-kernel framework__ for
> > > developing basic user-space drivers?
> > >
> > > We already have a frameowrk for that, and it's UIO. [1] The UIO
> > > code is a very stable and simple subsystem; it's also heavily used
> > > in the embedded industry..
> >
> > As Todd said, the code will end up being a simple UIO driver, if even
> > that big, in th end.  It is just going to take him a while to constantly
> > refactor things until he achieves that goal...
> >
> > > I've looked at the gasket documentation [2], and the first user
> > > of this new in-kernel API [3], and this is almost replicating UIO
> > > it's not funny. [4] True, the gasket APIs adds some extra new
> > > conveniences (PCI BAR re-mapping, MSI, ..), but there's no
> > > technical reason this cannot be added to the UIO code instead.
> >
> > {shh} That's my plan :)
> >
> 
> Cool, thanks a lot.
> 
> Can we then merge something like below patch?
> 
> [ I've searched the gasket included TODO file before posting,
>   but did not find any mention of UIO. Below patch will make
>   sure this will not be forgotten over time.. ]

Looks good, can you resend it in a format I can apply it in (i.e. one
that does not require me to hand-edit a patch?)

thanks,

greg k-h
