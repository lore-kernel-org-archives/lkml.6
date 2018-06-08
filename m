Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id mm33NEqXGlsRHAAAmS7hNA
	; Fri, 08 Jun 2018 14:51:02 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 2BD536089E; Fri,  8 Jun 2018 14:51:02 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,MAILING_LIST_MULTI
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 807D5607E4;
	Fri,  8 Jun 2018 14:51:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 807D5607E4
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=ucw.cz
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752872AbeFHOu7 (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Fri, 8 Jun 2018 10:50:59 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:45177 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752411AbeFHOu6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jun 2018 10:50:58 -0400
Received: by atrey.karlin.mff.cuni.cz (Postfix, from userid 512)
        id 08A518054A; Fri,  8 Jun 2018 16:50:55 +0200 (CEST)
Date: Fri, 8 Jun 2018 16:50:55 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Tony Lindgren <tony@atomide.com>
Cc: Kishon Vijay Abraham I <kishon@ti.com>,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-omap@vger.kernel.org
Subject: Re: [PATCH] phy: mapphone-mdm6600: Fix wrong enum used for status
 lines
Message-ID: <20180608145055.GA11958@amd>
References: <20180531170538.32264-1-tony@atomide.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="a8Wt8u1KmwUX3Y2C"
Content-Disposition: inline
In-Reply-To: <20180531170538.32264-1-tony@atomide.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--a8Wt8u1KmwUX3Y2C
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu 2018-05-31 10:05:38, Tony Lindgren wrote:
> Kbuilt test robot reported:
>=20
> drivers/phy/motorola/phy-mapphone-mdm6600.c:188:16: warning:  is used
> uninitialized in this function [-Wuninitialized]
>         val |=3D values[i] << i;
>                ~~~~~~^~~
>=20
> Looking at the phy_mdm6600_status() values does get initialized by
> gpiod_get_array_value_cansleep(), but we are using wrong enum
> in that function. Let's fix the use, both end up being three though
> so urgent rush on this one AFAIK.
>=20
> Fixes: 5d1ebbda0318 ("phy: mapphone-mdm6600: Add USB PHY driver for
> MDM6600 on Droid 4")
> Reported-by: kbuild test robot <lkp@intel.com>
> Signed-off-by: Tony Lindgren <tony@atomide.com>

Reviewed-by: Pavel Machek <pavel@ucw.cz>

--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--a8Wt8u1KmwUX3Y2C
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlsal88ACgkQMOfwapXb+vLzEgCgvqK8LCcStxYo3zTSqe09oCIz
aV8An1r3vfthMGVK/1RhUuy7byaJ2pKb
=uf1Q
-----END PGP SIGNATURE-----

--a8Wt8u1KmwUX3Y2C--
