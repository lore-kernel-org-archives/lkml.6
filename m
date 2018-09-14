Return-Path: <SRS0=Jh2l=L4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CFE1ECDFD0
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 16:26:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B4DFD20861
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 16:26:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B4DFD20861
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728390AbeINVmF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Sep 2018 17:42:05 -0400
Received: from mail.bootlin.com ([62.4.15.54]:50073 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726900AbeINVmF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Sep 2018 17:42:05 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id C93BC20741; Fri, 14 Sep 2018 18:26:49 +0200 (CEST)
Received: from qschulz (LFbn-1-10589-128.w90-89.abo.wanadoo.fr [90.89.181.128])
        by mail.bootlin.com (Postfix) with ESMTPSA id 6DB1B20741;
        Fri, 14 Sep 2018 18:26:39 +0200 (CEST)
Date:   Fri, 14 Sep 2018 18:26:38 +0200
From:   Quentin Schulz <quentin.schulz@bootlin.com>
To:     Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc:     ralf@linux-mips.org, paul.burton@mips.com, jhogan@kernel.org,
        robh+dt@kernel.org, mark.rutland@arm.com, davem@davemloft.net,
        andrew@lunn.ch, f.fainelli@gmail.com, allan.nielsen@microchip.com,
        linux-mips@linux-mips.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        thomas.petazzoni@bootlin.com, antoine.tenart@bootlin.com
Subject: Re: [PATCH 5/7] MIPS: mscc: ocelot: add GPIO4 pinmuxing DT node
Message-ID: <20180914162638.fgzzjin2bzgx74de@qschulz>
References: <cover.b921b010b6d6bde1c11e69551ae38f3b2818645b.1536916714.git-series.quentin.schulz@bootlin.com>
 <92e37a04e77003f01a67ac5e49e66ae83f87c591.1536916714.git-series.quentin.schulz@bootlin.com>
 <20180914145446.GQ14988@piout.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="2afe6svvec7mox5x"
Content-Disposition: inline
In-Reply-To: <20180914145446.GQ14988@piout.net>
User-Agent: NeoMutt/20171215
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--2afe6svvec7mox5x
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Alexandre,

On Fri, Sep 14, 2018 at 04:54:46PM +0200, Alexandre Belloni wrote:
> Hi,
>=20
> On 14/09/2018 11:44:26+0200, Quentin Schulz wrote:
> > In order to use GPIO4 as a GPIO, we need to mux it in this mode so let's
> > declare a new pinctrl DT node for it.
> >=20
> > Signed-off-by: Quentin Schulz <quentin.schulz@bootlin.com>
> > ---
> >  arch/mips/boot/dts/mscc/ocelot.dtsi | 5 +++++
> >  1 file changed, 5 insertions(+)
> >=20
> > diff --git a/arch/mips/boot/dts/mscc/ocelot.dtsi b/arch/mips/boot/dts/m=
scc/ocelot.dtsi
> > index 8ce317c..b5c4c74 100644
> > --- a/arch/mips/boot/dts/mscc/ocelot.dtsi
> > +++ b/arch/mips/boot/dts/mscc/ocelot.dtsi
> > @@ -182,6 +182,11 @@
> >  			interrupts =3D <13>;
> >  			#interrupt-cells =3D <2>;
> > =20
> > +			gpio4: gpio4 {
> > +				pins =3D "GPIO_4";
> > +				function =3D "gpio";
> > +			};
> > +
>=20
> For a GPIO, I would do that in the board dts because it is not used
> directly in the dtsi.
>=20

And the day we've two boards using this pinctrl we move it to a dtsi. Is
that the plan?

Thanks,
Quentin

--2afe6svvec7mox5x
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEXeEYjDsJh38OoyMzhLiadT7g8aMFAlub4T4ACgkQhLiadT7g
8aP7UQ/9ELOF+YSXDT7P+rBVWy1M48MB/sdLCLsDzojLZaN/T5sIC5+quBt6k8JF
1r9pBj1TWRy5zVNXDNY1yFSerQ0EYNRmSUMHT/ECdoLbwZuD55Md6nOesXWdVoGv
R8tEjqloxkUOIshLMXbWXXIFlUFLxqo6BVbf2+2shz10zFR333HgrTdLQLrp8zA2
zANt5vJ4ZZyOH/Ei2B1DjBaAD4mbIXDvNIr/Z9JZdGNpiyxDsWLzJbBXmBzWLF/v
/O4Njt7xv/ALmCawBD0ugE5vMuHdADPlZX1r37XhlJCxDAQulzua7iXDvTfuzAjk
k0fGECmQvMfeGujkpPeaheeqMGeGTQSKwgltmp2kEAYymVOiOH5WTdtWrv1B7s+E
RnaPP/53CVC4kbdCTvVJ7tSHn8qJ+IG2J8PGKd1iBDa/5qB5rYyVobjeeytb5sup
IT6csKdtmX15ZeotKOLap3dVzXhZs4acOLPtNJ2LPW9HEBXjsIfOSyInOki/AgM1
qnTzanB42dSueNh6cyEnevRrDrqoPfsZQ4qb6Xt9yXidChb8ClUVrO+Qw7N1q947
gzHl/dOtf7T4Y7jyoIOe96TK+bldGeBuvUD9Q8xYk4gj5UIzKcycHN8WKF5vNnxb
86uOVSrJWcdS2oO08lmPnGCgMRhqguIrF69ohP+DhgQ+q0P7Rus=
=VQZS
-----END PGP SIGNATURE-----

--2afe6svvec7mox5x--
