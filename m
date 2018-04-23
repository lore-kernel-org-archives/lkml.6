Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754859AbeDWLnn (ORCPT <rfc822;w@1wt.eu>);
        Mon, 23 Apr 2018 07:43:43 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:39586 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754710AbeDWLnj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Apr 2018 07:43:39 -0400
Date: Mon, 23 Apr 2018 13:43:35 +0200
From: Sebastian Reichel <sebastian.reichel@collabora.co.uk>
To: Nick Dyer <nick@shmanahar.org>
Cc: Ezequiel Garcia <ezequiel@collabora.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel@collabora.com
Subject: Re: [PATCH] Input: atmel_mxt_ts - fix reset-gpio for level based irqs
Message-ID: <20180423114335.n5n7q4arn2petcnd@earth.universe>
References: <20180420172408.26164-1-sebastian.reichel@collabora.co.uk>
 <7b4976b0a8a642767bd4e0a5e9d7fb6c9dc86ec9.camel@collabora.com>
 <20180420194207.i2zo235duknjsjjd@earth.universe>
 <20180421201137.fyr6eqzjuob765ie@hairyalien>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="gwmftp2gnz33cgg3"
Content-Disposition: inline
In-Reply-To: <20180421201137.fyr6eqzjuob765ie@hairyalien>
User-Agent: NeoMutt/20180323
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--gwmftp2gnz33cgg3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Sat, Apr 21, 2018 at 09:11:37PM +0100, Nick Dyer wrote:
> On Fri, Apr 20, 2018 at 09:42:07PM +0200, Sebastian Reichel wrote:
> > On Fri, Apr 20, 2018 at 02:44:02PM -0300, Ezequiel Garcia wrote:
> > > Hi Sebastian,
> > >=20
> > > On Fri, 2018-04-20 at 19:24 +0200, Sebastian Reichel wrote:
> > > > The current reset-gpio support triggers an interrupt storm on platf=
orms
> > > > using the maxtouch with level based interrupt. The Motorola Droid 4,
> > > > which I used for some of the tests is not affected, since it uses a=
 level
> > > > based interrupt.
> > > >=20
> > >=20
> > > I found this confusing. Interrupt storm happen with level-based inter=
rupts,
> > > but the Droid4 is not affected?
>=20
> Can I ask what happens during the interrupt storm. Are you getting lots
> of the "failed to read T44 and T5" message, or something else?

I don't get any message (with DEBUG enabled for the driver).
The boot process hangs and after a few seconds the watchdog kicks in.

> > > > This change avoids the interrupt storm by enabling the device while
> > > > its interrupt is disabled. The following mxt_initialize() requires,
> > > > that the device is responsive (at least mxt224E is unresponsive for
> > > > ~22ms), so we wait some time. We don't wait for leaving bootloader
> > > > mode anymore, since mxt_initialize() checks for it anyways.
> > > >=20
> > >=20
> > > IMHO, having some more or less arbritrary sleeps is almost
> > > always a problem. This value might be enough for some platform,
> > > might be too short for some other, and then it might get too large
> > > for someone else.
> >=20
> > The 22ms chip-being-unresponsive are not newly introduced. The
> > same 22ms are also required for soft-reset. I did introduce a
> > new time (MXT_RESET_GPIO_TIME) for the "chip being reset" state,
> > since my randomly chosen 200ms from before were exaggerated
> > considering all mxt datasheets I checked stated only a few nano
> > seconds.
>=20
> According to the data sheets there is a period after a reset where the
> CHG line is temporarily set as an input, during which the host should
> ignore it. If you don't, you might get a stray interrupt and try and
> communicate with the device, which might leave it in a bad state. I
> think you mentioned that later in your email.
>=20
> The reset time varies per chip, but the 100ms in mxt_soft_reset() was
> based on discussions with app support at Atmel, so should be correct in
> most cases.

Right. This sleep time is missing for the gpio based reset. The
other checks are not required, since the chip initialization
routine is called directly afterwards. I will send a PATCHv2,
that fixes the patch description and uses the same timeout value
for both resets.

-- Sebastian

--gwmftp2gnz33cgg3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAlrdxuQACgkQ2O7X88g7
+prYVA/+N1Pg3YTXms6tI+cykdrrn34BGPKqKGRgEcXYgxCwe8GabLxdA0lP2vzd
h4QQs95eHZGNTkDPSSwFftHaRvX+OqZBBh/Z5cvQ4czNW0UPIO+mRnCGicYyG8jM
cFKn7g5ShV9+aEFIELUk5m/xXcO4kdNL6Gd5P21XuviNG4mSg7SyL5fqucSyvfIO
I66WbDl6ZbuIoV2vfoZFce4bqPLfh15Hky61/l0pV0w5LQyqpQB2XuG+idGcR3HN
JS7sIIZ45ZDDJaIVaBdpyNU8S6bqGFnEORSMy/3UOHKDi2gqqwdS7I5YzTe3BZ+f
oBGBLSmHJ58jXox4Bj9UrtLyZMW+f2Ru8pL/LkZ6Iekv5cCZ9tRqZ5VIz6ZgJK47
J5woPiy9zXvnM0rZ6dsFETPDYpaPOUtzWczYnrD+ZxtaSG8fPUbPzB0qRblq5D8f
pu/+bLX2SyheGGcfeCQfg4dp3BZmxsMBFie8PdgXQ3fhn4rfFIuTzFxeTNHVn84E
dAiA/zifXpfvGb6SBklrR1baBaECJpdAA6b1+F24nkIH+ldp2bnk6sH//H3DopYE
7JU+d0IUMOpGosVffM/FGC0R0zvNjnVHSyPospCUoMW3I5z1tTPL70dcgqwjBSPH
Wmme0mgsf5qezGOozjAne8EVqEtneLlnljrRme+MvBx1wi7Si6o=
=5Dek
-----END PGP SIGNATURE-----

--gwmftp2gnz33cgg3--
