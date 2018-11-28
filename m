Return-Path: <SRS0=rk9P=OH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A00DC43441
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 09:20:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C8B322081C
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 09:20:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QwR2KBZP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C8B322081C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728061AbeK1UVG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Nov 2018 15:21:06 -0500
Received: from mail-ed1-f65.google.com ([209.85.208.65]:42550 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727541AbeK1UVF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Nov 2018 15:21:05 -0500
Received: by mail-ed1-f65.google.com with SMTP id j6so21446252edp.9;
        Wed, 28 Nov 2018 01:20:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=rLg+/sYLlg9Hi5SLi1i1yn0ndxDeqp0j42M/myn/Oxg=;
        b=QwR2KBZPy3jVoWXxjmOCVcjLgyg4i51I26/9fLsVDyzkRl7fHpJq+GWdRfUGQ4XWqs
         byDBguC3HhwcAEIc5pAU495zJ4Smv79+z8wB42QNLYK1bNXn99VnROBAkcgDPXj1VTM9
         aYSp2FE6LOWmBgW0k8jkuXah1+faak95BsEIr5fWuGgKPjEzhPxxx2K0vycln7KtF7Ae
         1Cvcn6rXgFufwXsz0HU4mogLGgIXqChfya1O0/l650O7PIu5hM5aqBvd9XcOtTQk15dU
         cuamhKqnuPA7YXkMCXgFbTbQxkhTBAfEU3CEOSBtmZwoueTd6ypYPe0ogLBY3Lp4POEF
         5j9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=rLg+/sYLlg9Hi5SLi1i1yn0ndxDeqp0j42M/myn/Oxg=;
        b=ccrlP/u+MtBpdN/SowBkzTP4KvUZsq14gPQqq4bPxew8wnptRwzxD2Guoqhtd+Y9mk
         D9sWdkAmwRRl86BnZP36xOwwJ3blPRc4NOaf/ovHLW1I/26Y7TQtbN6CiTnrztB+LTgi
         PyYnt8LyEhyi9cSCN65GNbV4UrjcWjHTKOXnpLhXNtCXI4vEdDURNUm9sO9KyFvVUx4P
         AUiQS7vclboiXmV5zaenTqAXoXwGbgec5GQliNZ0eyFjpIHcf8Ez8GQe+9OXKxfAy9ba
         RXNZjKZL4AneLuIWzPQe1p9VPpCGz4jAXgOpjmxmZffNxigSmCiaPt52KcU4bZuLdaMo
         7Z9A==
X-Gm-Message-State: AA+aEWbqkUNZn+cfTli62U9KnjUA02gu5xZDFbE8kOlvlaSVksh+4Sue
        uWJTl5IjGaQROH5gyu1ruVzXVZuT
X-Google-Smtp-Source: AFSGD/VgymyqGsh+hjbu4kxVqCQ31gVjiNTk57eqXrhEcaz9AlXfK2NZt6iN18ybYUsM5gvMyMBdqw==
X-Received: by 2002:a17:906:7a4e:: with SMTP id i14-v6mr21924202ejo.16.1543396806288;
        Wed, 28 Nov 2018 01:20:06 -0800 (PST)
Received: from localhost (pD9E51040.dip0.t-ipconnect.de. [217.229.16.64])
        by smtp.gmail.com with ESMTPSA id e14sm1675564edb.79.2018.11.28.01.20.05
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 28 Nov 2018 01:20:05 -0800 (PST)
Date:   Wed, 28 Nov 2018 10:20:04 +0100
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Marcel Ziswiler <marcel@ziswiler.com>
Cc:     linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Jiri Slaby <jslaby@suse.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        linux-serial@vger.kernel.org,
        Laxman Dewangan <ldewangan@nvidia.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH v1 3/3] serial: tegra: fix some spelling mistakes
Message-ID: <20181128092004.GE17419@ulmo>
References: <20181101015230.27310-1-marcel@ziswiler.com>
 <20181101015230.27310-4-marcel@ziswiler.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="6e7ZaeXHKrTJCxdu"
