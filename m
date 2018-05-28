Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753579AbeE1Glj (ORCPT <rfc822;w@1wt.eu>);
        Mon, 28 May 2018 02:41:39 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:51504 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753390AbeE1Glf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 May 2018 02:41:35 -0400
Date: Mon, 28 May 2018 08:41:31 +0200
From: Sebastian Reichel <sebastian.reichel@collabora.co.uk>
To: Shawn Guo <shawnguo@kernel.org>
Cc: Sascha Hauer <kernel@pengutronix.de>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Will Deacon <will.deacon@arm.com>, Mark Rutland <mark.rutland@arm.com>,
        Russell King <linux@armlinux.org.uk>, Ian Ray <ian.ray@ge.com>,
        Nandor Han <nandor.han@ge.com>, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, kernel@collabora.com
Subject: Re: [PATCHv4 1/2] ARM: imx53: add secure-reg-access support for PMU
Message-ID: <20180528064131.y5burm5kakiazaq4@earth.universe>
References: <20180212123945.15732-1-sebastian.reichel@collabora.co.uk>
 <20180212123945.15732-2-sebastian.reichel@collabora.co.uk>
 <20180224074543.GF3217@dragon>
 <20180226134741.neqkpge33zo3pfzt@earth.universe>
 <20180227011033.GV3217@dragon>
 <20180227101712.3zwobvs4ox4jchcj@earth.universe>
 <20180528022652.GA3143@dragon>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="q6zyqxvlcazwgqdc"
Content-Disposition: inline
In-Reply-To: <20180528022652.GA3143@dragon>
User-Agent: NeoMutt/20180323
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--q6zyqxvlcazwgqdc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, May 28, 2018 at 10:26:54AM +0800, Shawn Guo wrote:
> On Tue, Feb 27, 2018 at 11:17:12AM +0100, Sebastian Reichel wrote:
> > Hi,
> >=20
> > On Tue, Feb 27, 2018 at 09:10:34AM +0800, Shawn Guo wrote:
> > > On Mon, Feb 26, 2018 at 02:47:41PM +0100, Sebastian Reichel wrote:
> > > > On Sat, Feb 24, 2018 at 03:45:44PM +0800, Shawn Guo wrote:
> > > > > On Mon, Feb 12, 2018 at 01:39:44PM +0100, Sebastian Reichel wrote:
> > > > > > On i.MX53 it is necessary to set the DBG_EN bit in the
> > > > > > platform GPC register to enable access to PMU counters
> > > > > > other than the cycle counter.
> > > > > >=20
> > > > > > Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.c=
o.uk>
> > > > > > ---
> > > > > >  arch/arm/mach-imx/mach-imx53.c | 39 ++++++++++++++++++++++++++=
++++++++++++-
> > > > > >  1 file changed, 38 insertions(+), 1 deletion(-)
> > > > > >=20
> > > > > > diff --git a/arch/arm/mach-imx/mach-imx53.c b/arch/arm/mach-imx=
/mach-imx53.c
> > > > > > index 07c2e8dca494..658e28604dca 100644
> > > > > > --- a/arch/arm/mach-imx/mach-imx53.c
> > > > > > +++ b/arch/arm/mach-imx/mach-imx53.c
> > > > > > @@ -28,10 +28,47 @@ static void __init imx53_init_early(void)
> > > > > >  	mxc_set_cpu_type(MXC_CPU_MX53);
> > > > > >  }
> > > > > > =20
> > > > > > +#define MXC_CORTEXA8_PLAT_GPC 0x63fa0004
> > > > >=20
> > > > > The base address should be retrieved from device tree.
> > > >=20
> > > > DT has no entry for 0x63fa0000-0x63fa3fff. iMX53 TRM lists it as "A=
RM Platform"
> > > > with 8 platform specific 32 bit registers. Do you think it's worth =
the trouble
> > > > adding a new binding? Do you have a suggestion for a compatible val=
ue?
> > >=20
> > > Looking at it more closely, I feel that patching every single platform
> > > which needs to set up additional register for secure-reg-access suppo=
rt
> > > doesn't really scale.  Can we have pmu driver do it with a phandle in
> > > DT pointing to the register and bit that need to be configured?
> >=20
> > The PMU driver used to have a feature for initialising platform
> > specific bits, but it is currently being removed to make the PMU
> > code more maintainable. My understanding is, that it's very uncommon
> > to require platform specific setup to get secure-reg-access working.
> > I.e. it is not needed for newer iMX platforms.
>=20
> Are you saying this is a very specific setup required by i.MX53 only?

Yes, all other SoCs supported by Linux ARM PMU counters driver can
just use the registers without having to enable platform specific
bits first.

> In that case, I can live with it.

What about the DT node? I did not add it, since this is a i.MX53
specific workaround anyways.

-- Sebastian

--q6zyqxvlcazwgqdc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAlsLpI4ACgkQ2O7X88g7
+ppnIxAAmol/Yd962PK94u+QLyU7i3QPcIQfSRyliiqINvxoKlqMHrtcoJzrO9wx
jiwWbU3iFCiX08Slhb0xjLMgXxPQVPriUcv58GQI6aVTwL7egZLUXURGH5ghrGp0
79RZ00R8xbw+2+DV2BYsqGQJSK4HHL5xiVWqIcUEP/zvCOOvDRp6VgQgKxC45/tN
f4dl3oeAkNvc4EDLkK2w/f4sBKGPpF08KVDkrjAOUNxisD6IZ+5eS9E7NGv53quW
7J47+kf3oX/vJszS03yuguMHVQyX12ItpTVS74nlC1kSKjHmYT0OiKiKZzVoCfVQ
mL7fJh7f4VlxYtcZ9oF7vWlWJzeg0j9z2zwMkn6cSAOHonlQkkIhO9jfUQYlvK5w
5PlWDRppfBJ56nfntmfitaaFVJW/LL2KPcEgIF6LCgAYeYfHFy/Y/juqlECNpIfB
WvHpRaKAdAWdL7BUTJmZitb6gzsoT+hE4fl79Fg1JaHc86QBOxGI/AOGXOJJJJUq
nHf6QMCui9PcJx4capbJbD50NdD5qLc2WLUa4yRljLUyjlg+dX4Ma69AsWUIj4pX
EVouU6rMHA6dEBvp6DBGPJ9YJ7TKYFGiqb3MooiAjKWcFHTWX2qBvGZbEaSDtY+B
4NGd3iQWWE/pmCl07pyy+hRbJZDfnBLm1URC3x5UbecXJpmy6Ok=
=CG7z
-----END PGP SIGNATURE-----

--q6zyqxvlcazwgqdc--
