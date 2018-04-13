Return-Path: <robh@kernel.org>
X-Google-Smtp-Source: AIpwx4+REgus17UhJJ4d9kQPLcqvGMzSLMQsnxjRe4UDuUXl7Ul7aEfwQnYqbBKCy9HSHd3mmyLH
ARC-Seal: i=1; a=rsa-sha256; t=1523633607; cv=none;
        d=google.com; s=arc-20160816;
        b=0BnvhKrJiOrUVAeYC7qbVheSnBwQf9Go4X9VnfkPUoSTNwXxYdzLpoGUFDiK1x5rOO
         5bTcyZHw13RosoCiziE7wu8tQeC9JWSLEg8m/GF8l0yH3C4pQBNNjuNTA2BTnXOp/RuR
         20x8YZ54syOcenoRgM5oum8kpTjNKNBFjdk1oBPqlhCa+EUXGQXtt9ehwziF3RGmYjn8
         afJ9pKP9JiJZZ5LEyarBGI0yLOuKlSR3iKQVTcsJed0feErjKPkDpvI4JIdZfK/+lK3p
         JbYX388qmqUCzC+k9Zae3b4al3cpcalRbvGdGRSQS1+0OGdAUPwlhtVTSnwRYCkzHyOk
         VAFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:references:in-reply-to
         :mime-version:dmarc-filter:arc-authentication-results;
        bh=k6ZMOXA0imTpT8r2kbCmPp0l4A7NhN/RkpVZZqA+qDQ=;
        b=Kq63X/kOzJCli/KrqQtrnEMdc0zNFfyoGLVEfZpmGxedF9sgDoorjrVn5OkhrXvY07
         8D+/R9M+z6H7mJJyKaKFO0plqRH0o4jPen0urrK4TbMgxP21YtqOLejEx5dpT5YvuqkK
         1YyWrppwZAmNzrRqwdiLbHJs1AapgOhPgtTIGAKpg1xatFYC1I+EE/Qp4WPPUG4AIoaU
         X/Af1p37ynweyqQc/QzJI0/+TiivtjvfaSxkomHG9YhOyBlDiIdtKcrvF/QFiQnF+g0B
         KVVFbzdbNA8zL/fw5zmoB6OB0dBWjxKfBcbXShUGR6nVVlaO7Lbx3ET0x+1Gn9jRVp5v
         742g==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of robh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=robh@kernel.org
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of robh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=robh@kernel.org
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8CC772183A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=robh@kernel.org
MIME-Version: 1.0
In-Reply-To: <20180409211337.goavadt6f22wtkbw@earth.universe>
References: <20180327135259.30890-1-sebastian.reichel@collabora.co.uk>
 <20180327135259.30890-2-sebastian.reichel@collabora.co.uk>
 <20180409185727.j4unhx5ig3fgm6ex@rob-hp-laptop> <20180409211337.goavadt6f22wtkbw@earth.universe>
From: Rob Herring <robh@kernel.org>
Date: Fri, 13 Apr 2018 10:33:05 -0500
X-Gmail-Original-Message-ID: <CAL_JsqJfj_tvojYnGQhK1Pj88tUFMGX6cB1t0=U5-34XKaA+bw@mail.gmail.com>
Message-ID: <CAL_JsqJfj_tvojYnGQhK1Pj88tUFMGX6cB1t0=U5-34XKaA+bw@mail.gmail.com>
Subject: Re: [PATCHv2 1/3] dt-bindings: misc: achc: Make ezport distinguishable
To: Sebastian Reichel <sebastian.reichel@collabora.co.uk>
Cc: Arnd Bergmann <arnd@arndb.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <kernel@pengutronix.de>,
	Fabio Estevam <fabio.estevam@nxp.com>, Mark Rutland <mark.rutland@arm.com>,
	Nandor Han <nandor.han@ge.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, devicetree@vger.kernel.org,
	kernel@collabora.com
Content-Type: text/plain; charset="UTF-8"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1596099171871027959?=
X-GMAIL-MSGID: =?utf-8?q?1597645633777197632?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Mon, Apr 9, 2018 at 4:13 PM, Sebastian Reichel
<sebastian.reichel@collabora.co.uk> wrote:
> Hi,
>
> On Mon, Apr 09, 2018 at 01:57:27PM -0500, Rob Herring wrote:
>> On Tue, Mar 27, 2018 at 03:52:57PM +0200, Sebastian Reichel wrote:
>> > This updates the GE ACHC binding, so that different compatible
>> > strings are used for the programming interface, which is the
>> > ezport interface from NXP MK20FN1M0VMD12 and the microcontroller's
>> > normal SPI interface.
>> >
>> > Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.co.uk>
>> > ---
>> >  Documentation/devicetree/bindings/misc/ge-achc.txt | 19 ++++++++++++++++---
>> >  1 file changed, 16 insertions(+), 3 deletions(-)
>> >
>> > diff --git a/Documentation/devicetree/bindings/misc/ge-achc.txt b/Documentation/devicetree/bindings/misc/ge-achc.txt
>> > index 77df94d7a32f..6c6bd6568504 100644
>> > --- a/Documentation/devicetree/bindings/misc/ge-achc.txt
>> > +++ b/Documentation/devicetree/bindings/misc/ge-achc.txt
>> > @@ -7,7 +7,13 @@ Note: This device does not expose the peripherals as USB devices.
>> >
>> >  Required properties:
>> >
>> > -- compatible : Should be "ge,achc"
>> > +- compatible : Should be
>> > +  "ge,achc" (normal interface)
>> > +  "ge,achc-ezport" (flashing interface)
>> > +
>> > +Required properties (flashing interface only):
>> > +
>> > +- reset-gpios: GPIO Specifier for the reset GPIO
>>
>> Does the reset only affect the flashing interface and are the data pins
>> shared? If not for both, then I think the correct thing to do here is
>> just extend reg to support multiple values to represent multiple chip
>> selects.
>
> reset affects the whole chip and the same spi data/clock pins are
> being used, so extending reg should work. The flashing cannot happen
> with the same speed, though. I'm currently encoding this by using
> different "spi-max-frequency" properties. I suppose I could limit
> it in the driver instead. I tried to come up with an example for
> your suggestion. Is this what you had in mind?

If the max frequency is the device max, then that should be in the
driver. spi-max-frequency should really only be needed if the
frequency is less than the max of either the host or device.

>
> &spi_controller {
>     achc@multiple {

@0

unit addresses are the 1st address.

>         /* 0 = flashing interface, 1 = normal interface */
>         reg = <0>, <1>;

You may want to put the normal interface first as that is the primary
interface and would still work assuming the OS ignored extra entries.

>         compatible = "ge,achc";
>         reset-gpios = <&gpio42 23 ACTIVE_LOW>;
>         spi-max-frequency = <42>; /* max speed for normal operation */

42 Hz?

Rob
