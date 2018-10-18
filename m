Return-Path: <SRS0=Z5ET=M6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 847C5C67863
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 22:10:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3331D20866
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 22:10:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3331D20866
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ucw.cz
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726867AbeJSGNy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Oct 2018 02:13:54 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:56462 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725738AbeJSGNy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Oct 2018 02:13:54 -0400
Received: by atrey.karlin.mff.cuni.cz (Postfix, from userid 512)
        id 43CD780906; Fri, 19 Oct 2018 00:10:48 +0200 (CEST)
Date:   Fri, 19 Oct 2018 00:10:48 +0200
From:   Pavel Machek <pavel@ucw.cz>
To:     Dan Murphy <dmurphy@ti.com>
Cc:     Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        Rob Herring <robh@kernel.org>,
        Lee Jones <lee.jones@linaro.org>,
        Tony Lindgren <tony@atomide.com>, devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Linux LED Subsystem <linux-leds@vger.kernel.org>
Subject: Re: [PATCH v3 2/9] dt-bindings: ti-lmu: Remove LM3697
Message-ID: <20181018221048.GA6364@amd>
References: <4fcb91c7-b2b2-798d-8a41-fa1b475086e0@ti.com>
 <8c1559e1-b703-4c98-8bd9-7c9993bd59f5@gmail.com>
 <20181012162619.GA28573@bogus>
 <20181012180312.GB5565@amd>
 <60cc9238-aba2-aa6a-64a4-2b5e20835549@gmail.com>
 <CAL_Jsq+Yspr_iNP1eYanvtmiuMf-xNEZ0suDH3tQayV=V5r5=g@mail.gmail.com>
 <73647af4-0258-49a9-d9b6-eeef7e7813dc@gmail.com>
 <5c7f03cc-4d45-6010-523d-46721c218731@ti.com>
 <20181015214512.GA2001@amd>
 <aa401333-9650-c925-2085-6e6d17b576bd@ti.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="Kj7319i9nmIyA2yE"
Content-Disposition: inline
In-Reply-To: <aa401333-9650-c925-2085-6e6d17b576bd@ti.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--Kj7319i9nmIyA2yE
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> >>>> Given this one seems to have not really been finished, it's probably
> >>>> okay to make changes in this case. Still, it would be good to see
> >>>> patches structured so that it's obvious we're breaking things. But h=
ow
> >>>> the patches are structured doesn't matter until there's some agreeme=
nt
> >>>> on the end result.
> >>>
> >>> OK, so if I'm getting it right, the correct patch structure in this c=
ase
> >>> means that changes removing bindings from MFD and moving them along
> >>> with the modifications to the LED subsystem should be placed in a sin=
gle
> >>> patch.
> >>>
> >>> Dan, could you please arrange the next patch set version accordingly?
> >>
> >> Yes I can squash the DT bindings patches and call it a "move and modif=
y"
> >=20
> > You can do move without problems. But if you plan to modify them,
> > please try to change as little as possible, make it separate patch and
> > explain why new version is better than old one.
> >=20
>=20
> I have been thinking of how to do this.  Since the 2 devices are part of =
the current
> binding there really is not a way to move them.  Since there are still MF=
D capable
> devices available.
>=20
> I would still need to remove the current active binding and create a new =
binding in the LED
> bindings directory.
>=20
> I would have to remove and create in the same patch.

Yeah, and this all is a sign that you should just keep the current
binding, and make your code use it, see?

You are free to use Sebastian's updated binding. It has "suggested by:
Rob" or something like that on it, so it should be fine.

You can add note to bindings/leds pointing to mfd binding.

Now... this is what I've suggested before. If you don't agree, you may
want to contact Tony Lindgren, IIRC he works for TI, too, and might be
willing to help.

Thank you,
									Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--Kj7319i9nmIyA2yE
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlvJBOgACgkQMOfwapXb+vK14QCgtVl9pa/1OxjqylTQJZ5qJ0bm
ihgAnRt5xkqAWZuKzr385+l6umkgYMS4
=0x8R
-----END PGP SIGNATURE-----

--Kj7319i9nmIyA2yE--
