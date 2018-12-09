Return-Path: <SRS0=cWqk=OS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DDE7C07E85
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Dec 2018 11:56:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CCE8220661
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Dec 2018 11:56:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CCE8220661
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ucw.cz
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726272AbeLIL4w (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 9 Dec 2018 06:56:52 -0500
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:55955 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726127AbeLIL4v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Dec 2018 06:56:51 -0500
Received: by atrey.karlin.mff.cuni.cz (Postfix, from userid 512)
        id 76F388076B; Sun,  9 Dec 2018 12:56:45 +0100 (CET)
Date:   Sun, 9 Dec 2018 12:56:48 +0100
From:   Pavel Machek <pavel@ucw.cz>
To:     Tony Lindgren <tony@atomide.com>
Cc:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-omap@vger.kernel.org, Axel Haslam <axelhaslam@ti.com>,
        Felipe Balbi <felipe.balbi@linux.intel.com>,
        Illia Smyrnov <illia.smyrnov@ti.com>,
        Marcel Partap <mpartap@gmx.net>,
        Merlijn Wajer <merlijn@wizzup.org>,
        Michael Scott <hashcode0f@gmail.com>,
        NeKit <nekit1000@gmail.com>, Sebastian Reichel <sre@kernel.org>
Subject: Re: [PATCH 1/2] Input: omap-keypad: Fix keyboard debounce
 configuration
Message-ID: <20181209115648.GA23309@amd>
References: <20181203012933.6647-1-tony@atomide.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="rwEMma7ioTxnRzrJ"
Content-Disposition: inline
In-Reply-To: <20181203012933.6647-1-tony@atomide.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--rwEMma7ioTxnRzrJ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun 2018-12-02 17:29:32, Tony Lindgren wrote:
> I noticed that the Android v3.0.8 kernel on droid4 is using different
> keypad values from the mainline kernel and does not have issues with
> keys occasionally being stuck until pressed again. Turns out there was
> an earlier patch posted to fix this as "Input: omap-keypad: errata i689:
> Correct debounce time", but it was never reposted to fix use macros
> for timing calculations.
>=20
> This updated version is using macros, and also fixes the use of the
> input clock rate to use 32768KiHz instead of 32000KiHz. And we want to
> use the known good Android kernel values of 3 and 6 instead of 2 and 6
> in the earlier patch.
>=20
> Cc: Axel Haslam <axelhaslam@ti.com>
> Cc: Felipe Balbi <felipe.balbi@linux.intel.com>
> Cc: Illia Smyrnov <illia.smyrnov@ti.com>
> Cc: Marcel Partap <mpartap@gmx.net>
> Cc: Merlijn Wajer <merlijn@wizzup.org>
> Cc: Michael Scott <hashcode0f@gmail.com>
> Cc: NeKit <nekit1000@gmail.com>
> Cc: Pavel Machek <pavel@ucw.cz>
> Cc: Sebastian Reichel <sre@kernel.org>
> Reported-by: Pavel Machek <pavel@ucw.cz>
> Signed-off-by: Tony Lindgren <tony@atomide.com>

So, if I press key "." quickly on console in
4.18.0-rc4-88970-gf075a2c-dirty it starts repeating. I could reproduce
it 3 times from tree tries. Then I decided to test your patch, and so
I booted 4.20-rc5+ using kexec. Turns out, I can't reproduce that
repeat there... I tried more than 10 times. But that's before your
patch.

So -- bad news for you -- seems like someone -- maybe you -- already
fixed this. (But that does not mean the patch is bad idea).

Thanks,
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

iEYEARECAAYFAlwNAwAACgkQMOfwapXb+vIzOwCgwGpGhjOyTgDxRGX5KMcDvnjp
laIAoK9E4BElVpVT2De8AQRVQz87KZ2u
=Pik5
-----END PGP SIGNATURE-----

--rwEMma7ioTxnRzrJ--
