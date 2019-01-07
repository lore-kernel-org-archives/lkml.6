Return-Path: <SRS0=PvM2=PP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C6ADC43387
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 19:05:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D7ABF206B7
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 19:05:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727233AbfAGTF5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Jan 2019 14:05:57 -0500
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:49670 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726392AbfAGTF5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jan 2019 14:05:57 -0500
Received: by atrey.karlin.mff.cuni.cz (Postfix, from userid 512)
        id 9E15A809DB; Mon,  7 Jan 2019 20:05:50 +0100 (CET)
Date:   Mon, 7 Jan 2019 20:05:55 +0100
From:   Pavel Machek <pavel@ucw.cz>
To:     kernel list <linux-kernel@vger.kernel.org>, baolin.wang@linaro.org,
        linus.walleij@linaro.org, sebastian.reichel@collabora.com
Subject: 5.0-rc1 Open circuit voltage tables -- 3afb50d7125bc
Message-ID: <20190107190555.GA18865@amd>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="Qxx1br4bt0+wmkIi"
Content-Disposition: inline
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--Qxx1br4bt0+wmkIi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

Can we do something with that code?

First -- tables should not be necceessary. Formula for li-ion open
circuit voltage is well-known, and does not really depend on the
device -- only on the chemistry of battery.

state of charge =3D f( voltage, current, internal resistance )

(And yes, internal resistance depends on temperature and health of the
battery).

Second, even if we need tables, why is it doing multiple allocations?

info->ocv_temp[index]        =3D -EINVAL;

That's just wrong. Ocv_temp is temperature in celsius. Temperatures go
below zero.

								Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--Qxx1br4bt0+wmkIi
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlwzoxMACgkQMOfwapXb+vJWQwCffZliqg1CauJhr5G2AxH2XCZE
tUcAmQG/7RJ2xRgNIaKRERNwltVJnhHT
=Tkwq
-----END PGP SIGNATURE-----

--Qxx1br4bt0+wmkIi--
