Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752179AbeBHOrM (ORCPT <rfc822;w@1wt.eu>);
        Thu, 8 Feb 2018 09:47:12 -0500
Received: from metis.ext.pengutronix.de ([85.220.165.71]:37205 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751544AbeBHOrK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Feb 2018 09:47:10 -0500
Subject: Re: [PATCH v2 1/2] net, can, ifi: fix "write buffer full" error
To: Heiko Schocher <hs@denx.de>, linux-can@vger.kernel.org
Cc: Markus Marb <markus@marb.org>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, Marek Vasut <marex@denx.de>,
        Wolfgang Grandegger <wg@grandegger.com>
References: <20180208064748.17985-1-hs@denx.de>
From: Marc Kleine-Budde <mkl@pengutronix.de>
Message-ID: <59322f7d-4207-a5a4-89b5-dff1634e4183@pengutronix.de>
Date: Thu, 8 Feb 2018 15:46:27 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180208064748.17985-1-hs@denx.de>
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="IgjQZx4c8IMbn8rd8W8kueTZeypshVxNq"
X-SA-Exim-Connect-IP: 2001:67c:670:201:5054:ff:fe8d:eefb
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--IgjQZx4c8IMbn8rd8W8kueTZeypshVxNq
Content-Type: multipart/mixed; boundary="MIZtyo0ovlOiyelZbmtVEAFouL0Lq30pA";
 protected-headers="v1"
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Heiko Schocher <hs@denx.de>, linux-can@vger.kernel.org
Cc: Markus Marb <markus@marb.org>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, Marek Vasut <marex@denx.de>,
 Wolfgang Grandegger <wg@grandegger.com>
Message-ID: <59322f7d-4207-a5a4-89b5-dff1634e4183@pengutronix.de>
Subject: Re: [PATCH v2 1/2] net, can, ifi: fix "write buffer full" error
References: <20180208064748.17985-1-hs@denx.de>
In-Reply-To: <20180208064748.17985-1-hs@denx.de>

--MIZtyo0ovlOiyelZbmtVEAFouL0Lq30pA
Content-Type: text/plain; charset=utf-8
Content-Language: de-DE
Content-Transfer-Encoding: quoted-printable

On 02/08/2018 07:47 AM, Heiko Schocher wrote:
> the driver reads in the ISR first the IRQpending register,
> and clears after that in a write *all* bits in it.
>=20
> It could happen that the isr register raise bits between
> this 2 register accesses, which leads in lost bits ...
>=20
> In case it clears "TX message sent successfully", the driver
> never sends any Tx data, and buffers to userspace run over.
>=20
> Fixed this:
> clear only the bits in the IRQpending register, the
> driver had read.
>=20
> Signed-off-by: Heiko Schocher <hs@denx.de>
> Reviewed-by: Marek Vasut <marex@denx.de>

Applied both to linux-can.

Tnx,
Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--MIZtyo0ovlOiyelZbmtVEAFouL0Lq30pA--

--IgjQZx4c8IMbn8rd8W8kueTZeypshVxNq
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEENrCndlB/VnAEWuH5k9IU1zQoZfEFAlp8YsMACgkQk9IU1zQo
ZfHnQQgApJa10e389jp6bHp3E6cB6bCLIqQ5LDunEeJ0Nlk2OCObXdZEtdcHFJvG
zNe33zZP+wr+x+oSXplEkfhMrzuLjc4BmVNba58ZYKDdIa+NtuG4lvNbGKPBgE/i
9KWphlslpj+Ew8sBGBQWQjJCNqM1cZYk9EM4O1ila42kK99TmZQr7l7Tn2FqdWdR
Mt8y81Dc7Y/AVe+zqxmhdWfFBcvnn00x2wTmoLVQ0kFA40qL2doKokh3m9NcUyGV
BTLAy1KYGuoPk16hy/pgwuJFN2v2KwdV9CUdWX6wkZWkRGmpHySZyE9Umt0GIsJ/
uX2cDaNM1a6cooTBVk0NBq02uV5tiA==
=3kXY
-----END PGP SIGNATURE-----

--IgjQZx4c8IMbn8rd8W8kueTZeypshVxNq--
