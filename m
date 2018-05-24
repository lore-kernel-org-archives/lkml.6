Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1034226AbeEXSPN (ORCPT <rfc822;w@1wt.eu>);
        Thu, 24 May 2018 14:15:13 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:41650 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1030579AbeEXSPK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 May 2018 14:15:10 -0400
Date: Thu, 24 May 2018 19:15:04 +0100
From: Mark Brown <broonie@kernel.org>
To: Radu Pirea <radu.pirea@microchip.com>
Cc: Andy Shevchenko <andy.shevchenko@gmail.com>,
        devicetree <devicetree@vger.kernel.org>,
        "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>,
        linux-spi <linux-spi@vger.kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, Rob Herring <robh+dt@kernel.org>,
        Lee Jones <lee.jones@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>,
        Richard Genoud <richard.genoud@gmail.com>,
        alexandre.belloni@bootlin.com,
        Nicolas Ferre <nicolas.ferre@microchip.com>
Subject: Re: [PATCH v3 5/6] spi: at91-usart: add driver for at91-usart as spi
Message-ID: <20180524181504.GD4828@sirena.org.uk>
References: <20180511103822.31698-1-radu.pirea@microchip.com>
 <20180511103822.31698-6-radu.pirea@microchip.com>
 <CAHp75Ve3Ugnjjm8EZkPQTZSvH1qad1e5SqjOn8zz5syHSQea_g@mail.gmail.com>
 <5a3930b867cf8c279953d08c5d5dd1d93113a43b.camel@microchip.com>
 <CAHp75VdRrL25Jgnbk64Qqc5RY3uJdcntJ3xwRdp3F+rRFeTHBA@mail.gmail.com>
 <c23cdde58b9f724f51787c6c38478df983be6efa.camel@microchip.com>
 <20180517045437.GE20254@sirena.org.uk>
 <0e6e71e2-f8ac-7889-0d81-8d8a4c15223d@microchip.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="nM4qzG6nHdnn/sXd"
Content-Disposition: inline
In-Reply-To: <0e6e71e2-f8ac-7889-0d81-8d8a4c15223d@microchip.com>
X-Cookie: Excellent day to have a rotten day.
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--nM4qzG6nHdnn/sXd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, May 24, 2018 at 07:04:11PM +0300, Radu Pirea wrote:

>     if (ctlr->cs_gpios){
>         spi->cs_gpio =3D ctlr->cs_gpios[spi->chip_select];
>         if(gpio_is_valid(spi->cs_gpio))
>             gpio_direction_output(spi->cs_gpio, !(spi->mode & SPI_CS_HIGH=
));
>=20
>     }

You're expected to request the GPIOs in your driver using one of the
modern request functions like gpio_request_one() (or ideally the GPIO
descriptor APIs now) which combine the direction setting and request
into a single operation.

--nM4qzG6nHdnn/sXd
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlsHAScACgkQJNaLcl1U
h9BqxAf/S0gGqu0IMSK130ze8IY89SOLEGlgGuLh/vwkkGxSCgPr0mICv9ACiGpT
OHwxAY3B5/c4pNaBy+fxG9lbX9ICC9h0KXlI8rR77QoswXGhgpJRPRHOQXMJM+jC
xhqikX6tCNqY63QiW4RcVD8VwXZcD3oXZxCFxGuIOGApc/Rr9wEHnYixQALYVVLJ
pYMXKkH5QPAjT8AhNVT0WP5kWKTdy1RGrxQUeDDfx3+sG/qon5/wsi0sv94/k2Mg
JR4o9b3106ixUzdQg1unGL+yIJ1FXRuaAScxr40oxvTyq2g9Y3lSCeOM3mQ9As86
oTBXd72yVK8/rlDeP+58c6MCOeXOyg==
=BBrr
-----END PGP SIGNATURE-----

--nM4qzG6nHdnn/sXd--
