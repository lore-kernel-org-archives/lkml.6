Return-Path: <SRS0=BZo9=L2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C829C070C3
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 19:36:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 25E662133F
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 19:36:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=upb.ro header.i=@upb.ro header.b="EsF1vIFL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 25E662133F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=upb.ro
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728204AbeIMAmm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Sep 2018 20:42:42 -0400
Received: from mail-sender200.upb.ro ([141.85.13.200]:35800 "EHLO mx.upb.ro"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727872AbeIMAmm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Sep 2018 20:42:42 -0400
Received: from mx.upb.ro (localhost [127.0.0.1])
        by mx.upb.ro (Postfix) with ESMTPS id E1B63B57CA4A;
        Wed, 12 Sep 2018 22:36:37 +0300 (EEST)
Received: from localhost (localhost [127.0.0.1])
        by mx.upb.ro (Postfix) with ESMTP id B9E99B566DC6;
        Wed, 12 Sep 2018 22:36:37 +0300 (EEST)
DKIM-Filter: OpenDKIM Filter v2.10.3 mx.upb.ro B9E99B566DC6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=upb.ro;
        s=96342B8A-77E4-11E5-BA93-D93D0963A2DF; t=1536780997;
        bh=e3zRgIrHUlmbStt2hPoQp2spzwbWa9QtwJqxLv4027A=;
        h=Message-ID:From:To:Date:Mime-Version;
        b=EsF1vIFLGduLvpTPfux8H7nV9lyE4Yr1v1R/dhwCGo6PCm3z/Jq6wsCpA9ZexBnq7
         j2kMB55WcEKzNMJMQB8kzGgwxzyaLAWFto/fpCvTIcJtUm8jFPc03TubNXZf45GXbb
         Cu4PxjlpwupRI2jBcBcKCvQWXT31RkgyxA+dP2nY=
Received: from mx.upb.ro ([127.0.0.1])
        by localhost (mx.upb.ro [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id riSnY_ru48Ge; Wed, 12 Sep 2018 22:36:37 +0300 (EEST)
Received: from sabertooth (unknown [188.27.118.63])
        by mx.upb.ro (Postfix) with ESMTPSA id 7F3CAB56345F;
        Wed, 12 Sep 2018 22:36:37 +0300 (EEST)
Message-ID: <a143edd3c0de2ba98b64e642b4384edf4323be2b.camel@upb.ro>
Subject: Re: [PATCH v12 0/6] Driver for at91 usart in spi mode
From:   Radu Pirea <radu_nicolae.pirea@upb.ro>
To:     Lee Jones <lee.jones@linaro.org>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        Mark Brown <broonie@kernel.org>, Jiri Slaby <jslaby@suse.com>,
        Richard Genoud <richard.genoud@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>,
        linux-spi <linux-spi@vger.kernel.org>
Date:   Wed, 12 Sep 2018 22:36:40 +0300
In-Reply-To: <20180912131248.GA21544@dell>
References: <20180911185839.GA25212@piout.net> <20180911224418.GK4185@dell>
         <20180911225440.GL4185@dell> <20180912073355.GB2557@piout.net>
         <20180912084143.GN4185@dell>
         <CAMuHMdWefU0pw=c9TKOa+wGHchpg8JRfE0OnC4+wKDt-qrbH1A@mail.gmail.com>
         <20180912105407.GR4185@dell> <20180912111757.GC2760@piout.net>
         <20180912114352.GT4185@dell> <20180912121420.GE2760@piout.net>
         <20180912131248.GA21544@dell>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2018-09-12 at 14:12 +0100, Lee Jones wrote:
> On Wed, 12 Sep 2018, Alexandre Belloni wrote:
> 
> > On 12/09/2018 12:43:52+0100, Lee Jones wrote:
> > > > > But ... we can't have it both ways.  *Either* it's a true
> > > > > MFD, in
> > > > > which case it can/should have 2 separate compatible strings
> > > > > which can
> > > > > be specified directly from the DT.  *Or* it's not an MFD.  In
> > > > > the
> > > > > latter case, which I think we're all agreeing on (else we'd
> > > > > have 2
> > > > > compatible strings), MFD is not the place to handle this (my
> > > > > original
> > > > > point).
> > > > > 
> > > > 
> > > > If that is what bothers you, then let's move it out of mfd.
> > > 
> > > As I've already mentioned.  I don't just want it moved out of MFD
> > > and
> > > shoved somewhere else.  My aim is to fix this properly.
> > > 
> > 
> > If it is out of MFD, then I'm not sure why you would care too much
> > about
> > it as you won't be maintaining that code. And I still this what was
> > done
> > was correct but I'm open to test what you suggest.
> 
> I care for the kernel in general, not just the areas I'm responsible
> for.  I guess I'm just that kinda guy! ;)

Well, Lee, like you, I think this driver should not be a MFD driver,
but Alex has a good point of view. 

> 
> > > > > So ... this is a USART device which can do SPI, right?
> > > > > 
> > > > > My current thinking is that; as this is a USART device first
> > > > > &
> > > > > foremost, the USART should be probed in the first instance
> > > > > regardless,
> > > > > then if SPI mode is specified it (the USART driver) registers
> > > > > the SPI
> > > > > platform driver (as MFD does currently) and exits gracefully,
> > > > > allowing
> > > > > the SPI driver to take over.
> > > > > 
> > > > > Spanner in the works: is it physically possible to change the
> > > > > mode at
> > > > > run-time?  :s
> > > > 
> > > > Yes it is possible but on Linux that will not happen without
> > > > probing
> > > > the drivers again.
> > > 
> > > Not sure I understand what you mean.
> > 
> > I was just commenting on changing the mode at runtime.
> 
> Oh I see.  My question was relating to whether the H/W is physically
> capable of changing modes on-the-fly, rather than how Linux would
> handle that.  If this is something we'd wish to support, then it
> would
> have to be a single driver, which is why I was asking.  By separating
> the drivers this way, we are blocking that as a
> possibility.  Although
> I guess the OP has already thought about that and made the decision
> not to support it.

Is possible to change modes on-the-fly, but you have no reason to do
that. On the PCB you will have a SPI slave or a serial console :)
Anyway, the current form of the driver, and through this I want to say
"this ugly hack", allows the user to switch from serial to SPI mode by
adding only one property to the device tree node of USART. If the
driver were in his first form, a simple SPI driver, how you will make a
dtsi file for an IP like this? You will add two nodes for the same IP
in dtsi and will take care to enable correct node in dts?
I think this driver is only a tradeoff between having an ugly hack in
kernel or having an messy device tree.

> 
> > > I'm suggesting that you use the same platform_* interfaces MFD
> > > uses to
> > > register the SPI driver if SPI mode has been selected.  Only do
> > > so
> > > from the appropriate driver i.e. USART.
> > 
> > Yeah, I understood that but I didn't comment because I'm not sure
> > this
> > will work yet.
> 
> Other drivers already do this.

Can you give me an example please?
I am open to suggestions.

Sorry for that acked-by. There was a lot of "reviewed-by", "acked-by",
etc in a single version and I messed up :).

