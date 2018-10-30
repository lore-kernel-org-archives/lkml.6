Return-Path: <SRS0=BpFy=NK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: *
X-Spam-Status: No, score=1.0 required=3.0 tests=FUZZY_XPILL,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E21EBC6786F
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 19:40:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AC95C20657
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 19:40:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AC95C20657
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=v3.sk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727668AbeJaEfk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Oct 2018 00:35:40 -0400
Received: from shell.v3.sk ([90.176.6.54]:49499 "EHLO shell.v3.sk"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726072AbeJaEfk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Oct 2018 00:35:40 -0400
Received: from localhost (localhost [127.0.0.1])
        by zimbra.v3.sk (Postfix) with ESMTP id 648FFC48A9;
        Tue, 30 Oct 2018 20:40:44 +0100 (CET)
Received: from shell.v3.sk ([127.0.0.1])
        by localhost (zimbra.v3.sk [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id lPgAu88fNFlh; Tue, 30 Oct 2018 20:40:41 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by zimbra.v3.sk (Postfix) with ESMTP id 53E53C48AA;
        Tue, 30 Oct 2018 20:40:41 +0100 (CET)
X-Virus-Scanned: amavisd-new at zimbra.v3.sk
Received: from shell.v3.sk ([127.0.0.1])
        by localhost (zimbra.v3.sk [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id EViGJRb0AfFv; Tue, 30 Oct 2018 20:40:40 +0100 (CET)
Received: from odvarok.lan (ip-89-102-31-34.net.upcbroadband.cz [89.102.31.34])
        by zimbra.v3.sk (Postfix) with ESMTPSA id 3226CC48A9;
        Tue, 30 Oct 2018 20:40:40 +0100 (CET)
Message-ID: <2761d7e31cf7118492e466a5249303c92f68049b.camel@v3.sk>
Subject: Re: [PATCH v2 0/8] OLPC 1.75 Keyboard/Touchpad fixes
From:   Lubomir Rintel <lkundrak@v3.sk>
To:     Pavel Machek <pavel@ucw.cz>
Cc:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Stephen Boyd <sboyd@kernel.org>,
        James Cameron <quozl@laptop.org>, linux-input@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org
Date:   Tue, 30 Oct 2018 20:40:38 +0100
In-Reply-To: <20181030102610.GC21529@amd>
References: <20181010142504.233467-1-lkundrak@v3.sk>
         <20181015195612.GB29649@amd>
         <c4edf9b09e88cd265a0829644aa962c28cbc3d51.camel@v3.sk>
         <20181030100139.GB21529@amd> <20181030102610.GC21529@amd>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.1 (3.30.1-1.fc29) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Pavel,

On Tue, 2018-10-30 at 11:26 +0100, Pavel Machek wrote:
> Hi!
> 
> > > https://github.com/hackerspace/olpc-xo175-linux/wiki/How-to-run-an-up-to-date-Linux-on-a-XO-1.75
> > > 
> > > I didn't test it yet -- will do when I get home in the evening.
> > > But
> > > chances are it's good enough and I guess you'd be able to get it
> > > working even if I messed up some details.
> 
> Instruction say make, but you really need to do make zImage and make
> mmp2-olpc-xo-1-75.dtb .

Have you tried? I'm typically doing just a plain "make".

According to "make help", a plain "make" (assuming it's equivalent to
"make all") includes "zImage" and "dtbs" targets.

> 
> Instructions say "make -j", which is nice way to crash a machine. I
> suggest "make -j 8" :-).

Holy... what sort of a machine do you have?

> Ok, I think I followed the instructions. I am using empty root
> filesystem, just with /boot -- want to see kernel messages first
> before I mess with the userland.
> 
> But I don't get kernel messages during boot:
> 
> OLPC 1B1, 512 MiB memory...
> OpenFirmware Q4C02 EC Frimware 0.3.02

"Frimware" -- I assume you don't have a serial console hooked on? :)

Doesn't matter though, your OF doesn't seem to even get to load the
kernel anyways. And the framebuffer console (though only by the means
of a hacked pxa168fb for the time being, no armada drm yet) works.

Here's my bootup banner:

OLPC 1B1, 800 MHz, 512 MiB memory, 4 GB internal storage...
OpenFirmware  Q4D38   EC Firmware 1.0.01   2018-10-30 19:11:36 UTC

I seem to have a bit newer OF.

> Type any key to interrupt...
> (but keys do not interrupt anything, ouch).

In my version of the OLPC OF the routine is replaced with one that only
accepts the Escape key, because kids like to press random keys without
really wanting a shell. Maybe try that one?

Although my prompt is also a bit different: "Type the Esc key to
interrupt automatic startup"

> Warning... partition type is 0xb...
> Boot device: /usb/disk:\boot\olpc.fth Arguments:
> Boot device ....
> Warning... partition type is 0xb...

Maybe the older version wouldn't support a VFAT volume, hence the
complains about the id=0xb volume? Try ext3?
> 
> And that's it, cursor and no kernel messages.
> 
> Any ideas?
> 
> Could I get prepared binary zImage for testing?

https://github.com/hackerspace/olpc-xo175-buildroot/releases

Here's a SD card image that works for me. The topmost commit in the
same repository is the build configuration that was used to generate
it:

https://github.com/hackerspace/olpc-xo175-buildroot/commit/71783d599.patch

Note it is only going to boot off the SD card, because the root=
argument is hardwired in the devicetree. Sorry about that -- I built
the image before I noticed you're booting off an USB stick and I don't
have the resources to regenerate the image at the moment.

If this won't boot for you, we may need fixes for older FW. Until then
it might be a good idea if you just update to the latest one (it is as
easy as booting the last version of the stock distro with a charged
battery pack).

> Thanks.							
>
> 		
> Pavel

Take care
Lubo

