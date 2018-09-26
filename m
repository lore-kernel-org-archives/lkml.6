Return-Path: <SRS0=3sEf=MI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFC86C43382
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 22:46:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8C9CE21533
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 22:46:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8C9CE21533
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726585AbeI0FBc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Sep 2018 01:01:32 -0400
Received: from mail-oi1-f196.google.com ([209.85.167.196]:34307 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726186AbeI0FBc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Sep 2018 01:01:32 -0400
Received: by mail-oi1-f196.google.com with SMTP id 13-v6so575850ois.1;
        Wed, 26 Sep 2018 15:46:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Dzdy6iB+uNOtlAAiCxj/SDaQUvUK5Vmaa2dsmdoDU6s=;
        b=nx+8cNOKsbQxOAqF28yUYylY9SYxmdQZvyS+uzMc61WY7lsrkc3m+M9HdeIimaad3O
         5WE+FeI+WlKoskJBp+8iJ6rjEZhqQALJCTjm8TvuWrOz847LFHbdJqe7HBdk4SpyfdyT
         o6fj0mTjn9LNlsJdZcDgoY7puDBfPbZQqIvXPi8IKRNB5W5Es3oKC70YZQu0MWtp3+rk
         to0kY7CRpW8EvwXvLtCbuGOymMQ6bF0wWNSpQUQMRTXIV4GeQYWQF5cwejnQCq0kXpsD
         9BppthlrRG5tlNf46VubWMO7y/cJnLhq/vGlsEiQJBCC/6GxWebtkJOWBgTbUYaxQ0Qg
         P9IA==
X-Gm-Message-State: ABuFfogWYKpZYfS5QzsERKHEVbY6nZ3MpLZl5B5cSehe73prPZ0SW0Vs
        1XQNUZh/81jXUim7ZkorPQ==
X-Google-Smtp-Source: ACcGV62RFoMXk/c6pw0+n4QtOaBFwdDl2pytH8uSGzkMYk5NZk09LRUyAwIJJLuNrexzQ9Mh3bHzxQ==
X-Received: by 2002:a54:468e:: with SMTP id k14-v6mr1899602oic.27.1538001979613;
        Wed, 26 Sep 2018 15:46:19 -0700 (PDT)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id u21-v6sm125213oie.22.2018.09.26.15.46.18
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 26 Sep 2018 15:46:19 -0700 (PDT)
Date:   Wed, 26 Sep 2018 17:46:18 -0500
From:   Rob Herring <robh@kernel.org>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Song Qiang <songqiang1304521@gmail.com>, knaack.h@gmx.de,
        lars@metafoo.de, pmeerw@pmeerw.net, mark.rutland@arm.com,
        andriy.shevchenko@linux.intel.com, matt.ranostay@konsulko.com,
        tglx@linutronix.de, ak@it-klinger.de, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v6 2/2] iio: proximity: vl53l0x: add interrupt support
Message-ID: <20180926224618.GA32126@bogus>
References: <20180918082422.13050-1-songqiang1304521@gmail.com>
 <20180918082422.13050-2-songqiang1304521@gmail.com>
 <20180922160523.16b399fc@archlinux>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180922160523.16b399fc@archlinux>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 22, 2018 at 04:05:23PM +0100, Jonathan Cameron wrote:
> On Tue, 18 Sep 2018 16:24:22 +0800
> Song Qiang <songqiang1304521@gmail.com> wrote:
> 
> > The first version of this driver issues a measuring request and polling
> > for a status register in the device for measuring completes.
> > vl53l0x support configuring GPIO1 on it to generate interrupt to
> > indicate that new measurement is ready. This patch adds support for
> > using this mechanisim to reduce cpu cost.
> > 
> > Signed-off-by: Song Qiang <songqiang1304521@gmail.com>
> Hi Song.
> 
> Looks correct in principal but a few things to tidy up before
> this is ready to apply.
> 
> Also we have an unrelated change in here to check the devices ID.
> That should be in it's own patch.
> 
> Thanks,
> 
> Jonathan
> > ---
> >  .../bindings/iio/proximity/vl53l0x.txt        |  14 +-

This should have been split with the complete binding in one patch 
rather than piecemeal driver feature by feature.

> >  drivers/iio/proximity/vl53l0x-i2c.c           | 135 +++++++++++++++---
> >  2 files changed, 129 insertions(+), 20 deletions(-)
> > 
> > diff --git a/Documentation/devicetree/bindings/iio/proximity/vl53l0x.txt b/Documentation/devicetree/bindings/iio/proximity/vl53l0x.txt
> > index ab9a9539fec4..40290f8dd70f 100644
> > --- a/Documentation/devicetree/bindings/iio/proximity/vl53l0x.txt
> > +++ b/Documentation/devicetree/bindings/iio/proximity/vl53l0x.txt
> > @@ -4,9 +4,21 @@ Required properties:
> >  	- compatible: must be "st,vl53l0x-i2c"

Is there more than one interface on this device, such as SPI? If not, 
then '-i2c' should be dropped.

> >  	- reg: i2c address where to find the device
> >  
> > +Optional properties:
> > +	- interrupts : Interrupt line receiving GPIO1's measuring complete
> > +	  output, supports IRQ_TYPE_EDGE_FALLING only.
> > +
> > +	Refer to interrupt-controller/interrupts.txt for generic
> > +	interrupt client node bindings.
> > +
> >  Example:
> >  
> >  vl53l0x@29 {
> > +	pinctrl-names = "default";
> > +	pinctrl-0 = <&vl53l0x_pins>;
> > +
> Please drop this from the example.  This is board specific rather than
> being generally required.
> 
> >  	compatible = "st,vl53l0x-i2c";
> >  	reg = <0x29>;
> > -};
> > +	interrupt-parent = <&gpio3>;
> > +	interrupts = <17 IRQ_TYPE_EDGE_FALLING>;
> > +}
