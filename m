Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752061AbeBAJui (ORCPT <rfc822;w@1wt.eu>);
        Thu, 1 Feb 2018 04:50:38 -0500
Received: from esa5.microchip.iphmx.com ([216.71.150.166]:10075 "EHLO
        esa5.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751628AbeBAJue (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Feb 2018 04:50:34 -0500
X-IronPort-AV: E=Sophos;i="5.46,443,1511852400";
   d="scan'208";a="8780226"
Date: Thu, 1 Feb 2018 10:50:21 +0100
From: Ludovic Desroches <ludovic.desroches@microchip.com>
To: Rob Herring <robh@kernel.org>
CC: Linus Walleij <linus.walleij@linaro.org>,
        Ludovic Desroches <ludovic.desroches@microchip.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        <linux-gpio@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
        <devicetree@vger.kernel.org>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@free-electrons.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] pinctrl: at91-pio4: add support for drive-strength
 property
Message-ID: <20180201095021.GA2580@rfolt0960.corp.atmel.com>
Mail-Followup-To: Rob Herring <robh@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-gpio@vger.kernel.org,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@free-electrons.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20180118160208.16461-1-ludovic.desroches@microchip.com>
 <CACRpkdanweSmHd_M+feHauEHtvKSW+-W=djb186BFdbxTf20Jg@mail.gmail.com>
 <20180129190130.qjej6hmudszzbfdz@rob-hp-laptop>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20180129190130.qjej6hmudszzbfdz@rob-hp-laptop>
User-Agent: Mutt/1.9.3 (2018-01-21)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 29, 2018 at 01:01:30PM -0600, Rob Herring wrote:
> On Mon, Jan 22, 2018 at 09:37:38AM +0100, Linus Walleij wrote:
> > On Thu, Jan 18, 2018 at 5:02 PM, Ludovic Desroches
> > <ludovic.desroches@microchip.com> wrote:
> > 
> > > Add support for the drive-strength property. Usually its value is
> > > expressed in mA. Since the numeric value depends on VDDIOP voltage,
> > > the controller uses low, medium and high to define the drive-strengh.
> > 
> > Aha I see. That's complex. It certainly results in a certain mA drive
> > strength in the end, but what you're saying is that this is not usually
> > what we configure.
> > 
> > > The PIO controller accepts two values for the low drive: 0 or 1. Most
> > > of the time, we don't care about the drive strength, there is no need
> > > to change it, so 0 is considered as the default value.
> > 
> > Do you mean default value as in "whatever the hardware was set
> > up as at boot time"?
> > 
> > > The low-drive
> > > value won't be advertised through pinconf-pins file excepted if it
> > 
> > except?
> > 
> > > has been set explicitly in the device tree ie if its value is
> > > different from 0.
> > >
> > > Signed-off-by: Ludovic Desroches <ludovic.desroches@microchip.com>
> > 
> > OK I think I get it.
> > 
> > >  Optional properties:
> > >  - GENERIC_PINCONFIG: generic pinconfig options to use, bias-disable,
> > > -bias-pull-down, bias-pull-up, drive-open-drain, input-schmitt-enable,
> > > -input-debounce, output-low, output-high.
> > > +bias-pull-down, bias-pull-up, drive-open-drain, drive-strength,
> > > +input-schmitt-enable, input-debounce, output-low, output-high.
> > (...)
> > > +                       drive-strength = <ATMEL_PIO_DRVSTR_LO>;
> > 
> > So you say you support this argument and it will be something like
> > 
> > include/dt-bindings/pinctrl/at91.h:#define ATMEL_PIO_DRVSTR_LO  1
> > include/dt-bindings/pinctrl/at91.h:#define ATMEL_PIO_DRVSTR_ME  2
> > include/dt-bindings/pinctrl/at91.h:#define ATMEL_PIO_DRVSTR_HI  3
> > 
> > But the definition if generic drive strength is actually in mA.
> 
> Yes, and the reason we put unit suffixes on properties is to avoid 
> differing units.
>  
> > I think it is OK to deviate from stating it in mA, but you should
> > write this in the DT bindings so people do not get confused.
> 
> I don't think it is okay. If "drive-strength" doesn't work, then use 
> a vendor specific property ("atmel,drive-strength"). Of course, I might 
> forget this in the next version and tell you to use a standard property 
> in mA. 

Ok, so I am going to send the next version! The purpose is to keep using the
generic pinconf parsing function.
If I need to use "atmel,drive-strength" property, I assume I could
manage it with custom_params, isn't it?

Regards

Ludovic
