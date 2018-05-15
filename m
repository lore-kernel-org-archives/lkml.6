Return-Path: <Radu.Pirea@microchip.com>
X-Google-Smtp-Source: AB8JxZqriAu/NLTwQM1hO0I1aU6L9g6uYsgwl0x+xgw9A+g7Vsv6OAiA5PPVJbLBZl/pV0M5YCL9
ARC-Seal: i=1; a=rsa-sha256; t=1526388371; cv=none;
        d=google.com; s=arc-20160816;
        b=DF/kadzP6qCVOYSIJRfh/AZ8m+zWgrrRTEPMFZtE7H1PSvxdUwgVXZ2Q8RDPbzrRA8
         YKkNNmYfPx6OaSCgome71As8ss6VEpdjnjhmmGRT5ZqVWPyfJcxbLrZuSurQ1ya74drL
         c6nOgfVC1JNJk1PjQfYUlE7mShFF+jaeRo2gDh9xwu6Gr77icIQ46ZyMgkAfsTwfgTrC
         QwKE+yB+mS2V0SGtrPlnQvZ1ip8TvJGRuG77oR9xMTubbdnY9hSyP80cYEYU44R+GxBP
         wammlVICn4zKhWwREpJ0JXPDcTl5rCCqgFKs3eRHyqKfQKy+us7hPz+u/IwrFfTSlnlc
         WRNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:references:in-reply-to:date:cc:to:from:subject
         :message-id:arc-authentication-results;
        bh=6rQNNIXM95e9WXQJ9wypP4+VroWUuHcPN6yDP31iah4=;
        b=nt90dKRYaMUebXIxyzXrF5HZYKMHyxTmKXptx+DMB3ZK0fkQnt1esYa5DJ57g7arzx
         WFj55exmR63Ouz2pKMWFG4OLvrCplw0jKbTusu0BD/zzXllBLggqcCglPG3nuRvynxXa
         GPLTEU4vd7ij9IWHsZtsmDLIYpFLv5oLUbffaYNXMVUrefJg7kdLOrXBObwbg1ujak24
         8RhIcchJdoEwnPm0fYCOrAKHW36oTmp9z5K3xw1TTMnFul+MnEqDpfA9HMk1NZyvOEsa
         eBixj9j/6oPQDP0nWPGl1Uhlyp9u7EE1C9O3OuUlfZuWddATqkGUeAncG087oOAmQVSt
         FlfA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of radu.pirea@microchip.com designates 68.232.154.123 as permitted sender) smtp.mailfrom=Radu.Pirea@microchip.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of radu.pirea@microchip.com designates 68.232.154.123 as permitted sender) smtp.mailfrom=Radu.Pirea@microchip.com
X-IronPort-AV: E=Sophos;i="5.49,403,1520924400";
   d="asc'?scan'208";a="13953756"
Message-ID: <95a51c6c69bf1a2422f545ac1f06846ebcdb186a.camel@microchip.com>
Subject: Re: [PATCH v3 6/6] tty/serial: atmel: changed the driver to work
 under at91-usart mfd
From: Radu Pirea <radu.pirea@microchip.com>
To: Richard Genoud <richard.genoud@gmail.com>, <devicetree@vger.kernel.org>,
	<linux-serial@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-spi@vger.kernel.org>
CC: <mark.rutland@arm.com>, <robh+dt@kernel.org>, <lee.jones@linaro.org>,
	<gregkh@linuxfoundation.org>, <jslaby@suse.com>,
	<alexandre.belloni@bootlin.com>, <nicolas.ferre@microchip.com>,
	<broonie@kernel.org>
Date: Tue, 15 May 2018 15:47:22 +0300
In-Reply-To: <4a75568e-a52e-3872-f465-d707372a5c12@sorico.fr>
References: <20180511103822.31698-1-radu.pirea@microchip.com>
	 <20180511103822.31698-7-radu.pirea@microchip.com>
	 <4a75568e-a52e-3872-f465-d707372a5c12@sorico.fr>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="=-b3g2qpcC+4sIoVnDF1W/"
X-Mailer: Evolution 3.28.2 
MIME-Version: 1.0
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1600163742597492266?=
X-GMAIL-MSGID: =?utf-8?q?1600534213503197471?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

