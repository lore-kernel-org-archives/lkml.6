Return-Path: <linux-kernel-owner@vger.kernel.org>
Authentication-Results: smtp.codeaurora.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Pj0g1pEM"
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org DC9416063F
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932503AbeFFIEy (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Wed, 6 Jun 2018 04:04:54 -0400
Received: from mail-wr0-f196.google.com ([209.85.128.196]:42989 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932290AbeFFIEv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jun 2018 04:04:51 -0400
X-Google-Smtp-Source: ADUXVKLbbEeCNeuJSdU5cG1/6fad4xj2x3QR9IP0S9MHeISWip1n9oIrgjuDWOcZZQezIOSRxas2Fg==
Date: Wed, 6 Jun 2018 10:04:47 +0200
From: Thierry Reding <thierry.reding@gmail.com>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Benjamin Gaignard <benjamin.gaignard@st.com>,
        linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] pwm: stm32: enforce dependency on CONFIG_MFD_STM32_TIMERS
Message-ID: <20180606080447.GB11810@ulmo>
References: <20180525160523.29124-1-arnd@arndb.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="xgyAXRrhYN0wYx8y"
Content-Disposition: inline
In-Reply-To: <20180525160523.29124-1-arnd@arndb.de>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--xgyAXRrhYN0wYx8y
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, May 25, 2018 at 06:04:54PM +0200, Arnd Bergmann wrote:
> When compile-testing the pwm driver without also enabling the
> stm32_timers MFD, we run into a link error:
>=20
> drivers/pwm/pwm-stm32.o: In function `stm32_pwm_raw_capture.isra.6':
> pwm-stm32.c:(.text+0xcb0): undefined reference to `stm32_timers_dma_burst=
_read'
>=20
> We don't need the '|| COMPILE_TEST' here, since stm32_timers itself
> can be built with CONFIG_COMPILE_TEST on all architectures, so we do
> get the coverage through allmodconfig and randconfig builds even
> when we make it a hard dependency.
>=20
> Fixes: 7edf7369205b ("pwm: Add driver for STM32 plaftorm")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  drivers/pwm/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Applied, thanks.

Thierry

--xgyAXRrhYN0wYx8y
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlsXlZ8ACgkQ3SOs138+
s6GHOxAAjzrOSS+vSZ5YUbmkDs7Kq6nIMWvjXX3UFfn1ooi7tXZA4WZ81SCn08O2
ytwxtdlIfsnQ/TgWjMY0jSpk94Dh4XPoHeKSsJUOYfQKirN6x5CLj3P2rviYFBIZ
2z/F+nRwsaJ9hax2ILZawcknPOSi7oZY2orwC7laOfaASvA8X2Rw1j5fWcU7OsMA
4euQStPfpAHGgyZusP/5N4zFlB4fzoHF7us4RMYBIpZcn3I/g4lDKJnjhmQEpO77
5WVi+U0wRO7UIjXQKariocS4I3a7ZH/iAZWLRnuUJhtxBER0hwUuKd5qcgCRedUr
5nlzdRB0lPk31YYsHJYdBZ5n4WpYUqddZZBPUxo2AwpwzLLfsgU2Pn8MDrTXZPN4
x2ur1UMw43LQn2A5L5xgg7hOsKr4/YLo+xrxfs5hto/gki/i5ulYvnLF4PWKyADn
AV/0oBB5GLxQIYObqVKltva54q+P2K67tTqQjayEiViDjVYuIEtrM8aBFyUYQSwR
BjWJCC0pDRCbTiSd/ww48tTtN/G/ChC7bSY4DYc8tZiMlbvKL9MWGdjthhAYnl5L
OQumW7cc5DlIsac7QV3tWY/0EVG+r3eyGk/9Kqs+a/ExL8kTIdp3f5/BUwzObKIR
0jnR4dg8n6iYA6d0pJHX0oOSLcxSMQCV8etI2NNXK001ti8qqrY=
=ZYFI
-----END PGP SIGNATURE-----

--xgyAXRrhYN0wYx8y--
