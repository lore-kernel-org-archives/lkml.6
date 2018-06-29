Return-Path: <SRS0=sqHT=JP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD820C43141
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 14:45:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 89B1F27FDC
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 14:45:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=verge.net.au header.i=@verge.net.au header.b="ag5fQuqg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 89B1F27FDC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=verge.net.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935862AbeF2OpN (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Jun 2018 10:45:13 -0400
Received: from kirsty.vergenet.net ([202.4.237.240]:45939 "EHLO
        kirsty.vergenet.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934656AbeF2OpL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jun 2018 10:45:11 -0400
Received: from reginn.horms.nl (watermunt.horms.nl [80.127.179.77])
        by kirsty.vergenet.net (Postfix) with ESMTPA id A1A8125B7B9;
        Sat, 30 Jun 2018 00:45:08 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=verge.net.au; s=mail;
        t=1530283508; bh=vYdxUDG85rQxjdovn/q9n0KtVLDvEKF9IvlP6wVuvoY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ag5fQuqgpNn9foeRRKvW9uLCTo+k3n80AcVY3U1jjmEDVWz0tB/9oyzijvW+Xm1fc
         OXW1VoEmC3Jvi8RFHjxc9Zwn0Ufqf77i6Gwv5UNRkyOAp1RYxB54jdNy5puYQN35Lk
         czOgaV6rlJa1eq1lCXRmtRgm3JChUmKApF479xkU=
Received: by reginn.horms.nl (Postfix, from userid 7100)
        id A3618940760; Fri, 29 Jun 2018 16:45:06 +0200 (CEST)
Date:   Fri, 29 Jun 2018 16:45:06 +0200
From:   Simon Horman <horms@verge.net.au>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Michel Pollet <michel.pollet@bp.renesas.com>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        Phil Edworthy <phil.edworthy@renesas.com>,
        Michel Pollet <buserror+upstream@gmail.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        linux-clk <linux-clk@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v9 3/5] ARM: dts: Renesas R9A06G032 base device tree file
Message-ID: <20180629144505.xcencoba4ru6tiee@verge.net.au>
References: <1528973829-25493-1-git-send-email-michel.pollet@bp.renesas.com>
 <1528973829-25493-4-git-send-email-michel.pollet@bp.renesas.com>
 <20180628120031.eq2yuysz4re2olwn@verge.net.au>
 <20180628121609.jf4dp4azeowte7pb@verge.net.au>
 <CAMuHMdWqowQjZ8Wsdj6ne-+UG8-OY_j6pi3R9JPP6L7ZgRhvBQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMuHMdWqowQjZ8Wsdj6ne-+UG8-OY_j6pi3R9JPP6L7ZgRhvBQ@mail.gmail.com>
Organisation: Horms Solutions BV
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 28, 2018 at 02:45:41PM +0200, Geert Uytterhoeven wrote:
> Hi Simon,
> 
> On Thu, Jun 28, 2018 at 2:16 PM Simon Horman <horms@verge.net.au> wrote:
> > On Thu, Jun 28, 2018 at 02:00:32PM +0200, Simon Horman wrote:
> > > On Thu, Jun 14, 2018 at 11:56:32AM +0100, Michel Pollet wrote:
> > > > This adds the Renesas R9A06G032 bare bone support.
> > > >
> > > > This currently only handles the SYSCTRL block note,
> > > > generic parts (gic, architected timer) and a UART.
> > > >
> > > > Signed-off-by: Michel Pollet <michel.pollet@bp.renesas.com>
> > > > Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
> > > > Reviewed-by: Simon Horman <horms+renesas@verge.net.au>
> > >
> > > Thanks, applied with the following appended:
> > >
> > > diff --git a/MAINTAINERS b/MAINTAINERS
> > > index 9d5eeff51b5f..4c85ac04872d 100644
> > > --- a/MAINTAINERS
> > > +++ b/MAINTAINERS
> > > @@ -1969,6 +1969,7 @@ S:      Supported
> > >  F:   arch/arm/boot/dts/emev2*
> > >  F:   arch/arm/boot/dts/r7s*
> > >  F:   arch/arm/boot/dts/r8a*
> > > +F:   arch/arm/boot/dts/r9a*
> > >  F:   arch/arm/boot/dts/sh*
> > >  F:   arch/arm/configs/shmobile_defconfig
> > >  F:   arch/arm/include/debug/renesas-scif.S
> >
> > One more update.
> >
> > dt-bindings/clock/r9a06g032-sysctrl.h is not present in v4.18-rc1,
> > current base of the renesas tree and likely base for the rest of the v4.19
> > development cycle.
> >
> > Accordingly I have removed the include of that header and replaced
> > the use of symbols it defines with numeric constants. The result is below.
> 
> Oh right. Thanks!
> 
> > Please:
> > 1) Check that this is correct and
> 
> Looks good to me, except for the bogus "fixes" and "SoB" below
> (bad squash?)
> 
> > From: Michel Pollet <michel.pollet@bp.renesas.com>
> > Subject: [PATCH] ARM: dts: Renesas R9A06G032 base device tree file
> >
> > This adds the Renesas R9A06G032 bare bone support.
> >
> > This currently only handles the SYSCTRL block note,
> > generic parts (gic, architected timer) and a UART.
> >
> > Signed-off-by: Michel Pollet <michel.pollet@bp.renesas.com>
> > Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
> > [simon: updated MAINTAINERS file
> > [simon: do not use r9a06g032-sysctrl.h as it is not in the renesas tree yet]
> > Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
> >
> > fixes
>   ^^^^^
> >
> > Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
>   ^^^^
> 
> Gr{oetje,eeting}s,

Thanks, I'll remove that trailing garbage.
