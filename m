Return-Path: <SRS0=Clcj=JE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14167C5CFC0
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 15:56:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CBD8820864
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 15:56:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CBD8820864
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ucw.cz
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933773AbeFRP4A (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Jun 2018 11:56:00 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:39725 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932860AbeFRPz6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jun 2018 11:55:58 -0400
Received: by atrey.karlin.mff.cuni.cz (Postfix, from userid 512)
        id 34E3680576; Mon, 18 Jun 2018 17:55:57 +0200 (CEST)
Date:   Mon, 18 Jun 2018 17:55:57 +0200
From:   Pavel Machek <pavel@ucw.cz>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        y2038 Mailman List <y2038@lists.linaro.org>,
        Kees Cook <keescook@chromium.org>, Willy Tarreau <w@1wt.eu>,
        linux-leds@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] leds: ledtrig-activity: use ktime_get_boot_ns()
Message-ID: <20180618155557.GB30470@amd>
References: <20180618144210.72367-1-arnd@arndb.de>
 <20180618150715.GA30470@amd>
 <CAK8P3a1K19WoEGaqrj6Fx0GYyj1jmA50dS+dMJuF7ugkwjCiug@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="i0/AhcQY5QxfSsSZ"
Content-Disposition: inline
In-Reply-To: <CAK8P3a1K19WoEGaqrj6Fx0GYyj1jmA50dS+dMJuF7ugkwjCiug@mail.gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--i0/AhcQY5QxfSsSZ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


> >> index 5081894082bd..589c1bc4d0b9 100644
> >> --- a/drivers/leds/trigger/ledtrig-activity.c
> >> +++ b/drivers/leds/trigger/ledtrig-activity.c
> >> @@ -37,7 +37,6 @@ static void led_activity_function(struct timer_list =
*t)
> >>       struct activity_data *activity_data =3D from_timer(activity_data=
, t,
> >>                                                        timer);
> >>       struct led_classdev *led_cdev =3D activity_data->led_cdev;
> >> -     struct timespec boot_time;
> >>       unsigned int target;
> >>       unsigned int usage;
> >>       int delay;
> >> @@ -57,7 +56,7 @@ static void led_activity_function(struct timer_list =
*t)
> >>               return;
> >>       }
> >>
> >> -     get_monotonic_boottime(&boot_time);
> >> +     curr_boot =3D ktime_get_boot_ns();
> >>
> >>       cpus =3D 0;
> >>       curr_used =3D 0;
> >> @@ -76,7 +75,6 @@ static void led_activity_function(struct timer_list =
*t)
> >>        * down to 16us, ensuring we won't overflow 32-bit computations =
below
> >>        * even up to 3k CPUs, while keeping divides cheap on smaller sy=
stems.
> >>        */
> >> -     curr_boot =3D timespec_to_ns(&boot_time) * cpus;
> >
> > Original code is pretty weird (notice the * cpus), so I'm
> > double-checking.
>=20
> Ok, dropping the *cpus was not intentional, I'll repost a version that pu=
ts
> it that back. Thanks for pointing this out!

Feel free to add my Acked-by to fixed version.

Thanks,
									Pavel

--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--i0/AhcQY5QxfSsSZ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlsn1g0ACgkQMOfwapXb+vJTrQCdGtD8X0sayoNO2E4g0V054I8Z
o1cAn2HdnNkTpewCAZ/lCC6tYhSUL3Z3
=qFwR
-----END PGP SIGNATURE-----

--i0/AhcQY5QxfSsSZ--
