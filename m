Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id 3izAEUcbGltdIwAAmS7hNA
	; Fri, 08 Jun 2018 06:03:57 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 5CC996089E; Fri,  8 Jun 2018 06:03:57 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,MAILING_LIST_MULTI
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 9BCF9606FA;
	Fri,  8 Jun 2018 06:03:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 9BCF9606FA
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751185AbeFHGDx (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Fri, 8 Jun 2018 02:03:53 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:57573 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750909AbeFHGDu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jun 2018 02:03:50 -0400
Received: from pty.hi.pengutronix.de ([2001:67c:670:100:1d::c5])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ore@pengutronix.de>)
        id 1fRAUz-0007oz-O6; Fri, 08 Jun 2018 08:03:45 +0200
Received: from ore by pty.hi.pengutronix.de with local (Exim 4.89)
        (envelope-from <ore@pengutronix.de>)
        id 1fRAUy-0001S4-DF; Fri, 08 Jun 2018 08:03:44 +0200
Date: Fri, 8 Jun 2018 08:03:44 +0200
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
Message-ID: <20180608060344.crzezckorbtacc7g@pengutronix.de>
References: <1528224240-30786-1-git-send-email-mark.jonas@de.bosch.com>
 <1528224240-30786-3-git-send-email-mark.jonas@de.bosch.com>
 <CAHp75Vd0xqKwJCYqOWvFTpMy8iH4PPf_HXX4dkx=KER4UD13fA@mail.gmail.com>
 <be0d6a5f98e840d29f673d976416a4b2@de.bosch.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="kkcqdhjtmfe5tbyp"
Content-Disposition: inline
In-Reply-To: <be0d6a5f98e840d29f673d976416a4b2@de.bosch.com>
X-Sent-From: Pengutronix Hildesheim
X-URL: http://www.pengutronix.de/
X-IRC: #ptxdist @freenode
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-Uptime: 07:37:12 up 168 days, 18:15, 93 users,  load average: 0.06, 0.05,
 0.03
User-Agent: NeoMutt/20170113 (1.7.2)
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c5
X-SA-Exim-Mail-From: ore@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--kkcqdhjtmfe5tbyp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Mark,

