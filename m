Return-Path: <SRS0=cgxA=JU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CD5CC3279B
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 18:19:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 41D4923F4B
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 18:19:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 41D4923F4B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ucw.cz
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752839AbeGDSTX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Jul 2018 14:19:23 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:39987 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752565AbeGDSTV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jul 2018 14:19:21 -0400
Received: by atrey.karlin.mff.cuni.cz (Postfix, from userid 512)
        id 762F1804FE; Wed,  4 Jul 2018 20:19:20 +0200 (CEST)
Date:   Wed, 4 Jul 2018 20:19:16 +0200
From:   Pavel Machek <pavel@ucw.cz>
To:     Willy Tarreau <w@1wt.eu>
Cc:     Andreas Klinger <ak@it-klinger.de>, jacek.anaszewski@gmail.com,
        ben.whitten@gmail.com, geert+renesas@glider.be,
        pombredanne@nexb.com, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org, linux-leds@vger.kernel.org
Subject: Re: [PATCH v2] leds: ledtrig-morse: send out morse code
Message-ID: <20180704181916.GA10785@amd>
References: <20180703155328.GA18299@arbeit>
 <20180704065305.GA23509@amd>
 <20180704073443.GA9388@1wt.eu>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="fUYQa+Pmc3FrFX/N"
Content-Disposition: inline
In-Reply-To: <20180704073443.GA9388@1wt.eu>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--fUYQa+Pmc3FrFX/N
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> On Wed, Jul 04, 2018 at 08:53:05AM +0200, Pavel Machek wrote:
> > As I stated before, I don't think morse encoder belongs in kernel.
>=20
> On the opposite, I think that the kernel needs to be a bit more autonomous
> when it comes to reporting its own issues. Being able to report a panic
> when userland cannot be accessed for example is the reason why we've seen
> various features such as blinking keyboard LEDs for this.

Being able to report panics by blinking would be nice... but proposed
patch does NOT do that.

> > LED pattern trigger should be merged, instead.
>=20
> Well, just like we have LED and LED triggers in the kernel, I think having
> a generic way to use patterns could be nice and in this case Morse could =
be
> one such pattern, but if that means it's limited to userland to configure
> it then it sadly voids all of its benefits.

Proposed patch is already limited to configuration from userland... so
it does not have any benefits.

If special "panic blinking" mode is wanted -- I guess that would make
sense.

But

a) trigger may not be right infrastructure for that; triggers need
quite a lot kernel to be working, as they run in separate threads --
panic blinking probably should be mdelay / brightness set / mdelay,
and probably limited to LEDs that can be accessed without sleeping.

b) we may want trigger to be used for something else (Caps lock? HDD
activity?)  when not panicked. Thus, again, trigger is not exactly
suitable. (It might make sense to blink many/all LEDs simultaneously
to make it super obvious to the user).

									Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--fUYQa+Pmc3FrFX/N
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAls9D6QACgkQMOfwapXb+vJBBQCgnDtU7XYmFul7TKOT2pU99SNY
01gAoJn7YYvvoYh0eCxrS+AEOFQOjHR4
=rhKO
-----END PGP SIGNATURE-----

--fUYQa+Pmc3FrFX/N--
