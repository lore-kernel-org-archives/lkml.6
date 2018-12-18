Return-Path: <SRS0=vePq=O3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9E43C43612
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 23:33:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A6C5D21873
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 23:33:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728074AbeLRXd6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Dec 2018 18:33:58 -0500
Received: from sauhun.de ([88.99.104.3]:50012 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726817AbeLRXd5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Dec 2018 18:33:57 -0500
Received: from localhost (p54B3362C.dip0.t-ipconnect.de [84.179.54.44])
        by pokefinder.org (Postfix) with ESMTPSA id 240122E3542;
        Wed, 19 Dec 2018 00:33:55 +0100 (CET)
Date:   Wed, 19 Dec 2018 00:33:54 +0100
From:   Wolfram Sang <wsa@the-dreams.de>
To:     Peter Rosin <peda@axentia.se>
Cc:     Wolfram Sang <wsa+renesas@sang-engineering.com>,
        "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>,
        "linux-renesas-soc@vger.kernel.org" 
        <linux-renesas-soc@vger.kernel.org>,
        Hans de Goede <hdegoede@redhat.com>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [RFC/RFT 01/10] i2c: add 'is_suspended' flag for i2c adapters
Message-ID: <20181218233354.pie5i3lvrrhq5q2c@ninjato>
References: <20181210210310.12677-1-wsa+renesas@sang-engineering.com>
 <20181210210310.12677-2-wsa+renesas@sang-engineering.com>
 <a4fdd7f1-be79-48fd-0d13-410276962384@axentia.se>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="kkoegvsoxj4nbwmq"
Content-Disposition: inline
In-Reply-To: <a4fdd7f1-be79-48fd-0d13-410276962384@axentia.se>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--kkoegvsoxj4nbwmq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


> > +	unsigned int is_suspended:1;	/* owned by the I2C core */
>=20
> When more stuff is added to this bit field (which always happens at
> some point) updates to all members of the bit field will have to use
> the same root-adapter-locking, or we will suffer from RMW-races. So
> this feels like an invitation for future disaster. Maybe a comment
> about that to remind our future selves? Or perhaps the bit field
> should be avoided altogether?

Changed to bool. Thanks!


--kkoegvsoxj4nbwmq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlwZg+EACgkQFA3kzBSg
KbZljQ/9FWhnSg2KAf/UssubqDJ1lmNWr9tNZYeZy56inKDT504CHLS7psgOekeS
ktdvqMny8x08MmKEeeKRUiAyc/G7RH2fqzYDehX7/fTp9JurpkAzUU3R3ojKKTUk
LttUvwiH3sox6DTtxNwVX5L+QlrJYj7MdGYLh4C7wC5GEmaqdK0Gev5wyksiqu8b
CpY5l6Mux+3ZIm1s3gQaa1mC6wVGvodvtpJ569ttR2XaaX4uhlg9OGDAGTT5Xck8
4rUiXKYBIvv3pGoq8KSNVunayb8zo82vsspr3QzCW010Tn9HKAbAJkvj85qBVcrq
f7ibMz8yI0cSyewn9rxQJlO7XPrkigRTyNScUhansbHOygY0lRa2VT7yh1at3uCg
FeGV6K3DSOYh43W+iy+qL+pUmiVzuTBiQ+Si+Ko3FcoGqx2OMg9dUk7Jm3ReWo5E
gRF0i1i5EmpP6qtzpd4miyVlrMupj4VL5huRV1vT67UgHHyrirMnXwuvLm7Lejwb
NTPAJSVCDC7lgiqnw9zfVqART0ZLm0iWGQGYOoMAVl1XCowvkB4GmSAztviWOyui
m+1pEjjwNMKntfoQqSi00B4dPBwxNsYTesAoBSNJuDYwkoDcsigM42sqKykKydDa
rcb4ZgX+UA8hP7VGZFnjouQWkU6KsoJNr9SxJuvqGlaOjwNvC1k=
=fCGw
-----END PGP SIGNATURE-----

--kkoegvsoxj4nbwmq--
