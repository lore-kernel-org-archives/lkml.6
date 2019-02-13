Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A708EC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 22:29:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 756B32082F
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 22:29:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550096997;
	bh=FnvlBEC5OiGEGZl1TrhY+RFb4pt28O2FesdFSAu/REo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=1G57B2U3HxqTS0V5KlBlDjNL18i9sLayQJXBW/0PL3xr9sJl9y4MmXBQRquryWY9A
	 iGq1DYAMQbJbuR3/T5BQ5KKzy9yc99fpcEpXFmtiBHIwx59oTcmIr2TeYvBtZoLh2T
	 WBZBWhorHx716Khm9d7gtpDz5XDSa6dfpZ1S3FmE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2395087AbfBMW34 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Feb 2019 17:29:56 -0500
Received: from mail-ot1-f66.google.com ([209.85.210.66]:36155 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389384AbfBMW3z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Feb 2019 17:29:55 -0500
Received: by mail-ot1-f66.google.com with SMTP id k98so7217115otk.3;
        Wed, 13 Feb 2019 14:29:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ZOO8W4sPhEmShu7hGha8/Nl7mLjvHcJawMwQNvDVgVI=;
        b=CFOM/nt1vr/8QqNVdwR+rSJvp4hIAAVLzrb2br6nw+DR4i42xPpZyjdLx0u/XNRzDN
         +HLYS3020lRa+SMmXQnXXqTaD9tqbLqnAF45yNmBqj35jPPm/iCh5mrEZlMhaJ6cg4vw
         xO9Qs8AfRB0yXqKq/5mtrg5Fppb0Jf3LN7E0sfVXwsUqlf2sbncT15R2Xrv4n9sMEPwe
         FBTW07d4vH1HY5zhwKswpdwmPxI/aogQEFeLhJSP5nhUJwf9IDFETbQkviZClLjknKJt
         29BN2DpPhJqPJf0O6EZAEk1eO9VEDYScFRSEUbKx9ETxoVdptw1ayLtStVGvWMxERHRh
         vS/g==
X-Gm-Message-State: AHQUAuZkwogV+eeaaUHY5FFaXz0bz5AbWDdU6tL04CYkXrRcos16yP6P
        Jci+0myK0jm229sHVNTyt0Nq3iE=
X-Google-Smtp-Source: AHgI3IZcl27xOnyAtGs6JS+C2FHBrJftx6A7Stbp1qG3cn9Q+uZpwZ05ftqwdFUhhjB54wP1IK6kpg==
X-Received: by 2002:a9d:760f:: with SMTP id k15mr280478otl.149.1550096994368;
        Wed, 13 Feb 2019 14:29:54 -0800 (PST)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id q26sm240441otf.73.2019.02.13.14.29.52
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 13 Feb 2019 14:29:53 -0800 (PST)
Date:   Wed, 13 Feb 2019 16:29:52 -0600
From:   Rob Herring <robh@kernel.org>
To:     Marc Zyngier <marc.zyngier@arm.com>
Cc:     Aisheng Dong <aisheng.dong@nxp.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>,
        "l.stach@pengutronix.de" <l.stach@pengutronix.de>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>
Subject: Re: [PATCH V3 2/4] dt-bindings: irq: imx-irqsteer: add multi output
 interrupts support
Message-ID: <20190213222952.GA4814@bogus>
References: <1548921464-28917-1-git-send-email-aisheng.dong@nxp.com>
 <1548921464-28917-3-git-send-email-aisheng.dong@nxp.com>
 <23f5f2f0-79b8-b9f7-9f46-972966563596@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <23f5f2f0-79b8-b9f7-9f46-972966563596@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 11, 2019 at 03:34:23PM +0000, Marc Zyngier wrote:
> On 31/01/2019 08:03, Aisheng Dong wrote:
> > One irqsteer channel can support up to 8 output interrupts.
> > 
> > Cc: Marc Zyngier <marc.zyngier@arm.com>
> > Cc: Rob Herring <robh+dt@kernel.org>
> > Cc: Lucas Stach <l.stach@pengutronix.de>
> > Cc: Shawn Guo <shawnguo@kernel.org>
> > Cc: devicetree@vger.kernel.org
> > Signed-off-by: Dong Aisheng <aisheng.dong@nxp.com>
> > ---
> > ChangeLog:
> > v2->v3:
> >  * fix a typo
> > v1->v2:
> >  * remove one unnecessary note.
> > ---
> >  .../devicetree/bindings/interrupt-controller/fsl,irqsteer.txt        | 5 +++--
> >  1 file changed, 3 insertions(+), 2 deletions(-)
> > 
> > diff --git a/Documentation/devicetree/bindings/interrupt-controller/fsl,irqsteer.txt b/Documentation/devicetree/bindings/interrupt-controller/fsl,irqsteer.txt
> > index 6d0a41b..582991c 100644
> > --- a/Documentation/devicetree/bindings/interrupt-controller/fsl,irqsteer.txt
> > +++ b/Documentation/devicetree/bindings/interrupt-controller/fsl,irqsteer.txt
> > @@ -6,8 +6,9 @@ Required properties:
> >  	- "fsl,imx8m-irqsteer"
> >  	- "fsl,imx-irqsteer"
> >  - reg: Physical base address and size of registers.
> > -- interrupts: Should contain the parent interrupt line used to multiplex the
> > -  input interrupts.
> > +- interrupts: Should contain the up to 8 parent interrupt lines used to
> > +  multiplex the input interrupts. They should be specified sequentially
> > +  from output 0 to 7.
> >  - clocks: Should contain one clock for entry in clock-names
> >    see Documentation/devicetree/bindings/clock/clock-bindings.txt
> >  - clock-names:
> > 
> 
> I'd like an Ack from a DT person, as this is a change to an existing
> binding.

It's fine as long as old kernels ignore extra entries and new kernels 
still support a single entry. Otherwise, it needs a explanation.

Rob
