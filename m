Return-Path: <SRS0=HMm1=J4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99BB7C43A1D
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 08:05:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4AFA020C0C
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 08:05:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4AFA020C0C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732361AbeGLINb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Jul 2018 04:13:31 -0400
Received: from mail.bootlin.com ([62.4.15.54]:52605 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726896AbeGLINa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jul 2018 04:13:30 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 00F732074F; Thu, 12 Jul 2018 10:05:02 +0200 (CEST)
Received: from bbrezillon (AAubervilliers-681-1-12-56.w90-88.abo.wanadoo.fr [90.88.133.56])
        by mail.bootlin.com (Postfix) with ESMTPSA id AFB2420618;
        Thu, 12 Jul 2018 10:04:35 +0200 (CEST)
Date:   Thu, 12 Jul 2018 10:04:34 +0200
From:   Boris Brezillon <boris.brezillon@bootlin.com>
To:     Peter Rosin <peda@axentia.se>
Cc:     Arnd Bergmann <arnd@arndb.de>, Wolfram Sang <wsa@the-dreams.de>,
        linux-i2c@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
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
        Xiang Lin <Xiang.Lin@synaptics.com>, linux-gpio@vger.kernel.org
Subject: Re: [PATCH v4 01/10] i3c: Add core I3C infrastructure
Message-ID: <20180712100434.79f1e962@bbrezillon>
In-Reply-To: <a31dc625-56bf-7a59-d9a3-2841360b864e@axentia.se>
References: <20180330074751.25987-1-boris.brezillon@bootlin.com>
        <20180330074751.25987-2-boris.brezillon@bootlin.com>
        <CAK8P3a1aZXf2sQW2mgwJScycKPhdoOAwxRjm5cQG83513uc3fg@mail.gmail.com>
        <20180711164120.3e32fb08@bbrezillon>
        <CAK8P3a2EZB_tMS_47wv6M2Qpm79ZocxxhG5zLxXsBM_YjZgkyA@mail.gmail.com>
        <20180711191212.3855bb25@bbrezillon>
        <a31dc625-56bf-7a59-d9a3-2841360b864e@axentia.se>
X-Mailer: Claws Mail 3.15.0-dirty (GTK+ 2.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 12 Jul 2018 06:41:15 +0200
Peter Rosin <peda@axentia.se> wrote:

> [tried to send something like this yesterday, but it appears to have been
> lost, sorry for any duplicate]
> 
> On 2018-07-11 19:12, Boris Brezillon wrote:
> > On Wed, 11 Jul 2018 17:39:56 +0200
> > Arnd Bergmann <arnd@arndb.de> wrote:
> >   
> >> On Wed, Jul 11, 2018 at 4:41 PM, Boris Brezillon
> >> <boris.brezillon@bootlin.com> wrote:  
> >>> On Wed, 11 Jul 2018 16:01:56 +0200 Arnd Bergmann <arnd@arndb.de> wrote:    
> >>>>> - the bus element is a separate object and is not implicitly described
> >>>>>   by the master (as done in I2C). The reason is that I want to be able
> >>>>>   to handle multiple master connected to the same bus and visible to
> >>>>>   Linux.
> >>>>>   In this situation, we should only have one instance of the device and
> >>>>>   not one per master, and sharing the bus object would be part of the
> >>>>>   solution to gracefully handle this case.
> >>>>>   I'm not sure we will ever need to deal with multiple masters
> >>>>>   controlling the same bus and exposed under Linux, but separating the
> >>>>>   bus and master concept is pretty easy, hence the decision to do it
> >>>>>   like that.
> >>>>>   The other benefit of separating the bus and master concepts is that
> >>>>>   master devices appear under the bus directory in sysfs.    
> >>>>
> >>>> I'm not following here at all, sorry for missing prior discussion if this
> >>>> was already explained. What is the "multiple master" case? Do you
> >>>> mean multiple devices that are controlled by Linux and that each talk
> >>>> to other devices on the same bus, multiple operating systems that
> >>>> have talk to are able to own the bus with the kernel being one of
> >>>> them, a controller that controls multiple independent buses,
> >>>> or something else?    
> >>>
> >>> I mean several masters connected to the same bus and all exposed to the
> >>> same Linux instance. In this case, the question is, should we have X
> >>> I3C buses exposed (X being the number of masters) or should we only
> >>> have one?
> >>>
> >>> Having a bus represented as a separate object allows us to switch to
> >>> the "one bus : X masters" representation if we need too.    
> >> ...  
> >>>>
> >>>> This feels a bit odd: so you have bus_type that can contain devices
> >>>> of three (?) different device types: i3c_device_type, i3c_master_type
> >>>> and i3c_busdev_type.
> >>>>
> >>>> Generally speaking, we don't have a lot of subsystems that even
> >>>> use device_types. I assume that the i3c_device_type for a
> >>>> device that corresponds to an endpoint on the bus, but I'm
> >>>> still confused about the other two, and why they are part of
> >>>> the same bus_type.    
> >>>
> >>> i3c_busdev is just a virtual device representing the bus itself.
> >>> i3c_master is representing the I3C master driving the bus. The reason
> >>> for having a different type here is to avoid attaching this device to a
> >>> driver but still being able to see the master controller as a device on
> >>> the bus. And finally, i3c_device are all remote devices that can be
> >>> accessed through a given i3c_master.
> >>>
> >>> This all comes from the design choice I made to represent the bus as a
> >>> separate object in order to be able to share it between different
> >>> master controllers exposed through the same Linux instance. Since
> >>> master controllers are also remote devices for other controllers, we
> >>> need to represent them.    
> >>
> >> Ok, so I think this is the most important question to resolve: do we
> >> actually need to control multiple masters on a single bus from one OS
> >> or not?
> >>
> >> The problem that I see is that it breaks the tree abstraction that
> >> we use in the dtb interface, in the driver model and in sysfs.
> >> If we need to deal with a hardware bus structure like
> >>
> >>               cpu
> >>              /   \
> >>             /     \
> >>        platdev   platdev
> >>            |        |
> >>      i3c-master   i3c-master
> >>             \      /
> >>              \    /
> >>             i3c-bus
> >>              /    \
> >>          device   device
> >>
> >> then that abstraction no longer holds. Clearly you could build
> >> a system like that, and if we have to support it, the i3c infrastructure
> >> should be prepared for it, since we wouldn't be able to retrofit
> >> it later.  
> > 
> > Exactly. For the DT representation I thought we could have the primary
> > master hold the device nodes, and then have secondary masters reference
> > the main master with a phandle (i3c-bus = <&main_i3c_master>;). For the
> > sysfs representation, it would be the same. Only one of the master
> > would create the i3c_bus object and the other masters would just
> > reference it.
> >   
> >>
> >> What would be the point of building such a system though?  
> > 
> > This, I don't know. But as you said, if we go for a "one bus per
> > master" representation, going back will be difficult.
> >   
> >> Is this for performance, failover, or something else?  
> > 
> > No, I don't think so, especially since the mastership handover
> > operation is not free. So keeping the same master in control is
> > probably better in term of perfs.
> > 
> > One case I can think of is when the primary master does not have enough
> > resources to address all devices on the bus, and let the secondary
> > master handle all transactions targeting those devices.
> >   
> >> IOW, what feature would we lose if we were to declare that
> >> setup above invalid (and ensure you cannot represent it in DT)?  
> > 
> > That's exactly the sort of discussion I wanted to trigger. Maybe we
> > shouldn't care and expose this use case as if it was X different I3C
> > buses (with all devices present on the bus being exposed X times to the
> > system).  
> 
> For I2C, this multiple masters for one bus case was retrofitted in
> the i2c-demux-pinctrl driver. It's a huge kludge with a number of
> undesirable quirks. I don't know if the circumstances for adding
> this I2C driver also applies for I3C,

It's hard to guess now.

> but it might be an argument
> in favor of the proposed extra bus object...

I know that Wolfram was in favor of this separate bus <-> master
representation, probably because of his experience with this particular
driver.

