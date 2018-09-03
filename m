Return-Path: <SRS0=G629=LR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECF5FC43334
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 11:25:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 92775204EC
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 11:25:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 92775204EC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=jmondi.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727402AbeICPpV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Sep 2018 11:45:21 -0400
Received: from relay2-d.mail.gandi.net ([217.70.183.194]:49659 "EHLO
        relay2-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726023AbeICPpV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Sep 2018 11:45:21 -0400
X-Originating-IP: 2.224.242.101
Received: from w540 (2-224-242-101.ip172.fastwebnet.it [2.224.242.101])
        (Authenticated sender: jacopo@jmondi.org)
        by relay2-d.mail.gandi.net (Postfix) with ESMTPSA id 20B884002A;
        Mon,  3 Sep 2018 11:25:32 +0000 (UTC)
Date:   Mon, 3 Sep 2018 13:25:17 +0200
From:   jacopo mondi <jacopo@jmondi.org>
To:     Phil Edworthy <phil.edworthy@renesas.com>
Cc:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Simon Horman <horms@verge.net.au>,
        "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>,
        "linux-renesas-soc@vger.kernel.org" 
        <linux-renesas-soc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 0/3] Renesas R9A06G032 PINCTRL Driver
Message-ID: <20180903112517.GE20333@w540>
References: <1535634775-19365-1-git-send-email-phil.edworthy@renesas.com>
 <20180903103358.GC20333@w540>
 <TY1PR01MB17697F04004A7C8CF1D21CC1F50C0@TY1PR01MB1769.jpnprd01.prod.outlook.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="Zrag5V6pnZGjLKiw"
Content-Disposition: inline
In-Reply-To: <TY1PR01MB17697F04004A7C8CF1D21CC1F50C0@TY1PR01MB1769.jpnprd01.prod.outlook.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--Zrag5V6pnZGjLKiw
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Phil,

On Mon, Sep 03, 2018 at 11:03:18AM +0000, Phil Edworthy wrote:
> Hi Jacopo,
>
> On 03 September 2018 11:34, jacopo mondi wrote:
> > On Thu, Aug 30, 2018 at 02:12:52PM +0100, Phil Edworthy wrote:
> > > This implements the pinctrl driver for the RZ/N1 family of devices, i=
ncluding
> > > the R9A06G032 (RZ/N1D) device.
> > >
> > > One area that is likely to be contentious is the use of 'virtual pins=
' for the
> > > MDIO pinmuxing. The driver uses two pins (170 and 171) that don't exi=
st on
> > the
> > > device to configure the MDIO source within the RZ/N1 devices. On these
> > devices,
> > > there are two Ethernet MACs, a 5-Port Switch, numerous industrial
> > Ethernet
> > > peripherals, any of which can be the MDIO source. Configuring the MDIO
> > source
> > > could be done without the virtual pins, e.g. by extending the functio=
ns to
> > > cover all MDIO variants (a total of 32 additional functions), but thi=
s would
> > > allow users to misconfigure individual MDIO pins, rather than assign =
all
> > MDIO
> > > pins to a MDIO source. The choice of how to implement this will affec=
t the
> > > DT bindings.
> > >
> > > This series was originally written by Michel Pollet whilst at Renesas=
, and I
> > > have taken over this work.
> > >
> > > One point from Michel's v1 series:
> > > "Note, I used renesas,rzn1-pinmux node to specify the pinmux constant=
s,
> > > and I also don't use some of the properties documented in
> > > pinctrl-bindings.txt on purpose, as they are too limited for my use
> > > (I need to be able to set, clear, ignore or reset level, pull up/down
> > > and function as the pinmux might be set by another OS/core running
> > > concurently)."
> > >
> >
> > I start by saying that I don't know this HW pin controller well, so
> > I might be missing something, but as commented on the original series f=
rom
> > Micheal, I still don't see why you need a custom property here...
> >
> > My understanding, looking at this comment and the header provided by
> > patch [1/3] (include/dt-bindings/pinctrl/rzn1-pinctrl.h) is that
> > basically need to control pull-up/down and the output driver strength.
> >
> > Documentation/devicetree/bindings/pinctrl/pinctrl-bindings.txt reports
> > a set of generic pin configuration properties to be applied to a pin
> > configuration (and multiplexing) pin controller child node that fully
> > express all (most?) of your needs.
> >
> > Eg. a pin configuration with pull up applied, using examples from your
> > cover letter should be expressed as
> >
> > Your example:
> >          &pinctrl {
> >                  pinsuart0: pinsuart0 {
> >                          renesas,rzn1-pinmux-ids =3D <
> >                                  RZN1_MUX(103, UART0_I)  /* UART0_TXD */
> >                                  RZN1_MUX_PUP(104, UART0_I)      /* UAR=
T0_RXD */
> >                          >;
> >                  };
> >          };
> >
> > Using standard pinctroller bindings pin configuration properties:
> >
> >          &pinctrl {
> >                  pinsuart0: uart0  {
> >                         pinsuart_tx0 {
> >                                 pinmux =3D <103, UART0_I>;  /* UART0_TX=
D */
> >                         };
> >
> >                         pinsuart_rx0 {
> >                                  pinmux =3D <104, UART0_I>; /* UART0_RX=
D */
> >                                  bias-pull-up;
> >                         };
> >                  };
> >          };
> >
> > Is there anything I am missing? Maybe from the interaction with
> > "another OS/core running concurrently" you mentioned? In this case if
> > you only have to perform pin configuration (because muxing is handled
> > already) things are even simpler, just use the pin configuration
> > bindings, without involving muxing at all:
> >
> >         &pinctrl {
> >                 pinsuart_conf: uart0 {
> >                         pins =3D <103, 104>;
> >                         bias-pull-up;
> >                  };
> >          };
>
> Sorry I didn=E2=80=99t address your point.
> The only reason we want to use new properties is so the driver can process
> dts files that have been generated from an existing PinMux App. That outp=
ut
> is used by VxWorks as well as our out-of-tree Linux port. If that is not a
> good enough reason to add new properties, then I can't see any technical
> reason not to use the existing bindings.

