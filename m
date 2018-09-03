Return-Path: <SRS0=G629=LR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FB18C43334
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 21:53:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B487B20862
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 21:53:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B487B20862
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ucw.cz
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727501AbeIDCPc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Sep 2018 22:15:32 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:40648 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726183AbeIDCPc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Sep 2018 22:15:32 -0400
Received: by atrey.karlin.mff.cuni.cz (Postfix, from userid 512)
        id B0B5280642; Mon,  3 Sep 2018 23:53:23 +0200 (CEST)
Date:   Mon, 3 Sep 2018 23:53:23 +0200
From:   Pavel Machek <pavel@ucw.cz>
To:     Jacek Anaszewski <jacek.anaszewski@gmail.com>
Cc:     bjorn.andersson@linaro.org, Baolin Wang <baolin.wang@linaro.org>,
        rteysseyre@gmail.com, broonie@kernel.org, linus.walleij@linaro.org,
        linux-leds@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7 1/2] leds: core: Introduce LED pattern trigger
Message-ID: <20180903215323.GA21489@amd>
References: <e6d4e7be537a4e4d6fce26c6d446703b1910eab9.1535700092.git.baolin.wang@linaro.org>
 <ef266d4a-ba0e-cba6-ae30-ebbf730e28a2@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="LZvS9be/3tNcYl/X"
Content-Disposition: inline
In-Reply-To: <ef266d4a-ba0e-cba6-ae30-ebbf730e28a2@gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--LZvS9be/3tNcYl/X
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> > +static int pattern_trig_start_pattern(struct led_classdev *led_cdev)
> > +{
> > +	struct pattern_trig_data *data =3D led_cdev->trigger_data;
> > +
> > +	if (!data->npatterns)
> > +		return 0;
> > +
> > +	if (data->is_hw_pattern) {
> > +		return led_cdev->pattern_set(led_cdev, data->patterns,
> > +					     data->npatterns, data->repeat);
> > +	}
>=20
> I have doubts here if it is a good idea to enforce array of tuples
> as a generic interface for all hw_patterns. It may not fit well for
> every hw pattern engine. It seems that the only feasible solution will
> be allowing drivers to come up with their own interfaces, i.e. the
> approach you proposed at first for your driver. It seems that the
> ledtrig-pattern with software pattern mechanism will be just
> a nice side effect of this series :-)
>=20
> Unless someone will propose a better solution.

I believe array of tuples will work for everyone. It is just a LED, it
can change intensity over time.

> We need a broader consensus here. I'd like to hear Pavel's opinion,
> since he's been always in favor of common pattern interface, and
> inspired this work.

I believe Baolin did good work here. I believe it will cover most, if
not all, hardware engines out there. I think we should merge it, and
see what happens -- it should be good enough.

(Yes, there's still more work to do, but that will be stuff like RGB
LED synchronization.)

(And yes, one of the LED chip has pattern engine that can compute
prime numbers on its own. I don't expect to support
_that_. Fortunately, nobody but me is likely to want that pattern, so
we are still okay :-)=20

https://gitlab.com/tui/tui/blob/master/ofone/tests.notcc/primes.nc

)
									Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--LZvS9be/3tNcYl/X
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAluNrVMACgkQMOfwapXb+vJ5fgCfZH6qXX2O1Uaq4FdANEL8rNhR
BdcAn0Q95ZTd5C2NKYMwtmkOQWSzc+Lg
=7xnK
-----END PGP SIGNATURE-----

--LZvS9be/3tNcYl/X--
