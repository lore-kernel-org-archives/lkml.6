Return-Path: <SRS0=szhz=OQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F2E4C07E85
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 09:34:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3D27020838
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 09:34:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3D27020838
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726113AbeLGJeJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Dec 2018 04:34:09 -0500
Received: from mail.bootlin.com ([62.4.15.54]:48117 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725985AbeLGJeI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Dec 2018 04:34:08 -0500
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 12DD420717; Fri,  7 Dec 2018 10:34:06 +0100 (CET)
Received: from localhost (unknown [88.191.26.124])
        by mail.bootlin.com (Postfix) with ESMTPSA id D71C120717;
        Fri,  7 Dec 2018 10:33:55 +0100 (CET)
Date:   Fri, 7 Dec 2018 10:33:56 +0100
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Rob Herring <robh+dt@kernel.org>, linux-rtc@vger.kernel.org,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/2] dt-bindings: rtc: add generic bindings
Message-ID: <20181207093356.GG8952@piout.net>
References: <20181111193114.24307-1-alexandre.belloni@bootlin.com>
 <CAMuHMdX9xZgAiBeXCXxLRSJYMefsFwhH3NGC7=EYteFd6kODMQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMuHMdX9xZgAiBeXCXxLRSJYMefsFwhH3NGC7=EYteFd6kODMQ@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/12/2018 11:36:59+0100, Geert Uytterhoeven wrote:
> > +The following properties may not be supported by all drivers. However, if a
> > +driver wants to support one of the below features, it should adapt the bindings
> > +below.
> > +- trickle-resistor-ohms : Selected resistor for trickle charger. Should be given
> 
> Can this resistor be less than 1 ohm?
> trickle-resistor-milli-ohms?
> 

Well, this is what current drivers already use so we are stuck with that
for now.

The value should be a few kOhm anyway. I think the lowest I know about
is 250 Ohm.

> > +                          if trickle charger should be enabled
> > +- trickle-diode-disable : Do not use internal trickle charger diode Should be
> > +                          given if internal trickle charger diode should be
> > +                          disabled
> > +- wakeup-source :         Enables wake up of host system on alarm
> 
> Gr{oetje,eeting}s,
> 
>                         Geert
> 
> -- 
> Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org
> 
> In personal conversations with technical people, I call myself a hacker. But
> when I'm talking to journalists I just say "programmer" or something like that.
>                                 -- Linus Torvalds

-- 
Alexandre Belloni, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
