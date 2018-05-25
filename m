Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966761AbeEYPp4 (ORCPT <rfc822;w@1wt.eu>);
        Fri, 25 May 2018 11:45:56 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:34450 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S966128AbeEYPpy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 May 2018 11:45:54 -0400
Date: Fri, 25 May 2018 17:45:49 +0200
From: Sebastian Reichel <sebastian.reichel@collabora.co.uk>
To: Shawn Guo <shawnguo@kernel.org>
Cc: Sascha Hauer <kernel@pengutronix.de>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Will Deacon <will.deacon@arm.com>, Mark Rutland <mark.rutland@arm.com>,
        Russell King <linux@armlinux.org.uk>, Ian Ray <ian.ray@ge.com>,
        Nandor Han <nandor.han@ge.com>, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, kernel@collabora.com
Subject: Re: [PATCHv4 1/2] ARM: imx53: add secure-reg-access support for PMU
Message-ID: <20180525154549.r7gwxegcu4colhvs@earth.universe>
References: <20180212123945.15732-1-sebastian.reichel@collabora.co.uk>
 <20180212123945.15732-2-sebastian.reichel@collabora.co.uk>
 <20180224074543.GF3217@dragon>
 <20180226134741.neqkpge33zo3pfzt@earth.universe>
 <20180227011033.GV3217@dragon>
 <20180227101712.3zwobvs4ox4jchcj@earth.universe>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="igqoj6vbus4t7g7w"
Content-Disposition: inline
In-Reply-To: <20180227101712.3zwobvs4ox4jchcj@earth.universe>
User-Agent: NeoMutt/20180323
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--igqoj6vbus4t7g7w
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Shawn,

On Tue, Feb 27, 2018 at 11:17:12AM +0100, Sebastian Reichel wrote:
> Hi,
>=20
> On Tue, Feb 27, 2018 at 09:10:34AM +0800, Shawn Guo wrote:
> > On Mon, Feb 26, 2018 at 02:47:41PM +0100, Sebastian Reichel wrote:
> > > On Sat, Feb 24, 2018 at 03:45:44PM +0800, Shawn Guo wrote:
> > > > On Mon, Feb 12, 2018 at 01:39:44PM +0100, Sebastian Reichel wrote:
> > > > > On i.MX53 it is necessary to set the DBG_EN bit in the
> > > > > platform GPC register to enable access to PMU counters
> > > > > other than the cycle counter.
> > > > >=20
> > > > > Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.co.=
uk>
> > > > > ---
> > > > >  arch/arm/mach-imx/mach-imx53.c | 39 ++++++++++++++++++++++++++++=
++++++++++-
> > > > >  1 file changed, 38 insertions(+), 1 deletion(-)
> > > > >=20
> > > > > diff --git a/arch/arm/mach-imx/mach-imx53.c b/arch/arm/mach-imx/m=
ach-imx53.c
> > > > > index 07c2e8dca494..658e28604dca 100644
> > > > > --- a/arch/arm/mach-imx/mach-imx53.c
> > > > > +++ b/arch/arm/mach-imx/mach-imx53.c
> > > > > @@ -28,10 +28,47 @@ static void __init imx53_init_early(void)
> > > > >  	mxc_set_cpu_type(MXC_CPU_MX53);
> > > > >  }
> > > > > =20
> > > > > +#define MXC_CORTEXA8_PLAT_GPC 0x63fa0004
> > > >=20
> > > > The base address should be retrieved from device tree.
> > >=20
> > > DT has no entry for 0x63fa0000-0x63fa3fff. iMX53 TRM lists it as "ARM=
 Platform"
> > > with 8 platform specific 32 bit registers. Do you think it's worth th=
e trouble
> > > adding a new binding? Do you have a suggestion for a compatible value?
> >=20
> > Looking at it more closely, I feel that patching every single platform
> > which needs to set up additional register for secure-reg-access support
> > doesn't really scale.  Can we have pmu driver do it with a phandle in
> > DT pointing to the register and bit that need to be configured?
>=20
> The PMU driver used to have a feature for initialising platform
> specific bits, but it is currently being removed to make the PMU
> code more maintainable. My understanding is, that it's very uncommon
> to require platform specific setup to get secure-reg-access working.
> E.g. it is not needed for newer iMX platforms.

You never replied to this one. Are you fine with adding the
function? This is kind of a deadlock situation with neither
you wanting to enable the platform bit, nor the generic PMU
driver.

-- Sebastian

--igqoj6vbus4t7g7w
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAlsIL6sACgkQ2O7X88g7
+prqNA/+NPBc0PDqbq8rrhPRw8MqT3/N+HrtlEHZ/GOs1XBWHpaEveQC6fHC2e06
zeyRjSoX7RVwQpkXNRprW51357GUWAO/w9XAsjgZwmchEd/47GLjMjJG4x3HHLd+
uVmwHNH06YnQMnVx0WIkLr6EKMDrUsfqm0Y2Bg49HS6pX6AwHPSMnjALc4368ejd
wTXtghus1npyRcMqB/AK1uDEOzvyQNywzjy2OEKezV6y+zu7qVm7pPDzQcJRz/cx
GoxOOI9bwv6MWgU9eWrufwRnfQ/XA7JM/Hnf7hj2a/+ojqnutcFnHpYvJqZoCBce
CCLjAe8Hn+NQHSZIBcfHIXjkeb/D16u/Mk3NDzTr7UcQM6orK3jcX2Bz1N89ibS5
GdL+uLYXTcwfBcjD+g+fHKZj1wM8aVHrZ32uQu8CrClbcG/FNoRz9ZiUIPZYiL6q
7W4HVq1FyaGbjyUFxclXEZXFOr0YSgTqCRTJ237kbh2ZrLBX6JzlaOzvgeu0c6Or
FcbGR8nHXkHd5dDIj/UDiIHCf33i1CcWf0OyoihN/m38xCn9LuQXBq4gkCsp1p+p
tJktTqVh4DobEqVV+urtu5CZBfeS4lVFnBcdhL3c+r5NAemx8cAy4rzKvbdCAqHj
P9Z9vcktXYJpT5shVlxYDB6hBxgdaqrNDJwwWcyA5NLt2DMnaf4=
=L6n4
-----END PGP SIGNATURE-----

--igqoj6vbus4t7g7w--
