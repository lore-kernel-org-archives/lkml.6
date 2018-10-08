Return-Path: <SRS0=fRGm=MU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E446C65C20
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 16:48:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DC8DA214DA
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 16:48:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DC8DA214DA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=angband.pl
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726486AbeJIAAx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Oct 2018 20:00:53 -0400
Received: from tartarus.angband.pl ([54.37.238.230]:41120 "EHLO
        tartarus.angband.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726291AbeJIAAw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Oct 2018 20:00:52 -0400
Received: from kilobyte by tartarus.angband.pl with local (Exim 4.89)
        (envelope-from <kilobyte@angband.pl>)
        id 1g9YhX-000161-2O; Mon, 08 Oct 2018 18:48:11 +0200
Date:   Mon, 8 Oct 2018 18:48:11 +0200
From:   Adam Borowski <kilobyte@angband.pl>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, x86@kernel.org,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] x86/defconfig: Enable CONFIG_USB_XHCI_HCD
Message-ID: <20181008164811.oydbuy2xu2d72y5f@angband.pl>
References: <20181008103223.15362-1-kilobyte@angband.pl>
 <20181008131944.GB20703@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20181008131944.GB20703@kroah.com>
X-Junkbait: aaron@angband.pl, zzyx@angband.pl
User-Agent: NeoMutt/20170113 (1.7.2)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: kilobyte@angband.pl
X-SA-Exim-Scanned: No (on tartarus.angband.pl); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 08, 2018 at 03:19:44PM +0200, Greg Kroah-Hartman wrote:
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

IIRC Gentoo even suggests it in the install instructions (although I
haven't looked at Gentoo in quite a while).  Other distros have handcrafted
approximations of allmodconfig.
 
> > +CONFIG_USB_XHCI_HCD=y
> >  CONFIG_USB_EHCI_HCD=y
> >  CONFIG_USB_OHCI_HCD=y
> 
> You can probably turn ehci and ohci off if you have xhci in the
> "default" system now.

Besides mixed wiring (as Alan and Randy mentioned), some machines without
USB3 are still usable.  I haven't upgraded my home machine in ages -- yet
despite it being an ancient Phenom2 x6 it builds defconfig in 6m 13s while
this fresh work box in 3m something.  Defconfig is supposed to handle a wide
range of common hardware, so keeping support for 2011 stuff would be wise.

As for !x86, I see that defconfigs for non-fringe archs already enable XHCI.


Meow!
-- 
⢀⣴⠾⠻⢶⣦⠀ 
⣾⠁⢰⠒⠀⣿⡁ 10 people enter a bar: 1 who understands binary,
⢿⡄⠘⠷⠚⠋⠀ 1 who doesn't, D who prefer to write it as hex,
⠈⠳⣄⠀⠀⠀⠀ and 1 who narrowly avoided an off-by-one error.
