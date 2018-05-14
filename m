Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753103AbeENLvo (ORCPT <rfc822;w@1wt.eu>);
        Mon, 14 May 2018 07:51:44 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:50803 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753085AbeENLvj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 May 2018 07:51:39 -0400
X-Google-Smtp-Source: AB8JxZoqCmUT/zed86F9m9R7aHo0SXUTxBA1X5Wn6tPcojaUq99B/h+RGQZp3T8LQPBEEmTuHSfZrg==
Date: Mon, 14 May 2018 13:51:35 +0200
From: Thierry Reding <thierry.reding@gmail.com>
To: Dmitry Osipenko <digetx@gmail.com>
Cc: Lee Jones <lee.jones@linaro.org>,
        Jonathan Hunter <jonathanh@nvidia.com>, linux-tegra@vger.kernel.org,
        linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] mfd: tps6586x: Move interrupt handling into workqueue
Message-ID: <20180514115135.GG18312@ulmo>
References: <20180513211842.7819-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="64j1qyTOoGvYcHb1"
Content-Disposition: inline
In-Reply-To: <20180513211842.7819-1-digetx@gmail.com>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--64j1qyTOoGvYcHb1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, May 14, 2018 at 12:18:42AM +0300, Dmitry Osipenko wrote:
> Reading of status register within the interrupt handler fails with -EAGAIN
> if I2C is busy with handling some other request at the same time. Move the
> actual interrupt handling into a workqueue to avoid the unfortunate I2C
> failure and to avoid hanging CPU in interrupt up to 1 second (transfer
> timeout in the Tegra I2C driver).
>=20
> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
> ---
>  drivers/mfd/tps6586x.c | 40 +++++++++++++++++++++++++++++-----------
>  1 file changed, 29 insertions(+), 11 deletions(-)

Could this not be achieved with a threaded interrupt handler?

Thierry

--64j1qyTOoGvYcHb1
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlr5eEcACgkQ3SOs138+
s6FAyhAAq80tkvFczYnA4GX2jq86xP/IB3C7Djg4zOp/dEpUFGTtH7jMHrMUiq7d
lsNU2YRhorcT7cqslncYo6L6RSVTti65HBmww856j8f7GvOO+roMm/ysmvGP0mhr
f0byAaXL3hcZbRL13Y9B8x9HQc3SD/r1YzFYUNwJb3eV6xjWO3dStq5C8OFIRm/A
KQrdTO/VqIfWmzVSFwL8SlbTqhgfZBAkCs+YrY5Gm1TC7rFUtPh4hFpC+dHboq6v
RFQTGUDj5TE+J8OZ79nQQBaOzRGymrNln3OvnfhZ92f//SF1uJGeh6Xm+WmjfFGe
YqIhLgtpO6F3gTqAzxC+6N6Y7H9BaeBANwwJ0OOcsnkY6cuL2m4nj3nZWYqLgHYp
blBA1FtbF2o1Zbo3VP3OyDWDWpFrkKXghVGScJtUdotRj7M6AQXglCaodHUBMTmt
zoc9ZVinnt0Bm6GmeSKfeFvZnCi6FquXwIaUlxENzKv9AfYNktAUcRejuwZiAWy4
GE36Ax1f1K9IpoHkC3GGJUpkHmqbl6ddUv0Yz89ipcc9X2sQ60RhVBD8V+FJJoqD
jUgR4SLkRM9DXhGzUiogzhKdrPRw1VmfeGSVfe2H7ZbWdvl6NobUhNYVLxbLKl+1
QGqvTdlJGymSLqTJSDIlLGZvlcN7nEDtzKIzBgsAWsT9U2aZhhs=
=zJYC
-----END PGP SIGNATURE-----

--64j1qyTOoGvYcHb1--
