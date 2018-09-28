Return-Path: <SRS0=0/YT=MK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F80AC43382
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 09:36:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 19CFA215F0
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 09:36:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dagUpB9E"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 19CFA215F0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729234AbeI1P7l (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Sep 2018 11:59:41 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:39485 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729008AbeI1P7l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Sep 2018 11:59:41 -0400
Received: by mail-pf1-f195.google.com with SMTP id j8-v6so3947001pff.6;
        Fri, 28 Sep 2018 02:36:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=4eNHc21yBFNCr7RlOKT40cpVoo7iUlCzeu6+oQIRa4M=;
        b=dagUpB9EmhNnOuM9u3wrKADxabIZU2VMb9OmIx7NTorQlG3CV25Gi5mwvi99Qn8thW
         3YhgEfPgehfhsep4taK33ql2KnShP/ul6+mx47Kk9a/exvpCoiTIXznHsWM8aDAgn5vF
         XZ3xx5iPwJ6kyeVC4TqtkIwynxyEf5hF/1/QfLbF5JFtDEm4oeHuLIEIu8HJNaS4a2nX
         L3TWdzg5Z0aMYeWd6tpd0W2xmBrhaU5BHIWZzARxMvWWI4iEWgI/pHyPlRIAZAfIYgiC
         /fLrS1snfWvHuSZUrbe2NXR/IeJ05rSE1E+KkPu5a8NwtVWD9GlpPvqas8TBJudJ+MQR
         CLMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=4eNHc21yBFNCr7RlOKT40cpVoo7iUlCzeu6+oQIRa4M=;
        b=kNkI7VvAyOv29xLyP1tFkYktVwu5QDjK/5vNdp/cUxjHh7Rb7Yc2OIayDznuVosuFu
         6WBPa/p+unMUK+4pjBe5JgRCPMjdzr0ZpPE6XfGKxCCCmflcYVTEkjd/5xWXwiw+Y4nU
         kZKEMPMOYCRcR7N7AjJ58IXvpAq7JBrvj6cQac+reBUlUamglwugLobR3+AFyqPwvF7t
         27E0/+vp7hm7l3JTEeo65WAizzT1/ccpRRQXV8Y2HqW+031HQVNBcw+PNZCFLaUL8css
         qXFCtLkZBIert107frjZdefyr33rGVBAqr+3UcJiHSQcVqG4WprRvLtF9HLcAl1VGUaJ
         LFig==
X-Gm-Message-State: ABuFfoiFy+v/VPQv5NZoBxieltI/pWGrd82dAFdesb02eMysCoue6nNr
        1W3ubxASnnzB0RUc++PiavI=
X-Google-Smtp-Source: ACcGV61IQZpa/aAVqxoFkYBOXBEdLATajPXBx3xVoky4/ZQ1up0FueuQAWNn+YL/ea7O9FqtbEvmIA==
X-Received: by 2002:a62:6104:: with SMTP id v4-v6mr16097050pfb.122.1538127407191;
        Fri, 28 Sep 2018 02:36:47 -0700 (PDT)
Received: from Eros (104.176.229.35.bc.googleusercontent.com. [35.229.176.104])
        by smtp.gmail.com with ESMTPSA id l3-v6sm6173466pff.8.2018.09.28.02.36.36
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 28 Sep 2018 02:36:46 -0700 (PDT)
Date:   Fri, 28 Sep 2018 17:36:18 +0800
From:   Song Qiang <songqiang1304521@gmail.com>
To:     Rob Herring <robh@kernel.org>
Cc:     Jonathan Cameron <jic23@kernel.org>, knaack.h@gmx.de,
        lars@metafoo.de, pmeerw@pmeerw.net, mark.rutland@arm.com,
        andriy.shevchenko@linux.intel.com, matt.ranostay@konsulko.com,
        tglx@linutronix.de, ak@it-klinger.de, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v6 2/2] iio: proximity: vl53l0x: add interrupt support
