Return-Path: <SRS0=BZo9=L2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66864C070C3
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 19:18:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 26CE22146D
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 19:18:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 26CE22146D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ucw.cz
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728215AbeIMAYU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Sep 2018 20:24:20 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:41431 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728014AbeIMAYU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Sep 2018 20:24:20 -0400
Received: by atrey.karlin.mff.cuni.cz (Postfix, from userid 512)
        id EF418806C7; Wed, 12 Sep 2018 21:18:20 +0200 (CEST)
Date:   Wed, 12 Sep 2018 21:18:20 +0200
From:   Pavel Machek <pavel@ucw.cz>
To:     Jacek Anaszewski <jacek.anaszewski@gmail.com>
Cc:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Baolin Wang <baolin.wang@linaro.org>, rteysseyre@gmail.com,
        broonie@kernel.org, linus.walleij@linaro.org,
        linux-leds@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v8 1/2] leds: core: Introduce LED pattern trigger
Message-ID: <20180912191820.GA27704@amd>
References: <5a502ec29251c019ddad8f3314ab45fc0f6feaf7.1536027873.git.baolin.wang@linaro.org>
 <20180908050208.GY2523@minitux>
 <20180910211935.GA4697@amd>
 <dd1f8dd2-d577-ab12-e67a-7ed71459055a@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="2fHTh5uZTiUOsy+g"
Content-Disposition: inline
In-Reply-To: <dd1f8dd2-d577-ab12-e67a-7ed71459055a@gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--2fHTh5uZTiUOsy+g
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> >>> diff --git a/Documentation/ABI/testing/sysfs-class-led-trigger-patter=
n b/Documentation/ABI/testing/sysfs-class-led-trigger-pattern
> >> [..]
> >>> +What:		/sys/class/leds/<led>/hw_pattern
> >>> +Date:		September 2018
> >>> +KernelVersion:	4.20
> >>> +Description:
> >>> +		Specify a hardware pattern for the LED, for LED hardware that
> >>> +		supports autonomously controlling brightness over time, according
> >>> +		to some preprogrammed hardware patterns.
> >>> +
> >>> +		Since different LED hardware can have different semantics of
> >>> +		hardware patterns, each driver is expected to provide its own
> >>> +		description for the hardware patterns in their ABI documentation
> >>> +		file.
> >>> +
> >>
> >> So, after a full circle we're back at drivers with support for hardware
> >> patterns should have their own ABI for setting that pattern.
> >>
> >> The controls for my hardware is:
> >> * a list of brightness values
> >> * the rate of the pattern
> >> * a flag to indicate that the pattern should be played from start
> >>   to end, end to start or start to end to start
> >> * a boolean indicating if the pattern should be played once or repeated
> >>   indefinitely.
> >=20
> > No, we are not back to full circle.
> >=20
> > Or at least we should not be.
> >=20
> > Yes, hw_pattern can have some limitation pattern does not, but if you
> > take values from hw_pattern file and put them into pattern file, you
> > should get the same pattern (with more power being consumed). And that
> > property is kind of important for me, because it should keep the ABI
> > reasonable.
>=20
> If you looked at what we agreed on with Baolin, you'd realize
> that this property is in no way preserved.
> This is what the whole story is about - we're introducing hw_pattern
> because of difficulties in describing breathing pattern by a series
> of [brightness delta_t] tuples.
>=20
> And Bjorn presented another example. I'm inclined to leave the
> definition of hw_pattern semantics to the LED class drivers,
> and allow them to create related sysfs files.

Please lets not do that.

We already have drivers that do that and it is complete
nightmare. Some take binary code for the tiny CPU driving the LED.

What exactly is the problem? [brightness delta_t] can describe
anything single LED can do in finite time. You are right, that
[brightness delta_t] sequence may get rather long, and it may be hard
to turn that sequence into parameters. Are there any _interesting_
sequences hardware can do but [brightness delta_t] can not store
reasonably?

Thanks,
									Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--2fHTh5uZTiUOsy+g
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAluZZnwACgkQMOfwapXb+vKk4ACfeuiIz9zul593vxA5PPJRklQ7
04wAn3mbOGBFjJoVrINshnq/FECRY26v
=EOK8
-----END PGP SIGNATURE-----

--2fHTh5uZTiUOsy+g--
