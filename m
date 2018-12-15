Return-Path: <SRS0=+3zQ=OY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BBB2C43387
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Dec 2018 09:47:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 36E4A2084D
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Dec 2018 09:47:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730036AbeLOJrZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 15 Dec 2018 04:47:25 -0500
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:45296 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728731AbeLOJrZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Dec 2018 04:47:25 -0500
Received: by atrey.karlin.mff.cuni.cz (Postfix, from userid 512)
        id 2937580913; Sat, 15 Dec 2018 10:47:19 +0100 (CET)
Date:   Sat, 15 Dec 2018 10:47:22 +0100
From:   Pavel Machek <pavel@ucw.cz>
To:     Vojtech Pavlik <vojtech@suse.cz>
Cc:     kernel list <linux-kernel@vger.kernel.org>, jikos@suse.cz,
        linux-input@vger.kernel.org, dmitry.torokhov@gmail.com
Subject: Re: [rfd] saving old mice -- button glitching/debouncing
Message-ID: <20181215094722.GA5804@amd>
References: <20181214232437.GA8310@amd>
 <20181215085510.GB12930@suse.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="pWyiEgJYm5f9v55/"
Content-Disposition: inline
In-Reply-To: <20181215085510.GB12930@suse.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--pWyiEgJYm5f9v55/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> > Patch is obviously not ready; but:
> >=20
> > a) would it be useful to people
>=20
> Probably not.
>=20
> Mice already do internal software/hardware debouncing on switches. If you
> see duplicate clicks making it all the way to the kernel driver, something
> is very wrong with the switch, to the point where it'll soon fail
> completely.

It seems mice normally survive 2 years under my use. This one has left
button repaired and middle button failing... If debouncing gives it
one more year, it will be success...

> > b) would it be acceptable if done properly? (cmd line option to
> > enable, avoiding duplicate/wrong events?)
>=20
> Well, for one, you shouldn't be using a timer, all the debouncing can be
> done by math on the event timestamps.

Not... really, right? You need to send an release some time after
button indicates release if bounce did not happen. It is similar to
autorepeat needing a timer.

Let me gain some experience with the patch. I don't think hardware
does as heavy debouncing as you describe.

Best regards,
								=09
									Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--pWyiEgJYm5f9v55/
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlwUzaoACgkQMOfwapXb+vKp9wCgwJowBaO003wnM519XYW0uBW0
4h0An1zQelskdUkoRGIrsQXR1Qg06TwI
=4Co/
-----END PGP SIGNATURE-----

--pWyiEgJYm5f9v55/--
