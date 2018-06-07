Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id oc7aEhwqGVvwEwAAmS7hNA
	; Thu, 07 Jun 2018 12:51:07 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id A30CB608B8; Thu,  7 Jun 2018 12:51:07 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,MAILING_LIST_MULTI
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 2214C602FC;
	Thu,  7 Jun 2018 12:51:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 2214C602FC
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=ucw.cz
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932516AbeFGMvE (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Thu, 7 Jun 2018 08:51:04 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:59749 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932100AbeFGMvD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jun 2018 08:51:03 -0400
Received: by atrey.karlin.mff.cuni.cz (Postfix, from userid 512)
        id A93158059E; Thu,  7 Jun 2018 14:51:01 +0200 (CEST)
Date: Thu, 7 Jun 2018 14:51:01 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-serial@vger.kernel.org,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Rob Herring <robh@kernel.org>, Johan Hovold <johan@kernel.org>,
        linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 04/19] Bluetooth: hci_nokia: Add serdev_id_table
Message-ID: <20180607125101.GA8074@amd>
References: <20180529131014.18641-1-ricardo.ribalda@gmail.com>
 <20180529131014.18641-5-ricardo.ribalda@gmail.com>
 <E848BED5-1D83-47FA-A673-29B366A60227@holtmann.org>
 <20180607102740.GD4372@localhost>
 <22CF0FC7-6DC7-4DD2-9EA1-9F51B40F53E5@holtmann.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="8t9RHnE3ZwKMSgU+"
Content-Disposition: inline
In-Reply-To: <22CF0FC7-6DC7-4DD2-9EA1-9F51B40F53E5@holtmann.org>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--8t9RHnE3ZwKMSgU+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!


> >>> +	{ "hp4-bluetooth", },
> >>> +	{},
> >>> +};
> >>> +
> >>> static struct serdev_device_driver nokia_bluetooth_serdev_driver =3D {
> >>> 	.probe =3D nokia_bluetooth_serdev_probe,
> >>> 	.remove =3D nokia_bluetooth_serdev_remove,
> >>> @@ -809,6 +814,7 @@ static struct serdev_device_driver nokia_bluetoot=
h_serdev_driver =3D {
> >>> 		.pm =3D &nokia_bluetooth_pm_ops,
> >>> 		.of_match_table =3D of_match_ptr(nokia_bluetooth_of_match),
> >>> 	},
> >>> +	.id_table =3D nokia_bluetooth_serdev_id,
> >>> };
> >>=20
> >> I would actually skip this hardware. First of all it is such a dedicat=
ed custom Nokia transport and hardware, and secondly it is no longer produc=
ed anyway.
> >>=20
> >=20
> > Would it make sense to cc: sre here? We want good support even for old
> > hardware, and this is n9/n950, it is still on "top ten supported
> > phones" list... Probably even top 5.
>=20
> but that is not what this patch series is about. We do not need new_id ki=
nda support for the existing hardware. My point is there will be no newly d=
esigned hardware using this driver.
>=20

You are right, new hardware with that protocol sounds unlikely at this
point.

Sorry for the noise,
									Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--8t9RHnE3ZwKMSgU+
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlsZKjUACgkQMOfwapXb+vJTiACeLqDgMf0mHp9GAafdvWoq7hf8
oq4An0BpsPFON4XV2mEol/wRhJ5nDXfh
=FwgU
-----END PGP SIGNATURE-----

--8t9RHnE3ZwKMSgU+--
