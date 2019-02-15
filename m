Return-Path: <SRS0=lv5c=QW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C70E0C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 13:02:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9D39C21B18
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 13:02:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394829AbfBONCM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Feb 2019 08:02:12 -0500
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:57204 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727303AbfBONCL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Feb 2019 08:02:11 -0500
Received: by atrey.karlin.mff.cuni.cz (Postfix, from userid 512)
        id E0F088036F; Fri, 15 Feb 2019 14:02:01 +0100 (CET)
Date:   Fri, 15 Feb 2019 14:02:07 +0100
From:   Pavel Machek <pavel@ucw.cz>
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        Yauhen Kharuzhy <jekhor@gmail.com>,
        linux-kernel@vger.kernel.org, linux-leds@vger.kernel.org
Subject: Re: [PATCH v2 1/2] leds: Add Intel Cherry Trail Whiskey Cove PMIC
 LEDs
Message-ID: <20190215130207.GB32198@amd>
References: <1df39a63-533f-bb68-a056-a0241f148be9@redhat.com>
 <20190213230731.GA8557@amd>
 <42078a81-e32e-81b7-528f-d1adb60d31c3@redhat.com>
 <20190213233806.GA11867@amd>
 <562e2acd-a60a-2aea-4050-6d9414d23a4e@redhat.com>
 <20190214111423.GE6132@amd>
 <92cf09b8-726d-4f1b-94ba-368a66af2246@redhat.com>
 <2b6faaa5-b21e-a512-de7d-ca21be5045fc@gmail.com>
 <20190214230307.GA17358@amd>
 <2a5e2002-e5f1-6da3-8a43-317801b69657@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="v9Ux+11Zm5mwPlX6"
Content-Disposition: inline
In-Reply-To: <2a5e2002-e5f1-6da3-8a43-317801b69657@redhat.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--v9Ux+11Zm5mwPlX6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> >Hardware can automatically control the LED according to the charging
> >status, or it can be used as normal software-controlled LED.
> >
> >I believe we should use trigger to select if hardware controls it or
> >not (and then add driver-specific files to describe the
> >details). Other proposal is in the mail thread, too.
>=20
> Right, so there are really 2 orthogonal issues here:

For completeness, there are actually 3 issues:

> 1) With this hardware the LED is either turned on/off automatically
> by the PMIC based on charging state; or it is under user control.
>=20
> This is different from the led_classdev_notify_brightness_hw_changed
> case, where the hardware may update the state underneath the driver,
> but the driver can still always update the state itself. In this case
> if the LED is in hw-control mode then the driver cannot turn it on/off.
>=20
> Pavel suggested modeling this with a new "hardware' trigger, where
> setting the trigger to this trigger will enable the hw-controlled
> mode and setting any other trigger will switch thing to the user-controll=
ed
> mode.
>=20
> 2) This hardware can do blinking / breathing. There are various issues wi=
th
> this:
>=20
> 2.1) Blinking is more or less covered by the timer trigger. But breathing=
 is
> not the pattern trigger is a poor match since there is only 1 fixed patte=
rn
>=20
> 2.2) The supported blinking frequencies are very limited, so it might be =
better
> to keep the standard software blinking mode and have a special sysfs attr=
ibute
> to select the hardware blink support
>=20
> 2.3) The user can also select between continuous on / blinking / breathing
> when the LED is under hardware control (it will then be on / blinking / b=
reathing)
> when charging.

3) Your hardware supports "composed" triggers:

You can do "breathing while charging", can do "blinking while
charging" and you probably could do "blinking while disk is active" or
"breathing while microphone is muted".

We don't have such support in LED subsystem, AFAICT. Anyway, I'd say
3) Does not need to be solved now...

									Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--v9Ux+11Zm5mwPlX6
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlxmuE8ACgkQMOfwapXb+vLudQCgqQS77n5Tsm6sjJ5KCzmEdqP/
qxUAn06KMMaz2kPH8f+lqCCXxQJT+vyT
=tSOZ
-----END PGP SIGNATURE-----

--v9Ux+11Zm5mwPlX6--
