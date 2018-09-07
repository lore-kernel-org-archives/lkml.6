Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC432C4321E
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 07:34:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7F8A22075E
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 07:34:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7F8A22075E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ucw.cz
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727783AbeIGMOI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 08:14:08 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:45261 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725987AbeIGMOI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 08:14:08 -0400
Received: by atrey.karlin.mff.cuni.cz (Postfix, from userid 512)
        id 3DB068057A; Fri,  7 Sep 2018 09:34:28 +0200 (CEST)
Date:   Fri, 7 Sep 2018 09:34:27 +0200
From:   Pavel Machek <pavel@ucw.cz>
To:     Jacek Anaszewski <jacek.anaszewski@gmail.com>
Cc:     bjorn.andersson@linaro.org, Baolin Wang <baolin.wang@linaro.org>,
        rteysseyre@gmail.com, broonie@kernel.org, linus.walleij@linaro.org,
        linux-leds@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7 1/2] leds: core: Introduce LED pattern trigger
Message-ID: <20180907073427.GA21515@amd>
References: <e6d4e7be537a4e4d6fce26c6d446703b1910eab9.1535700092.git.baolin.wang@linaro.org>
 <ef266d4a-ba0e-cba6-ae30-ebbf730e28a2@gmail.com>
 <20180903215323.GA21489@amd>
 <e6cf7c2d-917a-b05f-178c-012c6b4161cf@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="4Ckj6UjgE2iN1+kY"
Content-Disposition: inline
In-Reply-To: <e6cf7c2d-917a-b05f-178c-012c6b4161cf@gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--4Ckj6UjgE2iN1+kY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> +What:		/sys/class/leds/<led>/hw_pattern
> +Date:		September 2018
> +KernelVersion:	4.20
> +Description:
> +		Specify a hardware pattern for the SC27XX LED. For the SC27XX
> +		LED controller, it only supports 4 hardware patterns to configure
> +		the low time, rise time, high time and fall time for the breathing
> +		mode, and each stage duration unit is 125ms. So the format of
> +		the hardware pattern values should be:
> +		"brightness_1 duration_1 brightness_2 duration_2 brightness_3
> +		duration_3 brightness_4 duration_4".
>=20
> In this case low time and high time can be easily described with
> use of the proposed [brightness delta_t] tuples. It is not equally
> obvious in case of rise time and fall time.
>=20
> I can imagine hw pattern that would require defining blink rate
> over period of time, or blink rate during rise/fall time - in the
> latter case we would have odd number of pattern components. Probably
> it wouldn't be a big deal, we'd need one "padding" value, but still
> there's room for improvement IMHO.

Well, you can describe blinking while rising, it is just going to be
awkward as you'll need to give precise times/brightnesses for each
blinking, and pattern will become long.

I'm sure some hardware can do that (the led in N900 can compute prime
numbers, it can blink while changing brightness, too).

OTOH people tend to use pretty simple patterns on their LEDs, so we
should be fine.

									Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--4Ckj6UjgE2iN1+kY
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAluSKgMACgkQMOfwapXb+vJHZQCdHkw3PCEI++F00tF072ZG8acW
FmYAn1+4tte5d45a2/fz/fl+ExAUNs9x
=sKiP
-----END PGP SIGNATURE-----

--4Ckj6UjgE2iN1+kY--
