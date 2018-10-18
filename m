Return-Path: <SRS0=Z5ET=M6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFC5BECDE43
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 13:04:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 971FB21486
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 13:04:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=verge.net.au header.i=@verge.net.au header.b="owCL9WWq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 971FB21486
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=verge.net.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727638AbeJRVFM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Oct 2018 17:05:12 -0400
Received: from kirsty.vergenet.net ([202.4.237.240]:50725 "EHLO
        kirsty.vergenet.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727152AbeJRVFL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Oct 2018 17:05:11 -0400
Received: from reginn.horms.nl (watermunt.horms.nl [80.127.179.77])
        by kirsty.vergenet.net (Postfix) with ESMTPA id 7491225B853;
        Fri, 19 Oct 2018 00:04:13 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=verge.net.au; s=mail;
        t=1539867854; bh=0/e++dXnhk4VqjzvYIRoLenXLXr4Ifh2wEHuGPjelpA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=owCL9WWqh0JZ8pQHZm7GtUGR6YXJWTSzSLuIyjSVaEZgu52e5OLsq9/kbxrRodJGj
         ervVye76bB3weKHHDP4/NKrEoaMC3Mbkmoeh6cVcDi46UZQtx596F5F5/dXFWHebZ8
         0m9YX/zIguqZCRRSuZgIvyF6yDsd6gQUYbx/1ycw=
Received: by reginn.horms.nl (Postfix, from userid 7100)
        id 57D94940162; Thu, 18 Oct 2018 15:04:11 +0200 (CEST)
Date:   Thu, 18 Oct 2018 15:04:11 +0200
From:   Simon Horman <horms@verge.net.au>
To:     Rob Herring <robh@kernel.org>
Cc:     Geert Uytterhoeven <geert@linux-m68k.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        devicetree@vger.kernel.org,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        Grant Likely <glikely@secretlab.ca>,
        Kumar Gala <kumar.gala@linaro.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Olof Johansson <olof@lixom.net>, Arnd Bergmann <arnd@arndb.de>,
        Mark Brown <broonie@kernel.org>, Tom Rini <trini@konsulko.com>,
        Pantelis Antoniou <pantelis.antoniou@konsulko.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Magnus Damm <magnus.damm@gmail.com>,
        "open list:MEDIA DRIVERS FOR RENESAS - FCP" 
        <linux-renesas-soc@vger.kernel.org>
Subject: Re: [PATCH 05/36] dt-bindings: arm: renesas: Move 'renesas,prr'
 binding to its own doc
Message-ID: <20181018130411.vbammbqqiyvmmcxo@verge.net.au>
References: <20181005165848.3474-1-robh@kernel.org>
 <20181005165848.3474-6-robh@kernel.org>
 <CAMuHMdV=HaVhGf-7-21OHb05dCc0q9MDUNknAcybEiGSxATeEA@mail.gmail.com>
 <CAL_JsqJGGRfoEb_TjZy2X9QwjfAdoxs_EB+cLNmszHOE8-OtHw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAL_JsqJGGRfoEb_TjZy2X9QwjfAdoxs_EB+cLNmszHOE8-OtHw@mail.gmail.com>
Organisation: Horms Solutions BV
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 08, 2018 at 09:59:19AM -0500, Rob Herring wrote:
> On Mon, Oct 8, 2018 at 2:05 AM Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> >
> > Hi Rob,
> >
> > On Fri, Oct 5, 2018 at 6:58 PM Rob Herring <robh@kernel.org> wrote:
> > > In preparation to convert board-level bindings to json-schema, move
> > > various misc SoC bindings out to their own file.
> > >
> > > Cc: Mark Rutland <mark.rutland@arm.com>
> > > Cc: Simon Horman <horms@verge.net.au>
> > > Cc: Magnus Damm <magnus.damm@gmail.com>
> > > Cc: devicetree@vger.kernel.org
> > > Cc: linux-renesas-soc@vger.kernel.org
> > > Signed-off-by: Rob Herring <robh@kernel.org>
> >
> > Looks good to me, but needs a rebase, as the PRR section has been extended
> > in -next.
> 
> Is this something you all can apply still for 4.20?

Sorry, missing this until now. It was too late.

Shall I take it for v4.21?