I see. I step back then and let this to be handled by the pinctrl
subsystem people and maintainer :)

Thanks
   j

> The use with another OS running on a different core should not be a barri=
er
> as it must not use the same pins as Linux.
>
> Thanks
> Phil
>
> > Thanks
> >   j
> >
> > > Patch 0003 should really be applied after patch:
> > >  "ARM: dts: r9a06g032: Correct UART and add all other UARTs", see
> > >  https://www.spinics.net/lists/arm-kernel/msg673525.html
> > >
> > > Main changes:
> > > v2:
> > >  - Change to generic rzn1 family driver, instead of device specific.
> > >  - Review comments fixed.
> > >  - Fix error handling during probe
> > >
> > > Phil Edworthy (3):
> > >   dt-bindings: pinctrl: renesas,rzn1-pinctrl: documentation
> > >   pinctrl: renesas: Renesas RZ/N1 pinctrl driver
> > >   ARM: dts: r9a06g032: Add pinctrl node
> > >
> > >  .../bindings/pinctrl/renesas,rzn1-pinctrl.txt      |  97 +++
> > >  arch/arm/boot/dts/r9a06g032.dtsi                   |   8 +
> > >  drivers/pinctrl/Kconfig                            |  10 +
> > >  drivers/pinctrl/Makefile                           |   1 +
> > >  drivers/pinctrl/pinctrl-rzn1.c                     | 844 +++++++++++=
++++++++++
> > >  include/dt-bindings/pinctrl/rzn1-pinctrl.h         | 191 +++++
> > >  6 files changed, 1151 insertions(+)
> > >  create mode 100644
> > Documentation/devicetree/bindings/pinctrl/renesas,rzn1-pinctrl.txt
> > >  create mode 100644 drivers/pinctrl/pinctrl-rzn1.c
> > >  create mode 100644 include/dt-bindings/pinctrl/rzn1-pinctrl.h
> > >
> > > --
> > > 2.7.4
> > >

--Zrag5V6pnZGjLKiw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJbjRodAAoJEHI0Bo8WoVY8Ql4P/R+Ts1bZCraK4kn9Rs9H4lHT
dVtkCclhwdU8Cj2cy0hQZUogBCF3GQqlg3Doxol9x7fxp/Rg0rC5PDsngex1wUrr
v3vo/KDyk9yFAbwAtIduJDqxE/XN0q0q3hRYOWUPmxMicsR+YilBHW6k9tMZjIY4
JBau5cTZ9rundJOGwpUajeEMRH4LNE4EH0zATC2UYQfIenuza+fpJgSUr+eG9c4l
esH5P+VuefcgCNuvjjGXGsIqd4FhZ/w2jHud/5BuyR/BgiXVYROPczbBJTpXknu4
mCgL13becNQVxoX7C0KZ0K5eOmioMX2kz1iHhUN6kpyzfixLoLAUKuSHRDhM30l3
zbE3gIhwELl5RPkkp1YUNvRTfCbc9mpP/Ij0k+mTlzA9Ldf09Y2CUrXPCTWHkEtK
QX7aNfaUuOpf6dnfa1tSuBO4O7DApft/jWqn+5F7vaX71AvV2ZkUbHKlGZukkx1N
T237cD51dqkcs/IyX+qI/gefsZE17I/X+47EDN54CohVlER0PjlQBhbKHqU2wiLQ
xmSXYxPaldIFmzXdpw4mnmiJZPrRFuAcK3cQWVXu/mBThPIhVx4MAWhM0nOSTANL
4z+fiT16NwiJrqfi6rOPyYJHML6HQDDrBqPCWPpGlj357gXpj3kl7H1qM9Sd8qxE
6rLfMpCdcJuQqmUYZEe7
=Taz7
-----END PGP SIGNATURE-----

--Zrag5V6pnZGjLKiw--
