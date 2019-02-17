Return-Path: <SRS0=Aihr=QY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0E8CC43381
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Feb 2019 00:09:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 71701206A3
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Feb 2019 00:09:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727893AbfBQAIz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 16 Feb 2019 19:08:55 -0500
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:58409 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726386AbfBQAIy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Feb 2019 19:08:54 -0500
Received: by atrey.karlin.mff.cuni.cz (Postfix, from userid 512)
        id C3256804E6; Sun, 17 Feb 2019 01:08:44 +0100 (CET)
Date:   Sun, 17 Feb 2019 01:08:51 +0100
From:   Pavel Machek <pavel@ucw.cz>
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        Yauhen Kharuzhy <jekhor@gmail.com>,
        linux-kernel@vger.kernel.org, linux-leds@vger.kernel.org
Subject: Re: [PATCH v2 1/2] leds: Add Intel Cherry Trail Whiskey Cove PMIC
 LEDs
Message-ID: <20190217000851.GA29803@amd>
References: <20190214230307.GA17358@amd>
 <2a5e2002-e5f1-6da3-8a43-317801b69657@redhat.com>
 <3d5407a7-9458-f071-a1d5-511b09678e20@gmail.com>
 <87a21c4e-8e5e-c180-2ff3-eb8170746e71@redhat.com>
 <80971bc3-1193-83ed-913a-12f6217016c8@gmail.com>
 <b15fd048-8206-4057-a354-07dc14ca15e3@redhat.com>
 <8a263266-a41f-c916-e990-02d04de9b5d0@gmail.com>
 <af5bec7b-0da1-ee19-cdf4-0240f56221ad@redhat.com>
 <20190216193727.GA14305@amd>
 <7be63b6b-8d8d-90b8-fb17-d219b87a101f@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="5mCyUwZo2JvN/JJP"
Content-Disposition: inline
In-Reply-To: <7be63b6b-8d8d-90b8-fb17-d219b87a101f@redhat.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--5mCyUwZo2JvN/JJP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


> >I don't pretend to fully understand it, _but_ hw_pattern should really
> >describe the pattern LED should do, not whether it reacts to charging
> >or not.
>=20
> Then we are back to step 1 of the discussion, that we need another
> mechanism outside of the trigger to select if the LED shows the configured
> pattern always, or only when the charger is on.

Yep, sorry.

> These really are 2 orthogonal settings, there is a pattern which can
> be set and the LED can either show that pattern always; or only when
> charging the battery. Note that the same pattern is used in both cases.
>=20
> This is why I previously suggested having a custom sysfs hardware_control
> attribute which selects between the "only show pattern when charging"
> modes ("hardware_control=3D1" or "always show the pattern mode"
> ("hardware_control=3D0").

I see... and yes, that would be the easiest solution.

But somehow I see "this LED is controlled by charging state" as
primary and "it shows pulses instead of staying on" as secondary
eye-candy.

This week there was another driver for charger LED.. but that one does
not do pulses. Ideally, we'd like consistent interface to the
userland.

(To make it complex, the other driver supports things like:
  LED solid on -- fully charged
  LED blinking slowly -- charging
  LED blinking fast -- charge error
  LED off -- not charging).

Best regards,

									Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--5mCyUwZo2JvN/JJP
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlxophIACgkQMOfwapXb+vI6NQCfWrGk7pBbZdnqpB/LDOPI7Npm
dx8An3ojbA4KFzTml0TUBAqYrAUcFqbo
=hEP3
-----END PGP SIGNATURE-----

--5mCyUwZo2JvN/JJP--
