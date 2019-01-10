Return-Path: <SRS0=lBHl=PS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B1B2C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 23:12:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 18FCC2173B
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 23:12:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730034AbfAJXMC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Jan 2019 18:12:02 -0500
Received: from sauhun.de ([88.99.104.3]:52716 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726149AbfAJXMA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jan 2019 18:12:00 -0500
Received: from localhost (p54B33797.dip0.t-ipconnect.de [84.179.55.151])
        by pokefinder.org (Postfix) with ESMTPSA id 2AD103E48C4;
        Fri, 11 Jan 2019 00:11:58 +0100 (CET)
Date:   Fri, 11 Jan 2019 00:11:57 +0100
From:   Wolfram Sang <wsa@the-dreams.de>
To:     Yi Zeng <yizeng@asrmicro.com>
Cc:     linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] i2c: dev: prevent adapter retries and timeout being
 set as minus value
Message-ID: <20190110231157.GA3628@kunai>
References: <e0fba81c63e03b58e15143638f0cc42678d07c61.1547018829.git.yizeng@asrmicro.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="ibTvN161/egqYuK8"
Content-Disposition: inline
In-Reply-To: <e0fba81c63e03b58e15143638f0cc42678d07c61.1547018829.git.yizeng@asrmicro.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--ibTvN161/egqYuK8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 09, 2019 at 03:33:07PM +0800, Yi Zeng wrote:
> If set adapter->retries to minus value from user space via ioctl,
> will make __i2c_transfer and __i2c_smbus_xfer jump the calling to
> adapter->algo->master_xfer and adapter->algo->smbus_xfer that
> registered by the underlying bus drivers, and return value 0 to
> all the callers. The bus driver will never be accessed anymore by
> all users, besides, the users may still get successful return value
> without any error or information log print out.
>=20
> If set adapter->timeout to minus value from user space via ioctl,
> will make the retrying loop in __i2c_transfer and __i2c_smbus_xfer
> always break after the the first try, due to the time_after always
> returns true.
>=20
> Signed-off-by: Yi Zeng <yizeng@asrmicro.com>

Applied to for-current, thanks!


--ibTvN161/egqYuK8
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlw30TkACgkQFA3kzBSg
Kba04RAAgQBNX3MnzAximH2sCiu5dNJYr5v2qfnibyvIn2RpOV0ZTXdDyW4MTrd/
xCLF2xdQo2MiGIWjjUbucFx005GFqTosFyZWPERHMI53ugDOBY0WNlEkfXghP2N7
IIfh7xj8bgsy3TXhKcTZq9oKQLnfB6hpyzq07uy3taQ1l0xvjtgR+07Njw5ZgO/W
57omF9LcRp6T5jzvFoLHI/pDUb8awySektNqZYw03OSVFwf8Oq2JU/6g6egPlPiF
Z9kJ0DzmQVn4l/jchCs/mcPggfyGkMYTClEhLwycLVQTye4n27Nkmh75c3ej7uFB
5rGvgqZyWeb7HCZKX6ln4dZ9qL+ejdjt6gHV0Umnxpoz8/8I6BXInQLTiDAUHwxI
LaW5MN/duPeaD3tYMEaS5TF/3F21Y6ukpUC3dH2al2qAfk9qLBwxMWXqWxOpxOb3
y+CJcey2yPfwLt/spt8+xHaDx81dnFkfojAkkRUe+/zcgfHZAQiBQ81zQJHHiT2O
aTiW/ySB8gyCjjcMTObgSZfU5l/qLir3cCiDkwmBfbXFYbjvKKCFUy2DoEQXnabb
k76oCUsqZD80zFATtf7uQNANnEEMLXJasxTr/8SrMeJvRYY8BrTWqHjhIOri9ynZ
KeuFawo5gaJsSMjYr43MTedxZ6/sfZvQVUZr1HLV47G6O+KInm4=
=nqMS
-----END PGP SIGNATURE-----

--ibTvN161/egqYuK8--
