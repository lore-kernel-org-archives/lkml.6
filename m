Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42073C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 22:27:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 07FB821934
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 22:27:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550096825;
	bh=FecSmF1qy0nkJRUKTfzS2BFVkV036a08XLhtomNVamE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=G3Wg4a16Z6AA76af9NAha9TZvyDXFNdIqok+bsot+kdMOTtHk3MAux+0U8VR4UxQv
	 bT3vh7nnJJXCuILg1aBw/6BZLLTGucEY6QAkrIaQ5RF5qwG7naEfJGQd3BQ8gtmM9o
	 HeojaW8nqyKoEzv8pup/Ql/Wx+0zfKRISlGxHDdE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391536AbfBMW1D (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Feb 2019 17:27:03 -0500
Received: from mail-ot1-f65.google.com ([209.85.210.65]:35203 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729121AbfBMW1D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Feb 2019 17:27:03 -0500
Received: by mail-ot1-f65.google.com with SMTP id z19so7209798otm.2;
        Wed, 13 Feb 2019 14:27:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=zAn8RFeQYoLA8lxdBOQ25WWJzWNjXK8/90SeqULz5do=;
        b=msnqbJUFyzh3HLvsNk8WxKGtRXJLmPwBiaJ/9alvqTiA0GDyR5t3A88WM3kz4KDOVU
         Ueh2a15+URlOK5Oa3L2cSZIEHA4WwKIMc4M34Wt3VYaakRTOVNL+TixQVEwVTrpfBUjI
         U5QVgFTWsRmav1zrh7PBioGEyfPj9Q4dDMsEMGHxo0P2aV67JmJCjRiA3MB1f2N/sRdr
         0wPWv7OyS5iAXMdYnAyBSBcuL9kdtOtd960UuCDRLFjSrTf7DAy2RlCwbnXCZ7KVWI+u
         eO9Wo2BqOTDKu69f/wQ1erhoj/yWzHZpmOOghqH4tRLPSqLg/KLqPyp/kbxeNM3vEa3u
         Ibyg==
X-Gm-Message-State: AHQUAub6Dz2D320DVIXi4wwlCnEjfeGwzNVk6y6tdNB+5sy0A2zdwE1W
        Dgh7ZR9txJae9QW6PjC3lg==
X-Google-Smtp-Source: AHgI3IY1w0jGZPfw9gk40cpNCv0rluNp25L/EsIfQHhfwG7lBjisOVZ5fKSIdWO0x6Ix13pVtGjftQ==
X-Received: by 2002:a9d:6954:: with SMTP id p20mr267567oto.261.1550096821987;
        Wed, 13 Feb 2019 14:27:01 -0800 (PST)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id d7sm215956otq.27.2019.02.13.14.27.01
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 13 Feb 2019 14:27:01 -0800 (PST)
Date:   Wed, 13 Feb 2019 16:27:00 -0600
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
Subject: Re: [PATCH V3 1/4] dt-binding: irq: imx-irqsteer: use irq number
 instead of group number
Message-ID: <20190213222700.GA31052@bogus>
References: <1548921464-28917-1-git-send-email-aisheng.dong@nxp.com>
 <1548921464-28917-2-git-send-email-aisheng.dong@nxp.com>
 <8db40cd7-7695-0267-c626-26ebe086b2b8@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8db40cd7-7695-0267-c626-26ebe086b2b8@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 11, 2019 at 03:35:40PM +0000, Marc Zyngier wrote:
> On 31/01/2019 08:03, Aisheng Dong wrote:
> > Not all 64 interrupts may be used in one group. e.g. most irqsteer in
> > imx8qxp and imx8qm subsystems supports only 32 interrupts.
> > 
> > As the IP integration parameters are Channel number and interrupts number,
> > let's use fsl,irqs-num to represents how many interrupts supported
> > by this irqsteer channel.
> > 
> > Cc: Marc Zyngier <marc.zyngier@arm.com>
> > Cc: Rob Herring <robh+dt@kernel.org>
> > Cc: Shawn Guo <shawnguo@kernel.org>
> > Cc: devicetree@vger.kernel.org
> > Reviewed-by: Lucas Stach <l.stach@pengutronix.de>
> > Signed-off-by: Dong Aisheng <aisheng.dong@nxp.com>
> > ---
> > ChangeLog:
> >  v1->v2:
> >   * change property name fsl,irqs-per-chan to fsl,num-irqs.
> > ---
> >  .../devicetree/bindings/interrupt-controller/fsl,irqsteer.txt       | 6 +++---
> >  1 file changed, 3 insertions(+), 3 deletions(-)
> > 
> > diff --git a/Documentation/devicetree/bindings/interrupt-controller/fsl,irqsteer.txt b/Documentation/devicetree/bindings/interrupt-controller/fsl,irqsteer.txt
> > index 45790ce..6d0a41b 100644
> > --- a/Documentation/devicetree/bindings/interrupt-controller/fsl,irqsteer.txt
> > +++ b/Documentation/devicetree/bindings/interrupt-controller/fsl,irqsteer.txt
> > @@ -16,8 +16,8 @@ Required properties:
> >  - #interrupt-cells: Specifies the number of cells needed to encode an
> >    interrupt source. The value must be 1.
> >  - fsl,channel: The output channel that all input IRQs should be steered into.
> > -- fsl,irq-groups: Number of IRQ groups managed by this controller instance.
> > -  Each group manages 64 input interrupts.
> > +- fsl,num-irqs: Number of input interrupts of this channel.
> > +  Should be multiple of 32 input interrupts and up to 512 interrupts.
> >  
> >  Example:
> >  
> > @@ -28,7 +28,7 @@ Example:
> >  		clocks = <&clk IMX8MQ_CLK_DISP_APB_ROOT>;
> >  		clock-names = "ipg";
> >  		fsl,channel = <0>;
> > -		fsl,irq-groups = <1>;
> > +		fsl,num-irqs = <64>;
> >  		interrupt-controller;
> >  		#interrupt-cells = <1>;
> >  	};
> > 
> 
> This is a change to an existing binding, so I'd need the Ack from a DT
> maintainer before I can queue this.

The DT maintainer doesn't care as long as there's an explanation that 
says it's breaking compatibility and why it is okay to do so. This one 
doesn't do that.

Rob