--=-b3g2qpcC+4sIoVnDF1W/
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 2018-05-14 at 12:57 +0200, Richard Genoud wrote:
> Hi,
>=20
> On 11/05/2018 12:38, Radu Pirea wrote:
> > This patch modifies the place where resources and device tree
> > properties
> > are searched.
> >=20
> > Signed-off-by: Radu Pirea <radu.pirea@microchip.com>
> > ---
> >  drivers/tty/serial/Kconfig        |  1 +
> >  drivers/tty/serial/atmel_serial.c | 29 +++++++++++++++----------
> > ----
> >  2 files changed, 16 insertions(+), 14 deletions(-)
> >=20
> > diff --git a/drivers/tty/serial/Kconfig
> > b/drivers/tty/serial/Kconfig
> > index 3682fd3e960c..25e55332f8b1 100644
> > --- a/drivers/tty/serial/Kconfig
> > +++ b/drivers/tty/serial/Kconfig
> > @@ -119,6 +119,7 @@ config SERIAL_ATMEL
> >  	depends on ARCH_AT91 || COMPILE_TEST
> >  	select SERIAL_CORE
> >  	select SERIAL_MCTRL_GPIO if GPIOLIB
> > +	select MFD_AT91_USART
> >  	help
> >  	  This enables the driver for the on-chip UARTs of the
> > Atmel
> >  	  AT91 processors.
> > diff --git a/drivers/tty/serial/atmel_serial.c
> > b/drivers/tty/serial/atmel_serial.c
> > index df46a9e88c34..6b4494352853 100644
> > --- a/drivers/tty/serial/atmel_serial.c
> > +++ b/drivers/tty/serial/atmel_serial.c
> > @@ -193,8 +193,8 @@ static struct console atmel_console;
> > =20
> >  #if defined(CONFIG_OF)
> >  static const struct of_device_id atmel_serial_dt_ids[] =3D {
> > -	{ .compatible =3D "atmel,at91rm9200-usart" },
> > -	{ .compatible =3D "atmel,at91sam9260-usart" },
> > +	{ .compatible =3D "atmel,at91rm9200-usart-serial" },
> > +	{ .compatible =3D "atmel,at91sam9260-usart-serial" },
> >  	{ /* sentinel */ }
> >  };
> >  #endif
> > @@ -1631,7 +1631,7 @@ static void atmel_tasklet_tx_func(unsigned
> > long data)
> >  static void atmel_init_property(struct atmel_uart_port
> > *atmel_port,
> >  				struct platform_device *pdev)
> >  {
> > -	struct device_node *np =3D pdev->dev.of_node;
> > +	struct device_node *np =3D pdev->dev.parent->of_node;
> > =20
> >  	/* DMA/PDC usage specification */
> >  	if (of_property_read_bool(np, "atmel,use-dma-rx")) {
> > @@ -2223,7 +2223,8 @@ static const char *atmel_type(struct
> > uart_port *port)
> >  static void atmel_release_port(struct uart_port *port)
> >  {
> >  	struct platform_device *pdev =3D to_platform_device(port-
> > >dev);
> > -	int size =3D pdev->resource[0].end - pdev->resource[0].start=20
> > + 1;
> > +	int size =3D to_platform_device(pdev->dev.parent)-
> > >resource[0].end -
> > +		to_platform_device(pdev->dev.parent)-
> > >resource[0].start + 1;
>=20
> I think it may be simpler with something like:
> +	struct platform_device *mfd_pdev =3D to_platform_device(port-
> >dev->parent);
> +	int size =3D mfd_pdev->resource[0].end - mfd_pdev-
> >resource[0].start + 1;
>=20
> > =20
> >  	release_mem_region(port->mapbase, size);
> > =20
> > @@ -2239,7 +2240,8 @@ static void atmel_release_port(struct
> > uart_port *port)
> >  static int atmel_request_port(struct uart_port *port)
> >  {
> >  	struct platform_device *pdev =3D to_platform_device(port-
> > >dev);
> > -	int size =3D pdev->resource[0].end - pdev->resource[0].start=20
> > + 1;
> > +	int size =3D to_platform_device(pdev->dev.parent)-
> > >resource[0].end -
> > +		to_platform_device(pdev->dev.parent)-
> > >resource[0].start + 1;
> > =20
>=20
> ditto
>=20
> >  	if (!request_mem_region(port->mapbase, size,
> > "atmel_serial"))
> >  		return -EBUSY;
> > @@ -2345,23 +2347,23 @@ static int atmel_init_port(struct
> > atmel_uart_port *atmel_port,
>=20
> Here, we could also add:
> +	struct device *mfd_dev =3D pdev->dev.parent;
> +	struct platform_device *mfd_pdev =3D
> to_platform_device(mfd_dev);
>=20
> >  	atmel_init_property(atmel_port, pdev);
> >  	atmel_set_ops(port);
> > =20
> > -	uart_get_rs485_mode(&pdev->dev, &port->rs485);
> > +	uart_get_rs485_mode(pdev->dev.parent, &port->rs485);
>=20
> ...and use them here
>=20
> > =20
> >  	port->iotype		=3D UPIO_MEM;
> >  	port->flags		=3D UPF_BOOT_AUTOCONF |
> > UPF_IOREMAP;
> >  	port->ops		=3D &atmel_pops;
> >  	port->fifosize		=3D 1;
> >  	port->dev		=3D &pdev->dev;
> > -	port->mapbase	=3D pdev->resource[0].start;
> > -	port->irq	=3D pdev->resource[1].start;
> > +	port->mapbase		=3D to_platform_device(pdev-
> > >dev.parent)->resource[0].start;
> > +	port->irq		=3D to_platform_device(pdev-
> > >dev.parent)->resource[1].start;
>=20
> and here
> I think it would be easier to read.
>=20
> >  	port->rs485_config	=3D atmel_config_rs485;
> > -	port->membase	=3D NULL;
> > +	port->membase		=3D NULL;
> > =20
> >  	memset(&atmel_port->rx_ring, 0, sizeof(atmel_port-
> > >rx_ring));
> > =20
> >  	/* for console, the clock could already be configured */
> >  	if (!atmel_port->clk) {
> > -		atmel_port->clk =3D clk_get(&pdev->dev, "usart");
> > +		atmel_port->clk =3D clk_get(pdev->dev.parent,
> > "usart");
>=20
> and here
>=20
> >  		if (IS_ERR(atmel_port->clk)) {
> >  			ret =3D PTR_ERR(atmel_port->clk);
> >  			atmel_port->clk =3D NULL;
> > @@ -2656,7 +2658,7 @@ static void atmel_serial_probe_fifos(struct
> > atmel_uart_port *atmel_port,
> >  	atmel_port->rts_low =3D 0;
> >  	atmel_port->rts_high =3D 0;
> > =20
> > -	if (of_property_read_u32(pdev->dev.of_node,
> > +	if (of_property_read_u32(pdev->dev.parent->of_node,
> >  				 "atmel,fifo-size",
> >  				 &atmel_port->fifo_size))
> >  		return;
> > @@ -2694,11 +2696,10 @@ static void atmel_serial_probe_fifos(struct
> > atmel_uart_port *atmel_port,
> >  static int atmel_serial_probe(struct platform_device *pdev)
> >  {
> >  	struct atmel_uart_port *atmel_port;
> > -	struct device_node *np =3D pdev->dev.of_node;
> > +	struct device_node *np =3D pdev->dev.parent->of_node;
> >  	void *data;
> >  	int ret =3D -ENODEV;
> >  	bool rs485_enabled;
> > -
>=20
> I think this line feed wasn't so bad.
>=20
> >  	BUILD_BUG_ON(ATMEL_SERIAL_RINGSIZE &
> > (ATMEL_SERIAL_RINGSIZE - 1));
> > =20
> >  	ret =3D of_alias_get_id(np, "serial");
> > @@ -2845,7 +2846,7 @@ static struct platform_driver
> > atmel_serial_driver =3D {
> >  	.suspend	=3D atmel_serial_suspend,
> >  	.resume		=3D atmel_serial_resume,
> >  	.driver		=3D {
> > -		.name			=3D "atmel_usart",
> > +		.name			=3D
> > "atmel_usart_serial",
> >  		.of_match_table		=3D
> > of_match_ptr(atmel_serial_dt_ids),
> >  	},
> >  };
> >=20
>=20
> After your patch, the DMA is not selected anymore:
> atmel_usart_serial atmel_usart_serial.0.auto: TX channel not
> available, switch to pio
> instead of:
> atmel_usart fffff200.serial: using dma1chan2 for tx DMA transfers
>=20
Fixed.
> And the kernel doesn't log anymore on the serial console, despite the
> loglevel=3D8
> (after reverting this series, the kernel logs reappears on the serial
> console)
>=20
Which serial are you using as console?=20
> (tests done on sam9g35)
>=20
I will consider the rest of suggestions.=20
> regards,
> Richard
>=20
--=-b3g2qpcC+4sIoVnDF1W/
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEdoCq2H4M7urKoB6rrwWfQ+JrPx0FAlr61toACgkQrwWfQ+Jr
Px3Vhg//e1Hlkc0xBxxdhcCfU3mgYlUj41YRJJphrgSx+p28h5HSRxcuv6X703VH
A8NxaPPSR2Yv7wu8/fXxiVYL2xhxf7uWx9U6PoUGajq+iuRoMnuDuNJp7cbKUh+L
DAoTTnVBKiQ1GTnFDZHRGqLoKbQUO+Ph/fzhYBScXNykW+Q8ze8IVv5Mg4Bbmw1o
lKcUrrKA0BgdBpYLNnbDd/sgH5+xUXixKquqJOQHzK4HUtEQJToKMVg+/6T9QrWl
l6VD0w0j6i3/zFSIQtskH0BGLw4uTDNx5aXn/R2gAWn4sQLlVvCYHg9dEVOXfFvO
k+BWgpQrE+N2E0ReUzlo+ic74LoEgLyorbkJnXI4+k05XGYBYoW2XYyu35UJjN97
aRWD4hlxsydGBUGcIWSYGz5EY3k1yK/9lIz0U4/+PaLvG4md/9D3Khlkz0Ruy+re
hQv3XYtOIlMb2tXCods8IMbrUBOgChZGo1qjmQ3DadNFR6r1tXTInSRVnZyPrd4p
U1aN3R27tQ7JFS8ad0AN9LOadIomYvRzunqTk8ytG6E80fM/JgIyqSs68AJb0Bme
hLFfwd+ZQKKjihgYh03lEQOWCE7qRr2BsHRJQS6g/0kRnm/pMJFPNy5+ah5foxJm
eh6ljO/K65m5N/DgHC+VKOHWTx9VzjfsnoTuhyQ646uaSkoTFtQ=
=x7zo
-----END PGP SIGNATURE-----

--=-b3g2qpcC+4sIoVnDF1W/--