Content-Disposition: inline
In-Reply-To: <20181101015230.27310-4-marcel@ziswiler.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--6e7ZaeXHKrTJCxdu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 01, 2018 at 02:52:30AM +0100, Marcel Ziswiler wrote:
> From: Marcel Ziswiler <marcel.ziswiler@toradex.com>
>=20
> Fix a few spelling mistakes I stumbled upon while debugging a customers
> UART issues.
>=20
> Signed-off-by: Marcel Ziswiler <marcel.ziswiler@toradex.com>
>=20
> ---
>=20
>  drivers/tty/serial/serial-tegra.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
>=20
> diff --git a/drivers/tty/serial/serial-tegra.c b/drivers/tty/serial/seria=
l-tegra.c
> index af2a29cfbbe9..d5269aaaf9b2 100644
> --- a/drivers/tty/serial/serial-tegra.c
> +++ b/drivers/tty/serial/serial-tegra.c
> @@ -746,7 +746,7 @@ static void tegra_uart_stop_rx(struct uart_port *u)
>  	if (!tup->rx_in_progress)
>  		return;
> =20
> -	tegra_uart_wait_sym_time(tup, 1); /* wait a character interval */
> +	tegra_uart_wait_sym_time(tup, 1); /* wait one character interval */
> =20
>  	ier =3D tup->ier_shadow;
>  	ier &=3D ~(UART_IER_RDI | UART_IER_RLSI | UART_IER_RTOIE |
> @@ -887,7 +887,7 @@ static int tegra_uart_hw_init(struct tegra_uart_port =
*tup)
>  	 *
>  	 * EORD is different interrupt than RX_TIMEOUT - RX_TIMEOUT occurs when
>  	 * the DATA is sitting in the FIFO and couldn't be transferred to the
> -	 * DMA as the DMA size alignment(4 bytes) is not met. EORD will be
> +	 * DMA as the DMA size alignment (4 bytes) is not met. EORD will be
>  	 * triggered when there is a pause of the incomming data stream for 4
>  	 * characters long.
>  	 *
> @@ -1079,7 +1079,7 @@ static void tegra_uart_set_termios(struct uart_port=
 *u,
>  	if (tup->rts_active)
>  		set_rts(tup, false);
> =20
> -	/* Clear all interrupts as configuration is going to be change */
> +	/* Clear all interrupts as configuration is going to be changed */
>  	tegra_uart_write(tup, tup->ier_shadow | UART_IER_RDI, UART_IER);
>  	tegra_uart_read(tup, UART_IER);
>  	tegra_uart_write(tup, 0, UART_IER);
> @@ -1165,10 +1165,10 @@ static void tegra_uart_set_termios(struct uart_po=
rt *u,
>  	/* update the port timeout based on new settings */
>  	uart_update_timeout(u, termios->c_cflag, baud);
> =20
> -	/* Make sure all write has completed */
> +	/* Make sure all writes have completed */
>  	tegra_uart_read(tup, UART_IER);
> =20
> -	/* Reenable interrupt */
> +	/* Re-enable interrupt */

I think both forms are valid. Either way:

Acked-by: Thierry Reding <treding@nvidia.com>

--6e7ZaeXHKrTJCxdu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlv+XcQACgkQ3SOs138+
s6E7mg//UyZ1H1cQlmNMldSeHIIK4SeXON8qXOeM7HTcLh5uUv/c+R64nrbZ3rQz
wd8FPn3qsti83FKTIV1Ev1SO93mtrhB5MU1/zBisFXHVPiDLs75J7pMHg2MJ957e
75ebhBdqOS1JPvbmp1T+J96MtKMkXW6v/9Z9BhL0HVhBmflfsJHrA3FkLJL8/RAM
vVtJ9RPcXJUgCz+vTjmU4D6E15yKPpPm/eV0nGYbFbwyDMwPag22t8j6sDg2UZ5r
JKwD9ONmHLXUbjYz3+yw+/vZGcnGJFuJDeFC8gpx4hsK5ZNw1pVs2gxLMjwE1QZm
liED6qT1VakaIp6/5p3YJncYJxN/4ITyuzC2e7Z8gCxxo5mns/eGzEqlRh+nKcVe
2kccILiSROjPFa2yjCH6VtwfWsuJmJ55Jhqrfls5k8xS8O4l5Say0zrmgNEb/6X8
fBwVc3a0ppjkQijklfbvlTo4bajO9gS7Uo+YJ63rmi63kPYSLHi/OkFIGfXNi1Ys
mrLreQu0Wa3xF16Dadfxw7Jz7y5sa1lj5VSjJt5G4wWi3iw3fOicKjiwutyV7ytL
ylHU6TyR7Wyz14jPynrUCaGB4uIulPgc34W8KpDN6A4nJOWi4UbHlInhmyErUVCu
cVoY07JADA5egkRIjt34La6Dz9nC09gB5gzMuhQjHn0oSCcFDjo=
=bd89
-----END PGP SIGNATURE-----

--6e7ZaeXHKrTJCxdu--
