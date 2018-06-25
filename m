Return-Path: <SRS0=Q/hc=JL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BAADAC43142
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 09:42:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 63FB3256E4
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 09:42:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=verge.net.au header.i=@verge.net.au header.b="k2vhN5tX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 63FB3256E4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=verge.net.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754970AbeFYJm4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Jun 2018 05:42:56 -0400
Received: from kirsty.vergenet.net ([202.4.237.240]:49246 "EHLO
        kirsty.vergenet.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754682AbeFYJmz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jun 2018 05:42:55 -0400
Received: from reginn.horms.nl (watermunt.horms.nl [80.127.179.77])
        by kirsty.vergenet.net (Postfix) with ESMTPA id 0785825AD81;
        Mon, 25 Jun 2018 19:42:53 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=verge.net.au; s=mail;
        t=1529919773; bh=cW27WSAX65/IVhvtrTb0tZysls7O9dLXoAtnW3D4q4Q=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=k2vhN5tX8Ia6z9WAvr8dVdY02JwnvC9nSpng/wQygOgwoYm4K3x+AecrLV+TIR9tI
         CC+27VYq5tf8DKmCCBPR8hfvI77tXB8SvWSQMLaoUIyEvjDgdMEZlkpAo2Kh4PFL22
         wNI0M50ZKgr0R8MiJIkmubVSz+Fx+ghXFqp6z32I=
Received: by reginn.horms.nl (Postfix, from userid 7100)
        id F391D940660; Mon, 25 Jun 2018 11:42:50 +0200 (CEST)
Date:   Mon, 25 Jun 2018 11:42:50 +0200
From:   Simon Horman <horms@verge.net.au>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Michel Pollet <michel.pollet@bp.renesas.com>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        Phil Edworthy <phil.edworthy@renesas.com>,
        Michel Pollet <buserror+upstream@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Magnus Damm <magnus.damm@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Andy Gross <andy.gross@linaro.org>,
        Carlo Caione <carlo@endlessm.com>,
        Stefan Wahren <stefan.wahren@i2se.com>,
        Chen-Yu Tsai <wens@csie.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH v6 2/3] arm: shmobile: Add the R9A06G032 SMP enabler
 driver
Message-ID: <20180625094249.b6dwnraqruicmo2u@verge.net.au>
References: <1529915110-5867-1-git-send-email-michel.pollet@bp.renesas.com>
 <1529915110-5867-3-git-send-email-michel.pollet@bp.renesas.com>
 <CAMuHMdVarwq26Jr=YN+zBDrHjQf-Q+u3L6oRNiSKh-hxuwOsrA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMuHMdVarwq26Jr=YN+zBDrHjQf-Q+u3L6oRNiSKh-hxuwOsrA@mail.gmail.com>
Organisation: Horms Solutions BV
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 25, 2018 at 11:24:48AM +0200, Geert Uytterhoeven wrote:
> Hi Michel,
> 
> On Mon, Jun 25, 2018 at 10:31 AM Michel Pollet
> <michel.pollet@bp.renesas.com> wrote:
> > The Renesas R9A06G032 second CA7 is parked in a ROM pen at boot time, it
> > requires a special enable method to get it started.
> >
> > Signed-off-by: Michel Pollet <michel.pollet@bp.renesas.com>
> > Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
> > ---
> >  arch/arm/mach-shmobile/Makefile        |  1 +
> >  arch/arm/mach-shmobile/smp-r9a06g032.c | 96 ++++++++++++++++++++++++++++++++++
> >  2 files changed, 97 insertions(+)
> >  create mode 100644 arch/arm/mach-shmobile/smp-r9a06g032.c
> 
> Given this doesn't depend on anything under arch/arm/mach-shmobile/,
> perhaps this should be moved to drivers/soc/renesas/ (and renamed to
> r9a06g032-smp.c for consistency) instead?
> 
> Simon: what do you think?

Yes, I think that would be nice.
