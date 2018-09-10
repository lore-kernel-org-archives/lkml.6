Return-Path: <SRS0=FvrY=LY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B48FAC433F5
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 21:19:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6D5A620855
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 21:19:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6D5A620855
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ucw.cz
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726980AbeIKCPf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Sep 2018 22:15:35 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:38801 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726141AbeIKCPf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Sep 2018 22:15:35 -0400
Received: by atrey.karlin.mff.cuni.cz (Postfix, from userid 512)
        id AFFBA8057B; Mon, 10 Sep 2018 23:19:35 +0200 (CEST)
Date:   Mon, 10 Sep 2018 23:19:35 +0200
From:   Pavel Machek <pavel@ucw.cz>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Baolin Wang <baolin.wang@linaro.org>, jacek.anaszewski@gmail.com,
        rteysseyre@gmail.com, broonie@kernel.org, linus.walleij@linaro.org,
        linux-leds@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v8 1/2] leds: core: Introduce LED pattern trigger
Message-ID: <20180910211935.GA4697@amd>
References: <5a502ec29251c019ddad8f3314ab45fc0f6feaf7.1536027873.git.baolin.wang@linaro.org>
 <20180908050208.GY2523@minitux>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="cNdxnHkX5QqsyA0e"
Content-Disposition: inline
In-Reply-To: <20180908050208.GY2523@minitux>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--cNdxnHkX5QqsyA0e
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri 2018-09-07 22:02:08, Bjorn Andersson wrote:
> On Tue 04 Sep 04:01 PDT 2018, Baolin Wang wrote:
>=20
> > diff --git a/Documentation/ABI/testing/sysfs-class-led-trigger-pattern =
b/Documentation/ABI/testing/sysfs-class-led-trigger-pattern
> [..]
> > +What:		/sys/class/leds/<led>/hw_pattern
> > +Date:		September 2018
> > +KernelVersion:	4.20
> > +Description:
> > +		Specify a hardware pattern for the LED, for LED hardware that
> > +		supports autonomously controlling brightness over time, according
> > +		to some preprogrammed hardware patterns.
> > +
> > +		Since different LED hardware can have different semantics of
> > +		hardware patterns, each driver is expected to provide its own
> > +		description for the hardware patterns in their ABI documentation
> > +		file.
> > +
>=20
> So, after a full circle we're back at drivers with support for hardware
> patterns should have their own ABI for setting that pattern.
>=20
> The controls for my hardware is:
> * a list of brightness values
> * the rate of the pattern
> * a flag to indicate that the pattern should be played from start
>   to end, end to start or start to end to start
> * a boolean indicating if the pattern should be played once or repeated
>   indefinitely.

No, we are not back to full circle.

Or at least we should not be.

Yes, hw_pattern can have some limitation pattern does not, but if you
take values from hw_pattern file and put them into pattern file, you
should get the same pattern (with more power being consumed). And that
property is kind of important for me, because it should keep the ABI
reasonable.


> > +What:		/sys/class/leds/<led>/repeat
> > +Date:		September 2018
> > +KernelVersion:	4.20
> > +Description:
> > +		Specify a pattern repeat number. 0 means repeat indefinitely.
> > +
> > +		This file will always return the originally written repeat
> > +		number.
>=20
> I'm still convinced that this will confuse our users and to me it would
> be more logical if this denotes the number of times the pattern should
> be repeated, with e.g. negative numbers denoting infinite.
>=20
> In particular I expect to have to explain why my driver expects that you
> write 0 in the file named "repeat" to make it repeat and 1 to make it
> not repeat.

Ok, -1 works for me :-).

Thanks,
									Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--cNdxnHkX5QqsyA0e
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAluW3+cACgkQMOfwapXb+vLfhwCggPzf4UFQRwlNmyNbpUNg9TBI
iKUAoK+ksS0tKjEMqCfLrnqXN2kn847m
=S0ab
-----END PGP SIGNATURE-----

--cNdxnHkX5QqsyA0e--
