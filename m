Return-Path: <SRS0=aB5v=OC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DCA5C43441
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Nov 2018 12:20:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1390E20820
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Nov 2018 12:20:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=verge.net.au header.i=@verge.net.au header.b="OCdk50wn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1390E20820
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=verge.net.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2504191AbeKWXEv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 23 Nov 2018 18:04:51 -0500
Received: from kirsty.vergenet.net ([202.4.237.240]:50013 "EHLO
        kirsty.vergenet.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730534AbeKWXEu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Nov 2018 18:04:50 -0500
Received: from reginn.horms.nl (watermunt.horms.nl [80.127.179.77])
        by kirsty.vergenet.net (Postfix) with ESMTPA id 7AD6C25B823;
        Fri, 23 Nov 2018 23:20:48 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=verge.net.au; s=mail;
        t=1542975648; bh=82XY75AmoCN4dDp8hxXEdnJcrFhwoRD2XVw33KM0ar8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=OCdk50wn7E0hoNIaw0Pc7ptf1ib2KaOMdPKM0BwqohIlBBTFKWrrr7HrJJIZgUdHv
         jMoBxQUrlhkm7Ek1Hep/zwX+wvDxQL5r3X0pMInx4KJqHZrAeXYDGch1fMUdqnlxi6
         e9i1wysI0220D0opYE7S3LOxZEKypAFnww85u2ms=
Received: by reginn.horms.nl (Postfix, from userid 7100)
        id 034839403E4; Fri, 23 Nov 2018 13:20:46 +0100 (CET)
Date:   Fri, 23 Nov 2018 13:20:46 +0100
From:   Simon Horman <horms@verge.net.au>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Phil Edworthy <phil.edworthy@renesas.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>
Subject: Re: [PATCH v2] ARM: dts: r9a06g032: Correct the GIC DT node name
Message-ID: <20181123122046.xqxq7kxdkp7swxf4@verge.net.au>
References: <20181121100844.25825-1-phil.edworthy@renesas.com>
 <CAMuHMdUH74QA5oSuOe9LgoS08-CEHiGSz_FzPQs6S9BzCijDag@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMuHMdUH74QA5oSuOe9LgoS08-CEHiGSz_FzPQs6S9BzCijDag@mail.gmail.com>
Organisation: Horms Solutions BV
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 23, 2018 at 10:24:06AM +0100, Geert Uytterhoeven wrote:
> On Wed, Nov 21, 2018 at 11:10 AM Phil Edworthy
> <phil.edworthy@renesas.com> wrote:
> > Harmless mistake, but it's incorrect. The DT spec provides recommendations
> > for the node names:
> > "The name of a node should be somewhat generic, reflecting the function
> > of the device and not its precise programming model. If appropriate, the
> > name should be one of the following choices:
> > ...
> > interrupt-controller"
> >
> > Signed-off-by: Phil Edworthy <phil.edworthy@renesas.com>
> 
> Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Thanks, applied for v4.21.
