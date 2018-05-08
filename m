Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756010AbeEHVvG (ORCPT <rfc822;w@1wt.eu>);
        Tue, 8 May 2018 17:51:06 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:37686 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755504AbeEHVvF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 May 2018 17:51:05 -0400
Date: Tue, 8 May 2018 23:51:02 +0200
From: Pavel Machek <pavel@ucw.cz>
To: ofono@ofono.org, kernel list <linux-kernel@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-omap@vger.kernel.org, tony@atomide.com, sre@kernel.org,
        nekit1000@gmail.com, mpartap@gmx.net, merlijn@wizzup.org
Subject: Incoming sms problem on Motorola Droid 4
Message-ID: <20180508215102.GA5253@amd>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="cNdxnHkX5QqsyA0e"
Content-Disposition: inline
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--cNdxnHkX5QqsyA0e
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

I have problems with incoming SMS. ofono tries to use +CNMI=3D1,2,2,1,0

> AT+CNMI=3D?
< +CNMI: (0,1,2),(0,1,2,3),(0,2),(0,1,2),(0,1)
< OK
ofonod[3070]: drivers/atmodem/sms.c:build_cnmi_string()
ofonod[3070]: drivers/atmodem/sms.c:construct_ack_pdu()
> AT+CNMI=3D1,2,2,1,0
< OK
ofonod[3070]: src/network.c:__ofono_netreg_add_status_watch() 0x5bbbf0

=2E.. unfortunately, with that configuration no messages are comming to
ofono and the other phone sees them as "delievery failed".

I had some luck with unicsy_demo using AT+CNMI=3D1,2 with text mode (not
PDU) messages. That works well enough for me.

Unfortunately, if I force ofono to pass "AT+CNMI=3D1,2", it does not
work well, either.

Any ideas how to debug this / what to try?

Thanks,

								Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--cNdxnHkX5QqsyA0e
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlryG8YACgkQMOfwapXb+vJMHQCfcLKpuvMsUeL+lwd58tMFjiZE
mqIAnRukPDQMkJTHVz/nUgIGM1ckM6eX
=QLm9
-----END PGP SIGNATURE-----

--cNdxnHkX5QqsyA0e--
