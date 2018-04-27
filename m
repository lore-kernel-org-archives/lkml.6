Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1758000AbeD0MHC (ORCPT <rfc822;w@1wt.eu>);
        Fri, 27 Apr 2018 08:07:02 -0400
Received: from sauhun.de ([88.99.104.3]:48740 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1757805AbeD0MHB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Apr 2018 08:07:01 -0400
Date: Fri, 27 Apr 2018 14:06:58 +0200
From: Wolfram Sang <wsa@the-dreams.de>
To: Alexander Popov <alex.popov@linux.com>
Cc: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?=
        <u.kleine-koenig@pengutronix.de>,
        linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org,
        sil2review@lists.osadl.org, Dmitry Vyukov <dvyukov@google.com>,
        syzkaller@googlegroups.com
Subject: Re: [v2 1/1] i2c: dev: prevent ZERO_SIZE_PTR deref in
 i2cdev_ioctl_rdwr()
Message-ID: <20180427120658.wi32f7margtfazzp@ninjato>
References: <1524140962-25639-1-git-send-email-alex.popov@linux.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="cil4o76td5xr644s"
Content-Disposition: inline
In-Reply-To: <1524140962-25639-1-git-send-email-alex.popov@linux.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--cil4o76td5xr644s
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 19, 2018 at 03:29:22PM +0300, Alexander Popov wrote:
> i2cdev_ioctl_rdwr() allocates i2c_msg.buf using memdup_user(), which
> returns ZERO_SIZE_PTR if i2c_msg.len is zero.
>=20
> Currently i2cdev_ioctl_rdwr() always dereferences the buf pointer in case
> of I2C_M_RD | I2C_M_RECV_LEN transfer. That causes a kernel oops in
> case of zero len.
>=20
> Let's check the len against zero before dereferencing buf pointer.
>=20
> This issue was triggered by syzkaller.
>=20
> Signed-off-by: Alexander Popov <alex.popov@linux.com>

Applied to for-current with the arithmetic expression changed to '< 1'
to keep in sync with the previous one. Will push out soon, so you can
double check if you are interested.

Thanks for the debugging, Alexander!


--cil4o76td5xr644s
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlrjEl4ACgkQFA3kzBSg
KbY65w/7BYlvSUKh16QpzYUCT6TSbRLnsqURdqNSN8iDZ1RdyBdDC6rsYnN5uYOk
QgB9bFQs1rMcVX1DLV/+mdI06jnqJsmqQfQq6y7PFwn24qrAOR2/uAFX9t1LFuzg
xFPGn6oq1CEZUZP6/J851SEPbAKvA8J2HiC7Qf3UL2662FEz4Q1Ev0bMKwJ9CKMi
9lUybfB2HhPYxBV+FAhicESq8lRwYdpYQ+xE+xe0tMRE6yJ4XblXylgxfXJfA3hR
xUJCM6N3Xz/LICAzzF2GkCuRxFoRqpJVOxticwZG//ja0on0c6y1WJK86AatTVai
rxBU9p4mTTudoyyVENWp60FCSCVoOmh0QUpMEtWddz0LOSUaT3208fjnXTZbAliC
K2nkg3pkndU9S6ABRvkq/gHmpNV6qlSklnTMT3jhWZ/Ie4RiVUIHsAJvZO/vP3q8
XbgZf65pIffGJppRcJFkBuJRmzCOfnvl7rsMykQjxVUCO828ww38Du/B31kfJ8w8
mL5QXXPaSeTsbhhQjIl+WIu9Dl0qmUkrdVMSuigJG2t6aZ5HgQhrwoqr5P2GThNP
q6m1IL7tA9NgfiydvdL0Ku7Dz6gQTSMpuuv6rFqe4p2OS1/8GPj6yXy6W6KIUXI8
hse8kHpoQHccQ6ZrK74823PWYcF+SA9UWEqZF+s5eSZKTQ2bgBM=
=4HXa
-----END PGP SIGNATURE-----

--cil4o76td5xr644s--
