Return-Path: <SRS0=p8q0=NW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91EBBC43441
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 20:08:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5932F2080D
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 20:08:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5932F2080D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731453AbeKLF6D (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 00:58:03 -0500
Received: from mail.bootlin.com ([62.4.15.54]:52027 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726471AbeKLF6C (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 00:58:02 -0500
Received: by mail.bootlin.com (Postfix, from userid 110)
        id A4C6C224E9; Sun, 11 Nov 2018 21:08:31 +0100 (CET)
Received: from bbrezillon (unknown [91.160.177.164])
        by mail.bootlin.com (Postfix) with ESMTPSA id CEDD3224CD;
        Sun, 11 Nov 2018 21:08:20 +0100 (CET)
Date:   Sun, 11 Nov 2018 21:08:18 +0100
From:   Boris Brezillon <boris.brezillon@bootlin.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Wolfram Sang <wsa@the-dreams.de>, linux-i2c@vger.kernel.org,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
        Arnd Bergmann <arnd@arndb.de>,
        Przemyslaw Sroka <psroka@cadence.com>,
        Arkadiusz Golec <agolec@cadence.com>,
        Alan Douglas <adouglas@cadence.com>,
        Bartosz Folta <bfolta@cadence.com>,
        Damian Kos <dkos@cadence.com>,
        Alicja Jurasik-Urbaniak <alicja@cadence.com>,
        Cyprian Wronka <cwronka@cadence.com>,
        Suresh Punnoose <sureshp@cadence.com>,
        Rafal Ciepiela <rafalc@cadence.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Nishanth Menon <nm@ti.com>, Rob Herring <robh+dt@kernel.org>,
        Pawel Moll <pawel.moll@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Ian Campbell <ijc+devicetree@hellion.org.uk>,
        Kumar Gala <galak@codeaurora.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Vitor Soares <Vitor.Soares@synopsys.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Xiang Lin <Xiang.Lin@synaptics.com>,
        linux-gpio@vger.kernel.org, Sekhar Nori <nsekhar@ti.com>,
        Przemyslaw Gaj <pgaj@cadence.com>,
        Peter Rosin <peda@axentia.se>,
        Mike Shettel <mshettel@codeaurora.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>
Subject: Re: [PATCH v10 0/9] Add the I3C subsystem
Message-ID: <20181111210818.08af6731@bbrezillon>
In-Reply-To: <20181111191020.GA21003@kroah.com>
References: <20181026144333.12276-1-boris.brezillon@bootlin.com>
        <20181111173932.GA12254@kroah.com>
        <20181111191017.7b2efdf1@bbrezillon>
        <20181111191020.GA21003@kroah.com>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 11 Nov 2018 11:10:20 -0800
Greg Kroah-Hartman <gregkh@linuxfoundation.org> wrote:

> On Sun, Nov 11, 2018 at 07:10:17PM +0100, Boris Brezillon wrote:
> > Hi Greg,
> > 
> > On Sun, 11 Nov 2018 09:39:32 -0800
> > Greg Kroah-Hartman <gregkh@linuxfoundation.org> wrote:
> >   
> > > On Fri, Oct 26, 2018 at 04:43:24PM +0200, Boris Brezillon wrote:  
> > > > Hi Greg,
> > > > 
> > > > I think we've reached a point where we can eventually consider the I3C
> > > > framework for inclusion in 4.20 (5.0?). A few more issues were reported
> > > > on v9 and fixed in v10. I can't guarantee that the implementation is
> > > > free of bugs but I still think it's worth merging it in v4.20: it's a
> > > > new subsystem, so we don't risk regressions, and the only way we can
> > > > detect other issues is by having other people experiment with this
> > > > implementation.
> > > > 
> > > > The only remaining concern raised by Arnd is the fact that both hosts
> > > > and slaves share the same bus type and are differentiated thanks to
> > > > their device_type, which IMHO is fine since this is what other
> > > > subsystems do (plus I don't see other solutions to have both I3C
> > > > devices and I3C buses represented under /sys/bus/i3c/).    
> > > 
> > > Yeah, it's not the nicest, but it will work, we did it also for USB and
> > > greybus and it solves the issue.
> > > 
> > > This all looks good to me, so I've queued it up.  Let's see if
> > > linux-next has any problems with it.  
> > 
> > I recently asked Stephen to add the linux-i3c tree to linux-next, so
> > I'm expecting conflicts :-/. Sorry, I didn't know you were planning to
> > take these patches through your tree.
> > 
> > BTW, I also fixed a couple of things when rebasing on top of 4.20-rc1:
> > 
> > - KernelVersion in the sysfs ABI doc has been updated to 5.0  
> 
> There is no 5.0 yet :)

Actually I had a hard time choosing between 4.21 and 5.0, and then I
saw Linus' email announcing 4.20-rc1 ;-). But I can change it back to
4.21 if you prefer.

> 
> > - Fixed i3c_master_getmxds_locked() (bug reported/fixed by Colin here
> >   https://www.mail-archive.com/linux-kernel@vger.kernel.org/msg1799850.html)
> > - Removed a blank line at the end of master-driver-api.rst

One extra thing I didn't mention (and didn't fix yet) is the I3C
mailing list. I asked Dave Miller if he'd be okay to create the
linux-i3c ML on vger.kernel.org, and he suggested that we use the
linux-i2c ML instead which I know Wolfram is not fond of. I might
decide to just put linux-kernel@vger.kernel.org as the ML to Cc for
I3C patches until we settle on something. 

> > 
> > For the record, the i3c/next branch pulled by Stephen is available here
> > [1].
> >   
> > > Thanks for sticking with it, nice work!  
> > 
> > Thanks for reviewing it! Greg, Stephen, let me know if you want me to
> > reset i3c/next to v4.20-rc1 to avoid conflicts in linux-next.  
> 
> So do you want me to just drop these patches from my tree?  If so, I
> can, but i have no problem sending these to Linus for the next -rc1
> merge window through my tree if that is easier.
> 
> It's up to you.

I think that's easier for me and for you if I take them in the i3c tree
and then send a PR to Linus myself. This way I won't bother you if
fixes are needed or if I decide to apply patches adding support for
other I3C controllers (I see you commented on the Synopsys driver
already, and I might indeed decide to queue this patchset for this
release).

Doing that also allows me to get everything in place since I'll anyway
have to send PRs to Linus at some point.

Regards,

Boris

PS: If you're fine with me taking the I3C patches, I'll need your
Acked-by.
