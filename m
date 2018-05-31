Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754050AbeEaIWz (ORCPT <rfc822;w@1wt.eu>);
        Thu, 31 May 2018 04:22:55 -0400
Received: from mail-lf0-f68.google.com ([209.85.215.68]:38799 "EHLO
        mail-lf0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753957AbeEaIWr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 May 2018 04:22:47 -0400
X-Google-Smtp-Source: ADUXVKKB/VICoccB/EhzjnZx+Up72Fo1RxBG3hW+zuiQSY0gdhUHN7aGaUIVajG8ZCORdP3vgxcBbg==
Date: Thu, 31 May 2018 10:22:41 +0200
From: Johan Hovold <johan@kernel.org>
To: Rob Herring <robh@kernel.org>
Cc: Johan Hovold <johan@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Andreas Kemnade <andreas@kemnade.info>, Arnd Bergmann <arnd@arndb.de>,
        "H . Nikolaus Schaller" <hns@goldelico.com>,
        Pavel Machek <pavel@ucw.cz>, Marcel Holtmann <marcel@holtmann.org>,
        Sebastian Reichel <sebastian.reichel@collabora.co.uk>,
        Tony Lindgren <tony@atomide.com>, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v2 4/8] dt-bindings: gnss: add u-blox binding
Message-ID: <20180531082241.GD3259@localhost>
References: <20180530103242.20773-1-johan@kernel.org>
 <20180530103242.20773-5-johan@kernel.org>
 <20180531035805.GA16906@rob-hp-laptop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180531035805.GA16906@rob-hp-laptop>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 30, 2018 at 10:58:05PM -0500, Rob Herring wrote:
> On Wed, May 30, 2018 at 12:32:38PM +0200, Johan Hovold wrote:
> > Add binding for u-blox GNSS receivers.
> > 
> > Note that the u-blox product names encodes form factor (e.g. "neo"),
> > chipset (e.g. "8") and variant (e.g. "q"), but that only formfactor and
> > chipset is used for the compatible strings (for now).
> > 
> > Signed-off-by: Johan Hovold <johan@kernel.org>
> > ---
> >  .../devicetree/bindings/gnss/u-blox.txt       | 44 +++++++++++++++++++
> >  .../devicetree/bindings/vendor-prefixes.txt   |  1 +
> >  2 files changed, 45 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/gnss/u-blox.txt
> > 
> > diff --git a/Documentation/devicetree/bindings/gnss/u-blox.txt b/Documentation/devicetree/bindings/gnss/u-blox.txt
> > new file mode 100644
> > index 000000000000..caef9ace0b0c
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/gnss/u-blox.txt
> > @@ -0,0 +1,44 @@
> > +u-blox GNSS Receiver DT binding
> > +
> > +The u-blox GNSS receivers can use UART, DDC (I2C), SPI and USB interfaces.
> > +
> > +Please see Documentation/devicetree/bindings/gnss/gnss.txt for generic
> > +properties.
> > +
> > +Required properties:
> > +
> > +- compatible 	: Must be one of
> 
> mixture of space and tab here.

Oops. Same single space character before the tab here in all three
binding docs (and in the in-tree slave_devices.txt which I think I used
as a template).

Do you want me to fix this even if this turns out to be the only thing
that needs to be addressed in a v3?

> > +
> > +			"u-blox,neo-8"
> > +			"u-blox,neo-m8"
> > +
> > +- vcc-supply	: Main voltage regulator
> > +
> > +Required properties (DDC):
> > +- reg		: DDC (I2C) slave address
> > +
> > +Required properties (SPI):
> > +- reg		: SPI chip select address
> > +
> > +Required properties (USB):
> > +- reg		: Number of the USB hub port or the USB host-controller port
> > +                  to which this device is attached
> > +
> > +Optional properties:
> > +
> > +- timepulse-gpios	: Time pulse GPIO
> > +- u-blox,extint-gpios	: External interrupt GPIO
> 
> This should be interrupts property instead of a gpio.

Contrary to what the name may suggest, this pin is actually an input
which can be used to control active power or to provide time or
frequency aiding data to the receiver (see section 1.13 in [1]).

I only added it for completeness as the driver does not use it
currently. Remove, leave as is, or add "input" to the description as in:

	- u-blox,extint-gpios	: External interrupt input GPIO

perhaps?

Thanks,
Johan

[1] https://www.u-blox.com/sites/default/files/NEO-8Q_DataSheet_%28UBX-15031913%29.pdf
