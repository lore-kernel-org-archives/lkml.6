Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751604AbeBBLKQ (ORCPT <rfc822;w@1wt.eu>);
        Fri, 2 Feb 2018 06:10:16 -0500
Received: from bhuna.collabora.co.uk ([46.235.227.227]:42908 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750773AbeBBLKI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Feb 2018 06:10:08 -0500
Date: Fri, 2 Feb 2018 12:10:04 +0100
From: Sebastian Reichel <sebastian.reichel@collabora.co.uk>
To: Shawn Guo <shawnguo@kernel.org>
Cc: Sascha Hauer <kernel@pengutronix.de>, Frank Li <Frank.li@nxp.com>,
        Fabio Estevam <fabio.estevam@nxp.com>, Ian Ray <ian.ray@ge.com>,
        Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ARM: dts: imx6q-bx50v3: Enable secure-reg-access
Message-ID: <20180202111004.mnv3elblyjxkbyzz@earth.universe>
References: <20180115160722.17206-1-sebastian.reichel@collabora.co.uk>
 <20180202071819.GE25699@dragon>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="oqt2zu6s5rd7zxgq"
Content-Disposition: inline
In-Reply-To: <20180202071819.GE25699@dragon>
User-Agent: NeoMutt/20171215
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--oqt2zu6s5rd7zxgq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Fri, Feb 02, 2018 at 03:18:20PM +0800, Shawn Guo wrote:
> + Frank
>=20
> On Mon, Jan 15, 2018 at 05:07:22PM +0100, Sebastian Reichel wrote:
> > From: Peter Senna Tschudin <peter.senna@collabora.com>
> >=20
> > Add secure-reg-access on device tree include file for Bx50 devices
> > to enable PMU and hardware counters for perf.
> >=20
> > Signed-off-by: Peter Senna Tschudin <peter.senna@collabora.com>
> > Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.co.uk>
> > ---
> >  arch/arm/boot/dts/imx6q-bx50v3.dtsi | 7 +++++++
> >  1 file changed, 7 insertions(+)
> >=20
> > diff --git a/arch/arm/boot/dts/imx6q-bx50v3.dtsi b/arch/arm/boot/dts/im=
x6q-bx50v3.dtsi
> > index 86cfd4481e72..ccaaee83e2fa 100644
> > --- a/arch/arm/boot/dts/imx6q-bx50v3.dtsi
> > +++ b/arch/arm/boot/dts/imx6q-bx50v3.dtsi
> > @@ -43,6 +43,13 @@
> >  #include "imx6q-ba16.dtsi"
> > =20
> >  / {
> > +	soc {
> > +		pmu {
> > +			compatible =3D "arm,cortex-a9-pmu";
> > +			secure-reg-access;
>=20
> I'm not sure this could be a board level configuration.  Shouldn't this
> property just be added into pmu node in imx6qdl.dtsi?

This cannot become part of imx6qdl.dtsi for two reasons:

1. It's not safe to be enabled on imx6qdl in secure state, see
   excerpt from DT binding documentation below
2. We cannot enable it by default, since DTS format does not provide
   a method to unset it in board files using a imx6qdl in secure
   mode.

Here is an extract from the DT documentation for the PMU node:

- secure-reg-access : Indicates that the ARMv7 Secure Debug Enable Register
		      (SDER) is accessible. This will cause the driver to do
		      any setup required that is only possible in ARMv7 secure
		      state. If not present the ARMv7 SDER will not be touched,
		      which means the PMU may fail to operate unless external
		      code (bootloader or security monitor) has performed the
		      appropriate initialisation. Note that this property is
		      not valid for non-ARMv7 CPUs or ARMv7 CPUs booting Linux
		      in Non-secure state.

For B450v3, B650v3 and B850v3 it's safe to enable the bit and it
improves debugging capabilities a lot.

-- Sebastian

>=20
> Shawn
>=20
> > +		};
> > +	};
> > +
> >  	clocks {
> >  		mclk: clock@0 {
> >  			compatible =3D "fixed-clock";
> > --=20
> > 2.15.1
> >=20

--oqt2zu6s5rd7zxgq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAlp0RwkACgkQ2O7X88g7
+przbxAAj8IZq1fcC3bQYRSj88o8koPCdOL514egIq9don6K3J3ozFd4xzeXB72h
YOCyqk63Ze2uDG1ZB4ilfgsr2afKcQIC46v/U4/9PqC/xd7JrO3KV5HVkNpASVE6
XZGuV0ekMWEPRev6xlq3fIwMR+q2WGmn7Zr4Cj2s4ughbTqlrseqTXI4T78ZKGOf
nighHWK0HkmlCTFf/S+//UV+3YkIztfLdjdKe51GwTujvbmmSKtZ76NMpZCONZqV
PkkdK4FY2zR5+uXRwMrDE14SpuW04MWC94alSHShpSZGX03m69Z4rXtgJTcnV8Xa
q/gMqJrh96i1mMZIkJQ2BTcQAMoPoB1NCrSj0304QVFhXd5TKO/yP5vpFZqI1nI5
KDoY4H38mBI+kzdMJXCQvqw/WdDrNROr1oG775q6/d4fNNztNn5H+iWPc5KgdiGj
NaljqhHxARsnkMN1s8sEnVeMIr1/PxBw/5krnTzt1aHmv3Nf0zsii65THZU0yJxW
w1K7N5pfCriyhXmmFMgBF8sg935uYG9aUt6zS5JHT8FdWY3K65kminwAx6DiCVPP
+UZIS265IGnSnWzZJJgq30mEGXfnvkAvJ3+asrKXOW+u2Psf3HTClJzUOqzfO7ej
wJaReTnwlxKNj8+zmps4WHwavIQ4o4+5IJ1xc9VGB9hx7LVc7wc=
=NP40
-----END PGP SIGNATURE-----

--oqt2zu6s5rd7zxgq--
