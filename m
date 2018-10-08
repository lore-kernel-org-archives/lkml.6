Return-Path: <SRS0=fRGm=MU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40557C65C20
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 14:25:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EBDF32075C
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 14:25:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EBDF32075C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=siol.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726461AbeJHVhT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Oct 2018 17:37:19 -0400
Received: from mailoutvs38.siol.net ([185.57.226.229]:40207 "EHLO
        mail.siol.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726078AbeJHVhT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Oct 2018 17:37:19 -0400
Received: from localhost (localhost [127.0.0.1])
        by mail.siol.net (Postfix) with ESMTP id EAFC65207C0;
        Mon,  8 Oct 2018 16:25:13 +0200 (CEST)
X-Virus-Scanned: amavisd-new at psrvmta10.zcs-production.pri
Received: from mail.siol.net ([127.0.0.1])
        by localhost (psrvmta10.zcs-production.pri [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id Fq3T6VUpzvA3; Mon,  8 Oct 2018 16:25:13 +0200 (CEST)
Received: from mail.siol.net (localhost [127.0.0.1])
        by mail.siol.net (Postfix) with ESMTPS id 7967552027B;
        Mon,  8 Oct 2018 16:25:13 +0200 (CEST)
Received: from jernej-laptop.localnet (cpe1-8-82.cable.triera.net [213.161.8.82])
        (Authenticated sender: 031275009)
        by mail.siol.net (Postfix) with ESMTPA id 97EF9520230;
        Mon,  8 Oct 2018 16:25:06 +0200 (CEST)
From:   Jernej =?utf-8?B?xaBrcmFiZWM=?= <jernej.skrabec@siol.net>
To:     Maxime Ripard <maxime.ripard@bootlin.com>
Cc:     wens@csie.org, robh+dt@kernel.org, sboyd@kernel.org,
        airlied@linux.ie, architt@codeaurora.org, a.hajda@samsung.com,
        Laurent.pinchart@ideasonboard.com, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-sunxi@googlegroups.com, Icenowy Zheng <icenowy@aosc.io>
Subject: Re: [PATCH v2 01/29] dt-bindings: bus: add H6 DE3 bus binding
Date:   Mon, 08 Oct 2018 16:25:06 +0200
Message-ID: <3254500.X28SCFYq22@jernej-laptop>
In-Reply-To: <20181008083154.hhrelzmmpbjwu7sy@flea>
References: <20181007093905.11253-1-jernej.skrabec@siol.net> <20181007093905.11253-2-jernej.skrabec@siol.net> <20181008083154.hhrelzmmpbjwu7sy@flea>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dne ponedeljek, 08. oktober 2018 ob 10:31:54 CEST je Maxime Ripard napisal(a):
> On Sun, Oct 07, 2018 at 11:38:37AM +0200, Jernej Skrabec wrote:
> > From: Icenowy Zheng <icenowy@aosc.io>
> > 
> > The Allwinner H6 DE3 bus is similar to the A64 DE2 one.
> > 
> > Add its compatible string with the A64 string as fallback to the
> > binding.
> > 
> > Some description of the binding is modified to make it more generic.
> > 
> > Reviewed-by: Rob Herring <robh@kernel.org>
> > Signed-off-by: Icenowy Zheng <icenowy@aosc.io>
> > ---
> > 
> >  Documentation/devicetree/bindings/bus/sun50i-de2-bus.txt | 9 ++++++---
> >  1 file changed, 6 insertions(+), 3 deletions(-)
> > 
> > diff --git a/Documentation/devicetree/bindings/bus/sun50i-de2-bus.txt
> > b/Documentation/devicetree/bindings/bus/sun50i-de2-bus.txt index
> > 87dfb33fb3be..ac1445b95f41 100644
> > --- a/Documentation/devicetree/bindings/bus/sun50i-de2-bus.txt
> > +++ b/Documentation/devicetree/bindings/bus/sun50i-de2-bus.txt
> > @@ -1,11 +1,14 @@
> > -Device tree bindings for Allwinner A64 DE2 bus
> > +Device tree bindings for Allwinner DE2/3 bus
> > 
> >  The Allwinner A64 DE2 is on a special bus, which needs a SRAM region
> >  (SRAM C)> 
> > -to be claimed for enabling the access.
> > +to be claimed for enabling the access. The DE3 on Allwinner H6 is at the
> > same +situation, and the binding also applies.
> > 
> >  Required properties:
> > - - compatible:		Should contain "allwinner,sun50i-a64-de2"
> > + - compatible:		Should be one of:
> > +				- "allwinner,sun50i-a64-de2"
> > +				- "allwinner,sun50i-a6-de3", "allwinner,sun50i-a64-de2"
> 
>                                                     ^ that would be h6 I
> guess?

Good catch! Yes, it should.

Best regards,
Jernej



