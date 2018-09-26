Return-Path: <SRS0=3sEf=MI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0116C43382
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 14:32:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4BE6420843
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 14:32:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4BE6420843
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=denx.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727375AbeIZUpl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Sep 2018 16:45:41 -0400
Received: from mail-out.m-online.net ([212.18.0.10]:52853 "EHLO
        mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727067AbeIZUpl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Sep 2018 16:45:41 -0400
Received: from frontend01.mail.m-online.net (unknown [192.168.8.182])
        by mail-out.m-online.net (Postfix) with ESMTP id 42L0lC6kHkz1qwJF;
        Wed, 26 Sep 2018 16:32:23 +0200 (CEST)
Received: from localhost (dynscan1.mnet-online.de [192.168.6.70])
        by mail.m-online.net (Postfix) with ESMTP id 42L0lC5kZnz1qqkL;
        Wed, 26 Sep 2018 16:32:23 +0200 (CEST)
X-Virus-Scanned: amavisd-new at mnet-online.de
Received: from mail.mnet-online.de ([192.168.8.182])
        by localhost (dynscan1.mail.m-online.net [192.168.6.70]) (amavisd-new, port 10024)
        with ESMTP id cwav_t3pUidQ; Wed, 26 Sep 2018 16:32:21 +0200 (CEST)
X-Auth-Info: Pg15wj60j1+C+nT4frh2bYxjuKg5FuJFHP5iVetb9PU=
Received: from jawa (85-222-111-42.dynamic.chello.pl [85.222.111.42])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.mnet-online.de (Postfix) with ESMTPSA;
        Wed, 26 Sep 2018 16:32:21 +0200 (CEST)
Date:   Wed, 26 Sep 2018 16:32:12 +0200
From:   Lukasz Majewski <lukma@denx.de>
To:     Rob Herring <robh@kernel.org>
Cc:     Mark Brown <broonie@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, linux-spi@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] dt-bindings: spi: Provide bindings for fsl dspi
 working in slave mode
Message-ID: <20180926163212.17646e43@jawa>
In-Reply-To: <5baa1aee.1c69fb81.cc7c6.340b@mx.google.com>
References: <20180918093437.26799-1-lukma@denx.de>
        <20180918093437.26799-2-lukma@denx.de>
        <5baa1aee.1c69fb81.cc7c6.340b@mx.google.com>
Organization: denx.de
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/LGoFAwmaqALw0uZRX55V==p"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/LGoFAwmaqALw0uZRX55V==p
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Rob,

> On Tue, Sep 18, 2018 at 11:34:35AM +0200, Lukasz Majewski wrote:
> > This commit provides the description of new property:
> > "fsl,spi-slave-mode" which enables support for DSPI driver working
> > in slave mode.
> >=20
> > As the new compatible shall be used with SPI bus equipped with
> > master device a new "spidev" based node has been introduced to
> > avoid confusion.
> >=20
> > Signed-off-by: Lukasz Majewski <lukma@denx.de>
> > ---
> >  Documentation/devicetree/bindings/spi/spi-fsl-dspi.txt | 8 ++++++++
> >  1 file changed, 8 insertions(+)
> >=20
> > diff --git a/Documentation/devicetree/bindings/spi/spi-fsl-dspi.txt
> > b/Documentation/devicetree/bindings/spi/spi-fsl-dspi.txt index
> > 18eeafe359d8..b30af19a2bc5 100644 ---
> > a/Documentation/devicetree/bindings/spi/spi-fsl-dspi.txt +++
> > b/Documentation/devicetree/bindings/spi/spi-fsl-dspi.txt @@ -26,6
> > +26,7 @@ Optional SPI properties for slave nodes:
> >  - fsl,spi-sck-cs-delay: a delay in nanoseconds between stopping
> > the clock signal and deactivating chip select, at the end of a
> > transfer.
> >  - bus-num : the slave chip chipselect signal number.
> > +- fsl,spi-slave-mode: if present, controller runs in slave mode. =20
>=20
> There's a standard property for this.

I've just realised that there is "spi-slave" property in the
Documentation/devicetree/bindings/spi/spi-bus.txt

I will convert the code to use it.

>=20
> > =20
> >  Example:
> > =20
> > @@ -56,6 +57,13 @@ dspi0@4002c000 {
> >  		fsl,spi-cs-sck-delay =3D <100>;
> >  		fsl,spi-sck-cs-delay =3D <50>;
> >  	};
> > +
> > +	spidev3@1 {
> > +		compatible =3D "fsl,vf610-dspi";
> > +		spi-max-frequency =3D <30000000>;
> > +		reg =3D <1>;
> > +		fsl,spi-slave-mode; =20
>=20
> This doesn't look right for how slave mode is described.

You mean that I shall replace fsl,spi-slave-mode; with "spi-slave" ?

Or is there any other issue with this code?

Thanks for your review,

>=20
> > +	};
> >  };
> > =20
> > =20
> > --=20
> > 2.11.0
> >  =20
>=20




Best regards,

Lukasz Majewski

--

DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: (+49)-8142-66989-10 Fax: (+49)-8142-66989-80 Email: wd@denx.de

--Sig_/LGoFAwmaqALw0uZRX55V==p
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEgAyFJ+N6uu6+XupJAR8vZIA0zr0FAlurmGwACgkQAR8vZIA0
zr04yggAxcFTFmT/2Ptx9RsItXvDRTGISWqky1pCWdlAhttHe6XELQTXBaRQfKox
MBP3NP7pIQlAPwHNtJqZWafcEBCAfkg1NL154CbDjoDCtuvSCMsGOUqksg7jNQEz
RT9lfEYfopqskhGapo6u1Oi2R+7RF2CcrEr00+VsrqtzXW1vtNaiT3AqwOyq+RFy
8tNghCmdumKKG9md1mS5cCSqsnqUhQjKNW7GQxiVoEye4pY1fJsak4+WHrSH9VCG
gPj6S1khWGA8u4qKI5IpXs4r252zRMXy4NPWS+LG1Kms1oCLtcWInGUr98kzrCqp
MXzpEfCqjQMiCcpBDTcOHDjv+woAKA==
=gVjF
-----END PGP SIGNATURE-----

--Sig_/LGoFAwmaqALw0uZRX55V==p--
