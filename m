Return-Path: <SRS0=k9B+=NF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73726C46475
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 16:30:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4259320856
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 16:30:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4259320856
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728465AbeJZBDk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Oct 2018 21:03:40 -0400
Received: from mail.bootlin.com ([62.4.15.54]:51171 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728427AbeJZBDj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Oct 2018 21:03:39 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 48170208CD; Thu, 25 Oct 2018 18:30:06 +0200 (CEST)
Received: from bbrezillon (91-160-177-164.subs.proxad.net [91.160.177.164])
        by mail.bootlin.com (Postfix) with ESMTPSA id 7971F2072D;
        Thu, 25 Oct 2018 18:30:05 +0200 (CEST)
Date:   Thu, 25 Oct 2018 18:30:05 +0200
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
Message-ID: <20181025183005.3c0fa452@bbrezillon>
In-Reply-To: <CAK8P3a02ELWiMB_pe0bzbsMfdqYOG1G0bFnSHzGu3ZbQHatH2w@mail.gmail.com>
References: <20181022133404.2061-1-boris.brezillon@bootlin.com>
        <20181022133404.2061-7-boris.brezillon@bootlin.com>
        <20181024202048.7e3534f7@bbrezillon>
        <CAK8P3a2DBgfvXs-9KzoDvbQpV+VN96xb7xHG-5=NDDgnt7ViVQ@mail.gmail.com>
        <20181025180720.1790f6a1@bbrezillon>
        <CAK8P3a02ELWiMB_pe0bzbsMfdqYOG1G0bFnSHzGu3ZbQHatH2w@mail.gmail.com>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 25 Oct 2018 18:13:51 +0200
Arnd Bergmann <arnd@arndb.de> wrote:

> On Thu, Oct 25, 2018 at 6:07 PM Boris Brezillon
> <boris.brezillon@bootlin.com> wrote:
> >
> > On Thu, 25 Oct 2018 17:30:26 +0200
> > Arnd Bergmann <arnd@arndb.de> wrote:
> >  
> > > On 10/24/18, Boris Brezillon <boris.brezillon@bootlin.com> wrote:  
> > > > Hi Arnd,
> > > >
> > > > On Mon, 22 Oct 2018 15:34:01 +0200
> > > > Boris Brezillon <boris.brezillon@bootlin.com> wrote:
> > > >
> > > >  
> > > >> +
> > > >> +static void cdns_i3c_master_rd_from_rx_fifo(struct cdns_i3c_master
> > > >> *master,
> > > >> +                                      u8 *bytes, int nbytes)
> > > >> +{
> > > >> +  readsl(master->regs + RX_FIFO, bytes, nbytes / 4);  
> > > >
> > > > Vitor reported a problem with readsl(): this function expects the 2nd
> > > > argument to be aligned on 32-bit, which is not guaranteed here. Unless
> > > > you see a better solution, I'll switch back to a loop doing:
> > > >
> > > >     for (i = 0; i < nbytes; i += 4) {
> > > >             u32 tmp = __raw_readl(...);
> > > >             memcpy(bytes + i, &tmp,
> > > >                    nbytes - i  > 4 ? 4 : nbytes - i);
> > > >     }  
> > >
> > > Could we maybe mandate that the buffer itself must be aligned here?
> > > What would be a reason why we see an unaligned target buffer?  
> >
> > Well, the buffers we pass to i3c_send_ccc_cmd() are not necessarily
> > aligned because they're not dynamically allocated (allocated on the
> > stack) and are not naturally aligned on 32-bits (either because they
> > are smaller than 32bits or because the struct is declared __packed).
> >
> > I guess I could dynamically allocate the payload, but that requires
> > going over all users of i3c_send_ccc_cmd() to patch them.  
> 
> This reminds me that Wolfram mentioned in his ELC talk that the
> buffers on i3c should all be DMA capable to make life easier for
> i3c master drivers that want to implement DMA transfers.

And this is the case for all buffers passed to
i3c_device_do_priv_xfers() (and soon i3c_device_send_hdr_cmd()),
but I did not enforce that for the internal
i3c_master_send_ccc_cmd_locked() helper, maybe I should...
It was just convenient to place the object to be transmitted/received on
the stack.

> 
> If we have buffers here that are not aligned to cache lines
> (or even just 32 bit words), doesn't that also mean that the
> same buffers are not DMA capable either?

Yep, if it's not cache-line-aligned (and on the stack), it's not
DMA-able.
