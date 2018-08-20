Return-Path: <SRS0=A5JR=LD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35B21C4321D
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Aug 2018 15:02:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DEFA8208DC
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Aug 2018 15:02:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DEFA8208DC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726710AbeHTSSN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Aug 2018 14:18:13 -0400
Received: from mail.bootlin.com ([62.4.15.54]:45099 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726010AbeHTSSN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Aug 2018 14:18:13 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 358B520717; Mon, 20 Aug 2018 17:02:11 +0200 (CEST)
Received: from localhost (AAubervilliers-681-1-85-9.w90-88.abo.wanadoo.fr [90.88.27.9])
        by mail.bootlin.com (Postfix) with ESMTPSA id 01C63206A6;
        Mon, 20 Aug 2018 17:02:00 +0200 (CEST)
Date:   Mon, 20 Aug 2018 17:02:01 +0200
From:   Maxime Ripard <maxime.ripard@bootlin.com>
To:     Icenowy Zheng <icenowy@aosc.io>
Cc:     linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        Chen-Yu Tsai <wens@csie.org>, linux-sunxi@googlegroups.com,
        linux-kernel@vger.kernel.org
Subject: Re: [linux-sunxi] Re: [PATCH] ARM: dts: sun8i: r40/v40: rewrite BPi
 M2 Berry DTS to rebase on M2 Ultra
Message-ID: <20180820150201.t2qoqvpsd66arprz@flea>
References: <20180724163655.61365-1-icenowy@aosc.io>
 <20180726124119.dwne2sncws2p3sdi@flea>
 <dc8a28bcfbe082158bac5b097badb3ddf0f51ce8.camel@aosc.io>
 <20180820120046.7tonxtb52q43ocfq@flea>
 <2782CDF6-C36F-49EF-97AE-75382C416489@aosc.io>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="ubiy6wokou235udw"
Content-Disposition: inline
In-Reply-To: <2782CDF6-C36F-49EF-97AE-75382C416489@aosc.io>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--ubiy6wokou235udw
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 20, 2018 at 08:06:21PM +0800, Icenowy Zheng wrote:
>=20
>=20
> =E4=BA=8E 2018=E5=B9=B48=E6=9C=8820=E6=97=A5 GMT+08:00 =E4=B8=8B=E5=8D=88=
8:00:46, Maxime Ripard <maxime.ripard@bootlin.com> =E5=86=99=E5=88=B0:
> >Hi!
> >
> >On Wed, Aug 08, 2018 at 06:36:56PM +0800, Icenowy Zheng wrote:
> >> =E5=9C=A8 2018-07-26=E5=9B=9B=E7=9A=84 14:41 +0200=EF=BC=8CMaxime Ripa=
rd=E5=86=99=E9=81=93=EF=BC=9A
> >> > On Wed, Jul 25, 2018 at 12:36:55AM +0800, Icenowy Zheng wrote:
> >> > > Banana Pi designs the BPi M2 Berry board to be software
> >compatible
> >> > > with
> >> > > BPi M2 Ultra,
> >> >=20
> >> > Do you have a reference for this?
> >> >=20
> >> > > so it's based on M2 Ultra with some function cuts, including:
> >> > >=20
> >> > > - 2048MiB DRAM -> 1024MiB (this should be proceed by the
> >> > > bootloader);
> >> > > - dropped a LED;
> >> > > - dropped eMMC;
> >> > > - dropped USB2 and connect USB1 to a 4-port HUB.
> >> >=20
> >> > Is it the exhaustive list?
> >>=20
> >> I have asked Mikey from Sinovoip, and he has agreed this.
> >>=20
> >> Here's a list provided by him, which covers some things I forgot:
> >> - 2GiB -> 1GiB
> >> - no eMMC
> >> - no onboard microphone
> >> - no IR
> >> - no charging (and power jack to USB)
> >> - USB change
> >> - one less LED
> >>=20
> >> Should I add this to the device tree's comment?
> >
> >Not really, because...
> >
> >> >=20
> >> > I'm a bit reluctant to merge that kind of patches usually, since
> >that
> >> > would also imply that each time someone will commit something to
> >the
> >> > M2-Ultra, it would automatically apply to the M2-Berry, without any
> >> > easy way to tell and / or test.
> >
> >... this still applies.
>=20
> But I think few developers will have both boards at the same time.

Which is only making it worse, because then someone with only the BPI
m2-ultra, when changing the DT, will not be able to tell that:

 - it's applied to the M2-Berry too,
 - if it works on the M2-Berry.

Maxime

--=20
Maxime Ripard, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com

--ubiy6wokou235udw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEE0VqZU19dR2zEVaqr0rTAlCFNr3QFAlt61+gACgkQ0rTAlCFN
r3T6cA/9HJs6NWHZ6nfVmUQT5rFNFR6ovzGPpAqny2McXM8oc1+Ytcj3tYqC6WZf
H/kqoZzK6qU+Xmkw0l0kK0OIaQ7SYAhwQ5o1JzFoMewaiD5X2YpNfU55sX93qbc8
bu5EW8nsm/knwFx1zFFVEmkA2TykOM8L3f1jj4xqqEfSfdIWjWL9ZvArNT6W5pvE
zIZsUFmaaMb+Z+ndSGzzMdJtzDR+832kyiugqYjwy9GNAh0WhNpqetaR0owhjqc2
/R3Emcdc4cpZl1zCE8mRPp6F69RhwXEvSZz7TqWQDaGBP/okuFsp+ULgHu06uJ18
DOGtUc7PeqKJobXXftG20HiA05COno/2ta/iRBEv5D7O64X7saSOY5Kl3GHKcgt7
WB5agJ8w4Tg8G4+n6MP5mmmJdjH3uNAiZPb6TR7Ex7MDf6gJiO4OJt2NIpimzz77
9E+PAe6KR1ZgZjSpE+8ZO+7iUrOA7ehQP5D4cgtj3RomnCCWBsBoa4Ct0yP9Feob
pvEZ+iWW9aYRuq2BaOIyBWn4Sd9h4RuBleMJ9qJuqpAZkd/E131qf7qFPvwGb0rD
w7cUtFtjLEp8bXukUavxkyXFJeTBI0zQxsdy0OETJ1137RE5P3FwtVUgeWQVIL3P
k4ABBfC6s8c2FpxE2ZkqC0PrtUDvEiprPSZ0gNfitlj7VGQiqYg=
=bOvK
-----END PGP SIGNATURE-----

--ubiy6wokou235udw--
