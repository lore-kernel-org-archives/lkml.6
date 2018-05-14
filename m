Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753342AbeENMjk (ORCPT <rfc822;w@1wt.eu>);
        Mon, 14 May 2018 08:39:40 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:35199 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752936AbeENMjh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 May 2018 08:39:37 -0400
X-Google-Smtp-Source: AB8JxZqmLO2JiMCsSAfjakBkNCD5kbHE0496HsqDoCYwMnTnGm4uDfe5NNDQoKFTrpEKi3EvEjpEfA==
Date: Mon, 14 May 2018 14:39:33 +0200
From: Thierry Reding <thierry.reding@gmail.com>
To: Dmitry Osipenko <digetx@gmail.com>
Cc: Lee Jones <lee.jones@linaro.org>,
        Jonathan Hunter <jonathanh@nvidia.com>, linux-tegra@vger.kernel.org,
        linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] mfd: tps6586x: Move interrupt handling into workqueue
Message-ID: <20180514123933.GI18312@ulmo>
References: <20180513211842.7819-1-digetx@gmail.com>
 <20180514115135.GG18312@ulmo>
 <739706a9-4925-a7a0-686e-8d352ece4bac@gmail.com>
 <af2393f6-f4cd-13c8-01ef-760e90a660a0@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="nO3oAMapP4dBpMZi"
Content-Disposition: inline
In-Reply-To: <af2393f6-f4cd-13c8-01ef-760e90a660a0@gmail.com>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--nO3oAMapP4dBpMZi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, May 14, 2018 at 03:20:55PM +0300, Dmitry Osipenko wrote:
> On 14.05.2018 15:01, Dmitry Osipenko wrote:
> > On 14.05.2018 14:51, Thierry Reding wrote:
> >> On Mon, May 14, 2018 at 12:18:42AM +0300, Dmitry Osipenko wrote:
> >>> Reading of status register within the interrupt handler fails with -E=
AGAIN
> >>> if I2C is busy with handling some other request at the same time. Mov=
e the
> >>> actual interrupt handling into a workqueue to avoid the unfortunate I=
2C
> >>> failure and to avoid hanging CPU in interrupt up to 1 second (transfer
> >>> timeout in the Tegra I2C driver).
> >>>
> >>> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
> >>> ---
> >>>  drivers/mfd/tps6586x.c | 40 +++++++++++++++++++++++++++++-----------
> >>>  1 file changed, 29 insertions(+), 11 deletions(-)
> >>
> >> Could this not be achieved with a threaded interrupt handler?
> >>
> >> Thierry
> >>
> >=20
> > Seems yes. I completely forgot about the threaded interrupt handlers ex=
istence.
> > Thank you very much for the suggestion, I'll try with the threaded IRQ =
and send
> > v2 if it will be fine.
> >=20
>=20
> Oh wait! TPS6586x driver already uses threaded interrupt handler, so ever=
ything
> should be fine in regards to the interrupt handling and this patch is obs=
olete.
> Thank you again for the good suggestion, then it's only the Tegra's I2C d=
river
> that causes trouble for the TPS6586x right now.

Heh... indeed. Sounds like the discussion that Wolfram pointed out is
the right way forward.

Thierry

--nO3oAMapP4dBpMZi
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlr5g4MACgkQ3SOs138+
s6Ft3hAAvL7R3y+XemmmGs/JBWdaFlJNbuqViIhJk3ITeP7kxfDCh8QbqeW/yhLa
LAvWqCFLw6lnra5b/t+Ux6wLpaPUTN9LBZjoziz2wgLtPtu2qn2oaAJG5PHzrh55
CWrcw//Fd03x3GjdrtlmQl3BABQgql72BTTNuzprsdEK7Q/HUaQaWsREMNbPwlHq
IV6zggdLkrbOJ9veMkNyx8ScPf2VwPdqO9kpr9lsw1W8/i+2mxKxadYija0hE8+9
MeKdac0PZYMppz5YJ+RGqouqzr768+21OXmcP4F35RaJN6EGpFTjxiM+QtB9Ng7v
kB8hIDtMg//jawQgO7MhW14T0vvTh22QQ8+oiqszizoV9R1/FB3L1hpUJ5P8Jg3w
M570UV5B83xz+zONBaBiz3ZGyyBYRHxvYd23EGLL0Qs1N/deWC47kRwMewL9sOvU
FG9djADKyjUUFysJpK5umXplCHazdL0DukADljI141ZgoBbNn1HnB2VMRKZ09y9A
gj0dlU8u/W82g07pUDkzlPyvwm2WNXOcHDfFTytW8H60ewH2tCndKy4CZjpr/pgO
csSo4grmtgzgSIr9JHQ8StjeMe2rM77KzegKybHQRfBsUvbtPznMRhjK3zqf70NJ
P/FHKKhy5nqo5b63sIu5UhLOofRnfarX75c79YoOxlOFnK9732M=
=Zx4p
-----END PGP SIGNATURE-----

--nO3oAMapP4dBpMZi--
