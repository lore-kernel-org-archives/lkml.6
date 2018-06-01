Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751250AbeFAIQB (ORCPT <rfc822;w@1wt.eu>);
        Fri, 1 Jun 2018 04:16:01 -0400
Received: from mail-lf0-f68.google.com ([209.85.215.68]:47035 "EHLO
        mail-lf0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750987AbeFAIP5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jun 2018 04:15:57 -0400
X-Google-Smtp-Source: ADUXVKLdaesd3UNIFyndcZWn1dlnkE7Npg1G5O0T3HdFYbK//2rvPp7rnddezOG60syKlmKXCNqXTg==
Date: Fri, 1 Jun 2018 10:15:48 +0200
From: Johan Hovold <johan@kernel.org>
To: Rob Herring <robh@kernel.org>
Cc: Johan Hovold <johan@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Andreas Kemnade <andreas@kemnade.info>, Arnd Bergmann <arnd@arndb.de>,
        "H . Nikolaus Schaller" <hns@goldelico.com>,
        Pavel Machek <pavel@ucw.cz>, Marcel Holtmann <marcel@holtmann.org>,
        Sebastian Reichel <sebastian.reichel@collabora.co.uk>,
        Tony Lindgren <tony@atomide.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v2 4/8] dt-bindings: gnss: add u-blox binding
Message-ID: <20180601081548.GN3259@localhost>
References: <20180530103242.20773-1-johan@kernel.org>
 <20180530103242.20773-5-johan@kernel.org>
 <20180531035805.GA16906@rob-hp-laptop>
 <20180531082241.GD3259@localhost>
 <CAL_Jsq+-NBqR8H49oB-XZtH8XSCn_BO92Zf17=KfEXfE5mvjAg@mail.gmail.com>
 <20180531143428.GK3259@localhost>
 <CAL_JsqLfqgUbzMWdE_c96DrdgB31gSixbJo+JvsZhoJGJRWYMw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAL_JsqLfqgUbzMWdE_c96DrdgB31gSixbJo+JvsZhoJGJRWYMw@mail.gmail.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 31, 2018 at 10:58:59AM -0500, Rob Herring wrote:
> On Thu, May 31, 2018 at 9:34 AM, Johan Hovold <johan@kernel.org> wrote:
> > On Thu, May 31, 2018 at 08:55:10AM -0500, Rob Herring wrote:
> >> On Thu, May 31, 2018 at 3:22 AM, Johan Hovold <johan@kernel.org> wrote:
> >> > On Wed, May 30, 2018 at 10:58:05PM -0500, Rob Herring wrote:
> >> >> On Wed, May 30, 2018 at 12:32:38PM +0200, Johan Hovold wrote:
> >> >> > Add binding for u-blox GNSS receivers.

> >> >> > +Optional properties:
> >> >> > +
> >> >> > +- timepulse-gpios  : Time pulse GPIO
> >> >> > +- u-blox,extint-gpios      : External interrupt GPIO
> >> >>
> >> >> This should be interrupts property instead of a gpio.
> >> >
> >> > Contrary to what the name may suggest, this pin is actually an input
> >> > which can be used to control active power or to provide time or
> >> > frequency aiding data to the receiver (see section 1.13 in [1]).
> >> >
> >> > I only added it for completeness as the driver does not use it
> >> > currently. Remove, leave as is, or add "input" to the description as in:
> >> >
> >> >         - u-blox,extint-gpios   : External interrupt input GPIO
> >>
> >> Yes. You should also define the active level.
> >
> > The active level appears to be runtime configurable and dependent on the
> > selected function. For power control it can be used to control force-on
> > (active high), force-off (active low) or both; and for time aiding
> > sampling on falling or rising edge is also configurable. And who knows
> > what else this pin is used for next time they update the firmware. ;)
> 
> Okay.
> 
> > Shall I remove the property, or just add "input" as suggested above?
> 
> Just add "input".

I ended up rewording this as

	u-blox,extint-gpios  : GPIO connected to the "external
			       interrupt" input pin

to avoid any confusion about the direction of the GPIO.

Thanks,
Johan
