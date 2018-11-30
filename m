Return-Path: <SRS0=bYeO=OJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4DCDC04EB8
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 21:08:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7E88A20660
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 21:08:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7E88A20660
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ucw.cz
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726796AbeLAISx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 1 Dec 2018 03:18:53 -0500
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:57522 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726103AbeLAISx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Dec 2018 03:18:53 -0500
Received: by atrey.karlin.mff.cuni.cz (Postfix, from userid 512)
        id E91668098B; Fri, 30 Nov 2018 22:08:11 +0100 (CET)
Date:   Fri, 30 Nov 2018 22:08:14 +0100
From:   Pavel Machek <pavel@ucw.cz>
To:     Rob Herring <robh@kernel.org>
Cc:     Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        Linux LED Subsystem <linux-leds@vger.kernel.org>,
        devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Baolin Wang <baolin.wang@linaro.org>,
        Daniel Mack <daniel@zonque.org>, Dan Murphy <dmurphy@ti.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Oleh Kravchenko <oleg@kaa.org.ua>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Simon Shields <simon@lineageos.org>
Subject: Re: [PATCH 04/24] dt-bindings: leds: Add function and color
 properties
Message-ID: <20181130210814.GA5756@amd>
References: <1541542052-10081-1-git-send-email-jacek.anaszewski@gmail.com>
 <1541542052-10081-5-git-send-email-jacek.anaszewski@gmail.com>
 <5bea0eb8.1c69fb81.6b921.80e6@mx.google.com>
 <dfb5bd23-bcb9-7501-a608-969cb0464168@gmail.com>
 <0a0b176c-4eb4-4b0e-6c3c-b3c6c8f5fff5@gmail.com>
 <CAL_JsqKEpbJjExkQKSXwYma9wPPO+8E0QMTyWTPs1nkGSd49_g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="ZGiS0Q5IWpPtfppv"
Content-Disposition: inline
In-Reply-To: <CAL_JsqKEpbJjExkQKSXwYma9wPPO+8E0QMTyWTPs1nkGSd49_g@mail.gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--ZGiS0Q5IWpPtfppv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> > Pavel gave following examples:
> >
> > eth0:green:link
> > adsl0:green:link
> > adsl0:red:error
> >
> > So we would have e.g.:
> >
> > associated-vl42-device =3D <&camera1>;
> > associated-network-device =3D <&phy1>;
> > associated-block-device =3D <&phy1>;
>=20
> Variable property names are kind of a pain to parse.

Ok, would it be enough to have associated-device =3D <&whatever>?

> Perhaps when LEDs are associated with a device, we shouldn't care
> within the context of the LED subsystem what the name is. The
> association is more important and if you have that exposed, then you
> don't really need to care what the name is. You still have to deal
> with a device with more than 1 LED, but that becomes a problem local
> to that device.
>=20
> What I'm getting at is following a more standard binding pattern of
> providers and consumers like we have for gpios, clocks, etc. So we'd
> have something like this:
>=20
> ethernet {
>   ...
>   leds =3D <&green_led>, <&red_led>;
>   led-names =3D "link", "err";
> };

Basically every single device could have a LED associated with it
("activity"). Would doing it like this mean we'd have to modify every
single driver to parse leds / led-names properties?

									Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--ZGiS0Q5IWpPtfppv
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlwBpr4ACgkQMOfwapXb+vL96QCfdY7k6J8earpw9VTU/PFyLHAg
0TcAn35xQjH4+gVL97ylZhidUy84B5+h
=5ag6
-----END PGP SIGNATURE-----

--ZGiS0Q5IWpPtfppv--
