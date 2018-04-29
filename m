Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752561AbeD3Hzb (ORCPT <rfc822;w@1wt.eu>);
        Mon, 30 Apr 2018 03:55:31 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:44003 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752445AbeD3Hz3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Apr 2018 03:55:29 -0400
Subject: Re: [PATCH net-next] can: dev: use skb_put_zero to simplfy code
To: YueHaibing <yuehaibing@huawei.com>, wg@grandegger.com
Cc: netdev@vger.kernel.org, linux-can@vger.kernel.org, davem@davemloft.net,
        linux-kernel@vger.kernel.org
References: <20180428074957.17084-1-yuehaibing@huawei.com>
From: Marc Kleine-Budde <mkl@pengutronix.de>
Openpgp: preference=signencrypt
Autocrypt: addr=mkl@pengutronix.de; keydata=
 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
 /6jKeO1yNpD5UgI9bzazBn1mwg==
Message-ID: <0f0a2623-da07-d102-8bed-d2034c41520a@pengutronix.de>
Date: Sun, 29 Apr 2018 18:24:19 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180428074957.17084-1-yuehaibing@huawei.com>
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="h7VF7kDEiHZCpqK4hmtA9O6mLmnTRpLUk"
X-SA-Exim-Connect-IP: 2001:67c:670:201:5054:ff:fe8d:eefb
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--h7VF7kDEiHZCpqK4hmtA9O6mLmnTRpLUk
Content-Type: multipart/mixed; boundary="ZT4sclf9KRnlyTZZdDcm5VvmZvDJrrFkk";
 protected-headers="v1"
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: YueHaibing <yuehaibing@huawei.com>, wg@grandegger.com
Cc: netdev@vger.kernel.org, linux-can@vger.kernel.org, davem@davemloft.net,
 linux-kernel@vger.kernel.org
Message-ID: <0f0a2623-da07-d102-8bed-d2034c41520a@pengutronix.de>
Subject: Re: [PATCH net-next] can: dev: use skb_put_zero to simplfy code
References: <20180428074957.17084-1-yuehaibing@huawei.com>
In-Reply-To: <20180428074957.17084-1-yuehaibing@huawei.com>

--ZT4sclf9KRnlyTZZdDcm5VvmZvDJrrFkk
Content-Type: text/plain; charset=utf-8
Content-Language: de-DE
Content-Transfer-Encoding: quoted-printable

On 04/28/2018 09:49 AM, YueHaibing wrote:
> use helper skb_put_zero to replace the pattern of skb_put() && memset()=

>=20
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>

Applied to linux-can-next.

Tnx,
Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--ZT4sclf9KRnlyTZZdDcm5VvmZvDJrrFkk--

--h7VF7kDEiHZCpqK4hmtA9O6mLmnTRpLUk
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEENrCndlB/VnAEWuH5k9IU1zQoZfEFAlrl8bMACgkQk9IU1zQo
ZfGfIAgAw59vA9/t8GsiIehpDjmL+RTT9WQpYqLCQZSnWkYfV1YZ1OiHpbKiPUrI
+F+mxDzMPrjQE1Z+uxSzvjxUmdKq2EcEek0zgNetd+kLjzJnifeVCt2dH8/pdtNY
fmObXrvvV4xXMf10EBo44CQo7PYpBi2VE0nUVrqSd3PhVMpnV5l6LEkb+7inyftH
KLqC/kZsOqT4aj+fFYkMycExqoPT7c0ud+zr4jvqsavRwOZNm62t6gZgMRQPfW1M
V3vXDv+aG6UlzCqZu634Eujb55yhHZEgIBRRUDekzGo/3AI+ZzDEatIK+sWNSNvs
3+Rsv2r9J+cfQUFfGdp72bsc3vhpVg==
=bZ5U
-----END PGP SIGNATURE-----

--h7VF7kDEiHZCpqK4hmtA9O6mLmnTRpLUk--
