Return-Path: <SRS0=71UW=JV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F412C6778C
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 15:13:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C8EDC24065
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 15:13:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C8EDC24065
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754253AbeGEPNY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Jul 2018 11:13:24 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:50084 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753699AbeGEPNW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jul 2018 11:13:22 -0400
Received: from localhost (D57D388D.static.ziggozakelijk.nl [213.125.56.141])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id E11B0BB6;
        Thu,  5 Jul 2018 15:13:21 +0000 (UTC)
Date:   Thu, 5 Jul 2018 17:13:19 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Pawel Laszczak <pawell@cadence.com>
Cc:     "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        Felipe Balbi <balbi@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Lukasz Tyrala <ltyrala@cadence.com>,
        Bartosz Folta <bfolta@cadence.com>
Subject: Re: [PATCH 09/15] Introduce Cadence USBSSP DRD Driver - added
 debugfs files.
Message-ID: <20180705151319.GB10795@kroah.com>
References: <1530647879-10007-1-git-send-email-pawell@cadence.com>
 <1530647879-10007-10-git-send-email-pawell@cadence.com>
 <20180704091524.GB25518@kroah.com>
 <BYAPR07MB4709412C63D2D9947F8EEFF4DD400@BYAPR07MB4709.namprd07.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BYAPR07MB4709412C63D2D9947F8EEFF4DD400@BYAPR07MB4709.namprd07.prod.outlook.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 05, 2018 at 09:44:27AM +0000, Pawel Laszczak wrote:
> > > Signed-off-by: Laszczak Pawel <pawell@cadence.com>
> > > ---
> > 
> > Again for all of these, you need a changelog text.
> > 
> > >  drivers/usb/usbssp/gadget-debugfs.c | 514
> > ++++++++++++++++++++++++++++
> > >  drivers/usb/usbssp/gadget-debugfs.h | 137 ++++++++
> > >  2 files changed, 651 insertions(+)
> > >  create mode 100644 drivers/usb/usbssp/gadget-debugfs.c
> > >  create mode 100644 drivers/usb/usbssp/gadget-debugfs.h
> > >
> > > diff --git a/drivers/usb/usbssp/gadget-debugfs.c
> > b/drivers/usb/usbssp/gadget-debugfs.c
> > > new file mode 100644
> > > index 000000000000..c0d1e96728e6
> > > --- /dev/null
> > > +++ b/drivers/usb/usbssp/gadget-debugfs.c
> > > @@ -0,0 +1,514 @@
> > > +// SPDX-License-Identifier: GPL-2.0
> > > +/*
> > > + * USBSSP device controller driver
> > > + *
> > > + * Copyright (C) 2018 Cadence.
> > > + *
> > > + * Author: Pawel Laszczak
> > > + * Some code borrowed from the Linux XHCI driver.
> > 
> > What code was borrowed?  Please acknowledge that copyright.
> 
> USBSSP controller is very similar to XHCI controller and 
> is mostly  compliance with XHCI specification.  
> In result, driver for device mode based on 
> drivers/usb/host/xhci* driver. 
> 
> Especially xhci.c, xhci-ring.c, xhci-mem.c , xhci-debugfs.c
> and xhci-trace.h was re-used. By borrowed I means that these 
> files have been taken from xhci driver and have been adopted
> in such way that it can be use for the device side. 
> Probably this sentence should looks like: 
> " A  lot of code based on Linux XHCI driver" ?

Be specific, just like you said so here.  And include the copyright
ownership of that code please, because it is relevant here.

> You know, the most of algorithm for handling transfer and
> memory management are the same as for XHCI driver.
> 
> Because the USB gadget API in kernel completely different 
> from Host USB API, so files had to been changed very much. 
> 
> What do you think by "Please acknowledge that copyright" ?
> 
> "
> The standard header for xhci driver looks like: 
> // SPDX-License-Identifier: GPL-2.0
> /*
>  * xHCI host controller driver PCI Bus Glue.
>  *
>  * Copyright (C) 2008 Intel Corp.
>  *
>  * Author: Sarah Sharp
>  * Some code borrowed from the Linux EHCI driver.
>  */
> "
> Should I add In my header:
> Copyright (C) 2018 Cadence. 
> Copyright (C) 2008 Intel Corp.
> 
> or something like this:
> .... 
> A  lot of code based on Linux XHCI driver
> Origin: Copyright (C) 2008 Intel Corp

Yes, that would be good.

thanks,

greg k-h
