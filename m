Return-Path: <SRS0=fRGm=MU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CF00C65C20
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 15:20:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E05352075E
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 15:20:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E05352075E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=rowland.harvard.edu
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726510AbeJHWcf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Oct 2018 18:32:35 -0400
Received: from netrider.rowland.org ([192.131.102.5]:60075 "HELO
        netrider.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with SMTP id S1726451AbeJHWcf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Oct 2018 18:32:35 -0400
Received: (qmail 28855 invoked by uid 500); 8 Oct 2018 11:20:22 -0400
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 8 Oct 2018 11:20:22 -0400
Date:   Mon, 8 Oct 2018 11:20:22 -0400 (EDT)
From:   Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@netrider.rowland.org
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
cc:     Adam Borowski <kilobyte@angband.pl>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, <x86@kernel.org>,
        <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] x86/defconfig: Enable CONFIG_USB_XHCI_HCD
In-Reply-To: <20181008131944.GB20703@kroah.com>
Message-ID: <Pine.LNX.4.44L0.1810081117030.28294-100000@netrider.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 8 Oct 2018, Greg Kroah-Hartman wrote:

> On Mon, Oct 08, 2018 at 12:32:23PM +0200, Adam Borowski wrote:
> > A spanking new machine I just got has all but one USB ports wired as 3.0.
> > Booting defconfig resulted in no keyboard or mouse, which was pretty
> > uncool.  Let's enable that -- USB3 is ubiquitous rather than an oddity.
> > As 'y' not 'm' -- recovering from initrd problems needs a keyboard.
> > 
> > Signed-off-by: Adam Borowski <kilobyte@angband.pl>
> > ---
> >  arch/x86/configs/x86_64_defconfig | 1 +
> >  1 file changed, 1 insertion(+)
> 
> defconfig for x86 actually still works?  That's amazing in itself :)
> 
> > diff --git a/arch/x86/configs/x86_64_defconfig b/arch/x86/configs/x86_64_defconfig
> > index e32fc1f274d8..ac9ae487cfeb 100644
> > --- a/arch/x86/configs/x86_64_defconfig
> > +++ b/arch/x86/configs/x86_64_defconfig
> > @@ -243,6 +243,7 @@ CONFIG_USB_HIDDEV=y
> >  CONFIG_USB=y
> >  CONFIG_USB_ANNOUNCE_NEW_DEVICES=y
> >  CONFIG_USB_MON=y
> > +CONFIG_USB_XHCI_HCD=y
> >  CONFIG_USB_EHCI_HCD=y
> >  CONFIG_USB_EHCI_TT_NEWSCHED=y
> >  CONFIG_USB_OHCI_HCD=y
> 
> You can probably turn ehci and ohci off if you have xhci in the
> "default" system now.

Heh.  My office PC has both EHCI and xHCI controllers, but it uses xHCI
_only_ for SuperSpeed devices, and only on some of the ports.  Not a
combination I have heard of anywhere else.  Enabling xHCI without EHCI
on that computer would be a bad idea.  :-)

Alan Stern

