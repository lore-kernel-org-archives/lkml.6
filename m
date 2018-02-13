Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933497AbeBMFDm (ORCPT <rfc822;w@1wt.eu>);
        Tue, 13 Feb 2018 00:03:42 -0500
Received: from kvm5.telegraphics.com.au ([98.124.60.144]:58268 "EHLO
        kvm5.telegraphics.com.au" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751504AbeBMFDk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Feb 2018 00:03:40 -0500
Date: Tue, 13 Feb 2018 16:03:44 +1100 (AEDT)
From: Finn Thain <fthain@telegraphics.com.au>
To: Geert Uytterhoeven <geert@linux-m68k.org>
cc: "David S. Miller" <davem@davemloft.net>,
        netdev <netdev@vger.kernel.org>,
        Linux/m68k <linux-m68k@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net v4 09/13] net/mac8390: Convert to nubus_driver
In-Reply-To: <CAMuHMdUoiVhA5BxVpxJ81VxZ5Y_n1DBugqPxhABE5Z8eL1Bd3w@mail.gmail.com>
Message-ID: <alpine.LNX.2.21.1802131416310.8@nippy.intranet>
References: <cover.1518397634.git.fthain@telegraphics.com.au> <219b4da3972b28307c599f7d340e613303de7ed7.1518397634.git.fthain@telegraphics.com.au> <CAMuHMdUoiVhA5BxVpxJ81VxZ5Y_n1DBugqPxhABE5Z8eL1Bd3w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 12 Feb 2018, Geert Uytterhoeven wrote:

> On Mon, Feb 12, 2018 at 4:08 AM, Finn Thain <fthain@telegraphics.com.au> wrote:
> > This resolves an old bug that constrained this driver to no more than
> > one card.
> >
> > Tested-by: Stan Johnson <userm57@yahoo.com>
> > Signed-off-by: Finn Thain <fthain@telegraphics.com.au>
> 
> > --- a/drivers/net/ethernet/8390/mac8390.c
> > +++ b/drivers/net/ethernet/8390/mac8390.c
> 
> > @@ -390,86 +389,86 @@ static bool __init mac8390_init(struct net_device *dev,
> >         return true;
> >  }
> >
> > -struct net_device * __init mac8390_probe(int unit)
> > +static int mac8390_device_probe(struct nubus_board *board)
> >  {
> >         struct net_device *dev;
> > -       struct nubus_rsrc *ndev = NULL;
> >         int err = -ENODEV;
> > -       static unsigned int slots;
> > -
> > -       enum mac8390_type cardtype;
> > -
> > -       /* probably should check for Nubus instead */
> > +       struct nubus_rsrc *fres;
> > +       enum mac8390_type cardtype = MAC8390_NONE;
> >
> >         if (!MACH_IS_MAC)
> > -               return ERR_PTR(-ENODEV);
> > +               return -ENODEV;
> 
> I think this check can be removed completely,

I agree.

> as the nubus_board will exist on suitable Macs only.
> 

And considering the out-of-tree Nubus PowerMac port, this check just makes 
the driver less portable.

I'll resubmit these patches with the changes you have suggested (here and 
elsewhere). Thanks for your review.

BTW, would you be willing to review the rest of this series sometime? I 
ask because David has voiced concerns about code quality, and your 
"reviewed-by" tag speaks volumes.

-- 

> Gr{oetje,eeting}s,
> 
>                         Geert
> 
