Return-Path: <SRS0=3gpS=RA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0532C10F00
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 09:24:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A124820842
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 09:24:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=verge.net.au header.i=@verge.net.au header.b="WnJRdTQJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726485AbfBYJYA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Feb 2019 04:24:00 -0500
Received: from kirsty.vergenet.net ([202.4.237.240]:40492 "EHLO
        kirsty.vergenet.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726388AbfBYJX7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Feb 2019 04:23:59 -0500
Received: from reginn.horms.nl (watermunt.horms.nl [80.127.179.77])
        by kirsty.vergenet.net (Postfix) with ESMTPA id 6022325B784;
        Mon, 25 Feb 2019 20:23:57 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=verge.net.au; s=mail;
        t=1551086637; bh=fxFeSTnPjMAohOa1nqLu2C1YSHkI9KKJVUvMMLCn1mI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=WnJRdTQJwhzYxOu+HPeaAuljvy1b5LI9o/tBPCC/JOtizhPb+bqucpYI9mzYIwlp7
         DYXjhmJA+7mz+ZsRg7w0ANARRHh8Pr0c1BlGxHZuwz0Dtz+eEa3lDLWUShPzFwG9e/
         Jb+mEraLdRxG4HzHeFYWdZWxmgOVQ84IJrn26TTY=
Received: by reginn.horms.nl (Postfix, from userid 7100)
        id 8219D94056F; Mon, 25 Feb 2019 10:23:55 +0100 (CET)
Date:   Mon, 25 Feb 2019 10:23:55 +0100
From:   Simon Horman <horms@verge.net.au>
To:     jiada <jiada_wang@mentor.com>
Cc:     Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Magnus Damm <magnus.damm@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v1 0/2] rsnd: dts: change to use extended audio dmac
 register
Message-ID: <20190225092355.w5o5se22mucgb5i5@verge.net.au>
References: <20190220052435.20508-1-jiada_wang@mentor.com>
 <CAMuHMdX1OqmwtCAtx8mxQtrG0D6bxkJ-trkA50qw=t16kBfdTQ@mail.gmail.com>
 <871s427ux5.wl-kuninori.morimoto.gx@renesas.com>
 <021012f9-f522-0efd-4bb2-c56917623266@mentor.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <021012f9-f522-0efd-4bb2-c56917623266@mentor.com>
Organisation: Horms Solutions BV
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 22, 2019 at 12:05:02PM +0900, jiada wrote:
> Hi Geert
> 
> 
> On 2019/02/20 17:10, Kuninori Morimoto wrote:
> > 
> > Hi Geert
> > 
> > > > According to user reference manual for R-CAR H3 and M3-W SoCs,
> > > > in order to access busif4 ~ busif7, extended audio dmac registers
> > > > (PDMASAREn, PDMADAREn, PDMACHCREn)
> > > > need to be used, rather than basic audio dmac registers
> > > > (PDMASARn, PDMADARn, PDMACHCRn)
> > > > 
> > > > This patch set updates H3 (= r8a7795) and M3-W (= r8a7796)
> > > > to use extended audio dmac registers
> > > 
> > > The same change should be applied for M3-N and RZ/G2M, right?
> > > 
> Currently only H3 and M3-W support to use busif other than busif0,
> I feel currently it's only necessary to use extended audio dmac register for
> these SoCs
> 
> > > R-Car E3 and RZ/G2E already use the extended register set, as they do not
> > > have the basic set.
> > > 
> > > For SoCs having both, this feels a bit like describing software policy, instead
> > > of hardware, to me. Would it make sense to extend the audio bindings, and
> > > allow describing both the basic and extended register sets, and let the driver
> > > make the decision which one to use?
> > 
> > I don't think we need to use basic register.
> > This means extended register only is very enough.
> > I'm not sure why datasheet is indicating basic...
> > 
> Extended audio dmac registers covers all function of basic ones,
> so there is no need to use basic registers

This still sounds a lot like a policy decision that should
be made by the driver based on a fuller description of the hardware
in DT.
