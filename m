Return-Path: <SRS0=Jh2l=L4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0320DECE561
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 21:42:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A9EF320853
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 21:42:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A9EF320853
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ucw.cz
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728289AbeIOC6m (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Sep 2018 22:58:42 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:49274 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727807AbeIOC6m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Sep 2018 22:58:42 -0400
Received: by atrey.karlin.mff.cuni.cz (Postfix, from userid 512)
        id 9269C8070B; Fri, 14 Sep 2018 23:42:21 +0200 (CEST)
Date:   Fri, 14 Sep 2018 23:42:20 +0200
From:   Pavel Machek <pavel@ucw.cz>
To:     Jacek Anaszewski <jacek.anaszewski@gmail.com>
Cc:     Dan Murphy <dmurphy@ti.com>, robh+dt@kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        lee.jones@linaro.org, linux-omap@vger.kernel.org,
        linux-leds@vger.kernel.org
Subject: Re: [PATCH v7 1/6] dt-bindings: ti-lmu: Remove LM3697
Message-ID: <20180914214220.GA2081@amd>
References: <20180911170825.17789-1-dmurphy@ti.com>
 <20180911170825.17789-2-dmurphy@ti.com>
 <20180911200530.GA28290@amd>
 <85ab3bf4-21d4-dda9-a7c8-5ed68f15c611@ti.com>
 <20180912214938.GA30654@amd>
 <7950fa32-c8f9-52bb-06b0-0c1cc93b6bc9@ti.com>
 <20180914081822.GA21830@amd>
 <9c14ee7c-f172-bb0c-d9a8-8aeee408f716@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="G4iJoqBmSsgzjUCe"
Content-Disposition: inline
In-Reply-To: <9c14ee7c-f172-bb0c-d9a8-8aeee408f716@gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--G4iJoqBmSsgzjUCe
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> > You may want to learn more about device tree and/or talk to the device
> > tree maintainers. This is an old article. https://lwn.net/Articles/5614=
62/
>=20
> The article title is "Device trees as ABI". A device tree is defined
> in the "*.dts" file that is then compiled to a dtb blob, which
> constitutes the ABI. And this ABI should be kept backwards compatible.
>=20
> What is discussed here is a documentation of bindings, i.e. according
> to ePAPR: "requirements for how specific types and classes of devices
> are represented in the device tree".
>=20
> >From the bindings documented in the
> Documentation/devicetree/bindings/mfd/ti-lmu.txt only
> ti,lm3532-backlight is used in the mainline dts file
> (arch/arm/boot/dts/omap4-droid4-xt894.dts).
>=20
> Having the above it seems that there is no risk of breaking any
> users.

DTBs and bindings are supposed to be portable between operating
systems. You are right there are no _mainline_ _Linux_ users.

> > NAK on this patch. I see that this binding has problems, but
> > introducing different binding for subset of devices is _not_ a fix.
> >=20
> >>> What about the multi function devices? They should have same binding.
> >>
> >> The MFD devices defined are not in contention here only the SFD.
> >=20
> > I'd like to see common solutions for SFD and MFD, as the hardware is
> > similar, and that includes the code. Having code that is easier to
> > maintain is important, and having many drivers are harder to maintain
> > than one driver.
> >=20
> > Milo's code looks better than yours in that regard. I disagree about
> > Milo's code being "nightmare" to modify, and care about "easy to
> > maintain" more than "binary size".
>=20
> Easy to maintain will be a dedicated LED class driver.

You mean, 3 dedicated LED class drivers and 3 MFD drivers with LED
parts? We'll need complex driver anyway, and I'd really like to have
just one.

								Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--G4iJoqBmSsgzjUCe
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlucKzwACgkQMOfwapXb+vKGhACfYFjlT+injDg6vImcqfgqAGzY
aPYAoKPf+IRKyxKe+WsnjSmayJNR38cU
=4BH5
-----END PGP SIGNATURE-----

--G4iJoqBmSsgzjUCe--
