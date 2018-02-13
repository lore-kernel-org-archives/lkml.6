Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933471AbeBMFDI (ORCPT <rfc822;w@1wt.eu>);
        Tue, 13 Feb 2018 00:03:08 -0500
Received: from kvm5.telegraphics.com.au ([98.124.60.144]:58244 "EHLO
        kvm5.telegraphics.com.au" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751661AbeBMFDG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Feb 2018 00:03:06 -0500
Date: Tue, 13 Feb 2018 16:03:09 +1100 (AEDT)
From: Finn Thain <fthain@telegraphics.com.au>
To: David Miller <davem@davemloft.net>
cc: netdev@vger.kernel.org, linux-m68k@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux@armlinux.org.uk,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH net v4 02/13] net/8390: Fix msg_enable patch snafu
In-Reply-To: <20180212.103956.1262868827217051631.davem@davemloft.net>
Message-ID: <alpine.LNX.2.21.1802131419540.8@nippy.intranet>
References: <cover.1518397634.git.fthain@telegraphics.com.au>        <f697da2b2513e025688f6c48088536060575a249.1518397634.git.fthain@telegraphics.com.au> <20180212.103956.1262868827217051631.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 12 Feb 2018, David Miller wrote:

> From: Finn Thain <fthain@telegraphics.com.au>
> Date: Sun, 11 Feb 2018 22:08:43 -0500 (EST)
> 
> > The lib8390 module parameter 'msg_enable' doesn't do anything useful:
> > it causes an ancient version string to be logged.
> 
> Not true.
> 
> You need to look at the various netif_*() et al. message logging
> interfaces, they check "p->msg_enable" to determine which messages to
> print.
> 

I think you have overlooked those modules which offer no way to set 
p->msg_enable, i.e. ax88796, axnet_cs, etherh, hydra, mac8390, mcf8390, 
pcnet_cs and zorro8390.

The apne, ne, ne2k-pci, smc-ultra, stnic, and wd modules are not at issue 
here because they define their own msg_enable parameters and they also 
assign p->msg_enable accordingly.

> I'm not applying this, sorry.
> 

Please take another look.

> Just for the record, I consider these kinds of ancient driver cleanups 
> painful to review, and unless they allow some ugly global kernel API to 
> be improved or removed such changes have very little gain.
> 

OK. When there are no users, I'll send you no patches.

But even then, I may continue to send patches to other maintainers who may 
be open to the possibility of unforeseen future uses of the body of 
contributed code under their care.

> In fact, most of them have a good chance to break things.
> 

You saw the tested-by tags, right? Anyway, if you consider my previous 
work, I believe you'll find that I've fixed more bugs than I've 
introduced.

> It is especially a dubious sequence when you cluster so many of these 
> things together into a large patch series.
> 

Sorry if that gave the wrong impression. Doing that made my workflow 
easier.

> If you are really serious about fixing real bugs, post these one at a 
> time, very slowly, for us to review properly and apply.
> 
> Thank you.

Please don't feel like I'm trying to pressure you to expedite this.

FWIW, this submission was arranged so that you might cherry-pick the first 
N patches, for some satisfactory value of N.

I will split up this series by driver (8390, sonic, etc) so it's more 
clear which patches are independent and which patches can be reviewed 
together.

Thanks.

-- 

> --
> To unsubscribe from this list: send the line "unsubscribe linux-m68k" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
