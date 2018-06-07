Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id VBZ9IhISGVs0LAAAmS7hNA
	; Thu, 07 Jun 2018 11:12:32 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id D6769607DC; Thu,  7 Jun 2018 11:12:30 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="amQv5SzG"
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=2.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FROM,MAILING_LIST_MULTI
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 236076090E;
	Thu,  7 Jun 2018 11:12:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 236076090E
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932323AbeFGLM1 (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Thu, 7 Jun 2018 07:12:27 -0400
Received: from mail-lf0-f65.google.com ([209.85.215.65]:36300 "EHLO
        mail-lf0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752577AbeFGLMY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jun 2018 07:12:24 -0400
Received: by mail-lf0-f65.google.com with SMTP id u4-v6so14063882lff.3;
        Thu, 07 Jun 2018 04:12:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=pmRrr7DlSrvh6Afoiu8azY8hCl3ZXESYqSNteWAYVnA=;
        b=amQv5SzGZmnqwUUVLZ6jbHmy3oWOULvyE3grl2f99T7ueqrZUKbkKpVLUIDeK23riQ
         gibpaa4IdEsEgJGGp/8HY2Gh6ro57VpdaleI+s8ypAy3hz3I7SJbDodLZgXnj9ZAWQ06
         WtogUpLDoxdZbI68nIrIjtcjLksQpXppPlmn29CWlyfAWvckjR0ojWZ/J4sHmFZlGrOJ
         GOqFn5sT8n4YELqj0a576vXD7WnqWXelA5hYFFZCpvb/LkagY9yy8BkZpGAG2yPzGMEU
         Yyind1oKvUjbDKLDIvKvTQaUHzFDEKFws0fD2A76vUIDDvyZKajegTwSLB0qCuGTsQS3
         gzBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=pmRrr7DlSrvh6Afoiu8azY8hCl3ZXESYqSNteWAYVnA=;
        b=HB7TyVfteUFwo7cRns4qXbpANMG+RLp/dtUHwoHYjVwwn2l8RfvDKjtFdoY2HmruLb
         /8iyXJU8JtgwalI/50RCgX5OBqkGG3C74P2PYEpgLB90j1Au6g3TRQn2IqNyPyebcp2I
         fFbA6OG5WqND45GNpXoZSXQPeNYW8kkMCmEP4nLVWcIwYApibocds6bfCKBW2TCUmA46
         +VtV9Kq+QRVG2A1uMmo1YqjAfQQBYa+0xsoUqnLvRknL+6xFioYnSTCHUFowmvSbXOIA
         /zYMS4tSsSr+gZ7ru2R0mH2wt1kIF33fDNB2wIlL6zpepL997AM1KfIQecmI0LFLfRDN
         U/3w==
X-Gm-Message-State: APt69E3H0KUsBfk2kWoh0xARuMipsvDo06DGvSMq1mC6ek5yp5813lPD
        bMtoo1En4aT1zg2Vs7jqDbW/Asih
X-Google-Smtp-Source: ADUXVKLbvBClVE7gDD3/zqzGI5v1Ah6WZhFBScjU5oZF8Gdet7okE1RL3+M3X7Nrm5uUGkOQ1sjadA==
X-Received: by 2002:a2e:cf:: with SMTP id e76-v6mr1196479lji.82.1528369942292;
        Thu, 07 Jun 2018 04:12:22 -0700 (PDT)
Received: from localhost.localdomain ([213.255.186.34])
        by smtp.gmail.com with ESMTPSA id h28-v6sm6776915lfb.43.2018.06.07.04.12.20
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 07 Jun 2018 04:12:21 -0700 (PDT)
From: Matti Vaittinen <mazziesaccount@gmail.com>
X-Google-Original-From: Matti Vaittinen <mvaittin@localhost.localdomain>
Date: Thu, 7 Jun 2018 14:12:18 +0300
To: Rob Herring <robh@kernel.org>
Cc: Matti Vaittinen <mazziesaccount@gmail.com>,
        Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Lee Jones <lee.jones@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        linux-clk <linux-clk@vger.kernel.org>,
        devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        mikko.mutanen@fi.rohmeurope.com, heikki.haikola@fi.rohmeurope.com
Subject: Re: [PATCH v4 2/6] mfd: bd71837: Devicetree bindings for ROHM
 BD71837 PMIC
Message-ID: <20180607111218.GF20078@localhost.localdomain>
References: <20180531030129.GA16122@rob-hp-laptop>
 <20180531071717.GG13528@localhost.localdomain>
 <20180531102315.GA5150@localhost.localdomain>
 <CAL_Jsq+33G7zMEDOUXHQijxqqbvqykxZENLe1-52ECkXwo2o4g@mail.gmail.com>
 <20180601062540.GB5150@localhost.localdomain>
 <CAL_JsqJNMxR=zdwR41iLfWU=u3J_=_VkxVL+g3a12_4vvNwBtw@mail.gmail.com>
 <20180604113225.GE5150@localhost.localdomain>
 <CAL_JsqL3Z_o2CFeYDvb3PqgiskTSHuOVqwdUP+gFymLDTKhn2g@mail.gmail.com>
 <20180606073449.GD20078@localhost.localdomain>
 <CAL_JsqKjwtq+7CSDKiaWGa011oqdsrc-XjOyfuBPOQ9UB=EtWQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAL_JsqKjwtq+7CSDKiaWGa011oqdsrc-XjOyfuBPOQ9UB=EtWQ@mail.gmail.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 06, 2018 at 10:16:37AM -0500, Rob Herring wrote:
> On Wed, Jun 6, 2018 at 2:34 AM, Matti Vaittinen
> <mazziesaccount@gmail.com> wrote:
> > On Tue, Jun 05, 2018 at 10:46:14AM -0500, Rob Herring wrote:
> >> On Mon, Jun 4, 2018 at 6:32 AM, Matti Vaittinen
> >> <mazziesaccount@gmail.com> wrote:
> >> > On Fri, Jun 01, 2018 at 12:32:16PM -0500, Rob Herring wrote:
> >> >> On Fri, Jun 1, 2018 at 1:25 AM, Matti Vaittinen
> >> >> <mazziesaccount@gmail.com> wrote:
> >> >> > On Thu, May 31, 2018 at 09:07:24AM -0500, Rob Herring wrote:
> >> >> >> On Thu, May 31, 2018 at 5:23 AM, Matti Vaittinen
> >> >> >> <mazziesaccount@gmail.com> wrote:
> >> >> >> > On Thu, May 31, 2018 at 10:17:17AM +0300, Matti Vaittinen wrote:
> >> >> >> >> On Wed, May 30, 2018 at 10:01:29PM -0500, Rob Herring wrote:
> >> >> >> >> > On Wed, May 30, 2018 at 11:42:03AM +0300, Matti Vaittinen wrote:
> > Datasheet:
> > https://www.rohm.com/datasheet/BD71837MWV/bd71837mwv-e
> > (Would it be good idea to add this link to comments in MFD driver or to
> > binding document(s)?)
> 
> Yes, it would.

I will add this then. I don't really like adding links like this as urls
tend to change and links become dead - but I guess this is something we
just must live with.

> >                     +--------------------------------------------------+
> >                     |                                                  |
> > VSYS           +-----------------+                    +-----------+    |
> >                     |            |                    |           |    |
> >                     |  +-------+ |                    | BUCKS 1-4 +-------->
> >                     |  |       | |                    |           |    |
> > I2C IF         +------->   H   | +--------------------+  DVS      +-------->
> >                     |  |   O   | |                    |  Support  |    |
> > PWRON_B        +------->   S   | |                    |           +-------->
> >                     |  |   T   | |                    |           |    |
> > PMIC_STBY_REQ  +------->       | |                    |           +-------->

Do you think this ASCII art picture in MFD or regulator driver comments would
be an overkill?

> > On the left we see input lines to PMIC. PWRON_B intended to be connected
> > to power button. PMIC_STBY_REQ and PMIC_ON_REQ lines for controlling HW
> > state machine PMIC has. And WDOG_B from watch dog.
> >
> > PMIC has control register for controlling what happens to BUCK/LDO
> > outputs when input line states change. PMIC reports change in input
> > lines via the IRQ_OUT line and IRQ status register.
> 
> So it looks like this is just regulators with a few other signals to handle.

Yes. Regulators and the HW state machine which is currently mostly
bypassed by drivers. And while we are at it - is there some standard
device-tree properties for describing the voltages for different PMIC states
(idle, run, standby) so that the driver could configure voltages the
bucks should use when PMIC state is changed. Or do you think I should
use custom ones like:

bd71837,pmic-buck1-dvs-voltage = <900000>, <850000>, <800000>; /* VDD_SOC: Run-Idle-Suspend */
bd71837,pmic-buck2-dvs-voltage = <1000000>, <900000>, <0>; /* VDD_ARM: Run-Idle */
bd71837,pmic-buck3-dvs-voltage = <1000000>, <0>, <0>; /* VDD_GPU: Run */
bd71837,pmic-buck4-dvs-voltage = <1000000>, <0>, <0>; /* VDD_VPU: Run */

I think this is not the only PMIC with configurable voltages for
different states so someone has probably already invented a way to
provide this information - is the DT correct place to search for this?

> 
> > So HW mapping for interrup(s) from PMIC would be:
> >
> > (HW) event => BD71837 domain IRQ
> >
> > PMIC_STBY_REQ line level change         => 0
> > PMIC_ON_REQ line level change           => 1
> 
> I'm not really clear how these would have s/w handling. They look like
> handshake signals for the processor to enter and exit standby/suspend.
> H/w designers don't always know what to do with things and may have
> just said lets have an interrupt for every input signal.

The PMIC_ON_REQ can be used to switch the PMIC from 'READY' to 'SNVS'
and from 'SNVS' to 'RUN' states. But same transitions can be configured
to be done by power button presses too.

I think I in some earlier mail said that I can't think how to handle
other but power button interrupts - when PMIC is used to power the
processor controlling PMIC. But I also mentioned another use case
which I can think of - but I am not sure if it is relevant or not. In
this other use case we have a 'slave processor' powered by PMIC doing
some specific tasks - and a 'control processor' which is not powered by
this PMIC - but which may be controlling it (and thus also controls power
for the slave). In such setup all these interrupts mmight become
meaningfull - but handling should be platform specific then. (The
control processor could for example detect slave processor resets or
wake-ups via these interrupts and initiate any platform specific
activities based on this). I have no system design experience so I don't
know if this sounds reasonable or not - but thats why I liked the idea
of providing access to all interrupts via this interrupt-controller.

> I'd think you
> would just want DT properties to configure what action to take (and
> perhaps polarity?).

Currently the driver is not configuring what happens when state of these
signals change. But it could as you say. And it would be nice to get the
configuration from DT. I think the polarity is fixed.


> > PMIC_WDOG_B line level change           => 2
> 
> Ah, this is an input signal, not a watchdog block within the PMIC. I
> think this should just be handled by the core driver. If you need to
> configure what this does, then we can add a property to handle that.

Action taken when WDOG_B is asserted is indeed configurable. PMIC can do
cold reset, warm reset of take no action. But here I again fail to think
how this should be handled - especially because HW default for action is
cold reset. But as I said abowe - it may be there is use case for this
interrupt even though I can't provide generic one. ...and this is why I
liked the idea of having it available via DT... :)

> 
> > PMIC_PWRON_B line level change          => 3
> > PMIC_PWRON_B line/long push detected    => 4
> > PMIC_PWRON_B line/short push detected   => 5
> 
> So you need a power button driver (or maybe not even a separate
> driver) for this, but I don't think that warrants a child node. I
> think some PMIC drivers just generate a power key press (which just
> gets punted to userspace), but some will do an actual power down. Or
> maybe a combination of those based on short/long press.

I agree with you on this. A power button driver could consume these
IRQs. And yes, (input?) event to user-space sounds reasonable. Maybe
also a power-off handler if "system-power-controller" property is given.

Whether this is something crying for own DT node is not my decision. I
just know that having own sub nodes and relying on irq-controller xlate
callbacks eould make driver side really simple.

> 
> I think there's already some DT properties defined to control the
> behavior as well.
> 
> > SWRESET register on PMIC written        => 6
> 
> Probably this can be handled within the core driver. Seems like you'd
> only use this if you have separate entities that write and read this.
> If you don't know, then just ignore it for now.

Yep. My plan was not to implement handling for any of these interrupts
for now. I just wanted to make them easily available for any future use.

> > Hence I liked the idea of hiding the irq register
> > details in MFD driver by declaring it as interrupt controller - and
> > leaving the interrupts to be used by what ever drivers need the change
> > information is system the PMIC is used.
> 
> This can still be done but doesn't have to be in DT.

I think this is my weak spot. I don't know how to do this easily without
DT. How do I bring the irq to power-button driver or to WDOG
irq handler (or XXX-driver invented by one who needs these IRQs) without
DT. Options I can think of are:

1. getting the GPIO irq (from MFD parent) and making the IRQ registers
   visible to power button/XXX drivers. Possibly ending up with shared
   IRQ hanlder.
2. Keeping the IRQ register accesses in MFD driver and providing some
   handler callback registration interface from MFD driver to power
   button/XXX drivers
3. Using this interrupt-controller approach.

I dislike option 1 because all drivers using IRQs need to be aware of
IRQ registers.

I dislike option 2 because inventing such IRQ callbacks just feel wrong.
There must be better way - I just don't know it =)

I would like to use option 3 - but I don't know how to do it without DT?
Specifically I don't know how to provide the irq number and interrupt
parent to power-button/XXX drivers if they are not brought from DT. And
why to invent some parallel mechanism for this when DT usage already
provides this. I would be really gratefull for any tips how to do this
correctly if DT is not used.

> > So what do you think of this:
> >
> > +Optional properties:
> > + - interrupt-controller        : Marks the device node as an interrupt controller.
> > +                         BD71837MWV can report input line state change and SW
> > +                         reset events via interrupts. Different events can be seen
> > +                         as separate BD71837 domain interrupts.
> > + - #interrupt-cells    : The number of cells to describe an IRQ should be 1.
> > +                         The value in cell is the IRQ number.
> > +                           Meaningfull numbers are:
> > +                             0 => PMIC_STBY_REQ level change
> > +                             1 => PMIC_ON_REQ level change
> > +                             2 => WDOG_B level change
> > +                             3 => Power Button level change
> > +                             4 => Power Button Long Push
> > +                             5 => Power Button Short Push
> > +                             6 => SWRESET register is written 1
> >
> > Would this be getting closer to what is needed from binding document?
> 
> I don't think any of this needs to live in DT. All you really need a
> separate driver (and hence irq) for is really just the power button.
> You can just define the interrupts within the kernel.

So I tried to argue that all of the IRQs should be usable and we should
not limit the HW capabilities by design (I like the idea of exposing all
HW functionality because I only rarely know what should be usable better
than the user). Are you sure my dual processor use-case is not
convincing you we should provide these interrupts via DT?

If so - as I already said, I would be gratefull for any suggestions on
how to provide access to irqs without DT. I just can't help feeling that
DT would have been the best way for cleanest and most
understandable/usable end result.

Meanwhile I will prepare a patch where the interrupt handling is
completely ripped from MFD and binding documents as I don't have power
button driver tested (I drafted something though). Maybe such a patch
could be acceptable in order to enable regulator usage (and
compilation). Is that Ok?

Best Regards
    Matti Vaittinen
