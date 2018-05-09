Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935184AbeEIOkh (ORCPT <rfc822;w@1wt.eu>);
        Wed, 9 May 2018 10:40:37 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:56060 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933988AbeEIOkg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 May 2018 10:40:36 -0400
Date: Wed, 9 May 2018 16:40:32 +0200
From: Sebastian Reichel <sebastian.reichel@collabora.co.uk>
To: Pavel Machek <pavel@ucw.cz>
Cc: Nick Dyer <nick@shmanahar.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        Ezequiel Garcia <ezequiel@collabora.com>, kernel@collabora.com
Subject: Re: [PATCHv2] Input: atmel_mxt_ts - fix reset-gpio for level based
 irqs
Message-ID: <20180509144032.kirx5rz4cbz6cl4l@earth.universe>
References: <20180420172408.26164-1-sebastian.reichel@collabora.co.uk>
 <20180423115844.26281-1-sebastian.reichel@collabora.co.uk>
 <20180509142545.GC25131@amd>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="dxewti5y2ddcf3wa"
Content-Disposition: inline
In-Reply-To: <20180509142545.GC25131@amd>
User-Agent: NeoMutt/20180323
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--dxewti5y2ddcf3wa
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, May 09, 2018 at 04:25:45PM +0200, Pavel Machek wrote:
> On Mon 2018-04-23 13:58:44, Sebastian Reichel wrote:
> > The current reset-gpio support triggers an interrupt storm on platforms
> > using the maxtouch with level based interrupt. The Motorola Droid 4,
> > which I used for some of the tests is not affected, since it uses a edge
> > based interrupt.
> >=20
> > This change avoids the interrupt storm by enabling the device while its
> > interrupt is disabled. Afterwards we wait 100ms. This is important for
> > two reasons: The device is unresponsive for some time (~22ms for
> > mxt224E) and the CHG (interrupt) line is not working properly for 100ms.
> > We don't need to wait for any following interrupts, since the following
> > mxt_initialize() checks for bootloader mode anyways.
> >=20
> > This fixes a boot issue on GE PPD (watchdog kills device due to
> > interrupt storm) and does not cause regression on Motorola Droid 4.
>=20
> Out of curiosity, what is "GE PPD"?

PPD is a product from GE Healthcare to monitor vital biometric signals:

arch/arm/boot/dts/imx53-ppd.dts

> > Fixes: f657b00df22e ("Input: atmel_mxt_ts - add support for reset line")
> > Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.co.uk>
>=20
> Reviewed-by: Pavel Machek <pavel@ucw.cz>

Thanks,

-- Sebastian

--dxewti5y2ddcf3wa
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAlrzCF0ACgkQ2O7X88g7
+ppdYA//SiNyLginSyY1gtjGqHxRFljwB59QXKJXel4+Dni4CIRQj6zSQAn3DV3i
raDjqkDJ0hmrmlhofgwMIG07MGDFasHDpsfoc9Be9mLMgpFn7LZhZ7ePfu7Gu6A/
P+O2yOprL8v3j1fM0t/0AIUtZRXo/nu1CCmb21Kj+Nic0fbKc2HPJs8troI9GaBY
OQhuSv5oFAiadlAA3Yt9owPyhJTPSZybShhqFiZeqcF86o+bCtwPLx0OcBoF71iR
VT6ttCZogn+GLr2DarnsYZxBC1Qv0PWEK9noDfo8eQZGxcvv/V6CYIDXkmHzlipu
jTdYRNt0LTWfotlnv02NnCM4yU0k9Dm7fCASgPfDG9dZNX0IAAv0rmDK8fRkfYth
tqSvBjOWlwtRtudCVFt1FZrIXbK25els/nZdlWIHnxmIFbsjgCZbvkMhJBIXRn3A
ItIgft2jysHZt1LhRsrPrtondF//v2sdcLgCTmUAn2EbwLkGJKbhDiTQMCLSpbn/
ns5pasYDlVKuSf9JlBZ9kLfnOJBilsGTHc2ADQR8AnulkcIx+ql/UYf2BFJ2lItY
/iH66gVJqZE0VRyw1TM/ErX0MhxTZwF97jX5Dqy/mcaQp7rZDJuELYTH5ao31AkF
qi0uQKsgZd7gGCWvXhQj+3P7D0jvTbmEJnf679TxDRX3ZrBYX/8=
=ZL8Z
-----END PGP SIGNATURE-----

--dxewti5y2ddcf3wa--
