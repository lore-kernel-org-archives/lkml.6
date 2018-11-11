Return-Path: <SRS0=p8q0=NW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FE12C43441
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 20:21:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AFA2620854
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 20:21:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AFA2620854
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ucw.cz
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731659AbeKLGK2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 01:10:28 -0500
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:53989 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726912AbeKLGK2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 01:10:28 -0500
Received: by atrey.karlin.mff.cuni.cz (Postfix, from userid 512)
        id 69E5D80694; Sun, 11 Nov 2018 21:20:54 +0100 (CET)
Date:   Sun, 11 Nov 2018 21:20:56 +0100
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
Subject: Re: [PATCH 03/24] leds: dt-bindings: Add LED_FUNCTION definitions
Message-ID: <20181111202056.GB20160@amd>
References: <1541542052-10081-1-git-send-email-jacek.anaszewski@gmail.com>
 <1541542052-10081-4-git-send-email-jacek.anaszewski@gmail.com>
 <20181111113157.GK27666@amd>
 <96296b4d-d49e-2b08-4306-196605a9f5dc@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="wzJLGUyc3ArbnUjN"
Content-Disposition: inline
In-Reply-To: <96296b4d-d49e-2b08-4306-196605a9f5dc@gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--wzJLGUyc3ArbnUjN
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> >> +#define LED_FUNCTION_BACKLIGHT "backlight"
> >> +#define LED_FUNCTION_BACKLIGHT_CLUSTER "backlight_cluster"
> >=20
> > Sounds like one of backlight and backlight_cluster should be deprecated?
>=20
> I think so.

Agreed.

> >> +#define LED_FUNCTION_DEBUG "debug"
> >> +#define LED_FUNCTION_DIA "dia"
> >=20
> > What does this one do?
>=20
> I'd opt for something like "diagnostics", but this is a blind shot.
> Let's remove it then and, and let people add more meaningful
> definition in case it is needed.
>=20
> >> +#define LED_FUNCTION_DISK "disk"
> >=20
> > We have disk, hd, hdd and sata. Deprecate some?
>=20
> Disk should be the best choice, especially given that we have
> identically named trigger.

Ok.

> >> +#define LED_FUNCTION_HD "hd"
> >> +#define LED_FUNCTION_HDD "hdd"
> >> +#define LED_FUNCTION_HDDERR "hdderr"
> >=20
> > Ok, I'll=20
>=20
> Hmm?

I was going to say that I'll bring it up in different email.

I believe we should have disk:green:activity and disk:red:error, not
"green:hdd" and "red:hdderr".

> >> +#define LED_FUNCTION_HEALTH "health"
> >> +#define LED_FUNCTION_HEARTBEAT "heartbeat"
> >=20
> > Sounds same as alive, deprecate alive?
>=20
> Heartbeat may be designated specifically for registration
> for events from the trigger with the same name.

Ok. What is "alive" then?

> >> +#define LED_FUNCTION_WIFI "wifi"
> >> +#define LED_FUNCTION_WIRELESS "wireless"
> >> +#define LED_FUNCTION_WLAN "wlan"
> >=20
> > Same as wifi and wireless, I guess, deprecate some?
>=20
> I'd remove "wireless" and "wlan".

Actually I'd keep wlan, but... :-).

We may want to do add some comments there, and sort it "most
common/recommended first" or something.

Best regards (and thanks for doing the work),
									Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--wzJLGUyc3ArbnUjN
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlvojycACgkQMOfwapXb+vI7SACfW93uH8rBuPN5hycAP36oG2sk
Iw0An1ppzjzwqhiG2q/mlkJqKjLroxAG
=6Be5
-----END PGP SIGNATURE-----

--wzJLGUyc3ArbnUjN--
