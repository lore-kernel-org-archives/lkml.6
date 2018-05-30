Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932259AbeE3USh (ORCPT <rfc822;w@1wt.eu>);
        Wed, 30 May 2018 16:18:37 -0400
Received: from sauhun.de ([88.99.104.3]:37188 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753718AbeE3USd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 May 2018 16:18:33 -0400
Date: Wed, 30 May 2018 22:18:31 +0200
From: Wolfram Sang <wsa@the-dreams.de>
To: Dmitry Osipenko <digetx@gmail.com>
Cc: Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Laxman Dewangan <ldewangan@nvidia.com>, linux-tegra@vger.kernel.org,
        linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] i2c: tegra: Remove suspend-resume
Message-ID: <20180530201831.6327alcmr2stgr3a@ninjato>
References: <20180513211347.7187-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="e5vf2g2grh6d4q2g"
Content-Disposition: inline
In-Reply-To: <20180513211347.7187-1-digetx@gmail.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--e5vf2g2grh6d4q2g
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, May 14, 2018 at 12:13:47AM +0300, Dmitry Osipenko wrote:
> Nothing prevents I2C clients to access I2C while Tegra's driver is being
> suspended, this results in -EBUSY error returned to the clients and that
> may have unfortunate consequences. In particular this causes problems
> for the TPS6586x MFD driver which emits hundreds of "failed to read
> interrupt status" error messages on resume from suspend. This happens if
> TPS6586X is used to wake system from suspend by the expired RTC alarm
> timer because TPS6586X is an I2C device driver and its IRQ handler reads
> the status register while Tegra's I2C driver is suspended, i.e. just after
> kernel enabled IRQ's during of resume-from-suspend process.
>=20
> Note that the removed tegra_i2c_resume() invoked tegra_i2c_init() which
> performs HW reset. That seems was also not entirely correct because moving
> tegra_i2c_resume to an earlier stage of resume-from-suspend process causes
> I2C transfer to fail in the case of TPS6586X. It is fine to remove the
> HW-reinitialization for now because it should be only needed in a case of
> using lowest power-mode during suspend, which upstream kernel doesn't
> support.
>=20
> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
> Cc: <stable@vger.kernel.org>

Applied to for-next, thanks!


--e5vf2g2grh6d4q2g
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlsPBxcACgkQFA3kzBSg
KbbFZw//SMNfWMlDFbsbF6Gb+7UXJQ9Yj8lterDd+32HwO2oAnM8VxIDdP9qkTTL
ZsLy1/tddjX+6yX1H7MQw/fcOPk1FArnWXtAhCaE48SsaovY5Sgl1+X7RDDkzypt
pUkneCDeVHmkVpaYq6X/4BLAodThAlES2QwMS/WWUBKpSdUHugYB0nHiD4Zb2tb0
x52sK1VU1r5C3sc3HMJK5HZ6n+k+qe0mw5bFpsmGXuxC1jf79sqdtfSRi/DMwl3t
Do3rhhgDRrqYg/FTDR//w6cq7JNUTCnfS29LjtdWDA+opO2OLsjteOnhW53MFynw
otvkVcf+RFeV7Jsgz4H7uCj0YAq7mGeqVqIfgDHfvtiFmDGqNdMsbSxN5xws5BNK
Xjh+xHr64G5cZxtpJTUVVQItARUmETlhVU3jQtCbp7ioc1ehNw3GSWVyXiIqjG+g
VSSaj32slpWhCckna7jH6cWLUosQRoKBe496Owdj1ugDAoH0714wmMcM6LZ8eZN8
3n1tzxsk6P4w4QLnJixcAfQVYqlj+kVghWX0sKZrVopshVYR6LpoTgcXJhutGD40
nTUuzuqabi/4SjmWndXlYKhRUTlGiORGsQO6yN2u7ae6HB5+sfLmHIbz/TgQqdrO
CCbNtCDRv2eOaPfkd+uHL2TERcFuwMOz/IVvPEdeaPGjgr9KTxU=
=Rq5I
-----END PGP SIGNATURE-----

--e5vf2g2grh6d4q2g--
