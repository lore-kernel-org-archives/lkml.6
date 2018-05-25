Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S967911AbeEYSuL (ORCPT <rfc822;w@1wt.eu>);
        Fri, 25 May 2018 14:50:11 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:57520 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S967557AbeEYSuK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 May 2018 14:50:10 -0400
Date: Fri, 25 May 2018 20:50:07 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Tomas Hlavacek <tomas.hlavacek@nic.cz>
Cc: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <uwe@kleine-koenig.org>,
        Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: Re: Turris Omnia firmware possibilities [Was: Re: led: hw-trigger,
 global brightness and multi-colored leds]
Message-ID: <20180525185007.GA29954@amd>
References: <20180502151108.GA25970@taurus.defre.kleine-koenig.org>
 <CAEB7QLBcLnv4JYphjxqESqofTbGyVWOd6QYKzfvdEZyDXH9LLQ@mail.gmail.com>
 <e72ed1b1-1225-2782-e207-1af6af347810@kleine-koenig.org>
 <CAEB7QLA3hs+Wa_UD4tUXN1JB535dWJxtBLo_jveKkGkyKyGAJQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="TB36FDmn/VVEgNH/"
Content-Disposition: inline
In-Reply-To: <CAEB7QLA3hs+Wa_UD4tUXN1JB535dWJxtBLo_jveKkGkyKyGAJQ@mail.gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--TB36FDmn/VVEgNH/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> > On 05/25/2018 12:08 AM, Tomas Hlavacek wrote:
> >> But I also have good news: The FW of the MCU is also OSS (see the repo
> >> in the link (1)). There is a method for flashing the MCU over I2C from
> >> Linux and there is JTAG connector for the MCU, in case un-bricking is
> >> needed. Therefore the LED protocol can be changed to be more sensible
> >> and/or it is even possible to emulate some existing HW LED driver chip
> >> in Omnia MCU and reuse OSS driver for that chip.
> >
> > Yeah, I noticed, but when we start replacing the firmware, we'd need to
> > detect somehow when a machine has an old (or only different) firmware.
> > That would imply a versioning scheme and a generic way to read out the
> > firmware version. (CMD_GET_FW_VERSION_BOOT is already a start, but this
> > doesn't help me if I find an unknown hash.) So a CMD_GET_FW_SOMETHING
> > that yields a version string that is similar to the soname of a library
> > would be great.
>=20
> Oh yes, I was actually trying to push rewrite of the FW before the
> production started, but it looked like a redundant work and I rather
> implemented the mentioned rule-breaking LED driver. Another good news
> is that all the produced boards had the same FW image and there were
> no (official and automated) updates so far. I think that in this
> situation it is possible to re-write the firmware it if proves to be
> the best solution for LED driver and fixing other glitches perhaps.
> The only thing we need regarding versions we need is to either check
> that we are upgrading the original version and/or consent from the
> user to rewrite any other version that we might encounter. (If there
> are some user-customized boards around.)

Actually, I believe you should try to write the driver for existing
firmware, and only if you find that performance is not good enough,
change the protocol.

> > Talking about firmware, I wonder if there is firmware supported needed
> > to solve
> > https://wiki.debian.org/InstallingDebianOn/TurrisOmnia#Power_Management
> > . Didn't look into that deeply yet and probably not high prio given that
> > normally the Turris Omnia will just run 7x24h.
>=20
> That's right, there is no power-down signalization from the CPU right
> now. Btw. is there any mechanism in kernel to signal over arbitrary
> bus (like I2C) that the host is shutting down and the power can/should
> be cut to CPU in N seconds?

I'm pretty sure kernel can ask the hardware to cut its power. This
sounds like it: drivers/power/reset/gpio-poweroff.c

									Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--TB36FDmn/VVEgNH/
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlsIWt8ACgkQMOfwapXb+vILQACgsEoXrsZhPY30YGX9FER836VP
H5EAnifsIZptnFUW/DpwTmdo6uGknRso
=TWcC
-----END PGP SIGNATURE-----

--TB36FDmn/VVEgNH/--
