Return-Path: <SRS0=6SfI=LH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9ED0EC433F5
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Aug 2018 20:12:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 526D821529
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Aug 2018 20:12:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 526D821529
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ucw.cz
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727557AbeHXXsk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Aug 2018 19:48:40 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:53219 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726675AbeHXXsj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Aug 2018 19:48:39 -0400
Received: by atrey.karlin.mff.cuni.cz (Postfix, from userid 512)
        id BC2BD83F58; Fri, 24 Aug 2018 22:12:30 +0200 (CEST)
Date:   Fri, 24 Aug 2018 22:12:27 +0200
From:   Pavel Machek <pavel@ucw.cz>
To:     Jacek Anaszewski <jacek.anaszewski@gmail.com>
Cc:     Baolin Wang <baolin.wang@linaro.org>, rteysseyre@gmail.com,
        bjorn.andersson@linaro.org, broonie@kernel.org,
        linux-leds@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 1/2] leds: core: Introduce LED pattern trigger
Message-ID: <20180824201227.GB17146@amd>
References: <1dc5d394324b2bf1ffe229b8e42691fab6d749e0.1533556992.git.baolin.wang@linaro.org>
 <c18fd41f-831c-ab74-57e5-d4151f4b47cc@gmail.com>
 <20180824101145.GA1510@amd>
 <9bb7ac19-36a6-d11a-6d46-fc65c2026201@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="p2kqVDKq5asng8Dg"
Content-Disposition: inline
In-Reply-To: <9bb7ac19-36a6-d11a-6d46-fc65c2026201@gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--p2kqVDKq5asng8Dg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri 2018-08-24 21:49:50, Jacek Anaszewski wrote:
> Hi Pavel,
>=20
> On 08/24/2018 12:11 PM, Pavel Machek wrote:
> > Hi!
> >=20
> >> I think that it would be more flexible if software pattern fallback
> >> was applied in case of pattern_set failure. Otherwise, it would
> >> lead to the situation where LED class devices that support hardware
> >> blinking couldn't be applied the same set of patterns as LED class
> >> devices that don't implement pattern_set. The latter will always have =
to
> >> resort to using software pattern engine which will accept far greater
> >> amount of pattern combinations.
> >>
> >> In this case we need to discuss on what basis the decision will be
> >> made on whether hardware or software engine will be used.
> >>
> >> Possible options coming to mind:
> >> - an interface will be provided to determine max difference between
> >>   the settings supported by the hardware and the settings requested by
> >>   the user, that will result in aligning user's setting to the hardware
> >>   capabilities
> >> - the above alignment rate will be predefined instead
> >> - hardware engine will be used only if user requests supported settings
> >>   on the whole span of the requested pattern
> >> - in each of the above cases it would be worth to think of the
> >>   interface to show the scope of the settings supported by hardware
> >=20
> > I'd recommend keeping it simple. We use hardware engine if driver
> > author thinks pattern is "close enough".
>=20
> The thing is that in the ledtrig-pattern v5 implementation there
> is no option of using software fallback if pattern_set op
> is initialized:
>=20
> +	if (led_cdev->pattern_set) {
> +		return led_cdev->pattern_set(led_cdev, data->patterns,
> +					     data->npatterns, data->repeat);
> +	}

Yeah, that sounds wrong. (Sorry I did not pay enough attention).

It pattern_set() returns special error code, it should just continue
and use software pattern fallback.
									Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--p2kqVDKq5asng8Dg
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAluAZqsACgkQMOfwapXb+vL6qACfUF2J7US+MKxUh5rbg3o0Pz2L
w8EAnjdHFhPzPYHAXmpCrKfW4jdnOlLp
=XQ6Y
-----END PGP SIGNATURE-----

--p2kqVDKq5asng8Dg--
