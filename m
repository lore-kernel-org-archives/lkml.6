Return-Path: <SRS0=E8pv=NX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB038C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 22:06:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 79AF722360
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 22:06:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 79AF722360
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ucw.cz
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730649AbeKMIB0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Nov 2018 03:01:26 -0500
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:59484 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728325AbeKMIBZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Nov 2018 03:01:25 -0500
Received: by atrey.karlin.mff.cuni.cz (Postfix, from userid 512)
        id 69EA680708; Mon, 12 Nov 2018 23:06:14 +0100 (CET)
Date:   Mon, 12 Nov 2018 23:06:16 +0100
From:   Pavel Machek <pavel@ucw.cz>
To:     Jacek Anaszewski <jacek.anaszewski@gmail.com>
Cc:     linux-leds@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, robh@kernel.org,
        Baolin Wang <baolin.wang@linaro.org>,
        Daniel Mack <daniel@zonque.org>, Dan Murphy <dmurphy@ti.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Oleh Kravchenko <oleg@kaa.org.ua>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Simon Shields <simon@lineageos.org>,
        Xiaotong Lu <xiaotong.lu@spreadtrum.com>
Subject: Re: [PATCH 02/24] leds: core: Add support for composing LED class
 device names
Message-ID: <20181112220616.GB11942@amd>
References: <1541542052-10081-1-git-send-email-jacek.anaszewski@gmail.com>
 <1541542052-10081-3-git-send-email-jacek.anaszewski@gmail.com>
 <20181111120234.GA28794@amd>
 <a640167b-3a3e-daea-b377-6e82b653c5e8@gmail.com>
 <20181111201605.GA20160@amd>
 <57b77d4e-39a0-aaf2-5952-c2c25dc58593@gmail.com>
 <20181112103513.GB5695@amd>
 <662c02ba-455b-e2bf-a5e2-ae3933161894@gmail.com>
 <20181112190554.GA13959@amd>
 <b167cfc1-e392-eec6-6455-5983dc1c7212@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="NMuMz9nt05w80d4+"
Content-Disposition: inline
In-Reply-To: <b167cfc1-e392-eec6-6455-5983dc1c7212@gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--NMuMz9nt05w80d4+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon 2018-11-12 21:11:32, Jacek Anaszewski wrote:
> On 11/12/2018 08:05 PM, Pavel Machek wrote:
> > Hi!
> >=20
> >>>>> My system looks like this:
> >>>>>
> >>>>> input16::capslock    tpacpi::bay_active    tpacpi::standby
> >>>>> input16::numlock     tpacpi::dock_active   tpacpi::thinklight
> >>>>> input16::scrolllock  tpacpi::dock_batt	      tpacpi::thinkvantage
> >>>>> input5::capslock     tpacpi::dock_status1  tpacpi::unknown_led
> >>>>> input5::numlock      tpacpi::dock_status2  tpacpi::unknown_led2
> >>>>> input5::scrolllock   tpacpi:green:batt	      tpacpi::unknown_led3
> >=20
> >>> But it is not just for backwards compatibility. See my examples above,
> >>> it is needed to tell which device the LED is asociated with, and it is
> >>> absolutely required for USB devices (for example).
> >>
> >> For USB devices there is already ledtrig-usbport available, which
> >> provides sysfs interface for defining and reading the usb ports,
> >> the status of which the LED indicates. Since the USB devices can be
> >> attached/removed dynamically, it would be impossible to reflect
> >> the associations in the LED class device name.
> >=20
> > I'm not talking USB activity. I'm talking USB devices with LEDs on
> > them, like for example keyboards.
> >=20
> > Please take a look at example above. input16::numlock ;
> > input5::numlock . You absolutely need device part.
>=20
> It would be redundant since there is "device" symbolic link
> created in given LED class device sysfs directory, pointing to the
> corresponding input device directory, like in case of my USB
> keyboard:

You are right I forgot about the device symlink, and it partly helps
with the USB keyboard case...=20

But you still need the device part. Sysfs will not like two
directories named "::numlock".

> #/sys/class/leds/input5::scrolllock$ ls -l
> total 0
> -rw-r--r-- 1 root root 4096 Nov 12 20:22 brightness
> lrwxrwxrwx 1 root root    0 Nov 12 20:22 device -> ../../input5
> -r--r--r-- 1 root root 4096 Nov 12 20:22 max_brightness
> drwxr-xr-x 2 root root    0 Nov 12 20:22 power
> lrwxrwxrwx 1 root root    0 Nov 12 20:04 subsystem ->
> ../../../../../../../../../../../class/leds
> -rw-r--r-- 1 root root 4096 Nov 12 20:22 trigger

> > Because userspace needs that information?
> >=20
> > Say you have raid array, with "error" leds for each drive (your list
> > already contains "hdderr"). Now userland detects problem with hdparm
> > on /dev/sdi. It would like to turn on corresponding LED.
> >=20
> > How do you propose we do that?
>=20
> Similarly as in case of USB keyboard.

Not really, I'm afraid. Hard drives have no red LEDs on them (and the
LED would not be visible, anyway) so the "device" symlink in such case
would point to some kind of i2c LED controller.

Eventually we'll need to have two devices for each LED. "Controller
this is on" -- in device symlink and "device this talks about".

									Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--NMuMz9nt05w80d4+
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlvp+VgACgkQMOfwapXb+vKgpwCgrDEQZhiCh6+UtO5uFuLgRgiK
lVEAoK+Mz4j9QOgzGmXBTaMYGMNKkai8
=vj6U
-----END PGP SIGNATURE-----

--NMuMz9nt05w80d4+--
