Return-Path: <SRS0=p8q0=NW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58F9DC43441
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 20:18:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 234CC20854
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 20:18:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 234CC20854
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ucw.cz
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730697AbeKLGFi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 01:05:38 -0500
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:53883 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731042AbeKLGFh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 01:05:37 -0500
Received: by atrey.karlin.mff.cuni.cz (Postfix, from userid 512)
        id AF3BE806E5; Sun, 11 Nov 2018 21:16:03 +0100 (CET)
Date:   Sun, 11 Nov 2018 21:16:05 +0100
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
Message-ID: <20181111201605.GA20160@amd>
References: <1541542052-10081-1-git-send-email-jacek.anaszewski@gmail.com>
 <1541542052-10081-3-git-send-email-jacek.anaszewski@gmail.com>
 <20181111120234.GA28794@amd>
 <a640167b-3a3e-daea-b377-6e82b653c5e8@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="6TrnltStXW4iwmi0"
Content-Disposition: inline
In-Reply-To: <a640167b-3a3e-daea-b377-6e82b653c5e8@gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--6TrnltStXW4iwmi0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> >> diff --git a/Documentation/leds/leds-class.txt b/Documentation/leds/le=
ds-class.txt
> >> index 836cb16..e9009c4 100644
> >> --- a/Documentation/leds/leds-class.txt
> >> +++ b/Documentation/leds/leds-class.txt
> >> @@ -43,7 +43,7 @@ LED Device Naming
> >> =20
> >>  Is currently of the form:
> >> =20
> >> -"devicename:colour:function"
> >> +"colour:function"
> >> =20
> >=20
> > I don't think we want to do it in all cases.
> >=20
> > So, on my cellphone seeing lp5523:green:led is indeed not useful.
> >=20
> > But on notebook with usb keyboard attached, you need to keep the
> > devicename to be able to distinguish capslock on internal keyboard and
> > capslock on first USB keyboard and capslock on second USB keyboard.
> >=20
> > Taking look at the list of functions, here's stuff like "hdd" and
> > "hdderr". I assume the first means hdd activity... If we can do it, it
> > would be nicest to have "sda:green:activity" and maybe
> > "sda:red:error". For a raid array with 8 drives...
> >=20
> > For example I have a router running linux. It has 4 lan ports, with
> > correspondings LED, and an wan led.
> >=20
> > Having "green:lan1" to "green:lan4" and "green:wan" plus
> > "red:wanerror" would work, but I'd really preffer
> > "eth0:green:link"... "adsl0:green:link", "adsl0:red:error".
> >=20
> > There are now phones with flashes on both main and selfie
> > cameras. Again, knowing which device is which is important. As is
> > knowing which display is controlled by particular backlight.
>=20
> It's overcomplicating the naming again. In every case you can tweak
> the function name to eth0_link, eth1_link etc.

Well, but in such case it would be good to keep existing scheme.

My system looks like this:

input16::capslock    tpacpi::bay_active    tpacpi::standby
input16::numlock     tpacpi::dock_active   tpacpi::thinklight
input16::scrolllock  tpacpi::dock_batt	      tpacpi::thinkvantage
input5::capslock     tpacpi::dock_status1  tpacpi::unknown_led
input5::numlock      tpacpi::dock_status2  tpacpi::unknown_led2
input5::scrolllock   tpacpi:green:batt	      tpacpi::unknown_led3

I agree that we should get rid of "tpacpi:" part in some cases. But
it does not make sense to get rid of "input16:" part -- it tells you
if the LED is on USB or on built-in keyboard.

Ideally, tpacpi::thinklight would be input5::frontlight (as it is
frontlight for the keyboard).

Yes we should simplify, but it still needs to work in all cases.

Best regards,
									Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--6TrnltStXW4iwmi0
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlvojgUACgkQMOfwapXb+vKxOgCgm55bMnwwdPRG9f8nOhIzpyhq
aOgAn2aKriCeAb5PGsRlRrPIqfT1S2Eo
=HGY4
-----END PGP SIGNATURE-----

--6TrnltStXW4iwmi0--
