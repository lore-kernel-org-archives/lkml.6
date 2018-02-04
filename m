Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751848AbeBDMPm (ORCPT <rfc822;w@1wt.eu>);
        Sun, 4 Feb 2018 07:15:42 -0500
Received: from mail-wr0-f178.google.com ([209.85.128.178]:44009 "EHLO
        mail-wr0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750796AbeBDMPe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Feb 2018 07:15:34 -0500
X-Google-Smtp-Source: AH8x2273mo/bvpLk0jFWKZBtIisz6p5oV1VIuqbfEVxxMJ3rzW7Ll7lpK7y3Q2ATNyi9QXUCVBMZzA==
Date: Sun, 4 Feb 2018 13:15:30 +0100
From: Pali =?utf-8?B?Um9ow6Fy?= <pali.rohar@gmail.com>
To: Alexander Sergeyev <sergeev917@gmail.com>
Cc: Mario.Limonciello@dell.com, dvhart@infradead.org, andy@infradead.org,
        linux-kernel@vger.kernel.org, mjg59@srcf.ucam.org,
        platform-driver-x86@vger.kernel.org
Subject: Re: PROBLEM: NULL pointer dereference in dell_set_arguments() in 4.15
Message-ID: <20180204121530.sl3h77mxbwusp2ul@pali>
References: <20180203162021.GA4571@localhost.localdomain>
 <e489f5ee-34e5-4777-afe7-38d31d2ad3fd@Dell.com>
 <20180204092333.GA2010@localhost.localdomain>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="3ra52usstgql7qaq"
Content-Disposition: inline
In-Reply-To: <20180204092333.GA2010@localhost.localdomain>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--3ra52usstgql7qaq
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sunday 04 February 2018 12:23:33 Alexander Sergeyev wrote:
> Mario,
>=20
> > Would you please try https://patchwork.kernel.org/patch/10194287/
> > And see if it cleans up this null pointer dereference?
>=20
> Yes, it does.

So problem which I spotted is not only theoretical, but already affects
users... Pity that I have not looked at that patch which introduced that
problem deeply earlier :-(

So there is race condition between initializing dell-laptop driver and
calling exported function from this driver. But does not we still have
same problem at layer between dell-laptop.ko dell-sbios.ko and
dell-smbios-*.ko?

To make dell_micmute_led_set() work properly we need to ensure that
either WMI or SMM driver is already loaded and initialized.

> Is there any estimates on when the patch will be merged into mainline? I
> want to put something into my distribution bug tracker, but it's unlikely
> they will use this patch before its stabilization.

It should go in next round of merging into linus tree and after that
with proper commit message tags it should included in next stable
versions.

--=20
Pali Roh=C3=A1r
pali.rohar@gmail.com

--3ra52usstgql7qaq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQS4VrIQdKium2krgIWL8Mk9A+RDUgUCWnb5YQAKCRCL8Mk9A+RD
UgfNAJ4nMF9y/lKZCSmOnDdLbjaP73dtMgCfcjLWwwprfyt/aho9LIjCsN9PRwk=
=jN4r
-----END PGP SIGNATURE-----

--3ra52usstgql7qaq--
