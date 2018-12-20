Return-Path: <SRS0=2vky=O5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 637E9C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 20:58:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 317E5218FE
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 20:58:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389723AbeLTU60 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Dec 2018 15:58:26 -0500
Received: from metis.ext.pengutronix.de ([85.220.165.71]:35553 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729211AbeLTU6Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Dec 2018 15:58:25 -0500
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ukl@pengutronix.de>)
        id 1ga5OW-0005zd-Dj; Thu, 20 Dec 2018 21:58:12 +0100
Received: from ukl by ptx.hi.pengutronix.de with local (Exim 4.89)
        (envelope-from <ukl@pengutronix.de>)
        id 1ga5OT-0000P7-8J; Thu, 20 Dec 2018 21:58:09 +0100
Date:   Thu, 20 Dec 2018 21:58:09 +0100
From:   Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     Paul Cercueil <paul@crapouillou.net>,
        Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ralf Baechle <ralf@linux-mips.org>, paul.burton@mips.com,
        James Hogan <jhogan@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Mathieu Malaterre <malat@debian.org>, ezequiel@collabora.co.uk,
        prasannatsmkumar@gmail.com, linux-pwm@vger.kernel.org,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        LINUXWATCHDOG <linux-watchdog@vger.kernel.org>,
        linux-mips@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-clk <linux-clk@vger.kernel.org>, od@zcrc.me
Subject: Re: [PATCH v8 15/26] pwm: jz4740: Add support for the JZ4725B
Message-ID: <20181220205809.5t2klpb7donmoibb@pengutronix.de>
References: <20181212220922.18759-1-paul@crapouillou.net>
 <20181212220922.18759-16-paul@crapouillou.net>
 <20181213092409.ml4wpnzow2nnszkd@pengutronix.de>
 <1544709795.18952.1@crapouillou.net>
 <20181213204219.onem3q6dcmakusl2@pengutronix.de>
 <CACRpkdbABtDgwKai=8Pfji7qVb-XHsX8pDsuDdS5hhg7qEN0Bw@mail.gmail.com>
 <20181214142628.zwi4hadrju53z6f3@pengutronix.de>
 <1544969932.1649.1@crapouillou.net>
 <20181217075321.k45vhgnszeqs3tea@pengutronix.de>
 <20181220173904.GE9408@ulmo>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20181220173904.GE9408@ulmo>
User-Agent: NeoMutt/20170113 (1.7.2)
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c0
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 20, 2018 at 06:39:04PM +0100, Thierry Reding wrote:
> On Mon, Dec 17, 2018 at 08:53:21AM +0100, Uwe Kleine-König wrote:
> > On Sun, Dec 16, 2018 at 03:18:52PM +0100, Paul Cercueil wrote:
> > > Hi,
> > > 
> > > Le ven. 14 déc. 2018 à 15:26, Uwe Kleine-König
> > > <u.kleine-koenig@pengutronix.de> a écrit :
> > > > Hello,
> > > > 
> > > > On Fri, Dec 14, 2018 at 02:50:20PM +0100, Linus Walleij wrote:
> > > > > On Thu, Dec 13, 2018 at 9:42 PM Uwe Kleine-König
> > > > > <u.kleine-koenig@pengutronix.de> wrote:
> > > > > > [Adding Linus Walleij to Cc:]
> > > > > > On Thu, Dec 13, 2018 at 03:03:15PM +0100, Paul Cercueil wrote:
> > > > > > > Le jeu. 13 déc. 2018 à 10:24, Uwe Kleine-König
> > > > > > > <u.kleine-koenig@pengutronix.de> a écrit :
> > > > > > > > On Wed, Dec 12, 2018 at 11:09:10PM +0100, Paul Cercueil wrote:
> > > > > > > > >  The PWM in the JZ4725B works the same as in the JZ4740,
> > > > > > > > >  except that it only has 6 channels available instead of
> > > > > > > > >  8.
> > > > > > > >
> > > > > > > > this driver is probed only from device tree? If yes, it
> > > > > > > > might be sensible to specify the number of PWMs there and
> > > > > > > > get it from there.
> > > > > > > > There doesn't seem to be a generic binding for that, but there are
> > > > > > > > several drivers that could benefit from it. (This is a bigger project
> > > > > > > > though and shouldn't stop your patch. Still more as it already got
> > > > > > > > Thierry's ack.)
> > > > > > >
> > > > > > > I think there needs to be a proper guideline, as there doesn't seem to be
> > > > > > > a consensus about this. I learned from emails with Rob and  Linus (Walleij)
> > > > > > > that I should not have in devicetree what I can deduce from the compatible
> > > > > > > string.
> > > > > >
> > > > > > I understood them a bit differently. It is ok to deduce things from the
> > > > > > compatible string. But if you define a generic property (say) "num-pwms"
> > > > > > that is used uniformly in most bindings this is ok, too. (And then the
> > > > > > two different devices could use the same compatible.)
> > > > > >
> > > > > > An upside of the generic "num-pwms" property is that the pwm core could
> > > > > > sanity check pwm phandles before passing them to the hardware drivers.
> > > > > 
> > > > >  I don't know if this helps, but in GPIO we have "ngpios" which is
> > > > >  used to augment an existing block as to the number of lines actually
> > > > >  used with it.
> > > > > 
> > > > >  The typical case is that an ASIC engineer synthesize a block for
> > > > >  32 GPIOs but only 12 of them are routed to external pads. So
> > > > >  we augment the behaviour of that driver to only use 12 of the
> > > > >  32 lines.
> > > > > 
> > > > >  I guess using the remaining 20 lines "works" in a sense but they
> > > > >  have no practical use and will just bias electrons in the silicon
> > > > >  for no use.
> > > > 
> > > > This looks very similar to the case under discussion.
> > > > 
> > > > >  So if the PWM case is something similar, then by all means add
> > > > >  num-pwms.
> > > > 
> > > > .. or "npwms" to use the same nomenclature as the gpio binding?
> > > 
> > > If we're going to do something like this, should it be the drivers or
> > > the core (within pwmchip_add) that checks for this "npwms" property?
> > 
> > Of course this should be done in the core. The driver than can rely on
> > the validity of the index. But as I wrote before, this shouldn't stop
> > your patch from going in.

Actually the core already takes care of the validity of the index with
the number of pwms being provided to pwmchip_add().
 
> > But if Thierry agrees that this npmws (or num-pwms) is a good idea, it
> > would be great to start early to convert drivers.
> 
> Do we actually need this? It seems like Paul's patch here properly
> derives the number of available PWMs from the compatible string, so I
> don't see what the extra num-pwms (or whatever) property would add.

Given that the only difference between the two different implementations
is just the number of pwms provided, this could just be expressed in the
dts as:

	pwm@2000000 {
		compatible = "jz4740";
		num-pwms = <8>;
	}

and

	pwm@2000000 {
		compatible = "jz4740";
		num-pwms = <6>;
	}

instead of

	pwm@2000000 {
		compatible = "jz4740";
	}

and

	pwm@2000000 {
		compatible = "jz4725";
	}

. According to my metric the former is more descriptive and so better.

And then the pwm core could provide parsing of that property (e.g. if
chip.npwm == 0) which simplifies the driver (and all others using that
mechanism).

Regarding the question "Do we actually need this?": We don't, but I
think it would make a nice step to get more descriptive device trees and
so I consider it an improvement. It would also allow to check a dtb
because even without the driver you can notice that

	pwms = <&pwm 12 0>;

is invalid if &pwm has "num-pwms = <8>". Drivers that could benefit are
(at least): hibvt, sun4i, tegra, lpss.

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-König            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
