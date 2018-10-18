Return-Path: <SRS0=Z5ET=M6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2F70C5ACCC
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 13:01:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6A7BB21477
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 13:01:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=verge.net.au header.i=@verge.net.au header.b="PhPYYbfV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6A7BB21477
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=verge.net.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727745AbeJRVCF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Oct 2018 17:02:05 -0400
Received: from kirsty.vergenet.net ([202.4.237.240]:50631 "EHLO
        kirsty.vergenet.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727110AbeJRVCE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Oct 2018 17:02:04 -0400
Received: from reginn.horms.nl (watermunt.horms.nl [80.127.179.77])
        by kirsty.vergenet.net (Postfix) with ESMTPA id 9FDCA25BE28;
        Fri, 19 Oct 2018 00:01:07 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=verge.net.au; s=mail;
        t=1539867668; bh=nlzSdoM3o1Q1qB6ObE17iQR0UbnfF5kWb9Wkm1Aa7YU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=PhPYYbfVQIXstV12IDRbD+CWnQUyBuz0xw0v/HNjUFpdieiiuRphxxvDXIC2ZxZe5
         OiVJodeAHE5MM0fsS7+o0mRmeblnEXSPHHLzS7WMdsiJT9UChmi3T3VGqQjU4B5BJv
         7mC4RK8G+eDL1izXnVtTSRWmfoGzCLevxKEHMWqc=
Received: by reginn.horms.nl (Postfix, from userid 7100)
        id 83B96940162; Thu, 18 Oct 2018 15:01:05 +0200 (CEST)
Date:   Thu, 18 Oct 2018 15:01:05 +0200
From:   Simon Horman <horms@verge.net.au>
To:     Rob Herring <robh@kernel.org>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
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
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Magnus Damm <magnus.damm@gmail.com>,
        "open list:MEDIA DRIVERS FOR RENESAS - FCP" 
        <linux-renesas-soc@vger.kernel.org>,
        Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Subject: Re: [PATCH 29/36] dt-bindings: arm: Convert Renesas board/soc
 bindings to json-schema
Message-ID: <20181018130105.2guhavajp754qbnk@verge.net.au>
References: <20181005165848.3474-1-robh@kernel.org>
 <20181005165848.3474-30-robh@kernel.org>
 <20181008080220.rmxk57ckdfmwuk62@verge.net.au>
 <CAL_Jsq+8EwYzBmzSWL0q0YB3rP-xdrZreRnt1Rj-h=D8OTNVwA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAL_Jsq+8EwYzBmzSWL0q0YB3rP-xdrZreRnt1Rj-h=D8OTNVwA@mail.gmail.com>
Organisation: Horms Solutions BV
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 08, 2018 at 09:05:58AM -0500, Rob Herring wrote:
> On Mon, Oct 8, 2018 at 3:02 AM Simon Horman <horms@verge.net.au> wrote:
> >
> > On Fri, Oct 05, 2018 at 11:58:41AM -0500, Rob Herring wrote:
> > > Convert Renesas SoC bindings to DT schema format using json-schema.
> > >
> > > Cc: Simon Horman <horms@verge.net.au>
> > > Cc: Magnus Damm <magnus.damm@gmail.com>
> > > Cc: Mark Rutland <mark.rutland@arm.com>
> > > Cc: linux-renesas-soc@vger.kernel.org
> > > Cc: devicetree@vger.kernel.org
> > > Signed-off-by: Rob Herring <robh@kernel.org>
> >
> > This seems fine to me other than that it does not seem
> > to apply cleanly to next.
> >
> > shmobile.txt sees a couple of updates per release cycle so from my point of
> > view it would ideal if this change could hit -rc1 to allow patches for
> > v4.21 to be accepted smoothly (already one from Sergei will need rebasing).
> 
> When we get to the point of merging (which isn't going to be 4.20),
> you and other maintainers can probably take all these patches. Other
> than the few restructuring patches, the only dependency is the build
> support which isn't a dependency to apply it, but build it. I plan to
> build any patches as part of reviewing at least early on. OTOH, the
> build support is small enough and self contained that maybe it can
> just be applied for 4.20.

Thanks, understood.

My preference would be to, as you suggest, take changes like
this through the renesas tree.
