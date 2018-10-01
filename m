Return-Path: <SRS0=RFFj=MN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCC93C64EAD
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 09:01:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 89CBD2084C
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 09:01:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 89CBD2084C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729000AbeJAPic (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Oct 2018 11:38:32 -0400
Received: from mail.bootlin.com ([62.4.15.54]:49867 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728849AbeJAPic (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Oct 2018 11:38:32 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 3EC41207EB; Mon,  1 Oct 2018 11:01:45 +0200 (CEST)
Received: from qschulz (AAubervilliers-681-1-24-95.w90-88.abo.wanadoo.fr [90.88.144.95])
        by mail.bootlin.com (Postfix) with ESMTPSA id D0575206A2;
        Mon,  1 Oct 2018 11:01:34 +0200 (CEST)
Date:   Mon, 1 Oct 2018 11:01:34 +0200
From:   Quentin Schulz <quentin.schulz@bootlin.com>
To:     Andrew Lunn <andrew@lunn.ch>
Cc:     Alexandre Belloni <alexandre.belloni@bootlin.com>,
        ralf@linux-mips.org, paul.burton@mips.com, jhogan@kernel.org,
        robh+dt@kernel.org, mark.rutland@arm.com, davem@davemloft.net,
        f.fainelli@gmail.com, allan.nielsen@microchip.com,
        linux-mips@linux-mips.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        thomas.petazzoni@bootlin.com, antoine.tenart@bootlin.com
Subject: Re: [PATCH 5/7] MIPS: mscc: ocelot: add GPIO4 pinmuxing DT node
Message-ID: <20181001090134.jj47azs5nlbugmbi@qschulz>
References: <cover.b921b010b6d6bde1c11e69551ae38f3b2818645b.1536916714.git-series.quentin.schulz@bootlin.com>
 <92e37a04e77003f01a67ac5e49e66ae83f87c591.1536916714.git-series.quentin.schulz@bootlin.com>
 <20180914145446.GQ14988@piout.net>
 <20180914162638.fgzzjin2bzgx74de@qschulz>
 <20180914170221.GB3811@lunn.ch>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="y3mid7ypocxn35om"
Content-Disposition: inline
In-Reply-To: <20180914170221.GB3811@lunn.ch>
User-Agent: NeoMutt/20171215
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--y3mid7ypocxn35om
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Andrew,

On Fri, Sep 14, 2018 at 07:02:21PM +0200, Andrew Lunn wrote:
> On Fri, Sep 14, 2018 at 06:26:38PM +0200, Quentin Schulz wrote:
> > Hi Alexandre,
> >=20
> > On Fri, Sep 14, 2018 at 04:54:46PM +0200, Alexandre Belloni wrote:
> > > Hi,
> > >=20
> > > On 14/09/2018 11:44:26+0200, Quentin Schulz wrote:
> > > > In order to use GPIO4 as a GPIO, we need to mux it in this mode so =
let's
> > > > declare a new pinctrl DT node for it.
> > > >=20
> > > > Signed-off-by: Quentin Schulz <quentin.schulz@bootlin.com>
> > > > ---
> > > >  arch/mips/boot/dts/mscc/ocelot.dtsi | 5 +++++
> > > >  1 file changed, 5 insertions(+)
> > > >=20
> > > > diff --git a/arch/mips/boot/dts/mscc/ocelot.dtsi b/arch/mips/boot/d=
ts/mscc/ocelot.dtsi
> > > > index 8ce317c..b5c4c74 100644
> > > > --- a/arch/mips/boot/dts/mscc/ocelot.dtsi
> > > > +++ b/arch/mips/boot/dts/mscc/ocelot.dtsi
> > > > @@ -182,6 +182,11 @@
> > > >  			interrupts =3D <13>;
> > > >  			#interrupt-cells =3D <2>;
> > > > =20
> > > > +			gpio4: gpio4 {
> > > > +				pins =3D "GPIO_4";
> > > > +				function =3D "gpio";
> > > > +			};
> > > > +
> > >=20
> > > For a GPIO, I would do that in the board dts because it is not used
> > > directly in the dtsi.
> > >=20
> >=20
> > And the day we've two boards using this pinctrl we move it to a dtsi. Is
> > that the plan?
>=20
> Hi Quentin
>=20
> gpio4 appears to be pretty arbitrary. Could a different design use a
> different gpio? It me, this seems like a board property.
>=20

Right now, I don't see why it couldn't be.

Quentin

--y3mid7ypocxn35om
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEXeEYjDsJh38OoyMzhLiadT7g8aMFAlux4m4ACgkQhLiadT7g
8aOwrw//fggU/lf20tjDRRE/OUzOw7mWBOfcLJW8Vgt/5R21//tJiSE2ZROZwhD1
Lhlwfq2yvRuOHD9y+7qbgD76h5CjT5++AtRYEG7OCnzcRgTSb+P/KYHm+WX9D4y7
lBzFrTm0pDvCi7lKldMQy4KDgaSV0XnStL8WdW1VXK7PjUOenpHlT22pcckO5MH0
0BLAflw6Gzi2bqc4EtZqlmVA5jDMLA6BlI/fq885RxCLjAPl+bvAA8PvqO0+ZVm0
8gdiVGkM4O+HFPRQLh20uR83kr0+Y6f5/NjymJFSxIS362QzC1FRImQWreBwv8jr
FaDapv3lPv9zQOCqHDz+/4Da4/8kRYLC9jdStnb+ecoFQhl1QyMB8x1GYCLFv0ok
/SQu9pJyCb8aoPkO9yw2oIE/6ilGVczC651z+CUbKOO34C1yLHRrzjT2/kW2FfEt
y+Y6hvXyQgboUwXYPXV5vW3m/y5TLnKlLu/Yox52YFIdHw8tEn6zEIMidp3DQ/GM
jNZROfROVoBOlsFKvCCfU9oszdIxQAkB25mGKOyO1FaIvZ8ZtXwdTC9ezakbhmxc
zeStyj35qOz7np84EXBBZVSOvxrvXN/q0fGzGojxh+v2voOCmqnA/jn0TpROfkyL
cVuXU9aQgcCs6depD2NTmpyO5RCOqGojVYG1lFjdXWOqUqvFWuU=
=rpvF
-----END PGP SIGNATURE-----

--y3mid7ypocxn35om--