Message-ID: <20180928093618.GA24536@Eros>
References: <20180918082422.13050-1-songqiang1304521@gmail.com>
 <20180918082422.13050-2-songqiang1304521@gmail.com>
 <20180922160523.16b399fc@archlinux>
 <20180926224618.GA32126@bogus>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180926224618.GA32126@bogus>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 26, 2018 at 05:46:18PM -0500, Rob Herring wrote:
> On Sat, Sep 22, 2018 at 04:05:23PM +0100, Jonathan Cameron wrote:
> > On Tue, 18 Sep 2018 16:24:22 +0800
> > Song Qiang <songqiang1304521@gmail.com> wrote:
> > 
> > > The first version of this driver issues a measuring request and polling
> > > for a status register in the device for measuring completes.
> > > vl53l0x support configuring GPIO1 on it to generate interrupt to
> > > indicate that new measurement is ready. This patch adds support for
> > > using this mechanisim to reduce cpu cost.
> > > 
> > > Signed-off-by: Song Qiang <songqiang1304521@gmail.com>
> > Hi Song.
> > 
> > Looks correct in principal but a few things to tidy up before
> > this is ready to apply.
> > 
> > Also we have an unrelated change in here to check the devices ID.
> > That should be in it's own patch.
> > 
> > Thanks,
> > 
> > Jonathan
> > > ---
> > >  .../bindings/iio/proximity/vl53l0x.txt        |  14 +-
> 
> This should have been split with the complete binding in one patch 
> rather than piecemeal driver feature by feature.
> 

Hi Rob,

A few days ago when I was submitting this driver, I didn't do it very
well, the function of this driver is limited. I added interrupt support 
the next day after you acked my first patch. I thought it's not polite 
to add something after someone acked that patch, so I send the interrupt
support as a second patch. The first patch is merged to togreg now, but
this doesn't. I don't know when can I add new functions to the code that
just merged to togreg branch, could you offer some suggestions?

> > >  drivers/iio/proximity/vl53l0x-i2c.c           | 135 +++++++++++++++---
> > >  2 files changed, 129 insertions(+), 20 deletions(-)
> > > 
> > > diff --git a/Documentation/devicetree/bindings/iio/proximity/vl53l0x.txt b/Documentation/devicetree/bindings/iio/proximity/vl53l0x.txt
> > > index ab9a9539fec4..40290f8dd70f 100644
> > > --- a/Documentation/devicetree/bindings/iio/proximity/vl53l0x.txt
> > > +++ b/Documentation/devicetree/bindings/iio/proximity/vl53l0x.txt
> > > @@ -4,9 +4,21 @@ Required properties:
> > >  	- compatible: must be "st,vl53l0x-i2c"
> 
> Is there more than one interface on this device, such as SPI? If not, 
> then '-i2c' should be dropped.
> 

Yes, there is a CCI(Camera Control Interface) for communication.

> > >  	- reg: i2c address where to find the device
> > >  
> > > +Optional properties:
> > > +	- interrupts : Interrupt line receiving GPIO1's measuring complete
> > > +	  output, supports IRQ_TYPE_EDGE_FALLING only.
> > > +
> > > +	Refer to interrupt-controller/interrupts.txt for generic
> > > +	interrupt client node bindings.
> > > +
> > >  Example:
> > >  
> > >  vl53l0x@29 {
> > > +	pinctrl-names = "default";
> > > +	pinctrl-0 = <&vl53l0x_pins>;
> > > +
> > Please drop this from the example.  This is board specific rather than
> > being generally required.
> > 

Sure.

yours,
Song Qiang
> > >  	compatible = "st,vl53l0x-i2c";
> > >  	reg = <0x29>;
> > > -};
> > > +	interrupt-parent = <&gpio3>;
> > > +	interrupts = <17 IRQ_TYPE_EDGE_FALLING>;
> > > +}