On Thu, Jun 07, 2018 at 02:58:24PM +0000, Jonas Mark (BT-FIR/ENG1) wrote:
> Hello Andy,
>=20
> Thank you very much for your feedback.
>=20
> > > +       /*TODO: support mutiple packets in one write in future*/
> >=20
> > Hmm... Either fix this, or remove comment?
>=20
> Agreed, we will manage ideas for future changes at a different place.
>=20
> > > +       if (copy_from_user(p.data, buf, sizeof(p)) =3D=3D 0) {
> > > +               if (is_can_type(&p))
> > > +                       return -EINVAL;
> > > +       } else {
> > > +               dev_info(parent, "copy from user not succeed in one c=
all\n");
> >=20
> > Shouldn't it return immediately?
>=20
> Yes, it should. Will be changed.
>=20
> >=20
> > > +       }
> >=20
> > > +
> > > +       error =3D qm_io_txq_in(&priv->pm.qm, buf, count, &copied);
> >=20
> > ...what the point to call if we got garbage from user space?
>=20
> Will be changed with the code above.
>=20
> > > +       if (!error) {
> >=20
> > The usual pattern is to check for errors first.
>=20
> Understood, will be changed.
>=20
> > > +               wake_up_interruptible(&priv->wait);
> > > +               priv->pm.stats.io_tx++;
> > > +               return copied;
> > > +       } else {
> > > +               priv->pm.stats.io_tx_overflows++;
> > > +       }
> > > +       return error;
> > > +}
> >=20
> > > +       ... qm_io_rxq_out(&priv->pm.qm, buf, count, &copied);
> >=20
> > > +       ... pm_can_data_tx(&priv->pm, port, prio, cf);
> >=20
> > Oh, oh, oh.
> >=20
> > These namespaces are too generic, moreover pm is kinda occupied by
> > power management. You bring a lot of confusion here, I think.
>=20
> We agree and we started thinking about better names. We will send a propo=
sal.
>=20
> > > +       err =3D pm_can_get_txq_status(pm, port);
> > > +       if (!err) {
> >=20
> > if (err)
> >  return err;
>=20
> Yes, will be changed.
>=20
> > > +       }
> > > +       return err;
> >=20
> >=20
> > > +       int                        ret, value;
> > > +
> > > +       ret =3D sscanf(buf, "%d", &value);
> > > +       if (ret !=3D 1) {
> >=20
> > > +       }
> >=20
> > You have to be consistent in your code.
> >=20
> > I've already noticed
> >=20
> > err
> > error
> >=20
> > and now
> >=20
> > ret
> >=20
> > Choose one and stick with it.
>=20
> Yes, will be changed.
>=20
> > Also check your entire patch series' code for consistency.
>=20
> We will have a look.
>=20
> > > +static DEVICE_ATTR(dump_packets, S_IRUGO | S_IWUSR,
> > > +                   show_dump_packets, store_dump_packets);
> >=20
> > We have helpers, like DEVICE_ATTR_RW().
>=20
> Will be changed.
>=20
> > > +               ret  =3D snprintf(buf + pos, PAGE_SIZE - pos,
> > > +                               "\ntx: %u, rx: %u, err: %u\n\n",
> > > +                               total,
> > > +                               priv->pm.stats.can_rx_overflows[i],
> > > +                               priv->pm.stats.can_err_overflows[i]);
> >=20
> > Please, avoid leading '\n'.
>=20
> We think we will stick to the existing. Otherweise we would have to
> insert another pair of sprint() and pos +=3D ret. Is it worth that?
>=20
> >=20
> > > +       gpio_set_value(priv->cs_gpios, priv->cs_gpios_assert);
> >=20
> > > +       gpio_set_value(priv->cs_gpios, !priv->cs_gpios_assert);
> >=20
> > Can you switch to GPIO descriptor API?
>=20
> Yes, we are working on it.
>=20
> > > +       unsigned int count =3D READY_POLL_US / READY_POLL_US_GRAN;
> > > +       while (count--) {
> >=20
> > For counting like this better to have
> > do {
> > } while (--count);
> >=20
> > The rationale, reader at first glance will know that the loop will
> > iterate at least once.
>=20
> Agreed, will be changed.
>=20
> > > +               if (slave_is_not_busy(priv))
> > > +                       return 0;
> > > +
> >=20
> > > +               udelay(READY_POLL_US_GRAN);
> >=20
> > Should it be atomic?
> > Can it use read_poll_* type of helpers instead?
>=20
> Yes, it shall be atomic because we need to reduce the latency at
> detecting the de-assertion of the busy signal. We accept that this will
> cost CPU time.
>=20
> In case the Companion itself is very busy and does not reply quickly we
> are have second polling loop below which sleeps longer and is non-atomic.

I can confirm, this make huge impact on protocol performance. And this
protocol is not really the speed runner.=20

> > Above comments applicable to entire code you have.
>=20
> We will look at it.
>=20
> > > +static void companion_spi_cpu_to_be32(char *buf)
> > > +{
> > > +       u32 *buf32 =3D (u32*)buf;
> > > +       int  i;
> > > +
> > > +       for (i =3D 0; i < (BCP_PACKET_SIZE / sizeof(u32)); i++, buf32=
++)
> > > +               *buf32 =3D cpu_to_be32(*buf32);
> > > +}
> >=20
> > This entire function should be replaced by one of the helpers from
> > include/linux/byteorder/generic.h
> >=20
> > I guess cpu_to_be32_array() is a right one.
>=20
> Correct. We are testing the driver against 4.14 and that function is not
> available there. It will be changed later.
>=20
> > > +static void companion_spi_be32_to_cpu(char *buf)
> > > +{
> > > +       u32 *buf32 =3D (u32*)buf;
> > > +       int  i;
> > > +
> > > +       for (i =3D 0; i < (BCP_PACKET_SIZE / sizeof(u32)); i++, buf32=
++)
> > > +               *buf32 =3D be32_to_cpu(*buf32);
> > > +}
> >=20
> > Ditto.
> >=20
> > Recommendation: check your code against existing helpers.
>=20
> Yes, every kernel release brings new helpers. We will have to learn how
> to keep track of the additions.
>=20
> > > +               p =3D (const struct companion_packet*)transfer->tx_bu=
f;
> >=20
> > > +       companion_spi_cpu_to_be32((char*)transfer->tx_buf);
> >=20
> > If tx_buf is type of void * all these castings are redundant.
>=20
> The type is const void*. So the first cast is superfluous, the second
> is not.
>=20
> > Also looking at the function, did you consider to use whatever SPI
> > core provides, like CS handling, messages handling and so on?
>=20
> SPI CS has to be done manually in our case because we need to wait
> until the Companion signals that it is ready for the transfer.
>=20
> Do you have concrete proposals regarding messages handling?

you can send dummy message to set CS.
+	struct spi_transfer t =3D {
+		.len =3D 0,
+		.cs_change =3D 1,
+	};

+	/* send dummy to trigger CS */
+	reinit_completion(&priv->fc_complete);
+	spi_sync_locked(spi, &m);

see my ancient unfinished code:
https://patchwork.kernel.org/patch/9418511/

In general, this part of the code, can be provided as separate driver
which should be called as "SPI 5wire protocol". 3 wires for data, 1 -
chip select, 1 - busy state. Since, the slave cant fit to normal SPI
requirements, and can't be ready within predictable time, busy signal is
needed. Providing this as separate driver or part of SPI framework
should reduce the code for many different drivers.

The actual datagram on top of your spi companion should go to
separate driver. There are similar (almost identical designs)

can :+
char:+
dw:  +
gpio:+--->some_multi_end_mux_protocol--->spi_5wire_protocol->spi--->

In my knowledge, only data format on top of spi_5wire_protocol is
different. See my notes for similar topics:
https://github.com/olerem/icc
https://github.com/olerem/spi-5wire

--=20
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

--kkcqdhjtmfe5tbyp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEpENFL0P3hvQ7p0DDdQOiSHVI77QFAlsaHDkACgkQdQOiSHVI
77S/5gf/Wst/IYrAs7e7q+45QzUHZwB0Q3IDiKxqeIbsXbLgNKFo9pZcUiD6wD/9
Kw98IzgGRkXydCpwCgawv/vjIW1hYvcHGqIrqqpNq3sDFS9aNgF3YtUlqTKmiTJ2
9afK7JSvprcOoOVC9Cv01SgY+Md55OdSgpTr6GAaDFjcEOFpfaG6LMrum5zMVf3/
ilJw3Vx9sktK2OIg7tWBbLlOSwq1nkKP2Ignvc5ICwvxBMUZQdNvtK8Lb6QmEnqr
+LM1NJ41dlNZa2XGSjbaKION5Y7VtsoOVtXCM3irdzzW6MtxIUu6LlOylYPgH2+M
UKkyhbu0vjNbAp1UZ134dKZQbe19gQ==
=o1Cx
-----END PGP SIGNATURE-----

--kkcqdhjtmfe5tbyp--
