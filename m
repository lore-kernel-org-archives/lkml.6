Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1035003AbeE1Put (ORCPT <rfc822;w@1wt.eu>);
        Mon, 28 May 2018 11:50:49 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:54812 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1034912AbeE1Pup (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 May 2018 11:50:45 -0400
Date: Mon, 28 May 2018 17:50:42 +0200
From: Sebastian Reichel <sebastian.reichel@collabora.co.uk>
To: Shawn Guo <shawnguo@kernel.org>
Cc: Sascha Hauer <kernel@pengutronix.de>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Will Deacon <will.deacon@arm.com>, Mark Rutland <mark.rutland@arm.com>,
        Russell King <linux@armlinux.org.uk>, Ian Ray <ian.ray@ge.com>,
        Nandor Han <nandor.han@ge.com>, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, kernel@collabora.com
Subject: Re: [PATCHv4 1/2] ARM: imx53: add secure-reg-access support for PMU
Message-ID: <20180528155042.ilmyqe4z5gekakrl@earth.universe>
References: <20180212123945.15732-1-sebastian.reichel@collabora.co.uk>
 <20180212123945.15732-2-sebastian.reichel@collabora.co.uk>
 <20180224074543.GF3217@dragon>
 <20180226134741.neqkpge33zo3pfzt@earth.universe>
 <20180227011033.GV3217@dragon>
 <20180227101712.3zwobvs4ox4jchcj@earth.universe>
 <20180528022652.GA3143@dragon>
 <20180528064131.y5burm5kakiazaq4@earth.universe>
 <20180528072034.GB3143@dragon>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="tpsdtjf4pjsztwzr"
Content-Disposition: inline
In-Reply-To: <20180528072034.GB3143@dragon>
User-Agent: NeoMutt/20180323
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--tpsdtjf4pjsztwzr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, May 28, 2018 at 03:20:35PM +0800, Shawn Guo wrote:
> On Mon, May 28, 2018 at 08:41:31AM +0200, Sebastian Reichel wrote:
> > > Are you saying this is a very specific setup required by i.MX53 only?
> >=20
> > Yes, all other SoCs supported by Linux ARM PMU counters driver can
> > just use the registers without having to enable platform specific
> > bits first.
> >=20
> > > In that case, I can live with it.
> >=20
> > What about the DT node? I did not add it, since this is a i.MX53
> > specific workaround anyways.
>=20
> What you are adding here is secure-reg-access property, which has an
> defined meaning in PMU binding doc.  I'm not really sure if it's
> appropriate to use the property as a condition for DBGEN bit setup.
> Or can we set up the bit regardless of the property?

The description for DBGEN bit is:

> Debug enable. This allows the user to manually activate clocks
> within the debug system. This register bit directly controls the
> platform's dbgen_out output signal which connects to the DAP_SYS to
> enable all debug clocks. Once enabled, the clocks cannot be disabled
> except by asserting the disable_trace input of the DAP_SYS.

I only enable this bit when the kernel configuration allows
using the PMU, since otherwise we do not need the clocks
in the debug system. This limits any potential side-effects
of this patchset.

-- Sebastian

--tpsdtjf4pjsztwzr
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAlsMJU4ACgkQ2O7X88g7
+porgBAAkxZW0DEj8eGRQrhYR6JyOX1+uNnsixpHE+yKYXysCoLfi8eNN36nCP/A
H9/R+luSPyaQO/xQZ+6+818n4t4FMkDdR/TuiUZbuQf0AnaG15SY/Lkn2UZi0ZN2
ex2BEx7AGQHCd3NY5wAtMtg/vqd8ZjR4aZh88+Ib9gSmVbodwi2QG5I/c6LTg6+F
mGoCb8JbZytZjs+WPgMk5JYKHktiNDTiEhCPezOmbXYDJgWVAlg+I53aBLD6iQDR
q8dnzS/JtPBYwqPFdFbJD4P9p/IZraJeaulCIselpLogBIlG/HRvFud/DGwL46xj
fNfDdc4HSam1T+4+I0HbbrOxvOUqzMFEdhC5IwQQNTv4HE09pBuCjiu57V1hyQWb
DmlUfrcBqpSZdtS6MZKDDj2uQZGs2B/nkTm47c4stWtckSeKHT+t9gpFgqrdyfCX
+U6ByiB1jDr0cXwRviqbyoCFaDtGwrvilDpmR/5S5xPAUmr124MVlivuS0GflENP
UNMDXTP9nC2IE3lvCOCXS8iEAYwOiv0/Ss2rAofiM8qyT3wDg/zpQduvNzLA1i8+
a5NhjOnqX4ElUUlVoiLchKm8ornjrZ4ovlYOctSFJpLsQ04kpwWlZWYpeNl55T/4
K7BW5GntGjJ+lfDd/3SrHKhU3rqllQKqqjScSf1k4hJidystdIE=
=ND9F
-----END PGP SIGNATURE-----

--tpsdtjf4pjsztwzr--
