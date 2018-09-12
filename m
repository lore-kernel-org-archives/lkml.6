Return-Path: <SRS0=BZo9=L2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10B5BC070C3
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 20:42:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A15DB2146F
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 20:41:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A15DB2146F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ucw.cz
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728320AbeIMBsM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Sep 2018 21:48:12 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:43373 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726239AbeIMBsM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Sep 2018 21:48:12 -0400
Received: by atrey.karlin.mff.cuni.cz (Postfix, from userid 512)
        id 4075E806C7; Wed, 12 Sep 2018 22:41:55 +0200 (CEST)
Date:   Wed, 12 Sep 2018 22:41:56 +0200
From:   Pavel Machek <pavel@ucw.cz>
To:     Jacek Anaszewski <jacek.anaszewski@gmail.com>
Cc:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Baolin Wang <baolin.wang@linaro.org>, rteysseyre@gmail.com,
        broonie@kernel.org, linus.walleij@linaro.org,
        linux-leds@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v8 1/2] leds: core: Introduce LED pattern trigger
Message-ID: <20180912204156.GA15541@amd>
References: <5a502ec29251c019ddad8f3314ab45fc0f6feaf7.1536027873.git.baolin.wang@linaro.org>
 <20180908050208.GY2523@minitux>
 <20180910211935.GA4697@amd>
 <dd1f8dd2-d577-ab12-e67a-7ed71459055a@gmail.com>
 <20180912191820.GA27704@amd>
 <a82e3d9c-1df8-9e73-7371-613ad550693d@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="5mCyUwZo2JvN/JJP"
Content-Disposition: inline
In-Reply-To: <a82e3d9c-1df8-9e73-7371-613ad550693d@gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--5mCyUwZo2JvN/JJP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> >>> No, we are not back to full circle.
> >>>
> >>> Or at least we should not be.
> >>>
> >>> Yes, hw_pattern can have some limitation pattern does not, but if you
> >>> take values from hw_pattern file and put them into pattern file, you
> >>> should get the same pattern (with more power being consumed). And that
> >>> property is kind of important for me, because it should keep the ABI
> >>> reasonable.
> >>
> >> If you looked at what we agreed on with Baolin, you'd realize
> >> that this property is in no way preserved.
> >> This is what the whole story is about - we're introducing hw_pattern
> >> because of difficulties in describing breathing pattern by a series
> >> of [brightness delta_t] tuples.
> >>
> >> And Bjorn presented another example. I'm inclined to leave the
> >> definition of hw_pattern semantics to the LED class drivers,
> >> and allow them to create related sysfs files.
> >=20
> > Please lets not do that.
> >=20
> > We already have drivers that do that and it is complete
> > nightmare. Some take binary code for the tiny CPU driving the LED.
> >=20
> > What exactly is the problem? [brightness delta_t] can describe
>=20
> You wrote:
>=20
> <quote>
> Yes, hw_pattern can have some limitation pattern does not, but if you
> take values from hw_pattern file and put them into pattern file, you
> should get the same pattern (with more power being consumed).
> </quote>
>=20
> The problem is that we decided to introduce hw_pattern to
> to take away from drivers a responsibility for translating
> a series of tuples, approximating the brightness curve,
> to the values that can be written to the hardware registers.
>=20
> Because this is what would need to be done to check if hw can support
> given series of tuples and activate it. Actually with this approach
> we wouldn't need hw_pattern at all, since pattern alone would do.
> But implementation thereof is what we could call a nightmare.
>=20
> What follows, your claim from the quotation is inaccurate:
> values from hw_pattern written to the pattern file will not
> produce the same pattern, at least in case of what was proposed
> in [0] for drivers/leds/leds-sc27xx-bltc.c.

That sounds easy, see below.

> > anything single LED can do in finite time. You are right, that
> > [brightness delta_t] sequence may get rather long, and it may be hard
> > to turn that sequence into parameters. Are there any _interesting_
> > sequences hardware can do but [brightness delta_t] can not store
> > reasonably?
>=20
> Please propose the implementation of pattern_set for
> drivers/leds/leds-sc27xx-bltc.c breathing pattern, that will
> setup breathing mode basing on the values from tuples.
>=20
> Use Baolin's patch [0] for a reference of what hardware expects.
>=20
> [0] https://lore.kernel.org/patchwork/patch/984246/

Yep, so we change documentation to require

0 rise_duration brightness high_duration brightness fall_duration 0 low_dur=
ation"

=2E..and we are done; at least as long as user writes expected pattern
to the file.

I'd actually like to see this at begining of function:
    if (pattern[0].brightness !=3D 0)
        return -EINVAL;
    if (pattern[2].brightness !=3D 0)
        return -EINVAL;
    if (pattern[3].brightness !=3D 0)
        return -EINVAL;
    if (pattern[1].brightness !=3D pattern[2].brightness)
        return -EINVAL;

=2E.so if user writes something unexpected, he gets the error back.

What am I missing?

Thanks,
									Pavel   =20
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--5mCyUwZo2JvN/JJP
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAluZehQACgkQMOfwapXb+vKiPgCfTofT1+7e7qBdm6jFdMVMITUx
nvoAn2cHlCQj2u+k/NTwlB+9xRx9GRsA
=4/Z0
-----END PGP SIGNATURE-----

--5mCyUwZo2JvN/JJP--
