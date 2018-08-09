Return-Path: <SRS0=+sa6=KY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF6F9C46464
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 21:59:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6286222392
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 21:59:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6286222392
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ucw.cz
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727406AbeHJA0m (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Aug 2018 20:26:42 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:47608 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727324AbeHJA0m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Aug 2018 20:26:42 -0400
Received: by atrey.karlin.mff.cuni.cz (Postfix, from userid 512)
        id A474F80579; Thu,  9 Aug 2018 23:59:49 +0200 (CEST)
Date:   Thu, 9 Aug 2018 23:59:49 +0200
From:   Pavel Machek <pavel@ucw.cz>
To:     Dan Murphy <dmurphy@ti.com>
Cc:     Jacek Anaszewski <jacek.anaszewski@gmail.com>, robh+dt@kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-leds@vger.kernel.org
Subject: Re: [PATCH v2 1/2] dt: bindings: lm3697: Add bindings for lm3697
 driver
Message-ID: <20180809215949.GA6949@amd>
References: <20180807160442.8937-1-dmurphy@ti.com>
 <20180808195903.GB20912@amd>
 <f6b3534b-2ee9-782e-35e5-e103c34528bc@ti.com>
 <20180808210215.GA15831@amd>
 <f18a5616-bb25-da0d-aec8-585e042b4919@ti.com>
 <53691469-4554-42a8-c182-762c1a3939b7@gmail.com>
 <01bbf05a-8e5e-d3ce-857a-ac5c6efb779c@ti.com>
 <683f9e60-9ad8-93d8-e4ed-dbfdae78c307@gmail.com>
 <c028fb73-8df5-9402-d96e-c907199356ed@ti.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="9amGYk9869ThD9tj"
Content-Disposition: inline
In-Reply-To: <c028fb73-8df5-9402-d96e-c907199356ed@ti.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--9amGYk9869ThD9tj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> > Following node would describe strings connected to the outputs
> > HVLED1 and HVLED2 controlled by bank A.
> >=20
> > led@0 {
> > 	reg =3D <0>;
> > 	led-sources =3D <0>. <1>;
> > 	label =3D "white:first_backlight_cluster";
> > 	linux,default-trigger =3D "backlight";
> > };
> >=20
> >=20
> > IOW I agree with Pavel, but I propose to use already documented common
> > DT LED property.
> >=20
>=20
> I agree to use the led-sources but I still believe this approach may be c=
onfusing to other sw devs
> and will lead to configuration issues by users.
>=20
> This implementation requires the sw dev to know which strings are control=
led by which bank.
> And this method may produce a misconfiguration like something below where=
 HVLED2 is declared in
> both bank A and bank B
>=20
> led@0 {
> 	reg =3D <0>;
> 	led-sources =3D <0>. <1>;
> 	label =3D "white:first_backlight_cluster";
> 	linux,default-trigger =3D "backlight";
> };
>=20
> led@1 {
> 	reg =3D <1>;
> 	led-sources =3D <1>. <2>;
> 	label =3D "white:keypad_cluster";
> 	linux,default-trigger =3D "backlight";
> };
>=20
> The driver will need to be intelligent and declare a miss
> configuration on the above.

Yes. But please do it that way, it is still better than being
different from all the other drivers.

Thanks,
									Pavel

--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--9amGYk9869ThD9tj
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAltsuVUACgkQMOfwapXb+vL6AgCgpdcxeVKqePKdmWiOYRaOUAVE
VwEAoLgZIng4U8cSvXmnb8KGob2nKzZ0
=Sv09
-----END PGP SIGNATURE-----

--9amGYk9869ThD9tj--
