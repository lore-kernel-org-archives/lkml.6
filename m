Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751828AbeEBPLV (ORCPT <rfc822;w@1wt.eu>);
        Wed, 2 May 2018 11:11:21 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:45725 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751690AbeEBPLL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 May 2018 11:11:11 -0400
Date: Wed, 2 May 2018 17:11:09 +0200
From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <uwe@kleine-koenig.org>
To: Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        Pavel Machek <pavel@ucw.cz>
Cc: linux-kernel@vger.kernel.org, Tomas Hlavacek <tomas.hlavacek@nic.cz>
Subject: led: hw-trigger, global brightness and multi-colored leds
Message-ID: <20180502151108.GA25970@taurus.defre.kleine-koenig.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="IJpNTDwzlM2Ie8A6"
Content-Disposition: inline
User-Agent: Mutt/1.9.5 (2018-04-13)
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c5
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--IJpNTDwzlM2Ie8A6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hello,

on the Turris Omnia[1] the LEDs are controllable via an i2c device. Each
LED can be either in "manual mode" or in a mode I'd call "native mode"
which is the default. In this native mode the LED being on or off
depends on an input line that is controlled by another hardware. So a
LED signals for example activity on the WAN ethernet port without any
software intervention, but can be used as a normal LED, too, when in
"manual mode" where it can be switched on and off by a register write.

Another feature of the LED device is that there is a global brightness
register that influences all LED's brightness (if on) independent of the
operating mode.

Further the color of each LED can be set to an RGB triplet.

Now I wonder how to match these two features to the LED device model. Do
you have an idea? The first one is the most important one, as the
brightness and color can simply be ignored for a first driver, but I'd
rater not loose the "native mode".

Best regards
Uwe

[1] https://omnia.turris.cz/en/


--IJpNTDwzlM2Ie8A6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAlrp1QgACgkQwfwUeK3K
7Am0TAf/W6zn6hwyCnVNwTvAJxygUZSqg1/4BidPwbio8BWNfnUYfP2uxqw0Fmkr
aFGOdNmHg0YGBC9WAJvmQRrn7pGZ9SD3Rid8AQQjskuIUC3r7xTuGdoWmdvPK2lg
QQ89j1sdnlvsjQPa+sDRQPGhbe0vjFRNtJYfpMG1YrE9kb/wOw8UlkABUJvHVYtD
Fg1c+zLUhDjBBkqw2q+VbHPmUkwCgSkDjSM9vV3JZqVLisdXaQa/A18YXaNBkYx8
NdTsvmJtNV+Cw0fpIIpr11T8Grnp3ivI/zrr1dtbu9zUIfGqMVA42PP+7w4akycQ
nTxwgpL9542QFMQvWH7zPmOiXYEf9w==
=DCQp
-----END PGP SIGNATURE-----

--IJpNTDwzlM2Ie8A6--
