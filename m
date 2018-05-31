Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755372AbeEaNzh (ORCPT <rfc822;w@1wt.eu>);
        Thu, 31 May 2018 09:55:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:34972 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755155AbeEaNzc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 May 2018 09:55:32 -0400
X-Google-Smtp-Source: ADUXVKJvgs6DOiApuszpdfgczO0utfILXN4e6A+y1dRG/j1NhrwEXpX5pkNjcB3XBVbYdgGJS8aZpV6w1ES4f+EXJwU=
MIME-Version: 1.0
In-Reply-To: <20180531082241.GD3259@localhost>
References: <20180530103242.20773-1-johan@kernel.org> <20180530103242.20773-5-johan@kernel.org>
 <20180531035805.GA16906@rob-hp-laptop> <20180531082241.GD3259@localhost>
From: Rob Herring <robh@kernel.org>
Date: Thu, 31 May 2018 08:55:10 -0500
X-Gmail-Original-Message-ID: <CAL_Jsq+-NBqR8H49oB-XZtH8XSCn_BO92Zf17=KfEXfE5mvjAg@mail.gmail.com>
Message-ID: <CAL_Jsq+-NBqR8H49oB-XZtH8XSCn_BO92Zf17=KfEXfE5mvjAg@mail.gmail.com>
Subject: Re: [PATCH v2 4/8] dt-bindings: gnss: add u-blox binding
To: Johan Hovold <johan@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Andreas Kemnade <andreas@kemnade.info>, Arnd Bergmann <arnd@arndb.de>,
        "H . Nikolaus Schaller" <hns@goldelico.com>,
        Pavel Machek <pavel@ucw.cz>, Marcel Holtmann <marcel@holtmann.org>,
        Sebastian Reichel <sebastian.reichel@collabora.co.uk>,
        Tony Lindgren <tony@atomide.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 31, 2018 at 3:22 AM, Johan Hovold <johan@kernel.org> wrote:
> On Wed, May 30, 2018 at 10:58:05PM -0500, Rob Herring wrote:
>> On Wed, May 30, 2018 at 12:32:38PM +0200, Johan Hovold wrote:
>> > Add binding for u-blox GNSS receivers.
>> >
>> > Note that the u-blox product names encodes form factor (e.g. "neo"),
>> > chipset (e.g. "8") and variant (e.g. "q"), but that only formfactor and
>> > chipset is used for the compatible strings (for now).
>> >
>> > Signed-off-by: Johan Hovold <johan@kernel.org>
>> > ---
>> >  .../devicetree/bindings/gnss/u-blox.txt       | 44 +++++++++++++++++++
>> >  .../devicetree/bindings/vendor-prefixes.txt   |  1 +
>> >  2 files changed, 45 insertions(+)
>> >  create mode 100644 Documentation/devicetree/bindings/gnss/u-blox.txt
>> >
>> > diff --git a/Documentation/devicetree/bindings/gnss/u-blox.txt b/Documentation/devicetree/bindings/gnss/u-blox.txt
>> > new file mode 100644
>> > index 000000000000..caef9ace0b0c
>> > --- /dev/null
>> > +++ b/Documentation/devicetree/bindings/gnss/u-blox.txt
>> > @@ -0,0 +1,44 @@
>> > +u-blox GNSS Receiver DT binding
>> > +
>> > +The u-blox GNSS receivers can use UART, DDC (I2C), SPI and USB interfaces.
>> > +
>> > +Please see Documentation/devicetree/bindings/gnss/gnss.txt for generic
>> > +properties.
>> > +
>> > +Required properties:
>> > +
>> > +- compatible       : Must be one of
>>
>> mixture of space and tab here.
>
> Oops. Same single space character before the tab here in all three
> binding docs (and in the in-tree slave_devices.txt which I think I used
> as a template).

Who wrote that crap? ;)

> Do you want me to fix this even if this turns out to be the only thing
> that needs to be addressed in a v3?

No

>
>> > +
>> > +                   "u-blox,neo-8"
>> > +                   "u-blox,neo-m8"
>> > +
>> > +- vcc-supply       : Main voltage regulator
>> > +
>> > +Required properties (DDC):
>> > +- reg              : DDC (I2C) slave address
>> > +
>> > +Required properties (SPI):
>> > +- reg              : SPI chip select address
>> > +
>> > +Required properties (USB):
>> > +- reg              : Number of the USB hub port or the USB host-controller port
>> > +                  to which this device is attached
>> > +
>> > +Optional properties:
>> > +
>> > +- timepulse-gpios  : Time pulse GPIO
>> > +- u-blox,extint-gpios      : External interrupt GPIO
>>
>> This should be interrupts property instead of a gpio.
>
> Contrary to what the name may suggest, this pin is actually an input
> which can be used to control active power or to provide time or
> frequency aiding data to the receiver (see section 1.13 in [1]).
>
> I only added it for completeness as the driver does not use it
> currently. Remove, leave as is, or add "input" to the description as in:
>
>         - u-blox,extint-gpios   : External interrupt input GPIO

Yes. You should also define the active level.

Rob
