Return-Path: <SRS0=YyAj=PE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC4FCC43387
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Dec 2018 19:52:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 60DF5218FE
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Dec 2018 19:52:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729331AbeL0TwZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Dec 2018 14:52:25 -0500
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:59258 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729123AbeL0TwZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Dec 2018 14:52:25 -0500
Received: by atrey.karlin.mff.cuni.cz (Postfix, from userid 512)
        id 5D4DF806DE; Thu, 27 Dec 2018 20:52:18 +0100 (CET)
Date:   Thu, 27 Dec 2018 20:52:21 +0100
From:   Pavel Machek <pavel@ucw.cz>
To:     Sebastian Reichel <sre@kernel.org>, linux-pm@vger.kernel.org,
        kernel list <linux-kernel@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-omap@vger.kernel.org, tony@atomide.com, nekit1000@gmail.com,
        mpartap@gmx.net, merlijn@wizzup.org
Subject: cpcap-charger: generate events for userspace
Message-ID: <20181227195221.GA11920@amd>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="opJtzjQTFsWo+cga"
Content-Disposition: inline
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--opJtzjQTFsWo+cga
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

   =20
The driver doesn't generate uevents on charger connect/disconnect.
This leads to UPower not detecting when AC is on or off... and that is
bad.
   =20
Reported by Arthur D. on github (
https://github.com/maemo-leste/bugtracker/issues/206 ), thanks to
Merlijn Wajer for suggesting a fix.
   =20
Cc: stable@kernel.org
Signed-off-by: Pavel Machek <pavel@ucw.cz>

diff --git a/drivers/power/supply/cpcap-charger.c b/drivers/power/supply/cp=
cap-charger.c
index 9e8ff5c..7d8b4d5 100644
--- a/drivers/power/supply/cpcap-charger.c
+++ b/drivers/power/supply/cpcap-charger.c
@@ -576,6 +576,7 @@ static void cpcap_usb_detect(struct work_struct *work)
 			goto out_err;
 	}
=20
+	power_supply_changed(ddata->usb);
 	return;
=20
 out_err:

--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--opJtzjQTFsWo+cga
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlwlLXUACgkQMOfwapXb+vLYPgCdGSb1Xix0v8c/98jQt4q0SjNl
aaYAnjX5359IdWTVGczs4aF+UtxlGfeH
=VwT6
-----END PGP SIGNATURE-----

--opJtzjQTFsWo+cga--
