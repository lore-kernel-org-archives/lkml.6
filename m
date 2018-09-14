Return-Path: <SRS0=Jh2l=L4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B183EECDFD0
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 16:28:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6D2C820861
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 16:28:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6D2C820861
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728471AbeINVn4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Sep 2018 17:43:56 -0400
Received: from mail.bootlin.com ([62.4.15.54]:50220 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727749AbeINVnz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Sep 2018 17:43:55 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 78D0520877; Fri, 14 Sep 2018 18:28:39 +0200 (CEST)
Received: from qschulz (LFbn-1-10589-128.w90-89.abo.wanadoo.fr [90.89.181.128])
        by mail.bootlin.com (Postfix) with ESMTPSA id 20F5D207D4;
        Fri, 14 Sep 2018 18:28:29 +0200 (CEST)
Date:   Fri, 14 Sep 2018 18:28:28 +0200
From:   Quentin Schulz <quentin.schulz@bootlin.com>
To:     Andrew Lunn <andrew@lunn.ch>
Cc:     alexandre.belloni@bootlin.com, ralf@linux-mips.org,
        paul.burton@mips.com, jhogan@kernel.org, robh+dt@kernel.org,
        mark.rutland@arm.com, davem@davemloft.net, f.fainelli@gmail.com,
        allan.nielsen@microchip.com, linux-mips@linux-mips.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, thomas.petazzoni@bootlin.com,
        antoine.tenart@bootlin.com
Subject: Re: [PATCH net-next 2/7] net: phy: mscc: add support for VSC8584 PHY
Message-ID: <20180914162828.5e75ffh5sig4om3d@qschulz>
References: <cover.b921b010b6d6bde1c11e69551ae38f3b2818645b.1536916714.git-series.quentin.schulz@bootlin.com>
 <a61d9affd3f1ec9deb60c882cce1daf37fbe2427.1536916714.git-series.quentin.schulz@bootlin.com>
 <20180914131846.GG14865@lunn.ch>
 <20180914132930.fphdm3dm2incetbq@qschulz>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="lrvuohlm2to6nryf"
Content-Disposition: inline
In-Reply-To: <20180914132930.fphdm3dm2incetbq@qschulz>
User-Agent: NeoMutt/20171215
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--lrvuohlm2to6nryf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Andrew,

On Fri, Sep 14, 2018 at 03:29:30PM +0200, Quentin Schulz wrote:
> Hi Andrew,
>=20
> On Fri, Sep 14, 2018 at 03:18:46PM +0200, Andrew Lunn wrote:
> > > Most of the init sequence of a PHY of the package is common to all PH=
Ys
> > > in the package, thus we use the SMI broadcast feature which enables us
> > > to propagate a write in one register of one PHY to all PHYs in the
> > > package.
> >=20
> > Hi Quinten
> >=20
> > Could you say a bit more about the broadcast. Does the SMI broadcast
> > go to all PHY everywhere on an MDIO bus, or only all PHYs within one
> > package? I'm just thinking about the case you need two of these
> > packages to cover 8 switch ports.
> >=20
>=20
> Ah sorry, that wasn't very explicit. That's a feature on the PHY side so
> my wildest guess is that it wouldn't impact any other PHY outside of
> this package. Affecting any other PHY on the bus is counter-intuitive to
> me but I'll ask the HW engineers for confirmation.
>=20

Confirmed by HW engineers, it only impacts PHYs in the same package.

Quentin

--lrvuohlm2to6nryf
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEXeEYjDsJh38OoyMzhLiadT7g8aMFAlub4awACgkQhLiadT7g
8aP1fg//V+Mup3knhZdlR5JAs/en28BkBQ1Tc76y+7zpzgqSMjAyP2gfg4vMoKz2
3H1Y+jQcX0QopeLDwks0To8eyHwYcq//Wvlv6XSvl7W3/8qPYqIaTXlWZD+O4smK
d0+MP8u5silgh5hS9NKDBKdKheXirH7gdCDLbXDhY2TMCDYYTfrx6Xi3dwRfdivc
x+Zhhmp14p5qhyvEDE7IUSzMcqGo9tKKwR6VQPHtMCyJ3+Wfe4kmTm8nkTFwL1fF
T2l1V1U7ROEQXhyUni61JEH33CZzp8WwOwOkaUjvBIOsur8K+xb7LboHYvh5b0ni
szCdTBqtybkKxUT4FHLm2xWexBBDb5vWQYOQUxMxybe/xfsIsGLUX2MQt9g4PNMO
MTWW7H662G9H0lsqcp4/e05eyIkroBX8Qt547NuQ3dr+RjPn1C9ZbwEPz4C/14+T
GaXc+sncNluq2A+VaMGTx2ZjZOo/Y+coVdhm9nuup9kMibboAd10KqchPBvtBGS0
4IqacfOHH+oNzAkoq30s6Ta4uixULZls6Exfzrn0yKLffxwOeD3fPisCwLGsW2zV
DN1L0uubJWCkTFYuO5tilgZrl3HuF1f4cu/xhtl2kq0bMm3pgAVK/UXXQcqnZ/Rh
bFNMfRwHSSMhAnDHKIXzmLgNf9iGE2skB/QyNuvZr9Nc+7VxlO4=
=qNw+
-----END PGP SIGNATURE-----

--lrvuohlm2to6nryf--
