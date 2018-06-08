Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id 74ybIiMhGltjTgAAmS7hNA
	; Fri, 08 Jun 2018 07:05:20 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 8E24B607DC; Fri,  8 Jun 2018 07:05:20 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,MAILING_LIST_MULTI
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 01F39606FA;
	Fri,  8 Jun 2018 07:05:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 01F39606FA
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751843AbeFHHFO (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Fri, 8 Jun 2018 03:05:14 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:45417 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750945AbeFHHFK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jun 2018 03:05:10 -0400
Received: from pty.hi.pengutronix.de ([2001:67c:670:100:1d::c5])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ore@pengutronix.de>)
        id 1fRBSM-0004rw-0c; Fri, 08 Jun 2018 09:05:06 +0200
Received: from ore by pty.hi.pengutronix.de with local (Exim 4.89)
        (envelope-from <ore@pengutronix.de>)
        id 1fRBSL-0003WX-BB; Fri, 08 Jun 2018 09:05:05 +0200
Date: Fri, 8 Jun 2018 09:05:05 +0200
From: Oleksij Rempel <o.rempel@pengutronix.de>
To: "Jonas Mark (BT-FIR/ENG1)" <Mark.Jonas@de.bosch.com>
Cc: Andy Shevchenko <andy.shevchenko@gmail.com>,
        Wolfgang Grandegger <wg@grandegger.com>,
        Marc Kleine-Budde <mkl@pengutronix.de>,
        "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>,
        netdev <netdev@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Heiko Schocher <hs@denx.de>,
        "ZHU Yi (BT-FIR/ENG1-Zhu)" <Yi.Zhu5@cn.bosch.com>
Subject: Re: [PATCH 2/5] spi: implement companion-spi driver
Message-ID: <20180608070505.gmirhvtqdr2uzvtw@pengutronix.de>
References: <bb9540ed90e944c7a8e27287e6df25d5@de.bosch.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="g2iqv75r7rvnlvzl"
Content-Disposition: inline
In-Reply-To: <bb9540ed90e944c7a8e27287e6df25d5@de.bosch.com>
X-Sent-From: Pengutronix Hildesheim
X-URL: http://www.pengutronix.de/
X-IRC: #ptxdist @freenode
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-Uptime: 09:00:42 up 168 days, 19:38, 88 users,  load average: 0.26, 0.14,
 0.04
User-Agent: NeoMutt/20170113 (1.7.2)
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c5
X-SA-Exim-Mail-From: ore@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--g2iqv75r7rvnlvzl
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 08, 2018 at 06:56:23AM +0000, Jonas Mark (BT-FIR/ENG1) wrote:
> Hi Oleksij,
>=20
> > > > > +               if (slave_is_not_busy(priv))
> > > > > +                       return 0;
> > > > > +
> > > >
> > > > > +               udelay(READY_POLL_US_GRAN);
> > > >
> > > > Should it be atomic?
> > > > Can it use read_poll_* type of helpers instead?
> > >
> > > Yes, it shall be atomic because we need to reduce the latency at
> > > detecting the de-assertion of the busy signal. We accept that this wi=
ll
> > > cost CPU time.
> > >
> > > In case the Companion itself is very busy and does not reply quickly =
we
> > > are have second polling loop below which sleeps longer and is non-ato=
mic.
> >=20
> > I can confirm, this make huge impact on protocol performance. And this
> > protocol is not really the speed runner.
>=20
> The challenge is that the protocol is synchronous and without back to
> back transfers.
>=20
> > you can send dummy message to set CS.
> > +	struct spi_transfer t =3D {
> > +		.len =3D 0,
> > +		.cs_change =3D 1,
> > +	};
> >=20
> > +	/* send dummy to trigger CS */
> > +	reinit_completion(&priv->fc_complete);
> > +	spi_sync_locked(spi, &m);
> >=20
> > see my ancient unfinished code:
> > https://patchwork.kernel.org/patch/9418511/
>=20
> We will check it out.
>=20
> > In general, this part of the code, can be provided as separate driver
> > which should be called as "SPI 5wire protocol". 3 wires for data, 1 -
> > chip select, 1 - busy state. Since, the slave cant fit to normal SPI
> > requirements, and can't be ready within predictable time, busy signal is
> > needed. Providing this as separate driver or part of SPI framework
> > should reduce the code for many different drivers.
> >=20
> > The actual datagram on top of your spi companion should go to
> > separate driver. There are similar (almost identical designs)
> >=20
> > can :+
> > char:+
> > dw:  +
> > gpio:+--->some_multi_end_mux_protocol--->spi_5wire_protocol->spi--->
> >=20
> > In my knowledge, only data format on top of spi_5wire_protocol is
> > different. See my notes for similar topics:
> > https://github.com/olerem/icc
> > https://github.com/olerem/spi-5wire
>=20
> With 5-wire protocol you are referencing to CLK, MISO, MOSI, CS (all
> standard SPI signals) and an extra BUSY signal. What we implemented is
> a 6-wire protocol. There is an additional REQUEST line where the SPI
> slave requests a transfer. It is like a level triggered interrupt
> request.
>=20
> Yes, for making it more generic the code in drivers/spi/companion
> could be split into a generic 6-wire protocol driver and a multiplexing
> protocol on top of it.
>=20
> How does a slave signal that it has data to be picked up with the
> 5-wire protocol?

The request and busy signals are multiplexed to one wire. So, it should
be easy to implement both, 5 and 6 wire protocol in one driver.

--=20
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

--g2iqv75r7rvnlvzl
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEpENFL0P3hvQ7p0DDdQOiSHVI77QFAlsaKpcACgkQdQOiSHVI
77SLVQgAsKUqGPKHriKUVOOkpbR1bLA+4sdqYwgj3oxuRFwKxw1aCiGWsV4r3tZj
C2wkzpXdHn0rN2ddX7vHscfB9/3+hKJWlTXP9g3b/69ZjGEGS8rfsSYqLf+rysQ4
C9VtrvxqbhFdU/IvNTUDYJUFF+pAWDDQOBXu8LhlUnaB9ppO9kpDnFDt9d9I9yn9
cf9EvzFMrS0obQJm0SECPAwI3B/IyAJxUYaUh5leOnsTSlBJO9Tj1FgvRAlSITsU
Vbxpleq6x7t+Z3RqwyNKUPBzZwPZJxUeDzauZcWjmLdx4ExyJBPSrzEmkHVd2j+z
JAy7nBstyT3zu8dkQMc1WajABMPETw==
=Oh2u
-----END PGP SIGNATURE-----

--g2iqv75r7rvnlvzl--
