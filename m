Return-Path: <SRS0=IQwf=QG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBB04C282D7
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 09:59:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 98A0A2184D
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 09:59:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730516AbfA3J7R (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Jan 2019 04:59:17 -0500
Received: from relay8-d.mail.gandi.net ([217.70.183.201]:42769 "EHLO
        relay8-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726406AbfA3J7R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Jan 2019 04:59:17 -0500
X-Originating-IP: 90.88.147.226
Received: from localhost (aaubervilliers-681-1-27-226.w90-88.abo.wanadoo.fr [90.88.147.226])
        (Authenticated sender: maxime.ripard@bootlin.com)
        by relay8-d.mail.gandi.net (Postfix) with ESMTPSA id B8E951BF20A;
        Wed, 30 Jan 2019 09:59:12 +0000 (UTC)
Date:   Wed, 30 Jan 2019 10:59:12 +0100
From:   Maxime Ripard <maxime.ripard@bootlin.com>
To:     Chen-Yu Tsai <wens@csie.org>
Cc:     linux-sunxi <linux-sunxi@googlegroups.com>,
        Icenowy Zheng <icenowy@aosc.io>,
        Andre Przywara <andre.przywara@arm.com>,
        Emmanuel Vadot <manu@freebsd.org>,
        Jagan Teki <jagan@amarulasolutions.com>,
        Sergey Matyukevich <geomatsi@gmail.com>,
        Hauke Mehrtens <hauke@hauke-m.de>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        devicetree <devicetree@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 10/10] arm64: dts: allwinner: h5: Add CPU Operating
 Performance Points table
Message-ID: <20190130095912.yq6anxqnczi6btpv@flea>
References: <20190130084203.25053-1-wens@csie.org>
 <20190130084203.25053-11-wens@csie.org>
 <20190130092927.x65ihy3je5n6324w@flea>
 <CAGb2v64ZFZty-jeeKmPU8Ecg+rAE6zEm65tedb_ZZTTSXMEPOA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="wfmp6bpod2cyevow"
Content-Disposition: inline
In-Reply-To: <CAGb2v64ZFZty-jeeKmPU8Ecg+rAE6zEm65tedb_ZZTTSXMEPOA@mail.gmail.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--wfmp6bpod2cyevow
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 30, 2019 at 05:41:16PM +0800, Chen-Yu Tsai wrote:
> On Wed, Jan 30, 2019 at 5:29 PM Maxime Ripard <maxime.ripard@bootlin.com>=
 wrote:
> >
> > On Wed, Jan 30, 2019 at 04:42:03PM +0800, Chen-Yu Tsai wrote:
> > >                       enable-method =3D "psci";
> > >                       clocks =3D <&ccu CLK_CPUX>;
> > >                       clock-latency-ns =3D <244144>; /* 8 32k periods=
 */
> > > +                     operating-points-v2 =3D <&cpu_opp_table>;
> > > +                     #cooling-cells =3D <2>;
> > > +             };
> > > +     };
> > > +
> > > +     cpu_opp_table: opp_table {
> > > +             compatible =3D "operating-points-v2";
> > > +             opp-shared;
> > > +
> > > +             opp@408000000 {
> > > +                     opp-hz =3D /bits/ 64 <408000000>;
> > > +                     opp-microvolt =3D <1000000 1000000 1310000>;
> > > +                     clock-latency-ns =3D <244144>; /* 8 32k periods=
 */
> > > +             };
> > > +
> > > +             opp@648000000 {
> > > +                     opp-hz =3D /bits/ 64 <648000000>;
> > > +                     opp-microvolt =3D <1040000 1040000 1310000>;
> > > +                     clock-latency-ns =3D <244144>; /* 8 32k periods=
 */
> > > +             };
> > > +
> > > +             opp@816000000 {
> > > +                     opp-hz =3D /bits/ 64 <816000000>;
> > > +                     opp-microvolt =3D <1080000 1080000 1310000>;
> > > +                     clock-latency-ns =3D <244144>; /* 8 32k periods=
 */
> > > +             };
> > > +
> > > +             opp@912000000 {
> > > +                     opp-hz =3D /bits/ 64 <912000000>;
> > > +                     opp-microvolt =3D <1120000 1120000 1310000>;
> > > +                     clock-latency-ns =3D <244144>; /* 8 32k periods=
 */
> > > +             };
> > > +
> > > +             opp@960000000 {
> > > +                     opp-hz =3D /bits/ 64 <960000000>;
> > > +                     opp-microvolt =3D <1160000 1160000 1310000>;
> > > +                     clock-latency-ns =3D <244144>; /* 8 32k periods=
 */
> > > +             };
> > > +
> > > +             opp@1008000000 {
> > > +                     opp-hz =3D /bits/ 64 <1008000000>;
> > > +                     opp-microvolt =3D <1200000 1200000 1310000>;
> > > +                     clock-latency-ns =3D <244144>; /* 8 32k periods=
 */
> > > +             };
> > > +
> > > +             opp@1056000000 {
> > > +                     opp-hz =3D /bits/ 64 <1056000000>;
> > > +                     opp-microvolt =3D <1240000 1240000 1310000>;
> > > +                     clock-latency-ns =3D <244144>; /* 8 32k periods=
 */
> > > +             };
> > > +
> > > +             opp@1104000000 {
> > > +                     opp-hz =3D /bits/ 64 <1104000000>;
> > > +                     opp-microvolt =3D <1260000 1260000 1310000>;
> > > +                     clock-latency-ns =3D <244144>; /* 8 32k periods=
 */
> > > +             };
> > > +
> > > +             opp@1152000000 {
> > > +                     opp-hz =3D /bits/ 64 <1152000000>;
> > > +                     opp-microvolt =3D <1300000 1300000 1310000>;
> > > +                     clock-latency-ns =3D <244144>; /* 8 32k periods=
 */
> >
> > What is the frequency and voltage that U-Boot sets up?
>=20
> 1008 MHz, and whatever voltage the board design defaults to (typically
> the higher setting).
>=20
> > We've had the issue with the A33 that it's started at 1008MHz, with
> > the matching voltage, and ramping up the frequency to 1.2GHz on boards
> > without PMIC support would increase the frequency but not the voltage,
> > resulting in a brownout.
>=20
> Which is why I added the regulator to all boards before this patch. At
> least for Linux, once the regulator supply is described in the device
> tree, if the driver is missing, regulator_get_* and thus cpufreq should
> fail with -EPROBE_DEFER.
>=20
> Or we could drop the extra OPPs.

Ok, if you covered all of them then fine by me. For the whole series,
Acked-by: Maxime Ripard <maxime.ripard@bootlin.com>

Maxime

--=20
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

--wfmp6bpod2cyevow
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCXFF1bwAKCRDj7w1vZxhR
xbZhAP46JffbKB3rQtH3OZZp/Q8KDlrR+H9ZICzLbzMMU9z0rwEA15eZqCKQVZgW
jF6e24cIZ8zqdNsUMVB8SlklJRRa7wo=
=/pAR
-----END PGP SIGNATURE-----

--wfmp6bpod2cyevow--
