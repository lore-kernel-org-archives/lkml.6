Return-Path: <SRS0=PZ5q=MW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D23EAC43610
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 16:00:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A34732086E
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 16:00:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A34732086E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ucw.cz
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727051AbeJJXXk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Oct 2018 19:23:40 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:55659 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726479AbeJJXXj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Oct 2018 19:23:39 -0400
Received: by atrey.karlin.mff.cuni.cz (Postfix, from userid 512)
        id 8CEE7807D6; Wed, 10 Oct 2018 18:00:48 +0200 (CEST)
Date:   Wed, 10 Oct 2018 18:00:48 +0200
From:   Pavel Machek <pavel@ucw.cz>
To:     Jacek Anaszewski <jacek.anaszewski@gmail.com>
Cc:     Baolin Wang <baolin.wang@linaro.org>, rteysseyre@gmail.com,
        bjorn.andersson@linaro.org, broonie@kernel.org,
        linux-leds@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v14 1/2] leds: core: Introduce LED pattern trigger
Message-ID: <20181010160041.GA22121@amd>
References: <c3a6f08ac978c309bb0b002a0384c4f0ad0f59cd.1538494476.git.baolin.wang@linaro.org>
 <9bf6236e-83af-7156-b26b-7d88ece2d81e@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="pvezYHf7grwyp3Bc"
Content-Disposition: inline
In-Reply-To: <9bf6236e-83af-7156-b26b-7d88ece2d81e@gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--pvezYHf7grwyp3Bc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

[Oops. I wrote this but forgot to send it? Anyway.. I guess it is
redundant now.]

> > +++ b/Documentation/ABI/testing/sysfs-class-led-trigger-pattern
> > @@ -0,0 +1,76 @@
> > +What:		/sys/class/leds/<led>/pattern
> > +Date:		September 2018
> > +KernelVersion:	4.20
> > +Description:
> > +		Specify a software pattern for the LED, that supports altering
> > +		the brightness for the specified duration with one software
> > +		timer. It can do gradual dimming and constant brightness.
> > +
> > +		The pattern is given by a series of tuples, of brightness and
> > +		duration (ms). The LED is expected to traverse the series and
> > +		each brightness value for the specified duration. Duration of
> > +		0 means brightness should immediately change to new value.
> > +
> > +		1. When doing gradual dimming, the led brightness will be updated
> > +		every 50 milliseconds, so the duration of each step should not
> > +		less than 50 milliseconds.
>=20
> I'd like to avoid this constraint. Lowest supported delta_t should be 1.
>=20
> We should only prevent entering dimming mode if current delta_t
> is lower than UPDATE_INTERVAL.

I agree that documenting it like this is strange. I don't think this
should be part of ABI as we may want to adjust it in the future.

> I also propose to make the dimming interval configurable via sysfs
> dimming_interval file.

I believe we should provide "right" dimming_interval. 50msec sounds
good. If we find it is too low / too high, we might want to adjust it.

If we find out that different users need different values, I guess we
can still add "dimming_interval" knob, but I'd suggest waiting until
such need arises.

[Now, I don't have strong feelings here, and patch would probably be
okay with me even if it has dimming_interval, but I'd prefer to keep
it simple. We are at v14 of the patch...]

Thanks,
									Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--pvezYHf7grwyp3Bc
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlu+IjAACgkQMOfwapXb+vJKGACgsHAAydYbN5GADkbD3KjEsy91
qKIAn3vRLOcAeeemxCOYBEwNIcLUlrIG
=Y0m2
-----END PGP SIGNATURE-----

--pvezYHf7grwyp3Bc--
