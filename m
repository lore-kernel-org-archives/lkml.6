Return-Path: <SRS0=cWqk=OS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DED3C07E85
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Dec 2018 19:01:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 35DEF2081C
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Dec 2018 19:01:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 35DEF2081C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ucw.cz
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726254AbeLITBg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 9 Dec 2018 14:01:36 -0500
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:38319 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726088AbeLITBf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Dec 2018 14:01:35 -0500
Received: by atrey.karlin.mff.cuni.cz (Postfix, from userid 512)
        id 0649380736; Sun,  9 Dec 2018 20:01:29 +0100 (CET)
Date:   Sun, 9 Dec 2018 20:01:33 +0100
From:   Pavel Machek <pavel@ucw.cz>
To:     Jacek Anaszewski <jacek.anaszewski@gmail.com>
Cc:     linux-leds@vger.kernel.org, linux-kernel@vger.kernel.org,
        krzk@kernel.org
Subject: Re: [PATCH 2/2] led: triggers: Add LED_INIT_DEFAULT_TRIGGER flag
Message-ID: <20181209190133.GD6331@amd>
References: <20181209184942.22391-1-jacek.anaszewski@gmail.com>
 <20181209184942.22391-2-jacek.anaszewski@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="qGV0fN9tzfkG3CxV"
Content-Disposition: inline
In-Reply-To: <20181209184942.22391-2-jacek.anaszewski@gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--qGV0fN9tzfkG3CxV
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun 2018-12-09 19:49:42, Jacek Anaszewski wrote:
> Add the flag LED_INIT_DEFAULT_TRIGGER for indicating that trigger
> being set is a default trigger for the LED class device, and
> thus it should be initialized with settings provided in the fwnode.
>=20
> Set the flag in the led_trigger_set_default(). It is expected to be
> cleared in the activate() op of a trigger after trigger fwnode
> initialization data is parsed and applied. This should happen only
> once after LED class device registration, to allow leaving triggers
> in the idle state on re-apply and let the users apply their own
> settings without being interfered with the default ones.
>=20
> Signed-off-by: Jacek Anaszewski <jacek.anaszewski@gmail.com>

Aha, I see the user now. Sorry for the noise.

Acked-by: Pavel Machek <pavel@ucw.cz>
									Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--qGV0fN9tzfkG3CxV
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlwNZo0ACgkQMOfwapXb+vLRiwCgvH4IZ0IkS5IjxYKUpWDPltZz
iYwAn09jbAXIiyd75nezMHLipMplWH65
=oaoo
-----END PGP SIGNATURE-----

--qGV0fN9tzfkG3CxV--
