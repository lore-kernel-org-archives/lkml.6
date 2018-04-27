Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757534AbeD0HWB (ORCPT <rfc822;w@1wt.eu>);
        Fri, 27 Apr 2018 03:22:01 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:59743 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1757397AbeD0HV7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Apr 2018 03:21:59 -0400
Subject: Re: [PATCH 0/3] can: fix ndo_start_xmit()'s return type
To: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc: Wolfgang Grandegger <wg@grandegger.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Chen-Yu Tsai <wens@csie.org>, Michal Simek <michal.simek@xilinx.com>,
        "open list:CAN NETWORK DRIVERS" <linux-can@vger.kernel.org>,
        "open list:NETWORKING DRIVERS" <netdev@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        "moderated list:ARM/Allwinner sunXi SoC support"
        <linux-arm-kernel@lists.infradead.org>
References: <20180426211339.30821-1-luc.vanoostenryck@gmail.com>
From: Marc Kleine-Budde <mkl@pengutronix.de>
Openpgp: preference=signencrypt
Autocrypt: addr=mkl@pengutronix.de; keydata=
 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
 /6jKeO1yNpD5UgI9bzazBn1mwg==
Message-ID: <62fdb875-0940-3396-612c-06ef7533399b@pengutronix.de>
Date: Fri, 27 Apr 2018 09:21:38 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180426211339.30821-1-luc.vanoostenryck@gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="h1Ujan5qz4X7lsH1QzjmC1LunW5yQrGD5"
X-SA-Exim-Connect-IP: 2001:67c:670:201:5054:ff:fe8d:eefb
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--h1Ujan5qz4X7lsH1QzjmC1LunW5yQrGD5
Content-Type: multipart/mixed; boundary="3Szq496S26ecTDO0b8Uki3mtIHn8xYauf";
 protected-headers="v1"
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc: Wolfgang Grandegger <wg@grandegger.com>,
 Maxime Ripard <maxime.ripard@bootlin.com>, Chen-Yu Tsai <wens@csie.org>,
 Michal Simek <michal.simek@xilinx.com>,
 "open list:CAN NETWORK DRIVERS" <linux-can@vger.kernel.org>,
 "open list:NETWORKING DRIVERS" <netdev@vger.kernel.org>,
 open list <linux-kernel@vger.kernel.org>,
 "moderated list:ARM/Allwinner sunXi SoC support"
 <linux-arm-kernel@lists.infradead.org>
Message-ID: <62fdb875-0940-3396-612c-06ef7533399b@pengutronix.de>
Subject: Re: [PATCH 0/3] can: fix ndo_start_xmit()'s return type
References: <20180426211339.30821-1-luc.vanoostenryck@gmail.com>
In-Reply-To: <20180426211339.30821-1-luc.vanoostenryck@gmail.com>

--3Szq496S26ecTDO0b8Uki3mtIHn8xYauf
Content-Type: text/plain; charset=utf-8
Content-Language: de-DE
Content-Transfer-Encoding: quoted-printable

On 04/26/2018 11:13 PM, Luc Van Oostenryck wrote:
> ndo_start_xmit() is defined as returing an 'netdev_tx_t'.
> However, several can drivers use 'int' as the return type
> of their start_xmit() method.
> This series contains the fix for all three of them.
>=20
> Luc Van Oostenryck (3):
>   can: janz-ican3: fix ican3_xmit()'s return type
>   can: sun4i: fix sun4ican_start_xmit()'s return type
>   can: xilinx: fix xcan_start_xmit()'s return type
>=20
>  drivers/net/can/janz-ican3.c | 2 +-
>  drivers/net/can/sun4i_can.c  | 2 +-
>  drivers/net/can/xilinx_can.c | 2 +-
>  3 files changed, 3 insertions(+), 3 deletions(-)

Applied all 3 to linux-can-next, added similar patch for the flexcan driv=
er.

Tnx,
Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--3Szq496S26ecTDO0b8Uki3mtIHn8xYauf--

--h1Ujan5qz4X7lsH1QzjmC1LunW5yQrGD5
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEENrCndlB/VnAEWuH5k9IU1zQoZfEFAlriz4cACgkQk9IU1zQo
ZfH2mQf9HBvlAEf7YT3JUmRjWzO0A02xl+q38B1Vks0QH1nmrJm9bxEaYyREYk9d
6hAM/y3wyH7BR0MoGfstOOfnS065I3ob1Wfra0vrMmqHC90QJ7bVOAL/eB33+vEz
1ogR797IGWp9RuA2bVlrXPOy4NmS4gVDpI9dfQynmmxW/R+FdsK1WwZuzuTZByzo
fsps5wqUnV92lWb4n3Iaaly7rFasq0OKgFA5vjCDJJYZGiKdk6fmrGHb/IXZdjgt
923AtsWHzF6M1pk131oLsJ3bdmbu73F9LIcbZDcvLUnPA/L5by6tsFlac5NPbGaa
g8RVsqbyISBTmQSpfojSncpks6Z6JQ==
=DW9s
-----END PGP SIGNATURE-----

--h1Ujan5qz4X7lsH1QzjmC1LunW5yQrGD5--
