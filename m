Return-Path: <SRS0=FPao=NG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80482C6786E
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Oct 2018 12:47:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2B87A2082B
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Oct 2018 12:47:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2B87A2082B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727722AbeJZVX7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Oct 2018 17:23:59 -0400
Received: from mail.bootlin.com ([62.4.15.54]:42908 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727582AbeJZVX7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Oct 2018 17:23:59 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id B0983208AE; Fri, 26 Oct 2018 14:46:57 +0200 (CEST)
Received: from bbrezillon (aaubervilliers-681-1-12-210.w90-88.abo.wanadoo.fr [90.88.133.210])
        by mail.bootlin.com (Postfix) with ESMTPSA id E3E4B20726;
        Fri, 26 Oct 2018 14:46:46 +0200 (CEST)
Date:   Fri, 26 Oct 2018 14:46:47 +0200
From:   Boris Brezillon <boris.brezillon@bootlin.com>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Wolfram Sang <wsa@the-dreams.de>,
        Linux I2C <linux-i2c@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        gregkh <gregkh@linuxfoundation.org>,
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
        Kumar Gala <galak@codeaurora.org>,
        DTML <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Vitor Soares <Vitor.Soares@synopsys.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Xiang Lin <Xiang.Lin@synaptics.com>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Sekhar Nori <nsekhar@ti.com>,
        Przemyslaw Gaj <pgaj@cadence.com>,
        Peter Rosin <peda@axentia.se>,
        Mike Shettel <mshettel@codeaurora.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Joe Perches <joe@perches.com>
Subject: Re: [PATCH v9 6/9] i3c: master: Add driver for Cadence IP
Message-ID: <20181026144647.11926142@bbrezillon>
In-Reply-To: <CAK8P3a0_En6e6ORvNqxprBcsT3+NmFO8nFnQ3nNiv-5Hq2LjrQ@mail.gmail.com>
References: <20181022133404.2061-1-boris.brezillon@bootlin.com>
        <20181022133404.2061-7-boris.brezillon@bootlin.com>
        <20181024202048.7e3534f7@bbrezillon>
        <CAK8P3a2DBgfvXs-9KzoDvbQpV+VN96xb7xHG-5=NDDgnt7ViVQ@mail.gmail.com>
        <20181025180720.1790f6a1@bbrezillon>
        <CAK8P3a02ELWiMB_pe0bzbsMfdqYOG1G0bFnSHzGu3ZbQHatH2w@mail.gmail.com>
        <20181025183005.3c0fa452@bbrezillon>
        <CAK8P3a0WDRpukjDBm1rGPnZiH2FJRpquWhEknOBg=CphNOYOwg@mail.gmail.com>
        <20181026095707.3cd9b511@bbrezillon>
        <CAK8P3a0_En6e6ORvNqxprBcsT3+NmFO8nFnQ3nNiv-5Hq2LjrQ@mail.gmail.com>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 26 Oct 2018 12:01:52 +0200
Arnd Bergmann <arnd@arndb.de> wrote:

> On Fri, Oct 26, 2018 at 9:57 AM Boris Brezillon
> <boris.brezillon@bootlin.com> wrote:
> > On Fri, 26 Oct 2018 09:43:25 +0200
> > Arnd Bergmann <arnd@arndb.de> wrote:
> >  
> > > On Thu, Oct 25, 2018 at 6:30 PM Boris Brezillon
> > > <boris.brezillon@bootlin.com> wrote:  
> > > > On Thu, 25 Oct 2018 18:13:51 +0200 Arnd Bergmann <arnd@arndb.de> wrote:
> > > > On Thu, Oct 25, 2018 at 6:07 PM Boris Brezillon <boris.brezillon@bootlin.com> wrote:  
> > > > > > On Thu, 25 Oct 2018 17:30:26 +0200  
> > > Ok. Is i3c_master_send_ccc_cmd_locked() what implements the public
> > > interfaces then, or is this something else?  
> >
> > i3c_master_send_ccc_cmd_locked() calls master->ops->send_ccc_cmd(), so
> > it's part of the master controller interface.
> >  
> > >
> > > If you place a buffer on the stack, it is not DMA capable, but
> > > it is guaranteed to be at least 32-bit word aligned, and should
> > > not cause an exception in readsl(), unless it starts with a couple of
> > > (not multiple of four)  extra bytes that are not sent to the devices.
> > > Is that what happens here?  
> >
> > Here is the report I received from Vitor:
> >
> > "
> >         Hi Boris,
> >
> >
> >         I'm trying this new patch-set version but I get some issues when use
> >         readsl() function.
> >
> >         Basically the system complain about memory alignment.
> >  
> 
> >         > +static int i3c_master_getpid_locked(struct i3c_master_controller *master,
> >         > +                                 struct i3c_device_info *info)
> >         > +{
> >         > +     struct i3c_ccc_getpid getpid;  
> >
> >         at this point the getpid struct it is already unaligned with
> >
> >         i3c_master_getpid_locked:1129 getpid_add=0x9a249c7a
> >  
> >         > +     struct i3c_ccc_cmd_dest dest = {
> >         > +             .addr = info->dyn_addr,
> >         > +             .payload.len = sizeof(struct i3c_ccc_getpid),
> >         > +             .payload.data = &getpid,
> >         > +     };  
> 
> >         > +}
> >         > +  
> >
> >         and them when
> >
> >         static void dw_i3c_master_read_rx_fifo(struct dw_i3c_master *master,
> >                                 u8 *bytes, int nbytes)
> >         {
> >              readsl(master->regs + RX_TX_DATA_PORT, bytes, nbytes / 4);
> >         ...
> >         }  
> 
> Ok, I spent an hour chasing the ARM implementation and finding
> no way this could go wrong here. I see that 'struct i3c_ccc_getpid'
> may be misaligned on the stack (it normally won't be), and that
> the ARM readsl() has a lot of extra code to handle unaligned
> output.

I didn't have this problem on xtensa either.

> However, the dump that Vitor reports
> 
> >         [ECR   ]: 0x00230400 => Misaligned r/w from 0x9a249c7a
> >         [EFA   ]: 0x9a249c7a
> >        [BLINK ]: dw_i3c_master_irq_handler+0x200/0x2fc [dw_i3c_master]  
> 
> Is from an arch/arc kernel that uses asm-generic/io.h, and
> that stores the output using a u32 pointer:
> 
> static inline void readsl(const volatile void __iomem *addr, void *buffer,
>                           unsigned int count)
> {
>         if (count) {
>                 u32 *buf = buffer;
> 
>                 do {
>                         u32 x = __raw_readl(addr);
>                         *buf++ = x;
>                 } while (--count);
>         }
> }
> 
> This is apparently not allowed on ARC when 'buffer' is
> unaligned. I think what we need here is to use
> put_unaligned() instead of the pointer dereference.
> For architectures that can do unaligned accesses,
> the result is the same, but for ARC it will fix the problem.

Okay, so writesl()/readsl() should deal with unaligned pointers, and
default implementations should be fixed. I guess you'll send a patch to
use put/get_unaligned().

> 
> > > One way to address this might be to always bounce any
> > > messages that are less than a cache line through a
> > > (pre-)kmallocated buffer, and require any longer messages
> > > to be cache capable. This could also solve the issue with
> > > readsl(), but it would be a rather confusing user interface.
> > >
> > > Another option might be to have separate interfaces for
> > > "short" and "long" messages at the API level and have
> > > distinct rules for those: short would always be bounced
> > > by the i3c code, and long puts restrictions on the buffer
> > > location.  
> >
> > Hm, let's keep the API simple. I'll just mandate that all payload bufs
> > passed to i3c_master_send_ccc_cmd_locked() be dynamically allocated.  
> 
> Ok. What about i2c commands sent to the same i3c controller
> then?

Still not taken care of.

> Do we need to copy those to satisfy the requirements
> of the i3c layer?

I guess we should. The question is, should we do that unconditionally
or should we try to optimize thins with something like:

	if (!virt_addr_valid(xfer->buf) ||
	    object_is_on_stack(xfer->buf))
		/* Alloc bounce buf. */
	else
		/* Use provided buf. */
