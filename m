Return-Path: <SRS0=iNRz=MO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B8C9C64EBC
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 22:09:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DC6202083F
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 22:09:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DC6202083F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727276AbeJCEzL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Oct 2018 00:55:11 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:41676 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725744AbeJCEzL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Oct 2018 00:55:11 -0400
Received: from localhost (unknown [64.124.202.226])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id D5B28F1F;
        Tue,  2 Oct 2018 22:09:38 +0000 (UTC)
Date:   Tue, 2 Oct 2018 15:09:37 -0700
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Lidza Louina <lidza.louina@gmail.com>
Cc:     markh@compro.net, Sehro Rautenkranz <sehro@sehro.org>,
        driverdev-devel@linuxdriverproject.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] staging: dgnc: Fix Kconfig help header and text
Message-ID: <20181002220937.GA29970@kroah.com>
References: <59f16a7e-4221-73e0-cf6e-3461717be318@infradead.org>
 <20180925234159.22547-1-sehro@sehro.org>
 <CA+t4uCMAgpNtpdLfxNY_cmx7WONKOYjiaTBDGRNd+7H_GUdRAA@mail.gmail.com>
 <cdd97ca9-68c8-3a5e-faa1-d19cd5fe93a7@compro.net>
 <CA+t4uCPFZSTjyN-Wd3ppOp-edAXfSSTTdT8uab+-E53=Htv9+A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+t4uCPFZSTjyN-Wd3ppOp-edAXfSSTTdT8uab+-E53=Htv9+A@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 01, 2018 at 12:49:50PM -0400, Lidza Louina wrote:
> On Mon, Oct 1, 2018 at 8:09 AM Mark Hounschell <markh@compro.net> wrote:
> 
> > On 9/28/18 3:59 PM, Lidza Louina wrote:
> > > I haven't done work on this driver in a long time. I looked up the
> > > devices, and they seem to already have an existing Linux driver:
> > >
> > https://www.digi.com/products/usb-and-serial-connectivity/serial-cards/digineo and
> >
> > > https://www.digi.com/support/productdetail?pid=1694
> > >
> > > I've contacted the company to see if the driver is still needed in
> > > staging. I'll send an update once they get back to me.
> > >
> > > Lidza
> > >
> >
> > Good luck with that. Digi obsoleted ALL their PCI serial cards several
> > months ago. They would not even respond to requests from me to include
> > their firmware for their PCI dgap cards into the kernel firmware
> > package. The card for the dgnc driver is a pci-e card that may still be
> > supported by them however. Also there does appear to be an already in
> > kernel driver for these "PCI-e" cards too. It actually works as I have a
> > couple of these cards. The module name is "jsm".
> >
> >
> > 03:00.0 Serial controller: Digi International Device 00f0 (rev 02)
> > (prog-if 02 [16550])
> >          Subsystem: Digi International Device 00f0
> >          Control: I/O- Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop-
> > ParErr- Stepping- SERR- FastB2B- DisINTx-
> >          Status: Cap+ 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort-
> > <TAbort- <MAbort- >SERR- <PERR- INTx-
> >          Interrupt: pin A routed to IRQ 29
> >          Region 0: Memory at f7200000 (32-bit, non-prefetchable) [size=4K]
> >          Capabilities: [40] Power Management version 2
> >                  Flags: PMEClk+ DSI- D1- D2- AuxCurrent=0mA
> > PME(D0-,D1-,D2-,D3hot+,D3cold-)
> >                  Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
> >          Kernel driver in use: jsm
> >          Kernel modules: jsm
> >
> >
> > Regards
> > Mark
> >
> 
> Thanks for the heads up Mark. I've totally neglected this driver and should
> have caught this earlier. I'm okay with removing it from staging. We can
> bring it back if they need it.

Ok, I'll go delete it, thanks.

greg k-h
