Return-Path: <SRS0=pNWC=KQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4D7BC28CF6
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 08:24:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8DD4D2083E
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 08:24:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8DD4D2083E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388577AbeHAKIu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Aug 2018 06:08:50 -0400
Received: from mail.bootlin.com ([62.4.15.54]:34287 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387750AbeHAKIt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Aug 2018 06:08:49 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 7BFBD2074F; Wed,  1 Aug 2018 10:24:14 +0200 (CEST)
Received: from qschulz (AAubervilliers-681-1-89-120.w90-88.abo.wanadoo.fr [90.88.30.120])
        by mail.bootlin.com (Postfix) with ESMTPSA id A985020740;
        Wed,  1 Aug 2018 10:24:13 +0200 (CEST)
Date:   Wed, 1 Aug 2018 10:24:13 +0200
From:   Quentin Schulz <quentin.schulz@bootlin.com>
To:     Andrew Lunn <andrew@lunn.ch>
Cc:     alexandre.belloni@bootlin.com, ralf@linux-mips.org,
        paul.burton@mips.com, jhogan@kernel.org, robh+dt@kernel.org,
        mark.rutland@arm.com, davem@davemloft.net, kishon@ti.com,
        f.fainelli@gmail.com, linux-mips@linux-mips.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, allan.nielsen@microsemi.com,
        thomas.petazzoni@bootlin.com
Subject: Re: [PATCH 07/10] dt-bindings: phy: add DT binding for Microsemi
 Ocelot SerDes muxing
Message-ID: <20180801082413.2mjm52vwxw3anun6@qschulz>
References: <cover.aa759035f6eefdd0bb2a5ae335dab5bd5399bd46.1532954208.git-series.quentin.schulz@bootlin.com>
 <cd75c96640cc7fe306ee355acb1db85adb5b796f.1532954208.git-series.quentin.schulz@bootlin.com>
 <20180730133448.GD13198@lunn.ch>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="aipy2f7xx2epmgoe"
Content-Disposition: inline
In-Reply-To: <20180730133448.GD13198@lunn.ch>
User-Agent: NeoMutt/20171215
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--aipy2f7xx2epmgoe
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Andrew,

On Mon, Jul 30, 2018 at 03:34:48PM +0200, Andrew Lunn wrote:
> > +Required properties:
> > +
> > +- compatible: should be "mscc,vsc7514-serdes"
> > +- #phy-cells : from the generic phy bindings, must be 3. The first num=
ber
> > +               defines the kind of Serdes (1 for SERDES1G_X, 6 for
> > +	       SERDES6G_X), the second defines the macros in the specified
> > +	       kind of Serdes (X for SERDES1G_X or SERDES6G_X) and the
> > +	       last one defines the input port to use for a given SerDes
> > +	       macro,
>=20
> It looks like there are some space vs tab issues here.
>=20

Yup.

> > +
> > +Example:
> > +
> > +	serdes: serdes {
>=20
> Maybe this should be serdes-mux? The SERDES itself should have some
> registers somewhere. If you ever decide to make use of phylink,
> e.g. to support SFP, you are going to need to know if the SERDES is
> up. So you might need to add the actual SERDES device, in addition to
> the mux for the SERDES.
>=20

I'm not sure to follow.

To be honest, I might have mislead you. The whole configuration of the
serdes is in the hsio register address space. For now, muxing is the
only reason there is a driver for the serdes but there are other things
that can be configured (though not used yet): de/serializer, input/output
buffers, PLL, ... configuration registers for the SerDes.

So I think I should remove the mention to muxing and just say in the
cover letter and commit log it's for muxing the SerDes among other
configurations.

So I think we're good with the current driver and DT, just poor wording
on my side for the commit log/cover letter. Do you agree?

Quentin

--aipy2f7xx2epmgoe
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEXeEYjDsJh38OoyMzhLiadT7g8aMFAlthbi0ACgkQhLiadT7g
8aOyLA/9HtLbvOJgwUIZRSo5DLUGfIBcDAtRbCl1SaO8iLbCWTxaIoBuNXuNO8XI
yUjneskEuXEAf0cuKpvrCmc34rK/ccezT1FoI7GSZ1avKosbpBo7CexZNoIPlp5S
ABoiNORwbiTeZgth+ppgT1rSYB7RkxH0Rn3PeArX6jOdxUQz2iSZVfDK/6WmoHaA
tWwfivFI428uVRq+dD5PRUW+eOF4EA+wnvGGL0I/Dl1Tsp6Z93hxdKLrkT6d6pxn
n/JR5d9r/U7uyTJ20/oK+202y2/dG+5Iy6+UIUFH+Y5CuxeOroJJbLAfhk2yC2sI
BgKLVqrH5i6UI1dWmdyC1YGKOyQE8WZ3oJ2Nht1VvYs92OKfEF8RIn9v788RdkgI
bB7s4KM5hT9qnon+t2iw7q1UKmyTCcV1Mcdm1j/yNDWE4grK3DkeOQXBhBhpeZhf
jFdKmNUkrTCrxtoOLlm7NYNGJLlY9gAmOJiXeGRmQZYnzpJvZ8vbPx0MzSSdoqqR
wxuNrOC2pzv5zc5Vv33WDtC62Nz5IkZMdVqm4tDlI/HVgcdLgyf/UOuJIqhWd3Zy
oSLPrS0OrWac72jJ3MYORq+EqxDcdHEqbUl6kaDNlXTwonZ7mHyS92IKdtUIrhdx
jvHh8+OmPTht1cRXtWpoIvPyOIrEF/H3DV7b5Ikp1eHEDCnjsAg=
=0DPF
-----END PGP SIGNATURE-----

--aipy2f7xx2epmgoe--
