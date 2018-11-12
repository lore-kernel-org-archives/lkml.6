Return-Path: <SRS0=E8pv=NX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45977C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 19:06:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 14FF722504
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 19:06:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 14FF722504
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ucw.cz
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725876AbeKMFAb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Nov 2018 00:00:31 -0500
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:55145 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725749AbeKMFAb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Nov 2018 00:00:31 -0500
Received: by atrey.karlin.mff.cuni.cz (Postfix, from userid 512)
        id EA67980577; Mon, 12 Nov 2018 20:05:52 +0100 (CET)
Date:   Mon, 12 Nov 2018 20:05:55 +0100
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
Message-ID: <20181112190554.GA13959@amd>
References: <1541542052-10081-1-git-send-email-jacek.anaszewski@gmail.com>
 <1541542052-10081-3-git-send-email-jacek.anaszewski@gmail.com>
 <20181111120234.GA28794@amd>
 <a640167b-3a3e-daea-b377-6e82b653c5e8@gmail.com>
 <20181111201605.GA20160@amd>
 <57b77d4e-39a0-aaf2-5952-c2c25dc58593@gmail.com>
 <20181112103513.GB5695@amd>
 <662c02ba-455b-e2bf-a5e2-ae3933161894@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="rwEMma7ioTxnRzrJ"
Content-Disposition: inline
In-Reply-To: <662c02ba-455b-e2bf-a5e2-ae3933161894@gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--rwEMma7ioTxnRzrJ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> >>> My system looks like this:
> >>>
> >>> input16::capslock    tpacpi::bay_active    tpacpi::standby
> >>> input16::numlock     tpacpi::dock_active   tpacpi::thinklight
> >>> input16::scrolllock  tpacpi::dock_batt	      tpacpi::thinkvantage
> >>> input5::capslock     tpacpi::dock_status1  tpacpi::unknown_led
> >>> input5::numlock      tpacpi::dock_status2  tpacpi::unknown_led2
> >>> input5::scrolllock   tpacpi:green:batt	      tpacpi::unknown_led3

> > But it is not just for backwards compatibility. See my examples above,
> > it is needed to tell which device the LED is asociated with, and it is
> > absolutely required for USB devices (for example).
>=20
> For USB devices there is already ledtrig-usbport available, which
> provides sysfs interface for defining and reading the usb ports,
> the status of which the LED indicates. Since the USB devices can be
> attached/removed dynamically, it would be impossible to reflect
> the associations in the LED class device name.

I'm not talking USB activity. I'm talking USB devices with LEDs on
them, like for example keyboards.

Please take a look at example above. input16::numlock ;
input5::numlock . You absolutely need device part.

> > And even for "embedded" stuff like routers, we want eth0:green:link,
> > eth0:yellow:activity and not some kind of hack.
>=20
> eth0 is not something you can be certain of at the stage of defining DT
> node.

In the common case DT is used for, yes, you can, because whole system
is in one box.

(And really DT does not matter. We are talking kernel <-> user
interface here).

> > Ideally, colors would come from fixed list, functions would come from
> > fixed list, and device part would come from name used elsewhere in the
> > kernel.
> >=20
> > (And yes, it probably means we should have something in device tree to
> > link LED to its device. device =3D "name" would be good start...)
>=20
> Why would you need such link?

Because userspace needs that information?

Say you have raid array, with "error" leds for each drive (your list
already contains "hdderr"). Now userland detects problem with hdparm
on /dev/sdi. It would like to turn on corresponding LED.

How do you propose we do that?
									Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--rwEMma7ioTxnRzrJ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlvpzxIACgkQMOfwapXb+vKHRwCfULNoqi7nqurfv2LaLbnmDUNJ
QK0AoKtEbe3EnDfkz6s6KDONqzCSTxz7
=PU0k
-----END PGP SIGNATURE-----

--rwEMma7ioTxnRzrJ--
